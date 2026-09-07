# Remote Browser Access - GStack 브라우저를 가진 쌍을 하는 방법

GStack 브라우저 서버는 HTTP 요청을 만들 수있는 AI 에이전트와 공유 할 수 있습니다. 에이전트는 scoped 실제 Chromium 브라우저에 액세스합니다. 페이지를 탐색하고 내용을 읽으십시오. click 요소, fill 형태, 스크린 샷을 가져 가라. 각 에이전트는 자체 탭을 가져옵니다.

이 문서는 원격 에이전트에 대한 참조입니다. 빠른 시작 지침은 `$B pair-agent`에 의해 생성되어 실제적인 자격 증명을 구운.

## 건축

```
Your Machine                          Remote Agent
─────────────                         ────────────
GStack Browser Server                 Any AI agent
  ├── Chromium (Playwright)           (OpenClaw, Hermes, Codex, etc.)
  ├── Local listener  127.0.0.1:LOCAL         │
  │    (bootstrap, CLI, sidebar, cookies)      │
  ├── Tunnel listener 127.0.0.1:TUNNEL ◄───────┤
  │    (pair-agent only: /connect and          │
  │     /command — locked allowlist)           │
  ├── ngrok tunnel (forwards tunnel port only) │
  │     https://xxx.ngrok.dev ─────────────────┘
  └── Token Registry
        ├── Root token (local listener only)
        ├── Setup keys (5 min, one-time)
        ├── Session tokens (24h, scoped)
        └── SSE session cookies (30 min, stream-scope)
```

## 듀얼-리스트 에너지 아키텍처 (v1.6.0.0)

daemon는 두 개의 HTTP 소켓을 묶습니다. **지역 청취자**는 127.0.0.1에 완전 명령 표면을 제공하고 결코 전달되지 않습니다. **터널링**는 고정된 경로 수당으로 `/tunnel/stop`에 아래로 `/tunnel/stop`에 묶는 ngrok는 터널 항구만 전달합니다.

ngrok URL에 흠뻑 빠지는 콜러는 `/health`, `/cookie-picker`, `/inspector/*`, 또는 `/welcome`에 도달할 수 없습니다 — 그 경로는 그 TCP 소켓에 존재하지 않습니다. 터널에 보내지는 뿌리 토큰은 403를 얻습니다. 터널 청취자는 `/connect` 및 `/command` (scoped token + 26-commandiving browser allowlist)에서만 허용됩니다.

