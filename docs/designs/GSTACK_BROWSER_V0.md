# GStack 브라우저 V0 — AI-Native Development Browser

**일:** 2026-03-30 **저자:** Garry Tan + Claude Code **상태:** 단계 1a 발송해, 진행중인 단계 1b **주요 특징:** garrytan/gstack-as-browser

## Thesis의

다른 AI 브라우저 (Atlas, Dia, Comet, Chrome 자동 블로깅)는 소비자 브라우저와 볼트 AI로 시작합니다. GStack 브라우저가 이것을 몹니다. 그것은 Claude Code로 런타임으로 시작하고 브라우저 뷰포트를 제공합니다.

이 에이전트는 기본 시민입니다. 브라우저는 캔버스입니다. 기술은 일류 기능입니다. "AI 도움으로 브라우저를 사용하지 마십시오." 당신은 웹과 볼 수 있는 AI를 사용합니다.

IDE는 포스트 IDE 시대를 위해 IDE입니다. 코드는 맨끝에서 생활합니다. 제품은 브라우저에서 생활합니다. AI는 둘 다 동시에 작동합니다. Cursor는 원본 편집기를 위해, GStack 브라우저를 위해 했습니다.

## 오늘 (파워 1a 단계)

macOS .app 을 더블 클릭 Playwright 를 Chromium 으로 감싸는 gstack 사이드바 확장. 당신은 그것을 열고 Claude Code 를 볼 수 있습니다 당신의 화면을, 탐색 페이지, fill 모양, 스크린 샷을 찍고, CSS, 청소 오버레이를 검사하고, 어떤 gstack 기술을 실행하십시오. 맨끝을 만지기 없이 모두.

```
GStack Browser.app (389MB, 189MB DMG)
├── Compiled browse binary (58MB) — CLI + HTTP server
├── Chrome extension (172KB) — sidebar, activity feed, inspector
├── Playwright's Chromium (330MB) — the actual browser
└── Launcher script — binds project dir, sets env vars
```

시작 → Chromium는 sidebar → 확장 자동 연결으로 ~5 초에서 서버 → 에이전트을 찾아냅니다.

## 그것은 무슨 일

### 단계 1b: 개발자 UX (다음)

**명령 팔레트 (Cmd+K):** 서명 상호 작용. 퓨지 필터링 기술 선택기를 엽니다. QA 테스트를 시작하려면 QA를 입력하여 /ship를 디버깅하기 위해 "/ship"를 시작합니다. 기술은 검색 서버에서 태깅되어 하드 코딩되지 않습니다. 팔레트는 모든 항목에 항목 포인트입니다.

**빠른 스크린 샷 (Cmd + Shift + S) :** 현재 뷰포트를 캡처하고 "What do you see?" context와 사이드바 채팅으로 파이프를 캡처합니다. AI 스크린 샷을 분석하고 행동 가능한 피드백을 제공합니다. 1 개의 키 입력에 대한 비주얼 버그 보고서.

**상태 막대기:** 각 페이지의 하단에 지속 30px 바. 에이전트 상태 표시 (idle/thinking), workspace 이름, 현재 branch, 자동 감지 dev 서버. 탐색을 위해 dev 서버 알약을 클릭합니다. AI가 수행되는지에 대해 항상 접근 할 수 있습니다.

**Auto-Detect Dev Servers:** 시작에, 스캔 일반적인 포트 (3000, 3001, 4200, 5173, 5174, 8000, 8080). 정확히 하나의 서버가 발견되면 자동 -navigates to it. 한 클릭 전환을위한 상태 표시줄에 있는 서버 약을 개발하십시오.

### 2 단계: BoomLooper 통합

sidebar는 BoomLooper의 Phoenix/Elixir API로 로컬 `claude -p` 하위 처리 대신 연결됩니다. BoomLooper는 다음과 같습니다.

- **멀티 에이전트 관현.** Spawn 5 에이전트은 평행한, 각각에 그것의 자신의
  브라우저 탭. 하나의 실행 QA, 하나는 디자인 검토, 회귀를위한 하나의 시계.
- **Docker 인프라.** 각 에이전트는 격리 된 컨테이너를 가져옵니다. 브라우저
  컨테이너 내부는 dev 서버를 테스트합니다. No 포트 충돌, no 상태 누설.
- **세션 지속.** Agent 대화는 브라우저를 다시 시작한다.
  당신은 떨어져 있습니다.
