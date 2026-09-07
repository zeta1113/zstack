<!-- AUTO-GENERATED from tests.md.tmpl — do not edit directly -->
<!-- Regenerate: bun run gen:skill-docs -->
## Step 4: 프레임 워크 부트 스트랩 테스트

## 테스트 프레임 워크 부트 스트랩

**프로젝트의 CLAUDE.md (및 TESTING.md 현재) FIRST를 읽으십시오.** 테스트 명령을 문서화하면 이미 프로젝트가 no 탐지, no 부츠 스트랩에 대해 알려줍니다. 부츠 스트랩의 나머지를 건너 단계 5. 명령을 사용하십시오.

**그렇지 않으면 마크를 수집합니다. 아래 모든 마커는 EVIDENCE입니다. 요청한 질문에 대한 - 장님을 실행하는 명령이 없습니다.** 마커는 OFFER 명령을 실행하고 있는 생태계를 알려줍니다. 명령이 작동되지 않습니다. 실행자가 크게 실패하고, 아무것도 가르치고, 작업 하나 이상의 두 번째 프레임 워크를 설치하지 못했던 프로젝트에서 "check"로 후보 테스트 명령을 실행하지 마십시오.

```bash
setopt +o nomatch 2>/dev/null || true  # zsh compat
# Definitive ecosystem markers (presence = ecosystem, NOT a command to run)
[ -f manage.py ] && echo "RUNTIME:python FRAMEWORK:django MARKER:manage.py"
{ [ -f pyproject.toml ] || [ -f pytest.ini ] || [ -f tox.ini ] || [ -f setup.cfg ] || [ -f requirements.txt ]; } && echo "RUNTIME:python"
[ -f Gemfile ] || [ -f Rakefile ] || [ -f .rspec ] && echo "RUNTIME:ruby"
[ -f package.json ] && echo "RUNTIME:node"
[ -f go.mod ] && echo "RUNTIME:go"
[ -f Cargo.toml ] && echo "RUNTIME:rust"
[ -f composer.json ] && echo "RUNTIME:php"
[ -f mix.exs ] && echo "RUNTIME:elixir"
[ -f pom.xml ] && echo "RUNTIME:jvm BUILD:maven"
{ [ -f build.gradle ] || [ -f build.gradle.kts ]; } && echo "RUNTIME:jvm BUILD:gradle"
# Detect sub-frameworks
[ -f Gemfile ] && grep -q "rails" Gemfile 2>/dev/null && echo "FRAMEWORK:rails"
[ -f package.json ] && grep -q '"next"' package.json 2>/dev/null && echo "FRAMEWORK:nextjs"
# Existing test path — config files, declared scripts, AND test FILES.
# A project with real tests and no config file is the common miss.
ls jest.config.* vitest.config.* playwright.config.* .rspec pytest.ini tox.ini phpunit.xml* 2>/dev/null
[ -f package.json ] && grep -q '"test"[[:space:]]*:' package.json && echo "SCRIPT:package.json test"
[ -f Makefile ] && grep -qE '^(test|check):' Makefile && echo "TARGET:make test"
[ -f pyproject.toml ] && grep -q "pytest" pyproject.toml && echo "CONFIG:pyproject pytest"
git ls-files | grep -cE '(^|/)(tests?|spec|__tests__)/|(^|/)tests?\.py$|(^|/)test_[^/]+\.py$|_test\.(go|py|rb|ts|js|exs)$|\.(test|spec)\.[jt]sx?$|_spec\.rb$|Test\.(java|kt)$' | sed 's/^/TESTFILES:/'
# Rust keeps unit tests inside src/, so file names alone miss them
[ -f Cargo.toml ] && git grep -lF '#[test]' -- 'src' >/dev/null 2>&1 && echo "TESTS:rust in-source"
# Check opt-out marker
[ -f .gstack/no-test-bootstrap ] && echo "BOOTSTRAP_DECLINED"
```

명령에 마커를 맵을 OFFER - 추측에 실행하지 못합니다.

