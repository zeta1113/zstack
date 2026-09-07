<!-- AUTO-GENERATED from plan-completion.md.tmpl — do not edit directly -->
<!-- Regenerate: bun run gen:skill-docs -->
## 단계 8: 계획 완료 감사

**이 단계를 subagent로 Dispatch** 를 사용하여 에이전트 도구 `subagent_type: "general-purpose"`. 서브 에이전트은 플랜 파일을 읽고 각 참조 코드는 자신의 신선한 컨텍스트에 있습니다. 부모는 결론을 내린다.

**필요한 경우:** 패스 `run_in_background: false` 에이전트 호출에서 - 서브 에이전트은 Claude Code v2.1.198 이후 기본적으로 BACKGROUND에서 실행됩니다. (더 이상 플래그를 생성하지 않는 것은 전경 실행을 생성합니다. 그것은 명시적으로 false이어야합니다.) 파견은 에이전트 도구를 통해 ONLY를 발생합니다. 이 문서는 "이 문서는 "이 문서는 "이 문서는"라고 합니다. 예를 들어, "이 문서는 "이 문서는"라고 합니다. "이 문서는 "이 문서는"라고 합니다. "이 문서는 "이 문서는"라고 합니다. "이 문서는 "이 문서는"라고 합니다. "이 문서는 "이 문서는"라고 합니다. "이 문서는 "이 문서는"라고 합니다. "이 문서는 "이 문서는"라고 합니다. "이 문서는"라고 합니다. "이 문서는 "이 문서는"라고 합니다.

**에이전트 프롬프트:** 이 지시를 에이전트에 전달하십시오:

> 배 워크플로우 플랜 완료 감사를 실행하고 있습니다. 기본 branch은 `<base>`입니다. `git diff <base>...HEAD`를 사용하여 배송을 볼 수 있습니다. 커밋하거나 푸시하지 마십시오. 보고서만.
>
> ### 계획 파일 발견

1. **대화 (primary):** 이 대화에서 활동 계획 파일이 있는 경우 확인. 호스트 에이전트의 시스템 메시지는 플랜 모드에 계획 파일 경로가 포함되어 있습니다. 발견되면 직접 사용 — 이것은 가장 신뢰할 수있는 신호입니다.

2. **콘텐츠 기반 검색 (fallback):** 계획 파일이 대화 컨텍스트에 참조되지 않으면 내용에 의해 검색:

```bash
setopt +o nomatch 2>/dev/null || true  # zsh compat
BRANCH=$(git branch --show-current 2>/dev/null | tr '/' '-' | tr -cd 'a-zA-Z0-9._-')
REPO=$(basename "$(git rev-parse --show-toplevel 2>/dev/null)")
# Compute project slug for ~/.gstack/projects/ lookup
_PLAN_SLUG=$(git remote get-url origin 2>/dev/null | sed 's|.*[:/]\([^/]*/[^/]*\)\.git$|\1|;s|.*[:/]\([^/]*/[^/]*\)$|\1|' | tr '/' '-' | tr -cd 'a-zA-Z0-9._-') || true
_PLAN_SLUG="${_PLAN_SLUG:-$(basename "$PWD" | tr -cd 'a-zA-Z0-9._-')}"
# Search common plan file locations (project designs first, then personal/local)
for PLAN_DIR in "$HOME/.gstack/projects/$_PLAN_SLUG" "$HOME/.claude/plans" "$HOME/.codex/plans" ".gstack/plans"; do
  [ -d "$PLAN_DIR" ] || continue
  PLAN=$(ls -t "$PLAN_DIR"/*.md 2>/dev/null | xargs grep -l "$BRANCH" 2>/dev/null | head -1)
  [ -z "$PLAN" ] && PLAN=$(ls -t "$PLAN_DIR"/*.md 2>/dev/null | xargs grep -l "$REPO" 2>/dev/null | head -1)
  [ -z "$PLAN" ] && PLAN=$(find "$PLAN_DIR" -name '*.md' -mmin -1440 -maxdepth 1 2>/dev/null | xargs -r ls -t 2>/dev/null | head -1)
  [ -n "$PLAN" ] && break
done
[ -n "$PLAN" ] && echo "PLAN_FILE: $PLAN" || echo "NO_PLAN_FILE"
```

