# Browser — 전체 참조

gstack의 브라우저 표면은 한 문서에 있습니다. Headless Chromium daemon, ~70+ 명령, ref-based element 선택, codifiable browser-skills, Chrome 측 패널과 실제 브라우저 모드, in-sidebar Claude PTY, ngrok 쌍 에이전트 흐름, 그리고 계층화된 프롬프트 주입 방어 — 모두 컴파일된 CLI 텍스트에 의해 텍스트를 출력하는 CLI.

마지막 릴리스 또는 두 가지의 gstack를 사용한다면 생산성 루프는 새로운 헤드 라인입니다. `/scrape <intent>`는 한 번 페이지를 구동, `/skillify`는 세례적인 Playwright 스크립트로 흐름을 조정하고, 다음 `/scrape`는 에이전트 재검출의 ~30 초 대신 ~200ms에서 동일한 의도적 실행됩니다.

---

## 빠른 시작

```bash
# One-time: build the binary (browse/dist/browse, ~58MB)
bun install && bun run build

# Set $B once and forget about it
B=./browse/dist/browse           # or ~/.claude/skills/gstack/browse/dist/browse

# Drive a page
$B goto https://news.ycombinator.com
$B snapshot -i                   # @e refs you can click/fill/inspect later
$B click @e30                    # click ref 30 from the snapshot
$B text                          # get clean page text
$B screenshot /tmp/hn.png

# Codify a repeated flow
/scrape latest hacker news stories
/skillify                        # writes ~/.gstack/browser-skills/hn-front/...
/scrape hacker news front page   # second call: 200ms via the codified skill

# Watch Claude work in real time
$B connect                       # headed Chromium + Side Panel extension
```

---

## 내용 표

