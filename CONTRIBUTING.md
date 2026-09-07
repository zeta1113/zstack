# gstack에 기여

gstack 더 나은 만들기를 원하신다면, 기술 프롬프트에서 태풍을 고정하거나 완전히 새로운 워크플로우를 구축할 수 있는 것이든, 이 가이드가 빠르게 진행할 수 있습니다.

## 빠른 시작

gstack 기술은 Markdown 파일 Claude Code가 `skills/` 디렉토리에서 발견된다. 일반적으로 `~/.claude/skills/gstack/` (당신의 글로벌 설치)에서 살고 있다. 그러나 gstack 자체 개발할 때, 당신은 Claude Code 기술을 사용 하 여 원하는 *당신의 작업 나무에서* - 그래서 복사 또는 배포 없이 즉시 효과를 수정.

즉, dev 모드가 무엇인지. 그것은 repo 로컬 `.claude/skills/` 디렉토리에 Claude Code가 체크 아웃에서 바로 기술을 읽습니다.

```bash
git clone https://github.com/garrytan/gstack.git && cd gstack
bun install                    # install dependencies
bin/dev-setup                  # activate dev mode
```

> **전체 클론 대 얕은.** The README's user-facing install uses `--depth 1` for speed. As a contributor, use a full clone (no `--depth` flag) — you'll need history for `git log`, `git blame`, `git bisect`, and reviewing PRs against earlier versions. If you already have a `--depth 1` clone from following the README, promote it to a full clone with `git fetch --unshallow`.

`SKILL.md`, Claude Code (예: `/review`)에서 호출하고, 변경을 라이브 볼 수 있습니다. 개발할 때:

```bash
bin/dev-teardown               # deactivate — back to your global install
```

## 운영 자체 개선

gstack는 실패에서 자동적으로 삽니다. 각 기술 회의의 끝에, 에이전트은 무슨 잘못되었는지에 반영합니다 (CLI 과실, 잘못된 접근, 프로젝트 quirks) 및 `~/.gstack/projects/{slug}/learnings.jsonl`에 가동 학습을 기록합니다. 미래 세션은 이 학습을 자동적으로, 그래서 gstack는 당신의 코디베이스에 더 똑똑한 시간을 가져옵니다.

No 설치가 필요합니다. 학습은 자동으로 로그됩니다. `/learn`로 보기.

### 기여자 워크플로우

1. **사용 gstack 일반적으로** - 운영 학습은 자동으로 캡처됩니다.
2. **학습을 확인:** `/learn` 또는 `ls ~/.gstack/projects/*/learnings.jsonl`
3. **Fork and clone gstack** (당신은 이미 못하지 않은 경우)
4. **fork를 버그를 명중하는 프로젝트에 심볼:**
   ```bash
   # In your core project (the one where gstack annoyed you)
   ln -sfn /path/to/your/gstack-fork .claude/skills/gstack
   cd .claude/skills/gstack && bun install && bun run build && ./setup
   ```
   설정은 SKILL.md symlinks 내부 (`qa/SKILL.md -> gstack/qa/SKILL.md`), 각 기술 실행 시간 자산을 연결 (섹션 / 템플릿, 체크리스트 - 모든 제외 SKILL.md, 테스트, 출력 및 `.tmpl` 소스), 그리고 당신의 접두사 선호도를 요청합니다. `--no-prefix`를 통과하고 신속한 사용 짧은 이름을 건너뛰기 위해 `--no-prefix`를 선택하십시오.
5. **문제 수정** — 변경은 이 프로젝트에서 즉시 생생합니다.
6. **gstack를 이용하여 실제로 시험** - 너를 성악한 일을 하려면, 그것을 고정 확인
7. **포크에서 PR를 엽니다**

이것은 기여하는 가장 좋은 방법입니다: 당신이 실제로 고통을 느꼈다 프로젝트에서 실제 작업을하고있는 동안 gstack를 수정합니다.

### 세션 인식

gstack 세션이 동시에 열립니다. 각 질문은 branch, 그리고 무슨 일이 일어나는지, 프로젝트가 당신에게 알려줍니다. No는 질문 생각 "wait, 즉 창이?" 형식이 모든 기술에 걸쳐 일관성이 있습니다.

## gstack 내부 gstack repo 작업

gstack 기술을 편집하고 gstack를 repo, `bin/dev-setup` 철사로 실제로 사용해서 시험하고 싶을 때 이것 위로. 그것은 `.claude/skills/` symlinks (gitignored)를 당신의 작업 나무에 돌려 놓는, 그래서 Claude Code는 당신의 국부적으로 편집을 글로벌 설치 대신 사용합니다.

```
gstack/                          <- your working tree
├── .claude/skills/              <- created by dev-setup (gitignored)
│   ├── gstack -> ../../         <- symlink back to repo root
│   ├── review/                  <- real directory (short name, default)
│   │   └── SKILL.md -> gstack/review/SKILL.md
│   ├── ship/                    <- or gstack-review/, gstack-ship/ if --prefix
│   │   └── SKILL.md -> gstack/ship/SKILL.md
│   └── ...                      <- one directory per skill
├── review/
│   └── SKILL.md                 <- edit this, test with /review
├── ship/
│   └── SKILL.md
├── browse/
│   ├── src/                     <- TypeScript source
│   └── dist/                    <- compiled binary (gitignored)
└── ...
```