3. **유효성:** 플랜 파일이 내용 기반 검색을 통해 발견되면 ( 대화 컨텍스트 없음), 첫 20 줄을 읽고 현재의 지점 작업과 관련이 있는지 확인합니다. 다른 프로젝트 또는 기능에서 나타나면 "계획 파일이 발견되지 않음"으로 치료하십시오.

**오류 처리 :**
- 찾을 계획 파일 없음 → 건너뛰기 "No plan file detected — Skipping."
- 플랜 파일 발견하지만 읽을 수 있는 (출금, 인코딩) → "플랜 파일 발견하지만 읽을 수 없습니다 - 건너 뛰기"로 건너 뛰기

### 작용할 수 있는 품목 적출

플랜 파일을 읽으십시오. 모든 작업 가능한 항목을 추출하십시오. — 아무것도 설명하는 작업이 수행됩니다. 보기 :

- **Checkbox 항목:** `- [ ] ...` 또는 `- [x] ...`
- 구현 헤더의 **관련 항목**: "1. Create ...", "2. Add ...", "3. Modify ..."
- **부정 진술:** "X를 Y에 추가", "Z 서비스를 수집", "W 컨트롤러를 구성"
- **파일 수준 명세:** "새 파일 : path/to/file.ts", "path/to/existing.rb를 가리키십시오"
- **시험 필요조건:** "X 테스트" "Y에 대한 테스트 추가", "Z를 인증"
- **데이터 모델 변경:** "표 Y에 열 X 추가", "Z에 대한 마이그레이션"

**Ignore:**
- Context/Background 섹션 (`## Context`, `## Background`, `## Problem`)
- 질문 및 열린 항목 (로 표시 ?, "TBD", "TODO: 결정")
- 보고서 섹션 (`## GSTACK REVIEW REPORT`)
- 분해성 품목 ( "Future:", "범위의 아웃 :", "NOT 범위 :", "P2:", "P3:", "P4:")
- CEO 검토 결정 섹션 (결과 기록 선택, 작동하지 항목)

**모자:** 대부분의 50 항목에 추출. 계획이 더 있다면, 참고: "계획서 파일에 전체 목록 - N 계획 항목의 상위 50보기".

**상품 번호:** 플랜에는 추출 가능한 작업 가능한 항목이 포함되어 있지 않은 경우, 건너뛰기: "Plan file include no actionable items — Skipping complete Audit."

각 품목을 위해, 주:
- 아이템 텍스트 (verbatim 또는 concise 요약)
- 그 카테고리: CODE | TEST | MIGRATION | CONFIG | DOCS

### 검증 모드

완료를 판단하기 전에, HOW 각 품목을 확인할 수 있습니다 분류하십시오. 혼자서 빚은 것은 일의 각 종류를 증명할 수 없습니다. 현재 repo 또는 체계의 외부 품목은 `git diff`에 구조상으로 보이지 않습니다.

- **DIFF-VERIFIABLE** — 이 repo의 코드 변경은 `git diff <base>...HEAD`로 나타날 것입니다. 예: "add UserService" (파일이 나타납니다), "validate input X" (validation logic 가 나타납니다), "사용자 테이블 만들기" (이전 파일이 나타납니다).
- **CROSS-REPO** - 파일명 또는 sibling repo에서 변경 (예를들면 `domain-hq/docs/dashboard.md`, `~/Development/<other-repo>/...`). 현재 diff CANNOT는 이것을 증명합니다.
- **EXTERNAL-STATE** - 외부 시스템의 항목 이름 상태: Supabase config/RLS, Cloudflare DNS, Vercel env vars, OAuth 공급자 수당, 제 3 자 SaaS, DNS 기록. 현재 diff CANNOT는 이것을 증명합니다.
- **CONTENT-SHAPE** - 항목은 특정한 규칙을 따르는 파일을 요구합니다. 이 repo에 있는 파일이 인 경우에: diff-verifiable. 다른 repo 또는 체계에서: CROSS-REPO/EXTERNAL-STATE를 보십시오.

**검증 파견:**

