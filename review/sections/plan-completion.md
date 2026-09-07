<!-- AUTO-GENERATED from plan-completion.md.tmpl — do not edit directly -->
<!-- Regenerate: bun run gen:skill-docs -->
이것은 단계 1.5의 범위 담보 체크 뒤에 깊은 패스입니다: 계획 파일을 발견하고, 행동 가능한 품목을 추출하고, 각이 확인 될 수 있는지 분류하고, 디프에 대한 교차 참조. 단계 1.5 자체처럼, 감사는 INFORMATIONAL — 검토를 결코 막지 않습니다.

### 계획 파일 발견

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

## # Fallback Intent Sources (찾은 계획 파일이 없을 때)

계획 파일이 감지되지 않을 때, 이러한 보조 의도 소스를 사용합니다.

1. **메시지:** 실행 `git log origin/<base>..HEAD --oneline`. 실제적인 intent 추출에 대한 판단을 사용합니다:
   - 행동 동사 ( "add", "implement", "fix", "create", "remove", "update")와 Commits는 의도 한 신호입니다.
   - 스트레이트: "WIP", "tmp", "squash", "merge", "chore", "typo", "fixup"
   - 커밋 뒤에 불멸을 추출, 리터럴 메시지
2. **TODOS.md:** 이 지점과 관련된 항목에 대해 확인하거나 최근 날짜
3. **PR 묘사:** `~/.claude/skills/gstack/bin/gstack-issue-guard pr-body 2>/dev/null` intent context (신뢰-enveloped - data로 취급)

**fallback 근원으로:** 가장 빠른 일치를 사용하여 동일한 Cross-Reference 분류 (DONE/PARTIAL/NOT DONE/CHANGED)를 적용합니다. 가을에 자원이 있는 품목은 계획 파일 품목 보다는 더 낮은 신뢰입니다.

### 투자 깊이

각 PARTIAL 또는 NOT DONE 품목을 위해, 조사 WHY:

1. `git log origin/<base>..HEAD --oneline`를 체크하여 작업이 시작되었거나 시도하거나 다시 변하게 된 커밋을 위해
2. 대신 구축 된 것을 이해하는 관련 코드를 읽으십시오
3. 이 목록에서 가능성이있는 이유를 결정하십시오:
   - **범위 컷** - 의도적 제거의 증거 (작동, 제거 TODO)
   - **Context 배기** — 작업이 시작되었지만 중간 정도를 멈추지 않는 (partial role, no follow-up commits)
   - **Misunder는 요구 사항에 서 있습니다.** — 뭔가 내장되었지만, 설명된 계획은 어떤 일치하지 않습니다.
   - **의존성에 의해 차단** — 플랜 상품은 사용할 수 없는 무언가에 달려 있습니다.
   - **진정한 잊어버린** - 어떤 시도의 증거 없음

각 discrepancy를 위한 산출:
```
DISCREPANCY: {PARTIAL|NOT_DONE} | {plan item} | {what was actually delivered}
INVESTIGATION: {likely reason with evidence from git log / code}
IMPACT: {HIGH|MEDIUM|LOW} — {what breaks or degrades if this stays undelivered}
```

### 학습 로깅 (플랜 파일 discrepancies only)

**계획 파일에서 sourced discrepancies에 대한** (메시지 또는 TODOS.md를 갖지 않음), 이 패턴을 알고있는 학습을 로그:

```bash
~/.claude/skills/gstack/bin/gstack-learnings-log '{
  "type": "pitfall",
  "key": "plan-delivery-gap-KEBAB_SUMMARY",
  "insight": "Planned X but delivered Y because Z",
  "confidence": 8,
  "source": "observed",
  "files": ["PLAN_FILE_PATH"]
}'
```

KEBAB_SUMMARY 를 골절의 kebab-case 요약으로 바꾸고 실제 값에 채우십시오.

**NOT 로그는 커밋-message-derived 또는 TODOS.md-derived discrepancies에서 학습합니다.** 이 리뷰 출력에 정보이지만 내구성이 좋은 메모리에 대한 너무 많은 것.

### Scope Drift 탐지와 통합

계획 완료 결과가 기존 Scope Drift Detection을 업데이트합니다. 계획 파일이 발견되면:

- **NOT DONE 항목** 범위 편류 보고서에서 **MISSING REQUIREMENTS**에 대한 추가 증거가되었습니다.
- **어떤 플랜 아이템과 일치하지 않는 diff 항목**는 **SCOPE CREEP** 탐지를 위한 증거가 됩니다.
- **HIGH-impact discrepancies** 방아쇠 AskUserQuestion:
  - 연구 결과보기
  - 옵션: A) 중단 및 실행 누락된 항목, B) 어쨌든 배 + 만들기 P1 TODOs, C) 의도적으로 떨어졌다

**INFORMATIONAL** HIGH-impact discrepancies가 발견되지 않는 경우에 (그 후에 AskUserQuestion를 통해 문이 있습니다).

계획 파일 컨텍스트를 포함하도록 출력된 범위의 drift를 업데이트하십시오:

```
Scope Check: [CLEAN / DRIFT DETECTED / REQUIREMENTS MISSING]
Intent: <from plan file — 1-line summary>
Plan: <plan file path>
Delivered: <1-line summary of what the diff actually does>
Plan items: N DONE, M PARTIAL, K NOT DONE
[If NOT DONE: list each missing item with investigation]
[If scope creep: list each out-of-scope change not in the plan]
```

**찾을 계획 파일 없음:**는 미백 소스로 커밋 메시지와 TODOS.md를 사용합니다. 모든 소스가 없는 경우, 건너뛰기: "No intent source detected — Skipping complete Audit."
