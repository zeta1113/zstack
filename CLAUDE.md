# gstack 개발

## 명령

```bash
bun install          # install dependencies
bun run test         # run free tests via the strict parallel runner (~90-100s full suite)
bun run test:evals   # run paid evals: LLM judge + E2E (diff-based, ~$4.35/run max)
bun run test:evals:all  # run ALL paid evals regardless of diff
bun run test:gate    # run gate-tier tests only (CI default, blocks merge)
bun run test:periodic  # run periodic-tier tests only (weekly cron / manual)
bun run test:gate:sharded    # gate tier via the sharded paid runner (one Bun process per test file)
bun run test:periodic:sharded  # periodic tier via the sharded paid runner (implies EVALS_ALL=1)
bun run test:e2e     # run E2E tests only (diff-based, ~$4.20/run max)
bun run test:e2e:all # run ALL E2E tests regardless of diff
bun run eval:select  # show which tests would run based on current diff
bun run dev <cmd>    # run CLI in dev mode, e.g. bun run dev goto https://example.com
bun run build        # gen docs + compile binaries
bun run gen:skill-docs  # regenerate SKILL.md files from templates
bun run skill:check  # health dashboard for all skills
bun run dev:skill    # watch mode: auto-regen + validate on change
bun run eval:list    # list all eval runs from ~/.gstack/projects/<slug>/evals/
bun run eval:compare # compare two eval runs (auto-picks most recent)
bun run eval:summary # aggregate stats across all eval runs
bun run eval:flake-rank  # rank tests by flake signal (retried passes first; --json, --dir, --since-days)
bun run slop          # full slop-scan report (all files)
bun run slop:diff     # slop findings in files changed on this branch only
```

`test:evals`는 `ANTHROPIC_API_KEY`를 요구합니다. Codex E2E 시험 (`test/codex-e2e.test.ts`, `test/codex-e2e-sol-scope.test.ts`) 사용 Codex의 자신의 auth — 신비한 주자 사본 `auth.json`에서 `${CODEX_HOME:-~/.codex}`와 핀 `CODEX_HOME`에서 아이 env — no `OPENAI_API_KEY` env var 필요했습니다.

**신비한 E2E + env 열쇠:** 각 E2E 주자 스파드 아이들을 `test/helpers/hermetic-env.ts` (allowlist-scrubbed env, 신선한씨 `CLAUDE_CONFIG_DIR`, 임시 `GSTACK_HOME`, `--strict-mcp-config`); per-test `env:` overrides merge는 COMPLETE 신비한 env에 지속해, 그래서 안전합니다. PTY는 `/skill` 명령을 타자를 칩니다 merge를 가진 종자 시험합니다 (실행선을 가진). [docs/TESTING_INTERNALS.md](docs/TESTING_INTERNALS.md).

**Diff 근거한 시험 선택:** `test:evals` and `test:e2e` auto-select tests based on `git diff` against the base branch. Each test declares its file dependencies in `test/helpers/touchfiles.ts`. Changes to global touchfiles (session-runner, eval-store, touchfiles.ts itself) trigger all tests. Use `EVALS_ALL=1` or the `:all` script variants to force all tests. Run `eval:select` to preview which tests would run.

