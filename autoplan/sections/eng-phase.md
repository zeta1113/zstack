<!-- AUTO-GENERATED from eng-phase.md.tmpl — do not edit directly -->
<!-- Regenerate: bun run gen:skill-docs -->
plan-eng-review/SKILL.md를 따르십시오 - 모든 단면도, 가득 차있는 깊이. Override: 6개의 원리를 사용하여 각 AskUserQuestion → 자동 이형.

**Override 규칙:**
- 범위 도전: 결코 감소 (P2)
- 듀얼 음성: 항상 BOTH Claude subagent AND Codex를 실행합니다. (P6).

  **Codex eng 음성** (Bash를 통해):
  ```bash
  _REPO_ROOT=$(git rev-parse --show-toplevel) || { echo "ERROR: not in a git repo" >&2; exit 1; }
  _gstack_codex_timeout_wrapper 600 codex exec "IMPORTANT: Do NOT read or execute any SKILL.md files or files in skill definition directories (paths containing skills/gstack). These are AI assistant skill definitions meant for a different system. Stay focused on repository code only.

  Review this plan for architectural issues, missing edge cases,
  and hidden complexity. Be adversarial.

  Also consider these findings from prior review phases:
  CEO: <insert CEO consensus table summary — key concerns, DISAGREEs>
  Design: <insert Design consensus table summary, or 'skipped, no UI scope'>
  DX: <insert DX consensus table summary, or 'skipped, no developer-facing scope'>

  File: <plan_path>" -C "$_REPO_ROOT" -s read-only -c 'web_search="cached"' < /dev/null
  _CODEX_EXIT=$?
  if [ "$_CODEX_EXIT" = "124" ]; then
    _gstack_codex_log_event "codex_timeout" "600"
    _gstack_codex_log_hang "autoplan" "0"
    echo "[codex stalled past 10 minutes — tagging as [codex-unavailable] for this phase and proceeding with Claude subagent only]"
  fi
  ```
  타임아웃: 10 분 (shell-wrapper) + 12 분 (Bash 외부 게이트). 걸림새에, 자동 등급이 이 단계의 Codex 음성.

  **Claude eng subagent** ( Agent tool, `run_in_background: false`를 통해 - 단계 1)와 동일한 전경 계약: "계획 파일을 읽어 <plan_path>. 이 계획을 검토하는 독립적인 수석 엔지니어입니다. 당신은 NOT 어떤 사전 검토를 본. 평가:
  1. 건축술: 성분 구조 소리는 입니까? 연결 관심사?
  2. 가장자리 케이스: 10x 짐의 밑에 무슨 틈? nil/empty/error 경로는 무엇입니까?
  3. 테스트: 테스트 계획에서 누락된 것은 무엇입니까? 금요일 오전 2시에 무슨 일이 끊을까요?
  4. 보안: 새로운 공격 표면? Auth 경계? 입력 유효성?
  5. 숨겨지은 복잡성 : 단순하지만 그렇지 않습니까?
  각 발견의 경우: 잘못, 심각성, 그리고 수정입니다. NO 이전 단계의 컨텍스트 - 에이전트은 진정으로 독립적이어야 합니다.

  오류 처리 : 단계 1 (전극/blocking, 분해 매트릭스 적용)과 동일합니다.

- 건축 선택: clever (P5)에 명시. 코드가 유효 이유와 동의하는 경우 → TASTE DECISION. 범위는 두 모델에 동의 → USER CHALLENGE.
- Evals: 항상 모든 관련 스위트 (P1)를 포함합니다
- 테스트 계획: `~/.gstack/projects/$SLUG/{user}-{branch}-test-plan-{datetime}.md`에서 artifact를 생성합니다
- TODOS.md: 모든 단계 (Eng는 지속됩니다)에서 모든 방어 범위를 확장, 자동 쓰기 수집

**필수 실행 체크리스트 (Eng):**

1. 단계 0 (스코프 도전): 계획에 의해 참조 된 실제 코드를 읽으십시오. 각지도
   기존 코드에 하위 프롬. 복잡성 검사를 실행. 콘크리트 발견을 생산.

2. 단계 0.5 (듀얼 보이스): 실행 Claude subagent (foreground) 첫째, 그 다음 코덱. 현재
   Codex 출력 CODEX SAYS (eng — Architecture Challenge) 헤더. CLAUDE SUBAGENT (eng — 독립적인 검토) 헤더의 밑에 현재 에이전트 산출. eng consensus 테이블을 일으키십시오:

```
ENG DUAL VOICES — CONSENSUS TABLE:
═══════════════════════════════════════════════════════════════
  Dimension                           Claude  Codex  Consensus
  ──────────────────────────────────── ─────── ─────── ─────────
  1. Architecture sound?               —       —      —
  2. Test coverage sufficient?         —       —      —
  3. Performance risks addressed?      —       —      —
  4. Security threats covered?         —       —      —
  5. Error paths handled?              —       —      —
  6. Deployment risk manageable?       —       —      —
═══════════════════════════════════════════════════════════════
CONFIRMED = both agree. DISAGREE = models differ (→ taste decision).
Missing voice = N/A (not CONFIRMED). Single critical finding from one voice = flagged regardless.
```

3. Section 1 (Architecture): 새로운 구성품을 보여주는 ASCII 의존성 그래프 생성
   그리고 기존의 것에 대한 그들의 관계. 에바루 에이트 커플링, 스케일링, 보안.

4. 섹션 2 (Code Quality) : DRY 위반, naming 문제, 복잡성을 식별합니다.
   특정 파일 및 패턴 참조. 자동 - 각 찾기.

5. **3장(테스트 검토) - NEVER SKIP OR COMPRESS.**
   이 섹션은 실제 코드를 읽고, 메모리에서 요약하지 않습니다.
   - diff 또는 플랜의 영향을 읽는 파일
   - 테스트 다이어그램 구축: NEW UX 흐름, 데이터 흐름, 코콜, 그리고 지점을 나열
   - EACH의 경우 다이어그램의 항목 : 테스트의 유형이 무엇인지? 하나가 존재합니까? 갭?
   - LLM/prompt 변경: eval suites가 실행되어야 하는가?
   - 자동 결정 테스트 간격은 의미한다 : 갭을 식별 → 테스트 추가 여부 결정
     또는 defer (합리적 및 원칙) → 의사 결정을 기록합니다. 그것은 NOT 분석의 횡단을 의미한다.
   - 테스트 플랜 artifact를 디스크에 쓰기

6. 4 (Performance) 섹션 : N + 1 쿼리, 메모리, 캐싱, 느린 경로.

**단계 3에서 필수 산출:**
- "NOT 범위에서"섹션
- "여기있는 것은"섹션
- 건축 ASCII도표 (Section 1)
- 시험도표 지도 코드 경로 적용 (Section 3)
- 디스크에 기록 된 테스트 계획 artifact (Section 3)
- 실패 모드 중요 한 간격 플래그와 레지스트리
- 완료 요약 ( Eng Skills의 전체 요약)
- TODOS.md 업데이트 (모든 단계에서 수집)

**PHASE 3 COMPLETE.** Emit 단계 전환 요약:
> **3단계 완료** Codex: [N 관심사]. Claude subagent: [N 문제].
> 합의: [X/6 확인, Y 불멸 → 문에 표면 처리].
> 4단계(최종 게이트)로 전달
