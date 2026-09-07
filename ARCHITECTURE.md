# 건축

이 문서는 **왜?** gstack 는 방법을 내장한다. 설정 및 명령의 경우 CLAUDE.md 을 참조하십시오. 기여를 위해 CONTRIBUTING.md 를 참조하십시오.

## 핵심 아이디어

gstack는 Claude Code를 영구적인 브라우저와 의견이 있는 워크플로우 기술을 제공합니다. 브라우저는 하드 부분입니다. 다른 모든 것은 Markdown입니다.

AI는 브라우저의 **서브초기**와 **persistent 상태**와 상호 작용하는 핵심 통찰력: AI 에이전트. 각 명령이 브라우저를 실행하면 도구 통화당 3-5 초를 기다리게 됩니다. 브라우저가 명령 사이 죽으면 쿠키, 탭 및 로그인 세션을 잃게 됩니다. gstack는 CLI가 로컬 호스트 HTTP가 이야기하는 긴 Chromium daemon를 실행합니다.

```
Claude Code                     gstack
─────────                      ──────
                               ┌──────────────────────┐
  Tool call: $B snapshot -i    │  CLI (compiled binary)│
  ─────────────────────────→   │  • reads state file   │
                               │  • POST /command      │
                               │    to localhost:PORT   │
                               └──────────┬───────────┘
                                          │ HTTP
                               ┌──────────▼───────────┐
                               │  Server (Bun.serve)   │
                               │  • dispatches command  │
                               │  • talks to Chromium   │
                               │  • returns plain text  │
                               └──────────┬───────────┘
                                          │ CDP
                               ┌──────────▼───────────┐
                               │  Chromium (headless)   │
                               │  • persistent tabs     │
                               │  • cookies carry over  │
                               │  • 30min idle timeout  │
                               └───────────────────────┘
```

첫 번째 호출은 모든 것을 시작합니다 (~3s). 모든 전화 후 : ~100-200ms.

## 왜 Bun

Node.js가 작동할 것입니다. Bun는 세 가지 이유에 대해 더 잘 알고 있습니다.

1. **컴파일된 binaries.** `bun build --compile`는 단 하나 ~58MB 실행할 수 있는 생성합니다. No `node_modules`는 런타임에, no `npx`, no PATH 윤곽에 gstack 설치합니다. 이 문제 때문에 `~/.claude/skills/`는 Node.js 프로젝트를 처리할 것으로 예상하지 않습니다 Node.js로 설치합니다.

2. **기본 SQLite.** 쿠키 해독은 Chromium의 SQLite cookie 데이타베이스를 직접 읽습니다. Bun에는 `new Database()`에서 건축하는 no `better-sqlite3`, no 본래 addon 컴파일, no gyp가 있는 `new Database()`가 있습니다. 다른 기계에 틈이 있는 것 보다는 더 적은 것.

3. **Native TypeScript를 사용하세요.** 서버는 `bun run server.ts`로 개발 중이다. No 컴파일 단계, no `ts-node`, no 소스 맵을 디버그로 실행한다. 컴파일된 바이너리는 배포를 위한 것이다; 소스 파일은 개발을 위해 입니다.

4. **내장 HTTP 서버.** `Bun.serve()`는 빠르고, 간단합니다, Express 또는 Fastify가 필요하지 않습니다. 서버는 ~10개의 노선을 합계 처리합니다. 기구는 머리 위일 것입니다.