- **팀 가시성.** 당신의 팀원은 당신의 에이전트이 무슨 일을 하는지 볼 수 있습니다
  실시간. 페어 프로그래밍처럼, 쌍은 5 AI 에이전트이며, 당신은 지휘자입니다.

### 단계 3: BoomLooper 도구로 찾아

검색 바이너리는 BoomLooper의 MCP 도구가 됩니다. Docker 컨테이너의 에이전트는 dev 서버 테스트 명령을 사용하여 스크린 샷을 찍고 fill 양식을 입력하고 배포를 확인합니다. Cross-platform 컴파일 (linux-arm64/x64)가 필요합니다.

### 단계 4: Chromium 포크 (건조한 가닥)

확장 측면 패널이 하드 API 제한을 보았을 때, GStack 브라우저는 외부 사용자에게 배를 제공, 인프라가 존재하고, 사업은 유지 보수를 촉진합니다. 포크 크롬. 브래브의 `chromium_src` 과도한 패턴, CC-powered 6-week rebases (2-4 시간 CC vs 1-2 주 인간). ~20-30 파일 수정.

### 단계 5: 본래 포탄

SwiftUI/AppKit 앱 쉘은 네이티브 사이드바, 분리된 Chromium 서비스. 전체 플랫폼 통합. Chromium 포크가 네이티브 사이드바를 포함하면 Phase 4에 의해 초소음 될 수 있습니다.

## 시각: AI 브라우저가 할 수 있는 것

##1. 당신이 본 것을 보십시오

브라우저는 AI의 눈입니다. 스크린 샷을 통해서도 (그것을 할 수 있는 것), 그러나 DOM 접근, CSS 검사, 네트워크 감시 및 접근가능성 나무 파싱을 통해서. AI는 단지 화소가 아닌 페이지 구조를 이해합니다.

**오늘:** `snapshot` 명령은 모든 페이지의 접근성tree 표현을 반환합니다. AI는 각 단추, 연결, 모양 분야 및 원본 성분을 볼 수 있습니다. 요소 참조 (`@e1`, `@e2`)는 AI click, fill, 상호 작용합니다.

**다음 :** 실시간 페이지 관측. AI는 페이지 변경이 되면 오류가 콘솔에 나타나면 네트워크 요청이 실패할 때 발생합니다. 요청하지 않고도 능동적 디버깅.

**미래:** 시각 이해. AI 앞에 비교합니다/after 스크린 샷은 시각 회귀를 잡기 위해. 픽셀 수준의 디자인 검토. "이 버튼은 왼쪽 3px로 이동하고 글꼴은 14px에서 13px로 변경했습니다."

##2. 그것이 무엇을 본 적법

페이지는 읽지 않지만, 인간 사용자와 같은 사람들과 상호 작용합니다.

**오늘:** 클릭, fill, 선택, hover, 유형, 스크롤, 업로드 파일, 핸들 대화, 탐색, 탭을 관리. 모든 검색 서버를 통해 간단한 명령을 통해.

**다음 :** 멀티 스텝 사용자 흐름. "로그인, 설정으로 이동, 시간대를 변경, 확인 메시지 확인." AI 체인은 각 단계에서 검증을 가진 명령을 나타냅니다.

**미래:** 자율 QA 에이전트. "이 페이지에 각 링크를 테스트합니다. 모든 양식을 작성하십시오. 그것을 깰 것을 시도하십시오." AI는 스크립트없이 배설 상호 작용 테스트를 실행합니다. 인간 테스터를 찾아서 인간이 생각하지 않도록 놓습니다.

##3. 검색하는 동안 코드 작성

이것은 키가 다르다. AI는 브라우저 AND에서 버그를 동시에 수정할 수 있습니다.

**오늘:** 사이드바 채팅은 Claude 코드에 연결됩니다. "이 버튼은 잘못 정렬되어 있습니다"라고 말하며 AI는 CSS를 읽고 문제를 식별하고 수정을 제안합니다. `/design-review` 기술은 스크린 샷을 식별하고 시각적 문제를 식별하고 이전 /after 증거와 수정을 투입합니다.

**다음 :** 라이브 리로드 루프. AI CSS/HTML, 브라우저 자동 리로드, AI는 수정을 시각화 정의합니다. No 간단한 시각 수정을위한 루프의 인간. "이 페이지에 모든 간격 문제가"은 30 초 작업이됩니다.

