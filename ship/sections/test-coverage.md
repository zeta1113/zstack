<!-- AUTO-GENERATED from test-coverage.md.tmpl — do not edit directly -->
<!-- Regenerate: bun run gen:skill-docs -->
## Step 7: 시험 적용 감사

**이 단계를 subagent로 Dispatch** 를 사용하여 에이전트 도구 `subagent_type: "general-purpose"`. 서브 에이전트은 신선한 컨텍스트 창에서 적용 감사를 실행합니다. 부모는 결론을 볼 수 있으며 중간 파일이 읽지 않습니다. 이것은 컨텍스트로 방어입니다.

**필요한 경우:** 패스 `run_in_background: false` 에이전트 호출에서 - 서브 에이전트은 Claude Code v2.1.198 이후 기본적으로 BACKGROUND에서 실행됩니다. (더 이상 플래그를 생성하지 않는 것은 전경 실행을 생성합니다. 그것은 명시적으로 false이어야합니다.) 파견은 에이전트 도구를 통해 ONLY를 발생합니다. 이 문서는 "이 문서는 "이 문서는 "이 문서는"라고 합니다. 예를 들어, "이 문서는 "이 문서는"라고 합니다. "이 문서는 "이 문서는"라고 합니다. "이 문서는 "이 문서는"라고 합니다. "이 문서는 "이 문서는"라고 합니다. "이 문서는 "이 문서는"라고 합니다. "이 문서는 "이 문서는"라고 합니다. "이 문서는 "이 문서는"라고 합니다. "이 문서는 "이 문서는"라고 합니다.).

**에이전트 프롬프트:**는 기본 branch과 대체된 `<base>`와 더불어 에이전트에 뒤에 오는 지시를 통과합니다:

> 배스 워크플로 테스트 적용 감사를 실행하고 있습니다. `git diff <base>...HEAD`를 필요에 따라 실행하십시오. 커밋하거나 푸시하지 마십시오. — 보고만.
>
> 100% 적용은 목표입니다 — 모든 테스트되지 않은 경로는 버그가 숨기고 vibe 코딩이 요로 코딩이되는 경로입니다. ACTUALLY 코드가 된 것을 평가하십시오 (diff에서), 계획되지 않았습니다.

### 테스트 프레임 워크 감지

적용을 분석하기 전에 프로젝트의 테스트 프레임을 감지하십시오.

1. **CLAUDE.md를 읽으십시오** - 테스트 명령과 프레임 워크 이름을 가진 `## Testing` 섹션을 찾습니다. 발견되면, 권한으로 사용하는 것을 사용합니다.
2. **CLAUDE.md는 시험 단면도가 없는 경우에, 자동 탐지:**

```bash
setopt +o nomatch 2>/dev/null || true  # zsh compat
# Detect project runtime (markers are evidence, not commands to run blind)
[ -f manage.py ] && echo "RUNTIME:python FRAMEWORK:django"
{ [ -f pyproject.toml ] || [ -f pytest.ini ] || [ -f tox.ini ] || [ -f setup.cfg ] || [ -f requirements.txt ]; } && echo "RUNTIME:python"
[ -f Gemfile ] || [ -f Rakefile ] || [ -f .rspec ] && echo "RUNTIME:ruby"
[ -f package.json ] && echo "RUNTIME:node"
[ -f go.mod ] && echo "RUNTIME:go"
[ -f Cargo.toml ] && echo "RUNTIME:rust"
[ -f pom.xml ] && echo "RUNTIME:jvm BUILD:maven"
{ [ -f build.gradle ] || [ -f build.gradle.kts ]; } && echo "RUNTIME:jvm BUILD:gradle"
# Check for existing test infrastructure — config files, scripts, AND test files
ls jest.config.* vitest.config.* playwright.config.* cypress.config.* .rspec pytest.ini tox.ini phpunit.xml 2>/dev/null
[ -f package.json ] && grep -q '"test"[[:space:]]*:' package.json && echo "SCRIPT:package.json test"
[ -f Makefile ] && grep -qE '^(test|check):' Makefile && echo "TARGET:make test"
git ls-files | grep -cE '(^|/)(tests?|spec|__tests__)/|(^|/)tests?\.py$|(^|/)test_[^/]+\.py$|_test\.(go|py|rb|ts|js|exs)$|\.(test|spec)\.[jt]sx?$|_spec\.rb$|Test\.(java|kt)$' | sed 's/^/TESTFILES:/'
```