- **DIFF-VERIFIABLE** → diff (다음 섹션)에 대한 교차 환경.
- **CROSS-REPO** → 주사통이 디스크에 도달 할 수 있는지 (try `~/Development/<repo>/`, `~/code/<repo>/`, 현재 repo의 부모), 실행 `[ -f <path> ]` 파일 존재를 확인. 파일 존재 → DONE (시행 경로). 파일 누락 → NOT DONE (시행 경로). 접근 가능한 경로 → UNVERIFIABLE (시행 설명서 체크).
- **EXTERNAL-STATE** → UNVERIFIABLE. 시스템의 Cite와 특정 체크는 사용자가 수행해야 합니다.
- **CONTENT-SHAPE 다른 repo에서** → 파일이 존재하는 경우, 프로젝트 감지된 검증자 (이하 "Validator Detection" 참조)를 실행하십시오. UNVERIFIABLE로 떨어지기 전에. 유효성 검사기 : 패스 → DONE; 실패 → NOT DONE (표시 유효성 검사기 출력). 유효성 검사기 없음: 분류 UNVERIFIABLE 및 파일 경로와 규칙 모두 확인.

**Path 콘크리트 규칙.** 플랜트 항목이 *콘크리트 파일시스템 경로* (absolute, `~/...`, 또는 `<sibling-repo>/<file>`)인 경우 MUST는 `[ -f <path> ]`에 근거를 둔 NOT DONE 또는 NOT DONE를 분류합니다. UNVERIFIABLE는 경로가 진짜 추상 ("Cloudflare DNS", "Supabase allowlist") 또는 sibling 뿌리는 "Iachable"에 믿을 수 없습니다.

**검증자 탐지.** CONTENT-SHAPE 항목에 `package.json`를 떨어뜨리기 전에 `validate-*`, `lint-wiki`, `check-docs`, 또는 이와 유사한 스크립트를 일치시키십시오. 발견되면 관련 경로 인수 (예를들면 `npm run validate-wiki -- <path>`)로 변환하십시오. 멀티 표적 유효성 검사기 (예를 들어, `validate-wiki --all`, `validate-wiki --all`, `validate-wiki --all`, UNVERIFIABLE, `validate-wiki --all`, UNVERIFIABLE, `npm run validate-wiki -- <path>`)를 전달하는 것은 출력에서 실패합니다.

**정직 규칙.** NOT는 DONE로 항목에 분류합니다. *의 특징*는 배달이 불가능합니다. 마운팅은 마운팅 파일 발송과 동일하지 않습니다. DONE와 UNVERIFIABLE 사이에 의심할 여지라도 UNVERIFIABLE를 더 잘 표면으로 확인을 부드럽게 놓는 것은 전달할 수 있습니다.

## # # Diff에 대한 십자가 - 거부

`git diff origin/<base>...HEAD`와 `git log origin/<base>..HEAD --oneline`를 실행하여 구현된 것을 이해합니다.

각 추출 계획 항목에 대 한, 이전 섹션에서 검증 파견을 실행, 다음 분류:

- **DONE** - 배송된 항목에 대한 명확한 증거. DIFF-VERIFIABLE 항목에 대한 디프에서 변경된 특정 파일(s) 또는 CROSS-REPO 항목에 대한 검증된 경로는 도달 가능한 주사통을 가진다.
- **PARTIAL** - 이 항목에 대한 일부 작업은 존재하지만 불완전 (예 : 모델 생성하지만 컨트롤러 누락, 기능에는 있지만 가장자리 케이스가 처리되지 않음).
- **NOT DONE** - 검증 랜과 생성 된 부정적인 증거 (파일 누락, diff, sibling-repo 파일에 부패).
- **CHANGED** - 설명된 플랜보다 다른 접근법을 이용하여 수행되었지만, 동일한 목표는 달성됩니다. 차이를 참고하십시오.
- **UNVERIFIABLE** - diff 및 어떤 도달 가능한 주사통 검사는 이것을 증명하거나 제공 할 수 없습니다. 항상 EXTERNAL-STATE 항목과 CROSS-REPO 항목에 적용되며, 재사용이 불가능할 수 없습니다. 사용자의 특정 수동 검증을 선호하는 것은 (예를 들어, "check Cloudflare DNS show DNS-only mode for 대쉬보드.example.com>, /docs->.htm> 도메인은 /docs.htm>에 있습니다.

**DONE로 보존** - 명확한 증거가 필요합니다. 터치 된 파일은 충분하지 않습니다. 특정 기능은 현재 있어야 합니다. **CHANGED로 관대하게** — 목표는 다른 수단으로 만났을 경우, 주소로 계산됩니다. **UNVERIFIABLE와 정직** — 표면 5 항목에 더 나은 사용자는 수동으로 DONE를 분류하는 것보다 확인해야합니다.

### 산출 체재

```
PLAN COMPLETION AUDIT
═══════════════════════════════
Plan: {plan file path}

## Implementation Items
  [DONE]         Create UserService — src/services/user_service.rb (+142 lines)
  [PARTIAL]      Add validation — model validates but missing controller checks
  [NOT DONE]     Add caching layer — no cache-related changes in diff
  [CHANGED]      "Redis queue" → implemented with Sidekiq instead

## Test Items
  [DONE]         Unit tests for UserService — test/services/user_service_test.rb
  [NOT DONE]    E2E test for signup flow

## Migration Items
  [DONE]         Create users table — db/migrate/20240315_create_users.rb

## Cross-Repo / External Items
  [DONE]         sibling-repo has /docs/dashboard.md — verified at ~/Development/sibling-repo/docs/dashboard.md
  [UNVERIFIABLE] Cloudflare DNS-only on api.example.com — external system, manual check required
  [UNVERIFIABLE] Supabase auth allowlist contains user email — external system, confirm in Supabase dashboard

─────────────────────────────────
COMPLETION: 5/9 DONE, 1 PARTIAL, 1 NOT DONE, 1 CHANGED, 2 UNVERIFIABLE
─────────────────────────────────
```

### 문 논리

완료 체크리스트를 생산한 후 우선순위로 평가하십시오.

1. **NOT DONE 항목** (최고 우선 순위 — 알려진 누락 작업). AskUserQuestion를 사용합니다:
   - 위의 완료 체크리스트 보기
   - "{N} 플랜의 항목은 NOT DONE입니다. 이 플랜의 일부가 있었지만 구현 중에는 누락되었습니다."
   - RECOMMENDATION: 항목 카운트와 severity에 따라 달라집니다. 1-2 미성년자 항목 (docs, config)이면 B를 추천합니다. 핵심 기능이 누락되면 A를 추천합니다.
   - 옵션:
     A) Stop - B를 배송하기 전에 누락 된 항목을 구현합니다. 어쨌든 -이를 따라 실행하십시오. (단계 5.5에서 P1 TODOs를 만들 것입니다) 이 항목은 의도적으로 떨어졌습니다. - 범위에서 제거
   - A: STOP. 구현할 수 있는 사용자에 대한 누락된 아이템을 나열합니다.
   - B: 계속. 각 NOT DONE 항목에 대해 P1 TODO를 "계획에서 설명합니다: {plan 파일 경로}"로 단계 5.5에서 생성합니다.
   - C: 계속. PR체에 주의: "Plan items 의도적으로 떨어졌다: {list}."