| 팟캐스트 | 에코시스템 | Candidate 명령을 제공 |
|--------|-----------|----------------------------|
| `manage.py` | 카지노사이트 | `python manage.py test` (또는 `pytest` pytest-django가 deps에 있을 때) |
| `pytest.ini` / `tox.ini` / pytest `pyproject.toml` / `test_*.py` | Python | `pytest` |
| `go.mod` (+ `*_test.go`) | 으로 | `go test ./...` |
| `Cargo.toml` | Rust | `cargo test` |
| `pom.xml` | JVM (매우) | `mvn test` |
| `build.gradle` / `build.gradle.kts` | JVM (그라들레) | `./gradlew test` |
| `Gemfile` / `Rakefile` / `.rspec` | Ruby | `bundle exec rspec`, `bin/rails test`, `rake test` |
| `mix.exs` | Elixir | `mix test` |
| `composer.json` | PHP | `composer test` 또는 `./vendor/bin/phpunit` |
| `package.json` 와 `test` 스크립트 | Node | 그 스크립트, 패키지 관리자와 실행 lockfile 이름 |
| `Makefile` 와 `test:` 대상 | 의 모든 | `make test` |

**ANY 기존 테스트 증거가 나타나면** (a config file, a declared test script or make target, a nonzero `TESTFILES:` count, or `TESTS:rust in-source`): the project has tests. **NOT 부츠 스트랩을 합니다.** Print "Existing tests detected: {the evidence}." Then get the command the same way Step 5 does — CLAUDE.md/TESTING.md if documented, otherwise AskUserQuestion offering the candidates from the table above plus "Other", and persist the answer to CLAUDE.md's `## Testing` section so it is never asked again. 생태계가 주자 (Django, Go, Rust, Elixir, Maven/Gradle)를 발송할 때, 주자는 후보자이며, 일체의 두 번째 프레임을 설치하지 못합니다. 컨벤션 (남성, 수입, assertion 스타일, 설정 패턴)을 배우기 위해 2-3개의 기존 테스트 파일을 읽으십시오. 단계 8e.5 또는 단계 7. **부츠 스트랩의 나머지를 건너.**에서 사용하기위한 prose context로 저장 규칙

Absent config 파일과 absent `tests/` 디렉토리는 NOT의 "no 테스트"의 증거입니다. Django는 `<app>/tests.py`에서 테스트를 유지하며 `*_test.go`의 소스 외에 Rust의 `#[test]` 블록 내부 `src/`의 `python manage.py test`의 no `pytest.ini`는 테스트 프로젝트가 아니라, bootstrap 후보가 아닙니다.

**BOOTSTRAP_DECLINED를 선택하면**는 다음과 같습니다. "테스트 부츠 스트랩 이전에 쇠퇴 - 건너뛰기" **부츠 스트랩의 나머지를 건너.**

**NO 생태계 마커가 일치하면:** AskUserQuestion: "나는 프로젝트의 언어를 감지 할 수 없었다. 어떤 실행 시간은 사용합니까?" 옵션 : A) Node.js/TypeScript B) Ruby/Rails C) Python D) Go E) Rust F) PHP G) Elixir H) 이 프로젝트는 테스트가 필요하지 않습니다. 실행 시간이 없다면 "다른"파일을 제공하지 않고 H/>를 테스트하지 않고 테스트가 계속됩니다. `.gstack/no-test-bootstrap` H) Elixir H> H를 사용하지 않으면 테스트가 실행되지 않습니다.

**생태계가 일치하지만 모든 것에 no 기존 테스트 증거가 있습니다. - bootstrap:**

### B2. 연구 모범 사례

WebSearch를 사용하여 검출된 실행 시간의 현재 모범 사례를 찾을 수 있습니다.
- `"[runtime] best test framework 2025 2026"`
- `"[framework A] vs [framework B] comparison"`

WebSearch가 사용할 수 없는 경우, 이 내장된 지식 테이블을 사용하십시오:

| 런타임 | 1차 권고 | Alternative |
|---------|----------------------|-------------|
| Ruby/Rails | minitest + 정착물 + capybara | rspec + factory_bot + 아야메모커 |
| Node.js | @testing-library - 비디오 @testing-library | jest + @testing-library의 |
| Next.js | vitest + @testing-library/react + 장난 | 제스트 + cypress |
| Python | pytest + pytest-cov | unittest |
| 카지노사이트 | pytest + pytest-django | 장고의 내장 `manage.py test` (단위 테스트) |
| 으로 | stdlib 테스트 + 테스트 | stdlib만 |
| JVM (말벌/Gradle) | JUnit 5 + 어시스턴트 | JUnit 5만 |
| Rust | cargo test (붙박이에서) + 모조각 | — |
| PHP | phpunit + 모조리 | pest |
| Elixir | ExUnit (붙박이) + ex_machina | — |

### B3. 프레임 워크 선택

Use AskUserQuestion: "I detected this is a [Runtime/Framework] project with no test framework. I researched current best practices. Here are the options: A) [Primary] — [rationale]. Includes: [packages]. Supports: unit, integration, smoke, e2e B) [Alternative] — [rationale]. Includes: [packages] C) Skip — don't set up testing right now RECOMMENDATION: Choose A because [reason based on project context]"

C → `.gstack/no-test-bootstrap`를 작성하면 됩니다. " 나중에 마음을 변경하면 `.gstack/no-test-bootstrap`와 re-run"을 삭제합니다. 테스트하지 않고 계속하십시오.

여러 번의 실행이 감지되면 (monorepo) → 먼저 설정할 때, 두 번의 순차적으로 수행 할 수있는 옵션.

## B4. 설치 및 구성

1. 선택된 패키지 설치 (npm/bun/gem/pip/etc.)
2. 최소 설정파일 생성
3. 디렉토리 구조 (test/, spec/, 등)를 만듭니다.
4. 설정 작업을 확인하기 위해 프로젝트의 코드를 일치하는 하나의 예 테스트 만들기

패키지 설치가 실패하면 → 디버그 한 번. 여전히 실패하면 → `git checkout -- package.json package-lock.json` (또는 실행 시간에 해당). Warn 사용자는 테스트없이 계속됩니다.

### B4.5. 첫번째 진짜 시험

기존 코드를 위한 3-5개의 실제 테스트를 생성:

1. **최근 변경된 파일 찾기:** `git log --since=30.days --name-only --format="" | sort | uniq -c | sort -rn | head -10`
2. **위험에 대한 우선 순위:** 오류 핸들러 > 상태와 비즈니스 논리 > API 엔드포인트 > 순수 함수
3. **각 파일에 대 한:**는 의미 있는 assertions를 가진 실제적인 행동을 시험하는 1개의 시험을 씁니다. `expect(x).toBeDefined()` — 코드 DOES를 시험하십시오.
4. 각 테스트를 실행합니다. Passes → 유지. 실패 → 한 번 수정. 여전히 실패 → 침묵으로 삭제.
5. 최소 1개의 시험, 5에 모자를 생성하십시오.

비밀, API 키, 또는 테스트 파일에 있는 자격 증명을 가져올 수 없습니다. 환경 변수 또는 테스트 정착물을 사용하십시오.

### B5. 검증

```bash
# Run the full test suite to confirm everything works
{detected test command}
```

테스트가 실패하면 → 디버그가 한 번. 여전히 실패하면 → 모든 부츠 스트랩 변경 및 경고 사용자를 반전합니다.

### B5.5. CI/CD 파이프라인

```bash
# Check CI provider
ls -d .github/ 2>/dev/null && echo "CI:github"
ls .gitlab-ci.yml .circleci/ bitrise.yml 2>/dev/null
```

`.github/`가 존재하면 (또는 no CI가 검출됨 - default에서 GitHub작동): `.github/workflows/test.yml`를 생성하고:
- `runs-on: ubuntu-latest`
- 실행 시간 (설정-node, 설정-ruby, 설정-python, 등)에 대한 적절한 설정 작업
- B5에서 확인된 동일한 테스트 명령
- 방아쇠: push + pull_request

