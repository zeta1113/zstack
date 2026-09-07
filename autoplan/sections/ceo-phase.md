<!-- AUTO-GENERATED from ceo-phase.md.tmpl — do not edit directly -->
<!-- Regenerate: bun run gen:skill-docs -->
plan-ceo-review/SKILL.md를 따르십시오 - 모든 단면도, 가득 차있는 깊이. Override: 6개의 원리를 사용하여 각 AskUserQuestion → 자동 이형.

**Override 규칙:**
- 형태 선택: SELECTIVE EXPANSION
- 약속: 합리적인 한 명을 수용 (P6). 명확하게 잘못 또는 도전 된 구내는
  NOT 중간 런 중지 - 각을 최종 승인 게이트 (상 4)에 대한 사용자 홀란지 모양의 항목으로 큐: 계획이 가정하는 것, 왜 잘못 되었는지, 그리고 어쨌든 진행 비용. 전제는 여전히 인간적인 판단이 필요합니다. 인간은 문에서 그것을, 정확히 한 번, 중간 파이프 라인이 아닙니다.
- 대안: 가장 높은 완전성 (P1)를 선택하십시오. 묶인 경우, 가장 간단한 (P5)를 선택하십시오.
  상단 2가 닫히는 경우 → TASTE DECISION를 표시하십시오.
- Scope expansion: in blast radius + <1d CC → approve (P2). Outside → defer to TODOS.md (P3).
  중복 → 거부 (P4). 국경 (3-5 파일) → 표 TASTE DECISION.
- 모든 10 리뷰 섹션 : 완전히 실행, 자동 수정 각 문제, 모든 결정에 로그.
- 듀얼 음성: 항상 BOTH Claude subagent AND Codex를 실행합니다. (P6).
  그(것)들을 전경에서 순차적으로 실행하십시오. Claude subagent (런_으로_background: false - BACKGROUND 의 Claude Code v2.1.198 이므로 flag 는 명시적으로 false이어야 합니다), Codex (Bash). 둘 다 합의 테이블을 건설하기 전에 완료해야 합니다.

  **Codex CEO 음성** (Bash를 통해):
  ```bash
  _REPO_ROOT=$(git rev-parse --show-toplevel) || { echo "ERROR: not in a git repo" >&2; exit 1; }
  _gstack_codex_timeout_wrapper 600 codex exec "IMPORTANT: Do NOT read or execute any SKILL.md files or files in skill definition directories (paths containing skills/gstack). These are AI assistant skill definitions meant for a different system. Stay focused on repository code only.

  You are a CEO/founder advisor reviewing a development plan.
  Challenge the strategic foundations: Are the premises valid or assumed? Is this the
  right problem to solve, or is there a reframing that would be 10x more impactful?
  What alternatives were dismissed too quickly? What competitive or market risks are
  unaddressed? What scope decisions will look foolish in 6 months? Be adversarial.
  No compliments. Just the strategic blind spots.
  File: <plan_path>" -C "$_REPO_ROOT" -s read-only -c 'web_search="cached"' < /dev/null
  _CODEX_EXIT=$?
  if [ "$_CODEX_EXIT" = "124" ]; then
    _gstack_codex_log_event "codex_timeout" "600"
    _gstack_codex_log_hang "autoplan" "0"
    echo "[codex stalled past 10 minutes — tagging as [codex-unavailable] for this phase and proceeding with Claude subagent only]"
  fi
  ```
  타임아웃: 10 분 (shell-wrapper) + 12 분 (Bash 외부 게이트). 걸림새에, 자동 등급이 이 단계의 Codex 음성.

  **Claude CEO 에이전트** ( Agent tool을 통해): "<plan_path>의 플랜 파일을 읽어보십시오. 이 플랜을 검토하는 독립적 인 CEO/strategist입니다. 당신은 NOT가 있습니다. 평가:
  1. 해결하기 위해이 올바른 문제입니까? reframing 수율 10x 충격을 수 있었습니까?
  2. 그곳에 명시된 것일까? 어느 것일까?
  3. 6 개월 후회 시나리오는 무엇입니까?
  4. 어떤 대안이 충분한 분석없이 해소되었습니까?
  5. 경쟁 위험은 무엇인가 — 다른 사람이이 먼저 해결 할 수/better?
  각 발견의 경우: 잘못된 것, 심각성 (critical/high/medium), 및 수정."

  **오류 처리 :** 이 지상에서 두 호출 블록. Codex auth/timeout/empty → Claude subagent와 진행, 태그 `[single-model]`. Claude 에이전트이 실패하면 → "사용 가능한 음성"

  **덱스터:** 둘 다 실패 → “단일 단 하나 더 형태”. Codex 단지 → 꼬리표 `[codex-only]`. 에이전트 단지 → 꼬리표 `[subagent-only]`.

