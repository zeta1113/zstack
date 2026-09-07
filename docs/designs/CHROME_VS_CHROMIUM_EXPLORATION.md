# Chrome vs Chromium: 왜 우리는 Playwright의 번들 Chromium를 사용합니다.

## 원래 비전

`$B connect`를 구축하면, 플랜은 사용자 **Chrome 브라우저**에 연결하기 위해 계획되어, 쿠키, 세션, 확장 및 열린 탭과 함께. 더 많은 쿠키 수입이 없습니다.

1. `chromium.connectOverCDP(wsUrl)` CDP를 통해 Chrome를 실행하는 연결
2. Quit Chrome gracefully, relaunch with `--remote-debugging-port=9222`
3. 사용자의 실제 검색 컨텍스트에 액세스

`chrome-launcher.ts`가 존재한 이유입니다 (361 LOC 브라우저 이진 발견의, CDP 항구 probing, 및 runtime 탐지) 그리고 왜 방법 `connectCDP()`이라고 불렸습니다.

## 실제로 Happened가

Real Chrome 침묵으로 블록 `--load-extension` Playwright의 `channel: 'chrome'`를 통해 시작될 때. 연장은 로드하지 않을 것입니다. 우리는 사이드 패널 (activity feed, refs, chat)의 확장을 필요로 합니다.

The implementation fell back to `chromium.launchPersistentContext()` with Playwright's bundled Chromium — which reliably loads extensions via `--load-extension` and `--disable-extensions-except`. But the naming stayed: `connectCDP()`, `connectionMode: 'cdp'`, `BROWSE_CDP_URL`, `chrome-launcher.ts`.

원래의 비전 (사용자의 실제 브라우저 상태)는 결코 구현되지 않았습니다. 우리는 매번 신선한 브라우저를 출시했습니다. - Playwright의 Chromium와 동일하지만, 죽은 코드와 미주리 이름의 361 줄이 있습니다.

## 디스커버리 (2026-03-22)

`/office-hours` 디자인 세션 중, 우리는 건축과 발견을 추적했습니다.

1. `connectCDP()`는 CDP를 사용하지 않습니다. `launchPersistentContext()`를 호출합니다.
2. `connectionMode: 'cdp'`는 misleading입니다 — 그것은 다만 "긴 형태"입니다
3. `chrome-launcher.ts`는 죽은 코드입니다. 그 유일한 수입은 `attemptReconnect()` 메소드에 속했습니다.
4. `preExistingTabIds`는 우리가 결코 연결하지 않는 진짜 Chrome 탭을 보호하기를 위해 디자인되었습니다
5. `$B handoff` (헤드리스 → 헤드)는 다른 API (`launch()` + `newContext()`)를 사용하여 확장을로드 할 수 없으므로 두 가지 다른 "머리" 경험을 만들 수 있습니다.

## 수정

## 이름
- `connectCDP()` → `launchHeaded()`
- `connectionMode: 'cdp'` → `connectionMode: 'headed'`
- `BROWSE_CDP_URL` → `BROWSE_HEADED`

### 삭제
- `chrome-launcher.ts` (361 LOC)
- `attemptReconnect()` (드래드 방법)
- `preExistingTabIds` (드래드 개념)
- `reconnecting` 필드 (드레드 상태)
- `cdp-connect.test.ts` (노출 코드 테스트)

## # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
- `$B handoff`는 `launchPersistentContext()` + 연장 선적 (`$B connect`와 같)를 사용합니다
- 1개의 머리로 한 형태, 2개 아닙니다
- Handoff는 당신에게 연장 + 측 패널을 무료로 제공합니다

#### 등급
- `--chat` 플래그 뒤에 사이드바 채팅
- `$B connect` (과태): 활동 급식 + refs만
- `$B connect --chat`: + 실험 독립 채 로봇

## 건축 (후)

```
Browser States:
  HEADLESS (default) ←→ HEADED ($B connect or $B handoff)
     Playwright            Playwright (same engine)
     launch()              launchPersistentContext()
     invisible             visible + extension + side panel

Sidebar (orthogonal add-on, headed only):
  Activity tab    — always on, shows live browse commands
  Refs tab        — always on, shows @ref overlays
  Chat tab        — opt-in via --chat, experimental standalone agent

Data Bridge (sidebar → workspace):
  Sidebar writes to .context/sidebar-inbox/*.json
  Workspace reads via $B inbox
```

## 왜 진짜 Chrome?

Real Chrome 블록 `--load-extension` Playwright에 의해 시작될 때. 이것은 Chrome 보안 기능 - 명령 줄 args를 통해 로드된 확장은 악성 확장 주사를 방지하기 위해 크롬 기반 브라우저에서 제한됩니다.

Playwright의 번들 Chromium는 테스트 및 자동화를 위해 디자인되기 때문에 이 제한이 없습니다. `ignoreDefaultArgs` 선택권은 Playwright의 자신의 연장 차단 깃발을 우회할 수 있습니다.

사용자의 실제 쿠키/sessions에 접속하려면, 경로는 다음과 같습니다.
1. 쿠키 가져오기 (`$B cookie-import`를 통해 알레디 작품)
2. 지휘자 세션 주입 (future — sidebar는 workspace 에이전트에 메시지를 보냅니다)

실제 크롬에 연결하지 마십시오.