CI 검출된 CI 생성을 가진 CI 생성을 비로그면 CI 파이프라인 생성은 GitHub 작용만 지원합니다. 기존 파이프라인에 테스트 단계를 수동으로 추가하십시오."

## B6. TESTING.md를 만듭니다

첫 번째 체크: TESTING.md 이미 존재하면 → 그것을 읽고 과잉 보다는 오히려 업데이트/append. 기존 콘텐츠를 파괴하지 마십시오.

TESTING.md 을 다음과 같이 작성:
- 철학: "100% 시험 적용은 중대한 vibe 기호화에 열쇠입니다. 시험은 당신이 빨리 움직이고, 당신의 instincts를 신뢰하고, 신뢰도로 발송합니다 - 그(것) 없이, vibe 기호화는 다만 yolo 기호화입니다. 시험으로, 그것은 superpower입니다."
- Framework 이름 및 버전
- 테스트 실행 방법 (B5에서 확인된 명령)
- 테스트 층: 단위 시험 (무엇, 어디, 언제), 통합 시험, 연기 시험, E2E 시험
- 컨벤션: 파일 명명, assertion 작풍, setup/teardown 본

## B7. 업데이트 CLAUDE.md

첫 번째 체크: CLAUDE.md 이미 `## Testing` 섹션 → 건너뛰기. 중복하지 마십시오.

`## Testing` 섹션을 승인하십시오:
- 명령 및 테스트 디렉토리
- TESTING.md에 대한 참조
- 시험 기대:
  - 100% 시험 적용은 목표입니다 — 시험은 vibe 기호화 안전을 만듭니다
  - 새로운 기능을 작성할 때, 대응 시험을 작성
  - 버그를 수정할 때, 회귀 테스트를 작성
  - 오류 처리 추가시 오류를 트리거하는 테스트 작성
  - 조건 (/else, 스위치)를 추가할 때, BOTH 경로에 대한 테스트 쓰기
  - commit 코드를 사용하지 않고 기존의 테스트를 실패

## B8. 모조

```bash
git status --porcelain
```

commit가 변경되면 commit 를 지정합니다. 모든 부팅 스트랩 파일 (config, test directory, TESTING.md, CLAUDE.md, .github/workflows/test.yml 를 생성하면): `git commit -m "chore: bootstrap test framework ({framework name})"`

---

---

## Step 5: 실행 테스트 (합합계 코드)

**NOT 실행 `RAILS_ENV=test bin/rails db:migrate`** - `bin/test-lane` 이미 `db:test:prepare`를 호출하고, 이는 올바른 차선 데이터베이스로 스키마를 로드합니다. INSTANCE가 안타깝게도 bare 테스트 마이그레이션을 실행하고 DB와 corrupts 구조.sql을 파고 있습니다.

평행한에 있는 시험 스위트를 둘 다 달리기, 각은 증거 원장에서 감싸입니다. 래퍼는 투명한 (동류 산출 살아있는, 출구 코드 통행)이고 `{command, exit, working-tree fingerprint, log path}`에 `~/.gstack/projects/<slug>/<branch>-evidence.jsonl`를 기록합니다 — 내용이 바뀌지 않을 때 재 실행의 이 기록을 나타내십시오:

```bash
~/.claude/skills/gstack/bin/gstack-evidence run --label tests -- 'bin/test-lane 2>&1' &
~/.claude/skills/gstack/bin/gstack-evidence run --label vitest -- 'npm run test 2>&1' &
wait
```

완료 후 `gstack-evidence: recorded label=... exit=... log=...` 요약 줄을 체크하십시오. 각 차선의 출구 코드와 per-run 로그 파일 (no는 concurrent 배 사이 /tmp 충돌을 공유했습니다)를 나릅니다. 실패 세부사항을 위한 기록 파일을 읽으십시오.