Bottleneck은 항상 Chromium, CLI 또는 서버가 아닙니다. Bun의 시작 속도 (Node를 위한 컴파일된 바이너리 대 ~100ms를 위한~1ms는 좋은 그러나 우리가 그것을 선택한 이유입니다. 컴파일한 이진과 본래 SQLite는 입니다.

## daemon 모델

## 왜 명령 당 브라우저를 시작하지 않습니까?

Playwright는 ~2-3 초에 Chromium를 시작할 수 있습니다. 단일 스크린 샷의 경우, 괜찮습니다. QA 세션을 20+ 명령으로 들어, 브라우저 시작 오버헤드의 40+ 초입니다. Worse: 당신은 명령 사이 모든 상태를 잃습니다. 쿠키, 로컬 저장, 로그인 세션, 열린 탭 — 모두 사라집니다.

daemon 모델은 다음과 같습니다.

- **지속적인 상태.** 로그인 한 번에 로그인하십시오. 탭을 열고, 엽니다. 명령을 통해 localStorage persists를 유지합니다.
- **서브초 명령.** 첫 번째 호출 후, 모든 명령은 HTTP POST입니다. Chromium의 일을 포함하여 ~100-200ms 둥근 지구.
- **자동적인 lifecycle.** 서버 자동 시작은 처음 사용, 30 분 후에 자동 shuts 아래로. No 가공 관리 필요.

### 국가 파일

서버는 `.gstack/browse.json` (tmp + rename, mode 0o600를 통해 원자 쓰기)를 쓰습니다:

```json
{ "pid": 12345, "port": 34567, "token": "uuid-v4", "startedAt": "...", "binaryVersion": "abc123" }
```

CLI는 서버를 찾기 위해이 파일을 읽습니다. 파일이 누락되거나 daemon 프로세스가 죽으면 CLI가 새 서버로 떠납니다. 살아있지 만 `/health`가 바쁘지 않다면 죽지 않습니다. CLI 프로브는 경계 ~8s를 위해 비제로 출구로 바빴습니다. `--force-restart`는 비이데몬을 죽이지 않습니다. liveness 프로브는 `isProcessAlive` (`isProcessAlive`)를 사용하여, `isProcessAlive` (`isProcessAlive`)를 통해 응답된 ~8s로 표시합니다. stdout/stderr는 `<project>/.gstack/browse-daemon.log`에 의거합니다.

### 포트 선택

10,000-49151 사이 무작위 포트 (중심 5까지), 공유 `browse/src/port-allocator.ts`를 통해 할당 된 그래서 모든 긴 수명 gstack 청취자는 동일한 범위에서 끌어. 범위는 49151의 목적에 종료 : 49152-65535는 macOS ephemeral 풀이며, OS가 다른 프로세스 순간에 동일한 포트를 수 있음을 의미한다. 이것은 10의 지휘자 작업이 각 0/>의 충돌을 파악하고 0/>의 충돌을 검색 할 수 있습니다. 오래된 접근법 (9400-9409를 허용)은 다중 작업 공간 설정에서 지속적으로 파산합니다.

## 버전 자동-restart

빌드는 `git rev-parse HEAD`에서 `browse/dist/.version`로 작성합니다. 이진의 버전이 실행 서버의 `binaryVersion`과 일치하지 않는 경우, CLI는 오래된 서버를 죽이고 새로운 것을 시작합니다. 이것은 "stale 바이너리"를 완전히 제거하고, 다음 명령을 자동으로 선택합니다.

## 보안 모델

## Localhost만

HTTP 서버는 `127.0.0.1`, `0.0.0.0`가 아닌 `0.0.0.0`에 바인딩합니다. 그것은 네트워크에서 접근할 수 없습니다.

## 듀얼-리스트 에너지 터널 아키텍처 (v1.6.0.0)

`pair-agent --client`를 실행할 때 daemon는 ngrok 터널를 시작으로, 먼 페어링 에이전트은 브라우저를 구동할 수 있습니다. 인터넷에 가득 차있는 daemon 표면을 노출시키십시오 (일부 무작위 ngrok subdomain)는 `/health`를 어떤 근원 spoof에 뿌리 token를 새겼습니다, `/cookie-picker`는 token를 HTML로 끼워넣었습니다.

수정은 **two HTTP listeners**, 하나가 아닙니다:

- **지역 청취자** (`127.0.0.1:LOCAL_PORT`) - 항상 경계. token 부트 스트랩 (`POST /extension-token`, 핀 확장 정체성에만 발표), `/health` (liveness/status만 - token), `/cookie-picker`, `/inspector/*`, `/welcome`, `/refs`, sidebar-agent API, 전체 명령 표면. 절대 앞으로.
- **터널링** (`127.0.0.1:TUNNEL_PORT`) - `/tunnel/start`에 속한 `/tunnel/stop`에 속한 `/tunnel/stop`에 속한 경계선. 잠긴 allowlist를 봉사하십시오: `/connect` (세로식, unauth + 비율 제한) 및 `/command` (scoped 토큰은, 브라우저 드레이는 명령 allowlist에 제한했습니다. 다른 모든 404s.

ngrok는 터널 포트만 전달합니다. 보안 속성은 **물리적 포트 분리**: 터널 콜러는 `/health` 또는 `/cookie-picker`에 도달할 수 없기 때문에 그 경로가 TCP 소켓에 존재하지 않기 때문에 TCP에 도달 할 수 없습니다. 헤더 인스 (check `x-forwarded-for`, 체크 origin)는 믿을 수 없습니다 (ngrok 헤더 동작 변경; 로컬 프록시는 이 헤더를 추가할 수 있습니다); 소켓 분리는 아닙니다.

| 종료점 | 지역 청취자 | 터널링 | 참고 |
|---|---|---|---|
| `GET /health` | public (liveness/status만 — token) | 404 | 토큰 부트 스트랩은 `POST /extension-token` (v1.63)로 이동 |
| `POST /extension-token` | 핀으로 꼿는 근원 (`chrome-extension://<GSTACK_EXTENSION_ID>`) + 루프백 Host | 404 | 뿌리를 밖으로 넣는 유일한 결점 token |
| `GET /connect` | public (`{alive:true}`) | public (`{alive:true}`) | 터널의 조사 경로 liveness |
| `POST /connect` | public (rate-limited 300/min) | public (정제) | 쌍 에이전트을 위한 Setup-key 교환 |
| `POST /command` | auth (Bearer 루트 OR scoped) | auth (scoped만, 수당 명령) | 루트 token 터널 = 403 |
| `POST /pair` | root-only | 404 | Pairing mint — 현지 연산자 작업 |
| `POST /tunnel/{start,stop}` | root-only | 404 | Daemon 구성 |
| `POST /token`, `DELETE /token/:id` | root-only | 404 | Scoped token mint/revoke |
| `GET /cookie-picker`, `GET /cookie-picker/*` | public UI, auth API | 404 | Local-only — 로컬 브라우저 DB를 읽습니다. |
| `GET /inspector`, `/inspector/events`, 등. | auth | 404 | 확장 콜백, local-only |
| `GET /welcome` | public | 404 | GStack 브라우저 랜딩 페이지, local-only |
| `GET /refs` | auth | 404 | Ref map – 내부 상태 |
| `GET /activity/stream` | Bearer OR HttpOnly `gstack_sse` cookie | 404 | SSE. ?token= 쿼리 파라m no 더 긴 허용 |
| `GET /inspector/events` | Bearer OR HttpOnly `gstack_sse` cookie | 404 | SSE. /activity/stream와 cookie와 같 |
| `POST /sse-session` | auth (Bearer) | 404 | Mints the view-only 30-min SSE session cookie |

**확장 token 부츠 스트랩 (v1.63.0.0).** `GET /health`는 어떤 형태든지에서 token를 결코 나타낸다 — liveness/status는 단지 입니다. 측바 연장은 `POST /extension-token`를 통해 뿌리 token를, 그것 풀어 놓는 것을 얻고, 콜러의 근원이 정확하게 `chrome-extension://<GSTACK_EXTENSION_ID>` (`key`에 의해 핀으로 꼿는 `extension/manifest.json`;에 있는 `key` 분야; `bun browse/scripts/extension-id.ts`)과 Host 헤더가 루프백 호스트 이름에 곱합니다. `new URL()`로 파싱된 Host는 포트를 운반하기 때문에, 원시를 비교하지 못했습니다. 웹 페이지는 `chrome-extension://` Origin을 강제할 수 없으며, 엔드포인트는 터널 allowlist에 추가되지 않습니다. 터널 표면은 기본적으로 밀도가 404s로 합니다.

**터널 표면 denial 로그.** 터널 리퍼에 대한 모든 거부 (`path_not_on_tunnel`, `root_token_on_tunnel`, `missing_scoped_token`, `disallowed_command:*`)는 타임 탬프, 소스 IP (`x-forwarded-for`), 경로 및 방법 /min와 `~/.gstack/security/attempts.jsonl`와 동시에 기록됩니다. 60의 쓰기에 비율을 붙인/min는 세계적으로 로그 od DoS를 방지하기 위하여. 시프 인젝션 스캐너를 가진 시도 로그를 공유합니다.

**SSE 세션 쿠키.** EventSource는 Authorization 헤더를 보낼 수 없습니다. Bearer를 가진 부트 스트랩에 한 번 확장된 POSTs `/sse-session`를 한 번에 보내고 30분만의 뷰 전용 cookie (`gstack_sse`, HttpOnly, SameSite=Strict)를 받게 됩니다. cookie는 ONLY를 위해 유효 ONLY이고 `/inspector/events` — NOT는 NOT scoped를 <b>/>에 의해 <b>를 가져올 수 없습니다. `/command`는 <b>/>를 <b>로 가져올 수 없습니다.

**이 파에서 비 고갈** (tracked as #1136): the cookie-import-browser path launches Chrome with `--remote-debugging-port=<random>`. On Windows with App-Bound Encryption v20, a same-user local process can connect to that port and exfiltrate decrypted v20 cookies — an elevation path relative to reading the SQLite DB directly (which can't decrypt v20 without DPAPI context). Fix direction is `--remote-debugging-pipe` instead of TCP; requires restructuring the CDP client.

### Bearer token auth

각 서버 세션은 임의 UUID token를 생성하여 모드 0o600 (독립자 전용 읽기)로 state 파일에 기록했습니다. 브라우저 상태가 `Authorization: Bearer <token>`를 포함해야 하는 모든 HTTP 요청은 token와 일치하지 않는 경우 서버는 401을 반환합니다.

이 검색 서버와 대화에서 동일한 기계에 다른 프로세스를 방지합니다. cookie 테이너 UI (`/cookie-picker`) 및 건강 검사 (`/health`)는 로컬 리서치를 면제합니다. 그들은 127.0.0.1-bound이며 명령을 실행하지 않습니다. 터널 리서치에는 `/connect`를 제외하고는 제외되지 않습니다.

## 쿠키 보안

쿠키는 가장 민감한 데이터 gstack 핸들입니다. 디자인:

1. **Keychain 접근은 사용자 승인을 요구합니다.** 브라우저 당 cookie 가져오기는 macOS 키 체인 대화 상자를 트리거합니다. 사용자는 click "Allow" 또는 "Always Allow." gstack 절대로 침묵하는 credentials에 접근해야 합니다.

2. **해독은 처리에서 발생합니다.** 쿠키 값은 Playwright 컨텍스트로 불러오고, 일반 텍스트에서 디스크에 쓰지 않는 PBKDF2 + AES-128-CBC)로 불러오고 있습니다. cookie 프레져 UI는 cookie 값만 표시하지 않습니다.

3. **데이터베이스는 read-only입니다.** gstack는 Chromium cookie DB를 임시 파일에 복사합니다 (뛰는 브라우저를 가진 SQLite 자물쇠 충돌을 피하기 위하여) 그리고 그것을 읽기 전용 열. 그것은 당신의 진짜 브라우저의 cookie 데이타베이스를 결코 변하지 않습니다.

4. **키 캐싱은 제한입니다.** 키 체인 암호 + 파생 AES 키는 서버의 수명에 메모리에 캐시됩니다. 서버가 종료되면 (idle timeout 또는 명시된 중지), 캐시가 사라집니다.

5. **No cookie 로그 값.** 콘솔, 네트워크 및 대화 상자는 cookie 값을 포함하지 않습니다. `cookies` 명령 출력 cookie 메타데이터 (도메인, 이름, 만료) 하지만 값은 truncated.

### 포탄 주입 예방

브라우저 레지스트리 (Comet, Chrome, Arc, Brave, Edge)는 하드 코딩됩니다. 데이터베이스 경로는 알려진 일정에서 구성되며 사용자 입력에서 절대로 유지됩니다. 키 체인 액세스는 `Bun.spawn()`를 명시적인 인수 배열과 함께 사용하며, 쉘 문자열 교환이 아닙니다.

## Egress 영수증 원장 (v1.63.0.0)

Every enumerated gstack-initiated off-machine sink writes a hash-chained, tamper-evident receipt to `~/.gstack/security/egress.jsonl` BEFORE the send — `writeReceipt` in `lib/egress-receipt.ts` for TypeScript callers, `_receipted_curl` / `_receipted_git` from `bin/gstack-egress-lib.sh` for shell scripts. Receipts record a sha256 of the exact bytes sent when the caller owns them (subprocess-owned sends like git pushes record `sha256: null`); they never store the body.

실패 극성은 시험에 의해 일류 그리고 핀으로 꼿습니다. 과민한 수채는 실패하 닫히는: 뇌 동기화 강요, 기억 - 가장, gbrain-sync, telemetry, ngrok 터널 시작, mcp-verify, 및 supabase-provision는 영수증이 (각 refusal 인쇄 문제 + 원인 + 고침) 쓸 수 없는 경우에 보내지 않는 경우에. 사용자 인터페이스 싱크는 stderr 경고로 열리지 않습니다 - 디자인 이진의 OpenAI 통화, 업데이트 검사, read-only 대쉬보드 및 git-class 영수증은 영수증이 실패할 때도 진행합니다. 실패하 열린 전송은 (디자인에 의해, 경고되는) 비결될 수 있습니다. `test/egress-receipt-wiring.test.ts`의 새로운 싱크 스캐너는 CI가 꺼져있을 때 자동 싱크가 발송될 때 실패합니다; 그것의 유일한 기술적인 점은, proseed, proseed. (접속적인)와 가진 proseed.

`bin/gstack-egress`: `list` (gstack가 보내려고 하는 경우), `verify` (체인을, 타당성에 3번 출구로 바꾸십시오), `grants` (각을 회귀하는 방법). `verify`는 편집, 재주문 및 중간 사슬 탈취를 검출합니다; 그것은 NOT는 꼬리 교정, 전체 파일 또는 자기 탈취를 검출합니다. ledger는 ATTEMPTED egress의 법정 관측입니다. 그것은 gstack가 사고를 보내려고하는 것을 기록합니다. 그것은 여과 통제가 아닙니다.

## 서버 egress에 Unicode sanitization (v1.38.0.0)

CDP에 의해 수확된 페이지 내용은 lone UTF-16 surrogate halves (혹은 JavaScript 의 문자열 처리에서 끊긴에서 또는 낮은 surrogates를 포함할 수 있습니다). 그 도달 `JSON.stringify`, Bun 는 `\uD800` 스타일의 탈출 순서로 그 아래에서 소비자의 `JSON.parse`는 허용하지만, Anthropic API 는 400-단일의 페이지에 할당된 페이지에 있는 묶음을 가진 묶습니다.

| Egress 경로 | 모듈 | Sanitization 점 |
|---|---|---|
| `POST /command` (HTTP) | `browse/src/server.ts` | `handleCommandInternal` 래퍼 (`handleCommandInternalImpl`의 결과를 제격) |
| `POST /command/batch` | `browse/src/server.ts` | 동일한 래퍼 - 일괄 소비자가 그것을 상속 |
| `GET /activity/stream` (SSE) | `browse/src/server.ts` | `sanitizeReplacer` `JSON.stringify`로 전달 |
| `GET /inspector/events` (SSE) | `browse/src/server.ts` | `sanitizeReplacer` `JSON.stringify`로 전달 |

`sanitizeReplacer`는 인코딩 중 각 문자열 값을 청소하는 `JSON.stringify` replacer 함수입니다. Post-stringify regex는 여기서 작동하지 않습니다. `JSON.stringify`는 이미 `\uD800`를 리터의 탈출 순서 `"\\ud800"`로 변환했습니다. regex가 일치하기 전에, 대신에 인코딩 파이프 라인 내부를 실행해야합니다. Pure-string helper `sanitizeLoneSurrogates`는 `text/plain` 응답을 위해 직접 사용됩니다.

**건축 invariant.** 모든 새로운 SSE/WebSocket 작가 또는 HTTP 응답은 페이지 내용 파생된 끈 MUST 두 경로 중 하나를 통해 이동: `JSON.stringify(payload, sanitizeReplacer)` 대상 탑재량, 또는 `sanitizeLoneSurrogates(body)` 텍스트 바디에 대 한. 두 우회 하는 새로운 표면은 시스템. SSE 생산자 `server.ts` 둘 다에 주석을 삽입 합니다; `browse/test/server-sanitize-surrogates.test.ts` 핀 배선 버그-repro + invariant 테스트 (`handleCommandInternalImpl` 이름, 중앙 위생 라인, replacer 존재, SSE 제작자는 대신에 끈으로 묶습니다).

## Prompt 주입 방위 (sidebar 에이전트)

Chrome 사이드바 에이전트는 도구 (Bash, 읽기, Glob, Grep, WebFetch) 및 hostile 웹 페이지를 읽는다. 그래서 그것은 gstack의 일부입니다. 방어는 단 하나 지점이 아닌 계층화되어 있습니다.

1. **L1-L3 내용 보안 (`browse/src/content-security.ts`).** 각 페이지 내용 명령과 각 도구 출력에 실행: datamarking, hidden-element strip, ARIA regex, URL blocklist, 그리고 신뢰 경계표 래퍼. 서버와 에이전트 둘 다에 적용.

2. **L4 ML 클래스터 — TestSavantAI (`browse/src/security-classifier.ts`).** A 22MB BERT-small ONNX 모형 (int8 quantized) 안전 sidecar 이하 처리에서 달리기. 국부적으로, no 네트워크를 실행하십시오. 에이전트이 그것을 보는 전에 인젝터 수로에 페이지 파생한 내용 검사하십시오.

3. **L4b 성적표 (제거).** A Claude Haiku 대화 모양 통행은 그것을 찢어 졌던 채권 에이전트까지 존재했습니다; 그것은 선택에서 DeBERTa ensemble과 더불어 죽은 코드 (zero 생산 외침)로 삭제되었습니다. 살아있는 것과 같이 문서를 재 문서하지 마십시오.

4. **L5캐나다 token (`browse/src/security.ts`).** Generate/inject/detect 임의 시스템 보호 token를 위한 유틸리티는, 공격자는 체계 신속한 계시를 위한 모형을 납득했습니다. 군중 누출 BLOCKs deterministically. 유틸리티는 순전하고 시험됩니다; canary를 주사하는 잡담은, 그래서 no 생산 경로는 오늘 주사했습니다.

5. **L6 앙상블 결합기 (`combineVerdict`).** BLOCK는 ML classifiers at >= `WARN` (0.75)에서, 단 하나 confident 명중이 아닙니다. 이것은 더미 Overflow 지시를 거짓 적당한 mitigation. 도구 산출 검사에, 단 하나 층 높은 신뢰 BLOCKs 직접 — 내용이 사용자 주의하지 않았던, 그래서 FP 관심사는 적용되지 않습니다.

**긴요한 constraint:** `security-classifier.ts`는 sidecar subprocess (`security-sidecar-entry.ts`)에서만, 컴파일된 찾아낸 바이너리에서 결코 뛰지 않습니다. `@huggingface/transformers` v4는 `dlopen`를 Bun 컴파일의 임시 직원 추출물 디렉토리에서 실패한 `onnxruntime-node`를 요구합니다. 순수한 끈 조각 (canary inject/check, verdict 결합자)는 `security.ts`에서, `server.ts`에서 수입하는 안전한 입니다 (`server.ts`). session-state/status 표면은 #2557에서 제거되었습니다.)

**Env 손잡이:** `GSTACK_SECURITY_OFF=1`는 실제 킬 스위치 (클래식이 끊어지더라도, L1-L3 필터가 실행되도록 유지). `~/.gstack/models/testsavant-small/` (112MB, first run)에서 모델 캐시. `~/.gstack/security/attempts.jsonl` (팔린 sha256 + 도메인, 10MB, 5 세대에서 회전)에서 공격 로그. `~/.gstack/security/device-salt` (0600)의 퍼 디바이트 소금, <7/>(writable environment)에 시렁이는 처리에서 <7/>(writable environment).

**의성.** 중앙 배너는 정확한 레이어 점수를 가진 운하 누출 또는 BLOCK verdict에 나타납니다. `bin/gstack-security-dashboard`는 로컬 시도를 집계합니다; `supabase/functions/community-pulse`는 사용자를 통해 opt-in 커뮤니티 원격 측정을 집계합니다. (측바 헤더의 SEC 방패 아이콘과 `/health` `security` 필드는 #2557에서 제거되었습니다. 그들의 유일한 데이터 소스 — `~/.gstack/security/session-state.json` — 잃어버린 그 에이전트이 보고될 때만, 그 에이전트이 비난한 상태에 보고된 경우에만 보고되었습니다. 자신의 전화 사이트를 통해 라이브 방어 보고서.)

## ref 체계

Refs (`@e1`, `@e2`, `@c1`)는 CSS selectors 또는 XPath를 쓰고 없는 에이전트 주소 페이지 성분이 어떻게 인지.

### 어떻게 작동합니까?

```
1. Agent runs: $B snapshot -i
2. Server calls Playwright's page.accessibility.snapshot()
3. Parser walks the ARIA tree, assigns sequential refs: @e1, @e2, @e3...
4. For each ref, builds a Playwright Locator: getByRole(role, { name }).nth(index)
5. Stores Map<string, RefEntry> on the BrowserManager instance (role + name + Locator)
6. Returns the annotated tree as plain text

Later:
7. Agent runs: $B click @e3
8. Server resolves @e3 → Locator → locator.click()
```

## 왜 거주자, DOM 역

명백한 접근은 `data-ref="@e1"` 속성을 DOM로 주사하는 것입니다. 이 휴식은 다음과 같습니다.

- **CSP (콘텐츠 보안 정책).** 많은 생산 사이트 블록 DOM 스크립트에서 수정.
- **React/Vue/Svelte 수화.** Framework 재구성은 주사된 속성을 스트립 할 수 있습니다.
- **그림자 DOM.**는 외부에서 그림자 뿌리 안쪽에 도달할 수 없습니다.

Playwright 로케이터는 DOM에 외부입니다. Chromium는 내부적으로 유지되는 접근성 나무를 사용합니다. `getByRole()` 쿼리. No DOM 뮤테이션, no CSP 문제, no 프레임 워크 충돌.

###는 생명주기를 보냅니다

Refs는 항법 (주요 구조에 `framenavigated` 사건)에 명확하게 합니다. 이것은 항법 후에 정확합니다, 모든 거주자는 stale입니다. 에이전트은 신선한 굴을 얻기 위하여 `snapshot`를 다시 실행해야 합니다. 이것은 디자인에 의하여 입니다: stale refs는 확고하게 실패해야 합니다, click는 틀린 성분.

### Ref staleness 탐지

SPA는 `framenavigated` (예 : React 라우터 전환, 탭 스위치, 모드 열림)를 트리거하지 않고 DOM를 mutate 할 수 있습니다. 이것은 refs stale을 페이지 URL가 변경되지 않았더라도 `resolveRef()`가 async `count()` 체크를 수행하려면 ref를 사용하기 전에 :

```
resolveRef(@e3) → entry = refMap.get("e3")
                → count = await entry.locator.count()
                → if count === 0: throw "Ref @e3 is stale — element no longer exists. Run 'snapshot' to get fresh refs."
                → if count > 0: return { locator }
```

Playwright의 30초 동작시간이 누락된 요소에 만료된 경우, `RefEntry` 저장 `role` 및 `name` 메타데이터를 저장하여 오류 메시지가 에이전트에게 알려줄 수 있도록 합니다.

## # 커서 인터랙티브 refs (@c)

`-C` 플래그는 ARIA 트리에 `cursor: pointer`, `onclick` 속성, 또는 `tabindex`로 요소가 스타일링되지 않는 요소를 찾습니다. 이 `@c1`, `@c2` refs는 별도의 네임스페이스에서 정의 구성 요소들을 찾습니다. 이 프레임워크가 `<div>`로 렌더링되었지만 실제로 버튼이 있습니다.

## 로깅 아키텍처

3개의 반지 완충기 (각 50,000의 입장, O(1) push):

```
Browser events → CircularBuffer (in-memory) → Async flush to .gstack/*.log
```

콘솔 메시지, 네트워크 요청 및 대화 상자 이벤트는 각각 버퍼가 있습니다. 플러싱은 각 1 초마다 발생합니다. 서버는 마지막 플러시 이후 새로운 항목을 추가합니다. 즉, 다음과 같습니다.

- HTTP 요청 처리는 디스크 I/O에 의해 차단되지 않습니다
- 서버 충돌을 생존 (데이터 손실의 최대 1 초)
- 메모리가 경계 (50K 항목 × 3 버퍼)
- Disk 파일은 외부 도구로만 읽을 수 있습니다.

`console`, `network`, `dialog` 명령은 in-memory 버퍼에서 읽을 수 있으며 디스크가 아닙니다. 디스크 파일은 포스트-mortem 디버깅에 사용됩니다.

## SKILL.md 템플릿 시스템

### 문제

SKILL.md 파일은 Claude 검색 명령을 사용하는 방법을 알려줍니다. docs가 존재하지 않는 플래그를 나열하거나 추가 된 명령을 놓으면 에이전트가 오류를 기록합니다. 코드에서 항상 드리프트를 docs.

### 솔루션

```
SKILL.md.tmpl          (human-written prose + placeholders)
       ↓
gen-skill-docs.ts      (reads source code metadata)
       ↓
SKILL.md               (committed, auto-generated sections)
```

템플릿에는 작업 흐름, 팁 및 인간적인 판단이 필요한 예가 포함되어 있습니다. Placeholders는 소스 코드에서 빌드 시간에 채워집니다.

| 회사연혁 | Source | 어떤 생성 |
|-------------|--------|-------------------|
| `{{COMMAND_REFERENCE}}` | `commands.ts` | 분류 명령 테이블 |
| `{{SNAPSHOT_FLAGS}}` | `snapshot.ts` | 예를 들어 플래그 참조 |
| `{{PREAMBLE}}` | `gen-skill-docs.ts` | 시작 블록: 업데이트 체크, 세션 추적, 기여자 모드, AskUserQuestion 형식 |
| `{{BROWSE_SETUP}}` | `gen-skill-docs.ts` | 바이너리 발견 + 설정 지침 |
| `{{BASE_BRANCH_DETECT}}` | `gen-skill-docs.ts` | 동적베이스 branch PR-targeting 기술 (선, 리뷰, qa, plan-ceo-review)에 대한 탐지 |
| `{{QA_METHODOLOGY}}` | `gen-skill-docs.ts` | QA 방법론 블록 /qa 및 /qa-only |
| `{{DESIGN_METHODOLOGY}}` | `gen-skill-docs.ts` | /plan-design-review 및 /design-review를 위한 공유 디자인 감사 방법론 |
| `{{REVIEW_DASHBOARD}}` | `gen-skill-docs.ts` | /ship 사전 flight에 대한 읽음 Dashboard 검토 |
| `{{TEST_BOOTSTRAP}}` | `gen-skill-docs.ts` | /qa, /ship, /design-review를 위한 프레임 워크 탐지, 부트 스트랩, CI/CD 체제를 시험하십시오 |
| `{{CODEX_PLAN_REVIEW}}` | `gen-skill-docs.ts` | 선택적 크로스모델 플랜 검토 (Codex 또는 Claude 미시간 미시간 미시간) /plan-ceo-review 및 /plan-eng-review |
| `{{DESIGN_SETUP}}` | `resolvers/design.ts` | `$D` 디자인 바이너리, 거울 `{{BROWSE_SETUP}}`를 위한 발견 본 |
| `{{DESIGN_SHOTGUN_LOOP}}` | `resolvers/design.ts` | /design-shotgun, /plan-design-review, /design-consultation를 위한 공유 비교 널 의견 반복 |
| `{{UX_PRINCIPLES}}` | `resolvers/design.ts` | 사용자 행동 기초 (, satisficing, goodwill reservoir, 트렁크 테스트) /design-html, /design-shotgun, /design-review, /plan-design-review |
| `{{GBRAIN_CONTEXT_LOAD}}` | `resolvers/gbrain.ts` | 키워드 추출, 건강 인식 및 데이터 검색 라우팅으로 두뇌 첫 번째 컨텍스트 검색. 10 개의 뇌 인식 기술로 주사. 비 뇌 호스트에 스프팅. |
| `{{GBRAIN_SAVE_RESULTS}}` | `resolvers/gbrain.ts` | Post-skill 두뇌는 엔리치먼트, 스로틀 처리 및 per-skill의 탁월한 성능을 발휘합니다. 8개의 기술 별 필터를 저장합니다. |
| `{{FOREGROUND_DISPATCH_NOTE}}` | `resolvers/constants.ts` | Canonical `run_in_background: false` 모든 동기 에이전트-tool 서브 에이전트 파견에 대한 안내 (subagents는 Claude Code v2.1.198 이후 배경에서 실행됩니다. 진실의 단일 소스; 캐리어는 `test/run-in-background-guidance.test.ts`에 의해 파일 당 핀입니다. |

이것은 구조적으로 소리 - 명령이 코드에 존재하면, 그것은 docs에 나타납니다. 존재하지 않는 경우, 그것은 나타날 수 없습니다.

### 전방

모든 기술은 기술 자체 논리 전에 실행되는 `{{PREAMBLE}}` 블록으로 시작합니다. v1.71.0.0 이후 렌더링 블록은 `bin/gstack-skill-start` (합체된 전방 실행 시간 - 그것은 tier-2+ 기술 당 인라인 배시의 ~18KB)를 호출하고 다시 `KEY: value` STATUS 줄을 읽습니다. `bin/gstack-skill-end`는 기술 끝에 원격 측정을 로그합니다. 한 번의 온보딩 및 동의 텍스트는 세션-바운드 `GSTACK_INSTRUCTION` 블록으로 방출되어 런타임 게이트가 실제로 화재가 발생하면 모든 기술에 렌더링됩니다. 시작은 여전히 다섯 가지를 처리합니다.

1. **업데이트 체크** - `gstack-update-check` 호출, 업그레이드가 가능한 경우 보고서.
2. **세션 추적** - `~/.gstack/sessions/<parent-pid>`와 2시간 이상 prunes 항목에 대해 접하게되므로 동시 유지 상태는 디스크에 관찰 가능합니다.
3. **운영 자체 - 개량** - 각 기술 세션의 끝에, 에이전트는 실패 (CLI 오류, 잘못된 접근, 프로젝트 quirks)에 반영하고 프로젝트의 JSONL 파일에 대한 운영 학습을 기록합니다.
4. **AskUserQuestion 형식** - 보편적인 체재: 맥락, 질문, `RECOMMENDATION: Choose X because ___`, 편지된 선택권. 모든 기술에 걸쳐 일관된.
5. **건물 전 찾기** — 인프라 구축 또는 무해한 패턴을 만들기 전에 먼저 검색합니다. 지식의 세 가지 층 : 시도 및 true (Layer 1), 새로운 - 및 -popular (Layer 2), 첫 번째 -principles (Layer 3). 처음 - 선실적인 주장은 기존 지혜가 잘못되었을 때, 에이전트는 "eureka 순간"을 이름하고 로그를합니다. 전체 빌더 철학을 위해 <1/ph>를 참조하십시오.

## 왜 헌신, runtime에서 생성되지?

3가지 이유:

1. **Claude는 기술 짐 시간에 SKILL.md를 읽습니다.** no는 `/browse`를 호출할 때 단계구조가 있습니다. 이 파일은 이미 존재하고 정확해야 합니다.
2. **CI는 신선도를 검증할 수 있습니다.** `gen:skill-docs --dry-run` + `git diff --exit-code`는 합병하기 전에 stale docs를 붙잡습니다.
3. **Git 비난 작품.** 명령이 추가되었을 때 볼 수 있습니다.

### 템플릿 테스트 계층

| Tier | 이란? | Cost | Speed |
|------|------|------|-------|
| 1 - 정적 유효성 | `$B` SKILL.md의 각 `$B` 명령을 파기하여 레지스트리에 대한 검증 | 의 % | <2s> |
| 2 - E2E 를 통해 `claude -p` | Spawn real Claude 세션, 각 기술을 실행, 오류 검사 | ~$3.85 | ~20분 |
| 3 - LLM-as-judge | Sonnet는 clarity/completeness/actionability에 대한 문서들을 수록한다. | ~$0.15 | ~30s의 |

Tier 1은 모든 `bun run test`에서 실행됩니다. Tier 2+3는 `EVALS=1` 뒤에 문질러집니다. 아이디어는: 자유로운을 위한 문제점의 95%를 붙잡고, 판단 전화를 위해 LLMs를 이용합니다.

## 명령 파견

명령은 부작용에 의해 분류됩니다:

- **READ** (텍스트, HTML, 링크, 콘솔, 쿠키, ...): No mutations. 안전 재량. 페이지 상태 반환.
- **WRITE** (goto, click, fill, 압박, ...): 페이지 상태. 불균형하지 않는.
- **META** (snapshot, 스크린 샷, 탭, 체인, ...) : 읽기에 neatly에 적합하지 않는 서버 수준의 작업/write.

이것은 단지 조직이 아닙니다. 서버는 파견을 위해 그것을 사용합니다:

```typescript
if (READ_COMMANDS.has(cmd))  → handleReadCommand(cmd, args, bm)
if (WRITE_COMMANDS.has(cmd)) → handleWriteCommand(cmd, args, bm)
if (META_COMMANDS.has(cmd))  → handleMetaCommand(cmd, args, bm, shutdown)
```

`help` 명령은 3 세트를 돌려주고 에이전트는 사용 가능한 명령을 자동 발견 할 수 있습니다.

## 오류 철학

오류는 AI 에이전트, 인간이 아닙니다. 모든 오류 메시지는 동작해야 합니다.

- "Element not found" → "Element not found or not interactiveable. 사용 가능한 요소를 보려면 `snapshot -i`를 실행하십시오."
- "선택자 일치 다중 요소" → "선택자 일치 다중 요소. 대신 `snapshot`에서 @refs를 사용하십시오."
- Timeout → "30 년대 후 중단 된 상황. 페이지는 느리거나 URL가 잘못 될 수 있습니다."

Playwright의 기본 오류는 `wrapError()`를 통해 내부 스택 추적을 스트립하고 지도를 추가합니다. 에이전트는 오류를 읽고 인간의 개입없이 다음 작업을 수행하는 것을 알 수 있어야 합니다.

## # 충돌 복구

서버는 자체 거래에 시도하지 않습니다. Chromium 충돌 (`browser.on('disconnected')`), 서버가 즉시 종료됩니다. CLI는 다음 명령과 자동 거래에서 죽은 서버를 감지합니다. 이것은 반 데드 브라우저 프로세스에 다시 연결하려고하는 것보다 간단하고 신뢰할 수 있습니다.

## E2E 테스트 인프라

## 세션 러너 (`test/helpers/session-runner.ts`)

E2E 테스트 spawn `claude -p` 완전 독립적 인 하위 처리로 - 에이전트를 통해하지 SDK, 내부에 배열 할 수 없습니다 Claude Code 세션. 주자:

1. 임시 파일로 프롬프트를 작성 (아보이즈 쉘 스 캐핑 문제)
2. Spawns `sh -c 'cat prompt | claude -p --output-format stream-json --verbose'`
3. NDJSON 에서 stdout 실시간 진행
4. 설정 가능한 timeout에 대한 레이스
5. 전체 NDJSON 의 를 구조화한 결과로 변환

`parseNDJSON()` 함수는 순수합니다 — no I/O, no 부작용 — 그것을 자주적으로 시험할 수 있는 만들기.

### Observability 데이터 흐름

```
  skill-e2e-*.test.ts
        │
        │ generates runId, passes testName + runId to each call
        │
  ┌─────┼──────────────────────────────┐
  │     │                              │
  │  runSkillTest()              evalCollector
  │  (session-runner.ts)         (eval-store.ts)
  │     │                              │
  │  per tool call:              per addTest():
  │  ┌──┼──────────┐              savePartial()
  │  │  │          │                   │
  │  ▼  ▼          ▼                   ▼
  │ [HB] [PL]    [NJ]          _partial-e2e.json
  │  │    │        │             (atomic overwrite)
  │  │    │        │
  │  ▼    ▼        ▼
  │ e2e-  prog-  {name}
  │ live  ress   .ndjson
  │ .json .log
  │
  │  on failure:
  │  {name}-failure.json
  │
  │  ALL files in ~/.gstack-dev/
  │  Run dir: e2e-runs/{runId}/
  │
  │         eval-watch.ts
  │              │
  │        ┌─────┴─────┐
  │     read HB     read partial
  │        └─────┬─────┘
  │              ▼
  │        render dashboard
  │        (stale >10min? warn)
```

**분할 소유권:** 세션-런너는 심박수 (현재 테스트 상태)를 소유하고, eval-store는 부분 결과를 소유합니다 (완전한 테스트 상태). 워커는 모두 읽습니다. Neither 구성 요소는 다른 것에 대해 알고 있습니다. 파일 시스템을 통해서만 데이터를 공유합니다.

**모든 것:** 모든 관찰성 I/O는 try/catch에서 감싸입니다. 쓰기 실패는 실패하는 시험이 결코 일어나지 않습니다. 시험은 진실의 근원입니다; 관찰성은 제일 불편입니다.

**기계 읽기 쉬운 진단:** 각 시험 결과는 `exit_reason` (수직, 타임아웃, 오류_최대._turns, error_api, 출구_code_N), `timeout_at_turn`, and `마지막_tool_call`. This enables `jq` 같이 쿼리를 포함합니다:
```bash
jq '.tests[] | select(.exit_reason == "timeout") | .last_tool_call' ~/.gstack/projects/<slug>/evals/_partial-e2e.json
```

### Eval persistence (`test/helpers/eval-store.ts`)

`EvalCollector`는 시험 결과를 축적하고 두 가지 방법으로 쓰입니다.

1. **공급 능력:** `savePartial()`는 각 시험 (원료: `.tmp`, `fs.renameSync`) 후에 `_partial-e2e.json`를 쓰. 생존자는 죽습니다.
2. **최종:** `finalize()`는 타임스탬프된 eval 파일 (예를들면 `e2e-20260314-143022.json`)를 쓰입니다. 부분적인 파일은 결코 청소되지 않습니다 — 관찰성을 위한 마지막 파일과 함께 persists.

`eval:compare` diffs 두 eval 실행. `eval:summary` 모든 실행에 걸쳐 통계를 집계 `~/.gstack/projects/<slug>/evals/` (사명 추락 `~/.gstack-dev/evals/`). 둘 다 shard-aware (v1.63.0.0): the sharded paid runner (`scripts/test-paid-shards.ts`, run via `test:gate:sharded` / `test:periodic:sharded` — the `eval:bg:gate` / `eval:bg:periodic` scripts now point at these) gives each shard's collector its own directory at `<evalDir>/shards/<slug>/` through the `GSTACK_EVAL_DIR` env var (honored by the `EvalCollector` constructor), and `eval:list` / `eval:compare` / `eval:summary` scan one level of `shards/<slug>/` subdirectories (`eval:flake-rank` reads the same tree recursively, plus the free-suite flake ledger). 기본보기는 `_partial` 축적자 (`isPartialEval`/`findLatestFinalizedRun` in `eval-store.ts`)를 제외하고, 그래서 자동 비교는 그것의 기본으로 현재 뛰는 자신의 부분 파일을 결코 사용하지 않습니다.

### 시험 층

| Tier | 이란? | Cost | Speed |
|------|------|------|-------|
| 1 - 정적 유효성 | Parse `$B` 명령, 레지스트리, 관측성 단위 테스트에 대한 검증 | 의 % | <5s>의 |
| 2 - E2E 를 통해 `claude -p` | Spawn real Claude 세션, 각 기술을 실행, 오류 검사 | ~$3.85 | ~20분 |
| 3 - LLM-as-judge | Sonnet는 clarity/completeness/actionability에 대한 문서들을 수록한다. | ~$0.15 | ~30s의 |

Tier 1은 모든 `bun run test`에서 실행됩니다. Tier 2+3는 `EVALS=1` 뒤에 문질러집니다. 아이디어: 자유로운을 위한 문제점의 95%를 붙잡고, 판단 통화와 통합 테스트를 위해 LLMs를 이용합니다.

## 의도적으로 여기에 있지 않은 것

- **No WebSocket 스트리밍.** HTTP request/response는 컬과 디버깅이 간단하며 충분히 빠르게 사용할 수 있습니다. 스트리밍은 마진 혜택에 대한 복잡성을 추가할 것입니다.
- **No MCP 의정서.** MCP는 요청당 JSON schema overhead를 추가하고 지속적인 연결을 요구합니다. 보통 HTTP + 일반 텍스트 출력은 토큰에 점화기이고 디버그에 더 쉽습니다.
- **No 다중 사용자 지원.** 작업 공간 당 1개의 서버, 1명의 사용자. token auth는 방어에서 심도, 다 강렬하지 않습니다.
- **No Windows/Linux cookie 해독.** macOS 키체인은 지원되는 자격 증명 상점입니다. Linux (GNOME Keyring/kwallet)와 Windows (DPAPI)는 건축적으로 가능하지만 구현되지 않습니다.
- **No iframe 자동 발견.** `$B frame`는 cross-frame 상호 작용을 지원합니다 (CSS selector, @ref, `--name`, `--url` matching), 그러나 ref 체계는 `snapshot` 도중 자동 크롤러를 갖지 않습니다. 당신은 첫째로 구조 상황에 따라서 입력해야 합니다.
