# 브라우저 / 사이드바 / 서버 내부

CLAUDE.md (token-load reduce)에서 동사. 이들은 `browse/src/server.ts`, Chrome 확장, sidebar PTY, SSE 엔드포인트, CDP 세션 및 사이드바 보안 스택에 대한 부하 방위적 인 변수입니다. 모든 규칙은 단락에 이름을 붙인 CI 트립 와이어 테스트에 의해 추가됩니다.

**Sidebar 건축:** `sidepanel.js`, `background.js`, `content.js`, `terminal-agent.ts`, 또는 sidebar-related 서버 엔드포인트 수정하기 전에 `docs/designs/SIDEBAR_MESSAGE_FLOW.md`를 읽으십시오. 사이드바에는 1개의 1개의 1개의 1개의 1 차적인 표면이 있습니다 — **의 끝** pane (interactive `claude` PTY) - 활동과 더불어, 발러의 `debug` toggle 뒤에 디버그 오바레이로/검사기. 대화는 일단 경로를 설명했습니다; PTY는, r10/>를 봅니다; `sidebar-agent.ts`와 `/sidebar-command`/ `/sidebar-chat`/ `/sidebar-agent/event` 엔드포인트가 사라집니다. doc은 WS auth 교류, 이중 군 모형 및 위협 모형 경계를 다룹니다 - 이차적인 실패는 여기에서 보통 교차 성분 교류를 이해하지 않기 위하여 추적합니다.

**Embedder 터미널 에이전트 소유권** (v1.42.1.0+의 ID 근거한 죽이는 v1.44.0.0+). `browse/src/server.ts`에서 `buildFetchHandler`는 `ServerConfig.ownsTerminalAgent?: boolean` (default `true`)를 받아들입니다. `true`일 때, 공장 폐쇄는 가득 차있는 눈물방울을 달립니다: `killAgentByRecord(readAgentRecord(stateDir))`를 통해 ID 기반 kill `browse/src/terminal-agent-control.ts`와 `safeUnlinkQuiet` `<stateDir>/terminal-port`, `<stateDir>/terminal-internal-token`, `<stateDir>/terminal-agent-pid` (v1.44)에 소개된 per-boot 에이전트 기록. Embedders (e.g. gbrowser phoenix overlay)는 PTY 서버를 미리 발사해야 합니다 `false` 그래서 그들의 발견 파일은 gstack 눈물주기를 살아남습니다. 플래그는 `ServerConfig` (alongside `xvfb?` 및 `proxyBridge?`); 극성은 (explicit bool vs 존재)로 거꾸로하고 필드 JSDoc에 문서화됩니다. CLI `start()`는 항상 `true`를 명시적으로 전달합니다. `browse/test/server-embedder-terminal-port.test.ts`의 정적 그립 테스트는 CI가 다시 떨어질 경우 CI가 실패합니다. `start()`는 호스트를 죽이는 `start()`와 동일하게 사용됩니다. `start()`는 호스트를 죽이는 CI와 동일하게 사용됩니다. 새로운 `browse/test/terminal-agent-pid-identity.test.ts` 정적 그립 삼각은 CI를 실패합니다
어떤 소스 파일 re-introduces `pkill ... terminal-agent` 또는 `spawnSync('pkill', ...)`를 읽는 경우에.

