<!-- AUTO-GENERATED from review-army.md.tmpl — do not edit directly -->
<!-- Regenerate: bun run gen:skill-docs -->
## Step 4.5: 육군 검토 — 전문가 Dispatch

### 스택과 범위를 감지

```bash
source <(~/.claude/skills/gstack/bin/gstack-diff-scope <base> 2>/dev/null) || true
# Detect stack for specialist context
STACK=""
[ -f Gemfile ] && STACK="${STACK}ruby "
[ -f package.json ] && STACK="${STACK}node "
[ -f requirements.txt ] || [ -f pyproject.toml ] && STACK="${STACK}python "
[ -f go.mod ] && STACK="${STACK}go "
[ -f Cargo.toml ] && STACK="${STACK}rust "
echo "STACK: ${STACK:-unknown}"
DIFF_BASE=$(git merge-base origin/<base> HEAD)
DIFF_INS=$(git diff "$DIFF_BASE" --stat | tail -1 | grep -oE '[0-9]+ insertion' | grep -oE '[0-9]+' || echo "0")
DIFF_DEL=$(git diff "$DIFF_BASE" --stat | tail -1 | grep -oE '[0-9]+ deletion' | grep -oE '[0-9]+' || echo "0")
DIFF_LINES=$((DIFF_INS + DIFF_DEL))
echo "DIFF_LINES: $DIFF_LINES"
# Detect test framework for specialist test stub generation
TEST_FW=""
{ [ -f jest.config.ts ] || [ -f jest.config.js ]; } && TEST_FW="jest"
[ -f vitest.config.ts ] && TEST_FW="vitest"
{ [ -f spec/spec_helper.rb ] || [ -f .rspec ]; } && TEST_FW="rspec"
{ [ -f pytest.ini ] || [ -f conftest.py ]; } && TEST_FW="pytest"
[ -f go.mod ] && TEST_FW="go-test"
echo "TEST_FW: ${TEST_FW:-unknown}"
```

### 전문가의 히트률 (다트라이트)

```bash
~/.claude/skills/gstack/bin/gstack-specialist-stats 2>/dev/null || true
```

### 전문가를 선택하십시오

위의 범위 신호를 기반으로, 어떤 전문가가 파견하는 것을 선택합니다.

**항상 (각 리뷰에 50 + 변경 라인) :**
1. **테스트** — `~/.claude/skills/gstack/review/specialists/testing.md`를 읽으십시오
2. **관련 상품** — `~/.claude/skills/gstack/review/specialists/maintainability.md`를 읽으십시오

**If DIFF_LINES < 50:** 모든 전문가를 건너 뛰기. 인쇄: "소형 디프 ($DIFF_LINES 선) - 전문가가 건너 뛰기." 단계 5로 계속

**조건 (맞추어 일치하는 범위 신호가 진실한 경우에 파견):**
3. **- 연혁** — SCOPE_AUTH=true, OR if SCOPE_BACKEND=true AND DIFF_LINES > 100. `~/.claude/skills/gstack/review/specialists/security.md`
4. **의 특징** — SCOPE_BACKEND=true OR SCOPE_FRONTEND=true. `~/.claude/skills/gstack/review/specialists/performance.md`를 읽으십시오
5. **데이터 마이그레이션** — SCOPE_MIGRATIONS=true. `~/.claude/skills/gstack/review/specialists/data-migration.md`를 읽으십시오
6. **API 계약** — SCOPE_API=true. `~/.claude/skills/gstack/review/specialists/api-contract.md`를 읽으십시오
7. **의 특징** — SCOPE_FRONTEND=true인 경우. `~/.claude/skills/gstack/review/design-checklist.md`에서 기존 디자인 검토 체크리스트를 사용하십시오.
8. **의 장점** — DIFF_LINES > 100. `~/.claude/skills/gstack/review/specialists/simplification.md`를 읽으십시오. 자문 전용 렌즈: , 결코 적용하지 않는 구조 (손 목록으로 만들어진 stdlib, 1 간단한 요약, 종점 duplicating 플랫폼 특징)를 사냥하십시오.

### 적응식

범위 기반 선택 후, 전문가의 히트율에 따라 적응식 글을 적용합니다.

범위를 지나는 각 조건부 전문가를 위해, 위에 `gstack-specialist-stats` 산출을 검사하십시오:
- 태그가 있다면 `[GATE_CANDIDATE]` (0 10+ 파견에서 발견): 그것을 건너 뛰기. 인쇄: "[전문가] 자동 gated (0 N 리뷰에서 발견)."
- 태그가 있다면 `[NEVER_GATE]`: 항상 히트율에 관계없이 파견. 보안 및 데이터 마이그레이션은 보험 정책 전문가입니다. 그들은 침묵 할 때도 실행해야합니다.

**힘 깃발:** 사용자의 프롬프트가 `--security`, `--performance`, `--testing`, `--maintainability`, `--data-migration`, `--api-contract`, `--design`, `--simplification`, `--all-specialists`, gating에 관계되는 그 전문가를 포함하는 경우에 **힘 깃발:**.