**어떤 시험이 실패하면:** NOT 즉시 정지. 시험 실패 소유권 부족 적용:

## 시험 실패 소유권 부족

테스트가 실패하면 NOT 즉시 중지합니다. 우선, 소유권을 결정하십시오.

### 단계 T1: 각 실패를 분류하십시오

각 실패 시험에 대 한:

1. **이 branch에 변경된 파일을 가져옵니다:**
   ```bash
   git diff origin/<base>...HEAD --name-only
   ```

2. **실패를 분류하십시오:**
   - **In-branch** if: 실패 테스트 파일 자체는 branch, OR 이 branch, OR에 바뀌는 시험 산출 참고 코드에, branch diff에 있는 변화에 실패를 추적할 수 있는 branch에 변경된.
   - **의외로 사전 노출** if: 테스트 파일도 없고, 테스트는 branch, AND 실패는 어떤 branch 변화든지에 관련이 없습니다.
   - **주변을 겪을 때, default에서 in-branch.** 그것은 깨진 시험 배를 시키기 보다는 개발자를 멈추는 더 안전한 입니다. 당신이 confident 때만 pre-existing로 분류하십시오.

   이 분류는 heuristic — 당신의 판단을 diff와 시험 산출 읽습니다. 당신은 programmatic 의존성 도표가 없습니다.

### 단계 T2: 브레이크 실패를 취급하십시오

**STOP.** 이 실패입니다. 그들을 표시하고 진행하지 마십시오. 개발자는 배송하기 전에 자신의 깨진 테스트를 수정해야합니다.

### 단계 T3: 사전 노출 실패를 취급하십시오

preamble 출력에서 `REPO_MODE`를 확인합니다.

**REPO_MODE는 `solo`인 경우:**

AskUserQuestion를 사용하십시오:

> 이 시험 실패는 사전 노출 (당신의 branch 변화에 기인하지 않음)를 나타납니다:
>
> [파일과 각 실패 목록:라인과 간단한 오류 설명]
>
> 이 솔로 repo이므로, 이 문제를 해결하는 유일한 사람입니다.
>
> RECOMMENDATION: A를 선택하십시오 — 수정은 이제 문맥이 신선하면서. 완료: 9/10.
> A) 조사 및 수정 (인간 : ~2-4h / CC : ~15min) - 완료 : 10/10
> B) P0 TODO로 추가 - 이 branch 땅 후에 고침 - 완료: 7/10
> C) Skip — 나는이에 대해 알고, 어쨌든 배송 — 완료: 3/10

**REPO_MODE는 `collaborative` 또는 `unknown`인 경우:**

AskUserQuestion를 사용하십시오:

> 이 시험 실패는 사전 노출 (당신의 branch 변화에 기인하지 않음)를 나타납니다:
>
> [파일과 각 실패 목록:라인과 간단한 오류 설명]
>
> 이것은 공동 repo입니다. 이것은 다른 사람의 책임이 될 수 있습니다.
>
> RECOMMENDATION: B를 선택하십시오 — 그 누구든지 그것을 부패하기 위하여 그것을 이렇게 적당한 사람이 그것을 고칠. 완료: 9/10.
> A) 투자 및 해결 지금 어쨌든 - 완료 : 10/10
> B) Blame + GitHub 저자에 대한 문제 - 완료 : 9/10
> C) P0 TODO로 추가하십시오 — 완료: 7/10
> D) Skip — 어떤 방향으로 배 — 완료: 3/10

### 단계 T4: 선택된 동작을 실행

**"투자 및 수정 사항"이 있다면:**
- /investigate로 전환: 루트가 먼저 발생하고, 최소 수정.
- 사전 노출 실패를 수정합니다.
- branch의 변경에서 별도로 수정을 시작합니다. `git commit -m "fix: pre-existing test failure in <test-file>"`
- 작업 흐름을 계속합니다.