1. [개요](#what-it-is)
2. [생산성 루프 - `/scrape` + `/skillify`](#the-productivity-loop)
3. [아키텍처](#architecture)
4. [Command reference](#command-reference)
5. [Snapshot 시스템 + 정유 기반 선택](#snapshot-system)
6. [Browser-skills 실행 시간](#browser-skills-runtime)
7. [도메인-skills (당사 에이전트 노트)](#domain-skills)
8. [Real-browser 모드 (`$B connect`)](#real-browser-mode) - [`--headed` + `--proxy` + `--navigate` (v1.28.0.0)](#headed-mode--proxy--browser-native-downloads-v12800) 및 [측과 제3자 드라이브 (v1.72.0.0+)](#aside-and-third-party-drives-v17200)를 포함하여
9. [측 패널 + sidebar 에이전트](#side-panel--sidebar-agent)
10. [페어 에이전트 - ngrok 터널을 통한 원격 에이전트](#pair-agent)
11. [인증 + 토큰](#authentication)
12. [신속한 주입 보안 스택 (L1–L6)](#security-stack)
13. [스크린 샷, PDF, 시각 검사](#screenshots-pdfs-visual)
14. [Local HTML — `goto file://` 대 `load-html`](#local-html)
15. [배치 엔드포인트](#batch-endpoint)
16. [콘솔, 네트워크, 대화 상자 캡처](#capture)
17. [JS 실행 - `js` + `eval`](#js-execution)
18. [탭, 프레임, 상태, 시계, inbox](#tabs-frames-state)
19. [CDP 탈출 해치 + CSS 검사기](#cdp)
20. [성능 + 스케일](#performance)
21. [멀티 워크스페이스 고립](#multi-workspace)
22. [환경 변수](#environment-variables)
23. [소스 맵](#source-map)
24. [개발 + 테스트](#development)
25. [크로스 환경](#cross-references)
26. [Acknowledgments의 특징](#acknowledgments)

---

## 그것은 무엇입니까

CLI 의 컴파일된 CLI 의 HTTP 의 persistent 로컬 Chromium 의 daemon 에 대해 이야기하는 바이너리. CLI 는 얇은 클라이언트입니다. 그것은 국가 파일을 읽고, 명령을 보내며, 의 응답을 출력합니다. daemon 는 [Playwright](https://playwright.dev/) 를 통해 실제 작업을 합니다.

Chrome MCP 서버가 정상적인 stdout을 통해 지금 일어나고 있는 모든 것. No JSON-schema framing, no 프로토콜 협상, no 지속 WebSocket — Claude's Bash 도구는 이미 존재합니다, 그래서 우리는 그것을 사용합니다.

3개의 에스컬레이션 형태:

- **Headless** (default). daemon은 Chromium 와 no 가시창을 실행한다. 가장 빠른,
  가장 싼, `/qa`, `/design-review`, `/benchmark`와 같은 어떤 기술은 과태에 의해 이용합니다.
- **Headed `$B connect`를 통해**. daemon와 같지만 Chromium는 가시 (rebranded)
  Side Panel extension을 자동 로드한 상태에서 "GStack Browser")로 이동합니다. 실시간 모든 명령을 틱으로 볼 수 있습니다.
- **터널에 대한 쌍 에이전트**. daemon은 ngrok를 두 번째 청취자에 묶습니다.
  앞으로. 원격 에이전트 (Codex, OpenClaw, Hermes, HTTP)는 scoped, 단일 사용 토큰과 함께 26-command allowlist를 통해 로컬 브라우저를 구동할 수 있는 모든 것.

---

## 생산성 루프

v1.19.0.0의 배송 헤드 라인. 두 gstack 기술이 브라우저 스킬 런타임을 감싸고, 두 번째로 Claude를 스크랩으로 요청하면 ~200ms로 실행됩니다.

### `/scrape <intent>`

페이지 데이터를 끌어 당기는 데 한 항목 포인트. 후드 아래에 세 가지 경로:

1. **경기 경로 (~200ms)** - 에이전트가 `$B skill list`, semantically 일치합니다
   각 기술 `triggers:` 배열 + `description` + `host`에 대한 의도는 confident match가 존재하는 경우 `$B skill run <name>`를 실행합니다.
2. **프로토 타입 경로 (~30s)** — no 경기, 에이전트는 `$B goto`로 페이지를 구동,
   `$B text`, `$B html`, `$B links`, 등, JSON를 반환하고, 1 선 "say `/skillify`" 제안을 부과합니다.
3. **Mutating-intent 정제** - *submit*, *click*, *fill* 노선과 같은 동사
   `/automate` (단계 2b, P0 in `TODOS.md`). `/scrape`는 계약에 의해 read-only입니다.

### `/skillify`

가장 최근 성공 `/scrape` 프로토 타입을 디스크에 영구 브라우저 스킬로 지정합니다. Eleven 단계, 3 개의 고정된 계약:

- **D1 - 입증 감시.**는 뒤로 걷습니다 ≤10 에이전트은 명확하게 반동했습니다
  `/scrape` 결과. 콜드가면 한 특정 메시지로 사용됩니다. No 채팅 파편의 침묵 합성.
- **D2 - 합성 입력 슬라이스.**는 ONLY를 최종적으로 호출합니다 `$B`를 추출합니다
  JSON를 생성한 사용자는 허용된 문자열과 사용자의 의도치 않은 문자열을 사용합니다. 드롭은 선택자를 실패하고 대화를 떨어뜨리고, 이전 세션 내용을 삭제합니다.
- **D3 — 원자 쓰기.** `~/.gstack/.tmp/skillify-<spawnId>/`에 모든 단계를,
  `$B skill test` 를 임시 직원 디디에 대하여 실행하고, 시험 통행 + 사용자 승인에 마지막 층 경로로 이름을 바꾸십시오. 시험 실패 또는 거절: `rm -rf` 는 전적으로 임시 직원 디디. No 반 강렬 기술은 `$B skill list`에서 나타날.

`/automate`를 섞는 교류는 `TODOS.md`에서 P0로 나누고 다음 branch에 배로 나뉩니다 — 동일한 기술화 기계장치, 비 응어리를 달릴 때 mutating 단계 확인 문.

전체 디자인 + 결정 트레일에 대한 [`docs/designs/BROWSER_SKILLS_V1.md`](docs/designs/BROWSER_SKILLS_V1.md)를 참조하십시오.

---

## 건축

```
┌─────────────────────────────────────────────────────────────────┐
│  Claude Code                                                    │
│                                                                 │
│  $B goto https://staging.myapp.com                              │
│       │                                                         │
│       ▼                                                         │
│  ┌──────────┐    HTTP POST     ┌──────────────┐                 │
│  │ browse   │ ──────────────── │ Bun HTTP     │                 │
│  │ CLI      │  127.0.0.1:rand  │ daemon       │                 │
│  │          │  Bearer token    │              │                 │
│  │ compiled │ ◄──────────────  │  Playwright  │──── Chromium    │
│  │ binary   │  plain text      │  API calls   │    (headless    │
│  └──────────┘                  └──────────────┘     or headed)  │
│   ~1ms startup                  persistent daemon               │
│                                 auto-starts on first call       │
│                                 auto-stops after 30 min idle    │
└─────────────────────────────────────────────────────────────────┘
```

## # daemon 라이프 사이클

1. **첫 번째 호출.** CLI `<project>/.gstack/browse.json`를 실행할 수 있습니다.
   서버. None 발견 — 배경에서 `bun run browse/src/server.ts`를 스파게 해줄 수 있습니다. headless Chromium를 통해 Playwright를 발사하고, 무작위 포트 (10000–49151의 밑에 deliberately를 macOS ephemeral pool 49152-65535를 통해서 OS를, 충돌하는 항구를 다른 과정에 결코 쫓아버리지 마십시오), 생성합니다 token, 쓰기 국가 파일 (600/>)를, 쓰기 시작하십시오. macOS XProtect 정의 업데이트가 SIGKILLs가 Chromium를 spawn에서 핀으로 꼿을 때, daemon는 죽이는 서명을 분류하고, Playwright 캐시에 quarantine 깃발을, 재설치합니다 gstack에서 핀으로 묶인 개정을 설치합니다 (배로 묶인 ~120s), 그리고 retries를 한 번 — daemon 과정 당 한 번에. 치유가 완료될 수 없는 경우에, 본래 오류 daemon는 daemon를 발사합니다. daemon는 daemon를 발사합니다. `browser-manager.ts`에서 `browse/src/xprotect-heal.ts`를 통해 3개의 발사 위치에 타전했습니다.
2. **자주 묻는 질문** CLI는 국가 파일을 읽습니다, HTTP POST를 가진 보내십시오
   Bearer token는, 응답을 인쇄합니다. ~100-200ms 둥근 여행.
3. **Idle 종료.** 30분 후 no 명령, daemon 종료 및
   state 파일을 정리합니다. 다음 호출은 다시 시작합니다.
4. **충돌 복구.** Chromium 충돌이 발생하면 daemon가 즉시 종료됩니다.
   no 자기 치유, 실패를 숨지지 마십시오. CLI는 다음 호출에서 죽은 daemon를 감지하고 신선한 것을 시작합니다.
5. **Busy 대 죽은.** A daemon는 HTTP를 멈추는 것이 과정이 있는 동안
   CLI는 `/health`를 복구하기 위해 경계된 ~8s를 부여하고, 비제로 출구로 바빴습니다. 살아 숨어 지는 pid를 죽지 못합니다. `--force-restart`는 비스트로프를 잃지 못합니다. `browse stop`는 이미 성공한 daemon에 대해 `browse stop`를 잃고, 그 대신 headless를 재시작하고, headless를 다시 한번 기록한 경우, headless를 다시 한번 멈춰서, headless를 다시 한번 멈춰서, headless를 기록한 후, headless를 다시 한번 멈춘다. 재ap는 모든 신호를 보내기 전에 기록 된 시작 시간 AND 크롬보기 cmdline을 verifies, 그래서 재생 PID는 결코 죽지 않습니다.

## 멀티 워크스페이스 고립

각 프로젝트 루트 (`git rev-parse --show-toplevel`를 통해 검출)는 daemon, 포트, 주 파일, 쿠키, 로그를 가져옵니다. No 크로스 워크스페이스 충돌. `<project>/.gstack/browse.json`의 상태.

| 작업 공간 | 국가 파일 | 의 특징 |
|-----------|-----------|------|
| `/code/project-a` | `/code/project-a/.gstack/browse.json` | 임의의 (10000–49151) |
| `/code/project-b` | `/code/project-b/.gstack/browse.json` | 임의의 (10000–49151) |

---

## 명령 참조

~70의 명령은 읽기, 쓰기, 그리고 메타를 가로 질러 입력합니다. 선택자는 CSS, `@e` refs, `@c` refs `snapshot -C`에서 `snapshot -C`를 받아들입니다. 전체 테이블:

### 읽기

| Command | 의 특징 |
|---------|-------------|
| `text [sel]` | 클린 페이지 텍스트 (또는 scoped를 선택자) |
| `html [sel]` | innerHTML, 또는 전체 페이지 HTML if no selector |
| `links` | `text → href`로 모든 링크 |
| `forms` | JSON로 형태 분야 |
| `accessibility` | 전체 ARIA 나무 |
| `media [--images\''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''|--비디오|--audio] [젤]` | URL, 치수, 유형의 미디어 요소 |
| `data [--jsonld\'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''|--오그|--meta\의 경우|--twitter]` | 구조화된 자료: JSON-LD, OG, Twitter 카드, 메타 태그 |

### 검사

| Command | 의 특징 |
|---------|-------------|
| `js <expr> [--out <file>] [--raw]` | inline JavaScript 식을 페이지 컨텍스트에서 실행하면 문자열로 반환합니다. `--out <file>` 으로 결과가 반환된 디스크에 쓰여져 있습니다. (a `data:*;base64,...` 은 `--raw` ) . `--out` 는 WRITE (needs `write` 스코프를 넘겨, 터널을 넘겨주지 않는). |
| `eval <file> [--out <file>] [--raw]` | JS 파일을 실행 (/tmp 또는 cwd의 밑에 동행); `js`와 동일한 샌드 박스. `--out`/`--raw`는 `js`를 위해 행동합니다. |
| `css <sel> <prop>` | Computed CSS 가치 |
| `attrs <sel\''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''|@ref>` | JSON로 요소 속성 |
| `is <prop> <sel\|@ref>` | 상태 확인: 가시, 숨겨진, 활성화, 비활성화, 검사, 편집, 집중 |
| `console [--clear\''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''|--errors]`를 | Captured 콘솔 메시지 |
| `network [--clear]` | Captured 네트워크 요청 |
| `dialog [--clear]` | Captured 대화 상자 메시지 |
| `cookies` | 모든 쿠키는 JSON |
| `storage` / `storage set <key> <val>` | localStorage + sessionStorage를 모두 읽으십시오; localStorage를 놓으십시오 |
| `perf` | 페이지로드 타이밍 |
| `inspect [sel] [--all] [--history]` | Deep CSS via CDP — full rule cascade, box model, computed styles |
| `ux-audit` | 행동 분석을위한 페이지 구조 : 사이트 ID, nav, headings, text block, 상호 작용 요소 |
| `cdp <Domain.method> [json-params]` | CDP 메서드 파견 (deny-default; allowlist `cdp-allowlist.ts`) |

### 내비게이션

| Command | 의 특징 |
|---------|-------------|
| `goto <url>` | URL (`http://`, `https://`, `file://`)로 이동하십시오 |
| `load-html <file>` | 로컬로드 HTML 메모리 (no `file://` URL; viewport 스케일 변경을 생존) |
| `back`, `forward`, `reload` | 표준 nav |
| `url` | 현재 페이지 URL |
| `wait <sel\|--networkidle\(으)로|--load>` | 요소, 네트워크 요원, 또는 페이지로드 (15s timeout) |

## # 상호 작용

| Command | 의 특징 |
|---------|-------------|
| `click <sel\|@ref>` | 을 클릭하십시오. |
| `fill <sel> <val>` | 입력 입력 |
| `select <sel> <val>` | 드롭다운 옵션 선택 (값, 라벨, 또는 볼 텍스트) |
| `hover <sel>` | Hover 성분 |
| `type <text>` | 유형에 집중된 요소 |
| `press <key>` | Playwright 키보드 키 (케이스 감지: 입력, 탭, 화살표 업, Shift+Enter, Control+A, ...) |
| [Sel\] 의 sel\|@ref]` | 스크롤 요소로 보기, 또는 페이지 하단으로 이동 no selector |
| `viewport [<WxH>] [--scale <n>]` | viewport 크기 + 선택 `deviceScaleFactor` 1-3 (retina 스크린 샷) |
| `upload <sel> <file> [...]` | 파일 업로드(s) |
| `dialog-accept [text]` | 다음 alert/confirm/prompt를 제외하고; 텍스트는 신속한 전송 |
| `dialog-dismiss` | 자동 dismiss 다음 대화 상자 |

## 스타일 + 정리

| Command | 의 특징 |
|---------|-------------|
| `style <sel> <prop> <val>` | CSS 속성 수정 (무도 지원) |
| `style --undo [N]` | Undo 마지막 N 스타일 변경 |
| `청소 [-ads\|--코크리 \|--sticky\(매우)|--교부|--all]'실제 이름입 | 페이지 clutter를 제거 |
| `prettyscreenshot [--scroll-to <sel\'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''|text>] [---cleanup] [---hide <sel>...] [path]` | 선택적 정리, 스크롤, 숨기지은과 깨끗한 스크린 샷 |

### 비주얼

| Command | 의 특징 |
|---------|-------------|
| `screenshot [--selector <css>] [--viewport] [---clip x,y,w,h] [-base64] [sel\|@ref] [경로]` | 다섯 모드: 전체 페이지, 뷰포트, 요소 작물, 지역 클립, base64 |
| `pdf [path] [---format Letter\|₢ 킹|법적] [...]` | PDF 전체 레이아웃: 형식, width/height, 마진, 헤더/footer 템플릿, 페이지 번호, -- 태그 accessibility, --toc wait for Paged.js |
| `responsive [prefix]` | 3개의 스크린 샷: 모바일 (375x812), 태블릿 (768x1024), 데스크탑 (1280x720) |
| `diff <url1> <url2>` | 텍스트 diff 두 URL 사이 |

## 쿠키 + 헤더

| Command | 의 특징 |
|---------|-------------|
| `cookie <name>=<value>` | 현재 페이지 도메인에 cookie 설정 |
| `cookie-import <json>` | JSON 파일에서 쿠키를 가져옵니다 |
| `cookie-import-browser [browser] [--domain d]` | 설치 Chromium 브라우저 (interactive picker, 또는 `--domain`에서 직접 수입) |
| `header <name>:<value>` | 사용자 지정 요청 헤더 설정 (감시 값 자동 재검토) |
| `useragent <string>` | user Agent 설정 (triggers context recreation, 잘못된 refs) |

## 탭 + 프레임

| Command | 의 특징 |
|---------|-------------|
| `tabs` | 탭 목록 |
| `tab <id>` | 탭으로 전환 |
| `newtab [url] [--json]` | 새 탭을 엽니다; `--json`는 programmatic 사용을 위한 `{tabId, url}`를 돌려줍니다 |
| `closetab [id]` | 닫기 탭 |
| `tab-each <command> [args...]` | 각 열린 탭에서 명령을 실행; JSON을 반환 |
| `frame <sel\'에 대하여|@ref\|--이름 n\|--url 패턴|메인>` | iframe context로 전환 (또는 메인으로 돌아 가기); refs |

### 추출

| Command | 의 특징 |
|---------|-------------|
| `download <url\'을 다운로드|@ref> [경로] [-base64]` | 브라우저 쿠키를 사용하여 URL 또는 미디어 요소 다운로드 |
| `scrape <이미지\|동영상|media> [---selector] [---dir] [--limit]` | 대량 다운로드 페이지의 모든 미디어; 쓰기 `manifest.json` |
| `archive [path]` | Save complete page as MHTML via CDP |

## 스냅샷

| Command | 의 특징 |
|---------|-------------|
| `snapshot [-i] [-c] [-d N] [-s sel] [-D] [-a] [-o path] [-C]` | `@e` refs; `-i`는 `-c` 콤팩트, `-d N` 깊이, `-s` 범위, `-D` diff 대, `-a` annotated 스크린, `-C` cursor-interactive `@c` refs를 가진 접근가능성 나무 |

## 서버 수명주기

| Command | 의 특징 |
|---------|-------------|
| `status` | daemon 건강 + 모드 (headless / headed / CDp) |
| `stop` | daemon (daemon가 이미 사망한 경우에도 succeeds; 중지 할 것만으로도 부츠가 없다; headless Chromium 를 재개한다. |
| `restart` | Restart daemon |
| `connect` | headed GStack 사이드 패널 확장을 가진 브라우저 |
| `disconnect` | headed Chrome, headless로 돌아갑니다 |
| `focus [@ref]` | headed Chrome를 전경으로 가져가십시오 (macOS); `@ref`는 또한 보기로 스크롤합니다 |
| `state 저장\|짐 <name>` | 브라우저 상태 저장 또는 로드 (cookies + URL) |
| `memory [--json]` | Snapshot Bun heap + per-tab JS heap + Chromium process tree + bounded buffer size. 프로그래밍 소비자를 위한 `--json`를 사용하십시오; 텍스트 모드는 "및 N" 꼬리를 가진 분류된 top-10 탭을 만듭니다. |

daemon의 stdout/stderr는 `<project>/.gstack/browse-daemon.log` (추가 모드, 크기 모자에 `.log.1`, 단일 세대), 토큰과 불합형 페이지 내용이 그대로 유지되어 있는 상태에서, daemon가 확고한 원인 없이 죽을 때 체크하십시오. 살아있는-but-unresponsive daemon는 결코 자동킬이 없는 것입니다; 그것을 명시적으로 대체하기 위하여 `--force-restart`를 통과하십시오 (daemon 사이클링을 보십시오).

### Handoff

| Command | 의 특징 |
|---------|-------------|
| `handoff [reason]` | 현재 페이지의 Chrome를 엽니다 (CAPTCHA, MFA, auth) |
| `resume` | 사용자 takeover 후 재 냅킨, AI로 리턴 제어 |

## 메타 + 체인

| Command | 의 특징 |
|---------|-------------|
| `chain` (JSON 를 통해 stdin) | 명령의 순서 실행. `[["cmd","arg1",...],...]`에서 `$B chain`로 파이프. 첫번째 오류에서 중지합니다. |
| `inbox [--clear]` | sidebar scout inbox에서 메시지 목록 |
| `watch [stop]` | Passive Observ — user가 검색하는 동안 주기적인 스냅샷; `stop`의 반환 요약 |

## 브라우저 - skills 실행 시간

| Command | 의 특징 |
|---------|-------------|
| `skill list` | 해결 계층 (프로젝트 > 글로벌 > 번들)과 함께 모든 브라우저 스킬 목록 |
| `skill show <name>` | 인쇄 SKILL.md |
| `skill run <name> [--arg k=v...] [--timeout=Ns]` | per-spawn scoped token와 기술 스크립트를 붙여넣으십시오. |
| `skill test <name>` | 번들 고정장치에 대한 기술 `script.test.ts` 실행 |
| `skill rm <name> [--global]` | 사용자 계층 기술 묘비 |

## 도메인 스킬

| Command | 의 특징 |
|---------|-------------|
| `domain-skill 저장\|list\|ღ♥ღ|ღ♥ღ|미션-to-global|롤백 \|rm <host?>` | 현장 에이전트 노트 (활성 탭에서 파생 된 호스트). 라이프 사이클 : quarantined → 활성 (N = 3 이후 클래스터 플래그없이 성공적인 사용) → 글로벌 (explicit Promot) |

Aliases: `setcontent`, `set-content`, `setContent` → `load-html` (범위 체크의 앞에, 이렇게 읽기스코프 token는 쓰기 명령을 실행하기 위하여 별명을 사용할 수 없습니다).

---

## 스냅샷 시스템

브라우저의 키 혁신은 Playwright의 접근성 트리 API에 내장된 **ref-based 요소 선택**입니다. No DOM 뮤테이션. No 주사된 스크립트. Playwright의 AX API.

## `@ref`는 어떻게 작동합니까?

1. `page.locator(scope).ariaSnapshot()`는 YAML-accessibility tree와 같이 반환합니다.
2. snapshot 파서는 각 원소에 refs (`@e1`, `@e2`, ...)를 할당합니다.
3. 각 ref를 위해, 그것은 Playwright `Locator` (`getByRole` + nth-child를 사용)를 건설합니다.
4. ref→로케이터 맵은 `BrowserManager`에 저장됩니다.
5. `click @e3`와 같은 나중에 명령은 찾기를보고 `locator.click()`를 호출합니다.

### Ref staleness 탐지

SPAs can mutate the DOM without navigation (React router, tab switches, modals). When this happens, refs collected from a previous `snapshot` may point to elements that no longer exist. `resolveRef()` runs an async `count()` check before using any ref — if the element count is 0, it throws immediately with a message telling the agent to re-run `snapshot`. Fails fast (~5ms) instead of waiting for Playwright's 30-second action timeout.

### 확장 snapshot 특징

- **`--diff` (`-D`).** 각 snapshot를 기본으로 저장합니다. 다음 `-D`
  호출, 변경된 내용을 보여주는 unified diff를 반환합니다. 이 작업을 확인하기 위해 사용 (click, fill, 등) 실제로 일했습니다.
- **`--annotate` (`-a`).** 각 ref의 임시 오버레이 divs를 주사합니다
  바인딩 상자, 보이는 ref 상표를 가진 스크린 샷을 가지고 가고, 그 후에 오버레이를 제거합니다. 산출을 통제하기 위하여 `-o <path>`를 사용하십시오.
- **`--cursor-interactive` (`-C`).** 비ARIA 상호 작용하는 성분을 위한 검사
  (divs with `cursor:pointer`, `onclick`, `tabindex>=0`) using `page.evaluate`. Assigns `@c1`, `@c2`... refs with deterministic `nth-child` CSS selectors. These are elements the ARIA tree misses but users can still click.

---

## 브라우저 - skills 실행 시간

반복된 브라우저가 정의된 Playwright 스크립트로 흐르는 것을 통합하는 Per-task 감독. 합성 층.

### 브라우저의 애벌레

```
browser-skills/<name>/
├── SKILL.md                        # frontmatter + prose contract
├── script.ts                       # deterministic Playwright-via-browse-client logic
├── _lib/browse-client.ts           # vendored copy of the SDK (~3KB, byte-identical to canonical)
├── fixtures/<host>-<date>.html     # captured page for fixture-replay tests
└── script.test.ts                  # parser tests against the fixture (no daemon required)
```

번들된 참조는 `browser-skills/hackernews-frontpage/`: HN 프론트 페이지에 스크랩, JSON 으로 30개의 이야기를 반환합니다. 그것을 시도하십시오:

```bash
$B skill list                            # shows hackernews-frontpage (bundled)
$B skill show hackernews-frontpage
$B skill run hackernews-frontpage        # JSON of 30 stories in ~200ms
$B skill test hackernews-frontpage       # runs script.test.ts against fixture
```

### 3 층 저장

`$B skill list`는 우선순위에서 3개의 걸음을 걸었습니다; 첫번째 명중 승리. Resolved 층은 각 기술 이름 옆에 인쇄한 인라인입니다:

| Tier | Path | 의 의 |
|------|------|------|
| **의정부** | `<project>/.gstack/browser-skills/<name>/` | 프로젝트별 기술 (committed 또는 gitignored) |
| **- 연혁** | `~/.gstack/browser-skills/<name>/` | Per-user 기술, 모든 프로젝트 |
| **묶음** | `<gstack-install>/browser-skills/<name>/` | gstack, read-only를 가진 배 |

### 신뢰 모델

두 개의 직각 축 - daemon-side 기능 및 프로세스 측면 env - 독립적으로 구성.

| 의 확장 | 의례 | Default |
|------|-----------|---------|
| **daemon사이드 기능** | scoped token 읽기+쓰기 범위 (브라우저-주제 명령 마이너스 관리자: `eval`, `js`, `cookies`, `storage`)에 바인딩하십시오. 단일 용도 clientId는 기술 이름 + 스파드 ID를 암호로 합니다. 스파드 출구 때 보류했습니다. | 항상 scoped — daemon 루트 token |
| **공정 측 env** | `trusted: true` frontmatter passes `process.env` minus `GSTACK_TOKEN`. `trusted: false` (default) drops everything except a minimal allowlist (LANG, LC_ALL, TERM, TZ) and pattern-strips secrets (TOKEN/KEY/SECRET/PASSWORD, AWS_*, ANTHROPIC_*, OPENAI_*, GITHUB_*, etc.) | 위탁 (무엇을 선택) |

`GSTACK_PORT`와 `GSTACK_SKILL_TOKEN`는 마지막으로 주사됩니다, 그래서 부모 과정은 그(것)들을 과도할 수 없습니다.

### 산출 의정서

stdout = JSON. stderr = 스트리밍 로그. 0/비-제로 출구. Default 60s timeout, `--timeout=Ns`를 통해 override. 최대 stdout 1MB (비-제로 출구를 초과하면). `gh`/ `kubectl`/ `docker` 대회 일치.

### SDK 배포 작업

Each skill ships its own copy of `browse-client.ts` at `_lib/browse-client.ts`, byte-identical to the canonical `browse/src/browse-client.ts`. `/skillify` copies the canonical SDK alongside every generated script. Each skill is fully self-contained: copy the directory anywhere, it runs. Version drift impossible — the SDK is frozen at the version the skill was authored against.

## Atomic 쓰기 분야 (`/skillify` D3)

`browse/src/browser-skill-write.ts`는 3개의 원시를 제공합니다:

- `stageSkill(opts)` - `~/.gstack/.tmp/skillify-<spawnId>/<name>/`에 파일을 쓰다
  제한적 perms로.
- `commitSkill(opts)` - 최종 계층 경로로 `fs.renameSync`.
  symlinked staging dirs (`lstat` check)를 따르는 것을 거부합니다. clobber 기존 기술을 거부하고, 계층 루트의 `realpath` 의 장을 실행합니다.
- `discardStaged(stagedDir)` - `rm -rf` 무대 디르 + per-spawn 래퍼.
  Idempotent. 시험 실패 또는 승인 거부에 호출.

no "알파"상태가 있습니다. 테스트 패스 + 사용자 승인 = 원자 이름. 테스트 실패 또는 사용자 거부 = 바니시를 완화.

전체 디자인 합리적 [`docs/designs/BROWSER_SKILLS_V1.md`](docs/designs/BROWSER_SKILLS_V1.md)를 참조하십시오.

---

## 도메인-스킬

브라우저의 다른 정신 모델: 사이트에 대한 에이전트-authored *notes* (예를들면 스크립트). 호스트 이름 당 하나. Lifecycle:

1. `domain-skill save <host>` - 에이전트는 사이트에 대한 메모를 작성합니다 (예 :
   "GitHub: PR 생성은 `--draft` 플래그를 비-staff" "X.com: 타임 라인은 cursor pagination, 페이지 번호가 아닌 사용); Default 상태: **의붓기**.
2. **N=3의**가 L4가 없는 성공적인 용도 후에 신속한 주입 classifier
   주의를 기울이는 것은 **active**에 자동 promotes.
3. `domain-skill promote-to-global <host>`는 글로벌 계층에 들어갑니다.
   (기계 전체, 모든 프로젝트).
4. `domain-skill rollback <host>` 데모; `domain-skill rm <host>` 묘비.

classifier flag는 L4 프롬프트 주사 검사에 의해 자동으로 설정됩니다. 에이전트는 수동으로 설정하지 않습니다.

저장:
- 프로젝트: `<project>/.gstack/domain-skills/<host>.md`
- 글로벌: `~/.gstack/domain-skills/<host>.md`

출처: `browse/src/domain-skills.ts`, `domain-skill-commands.ts`.

---

## Real-browser 모드

`$B connect`는 **GStack 브라우저**를 발사합니다 - 측 패널 연장 자동 적재되고 반대로 bot는 훔치는 헝겊 조각 적용된 Chromium에 의해 통제되는 Playwright. 당신은 순간에 눈에 보이는 창을 통해서 각 명령 진드기를 보게 합니다.

```bash
$B connect              # launches GStack Browser, headed
$B goto https://app.com # navigates in the visible window
$B snapshot -i          # refs from the real page
$B click @e3            # clicks in the real window
$B focus                # bring window to foreground (macOS)
$B status               # shows Mode: cdp
$B disconnect           # back to headless mode
```

창문은 정상에 미묘한 황금 shimmer 선을 비치하고 뜨는 “gstack” 바닥에 있는 알약이 그래서 당신은 항상 알고 있습니다 Chrome 창은 통제됩니다.

### "GStack 브라우저"는 뜻입니다.

Chrome - Dock과 menu bar (`.app` 이름, Dock 아이콘 및 트레이, NOT 문자열)에서 사용자 정의 브랜드와 함께 Playwright 관리 Chromium, 항상 레이어 C 안티-봇 훔치는 (대부분 JS-저장 자동화는 마스크를 말한다, 그래서 많은 안티-봇 보호 사이트로드 깨끗하게), 재고-저장 사용자 보고서를 통해 gstack-저장 자동화는 gstack-저장된 확장을 통해 gstack->-저장된 확장을 통해. UA no는 `GStackBrowser` suffix를 더 긴 나르습니다 - 상표 끈은 높 entropy 말 자체로, 그래서 브라우저는 지금 일반 `Chrome/<version>` UA를 보고합니다. Deepest-layer CDP-protocol 탐지는 아직도 (Google는 아직도 captchas를 방아쇠를 얻게 됩니다; CDP-patch 품목을 `TODOS.md`) 보십시오. 당신의 일정한 Chrome는 당신의 책과 일치하지 않는 탭을 가진 체재합니다.

### headed 모드를 사용할 때

- **QA 테스트** 앱을 통해 Claude click를 시청하고 싶은 곳
- **디자인 리뷰** Claude가 정확히 무엇을 볼 필요가 있는 곳
- **딜러** headless 동작은 실제 Chrome와 동일합니다.
- **데모** 화면을 공유하는 곳
- **쌍 에이전트** 세션 (주요청은 로컬 브라우저를 구동)

## Aside 및 제3자 드라이브 (v1.72.0.0+)

제3자 웹 사이트 순간 (API 키에 등록, 공급 업체 대시보드 구성), 워크플로 기술 (`/ship`, `/spec`, `/office-hours`, `/land-and-deploy`, `/setup-deploy`)는 설치될 때 Aside AI 브라우저를 권장합니다. 이것은 `$B` headed 모드 + 핸오프를 사용하여 실제 로그인 세션을 통해 작동하며, 유니버설 가을으로 제한됩니다. 따라서, 이진은 절대로 처리되지 않습니다. gstack headed 모드가 아닌 경우, 절대로 처리되지 않습니다.

한 관찰성 동굴 : Aside를 통해 구동은 전반적으로 발생하므로 no gstack-side Audit trail - no egress 영수증, no 검색 -daemon 로그를 남깁니다. 그 드라이브의 감사 흔적은 아편 자체에 살고 있습니다. `$B`를 통해 드라이브는 정상 daemon 로그 및 egress 영수증을 유지합니다.

## CDP-aware 기술

실제 브라우져 모드에서 `/qa` 및 `/design-review`는 자동으로 cookie 가져오기 프롬프트와 headless workarounds — headed 브라우저가 이미 로그인한 세션이 있습니다.

## Headed 모드 + 프록시 + 브라우저 고유 다운로드 (v1.28.0.0)

headless 브라우저, 지문 Playwright 기본을 차단하는 사이트의 세 개의 좌표 플래그 또는 정적 업스트림 프록시 뒤에 앉아:

```bash
# Visible Chromium. Auto-spawns Xvfb on Linux containers without DISPLAY.
$B --headed goto https://example.com

# SOCKS5 with auth — Chromium can't prompt for SOCKS5 creds, so $B runs a
# local 127.0.0.1 bridge that handles the auth handshake.
$B --proxy socks5://user:pass@residential.proxy.host:1080 goto https://example.com

# HTTP/HTTPS proxy passes through to Chromium directly.
$B --proxy http://corp-proxy:3128 goto https://example.com

# Browser-native download for Content-Disposition, redirect chains, anti-bot
# CDNs where page.request.fetch() falls over.
$B download "https://protected.example.com/file" /tmp/file.bin --navigate

# Combined.
$B --headed --proxy socks5://user:pass@host:1080 \
   download "https://protected.example.com/file" /tmp/file.bin --navigate
```

**Credential 정책.**는 URL (`socks5://user:pass@host`) OR를 통해 주름을 잡습니다 env vars `BROWSE_PROXY_USER`/ `BROWSE_PROXY_PASS` — 둘 다 결코. `$B`는 둘 다 놓일 때 명확한 힌트로 멈춥니다; 침묵하는 override는 “내 기계에 웍” 벌레잡기 함정을 창조했습니다.

**daemon 분야.** `--proxy`와 `--headed`는 daemon-startup config입니다. config B가 1을 `browse disconnect`로 설정하고, 탭 상태, 쿠키, 세션 대신 힌트로 설정한 daemon를 실행하는 daemon를 실행합니다.

**스텔스 범위 (Layer C, 항상 위에).** 모든 컨텍스트 — headless `launch`, `--headed`/`--proxy`, `handoff`, `useragent`/`viewport --scale` 재건 (`recreateContext`) - 전체 레이어 C 마스크, no 옵트인 플래그를 가져옵니다. 레이어 C 마스크 `navigator.webdriver`, `window.chrome.*` 모양을 복원 (`runtime`, `app`, `csi`, `loadTimes`), 퍼미션 API과 `Notification.permission`, 호스트 프로필에서 `hardwareConcurrency`/`deviceMemory`를 제거하고 알려진 Selenium/Phantom/Nightmare/Playwright 글로벌을 청소하고 `Function.prototype.toString` 프록시를 설치하여 각 패치를 다시 볼 수 있습니다. `[native code]`/>는 각 패치를 다시 볼 수 있습니다. `[native code]` NOT 가짜 `navigator.plugins` 또는 `navigator.languages` - 현대 지문인은 일관성을 위해 그들을 십자가 검사하고, 고정 값 플래그를 합성합니다 MORE bot-like, 더 적은. ChromeDriver의 `cdc_`/`__webdriver` 가동 시간 artifacts 및 권한 통보는 또한 각 경로에 청소됩니다.

`GSTACK_STEALTH=extended` (또한 `1` 또는 `true`를 받아들입니다; default)는 정상에 6개의 공격적인 헝겊 조각을 층을 칩니다 — WebGL 연출자 spoof, 가짜 `navigator.plugins` PluginArray, `navigator.mediaDevices`. 그것은 또한 그 재산에 반영한 사이트 및 틈을 수 있습니다; default 방아쇠 탐지 때만 사용하십시오. gbrowser는 C++ 패치와 함께 빌드합니다. `GSTACK_*` 호스트 프로파일 env (GPU 납품업자/renderer, UA-CH 플랫폼/model, 하드웨어)는 팩 1 `--gstack-gpu-vendor` / `--gstack-gpu-renderer` / `--gstack-ua-platform` / `--gstack-ua-model` / `--gstack-hw-concurrency` / `--gstack-device-memory` 스위치를 방출합니다. push push `true` / `true` / `true` / `--gstack-ua-model` / `--gstack-ua-model` / `--gstack-hw-concurrency` /> 재고 Playwright Chromium 이 스위치의 각 하나는 안전 no-op입니다.

`launchHeaded` / `handoff`는 `ignoreDefaultArgs` (`STEALTH_IGNORE_DEFAULT_ARGS`)를 통해 `ignoreDefaultArgs` (`STEALTH_IGNORE_DEFAULT_ARGS`)를 통해 `--enable-automation` (Chrome는 자동화된 시험 소프트웨어에 의해 통제됩니다), `--disable-extensions`, `--disable-component-extensions-with-background-pages`, `--disable-popup-blocking`, `--disable-component-update`, `--disable-default-apps`.

**컨테이너 지원.** `--headed` 에 Linux 없이 `DISPLAY` 전시 범위 (`:99`, `:100`, ...) 까지 `xdpyinfo` 보고 무료 슬롯, 그 후 spawn Xvfb. Cleanup-on-disconnect는 기록된 PID's `/proc/<pid>/cmdline` 경기 `Xvfb` AND 시작 시간 일치를 모두 사용하도록 유효한 no no PID의 기본 간격 PID의 PID는 전적으로 말립니다. 최소 이미지 (알파인, 디트로이)는 fonts/dbus/gtk libs for headed Chromium 을 렌더링할 수 있습니다.

**실패 모드.** SOCKS5 upstream rejected or unachable — fail-fast 시작에서 적격 오류 후 3 개의 retries (5s 예산). 중간 흐름 업스트림 드롭 - 다리는 영향을받는 클라이언트 연결 만 죽는다; no 수송은 브라우저 트래픽을 손상시킬 수 있습니다.

---

## 측 패널 + sidebar 에이전트

Chrome 확장은 GStack 브라우저가 사이드 패널에서 모든 검색 명령의 라이브 활동 피드를 보여 주며, `@ref` 페이지에 오버레이가 있고, Claude PTY는 사이드바 안에 있습니다.

## 제1터미널 팬(본선)

The Side Panel's primary surface is the **터미널 팬** — a live `claude -p` PTY you can type into directly from the sidebar. Activity / Refs / Inspector are debug overlays behind the footer's `debug` toggle. WebSocket auth uses `Sec-WebSocket-Protocol` (browsers can't set `Authorization` on a WebSocket upgrade), and the PTY session token is a 30-minute HttpOnly cookie minted via `POST /pty-session`.

도구 모음의 정리 버튼과 검사관의 "코드에 보내"작동 모두 파이프 텍스트를 라이브 Claude PTY를 통해 `window.gstackInjectToTerminal(text)`, `sidepanel-terminal.js`에 노출. no 분리 `/sidebar-command` POST - 라이브 REPL는 유일한 실행 표면입니다.

### 활동 피드

모든 검색 명령의 스크롤 피드 — 이름, args, 기간, 상태, 오류. Claude 작품으로 실시간 표시. SSE (`/activity/stream`)에 의해 백업 Bearer token OR HttpOnly `gstack_sse` 세션 cookie (30 분 스트림 -스코프 cookie를 통해 분화 `POST /sse-session`).

### 탭 참조

`$B snapshot` 이후, 현재 `@ref` 목록 (로레 + 이름)을 보여 주므로 Claude가 타겟팅하는 것을 볼 수 있습니다.

### CSS 검사기

`$B inspect` (CDP-based)에 의해 구동. 페이지에 어떤 성분을 클릭해서 전체 CSS 규칙 케이케이드, computed 작풍, 상자 모형, 및 수정 역사를 볼 수 있습니다. "코드에 보내기" 단추는 Claude PTY에 설명합니다.

### 사이드바 아키텍처

| 제품정보 | 그곳에서 | 참고 |
|-----------|----------------|-------|
| 측 패널 UI | `extension/sidepanel.js`, `sidepanel-terminal.js` | Chrome 확장 표면 |
| 배경 SW | `extension/background.js` | 탭 이벤트 관리, 포트 관리 |
| 콘텐츠 스크립트 | `extension/content.js` | 페이지 오버레이, `gstack` 알약 |
| 터미널 에이전트 | `browse/src/terminal-agent.ts` | PTY 스파드, 라이프사이클, auth |
| Sidebar 유틸리티 | `browse/src/sidebar-utils.ts` | URL 위생, 도움 |

이 모든 것을 수정하기 전에, "Sidebar Architecture"의 `CLAUDE.md`의 주석 블록을 읽으십시오. -이 오류는 보통 교차 구성 요소 흐름을 이해하지 못합니다.

## 수동 설치 (일반적인 Chrome를 위해)

일상의 확장을 원하면 Chrome (Playwright-controlled one):

```bash
bin/gstack-extension    # opens chrome://extensions, copies path to clipboard
```

또는 수동으로 수행하십시오 : `chrome://extensions` → toggle Developer Mode → Load unpacked → `~/.claude/skills/gstack/extension` → 핀 확장 → `$B status`에서 포트를 입력합니다.

v1.63는 `key` 필드를 통해 확장 ID를 핀으로 꼿습니다, 그래서 기존의 풀린 설치는 새로운 확장 ID 및 panel-local state (saved port)를 한 번 재설정합니다 — 한 번에 제품 공지는 설명합니다.

---

## 쌍 에이전트

AI 에이전트 (Codex, OpenClaw, Hermes, HTTP)는 ngrok 터널를 통해 로컬 브라우저를 구동할 수 있습니다. 전체 흐름은 26-command allowlist, scoped 토큰 및 축 로그에 의해 문지르는 것입니다.

### 어떻게 작동합니까?

```bash
/pair-agent                     # generates a setup key, prints connection instructions
# Copy the instructions to the remote agent
# Remote agent runs:
#   POST <tunnel-url>/connect with setup key → gets a scoped token (24h, single client)
#   POST <tunnel-url>/command with token → runs allowed commands
```

## 듀얼-리스트 에너지 아키텍처 (v1.6.0.0+)

`pair-agent` 활성화시 daemon 바인딩 **two HTTP listeners**:

- **지역 청취자** (`127.0.0.1:LOCAL_PORT`). 전체 명령 표면. 절대로
  ngrok에 의해 전달. 당신의 Claude Code, 측 패널, 당신의 기계에 무엇이든에 의해 사용하는.
- **터널링** (`127.0.0.1:TUNNEL_PORT`). Locked allowlist —
  `/connect`, `/command` (scoped 토큰 + 26-command 브라우저 - allowlist), `/sidebar-chat`. ngrok 이 포트만 전달합니다.

터널 반환 403을 통해 전송되는 루트 토큰. SSE 엔드포인트는 30 분 HttpOnly `gstack_sse` cookie (`/command`에 대한 유효성)를 사용합니다.

### The 26-command tunnel allowlist

`TUNNEL_COMMANDS`로 `browse/src/server.ts`에서 정의하는. 순수한 문 기능 `canDispatchOverTunnel(command)`는 단위 테스트를 위해 수출됩니다. 세트:

```
goto, click, text, screenshot, html, links, forms, accessibility,
attrs, media, data, scroll, press, type, select, wait, eval,
newtab, tabs, back, forward, reload, snapshot, fill, url, closetab
```

비유: `pair`, `unpair`, `cookies`, `setup`, `launch`, `restart`, `stop`, `tunnel-start`, `token-mint`, `state`, `connect`, `disconnect`. 그 자리에 403를 얻은 원격 에이전트는 denial 로그에 신선한 항목이 됩니다.

## 터널 덴탈 로그

`~/.gstack/security/attempts.jsonl` - 부록만 소금 SHA-256 소스
+ 도메인 만 (no 원시 IP, no 전체 요청 몸), 10MB에서 5로 회전
세대. `~/.gstack/security/device-salt` (mode 0600)에 퍼 디바이스 소금.

## 터널 egress 영수증 (v1.63+)

모든 터널 세션은 해시 체인의 egress 영수증 (싱크 `browse-tunnel`)을 `~/.gstack/security/egress.jsonl` BEFORE ngrok로 작성합니다. 실패 닫힌: 영수증이 작성되지 않는 경우 터널 청취자는 찢어지기 시작하고 시작은 거부됩니다. `bin/gstack-egress list`로 원장 검사를 통해 `bin/gstack-egress verify` (탬퍼에 3을 제외)로 체인 무결성을 확인합니다.

전체 연산자 가이드에 대한 [`docs/REMOTE_BROWSER_ACCESS.md`](docs/REMOTE_BROWSER_ACCESS.md)를 참조하십시오.

### 탭 소유권

Scoped tokens default to `tabPolicy: 'own-only'`. A paired agent can `newtab` to create its own tab and drive that tab freely, but it can't `goto`, `fill`, or `click` on tabs another caller owns. `tabs` lists ALL tab metadata (an accepted tradeoff — see ARCHITECTURE.md), but `text`/`html`/`snapshot` content of unowned tabs is blocked by ownership checks.

---

## 인증

3개의 token 유형, 3개의 일생, 3개의 범위.

| 의논하기 | 의 모든 것 | 의논하기 | 범위 |
|-------|--------------|----------|-------|
| **뿌리 token** | daemon 시작 (random UUID) | daemon 공정 수명 | 풀 명령 표면, 로컬 리리스만 — 403 over tunnel |
| **설정 키** | `POST /pair` | 5 분, 1 회 사용 | 단 하나 구속: `/connect`에서, 얻습니다 scoped token를 |
| **Scoped token** | `POST /connect` (설정 키 포함) | 24시간 | Per-client, allowlist-bound, 옵션 탭-경로 |

root token는 `<project>/.gstack/browse.json`와 chmod 600으로 작성됩니다. 브라우저 상태를 mutates하는 모든 명령은 `Authorization: Bearer <token>`를 포함해야 합니다.

## SSE 세션 cookie (v1.6.0.0+)

SSE 엔드포인트 (`/activity/stream`, `/inspector/events`)는 Bearer token OR를 `gstack_sse` cookie를 통해 minted `POST /sse-session`를 통해 30 분 HttpOnly `gstack_sse` cookie minted를 받아들입니다. `?token=<ROOT>` 질은 auth 더 긴 지원됩니다. 이것은 Chrome 연장은 확장 token 저장에 있는 뿌리 공급 없이 루트 급식에 어떤 lets가 허용하는지 입니다.

## PTY 세션 cookie

터미널 팬은 `POST /pty-session`를 통해 cookie, `gstack_pty`, minted를 분리하는 세션 `POST /pty-session`를 사용합니다. 다른 범위는 - 살아있는 `claude` PTY를, 파견하는 것은 `/command`를 호출할 수 없습니다. `/health` 엔드포인트 MUST NOT는 이 토큰을 지상에 놓을 수 없습니다.

## 확장 token 부츠 스트랩 (v1.63+)

`GET /health`는 liveness/status만 - 어떤 형태든지에서 token를 결코 나타낸다. 옆 패널 연장은 국부적으로 청취자에 `POST /extension-token`를 통해 뿌리 token를 찰상합니다. 서버는 콜러의 근원이 정확하게 `chrome-extension://<GSTACK_EXTENSION_ID>`일 때 `key` 분야 `extension/manifest.json`에 있는 ID (<11/>) ID (<12>; <12/>; <12>; <12>; <12>; <12>; <12>; <12>; `bun browse/scripts/extension-id.ts`) - AND를 통해 부패되는 Host hostname는 루프백입니다. 다른 사람은 세부사항 자유로운 403를 얻게 합니다. 엔드포인트는 `TUNNEL_PATHS`에 결코 추가되지 않습니다, 그래서 터널 표면 404s는 과태 조밀도에 의해 그것.

## 토큰 레지스트리

`browse/src/token-registry.ts`는 mint/validate/revoke를 3가지 유형으로 취급하고, 각각 토큰 비율 제한을 가진 취급합니다. 설정 열쇠는 단 하나 사용입니다; scoped 토큰은 미끄러지는 24h 창이 있습니다; 뿌리 token는 각 daemon 시작에 자전됩니다.

---

## 보안 스택

불신뢰한 페이지 내용에 대한 신속한 주입에 대한 방어를 계층화했습니다.

| Layer | 모듈 | 의 삶 |
|-------|--------|----------|
| **L1** 데이터 마킹 | `content-security.ts` | 서버 + 페이지-content 읽는 경로 |
| **L2** 숨겨지은 지구 | `content-security.ts` | 서버 + 페이지-content 읽는 경로 |
| **L3** ARIA + URL 블럭리스트 + 봉투 래핑 | `content-security.ts` | 서버 + 페이지-content 읽는 경로 |
| **L4** TestSavantAI ML 클래스터 (112MB ONNX) | `security-classifier.ts` | 보안 sidecar 하위 처리* |
| 수의 token 유틸리티 | `security.ts` | 순수한 기능 — no 오늘 살아있는 인젝터 |
| `combineVerdict` 앙상블 | `security.ts` | 서버 (inline L4 verdict 경로) |

\* `security-classifier.ts`는 컴파일된 검색 바이너리에서 가져올 수 없습니다 - `@huggingface/transformers` v4는 `dlopen`에서 Bun 컴파일의 임시 추출물 디디디에 실패한 `onnxruntime-node`를 요구합니다. 컴파일된 이진은 L1–L3를 실행하고 `security.ts`의 순수한 부분과 더불어 L4는 일반 Node sidecar (`security-sidecar-entry.ts`, 처음 `/pty-inject-scan`에 의해 좌절된 lazily>)에서 `security.ts` 뛰습니다.

### 임계값

- `BLOCK: 0.85` — 단층 점수는 BLOCK를 횡단 확인한 경우
- `WARN: 0.75` - `combineVerdict`의 교차확장 임계값
- `LOG_ONLY: 0.40` - 로그 전용 층
- `SOLO_CONTENT_BLOCK: 0.92` - 라벨 없는 콘텐츠 클래스터를 위한 단일 레이어 임계값

### 앙상블 규칙

`combineVerdict`는 다중층 앙상블 세망트(F-of-N 블록)을 유지하며, WARN에 단일 레이어 높은 신뢰 등급을 유지하며, Stack Overflow 명령어를 사용하여 FP mitigation)를 강제로 옮겼지만, L4 (testsavant)는 오늘 살아있다. Haiku transcript와 DeBERTa 앙상블 레이어는 사이드바 채팅 파이프와 함께 제거되었습니다. **수유는 항상 BLOCK (deterministic)를 누출합니다.**

### Env 손잡이

- `GSTACK_SECURITY_OFF=1` - 비상 사태 스위치. Classifier가 꺼져 있습니다.
  따뜻하게되면. ML 스캔이 건너 뛰는 것입니다.
- 분류기 모형 캐시: `~/.gstack/models/testsavant-small/` (112MB, 첫번째
  런치만
- 공격 로그: `~/.gstack/security/attempts.jsonl` (salted SHA-256 + 도메인
  10MB, 5세대에서 회전합니다.
- 퍼-디바이스 소금 : `~/.gstack/security/device-salt` (0600).

There is no security status indicator in the sidebar and no `security` field on `/health` (#2557): the session-state file that fed them lost its only writer when the chat-path agent was removed, so they reported stale or empty data. The live defenses report through their own call sites. See ARCHITECTURE.md § "Prompt injection defense" for the full threat model.

---

## 스크린샷, PDF, 시각

## 스크린 샷 모드

| * 이름 | 의논문 | Playwright API |
|------|--------|----------------|
| 전체 페이지 (default) | `screenshot [path]` | `page.screenshot({ fullPage: true })` |
| Viewport 전용 | `screenshot --viewport [path]` | `page.screenshot({ fullPage: false })` |
| 성분 작물 (flag) | `screenshot --selector <css> [path]` | `locator.screenshot()` |
| 성분 작물 (구분) | `screenshot "#sel" [path]` 또는 `screenshot @e3 [path]` | `locator.screenshot()` |
| 지역 클립 | `screenshot --clip x,y,w,h [path]` | `page.screenshot({ clip })` |

요소 작물은 CSS selectors (`.class`, `#id`, `[attr]`) 또는 `@e`/`@c` refs를 받아들입니다. **태그 selectors like `button` aren't catch by the positional heuristic** — `--selector` 플래그 모양을 사용하십시오.

`--base64` 디스크에 쓰기 대신 `data:image/png;base64,...`를 반환합니다. `--selector`, `--clip`, `--viewport`와 함께 구성합니다.

상호 포함 : `--clip` + 선택, `--viewport` + `--clip`, `--selector` + 위치 선택자 모두 던졌습니다.

## Retina 스크린 샷 - `viewport --scale`

`viewport --scale <n>` 세트 Playwright의 `deviceScaleFactor` (콘텍스트 레벨, 1–3 모자):

```bash
$B viewport 480x600 --scale 2
$B load-html /tmp/card.html
$B screenshot /tmp/card.png --selector .card
# .card at 400x200 CSS pixels → card.png is 800x400 pixels
```

`--scale N` 혼자 (no `WxH`)는 현재 전망 포트 크기를 지킵니다. 가늠자는 `@e`/`@c` refs를 유효하게 하는 컨텍스트 크기를 방아쇠를 끊습니다. HTML는 in-memory 재생을 통해 감소를 살아남습니다. headed 형태 (실행 브라우저 통제 가늠자)에서 거절하는.

## PDF 세대

`pdf`는 완전한 Playwright 표면 플러스 몇몇 추가를 받아들입니다:

- **모델 번호:** `--format letter|a4|legal`, `--width <dim>`, `--height <dim>`,
  `--margins <dim>`, `--margin-top/right/bottom/left <dim>`
- **구조:** `--toc` (부하되는 경우에 Paged.js를 위한 낭비), `--outline`,
  `--tagged` (PDF/A 접근성), `--print-background`, `--prefer-css-page-size`
- **상표:** `--header-template <html>`, `--footer-template <html>`,
  `--page-numbers`
- **탭:** `--tab-id <N>` 특정 탭을 렌더링
- **큰 탑재량:** `--from-file <payload.json>` (아보이즈 포탄 argv 한계)

### 책임 스크린샷

`responsive [prefix]` — 한 개의 호출에 세 개의 스크린 샷: 모바일 (375x812), 태블릿 (768x1024), 데스크탑 (1280x720). `{prefix}-mobile.png` 등으로 저장하십시오.

### `prettyscreenshot`

정리 + 스크롤 + 요소가 하나의 호출에 숨겨지다 :

```bash
$B prettyscreenshot --cleanup --scroll-to "hero section" --hide ".cookie-banner" /tmp/clean.png
```

---

## 지역 HTML

웹 서버가 아닌 HTML를 렌더링하는 두 가지 방법:

| 앱로치 | 의 의 | URL 후 | 상대 자산 |
|----------|------|-----------|-----------------|
| `goto file://<abs-path>` | 이미 Disk에 파일 | `file:///...` | 파일의 디렉토리에 대해 다시 해결 |
| `goto file://./<rel>`, `goto file://~/<rel>` | 스마트가 절대로 | `file:///...` | 의 의 |
| `load-html <file>` | HTML 메모리에서 생성 된 no 부모 디디스크가 필요 | `about:blank` | 브로큰 (각각종 HTML만) |

둘 다 scoped는 `eval`와 동일한 안전한 디디렉션을 통해 cwd 또는 `$TMPDIR`의 파일에 `file://`입니다. `file://` URL은 쿼리 문자열과 파편을 보존합니다 (SPA 노선 일).

`load-html`는 allowlist (`.html`, `.htm`, `.xhtml`, `.svg`)와 HTML로 잘못 이름이진 파일들을 거부하는 마술 바이트 스니프가 확장되어 있습니다. 50MB 사이즈 캡 (`GSTACK_BROWSE_MAX_HTML_BYTES`를 통해 오버라이드).

`load-html` 내용이 나중에 살아남은 `viewport --scale`는 in-memory 재생 (TabSession는 적재된 HTML + waitUntil)를 통해 부르는 것을. 재생은 순전히 기억입니다 - HTML는 결코 비밀 또는 고객 자료를 새는 것을 피하기 위하여 `state save`를 통해 디스크에 지속되지 않습니다.

---

## 배치 엔드포인트

`POST /batch`는 단일 HTTP 요청에서 여러 명령을 보냅니다. 각 HTTP 통화 비용 2-5s를 ngrok 이상 원격 에이전트에 대한 지속적인 라운드 트립 대기 시간 제거.

```json
POST /batch
Authorization: Bearer <token>

{
  "commands": [
    {"command": "text", "tabId": 1},
    {"command": "text", "tabId": 2},
    {"command": "snapshot", "args": ["-i"], "tabId": 3},
    {"command": "click", "args": ["@e5"], "tabId": 4}
  ]
}
```

`handleCommandInternal`를 통해 각 명령 경로 - 전체 보안 파이프라인 (경보 체크, 도메인 유효성, 탭 소유권, 콘텐츠 포장) 명령 당 시행. 퍼컴드 오류 격리 : 한 실패는 배치를 구부리지 않습니다. 일괄 처리 당 최대 50 명령. 배열 배치가 거부됩니다. 제한 속도 : 1 배치 = 1 per-agent limit에 대한 요청.

패턴 : 20 페이지를 눌린 에이전트는 20 탭 (개인 `newtab` 또는 일괄 처리)을 열고 `POST /batch` 20 `text` 명령 → 20 페이지 내용 ~2-3 초 총 대 ~40-100 초 연속.

---

# 캡처

콘솔, 네트워크 및 대화 상자 이벤트는 O(1) 원형 버퍼 (각 50,000 용량)로 흐릅니다. `Bun.write()`를 통해 비동기적으로 디스크에 플러시됩니다.

- 콘솔: `.gstack/browse-console.log`
- 네트워크: `.gstack/browse-network.log`
- 대화: `.gstack/browse-dialog.log`

`console`, `network`, `dialog` 명령은 in-memory 버퍼 ( disk)에서 읽을 수 있으므로 캡처가 디스크가 느리면 실시간으로 표시됩니다.

Dialogs (alert, check, prompt)는 브라우저 잠금을 방지하기 위해 default에 의해 자동 허용됩니다. `dialog-accept <text>`는 신속한 응답 텍스트를 제어합니다.

---

## JS 실행

`js`는 인라인 표현식을 실행합니다. `eval`는 JS 파일을 실행합니다. **동일한 JS 샌드박스**에서 둘 다 실행 — 유일한 다름은 인라인 vs-file입니다. `await`를 둘 다 지원 `await` — `await`를 포함하는 표식은 async 상황에 자동 감싸입니다:

```bash
$B js "await fetch('/api/data').then(r => r.json())"   # auto-wrapped
$B js "document.title"                                  # no wrap needed
$B eval my-script.js                                    # file with await
```

`eval` 파일에 대해서는, 단선 파일이 직접 표현값을 반환합니다. `await`를 사용할 때 다선 파일이 명시된 `return`를 필요로 합니다. 리터럴 token "await"를 포함하는 댓글은 감싸지 않습니다.

Path safety: `eval`는 cwd 또는 `/tmp` 외부 경로를 거부합니다. `js`는 모든 파일들을 읽지 않습니다.

---

## 탭, 프레임, 상태

## 탭

```bash
$B tabs                          # list all open tabs
$B tab 3                         # switch to tab 3
$B newtab https://example.com    # open new tab, switch to it
$B newtab --json                 # programmatic: returns {"tabId":N,"url":...}
$B closetab                      # close current
$B closetab 2                    # close tab 2
$B tab-each "text"               # run "text" on every tab, return JSON
```

`tab-each <command>` 팬들은 각 열린 탭에서 명령을 실행하고 JSON 배열을 반환합니다. "모든 탭의 텍스트를 열 수 있습니다."

## 프레임

```bash
$B frame "#stripe-iframe"        # switch to iframe by selector
$B frame @e7                     # by ref
$B frame --name "checkout"       # by name attribute
$B frame --url "stripe.com"      # by URL pattern match
$B frame main                    # back to top frame
```

스위치에 담겨 있습니다 (iframe에는 자체 AX 나무가 있습니다).

### 국가 저장/load

```bash
$B state save my-session         # save cookies + URLs to .gstack/browse-state-my-session.json
$B state load my-session         # restore
```

In-memory `load-html` 내용은 의도적으로 NOT persisted (디스크에 분기된 비밀을 누출).

수동 저장/load는 한 샷입니다. daemon가 자동으로 시작된 상태에 `BROWSE_PERSIST_STATE=1`의 daemon의 환경에서 headless daemon 스냅샷 쿠키 + per-tab URL/localStorage/sessionStorage에서 `<stateDir>/session-state.json` (0600, 원자 쓰기)에 대해 30 초마다, 깨끗한 폐쇄에서 부팅 경로가 삭제됩니다. Default의 실제 시작 비용으로, 사용자의 비용에 대해 자세히 알아볼 수 있습니다. Default Headless만 (headed 모드의 지속성 Chromium 프로필은 이미 주를 소유합니다. 로드 HTML 및 탭 소유권은 로컬 호스트, `.internal`, 루프백 IP 리터럴 (127.0.0.0/8, `::1`), 링크-local/cloud-metadata 주소 (169.254.0.0/16)는 복원에 떨어졌다, 그리고 손상 snapshot는 결코 차단할 수 없습니다.

### 시계

```bash
$B watch                         # passive observation: snapshot every 5s while user browses
$B watch stop                    # return summary of what changed
```

브라우저를 수동으로 구동하고 Claude를 원하면 `snapshot` 호출없이 종료된 것을 볼 수 있습니다.

## # 박스

```bash
$B inbox                         # list messages from sidebar scout
$B inbox --clear                 # clear after reading
```

사이드바 스크 아웃 (배경 처리는 Chrome 확장은 스팸을 할 수 있습니다)는 사용자가 눈에 띄는 무언가를 표면화 할 때 Claude의 메모를 삭제합니다. `.gstack/browser-scout.jsonl`에 저장됩니다.

---

## CDP

### `$B cdp` — 원시 Chrome DevTools 의정서 파견

Deny-default. `browse/src/cdp-allowlist.ts` (`CDP_ALLOWLIST` const)에 과잉하는 유일한 방법만 도달 가능합니다; 다른 방법 반환 403. 각 allowlist 입장은 범위를 선언합니다 (tab 대 브라우저) 및 출력 (신뢰되지 않는 대 위탁). 위탁한 방법 (data-exfil 모양, 예를들면. `Network.getResponseBody`)는 UNTRUSTED-envelope에 의하여 감싸인 산출을 얻습니다.

```bash
$B cdp Page.getLayoutMetrics
$B cdp Network.enable
$B cdp Accessibility.getFullAXTree '{"depth":5}'

# Perf measurement on a simulated low-end client (overrides persist on the
# tab until you clear them — callers own restoration):
$B cdp Emulation.setCPUThrottlingRate '{"rate":4}'   # clear: '{"rate":1}'
$B cdp Network.emulateNetworkConditions '{"offline":false,"latency":150,"downloadThroughput":195000,"uploadThroughput":97500}'
# clear: '{"offline":false,"latency":0,"downloadThroughput":-1,"uploadThroughput":-1}'
```

허용된 방법을 발견하려면 `browse/src/cdp-allowlist.ts`을 읽어보십시오.

## `$B inspect` — CDP - CSS 검사관

```bash
$B inspect ".header"                # full rule cascade for the header
$B inspect ".header" --all          # include user-agent rules
$B inspect ".header" --history      # show modification history
```

특정성, 계산된 스타일, 박스 모델, (`--history`)을 통해 만든 CSS 수정을 통해 매 `$B style`를 반환합니다. `browse/src/cdp-inspector.ts`의 페이지당 지속 CDP 세션에 의해 구동됩니다.

### `$B ux-audit`

```bash
$B ux-audit
```

사이트 정체성, 내비게이션, 헤더(50개), 텍스트 블록, 인터랙티브 엘리먼트(200개) - 전체 HTML를 덤프하지 않고 행동 분석을위한 페이지 구조. 저렴한 적용지도에 대한 `/qa` 및 `/design-review`에 의해 사용됩니다.

---

## 성과

| 의 특징 | 첫 번째 호출 | 자주 묻는 질문 | 호출 당 텍스트 오버 헤드 |
|------|-----------|------------------|---------------------------|
| Chrome MCP | ~5s의 | ~2-5s(대) | ~2000 토큰 (schema + 프로토콜) |
| Playwright MCP | ~3s의 | ~1～3대 | ~1500 토큰 (schema + 프로토콜) |
| **gstack 검색** | **~3s의** | **~100-200ms의** | **0 토큰** (문서 stdout) |
| **gstack 검색 + 통합 기술** | **~3s의** | **~200ms의** | **0 토큰** (단일 기술 invocation) |

20개 이상의 브라우저 세션에서 MCP 도구는 30,000~40,000개의 토큰을 프로토콜로 나타낸다. gstack는 0을 태우고 있다. 공동화-스킬 경로는 단일 `$B skill run` 호출로 20개 세션을 진행한다.

### Why CLI over MCP

MCP는 원격 서비스에 잘 작동합니다. 로컬 브라우저 자동화를 위해 그것은 순수한 머리 위를 추가합니다:

- **Context 블라우스** - MCP 호출은 JSON schemas를 포함. 간단한
  "페이지 텍스트"는 10x보다 더 많은 컨텍스트 토큰을 요한다.
- **연결 fragility** — 지속 WebSocket/stdio 연결 하락
  그리고 재연결에 실패.
- **긴급한 추상** - Claude 이미 Bash 도구가 있습니다. CLI 그
  stdout에 인쇄는 가장 간단한 가능한 공용영역입니다.

gstack는 이 모든 것을 건너뛰고 있습니다. 이진을 컴파일했습니다. 일반 텍스트, 일반 텍스트를 밖으로. No 프로토콜. No schema. No 연결 관리.

---

## 멀티 워크스페이스

각 프로젝트 루트 (`git rev-parse --show-toplevel`를 통해 검출)는 daemon, 포트, 주 파일, 쿠키, 로그를 가져옵니다. No 크로스 워크스페이스 충돌.

| 작업 공간 | 국가 파일 | 의 특징 |
|-----------|-----------|------|
| `/code/project-a` | `/code/project-a/.gstack/browse.json` | 임의의 (10000–49151) |
| `/code/project-b` | `/code/project-b/.gstack/browse.json` | 임의의 (10000–49151) |

Browser-skills 3 계층 조회 워크는 프로젝트 → 글로벌 → 번들, 그래서 프로젝트 계층 기술 `/code/project-a/.gstack/browser-skills/foo/` 프로젝트 -a 내부 `~/.gstack/browser-skills/foo/`를 그림자.

---

## 환경 변수

| 변수 | Default | 의 특징 |
|----------|---------|-------------|
| `BROWSE_PORT` | 0 (왼쪽 10000–49151) | HTTP 서버의 고정 포트 (버그 오버라이드) |
| `BROWSE_IDLE_TIMEOUT` | 1800000 (30 분) | 릴러의 폐쇄 시간 아웃 ms |
| `BROWSE_STATE_FILE` | `.gstack/browse.json` | 국가 파일 경로. 그것의 부모 디어는 gstack가 그것을 소유할 때만 강화하는 소유자 전용 (0700)를 가져옵니다 — 공유한 끈적한 디어 (`/tmp`, `/var/tmp`), 외국 소유한 디어, symlinked 디어, 그리고 (근법의 밑에) 어떤 세계 쓸 수 있는 디어는 1 시간 경고로 좌로 멈춰집니다 (v1.72.0.0+) |
| `BROWSE_SERVER_SCRIPT` | 자동 감지 | `server.ts`에 경로 |
| `BROWSE_CDP_URL` | (none) | `channel:chrome`로 설정 |
| `BROWSE_CDP_PORT` | 0 | CDP 포트 (내부 사용) |
| `BROWSE_HEADLESS_SKIP` | 0 | Skip Chromium 출시 (테스트 하네스만) |
| `BROWSE_TUNNEL` | 0 | 이중 감속기 터널 아키텍처 활성화 (`NGROK_AUTHTOKEN` 필요) |
| `BROWSE_TUNNEL_LOCAL_ONLY` | 0 | 테스트 전용 - ngrok없이 로컬 리리스를 모두 결합 |
| `CHROMIUM_PROFILE` | unset | Explicit Chromium 프로필 디렉토리 (gbrowser의 gbd per-workspace에 의해 사용); 두 발사 및 프로파일 잠금 정리에 의해 수여 |
| `GSTACK_DISABLE_GPU` | unset | `off`로 설정하여 macOS headless GPU-taming 플래그 세트 (다윈에서 default에 의해 구동 GPU-공정 회전 중지)를 중지합니다. |
| `GSTACK_BROWSE_MAX_HTML_BYTES` | 52428800 (50MB) | `load-html` 크기 모자 |
| `GSTACK_SECURITY_OFF` | unset | 비상 살인 스위치 - 비활성화 ML 클래스터 |
| `GSTACK_STEALTH` | unset | `extended` (또한 레이어 C의 상단에 `1`/`true`)을 6개의 공격적인 패치 (WebGL spoof, faked 플러그인, mediaDevices)를 레이어 C. Actively 거짓말; 사이트가 깰 수 있습니다. |
| `GSTACK_CDP_STEALTH` | unset | `on`/`1`/`true`를 `--gstack-suppress-prepare-stack-trace` (gbrowser Pack 2/B11 C++ 패치에만 출력합니다; 재고 Chromium에 아무 op) |
| `GSTACK_GPU_VENDOR`, `GSTACK_GPU_RENDERER`, `GSTACK_GPU_CHIPSET` | unset | 퍼-설치 GPU spoof는 팩 1 WebGL/UA-CH C++ 패치에 넣었습니다. 호스트 프로파일에서 gbd로 설정하십시오. `--gstack-gpu-vendor` / `--gstack-gpu-renderer` / `--gstack-ua-model` cmdline 스위치로 방출됩니다. |
| `GSTACK_PLATFORM` | unset | Host 플랫폼 분류 (`MacARM`/`MacIntel` → `macOS`, `Win32` → `Windows`, `Linux*` → `Linux`) `--gstack-ua-platform`로 방출 |
| `GSTACK_HW_CONCURRENCY`, `GSTACK_DEVICE_MEMORY` | 호스트 프로필 (fallback 8) | 층 C에 의해 보고된 `hardwareConcurrency`/`deviceMemory`를 설치하고 노동자 neavigator C++ 헝겊 조각을 위한 `--gstack-hw-concurrency`/`--gstack-device-memory`로 방출하는 |

---

## 소스 맵

```
browse/
├── src/
│   ├── cli.ts                   # Thin client — reads state, sends HTTP, prints
│   ├── server.ts                # Bun HTTP daemon — routes commands, dual-listener
│   ├── browser-manager.ts       # Chromium lifecycle, tabs, ref map, crash detection
│   ├── port-allocator.ts        # Fixed 10000-49151 scan range for every long-lived listener (never port:0)
│   ├── xprotect-heal.ts         # macOS XProtect launch-kill classify + quarantine-clear + bounded reinstall
│   ├── socks-bridge.ts          # Local 127.0.0.1 SOCKS5 bridge that handles auth handshakes Chromium can't speak
│   ├── proxy-config.ts          # --proxy URL parsing + cred resolution (URL vs env, fail-fast on both)
│   ├── proxy-redact.ts          # Cred-redaction helper for any proxy URL surfaced to logs/errors
│   ├── xvfb.ts                  # Xvfb auto-spawn + orphan cleanup with PID + start-time validation
│   ├── stealth.ts               # Layer C: webdriver mask + window.chrome.* + Notification/Permissions + per-install hardware + toString proxy + automation-global sweep; buildGStackLaunchArgs (GSTACK_* cmdline switches); GSTACK_STEALTH=extended opt-in
│   ├── browse-client.ts         # Canonical SDK — what skills import as _lib/browse-client.ts
│   ├── snapshot.ts              # AX tree → @e/@c refs → Locator map; -D/-a/-C handling
│   ├── read-commands.ts         # Non-mutating: text, html, links, js, css, is, dialog, ...
│   ├── write-commands.ts        # Mutating: goto, click, fill, upload, dialog-accept, ...
│   ├── meta-commands.ts         # state, watch, inbox, frame, ux-audit, chain, diff, ...
│   ├── browser-skills.ts        # 3-tier walk + frontmatter parser + tombstones
│   ├── browser-skill-commands.ts # $B skill list/show/run/test/rm + spawnSkill
│   ├── browser-skill-write.ts   # D3 atomic stage/commit/discard helper for /skillify
│   ├── skill-token.ts           # mintSkillToken / revokeSkillToken (per-spawn, scoped)
│   ├── domain-skills.ts         # Per-site agent notes (state machine: quarantined→active→global)
│   ├── domain-skill-commands.ts # $B domain-skill save/list/show/edit/promote/rollback/rm
│   ├── cdp-allowlist.ts         # Deny-default CDP method allowlist
│   ├── cdp-bridge.ts            # CDP session lifecycle bridge
│   ├── cdp-commands.ts          # $B cdp dispatcher
│   ├── cdp-inspector.ts         # $B inspect — persistent CDP session per page
│   ├── activity.ts              # ActivityEntry, CircularBuffer, SSE subscribers, privacy filtering
│   ├── buffers.ts               # Console/network/dialog circular buffers (O(1) ring)
│   ├── tab-session.ts           # Per-tab session state (load-html replay, ref map scope)
│   ├── token-registry.ts        # Mint/validate/revoke for root + setup keys + scoped tokens
│   ├── sse-session-cookie.ts    # 30-min HttpOnly cookie for /activity/stream + /inspector/events
│   ├── pty-session-cookie.ts    # Separate scope: live Claude PTY auth
│   ├── tunnel-denial-log.ts     # ~/.gstack/security/attempts.jsonl writer (salted)
│   ├── path-security.ts         # validateOutputPath / validateReadPath / validateTempPath
│   ├── url-validation.ts        # URL safety checks for goto
│   ├── content-security.ts      # L1-L3: datamarking, hidden strip, ARIA, URL blocklist, envelopes
│   ├── security.ts              # L5 canary + L6 verdict combiner + thresholds
│   ├── security-classifier.ts   # L4 ML classifier (TestSavantAI, runs in the security sidecar)
│   ├── security-sidecar-entry.ts # Sidecar subprocess entrypoint hosting the ONNX classifier
│   ├── security-sidecar-client.ts # server.ts-side client that drives the sidecar
│   ├── terminal-agent.ts        # Side Panel Claude PTY manager (auth + lifecycle)
│   ├── sidebar-utils.ts         # Sidebar URL sanitization + helpers
│   ├── cookie-import-browser.ts # Decrypt + import cookies from real Chromium browsers
│   ├── cookie-picker-routes.ts  # HTTP routes for /cookie-picker/*
│   ├── cookie-picker-ui.ts      # Self-contained HTML/CSS/JS for cookie picker
│   ├── network-capture.ts       # Network request capture for $B network
│   ├── media-extract.ts         # Media element extraction for $B media
│   ├── project-slug.ts          # Project slug derivation for state paths
│   ├── error-handling.ts        # safeUnlink / safeKill / isProcessAlive
│   ├── platform.ts              # OS detection (macOS, Linux, Windows)
│   ├── telemetry.ts             # Anonymous opt-in usage telemetry
│   ├── find-browse.ts           # Locate running daemon or bootstrap
│   └── config.ts                # Config resolution (env / files)
├── test/                        # Integration tests + HTML fixtures
└── dist/
    └── browse                   # Compiled binary (~58MB, Bun --compile)

browser-skills/
└── hackernews-frontpage/        # Bundled reference skill
    ├── SKILL.md
    ├── script.ts
    ├── _lib/browse-client.ts
    ├── fixtures/hn-2026-04-26.html
    └── script.test.ts

scrape/SKILL.md.tmpl             # /scrape gstack skill — match-or-prototype entry point
skillify/SKILL.md.tmpl           # /skillify gstack skill — codify last /scrape into permanent skill
```

---

## 개발

## # 필수품

- [Bun](https://bun.sh/) v1.0+
- Playwright's Chromium (`bun install`에 의해 자동적으로 설치해)

## 빠른 시작

```bash
bun install                      # install deps + Playwright Chromium
bun test                         # all integration tests (~3s for browse-only)
bun run dev <cmd>                # run CLI from source (no compile)
bun run build                    # compile to browse/dist/browse
```

## Dev 모드 대 컴파일 된 바이너리

개발 중, 컴파일된 바이너리 대신 `bun run dev`를 사용합니다. Bun로 `browse/src/cli.ts`를 직접 실행하므로 즉각적인 피드백을 얻을 수 있습니다.

```bash
bun run dev goto https://example.com
bun run dev text
bun run dev snapshot -i
bun run dev click @e3
```

컴파일된 바이너리 (`bun run build`)는 배포에만 필요합니다. Bun의 `--compile` 플래그를 사용하여 `browse/dist/browse`에서 실행할 수 있는 단일 ~58MB를 생성합니다.

### Running tests

```bash
bun test                                    # all tests
bun test browse/test/commands               # command integration tests
bun test browse/test/snapshot               # snapshot tests
bun test browse/test/cookie-import-browser  # cookie import unit tests
bun test browse/test/browser-skill-write    # D3 atomic-write helper tests
bun test browse/test/tunnel-gate-unit       # canDispatchOverTunnel pure tests
```

테스트는 `browse/test/fixtures/`에서 HTML 정착물을 서 있는 HTTP 서버 (`browse/test/test-server.ts`)를, 그 페이지에 대하여 CLI를 운동하는 국부적으로 HTTP 서버 (`browse/test/test-server.ts`)를 위로 회전시킵니다.

### 새 명령 추가

1. `read-commands.ts` (비-mutating) 또는 `write-commands.ts`에서 핸들러 추가
   (mutating), 또는 `meta-commands.ts` (서버/생활주기).
2. `server.ts`의 경로 등록
3. Add the entry to `COMMAND_DESCRIPTIONS` in `browse/src/commands.ts` (with
   `description`와 `usage` - `gen-skill-docs` 유효성 검사장치는 no `|` 캐릭터를 `description`)에 적용합니다.
4. HTML 정착물을 가진 `browse/test/commands.test.ts`에 있는 시험 상자를 추가하십시오
   ..
5. `bun test`를 실행하여 확인을 합니다.
6. 컴파일하기 `bun run build`를 실행합니다.
7. `bun run gen:skill-docs`를 재생합니다. SKILL.md ( 명령은 나타납니다.
   명령 설정 테이블 다운스트림에서).

### 새 브라우저를 추가

손 쓰기 기술: 복사 `browser-skills/hackernews-frontpage/`, 업데이트 SKILL.md frontmatter, 다시 쓰기 `script.ts` 당신의 대상 사이트에 대하여, 재 캡처 정착물을 다시 캡처, 파서 테스트를 업데이트. `bun test` 유효 SKILL.md 계약 (SDK 바이트 ID, frontmatter schema).

에이전트-written 기술: 페이지를 한 번에 구동 `/scrape <intent>`, 말한다 `/skillify`, 승인 게이트에서 제안 된 이름을 받아들입니다. 테스트 패스 후 `~/.gstack/browser-skills/<name>/`의 기술 토지.

### 활성 기술에 배포

능동적 인 기술은 `~/.claude/skills/gstack/`에 생명을 불어 넣는다. 변경 후:

```bash
cd ~/.claude/skills/gstack
git fetch origin && git reset --hard origin/main
bun run build
```

또는 직접 바이너리를 복사:

```bash
cp browse/dist/browse ~/.claude/skills/gstack/browse/dist/browse
```

---

## 크로스 환경

- [`ARCHITECTURE.md`](ARCHITECTURE.md) — 체계 수준 건축, 이중 감속기 터널 디자인, 신속한 주입 방위 위협 모형
- [`CLAUDE.md`](CLAUDE.md) — 프로젝트 수준의 지침, 사이드바 아키텍처 노트, 보안 스택 제약
- [`docs/REMOTE_BROWSER_ACCESS.md`](docs/REMOTE_BROWSER_ACCESS.md) - `/pair-agent` (설정 키, scoped 토큰, denial 로그)에 대한 연산자 가이드
- [`docs/designs/BROWSER_SKILLS_V1.md`](docs/designs/BROWSER_SKILLS_V1.md) - 브라우저 스킬 런타임을 위한 디자인 문서 (상 1 + 2a + 로드맵)
- [`scrape/SKILL.md`](scrape/SKILL.md) — `/scrape` 기술: 일치 또는 prototype 자료 적출
- [`skillify/SKILL.md`](skillify/SKILL.md) — `/skillify` 기술: 영구 기술로 마지막 `/scrape`를 codify
- [`TODOS.md`](TODOS.md) — `/automate` (단계 2b P0), 단계 3개의 결산기 주입, 단계 4 eval + sandbox

---

## Acknowledgments의 특징

브라우저 자동화 레이어는 [Playwright](https://playwright.dev/) 에 Microsoft에 의해 내장되어 있습니다. Playwright의 접근성 트리 API 위치, 또는 시스템, headless Chromium 관리는 ref-based interactive를 가능하게 하는 것입니다. snapshot 시스템 - `@ref` 라벨을 AX 트리 노드로 할당하고 Playwright 로 다시 매핑합니다. Playwright의 primitives Playwright의 primitives>의 상단에 완전히 내장되어 있습니다. AX는 같은 팀에 대해 잘 구축해 주셔서 감사합니다.

L4 레이어는 [TestSavantAI/distilbert-v1.1-32](https://huggingface.co/TestSavantAI/distilbert-v1.1-32) (112MB ONNX)를 사용하며, `@huggingface/transformers`를 통해 로컬로 실행합니다.

CDP 탈출 해치는 allowlist가 직접 v1.4 디자인 패스 중 T2 외부 송장 검토에서 영감을 얻은 allowlist에 의해 문질러집니다: denylist와 비례 없는 allowlist를 가진 deny-default.