전체 엔드포인트 테이블에 [ARCHITECTURE.md](../ARCHITECTURE.md#dual-listener-tunnel-architecture-v1600)를 참조하십시오.

## 연결 교류

1. **사용자 실행** `$B pair-agent` (또는 Claude Code에서 `/pair-agent`)
2. **Server 생성** 1회 설정 키 (5 분에 만료)
3. **사용자 사본** 다른 에이전트의 채팅으로 명령 블록
4. **원격 에이전트 실행** `POST /connect` 설정 키와 함께
5. **Server 반환** scoped 세션 token (24h default)
6. **원격 에이전트 생성** `newtab`로 `POST /command`를 통해 자체 탭
7. **원격 에이전트 검색** `POST /command`를 사용하여 세션 token + tabId

## API 참조

### 인증

모든 명령 엔드포인트는 Bearer token를 요구합니다:

```
Authorization: Bearer gsk_sess_...
```

`/connect`는 unauthenticated (rate-limited)입니다 - 그것은 원격 에이전트가 scoped 세션 토큰을 위한 설정 키를 교환하는 방법 이다. `/health`는 로컬 리리스 (liveness/status만에 unauthenticated - 절대 token) 그러나 터널 리리스 (404)에 존재한다. 확장 token 부츠 스트랩은 `POST /extension-token` 로컬 리리스에, 그것은 `chrome-extension://`는 문에 의해, 그것은 표면이 아닌, 그것은 문에 의해 문에 의해 문이 지어진, 그것은 문에 의해 문이 지어진, 그것입니다.

SSE 엔드포인트 (`/activity/stream`, `/inspector/events`)는 Bearer token 또는 HttpOnly `gstack_sse` cookie (`POST /sse-session`, 30 분 TTL, 스트림-스코프만 허용되지 않습니다. v1.6.0.0의 `?token=<ROOT>` 질의 auth는 no 더 긴 허용됩니다.

### 엔드포인트

#### POST /connect 세션 토큰의 설정 키 교환. No auth 필수. 300/minute (flood Defense — 설정 키는 24 임의 바이트, unbruteforceable)에 제한되는 비율.

```json
Request:  {"setup_key": "gsk_setup_..."}
Response: {"token": "gsk_sess_...", "expires": "ISO8601", "scopes": ["read","write","admin","meta"], "agent": "agent-name"}
```

#### POST /command 브라우저 명령을 보냅니다. Bearer auth를 요구합니다.

```json
Request:  {"command": "goto", "args": ["https://example.com"], "tabId": 1}
Response: (plain text result of the command)
```

#### GET /health 서버 상태. No auth 요구. 반환 상태, 탭, 형태, 가동 시간. 절대로 token - 연장 token 부트 스트랩은 `POST /extension-token` (현지 청취자만, 핀으로 꼿는 `chrome-extension://` 근원 및 루프백 Host; 403 그렇지 않으면). 터널 (404)에 도달하지 않기.

## 명령

#### 항법
| Command | Args | 의 특징 |
|---------|------|-------------|
| `goto` | `["URL"]` | URL로 이동 |
| `back` | `[]` | 으로 |
| `forward` | `[]` | Go forward |
| `reload` | `[]` | Reload 페이지 |

#### 읽기 내용
| Command | Args | 의 특징 |
|---------|------|-------------|
| `snapshot` | `["-i"]` | @ref 라벨과 snapshot (최대 유용) |
| `text` | `[]` | 본문내용 바로가기 |
| `html` | `["selector?"]` | HTML 요소 또는 전체 페이지 |
| `links` | `[]` | 모든 링크 페이지 |
| `screenshot` | `["/tmp/s.png"]` | 스크린 샷을 찍다 |
| `url` | `[]` | Current URL |

#### 상호 작용
| Command | Args | 의 특징 |
|---------|------|-------------|
| `click` | `["@e3"]` | Click an element (use @ref from snapshot) |
| `fill` | `["@e5", "text"]` | 양식 필드를 작성 |
| `select` | `["@e7", "option"]` | 드롭다운 값 선택 |
| `type` | `["text"]` | 유형 텍스트 (keyboard) |
| `press` | `["Enter"]` | 키 입력 |
| `scroll` | `["down"]` | 의논하기 |

### 탭
| Command | Args | 의 특징 |
|---------|------|-------------|
| `newtab` | `["URL?"]` | 새 탭 만들기 (글쓰기 전에 필요) |
| `tabs` | `[]` | 모든 탭 목록 |
| `closetab` | `["id?"]` | 탭 닫기 |

## 스냅샷 → @ref 패턴

이것은 가장 강력한 브라우징 패턴입니다. 대신 CSS selectors를 작성합니다.

1. `snapshot -i`를 실행하여 라벨을 붙인 요소로 snapshot를 대화형 snapshot를 얻을 수 있습니다.
2. snapshot는 다음과 같은 텍스트를 반환합니다.
   ```
   [Page Title]
   @e1 [link] "Home"
   @e2 [button] "Sign In"
   @e3 [input] "Search..."
   ```
3. `@e` refs 명령어에서 `click @e2`, `fill @e3 "search query"`를 직접 사용하십시오

snapshot 시스템 작동이 얼마나 되며, CSS selectors보다 훨씬 안정적입니다. 항상 `snapshot -i`를 먼저 사용하고, ref를 사용합니다.

## 범위

| 범위 | 무엇을 할 수 있습니까? |
|-------|---------------|
| `read` | snapshot, 텍스트, HTML, 링크, 스크린 샷, URL, 탭, 콘솔 등 |
| `write` | goto, click, fill, 스크롤, newtab, 옷장, 등. |
| `admin` | eval, js, 쿠키, 저장, 쿠키-import, useragent 등 |
| `meta` | 탭, diff, 프레임, 반응, 시계 |
| `control` | 중지, 재시작, 단, 상태, 손전등 — 브라우저 전체 파괴 ops |

Paired agents get `read+write+admin+meta` by default; the pairing ceremony is the trust boundary. `--restrict` narrows the list (it can never grant `control`). `--control` adds the control scope (`--admin` is a legacy alias). Over the tunnel, the `js`/`cookies`/`storage` commands are blocked by the command allowlist regardless of scope; `eval` works. Pair with `--restrict "read,write"` when the agent will read untrusted web content — scope caps the prompt-injection blast radius.

To tighten an already-paired agent, re-pair it with the **`--client` 이름** and the narrower `--restrict`/`--domain`: a reducing re-pair revokes the previous session and releases its tabs immediately (the agent must reconnect with the new key), so the old wide access never lingers. Broadening or refreshing keeps the working session with no outage. Re-pairing without `--client` mints a new agent instead. `root` is a reserved client name.

## 탭 고립

각 에이전트는 탭을 만듭니다. 규칙:
- **읽기 :** 모든 에이전트는 어떤 탭을 읽을 수 있습니다 (snapshot, 텍스트, 스크린 샷)
- **태그 :** 탭 소유자만 쓸 수 있습니다 (click, fill, goto, 등)
- **가장 인기있는 탭:** 사전 노출 탭은 root-only 쓰기
- **첫 번째 단계 :** 항상 `newtab` 상호 작용하기 전에

## 오류 코드

| 의 특징 | 의약 | 의 장점 |
|------|---------|------------|
| 401 | 토큰은 유효하지 않고 만료되거나 수정됨 | /pair-agent를 다시 실행하는 사용자를 요청하십시오 |
| 403 | 범위 내에서 명령, 탭이 아니라, 터널 allowlist에 있지 않음 | newtab을 사용하십시오; 사용자는 - 제한 없이 재선 할 수 있습니다 또는 - 통제 |
| 429 | 비율 제한 초과 (>10 req/s) | 헤더 후 Retry-After 대기 |

## 보안 모델

- **물리적 포트 분리.** 로컬 리리스 및 터널 리리스는 TCP 소켓을 분리하고 있습니다. ngrok는 터널 포트 만 전달합니다. 터널 콜러는 모든 (404, 잘못된 포트)의 부트 스트랩 엔드 포인트에 도달 할 수 없습니다.
- **터널 명령의 수당.** `/command` 터널에 단지 26개의 브라우저 건조 명령 (goto, click, fill, snapshot, text, newtab, 탭, 뒤, 앞으로, 재부하, 옷장, 등)를 받아들입니다. 서버 관리 명령 (tunnel, 쌍, token, useragent, js)는 터널에 denied.
- **뿌리 token는 터널 막힌 입니다.** 터널 리스너가 403을 쌍으로 돌려보내서 루트 token를 베어링하는 요청. scoped 세션 토큰은 터널에서 작동한다.
- **설정 키** 5 분에서 만료되고 한 번만 사용할 수 있습니다.
- **세션 토큰** 24시간 만료(configurable).
- root token는 명령어 블록이나 연결 문자열에 나타나지 않습니다.
- **제어 범위** (stop/restart/disconnect)는 default에 의해 연기되고 범위를 통해 결코 라이드가 없습니다. Admin는 페어링에 부여됩니다; `js`/`cookies`/`storage`는 명령 수당에 의해 터널을 차단했습니다. `--restrict`를 사용하여 덜 위탁 에이전트을 위해 사용하십시오.
- 토큰은 즉시 수정될 수 있습니다: `$B tunnel revoke agent-name` 세션을 삭제하고, 실제 에이전트 목록에 대한 정의. `$B tunnel agents`는 쌍을 이루는 (설정 키 포함)를 보여줍니다. `$B stop`는 모든 것을 명확하게합니다. 토큰은 daemon을 살아남지 않습니다.
- **SSE auth**는 30분 HttpOnly SameSite=Strict cookie, 스트림스코프만 사용(`/command`에 대한 유효성).
- **경로 traversal 보호** 에 `/welcome` — `GSTACK_SLUG` 은 `^[a-z0-9_-]+$` 와 일치해야 하고, 내장 템플릿으로 돌아갑니다.
- **SSRF 가드** 에 `goto`, `download`, 그리고 스크랩 경로 - localhost/private-range blocklist에 대한 URL 대상을 검증합니다.
- **터널 표면 denial 로깅.** 터널 리퍼에 대한 모든 거부 (`path_not_on_tunnel`, `root_token_on_tunnel`, `missing_scoped_token`, `disallowed_command:*`)는 `~/.gstack/security/attempts.jsonl`에 배회되어 배회, 소스 IP, 경로, 방법. 60의 쓰기/min에 넣을 비율.
- **터널 시작 (v1.63+)에 Egress 영수증.** 각 터널 회의는 `~/.gstack/security/egress.jsonl` BEFORE ngrok에 해 사슬을 씌운 영수증 (sink `browse-tunnel`)를 아무 것도 전달합니다. 실패 닫히는: 영수증이 기록될 수 없는 경우에, 터널는 시작을 거부합니다. `bin/gstack-egress list`/ `bin/gstack-egress verify`를 가진 감사.
- 모든 에이전트 활동은 attribution (clientId)로 로그인됩니다.

**비고 알 (#1136로 추적):** on Windows, 쿠키-import-browser path launches Chrome with `--remote-debugging-port=<random>`. App-Bound Encryption v20을 사용하면 동일한 로컬 프로세스가 포트와 exfiltrate decrypted v20 쿠키에 연결할 수 있습니다. SQLite DB를 직접 읽는 것과 관련된 고도 경로. TCP 대신 `--remote-debugging-pipe`를 수정하십시오.

## 동일한 기계 바로가기

두 에이전트이 동일한 기계에 있는 경우에, 사본을 건너뛰기:

```bash
$B pair-agent --local openclaw    # writes to ~/.openclaw/skills/gstack/browse-remote.json
$B pair-agent --local codex       # writes to ~/.codex/skills/gstack/browse-remote.json
$B pair-agent --local cursor      # writes to ~/.cursor/skills/gstack/browse-remote.json
```

No 터널이 필요합니다. localhost를 직접 사용합니다.

## ngrok 터널 설치

다른 기계에 원격 에이전트에 대 한:

1. [카지노사이트](https://ngrok.com) (무료 계층 작품)에 가입
2. 대시보드에서 auth token를 복사
3. 저장: `echo 'NGROK_AUTHTOKEN=your_token' > ~/.gstack/ngrok.env`
4. 선택적으로 안정적인 도메인 주장: `echo 'NGROK_DOMAIN=your-name.ngrok-free.dev' >> ~/.gstack/ngrok.env`
5. 터널로 시작: `BROWSE_TUNNEL=1 $B restart`
6. `$B pair-agent`를 실행하십시오 - 그것은 터널 URL를 자동적으로 이용할 것입니다
