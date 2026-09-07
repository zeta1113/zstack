<!-- AUTO-GENERATED from apple-release.md.tmpl — do not edit directly -->
<!-- Regenerate: bun run gen:skill-docs -->
# Apple App Store 출시

<!-- time-attack/gstack(GStack 2)의 APPLE-RELEASE.md에서 가져왔고,
     21회의 실제 App Store release를 거치며 다듬었습니다.
     일부 copyright (c) 2026 Sina Matian, time-attack/gstack, MIT.
     gstack main architecture에 맞게 조정했습니다: decision-store bin,
     Third-Party Web Actions contract, fork의 durable-state wrapper 대신
     idempotency log를 사용합니다. 모든 credential 예시는 placeholder이며
     실제 credential format이 아닙니다. -->

ship 대상이 Apple platform app일 때 적용합니다. repository에 `.xcodeproj` 또는 `.xcworkspace`가 있거나, app product가 포함된 Swift package가 있는 경우입니다. Step 1의 branch gate와 preflight를 시작하기 전에 이 문서를 먼저 읽으세요. 이 adapter는 `/ship`의 판단 범위를 App Store 여정 전체로 확장하고, 모든 upload/submission을 durable external effect로 취급합니다(아래 idempotency contract 참고). 다만 store distribution은 repository landing과 별개의 release path입니다. `/ship`의 branch/PR 절차(feature-branch gate, commit-review-PR pipeline, merge queue)는 사용자가 repository change를 land하라고 요청했을 때만 적용됩니다. 사용자가 App Store 또는 TestFlight로 ship하려는 경우 현재 branch가 무엇이든 이 adapter를 통해 진행합니다. base branch의 clean working tree에서 archive/upload하는 것도 정상적이고 유효한 상태입니다. branch topology만으로 App Store release를 중단하지 마세요.

전체 release는 machine-level `fastlane` 하나로 실행합니다. `produce`는 app record와 bundle ID를 만들고, `cert`와 `sigh`는 signing을 처리하며, `gym`은 archive와 signed export를 만듭니다. `pilot`은 TestFlight, `deliver`는 metadata/screenshot/Submit for Review, `frameit`은 device frame을 담당합니다. 없으면 한 줄로 알리고 설치하세요(`brew install fastlane`). release authorization은 machine tool 설치까지 포함하므로 별도 질문이 아닙니다. 추가 App Store CLI tool은 설치하지 마세요. 실행 중에는 API key, `.p8` file, session, credential format을 사용자에게 언급하지 않습니다. 예외는 closing report의 standing credential disclosure 한 줄뿐입니다(Storefront 완료 참고). 사용자는 US$99를 지불했고 ship하려고 합니다. 이 release 자체는 사용자의 project에 새 dependency를 추가하지 않습니다.

Mac은 build 단계에만 필요합니다. archive, signing, binary upload는 Xcode의 macOS-only toolchain에 의존하며 Apple은 이를 다른 platform에 제공하지 않습니다. 우회 도구도 없습니다. non-macOS host에서는 이 사실을 분명히 말한 뒤, 해당 build 단계만 macOS CI runner로 보냅니다. 예를 들어 GitHub Actions `macos` runner에서 같은 `gym` 및 `deliver`/`pilot` command를 실행하고, 발급된 upload key는 CI secret으로 제공합니다. key auth는 CI에 정확히 맞는 방식입니다. sign-in, key minting, metadata, screenshot, pricing, submission 판단은 사용자의 machine에서 수행하는 일반 API 작업입니다. Mac이 아니라고 전체 release가 불가능하다고 말하지 말고, 반대로 build 단계가 Mac 없이 가능하다고 가장하지도 마세요.

## 한 번의 authorization 순간