3. **틀이 검출되지 않는 경우:**는 전체 설정 처리가 가능한 Test Framework 부트 스트랩 단계(Step 4)로 떨어졌습니다.

**0. 전에/after 테스트 수:**

```bash
# Count test files before any generation
git ls-files 2>/dev/null | grep -E '(\.test\.|\.spec\.|_test\.|_spec\.)' | wc -l
```

PR체에 대한 이 번호를 저장합니다.

**1. 각 코콜 변경** using `git diff origin/<base>...HEAD`:

각 변경된 파일을 읽으십시오. 각 경우, 코드를 통해 데이터 흐름을 추적하는 방법 — 단지 목록 함수가 아니라, 실제로 실행을 따르십시오:

1. **diff를 읽으십시오.** 각 변경된 파일을 위해, 풀 파일 (dff hunk)를 읽어서 컨텍스트를 이해하십시오.
2. 각 항목 지점에서 시작 **Trace 데이터 흐름.** (도보 핸들러, 수출된 기능, 사건 들수, 성분 렌더링), 각 지점을 통해 데이터를 따르십시오:
   - 입력이 어디에서 왔습니까? (복사, props, database, API 호출)
   - 어떤 변화가? (무효, 매핑, 계산)
   - 어디가? (데이터베이스 쓰기, API 응답, 렌더링 출력, 측면 효과)
   - 각 단계에 잘못 될 수 있습니까? (null/undefined, 잘못된 입력, 네트워크 실패, 빈 수집)
3. **실행을 다이어그램.** 각 변경된 파일을 위해, ASCII 도표 전시를 그립니다:
   - 추가 또는 수정 된 모든 함수/method
   - 각 조건부 (/else, 스위치, ternary, 감시 절, 이른 반환)
   - 모든 오류 경로 (try/catch, 구조, 오류 경계, fallback)
   - 다른 함수에 대한 모든 호출 (그것으로 추적 — IT는 untested branch가 있습니까?)
   - 모든 가장자리 : null 입력으로 무슨 일이? 빈 배열? 잘못된 유형?

이 중요한 단계입니다. 입력을 기반으로 서로 다른 코드를 실행할 수 있는 모든 줄의 맵을 구축할 수 있습니다. 이 다이어그램의 모든 지점은 테스트가 필요합니다.

**2. 사용자의 흐름, 상호 작용, 과 오류 상태:**

Code 적용은 충분하지 않습니다. 실제 사용자들이 변경된 코드와 어떻게 상호 작용하는지 커버해야 합니다. 각 변경된 기능에 대해서는 다음을 통해 생각하십시오.