전문가가 선정한 주, 문질러 건너뛰기. 선택 인쇄: "N 전문가를 접목: [이름]. Skipped: [이름] (경쟁이 검출되지 않음). Gated: [이름] (0 N + 리뷰에서 발견)."

---

### Dispatch 전문가를 병렬로 잡기

각 선택된 전문가를 위해, 에이전트 도구를 통해 독립적 인 에이전트을 실행합니다. **ALL 한 메시지에 대한 전문가를 선정** (다중 에이전트 도구 호출) 그래서 그들은 병렬에서 실행. 각 에이전트 신선한 맥락을 가지고 있습니다. - 사전 검토 bias.

**각 전문가 에이전트 신속한:**

각 전문가를 위한 신속한 구성. 신속한 포함:

1. 전문가의 검사 내용 (당신은 이미 위에 파일을 읽습니다)
2. Stack context: "이것은 {STACK} 프로젝트입니다."
3. 이 도메인의 과거 학습 (모든 존재가 있다면):

```bash
~/.claude/skills/gstack/bin/gstack-learnings-search --type pitfall --query "{specialist domain}" --limit 5 2>/dev/null || true
```

학습이 발견되면 다음을 포함합니다: "이 도메인에 대한 학습 : {learnings}"

4. 사용 방법:

"전문 코드 검토자입니다. 아래 체크리스트를 읽어 보시고, `DIFF_BASE=$(git merge-base origin/<base> HEAD) && git diff "$DIFF_BASE"`를 실행하여 전체 디프를 얻으세요. 디프에 대한 체크리스트를 적용하십시오.

각 검색에 대해 JSON 객체를 자체 라인에 출력: "severity":"CRITICAL|INFORMATIONAL","confidence":N,"path":"file","line":N,"category":"category","summary":"description","fix":"recommended fix","fingerprint":"pathline:"category","specialist":""

필수 필드: 엄격, 신뢰, 경로, 범주, 요약, 전문가. 선택: 선, 수정, 지문, 증거, test_stub.

이 문제를 잡을 수있는 테스트를 작성할 수 있다면 `test_stub` 필드에 포함하십시오. 검출 된 테스트 프레임 워크 ({TEST_FW})를 사용하십시오. 최소 골격을 작성하십시오. describe/it/test 블록을 명확한 의도로 작성하십시오. 건축 또는 디자인 전용 검색을위한 test_stub를 건너 뛰십시오.

발견하지 않은 경우 : 출력 `NO FINDINGS` 및 다른 아무것도. 다른 것을 출력하지 마십시오 - 사전, 요약 없음, 논평.

스택 컨텍스트: {STACK} 과거 학습: {learnings or 'none'}

CHECKLIST: {checklist 내용}"

**Subagent 구성:**
- `subagent_type: "general-purpose"` 사용
- `run_in_background: false` 을 각 전문 에이전트 호출에 전달합니다. Claude Code v2.1.198 이후 BACKGROUND 를 기본으로 BACKGROUND 를 실행하고 모든 전문가는 합병 전에 완료해야합니다. (더 이상 플래그를 omitting 은 전장 실행을 생성합니다. 그것은 명시적으로 false이어야합니다.)
- 전문가가 에이전트을 실패하거나 시간이 지남에 따라 실패를 로그하고 성공적인 전문가의 결과를 계속하십시오. 전문가는 첨가제가 있습니다. 부분적인 결과는 결과가 더 낫습니다.

---

### Step 4.6: 수집 및 합병

모든 전문가에게 에이전트이 완료되면 출력을 수집합니다.

각 전문가의 산출을 위해 **파스 발견:**:
1. 출력이 "NO FINDINGS"인 경우, 이 전문가는 아무것도 발견되지 않습니다.
2. 그렇지 않으면, JSON 객체로 각 줄을 파싱합니다. JSON를 유효하지 않은 행을 건너 뛸 수 있습니다.
3. 모든 파종된 발견을 단일 목록에 모아서, 전문가 이름을 태그합니다.

각 발견을 위한 **지문과 deduplicate:**, 그것의 지문을 보상하십시오:
- `fingerprint` 필드가 존재하면, 그것을 사용
- 그렇지 않으면: `{path}:{line}:{category}` (선이 존재하는 경우에) 또는 `{path}:{category}`

지문에 의한 그룹 찾기. 동일한 지문을 공유하는 것을 찾는다 :
- 가장 높은 신뢰 점수를 가진 발견을 지키십시오
- 태그 : "MULTI-SPECIALIST CONFIRMED ({specialist1} + {specialist2})"
- +1에 대한 신뢰를 높일 수 있습니다 (캡 10)
- 출력의 확인 전문가를 참고하십시오.

**신뢰 문을 적용하십시오:**
- Confidence 7+: 결과 산출에서 일반적으로 보여주십시오
- Confidence 5-6 : 동굴 "Medium 신뢰"을 보여주고 -이 사실을 확인하는 것은 실제로 문제"
- Confidence 3-4: appendix로 이동 (주요 검색에서 압축)
- 신뢰 1-2: 전적으로 억압