2. **UNVERIFIABLE 항목** (실런 간격 — diff는 그(것)들을 증명할 수 없습니다). NOT DONE가 결심되거나 부패되는 경우에만 불이 켜집니다.

   **Per-item 확인은 필수입니다.** NOT는 UNVERIFIABLE 품목을 담요 확인하기 위하여 단 하나 AskUserQuestion를 이용합니다. 담요 확인은 VAS-449에서 지상에 놓는 실패 형태입니다 (사용자는 어떤 파일도 없이 A를 누르십시오). 대신:

   - UNVERIFIABLE를 통해 한 번에 한 번에 반복합니다.
   - 각 항목의 경우, AskUserQuestion를 아이템의 *specific* 수동 체크 (예를 들어, "Confirm: does `~/Development/domain-hq/docs/dashboard.md` 존재하지?"를 사용하며 "모든 항목을 검사합니까?").
   - 품목 당 선택권:
     Y) 확인 완료 — 확인된 것을 인용합니다 (PR 몸에서 끼워넣어지는 자유로운 원본) N) 완료하지 않는 - 구획 배; NOT DONE로 대우하고 우선권 1 문 D를 다시 입력하십시오) Intentionally는 - PR 몸에 주의: "계획 품목 의도적으로 떨어뜨립니다: {item}"
   - RECOMMENDATION 항목 당: Y 만약 항목은 콘크리트와 쉽게 확인; N 만약 그것은 중요 한 동요 (우, DNS, 다른 저장소에 전달) 및 사용자 표시 hesitation.

   **출구 상태:**
   - 어떤 N: STOP. 누락된 품목을 표면으로, re-running /ship를 주소로 기입한 후에 건의하십시오.
   - 모든 Y 또는 D : 계속. `## Plan Completion — Manual Verifications` 섹션 PR 본체는 사용자의 무료 텍스트 증거와 각 D'd 항목에 대한 Y'd 항목을 나열하고 "intentionally 떨어졌다".

   **모자.** 5개 이상인 경우 UNVERIFIABLE 항목이 있는 경우, 먼저 숫자로 지정된 리스트로 제시하고, 사용자가 원하는 것을 (1)는 각각 개별적으로, (2) 정지를 확인하고 범위를 감소시키거나 (3) 명시적으로 VAS-449 고장 모양인지 경고로 담요 확인을 허용한다. 기본 및 권장 옵션은 (1)입니다.

3. **PARTIAL 항목 (NOT DONE, UNVERIFIABLE 없음):** PR 몸에 주의를 계속하십시오. 막기지 마십시오.

4. **모든 DONE 또는 CHANGED:** 합격. "플랜 완료: PASS — 모든 항목 주소." 계속.

**찾을 계획 파일 없음:** 전반적으로 건너뛰기. "No plan file detected — Skipping plan complete Audit."

**PR 몸에 포함하십시오 (Step 8):** 체크리스트 요약을 가진 `## Plan Completion` 단면도를 추가하십시오.
>
> 분석 후, 단일 JSON 객체를 LAST LINE의 응답 (다른 텍스트가 그 후에도) 출력하십시오:
> `{"total_items":N,"done":N,"changed":N,"deferred":N,"unverifiable":N,"summary":"<markdown checklist for PR body>"}`

**부모 처리:**

1. JSON로 에이전트 출력의 LAST 선을 파십시오.
2. `done`, `deferred`, `unverifiable` 단계 20 미터를 위해; PR 몸에 있는 `summary`를 사용하십시오.
3. `deferred > 0` 또는 `unverifiable > 0` 및 사용자의 과도한 경우, 계속하기 전에 적절한 AskUserQuestion (문 논리 우선순서를 참조하십시오)를 통해 항목을 제시하십시오.
4. PR체 `## Plan Completion`섹션 (Step 19) `summary`를 에디브로딩한다. `unverifiable > 0`와 UNVERIFIABLE문에서 `## Plan Completion — Manual Verifications`를 선택하면 각 사용자 확인 아이템을 나열한 `## Plan Completion — Manual Verifications`를 지정한다.

**에이전트이 실패하면, 잘못된 JSON를 반환하거나, (가치에도 불구하고, 또는 ~10 분 후에 최종 출력을 완료하지 않는 경우, 기다리는; 배경 작업이 여전히 실행되면, 첫 번째를 중지 그래서 늦은 결과가 내리지 않는 것은 가을을 경주하지 않습니다) :** 감사 인라인을 실행하기 위해 다시 가을 (동의 계획 추출 + 분류 논리를 처리하는 것과 같은 프로세스). 인라인이 떨어지면 (예를 들어, 계획 파일 읽을 수 있음, 파서 오류), NOT 침묵으로 전달 - 명시적 AskUserQuestion로 실패를 표면: "Plan Completion Audit은 실행할 수 없습니다 ({reason}). 옵션: (A) Skip Audit and ship anyway — 감사가 PR체 및 단계 20 미터; (B) Stop and fix the Audit." 과태 및 권장 옵션은 (B). Silent failed-open은 VAS-449 표면의 실패 모양입니다.

---

## 단계 8.1: 계획 검증