**2 층 체계:** 테스트는 `gate` 또는 `periodic` (`test/helpers/touchfiles.ts`에서 `touchfiles-data.ts` + `test-selection.ts`에 정면으로 분류됩니다. CI는 PR를 통해 evals.yml의 슬라이딩 레인 (planner 나인 → 실행자 → 실패 닫힌 보고서를 통해 문 시험을 실행합니다. 엔진 = scripts/test-paid-shards.ts, 로컬 ePR를 통해 동일한 주자, evals.yml는 `.github/workflows/free-tests.yml`를 통해, `.github/workflows/free-tests.yml`를 통해, `.github/workflows/free-tests.yml`를, <12/>를 통해, <12/>를, <12/>를 통해 동일한 주자격을, <12>를, <12>를, <12>를, <12>는, <12>를, <12>를, <12>를, <12>를, <12>를, <12>를, <12>를, <12>를, <12>를, <12>를, <12>를, <12>를, <12>, <12>, <12>, <12>, <12>, <12>, <12>, <12>, <12>, <12>, <12>, <12>, <12>, <12>, <12>, <12>, <12>, <12>, <12>, <12> ALL 주기적 테스트는 evals-periodic.yml (EVALS_ALL, `test/helpers/periodic-exclude-data.ts` - `test/helpers/periodic-exclude-data.ts`의 소각된 배후를, 주 EVALS_ALL 문 조사를 통해 주당 + 추적 요구된 이유를, minus 실행합니다. `EVALS_TIER=gate` 또는 `EVALS_TIER=periodic`를 사용하여 로컬로 필터링하십시오. 새로운 E2E 테스트를 추가할 때, 분류하십시오:
1. 안전 난간 또는 세로 기능 시험? -> `gate`
2. 품질 벤치 마크, Opus 모델 테스트, 또는 비 결정? -> `periodic`
3. 외부 서비스 필요 (Codex, Gemini)? -> `periodic`

Tier 선언은 `test/e2e-tier-alignment.test.ts` (무료, `bun test`)에서 실행됩니다. `skill-e2e-*` 파일이 `EVALS_TIER` `E2E_TIERS`의 선언 계층과의 자체 게이트 함으로 `E2E_TIERS`가 스위트가 실패한 경우, 터치파일 dep 목록에 이름을 붙지 않는 파일은, notd - 동기화에서 둘 다 유지됩니다.

## 테스트

```bash
bun run test         # run before every commit — free, ~90-100s for the full ~8,700-test suite
bun run test:evals   # run before shipping — paid, diff-based (~$4.35/run max)
```

`bun run test` 경로를 통해 `scripts/test-free-shards.ts` (N 동시 shard 과정, 각 안에 일관되게, `scripts/free-test-durations.json`가 존재할 때 기록된 각 내구에 의해 포장해 - `bun run test:free --record-durations`로 때때로 새로 고침; shard 당 엄격한 산출 분류: bun's 맨끝 요약 선 FAILS 없이 shard - 침묵하는 truncation는 녹색을 보고할 수 없습니다). 전 길거리는 연속적인 나무 mut shard는 갔다: `TREE_MUTATING` is empty (gen-skill-docs has a main() guard and `--out-dir` renders every host, so tests render into mkdtemps — see docs/TESTING_INTERNALS.md). Never type bare `bun test` for the suite: it walks the whole repo, loading paid eval files and missing the strict classifier. It covers skill validation, gen-skill-docs quality checks, and browse integration tests. `bun run test:evals` runs LLM-judge quality evals and E2E tests via `claude -p`. Both must pass before creating a PR.

## 프로젝트 구조

Full annotated tree: [docs/PROJECT_STRUCTURE.md](docs/PROJECT_STRUCTURE.md). Quick map: `browse/` headless-browser CLI, `design/` design binary, `hosts/` typed host configs, `scripts/` build+DX tooling (gen-skill-docs, resolvers), `test/` validation+evals, `lib/` shared libraries, `bin/` CLI utilities, `extension/` Chrome extension, one directory per skill (`ship/`, `review/`, `qa/`, ...), `.github/` CI, `contrib/` contributor tools, `docs/designs/` design documents.

## SKILL.md 워크플로우

SKILL.md 파일은 `.tmpl` 템플릿에서 **제품정보**입니다. docs를 업데이트하려면:

1. `.tmpl` 파일 편집 (예: `SKILL.md.tmpl` 또는 `browse/SKILL.md.tmpl`)
2. `bun run gen:skill-docs` (또는 `bun run build`를 실행하여 자동으로 동작합니다)
3. `.tmpl` 및 `.md` 파일을 모두 압축

생성은 `--model`가 명시되지 않는 `--model`를 Codex를 위한 `claude`를, Codex를 위한 `gpt`를 기존 호스트를 위해 Codex (Codex)를 각각 사용합니다. Codex는 `${CODEX_HOME:-~/.codex}/config.toml`에서 상급 모델을 추가적으로 읽습니다; 그 모델 변경 후 `./setup --host codex`를 다시 실행하십시오. 참고: `bun run build`와 베어 `gen:skill-docs --host codex` 호스트 default (gpt)를 렌더링합니다. Codex config.toml가 다른 모델인 rerun `./setup --host codex`를 핀으로 처리하면 프로필 복원 (단일 다운 persistence는 TODOS.md)로 파일됩니다.

새로운 검색 명령을 추가하려면 `browse/src/commands.ts` 및 재 구축에 추가하십시오. snapshot 플래그를 추가하려면 `SNAPSHOT_FLAGS` `browse/src/snapshot.ts` 및 재 구축에 추가하십시오.

**토큰 천장:** Generated SKILL.md files trip a warning above 160KB (~40K tokens). This is a "watch for feature bloat" guardrail, not a hard gate. Modern flagship models have 200K-1M context windows, so 40K is 4-20% of window, and prompt caching makes the marginal cost of larger skills small. The ceiling exists to catch runaway preamble/resolver growth, not to force compression on carefully-tuned big skills (`ship`, `plan-ceo-review`, `office-hours` legitimately pack 25-35K tokens of behavior). 40K를 지나서 고장난 경우, 올바른 수정은 보통: (1) WHAT 성장, (2) 한개의 결산자가 단 하나 PR에 있는 10K+를 추가하면, 인라인 또는 참고문헌으로 속한 질문, (3) 마지막 리조트로 주의깊게 조정된 prose만 - 감사, 검토 육군, 음성 지시에 삭감하십시오 진짜 질 비용.

두 번째, 더 단단한 천장은 DISCOVERY 표면을 감시합니다: `test/catalog-budget.test.ts`는 1,150의 토큰 부동물 (260 바이트 당 skill sub-cap)에 모든 기술에 대하여 총계 frontmatter `name` + `description`를 모입니다. 이 것은, 경고가 아닙니다 — 각 주인은 전체 카탈로그를, 그래서 여기에서 세금을 이룹니다 각 대화를 이룹니다. 실패 메시지는 다시 측정 의정서를 나릅니다. `bin/gstack-context-bill`는 기술 나무 (직선에 대 한) 기술 나무 (직선에 대 한)에 대 한 전체 token, `--budget`; `--exact` 실제 Tokenizer 및 POSTs 파일 텍스트에 선택 api.anthropic.com egress 영수증).

The context-budget ratchet (`test/context-budget-ratchet.test.ts`, free, runs in `bun run test`) pins ABSOLUTE ceilings on two more ledgers: the always-on FULL-frontmatter aggregate (catalog-budget counts only name+description) and each skill's per-invocation eager tokens (SKILL.md + forced-read references — size floors and parity ratios guard these relatively, not absolutely), graded against `test/fixtures/context-budget.json`. A skill that grows past its ceiling fails; 새로운 기술은 의식적으로 예산을 잡을 때까지 실패합니다. 합법적 인 성장 또는 착륙 감소, 재 실행 `bun test/helpers/capture-context-budget.ts` 및 commit 같은 commit의 새로 고침 정착물을 위해, 그래서 천장은 아래로 등치하고 각 승리는 잠겨집니다.

**SKILL.md 파일에 대한 합병 분쟁:** NEVER는 생성된 SKILL.md 파일에 충돌을 해결합니다. 대신: (1) `.tmpl` 템플렛과 `scripts/gen-skill-docs.ts` (진실의 근원)에 충돌을 해결하고, (2)는 SKILL.md 파일을 재생하기 위하여 SKILL.md 파일을 재생하기 위하여 `scripts/gen-skill-docs.ts`를 실행합니다, (3) 재생된 파일을 단계. 1개의 측 생성한 산출을 받아들이는 것은 침묵하게 다른 측의 템플렛 변화를 삭제합니다.

## 플랫폼 - 가습 디자인

Skills should NEVER hardcode Framework-specific commands, file pattern, or directory Structures. 대신:

1. **CLAUDE.md를 읽으십시오** 프로젝트별 구성 (테스트 명령, eval 명령 등)
2. **누락된 경우 AskUserQuestion** — 사용자가 gstack를 검색하거나 repo를 알려줍니다.
3. **CLAUDE.md에 대한 답변을 주장** 그래서 우리는 다시 요구하지 않습니다

이 테스트 명령, eval 명령, 배포 명령 및 다른 프로젝트 별 동작에 적용됩니다. 이 프로젝트는 config를 소유합니다. gstack는 그것을 읽습니다.

## 쓰기 SKILL 템플릿

SKILL.md.tmpl 파일은 **Claude에 의해 읽는 신속한 템플렛**, bash 스크립트가 아닙니다. 각 bash 코드 블록은 별도의 쉘에서 실행됩니다. 변수는 블록 사이에 persist가 아닙니다.

규칙:
- **논리 및 상태에 대한 자연 언어를 사용합니다.** 통행을 쉘 변수를 사용하지 마십시오
  코드 블록 사이 상태. 대신 Claude를 기억하고 참조하는 것을 말한다 (예를 들어, "기본 branch는 단계 0에서 검출됩니다.").
- **branch 이름을 딴 것을 사용하지 마십시오.** `main`/`master`/etc를 동적인으로 검출하십시오
  `gh pr view` 또는 `gh repo view`. PR-targeting 기술을 위해 `{{BASE_BRANCH_DETECT}}`를 사용하십시오. prose, 코드 구획 홀더에 있는 `<base>`에서 "기본 branch"를 사용하십시오.
- **자가 함유 된 bash 블록을 유지하십시오.** 각 코드 구획은 자주적으로 작동되어야 합니다.
  블록이 이전 단계에서 컨텍스트를 필요로한다면 위의 prose에서 휴식을 취하십시오.
- **영어로 표현된 조건** 대신에 배열된 `if/elif/else` bash에서,
  번호 결정 단계 쓰기: "1. X가되면 Y. 2. 그렇지 않으면 Z를 수행."

## 쓰기 스타일 (V1)

Default output from every tier-≥2 skill follows the Writing Style section in `scripts/resolvers/preamble.ts`: jargon glossed on first use (curated list in `scripts/jargon-list.json`, baked at gen-skill-docs time), questions framed in outcome terms ("what breaks for your users if...") not implementation terms, short sentences, decisions close with user impact. Power users who want the tighter V0 prose set `gstack-config set explain_level terse` (binary switch, no middle mode). 전체 디자인 합리적 인 `docs/designs/PLAN_TUNING_V1.md`를 참조하십시오. 원본 쓰기 스타일과 함께 타기 위해 시도 된 검토는 V1.1에 추출되었습니다. `docs/designs/PACING_UPDATES_V0.md`.

## 브라우저 상호 작용

브라우저 (QA, 개식품, cookie 설정)과 상호 작용할 때, `/browse` 기술을 사용하거나 `$B <command>`를 통해 직접 검색 바이너리를 실행하십시오. NEVER는 `mcp__claude-in-chrome__*` 도구를 사용합니다. 그들은 느리며 신뢰할 수 없으며이 프로젝트가 사용되지 않습니다.

**서버/측바/팽창장 내부:** before editing `browse/src/server.ts`, `extension/`, the sidebar PTY, any SSE endpoint, or CDP session code, read [docs/BROWSER_INTERNALS.md](docs/BROWSER_INTERNALS.md) — sidebar message flow, WebSocket auth, tunnel dual-listener rules, Unicode sanitization at egress, SSE/CDP helpers, setup symlink hardening, and the sidebar security stack all live there, each pinned by a CI tripwire.

**모든 오프 머신 싱크에서 Egress 영수증** (v1.63.0.0+). 각 gstack 개시는 기계 MUST를 씁니다 해 사슬로 잡은 영수증을 `~/.gstack/security/egress.jsonl` BEFORE에 보냅니다: TypeScript 외침은 `lib/egress-receipt.ts`에서 `writeReceipt`를 사용합니다; 포탄 스크립트 근원 `bin/gstack-egress-lib.sh` 및 사용 `_receipted_curl`/`_receipted_git`. 실패 극성은 일류입니다: 민감한 싱크 (뇌 sync, 메모리 - 가장, gbrain-sync, telemetry, ngrok 터널, mcp-verify, supabase-provision), 실패 개방에 대 한 실패
+ stderr 사용자를 위한 경고 하나 (design OpenAI 외침, 갱신 검사,
대시보드, git-class ops). `test/egress-receipt-wiring.test.ts`의 새로운 싱크 스캐너는 CI를 비례없는 `curl`/ `git push`/ `fetch`에 `fetch`에 `SCANNER_EXEMPT` 목록 (사용자 지시된 페이지 fetches, 도달성 조사, 지시 끈, 기술 prose)에 있는 이유가 있는 경우에, 당신은 새로운 오프 기계 수채를 추가하고, `SCANNER_EXEMPT` 목록 (사용자 지시한 페이지 fetches, 도달성 조사, 지시 끈, 기술 prose)에 있는 이유가 있는 경우에. `list` 목록으로, 그것은 `list`를 가진 코드를, 돕습니다. 위협 모델: ATTEMPTED egress의 법정 관측성, exfiltration 통제가 아닙니다.

## Dev symlink 인식

gstack를 개발할 때, `.claude/skills/gstack`는 이 작업 디렉토리 (gitignored)로 symlink가 될 수 있습니다. 이는 기술 변경이 **즉시**, 급속하게 이행에 큰 위험이 있음을 의미합니다. 반휘발 기술이 Claude Code 세션을 사용하여 다른 Claude Code 세션을 깰 수 있는 큰 재발견 중 위험이 있습니다.

**세션당 한 번 확인:** 실행 `ls -la .claude/skills/gstack` 그것이 symlink 또는 실제 복사인지 볼 수 있습니다. 작업 디렉토리에 symlink가 있다면, 그 인식이 될 수 있습니다.
- 템플릿 변경 + `bun run gen:skill-docs` 즉시 모든 gstack invocations에 영향을 미칩니다.
- SKILL.md.tmpl 파일에 대한 변경 사항이 동시 gstack 세션을 깰 수 있습니다.
- 큰 재발견 중, symlink 제거 (`rm .claude/skills/gstack`) 그래서
  `~/.claude/skills/gstack/` 에서 글로벌 설치가 대신 사용

**접두사 조정:** 설정은 SKILL.md 내부의 symlink (예: `qa/SKILL.md -> gstack/qa/SKILL.md`)과 상단의 실제 디렉토리 (symlinks)를 생성하고, 각 기술 실행 시간 자산 (섹션 / 템플릿, 체크리스트 - SKILL.md, 테스트, 빌드 출력 및 `.tmpl` 소스 제외)에 대한 링크와 링크가 있습니다. 별명 기술 (`_gstack-command`, `connect-chrome`)는 `connect-chrome`, Claude, Claude)를 제거하지 않고, 그 결과의 기술이 발견되지 않습니다. 이름은 `~/.gstack/config.yaml`에서 `skill_prefix`에 의해 통제되는 `qa`) 또는 명명 (`gstack-qa`)입니다. 상호 작용하는 신속한 건너뛰기 위하여 `--no-prefix` 또는 `--prefix`를 통과하십시오.

**참고 :** gstack 프로젝트 repo로 납품. 글로벌 설치 사용
+ `./setup --team` 대신. 팀 모드 지시를 위한 README.md를 보십시오.

**계획 리뷰 :** 기술 템플릿 또는 gen-skill-docs 파이프라인을 수정할 계획이라면 변경이 생길 전에 격리 테스트되어야한다는 것을 고려하십시오 (특히 사용자가 다른 창에서 gstack를 사용하여 적극적으로 사용하는 경우).

**업그레이드 마이그레이션:** 변경이 기존 사용자 설치를 깰 수있는 방식으로 on-disk state (directory Structure, config format, stale file)를 수정할 때 마이그레이션 스크립트를 `gstack-upgrade/migrations/`로 추가합니다. CONTRIBUTING.md의 "Upgrade migrations" 섹션을 읽고 형식 및 테스트 요구 사항을 테스트합니다. 업그레이드 기술은 `./setup` 이후 자동으로 실행됩니다. `/gstack-upgrade`.

## 컴파일된 binaries — 절대 commit browse/dist/, design/dist/, 또는 make-pdf/dist/

`browse/dist/`, `design/dist/`, `make-pdf/dist/` 디렉토리는 Bun binaries (`browse`, `find-browse`, `design`, ~62MB 각각 컴파일된 Bun 디렉토리를 포함합니다). 이들은 Mach-O arm64만 - NOT, Windows, 또는 Intel Macs에서 `./setup` 스크립트 빌드를 합니다. `./setup` 스크립트는 각 플랫폼에 소스에서 빌드합니다.

이 감독은 **untracked 및 gitignored** (`.gitignore:3-6`; `browse/dist/` binaries는 `64d5a3e4`, v0.11.16.0; 다른 사람이 결코 추적되지 않았습니다). 그들은 NOT에 나타날 것입니다. 이 런이 `git status`에서 나타나는 경우, 그 힘이 추가된 (`git add -f`) - commit; 그것을; 그것이 어떻게 얻은지 그리고 어떻게 알아내는지.

파일을 staging하면 항상 특정 파일명 (`git add file1 file2`)을 사용하며, 출력과 정크를 구축 할 수 있는 `git add .` 또는 `git add -A`가 없습니다.

## Redaction guard (PII / 비밀 / 법적 내용)

공유 redaction 엔진은 credentials, PII 및 외부 싱크 (codex 파견, GitHub 문제점/PR 몸, 강요된 commit)에 도달하기 전에 법적/damaging 내용을 붙잡습니다. **난간, 완벽한 강제** - `git push --no-verify`, 직접 `gh issue create`, 그리고 `GSTACK_REDACT_PREPUSH=skip` 모든 우회에 도달하기 전에 입니다. 사고와 주의를 잡습니다, 99% 케이스. 그것은 그것을 주장하지 마십시오 (9) 스크린 샷을 실패하는 것을 주장하십시오.

- **엔진 + 과세:** `lib/redact-patterns.ts` (진의 단 하나 근원 —
  3 tiers; HIGH = genuinely-secret credentials that block, MEDIUM = PII/legal/ internal + high-FP credential shapes that confirm via AskUserQuestion, LOW = FYI) and `lib/redact-engine.ts` (pure `scan()` + `applyRedactions()`). Calibration matters: a gate that cries wolf gets ignored, so context-variable shapes (Stripe `pk_live_`, Google `AIza`, JWT, env `*_KEY=`) sit at MEDIUM.
- **CLI:** `bin/gstack-redact` (exit 0 청결한/2 MEDIUM/3 HIGH; `--json`,
  `--auto-redact`, `--repo-visibility`, `--from-file`). `bin/gstack-redact-prepush`는 git 걸이입니다.
- **Skill docs는 생성됩니다.** `scripts/resolvers/redact-doc.ts`에서
  (`{{REDACT_INVOCATION_BLOCK:<sink>}}`) 그래서 /spec, /cso, /ship, /document-release, /document-generate는 엔진에서 결코 무해하지 않습니다.
- **검사 잉크:** 항상 EXACT 바이트를 스캔하여 보내질 것입니다. — 쓰기
  임시 파일, 파일이, SAME 파일을 `gh`/`git`로 전달합니다. 문자열을 스캔하지 마십시오. 다시 렌더링 (그는 스캔-vs-send gap를 다시 열 수 있습니다).
- **가시성 (no 층 촉진):** 실행 당 한 번 해결, 순서 = 로컬 구성
  (`gstack-config get redact_repo_visibility`, ~/.gstack 이렇게 절대로 투입) → gh → glab → unknown(=public-strict). 공중 저장소는 STERNER per-finding 확인 (no 배치-acknowledge, no 침묵하 보호해 얻을 것입니다; MEDIUM는 HIGH에 자동 추진하지 않습니다.
- **도구에 의하여 묶인 담:** 포장 Codex/Greptile/eval 출력 ` ```codex-review
  / ` ```greptile ` 울타리 그래서 예제는 그 도구 인용 WARN-degrade 대신 차단. 울타리 내부의 라이브 형식의 식별 여전히 블록.
- **Config 열쇠:** `redact_repo_visibility` (public|개인|알 수 없음, local-only
  gh/glab를 읽을 수 없습니다), `redact_prepush_hook` (true|false)를 위한 override. 의도적으로 NO 열쇠가 HIGH 막기 가능하게 하는 경우에 있습니다.
- **감사:** /spec semantic pass 는 내용이 없는 레코드를 추가합니다 (카테고리 +
  몸 sha256, no spec text)에 `~/.gstack/security/semantic-reviews.jsonl` (0600).

## 콤모 스타일

**항상 비스듬한 커밋.** 각 commit는 단일 논리 변화이어야 합니다. 여러 변경을 만들 때 (예를들면, 이름 + 의 + 새 테스트), 밀어하기 전에 별도의 커밋으로 나눕니다. 각 commit는 독립적으로 이해 및 뒤집을 수 있어야 합니다.

좋은 비스듬한의 예:
- Rename/move 동작 변경
- 테스트 인프라 (터치파일, 헬프)는 테스트 구현과 분리
- 생성된 파일 재생과 분리된 템플릿 변경
- 기계식 재공장은 새로운 기능으로 분리되어 있습니다.

사용자가 "bisect commit"또는 "bisect and push," split staged/unstaged가 논리 커밋으로 변경하고 푸시합니다.

## 슬로프 수: AI 코드 품질, 아니 AI 코드 숨기

[slop-scan의](https://github.com/benvinegar/slop-scan)를 사용하여 AI 생성된 코드가 인간이 쓴 것 보다는 진짜로 나아지는 본을 붙잡기 위하여 NOT를 이용합니다. 우리는 인간적인 코드로 통과하는 것을 시도하고 있습니다. 우리는 AI 코드화되고 그것의 자랑입니다. 목표는 코드 질입니다.

```bash
npx slop-scan scan .          # human-readable report
npx slop-scan scan . --json   # machine-readable for diffing
```

Config: `slop-scan.config.json` (현재 `**/vendor/**`를 제외) repo 루트에서 `slop-scan.config.json`.

모든 것을 고치기 전에 [docs/SLOP_SCAN.md](docs/SLOP_SCAN.md): 그것은 파일 ops → `safeUnlink()`의 주위에 진짜 질 고침을 분리합니다, 과정 죽이는 linter 도박에서 → `safeKill()`) 우리는 (스트링 매트 간격 과실 메시지, 제일 불편정을 바짝 죄는). 공용품은 `browse/src/error-handling.ts`에서 살. 점수를 추적하지 마십시오.

## 커뮤니티 PR 난간

검토 또는 합병 커뮤니티 PR, **always AskUserQuestion** 어떤 commit를 허용하기 전에:

1. **Touches ETHOS.md** - 이 파일은 Garry의 개인 빌더 철학입니다. No 편집
   외부 기여자 또는 AI 에이전트, 기간에서.
2. **제거 또는 softens 홍보 자료** — YC 참조, 설립자 관점,
   그리고 제품 음성은 의도적입니다. "unnecessary"또는 "too Promotion"와 같은 프레임을 거부해야합니다.
3. **Garry의 목소리 변경** — 톤, 유머, 지향성, 기술에 대한 관점
   템플릿, CHANGELOG, 그리고 문서는 일반적이지 않습니다. 더 많은 "neutral"또는 "professional"가 거부되어야하는 음성을 읽는 PR.

이 세 가지 범주는 AskUserQuestion을 통해 명시된 사용자 승인을 요구합니다. No 예외. No 자동 매칭. No "나는 단지 이것을 청소합니다."

## garrytan-agents에서 PR을 확인

When the user says "check out <PR link>" and the PR is from `garrytan-agents/gstack` (or any other fork that is NOT a collaborator on `garrytan/gstack`), do NOT just `gh pr checkout`. Fork PRs don't receive base-repo secrets (`ANTHROPIC_API_KEY`, `OPENAI_API_KEY`, etc.), so the eval/E2E CI jobs fail with empty-env auth errors regardless of what's set on the base repo.

**작업 흐름:** push branch에서 `garrytan/gstack` (기본 repo)에 PR를 거기에서 재 표적하십시오.

구체적으로, `gh pr checkout <N>` 후에:

1. PR 번호와 머리 branch 이름을 참고하십시오.
2. Push the same branch to the base repo: `git push origin HEAD:<branch-name>`
   (origin = `garrytan/gstack`, worktree가 그 리모트로 설정되기 때문에).
3. 포크 PR (`gh pr close <N> --comment "moving to base-repo branch for secret access"`)를 닫습니다.
4. Open a new PR from the base-repo branch: `gh pr create --base main --head <branch-name>`.
5. 새로운 PR의 워크플로우는 자동으로 비밀을 얻을 수 있습니다.

왜 포크 측에 그것을 고치지? `garrytan-agents`는 `garrytan/gstack`에 공동 작업자가 아닙니다. 공동 작업자 (옵션 A)로 추가하거나 이 지점을 이동하기보다 넓은 폭발 반경을 우회 할 수 있습니다. 옵션 C (이 섹션)은 비밀 분산 범위를 유지.

사용자가 이동을 건너 뛸 수 있도록 요청하면 (예: "단, 포크 PR로 그대로 남길 수 있음), 즉, eval CI는 빈 엔브 auth로 실패하지만, 체크-freshness, 워크플로-린트, 윈도우 테스트는 여전히 포크 PR에서 전달됩니다.

## CHANGELOG + VERSION 스타일

**버전 invariant (workspace-aware ship).** VERSION는 엄격한 세이버 헌신이 아니라, 단색의 주문형 릴리즈 식별자입니다. 범위 (major/minor/patch/micro))은 배 시간에 의도를 표현합니다. 동일한 범위 수준 내에서 주장된 버전을 습득하면 명시적으로 허용됩니다. branch A는 MINOR와 branch B로 v1.7.0.0을 주장합니다. 또한 v1.7.0.0이 아닌 MINOR, B 땅은 v0.07/> (MINOR)에 따라 결정됩니다. MINOR MINOR MINOR MINOR 이것이 왜 `bin/gstack-next-version`가 충돌이 일어날 때 레벨을 재현하는 것보다 선택된 범퍼 레벨 내에서 진보합니다.

**package.json는 npm-valid 번역을, VERSION verbatim가 아닌 나옵니다.** VERSION는 진리의 4 자리 소스를 유지 (예 : `1.67.0.0`); package.json 및 `version` 필드와 어떤 하위 디렉토리는 3-digit npm-valid translation (`1.67.0`), lockfile `version` 필드는 이미 존재하는 경우에만 동기화합니다. `bin/gstack-version-bump` ( `lib/version-source.ts`를 통해) 번역된 형태에 번역하고 재판소를 소유합니다 - NOT "fix"를 손으로 잡은 명백한 잡음을, 그리고 package.json (npm)로 4자리 버전을 쓰지 마십시오. `lib/version-source.ts` 헤더에 사는 직업 및 번역 규칙; `test/gstack-version-bump.test.ts` 핀 계약.

**Scale-aware 범프 - 일반적인 감각을 사용합니다.** diff가 크면, MINOR (또는 MAJOR)가 PATCH가 아닌 범프 PATCH가 버그 수정과 작은 추가에 사용됩니다. MINOR는 실질적인 새로운 기능 또는 실질적인 감소를 위해 입니다; MAJOR는 변화를 끊기를 위해 입니다. 거친 가이드 포스트 (규정으로 대우하지 마십시오, 냄새 검사로 대우하십시오):

- **PATCH (X.Y.Z+1.0)**: 버그 수정, doc tweak, 작은 첨가제 변경, 단일
  test/file 추가. ~500의 선, no의 밑에 순중량 diff 새로운 사용자 방위 기능.
- **MINOR (X.Y+1.0.0)**: 새로운 기능 발송 (skill, 마구, 명령, 큰
  refactor), 실질적인 코드 감소 (압축, 마이그레이션), 또는 조정 멀티 파일 변경. 순 diff ~2000 라인 추가/removed, OR 리트윗에 넣어 사용자의 눈에 띄는 기능.
- **MAJOR (X+1.0.0.0)**: public 표면으로 바꾸는 (CLI 깃발 이름,
  기술 제거, 구성 형식 변경), OR 블로그 게시물의 헤드 라인이 될 정도로 큰 릴리스.

"is 10K add + 24K는 정말로 PATCH?"라는 것을 발견하면, 그것은 아닙니다. 범프 MINOR. "이에 동일하게 6 새로운 E2E 테스트 + 헬러 유틸리티"와 함께 전체 새로운 테스트 하네스를 추가합니다. MINOR. 범프 레벨은 사용자가 어떤 종류의 릴리스에 대해 통신합니다. 그것을 언젠가하지 마십시오.

origin/main가 VERSION를 더 높을 때, branch의 일 SCALE의 SCALE에 대한 융 수준을 재평가하는 것은, 다만 주요 앞으로 이동한다는 것을. 주요 범람된 MINOR 및 branch는 또한 실질적 변화, 당신 최고에 MINOR 다시 (예를들면, v1.14.0.0의 당신의 branch 땅 v0.0에 요점.

**VERSION와 CHANGELOG는 branch경입니다.** 모든 특징 branch 배는 자체 버전 범프와 CHANGELOG 입장을 얻습니다. 항목은 THIS branch가 주에 이미 있었던 것을 설명합니다.

**CHANGELOG 항목은 diff 주요와 선박 branch 사이이며, 사용자가 업그레이드 할 때 얻는 것. NOT branch가 어떻게 생겼는지.** 항목에 착륙하는 독자는 그들이 이전에 할 수 없었던 것을 배울 수 있어야 합니다; 그들은 branch의 내부 버전 범프에 대해 배울 수 없으며, 우리가 잡은 버그 및 고정 된 중공, 계획 리뷰 우리는 ran, 또는 우리가 돌진된 커밋에 대해 배울 수 없습니다. 그것은 branch 개발 narrative입니다. 그것은 PR 설명과 commit 메시지, CHANGELOG 메시지에 속합니다.

**CHANGELOG 입력에 있는 branch 내부 버전을 참고하지 마십시오.** branch v1.5.0.0 → v1.5.1.0 → v1.6.0.0 개발 중 VERSION 범퍼 VERSION가 개발 중이며 최종 v1.6.0.0 배가 메인으로 되어, 입력은 v1.5.1.0이 존재하지 않는 경우 읽을 수 있습니다. 구체적으로 NEVER 쓰기:
- "v1.5.1.0 v1.6.0.0 수정"- 리더는 v1.5.1.0에 대해 모른다. 그것은
  a branch-internal artifact.
- "V1.5.1.0의 배송 헤드 라인은 ..."- 같은 이유 때문에 깨졌습니다. 주요에서
  관점, v1.5.1.0은 결코 출시되지 않았습니다.
- "Pre-fix 테스트는 깨진 행동을 인코딩"-그는 기여자의 승리 랩,
  사용자의 이익이 아닙니다.
- "두 외과 편집, 파견 경로에서 모두"- 패치의 마이크로 - 월.

대신, 릴리스 된 시스템을 설명 : "Browser-skills는 예상된 탭 액세스 하수인과 함께 종료됩니다." 배송 시스템의 속성이 호출 될 가치가있는 경우 (예 : "skill spawns는 허용 탭 액세스를 얻을; 쌍 에이전트 터널 토큰은 소유권이 필요합니다"), 속성으로 문서, 고정되지 않습니다. 배송 시스템은 사용자가 얻는 것입니다; 그 시스템에 대한 경로는 그들에 보이지 않습니다.

**CHANGELOG 항목 작성 시:**
- `/ship` 시간 (Step 13), 개발 중 또는 중공 중.
- 항목은 ALL 이 branch 기본 branch을 대상으로 합니다.
- 기존 CHANGELOG에 새로운 작업을 접지 못했습니다.
  이미 주에 착륙. 주요 경우 v0.10.0.0 및 branch 기능을 추가, v0.10.1.0 새로운 항목으로 범프 — v0.10.0.0 항목을 편집하지 마십시오.

**쓰기 전에 중요한 질문:**
1. branch는 무엇인가요? THIS branch가 바뀌는 것은 무엇입니까?
2. 기본 branch 버전이 이미 출시되었습니까? (yes, 범프 및 새 항목 만들기.)
3. 이 branch에 기존의 항목은 이미 이전 작업을 커버합니까? (yes인 경우, 대체
   최종 버전에 대한 한 개의 통합 항목으로.)

**주요 합병은 NOT는 주요 버전을 채택한다.** When you merge origin/main into a feature branch, main may bring new CHANGELOG entries and a higher VERSION. Your branch still needs its OWN version bump on top. If main is at v0.13.8.0 and your branch adds features, bump to v0.13.9.0 with a new entry. Never jam your changes into an entry that already landed on main. Your entry goes on top because your branch lands next.

**주요 합병 후, 항상 확인 :**
- CHANGELOG는 branch의 입력을 주 항목에서 분리하는 가지고 있습니까?
- VERSION는 주요 VERSION 보다는 더 높습니까?
- CHANGELOG (현재)에 가장 큰 항목이 있습니까?
어떤 대답이 no인 경우, 계속하기 전에 수정하십시오.

**CHANGELOG가 동작하는 것을 편집한 후, 추가하거나, 항목을 제거하고,** 즉시 `grep "^## \[" CHANGELOG.md`를 실행하여 no 중복 및 감지 가능한 역동적 인 순서를 확인합니다. 버전 번호 사이의 간격은 괜찮습니다. v1.6.4.0에서 배하는 branch는 메인에 대한 사전 v1.5.2.0 또는 v1.5.3.0 항목이 정해지지 않은 branch 내부 버전 번호입니다. 위주 항목과 다시 채우기 간격을하지 마십시오.

**절대 orphan branch 내부 버전.** If your branch bumped VERSION several times during development (v1.5.1.0 → v1.5.2.0 → v1.6.4.0, say) and those earlier entries were never released to main, the final ship consolidates ALL of them into a single entry at the final version (v1.6.4.0). Collapse them — delete the old entries and move their content into the final entry, re-version table columns accordingly. Readers see one release, not a branch diary. 가파스는 정밀한 (v1.6.3.0 → v1.6.4.0 와 no v1.5.x 와 함께 메인이 정확합니다).

CHANGELOG.md는 **사용자의 경우**, 기여자 아닙니다. 제품 릴리스 노트와 같이 쓰십시오:

- 사용자가 이전 할 수 없었던 **으로**를 통해 리드합니다. 기능을 판매합니다.
- 일반 언어 사용, 구현 세부 사항이 아닙니다. "당신은 지금 할 수 있습니다 ..." "Refactored..."
- **이번 언급 TODOS.md, 내부 추적, eval 인프라, 또는 contributor-facing
  details.** 이들이 사용자와 의미를 이해하는 것이 가능함.
- contributor/internal을 아래에서 분리된 "Contributors"섹션으로 변경합니다.
- 모든 항목은 누군가가 "좋아요, 나는 그것을 시도하고 싶다."라고 생각해야합니다.
- No jargon: "지금이 프로젝트와 branch를 알려줍니다"라고 말했습니다.
  "AskUserQuestion preamble resolver를 통해 기술 템플릿을 표준화 한 형식."

**주요과이 변화 사이에 배송되는 문서 만.** 리더는 우리가 어떻게 얻은지 걱정하지 않습니다. CHANGELOG, 항상 유지하십시오:

- 브랜치 리syncs, merge 주, rebase 활동과 함께 커밋합니다.
- 플랜 승인, 결과 검토 (CEO / eng / 디자인 / 외부 청구서 / 코덱 찾기),
  AskUserQuestion 결정, 범위 협상.
- "Work queued," "계획 승인," "인-프로그레스," " 나중에 발송"- CHANGELOG
  DID 선박이 아닌 MIGHT 선박이 무엇인지, 문서.
- no 사용자 파싱 작업이 실제로 착륙했을 때 버전 범퍼.

diff 기본 branch 버전과 이 버전은 no 사용자 인터페이스 변경 (만 병합, 만 CHANGELOG 편집, 만 위주 작업), 솔직한 항목은 한 문장입니다: "분기 - 앞선 분야의 경계 범. No 사용자 직면 변경이 아직." 중지. 패드하지 마십시오. 결국 배가 될 계획이 설명하지 마십시오. branch 실제 기록이 발생하면 됩니다. 이 땅에서 이 땅에서 이 땅에 이 땅에 이 땅에 이 땅을 대체할 때.

### 입력 형식

`## [X.Y.Z]` 항목은 `### Itemized changes` 섹션에 따라 릴리스 요약 (두 선 대담한 헤드 라인, 리드 단락, 숫자 테이블, 종료 단락)을 시작합니다. 전체 형식의 사양 및 음성 규칙 BEFORE 항목에 대해 [docs/CHANGELOG_STYLE.md](docs/CHANGELOG_STYLE.md)를 읽어보십시오. 항상 `Contributed by @username`와 함께 커뮤니티 기여를합니다.

## AI 노력 압축

노력에 대한 평가 또는 토론 할 때, 항상 인간 팀과 CC + gstack 시간을 보여줍니다:

| 작업 유형 | 인간 팀 | CC+gstack | 압축 |
|-----------|-----------|-----------|-------------|
| 보일러판/비계 | 2 일 | 15분 | ~100x의 |
| 시험 쓰기 | 1 일 | 15분 | ~50x의 |
| 기능 구현 | 1 주일 | 30분 | ~30x의 |
| 버그 수정 + 회귀 테스트 | 4시간 | 15분 | ~20x의 |
| 건축/디자인 | 2 일 | 4시간 | ~5x의 |
| 연구/탐험 | 1 일 | 3시간 | ~3x의 |

완전한 것은 싸다. 완전한 구현이 성취 될 때 단축키를 권장하지 마십시오. 바다를 끓인다 - 완전한 것은 목표입니다; 단지 진짜로 관련 멀티 쿼터 마이그레이션은 짧게 변하지 않는 범위입니다. 전체 철학을 위해 기술에 대한 완전한 원리를 참조하십시오.

## 건물 전 검색

concurrency, unfamiliar 패턴, 인프라, 또는 runtime/framework가 내장된 모든 솔루션을 설계하기 전에:

1. "{runtime} {thing} 내장"에 대한 검색
2. "{thing} 최고의 연습 {current year}"에 대한 검색
3. 공식 실행시간/framework docs

지식의 세 가지 층 : 시도 및 true (Layer 1), 새로운 - 및 - 대중 (Layer 2), 첫 번째 - 펜시 (Layer 3). 상층 3 위. 전체 빌더 철학에 대한 ETHOS.md를 참조하십시오.

## 지역 계획

기여자는 `~/.gstack-dev/plans/`의 장거리 비전 문서와 디자인 문서를 저장할 수 있습니다. 이들은 local-only (에서 검사되지 않음)입니다. TODOS.md를 검토할 때, TODO 또는 구현에 기여할 수 있는 후보자에 `plans/`를 확인합니다.

## E2E eval 실패 비난 의정서

E2E eval이 `/ship` 또는 다른 워크플로우에서 실패할 때 **"우리의 변경과 관련이 없습니다"라고 주장하지 마십시오.** 이 시스템은 보이지 않는 연결이 있습니다. - preamble 텍스트 변경은 에이전트 행동에 영향을 미칩니다. 새로운 돕기 변경 타이밍, 재생 SKILL.md 시프트 컨텍스트가 있습니다.

**"pre-existing"에 실패를 attributing 전에 필요한 경우:**
1. 기본 (또는 기본 branch)에 동일한 eval을 실행하고 그것을 표시하지 않습니다
2. 그것이 메인에 전달하는 경우, branch에 실패 — 그것은 IS 당신의 변경. 비난을 추적.
3. 주에 실행할 수 없다면 "unverified — may or may not be related"라고 말하고 플래그를
   PR 몸의 위험

영수증이 없는 "Pre-existing"은 게으른 주장입니다. 그것을 시도하거나 그것을 말하지 마십시오.

## 긴 실행 작업: 포기하지 마십시오

evals를 실행할 때, E2E 테스트, 또는 긴 실행 배경 작업, **수료까지**. 사용 `sleep 180 && echo "ready"` + `TaskOutput` 루프에서 3 분. 절대 모드를 차단하고 오염 시간을 아웃 할 때 포기하지 마십시오. "나는 완료 할 때 알림이 될 것입니다"그리고 중지 검사 - 작업 종료 될 때까지 루프를 유지하거나 사용자가 중지 할 것을 알려줍니다.

전체 E2E 스위트는 30-45 분을 취할 수 있습니다. 즉 10-15 오염 사이클입니다. 그들 모두. 각 검사 (시험 통과, 실행중인, 실패 지금까지)에 진행 상황을보고. 사용자는 당신이 나중에 검사 할 것이라고 약속하지 않는 실행 완료를보고 싶어.

## 에이전트로 evals를 실행: 항상 detach (SIGTERM-proof)

When **(제/harness)** launch a long eval/benchmark run, run it through `bin/gstack-detach` — NEVER as a plain backgrounded Bash task. A plain background task lives in the harness's process group, so a SIGTERM ("polite quit") on a turn boundary, a stopped Monitor, or an interruption kills the run mid-flight (observed: `script "test:gate" was terminated by signal SIGTERM` ~40 min into a run). On macOS the run can also die to idle-sleep. `gstack-detach` fixes both: 신선한 세션 (그룹 SIGTERM)에 감싸인 `caffeinate -i` (잠자는 잠들기를 막습니다).

- `eval:bg*` 스크립트를 사용 (`eval:bg`, `eval:bg:all`, `eval:bg:gate`,
  `eval:bg:periodic`) — they wrap the eval command in `gstack-detach` with the machine-wide `gstack-evals` lock (concurrent worktrees serialize instead of saturating the shared model API), a per-tier watchdog, and a **런치스코프** log under `~/.gstack-dev/eval-runs/` (no shared-`/tmp` collision). Each prints its log path. `eval:bg:gate` / `eval:bg:periodic` run their tier through the sharded paid runner (`scripts/test-paid-shards.ts`, also exposed as `test:gate:sharded` / `test:periodic:sharded`): 테스트 파일 당 하나의 Bun 프로세스, shard의 프로세스 GROUP (stray `claude`/`codex` 그랜드 아이렌 포함), `GSTACK_EVAL_DIR=<evalDir>/shards/<slug>/`에 의해 명예를 부여하는 외부 벽시 타임 아웃, 그리고 비열한 대 timed-out 결코-started shards를 분리하는 집단, 그리고 비열한 시간 초과 (25s200s/>에 의해 계산되는), 그리고 비열한 시간 초과는 shards에 대하여 shards를 가진 반대합니다. shards/>는 벽에 대하여 shards를 위한 shards를 위한 것입니다. `EVALS_JOBS`는 shard 공정 카운트 (default 8); `EVALS_CONCURRENCY`는 bun's --max-concurrency WITHIN a shard (default 2)입니다. 그들은 deliberately 분리된 손잡이입니다. `eval:list`/`eval:compare`/
  `eval:summary` / `eval:flake-rank`는 shard dirs를 너무 읽습니다. 또는 전화
  `gstack-detach [--lock NAME] [--timeout SECS] [--label LBL] -- <cmd>`는 어떤 긴 에이전트 일을 위해 직접. 수출 `ANTHROPIC_API_KEY` 첫번째 (Argv에 있는 열쇠를 통과하십시오).
- 그런 다음 **인쇄된 logfile을 오염** 죽음의 조심자 : 휴식
  보장 `### gstack-detach EXIT=<code> ###` sentinel (success AND 실패는 둘 다 표를 합니다, 그래서 침묵은 성공을 위해 결코 실수가 아닙니다). 당신의 시계가 repo를 얻는 경우에, 이탈한 달리는 살아남기 위하여, 그래서 통나무를 항상 작동하.
- 왜 자물쇠: 몇몇 지휘자 worktrees를 가진 공유한 dev 상자는 비율 제한할 것입니다
  모델 API 두 개의 eval 스위트가 한 번에 실행하면 (각 15 방향), 대량 시간 아웃 E2E 테스트. 자물쇠는 두 번째 실행 WAIT, 콜드하지 않습니다.
- 인간은 `bun run test:evals` 그들의 자신의 맨끝에 있는 전경을 필요로 하지 않습니다
  이 — Ctrl-C가 거기있었습니다. Detachment는 에이전트 발사에만 사용됩니다.

## E2E 시험 정착물: 추출물, 복사하지 마십시오

**NEVER는 E2E 시험 정착물로 가득 차있는 SKILL.md 파일을 복사합니다.** SKILL.md 파일은 1500-2000 라인입니다. `claude -p`가 큰 파일이 읽을 때, 컨텍스트 블라우스, 플레키 턴 제한이 발생하며 5-10x를 더 이상 필요로하는 테스트가 필요합니다.

대신, 시험은 실제로 필요로 하는 단면도만 추출합니다:

```typescript
// BAD — agent reads 1900 lines, burns tokens on irrelevant sections
fs.copyFileSync(path.join(ROOT, 'ship', 'SKILL.md'), path.join(dir, 'ship-SKILL.md'));

// GOOD — agent reads ~60 lines, finishes in 38s instead of timing out
const full = fs.readFileSync(path.join(ROOT, 'ship', 'SKILL.md'), 'utf-8');
const start = full.indexOf('## Review Readiness Dashboard');
const end = full.indexOf('\n---\n', start);
fs.writeFileSync(path.join(dir, 'ship-SKILL.md'), full.slice(start, end > start ? end : undefined));
```

대상 E2E를 실행할 때 오류를 디버그합니다.
- **foreground** (`bun test ...`)에서 실행, `&`와 `tee`로 배경이 아닙니다
- `pkill` eval 프로세스를 실행하고 재시작 — 결과와 낭비를 잃습니다.
- 한 깨끗한 실행은 3 살살과 재시작 실행을 이길

## 출판 네이티브 OpenClaw ClawHub에 기술

Native OpenClaw skills live in `openclaw/skills/gstack-openclaw-*/SKILL.md`. The command is `clawhub publish` (NOT `clawhub skill publish`) — full workflow, auth, and verification: [docs/OPENCLAW_PUBLISHING.md](docs/OPENCLAW_PUBLISHING.md).

## 활성 기술에 배포

능동적 인 기술은 `~/.claude/skills/gstack/`에 생명을 불어 넣는다. 변경 후:

1. branch를 푸시
2. 기술 디렉토리에 흠뻑 빠르다: `cd ~/.claude/skills/gstack && git fetch origin && git reset --hard origin/main`
3. 재건: `cd ~/.claude/skills/gstack && bun run build`

**gbrain를 사용하는 경우:** 단계 2에서 `git reset --hard`는 뇌 인식 (`GBRAIN_CONTEXT_LOAD`/ `GBRAIN_SAVE_RESULTS`) 블록을 반전합니다 `gstack-config gbrain-refresh`는 설치 (제작품화 된 블록은 디자인에 의해 `main`와 다릅니다)로 렌더링합니다. 배포 후, 다시 실행 `gstack-config gbrain-refresh` 모든 프로젝트의 Claude 세션을 복원합니다. 그것은 공명입니다.

또는 직접 binaries를 복사하십시오:
- `cp browse/dist/browse ~/.claude/skills/gstack/browse/dist/browse`
- `cp design/dist/design ~/.claude/skills/gstack/design/dist/design`

## 기술 여정

사용자의 요청이 가능한 기술에 일치할 때, 기술 도구를 통해 호출. 의심 할 여지없이, 기술을 호출.

키 라우팅 규칙:
- 제품 아이디어/brainstorming → invoke /office-hours
- 전략/scope → invoke /plan-ceo-review
- 건축 → invoke /plan-eng-review
- 설계 시스템/plan 검토 → invoke /design-consultation 또는 /plan-design-review
- 전체 검토 파이프라인 → invoke /autoplan
- 버그/errors → /investigate
- QA/testing 사이트 행동 → invoke /qa 또는 /qa-only
- 코드 검토/diff 체크 → invoke /review
- 비주얼 폴란드어 → invoke /design-review
- Ship/deploy/PR → invoke /ship 또는 /land-and-deploy
- 진행 상황을 저장 → invoke /context-save
- 이력서 컨텍스트 → invoke /context-restore

## Cross-session 결정 기억

튼튼한 결정과 그 합리적은 부록에만 캡처됩니다, 이벤트 자원 매장에서 `~/.gstack/projects/<slug>/decisions.jsonl` 그래서 당신은 또는 사용자가 정착 통화를 다시 조명하거나 세션에 걸쳐 "왜"를 잃지. 이것은 신뢰할 수있는, 파일 전용 경로입니다 : 그것은 GBrain OFF와 함께 작동합니다. (gbrain semantic recall은 상단에 층으로 된 옵션 향상입니다, 절대 의존하지.)

- **의논하기** 재 결정 전의 적극적인 결정: `bin/gstack-decision-search`
  (`--recent N`, `--scope repo|branch|issue`, `--query KW`, `--all`, `--json`). `--semantic` (`--query`)를 추가하여 gbrain 메모리에서 관련 된 gbrain 메모리에서 append 관련; gbrain가 꺼질 때 믿을 수 있는 파일 결과에 조용히 degrades. 세션은 이미 Context Recovery를 통해 범위가 있는 활성 결정에 시작합니다. 결정이 목록으로 표시되면, 반대면에 대해 결정하는 것과 같이 대우하십시오.
- **팟캐스트** a DURABLE 결정 when you or user make one:
  `bin/gstack-decision-log '{"decision":"...","rationale":"...","scope":"repo|branch|issue","source":"user|skill|agent","confidence":1-10}'`. `--supersede <id>`로 이전 통화를 반전; `--redact <id>`로 사고 비밀을 폭발; `--compact`로 활성 설정으로 로그를 다시 작성합니다. 비동기 (안심 프롬프트), 주입 산화, 그리고 HIGH-secret-blocking 쓰기.
- **튼튼한 방법:** 건축 선택, 범위 커트, tool/vendor 선택, 또는 역방향
  우선 통화의. NOT 턴 레벨 편집, phrasing tweak, 또는 아무것도 trivially re-derivable. 캡처는 소스에서 큐레이터 - 로그 내구성 결정 만, 또는 저장소는 소음이됩니다.

## GBrain 검색 안내 (/sync-gbrain에 의해 구성)
<!-- gstack-gbrain-search-guidance:start -->

GBrain는 이 기계에 설치되고 동기화됩니다. 에이전트은 질문이 semantic 또는 만약에 정확한 식별자를 아직 모르는 경우에 윤활에 gbrain를 선호해야 합니다.

**이 worktree는 worktree-scoped 코드 근원에 핀으로 꼿습니다** 를 통해 `.gbrain-source` 의 파일 repo 루트 (kubectl-style context). `gbrain code-def`, `code-refs`, `code-callers`, `code-callees`, 또는 `query` 의 호출은 default — no `--source` 플래그가 필요한 소스에 이 worktree 노선의 밑에 이 worktree 노선에서 그 근원에 이 worktree 경로를 입력하고, 이 페이지에 있는 그들의 자신의 작품에 있는 그들의 작품이, 이렇게 실제적인 일치합니다.

`gbrain` CLI를 통해 유효한 2개의 색인된 corpora:
- 이 worktree의 코드 (`.gbrain-source`를 통해 자동 핀으로 꼿습니다.
- `~/.gstack/` curated Memory (`gstack-brain-<user>` 소스로 등록
  기존의 퓨어리 파이프).

프리퍼 gbrain 경우:
- "X가 처리되었는지?" / semantic intent, no 정확한 문자열은 아직:
    `gbrain search "<terms>"` 또는 `gbrain query "<question>"`
- "그럼은 Y 정의가 되었습니까?" / 기호 기반 코드 질문 :
    `gbrain code-def <symbol>` 또는 `gbrain code-refs <symbol>`
- "Y는 뭐요?" / "Y는 무엇을 의존합니까?" :
    `gbrain code-callers <symbol>` / `gbrain code-callees <symbol>`
- "우리는 마지막 시간을 결정 했습니까?" / 과거 계획, 복고풍, 학습 :
    `gbrain search "<terms>" --source gstack-brain-<user>`

Grep는 알려진 정확한 문자열, regex, 멀티 라인 패턴 및 파일 globs에 대한 여전히 권리입니다. 의미있는 코드 변경 후 `/sync-gbrain`를 실행하십시오. 모든 worktrees를 통해 지속적인 자동 동기화를 위해, 기계 당 `gbrain autopilot --install`를 한 번 실행하십시오. gbrain's daemon는 일정에 대한 증가를 처리합니다.

안전: `/sync-gbrain`는 `gbrain autopilot`가 활성화된 동안 `/sync-gbrain`를 실행할 때 관현관은 파괴적인 근원 ops를 거부합니다 (#1734) 경주를 피하기 위하여 autopilot를 검출합니다. `gbrain sources add --path <dir>` (no `--url`)를 가진 사용자 repos를 등록하는 Prefer: URL 관리한 근원은 자동 복제할 수 있고, 그(것)들을 위한 동기화 코드는 `--allow-reclone`를 옵트인 합니다.

<!-- gstack-gbrain-search-guidance:end -->
