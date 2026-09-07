# gstack — AI 엔지니어링 워크플로

gstack는 소프트웨어 개발을 위한 AI 에이전트 구조화된 역할을 주는 SKILL.md 파일의 수집입니다. 각 기술은 전문가입니다: CEO 검토자, eng 매니저, 디자이너, QA 지도, 방출 엔지니어, 디버거 및 더 많은 것.

## 사용 가능한 기술

`.agents/skills/` (또는 Claude Code)에서 라이브 스킬. 이름을 입력하면 (예를 들어, `/office-hours`).

### 플랜 모드 리뷰

| 스킬 | 역할 |
|-------|-------------|
| `/office-hours` | 여기 시작. 코드를 작성하기 전에 제품 아이디어를 재프레임. |
| `/plan-ceo-review` | CEO-level review: 요청시 10성급 제품을 찾습니다. |
| `/plan-eng-review` | 건축, 데이터 흐름, 가장자리 케이스 및 테스트 잠금. |
| `/plan-design-review` | 각 디자인 치수 0-10의 비율은 10처럼 보이는 것을 설명합니다. |
| `/plan-devex-review` | DX-mode review: TTHW, 마법의 순간, 마찰점, 사람 추적. |
| `/plan-tune` | 각자 두건 AskUserQuestion 질문 당 감도. |
| `/autoplan` | 하나의 명령은 CEO → 디자인 → DX → eng 검토 (여기서 항상 지속)를 실행합니다. |
| `/design-consultation` | 찰상에서 완벽한 디자인 시스템을 구축하십시오. |
| `/spec` | vague는 5 단계에서 정확하고 실행 가능한 spec로 의도합니다. GitHub 문제, 선택적으로 신선한 worktree에 Claude Code 에이전트을 스파게 되며, `/ship`가 병합에 소스 이슈를 닫습니다. |

### 구현 + 리뷰

| 스킬 | 역할 |
|-------|-------------|
| `/review` | Pre-landing PR 리뷰. CI를 통과하는 버그를 찾아서 prod에 끊습니다. |
| `/codex` | OpenAI Codex. 검토, 도전, 또는 모드를 통해 두 번째 의견. |
| `/investigate` | 디버깅을 하는 체계적인 뿌리 . No 조사 없이 수정. |
| `/design-review` | 실시간 시력 감사 + 임팩트와 루프 수정. |
| `/design-shotgun` | 여러 AI 디자인 변형, 비교 보드, iterate를 생성한다. |
| `/design-html` | 생산 품질 Pretext-native HTML/CSS를 생성하십시오. |
| `/devex-review` | 실시간 개발자 경험 감사 (TTHW 실제 흐름에 대해 측정). |
| `/qa` | 실제 브라우저를 열고 버그를 찾아 수정, 수정, 다시 수정. |
| `/qa-only` | /qa와 같은 방법론은, no 코드 변경만 보고한다. |
| `/scrape` | 웹페이지에서 데이터를 잡아라. 먼저 호출 시제품; codified call은 ~200ms에서 실행됩니다. |
| `/skillify` | 최근 성공 `/scrape`는 영구 브라우저-skill로 흐릅니다. |

### 릴리즈 + 배포

| 스킬 | 역할 |
|-------|-------------|
| `/ship` | 테스트, 검토, push, PR를 엽니다. Workspace-aware version queue. |
| `/land-and-deploy` | PR를 Merge, CI를 기다립니다. |
| `/canary` | 검색 daemon을 사용하여 포스트 배포 모니터링 루프. |
| `/landing-report` | workspace-aware ship queue에 대한 읽기 전용 대시보드. |
| `/document-release` | 배송된 것을 일치하는 모든 docs를 업데이트하십시오. |
| `/document-generate` | 코드에서 Diataxis docs (tutorial/how-to/ reference/Description)를 생성한다. |
| `/setup-deploy` | 1회 배포 config 검출 (Fly.io, Render, Vercel, 등). |
| `/gstack-upgrade` | 최신 버전으로 gstack를 업데이트합니다. |

## 운영 + 메모리

| 스킬 | 역할 |
|-------|-------------|
| `/context-save` | 작업 맥락 저장 (git state, decisions, 남은 작업). |
| `/context-restore` | 저장된 컨텍스트에서 이력서, 도도체 작업 공간. |
| `/learn` | 세션을 통해 gstack가 배운 것을 관리합니다. |
| `/retro` | 주간 복고풍과 1인 고장 및 배송 streaks. |
| `/health` | 코드 품질 대시보드 (유형 검수기, linter, test, dead code). |
| `/benchmark` | 성능 회귀 검출 (페이지 부하, 핵심 웹 비틀). |
| `/benchmark-models` | 기술에 대한 크로스 모델 벤치 마크 (Claude, GPT, Gemini 측 측). |
| `/cso` | OWASP 상위 10 + STRIDE 보안 감사. |
| `/setup-gbrain` | 크로스 머신 세션 메모리 동기화를 위한 gbrain를 설정합니다. |
| `/sync-gbrain` | 이 repo의 코드를 가진 gbrain 현재를 지키십시오; CLAUDE.md에 있는 에이전트 검색 지도를 상쾌하게 합니다. |