Setup creates real directories (not symlinks) at the top level with a SKILL.md symlink inside, plus links to each skill's runtime assets (sections/, templates, checklists). Alias skills (`_gstack-command`, `connect-chrome`) install as rewritten copies, never symlinks — editing a symlinked alias would corrupt the generated source. This ensures Claude discovers them as top-level skills, not nested under `gstack/`. Names depend on your prefix setting (`~/.gstack/config.yaml`). 짧은 이름 (`/review`, `/ship`)는 기본입니다. namespaced 이름을 선호하는 경우 `./setup --prefix`를 실행하십시오 (`/gstack-review`, `/gstack-ship`).

## 일 일 워크플로우

```bash
# 1. Enter dev mode
bin/dev-setup

# 2. Edit a skill template (SKILL.md files are generated — edit the .tmpl)
vim review/SKILL.md.tmpl
bun run gen:skill-docs   # or: bun run dev:skill (watch mode, auto-regen on change)

# 3. Test it in Claude Code — changes are live
#    > /review

# 4. Editing browse source? Rebuild the binary
bun run build

# 5. Done for the day? Tear down
bin/dev-teardown
```

### 뇌 인식 블록 dev 작업 공간 (gbrain install)

gbrain이 설치되고 사용 가능한 경우 (`bin/gstack-gbrain-detect --is-ok` 종료 0), `bin/dev-setup` 트랙을 유지 `SKILL.md` 파일 캐논ical 및 렌더링 뇌 인식 변형 (`GBRAIN_CONTEXT_LOAD` / `GBRAIN_SAVE_RESULTS` 블록) `.claude/gstack-rendered/` (gitignored, per-workspace). 그런 다음 렌더링에서 workspace의 `SKILL.md` symlinks를 다시 설정하면 Claude (gitignored, per-workspace)가 전체적으로 gbrain이 되도록 합니다. 두건에서 dev-setup은 `GSTACK_SKIP_GBRAIN_REGEN=1` 인라인을 배열 `./setup` (그래서 그것은 결코 먼지가 추적 소스)를 전달하고 렌더링에 포인트를하는 섹션베이스 경로만 다시 작성하는 `gen:skill-docs:user --out-dir .claude/gstack-rendered`를 실행합니다. `bin/dev-teardown`는 렌더링을 제거합니다. *기타* 프로젝트의 Claude 세션에서 블록을 살려면 `gstack-config gbrain-refresh`를 실행하고, 유저 렌더링 디디르 (`${GSTACK_USER_RENDER_DIR:-~/.gstack/render/claude}`, 성공적인 렌더링에만 스왑)을 렌더링하고 `gstack-relink`를 통해 설치 된 기술을 다시 지정합니다. 글로벌 인스톨 체크 아웃은 git-clean을 유지하고, 새로 고침을 통해 symlinked 또는 non-gstack 디렉토리를 결코 만지지 않습니다.

## 테스트 및 evals

## 설정

```bash
# 1. Copy .env.example and add your API key
cp .env.example .env
# Edit .env → set ANTHROPIC_API_KEY=sk-ant-...

# 2. Install deps (if you haven't already)
bun install
```

Bun 자동 로드 `.env` - no 추가 구성. 지휘자 작업 공간은 main worktree에서 `.env`를 자동적으로 상속합니다 (아래 "Conductor workspaces"를 보십시오).

### 시험 층

| Tier | Command | Cost | 테스트 |
|------|---------|------|---------------|
| 1 - 정적 | `bun run test` | 의 % | 명령 검증, snapshot 플래그, SKILL.md 정정, TODOS-format.md refs, 관측성 단위 테스트 |
| 2 — E2E | `bun run test:e2e` | ~$4.20 | `claude -p` 서브프로세스를 통한 풀 스킬 실행 |
| 3 - LLM eval | `EVALS=1 bun test test/skill-llm-eval.test.ts` | ~$0.15 독립 | LLM-as-judge 생성된 SKILL.md docs의 득점 |
| 2+3 | `bun run test:evals` | ~$4 결합 | E2E + LLM-s-judge (모두를 실행) |

```bash
bun run test                 # Tier 1 only (run before every commit, ~90-100s for the full ~8,700-test suite)
bun run test:e2e             # Tier 2: E2E only (needs EVALS=1, can't run inside Claude Code)
bun run test:evals           # Tier 2 + 3 combined (~$4.35/run)
```

## Tier 1: 정적 유효성 (무료)

Runs with `bun run test`, which routes through `scripts/test-free-shards.ts`: N concurrent shard processes under a strict output contract — a shard that exits without bun's own terminal summary line, or a crashed worker, fails the run, so silent truncation can never report green. Pass `--verbose` to forward the full child stream; `--wall-timeout <secs>` overrides the per-shard kill deadline. `GSTACK_FREE_JOBS=<n>`는 shard count (digits only, 확성한 쓰레기)를 과 `GSTACK_FREE_RETRY_FLAKY=1`는 syscall-supervised sandboxes (default 로컬로 - dev box가 흔들림을 볼 수 있다; 필요한 CI 자유 레인은 그것에 그것을 켜고 JSONL ledger artifact에 있는 각 플라키 통행을 올려 놓습니다 `bun run eval:flake-rank`는 구름에 있는 겹을 겹켜야 합니다. 부팅 당 `scripts/sandbox-doctor.sh`를 실행하면 스위트 실행 녹색 ([docs/TESTING_INTERNALS.md](docs/TESTING_INTERNALS.md)의 세부 사항)을 만들 수 있습니다. 스위트의 경우 `bun test`를 입력하지 마십시오. 전체 repo를 걸어, 유료 eval 파일을로드하고 엄격한 클래스터를 놓습니다. No API 키가 필요합니다.