전체 여정에서 허용되는 interaction은 정확히 두 번뿐입니다. 첫 번째는 시작 시점입니다. 사용자가 paid Apple Developer Program membership(US$99/year, App Store와 TestFlight 모두 필요)을 가지고 있는지 확인하고 release를 authorize합니다. pricing도 같은 질문 안에서, app마다 평생 한 번만 물어봅니다. decision store(`bin/gstack-decision-search --scope repo --query "pricing"`)를 먼저 확인한 뒤 free인지 paid인지, paid라면 price를 authorization question 안에 포함하세요. 별도의 interrupt로 묻지 않습니다. 답변은 `~/.claude/skills/gstack/bin/gstack-decision-log`에 `repo` scope로 저장해서 이후 release에서 다시 묻지 않습니다. paid answer라면 one-time Paid Apps banking/tax agreement도 그 자리에서 정직하게 언급합니다. 서명 전에는 판매가 불가능하기 때문입니다. 가격은 launch decision이며 agent가 조용히 default로 정하면 안 됩니다. free launch는 되돌릴 수 없습니다.

Apple sign-in도 같은 순간에 처리합니다. host의 interactive command path로 `fastlane spaceauth -u <apple-id>`를 실행하세요. Claude Code에서는 사용자가 `! fastlane spaceauth -u <email>`을 입력하므로 password와 one-time two-factor code가 session 안에서 Apple로 직접 전달됩니다. host에 interactive path가 없을 때만 별도 terminal window를 fallback으로 사용합니다. 출력된 session token은 transcript에 남기지 마세요. `fastlane`이 실제로 사용하는 credential은 `~/.fastlane/spaceship/`의 cached cookie입니다. password나 token을 저장, echo, log하지 말고, session이 만료되면 같은 command를 다시 실행하세요. 첫 sign-in 직후 permanent upload key를 mint합니다(Archive 및 upload의 step 4). 이미 `~/.gstack/apple/api-key.json`에 key가 있고 새 app record가 필요 없다면 sign-in을 완전히 건너뜁니다. 반복 release는 sign-in 없이 authorize 후 진행합니다.

두 번째 interaction은 preflight에서 icon 또는 screenshot이 없을 때만 허용되는 store-assets question입니다. 그 외 모든 것(tool install, upload, storefront, submission)은 authorization 범위 안에 있으며 추가 질문 없이 진행합니다. auth menu, tool-choice question, plan confirmation, 단계별 승인 요청은 contract violation입니다.

membership이 없으면 App Store path를 STOP합니다. Third-Party Web Actions contract(이 skill의 앞부분)를 통해 developer.apple.com enrollment를 안내하겠다고 제안하세요. 구매는 사용자가 직접 완료하며 activation에는 하루나 이틀이 걸릴 수 있습니다. free account의 한계도 정직하게 말합니다. personal-team install은 사용자의 기기에서만 가능하고 7일 후 만료되며, TestFlight와 App Store는 사용할 수 없습니다.

## Release Preflight

archive 전에 resolve와 verification을 끝내세요. printed mutation boundary가 허용한 항목은 수정하고, 그 밖의 문제는 blocking finding으로 보고합니다.

- Signing: app target에 development team이 설정되어 있어야 합니다. 없으면 `cert`와 `sigh`가 distribution certificate와 App Store profile을 mint합니다.
- Versioning: 사용자가 보게 될 marketing version과, 해당 version에 이미 upload된 어떤 build보다도 큰 build number가 필요합니다.
- Dependencies: `xcodebuild -resolvePackageDependencies`가 성공해야 합니다. `Podfile` 또는 `Cartfile`이 있으면 install step이 실행되어 있고 lockfile이 최신이어야 합니다.
- App Store validation blockers: 1024pt marketing icon을 포함한 complete app icon set, launch screen, app이 사용하는 모든 privacy-gated API의 usage-description string, required privacy manifests, export-compliance answer(`ITSAppUsesNonExemptEncryption`), sane deployment target이 필요합니다.

## Store Assets

preflight에서 icon 또는 screenshot이 빠진 경우에만 한 번 묻습니다. 이것이 여정에서 두 번째이자 마지막으로 허용되는 질문입니다. 답을 받은 뒤에는 추가 prompt 없이 선택한 방향으로 진행합니다. app마다 평생 한 번만 묻습니다. 질문 전 decision store(`bin/gstack-decision-search --scope repo --query "store assets"`)를 확인하고, 이미 정해진 선택(`defer screenshots`, `TestFlight only` 포함)이 있으면 조용히 적용합니다. 사용자 답변은 `~/.claude/skills/gstack/bin/gstack-decision-log`에 `repo` scope로 저장해서 이후 실행에서 다시 묻지 않습니다. 사용자가 직접 바꾸겠다고 말할 때만 변경합니다. 제공할 option:

- **App icon**: SnapAI(`npx snapai`, app-icon agent skill)가 사용자의 image-generation key로 단일 1024×1024 이미지를 생성합니다. Xcode 15+는 이 한 이미지에서 모든 size를 파생합니다.
- **Marketing screenshot, free/local/no API key**: app-store-screenshots deck editor skill을 scaffold하고, simulator capture와 benefit headline으로 deck JSON을 미리 채운 뒤, 필요한 모든 iPhone size를 덮는 bundle을 export합니다. export는 headless automation이 가능합니다. marketing-grade screenshot에 image backend는 필수가 아닙니다. 이 skill이 설치되어 있을 때 screenshot에 API key가 필요하다고 말하지 마세요.
- **Plain frame, free/local**: simulator에서 built app을 capture하고 fastlane `frameit`으로 frame을 씌웁니다. designed deck을 원하지 않을 때의 최소 option입니다.
- **AI-enhanced marketing screenshot**: aso-appstore-screenshots Agent Skill을 사용합니다(benefit headline, breakout panel, 정확한 App Store dimension). 사용자의 image-generation key가 필요한 유일한 option입니다. 설치되어 있으면 이 workflow를 따르고 재구현하지 마세요.
- **사용자 제공 file**: 항상 유효한 answer입니다. dimension을 validate하고 진행하세요.

이 question의 option은 질문 시점의 LIVE installed skill check에서 구성합니다. memory나 이전 대화에 의존하지 마세요. app-store-screenshots deck editor skill이 설치되어 있으면 free no-key option은 반드시 list에 포함되어야 합니다. 이를 빠뜨리는 것은 screenshot에 API key가 필요하다고 잘못 말하는 것과 같은 contract violation입니다. asset이 이미 있으면 이 단계 전체를 건너뜁니다. 종료 시 생성한 내용을 알립니다.

## Archive 및 Upload

1. `gym`으로 signed Release build를 archive/export합니다. `gym`은 xcodebuild와 preflight에서 mint한 signing을 구동합니다. custom archive requirement가 있는 project는 `xcodebuild archive`로 직접 내려가도 됩니다. 어떤 경로든 output은 App Store-signed `.ipa`입니다.
2. upload는 external effect입니다. `pilot`(TestFlight) 또는 `deliver`(App Store)를 실행하기 전 durable-effect contract에 따라 `~/.gstack/projects/$SLUG/apple-effects.log`에 `appstore.upload.<bundle-id>.<build>` key를 append하세요. 이전 실행(crash, retry)에서 key가 이미 있으면 upload가 완료됐을 수 있는 것으로 보고 다시 실행하지 않습니다. ambiguity에서는 재업로드하지 말고 App Store Connect에서 build를 먼저 inspect합니다.
3. cached session, minted key, 모든 credential file은 env-level 또는 file-level secret입니다. argv에 넣지 말고, echo하지 말고, commit하지 마세요.
4. app-specific password를 요구하지 마세요. session이 upload key를 mint합니다. fastlane의 documented authentication에 따르면 Apple binary-upload tool(iTMSTransporter, `deliver`/`pilot`이 `.ipa` upload에 shell out하는 도구)은 web session을 받지 않습니다. App Store Connect API key 또는 app-specific password만 받으며, Apple error `-22938`("Sign in with the app-specific password")는 Transporter가 정확히 이 사실을 말하는 것입니다. 이것은 gate도 question도 아닙니다. web session 자체가 key를 조용히 생성할 수 있기 때문입니다.