**WebSocket auth는 Sec-WebSocket-Protocol를 사용하며, 쿠키가 아닙니다.** 브라우저는 WebSocket 업그레이드에서 `Authorization`를 설정할 수 없지만 `Sec-WebSocket-Protocol`를 `new WebSocket(url, [token])`를 통해 CAN를 설정할 수 없습니다. 이 에이전트는 `validTokens`에 대한 유효성 검사 및 MUST는 echo 없이 업그레이드 응답에서 프로토콜을 다시 설정합니다. Chromium는 즉시 연결이 닫습니다. gstack_pty=...` is kept as a fallback for non-browser callers (the cross-port `SameSite=Strict` cookie 경로는 크롬 확장 origin)에서 살아남지 않습니다.

**Cross-pane PTY injection.** 도구 모음의 정리 버튼과 검사관의 "코드에 보내기"작동 모두 파이프 텍스트를 라이브 클로드 PTY를 통해 `window.gstackInjectToTerminal(text)`, `sidepanel-terminal.js`에 노출. No `/sidebar-command` POST — 라이브 REPL는 사이드바에서 유일한 실행 표면입니다.

**`/health` MUST NOT 표면 token — 그리고 그것은 no 더 긴 것** (v1.63+). The historical headed-mode leak of `AUTH_TOKEN` is fixed: `GET /health` is liveness/status only in every mode. Token bootstrap is `POST /extension-token`, which validates the caller's Origin against the pinned extension identity (the `key` field in `extension/manifest.json` pins the extension ID — `GSTACK_EXTENSION_ID` in `browse/src/server.ts`, derivation reproducible via `bun browse/scripts/extension-id.ts`) plus a loopback Host. PTY auth는 `POST /pty-session`를 통해서 아직도 흐릅니다. token에 `/health`를 추가하지 마십시오.

**교통층 보안** (v1.6.0.0+). `pair-agent`가 ngrok 터널를 시작하면 daemon는 두 HTTP 청취자를 묶습니다: 국부적으로 청취자 (127.0.0.1, 가득 차있는 명령 표면, 결코 앞으로) 및 터널 청취자 (locked allowlist: `/connect`, `/command`를 가진 scoped token + 26-command 브라우저 - allowlist 터널를, 앞으로 돌려보냅니다. SSE 엔드포인트는 `POST /sse-session` (`/command`에 대한 유효한) `POST /sse-session`를 통해 HttpOnly `gstack_sse` cookie를 사용하는 30 분 HttpOnly `gstack_sse` cookie를 사용합니다. `server.ts`, `sse-session-cookie.ts`, `tunnel-denial-log.ts`를 편집하기 전에 [ARCHITECTURE.md](../ARCHITECTURE.md#dual-listener-tunnel-architecture-v1600)를 읽어봅시다. no에서 `token-registry.ts`의 import는 `token-registry.ts`의 load/>를 위해 적재 범위가 로드됩니다.

**서버 egress에서 Unicode 위생** (v1.38.0.0+). 페이지 내용 파생 문자열 MUST를 발송하는 각 서버는 `JSON.stringify(payload, sanitizeReplacer)`를 통해 이동하고, 객체 탑재량 또는 `sanitizeLoneSurrogates(body)` 텍스트 몸에 대한. Lone UTF-16 surrogate halves from CDP 페이지 내용 그렇지 않으면 Anthropic API에 도달합니다 `\uD800`-style 탈출 및 400. 오늘 4개의 점에서 타전하십시오: `handleCommandInternal` (HTTP + `handleCommandInternalImpl`)와 SSE 프로듀서 (`/activity/stream`, `/inspector/events`)를 통해 배치. 포스트-stringify regex는 no-op입니다 — `JSON.stringify`는 이미 regex가 일치하기 전에 surrogate를 탈출했습니다, 그래서 대신 기호는 인코딩 파이프라인 안쪽에 실행해야합니다. 새로운 SSE/WebSocket 작가 또는 HTTP 응답 `server.ts`, `server.ts` 응답 `server.ts`, <10/>, <10/>, <10/>, <10/>, <10/>. `browse/test/server-sanitize-surrogates.test.ts`는 invariant 시험과 배선을 핀으로 꼿습니다, 그래서 우회는 CI 실패합니다.

**SSE 엔드포인트  헬퍼** (v1.51.0.0+). `server.ts` MUST 노선에서 `createSseEndpoint(req, config)`를 통해서 새로운 SSE 엔드포인트. 돕는자는 JSON.stringify에 `sanitizeLoneSurrogates`에 있는 `sanitizeLoneSurrogates`를 통해서 MUST 노선에 있는 클린업 계약 (abort + enqueue-throw + heartbeat-throw, 모든 idempotent) 그리고 빵을 소유합니다. `ReadableStream` 배선은 TCP 연결이 `req.signal.abort` (Chromium MV3 서비스 노동자 suspend, 중간 프록시 반 닫히는)를 강제하지 않고 사망했을 때 구독자를 유출했습니다. `/activity/stream`, `/inspector/events`, `/memory` (SSE-eligible) 모든 노선을 통해. `browse/test/sse-helpers.test.ts` 핀은 정리 계약을 핀으로 합니다.

**CDP 세션 수명주기** (v1.51.0.0+). `page.context().newCDPSession(page)` 외 `browse/src/cdp-bridge.ts` 외 CI를 `browse/test/cdp-session-cleanup.test.ts`에서 정적 지프 삼각을 통해 호출하십시오. `withCdpSession(page, async (s) => {...})`를 1발 CDP 일 (try/finally detach) 또는 `getOrCreateCdpSession(page, cache)`를 위한 캐시된 회의를 위해 `getOrCreateCdpSession(page, cache)`를 위해 사용하십시오 (`Map<page, session>`를 통해 닫히는 표). 3개의 migin-cdp-d-d-d-d-d-d-d-d-d-dtach. 돕는 성공적인 동경 파견이 일어난 per-session 누출 클래스를 방지하지만 오류 동경 파견이 놓쳤다.

**symlink 경화** (v1.38.0.0+). `setup` MUST 노선의 각 링크 사이트는 `IS_WINDOWS` 탐지를 가까이서 `_link_or_copy SRC DST` 돕는 사람을 통해서 입니다. 개발자 형태 없이 Windows에, 보통 `ln -snf`는 각 호스트 접합기의 맞은편에 `git pull`에 새로 고침하지 않는 언 파일 사본을 생성합니다. 돕는 유닉스에 `ln -snf` 및 `cp -R`에 `cp -R`/>에 `cp -f`에 `cp -f`를 전환합니다: variant in Windows/> 단일 원시 `ln` 은 돕기 바디 바깥쪽으로 호출됩니다 CI. Windows 사용자는 `_print_windows_copy_note_once` 에서 원라인 노트를 제거하여 `./setup` 를 각 `git pull` 으로 다시 실행합니다.

**Sidebar 보안 스택** (진짜 주입에 대하여 층을 꿴 방위):

| Layer | 모듈 | 의 삶 |
|-------|--------|----------|
| L1-L3 | `content-security.ts` | 서버 + 읽는 경로 — datamarking, 숨겨진 요소 스트립, ARIA regex, URL blocklist, 봉투 감싸기 |
| L4 | `security-classifier.ts` (테라다이 ONNX) | **보안 sidecar 하위 처리만** (`security-sidecar-entry.ts`, server.ts에서 `security-sidecar-client.ts`에 의해 모는) |
| 의약 | `security.ts` (generate/inject/detect) | 순수 유틸리티 - no 생산 인젝터 오늘 (그들은 ripped를 주사 한 채팅 프롬프트 빌더) |
| 팟캐스트 | `security.ts` (combineVerdict + THRESHOLDS) | 순수, 테스트; transcript/deberta 레이어의 투표 처리 no 라이브 레이어가 더 이상 생성 |

역사 참고: L4b Haiku 성적표 및 선택인 DeBERTa ensemble (`GSTACK_SECURITY_ENSEMBLE=deberta`)는 채팅 방향 에이전트가 찢어 졌을 때까지 존재했습니다. 둘 다 죽은 코드 (zero 생산 칭호)로 삭제되었습니다. 살아있는 것과 같이 재 문서하지 마십시오.

**긴요한 constraint:** `security-classifier.ts` CANNOT는 컴파일된 찾아 바이너리에서 수입됩니다. `@huggingface/transformers` v4는 `dlopen`에 실패한 Bun 컴파일의 임시 추출물 디디 — 그러므로 sidecar 이하 처리가 `security.ts` (pure-string 가동 — 공용품, verdict 결합자, 상태)만 `server.ts`를 위해 안전합니다. `~/.gstack/projects/garrytan-gstack/ceo-plans/2026-04-19-prompt-injection-guard.md` §"Pre-Impl Gate 1 Outcome"을 참조하십시오.

**Thresholds** (`security.ts`에서): `BLOCK: 0.85`, `WARN: 0.75`, `LOG_ONLY: 0.40`, `SOLO_CONTENT_BLOCK: 0.92` (표면 없는 내용 분류기는 사용자를 위해 "피싱"에서 "인젝션"를 구별할 수 없습니다, 그래서 그들의 솔로 막대기는 더 높습니다). 살아있는 L4 경로는 server.ts의 sidecar-scan 취급에서 이것을 적용합니다; 운새는 항상 BLOCKs (인테미리얼)를 누출합니다.

**Env 손잡이:**
- `GSTACK_SECURITY_OFF=1` - 비상 사태 스위치. Classifier가 꺼져도
  따뜻하게; L1-L3 필터가 실행되도록 합니다.
- Classifier 모델 캐시: `~/.gstack/models/testsavant-small/` (112MB, 첫 번째 실행만)
- 공격 로그: `~/.gstack/security/attempts.jsonl` — 작성한
  `tunnel-denial-log.ts` (전투표 표면 거부; 10MB, 5 세대에서 회전)

History note (#2557): the cross-process session state (`~/.gstack/security/session-state.json`), `getStatus()`, the `/health` `security` field, and the sidepanel SEC shield were all removed — the state file lost its only writer when sidebar-agent.ts was ripped, so the shield reported a permanent 'inactive' or a stale false-green 'protected' from leftover disk state. The live defenses (L1-L3 filters, L4 sidecar on the inject-scan path) report through their own call sites, never through /health. `browse/test/server-security-surface.test.ts` 핀은 제거와 살아있는 L4 배선 둘 다 핀으로 꼿습니다. 살아있는 것과 같이 이 문서를 재 문서화하지 마십시오.