- **기술 파서 테스트** (`test/skill-parser.test.ts`) - `$B` 명령을 SKILL.md bash 코드 블록에서 추출하고 `browse/src/commands.ts` 명령 레지스트리에 대한 검증. 캐치 태스, 명령 제거, 잘못된 snapshot 플래그.
- **기술 검증 시험** (`test/skill-validation.test.ts`) - SKILL.md 파일 참조만 실제 명령과 플래그만 유효하며, 그 명령 설명은 품질 임계값을 충족합니다.
- **발전기 시험** (`test/gen-skill-docs.test.ts`) - 템플릿 시스템을 테스트합니다. 위주자는 올바르게 해결하고 출력은 flag(예: `-d <N>`)에 대한 값 힌트를 포함하며, 키 명령에 대한 설명이 풍부하게 됩니다. (예: `is` 목록 유효국, `press` 목록 키 예제).
- **계층 정렬 invariant** (`test/e2e-tier-alignment.test.ts`) - 터치파일 dep 목록에 이름을 붙인 각 자음 `test/skill-e2e-*.test.ts`를 위해, 파일 `EVALS_TIER` 자체 문은 `E2E_TIERS`에 선언된 층과 일치해야 합니다. 시험이 `touchfiles.ts`에서 재 등급을 매기는 "inert demotion" 클래스를 죽이고, 오래된 층에 여전히 문이 있고 잘못된 차선에서 실행하십시오. 지도 또는 혼합 계층은 결코 침묵하지 않습니다.
- **카탈로그 예산** (`test/catalog-budget.test.ts`) - 집계 발견 표면 캡 : 모든 기술의 frontmatter `name` + `description` (각 세션에서 모든 호스트 부하가 있는지) 1,150 토큰 - 해당, 260 바이트 당 - skill 캡과 함께 유지해야합니다. 계산은 `test/helpers/skill-census.ts` (물리 파일 대 승인 기술 대역 기록 항목 - 세 가지 기술 의 계산 기술 추가)에서 공유 된 인구 통계를 통해 간다. 실패 메시지는 재 측정 + ratchet 프로토콜을 수행합니다.
- **Context-budget 래치** (`test/context-budget-ratchet.test.ts`) - CI 천장은 두 token ledgers에 카탈로그 예산이 커버되지 않습니다: 항상-에 전-frontmatter 집계 및 각 기술의 per-invocation eager 토큰 (SKILL.md + 강제 참조), `test/fixtures/context-budget.json`에 대한 등급을 매겨 `lib/context-bill.ts`. 새로운 기술은 천장이있을 때까지 실패; 제거 기술에 대한 기술은 증가 또는 토지의 증가를해야합니다. `bun test/helpers/capture-context-budget.ts`와 commit는 동일한 commit에 있는 새로 고침 정착물, 그래서 변화는 diff에 있는 눈에 보이는 결정입니다.

## Tier 2: E2E `claude -p` (~$4.20/run)

`--output-format stream-json --verbose`를 가진 하위 처리로, NDJSON를 실시간 진행을 위해 스트림, 그리고 검색 오류를 스캔합니다. 이것은 "이 기술이 실제로 작동을 종료하는 데 가장 가까운 것입니까?"

```bash
# Must run from a plain terminal — can't nest inside Claude Code or Conductor
EVALS=1 bun test test/skill-e2e-*.test.ts
```

- `EVALS=1` env var (비싸게이션을 전개)
- Claude Code (`claude -p`는 배열할 수 없습니다) 안쪽에 달리는 경우에 자동 스키
- API 연결성 사전 검사 — 예산을 점화하기 전에 ConnectionRefusion에 빠지게 실패
- stderr: `[Ns] turn T tool #C: Name(...)`에 실시간 진행
- 디버깅을 위한 NDJSON 성적 및 실패 JSON를 저장하십시오
- `test/skill-e2e-*.test.ts` (분류로 나누기), `test/helpers/session-runner.ts`의 주자 논리