fastlane bundled spaceship을 통해 `Spaceship::Tunes.login(<apple-id>)`로 cached cookie를 재사용한 뒤 raw client request를 보냅니다. app이 release될 scope로만 `POST https://appstoreconnect.apple.com/iris/v1/apiKeys`를 호출하세요. all apps가 아닙니다. JSON:API body는 `{data:{type:"apiKeys",attributes:{nickname:"gstack-upload",allAppsVisible:false,roles:["APP_MANAGER"],keyType:"PUBLIC_API"},relationships:{apps:{data:[{type:"apps",id:"<asc-app-id>"}]}}}}`입니다. `<asc-app-id>`는 `produce` output 또는 `GET https://appstoreconnect.apple.com/iris/v1/apps?filter[bundleId]=<bundle-id>`에서 얻는 App Store Connect app id입니다. `allAppsVisible:false`와 explicit `apps` relationship은 의도적인 least privilege입니다. `allAppsVisible:true` APP_MANAGER key는 team의 모든 app에 대한 standing authority가 되어 machine이 나중에 compromise되면 불필요한 blast radius가 됩니다. `apps` relationship은 optional이 아니라 REQUIRED입니다. app association이 없는 key는 아무것도 볼 수 없고 upload가 permission error로 실패할 수 있으므로, flag만 뒤집지 말고 target app에 scope를 거세요.

app record가 존재한 뒤에만 mint합니다. 새 app이면 `produce`를 먼저 실행해야 합니다. 그 다음 `GET .../iris/v1/apiKeys/<id>?fields[apiKeys]=privateKey`를 호출합니다. `privateKey` attribute는 COMPLETE PEM file의 base64입니다. 정확히 한 번 decode해서 즉시 `~/.appstoreconnect/private_keys/AuthKey_<id>.p8`(0600)에 씁니다. 이 값은 생성 시점에만 download 가능합니다. issuer ID는 `GET https://appstoreconnect.apple.com/olympus/v1/session`의 `provider.publicProviderId`입니다. key id, issuer id, key content를 fastlane api-key JSON으로 `~/.gstack/apple/api-key.json`(0600)에 기록하고 이후부터 `deliver`/`pilot`은 `api_key_path`로 실행하세요.

key는 만료되지 않으므로 SAME app의 이후 release는 sign-in을 건너뜁니다. DIFFERENT app을 release할 때는 이 key에 해당 app을 다시 associate(`PATCH .../iris/v1/apiKeys/<id>`로 `apps` relationship에 추가)하거나 새 app-scoped key를 mint합니다. key는 의도적으로 all-apps가 아닙니다. session은 `produce`에만 계속 필요합니다(Apple public API로는 app record를 만들 수 없습니다). 또한 re-association, key가 revoke된 경우 re-mint에도 필요합니다. key minting을 시도하지도 않고 사용자에게 credential을 직접 만들라고 말하는 것은 contract violation입니다.

credential을 건드리기 전에 error를 classify하세요. error가 authentication failure인 경우는 그것이 직접 그렇게 말할 때뿐입니다(401/403, session invalid/expired, Apple의 표현으로 "sign in", "app-specific password"). `Spaceship::UnexpectedResponse`, missing/invalid attribute, validation, precheck error는 METADATA 문제입니다. payload를 고치세요. 예를 들어 `app_rating_config.json`의 `lootBox`, `ageAssurance`, `parentalControls`, `messagingAndChat` 같은 Apple expanded age-rating attribute를 CLI에서 수정하고 retry합니다. metadata error를 credential 문제로 취급하면 contract violation입니다.
5. Apple release 안에서는 이 adapter가 Third-Party Web Actions contract(이 skill의 앞부분)를 override합니다. 일반 agentic-browser offer는 App Store Connect, Apple ID, credential work에 적용되지 않습니다. 전체 release는 CLI(`fastlane`)와 두 번의 허용된 interaction으로 진행합니다. 이 adapter가 허용하는 browser 사용은 문서 끝에 언급된 paid-app agreement/banking/tax residue뿐입니다. 그 외 여정에서 browser를 열거나, agent가 구동하거나, manual로 열게 하는 것은 contract violation입니다.

