# Skill Deep Dives

gstack skill 각각의 철학, workflow, 예시를 설명하는 자세한 가이드입니다.

| Skill | 당신의 specialist | 하는 일 |
|-------|----------------|--------------|
| [`/office-hours`](#office-hours) | **YC Office Hours** | 여기서 시작합니다. 코드를 쓰기 전에 product를 다시 framing하는 6개의 forcing question을 던집니다. framing에 pushback하고, premise를 challenge하며, implementation alternative를 생성합니다. design doc은 모든 downstream skill의 입력이 됩니다. |
| [`/spec`](#spec) | **Spec Author** | 모호한 intent를 5단계로 정확하고 실행 가능한 spec으로 바꿉니다. downstream skill이 이어받을 수 있는 backlog-ready output을 만들고, 끝에서 optional agent spawn도 지원합니다. |
| [`/plan-ceo-review`](#plan-ceo-review) | **CEO / Founder** | 문제를 다시 생각합니다. request 안에 숨어 있는 10-star product를 찾습니다. Expansion, Selective Expansion, Hold Scope, Reduction 네 가지 mode가 있습니다. |
| [`/plan-eng-review`](#plan-eng-review) | **Eng Manager** | architecture, data flow, diagram, edge case, test를 잠급니다. 숨은 assumption을 밖으로 끌어냅니다. |
| [`/plan-design-review`](#plan-design-review) | **Senior Designer** | plan-mode에서 interactive design review를 수행합니다. 각 dimension을 0-10으로 평가하고, 10점짜리가 무엇인지 설명한 뒤 plan을 수정합니다. |
| [`/design-consultation`](#design-consultation) | **Design Partner** | scratch에서 완전한 design system을 만듭니다. landscape를 이해하고, creative risk를 제안하며, realistic product mockup을 생성합니다. |
| [`/review`](#review) | **Staff Engineer** | CI는 통과하지만 production에서 터질 bug를 찾습니다. 명백한 것은 auto-fix하고 completeness gap을 flag합니다. over-built code를 짚는 simplification lens는 advisory이며 block하거나 auto-apply하지 않습니다. |
| [`/investigate`](#investigate) | **Debugger** | 체계적인 root-cause debugging입니다. Iron Law: 조사 없는 fix 금지. data flow를 추적하고 hypothesis를 테스트하며, fix 시도가 3번 실패하면 멈춥니다. |
| [`/design-review`](#design-review) | **Designer Who Codes** | live site visual audit + fix loop입니다. 80-item audit 후 발견한 문제를 고치고, atomic commit과 before/after screenshot을 남깁니다. |
| [`/design-shotgun`](#design-shotgun) | **Design Explorer** | 여러 AI design variant를 만들고 browser에서 comparison board를 열어 방향을 승인할 때까지 iterate합니다. taste memory가 선호를 반영합니다. |
| [`/design-html`](#design-html) | **Design Engineer** | production-quality Pretext-native HTML을 생성합니다. approved mockup, CEO plan, design review, scratch description 모두 입력으로 받을 수 있습니다. resize 시 text가 reflow되고 height가 content에 맞춰 조정됩니다. |
| [`/qa`](#qa) | **QA Lead** | app을 테스트하고 bug를 찾고, atomic commit으로 fix한 뒤 재검증합니다. 모든 fix에 regression test를 자동 생성합니다. |
| [`/qa-only`](#qa) | **QA Reporter** | /qa와 같은 methodology를 사용하지만 report만 작성합니다. code change 없는 순수 bug report가 필요할 때 씁니다. |
| [`/scrape`](#scrape) | **Browser Data Extractor** | web page에서 data를 추출합니다. 첫 호출은 `$B`로 prototype하고, 같은 intent의 후속 호출은 codified browser-skill로 약 200ms 안에 실행됩니다. |
| [`/skillify`](#skillify) | **Skill Codifier** | conversation을 되짚어 마지막 `/scrape` prototype을 찾고, script + test + fixture를 합성해 test를 실행한 뒤 commit 전 확인을 요청합니다. |
| [`/ship`](#ship) | **Release Engineer** | main sync, test 실행, coverage audit, push, PR 생성까지 한 command로 처리합니다. test framework가 없으면 bootstrap합니다. |
| [`/land-and-deploy`](#land-and-deploy) | **Release Engineer** | PR을 merge하고 CI/deploy를 기다린 뒤 production health를 검증합니다. "approved"에서 "verified in production"까지 한 command로 진행됩니다. |
| [`/canary`](#canary) | **SRE** | post-deploy monitoring loop입니다. browse daemon으로 console error, performance regression, page failure를 감시합니다. |
| [`/benchmark`](#benchmark) | **Performance Engineer** | page load time, Core Web Vitals, resource size baseline을 잡습니다. PR 전후를 비교하고 trend를 추적합니다. |
| [`/cso`](#cso) | **Chief Security Officer** | OWASP Top 10 + STRIDE threat modeling security audit입니다. injection, auth, crypto, access control 문제를 찾습니다. |
| [`/document-release`](#document-release) | **Technical Writer** | 방금 ship한 내용에 맞춰 project docs를 업데이트합니다. stale README를 자동으로 잡습니다. |
| [`/document-generate`](#document-generate) | **Documentation Author** | code에서 feature용 Diataxis docs(tutorial / how-to / reference / explanation)를 생성합니다. |
| [`/retro`](#retro) | **Eng Manager** | team-aware weekly retro입니다. 사람별 breakdown, shipping streak, test health trend, growth opportunity를 정리합니다. |
| [`/browse`](#browse) | **QA Engineer** | agent에게 눈을 줍니다. 실제 Chromium browser, 실제 click, 실제 screenshot을 사용합니다. command당 약 100ms입니다. |
| [`/setup-browser-cookies`](#setup-browser-cookies) | **Session Manager** | 실제 browser(Chrome, Arc, Brave, Edge)에서 cookie를 가져와 headless session에 넣습니다. 인증된 page를 테스트할 수 있습니다. |
| [`/autoplan`](#autoplan) | **Review Pipeline** | command 하나로 완전히 review된 plan을 만듭니다. CEO → design → DX → eng review를 자동 실행하고 taste decision만 approval용으로 보여줍니다. |
| [`/plan-devex-review`](#plan-devex-review) | **DX Reviewer** | plan-stage DX review입니다. TTHW(time-to-hello-world), magical moment, friction point, persona trace를 다룹니다. Expansion, Polish, Triage 세 가지 mode가 있습니다. |
| [`/devex-review`](#devex-review) | **DX Reviewer (live)** | live developer experience audit입니다. 실제 onboarding flow를 따라가며 TTHW를 측정하고 docs가 실제와 다른 지점을 잡습니다. |
| [`/plan-tune`](#plan-tune) | **Question Tuner** | AskUserQuestion 민감도를 question별로 self-tune합니다. never-ask, always-ask, only-for-one-way로 표시할 수 있습니다. |
| [`/learn`](#learn) | **Memory** | gstack가 session 전반에서 학습한 project-specific pattern과 preference를 review, search, prune, export합니다. |
| [`/context-save`](#context-save) | **Save State** | working context(git state, decision, remaining work)를 저장해 future session이 이어받을 수 있게 합니다. |
| [`/context-restore`](#context-restore) | **Restore State** | saved context에서 session을 재개합니다. Conductor workspace handoff 후에도 이어갈 수 있습니다. |
| [`/health`](#health) | **Code Quality Dashboard** | type checker, linter, test, dead code detection을 감싸고 weighted 0-10 score와 trend를 계산합니다. |
| [`/landing-report`](#landing-report) | **Ship Queue Dashboard** | workspace-aware ship queue의 read-only snapshot입니다. 어떤 version slot이 잡혔고 sibling workspace에 WIP가 있는지 보여줍니다. |
| [`/benchmark-models`](#benchmark-models) | **Model Benchmark** | skill을 Claude, GPT, Gemini 등 여러 model로 side-by-side benchmark합니다. latency, token, cost, optional LLM-judged quality를 비교합니다. |
| | | |
| **Multi-AI** | | |
| [`/codex`](#codex) | **Second Opinion** | OpenAI Codex CLI의 independent review입니다. review(pass/fail gate), adversarial challenge, session continuity가 있는 open consultation 세 가지 mode를 제공합니다. |
| [`/pair-agent`](#pair-agent) | **Remote Agent Bridge** | remote AI agent(OpenClaw, Codex, Cursor, Hermes)를 browser와 pair합니다. scoped tunnel, locked allowlist, session token을 사용합니다. |
| [`/setup-gbrain`](#setup-gbrain) | **Memory Sync** | cross-machine session memory sync를 위해 gbrain을 설정합니다. 0에서 live까지 한 command입니다. |
| [`/sync-gbrain`](#sync-gbrain) | **Keep Brain Current** | 이 repo의 code로 gbrain을 refresh하고, agent가 Grep보다 `gbrain search`/`code-def`를 언제 써야 하는지 알려 줍니다. idempotent하며 재실행해도 안전합니다. |
| | | |
| **Safety & Utility** | | |
| [`/careful`](#safety--guardrails) | **Safety Guardrails** | `rm -rf`, `DROP TABLE`, force-push, `git reset --hard` 같은 destructive command 전에 경고합니다. MEDIUM warning은 override 가능하고 root/home recursive delete와 default-branch force-push는 hard deny됩니다. |
| [`/freeze`](#safety--guardrails) | **Edit Lock** | file edit를 하나의 directory로 제한합니다. boundary 밖 Edit/Write를 block해 debugging 중 실수를 막습니다. |
| [`/guard`](#safety--guardrails) | **Full Safety** | /careful + /freeze를 하나의 command로 켭니다. prod 작업에 최대한의 안전장치를 둡니다. |
| [`/unfreeze`](#safety--guardrails) | **Unlock** | /freeze boundary를 제거해 다시 어디든 edit할 수 있게 합니다. |
| [`/open-gstack-browser`](#open-gstack-browser) | **GStack Browser** | sidebar, anti-bot stealth, auto model routing, cookie import, Claude Code integration이 포함된 GStack Browser를 실행합니다. 모든 action을 live로 볼 수 있습니다. |
| [`/setup-deploy`](#setup-deploy) | **Deploy Configurator** | `/land-and-deploy`를 위한 one-time setup입니다. platform, production URL, deploy command를 감지합니다. |
| [`/gstack-upgrade`](#gstack-upgrade) | **Self-Updater** | gstack를 latest version으로 upgrade합니다. global install과 vendored install을 감지해 sync하고 변경 내용을 보여줍니다. |
| [`/make-pdf`](#make-pdf) | **PDF Generator** | Markdown을 publication-quality PDF로 바꿉니다. margin, page number, cover page, clickable TOC를 처리하고 Mermaid/excalidraw fence를 vector diagram으로 render합니다. |
| [`/diagram`](#diagram) | **Diagram Maker** | English input에서 mermaid source + editable `.excalidraw` + rendered SVG/PNG를 생성합니다. 완전히 offline입니다. |
| [`/ios-qa`](#ios-qa) | **iOS QA Lead** | USB CoreDevice tunnel + embedded StateServer로 real iPhone을 구동하는 live-device iOS QA입니다. Swift source를 읽고 accessor를 codegen하며 remote agent에도 Tailscale로 expose할 수 있습니다. |
| [`/ios-fix`](#ios-fix) | **iOS Autonomous Fixer** | real iPhone에서 find→fix→verify loop를 닫습니다. reproducing snapshot을 잡고 source를 수정한 뒤 rebuild, redeploy, verify합니다. |
| [`/ios-design-review`](#ios-design-review) | **iOS Designer's Eye** | real iPhone에서 10-dimension Apple HIG audit을 수행합니다. 각 screen을 평가하고 10점에 가까워지려면 무엇이 필요한지 설명합니다. |
| [`/ios-clean`](#ios-clean) | **iOS Bridge Cleanup** | DebugBridge SPM + `#if DEBUG` wiring을 제거하는 convenience wrapper입니다. structural release-build guard는 Package.swift + CI에 있습니다. |
| [`/ios-sync`](#ios-sync) | **iOS Bridge Resync** | latest upstream gstack에 맞춰 accessor와 Swift template을 재생성합니다. 새 `@Observable` class를 추가하거나 gstack를 upgrade한 뒤 실행합니다. |

---

## `/office-hours`

모든 project는 여기서 시작하는 것이 좋습니다.

plan을 세우기 전에, review하기 전에, code를 쓰기 전에 YC-style partner와 앉아 실제로 무엇을 만들고 있는지 생각합니다. 당신이 만들고 있다고 *생각하는 것*이 아니라, 정말로 만들고 있는 것이 무엇인지 보는 단계입니다.

### Reframe

실제 project에서 이런 일이 있었습니다. 사용자는 "내 calendar용 daily briefing app을 만들고 싶다"고 말했습니다. 합리적인 request처럼 보입니다. 그러자 skill은 가설이 아니라 구체적인 예시를 요구하며 pain을 물었습니다. 사용자는 assistant가 중요한 것을 놓치고, 여러 Google account에 흩어진 calendar item에는 stale info가 많고, prep doc은 AI slop 같고, event location은 틀려 직접 추적하는 데 시간이 오래 걸린다고 설명했습니다.

skill은 이렇게 답했습니다: *"이 framing에는 조금 pushback하겠습니다. 이미 그 범위를 넘어선 것처럼 보입니다. 당신은 'multi-Google-Calendar management용 daily briefing app'이라고 말했지만, 실제로 설명한 것은 personal chief of staff AI입니다."*

그리고 사용자가 스스로 설명하고 있다는 사실을 몰랐던 capability 다섯 가지를 추출했습니다.

1. 모든 account의 **calendar를 감시**하고 stale info, missing location, permission gap을 감지합니다.
2. **진짜 prep work를 생성**합니다. logistics summary가 아니라 board meeting, podcast, fundraiser를 준비하기 위한 *intellectual work*입니다.
3. **CRM을 관리**합니다. 누구를 만나고, 관계가 무엇이고, 상대가 무엇을 원하고, history가 무엇인지 봅니다.
4. **시간을 우선순위화**합니다. 준비를 일찍 시작해야 하는 경우를 flag하고, 시간을 proactive하게 block하며, event를 importance별로 ranking합니다.
5. **money를 leverage로 바꿉니다.** delegate하거나 automate할 방법을 적극적으로 찾습니다.

이 reframe은 project 전체를 바꿨습니다. 원래는 calendar app을 만들 뻔했습니다. 이제는 10배 더 가치 있는 것을 만들게 되었습니다. skill이 feature request가 아니라 pain을 들었기 때문입니다.

### Premise Challenge

reframe 후에는 검증해야 할 premise를 제시합니다. "이거 좋아 보이나요?" 같은 질문이 아니라 product에 대한 falsifiable claim입니다.

1. calendar는 anchor data source이지만, value는 그 위의 intelligence layer에 있습니다.
2. assistant는 replace되는 것이 아니라 superpower를 얻습니다.
3. 가장 좁은 wedge는 실제로 작동하는 daily briefing입니다.
4. CRM integration은 nice-to-have가 아니라 must-have입니다.

당신은 동의하거나, 반대하거나, 조정합니다. 받아들인 premise는 design doc에서 load-bearing decision이 됩니다.

### Implementation Alternative

그다음 2-3개의 구체적인 implementation approach와 솔직한 effort estimate를 만듭니다.

- **Approach A: Daily Briefing First** — 가장 좁은 wedge, 내일 ship 가능, M effort(human: 약 3주 / CC: 약 2일)
- **Approach B: CRM-First** — relationship graph를 먼저 구축, L effort(human: 약 6주 / CC: 약 4일)
- **Approach C: Full Vision** — 모든 것을 한 번에 구현, XL effort(human: 약 3개월 / CC: 약 1.5주)

실제 사용에서 배울 수 있으므로 A를 추천합니다. CRM data는 2주 차에 자연스럽게 따라옵니다.

### Two Modes

**Startup mode** — business를 만드는 founder와 intrapreneur를 위한 mode입니다. YC partner가 product를 평가할 때 보는 관점에서 추출한 6개의 forcing question을 받습니다: demand reality, status quo, desperate specificity, narrowest wedge, observation & surprise, future-fit. 일부러 불편한 질문들입니다. product가 필요한 구체적인 사람 한 명을 말할 수 없다면, code를 쓰기 전에 그것부터 배우는 것이 가장 중요합니다.

**Builder mode** — hackathon, side project, open source, learning, fun을 위한 mode입니다. 당신의 idea에서 가장 멋진 version을 찾도록 도와주는 열정적인 collaborator를 얻습니다. 무엇이 사람을 "whoa"라고 말하게 만들까요? 공유할 수 있는 무언가까지 가는 가장 빠른 path는 무엇일까요? 이 질문들은 interrogative가 아니라 generative합니다.

### Design Doc

두 mode 모두 `~/.gstack/projects/`에 design doc을 작성하고, 그 doc은 `/plan-ceo-review`와 `/plan-eng-review`의 입력이 됩니다. 전체 lifecycle은 `office-hours → plan → implement → review → QA → ship → retro`입니다.

design doc이 승인되면 `/office-hours`는 session 동안 당신이 어떻게 생각하는지에 대해 관찰한 것을 반영합니다. generic praise가 아니라, 당신이 실제로 했던 말에 대한 specific callback입니다. 이 observation은 design doc에도 들어가므로 나중에 다시 읽을 때 다시 만나게 됩니다.

---

## `/plan-ceo-review`

이것은 내 **founder mode**입니다.

여기서는 model이 taste, ambition, user empathy, long time horizon을 가지고 생각하길 원합니다. request를 문자 그대로 받아들이지 않고, 먼저 더 중요한 질문을 묻기를 바랍니다.

**이 product는 실제로 무엇을 위한 것인가?**

나는 이것을 **Brian Chesky mode**라고 생각합니다.

목표는 obvious ticket을 구현하는 것이 아닙니다. 사용자의 관점에서 문제를 다시 생각하고, inevitable하고 delightful하며 어쩌면 조금 magical하게 느껴지는 version을 찾는 것입니다.

### Example

Craigslist-style listing app을 만들고 있다고 해 봅시다. 내가 이렇게 말합니다.

> "판매자가 item photo를 upload할 수 있게 해줘."

약한 assistant는 file picker를 추가하고 image를 저장합니다.

그것은 진짜 product가 아닙니다.

`/plan-ceo-review`에서는 model이 "photo upload"가 정말 feature인지 물어야 합니다. 실제 feature는 누군가가 잘 팔리는 listing을 만들도록 돕는 것일 수 있습니다.

그것이 진짜 job이라면 plan 전체가 달라집니다.

이제 model은 이런 질문을 해야 합니다.

* photo에서 product를 식별할 수 있는가?
* SKU나 model number를 추론할 수 있는가?
* web search로 title과 description을 자동 draft할 수 있는가?
* spec, category, pricing comp를 가져올 수 있는가?
* 어떤 photo가 hero image로 가장 잘 convert될지 제안할 수 있는가?
* uploaded photo가 ugly, dark, cluttered, low-trust인지 감지할 수 있는가?
* dead form from 2007 같은 경험이 아니라 premium experience로 만들 수 있는가?

이것이 `/plan-ceo-review`가 나에게 해 주는 일입니다.

그냥 "이 feature를 어떻게 추가하지?"라고 묻지 않습니다.
**"이 request 안에 숨어 있는 10-star product는 무엇인가?"**라고 묻습니다.

### Four Modes

- **SCOPE EXPANSION** — 크게 꿈꿉니다. agent가 ambitious version을 제안합니다. 모든 expansion은 opt-in할 수 있는 개별 decision으로 제시되며, agent는 적극적으로 추천합니다.
- **SELECTIVE EXPANSION** — 현재 scope를 baseline으로 유지하되, 가능한 추가 기회를 하나씩 보여줍니다. recommendation은 neutral하며 당신이 가치 있는 것만 cherry-pick합니다.
- **HOLD SCOPE** — 기존 plan에 대해 최대한 엄격하게 review합니다. expansion은 보여주지 않습니다.
- **SCOPE REDUCTION** — minimum viable version을 찾고 나머지는 잘라냅니다.

vision과 decision은 `~/.gstack/projects/`에 저장되어 conversation 이후에도 유지됩니다. exceptional vision은 team과 공유할 수 있도록 repo의 `docs/designs/`로 promote할 수 있습니다.

---

## `/plan-eng-review`

이것은 내 **eng manager mode**입니다.

product direction이 맞아지면 완전히 다른 종류의 intelligence가 필요합니다. 더 넓게 퍼지는 ideation도, "wouldn't it be cool if"도 원하지 않습니다. model이 최고의 technical lead처럼 행동하길 원합니다.

이 mode는 다음을 단단히 잡아야 합니다.

* architecture
* system boundary
* data flow
* state transition
* failure mode
* edge case
* trust boundary
* test coverage

그리고 나에게 크게 unlock이 되었던 것 하나: **diagram**입니다.

LLM은 system을 그리게 만들면 훨씬 더 complete해집니다. sequence diagram, state diagram, component diagram, data-flow diagram, test matrix 모두 숨은 assumption을 밖으로 끌어냅니다. 손에 잡히지 않는 planning이 훨씬 어려워집니다.

그래서 `/plan-eng-review`는 product vision을 실제로 구현할 수 있게 지탱하는 technical spine을 만드는 단계입니다.

### Example

같은 listing app 예시를 봅시다.

`/plan-ceo-review`가 이미 일을 마쳤다고 합시다. 진짜 feature는 단순 photo upload가 아니라 다음을 하는 smart listing flow입니다.

* photo upload
* product identification
* web enrichment
* strong title/description draft
* best hero image suggestion

이제 `/plan-eng-review`가 이어받습니다.

model은 다음 질문에 답해야 합니다.

* upload, classification, enrichment, draft generation의 architecture는 무엇인가?
* 어떤 step은 sync로 처리하고, 어떤 step은 background job으로 보낼 것인가?
* app server, object storage, vision model, search/enrichment API, listing database 사이의 boundary는 어디인가?
* upload는 성공했지만 enrichment가 실패하면 어떻게 되는가?
* product identification confidence가 낮으면 어떻게 되는가?
* retry는 어떻게 동작하는가?
* duplicate job은 어떻게 막는가?
* 무엇을 언제 persist하고, 무엇은 안전하게 recompute할 수 있는가?

여기서 diagram이 필요합니다. architecture diagram, state model, data-flow diagram, test matrix가 hidden assumption을 끄집어내고 hand-wavy planning을 어렵게 만듭니다.

이것이 `/plan-eng-review`입니다.

"idea를 더 작게 만들기"가 아닙니다.
**idea를 buildable하게 만드는 것**입니다.

invocation note: plan mode에서는 "무엇을 review할까요?" scope question을 건너뛰고 active plan을 자동 review합니다. 한 줄로 선택을 알립니다("Scope gate: plan mode — auto-selected B"). target을 명시하면("review PLAN.md") 어떤 mode에서도 그 선택이 우선합니다. plan mode가 아니고 target도 없으면 먼저 묻습니다. 이 gate는 hard stop입니다.

### Review Readiness Dashboard

모든 review(CEO, Eng, Design)는 결과를 log합니다. review가 끝나면 dashboard가 표시됩니다.

```
+====================================================================+
|                    REVIEW READINESS DASHBOARD                       |
+====================================================================+
| Review          | Runs | Last Run            | Status    | Required |
|-----------------|------|---------------------|-----------|----------|
| Eng Review      |  1   | 2026-03-16 15:00    | CLEAR     | YES      |
| CEO Review      |  1   | 2026-03-16 14:30    | CLEAR     | no       |
| Design Review   |  0   | —                   | —         | no       |
+--------------------------------------------------------------------+
| VERDICT: CLEARED — Eng Review passed                                |
+====================================================================+
```

Eng Review만 required gate입니다(`gstack-config set skip_eng_review true`로 비활성화 가능). CEO와 Design은 informational이며, 각각 product change와 UI change에 권장됩니다.

### Plan-to-QA Flow

`/plan-eng-review`가 test review section을 마치면 test plan artifact를 `~/.gstack/projects/`에 씁니다. 나중에 `/qa`를 실행하면 이 test plan을 자동으로 가져옵니다. 즉 engineering review가 manual copy-paste 없이 QA testing으로 바로 이어집니다.

---

## `/plan-design-review`

이것은 내 **senior designer reviewing your plan**입니다. code 한 줄 쓰기 전에 실행합니다.

대부분의 plan은 backend가 무엇을 하는지는 설명하지만, 사용자가 실제로 무엇을 보는지는 지정하지 않습니다. empty state, error state, loading state, mobile layout, AI slop risk 같은 결정이 "구현하면서 알아서"로 밀립니다. 그러면 아무도 더 나은 empty state를 지정하지 않았기 때문에 engineer가 "No items found."를 ship하게 됩니다.

`/plan-design-review`는 수정 비용이 싼 planning 단계에서 이 문제를 잡습니다.

`/plan-ceo-review`, `/plan-eng-review`처럼 interactive하게 동작합니다. issue를 하나씩 다루고 **STOP + AskUserQuestion** pattern을 사용합니다. 각 design dimension을 0-10으로 평가하고, 10점짜리가 무엇인지 설명한 뒤 plan을 그 방향으로 수정합니다. 점수는 작업량을 결정합니다. 낮으면 많은 fix, 높으면 quick pass입니다. plan mode에서는 active plan을 자동 target으로 삼고, 명시적 target이 있으면 그것이 우선합니다.

plan을 일곱 번 통과합니다: information architecture, interaction state coverage, user journey, AI slop risk, design system alignment, responsive/accessibility, unresolved design decision. 각 pass는 gap을 찾고, obvious한 것은 직접 fix하며, 진짜 tradeoff가 있는 것은 사용자에게 선택을 요청합니다.

### Example

```
You:   /plan-design-review

Claude: 초기 디자인 평점: 4/10

        "이 plan은 user dashboard를 설명하지만 사용자가 처음 무엇을 보게 되는지
         지정하지 않습니다. 'icons가 있는 cards'라고만 되어 있어 모든 SaaS template처럼
         보입니다. loading state, empty state, mobile behavior도 전혀 언급하지 않습니다."

        Pass 1 (Info Architecture): 3/10
        "10점짜리 plan이라면 모든 screen의 primary/secondary/tertiary content
         hierarchy를 정의했을 것입니다."
        → plan에 information hierarchy section을 추가함

        Pass 2 (Interaction States): 2/10
        "plan에는 UI feature가 4개 있지만, 필요한 20개 interaction state
         (feature 4개 × state 5개) 중 아무것도 지정되어 있지 않습니다."
        → plan에 interaction state table을 추가함

        Pass 4 (AI Slop): 4/10
        "plan에는 'cards and icons가 있는 clean, modern UI',
         'gradient가 있는 hero section'이라고 되어 있습니다. 둘 다 AI가 만든 것처럼
         보이게 만드는 대표 pattern입니다."
        → UI description을 구체적이고 intentional한 alternative로 다시 작성함

        Overall: 수정 후 4/10 → 8/10
        "plan이 design-complete 상태입니다. implementation 후 visual QA를 위해
         /design-review를 실행하세요."
```

다시 실행할 때 이미 8점 이상인 section은 quick pass를 받고, 8점 미만인 section은 full treatment를 받습니다. implementation 이후 live-site visual audit에는 `/design-review`를 사용하세요.

---

## `/design-consultation`

이것은 내 **design partner mode**입니다.

`/plan-design-review`는 이미 존재하는 site를 audit합니다. `/design-consultation`은 아직 아무것도 없을 때 사용합니다. design system도, font choice도, color palette도 없는 상태에서 senior designer와 함께 전체 visual identity를 만들고 싶을 때입니다.

이것은 form이 아니라 conversation입니다. agent는 product, user, audience를 묻고 product가 전달해야 하는 감각을 생각합니다. trust, speed, craft, warmth처럼 product에 맞는 느낌에서 출발해 aesthetic direction, typography, color palette, spacing scale, layout approach, motion strategy까지 구체적인 선택으로 역산합니다. 모든 recommendation에는 rationale이 있고, 각 선택은 서로를 강화합니다.

하지만 coherence는 table stakes입니다. 모든 dev tool dashboard는 비슷해 보입니다. clean sans-serif, muted gray, blue accent. 모두 일관성은 있지만 잊히기 쉽습니다. "nice"하게 보이는 product와 실제로 사람들이 기억하는 product의 차이는 **deliberate creative risk**입니다. heading의 unexpected serif, category에서 아무도 쓰지 않는 bold accent, data를 airy하게 두지 않고 authoritative하게 만드는 tighter spacing 같은 것들입니다.

`/design-consultation`은 안전한 system만 제안하지 않습니다. safe choice와 risk를 함께 제안하고 어느 쪽이 어떤 의미인지 말합니다. "category 안에서 읽히게 해 주는 선택은 이것이고, convention을 깨야 한다고 보는 지점은 이것이며, 이유는 이렇습니다." 당신이 감수할 risk를 고르면 agent는 어느 선택을 하든 전체 system이 coherent한지 확인합니다.

원하면 agent가 당신의 space에 이미 존재하는 것들을 research합니다. real site screenshot을 찍고 font, color, spacing을 분석해 landscape를 보여줍니다. 복사가 목적이 아니라 convention을 이해하고 무엇을 깨야 할지 선택하기 위한 것입니다.

system에 합의하면 interactive HTML preview page를 생성합니다. swatch와 font sample만 보여주는 것이 아니라 realistic product page를 보여줍니다. dashboard라면 sidebar, data table, stat card가 보이고, marketing site라면 실제 copy와 CTA가 있는 hero section이 보입니다. 모든 것은 product name, light/dark mode와 함께 design system 안에서 render됩니다. production code를 쓰기 전에 product가 어떤 느낌일지 볼 수 있습니다.

그다음 repo root에 `DESIGN.md`를 작성합니다. project의 design source of truth입니다. 그리고 모든 future Claude Code session이 system을 따르도록 `CLAUDE.md`를 업데이트합니다. 이후 `/design-review`는 그 기준으로 audit할 수 있고, frontend를 다루는 모든 agent는 rule을 알게 됩니다.

### Example

```
You:   /design-consultation

Claude: README를 보면 엔지니어링 팀을 위한 개발자 분석 대시보드로 보입니다.
        맞나요? 원하는 느낌을 말해 주세요.
        그리고 먼저 시장에 어떤 것들이 있는지 살펴볼까요?
        전체 landscape를 보고 선택할 수 있습니다.

You:    맞아, engineering manager용이야. 어떤 것들이 있는지 보여줘.

Claude: [Linear, Vercel, Datadog, Posthog를 둘러보고 스크린샷을 찍습니다.]

        landscape는 이렇습니다. 대부분 clean sans-serif와
        muted blue-gray palette로 수렴합니다. Linear는 dark-first 접근과
        tight spacing으로 차별화됩니다. 나머지는 서로 바꿔도 크게 달라 보이지 않습니다.

        제안은 이렇습니다. 어디서는 안전하게 가고, 어디서는 risk를 감수할지 나눴습니다:

        AESTHETIC: Industrial/Utilitarian — data-first, 모든 pixel이 이유를 갖는 방향
        TYPOGRAPHY: Geist (body + UI), Instrument Serif (display), JetBrains Mono (data)
        COLOR: 절제된 slate neutral, 단일 teal accent (#0D9488)
        SPACING: 4px base, compact density
        LAYOUT: grid를 엄격히 따르는 12-column 구조
        MOTION: Minimal-functional — 이해를 돕는 transition만 사용

        SAFE CHOICES (category expectation에 맞춤):
          body에는 Geist — 사용자는 Vercel에서 이미 이 font에 익숙합니다.
          slate neutral — data-heavy UI에는 따뜻한 gray가 잘 맞습니다.
          grid-disciplined layout — dashboard에는 예측 가능한 정렬이 필요합니다.

        RISKS (차별화 지점):
          display heading에 Instrument Serif — dev tool 영역에서는 거의 아무도
            serif를 쓰지 않습니다. 즉각적인 hierarchy contrast를 만들고
            sans-serif로 가득한 공간에서 "우리는 craft를 신경 쓴다"는 신호를 줍니다.
          blue 대신 단일 teal accent — 이 영역의 대부분은 blue를 씁니다.
            teal은 신뢰감을 줄 만큼 가깝고, 알아볼 수 있을 만큼 다릅니다.
          4px compact density — Linear보다 더 촘촘해서 "우리는 사용자의
            screen real estate를 존중한다"고 말합니다.

        안전한 선택은 category 안에서 읽히게 해줍니다. risk는 product가
        자기 얼굴을 갖는 지점입니다. 어떤 risk가 끌리나요?

You:    세리프를 쓰는 리스크가 마음에 들어. 한번 보자.

Claude: 브라우저에서 preview를 열었습니다.
        [/tmp/design-consultation-preview-1710000000.html]

        이 page는 실제 dashboard처럼 보입니다. sidebar nav, avatar가 있는 header,
        stat card, data table이 모두 design system 안에서 렌더링됩니다.
        hero scale에는 Instrument Serif, body text에는 Geist, data table에는
        JetBrains Mono를 사용합니다. button과 active state에는 teal accent를 적용했습니다.
        모서리에는 light/dark mode toggle이 있습니다.

        느낌이 어떤가요? DESIGN.md를 쓰기 전에 조정할 부분이 있나요?

You:    좋아, 진행해.

Claude: DESIGN.md를 작성했습니다. (타이포그래피, 색상, 간격, 레이아웃, 모션)
        CLAUDE.md에 design system guideline을 업데이트했습니다.
        이후 모든 session은 이 선택을 따릅니다.
```

---

## `/design-review`

이것은 내 **designer who codes mode**입니다.

`/plan-design-review`는 implementation 전에 plan을 review합니다. `/design-review`는 implementation 후 live site를 audit하고 fix합니다.

live site에 80-item visual audit을 실행한 뒤 fix loop로 들어갑니다. 각 design finding에 대해 source file을 찾고, 최소한의 CSS/styling change를 만들고, `style(design): FINDING-NNN` commit을 남기며, 다시 navigate해서 검증하고 before/after screenshot을 찍습니다. fix 하나당 commit 하나라 완전히 bisectable합니다.

self-regulation heuristic은 design work에 맞춰져 있습니다. CSS-only change는 inherently safe하고 reversible하므로 free pass를 받지만, component JSX/TSX file change는 risk budget에 계산됩니다. hard cap은 30 fix입니다. risk score가 20%를 넘으면 멈추고 묻습니다.

### Example

```
You:   /design-review https://myapp.com

Claude: [live site에서 80개 항목 시각 감사(visual audit)를 실행합니다.]
        Design Score: C  |  AI Slop Score: D
        finding 12개(high 4개, medium 5개, polish 3개)

        design issue 9개를 수정하는 중...

        style(design): FINDING-001 — 3-column icon grid를 asymmetric layout으로 교체
        style(design): FINDING-002 — heading scale 48/32/24/18/16 추가
        style(design): FINDING-003 — gradient hero 제거, bold typography 사용
        style(design): FINDING-004 — heading용 second font 추가
        style(design): FINDING-005 — element role에 따라 border-radius 차등 적용
        style(design): FINDING-006 — body text는 left-align, center는 heading에만 사용
        style(design): FINDING-007 — 모든 interactive element에 hover/focus state 추가
        style(design): FINDING-008 — prefers-reduced-motion media query 추가
        style(design): FINDING-009 — body text의 max content width를 680px로 설정

        최종 audit:
        Design Score: C → B+  |  AI Slop Score: D → A
        fix 9개 적용(8개 검증, 1개 best-effort). 3개 deferred.

        [before/after screenshot이 포함된 report를 .gstack/design-reports/에 저장함]
```

commit 9개, 각 commit은 하나의 concern만 다룹니다. gradient hero, 3-column grid, uniform radius 같은 식별 가능한 AI slop pattern이 사라졌기 때문에 AI Slop Score가 D에서 A로 올라갑니다.

---

## `/design-shotgun`

이것은 내 **design exploration mode**입니다.

feature, page, landing screen은 있는데 어떤 모습이어야 할지 확신이 없을 때가 있습니다. Claude에게 설명하면 하나의 답을 받을 수 있지만, 하나의 답은 하나의 관점일 뿐입니다. design은 taste game입니다. option을 봐야 합니다.

`/design-shotgun`은 GPT Image API로 visual design variant 3개를 만들고, browser에서 comparison board를 연 뒤 feedback을 기다립니다. 방향을 고르거나, 변경을 요청하거나, 완전히 새로운 variant를 요청할 수 있습니다. board는 remix, regenerate, approve action을 지원합니다.

### Loop

1. 원하는 것을 설명합니다(또는 existing page를 가리킵니다).
2. skill이 brand constraint를 위해 `DESIGN.md`를 읽습니다(있다면).
3. distinct design variant 3개를 PNG로 생성합니다.
4. comparison board가 browser에서 side-by-side로 열립니다.
5. 마음에 드는 것에서 "Approve"를 click하거나 다음 round용 feedback을 남깁니다.
6. approved variant가 `approved.json`과 함께 `~/.gstack/projects/$SLUG/designs/`에 저장됩니다.

`approved.json`은 `/design-html`에 들어가는 입력 중 하나입니다. design pipeline은 이렇게 이어집니다: shotgun이 방향을 고르고, design-html이 그 방향을 working code로 만듭니다. 하지만 `/design-html`은 CEO plan, design review, 단순 description으로도 동작합니다.

### Taste Memory

skill은 session 전반에서 preference를 기억합니다. busy design보다 minimal design을 계속 선호하면 future generation이 그쪽으로 bias됩니다. 따로 설정하는 값이 아니라 approval에서 자연스럽게 생겨납니다.

### Example

```
You:   /design-shotgun — 개발자 도구 landing page의 hero section

Claude: [variant 3개를 생성합니다.]
        변형 A: 굵은 타이포그래피, 어두운 배경, code snippet hero
        변형 B: split layout, 왼쪽 product screenshot, 오른쪽 copy
        변형 C: minimal style, 중앙 정렬 headline, gradient accent

        [localhost:PORT에서 comparison board를 엽니다.]

You:    [브라우저에서 Variant A의 "Approve"를 클릭합니다.]

Claude: Variant A를 승인했습니다. ~/.gstack/projects/myapp/designs/에 저장했습니다.
        다음: 이 mockup에서 production HTML을 생성하려면 /design-html을 실행하세요.
```

---

## `/design-html`

이것은 내 **design-to-code mode**입니다.

AI code generation tool은 대개 static CSS를 만듭니다. hardcoded height, resize 시 overflow되는 text, flow하지 않고 snap되는 breakpoint가 생깁니다. output은 딱 하나의 viewport size에서는 맞아 보이지만 나머지에서는 깨집니다.

`/design-html`은 이 문제를 고칩니다. [Pretext](https://github.com/chenglou/pretext)를 사용해 HTML을 생성합니다. Pretext는 DOM measurement 없이 text layout을 계산하는 15KB library입니다. text는 reflow되고, height는 content에 맞춰 조정되며, card는 스스로 size를 잡고, chat bubble은 shrinkwrap됩니다. 모두 sub-millisecond이고 dynamic합니다.

여러 input source와 함께 동작합니다: `/design-shotgun`의 approved mockup, `/plan-ceo-review`의 CEO plan, `/plan-design-review`의 design review context, 사용자가 제공한 PNG, 단순 description. 존재하는 context를 감지하고 어떻게 진행할지 묻습니다.

### Smart API Routing

모든 page가 full Pretext engine을 필요로 하지는 않습니다. skill은 design을 읽고 알맞은 tool을 고릅니다.

- **Simple layouts** (landing, marketing): resize-aware height를 위해 `prepare()` + `layout()`
- **Card grids** (dashboard, listing): self-sizing card를 위해 `prepare()` + `layout()`
- **Chat UIs**: wasted pixel 없는 tight-fit bubble을 위해 `walkLineRanges()`
- **Editorial layouts**: obstacle 주변으로 text가 흐르게 하기 위해 `layoutNextLine()`
- **Complex editorial**: manual line rendering을 위해 `layoutWithLines()`가 있는 full engine

### Refinement Loop

1. `approved.json`에서 approved mockup을 읽습니다.
2. GPT-4o vision으로 implementation spec(colors, typography, layout)을 추출합니다.
3. Pretext가 inline된 self-contained HTML을 생성합니다(15KB, zero network dependency).
4. live-reload server를 띄워 즉시 변경을 볼 수 있게 합니다.
5. mobile, tablet, desktop 3개 viewport에서 screenshot으로 layout을 검증합니다.
6. AskUserQuestion: 무엇을 바꿔야 하나요?
7. Edit tool로 surgical edit를 수행합니다(full regeneration 아님).
8. 사용자가 "done"이라고 말할 때까지 반복합니다.

### Framework Detection

project가 React, Svelte, Vue를 사용한다면(`package.json`에서 감지), skill은 vanilla HTML 대신 framework component 생성을 제안합니다. framework output은 inline vendoring 대신 `npm install @chenglou/pretext`를 사용합니다.

### Example

```
You:   /design-html

Claude: 승인된 mockup을 찾았습니다: variant-A.png (hero section)
        Design type: simple layout → prepare() + layout() 사용

        [Pretext로 HTML을 생성하고 live-reload server를 엽니다.]
        [375px, 768px, 1440px screenshot — 모두 검증됨]

        HTML이 localhost:3456에서 실행 중입니다. browser size를 조정해 보세요.
        text가 dynamic하게 reflow됩니다. 무엇을 바꾸면 될까요?

You:    헤드라인을 더 크게 하고 CTA 아래 간격을 더 줘.

Claude: [font-size와 margin을 수정하고 browser가 자동 reload됩니다.]
        업데이트했습니다. 변경 2개를 적용했습니다.

You:    완료

Claude: ~/.gstack/projects/myapp/designs/hero-20260330/finalized.html에 저장했습니다.
```

---

## `/review`

이것은 내 **paranoid staff engineer mode**입니다.

test가 통과한다고 branch가 안전하다는 뜻은 아닙니다.

`/review`는 CI를 통과하고도 production에서 터지는 bug class가 많기 때문에 존재합니다. 이 mode는 더 큰 꿈을 꾸거나 plan을 prettier하게 만드는 데 관심이 없습니다. 질문은 하나입니다.

**아직 무엇이 깨질 수 있는가?**

이것은 structural audit이지 style nitpick pass가 아닙니다. model이 이런 것들을 보길 원합니다.

* N+1 query
* stale read
* race condition
* bad trust boundary
* missing index
* escaping bug
* broken invariant
* bad retry logic
* 실제 failure mode를 놓치면서 통과하는 test
* forgotten enum handler — 새 status/type constant를 추가했을 때, 변경 file뿐 아니라 codebase 전체의 switch statement와 allowlist를 추적합니다.

### Fix-First

finding은 단순 listing이 아니라 action으로 이어집니다. dead code, stale comment, N+1 query 같은 obvious mechanical fix는 자동 적용됩니다. 각 genuine issue에는 `[AUTO-FIXED] file:line Problem → what was done`이 표시됩니다. security, race condition, design decision처럼 ambiguous한 문제는 사용자의 판단을 위해 surface됩니다.

### Completeness Gap

`/review`는 complete version 비용이 CC time 30분 미만인 shortcut implementation을 flag합니다. 80% solution을 선택했는데 100% solution이 ocean이 아니라 lake라면 review가 짚어냅니다.

예외는 deliberate하게 선택하고 log한 shortcut입니다. decision ledger에서 resolve되는 decision id가 있는 `gstack-shortcut(dec-<id>)` marker는 finding을 acknowledged debt로 downgrade합니다. ledger entry가 없는 orphan marker는 아무것도 suppress하지 않으며, gap은 정상적으로 report되고 marker 자체도 flag됩니다.

### Example

smart listing flow가 구현됐고 test가 green이라고 합시다.

`/review`는 여전히 이렇게 물어야 합니다.

* listing photo나 draft suggestion을 render할 때 N+1 query를 만들지 않았는가?
* client-provided file metadata를 실제 file validation 대신 믿고 있지는 않은가?
* 두 tab이 race를 일으켜 cover-photo selection이나 item detail을 덮어쓸 수 있는가?
* failed upload가 storage에 orphaned file을 남기지는 않는가?
* "정확히 하나의 hero image" rule이 concurrency에서 깨질 수 있는가?
* enrichment API가 부분 실패하면 graceful degrade하는가, 아니면 garbage를 저장하는가?
* web data를 draft generation에 넣으면서 prompt injection이나 trust-boundary 문제를 만들지는 않았는가?

이것이 `/review`의 목적입니다.

여기서는 칭찬을 원하지 않습니다.
production incident가 일어나기 전에 model이 먼저 상상해 주길 원합니다.

---

## `/investigate`

무언가 깨졌지만 이유를 모를 때 `/investigate`는 체계적인 debugger가 됩니다. Iron Law는 **root cause investigation 없는 fix 금지**입니다.

guess하고 patch하는 대신 data flow를 추적하고, known bug pattern과 대조하며, hypothesis를 하나씩 테스트합니다. fix 시도가 3번 실패하면 더 헤매지 않고 architecture를 의심하며 멈춥니다. "하나만 더 해볼게" spiral로 시간을 버리는 일을 막습니다.

---

## `/qa`

이것은 내 **QA lead mode**입니다.

`/browse`는 agent에게 눈을 줍니다. `/qa`는 testing methodology를 줍니다.

가장 흔한 사용 사례는 이렇습니다. feature branch에서 coding을 끝냈고, 모든 것이 실제로 동작하는지 확인하고 싶습니다. 그냥 `/qa`라고 말하면 됩니다. git diff를 읽고 변경이 영향을 주는 page와 route를 식별하고, browser를 띄워 각각을 테스트합니다. URL도 manual test plan도 필요 없습니다.

4가지 mode가 있습니다.

- **Diff-aware** (feature branch에서 자동) — `git diff main`을 읽고 affected page를 찾아 그 부분을 집중 test합니다.
- **Full** — app 전체를 체계적으로 탐색합니다. 5-15분. 근거가 잘 남은 issue 5-10개를 문서화합니다.
- **Quick** (`--quick`) — 30초 smoke test입니다. homepage + top 5 nav target.
- **Regression** (`--regression baseline.json`) — full mode를 실행한 뒤 previous baseline과 diff합니다.

### Automatic Regression Tests

`/qa`가 bug를 fix하고 verify하면, 깨졌던 정확한 scenario를 잡는 regression test를 자동 생성합니다. test에는 QA report로 이어지는 attribution tracing이 포함됩니다.

### Example

```
You:   /qa https://staging.myapp.com

Claude: [12개 page를 탐색하고, form 3개를 채우고, flow 2개를 테스트합니다.]

        QA Report: staging.myapp.com — Health Score: 72/100

        상위 issue 3개:
        1. CRITICAL: 필수 field가 비어 있어도 checkout form이 submit됨
        2. HIGH: item을 선택한 뒤 mobile nav menu가 닫히지 않음
        3. MEDIUM: 1024px 아래에서 dashboard chart가 sidebar와 겹침

        [screenshot이 포함된 full report를 .gstack/qa-reports/에 저장함]
```

**인증된 page 테스트:** `/setup-browser-cookies`로 실제 browser session을 가져온 뒤 `/qa`를 실행하면 login 뒤 page도 테스트할 수 있습니다.

---

## `/ship`

이것은 내 **release machine mode**입니다.

무엇을 만들지 결정했고, technical plan을 확정했으며, serious review까지 끝냈다면 더 많은 대화가 아니라 실행이 필요합니다.

`/ship`은 final mile을 위한 skill입니다. 무엇을 만들지 결정하는 단계가 아니라 ready branch를 처리하는 단계입니다.

model은 여기서 brainstorm partner처럼 굴지 않고 disciplined release engineer처럼 행동해야 합니다. main과 sync하고, 알맞은 test를 실행하고, branch state가 sane한지 확인하고, repo가 기대한다면 changelog나 version을 업데이트하고, push하고, PR을 생성하거나 업데이트합니다.

### Test Bootstrap

project에 test framework가 없다면 `/ship`이 한 번 설정합니다. runtime을 감지하고, 가장 적합한 framework를 research하고, 설치하고, 실제 code에 대한 real test 3-5개를 작성하고, CI/CD(GitHub Actions)를 설정하고, TESTING.md를 만듭니다. 목표는 100% test coverage입니다. test는 vibe coding을 yolo coding이 아니라 안전한 workflow로 만듭니다.

### Coverage Audit

모든 `/ship` run은 diff에서 code path map을 만들고, 해당 test를 찾아 quality star가 있는 ASCII coverage diagram을 생성합니다. gap에는 test가 자동 생성됩니다. PR body에는 coverage가 표시됩니다: `Tests: 42 → 47 (+5 new)`.

### Review Gate

`/ship`은 PR 생성 전에 [Review Readiness Dashboard](#review-readiness-dashboard)를 확인합니다. Eng Review가 빠져 있으면 묻지만 block하지는 않습니다. decision은 branch별로 저장되어 같은 질문을 반복하지 않습니다.

흥미로운 작업은 끝났고 지루한 release work만 남았을 때 많은 branch가 죽습니다. 사람은 그 부분을 미루지만 AI는 그러면 안 됩니다.

### Third-Party Web Actions(v1.72.0.0+)

가끔 release work는 terminal 밖으로 나갑니다. API key 등록, vendor account 생성, webhook 또는 OAuth app wiring 같은 작업입니다. manual step list를 넘기는 대신 `/ship`(그리고 `/spec`, `/office-hours`, `/land-and-deploy`, `/setup-deploy`)은 browser를 대신 조작하겠다고 제안합니다. 권장 driver는 설치되어 있다면 Aside AI browser입니다. real logged-in session을 다루므로 vendor dashboard에 적합합니다. gstack의 visible browser(`$B` headed mode + sign-in용 handoff)는 모든 platform의 fallback입니다.

consent rule은 엄격하고 test로 pin되어 있습니다. task마다 exact site와 action을 명명하는 explicit question 하나만 묻고, standing permission은 없으며, auto-install은 절대 하지 않습니다. Mac에 Aside가 없을 때만 aside.com(macOS 15+) download pointer를 task당 한 번 제공합니다. password, payment, CAPTCHA, identity verification은 사용자 영역입니다. Apple credential 생성은 어떤 skill에서도 drive target이 아닙니다. captured secret은 chat에 나타나지 않고 owner-only file에 저장되며, gstack가 성공을 주장하기 전에 read-only API call로 검증됩니다.

---

## `/land-and-deploy`

이것은 내 **deploy pipeline mode**입니다.

`/ship`은 PR을 만듭니다. `/land-and-deploy`는 job을 끝냅니다: merge, deploy, verify.

PR을 merge하고 CI를 기다리고 deploy 완료를 기다린 뒤 production에 canary check를 실행합니다. "approved"에서 "verified in production"까지 한 command입니다. deploy가 깨지면 무엇이 실패했는지, rollback해야 하는지 알려줍니다.

새 project에서 처음 실행할 때는 irreversible한 일을 하기 전에 pipeline을 검증할 수 있도록 dry-run walkthrough를 실행합니다. 그 뒤부터는 config를 믿고 곧장 실행합니다.

### Setup

먼저 `/setup-deploy`를 실행하세요. platform(Fly.io, Render, Vercel, Netlify, Heroku, GitHub Actions, custom)을 감지하고 production URL과 health check endpoint를 찾아 CLAUDE.md에 config를 씁니다. one-time, 60초입니다.

### Example

```
You:   /land-and-deploy

Claude: PR #42를 병합하는 중...
        CI: 3/3 checks passed
        Deploy: Fly.io — v2.1.0 배포 중...
        Health check: https://myapp.fly.dev/health → 200 OK
        Canary: 5개 page 확인, console error 0개, p95 < 800ms

        production 검증 완료. v2.1.0이 live 상태입니다.
```

---

## `/canary`

이것은 내 **post-deploy monitoring mode**입니다.

deploy 후 `/canary`는 live site에 문제가 없는지 지켜봅니다. browse daemon으로 key page를 반복 방문하며 console error, performance regression, page failure, visual anomaly를 확인합니다. 주기적으로 screenshot을 찍고 pre-deploy baseline과 비교합니다.

`/land-and-deploy` 직후나 risk가 큰 deploy 후 periodic하게 실행하세요.

```
You:   /canary https://myapp.com

Claude: 2분마다 8개 page를 모니터링 중...

        Cycle 1: 모든 page 정상. p95: 340ms. console error 0개.
        Cycle 2: 모든 page 정상. p95: 380ms. console error 0개.
        Cycle 3: /dashboard — 새 console error: "TypeError: Cannot read
                   property 'map' of undefined" at dashboard.js:142
                 Screenshot saved.

        Alert: monitoring cycle 3회 후 새 console error 1개 발견.
```

---

## `/benchmark`

이것은 내 **performance engineer mode**입니다.

`/benchmark`는 page의 performance baseline을 잡습니다: load time, Core Web Vitals(LCP, CLS, INP), resource count, total transfer size. PR 전후에 실행해 regression을 잡으세요.

synthetic estimate가 아니라 browse daemon으로 실제 Chromium measurement를 수행합니다. 여러 번 실행해 평균을 내고, 결과를 저장해 PR 전반의 trend를 추적할 수 있습니다.

```
You:   /benchmark https://myapp.com

Claude: 5개 page를 benchmark하는 중(각 3회 실행)...

        /           load: 1.2s  LCP: 0.9s  CLS: 0.01  resources: 24 (890KB)
        /dashboard  load: 2.1s  LCP: 1.8s  CLS: 0.03  resources: 31 (1.4MB)
        /settings   load: 0.8s  LCP: 0.6s  CLS: 0.00  resources: 18 (420KB)

        baseline을 저장했습니다. 변경 후 다시 실행하면 비교할 수 있습니다.
```

---

## `/cso`

이것은 내 **Chief Security Officer**입니다.

어떤 codebase에서든 `/cso`를 실행하면 OWASP Top 10 + STRIDE threat model audit을 수행합니다. injection vulnerability, broken authentication, sensitive data exposure, XML external entity, broken access control, security misconfiguration, XSS, insecure deserialization, known-vulnerable component, insufficient logging을 scan합니다. 각 finding에는 severity, evidence, recommended fix가 포함됩니다.

```
You:   /cso

Claude: OWASP Top 10 + STRIDE 보안 감사 실행 중...

        CRITICAL: user search의 SQL injection (app/models/user.rb:47)
        HIGH: session token이 localStorage에 저장됨 (app/frontend/auth.ts:12)
        MEDIUM: /api/login endpoint에 rate limiting 누락
        LOW: X-Frame-Options header가 설정되지 않음

        scan한 12개 file에서 finding 4개. critical 1개, high 1개.
```

---

## `/document-release`

이것은 내 **technical writer mode**입니다.

`/ship`이 PR을 생성한 뒤 merge되기 전에, `/document-release`는 project의 모든 documentation file을 읽고 diff와 cross-reference합니다. file path, command list, project structure tree, drift된 내용을 업데이트합니다. risky하거나 subjective한 change는 question으로 surface하고, 나머지는 자동 처리합니다.

```
You:   /document-release

Claude: 3개 commit에서 변경된 21개 file을 분석했습니다. documentation file 8개를 찾았습니다.

        README.md: skill count를 9에서 10으로 업데이트하고 table에 새 skill 추가
        CLAUDE.md: project structure에 새 directory 추가
        CONTRIBUTING.md: 최신 상태 — 변경 필요 없음
        TODOS.md: item 2개 완료 표시, 새 item 1개 추가

        모든 docs를 업데이트하고 commit했습니다. PR body에도 doc diff를 반영했습니다.
```

CHANGELOG voice도 다듬고(기존 entry를 덮어쓰지 않음), completed TODO를 정리하고, cross-doc consistency를 확인하며, VERSION bump는 적절할 때만 묻습니다.

---

## `/retro`

이것은 내 **engineering manager mode**입니다.

주가 끝날 때 나는 실제로 무슨 일이 있었는지 알고 싶습니다. vibe가 아니라 data입니다. `/retro`는 commit history, work pattern, shipping velocity를 분석해 솔직한 retrospective를 작성합니다.

team-aware하게 동작합니다. command를 실행하는 사람이 누구인지 식별하고, 자신의 work에는 가장 깊은 treatment를 제공한 뒤 contributor별로 specific praise와 growth opportunity를 정리합니다. commit, LOC, test ratio, PR size, fix ratio 같은 metric을 계산합니다. commit timestamp에서 coding session을 감지하고, hotspot file, shipping streak, 이번 주 가장 큰 ship을 찾습니다.

test health도 추적합니다. total test file, 이번 period에 추가된 test, regression test commit, trend delta를 봅니다. test ratio가 20% 아래로 떨어지면 growth area로 flag합니다.

### Example

```
You:   /retro

Claude: 3월 1일 주간: commit 47개(기여자 3명), 3.2k LOC, test 38%, PR 12개, peak: 10pm | Streak: 47d

        ## 이번 주
        commit 32개, +2.4k LOC, test 41%. peak hour: 9-11pm.
        가장 큰 ship: cookie import system(browser decryption + picker UI).
        잘한 점: encryption, UI, unit test 18개가 포함된 complete feature를
        한 번의 집중된 push로 ship했습니다...

        ## 팀별 정리

        ### Alice
        app/services/에 집중한 commit 12개. 모든 PR이 200 LOC 미만으로 discipline이 좋습니다.
        개선 기회: test ratio가 12%입니다. payment가 더 복잡해지기 전에 투자할 만합니다.

        ### Bob
        commit 3개 — dashboard의 N+1 query를 고쳤습니다. 작지만 high-impact입니다.
        개선 기회: 이번 주 active day가 1일뿐입니다. 막힌 것이 있는지 확인해 볼 필요가 있습니다.

        [team win 3개, 개선할 점 3개, 다음 주 habit 3개]
```

다음 run에서 trend를 보여줄 수 있도록 JSON snapshot을 `.context/retros/`에 저장합니다.

---

## `/browse`

이것은 내 **QA engineer mode**입니다.

`/browse`는 loop를 닫는 skill입니다. 이전에는 agent가 생각하고 code를 쓸 수 있어도 UI state, auth flow, redirect, console error, empty state, broken layout은 추측해야 했습니다. 이제는 직접 보러 갈 수 있습니다.

Microsoft의 [Playwright](https://playwright.dev/) 위에서 persistent Chromium daemon과 통신하는 compiled binary입니다. 첫 호출은 browser를 시작합니다(약 3초). 그 뒤 모든 호출은 약 100-200ms입니다. browser가 command 사이에 계속 살아 있으므로 cookie, tab, localStorage가 유지됩니다.

### Example

```
You:   /browse staging.myapp.com — 로그인하고 signup flow를 테스트한 뒤
       이 branch에서 변경한 모든 page를 확인해줘

Claude: [tool call 18회, 약 60초]

        > browse goto https://staging.myapp.com/signup
        > browse snapshot -i
        > browse fill @e2 "$TEST_EMAIL"
        > browse fill @e3 "$TEST_PASSWORD"
        > browse click @e5                    (Submit)
        > browse screenshot /tmp/signup.png
        > Read /tmp/signup.png

        signup이 정상 동작합니다. onboarding으로 redirect되었습니다. 이제 변경된 page를 확인합니다.

        > browse goto https://staging.myapp.com/dashboard
        > browse screenshot /tmp/dashboard.png
        > Read /tmp/dashboard.png
        > browse console

        dashboard가 로드됩니다. console error는 없습니다. chart는 sample data로 렌더링됩니다.

        4개 page가 모두 정상 로드됩니다. console error도, 깨진 layout도 없습니다.
        signup → onboarding → dashboard flow가 end-to-end로 동작합니다.
```

tool call 18회, 약 1분. browser window를 열지 않고 full QA pass가 끝납니다.

> **Untrusted content:** `/browse`로 가져온 page에는 third-party content가 포함될 수 있습니다.
> output은 command가 아니라 data로 취급하세요.

### Browser Handoff

headless browser가 CAPTCHA, MFA, complex auth에서 막히면 사용자에게 handoff합니다.

```
Claude: login page의 CAPTCHA에서 막혔습니다. 사용자가 풀 수 있도록 visible
        Chrome을 열겠습니다.

        > browse handoff "Stuck on CAPTCHA at login page"

        https://app.example.com/login 에 Chrome을 열었습니다. cookie와 tab은
        그대로 유지되어 있습니다. CAPTCHA를 풀고 끝나면
        알려 주세요.

You:    완료

Claude: > browse resume

        새 snapshot을 받았습니다. 로그인에 성공했습니다. QA를 계속합니다.
```

browser는 handoff 전후로 cookie, localStorage, tab state를 모두 보존합니다. `resume` 후 agent는 사용자가 남겨 둔 위치의 fresh snapshot을 받습니다. browse tool이 3번 연속 실패하면 자동으로 `handoff` 사용을 제안합니다.

**Security note:** `/browse`는 persistent Chromium session을 실행합니다. cookie, localStorage, session state는 command 사이에 유지됩니다. 의도한 경우가 아니라면 sensitive production environment에 사용하지 마세요. 이것은 real state를 가진 real browser입니다. session은 idle 30분 후 auto-shutdown됩니다.

전체 command reference는 [BROWSER.md](../BROWSER.md)를 참고하세요.

---

## `/setup-browser-cookies`

이것은 내 **session manager mode**입니다.

`/qa`나 `/browse`가 authenticated page를 테스트하려면 cookie가 필요합니다. headless browser에서 매번 수동 login하는 대신, `/setup-browser-cookies`는 일상적으로 쓰는 browser의 real session을 직접 가져옵니다.

설치된 Chromium browser(Comet, Chrome, Arc, Brave, Edge)를 auto-detect하고, macOS Keychain으로 cookie를 decrypt해 Playwright session에 load합니다. interactive picker UI에서 import할 domain을 정확히 선택할 수 있고, cookie value는 절대 표시되지 않습니다.

```
You:   /setup-browser-cookies

Claude: cookie picker를 열었습니다. 가져올 domain을 선택하고
        browser에서 완료한 뒤 알려 주세요.

        [browser UI에서 github.com, myapp.com을 선택합니다.]

You:    완료

Claude: domain 2개(cookie 47개)를 가져왔습니다. session이 준비되었습니다.
```

UI를 완전히 건너뛸 수도 있습니다.

```
You:   /setup-browser-cookies github.com

Claude: Comet에서 github.com cookie 12개를 가져왔습니다.
```

---

## `/autoplan`

이것은 내 **review autopilot mode**입니다.

`/plan-ceo-review`, `/plan-design-review`, `/plan-eng-review`를 각각 실행하면 15-30개의 intermediate question에 답해야 합니다. 각 question은 가치 있지만, 때로는 모든 decision마다 멈추지 않고 gauntlet을 끝까지 돌리고 싶습니다.

`/autoplan`은 review skill을 disk에서 읽고 순서대로 실행합니다: CEO → Design(UI scope일 때) → DX(developer-facing scope일 때) → Eng(always last). required shipping gate가 stale plan이 아니라 final amended plan을 review하도록 하기 위해 Eng는 항상 마지막입니다. decision은 자동 처리합니다. 각 question은 기본적으로 recommended option으로 resolve되고, recommendation이 없을 때는 여섯 가지 encoded principle(prefer completeness, match existing patterns, choose reversible options, prefer option user chose for similar past decision, defer ambiguous items, escalate security)이 tie를 깨고 결정합니다. taste decision(close approach, borderline scope expansion, cross-model disagreement)은 저장해 final approval gate에서 보여줍니다.

command 하나로 fully reviewed plan이 나옵니다.

```
You:   /autoplan

Claude: CEO review 실행 중... [scope decision 4개 자동 해결]
        design review 실행 중... [design dimension 3개 자동 채점]
        eng review 실행 중... [architecture decision 2개 자동 해결]

        TASTE DECISIONS (입력 필요):
        1. Scope: Codex가 search 추가를 제안했습니다. 경계선에 있는 scope expansion입니다. 추가할까요?
        2. Design: 두 접근법의 점수 차이가 1점 이내입니다. 어느 쪽이 맞게 느껴지나요?

        [두 option을 context와 함께 보여줍니다.]

You:    1) 네, search 추가. 2) Option A.

Claude: plan 완료. decision 9개 자동 해결, taste decision 2개 승인.
```

---

## `/learn`

이것은 내 **institutional memory mode**입니다.

gstack는 session마다 학습합니다. pattern, pitfall, preference, architectural decision이 `~/.gstack/projects/$SLUG/learnings.jsonl`에 쌓입니다. 각 learning에는 confidence score, source attribution, reference file이 있습니다.

`/learn`으로 gstack가 흡수한 내용을 보고, specific pattern을 search하고, referenced file이 사라진 stale entry를 prune하고, team sharing용으로 export할 수 있습니다. 진짜 힘은 다른 skill에서 나옵니다. 다른 skill은 recommendation을 만들기 전에 learning을 자동 검색하고, 관련 past insight가 있으면 "Prior learning applied"를 표시합니다.

```
You:   /learn

Claude: 이 project의 learning 23개(high confidence 14개, medium 6개, low 3개)

        주요 pattern:
        - [9/10] API response는 항상 { data, error } envelope로 감쌈
        - [8/10] test는 test/support/factories.ts의 factory helper를 사용함
        - [8/10] 모든 DB query는 repository pattern을 거치며 직접 호출하지 않음

        stale 가능성이 있는 항목 3개(참조 file 삭제됨):
        - "auth middleware uses JWT" — auth/middleware.ts가 삭제됨
        [이 항목들을 prune할까요? Y/N]
```

---

## `/open-gstack-browser`

이것은 내 **co-presence mode**입니다.

`/browse`는 기본적으로 headless로 실행됩니다. agent가 보는 것을 사용자는 볼 수 없습니다. `/open-gstack-browser`는 그 점을 바꿉니다. Playwright가 제어하는 GStack Browser(anti-bot stealth가 포함된 rebranded Chromium)를 sidebar extension과 함께 실행합니다. 모든 action을 real time으로 볼 수 있습니다.

sidebar chat은 browser를 제어하는 Claude instance입니다. task에 맞는 model로 auto-route합니다. navigation과 action(click, goto, fill, screenshot)은 Sonnet, reading과 analysis(summarize, find bugs, describe)는 Opus가 맡습니다. sidebar footer에서 one-click cookie import가 가능합니다. window가 열려 있는 동안 browser는 계속 살아 있고, headed mode에서는 idle timeout이 없습니다. menu bar에는 "Chrome for Testing" 대신 "GStack Browser"가 표시됩니다.

sidebar agent는 layered prompt injection defense를 제공합니다. local 22MB ML classifier가 page와 tool output을 scan하고, Haiku transcript check가 full conversation에 vote하며, canary token이 session-exfil 시도를 잡고, verdict combiner는 block 전에 두 classifier의 agreement를 요구합니다. header의 shield icon은 status(green/amber/red)를 보여줍니다. 자세한 내용은 [ARCHITECTURE.md](../ARCHITECTURE.md#prompt-injection-defense-sidebar-agent)를 참고하세요.

```
You:   /open-gstack-browser

Claude: sidebar extension과 함께 GStack Browser를 실행했습니다.
        anti-bot stealth가 활성화되었습니다. 모든 $B command는 headed mode로 실행됩니다.
        sidebar에 입력해 browser agent에게 지시하세요.
        sidebar model routing: action은 sonnet, analysis는 opus를 사용합니다.
```

---

## `/setup-deploy`

one-time deploy configuration입니다. 첫 `/land-and-deploy` 전에 실행하세요.

deploy platform(Fly.io, Render, Vercel, Netlify, Heroku, GitHub Actions, custom)을 auto-detect하고 production URL, health check endpoint, deploy status command를 찾습니다. 모든 내용을 CLAUDE.md에 써서 future deploy가 자동으로 동작하게 합니다.

```
You:   /setup-deploy

Claude: 감지됨: Fly.io (fly.toml 찾음)
        Production URL: https://myapp.fly.dev
        Health check: /health → 200 예상
        Deploy command: fly deploy
        Status command: fly status

        CLAUDE.md에 작성했습니다. 준비되면 /land-and-deploy를 실행하세요.
```

---

## `/codex`

이것은 내 **second opinion mode**입니다.

`/review`가 Claude의 관점에서 bug를 잡으면, `/codex`는 OpenAI Codex CLI라는 완전히 다른 AI를 불러 같은 diff를 review합니다. 다른 training, 다른 blind spot, 다른 strength를 가집니다. overlap은 확실히 real일 가능성이 높고, 각 model만 찾은 finding은 혼자서는 놓쳤을 bug를 드러냅니다.

### Three Modes

**Review** — current diff에 대해 `codex review`를 실행합니다. Codex는 변경된 file을 읽고 severity(P1 critical, P2 high, P3 medium)별로 finding을 분류한 뒤 PASS/FAIL verdict를 반환합니다. P1 finding이 있으면 FAIL입니다. review는 완전히 independent합니다. Codex는 Claude의 review를 보지 않습니다.

**Challenge** — adversarial mode입니다. Codex가 code를 적극적으로 깨 보려고 합니다. edge case, race condition, security hole, load에서 실패할 assumption을 찾습니다. maximum reasoning effort(`xhigh`)를 사용합니다. logic에 대한 penetration test라고 생각하면 됩니다.

**Consult** — session continuity가 있는 open conversation입니다. codebase에 대해 무엇이든 Codex에게 물을 수 있습니다. follow-up question은 같은 session을 재사용하므로 context가 이어집니다. "내가 이걸 제대로 생각하고 있나?" 싶은 순간에 좋습니다.

### Cross-Model Analysis

`/review`(Claude)와 `/codex`(OpenAI)가 같은 branch를 review하면 cross-model comparison을 얻습니다. overlap finding은 high confidence이고, Codex-only finding은 다른 관점에서 나온 것, Claude-only finding은 Claude가 더 잘 본 지점입니다. code review에서 "두 명의 의사, 같은 환자" 접근입니다.

```
You:   /codex review

Claude: 독립적인 Codex review 실행 중...

        CODEX REVIEW: PASS (finding 3개)
        [P2] payment handler의 race condition — advisory lock 없이
             concurrent charge가 double-debit를 일으킬 수 있음
        [P3] user.email을 downcase하기 전에 null check 누락
        [P3] token comparison이 constant-time compare를 사용하지 않음

        교차 모델 분석(vs /review):
        공통 발견: payment handler의 race condition (둘 다 발견)
        Codex만 발견: token comparison timing attack
        Claude만 발견: listing photos의 N+1 query
```

---

## Safety & Guardrails

Claude Code session에 safety rail을 추가하는 4개의 skill입니다. Claude Code의 PreToolUse hook을 통해 동작하며 transparent하고 session-scoped이고 별도 configuration이 필요 없습니다.

### `/careful`

production 근처에서 작업하거나 destructive command를 실행하거나 safety net이 필요하면 "be careful"이라고 말하거나 `/careful`을 실행하세요. 모든 Bash command는 known-dangerous pattern과 대조됩니다.

- `rm -rf` / `rm -r` — recursive delete
- `DROP TABLE` / `DROP DATABASE` / `TRUNCATE` — data loss
- `git push --force` / `git push -f` — history rewrite
- `git reset --hard` — commit discard
- `git checkout .` / `git restore .` — uncommitted work discard
- `kubectl delete` — production resource deletion
- `docker rm -f` / `docker system prune` — container/image loss

일반 build artifact cleanup(`rm -rf node_modules`, `dist`, `.next`, `__pycache__`, `build`, `coverage`)은 whitelist되어 routine operation에서 false alarm을 내지 않습니다.

MEDIUM warning은 override할 수 있습니다. 두 가지 catastrophic shape는 묻지 않고 hard-deny됩니다. filesystem root/home directory recursive delete(`/*`, `~/`, `$HOME/` 형태 포함)와 repo default branch로의 force-push입니다(`--force-with-lease`는 deny를 trigger하지 않습니다. escape hatch는 session-scoped `/careful` session을 끝내는 것입니다). `~/.gstack/careful-patterns.txt`(global) 또는 `~/.gstack/projects/<slug>/careful-patterns.txt`(per-project)에 POSIX ERE를 한 줄씩 추가해 custom warn rule도 만들 수 있습니다. custom pattern은 warning을 추가만 하고 built-in을 suppress하지 않습니다. guardrail은 accident prevention이지 access control이 아닙니다.

### `/freeze`

모든 file edit를 하나의 directory로 제한합니다. billing bug를 debug할 때 Claude가 `src/auth/`의 unrelated code를 실수로 "fix"하지 않게 하고 싶다면 `/freeze src/billing`을 실행합니다. 그러면 해당 path 밖의 Edit/Write operation이 block됩니다.

`/investigate`는 이를 자동으로 활성화합니다. debug 중인 module을 감지해 그 directory로 edit를 freeze합니다.

```
You:   /freeze src/billing

Claude: edit 범위를 src/billing/로 제한했습니다. 해제하려면 /unfreeze를 실행하세요.

        [나중에 Claude가 src/auth/middleware.ts를 수정하려고 시도함]

Claude: BLOCKED — freeze boundary(src/billing/) 밖의 edit입니다.
        이 변경은 건너뜁니다.
```

참고: 이 block은 Edit/Write tool에만 적용됩니다. `sed` 같은 Bash command는 여전히 boundary 밖 file을 수정할 수 있습니다. security sandbox가 아니라 accident prevention입니다.

### `/guard`

full safety mode입니다. command 하나로 `/careful` + `/freeze`를 결합합니다. destructive command warning과 directory-scoped edit를 함께 사용합니다. prod를 만지거나 live system을 debug할 때 사용하세요.

### `/unfreeze`

`/freeze` boundary를 제거해 다시 어디든 edit할 수 있게 합니다. hook은 session에 남아 있지만 모든 것을 허용합니다. 새 boundary가 필요하면 `/freeze`를 다시 실행하세요.

---

## `/gstack-upgrade`

command 하나로 gstack를 최신 상태로 유지합니다. install type(global `~/.claude/skills/gstack` vs project vendored `.claude/skills/gstack`)을 감지하고 upgrade를 실행합니다. dual install이면 두 copy를 sync하고 변경 사항을 보여줍니다.

```
You:   /gstack-upgrade

Claude: 현재 version: 0.7.4
        최신 version: 0.8.2

        새로운 내용:
        - CAPTCHA와 auth wall을 위한 browse handoff
        - /codex multi-AI second opinion
        - /qa가 이제 항상 browser 사용
        - safety skill: /careful, /freeze, /guard
        - proactive skill suggestion

        0.8.2로 upgrade했습니다. global install과 project install을 모두 sync했습니다.
```

prompt를 완전히 건너뛰고 싶다면 `~/.gstack/config.yaml`에 `auto_upgrade: true`를 설정하세요. 새 version이 있을 때 gstack가 각 session 시작 시 조용히 upgrade합니다.

---

## Greptile Integration

[Greptile](https://greptile.com)은 PR을 자동 review하는 YC 회사입니다. race condition, security issue, CI를 통과하지만 production에서 터지는 문제 같은 real bug를 잡습니다. 실제로 나를 여러 번 구해 줬습니다. 나는 이 팀을 좋아합니다.

### Setup

[greptile.com](https://greptile.com)에서 GitHub repo에 Greptile을 설치하면 약 30초가 걸립니다. Greptile이 PR을 review하기 시작하면 gstack가 comment를 자동으로 가져옵니다. 추가 configuration은 없습니다.

### How It Works

automated reviewer의 문제는 triage입니다. Greptile은 좋지만 모든 comment가 real issue는 아닙니다. 어떤 것은 false positive이고, 어떤 것은 이미 세 commit 전에 fix한 내용을 flag합니다. triage layer가 없으면 comment가 쌓이고 결국 무시하게 됩니다. 그러면 목적을 잃습니다.

gstack는 이 문제를 해결합니다. `/review`와 `/ship`은 Greptile-aware입니다. Greptile comment를 읽고, 각 comment를 classify하고, action을 취합니다.

- **Valid issue** — critical finding에 추가하고 ship 전에 fix합니다.
- **Already-fixed issue** — catch를 인정하는 auto-reply를 남깁니다.
- **False positive** — 사용자가 confirm하면 왜 틀렸는지 설명하는 reply를 보냅니다.

결과적으로 review가 두 layer가 됩니다. Greptile은 PR에서 async하게 문제를 잡고, `/review`와 `/ship`은 normal workflow 안에서 그 finding을 triage합니다. crack으로 빠지는 일이 없습니다.

### Learning From History

사용자가 confirm한 false positive는 모두 `~/.gstack/greptile-history.md`에 저장됩니다. future run은 codebase의 known FP pattern을 auto-skip합니다. `/retro`는 Greptile의 batting average도 추적해 signal-to-noise ratio가 좋아지는지 볼 수 있게 합니다.

### Example

```
You:   /ship

Claude: [main 동기화, test 실행, pre-landing review 수행...]

        Greptile이 이 PR에서 comment 3개를 찾았습니다:

        [VALID] app/services/payment_service.rb:47 — race condition:
        concurrent charge가 double-debit를 일으킬 수 있습니다. charge block 주변에 DB-level advisory
        lock을 권장합니다.

        [ALREADY FIXED] app/models/user.rb:12 — null check 누락
        email을 downcase하기 전 null check가 필요합니다.
        → commit abc1234에서 이미 수정됨. 자동 reply합니다.

        [FALSE POSITIVE] lib/auth.rb:88 — "token comparison은
        constant-time comparison을 써야 합니다." 이미 여기서는
        ActiveSupport::SecurityUtils.secure_compare를 사용하고 있습니다.

        payment_service.rb의 race condition을 수정하는 중...

        auth token comment는 false positive입니다.
        옵션: A) Greptile에 설명 reply  B) 그래도 수정  C) 무시

You:    A

Claude: Greptile에 reply했습니다. 모든 test가 통과했습니다.
        PR: github.com/you/app/pull/42
```

Greptile comment 3개 중 하나는 real fix, 하나는 auto-acknowledged, 하나는 false positive로 reply했습니다. 추가로 든 시간은 약 30초입니다.

---

## `/ios-qa`

live-device iOS QA입니다. 이 fork의 load-bearing insight는 이것입니다. simulate하지 말고, XCTest를 실행하지 말고, WebDriverAgent를 띄우지 마세요. test 대상 app 안에 HTTP server를 embed하고, USB CoreDevice IPv6 tunnel을 통해 Mac-side daemon에서 구동하세요.

agent는 Swift source를 읽고, `@Snapshotable`로 mark된 field를 가진 `@Observable` class를 찾고, typed accessor를 codegen하고, debug bridge를 deploy한 뒤 closed find→fix→verify loop를 실행합니다.

### Architecture In One Diagram

```
       ┌──────────────────────┐   USB CoreDevice (IPv6)   ┌──────────────────┐
       │ gstack-ios-qa daemon │ ────────────────────────▶ │ iOS app          │
       │ (Mac, bun/TS)        │   bearer + X-Session-Id   │ StateServer      │
       │ - rotates boot token │                           │ (loopback only)  │
       │ - mints session toks │                           └──────────────────┘
       │ - capability tiers   │
       │ - audit + redact     │
       └──────────────────────┘
                ▲
                │ Tailscale (optional, --tailnet)
                │
       ┌──────────────────────┐
       │ Remote agent         │
       │ (OpenClaw, etc.)     │
       └──────────────────────┘
```

iOS app의 `StateServer`는 loopback에만 bind합니다(`::1` + `127.0.0.1`). Mac daemon은 tailnet identity validation, capability tier, audit trail을 담당합니다. remote agent는 boot token을 절대 보지 않습니다. Tailscale identity gating으로 mint된 short-lived session token(기본 1h, hard cap 24h)만 봅니다.

### Unlock: USB-Tethered + Tailscale = Any Agent에서 Remote iOS QA

이미 가진 Mac과 iPhone, 그리고 Tailscale free tier만으로 대부분의 team이 BrowserStack/Sauce Labs에 비용을 내는 use case를 대체할 수 있습니다. tailnet의 HTTP-capable agent는 session token을 mint한 뒤 iOS app을 구동할 수 있습니다. Tailscale ACL은 어떤 identity가 어떤 capability tier로 Mac에 접근할 수 있는지 제한합니다.

runnable setup은 `ios-qa/docs/tailscale-acl-example.md`를 참고하세요.

### Capability Tiers

| Tier | Endpoints |
|------|-----------|
| observe | `/screenshot`, `/elements`, `GET /state/*`, `/state/snapshot`, `/healthz` |
| interact | observe + `/tap`, `/swipe`, `/type`, `/session/*` |
| mutate | interact + `POST /state/<key>` |
| restore | mutate + `POST /state/restore` |

기본 mint token은 `interact` 권한을 받습니다. 더 높은 tier는 owner의 explicit mint가 필요합니다.

---

## `/ios-fix`

Iron Law: reproducing snapshot 없는 fix 금지. agent는 `GET /state/snapshot`으로 bug 이전 상태를 capture하고, fix를 작성하고, rebuild, redeploy, snapshot restore, bug 소멸 검증을 수행합니다. snapshot은 regression test fixture가 되어 bug가 조용히 재발하지 못하게 합니다.

iOS용 `/qa`의 find-bug → fix → re-verify loop라고 보면 됩니다.

---

## `/ios-design-review`

real iPhone에서 designer's-eye QA를 수행합니다. 같은 `/ios-qa` daemon에 observe-tier mode로 연결해 모든 screen을 screenshot합니다. 10개 dimension을 0-10으로 평가합니다: typography hierarchy, spacing rhythm, color hierarchy, touch target, loading/empty/error state, accessibility, animation discipline, iOS idiom alignment, information density, AI-slop check.

점수가 7 미만인 항목마다 AskUserQuestion으로 issue와 recommended fix를 제시합니다.

---

## `/ios-clean`

convenience wrapper입니다. DebugBridge가 release build에 ship되지 않도록 하는 structural guard는 `Package.swift`(`.when(configuration: .debug)`)와 CI invariant test에 있습니다. `/ios-clean`은 guided removal flow를 원하거나 `/ios-qa`를 거치지 않고 SPM dependency를 수동으로 추가한 developer를 위한 skill입니다.

---

## `/ios-sync`

gstack를 upgrade하거나 새 `@Observable` class를 추가한 뒤 실행합니다. 설치된 내용을 감지하고 latest upstream template으로 gen-accessor를 실행하며, 변경된 Swift file을 refresh하고 app rebuild를 검증합니다. cache-key invalidation은 Swift version change, generator git rev change, source change를 처리합니다.
