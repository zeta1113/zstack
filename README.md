# gstack

> "아마 12월 이후로는 코드 한 줄도 직접 친 적이 거의 없는 것 같습니다. 기본적으로 아주 큰 변화죠." — [Andrej Karpathy](https://fortune.com/2026/03/21/andrej-karpathy-openai-cofounder-ai-agents-coding-state-of-psychosis-openclaw/), No Priors 팟캐스트, 2026년 3월

Karpathy의 말을 듣고 나는 그 방법이 궁금해졌습니다. 한 사람이 어떻게 스무 명짜리 팀처럼 ship할 수 있을까요? Peter Steinberger는 AI 에이전트와 함께 [OpenClaw](https://github.com/openclaw/openclaw)를 거의 혼자 만들었고, GitHub star는 247K에 이릅니다. 변화는 이미 와 있습니다. 올바른 도구를 가진 1인 빌더는 전통적인 팀보다 더 빠르게 움직일 수 있습니다.

저는 [Garry Tan](https://x.com/garrytan), [Y Combinator](https://www.ycombinator.com/)의 President & CEO입니다. Coinbase, Instacart, Rippling 같은 수천 개의 스타트업이 차고에서 한두 명으로 시작하던 시절부터 함께 일했습니다. YC 이전에는 Palantir의 초기 eng/PM/designer 중 한 명이었고, Posterous를 공동 창업해 Twitter에 매각했으며, YC의 내부 소셜 네트워크인 Bookface를 만들었습니다.

**gstack는 내가 찾은 답입니다.** 나는 20년 동안 제품을 만들어 왔고, 지금은 그 어느 때보다 많은 제품을 ship하고 있습니다. 지난 60일 동안 YC를 풀타임으로 운영하면서도 파트타임으로 production service 3개와 feature 40개 이상을 ship했습니다. AI가 부풀리기 쉬운 raw LOC가 아니라 logical code change 기준으로 보면, 2026년 내 run rate는 **2013년 대비 약 810배**입니다(하루 logical line 11,417 vs 14). 4월 18일까지의 2026년 산출량만 해도 2013년 전체의 **240배**입니다. Bookface를 포함한 public/private `garrytan/*` repo 40개를 기준으로 측정했고, demo repo 하나는 제외했습니다. 중요한 것은 누가 타이핑했느냐가 아니라 무엇이 ship됐느냐입니다.

> LOC 비판자들이 raw line count가 AI 때문에 부풀 수 있다고 말하는 것은 맞습니다. 하지만 그 부풀림을 보정해도 내가 덜 생산적이라는 말은 틀렸습니다. 오히려 훨씬 더 생산적입니다. 전체 방법론, 한계, 재현 스크립트는 **[On the LOC Controversy](docs/ON_THE_LOC_CONTROVERSY.md)**에 있습니다.

**2026 — 현재까지 1,237 contributions:**

![GitHub contributions 2026 — 1,237 contributions, massive acceleration in Jan-Mar](docs/images/github-2026.png)

**2013 — YC에서 Bookface를 만들던 시절(772 contributions):**

![GitHub contributions 2013 — 772 contributions building Bookface at YC](docs/images/github-2013.png)

같은 사람. 다른 시대. 차이는 도구입니다.

**gstack는 내가 일하는 방식입니다.** Claude Code를 가상 엔지니어링 팀으로 바꿉니다. 제품을 다시 생각하는 CEO, 아키텍처를 잠그는 eng manager, AI slop을 잡아내는 designer, production bug를 찾는 reviewer, 실제 브라우저를 여는 QA lead, OWASP + STRIDE 감사를 수행하는 security officer, PR을 ship하는 release engineer까지 갖춘 팀입니다. 23개의 specialist와 8개의 power tool이 모두 slash command, Markdown, 무료 MIT 라이선스로 제공됩니다.

이것은 내 오픈소스 소프트웨어 공장입니다. 나는 매일 이것을 사용합니다. 이런 도구는 모두에게 열려 있어야 한다고 믿기 때문에 공유합니다.

Fork하고, 개선하고, 당신의 것으로 만드세요. 무료 오픈소스 소프트웨어를 싫어하고 싶다면 그래도 됩니다. 다만 먼저 한번 써 보길 바랍니다.

**누가 이를 쓰면 좋은가:**
- **창업자와 CEO** — 특히 직접 제품을 ship하고 싶은 기술 창업자
- **처음 Claude Code를 쓰는 사용자** — 빈 prompt 대신 구조화된 역할이 필요한 사람
- **Tech lead와 staff engineer** — 모든 PR에 엄격한 review, QA, release automation을 붙이고 싶은 사람

## 빠른 시작

1. gstack를 설치합니다(30초, 아래 참고).
2. `/office-hours`를 실행하고 무엇을 만들고 있는지 설명합니다.
3. 기능 아이디어가 생길 때마다 `/plan-ceo-review`를 실행합니다.
4. 변경이 있는 branch에서 `/review`를 실행합니다.
5. staging URL에 `/qa`를 실행합니다.
6. 여기까지만 해 보세요. 당신에게 맞는 도구인지 바로 알 수 있습니다.

## 설치 — 30초

**Requirements:** [Claude Code](https://docs.anthropic.com/en/docs/claude-code), [Git](https://git-scm.com/), [Bun](https://bun.sh/) v1.0+, [Node.js](https://nodejs.org/) (Windows only)

### Step 1: 내 머신에 설치

Claude Code를 열고 아래 내용을 붙여 넣으세요. 나머지는 Claude가 처리합니다.

> Install gstack: **`git clone --single-branch --depth 1 https://github.com/garrytan/gstack.git ~/.claude/skills/gstack && cd ~/.claude/skills/gstack && ./setup`**를 실행한 다음, CLAUDE.md에 "gstack" 섹션을 추가해 모든 web browsing에는 gstack의 /browse skill을 사용하고 mcp\_\_claude-in-chrome\_\_\* tool은 절대 사용하지 않도록 적어 주세요. 사용 가능한 skill 목록도 넣어 주세요: /office-hours, /plan-ceo-review, /plan-eng-review, /plan-design-review, /design-consultation, /design-shotgun, /design-html, /review, /ship, /land-and-deploy, /canary, /benchmark, /browse, /connect-chrome, /qa, /qa-only, /design-review, /setup-browser-cookies, /setup-deploy, /setup-gbrain, /retro, /investigate, /document-release, /document-generate, /codex, /cso, /autoplan, /plan-devex-review, /devex-review, /careful, /freeze, /guard, /unfreeze, /gstack-upgrade, /learn. 마지막으로 팀원도 사용할 수 있도록 현재 project에 gstack를 추가할지 사용자에게 물어봐 주세요.

### Step 2: 팀 모드 — 공유 repo 자동 업데이트(추천)

repo 안에서 아래 명령을 붙여 넣으세요. 팀 모드로 전환하고, 팀원들이 gstack를 자동으로 받을 수 있도록 repo를 bootstrap한 뒤 변경 사항을 commit합니다.

```bash
(cd ~/.claude/skills/gstack && ./setup --team) && ~/.claude/skills/gstack/bin/gstack-team-init required && git add .claude/ CLAUDE.md && git commit -m "require gstack for AI-assisted work"
```

repo 안에 vendored file을 넣지 않고, version drift도 없고, 수동 upgrade도 필요 없습니다. 모든 Claude Code session은 빠른 auto-update check로 시작합니다(시간당 한 번으로 제한, network failure safe, 완전히 silent).

팀원을 block하기보다 안내만 하고 싶다면 `required` 대신 `optional`을 사용하세요.

### OpenClaw

OpenClaw는 ACP를 통해 Claude Code session을 spawn하므로, Claude Code에 gstack만 설치되어 있으면 모든 gstack skill이 그대로 작동합니다. OpenClaw agent에 아래 내용을 붙여 넣으세요.

> Install gstack: `git clone --single-branch --depth 1 https://github.com/garrytan/gstack.git ~/.claude/skills/gstack && cd ~/.claude/skills/gstack && ./setup`를 실행해 Claude Code용 gstack를 설치하세요. 그런 다음 AGENTS.md에 "Coding Tasks" 섹션을 추가하고, coding 작업을 위해 Claude Code session을 spawn할 때 그 session에 gstack skill을 사용하라고 지시하세요. 예시는 다음과 같습니다: security audit: "Load gstack. Run /cso", code review: "Load gstack. Run /review", QA test a URL: "Load gstack. Run /qa https://...", build a feature end-to-end: "Load gstack. Run /autoplan, implement the plan, then run /ship", plan before building: "Load gstack. Run /office-hours then /autoplan. Save the plan, don't implement."

**설정 후에는 OpenClaw agent에게 자연스럽게 말하면 됩니다.**

| 이렇게 말하면 | 이렇게 동작합니다 |
|---------|-------------|
| "README의 오타를 고쳐줘" | 단순한 Claude Code session으로 처리, gstack 불필요 |
| "이 repo에 security audit을 돌려줘" | `Run /cso`로 Claude Code를 spawn |
| "notification feature를 만들어줘" | /autoplan → 구현 → /ship 흐름으로 Claude Code를 spawn |
| "v2 API redesign을 계획해줘" | /office-hours → /autoplan으로 Claude Code를 spawn하고 plan을 저장 |

고급 dispatch routing과 gstack-lite/gstack-full prompt template은 [docs/OPENCLAW.md](docs/OPENCLAW.md)를 참고하세요.

## Native OpenClaw Skills (ClawHub)

Claude Code session 없이 OpenClaw agent 안에서 직접 동작하는 4개의 methodology skill입니다. ClawHub에서 설치하세요.

```
clawhub install gstack-openclaw-office-hours gstack-openclaw-ceo-review gstack-openclaw-investigate gstack-openclaw-retro
```

| Skill | 역할 |
|-------|-------------|
| `gstack-openclaw-office-hours` | 6개의 forcing question으로 product interrogation 수행 |
| `gstack-openclaw-ceo-review` | 4개의 scope mode를 가진 strategic challenge |
| `gstack-openclaw-investigate` | root-cause debugging methodology |
| `gstack-openclaw-retro` | weekly engineering retrospective |

이들은 대화형 skill입니다. OpenClaw agent가 채팅을 통해 직접 실행합니다.

## 다른 AI Agent

gstack는 Claude뿐 아니라 10개의 AI coding agent에서 동작합니다. setup은 설치된 agent를 자동 감지합니다.

```bash
git clone --single-branch --depth 1 https://github.com/garrytan/gstack.git ~/gstack
cd ~/gstack && ./setup
```

또는 `./setup --host <name>`으로 특정 agent를 지정할 수 있습니다.

| Agent | Flag | 결과 |
|-------|------|--------------|
| OpenAI Codex CLI | `--host codex` | Full install → `${CODEX_HOME:-~/.codex}/skills/gstack-*/` |
| OpenCode | `--host opencode` | Full install → `~/.config/opencode/skills/gstack-*/` |
| Cursor | `--host cursor` | Full install → `~/.cursor/skills/gstack-*/` |
| Factory Droid | `--host factory` | Full install → `~/.factory/skills/gstack-*/` |
| Kiro | `--host kiro` | Full install → `~/.kiro/skills/gstack-*/` |
| Slate | `--host slate` | Claude install을 가리키는 pointer(Slate는 fallback으로 `.claude/skills`를 읽음) |
| OpenClaw | `--host openclaw` | ACP spawn pointer + `gen:skill-docs --host openclaw`로 생성되는 methodology artifact + 아래 instruction-only digest(전체 가이드: [docs/OPENCLAW.md](docs/OPENCLAW.md)) |
| Hermes | `--host hermes` | `gen:skill-docs --host hermes`로 생성되는 methodology artifact + 아래 instruction-only digest |
| GBrain (mod) | `--host gbrain` | GBrain repo에서 제공되는 brain-aware skill variant |

**Instruction-only tier(any rules-reading agent — Zed, Amp, Jules, side projects):** [`agents-digest/gstack-AGENTS.md`](agents-digest/gstack-AGENTS.md)의 2KB digest를 agent가 읽는 위치에 복사하세요. 예를 들어 project의 `AGENTS.md`에 붙이면 됩니다. 이 digest에는 gstack의 ethos, reuse ladder, voice rule이 담겨 있으며 설치는 필요 없습니다. 첫 줄에는 gstack version이 표시됩니다. upgrade 후에는 다시 복사하세요.

Codex의 경우 setup은 `${CODEX_HOME:-~/.codex}/config.toml`의 top-level `model`을 읽고 그에 맞는 behavior profile을 생성합니다. `gpt-5.6-sol`은 요청한 lake를 끝내되 주변 cleanup이나 speculative hardening으로 확장하지 않도록 하는 bounded-scope instruction을 자동으로 받습니다. Sol profile은 exact match만 적용됩니다. dated snapshot이나 다른 5.6 variant는 generic GPT profile을 받고, `gpt-5.6-sol-2026-08-01`처럼 비슷하지만 정확히 일치하지 않는 값에는 warning이 표시됩니다. `./setup --host codex --model <id>`로 감지를 override할 수 있지만 해당 실행에만 적용됩니다. upgrade 이후에도 유지하려면 Codex `config.toml`에 `model`을 설정하세요. Codex model을 바꾼 뒤에는 `./setup --host codex`를 다시 실행해 skill을 재생성하세요.

**다른 agent 지원을 추가하고 싶나요?** [docs/ADDING_A_HOST.md](docs/ADDING_A_HOST.md)를 참고하세요. TypeScript config file 하나면 충분하고, code change는 0입니다.

## 동작 예시

```
You:    내 캘린더용 일일 브리핑 앱을 만들고 싶어.
You:    /office-hours
Claude: [고통 지점을 묻습니다. 가설이 아니라 구체적인 사례를 요구합니다.]

You:    Google Calendar가 여러 개이고, 이벤트 정보는 오래됐고, 장소도 틀릴 때가 많아.
        준비에는 시간이 너무 오래 걸리는데 결과도 충분히 좋지 않아...

Claude: 그 프레이밍에는 조금 반대할게요. 당신은 "일일 브리핑 앱"이라고 했지만,
        실제로 설명한 것은 개인 chief of staff AI에 가깝습니다.
        [당신이 설명하고 있다는 사실을 몰랐던 capability 5가지를 추출합니다.]
        [전제 4가지를 검토합니다. 동의하거나, 반대하거나, 조정할 수 있습니다.]
        [예상 작업량과 함께 3가지 구현 접근법을 생성합니다.]
        RECOMMENDATION: 내일 가장 좁은 wedge부터 ship하고 실제 사용에서 배우세요.
        전체 비전은 3개월짜리 프로젝트입니다. 먼저 진짜로 작동하는 일일 브리핑부터 시작하세요.
        [design doc을 작성하고 downstream skill에 자동으로 전달합니다.]

You:    /plan-ceo-review
        [design doc을 읽고, scope를 검토하고, 10개 섹션 review를 실행합니다.]

You:    /plan-eng-review
        [data flow, state machine, error path를 ASCII diagram으로 정리합니다.]
        [test matrix, failure mode, security concern을 정리합니다.]

You:    plan 승인. plan mode 종료.
        [11개 파일에 2,400줄을 작성합니다. 약 8분.]

You:    /review
        [AUTO-FIXED] issue 2개. [ASK] race condition → 수정 승인.

You:    /qa https://staging.myapp.com
        [실제 브라우저를 열고 flow를 클릭하며 bug를 찾아 수정합니다.]

You:    /ship
        Tests: 42 → 51 (+9 new). PR: github.com/you/app/pull/42
```

사용자는 "daily briefing app"이라고 말했지만, agent는 "당신은 chief of staff AI를 만들고 있다"고 짚었습니다. feature request가 아니라 고통 지점을 들었기 때문입니다. 8개의 command로 end-to-end 흐름이 이어집니다. copilot이 아니라 team입니다.

## 스프린트

gstack는 도구 모음이 아니라 process입니다. skill은 sprint가 진행되는 순서대로 실행됩니다.

**Think → Plan → Build → Review → Test → Ship → Careful**

각 skill은 다음 skill의 입력이 됩니다. `/office-hours`는 `/plan-ceo-review`가 읽는 design doc을 작성합니다. `/plan-eng-review`는 `/qa`가 이어받는 test plan을 작성합니다. `/review`는 `/ship` 전에 고쳐야 할 bug를 잡습니다. 각 단계가 이전 단계의 결과를 알고 있기 때문에 빈틈이 줄어듭니다.

| Skill | 당신의 specialist | 하는 일 |
|-------|----------------|--------------|
| `/office-hours` | **YC Office Hours** | 여기서 시작하세요. 코드를 쓰기 전에 product를 다시 framing하는 6개의 forcing question입니다. framing에 pushback하고, premise를 challenge하며, implementation alternative를 생성합니다. design doc은 모든 downstream skill의 입력이 됩니다. |
| `/plan-ceo-review` | **CEO / Founder** | 문제를 다시 생각합니다. request 안에 숨어 있는 10-star product를 찾습니다. 4가지 mode: Expansion, Selective Expansion, Hold Scope, Reduction. |
| `/plan-eng-review` | **Eng Manager** | architecture, data flow, diagram, edge case, test를 잠급니다. 숨은 assumption을 밖으로 끌어냅니다. |
| `/plan-design-review` | **Senior Designer** | 각 design dimension을 0-10으로 평가하고, 10점짜리가 무엇인지 설명한 뒤 plan을 그 방향으로 수정합니다. AI slop detection 포함. design choice마다 AskUserQuestion 1개씩 사용하는 interactive 흐름입니다. |
| `/plan-devex-review` | **Developer Experience Lead** | plan-stage DX review입니다. developer persona를 탐색하고, competitor의 TTHW와 benchmark하며, magical moment를 설계하고, friction point를 단계별로 추적합니다. 3가지 mode: DX EXPANSION, DX POLISH, DX TRIAGE. 20-45개의 forcing question. |
| `/design-consultation` | **Design Partner** | scratch에서 완전한 design system을 만듭니다. landscape를 research하고, creative risk를 제안하며, realistic product mockup을 생성합니다. |
| `/review` | **Staff Engineer** | CI는 통과하지만 production에서 터질 bug를 찾습니다. 명백한 것은 auto-fix하고, completeness gap을 flag합니다. over-built code를 짚는 advisory simplification lens는 block하지도 auto-apply하지도 않습니다. |
| `/investigate` | **Debugger** | 체계적인 root-cause debugging입니다. Iron Law: 조사 없는 fix 금지. data flow를 추적하고, hypothesis를 테스트하며, fix 시도가 3번 실패하면 멈춥니다. |
| `/design-review` | **Designer Who Codes** | /plan-design-review와 같은 audit을 live site에 실행한 뒤 발견한 문제를 고칩니다. atomic commit과 before/after screenshot을 남깁니다. |
| `/devex-review` | **DX Tester** | live developer experience audit입니다. 실제 onboarding을 테스트합니다: docs 탐색, getting started flow 실행, TTHW 측정, error screenshot 캡처. `/plan-devex-review` 점수와 비교해 plan이 reality와 맞았는지 보여줍니다. |
| `/design-shotgun` | **Design Explorer** | "옵션을 보여줘" 모드입니다. 4-6개의 AI mockup variant를 만들고, browser에서 comparison board를 열어 feedback을 수집하며 iterate합니다. taste memory가 선호를 학습합니다. 마음에 드는 방향이 나올 때까지 반복한 뒤 `/design-html`로 넘깁니다. |
| `/design-html` | **Design Engineer** | mockup을 실제로 동작하는 production HTML로 바꿉니다. Pretext computed layout으로 text가 reflow되고, height가 content에 맞춰 조정되며, layout이 dynamic하게 유지됩니다. 30KB, zero deps. React/Svelte/Vue 감지. design type(landing page vs dashboard vs form)에 따른 smart API routing. output은 demo가 아니라 shippable artifact입니다. |
| `/qa` | **QA Lead** | app을 테스트하고 bug를 찾고, atomic commit으로 fix한 뒤 재검증합니다. 모든 fix에 regression test를 자동 생성합니다. |
| `/qa-only` | **QA Reporter** | /qa와 같은 methodology를 쓰지만 report만 작성합니다. code change 없는 순수 bug report가 필요할 때 사용합니다. |
| `/pair-agent` | **Multi-Agent Coordinator** | AI agent와 browser를 공유합니다. command 하나, paste 한 번, 연결 완료. OpenClaw, Hermes, Codex, Cursor, 또는 curl 가능한 어떤 agent와도 동작합니다. 각 agent는 자기 tab을 받습니다. headed mode를 자동 실행해 모든 동작을 볼 수 있게 하고, remote agent용 ngrok tunnel도 자동 시작합니다. scoped token, tab isolation, rate limiting, activity attribution 포함. |
| `/cso` | **Chief Security Officer** | OWASP Top 10 + STRIDE threat model입니다. zero-noise: 17개의 false positive exclusion, 8/10+ confidence gate, independent finding verification. 각 finding에는 구체적인 exploit scenario가 포함됩니다. |
| `/ship` | **Release Engineer** | main sync, test 실행, coverage audit, push, PR 생성. test framework가 없으면 bootstrap합니다. |
| `/land-and-deploy` | **Release Engineer** | PR을 merge하고 CI와 deploy를 기다린 뒤 production health를 검증합니다. "approved"에서 "verified in production"까지 command 하나로 진행됩니다. |
| `/canary` | **SRE** | post-deploy monitoring loop입니다. console error, performance regression, page failure를 감시합니다. |
| `/benchmark` | **Performance Engineer** | page load time, Core Web Vitals, resource size의 baseline을 잡습니다. 모든 PR에서 before/after를 비교합니다. |
| `/document-release` | **Technical Writer** | 방금 ship한 내용과 project docs를 맞춥니다. stale README를 자동으로 잡고, Diataxis coverage map(reference / how-to / tutorial / explanation)을 만들어 PR body에서 gap이 보이게 합니다. |
| `/document-generate` | **Documentation Author** | Diataxis framework로 누락된 docs를 scratch에서 생성합니다. 먼저 codebase를 research한 뒤 실제 code와 맞는 reference / how-to / tutorial / explanation docs를 작성합니다. standalone으로 실행하거나, coverage map이 gap을 찾을 때 `/document-release`에서 chain할 수 있습니다. 자세히: [tutorial](docs/tutorial-document-generate.md) • [how-to](docs/howto-document-a-shipped-feature.md) • [why Diataxis](docs/explanation-diataxis-in-gstack.md). |
| `/retro` | **Eng Manager** | team-aware weekly retro입니다. 사람별 breakdown, shipping streak, test health trend, growth opportunity를 봅니다. `/retro global`은 모든 project와 AI tool(Claude Code, Codex, Gemini)을 가로질러 실행됩니다. |
| `/browse` | **QA Engineer** | agent에게 눈을 줍니다. 실제 Chromium browser, 실제 click, 실제 screenshot. command당 약 100ms. `/open-gstack-browser`는 sidebar, anti-bot stealth, auto model routing이 포함된 GStack Browser를 실행합니다. |
| `/setup-browser-cookies` | **Session Manager** | 실제 browser(Chrome, Arc, Brave, Edge)에서 cookie를 가져와 headless session에 넣습니다. 인증이 필요한 page를 테스트할 수 있습니다. |
| `/autoplan` | **Review Pipeline** | command 하나로 완전히 review된 plan을 만듭니다. CEO → design → DX → eng review를 자동 실행합니다(eng가 항상 마지막이어서 shipping gate가 최종 수정 plan을 review). encoded decision principle로 대부분 자동 결정하고, taste decision만 approval용으로 보여줍니다. |
| `/spec` | **Spec Author** | 모호한 intent를 5단계(why, scope, mandatory code-reading이 포함된 technical section, draft, file)로 정확하고 실행 가능한 spec으로 바꿉니다. file 작성 전 Codex quality gate(7/10 미만 block), fail-closed secret redaction, existing issue dedupe, team-corpus recall용 `$GSTACK_STATE_ROOT/projects/$SLUG/specs/` archive 포함. `--execute`는 fresh worktree에서 `claude -p`를 spawn하고, `/ship`은 merge 시 source issue를 자동 close합니다. plan-mode aware. |
| `/learn` | **Memory** | gstack가 session 전반에서 학습한 것을 관리합니다. project-specific pattern, pitfall, preference를 review, search, prune, export합니다. learning은 session을 거듭하며 누적되어 codebase에 더 맞는 판단을 하게 해 줍니다. |
| `/make-pdf` | **Publisher** | Markdown을 publication-quality document로 만듭니다. Mermaid와 excalidraw fence는 vector diagram으로 render되고 완전히 offline입니다. image는 page에 맞게 scale되고 잘리지 않으며, wide diagram은 별도의 landscape page를 받습니다. `--to html`은 self-contained file을, `--to docx`는 Word doc을 생성합니다. |
| `/diagram` | **Diagram Maker** | English input을 editable diagram으로 바꿉니다. mermaid source, excalidraw.com에서 편집 가능한 `.excalidraw`(hand-drawn style), rendered SVG/PNG의 triplet을 출력합니다. 네트워크 없이 동작합니다. Markdown에 source를 embed하면 `/make-pdf`가 render합니다. |

### 어떤 review를 써야 하나요?

| 만들고 있는 것 | Plan stage(코드 작성 전) | Live audit(ship 후) |
|-----------------|--------------------------|----------------------------|
| **User-facing** (UI, web app, mobile) | `/plan-design-review` | `/design-review` |
| **Developer-facing** (API, CLI, SDK, docs) | `/plan-devex-review` | `/devex-review` |
| **Architecture** (data flow, perf, tests) | `/plan-eng-review` | `/review` |
| **위 전부** | `/autoplan` (CEO → design → DX → eng, 자동 scope detection, eng always last) | — |

## Power Tool

| Skill | 역할 |
|-------|-------------|
| `/codex` | **Second Opinion** — OpenAI Codex CLI의 independent code review입니다. 3가지 mode: review(pass/fail gate), adversarial challenge, open consultation. `/review`와 `/codex`가 모두 실행되면 cross-model analysis를 제공합니다. |
| `/careful` | **Safety Guardrails** — `rm -rf`, `DROP TABLE`, force-push 같은 destructive command 전에 경고합니다. "be careful"이라고 말하면 활성화됩니다. MEDIUM warning은 override할 수 있고, root/home recursive delete와 default-branch force-push는 hard deny됩니다. 일반 build cleanup은 whitelist됩니다. |
| `/freeze` | **Edit Lock** — file edit를 하나의 directory로 제한합니다. debugging 중 unrelated code를 실수로 고치는 일을 막습니다. |
| `/guard` | **Full Safety** — `/careful` + `/freeze`를 command 하나로 켭니다. prod 작업에 더 강한 안전장치가 필요할 때 사용합니다. |
| `/unfreeze` | **Unlock** — `/freeze` boundary를 제거합니다. |
| `/open-gstack-browser` | **GStack Browser** — sidebar, anti-bot stealth, auto model routing(action은 Sonnet, analysis는 Opus), one-click cookie import, Claude Code integration이 들어간 GStack Browser를 실행합니다. page 정리, smart screenshot, CSS edit, terminal로 정보 전달까지 지원합니다. |
| `/setup-deploy` | **Deploy Configurator** — `/land-and-deploy`를 위한 one-time setup입니다. platform, production URL, deploy command를 감지합니다. |
| `/setup-gbrain` | **GBrain Bootstrap** — 0에서 5분 안에 gbrain을 실행합니다. PGLite local, existing Supabase URL, management API를 통한 Supabase auto-provision을 지원합니다. Claude Code MCP 등록과 per-repo trust triad(read-write/read-only/deny) 포함. [관련 문서](USING_GBRAIN_WITH_GSTACK.md). |
| `/sync-gbrain` | **Keep Brain Current** — `gbrain sources add` + `gbrain sync --strategy code`로 이 repo의 code를 gbrain에 re-index하고, CLAUDE.md의 `## GBrain Search Guidance` section을 갱신합니다. capability check가 실패하면 stale guidance를 자동 제거합니다. `--incremental`(default), `--full`, `--dry-run`. idempotent라 재실행해도 안전합니다. |
| `/gstack-upgrade` | **Self-Updater** — gstack를 최신 version으로 upgrade합니다. global install과 vendored install을 감지하고 둘 다 sync하며 변경 내용을 보여줍니다. |
| `/ios-qa` | **iOS Live-Device QA (v1.43.0.0+)** — USB CoreDevice tunnel과 app에 내장된 `StateServer`로 실제 iPhone을 구동합니다. Swift source를 읽고 `@Observable` accessor를 codegen한 뒤 agent loop를 실행합니다. optional `--tailnet` flag를 사용하면 OpenClaw나 HTTP-capable agent가 물리 device를 직접 만지지 않고 iOS QA를 수행할 수 있습니다. capability allowlist(observe/interact/mutate/restore), short-lived token, audit log 포함. |
| `/ios-fix`, `/ios-design-review`, `/ios-clean`, `/ios-sync` | iOS bug fix loop, designer's-eye HIG audit, debug bridge cleanup, accessor regeneration입니다. 자세한 내용은 `docs/skills.md`를 참고하세요. 전체 walkthrough: [docs/howto-ios-testing-with-gstack.md](docs/howto-ios-testing-with-gstack.md). |

### Standalone CLI

slash-command skill 외에도, gstack는 session 안에 묶이지 않는 workflow용 standalone CLI를 제공합니다.

| Command | 역할 |
|---------|-------------|
| `gstack-model-benchmark` | **Cross-model benchmark** — Claude, GPT(Codex CLI), Gemini에 같은 prompt를 실행해 latency, token, cost, optional LLM-judged quality score를 비교합니다. provider별로 auth를 감지하고 사용 불가 provider는 깔끔하게 skip합니다. table, JSON, markdown으로 출력할 수 있습니다. `--dry-run`은 spend 없이 flag와 auth를 검증합니다. |
| `gstack-taste-update` | **Design taste learning** — `/design-shotgun`의 approval/rejection을 per-project taste profile에 기록합니다. 5%/week로 decay되며 future variant generation에 다시 feed되어 시스템이 실제 선호를 학습합니다. |
| `gstack-egress` | **Egress receipt audit** — gstack가 machine 밖으로 보내려는 모든 network send는 전송 전에 `~/.gstack/security/egress.jsonl`에 tamper-evident hash-chained receipt를 씁니다. `list`는 어떤 host로 무엇을 보내려 했는지, `grants`는 current consent setting을, `verify`는 hash chain을 재계산하고 tamper 시 exit 3으로 종료합니다. ledger 자체의 삭제나 truncate까지 막는 저장소는 아니며, network firewall이 아니라 audit trail입니다. |
| `gstack-context-bill` | **Token cost profiler** — read-only offline audit로, installed skill tree가 token 기준으로 얼마나 비싼지 계산합니다. always-on frontmatter, session마다 지불하는 per-invocation SKILL.md와 forced reference를 구분합니다. `--diff`는 두 tree를 비교하고, `--budget`은 ceiling을 강제하며, `--exact`는 Anthropic `count_tokens`를 사용합니다(file text가 off-machine으로 나가므로 egress receipt를 먼저 쓰고 불가능하면 local tokenizer로 graceful degrade). |
| `gstack-code-intelligence` | **Code-intelligence provider picker** — GBrain, Sourcebot, Graphify를 하나의 interface로 감쌉니다. `options`/`status`로 available provider를 보고, `select`로 고르고, `index`/`search`로 사용하며, `suggest`로 one-time indexing offer가 필요한지 확인합니다. large repo(1,000+ tracked files)에서 offer가 뜨며 decline은 저장됩니다. non-local provider는 per-repo consent(`consent <repo> yes\|no`) 없이는 index를 거부합니다. 완전히 opt-in이며 없으면 gstack는 grep으로 fallback합니다. |
| `gstack-verify-gate` | **Verification stop hook(opt-in)** — project의 declared verify command가 통과할 때까지 Claude Code turn 종료를 막습니다. 3번의 blocked re-entry 후에는 무한 loop 대신 여전히 RED라는 warning과 함께 양보합니다. CLAUDE.md 한 줄로 선언합니다: `<!-- gstack:verify: bun test -->`. hook은 permission system을 우회하므로 repo별로 한 번 trust해야 실행됩니다(`gstack-verify-gate --trust`). command를 수정하면 trust가 무효화되며 모든 grant는 audit log에 남습니다. |
| `gstack-wtree` | **Working-tree fingerprint** — disk에 실제 존재하는 content hash를 출력합니다. stat cache로 seed된 temp index를 사용해 full rehash보다 약 40배 저렴하며 tracked source만 보고 gitignored scratch는 보지 않습니다. commit, rebase, amend, squash를 거쳐도 같은 content는 같은 fingerprint를 가지므로 review/test evidence를 commit SHA가 아니라 content에 묶을 수 있습니다. |
| `gstack-evidence` | **Verification evidence ledger** — `run --label <lane> -- <cmd>`로 test command를 감싸고(exit code는 그대로 passthrough) `{command, exit, working-tree fingerprint, log path}`를 `~/.gstack/projects/<slug>/<branch>-evidence.jsonl`에 기록합니다. `check`는 `--expect-cmd`, `--max-age`, `--allow-paths` binding으로 각 label을 FRESH/STALE/MISSING으로 평가합니다. /ship과 /land-and-deploy는 test suite를 다시 돌리기 전에 fresh evidence를 먼저 확인합니다. |
| `gstack-issue-guard` | **Tracker-text trust envelope** — GitHub issue/PR text(`issue <n>`, `pr-body`, `pr-comments`, `--stdin`)를 가져와 labelled envelope에 감싸 data로 취급합니다. prompt-injection-looking line은 fullwidth/hidden passive voice obfuscation을 거쳐도 mark되고, forged envelope banner는 defuse됩니다. gstack를 통해 들어오는 모든 tracker source ingress는 이 scanner를 통과합니다. |
| `gstack-ios-qa-daemon` | **iOS QA daemon** — agent와 USB CoreDevice로 연결된 iPhone 사이의 Mac-side broker입니다. 기본은 loopback이고, `--tailnet`은 authenticated capability tier가 있는 Tailscale listener를 엽니다. `~/.gstack/ios-qa-daemon.pid`의 flock으로 single-instance를 유지합니다. [docs/howto-ios-testing-with-gstack.md](docs/howto-ios-testing-with-gstack.md)를 참고하세요. |
| `gstack-ios-qa-mint` | **iOS allowlist manager** — tailnet allowlist용 owner-granted CLI입니다. `grant`/`revoke`/`list`가 `~/.gstack/ios-qa-allowlist.json`(mode 0600)을 관리합니다. remote agent가 자동으로 allowance를 얻는 일은 없으며, 이 command가 explicit path입니다. |
| `gstack-ios-qa-regen` | **iOS bridge regenerator** — canonical DebugBridge package를 deterministic하게 설치하고, typed state accessor를 생성하며, 설치된 gstack version을 기록합니다. source 변경이나 upgrade 후 재실행할 수 있습니다. |

`./setup`은 `~/.claude/settings.json`에 `gstack-timeline-stop` hook도 등록합니다. dangling session timeline item을 세션 중단 시 정리하는 hook이며, fail-open으로 동작합니다(2초 내부 budget, 항상 exit 0, session을 block하지 않음). `./setup --no-timeline-stop-hook`로 비활성화할 수 있습니다. 선택 값은 `timeline_stop_hook` config key에 저장되어 upgrade 이후에도 유지됩니다. `no`는 live registration도 제거합니다. `GSTACK_TIMELINE_STOP_HOOK=no`와 `gstack-config set timeline_stop_hook no`도 동작합니다(flag > env > config). `./setup --no-team`은 그 run에서만 건너뛰고, `gstack-settings-hook remove-source --source gstack-timeline-stop`은 수동 제거, `gstack-uninstall`은 함께 제거합니다.

Hook registration은 canonical-only입니다. 모든 hook command는 실행한 tree가 아니라 안정적인 `~/.claude/skills/gstack`를 가리키므로 worktree나 Conductor workspace를 삭제해도 session이 망가지지 않습니다. 각 `./setup`은 먼저 heal을 수행합니다. `gstack-settings-hook prune-stale --repoint`가 dead gstack hook entry를 제거하고 stale entry를 stable install로 repoint하며 duplicate를 collapse한 뒤 한 줄을 출력합니다.

### Continuous Checkpoint Mode(선택, local default)

`gstack-config set checkpoint_mode continuous`를 설정하면 skill이 자동으로 구조화된 `[gstack-context]` body(summary, remaining work, failed approach)를 가진 `WIP:` commit을 만들도록 조정됩니다. crash와 context switch를 견딥니다. `/context-restore`는 그 commit을 읽어 session state를 재구성합니다. `/ship`은 PR 전에 WIP commit을 squash filter합니다(non-WIP commit은 보존되므로 cleanup이 필요하면 해야 합니다). push는 `checkpoint_push=true`로 opt-in입니다. default는 local-only라 각 WIP commit마다 CI를 trigger하지 않습니다.

## Domain Skill + Raw CDP Escape Hatch

두 개의 새 browser primitive는 시간이 갈수록 gstack agent를 더 강하게 만듭니다.

- **`$B domain-skill save`** — agent가 site-specific note(예: "LinkedIn의 apply button은 iframe 안에 있다")를 hostname에 저장해 자동으로 재사용합니다. Quarantined → successful use 3회 후 active → `$B domain-skill promote-to-global`로 optional cross-project promotion. 저장 수명은 `/learn`의 project learning file과 일치합니다. 전체 reference: **[docs/domain-skills.md](docs/domain-skills.md)**.
- **`$B cdp <Domain.method>`** — curated command가 놓치는 rare case를 위한 raw Chrome DevTools Protocol escape hatch입니다. deny-default이며, method는 `browse/src/cdp-allowlist.ts`에 명시적으로 추가되어야 합니다. two-layer mutex가 browser-scoped CDP call과 per-tab work를 직렬화합니다. data-exfil method의 출력은 UNTRUSTED envelope로 감쌉니다.

> rail도 allowlist도 daemon도 없는 raw CDP, 즉 agent에서 Chrome으로 가는 얇은 transport만 원한다면 [browser-use/browser-harness-js](https://github.com/browser-use/browser-harness-js)는 다른 철학(agent-authored helper vs gstack curated command)의 도구이며 잘 맞을 수 있습니다. 둘은 공존할 수 있습니다. gstack의 `$B cdp`와 harness 모두 Playwright의 `newCDPSession`으로 같은 Chrome에 attach할 수 있습니다.

**[각 skill의 예시와 철학을 담은 deep dive 보기 →](docs/skills.md)**

## Karpathy의 4가지 failure mode? 이미 커버합니다.

Andrej Karpathy의 [AI coding rule](https://github.com/forrestchang/andrej-karpathy-skills)(17K stars)은 네 가지 failure mode를 말합니다: 잘못된 assumption, over-eagerness, tangential edit, statement incompleteness. gstack workflow skill은 네 가지를 모두 강제합니다. `/office-hours`는 code가 작성되기 전에 assumption을 열어 둡니다. Confusion Protocol은 architecture decision에서 Claude가 추측하지 못하게 합니다. `/review`는 unnecessary complexity와 drive-by edit를 잡습니다. `/ship`은 test-first execution으로 task를 verifiable goal로 바꿉니다. 이미 Karpathy-style CLAUDE.md rule을 쓰고 있다면, gstack는 그것을 단일 prompt가 아니라 전체 sprint에 붙어 있게 만드는 workflow enforcement layer입니다.

## Parallel Sprint

gstack는 sprint 하나만 돌려도 강력합니다. 10개를 동시에 돌리면 완전히 다른 도구가 됩니다.

**design은 중심에 있습니다.** `/design-consultation`은 scratch에서 design system을 만들고, landscape를 research하고, creative risk를 제안하며, `DESIGN.md`를 씁니다. 하지만 진짜 힘은 shotgun-to-HTML pipeline입니다.

**`/design-shotgun`은 탐색 방식입니다.** 원하는 것을 설명하면 GPT Image로 4-6개의 AI mockup variant를 만들고 browser에서 side-by-side comparison board를 엽니다. 마음에 드는 방향을 고르고, "more whitespace", "bolder headline", "lose the gray" 같은 feedback을 남기고, 새 round를 생성합니다. 마음에 드는 결과가 나올 때까지 반복합니다. 몇 round가 지나면 memory가 실제 선호를 반영하기 시작합니다. 더 이상 vision을 말로 설명하고 AI가 알아듣기를 바라지 않아도 됩니다. option을 보고, 좋은 것을 고르고, 시각적으로 iterate합니다.

**`/design-html`은 그것을 실제로 만듭니다.** `/design-shotgun`, CEO plan, design review, 또는 단순 설명에서 나온 approved mockup을 production-quality HTML/CSS로 바꿉니다. 한 viewport width에서는 괜찮아 보이지만 나머지에서는 깨지는 AI HTML이 아닙니다. Pretext로 computed text layout을 사용합니다. text는 resize 시 실제로 reflow되고, height는 content에 맞춰 조정되며, layout은 dynamic합니다. overhead 30KB, zero dependency. project의 framework(React, Svelte, Vue)를 감지하고 알맞은 format으로 출력합니다. smart API routing은 landing page, dashboard, form, card layout 여부에 따라 다른 Pretext pattern을 고릅니다. output은 demo가 아니라 실제 ship할 수 있는 결과물입니다.

**`/qa`는 큰 unlock이었습니다.** 덕분에 parallel worker를 6개에서 12개로 늘릴 수 있었습니다. Claude Code가 *"문제를 봤다"*고 말한 뒤 실제로 fix하고, regression test를 만들고, fix를 검증하는 흐름은 내가 일하는 방식을 바꿨습니다. 이제 agent에게 눈이 있습니다.

**똑똑한 review routing.** 잘 운영되는 startup처럼 동작합니다. CEO가 infra bug fix를 볼 필요는 없고, backend change에 design review가 항상 필요한 것도 아닙니다. gstack는 어떤 review가 실행됐는지 추적하고, 무엇이 적절한지 판단해 똑똑하게 실행합니다. Review Readiness Dashboard는 ship하기 전에 현재 상태를 보여줍니다.

**모든 것을 테스트합니다.** `/ship`은 project에 test framework가 없으면 scratch에서 bootstrap합니다. 모든 `/ship` run은 coverage audit을 만듭니다. 모든 `/qa` bug fix는 regression test를 생성합니다. 목표는 100% test coverage입니다. test가 있어야 vibe coding이 yolo coding이 아니라 안전한 workflow가 됩니다.

**`/document-release`는 당신에게 없던 engineer입니다.** project의 모든 doc file을 읽고 diff와 cross-reference하여 drift된 내용을 업데이트합니다. README, ARCHITECTURE, CONTRIBUTING, CLAUDE.md, TODOS가 자동으로 최신 상태를 유지합니다. 이제 `/ship`이 자동으로 호출하므로 추가 command 없이 docs가 따라옵니다.

**실제 browser mode.** `/open-gstack-browser`는 anti-bot stealth, custom branding, sidebar extension이 포함된 AI-controlled Chromium인 GStack Browser를 실행합니다. Google과 NYTimes 같은 site도 captcha 없이 동작합니다. menu bar에는 "Chrome for Testing" 대신 "GStack Browser"가 표시됩니다. 일반 Chrome은 건드리지 않습니다. 기존 browse command는 그대로 동작합니다. `$B disconnect`는 headless로 돌아갑니다. browser window가 열려 있는 동안은 idle timeout으로 죽지 않습니다.

**Sidebar agent — AI browser assistant.** Chrome side panel에 자연어를 입력하면 child Claude instance가 실행합니다. "설정 page로 이동해서 screenshot을 찍어줘." "이 form을 test data로 채워줘." "이 list의 모든 item을 돌며 price를 추출해줘." sidebar는 task에 맞는 model로 자동 route합니다. click, navigate, screenshot 같은 빠른 action은 Sonnet, 읽기와 분석은 Opus를 사용합니다. task당 최대 5분입니다. sidebar agent는 isolated session에서 실행되므로 main Claude Code window를 방해하지 않습니다. sidebar footer에서 one-click cookie import도 가능합니다.

**개인 자동화.** sidebar agent는 dev workflow에만 쓰이지 않습니다. 예: "아이 학교 parent portal을 둘러보고 다른 학부모의 이름, 전화번호, 사진을 Google Contacts에 추가해줘." 인증 방법은 두 가지입니다. (1) headed browser에서 한 번 login하면 session이 유지됩니다. (2) sidebar footer의 "cookies" button으로 실제 Chrome의 cookie를 가져옵니다. 인증 후 Claude가 directory를 탐색하고 data를 추출해 contact를 생성합니다.

**Prompt injection 방어.** 적대적인 web page는 sidebar agent를 hijack하려고 합니다. gstack는 layered defense를 제공합니다. 모든 page read에 content filter(datamarking, hidden-element stripping, ARIA scrubbing, URL blocklist)를 적용하고, page-derived content가 agent에게 보이기 전에 local sidecar subprocess의 22MB ML classifier가 scan합니다. verdict combiner는 block 전에 classifier agreement를 요구해 Stack Overflow 스타일의 instruction page에서 생길 수 있는 single-model false positive를 줄입니다. 모든 것은 내 machine에서 실행되며 network call이 없습니다. emergency kill switch: `GSTACK_SECURITY_OFF=1`. 전체 구조는 [ARCHITECTURE.md](ARCHITECTURE.md#prompt-injection-defense-sidebar-agent)를 참고하세요.

**AI가 막혔을 때 browser handoff.** CAPTCHA, auth wall, MFA prompt에 걸렸나요? `$B handoff`는 모든 cookie와 tab 상태를 유지한 채 정확히 같은 page를 visible Chrome으로 엽니다. 문제를 해결하고 Claude에게 끝났다고 말하면 `$B resume`이 그 지점부터 계속합니다. browse tool이 3번 연속 실패하면 agent가 자동으로 handoff를 제안합니다.

**`/pair-agent`는 cross-agent coordination입니다.** Claude Code를 쓰고 있는데 OpenClaw도 실행 중이거나, Hermes 또는 Codex도 같은 website를 보게 하고 싶을 수 있습니다. `/pair-agent`를 입력하고 agent를 고르면 GStack Browser window가 열려 모든 동작을 볼 수 있습니다. skill이 instruction block을 출력하고, 그것을 다른 agent의 chat에 붙여 넣으면 됩니다. 다른 agent는 one-time setup key를 session token으로 교환하고, 자기 tab을 만들고, browsing을 시작합니다. 두 agent가 같은 browser에서 각자의 tab으로 일하는 모습을 볼 수 있고 서로 간섭할 수 없습니다. ngrok이 설치되어 있으면 tunnel이 자동으로 열려 다른 machine의 agent도 연결할 수 있습니다. 같은 machine의 agent는 credential을 직접 쓰는 zero-friction shortcut을 사용합니다. scoped token, tab isolation, rate limiting, domain restriction, activity attribution으로 서로 다른 vendor의 AI agent가 shared browser를 안전하게 조정할 수 있게 합니다.

**Multi-AI second opinion.** `/codex`는 OpenAI Codex CLI에서 independent review를 가져옵니다. 같은 diff를 완전히 다른 AI가 봅니다. 3가지 mode: pass/fail gate가 있는 code review, code를 적극적으로 깨 보려는 adversarial challenge, session continuity가 있는 open consultation. 같은 branch를 `/review`(Claude)와 `/codex`(OpenAI)가 모두 review하면 overlap finding과 각 model만 찾은 unique finding을 보여주는 cross-model analysis를 얻습니다.

**필요할 때 켜는 safety guardrail.** "be careful"이라고 말하면 `/careful`이 `rm -rf`, `DROP TABLE`, force-push, `git reset --hard` 같은 destructive command 전에 경고합니다. `/freeze`는 debugging 중 Claude가 unrelated code를 실수로 "fix"하지 못하도록 edit를 한 directory로 잠급니다. `/guard`는 둘 다 켭니다. `/investigate`는 조사 중인 module에 자동 freeze를 겁니다.

**Proactive skill 제안.** gstack는 brainstorming, reviewing, debugging, testing 중 어느 단계인지 파악하고 적절한 skill을 제안합니다. 마음에 들지 않으면 "stop suggesting"이라고 말하세요. session 전반에 기억합니다.

## 10-15 Parallel Sprint

gstack는 sprint 하나에서도 강력하지만, 동시에 10개를 돌릴 때 진짜로 변합니다.

[Conductor](https://conductor.build)는 여러 Claude Code session을 parallel로 실행합니다. 각 session은 독립된 workspace를 가집니다. 하나는 새 idea에 `/office-hours`를 돌리고, 다른 하나는 PR에 `/review`를 돌리고, 세 번째는 feature를 구현하고, 네 번째는 staging에서 `/qa`를 수행하며, 나머지 여섯 개는 다른 branch에서 돌아갑니다. 나는 정기적으로 10-15개의 parallel sprint를 실행합니다. 지금 기준으로는 그 정도가 실용적인 최대치입니다.

sprint structure가 parallelism을 가능하게 합니다. process 없이 agent 10개를 돌리면 chaos source가 10개 생길 뿐입니다. process가 있으면 think, plan, build, review, test, ship 순서에 따라 각 agent가 무엇을 해야 하고 언제 멈춰야 하는지 압니다. CEO가 team을 관리하듯 중요한 decision만 확인하고 나머지는 실행하게 두면 됩니다.

### Voice Input(AquaVoice, Whisper 등)

gstack skill에는 voice-friendly trigger phrase가 있습니다. "run a security check", "test the website", "do an engineering review"처럼 자연스럽게 말하면 알맞은 skill이 활성화됩니다. slash command 이름이나 약어를 외울 필요가 없습니다.

## Uninstall

### Option 1: uninstall script 실행

gstack가 내 machine에 설치되어 있다면:

```bash
~/.claude/skills/gstack/bin/gstack-uninstall
```

이 script는 skill, symlink, global state(`~/.gstack/`), project-local state, browse daemon, temp file을 정리합니다. config와 analytics를 보존하려면 `--keep-state`를 쓰고, 확인 prompt를 건너뛰려면 `--force`를 사용하세요.

### Option 2: 수동 제거(local repo 없음)

repo clone이 없다면(예: Claude Code paste로 설치한 뒤 clone을 삭제한 경우):

```bash
# 1. browse daemon 중지
pkill -f "gstack.*browse" 2>/dev/null || true

# 2. SKILL.md가 gstack/를 가리키는 skill directory 제거
#    (rmdir가 아니라 rm -rf 사용 — 설치 directory에는 runtime-asset link도 들어 있음)
find ~/.claude/skills -mindepth 1 -maxdepth 1 -type d ! -name gstack 2>/dev/null |
while IFS= read -r dir; do
  link="$dir/SKILL.md"
  [ -L "$link" ] || continue
  target=$(readlink "$link" 2>/dev/null) || continue
  case "$target" in
    gstack/*|*/gstack/*)
      rm -rf "$dir"
      ;;
  esac
done
# alias skill은 copy로 설치됨(symlink로 감지 불가) — 이름으로 제거
rm -rf ~/.claude/skills/_gstack-command ~/.claude/skills/connect-chrome 2>/dev/null

# 3. gstack 제거
rm -rf ~/.claude/skills/gstack

# 4. global state 제거
rm -rf ~/.gstack

# 5. integration 제거(설치하지 않은 것은 skip)
rm -rf "${CODEX_HOME:-$HOME/.codex}/skills/gstack"* 2>/dev/null
rm -rf ~/.factory/skills/gstack* 2>/dev/null
rm -rf ~/.kiro/skills/gstack* 2>/dev/null
rm -rf ~/.openclaw/skills/gstack* 2>/dev/null
rm -rf ~/.cursor/skills/gstack* 2>/dev/null
rm -rf ~/.config/opencode/skills/gstack* 2>/dev/null

# 6. temp file 제거
rm -f /tmp/gstack-* 2>/dev/null

# 7. project별 cleanup(각 project root에서 실행)
rm -rf .gstack .gstack-worktrees .claude/skills/gstack 2>/dev/null
rm -rf .agents/skills/gstack* .factory/skills/gstack* 2>/dev/null
```

수동 제거는 `~/.claude/settings.json`에 남은 gstack hook entry를 정리하지 않습니다. uninstall script는 `_gstack_source` tag가 제거된 entry까지 모두 지웁니다. 수동으로 지우려면 해당 file을 열어 command path가 `.claude/skills/gstack/`를 가리키는 hook을 모두 삭제하세요: SessionStart auto-update hook, AskUserQuestion PreToolUse/PostToolUse hook, Stop hook(session timeline과 opt-in verify-gate). 남겨 두면 install directory가 사라진 뒤 matching event마다 error가 납니다.

### CLAUDE.md 정리

uninstall script는 CLAUDE.md를 편집하지 않습니다. gstack가 추가된 각 project에서 `## gstack`와 `## Skill routing` section을 제거하세요.

### Playwright

`~/Library/Caches/ms-playwright/`(macOS)는 다른 tool이 공유할 수 있으므로 남겨 둡니다. 더 이상 필요 없다면 제거하세요.

---

무료, MIT licensed, open source. premium tier도 waitlist도 없습니다.

나는 내가 software를 만드는 방법을 open source했습니다. fork해서 당신만의 것으로 만들 수 있습니다.

> **We're hiring.** AI coding speed로 실제 product를 ship하고 gstack를 harden하는 일을 함께하고 싶나요?
> YC에서 함께 일하세요 — [ycombinator.com/software](https://ycombinator.com/software)
> 매우 경쟁력 있는 salary와 equity. San Francisco, Dogpatch District.

## GBrain — coding agent를 위한 persistent knowledge

[GBrain](https://github.com/garrytan/gbrain)은 AI agent를 위한 persistent knowledge base입니다. session 사이에 agent가 실제로 유지하는 memory라고 생각하면 됩니다. GStack는 0에서 "동작 중이고, 내 agent가 호출할 수 있다"까지 가는 one-command path를 제공합니다.

```bash
/setup-gbrain
```

네 가지 경로 중 하나를 고르면 됩니다.

- **Supabase, existing URL** — cloud agent가 이미 brain을 provision한 경우입니다. Session Pooler URL을 붙여 넣으면 이 laptop이 같은 data를 사용합니다.
- **Supabase, auto-provision** — Supabase Personal Access Token을 붙여 넣으면 skill이 새 project를 만들고, healthy 상태가 될 때까지 polling하고, pooler URL을 가져와 `gbrain init`에 넘깁니다. end-to-end 약 90초입니다.
- **PGLite local** — account도 network도 필요 없고 약 30초면 됩니다. 이 Mac에만 격리된 brain입니다. 먼저 시도해 보기 좋고, 나중에 `/setup-gbrain --switch`로 Supabase로 migrate할 수 있습니다.
- **Remote gbrain MCP** — brain이 다른 machine(Tailscale, ngrok, internal LAN)이나 teammate server에서 실행되는 경우입니다. MCP URL과 Bearer token을 붙여 넣습니다. split-engine mode에서 symbol-aware code search를 위해 local PGLite와 함께 쓸 수도 있습니다. local DB를 세우지 않고 cross-machine memory를 쓰기에 가장 좋습니다.

init 후에는 skill이 gbrain을 Claude Code의 MCP server로 등록할지 제안합니다(`claude mcp add gbrain -- gbrain serve`). 그러면 `gbrain search`, `gbrain put` 등이 bash shell-out이 아니라 first-class typed tool로 표시됩니다.

**brain을 최신 상태로 유지하기.** 어느 repo에서든 `/sync-gbrain`을 실행하면 그 code를 gbrain에 다시 index합니다. 기본은 incremental이고, 전체 reindex는 `--full`, preview는 `--dry-run`입니다. skill은 `gbrain sources add`로 cwd를 federated source로 등록하고 `gbrain sync --strategy code`를 실행한 뒤, project의 CLAUDE.md에 `## GBrain Search Guidance` block을 작성해 agent가 Grep보다 `gbrain search`/`code-def`/`code-refs`를 우선 사용하도록 안내합니다. capability check가 실패하면 block은 자동으로 제거되어, 설치되지 않은 tool을 가리키는 stale guidance가 남지 않습니다.

**Per-remote trust policy.** machine의 각 repo는 세 가지 tier 중 하나를 갖습니다.

- `read-write` — agent가 brain을 search할 수 있고 이 repo에서 새 page를 write할 수도 있습니다.
- `read-only` — agent가 search는 할 수 있지만 write는 하지 않습니다. multi-client consultant에게 좋습니다. shared brain을 검색하되 Client B repo에서 Client A 작업으로 오염시키지 않습니다.
- `deny` — gbrain interaction을 전혀 하지 않습니다.

skill은 repo마다 한 번만 묻습니다. decision은 같은 remote의 worktree와 branch 전반에서 sticky합니다.

**GStack memory sync(다른 기능, 같은 private-repo infra).** 선택적으로 gstack state(learnings, CEO plan, design doc, retro, developer profile)를 private git repo에 push해 machine을 옮겨도 memory가 따라오게 할 수 있습니다. one-time privacy prompt(everything allowlisted / artifacts only / off)와 defense-in-depth secret scanner가 있어 AWS key, token, PEM block, JWT가 machine 밖으로 나가기 전에 block합니다.

```bash
gstack-artifacts-init
```

**Conductor에서 gstack를 실행하나요?** Conductor는 각 workspace의 process env에서 `ANTHROPIC_API_KEY`와 `OPENAI_API_KEY`를 명시적으로 strip하므로, paid eval과 gbrain embedding은 기본 상태로 동작하지 않습니다. 대신 Conductor workspace env config에 `GSTACK_ANTHROPIC_API_KEY`와 `GSTACK_OPENAI_API_KEY`를 설정하세요. gstack의 TS entry point가 runtime에 canonical name으로 승격합니다. 자세한 내용과 새 entry point에 import를 추가할 때의 contributor checklist는 [Conductor + GSTACK_* env vars](USING_GBRAIN_WITH_GSTACK.md#conductor--gstack_-env-vars)를 참고하세요.

**Full monty — 모든 scenario, flag, bin helper, troubleshooting step:** [USING_GBRAIN_WITH_GSTACK.md](USING_GBRAIN_WITH_GSTACK.md)

추가 reference: [docs/gbrain-sync.md](docs/gbrain-sync.md)(sync-specific guide) • [docs/gbrain-sync-errors.md](docs/gbrain-sync-errors.md)(error index)

## Docs

| Doc | 다루는 내용 |
|-----|---------------|
| [Skill Deep Dives](docs/skills.md) | 각 skill의 철학, 예시, workflow(Greptile integration 포함) |
| [Diagrams & Document Formats](docs/howto-diagrams-and-formats.md) | PDF 안의 Mermaid/excalidraw fence, image sizing과 safety default, `--to html\|docx`, `/diagram` triplet |
| [Builder Ethos](ETHOS.md) | Builder philosophy: Boil the Ocean, Search Before Building, 세 가지 knowledge layer |
| [Using GBrain with GStack](USING_GBRAIN_WITH_GSTACK.md) | `/setup-gbrain`의 모든 path, flag, bin helper, troubleshooting step |
| [GBrain Sync](docs/gbrain-sync.md) | cross-machine memory setup, privacy mode, troubleshooting |
| [Architecture](ARCHITECTURE.md) | design decision과 system internal |
| [Browser Reference](BROWSER.md) | `/browse` 전체 command reference |
| [Contributing](CONTRIBUTING.md) | dev setup, testing, contributor mode, dev mode |
| [Changelog](CHANGELOG.md) | version별 변경 사항 |

## Privacy & Telemetry

gstack에는 project 개선을 위한 **opt-in** usage telemetry가 포함되어 있습니다. 정확히 이렇게 동작합니다.

- **기본값은 off입니다.** 명시적으로 동의하지 않으면 아무것도 전송하지 않습니다.
- **첫 실행 시** gstack가 anonymous usage data 공유 여부를 묻습니다. 거절할 수 있습니다.
- **전송되는 것(동의한 경우):** skill name, duration, success/fail, gstack version, OS. 여기까지입니다.
- **절대 전송하지 않는 것:** code, file path, repo name, branch name, prompt, user-generated content.
- **언제든 변경:** `gstack-config set telemetry off`로 즉시 비활성화할 수 있습니다.
- **machine 밖으로 나가는 모든 send는 receipt를 남깁니다.** telemetry를 포함해 gstack가 시작한 모든 network send는 전송 전에 `~/.gstack/security/egress.jsonl`에 hash-chained, tamper-evident receipt를 씁니다. receipt를 쓸 수 없으면 sensitive sink는 전송하지 않습니다. `gstack-egress list`로 audit하고, `gstack-egress verify`로 chain을 검증하며(tamper 시 exit 3), `gstack-egress grants`로 standing consent setting을 볼 수 있습니다. ledger는 attempted send를 기록해 사고를 audit 가능하게 만드는 장치입니다. network firewall은 아닙니다.

data는 [Supabase](https://supabase.com)(open source Firebase alternative)에 저장됩니다. schema는 [`supabase/migrations/`](supabase/migrations/)에 있어 무엇을 수집하는지 직접 확인할 수 있습니다. repo의 Supabase publishable key는 Firebase API key처럼 public key입니다. row-level security policy가 direct access를 모두 deny합니다. telemetry는 schema check, event type allowlist, field length limit을 강제하는 validated edge function을 통해 흐릅니다.

**Local analytics는 항상 사용할 수 있습니다.** `gstack-analytics`를 실행하면 local JSONL file에서 personal usage dashboard를 볼 수 있습니다. remote data는 필요 없습니다.

## Troubleshooting

**Skill이 보이지 않나요?** `cd ~/.claude/skills/gstack && ./setup`

**`/browse`가 실패하나요?** `cd ~/.claude/skills/gstack && bun install && bun run build`

**Stale install인가요?** `/gstack-upgrade`를 실행하거나 `~/.gstack/config.yaml`에 `auto_upgrade: true`를 설정하세요.

**더 짧은 command를 원하나요?** `cd ~/.claude/skills/gstack && ./setup --no-prefix` — `/gstack-qa`에서 `/qa`로 전환합니다. 선택은 future upgrade에도 기억됩니다.

**Namespaced command를 원하나요?** `cd ~/.claude/skills/gstack && ./setup --prefix` — `/qa`에서 `/gstack-qa`로 전환합니다. 다른 skill pack과 함께 쓸 때 유용합니다.

**Codex가 "Skipped loading skill(s) due to invalid SKILL.md"라고 하나요?** Codex skill description이 stale입니다. 해결: `cd "${CODEX_HOME:-$HOME/.codex}/skills/gstack" && git pull && ./setup --host codex` — repo-local install의 경우: `cd "$(readlink -f .agents/skills/gstack)" && git pull && ./setup --host codex`

**Windows 사용자:** gstack는 Windows 11에서 Git Bash 또는 WSL을 통해 동작합니다. Bun 외에 Node.js가 필요합니다. Bun에는 Windows에서 Playwright pipe transport와 관련된 알려진 bug가 있습니다([bun#4253](https://github.com/oven-sh/bun/issues/4253)). browse server는 자동으로 Node.js로 fallback합니다. `bun`과 `node`가 모두 `PATH`에 있는지 확인하세요.

Developer Mode가 없는 Windows(MSYS2 / Git Bash)에서는 `ln -snf`가 `git pull` 후 refresh되지 않는 frozen copy를 만들 수 있어, `setup`이 symlink 대신 file copy로 fallback합니다. **`git pull` 후에는 매번 `cd ~/.claude/skills/gstack && ./setup`를 다시 실행하세요.** 그래야 skill file이 repo와 맞습니다. `setup`은 이를 알려주는 one-line note를 출력합니다. Unix와 WSL은 symlink를 유지하므로 재실행이 필요 없습니다.

**Claude가 skill을 볼 수 없나요?** project의 `CLAUDE.md`에 gstack section이 있는지 확인하세요. 아래 내용을 추가하면 됩니다.

```
## gstack
Use /browse from gstack for all web browsing. Never use mcp__claude-in-chrome__* tools.
Available skills: /office-hours, /plan-ceo-review, /plan-eng-review, /plan-design-review,
/design-consultation, /design-shotgun, /design-html, /review, /ship, /land-and-deploy,
/canary, /benchmark, /browse, /open-gstack-browser, /qa, /qa-only, /design-review,
/setup-browser-cookies, /setup-deploy, /setup-gbrain, /sync-gbrain, /retro, /investigate,
/document-release, /document-generate, /codex, /cso, /autoplan, /pair-agent, /careful, /freeze,
/guard, /unfreeze, /gstack-upgrade, /learn.
```

## License

MIT. 영원히 무료입니다. 무언가를 만들어 보세요.