실제 error로 fallback이 필요해지면 error를 verbatim으로 quote한 뒤, 다음 순서로 escalate하세요. FIRST: step 4에 따라 session에서 upload key를 mint 또는 re-mint하고 `api_key_path`로 upload를 retry합니다. disk에 key가 없는 upload-auth error는 사용자가 credential을 줘야 한다는 뜻이 아니라 mint를 건너뛰었다는 뜻입니다. SECOND: minting 자체가 session error로 실패하면 사용자에게 다시 sign-in을 요청합니다(초기 authorization과 같은 `! fastlane spaceauth -u <apple-id>` 순간). re-mint 후 retry합니다. FRESH session으로도 key를 mint할 수 없을 때, 즉 signed-in Apple ID가 team의 Admin 또는 Account Holder가 아니라는 permission refusal일 때만 app-specific-password path가 열립니다. 이 경우에도 self-service만 허용합니다. 사용자가 어떤 device에서든 password를 만들고, host의 in-session masked prompt를 통해 macOS keychain(`fastlane fastlane-credentials add --username <apple-id>`)에 입력하면 upload를 다시 시도합니다. credential을 만들기 위해 browser drive를 제안하거나 권장하지 마세요. password, key, token에 대해 어떤 framing으로도 agentic browser를 쓰면 안 됩니다.
6. App Review contact detail(name, email, phone)은 submission에 필요한 metadata입니다. name/email은 signed-in Apple ID와 git config에서 infer하고, phone number는 authorization moment 안에서 한 번 수집해 decision store에 저장합니다. 이후 다시 묻지 않습니다. contact detail은 metadata이며 mid-run에서 따로 알릴 blocking gate가 아닙니다.

## Storefront 완료

`produce`는 실행 중 app record와 bundle ID를 이미 만들었습니다. app record를 manual gate라고 부르지 마세요. authorization moment에서 정한 pricing은 App Store Connect price-schedule endpoint(`POST /v1/appPriceSchedules`, session 또는 minted key 사용)로 적용합니다. fastlane의 `price_tier` option은 현재 API에서 깨져 있습니다(`"'prices' is not a relationship on 'apps'"`). 따라서 pricing을 이 option으로 route하지 말고, 이 실패를 account 문제라고 부르지 마세요.

나머지 store listing은 `deliver`가 담당합니다. description, keyword, localization, device size별 screenshot upload, uploaded build attach, Submit for Review를 처리합니다. 사용자가 중간 TestFlight round를 요청했다면 `pilot`이 TestFlight group과 tester를 관리합니다. submission도 durable-effect contract를 따릅니다. key는 `appstore.submit.<bundle-id>.<version>`입니다. ambiguity에서는 재실행 전에 App Store Connect를 inspect합니다. 이후 review status는 CLI로 monitor합니다.

web-only로 남는 것은 딱 두 가지입니다. paid Apple Developer Program membership 구매 자체(전제 조건이며 release step이 아님), 그리고 PAID app일 때만 필요한 one-time Paid Apps agreement와 banking/tax입니다. manual checklist를 내기 전에 Third-Party Web Actions contract에 따라 agentic-browser drive를 제안합니다. free app은 어떤 시점에도 browser가 필요 없습니다. submission 후에는 App Review가 보통 하루나 이틀 안에 답한다고 보고하고 run을 닫습니다. review outcome은 이 workflow가 계속 gate로 붙잡을 수 있는 대상이 아닙니다.

같은 closing report에서 durable credential을 한 줄로 공개합니다. run마다 한 번만 말하세요. "이 release는 future release를 위해 App Store Connect API key(`gstack-upload`, 이 app에 scoped)를 생성했습니다. App Store Connect → Users and Access → Integrations에서 언제든 revoke하거나, local에서 `~/.gstack/apple/api-key.json`을 삭제할 수 있습니다." 이것은 mid-run no-credential-talk rule의 의도적인 예외입니다. 사용자는 그렇지 않으면 자기 account와 disk에 standing credential이 생겼다는 사실을 알 수 없어 revocation checklist에 올리지 못합니다. disclosure는 exit에서만 하고 mid-run question으로 만들지 않으므로 one-authorization-moment contract는 유지됩니다.