**기본적으로 Hermetic.** 각 E2E 주자 (클래드 -p, real-PTY 계획 형태 주자, 에이전트 SDK 주자, 코드 및 gemini 주자)는 `test/helpers/hermetic-env.ts`를 통해 그것의 아이를 향합니다: 수당 scrubbed 환경, 신선한씨가 쳐진 `CLAUDE_CONFIG_DIR`, 임시 직원 `GSTACK_HOME`, 그리고 `--strict-mcp-config`. `~/.claude` config, MCP 서버 (gbrain, 지휘자), 기술, `~/.gstack` 결정 로그 및 `CONDUCTOR_*` env 결코 아이로 누출하지 않고 로컬 eval 신호 일치 CI 대신 테스트 아래 코드와 관련되지 않는 이유를 인식하지 않는. 신비한 `CLAUDE_CONFIG_DIR`씨 no 기술 default; PTY는 `/skill` 명령을 입력하는 `/skill` 시험: `/skill`는 slashse 명령어를 전달했습니다: true` to the PTY runner, which swaps in `hermeticSkillsConfigDir()` — a seeded skill registry that symlinks the LIVE working tree's SKILL.md files (by design: the skills are the subject under test, so a snapshot would measure stale copies). Set `EVALS_HERMETIC=0` to debug against your real operator state (this also drops `--strict-mcp-config`). 배선은 `test/hermetic-wiring.test.ts` (무료 정적 삼각대), `test/skill-e2e-hermetic-canary.test.ts`의 두 개의 게이트 계층 고립 관할 및 기술 보행 삼각대에 의해 핀으로 꼿습니다
`test/hermetic-skills-seeding.test.ts` / `test/pty-skill-seeding-wiring.test.ts`.

## E2E 관측성

E2E 테스트 실행 시 `~/.gstack-dev/`의 기계 읽기 쉬운 artifacts를 생성합니다.

| 의약 | Path | 의논하기 |
|----------|------|---------|
| 팟캐스트 | `e2e-live.json` | 현재 시험 상태 (도구 통화 당 업데이트) |
| 부분적인 결과 | `evals/_partial-e2e.json` | 완료된 시험 (살아있는 살인) |
| 진행 로그 | `e2e-runs/{runId}/progress.log` | Append-only 텍스트 로그 |
| NDJSON 성적표 | `e2e-runs/{runId}/{test}.ndjson` | 시험 당 원료 `claude -p` 산출 |
| Failure JSON | `e2e-runs/{runId}/{test}-failure.json` | 실패에 진단 자료 |

**라이브 대시보드:** 실행 `bun run eval:watch` 두 번째 터미널에서 완료된 테스트를 보여주는 라이브 대시보드를 볼 수 있습니다. 현재 진행중인 테스트 및 비용. `--tail`를 사용하여 진행 상황을 확인할 수 있습니다.

**Eval 역사 도구:**

```bash
bun run eval:list            # list all eval runs (turns, duration, cost per run)
bun run eval:compare         # compare two runs — shows per-test deltas + Takeaway commentary
bun run eval:summary         # aggregate stats + per-test efficiency averages across runs
bun run eval:flake-rank      # rank tests by flake signal: retried passes first, then failure rate (--json, --dir, --since-days)
```

**에이전트 및 긴 스위트에 대한 분리 된 실행.** 에이전트가 되면 (또는, 실행을 위해 당신은 babysit을 원하지 않는다) 긴 eval을 실행하고 `eval:bg*` 스크립트를 사용합니다. 그들은 `bin/gstack-detach`의 eval 명령을 포장합니다. 턴바운드 SIGTERM를 탈출하는 신선한 세션은, `caffeinate` 래퍼는 idle-sleep를 차단하는, 기계 넓은 `gstack-evals` 자물쇠로 이렇게 concurrent worktrees는 모형 API를 포화하는 대신에 일련을, `~/.gstack-dev/eval-runs/`, per-tier watchdog의 밑에 뛰기된 통나무, 그리고 보장한 `### gstack-detach EXIT=<code> ###` sentinel 그래서 poller 결코 성공을 위한 침묵을 방해하지 않습니다.

```bash
bun run eval:bg              # detached test:evals (diff-based)
bun run eval:bg:all          # detached test:evals:all
bun run eval:bg:gate         # detached gate-tier suite
bun run eval:bg:periodic     # detached periodic-tier suite
```

각 인쇄 로그 경로. 게이트와 주기 변형은 sharded 유료 런너 (`scripts/test-paid-shards.ts`, 또한 `bun run test:gate:sharded` / `bun run test:periodic:sharded`)로 직접 사용할 수 있습니다. 테스트 파일 당 하나의 Bun 프로세스, shard의 전체 프로세스 그룹을 죽이는 외부 벽시 타임 아웃 (stray `claude`/`codex` grandchildren 포함), per-shard eval dir (`GSTACK_EVAL_DIR=<evalDir>/shards/<slug>/`), 그리고 결코 시작된 shards를 구별하는 집단. 주자도 선택 diff: shards는 branch: shards는 shards로 보고된 모든 것을 가진 branch (>). `EVALS_JOBS`는 한 번에 실행하는 몇 개의 shard 프로세스가 어떻게 설정합니까 (default 8); `EVALS_CONCURRENCY`는 bun's concurrency WITHIN a shard (default 2)입니다. 그들은 deliberately 분리 된 손잡이입니다. `eval:list`, `eval:compare`, `eval:summary`, `eval:flake-rank`는 shard-aware입니다. 인간들은 `bun run test:evals`ground를 실행하는 것은이 Ctrl-C가 필요합니다.

**Eval 비교 해설:** `eval:compare`는 뛰기 사이 무슨 변화하는 자연적인 언어 테이크아웃 단면도를, 감소시키기 개량, 밖으로 불러오기 효율성 이익을 (범류 회전, 더 빠르, 더 싼), 및 전반적인 요약 생성하. 이것은 `eval-store.ts`에서 `generateCommentary()`에 의해 모입니다.

Artifact는 결코 청소되지 않습니다 — 그들은 포스트 모르템 디버깅 및 동향 분석을 위해 `~/.gstack-dev/`에서 축적했습니다.

### Tier 3: LLM-as-judge (~$0.15/run)

Claude Sonnet을 사용하여 생성된 SKILL.md docs를 세 가지 차원으로 변환합니다. `GSTACK_EVAL_MODEL_JUDGE`와 함께 실행할 수 있는 판단 모델을 무시합니다:

- **팟캐스트** — AI 에이전트은 주변 환경 없이 지시를 이해할 수 있습니까?
- **의성** - 모든 명령, 플래그, 사용 패턴이 문서화되었습니까?
- **활동성** - 에이전트는 doc에 있는 정보를 사용하여 작업을 실행할 수 있습니까?

각 차원은 1-5를 점수를 매깁니다. 임계값: 각 차원은 **≥ 4**를 점수를 매야 합니다. `origin/main`에서 생성한 지분에 대하여 생성된 docs를 비교하는 회귀 시험도 있습니다 — 생성된 득점은 동등한 것 또는 더 높아야 합니다.

```bash
# Needs ANTHROPIC_API_KEY in .env — included in bun run test:evals
```

- 안정성 득점을 위한 `claude-sonnet-4-6`를 사용하십시오
- `test/skill-llm-eval.test.ts`에서 라이브 테스트
- Anthropic API를 직접 호출합니다 (`claude -p`), 그래서 그것은 어디에서나 Claude Code를 포함하여 작동합니다