**자문 carve-out (간단한 전문가):** `"advisory": true`로 찾기는 BOTH에서 제외됩니다. quality_score summation와 아래 발견 카운트 헤더 - 그들은 구조 제안, 결함이 아니며, "5개의 발견 ... 10/10"를 만들 필요가 없습니다. 수정에서 그들은 ASK-only: NEVER 자동 승인, 심지어 기계 할 때.

**Compute PR 품질 점수:** 수은 후 NON-advisory 발견에 대한 품질 점수를 계산합니다. `quality_score = max(0, 10 - (critical_count * 2 + informational_count * 0.5))` 10의 모자. 이 리뷰를 기록하여 결국 결과를 기록하십시오.

**산출 합병한 발견:** 현재 검토와 같은 형식의 합병 된 발견을 발표 :

```
SPECIALIST REVIEW: N findings (X critical, Y informational) from Z specialists

[For each finding, in order: CRITICAL first, then INFORMATIONAL, sorted by confidence descending;
 advisory findings last, each rendered with an [ADVISORY] label in place of the severity]
[SEVERITY] (confidence: N/10, specialist: name) path:line — summary
  Fix: recommended fix
  [If MULTI-SPECIALIST CONFIRMED: show confirmation note]

PR Quality Score: X/10
```

**단순화 발기자 (점수 선 후에):**
- simplification 전문가가 파견되고 재시작한 경우, 합계
  `lines_removable` 값과 인쇄: `net: -N lines possible` (소정에서 필드 없이 찾는).
- 파견되고 반환된 NO FINDINGS, 인쇄:
  `Simplification: lean already — nothing to cut.`
- 파견되지 않은 경우, 인쇄는 선을 인쇄하지 않습니다.

이 발견은 단계 5에서 발견을 전달하는 CRITICAL와 함께 단계 5 수정-First에 흐름을 나타냅니다. 수정-First heuristic는 동일하게 적용됩니다 — 전문가 발견은 동일한 AUTO-FIX 대 ASK 분류를 따릅니다 (위에 캐비티 아웃 당 ASK-only인 고문을 제외하고).

**의외선 통계:** merging finds 후, 단계 5.8에 있는 검토 로그 항목에 대한 `specialists` 객체를 컴파일합니다. 각 전문가 (테스트, 유지성, 보안, 성능, 데이터 마이그레이션, api-contract, 디자인, 단순화, red-team):
- 파견된 경우: `{"dispatched": true, "findings": N, "critical": N, "informational": N}`
- 범위로 건너뛰기: `{"dispatched": false, "reason": "scope"}`
- 삐걱거리는 경우: `{"dispatched": false, "reason": "gated"}`
- 적용되지 않은 경우 (예: red-team 활성화되지 않음): 객체에서 omit

자문은 통계 `findings` 필드에서 COUNT를 찾는다. 고문 캐비티 아웃은 품질 점수와 발견 표 헤더를 관리한다. `findings: 0`로 simplification의 자문을 썼다. 10 파견 후 영구 침묵으로 렌즈를 자동 문질러.

전문 스키마 파일 대신 `design-checklist.md`를 사용하더라도 디자인 전문가를 포함하십시오. 이 통계를 기억하십시오. - 당신은 단계 5.8에 있는 검토로 입장을 위해 그(것)들을 필요로 할 것입니다.

---

## Red Team 파견 (조건)

**인증:** DIFF_LINES > 200 OR 어떤 전문가든지 CRITICAL 발견을 생성했습니다.

활성화된 경우, 에이전트 도구를 통해 하나 더 서브 에이전트을 파견 (`run_in_background: false` - 전경; Claude Code v2.1.198 이후 배경으로 기본 에이전트.

Red Team 서브 에이전트은 다음과 같습니다.
1. `~/.claude/skills/gstack/review/specialists/red-team.md`의 빨간색 팀 체크리스트
2. 합병 전문가는 단계 4.6 (그래서 이미 잡힌 것을 알고 있습니다)
3. git diff 명령

Prompt: "당신은 빨간 팀 검토자입니다. 코드는 이미 다음 문제에서 발견 N 전문가에 의해 검토되었습니다 : {merged finds Summary}. 귀하의 작업은 그들이 MISSED. 체크리스트를 읽고, `DIFF_BASE=$(git merge-base origin/<base> HEAD) && git diff "$DIFF_BASE"`을 실행하고, 간격을 찾습니다. 출력은 JSON 객체 (전문가로서의 same schema)로 발견됩니다. 교차 절단 문제, 통합 문제 및 실패 모드에 초점을 맞춥니 다. 전문가가 검사하지 않은 경우."

Red Team이 추가 문제를 발견하면 Step 5 Fix-First 이전에 발견 목록으로 합병합니다. Red Team은 `"specialist":"red-team"` 태그입니다.

Red Team이 NO FINDINGS를 반환하면, 주의: "Red Team review: 추가 문제가 발견되지 않았습니다." Red Team subagent가 실패하거나, 침묵으로 건너뛰고 계속 건너뛰십시오.