- 전략 선택: codex가 유효성 검사를 전제 또는 범위 결정으로 동의하는 경우
  전략적인 이유 → TASTE DECISION. 두 모델이 사용자의 명시된 구조에 동의하는 경우 (merge, split, add, remove) → USER CHALLENGE (자동 유래)를 변경해야 합니다.

**필수 실행 체크리스트 (CEO):**

단계 0 (0A-0F) - 각 하위 단계 및 생성을 실행:
- 0A: 특정한 건물과 가진 전제 도전은 명명하고 평가했습니다
- 0B: 기존 코드 레버리지 맵(sub-problems → 기존 코드)
- 0C: 꿈 국가 도표 (CURRENT → THIS PLAN → 12-MONTH IDEAL)
- 0C-bis: 구현 대안 테이블 (2-3 접근 effort/risk/pros/cons)
- 0D: 범위 결정과 모드별 분석은 로그를 기록
- 0E: 임시 방해 (HOUR 1 → HOUR 6+)
- 0F: 형태 선택 확인

단계 0.5 (듀얼 보이스): Claude subagent (foreground Agent tool)를 첫째로 실행하고, 그 후에 Codex (Bash). 현재 Codex 출력 CODEX SAYS (CEO - 전략 도전) 헤더. 현재 CLAUDE SUBAGENT (CEO — 전략적 독립) 헤더의 밑에 에이전트 산출. 생성 CEO consensus 테이블:

```
CEO DUAL VOICES — CONSENSUS TABLE:
═══════════════════════════════════════════════════════════════
  Dimension                           Claude  Codex  Consensus
  ──────────────────────────────────── ─────── ─────── ─────────
  1. Premises valid?                   —       —      —
  2. Right problem to solve?           —       —      —
  3. Scope calibration correct?        —       —      —
  4. Alternatives sufficiently explored?—      —      —
  5. Competitive/market risks covered? —       —      —
  6. 6-month trajectory sound?         —       —      —
═══════════════════════════════════════════════════════════════
CONFIRMED = both agree. DISAGREE = models differ (→ taste decision).
Missing voice = N/A (not CONFIRMED). Single critical finding from one voice = flagged regardless.
```

섹션 1-10 - EACH 섹션에서는 로드된 기술 파일에서 평가 기준을 실행합니다.
- WITH 찾음: 전체 분석, 자동 변형 각 문제, 감사 트레일에 로그인
- NO를 가진 단면도는 찾아냈습니다: 시험되고 왜 아무것도 하는 1-2의 문장
  푹신한 NEVER는 테이블 행에 있는 그 이름에 단면도를 압축했습니다.
- 제11조(디자인): UI 범위가 단계 0에서 검출된 경우에만 실행

**단계 1에서 필수 산출:**
- "NOT 범위에서"부분을 갖는 항목과 합리적
- "무엇이 이미 존재"섹션 맵핑 하위 - 프롬스를 기존 코드에
- 오류 및 구조 레지스트리 테이블 (서부 2)
- 실패 모드 레지스트리 테이블 ( 리뷰 섹션에서)
- 꿈 상태 델타 (이 계획이 12 개월 이상 우리를 남겨)
- 완료 요약 (CEO 기술에서 전체 요약표)

**PHASE 1 COMPLETE.** Emit 단계 전환 요약:
> **1단계 완료** Codex: [N 관심사]. Claude subagent: [N 문제].
> 합의: [X/6 확인, Y 불멸 → 문에 표면 처리].
> 단계 2.에 전달

NOT는 모든 단계 1 산출이 계획 파일에 기록될 때까지 단계 2를 시작한다. (마지막 게이트에 도착한 예비적인 도전 여행은 - 그들은 여기에서 파이프라인을 일시 중지하지 않습니다).
