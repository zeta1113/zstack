# GStack iOS 앱을 테스트하는 방법

이것은 iOS QA 기능을 위해 end-to-end walkthrough입니다. gstack로 발송하는 기능: 당신의 앱에 canonical Swift 템플렛을 설치하고 USB를 통해 진짜 iPhone을 연결하고 어떤 에이전트 (Claude Code 로컬로, 또는 꼬리를 가진 어떤 HTTP-capable 에이전트)에서 그것을 몰기. No 시뮬레이터, no XCTest 마구, no Webr.Agent.

아래 모든 것은 실제 아이폰 17 프로 맥스 실행 iOS 26.5에 종료되었습니다. 동일한 흐름은 iOS 16 + 장치에서 작동합니다.

## 당신이 필요로 할 것

- macOS Xcode 16.0+ 설치 (`xcrun devicectl --version`가 성공해야 함). Xcode 16는 CoreDevice Tunnel `devicectl`를 USB를 통해 장치에 도달하기 위하여 이용됩니다.
- iOS 16 이상에서 실제 iPhone을 실행합니다. 잠금 해제, 설정 → 개인 정보 보호 및 보안에서 활성화 된 **개발자 모드**와 함께 Mac과 페어링.
- Apple Developer 팀 - 무료 개인 팀은 라이브 디버깅 배포에 대해 잘 작동합니다. 당신은 팀 ID (예 : `623FYQ2M88`), 인증서 ID가 아닌 팀이어야합니다. Xcode → 설정 → 계정 → Apple ID → 팀 목록에서 찾아보십시오. 설정은 `-allowProvisioningUpdates -allowProvisioningDeviceRegistration`를 통해 첫 번째 배포에 대한 응용 프로그램을 표시합니다.
- gstack 설치 (`./setup` 완료; `gstack-ios-qa-regen`와 `gstack-ios-qa-daemon`는 PATH에 있어야 합니다.
- Bun 런타임 PATH (`bun --version`). Mac-side daemon는 분 과정입니다.

선택적 원격 에이전트 (Tailscale) 모드를 위해, 당신은 `/var/run/tailscale.sock` 읽기 쉬운을 가진 Mac에 설치한 Tailscale를 더 필요로 할 것입니다.

## 한숨에 건축

```
┌─────────────────┐   tailnet (opt)    ┌──────────────────────┐   USB CoreDevice    ┌─────────────────────┐
│ Remote agent    │ ─────────────────▶ │ gstack-ios-qa-daemon │ ──────────────────▶ │ iOS app StateServer │
│ (Claude, GPT,   │  bearer + session  │  (Mac, bun/TS)       │  IPv6 ULA tunnel    │  (loopback only)    │
│  OpenClaw, ...) │                    │                      │                     │                     │
└─────────────────┘                    └──────────────────────┘                     └─────────────────────┘
```

- iOS 앱은 `StateServer` (`DebugBridge` SPM 라이브러리, `#if DEBUG`만) `::1` + `127.0.0.1` 포트 9999에 청취했습니다. Bearer-token 게이트. Boot token는 daemon의 ~5 초 이내에 회전하여 `os_log`를 긁는 것을 긁는 것을 긁는 것을 긁습니다.
- Mac daemon 브로커 트래픽을 CoreDevice IPv6 터널을 통해 `xcrun devicectl`는 페어링 장치가 연결될 때 자동으로 열립니다.
- 스태킹 모드에서 daemon는 세션 토큰 당 시행된 tiers(observe / interactive / mutate / restore)와 함께 맞춤식 IP에 별도의 청취자에 노출됩니다. 토큰은 `gstack-ios-qa-mint`를 통해 Mac 소유자에 의해 명시적으로 채굴됩니다. 원격 콜러는 자동 허용되지 않습니다.

iOS `StateServer`는 원격 모드에서도 루프백 전용 **의 모든 것**입니다. iPhone이 no가 꼬리 정체성을 검증하는 방법이므로 식별이 가능하기 때문에 식별이 가능합니다.

## 단계 1: DebugBridge 패키지 생성

app root에서 `/ios-qa`를 실행하거나, 같은 deterministic regenerator를 직접 호출합니다.

```bash
gstack-ios-qa-regen \
  --app-source "$PWD/Sources/YourApp" \
  --bridge-dir "$PWD/DebugBridge"
```

명령은 로컬 `DebugBridge/` Swift 패키지로 canonical Templates의 allowlist을 명시하고 `DebugBridgeGenerated/StateAccessor.swift`를 생성하고, 설치된 버전을 `DebugBridgeGenerated/.gstack-version`로 작성합니다. 자체 schema 해시에서 생성된 출력을 제외하므로 변경되지 않은 소스로 다시 실행하면 byte-stable cache hit이 빠릅니다. 이전 플랫 하네스 레이아웃에서 명시된 레거시 생성 파일 세트를 제거하므로 stale bridge source는 그림자가 될 수 없습니다.

1. 로컬 패키지 의존성으로 `DebugBridge/`를 추가하십시오.
   `DebugBridgeUI` 제품만 디버그 구성; `DebugBridgeCore`와 `DebugBridgeTouch`는 자동적으로 옵니다.
2. 앱 대상에 `DebugBridgeGenerated/StateAccessor.swift`을 추가합니다.
3. `@main` 앱 init에서 UIKit 해결자를 시작하기 전에 설치하십시오.
   서버, 그 후에 생성된 accessor를 등록합니다. 예를 들어 state/accessor 이름을 입력하여 생성기를 찾았습니다.

   ```swift
   #if DEBUG
   import DebugBridgeCore
   #if canImport(UIKit)
   import DebugBridgeUI
   #endif
   #endif

   // Inside App.init(), after appState is initialized:
   #if DEBUG
   #if canImport(UIKit)
   DebugBridgeUIWiring.installAll()
   #endif
   DebugBridgeManager.shared.start(
       appState: appState,
       register: AppStateAccessor.register
   )
   #endif
   ```

The three SwiftPM targets split as: `DebugBridgeCore` is cross-platform (so `swift build` on a CI Mac host can validate the bulk of the code without UIKit), `DebugBridgeUI` and `DebugBridgeTouch` are iOS-only (they link UIKit). `DebugBridgeTouch` is Objective-C — it carries the KIF-derived UITouch synthesis with the iOS 18+ `_UIHitTestContext` fix that makes SwiftUI Button taps actually fire.

The structural Release-build guard is layered. The `.when(configuration: .debug)` clause in `Package.swift` means SwiftPM refuses to link any `DebugBridge*` target in a Release build, so the bridge cannot ship to TestFlight even if you forget to clean up. 그 위에 `DebugBridgeTouch.m`의 프라이빗API 터치 합성은 `#if TARGET_OS_IOS && DEBUG` (`DEBUG`)가 `cSettings`를 통해 디버그 구성에서 `Package.swift`를 통해 대상에 정의된 `DEBUG` 뒤에 컴파일된 것입니다. 그래서 터치 브리지의 릴리스 컴파일은 빈 번역 단위를 방출합니다. - 링크커 가 우회된 경우에도 이진의 개인 기호는 0입니다.

## Step 2: Build + 장치 설치

앱의 프로젝트 디렉토리에서:

```
xcodebuild \
  -scheme YourAppScheme \
  -configuration Debug \
  -destination 'generic/platform=iOS' \
  -derivedDataPath /tmp/build \
  -allowProvisioningUpdates -allowProvisioningDeviceRegistration \
  CODE_SIGN_STYLE=Automatic \
  DEVELOPMENT_TEAM=YOUR_TEAM_ID \
  build
```

다음 + 출시를 설치:

```
UDID=$(xcrun devicectl list devices 2>/dev/null | awk 'NR>2 && $0!="" {print $(NF-2); exit}')
xcrun devicectl device install app --device "$UDID" /tmp/build/Build/Products/Debug-iphoneos/YourApp.app
xcrun devicectl device process launch --device "$UDID" --terminate-existing your.bundle.id
```

전화가 잠겨 있다면 `FBSOpenApplicationServiceErrorDomain error 1 — Locked`을 얻을 수 있습니다. 잠금 해제 및 재시동. 첫 번째 시간은 전화의 신뢰 대화 상자를 설치합니다. 신뢰를 탭 한 다음 다시 실행하십시오.

## 단계 3: 맥 사이드 daemon를 시작합니다.

두 가지 옵션.

**옵션 A - 기술이 스팸을 준다.** 실행 `/ios-qa` 어디에서나 Claude Code; 기술은 daemon 수요에, 부트 스트랩 터널을 파고, 부트 token를 회전시키고, 프록시를 통해 장치를 노출시킵니다. 로컬-USB 사용을 위한 가장 청결한 경로.

**Option B - 직접 시작.** 실행:

```
gstack-ios-qa-daemon
```

daemon는 `READY: port=<n> pid=<pid>`를 한 번 반복 백 청취자 모두 경계합니다. default 항구는 9099입니다. spawn셔는 읽을 것을 확인하기 위하여 ~5 초 timeout로 선을 읽을 수 있습니다; 당신은 또한 인쇄한 항구에 `curl`를 점할 수 있습니다.

daemon는 `~/.gstack/ios-qa-daemon.pid`에 독점 flock을 가지고 갑니다 - 2개의 Claude Code 회의에서 두번 달리는 안전합니다; 두번째 invocation는 달리는 daemon의 항구 및 결합을 발견합니다.

특정 장치 또는 번들을 대상으로 이러한 env vars를 설정합니다:

```
GSTACK_IOS_TARGET_UDID=248C3A58-B843-5BDB-8F5D-89ADB7D7BF6A
GSTACK_IOS_TARGET_BUNDLE_ID=com.yourorg.yourapp
GSTACK_IOS_DAEMON_PORT=9099       # loopback listener port; default 9099
```

`GSTACK_IOS_TARGET_UDID`가 설정되지 않은 경우, daemon는 가장 잘 페어링 된, 사용 가능한 iPhone을 선택합니다. 자동 선택은 사용 가능한 iPhone에 제한되며 유선 전화를 선호합니다. daemon는 건강한 회전 터널을 유지하고, 유효성 및 재부팅을 한 번 앱-릴라오 401 또는 복구 가능한 CoreDevice 연결 실패. 새로 시작된 daemon가 이미 실행된 대상에 도달하면, token가 이전 daemon로 소모되었고, 번들 소유자를 검증하고, 일단 목표가 다시 시작되고, 새로 고침 token를 기다리며, 소유권을 다시 검증하고, 일반적으로 회전합니다.

## 단계 4: 장치를 모십시오

daemon가 실행되면 `http://127.0.0.1:9099`(또는 `[::1]:9099`)에서 HTTP 표면이 있습니다. 기술 흐름은 이것을 위해, 그러나 익지않는 엔드포인트는 다음과 같습니다.

| 종료점 | 역할 | 의제 |
|---|---|---|
| `GET /healthz` | 버전 조사. | none (회로) |
| `POST /auth/rotate` | daemon 전용; 부팅 token를 in-memory-only 값으로 회전합니다. | 시동 token |
| `POST /session/acquire` | per-device session lock을 인수. `{session_id, ttl_seconds}`를 반환합니다. | bearer |
| `POST /session/release` | 자물쇠를 풀어 놓으십시오. | bearer + 세션 |
| `GET /screenshot` | PNG를 Active window로 캡처합니다. `{png_base64: "..."}`를 반환합니다. | bearer |
| `GET /elements` | 접근성-tree 스냅샷. | bearer |
| `GET /state/snapshot` | `// @Snapshotable` 필드를 JSON로 덤프하십시오. | bearer |
| `POST /state/restore` | 전체 snapshot를 유효하게 한 다음 MainActor에 복원하십시오. | bearer + 세션, mutate 층 |
| `POST /tap` `{x,y}` | 창 좌표에서 실제 UITouch를 구합니다. SwiftUI 버튼 화재. | bearer + 세션, 상호 작용 계층 |
| `POST /swipe` `{from_x,from_y,to_x,to_y}` | 가장 가까운 인클로징 UIScrollView를 스크롤합니다. | bearer + 세션, 상호 작용 계층 |
| `POST /type` `{text}` | 현재 첫 번째 응답자에 텍스트를 설정합니다. | bearer + 세션, 상호 작용 계층 |

계산 요청은 `Authorization: Bearer <token>` 헤더 AND `X-Session-Id` 헤더 모두 요구한다. endpoints (`/screenshot`, `/elements`, `GET /state/*`)를 읽어 보시기만 베어를 필요로 한다.

state snapshot는 속성 위 독립 발전기 감적 코멘트를 통해 필드 당 선택이다. 그것은 의도적으로 속성 래퍼가 아닌, 그래서 관찰과 함께 깨끗하게 컴파일:

```swift
@Observable
final class AppState {
    // @Snapshotable
    var username: String = ""

    var authToken: String = "" // never exported
}
```

Unmarked fields never appear in the snapshot, which keeps tokens, PII, and auth state out of recorded fixtures by default. A marked field must be a writable instance `var` on a file-scope observable class, with an explicit type and an internal or public setter. Supported snapshot types are JSON-native scalars (`String`, `Bool`, signed/unsigned integer widths, `Float`, `Double`, `CGFloat`), arrays, String-keyed dictionaries, and Optional compositions of those types. Snapshot 키는 관찰 가능한 클래스의 고유해야합니다. 발전기 보고서 및 잘못된 선언, 사용자 정의 값, implicitly unwrapped 선택적인, 배열 된 관찰 가능한 클래스, 또는 깨진 또는 손실 Swift를 방출 대신 중복 키에 중지합니다. 복원은 두 단계를 사용합니다. 모든 모델은 완전한 입력을 먼저 유효하며, MainActor에 적용 된 할당입니다.

## 단계 5: 원격 에이전트 작업을 (선택 사항)

다른 기계에 에이전트을 하자 장치에, `--tailnet`를 가진 daemon를 달기 위하여:

```
gstack-ios-qa-daemon --tailnet
```

daemon 프로브 `/var/run/tailscale.sock` 첫째; 소켓이 누락되거나 읽을 수 있는 경우에, 그것은 모든 (회로가 아직도 실행)에 tailnet 청취기를 열지 않습니다. 먼 형태 결코 반시작.

그런 다음 연결할 수 있어야 하는 정체성을 위해 세션 token을 축소하십시오.

```
gstack-ios-qa-mint grant --remote 'alice@example.com' --capability interact
gstack-ios-qa-mint grant --remote 'tag:ci' --capability mutate --ttl 86400 --note 'nightly'
gstack-ios-qa-mint list
```

Capability 계층은 배열됩니다: `observe` (읽힌 엔드 포인트 만) ❉ `interact` (taps, swipes, 유형)  `mutate` (`POST /state/*`) ❉ `restore` (`POST /state/restore`). 작업이 가장 작은 계층을 선택하십시오. allowlist 파일은 `~/.gstack/ios-qa-allowlist.json` (mode 0600)에 있습니다 - daemon는 각 `/auth/mint` (`/auth/mint`)에 그것을, 이렇게 즉시 신청 없이 다시 시작 효력이 있습니다.

The remote agent then hits `POST /auth/mint` against the daemon's tailnet listener. The daemon canonicalizes the caller's identity via tailscaled's WhoIs endpoint, checks the allowlist, and returns a short-lived session token (1 hour default, 24 hour cap). Every authenticated mutating request lands in `~/.gstack/security/ios-qa-audit.jsonl`; rejected requests land in `~/.gstack/security/attempts.jsonl`.

## Step 6: 출시 빌드를 배워

테스트 파이트 또는 앱 스토어로 발송하기 전에 `/ios-clean`을 실행합니다. `DebugBridge` SPM 의존도와 `#if DEBUG` 배선을 `@main` 앱에서 제거하십시오. `Package.swift` (`condition: .when(configuration: .debug)`)의 구조상 감시는 당신이 청소하는 것을 잊어버리면 다리를 연결할 수 없더라도, `/ios-clean`는 당신을 호랑이 diff를 검토하고 배를 줍니다.

## 일반적인 실패

| 의약 | 의논하기 |
|---|---|
| `xcodebuild` `Could not locate device support files for iOS X.Y`와 실패 | `xcodebuild -downloadPlatform iOS`를 실행하여 iPhone의 iOS 버전(~8GB)의 장치 지원 패키지를 넣으려면. |
| 성공 설치, `process launch` 실패 `Locked` | 전화가 잠겨 있습니다. 잠금 해제 및 재시. |
| 페어링 장치에 첫 설치하면 no 클리어 오류가 실패합니다. | 전화는 Mac을 신뢰해야 합니다. 설정 → 일반 → VPN 및 휴대폰의 장치 관리 및 확인을 엽니다. |
| `Developer Mode` 설정에서 누락된 toggle → 개인 정보 보호 | Xcode → Window → 장치 및 시뮬레이터에 장치를 한 번 연결하거나, 그것을 위해 `devicectl device install`를 시도하십시오. iOS는 첫 번째 시도 후 toggle를 표면화합니다. |
| `xcrun devicectl device copy from` ERROR 7000을 반환합니다 | 소스 경로는 잘못된다 - 부팅 token app의 데이터 컨테이너 내부의 `tmp/gstack-ios-qa.token` (NSTemporaryDirectory), 경로의 루트에. |
| `/healthz` 200을 반환하지만 `/tap`는 ok을 반환합니다 : no UI 변경 | 전화는 페어링되지만 StateServer 포트는 시작을 가로지르는 경우가 있습니다. CoreDevice IPv6 (`dscacheutil -q host -a name '<DeviceName>.coredevice.local'`)를 다시 해결합니다. |
| `403 identity_not_allowed` `/auth/mint`에서 | 원격 콜러의 정체성은 Mac의 허용 목록에 없습니다. Mac에서 `gstack-ios-qa-mint grant --remote <identity> --capability interact`를 실행하십시오. |
| daemon은 뒷문 청취자를 열지 않습니다. | 스태크는 설치되지 않습니다, 또는 `/var/run/tailscale.sock`는 읽을 수 없습니다. 스태크를 수정하고, 다음 데몬을 다시 시작합니다. 루프백은 여전히 그 동안 실행됩니다. |
| SwiftUI 버튼 탭은 `ok:true`를 반환하지만 동작은 불을 받지 않습니다. | `_UIHitTestContext`가 존재하지 않는 iOS 17 이상에 있습니다. DebugBridgeTouch 구현은 SwiftUI의 제스처 컨테이너로 해결되지 않는 일반 `hitTest:`로 돌아갑니다. 기기에서 iOS 18+로 업데이트하거나 UIKit 컨트롤을 대신 탭하십시오. |

## 이 얻은 것

HTTP라는 단어를 가진 모든 언어에서 에이전트 루프를 작성할 수 있습니다. 스크린 샷을 찍고, 탭을 보내세요. 캡처 상태 스냅 샷을 전후에 `/ios-fix` 회귀 테스트를 위해 세례적인 고정물을 기록합니다. allowlist에 동료를 추가하고 하드웨어를 만지지 않고 노트북에서 iPhone을 구동하십시오. daemon를 CI로 `tag:ci`를 `tag:ci`로 입력하고, TTL를 사용하여 24시간 세션을 갖추십시오.

전체 스택은 이미 소유 한 Mac, 이미 iPhone, 무료 Apple 개발자 계정 및 gstack입니다. No 유료 테스트 서비스. No 시뮬레이터 편방. 사용자가 표시하는 것은 에이전트 드라이브가 무엇인지.