**미래:** 풀 스택 디버깅. AI는 브라우저에서 500 오류를 보고 서버 로그를 읽고, 실패 줄에 추적, 수정을 작성하고 브라우저에서 검증합니다. 한 명령: "이 페이지는 깨어납니다. 수정"

##4. 전체 스택에 대한 이해

브라우저는 뷰포트가 아닙니다. 응용 프로그램의 건강에 창이 됩니다.

**오늘:**
- 콘솔 로그 캡처 - 모든 `console.log`, `console.error`, 경고
- 네트워크 요청 모니터링 - 모든 XHR, fetch, websocket 및 정적 자산
- 성능 메트릭 - 핵심 웹 비틀, 리소스 타이밍, 페인트 이벤트
- 쿠키 및 저장 검사 — 읽기 및 쓰기 localStorage, sessionStorage
- CSS 검사 - computed 작풍, 상자 모형, 규칙 폭포

**다음 :**
- 네트워크 요청 재생 — "다른 params와이 실패 요청 재생"
- 성능 회귀 감지 - "이 페이지는 어제보다 200ms 느리게"
- Dependency Auditing — "이 페이지는 47 타사 스크립트를로드합니다"
- 접근성 감사 - "이 양식에는 no 라벨이 있으며이 색상은 대조가 실패합니다"

**미래:**
- 풀 애플리케이션 원격 측정 - CPU, Memory, GPU 실시간 사용
- Cross-browser 테스트 - Chrome, Firefox, Safari의 동일한 테스트 스위트
- 실제 사용자 모니터링 상관 — "이 버그는 생산 사용자의 12%에 영향을줍니다"

##5. 작업 공간 모델

브라우저 IS 작업 공간. 작업 공간에 탭이 아닙니다. 작업 공간 자체.

**오늘:** 각 브라우저 세션은 프로젝트 디렉토리에 바인딩됩니다. 사이드바는 현재 branch을 보여줍니다. 상태 표시 줄은 dev 서버를 감지했습니다.

**다음 :** 멀티 프로젝트 지원. 브라우저를 닫지 않고 프로젝트간에 전환. 각 프로젝트는 탭, 자체 에이전트, 자체 컨텍스트를 가져옵니다. VSCode 작업 공간처럼, 하지만 브라우저에.

**미래:** 팀 워크스페이스. 여러 개발자는 브라우저 작업 공간을 공유합니다. 서로의 에이전트 작업을 참조하십시오. 한 사람이 탐색하고 다른 시계가 실시간 AI 수정 된 것들을 볼 수 있는 협업 디버깅.

##6. 브라우저 능력으로 기술

gstack 기술이 브라우저 기능이 됩니다.

| 스킬 | 비밀번호 |
|-------|-------------------|
| `/qa` | 모든 페이지를 테스트, 버그를 발견, 수정, 수정 |
| `/design-review` | 스크린 샷 → 분석 → 수정 CSS → 스크린 샷 다시 |
| `/investigate` | 브라우저에서 오류를 보고 → 코드를 추적 → 수정 → 확인 |
| `/benchmark` | 측정 페이지 성능 → 회귀 → alert |
| `/canary` | 호스팅 배포 사이트 → 스크린 샷 정기 → 변경 경고 |
| `/ship` | 테스트 실행 → 검토 diff → PR → 브라우저에서 배포 확인 |
| `/cso` | XSS, 리디렉션, 클릭잭링을 위한 감사페이지 |
| `/office-hours` | 경쟁 사이트 → 관측 → 설계 doc 종합 |

명령 팔레트 (Cmd+K)는 허브입니다. 기술이 존재하는 것을 알 필요가 없습니다. 원하는 것을 입력하면, fuzzy 필터는 올바른 기술을 찾아 AI는 브라우저에서 컨텍스트로 실행합니다.

##7 디자인 루프

AI 전원 디자인은 손전등이 아닌 루프입니다.

```
Generate mockup (GPT Image API)
  → Review in browser (side-by-side with live site)
  → Iterate with feedback ("make the header taller")
  → Approve direction
  → Generate production HTML/CSS
  → Preview in browser
  → Fine-tune with /design-review
  → Ship
```

브라우저는 "Figma"와 "생산에서 보이는 것"과 "같은 것"과 같은 차이를 닫습니다. AI는 동시에 볼 수 있기 때문에.

##8 보안 루프

CSO 실제 브라우저에서 검토, 그냥 정적 분석.