**"P0 TODO로 추가하는 경우:**
- `TODOS.md`가 존재하면 `review/TODOS-format.md` (또는 `.claude/skills/review/TODOS-format.md`)의 형식을 따르는 항목이 추가됩니다.
- `TODOS.md`가 존재하지 않는 경우, 표준 헤더로 생성하고 항목을 추가합니다.
- 입력은 다음을 포함한다 : 제목, 오류 출력, branch 그것은 눈에 띄는, 우선 P0.
- 워크플로우로 계속 - 차단을 해제하기 위해 사전 노출 실패를 치료합니다.

**"Blame + 할당 GitHub 문제"(채권자 만):**
- 그 가능성이 끊어지는 것을 발견하십시오. BOTH 시험 파일 AND 생산 코드를 검사하십시오:
  ```bash
  # Who last touched the failing test?
  git log --format="%an (%ae)" -1 -- <failing-test-file>
  # Who last touched the production code the test covers? (often the actual breaker)
  git log --format="%an (%ae)" -1 -- <source-file-under-test>
  ```
  이 다른 사람들이 있다면, 생산 코드 저자를 선호합니다. 그들은 회귀를 소개 할 가능성이 있습니다.
- 그 사람에게 할당된 문제점을 작성하십시오 (단계 0에서 검출된 플랫폼 사용):
  - **GitHub:**
    ```bash gh issue create \ --title "Pre-existing test failure: <test-name>" \ --body "Found failing on branch <current-branch>. Failure is pre-existing.\n\n**Error:**\n```\n<first 10 lines>\n```\n\n**최근 수정일:** <author>\n**에 의해 통지:** gstack /ship on <date>" \ --assignee "<github-username>"
    ```
  - **GitLab의 경우:**
    ```bash glab issue create \ -t "Pre-existing test failure: <test-name>" \ -d "Found failing on branch <current-branch>. Failure is pre-existing.\n\n**Error:**\n```\n<first 10 lines>\n```\n\n**최근 수정일:** <author>\n**에 의해 통지:** gstack /ship on <date>" \ -a "<gitlab-username>"
    ```
- CLI는 유효하지 않거나 `--assignee`/`-a`는 (org, etc.에서 아닙니다) 실패하고, 할당하지 않고 문제점을 만들고 몸에서 그것을 보는 주의하십시오.
- 작업 흐름을 계속합니다.

**"Skip"의 경우:**
- 작업 흐름을 계속합니다.
- 출력에 있는 주: "전사 시험 실패 건너뛰기: <test-name>"

**삼일 후:** 어떤 in-branch 실패가 불명한, **STOP**든지 경우에. 진행하지 마십시오. 모든 실패가 전출되고 취급된 경우에 (fixed, TODOed, 할당된, 또는 건너뛰기), 단계 6.에 계속하십시오.

**모든 패스가 있는 경우:** Continue Silently — 단지 카운트를 간단히 참고합니다.

---

## 단계 6: Eval Suites (조건)

Evals는 신속한 관련 파일 변경이 있을 때 필수입니다. no 프롬프트 파일이 diff에 있는 경우에 이 단계를 완전히 건너 뛰십시오.

**1. diff가 프롬프트 관련 파일에 대해 확인:**

```bash
git diff origin/<base> --name-only
```

이 패턴에 대한 일치 (CLAUDE.md에서):
- `app/services/*_prompt_builder.rb`
- `app/services/*_generation_service.rb`, `*_writer_service.rb`, `*_designer_service.rb`
- `app/services/*_evaluator.rb`, `*_scorer.rb`, `*_classifier_service.rb`, `*_analyzer.rb`
- `app/services/concerns/*voice*.rb`, `*writing*.rb`, `*prompt*.rb`, `*token*.rb`
- `app/services/chat_tools/*.rb`, `app/services/x_thread_tools/*.rb`
- `config/system_prompts/*.txt`
- `test/evals/**/*` (eval 인프라 변경은 모든 스위트에 영향을 미칩니다)

**no 경기:** "No 프린트 관련 파일 변경 - evals를 건너 뛰기." 그리고 계속 단계 9.

**2. 영향을받는 eval 제품군을 식별합니다.**