- **사용자 흐름:** 어떤 행동의 순서가 이 코드를 접촉하는지? 전체 여행 (예를들면, "사용자는 'Pay' → 양식 유효성 검사 → API 콜 → success/failure 스크린을 클릭한다. 여행의 각 단계는 테스트가 필요합니다.
- **Interaction 가장자리 상자:** 사용자가 예기치 않은 경우 어떻게됩니까?
  - 더블클릭/rapid 재조달
  - 중점 운영(뒤 버튼, 닫기 탭, 다른 링크를 클릭)
  - stale data 제출 (페이지는 30 분 동안 열려, 세션 만료)
  - 느린 연결 (API는 10 초를 걸립니다 — 사용자는 무엇을 보는가?)
  - 동시 행동 (두 개의 탭, 같은 형태)
- **오류는 사용자가 볼 수 있습니다.:** 각 오류에 대한 코드 핸들, 사용자의 실제 경험은 무엇입니까?
  - 명확한 오류 메시지 또는 침묵 실패가 있습니까?
  - 사용자가 재실행(레트리, 돌아가고, 입력을 수정) 하거나 갇혀 있습니까?
  - 네트워크가 없나요? API에서 500으로? 서버에서 잘못된 데이터로?
- **Empty/zero/boundary 주:** UI는 0개의 결과로 보여줍니다? 10,000개의 결과로? 단 하나 특성 입력으로? 최대 길이 입력으로?

코드 지점과 함께 다이어그램에 추가하십시오. 테스트가없는 사용자 흐름은 /else가 아닌 한 틈만큼이나 틈새입니다.

**3. 기존 테스트에 대한 각 지점을 확인:**

분기별로 다이어그램 분기를 통해 이동 — 모두 코드 경로 AND 사용자 흐름. 각 하나에 대한, 그것을 연습하는 테스트에 대한 검색:
- 기능 `processPayment()` → `billing.test.ts`, `billing.spec.ts`, `test/billing_test.rb`를 위한 보기
- /else → BOTH를 덮는 시험에 대한 진정한 AND false 경로
- 오류 핸들러 → 특정 오류 상태를 트리거하는 테스트에 대한
- `helperFn()`로 전화하면 자체 지점이 있고 그 지점이 시험도 할 수 있습니다.
- 사용자 흐름 → 여행을 통해 걸음을 걷는 통합 또는 E2E 테스트에 대한
- 상호 작용하는 가장자리 케이스 → 예상치 못한 동작을 시뮬레이션하는 테스트에 대한

품질 득점 루퍼:
- ★★★ 가장자리 케이스와 동작을 테스트 AND 오류 경로
- ★★ 정확한 행동, 행복한 경로만 테스트
- ★ 연기 테스트 / 존재 체크 / 트리 바이알 assertion (예 : "그것은 렌더링", "그것은 던지지 않습니다")

### E2E 테스트 결정 매트릭스

각 지점을 검사할 때, 단위 테스트 또는 E2E/integration 테스트가 올바른 도구인지 결정합니다.

**RECOMMEND E2E (도표에서 [→E2E]로 표시):**
- Common user flow spanning 3+ 구성품/services (예: signup → email → first login)
- 실제 실패를 숨기는 통합 지점 (예 : API → 큐 → 노동자 → DB)
- Auth/payment/data-destruction 흐름 - 단독으로 신뢰할 수 있는 단위 테스트에 너무 중요합니다

**RECOMMEND EVAL (도표에서 [→EVAL]로 표시):**
- 긴요한 LLM는 질 eval (e.g., 신속한 변화 → 시험 산출을 아직도 만족시키는 질 막대기를 요구합니다)를 부르습니다
- 템플릿, 시스템 지침, 도구 정의 변경

**STICK WITH UNIT TESTS:**
- 명확한 입력을 가진 순수한 기능/outputs
- 부작용이 없는 내부 돕기
- 단일 함수의 Edge case(null input, 빈 배열)
- Obscure/rare는 고객의 관계가 아닙니다

## REGRESSION RULE (필수)

**IRON RULE:** 적용 감사가 REGRESSION를 식별할 때 이전에 일했지만 diff broke - 회귀 테스트가 즉시 작성되었습니다. AskUserQuestion 없음. Skipping. 회귀는 무언가가 깨지기 때문에 가장 높은 선험 시험입니다.

회귀가 될 때:
- diff는 기존의 동작을 modify(새 코드가 아닙니다)
- 기존의 테스트 스위트(무엇이면)는 변경된 경로가 덮지 않습니다.
- 변경은 기존의 콜러에 대한 새로운 실패 모드를 소개합니다.

변경이 회귀인지 여부를 불허 할 때, 시험의 측면에 err.

형식 : `test: regression test for {what broke}`로 커밋

**4. 산출 ASCII 적용 도표:**

BOTH 코드 경로와 같은 다이어그램에서 사용자 흐름을 포함 합니다. 표시 E2E 가치와 eval 가치 경로:

```
CODE PATHS                                            USER FLOWS
[+] src/services/billing.ts                           [+] Payment checkout
  ├── processPayment()                                  ├── [★★★ TESTED] Complete purchase — checkout.e2e.ts:15
  │   ├── [★★★ TESTED] happy + declined + timeout      ├── [GAP] [→E2E] Double-click submit
  │   ├── [GAP]         Network timeout                 └── [GAP]        Navigate away mid-payment
  │   └── [GAP]         Invalid currency
  └── refundPayment()                                 [+] Error states
      ├── [★★  TESTED] Full refund — :89                ├── [★★  TESTED] Card declined message
      └── [★   TESTED] Partial (non-throw only) — :101  └── [GAP]        Network timeout UX

LLM integration: [GAP] [→EVAL] Prompt template change — needs eval test

COVERAGE: 5/13 paths tested (38%)  |  Code paths: 3/5 (60%)  |  User flows: 2/8 (25%)
QUALITY: ★★★:2 ★★:2 ★:1  |  GAPS: 8 (2 E2E, 1 eval)
```

전설: ★★★ 행동 + 가장자리 + 오류 | ★★ 행복한 경로 | ★ 연기 체크 [→E2E] = 통합 테스트 필요 | [→EVAL] = 필요 LLM eval

**빠른 경로:** 모든 경로가 덮여 → "Step 7 : 모든 새로운 코드 경로는 테스트 적용 ✓"를 계속합니다.

**5. 발견되지 않은 경로에 대한 테스트 생성 :**

테스트 프레임 워크 감지 (또는 단계 4)에 부트 스트랩:
- 오류 핸들러와 가장자리 케이스를 우선순위 (행복 경로는 이미 테스트 될 가능성이 더 있습니다)
- 2 ~ 3 기존 테스트 파일을 정확히 일치
- 단위 테스트를 생성. 모든 외부 의존성 (DB, API, Redis)를 매기십시오.
- 경로를 표시 [→E2E]: 프로젝트의 E2E 프레임워크를 사용하여 통합/E2E 테스트를 생성 (Playwright, Cypress, Capybara 등)
- 표시된 경로에 대해서는 [→EVAL]: 프로젝트의 eval 프레임워크를 사용하여 eval 테스트를 생성하거나, 수동 eval을 위한 flag는 존재하지 않는 경우
- 실제 주장과 특정 발견 된 경로를 연습하는 테스트 쓰기
- 각 테스트를 실행합니다. Passes → `test: coverage for {feature}`로 커밋
- 실패 → 한 번 수정. 여전히 실패 → 뒤로, 다이어그램의 메모 간격.

모자: 최대 30개의 코드 경로, 20의 시험 생성된 최대 (코드 + 사용자 교류 결합), 2 분 per-test 탐험 모자.

테스트 프레임 워크 AND 사용자가 부트 스트랩 → 다이어그램 만 감소하지 않는 경우, 생성. 참고 : "테스트 생성 건너 뛰기 - 테스트 프레임 워크가 형성되지 않습니다."

**Diff는 시험 전용 변화입니다:** 스킵 단계 7 완전히: "새로운 응용 프로그램 코드는 감사하는 경로"

**6. 할인 및 적용 요약 :**

```bash
# Count test files after generation
git ls-files 2>/dev/null | grep -E '(\.test\.|\.spec\.|_test\.|_spec\.)' | wc -l
```

PR 몸: `Tests: {before} → {after} (+{delta} new)` 적용 선: `Test Coverage Audit: N new code paths. M covered (X%). K tests generated, J committed.`

**7. 적용 문:**

진행하기 전에 `## Test Coverage` 섹션 `Minimum:` 및 `Target:` 필드를 CLAUDE.md를 확인합니다. 발견되면 해당 비율을 사용하십시오. 그렇지 않으면 기본값을 사용하십시오. 최소 = 60 %, 대상 = 80 %.

substep 4의 도표에서 적용 비율을 사용하여 (`COVERAGE: X/Y (Z%)` 선):

- **>= 대상:** 패스. "복사 게이트: PASS ({X}%)." 계속.
- **>= 최소, < 대상:** AskUserQuestion를 사용하십시오:
  - "AI-assessed 적용은 {X}%입니다. {N} 코드 경로는 테스트되지 않습니다. 대상은 {target}%입니다."
  - RECOMMENDATION: 시험되지 않은 코드 경로가 어디 생산 버그가 숨겨져 있기 때문에 A를 선택하십시오.
  - 옵션:
    A) 나머지 격차에 대한 더 많은 테스트를 생성 (권장) B) 어쨌든 배송 - 나는 적용 위험 C를 수용한다) 이러한 경로는 테스트가 필요하지 않습니다 - 의도적으로 발견 된 표
  - A: 나머지 간격을 표하는 5 (진격 시험)를 substep로 돌아갑니다. 표적의 밑에 아직도, 현재 AskUserQuestion를 갱신한 수로 다시 반복하십시오. 최대 2 발생은 합계를 전달합니다.
  - B: 계속. PR체에 포함: "Coverage gate: {X}% — 사용자 허용 위험."
  - C: 계속. PR체 포함: "오버지 게이트: {X}% — {N} 경로를 의도적으로 발견."