- XSS를 입력 필드에 출력하면, 실행 중인 경우 체크
- 다른 origin에서 요청을 재생하여 CSRF를 테스트하십시오
- URL을 제작하는 navigating에 의해 리디렉션을 엽니 다
- CSP 헤더를 실제로 시행합니다. (현재는 아닙니다)
- 테스트 auth는 실시간 쿠키 및 토큰을 조작하여 흐름을
- iframe에서 사이트에로드하여 clickjacking을 확인

정적 분석은 패턴을 잡아. 브라우저 테스트는 현실을 잡습니다.

##9. 모니터링 루프

Post-deploy canary monitoring, 실제 브라우저에서.

```
Deploy → Browser loads production URL
  → Screenshot baseline
  → Every 5 minutes: screenshot, compare, check console
  → Alert on: visual regression, new console errors, performance drop
  → Auto-rollback if critical error detected
```

AI 판단과 합성 모니터링. "페이지 반환 200"을 무시하지만 "페이지가 오른쪽과 제대로 작동"

## 건축

```
+-------------------------------------------------------+
|                  GStack Browser                        |
|                                                        |
|  +------------------+  +---------------------------+  |
|  |   Chromium        |  |   Extension Side Panel    |  |
|  |   (Playwright)    |  |   ├── Chat (Claude Code)  |  |
|  |                   |  |   ├── Activity Feed        |  |
|  |   ┌────────────┐  |  |   ├── Element Refs         |  |
|  |   │ Status Bar  │  |  |   ├── CSS Inspector        |  |
|  |   └────────────┘  |  |   ├── Command Palette      |  |
|  +--------┬──────────+  |   └── Settings             |  |
|           │              +-------------┬--------------+  |
+-----------┼────────────────────────────┼─────────────────+
            │                            │
            v                            v
  +---------┴-----------+    +-----------┴-----------+
  |  Browse Server      |    |  Sidebar Agent        |
  |  (HTTP + SSE)       |    |  (claude -p wrapper)  |
  |  :34567             |    |  Runs gstack skills   |
  |                     |    |  Per-tab isolation     |
  |  Commands:          |    |                       |
  |  goto, click, fill  |    |  Future: BoomLooper   |
  |  snapshot, screenshot|   |  GenServer agents     |
  |  css, inspect, eval |    |                       |
  +---------┬-----------+    +-----------┬-----------+
            │                            │
            v                            v
  +---------┴-----------+    +-----------┴-----------+
  |  User's App         |    |  Claude Code          |
  |  localhost:3000     |    |  (reads/writes code)  |
  |  (or any URL)       |    |                       |
  +---------------------+    +-----------------------+
```

## 경쟁적인 조경

| Browser | 앱로치 | 의 특징 | 의약 |
|---------|----------|---------------|----------|
| **팟캐스트** | Chromium 포크 + AI 층 | Agentic browser, "OWL" 고립 된 Chromium | 소비자 중심, no 코드 통합 |
| **디아지오** | AI-native browser | Clean UI, built for AI interaction | No dev 도구, no 코드 편집 |
| **Comet** | AI 브라우저 | 멀티 에이전트 브라우징 | 초기, 삼촌 dev 워크플로우 |
| **Chrome 자동 블로깅** | 의 확장 | Google의 자체, 딥 Chrome 통합 | 확장자, no 코드 편집 |
| **Cursor** | VSCode 포크 + AI | Best-in-class 코드 편집 | No 브라우저 뷰포트 |
| **GStack 브라우저** | CC 런타임 + 브라우저 뷰포트 | 브라우저에서 버그를 보고, 코드에 수정, 확인 | 현재 macOS 전용, no 소비자 기능 |

GStack Browser는 소비자 브라우저와 경쟁하지 않습니다. 브라우저와 편집기 간의 전환 작업 흐름과 경쟁합니다. 목표는 보이지 않는 전환을 만드는 것입니다.

## 디자인 시스템

