# 사이드바 흐름

GStack 브라우저 사이드바는 실제로 작동합니다. `sidepanel.js`, `background.js`, `content.js`, `terminal-agent.ts`, 또는 sidebar-related 서버 엔드포인트를 터치하기 전에 이것을 읽으십시오.

사이드바는 1개의 1개의 1 차적인 표면이 있습니다 — **의 끝** pane, 상호 작용하는 `claude` PTY. 활동/참고/검사기는 발기부에 있는 `debug` toggle 뒤에 벌레 오바레이로 살아납니다. 대화 큐 경로 (원샷 `claude -p`, sidebar-agent.ts)는 PTY가 밖으로 입증된 후에, 찢어졌습니다 — 맨끝 팬은 엄격히 더 가능합니다.

## 부품

```
┌─────────────────┐     ┌──────────────┐     ┌──────────────────┐
│  sidepanel.js + │────▶│  server.ts   │────▶│terminal-agent.ts │
│  -terminal.js   │     │  (compiled)  │     │  (non-compiled)  │
│  (xterm.js)     │     │              │     │  PTY listener    │
└─────────────────┘     └──────────────┘     └──────────────────┘
        ▲                       │                      │
        │  ws://127.0.0.1:<termPort>/ws (Sec-WebSocket-Protocol auth)
        └───────────────────────┼──────────────────────▶│ Bun.spawn(claude)
                                │                      │  terminal: {data}
                                │                      ▼
                                │              ┌──────────────────┐
                                │              │  claude PTY      │
                                │              └──────────────────┘
            POST /pty-session   │
            (Bearer AUTH_TOKEN) │
                                ▼
                       ┌──────────────────┐
                       │ pty-session-     │
                       │ cookie.ts        │
                       │ (in-memory token │
                       │  registry)       │
                       └──────────────────┘
                                │
                                │ POST /internal/grant (loopback)
                                ▼
                       ┌──────────────────┐
                       │  validTokens Set │
                       │  in agent memory │
                       └──────────────────┘
```

컴파일된 검색 서버는 `posix_spawn` 외부 실행을 하지 못할 수 있습니다. - `terminal-agent.ts`는 별도의 비 컴파일된 `bun run` 프로세스로 실행되며 `claude` 하위 처리를 소유합니다.

## 스타트업 + 첫 키 입력 타임라인

```
T+0ms     CLI runs `$B connect`
            ├── Server starts (compiled)
            └── Spawns terminal-agent.ts via `bun run`

T+500ms   terminal-agent.ts boots
            ├── Bun.serve on 127.0.0.1:0 (random port)
            ├── Writes <stateDir>/terminal-port (server reads it for /health)
            ├── Writes <stateDir>/terminal-internal-token (loopback handshake)
            └── Probes claude → writes claude-available.json

T+1-3s    Extension loads, sidebar opens
            ├── background.js: GET /health (liveness only — no token) then
            │   POST /extension-token → AUTH_TOKEN. The server releases the
            │   token only to Origin chrome-extension://<pinned id>; the
            │   manifest "key" pins the ID (browse/scripts/extension-id.ts)
            ├── sidepanel-terminal.js: setState(IDLE), shows "Starting Claude Code..."
            └── tryAutoConnect() polls until window.gstackServerPort + token are set

T+ready   tryAutoConnect calls connect()
            ├── POST /pty-session (Authorization: Bearer AUTH_TOKEN)
            │   └── server mints attach token, posts /internal/grant to agent
            │   └── responds with {terminalPort, sessionId, attachToken,
            │                      leaseExpiresAt}
            ├── GET /claude-available (preflight)
            ├── new WebSocket(`ws://127.0.0.1:<terminalPort>/ws`,
            │                 [`gstack-pty.<token>`])
            │   └── Browser sends Sec-WebSocket-Protocol + Origin
            │   └── Agent validates Origin AND token BEFORE upgrading
            │   └── Agent echoes the protocol back (REQUIRED — browser
            │       closes the connection without it)
            ├── On open: send {type:"resize"} then a single \n byte
            └── Agent message handler sees the byte → spawnClaude()