`/qa-only` 기술을 사용하여 플랜의 테스트를/verification 단계 자동 검증합니다.

##1. 검증 섹션을 확인

플랜 파일을 이미 단계 8에서 발견한 경우 검증 섹션을 찾습니다. 이 헤더의 모든 일치: `## Verification`, `## Test plan`, `## Testing`, `## How to test`, `## Manual testing`, 또는 검증된 항목과 섹션 (방문을 위해, 시각적으로, 테스트에 대한 상호 작용을 확인하는 것).

**인증 섹션이 없는 경우:** "계획에서 발견된 검증 단계가 없습니다. - 자동 검증을 건너 뛰기." **플랜 파일이 Step 8에서 발견되지 않은 경우:** Skip (already handled).

##2. dev server를 실행하려면 체크

검색 기반 검증을 호출하기 전에 dev-server URL를 찾아 프로젝트가 선언하는 방식은 결코 혼자 하드 코딩 포트 목록을 신뢰하지 않습니다.

1. **CLAUDE.md 처음:** 문서화 된 dev URL 또는 dev 명령을 찾습니다 (a
   `## Development`/`## Testing` 섹션은 포트 또는 URL를 naming. 그것을 사용합니다.
2. **계획 파일:** 플랜의 검증 섹션이 URL이라는 이름을 지정하면 사용.
3. **Fallback 프로브** (일반 포트, 1-2가 아무것도 발견했을 때만):

```bash
for _p in 3000 8080 5173 4000 4321 8000; do
  _code=$(curl -s -o /dev/null -w '%{http_code}' "http://localhost:$_p" 2>/dev/null)
  [ -n "$_code" ] && [ "$_code" != "000" ] && { echo "DEV_SERVER: http://localhost:$_p ($_code)"; break; }
done
[ -z "${_code:-}" ] || [ "${_code:-000}" = "000" ] && echo "NO_SERVER"
```

**NO_SERVER:** "No dev 서버가 감지되지 않음 (checked CLAUDE.md, 계획 및 일반적인 포트) - 스트립 플랜 검증. 배포 후 /qa를 별도로 실행하거나 CLAUDE.md에서 URL를 문서화하여 다음 시간을 찾습니다."

##3. /qa-only 인라인으로 호출

디스크에서 `/qa-only` 기술 읽기:

```bash
cat ${CLAUDE_SKILL_DIR}/../qa-only/SKILL.md
```

**읽을 수 없는 경우:** "Could not load /qa-only - Skipping plan 검증"으로 건너뛰기

/qa-only 작업 흐름을 다음과 같이 변경합니다.
- **바카라** (/ship에 의해 처리되는 보행)
- **플랜의 검증 섹션을 기본 시험 입력으로 사용하십시오.** - 테스트 케이스로 각 검증 항목을 처리
- **검출된 dev 서버 URL를 사용하십시오** 기초 URL로
- **수정 루프를 건너** — 이것은 /ship의 보고 전용 검증입니다.
- **플랜의 검증 항목에 캡** - 일반 사이트 QA로 확장하지 마십시오.

##4. 문 논리

- **모든 검증 항목 PASS:** 은 조용히 계속. "플랜 검증: PASS."
- **Any FAIL:** AskUserQuestion를 사용하십시오:
  - 스크린 샷 증거로 실패를 표시
  - RECOMMENDATION: 실패가 깨진 기능을 나타내면 A를 선택하십시오. B를 화장품만 선택하면 선택하세요.
  - 옵션:
    A) 배송 전에 실패를 수정 (기능 문제 수정) B) 어쨌든 배송 - 알려진 문제 (화장품 문제에 대한 허용)
- **인증 섹션 / 서버 없음 / 읽을 수없는 기술 :** Skip (비 차단).

##5. PR 몸에 포함

`## Verification Results` 섹션을 PR 본체에 추가하십시오. (Step 19):
- 인증란: 결과 요약 (N PASS, M FAIL, K SKIPPED)
- 건너뛰기: Skipping의 이유 (계획 없음, 서버 없음, 검증 섹션 없음)

## 사전 학습

이전 세션에서 관련 학습 검색:

```bash
_CROSS_PROJ=$(~/.claude/skills/gstack/bin/gstack-config get cross_project_learnings 2>/dev/null || echo "unset")
echo "CROSS_PROJECT: $_CROSS_PROJ"
if [ "$_CROSS_PROJ" = "true" ]; then
  ~/.claude/skills/gstack/bin/gstack-learnings-search --limit 10 --query "release ship version changelog merge pr" --cross-project 2>/dev/null || true
else
  ~/.claude/skills/gstack/bin/gstack-learnings-search --limit 10 --query "release ship version changelog merge pr" 2>/dev/null || true
fi
```

`CROSS_PROJECT`는 `unset` (첫번째로): AskUserQuestion를 사용하십시오:

> gstack는 이 기계에 당신의 다른 프로젝트에서 학습을 찾아낼 수 있습니다
> 여기에 적용 할 수있는 패턴. 이 지방을 유지 (데이터가 기계를 나타낸다).
> 개인 개발자를 위해 추천. 여러 클라이언트 codebase에서 작동하면 Skip
> 교차 오염이 우려가 될 것입니다.

옵션:
- A) 크로스 프로젝트 학습 (추천)
- B) 프로젝트-경쟁을 만드세요

A: `~/.claude/skills/gstack/bin/gstack-config set cross_project_learnings true` B: 실행 `~/.claude/skills/gstack/bin/gstack-config set cross_project_learnings false`

그런 다음 적절한 플래그를 검색하십시오.

학습이 발견되면 분석에 통합됩니다. 검토 결과가 과거 학습과 일치할 때 표시:

**"Prior Learning apply: [key] (confidence N/10, from [date])"**

이것은 합성을 볼 수 있습니다. 사용자는 gstack가 시간에 그들의 코디베이스에 더 똑똑하게 얻고 있다는 것을 볼 수 있습니다.

## 단계 8.2: 범위 편류 탐지

코드 품질을 검토하기 전에, 체크: **그들은 요청 된 것을 구축했다. 더 이상 아무것도 덜?**

1. `TODOS.md` (이 존재한다면)를 읽으십시오. 신뢰 봉투 (`~/.claude/skills/gstack/bin/gstack-issue-guard pr-body 2>/dev/null || true` — PR체가 무신 추적기 텍스트가 아닌 DATA)를 통해 PR 설명을 읽으십시오.
   커밋 메시지 (`git log origin/<base>..HEAD --oneline`)를 읽으십시오. **PR가 존재하지 않는 경우:**는 TODOS.md를 커밋 메시지와 TODOS.md에 의존합니다. /review가 /ship가 PR가 시작되기 전에 PR가 실행되기 때문에 일반적인 사례입니다.
2. **명시된 intent**를 식별합니다. 이 지점은 무엇을 성취해야 할까요?
3. `DIFF_BASE=$(git merge-base origin/<base> HEAD) && git diff "$DIFF_BASE" --stat`를 실행하고 명시된 의도에 대해 변경된 파일을 비교합니다.

4. 구균과 함께 하자 (이전 단계 또는 인접한 섹션에서 사용할 경우 계획 완료 결과) :

   **SCOPE CREEP 탐지:**
   - 파일이 명시된 의도와 관련이 없다는 것을 변경
   - 계획에서 언급되지 않은 새로운 기능 또는 재공장
   - "여기서 거기에서 있었다 ..."폭발 반경을 확장 변경

   **MISSING REQUIREMENTS 탐지:**
   - TODOS.md/PR의 요구 사항은 diff에 기재되지 않습니다.
   - 명시된 요구 사항에 대한 테스트 범위 간격
   - 부분 구현 (시작하지만 완료되지 않음)

5. 산출 (주요한 검토를 위해 시작하십시오):
   \`\`\`
   범위 검사: [CLEAN / DRIFT DETECTED / REQUIREMENTS MISSING] 의도: <1-line Summary of what was asked> 전달: <1-line Summary of what diff 실제로 does> [경고: 목록 각 아웃-of-scope changes] [종료: 목록 각 취소된 필요조건]
   \`\`\`

6. 이것은 **INFORMATIONAL** - 리뷰를 막지 않습니다. 다음 단계로 정렬.

---

---