### CI

GitHub 동작 (`.github/workflows/skill-docs.yml`)는 push와 PR에 `bun run gen:skill-docs --dry-run`를 실행합니다. 생성된 SKILL.md 파일이 무엇이 투입되는지, CI 실패하는 경우에. 이 캐치는 그들이 합병하기 전에 stale docs를 붙입니다.

공급 체인 게이트는 다음과 같이 실행합니다.

- **품질문** (`.github/workflows/quality-gate.yml`, every PR and push) — scans the diff's added lines for credentials using gstack's own redact engine (`.github/scripts/gate-secret-scan.mjs`). HIGH findings fail the job; MEDIUM findings surface as an advisory count. Fails closed if the scan can't produce a report. Also gates critical dependency advisories and runs ShellCheck on the setup/build boundaries.
- **Dependency 리뷰** (`.github/workflows/dependency-review.yml`) - lockfiles 또는 워크플로 파일을 터치 PR에 의존도 변경 사항.
- **OSV 스캐너** (`.github/workflows/osv-scanner.yml`) - OSV 데이타베이스에 대한 주간 취약점 검사. `.osv-scanner.toml`에서 생명을 곱하고 `--config` 플래그 (OSV는 파일명 자동 발견하지 않습니다); 각 무시 항목은 이유와 `ignoreUntil` expiry, `test/osv-config-wiring.test.ts`에 의해 시행됩니다.
- **이란봇** (`.github/dependabot.yml`) - 그룹화 된 의존성 업데이트 PR.

공급 체인 워크플로는 commit SHAs에 제 3 자 작업을 핀으로 꼿습니다. PR 템플릿 (`.github/PULL_REQUEST_TEMPLATE.md`)은 증거를 요청합니다. - 테스트 실행, eval 출력 - 약속하지 않습니다.

이진을 직접 찾아서 실행하는 테스트 — 그들은 dev 모드가 필요하지 않습니다.

## 편집 SKILL.md 파일

SKILL.md 파일은 `.tmpl` 템플릿에서 **제품정보**입니다. `.md`를 직접 편집하지 마십시오. 변경은 다음 빌드에서 overwritten이됩니다.

```bash
# 1. Edit the template
vim SKILL.md.tmpl              # or browse/SKILL.md.tmpl

# 2. Regenerate for all hosts
bun run gen:skill-docs --host all

# 3. Check health (reports all hosts)
bun run skill:check

# Or use watch mode — auto-regenerates on save
bun run dev:skill
```

템플릿 작성자 최고의 관행 (생각주의 이상 자연 언어, 동적 branch 검출, `{{BASE_BRANCH_DETECT}}` 사용), CLAUDE.md의 "Writing SKILL 템플릿" 섹션을 참조하십시오.

검색 명령을 추가하려면 `browse/src/commands.ts`에 추가하십시오. snapshot 플래그를 추가하려면 `SNAPSHOT_FLAGS` `browse/src/snapshot.ts`에서 `SNAPSHOT_FLAGS`로 추가하십시오. 그런 다음 다시 빌드하십시오.

**기술에 묶음 puppeteer/Chromium.** `browse`는 오프라인 로컬 렌더링 작업 부하를 포함하여 상자 당 하나의 공유 Chromium입니다. HTML/JSON (diagrams, card, og-images)를 rasterize해야 하는 기술은 `browse` - `screenshot --selector`를 통해 시각화 출력, `load-html` + `js --out`를 통해 바이트를 렌더링 함수 반환합니다 - 대신 `npm i puppeteer` 그리고 Chromium를 설치하고 Chromium를 syncing하는 것을 돕는 `load-html`를 설치합니다.

## Jargon 목록 (V1 쓰기 스타일)

gstack의 쓰기 스타일 섹션 (모든 계층 ≥2 기술의 전단에 주입) 기술은 기술 주장 당 첫 번째 사용에 기술 용어를 광택. `scripts/jargon-list.json`에서 광택 생활에 대한 자격이되는 용어 목록 - ~50 curated 고주파 용어 (idempotent, 인종 조건, N+1, backpressure 등). 목록의 사용은 충분히 일반 영어를 가정한다.

**용어를 추가하거나 제거 :** `scripts/jargon-list.json` 편집 PR를 엽니다. 편집 후에 `bun run gen:skill-docs`를 실행하십시오 - 기간은 gen 시간에 각 생성한 SKILL.md로 구워집니다, 그래서 재생 후에 효력을 단지 바꿉니다. No 가동 시간 선적; no 사용자 측 과다. repo 명부는 진실의 근원입니다.

또한 좋은 후보자 : 비 기술 사용자가 컨텍스트없이 검토 출력에 직면하는 고주파 용어 (일반 데이터베이스/concurrency 용어, 보안 사각형, frontend 프레임 워크 개념). 하나 또는 두 개의 틈새 기술에 표시된 용어를 추가하지 마십시오. 비용 가치 거래는 검토 오버 헤드 가치가 없습니다.

## 멀티 호스트 개발

gstack는 `.tmpl` 템플릿 중 하나에서 10개의 호스트를 위한 SKILL.md 파일을 생성합니다. 각 호스트는 `hosts/*.ts`에 있는 유형의 구성입니다. 발전기는 호스트 적합 산출 (다른 frontmatter, 경로, 도구 이름)를 생성하기 위하여 이 구성을 읽습니다.

**지원된 호스트:** Claude (주), Codex, 공장, Kiro, OpenCode, Slate, Cursor, OpenClaw, Hermes, GBrain.