```

## Auth: WebSocket는 허가 우두머리를 보낼 수 없습니다

브라우저 WebSocket 클라이언트는 `Authorization`를 놓을 수 없습니다. CAN는 `Sec-WebSocket-Protocol`의 두번째 arg를 통해 `new WebSocket(url, protocols)`를 놓습니다. 우리는 그것을 악용합니다:

1. `POST /pty-session` (auth: Bearer AUTH_TOKEN) → 서버는 분 a를 분
   짧은 라이브 세션 token, 반복백에 에이전트에 밀어, JSON 몸에 반환.
2. 확장 호출 `new WebSocket(url, ['gstack-pty.<token>'])`.
3. 에이전트는 `Sec-WebSocket-Protocol`, 스트립 `gstack-pty.`, 유효성 검사를 읽습니다
   `validTokens`에 대하여, 의정서를 뒤로 정합니다. Echo는 그것 Chromium 없이 필수 입니다 향상 응답의 영수증에 연결을 닫습니다.

`Set-Cookie: gstack_pty=...` 헤더는 비폭스 콜러 (curl, 통합 테스트)에 대해 반환됩니다. cookie 경로는 원래 v1 디자인이었지만 `SameSite=Strict` 쿠키는 server.ts:34567 → 에이전트에서 크로스 포트 점프를 생존하지 않습니다.<random>는 크롬 확장 기원에서. 프로토콜 토큰 경로는 실제로 사용하는 것입니다.

## 듀얼-투켄 모델

| 의논하기 | 의 삶 | 사용 | 의논하기 |
|-------|----------|----------|----------|
| `AUTH_TOKEN` | `<stateDir>/browse.json`; server.ts에 있는 in 메모리; pinned-origin `POST /extension-token`를 통해 확장 기억 (never `GET /health`) | `/pty-session` POST (mint cookie + token) | 서버 일생 |
| `gstack-pty.<...>` (Sec-WebSocket-Protocol) | 브라우저 메모리만; 에이전트 `validTokens` 설정 | `/ws` 업그레이드 auth | 30 분, 자동 보류에 WS 닫기 |
| `INTERNAL_TOKEN` | `<stateDir>/terminal-internal-token`; 에이전트 기억에서 | 서버 → 에이전트 루프백 `/internal/grant` | 에이전트 일생 |

`AUTH_TOKEN`는 `/ws`를 위해 유효한 **은지** 직접 입니다. 세션 token는 `/pty-session` 또는 `/command`를 위해 유효한 **은지**입니다. 엄격한 별거는 포탄 접근으로 에스컬레이션에서 SSE 또는 페이지 내용 token 누출을 방지합니다.

## 스트리 모델

터미널 팬 **신속한 주입 보안 스택 우회** on purpose — 사용자는 claude에 직접 입력하고, 루프에 no 무신뢰 페이지 내용이 있습니다. 신뢰할 수있는 소스는 키보드, 어떤 로컬 터미널과 동일합니다.

즉 신뢰 가정은 3개의 수송 보증에 짐 방위입니다:

1. **현지인 청취자** terminal-agent.ts `127.0.0.1`만 바인딩합니다.
   이중 감속기 터널 표면 (server.ts `TUNNEL_PATHS`)는 `/pty-session` 또는 `/terminal/*`를 포함하지 않습니다, 그래서 터널는 404를 기본적으로 데니에 의하여 반환합니다.
2. **근원 문.** `/ws` 업그레이드가 필요합니다.
   `Origin: chrome-extension://<id>`. localhost 웹 페이지는 원래 `http(s)://...`이기 때문에 포탄에 대하여 단면적 WebSocket hijack를 거치지 않을 수 있습니다.
3. **세션 token 우.** 정정된
   `/pty-session` POST, scoped에서 1개의 WS, 닫히는 자동 보복.

그 세 가지 중 하나를 떨어 뜨리고 전체 탭은 안전하지 않습니다.

## 라이프사이클

- **Eager 자동 연결.** 사이드바가 열립니다 → TryAutoConnect polls for
  부트 스트랩 글로벌과 연결이 곧 설정된다. No 키 프레스 필요.
- **WS 당 PTY.** WebSocket SIGINTs claude, 그 다음 SIGKILLs 닫기
  3s 후. 세션 token는 다시 재생할 수 없습니다 그래서 스 도난 token를 수정합니다.
- **No 자동 연결은 닫힙니다.** 사용자가 "Session end, click를 참조하십시오.
  새로운 세션을 시작합니다. 자동 연결은 각 리로드에 신선한 클로드 세션을 태울 것입니다. v1.1은 탭/session ID에 키 입력된 세션을 추가할 수 있습니다 (TODOS 참조).
- **수동 재시작 anytime.** A `↻ Restart` 단추는 항상 안으로 생활합니다-
  가시성 터미널 도구 모음 - ENDED 상태에서 중간 세션을 작동.

## 빠른 액션 툴바

세 개의 브라우저 액션 버튼은 터미널 팬의 상단의 나머지 버튼 옆에 있습니다.

| Button | Behavior |
|--------|----------|
|  ⁇   ⁇   ⁇  | `window.gstackInjectToTerminal(prompt)` - "remove ads/banners"를 라이브 PTY로 파이프. 터미널에 claude는 그것을보고 행동합니다. |
| 스크랩 | `POST /command screenshot` - 직접 검색 서버 통화, no PTY 참여. |
|  ⁇  쿠키 | `/cookie-picker` 페이지에 이동합니다. |

검사관의 "코드에 보내기" 버튼은 `gstackInjectToTerminal` 경로와 같은 CSS 검사관 데이터를 claude로 사용합니다.

## 디버그 표면 (액티비티 / Refs / Inspector)

발터의 `debug` toggle 뒤에. SSE-디렉션, 터미널 팬의 독립:

- **의정부** - `/activity/stream` SSE를 통해 모든 검색 명령을 스트림합니다.
- **의 특징** — REST: `GET /refs` — 현재 페이지 `@ref` 성분 상표.
- **검사기** — CDP-기반 요소 피커; SSE `/inspector/events`.

디버그 스트립이 닫을 때, 터미널 팬은 볼 수 있습니다. xterm.js는 `display:none`에서 `display:flex`로 컨테이너 플립이 될 때 자동 철회가 아니라 `MutationObserver`는 `#tab-terminal`의 클래스 속성에서 `.active`가 반환될 때 적합 + 새로 고침을 강제합니다.

## 파일

| 제품정보 | File | 을 실행 |
|-----------|------|---------|
| Sidebar UI shell | `extension/sidepanel.html` + `sidepanel.js` + `sidepanel.css` | Chrome 측 패널 |
| 맨끝 UI | `extension/sidepanel-terminal.js` + `extension/lib/xterm.js` | Chrome 측 패널 |
| 서비스 노동자 | `extension/background.js` | Chrome 배경 |
| 콘텐츠 스크립트 | `extension/content.js` | 페이지 컨텍스트 |
| HTTP 서버 | `browse/src/server.ts` | Bun (이익을 얻은 바이너리) |
| PTY 에이전트 | `browse/src/terminal-agent.ts` | Bun (비 컴파일) |
| PTY token 저장 | `browse/src/pty-session-cookie.ts` | Bun (필립, server.ts) |
| CLI 입력 | `browse/src/cli.ts` | Bun (이익을 얻은 바이너리) |
| 국가 파일 | `<stateDir>/browse.json` | 파일시스템 |
| 터미널 포트 | `<stateDir>/terminal-port` | 파일시스템 |
| 내부 token | `<stateDir>/terminal-internal-token` | 파일시스템 |
| Claude probe | `<stateDir>/claude-available.json` | 파일시스템 |
| Active 탭 | `<stateDir>/active-tab.json` | Filesystem (클래드 읽기) |