## Browser + 에이전트 통합

| 스킬 | 역할 |
|-------|-------------|
| `/browse` | Headless 브라우저 — 실제 Chromium, 실제 클릭, ~100ms/command. |
| `/open-gstack-browser` | sidebar + 훔치는과 함께 GStack 브라우저를 실행합니다. |
| `/setup-browser-cookies` | 실제 브라우저에서 쿠키를 가져가 인증된 테스트를 위한. |
| `/pair-agent` | 브라우저를 사용하여 AI 에이전트 (OpenClaw, Codex, 등)를 페어링합니다. |

## iOS QA - USB 또는 Tailscale (v1.43.0.0+)에 실제 iPhone을 구동

| 스킬 | 역할 |
|-------|-------------|
| `/ios-qa` | USB CoreDevice tunnel + Embedded StateServer를 통해 라이브 디바이스 iOS QA를 통해 라이브 디바이스를 노출시켜서 원격 에이전트를 구동할 수 있습니다. |
| `/ios-fix` | 회귀 snapshot 캡처를 가진 자율 iOS 버그 수정자. |
| `/ios-design-review` | 디자이너의 눈 QA 실제 아이폰에서 - 10 디멘션 애플 HIG 루비. |
| `/ios-clean` | 편의성: 스트립 디버그브릿지 + #if DEBUG 릴리스 빌드 전에 배선. |
| `/ios-sync` | 최신 업스트림 템플릿에 대한 iOS 디버그 브리지를 재생합니다. |

Companion CLIs (장치에 플러그를 붙여 넣는 Mac에서 실행):

| Command | 역할 |
|---------|-------------|
| `gstack-ios-qa-daemon` | Mac-side Broker. default; `--tailnet`는 기능 계층과 감사 로깅을 가진 스태킹 청취자를 추가합니다. |
| `gstack-ios-qa-mint` | tailnet allowlist (`grant`/`revoke`/`list`)를 위한 소유자 과립 CLI. |
| `gstack-ios-qa-regen` | canonical Local DebugBridge 패키지와 타입의 accessors(`--app-source` / `--bridge-dir`)를 재생합니다. |

끝 최후의 연습: [docs/howto-ios-testing-with-gstack.md](docs/howto-ios-testing-with-gstack.md).

### 안전 + 득점

| 스킬 | 역할 |
|-------|-------------|
| `/careful` | 파동 명령 전의 Warn (rm -rf, DROP TABLE, 강제 푸시). |
| `/freeze` | 한 디렉토리에 편집을 잠그십시오. 하드 블록, 경고가 아닙니다. |
| `/guard` | 두 주의깊게 활성화 + 한 번에 동결. |
| `/unfreeze` | 디렉토리 편집 제한 제거. |
| `/make-pdf` | 출판 품질 PDF로 모든 마크다운 파일을 켭니다. |
| `/diagram` | 영어, 외출: mermaid 소스 + 편집 가능 .excalidraw + SVG/PNG, 오프라인. |

## 빌드 명령

```bash
bun install              # install dependencies
bun run test             # run free tests via the strict shard runner (no API spend, ~90-100s)
bun run test:windows     # curated Windows-safe subset (runs on windows-latest)
bun run build            # generate docs + compile binaries
bun run gen:skill-docs   # regenerate SKILL.md files from templates
bun run skill:check      # health dashboard for all skills
```

## 플랫폼 지원

- **macOS** + **Linux**: 지원되는 가득 차있는 시험 스위트.
- **Windows**: curated Windows 안전 잠수함은 `windows-latest`에서 뛰기
  `windows-free-tests` CI 일. 설정 스크립트 (`./setup`)는 Git Bash 또는 MSYS 오늘; 기본 PowerShell 지원은 미래 확장입니다. `bin/gstack-paths` 돕는 사람은 `CLAUDE_PLUGIN_DATA`/ `GSTACK_HOME`를 통해서 국가 뿌리를 해결합니다 그래서 각 플랫폼에 일을 설치합니다.

## 키 컨벤션

- SKILL.md 파일은 `.tmpl` 템플릿에서 **제품정보**입니다. 템플릿을 편집하고 출력하지 않습니다.
- Codex-specific output을 재생하기 위해 `bun run gen:skill-docs --host codex`를 실행합니다.
- 검색 바이너리는 headless 브라우저 액세스를 제공합니다. `$B <command>`를 사용하세요.
- 안전 기술 (보건, 동결, 가드) 사용 인라인 자문가 prose — 항상 파괴적인 가동의 앞에 확인합니다.
- `bin/gstack-paths` (`eval "$(...)"`를 통해 자원)를 통해 해결되는 국가 경로. 명예 `GSTACK_HOME`, `CLAUDE_PLUGIN_DATA`, `CLAUDE_PLANS_DIR`.
- `claude` CLI 이진은 `browse/src/claude-bin.ts` (`Bun.which()` + `GSTACK_CLAUDE_BIN` override)를 통해 해결합니다. `GSTACK_CLAUDE_BIN=wsl` 플러스 `GSTACK_CLAUDE_BIN_ARGS='["claude"]'`를 Windows에서 WSL를 통해 Claude를 실행하기 위하여 놓으십시오.