- **< 최소:** AskUserQuestion를 사용하십시오:
  - "AI-assessed 적용은 매우 낮은것 ({X}%)입니다. {M} 코드 경로의 {N}에는 아무 시험도 없습니다. 최소 임계값은 {minimum}%입니다."
  - RECOMMENDATION: {minimum}% 보다는 더 적은이 시험하는 것보다 더 많은 코드가 시험되지 않다는 것을 선택하기 때문에 A를 선택하십시오.
  - 옵션:
    A) 나머지 격차 (추천) B) Override - 낮은 적용으로 배 (나는 위험을 이해)
  - A: 단계 5. 최대 2 패스로 돌아 가기. 2 패스 이후 최소 아래 여전히, 다시 override 선택을 제시.
  - B: 계속. PR체에 포함: "오버지 게이트: OVERRIDDEN {X}%에서."

**적용 비율 undetermined:** 적용 다이어그램이 명확한 수치 비율 (각각 출력, 파삭 오류), **문 건너뛰기**를 생성하지 않는 경우: "배당 게이트: 비율을 결정할 수 없습니다 — 건너뛰기." 0% 또는 차단으로 기본값이 없습니다.

**시험 전용 diffs:** 게이트를 건너 (현재의 빠른 방향과 동일).

**100%년 적용:** "복사 게이트: PASS (100%)." 계속.