각 eval runner (`test/evals/*_eval_runner.rb`)는 `PROMPT_SOURCE_FILES` 목록으로 만들어 소스 파일에 영향을줍니다. 이 옵션을 찾을 수 있습니다. 변경된 파일 일치:

```bash
grep -l "changed_file_basename" test/evals/*_eval_runner.rb
```

지도 주자 → 시험 파일: `post_generation_eval_runner.rb` → `post_generation_eval_test.rb`.

**특별 사례:**
- `test/evals/judges/*.rb`, `test/evals/support/*.rb`, `test/evals/fixtures/` 에 영향을 미쳤을 때 ALL 에 영향을 미칩니다. /support 파일을 사용. eval 테스트 파일에 가져 오기를 확인하여 결정합니다.
- `config/system_prompts/*.txt`로 변경 - 영향을받는 스위트를 찾기 위해 신속한 파일 이름에 대한 grep eval runners.
- 영향을받지 않는 경우, ALL 스위트를 실행하면, 가용성이 영향을 줄 수 있습니다. 과 테스트는 반복이 없으면 더 좋습니다.

**3. `EVAL_JUDGE_TIER=full`에서 영향을 받는 스위트를 실행하십시오:**

`/ship`는 전 merge 문, 그래서 항상 가득 차있는 층 (Sonnet 구조상 + Opus persona 판사)를 이용합니다.

```bash
EVAL_JUDGE_TIER=full EVAL_VERBOSE=1 bin/test-lane --eval test/evals/<suite>_eval_test.rb 2>&1 | tee /tmp/ship_evals.txt
```

여러 스위트가 실행되어야한다면, 순차적으로 실행하십시오 (각은 테스트 레인이 필요합니다). 첫 스위트가 실패하면 즉시 중지됩니다. 나머지 스위트에 API 비용을 태울 수 없습니다.

**긴 eval 스위트 (30 + min) : 차례의 경계를 쫓아 버릴 수 없습니다.** 하네스 프로세스 그룹에 일반 배경 eval 생활과 회전 경계에 SIGTERM ("polite 종료"), 정지 모니터 또는 중단 (중간`/ship`: `script terminated by signal SIGTERM`). `~/.claude/skills/gstack/bin/gstack-detach`를 통해 실행하십시오 - 그것은 그것의 자신의 회의에서 살아남고, 기계 자물쇠 (no API 포화)를 통해 다른 worktrees에 대하여 serializes, 그리고 보장한 `### gstack-detach EXIT=<code> ###` sentinel를 쓰십시오:

```bash
~/.claude/skills/gstack/bin/gstack-detach --label ship-evals --lock gstack-evals --timeout 5400 -- <project eval command>
```

그런 다음 인쇄 로그 경로를 오염; `EXIT=` sentinel에 깰 (모든 패스와 충돌을 덮습니다 - 침묵은 결코 성공하지 않습니다). 분리 된 실행은 당신의 poller가 재발하는 경우에도 살아남을 수 있습니다.

**4. 결과 확인:**

- **어떤 eval이 실패하면:** 실패, 비용 대쉬보드 및 **STOP**를 표시하십시오. 진행하지 마십시오.
- **모든 패스가 있는 경우:** 참고 통행 조사 및 비용. 단계 9에 계속하십시오.

**5. eval 산출을 저장하십시오** - PR체내의 eval 결과와 Cost 대시보드를 포함합니다.

**Tier 참고 ( context의 경우 - /ship는 항상 `full`를 사용합니다.**
| Tier | 의 의 | 속도 (스케이드) | Cost |
|------|------|----------------|------|
| `fast` (하쿠) | 침식, 연기 테스트 | ~5s (14x 더 빠른) | ~$0.07/run |
| `standard` (수) | Default dev, `bin/test-lane --eval` | ~17s (4x 더 빠른) | ~$0.37/run |
| `full` (오푸스 앵) | **`/ship` 및 전 merge** | ~72s (기본) | ~$1.27/run |

---