## 모든 호스트에 대한 생성

```bash
# Generate for a specific host
bun run gen:skill-docs                    # Claude (default)
bun run gen:skill-docs --host codex       # Codex
bun run gen:skill-docs --host opencode    # OpenCode
bun run gen:skill-docs --host all         # All 10 hosts

# Or use build, which does all hosts + compiles binaries
bun run build
```

## 호스트의 변화

각 호스트 설정 (`hosts/*.ts`) 제어:

| 의 특징 | 예제 (Claude 대 Codex) |
|--------|---------------------------|
| 출력 디렉토리 | `{skill}/SKILL.md` 대 `.agents/skills/gstack-{skill}/SKILL.md` |
| 프론트 매트 | Full (name, description, Hooks, version) 최소 대 (name + description) |
| Paths | `~/.claude/skills/gstack` 대 `$GSTACK_ROOT` |
| Tool 이름 | "Bash 도구" 대 동일 (이 명령을 실행하는 공장) |
| 훅 기술 | `hooks:` frontmatter 대 인라인 안전 자문 |
| 연락처 | None 대 Codex 각자 invocation 단면도 벗겨지는 |
| 모형 오버레이 | `claude` vs `gpt` (퍼 호스트 `defaultModel`; `--model` 또는 설정 시간, Codex `config.toml` 모델 오버라이드) |

`scripts/host-config.ts`를 전체 `HostConfig` 인터페이스에 참고하세요.

### 테스트 호스트 출력

```bash
# Run all static tests (includes parameterized smoke tests for all hosts)
bun run test

# Check freshness for all hosts
bun run gen:skill-docs --host all --dry-run

# Health dashboard covers all hosts
bun run skill:check
```

### 새 호스트 추가

전체 가이드에 대한 [docs/ADDING_A_HOST.md](docs/ADDING_A_HOST.md)를 참조하십시오. 짧은 버전:

1. `hosts/myhost.ts` (`hosts/opencode.ts`에서 복사)
2. `hosts/index.ts`에 추가
3. `.myhost/`를 `.gitignore`로 추가하십시오
4. `bun run gen:skill-docs --host myhost`를 실행하십시오
5. `bun run test` (전극적으로 시험은 그것을 덮습니다)

Zero generator, 설정, 툴링 코드 변경이 필요합니다.

### 새로운 기술을 추가

새로운 기술 템플릿을 추가하면 모든 호스트가 자동으로 얻습니다.
1. `{skill}/SKILL.md.tmpl` 만들기
2. `bun run gen:skill-docs --host all`를 실행하십시오
3. 동적 템플릿 발견은 그것을 선택합니다, no static list to update
4. 예산 : `bun test/helpers/capture-context-budget.ts` 및 commit 새로 고침 `test/fixtures/context-budget.json` - 문맥 판자 래치드는 천장없이 모든 기술을 실패
5. Commit `{skill}/SKILL.md`, 외부 호스트 출력은 설정 시간 및 gitignored에서 생성됩니다.

## 지휘자 작업 공간