### 시험 계획 Artifact

적용 다이어그램을 생산한 후, 테스트 플랜을 작성한 후 `/qa` 와 `/qa-only` 를 사용해서 다음을 사용해서는 안됩니다:

```bash
eval "$(~/.claude/skills/gstack/bin/gstack-slug 2>/dev/null)" && mkdir -p ~/.gstack/projects/$SLUG
USER=$(whoami)
DATETIME=$(date +%Y%m%d-%H%M%S)
```

`~/.gstack/projects/{slug}/{user}-{branch}-ship-test-plan-{datetime}.md`에 쓰기:

```markdown
# Test Plan
Generated by /ship on {date}
Branch: {branch}
Repo: {owner/repo}

## Affected Pages/Routes
- {URL path} — {what to test and why}

## Key Interactions to Verify
- {interaction description} on {page}

## Edge Cases
- {edge case} on {page}

## Critical Paths
- {end-to-end flow that must work}
```
>
> 분석 후, 단일 JSON 객체를 LAST LINE의 응답 (다른 텍스트가 그 후에도) 출력하십시오:
> `{"coverage_pct":N,"gaps":N,"diagram":"<full markdown coverage diagram for PR body>","tests_added":["path",...]}`

**부모 처리:**

1. Read the subagent's final output. Parse the LAST line as JSON.
2. `coverage_pct` 저장 (단계 20 미터를 위해), `gaps` (사용자 요약), `tests_added` (정치를 위해).
3. `diagram` PR체 `## Test Coverage` 섹션에서 `diagram` 동사.
4. 원라인 요약을 인쇄: `Coverage: {coverage_pct}%, {gaps} gaps. {tests_added.length} tests added.`

**에이전트이 실패하면, 밖으로 시간, 잘못된 JSON를 반환하거나, 결코 완료하지 않습니다 (가치에도 불구하고, 또는 ~10 분 후에 최종 출력 없음 - 정지 대기; 배경 작업이 여전히 실행되면, 첫 번째로 늦은 결과를 결코 미끄러운 경주하지 마십시오):** 부모의 감사 인라인을 실행하기 위해 가을. 미시시시 실패에 /ship를 막지 마십시오. 부분 결과는 아무도보다 더 낫습니다.

---
