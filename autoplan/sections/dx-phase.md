<!-- AUTO-GENERATED from dx-phase.md.tmpl — do not edit directly -->
<!-- Regenerate: bun run gen:skill-docs -->
plan-devex-review/SKILL.md를 따르십시오 - 모든 8 DX 차원, 가득 차있는 깊이. 각 AskUserQuestion → 6 원리를 사용하여 자동 이형.

**Override 규칙:**
- 형태 선택: DX POLISH
- Persona: README/docs에서 infer는 가장 일반적인 개발자 유형 (P6)를 선택합니다.
- 경쟁적인 벤치 마크: 웹 검색이 유효한 경우에, 사용 참고 벤치 마크 그렇지 않으면 (P1)
- 매직 순간: 경쟁적인 층을 달성하는 가장 낮은 노력 납품 차량을 선택하십시오 (P5)
- 시작 마찰을 얻기: 항상 몇 단계로 최적화 (P5, clever 이상으로 간단)
- 오류 메시지 품질: 항상 문제 + 원인 + 수정 (P1, 완료)
- API/CLI naming: 일관성은 절개 (P5)에 이깁니다
- DX 맛 결정 (예:, 매각된 기본 대 융통성): 표 TASTE DECISION
- 듀얼 음성: 항상 BOTH Claude subagent AND Codex를 실행합니다. (P6).

  **Codex DX 음성** (Bash를 통해):
  ```bash
  _REPO_ROOT=$(git rev-parse --show-toplevel) || { echo "ERROR: not in a git repo" >&2; exit 1; }
  _gstack_codex_timeout_wrapper 600 codex exec "IMPORTANT: Do NOT read or execute any SKILL.md files or files in skill definition directories (paths containing skills/gstack). These are AI assistant skill definitions meant for a different system. Stay focused on repository code only.

  Read the plan file at <plan_path>. Evaluate this plan's developer experience.

  Also consider these findings from prior review phases:
  CEO: <insert CEO consensus summary>
  Eng: <insert Eng consensus summary>

  You are a developer who has never seen this product. Evaluate:
  1. Time to hello world: how many steps from zero to working? Target is under 5 minutes.
  2. Error messages: when something goes wrong, does the dev know what, why, and how to fix?
  3. API/CLI design: are names guessable? Are defaults sensible? Is it consistent?
  4. Docs: can a dev find what they need in under 2 minutes? Are examples copy-paste-complete?
  5. Upgrade path: can devs upgrade without fear? Migration guides? Deprecation warnings?
  Be adversarial. Think like a developer who is evaluating this against 3 competitors." -C "$_REPO_ROOT" -s read-only -c 'web_search="cached"' < /dev/null
  _CODEX_EXIT=$?
  if [ "$_CODEX_EXIT" = "124" ]; then
    _gstack_codex_log_event "codex_timeout" "600"
    _gstack_codex_log_hang "autoplan" "0"
    echo "[codex stalled past 10 minutes — tagging as [codex-unavailable] for this phase and proceeding with Claude subagent only]"
  fi
  ```
  타임아웃: 10 분 (shell-wrapper) + 12 분 (Bash 외부 게이트). 걸림새에, 자동 등급이 이 단계의 Codex 음성.

  **Claude DX 에이전트** ( Agent tool, `run_in_background: false`를 통해 - 단계 1)와 동일한 전경 계약: "<plan_path>에 계획 파일을 읽어보십시오. 당신은 독립적인 DX이 계획을 검토하는 엔지니어입니다. 당신은 NOT 어떤 사전 검토든지 본. 평가:
  1. 시작: 0에서 hello world로 여러 단계가 어떻게 되었습니까? TTHW는 무엇입니까?
  2. API/CLI 인체공학: naming 견실함, 민감하는 과태, 진보적인 공개?
  3. 오류 처리 : 모든 오류 경로는 문제를 지정 + 원인 + 수정 + docs 링크?
  4. 문서: 복사-약 예제? 정보 아키텍처? 대화 형 요소?
  5. Escape hatches: 개발자가 모든 의견이 기본을 무시할 수 있습니까?
  각 발견의 경우: 잘못된 것, 심각성 (critical/high/medium), 및 수정." NO 이전 단계의 맥락 - 에이전트은 진정으로 독립적이어야 합니다.

  오류 처리 : 단계 1 (전극/blocking, 분해 매트릭스 적용)과 동일합니다.

- DX 선택: codex가 유효 개발자 empathy reasoning과 DX 결정과 관련하여 동의하는 경우
  → TASTE DECISION. 범위는 둘 다 모형에 동의합니다 → USER CHALLENGE.

**필수 실행 체크리스트 (DX):**

1. Step 0 (DX 범위 평가): 자동 탐지 제품 유형. 개발자 여행 지도.
   비율 처음 DX 완전성 0-10. 아시스테스 TTHW.

2. 단계 0.5 (듀얼 보이스): 실행 Claude subagent (foreground) 첫째, 그 다음 코덱. 현재
   CODEX SAYS (DX — 개발자 경험 도전) 및 CLAUDE SUBAGENT (DX - 독립적인 검토) 우두머리. DX consensus 테이블을 생성하십시오:

```
DX DUAL VOICES — CONSENSUS TABLE:
═══════════════════════════════════════════════════════════════
  Dimension                           Claude  Codex  Consensus
  ──────────────────────────────────── ─────── ─────── ─────────
  1. Getting started < 5 min?          —       —      —
  2. API/CLI naming guessable?         —       —      —
  3. Error messages actionable?        —       —      —
  4. Docs findable & complete?         —       —      —
  5. Upgrade path safe?                —       —      —
  6. Dev environment friction-free?    —       —      —
═══════════════════════════════════════════════════════════════
CONFIRMED = both agree. DISAGREE = models differ (→ taste decision).
Missing voice = N/A (not CONFIRMED). Single critical finding from one voice = flagged regardless.
```

3. 1-8을 통과: 로드된 기술에서 각각 실행. 비율 0-10. 각 문제점을 자동 삭제하십시오.
   DISAGREE consensus table →에서 항목은 두 가지 관점과 관련된 패스로 제기됩니다.

4. DX Scorecard: 모든 8 차원 득점을 가진 가득 차있는 득점방해를 생성하십시오.

**단계 2.5에서 필수 산출:**
- 개발자 여행 맵 (9단 테이블)
- 개발자 empathy narrative (최초의 관점)
- DX 모든 8개의 차원 점수를 가진 득점방해
- DX 구현 체크리스트
- TTHW 대상 평가

**PHASE 2.5 COMPLETE.** Emit 단계 전환 요약:
> **2.5 단계 완료.** DX 전체: [N]/10. TTHW: [N] 분 → [target] 분.
> Codex: [N 우려]. Claude 에이전트: [N 문제].
> 합의: [X/6 확인, Y 불멸 → 문에 표면 처리].
> 3단계(Eng Review — 필수 게이트는 최종 개정된 플랜을 검토합니다.