DESIGN.md에서:
- **1 차적인 악센트:** Amber-500 (#F59E0B) - 에이전트 활성, 초점 상태, 펄스
- **배경:** 아연 950 (#09090B) 아연-800 (#27272A) - 어둠, 밀도
- **전기:** JetBrains Mono (code/status), DM 산 (UI/labels)
- **국경 반경:** 8px (md), 12px (lg), 전체 (pills)
- **동작:** 펄스 애니메이션 에이전트 활성, 200ms 전환
- **모델 번호:** 사이드바 (right), 상태바 (바닥), 팔레트 (주로 오버레이)

## 구현 상태

| 제품정보 | Status | 참고 |
|-----------|--------|-------|
| .app 번들 | **SHIPPED** | 389MB, ~5s에서 출시 |
| DMG 포장 | **SHIPPED** | 189MB 압축 |
| `GSTACK_CHROMIUM_PATH` | **SHIPPED** | 사용자 정의 Chromium 바이너리 지원 |
| `BROWSE_EXTENSIONS_DIR` | **SHIPPED** | 확장 경로 override |
| `/health`를 통해 Auth | **SHIPPED** | .auth.json 파일 접근, 서버 재시작에 자동 재시작 |
| 스크립트 | **SHIPPED** | `scripts/build-app.sh` |
| 모형 routing | **SHIPPED** | 행동의 아들넷, 분석용 Opus (`pickSidebarModel`) |
| Debug 로깅 | **SHIPPED** | 40+ 침묵하는 캐치 → 4개의 파일에 의하여 접힌 콘솔 로깅 |
| No 요일 타임아웃 (headed) | **SHIPPED** | 브라우저는 창이 열리기 때문에 살아있다 |
| 쿠키 가져오기 버튼 | **SHIPPED** | 사이드바 풋거에서 클릭한 `/cookie-picker` |
| 사이드바 화살표 힌트 | **SHIPPED** | sidebar에 포인트, sidebar 실제로 열릴 때만 숨기십시오 |
| 건축 문서 | **SHIPPED** | `docs/designs/SIDEBAR_MESSAGE_FLOW.md` |
| 명령 팔레트 | 옵션 정보 | 단계 1b |
| 빠른 스크린 샷 | 옵션 정보 | 단계 1b |
| 상태 표시 | 옵션 정보 | 단계 1b |
| Dev 서버 탐지 | 옵션 정보 | 단계 1b |
| BoomLooper 통합 | Future | 단계 2 |
| 크로스 플랫폼 | Future | 3 단계 |
| Chromium 포크 | Trigger-gated를 덫을 놓으십시오 | 4 단계 |
| 기본 쉘 | 의제 | 5 단계 |

## 12개월 비전

```
TODAY (Phase 1)               6 MONTHS (Phase 2-3)          12 MONTHS (Phase 4-5)
─────────────                 ──────────────────            ────────────────────
macOS .app wrapper            BoomLooper multi-agent         Chromium fork OR
Extension sidebar             Docker containers              Native SwiftUI shell
Local claude -p agent         Team workspaces                Cross-platform
Single project                Linux/x64 browse               Auto-update
Manual skill invocation       Autonomous QA loops            Skill marketplace
                              Performance monitoring          Plugin API
                              Real-time collaboration         Enterprise features
```

12 개월 이상: GStack 브라우저를 열고, 프로젝트가 시작되며, dev 서버를 시작하며 테스트 스위트를 실행하고, 부서지는 것을 보고합니다. "fix it"와 AI는 각 버그를 수정하고, 각 수정을 시각화하고 PR를 생성합니다. 같은 브라우저에서 PR를 검토하고 AI는 그것을 배포하고 운하를 모니터링합니다. 모든 창에서.

AI workspace로 브라우저입니다. AI가 붙은 브라우저가 아닙니다. 브라우저가 켜져 있는 AI는 입니다.

## 리뷰 역사

이 계획은 4 리뷰를 통해 갔다 :

1. **CEO 리뷰** (`/plan-ceo-review`, SELECTIVE EXPANSION) - 9개의 범위 제안,
   3 허용 (Cmd+K, Cmd+Shift+S의 상태 막대기), 5개의 deferred, 1 건너뛰기
2. **디자인 리뷰** (`/plan-design-review`) - 점수 5/10 → 8/10, 9 디자인
   결정이 추가됨, 2개의 승인된 모조
3. **Eng 검토** (`/plan-eng-review`) - 4개의 문제점은, 0개의 긴요한 간격, 찾아냈습니다
   시험 계획 생성
4. **Codex 리뷰** (outside voice) - 9개의 결과, 3개의 중요한 간격 잡힌
   (서버 번들링, auth 파일 위치, 프로젝트 바인딩). 모든 해결.

Codex 리뷰는 3개의 실제 건축 격차를 기록했습니다. Cross-model 리뷰는 작동합니다.
