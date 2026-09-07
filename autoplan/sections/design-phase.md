<!-- AUTO-GENERATED from design-phase.md.tmpl — do not edit directly -->
<!-- Regenerate: bun run gen:skill-docs -->
plan-design-review/SKILL.md를 따르십시오 - 모든 7 차원, 가득 차있는 깊이. 각 AskUserQuestion → 6 원리를 사용하여 자동 이데드.

**Override 규칙:**
- 초점 지역: 모든 관련 차원 (P1)
- 구조 문제 (국가, 부서진 계층) : 자동 수정 (P5)
- Aesthetic/taste 문제: TASTE DECISION를 표시하십시오
- 설계 시스템 정렬 : DESIGN.md가 존재하고 수정이 명백하다면 자동 수정
- 듀얼 음성: 항상 BOTH Claude subagent AND Codex를 실행합니다. (P6).

  **Codex 디자인 음성** (Bash를 통해):
  ```bash
  _REPO_ROOT=$(git rev-parse --show-toplevel) || { echo "ERROR: not in a git repo" >&2; exit 1; }
  _gstack_codex_timeout_wrapper 600 codex exec "IMPORTANT: Do NOT read or execute any SKILL.md files or files in skill definition directories (paths containing skills/gstack). These are AI assistant skill definitions meant for a different system. Stay focused on repository code only.

  Read the plan file at <plan_path>. Evaluate this plan's
  UI/UX design decisions.

  Also consider these findings from the CEO review phase:
  <insert CEO dual voice findings summary — key concerns, disagreements>

  Does the information hierarchy serve the user or the developer? Are interaction
  states (loading, empty, error, partial) specified or left to the implementer's
  imagination? Is the responsive strategy intentional or afterthought? Are
  accessibility requirements (keyboard nav, contrast, touch targets) specified or
  aspirational? Does the plan describe specific UI decisions or generic patterns?
  What design decisions will haunt the implementer if left ambiguous?
  Be opinionated. No hedging." -C "$_REPO_ROOT" -s read-only -c 'web_search="cached"' < /dev/null
  _CODEX_EXIT=$?
  if [ "$_CODEX_EXIT" = "124" ]; then
    _gstack_codex_log_event "codex_timeout" "600"
    _gstack_codex_log_hang "autoplan" "0"
    echo "[codex stalled past 10 minutes — tagging as [codex-unavailable] for this phase and proceeding with Claude subagent only]"
  fi
  ```
  타임아웃: 10 분 (shell-wrapper) + 12 분 (Bash 외부 게이트). 걸림새에, 자동 등급이 이 단계의 Codex 음성.

  **Claude 디자인 에이전트** ( Agent tool, `run_in_background: false`를 통해 - 단계 1)와 동일한 전경 계약: "계획 파일을 읽어 <plan_path>. 이 계획을 검토하는 독립적인 고위 제품 디자이너입니다. 당신은 NOT 어떤 사전 검토를 본. 평가:
  1. 정보 hierarchy : 사용자가 먼저 볼 수있는 것은, 둘째, 셋째? 그것은 권리입니까?
  2. 미칭 상태: 로드, 빈, 오류, 성공, 부분 — 불특정?
  3. 사용자 여행: 감정적인 아크는 무엇입니까? 그것은 어디 끊는가?
  4. 특이성: 계획은 SPECIFIC UI 또는 일반적인 본을 설명합니까?
  5. 어떤 디자인 결정은 주변을 떠났을 때 구현자를 괴롭히게 될 것인가?
  각 발견의 경우: 잘못된 것, 심각성 (critical/high/medium), 및 수정." NO 이전 단계의 맥락 - 에이전트은 진정으로 독립적이어야 합니다.

  오류 처리 : 단계 1 (전극/blocking, 분해 매트릭스 적용)과 동일합니다.

- 디자인 선택: codex가 유효 UX 이유와 디자인 결정에 동의하는 경우
  → TASTE DECISION. 범위는 둘 다 모형에 동의합니다 → USER CHALLENGE.

**필수 실행 체크리스트 (Design):**

1. Step 0 (Design Scope): Rate completeness 0-10. Check DESIGN.md. Map existing patterns.

2. 단계 0.5 (듀얼 보이스): 실행 Claude subagent (foreground) 첫째, 그 다음 코덱. 현재 아래
   CODEX SAYS (설계 - UX 도전) 및 CLAUDE SUBAGENT (디자인 - 독립적인 검토) 우두머리. 생성 디자인 litmus scorecard (콘센서스 테이블). 계획 디자인 검토에서 litmus scorecard 체재를 사용하십시오. CEO 단계 발견을 포함하십시오 Codex 신속한 ONLY (Claude 에이전트 - 독립 체재하십시오).

3. 1-7 패스: 로드된 기술에서 각각 실행. 비율 0-10. 자동 결정 각 문제.
   DISAGREE scorecard →에서 두 관점과 관련된 패스로 올리는 항목.

**PHASE 2 COMPLETE.** Emit 단계 전환 요약:
> **2단계 완료** Codex: [N 관심사]. Claude subagent: [N 문제].
> 합의: [X/Y 확인, Z disagreements → 문에 표면 처리].
> 단계 3.에 전달

NOT는 플랜 파일에 기록된 모든 단계 2 출력(if run)까지 3 단계가 시작됩니다.
