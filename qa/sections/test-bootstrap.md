<!-- AUTO-GENERATED from test-bootstrap.md.tmpl — do not edit directly -->
<!-- Regenerate: bun run gen:skill-docs -->
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
