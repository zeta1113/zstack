<!-- AUTO-GENERATED from greptile.md.tmpl — do not edit directly -->
<!-- Regenerate: bun run gen:skill-docs -->
## 단계 10: 주소 휘발성 검토 코멘트 (PR 존재)

**의 궤멸 + 분류를 subagent로** 를 사용하여 에이전트 도구 `subagent_type: "general-purpose"`. 서브 에이전트은 모든 윤활성 주석을 끌어, 에스컬레이션 검출 알고리즘을 실행하고, 각 코멘트를 분류합니다. 부모는 구조화된 목록을 수신하고 사용자 상호 작용 + 파일 편집을 처리합니다.

**필요한 경우:** 패스 `run_in_background: false` 에이전트 호출에서 - 서브 에이전트은 Claude Code v2.1.198 이후 기본적으로 BACKGROUND에서 실행됩니다. (더 이상 플래그를 생성하지 않는 것은 전경 실행을 생성합니다. 그것은 명시적으로 false이어야합니다.) 파견은 에이전트 도구를 통해 ONLY를 발생합니다. 기술로 목표를 불러오거나, 자신의 맥락에서 워크플로 인라인을 실행하는 것은 WRONG이지만, 기술이 사용 가능한 스킬 목록에 나타나는 경우에도 - 신선한 컨텍스트 격리를 금지하는 인라인 실행은이 파견이 존재하고 명시적 인 플래그는 이미 에이전트 통화 블록을 만듭니다. (단계는 인라인 FALLBACK을 정의하는 것은 파견된 에이전트이 실패한 후에만 적용됩니다.)

**에이전트 프롬프트:**

> /ship 워크플로우에 대한 Greptile 리뷰 의견을 분류하고 있습니다. `~/.claude/skills/gstack/review/greptile-triage.md`를 읽고, fetch, filter, classify 및 **escalation 검출** 단계에 따라 읽습니다. NOT 수정 코드가 실행되며, NOT의 답장을 읽습니다. NOT 커밋 - 보고서만 수행하십시오.
>
> 각 의견의 경우, 할당 : `classification` (`valid_actionable`, `already_fixed`, `false_positive`, `suppressed`), `escalation_tier` (1 또는 2), 파일 : 라인 또는 [top-level] 태그, 바디 요약 및 permalink URL.
>
> PR가 존재하지 않는 경우 `gh`가 실패한 경우 API 오류가 발생하거나 0 개의 댓글이 출력됩니다. `{"total":0,"comments":[]}`와 중지.
>
> 그렇지 않으면, 단일 JSON 객체를 LAST LINE의 응답을 출력합니다.
> `{"total":N,"comments":[{"classification":"...","escalation_tier":N,"ref":"file:line","summary":"...","permalink":"url"},...]}`

**부모 처리:**

LAST 라인 JSON를 파십시오.

`total` 은 0 이라면, 이 단계를 침묵으로 건너 뛰십시오. 12 단계로 계속하십시오.

**에이전트이 실패하면, 잘못된 JSON를 반환하거나, (가치에도 불구하고, 또는 ~10 분 후에 최종 출력을 완료하지 않는 경우, 기다리는; 배경 작업이 여전히 실행되면, 첫 번째를 중지 그래서 늦은 결과 결코 미각을 착륙하지 않음):** 프린트 `Greptile triage did not complete — review the PR comments manually`와 12 단계로 계속, UNAVAILABLE로 삼기 기록 - PR 몸에서: 리터럴 라인 `Greptile triage를 추가하십시오: UNAVAILABLE (dispatch failed)`를 검토-results 섹션 단계 19 조립 (사용할 수없는 삼기로 읽지 않아야합니다. 단계 20's 메트릭 스키마는 삼기 필드를 운반하지 않습니다. 따라서 PR체는 기록입니다. 삼기 에이전트에 /ship를 차단하지 마십시오.

그렇지 않으면 인쇄 : `+ {total} Greptile comments ({valid_actionable} valid, {already_fixed} already fixed, {false_positive} FP)`.

`comments`의 각 의견에 대한:

**VALID & ACTIONABLE:** AskUserQuestion를 사용하여:
- 댓글 (파일:라인 또는 [위-수준] + 바디 요약 + permalink URL)
- `RECOMMENDATION: Choose A because [one-line reason]`
- 옵션: A) 지금 수정, B) Acknowledge 및 배 어쨌든, C) 그것은 거짓 긍정적입니다
- 사용자가 A를 선택하면 수정을 적용하고, 고정 파일 (`git add <fixed-files> && git commit -m "fix: address Greptile review — <brief description>"`)을 투입하고 greptile-triage.md ( 인라인 디퓨프 + 설명 포함)에서 **수정된 응답 템플렛**를 사용하여 응답하고, 프로젝트 및 글로벌 무성 -history (유형 : 수정)에 저장하십시오.
- If user chooses C: reply using the **False 긍정적인 대답 템플렛** from greptile-triage.md (include evidence + suggested re-rank), save to both per-project and global greptile-history (type: fp).

**VALID BUT ALREADY FIXED:** greptile-triage.md에서 **Already 고정된 대답 템플렛**를 사용하여 대답 - AskUserQuestion 필요 없음:
- 수행 된 것을 포함 하 고 수정 명령 SHA
- 프로젝트와 글로벌 greptile-history 모두에 저장 (유형: 이미 고정)

**FALSE POSITIVE:** AskUserQuestion를 사용하십시오:
- 댓글을 표시하고 왜 잘못되었는지 (파일:라인 또는 [상위] + 바디 요약 + permalink URL)
- 옵션:
  - A) 거짓 긍정적 설명에 대한 Greptile에 대한 답변 (확실하게 잘못되었는지 수정)
  - B)는 어쨌든 수정합니다 (trivial 경우에)
  - C) 나는 조용히
- 사용자가 A를 선택하면 **False 긍정적인 대답 템플렛**에서 greptile-triage.md (증명 + 제안 된 재랭크 포함)을 사용하여 응답하고 per-project 및 global greptile-history (type : fp)에 저장하십시오.

**SUPPRESSED:** 침묵을 건너 뛰기 — 이것은 이전 삼극에서 거짓 긍정적이라고 알려져 있습니다.

**모든 의견이 해결 된 후:** 어떤 수정이 적용되었던 경우, 단계 5의 테스트가 이제 stale입니다. **재 실행 테스트** (Step 5)는 12 단계로 계속되기 전에. 수정이 적용되지 않은 경우, 12 단계로 계속됩니다.

---