[의 GSM](https://conductor.build)를 사용하여 병렬에 여러 Claude Code 세션을 실행하려면 `conductor.json`를 자동으로 작업 공간 수명주기를 늘리십시오.

| 힌디어 | Script를 | 역할 |
|------|--------|-------------|
| `setup` | `bin/dev-setup` | 메인 워크 트리에서 복사 `.env`, symlinks 기술을 설치, 실행 `./setup` 비-interactively, 그리고 (gbrain가 설치되는 경우에)는 더럽히는 궤도 근원 없이 `.claude/gstack-rendered/`로 뇌 인식 구획을 만듭니다 |
| `archive` | `bin/dev-teardown` | 기술 symlinks, `.claude/gstack-rendered/` 렌더링 제거 및 `.claude/` 디렉토리 정리 |

지휘자가 새로운 작업 공간을 만들 때, `bin/dev-setup`는 자동적으로 달립니다. 그것은 주요 worktree (`git worktree list`를 통해)를 검출하고, `.env`를, 이렇게 복사합니다 API 열쇠를, 그리고 dev 형태를 놓습니다 — no 수동 단계 필요로 합니다.

`bin/dev-setup`는 `./setup` 완전하게 비동작적으로 (그것은 `--plan-tune-hooks=prompt`를 통과하고 stdin를 닫습니다), 그래서 앞으로 지휘자 TTY는 숨겨지은 체제를 멈출 수 없습니다. 또한 계획튠 Claude Code 걸이를 설치하지 않으며, 탈취 작업 공간은 당신의 세계적인 `~/.claude/settings.json`를 ephemeral worktree 경로에 점으로 바꾸지 않을 수 있습니다. 계획 실리를 설치하기 위하여 `./setup --plan-tune-hooks`는, 외부 `./setup --plan-tune-hooks`를 뛰기 위하여 `~/.claude/settings.json`를 뛰기 위하여. 명시된 플래그는 다음과 같은 결정으로 계산합니다. AskUserQuestion 훅의 설정은 진정한 침묵 낙하 (no 플래그, no `GSTACK_PLAN_TUNE_HOOKS` env var, no `plan_tune_hooks` config에서 config에서 의 key말리 존재를 위해, `gstack-config has` 를 통해 체크한, 그래서 훅을 설치하기 위해 dev-setup을 무시할 수 없습니다. 1개의 명시된 수리 예외: 설정의 치유 첫 번째 패스 (`gstack-settings-hook prune-stale --repoint`)는 prune dead gstack Hook Entry 및 re-point 기존의 하나가 안정된 `~/.claude/skills/gstack` install에 설치 될 수 있습니다. 그것은 엄격히 융합된 수리, 새로운 등록이 아니며, 등록 자체는 canonical-only이므로, ephemeral 나무 경로는 settings.json로 구워질 수 없습니다.

**첫 번째 시간 설정:** `.env`의 `ANTHROPIC_API_KEY`를 repo (`.env.example`를 보십시오) 넣으십시오. 각 지휘자 workspace는 그것을 자동적으로 상속합니다.

**`GSTACK_*` env prefix (Conductor-injected keys).** Conductor explicitly strips `ANTHROPIC_API_KEY` and `OPENAI_API_KEY` from every workspace's process env. The `.env` copy path doesn't restore them either — the strip happens after env inheritance. Users who want paid evals, `/sync-gbrain` embeddings, or `claude-agent-sdk` calls to work in a Conductor workspace must set `GSTACK_ANTHROPIC_API_KEY` and `GSTACK_OPENAI_API_KEY` in Conductor's workspace env config; Conductor passes those through untouched. gstack 측에, TS 입장 점 수입품 `lib/conductor-env-shim.ts`는 측 효력으로, canonical 이름이 빈 때 `GSTACK_FOO_API_KEY`에 `FOO_API_KEY`를 승진시킵니다. 당신이 지불한 API를 보인 새로운 TS 입장 점을 추가하는 경우에, 파일의 정상에 `import "../lib/conductor-env-shim";`를 추가하십시오. 오늘 shim는 `bin/gstack-gbrain-sync.ts`, `bin/gstack-model-benchmark`, `scripts/preflight-agent-sdk.ts`, `scripts/preflight-agent-sdk.ts`에서 수입됩니다.

## 알기위한 것들

- **SKILL.md 파일이 생성됩니다.** `.tmpl` 템플릿을 편집하고 `.md`가 아닌 `bun run gen:skill-docs`를 재생합니다. `bun run gen:skill-docs`를 재생합니다.
- **TODOS.md는 통일된 백로입니다.** P0-P4 우선 순위를 가진 기술/component에 의해 조직해. `/ship` 자동 탐지 완료된 품목. 모든 planning/review/retro 기술은 상황에 대 한 그것을 읽었습니다.
- **Browse 소스 변경은 다시 구축해야합니다.** `browse/src/*.ts`를 만지고 `bun run build`를 실행합니다.
- **Dev 모드는 글로벌 설치를 shadows합니다.** 프로젝트-현지 기술은 `~/.claude/skills/gstack`를 우선으로 합니다. `bin/dev-teardown`는 세계를 회복합니다.
- **지휘자 workspaces는 독립적입니다.** 각 작업 공간은 자체 git worktree입니다. `bin/dev-setup`는 `conductor.json`를 통해 자동으로 실행됩니다.
- **`.env` worktrees의 전례.** 주 repo에서 한 번 설정하면 모든 지휘자 작업 공간이됩니다.
- **`.claude/skills/`는 gitignored입니다.** symlinks는 결코 얻지 않습니다.
- **`setup`에서 `ln -snf`를 작성하지 마십시오.** `setup` MUST 노선의 각 링크 사이트 `IS_WINDOWS` 탐지를 가까이서 `cp -f`를 통해 `_link_or_copy SRC DST` 노선. 유닉스에 `ln -snf`를 보존하고 `cp -R`/ `cp -f`에 Windows 개발자 형태 없이, 일반 `ln -snf`는 `git pull`에 새로 고침하지 않는 언 파일 사본을 생성합니다. `test/setup-windows-fallback.test.ts`는 단 하나 `ln`에 있는 정적을 가진 이 강제합니다.
- **동시 대시 파견은 깃발을 주의해야 합니다.** Claude Code는 default (since v2.1.198)에 의해 배경에 에이전트 도구 subagents를 실행합니다, 그래서 어떤 템플렛 단계는 기질을 파견하고 그것의 산출을 가지고 있어야 합니다 `run_in_background: false`를. `{{FOREGROUND_DISPATCH_NOTE}}` placeholder (`scripts/resolvers/constants.ts`) 대신 가이드를 작성하고 `GENERATED_WITH_GUIDANCE`과 commit에서 `test/run-in-background-guidance.test.ts`로 생성된 운반대 파일을 추가합니다. 구조 스캐너는 flag가 부족한 생성된 파견 불완전한 것에 CI가 실패합니다.

## 실제 프로젝트에서 변화를 테스트

**이것은 gstack 개발 권장 방법입니다.** gstack는 실제로 그것을 사용하는 프로젝트에 체크 아웃을 Symlink, 그래서 당신의 변경은 당신이 진짜 일을 하는 동안 살.

### 단계 1: 당신의 체크 아웃을 심화

```bash
# In your core project (not the gstack repo)
ln -sfn /path/to/your/gstack-checkout .claude/skills/gstack
```

### Step 2: symlinks를 만들 수 있는 설정 실행

`gstack` symlink는 혼자 충분하지 않습니다. Claude Code는 `gstack/` 디렉토리 자체를 통해 개별 최상위 디렉토리 (`qa/SKILL.md`, `ship/SKILL.md`, 등)를 통해 기술을 발견합니다. `./setup`를 실행하여 생성하십시오.

```bash
cd .claude/skills/gstack && bun install && bun run build && ./setup
```

설정은 짧은 이름 (`/qa`) 또는 네임스페이스 (`/gstack-qa`)을 원하는지 묻는 것입니다. `~/.gstack/config.yaml`로 저장되며 향후 실행을 위해 기억됩니다. 프롬프트를 건너려면 `--no-prefix` (짧은 이름) 또는 `--prefix` (namespaced)를 통과하십시오.

### 단계 3: 개발

템플릿을 편집하고 `bun run gen:skill-docs`를 실행하고, 다음 `/review` 또는 `/qa` 호출은 즉시 픽업합니다. No 다시 시작해야 합니다.

## # 안정된 글로벌 설치로 돌아가기

프로젝트 로컬 symlink 제거. Claude Code는 `~/.claude/skills/gstack/`로 돌아갑니다:

```bash
rm .claude/skills/gstack
```

per-skill 감독 (`qa/`, `ship/`, 등)은 SKILL.md symlinks를 `gstack/...`로 가리키는 포함해, 그래서 그들은 글로벌 설치에 자동적으로 해결될 것입니다.

### 스위치 접두사 형태

gstack를 1개의 접두사 조정으로 설치하고 전환하고 싶은 경우에:

```bash
cd .claude/skills/gstack && ./setup --no-prefix   # switch to /qa, /ship
cd .claude/skills/gstack && ./setup --prefix       # switch to /gstack-qa, /gstack-ship
```

세팅은 이전의 symlinks를 자동으로 청소합니다. No 수동 세척이 필요합니다.

## 대안: 글로벌 설치를 branch

프로젝트 symlinks를 원하지 않는 경우, 글로벌 설치를 전환 할 수 있습니다.

```bash
cd ~/.claude/skills/gstack
git fetch origin
git checkout origin/<branch>
bun install && bun run build && ./setup
```

이 모든 프로젝트에 영향을 줍니다. 반전하기: `git checkout main && git pull && bun run build && ./setup`.

## 커뮤니티 PR 삼기 (파 과정)

커뮤니티 PR이 축적되면, 그들에 배치 된 파도:

1. **의약** - 테마별 그룹 (보안, 기능, 인프라, 문서)
2. **의제한** — 두 개의 PR이 같은 것을 수정하면, 그 것을 선택
   몇 줄을 변경합니다. 다른 것을 노트로 닫습니다.
3. **수집가 branch** — `pr-wave-N`, merge 깨끗한 PR을 만들고, 해결
   더러운 것들에 대한 충돌, `bun run test && bun run build`로 확인
4. **닫기** — 모든 닫히는 PR는 설명하는 의견 가져옵니다
   왜 그리고 무엇 (무엇이) supersedes 그것. 기여자는 진짜 일을 했습니다; 명확한 커뮤니케이션과 가진 존경.
5. **1개의 PR로 배** — 모든 attributions 보존을 가진 주에 단 하나 PR
   merge 커밋. 합병 및 닫힌 것의 요약 테이블을 포함.

[PR #205](../../pull/205) (v0.8.3)을 예제로 첫 번째 파를 참조하십시오.

## 업그레이드 마이그레이션

릴리스가 `./setup`가 만 수정할 수 없는 방식으로, config 형식, stale 파일)에 대한 변경이 있을 때, 마이그레이션 스크립트를 추가하여 기존 사용자의 깨끗한 업그레이드를 얻을 수 있습니다.

### 이동을 추가할 때

- 기술 감독이 어떻게 생성되는지 변경 (symlinks vs real dirs)
- `~/.gstack/config.yaml`에서 config 키를 변경하거나 이동
- 이전 버전에서 orphaned 파일을 삭제해야
- `~/.gstack/` 상태 파일의 형식을 변경

마이그레이션을 추가하지 마십시오 : 새로운 기능 (사용자가 자동으로 얻을), 새로운 기술 (설정은 그들을 발견), 또는 코드 전용 변경 (no on-disk 상태).

### 하나를 추가하는 방법

1. `gstack-upgrade/migrations/v{VERSION}.sh` `{VERSION}` 가 일치
   VERSION 파일을 수정해야 하는 릴리스에 대 한.
2. 실행할 수 있는 만들기: `chmod +x gstack-upgrade/migrations/v{VERSION}.sh`
3. 스크립트는 **idempotent에** (다시 실행 안전) 및
   **비파괴** (실습은 로그를 붙이고 그러나 향상을 막지 마십시오).
4. 변경된 것을 설명하는 상단의 주석 블록을 포함, 왜
   마이그레이션이 필요합니다., 어떤 사용자가 영향을받습니다.

예:

```bash
#!/usr/bin/env bash
# Migration: v0.15.2.0 — Fix skill directory structure
# Affected: users who installed with --no-prefix before v0.15.2.0
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "$0")/../.." && pwd)"
"$SCRIPT_DIR/bin/gstack-relink" 2>/dev/null || true
```

### 실행하는 방법

`/gstack-upgrade` 동안 `./setup`가 완료된 후 (Step 4.75), 업그레이드 기술은 `gstack-upgrade/migrations/`를 스캔하고 사용자의 이전 버전보다 더 새로운 버전이 있는 `v*.sh` 스크립트를 실행합니다. 스크립트는 버전 주문에서 실행됩니다. 실패는 기록되었지만 업그레이드를 차단하지 않습니다.

### 시험 마이그레이션

마이그레이션은 `bun run test` (tier 1, free)의 일부로 테스트됩니다. 테스트 스위트는 `gstack-upgrade/migrations/`의 모든 마이그레이션 스크립트가 syntax 오류없이 실행 및 파싱을 검증합니다.

## 배송 변경

기술 편집에 만족할 때:

```bash
/ship
```

이 테스트는 diff, Greptile의 댓글(2단계 에스컬레이션)을 평가하고 TODOS.md를 관리하고, 버전을 범프하고 PR를 엽니다. 전체 워크플로우를 위해 `ship/SKILL.md`를 참조하십시오.
