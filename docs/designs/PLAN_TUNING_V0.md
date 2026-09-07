# 계획 조정 v0 - 디자인 도크

**상태:** v1 구현 **주요 특징:** garrytan/plan-tune-skill **저자:** Garry Tan (user), AI-sisted review from Claude Opus 4.7 + OpenAI Codex gpt-5.4 **일:** 2026-04-16

## 이 문서는 무엇입니까?

`/plan-tune` v1이 무엇인지의 공명 기록은 NOT, 우리가 고려한 것, 왜 우리는 각 전화를 만들었습니다. repo에 Committed 그래서 미래 기여자 (그리고 미래 가르리) 고고학없이 소감을 추적 할 수 있습니다. Supersedes the two `~/.gstack/projects/` artifacts (office-hours design doc + CEO plan) which are per-user local record.

## 한 단락에서 기능

gstack의 40+ 기술 불 AskUserQuestion는 지속적으로. 힘 사용자는 반복적으로 동일한 질문을 대답하고 gstack를 말하는 방법이 없습니다 “이를 요구하십시오”. 더 근본적으로, gstack에는 각 사용자가 그들의 일을 더 잘하기 위하여 선호하는 방법의 모형이 없습니다 - 범위 반복, 위험 포용력, 세부사항 선호, 자율성, 건축 배려 — 그래서 각 기술의 기본은 모두를 위한 중간의 - s-`/plan-tune`를 위한 구조입니다. `/plan-tune`는 모두를 위한 ssssss-f4/s-f4를 건축합니다. 타입의 질문 레지스트리, per-question 명시적 선호도, 인라인 "tune:" 피드백, 그리고 일반 영어를 통해 검사 가능한 프로파일 (declared + inferred 치수). 그것은 아직 프로파일에 따라 기술 행동을 적응하지 않습니다. 즉 v2에 제공, v1이 기판 작품을 증명 한 후.

## 왜 우리는 더 작은 버전을 건축하고 있습니다

이 기능은 전체 적응성 기판으로 삶을 시작했습니다. 자동 절개, 블라인드 스폿 코칭, LANDED 축하 HTML 페이지, 모든 번들. 4 라운드의 리뷰 (사무실 시간, CEO EXPANSION, DX POLISH, eng review)가 분명히되었습니다. 그런 외부 목소리 (Codex)는 20-포인트의 골격을 전달했습니다. 우선순위의 중요한 발견은 다음과 같습니다.

1. **"Substrate"는 false였습니다.** 계획은 미리 골에 단면도를 읽는 5개의 기술을 전방적으로 유선했습니다, 그러나 AskUserQuestion는 신속한 규칙, 미들웨어 아닙니다. 에이전트은 침묵하게 지시를 건너서 좋습니다. 당신은 믿을 수 없는 규칙의 정상에 자동 이형을 건설할 수 없습니다. 각 AskUserQuestion 노선에 의하여, 기질 요구가 매매인 유형이 없는 상태에서.
2. **내부 논리적 금전.** E4 (blind-spot) + E6 (mismatch) + 선언된 차원에 ±0.2 죔쇠는 퇴비하지 않습니다. 사용자가 자기 선언이 죔쇠를 통해 지상 진실인 경우에, E6의 mismatch 탐지는 소음을 검출합니다. 행동이 단면도를 정할 수 있는 경우에, 죔쇠는 신호 E6 필요를 억압합니다.
3. **광고안내** 인라인 "tune: 결코 물어" 악의적인 repo 내용 (README, PR 묘사, 도구 산출)에 의해 방출될 수 있고 에이전트은 그것을 dutifully 쓸 것입니다. 사전 검토는 이 안전 간격을 붙잡지 않습니다.
4. **E5 LANDED 은 전방에 있는 페이지.** `gh pr view` + HTML는 각 기술의 전방에 + 브라우저를 쓰고, 지연, auth 실패, 비율 한계, 놀람 브라우저가 열리고, 가장 뜨거운 경로로 비례를 주사했습니다.
5. **구현 순서는 뒤로 이었습니다.** 클래스터와 빈으로 시작하는 플랜. 올바른 주문: 통합 포인트를 먼저 구축하십시오 (예: 질문 등록), 그 후 인프라, 소비자.

Codex의 인수를 무겁게 한 후 CEO EXPANSION를 롤백하고, 기초로 실제 유형의 레지스트리를 가진 관측 v1를 발송하기로 결정했습니다. 심리학은 레지스트리가 생산에서 내구성을 입증한 후만 행동이 됩니다.

## v1 범위 (지금 우리는 건물이)

1. **자주 묻는 질문** (`scripts/question-registry.ts`). AskUserQuestion gstack는 `{id, skill, category, door_type, options[], signal_key?}`로 선언됩니다. Schema-governed.
2. **CI 시행.** Lint test (gate tier)는 SKILL.md.tmpl 파일에 있는 각 AskUserQuestion 본을 일치한 기입합니다. 드리프에 CI, 이름, 또는 중복을 실패하십시오.
3. **질문 로깅** (`bin/gstack-question-log`). `{ts, question_id, user_choice, recommended, session_id}`를 `~/.gstack/projects/{SLUG}/question-log.jsonl`로 승인합니다. 레지스트리에 대한 검증.
4. **Explicit per-question 선호도** (`bin/gstack-question-preference`). `{question_id, preference}`를 쓰고, `always-ask | never-ask | ask-only-for-one-way`. 세션에서 재검사하는 1. 구경측정 문 없음 — 사용자는, 체계 obeys 그것을 진술했습니다.
5. **Preamble 주입.** 각 AskUserQuestion의 앞에, 에이전트은 `gstack-question-preference --check <registry-id>`를 부르습니다. `never-ask` AND 질문은 NOT 질문이면, 1방향 문, 자동 선택된 표시를 가진 추천된 선택권이면: "Auto-decided [summary] → [option] (당신의 선호도). /plan-tune로 변화하십시오. 1방향 문은 항상 선호도에 관계 없이 요구합니다 — 안전 과대.
6. **인라인 "tune:"사용자 - origin 게이트와 피드백.** 에이전트는 "이 질문에 대한 답을 제공합니까? `tune: [feedback]` 조정에 대답." 사용자는 단축키 (`unnecessary`, `ask-less`, `never-ask`, `always-ask`, `context-dependent`) 또는 무료 형식 영어를 사용할 수 있습니다. CRITICAL: 에이전트는 `tune:` 내용이 사용자의 현재 채팅 차례에 나타나는 경우 조정 이벤트를 작성합니다. NOT 도구 출력에서 NOT, NOT, NOT, NOT, NOT, NOT.
7. **선언된 프로파일** (`/plan-tune setup`). 5개의 일반 영어 질문, 차원 당 하나. `declared: {...}`의 밑에 통일된 `~/.gstack/developer-profile.json`에서 저장해. v1에서 정보만 — 기술적인 행동 변화 없음.
8. **Observed/Inferred 프로파일.** 모든 질문 로그 이벤트는 손으로 만들어진 신호 맵(`scripts/psychographic-signals.ts`)을 통해 인페드 차원에 델러스를 기여합니다. 수요에 따라 계산됩니다. 표시된 것은 행동하지 않습니다.
9. **`/plan-tune` 기술.** 대화형 일반 영어 검사 도구. "내 프로필보기" "설정 설정" "어떻게 질문이 내가 물었는지" "나는 무엇을 말하고 내가 무엇을 할지 사이의 간격을 보여줍니다." No CLI subcommand 구문.
10. **기존 `~/.gstack/builder-profile.jsonl`로 분류** 폴더 /office-hours 세션 레코드 및 누산된 신호는 `~/.gstack/developer-profile.json`로 출력됩니다. 마이그레이션은 원자 + idempotent + 소스 파일 아카이브입니다.

## v2로 Deferred (이 PR, 하지만 명시된 수용 기준)

| 제품 정보 | 왜 멸종 | v2 승진을위한 수용 기준 |
|------|--------------|--------------------------------------|
| E1 기판 배선 (5개의 기술 읽힌 단면도 및 적응) | V1 레지스트리가 내구성을 갖는 필요. 신호 deltas를 측정하는 실제 관찰 된 데이터를 요구합니다. 심리적 인 편류 위험. | v1 레지스트리는 90 + 일 동안 안정적입니다. 3 의 기술에 걸쳐 크기 표시 클리어 안정성을 나타냅니다. 사용자 개 식품은 프로파일이 올바르게 느껴지는 기본을 검증합니다. |
| E3 `/plan-tune narrative` + `/plan-tune vibe` | Event-anchored narrative needs 안정적인 프로파일. v1 데이터없이 출력은 일반 슬로프가 될 것입니다. | 프로필 다양성 체크는 2 + 주 실제 사용을위한 패스입니다. Narrative 테스트는 특정 이벤트를 인용하지 않습니다. |
| E4 블라인드 스팟 코치 | E1/E6 와 같은 통용적 충돌은 명시적인 상호작용 없이 디자인. 글로벌 세션 예산, 에스컬레이션 규칙, 오해 감지에서 제외. | 상호 작용 예산 + 에스컬레이션을위한 디자인 사양. Dogfood는 도전이 코칭, 엉킴이를 느끼지 못합니다. |
| E5 LANDED 축하 HTML 페이지 | 프리램블에서 살 수 없습니다 (Codex #9, #10). 홍보할 때, 명시된 명령 `/plan-tune show-landed` OR 포스트 ship 후크로 이동 - 핫 경로에서 수동 감지하지. | Explicit 명령 또는 후크 디자인. /design-shotgun → /design-html 시각적 방향. PR 데이터 집계에 대한 보안 + 개인 정보 보호 검토. |
| E6 잡기에 근거를 둔 자동 조정 | v1에서 /plan-tune는 선언된과 인페리드 사이 간격을 보여줍니다. v2에서, 그것은 선언 업데이트를 건의할 수 있었습니다. 안정되어 있는 이중 궤도 단면도를 요구합니다. | v1의 실제 잡화 데이터는 일관된 패턴을 보여줍니다. 제안 UX 별도로 설계. |
| 심리학 구동 자동차 - decide | v1의 Zero 행동 변화. 만 명시된 선호도 행동. | Real usage shows 명시된 preferences cover most case. Inferred profile stable 충분 한 신뢰. |

## 전적으로 거절 (Codex 옳았고, 우리는 이것을 하지 않습니다)

| 제품 정보 | 왜 거부 |
|------|--------------|
| Substrate-as-prompt-convention (vs. 유형 레지스트리) | Codex #1. 에이전트는 침묵적으로 지시를 건너 뛸 수 있습니다. 상단의 심리학은 모래입니다. |
| 선언된 차원에 ±0.2 죔쇠 | Codex #6. E6 잡화 탐지를 가진 논리적인 금전 창조. ONE를 선택하십시오: 편집 가능한 선호 OR 인페리드 행동. 지금: 둘 다, 따로따로 추적하는 (듀얼 트랙 단면도). |
| prose summaries를 파서로 한방향 도어 분류 | Codex #4. 안전은 wording에 달려 있습니다. door_type는 inferred 아닙니다 (registry), 질문 정의 위치에 선언되어야 합니다. |
| 단일 이벤트 - schema 파일 섞는 선언 + overrides + verdicts + 의견 | Codex #5. 호환 도메인 객체. 이제 세 파일로 나뉩니다. 문제-log.jsonl, question-preferences.json, 질문-events.jsonl. |
| TTHW /plan-tune 내장을 위한 telemetry | Codex #14. 로컬 첫 번째 framing을 예측합니다. 로컬 로깅 만. |
| 인라인 조정: user-origin 검증 없이 쓰기 | Codex #16. 프로필 중독 공격. 이제: 사용자 리긴 문은 비 선택적입니다. |

## 건축

```
~/.gstack/
  developer-profile.json            # unified: declared + inferred + sessions (from office-hours)

~/.gstack/projects/{SLUG}/
  question-log.jsonl                # every AskUserQuestion, append-only, registry-validated
  question-preferences.json         # explicit per-question user choices
  question-events.jsonl             # tune: feedback events, user-origin gated
```

**통합 프로필 schema** (v0.16.2.0 빌더-profile.jsonl과 제안 된 developer-profile.json 둘 다를 감독하는):

```json
{
  "identity": {"email": "..."},
  "declared": {
    "scope_appetite": 0.9,
    "risk_tolerance": 0.7,
    "detail_preference": 0.4,
    "autonomy": 0.5,
    "architecture_care": 0.7
  },
  "inferred": {
    "values": {"scope_appetite": 0.72, "risk_tolerance": 0.58, "...": "..."},
    "sample_size": 47,
    "diversity": {
      "skills_covered": 5,
      "question_ids_covered": 14,
      "days_span": 23
    }
  },
  "gap": {"scope_appetite": 0.18, "...": "..."},
  "sessions": [
    {"date": "...", "mode": "builder", "project_slug": "...", "signals": []}
  ],
  "signals_accumulated": {
    "named_users": 1, "taste": 4, "agency": 3, "...": "..."
  }
}
```

**Diversity 체크** (Codex #13): `inferred`는 `sample_size >= 20 AND skills_covered >= 3 AND question_ids_covered >= 8 AND days_span >= 7`일 때만 “필요한 자료”로 간주됩니다. 이것의 밑에, `/plan-tune profile`는 잠재적으로 미군가치의 인페로드 가치 대신 “필요한 자료 아직”를 보여줍니다.

## 데이터 흐름 (v1)

1. Preamble: `question_tuning` config를 확인합니다. , 아무것도하지 않습니다.
2. 각 AskUserQuestion의 앞에:
   - 에이전트 호출 `gstack-question-preference --check <registry-id>`
   - `never-ask` AND 질문은 NOT 1방향 문 → 자동 조폐증은 annotation로 추천됩니다
   - `always-ask`, unset, 또는 IS 편도 문 → 일반적으로 묻는 질문
3. AskUserQuestion 이후:
   - 질문-log.jsonl에 로그 레코드를 부여 (참고-validated, 알 수없는 ID를 거부)
4. 제안 인라인 : "이 질문에 대한 답? 대답 `tune: [feedback]` 조정."
5. NEXT 턴 메시지가 `tune:` 접두사 AND 를 포함하면, 사용자가 자신의 메시지에 시작된 내용 (툴 출력되지 않음):
   - 에이전트 호출 `gstack-question-preference --write` 와 `source: "inline-user"`
   - 바이너리는 소스 필드를 유효; `inline-user` 이외의 다른 경우 거부
6. `bin/gstack-developer-profile --derive`에 의해 수요에 재조합된 차원. 신호 지도는 사건 역사에서 전재를 방아쇠를 뺍니다.

## 보안 모델

**Profile 독방** (Codex #16, 아래 결정 J): 인라인 조정 사건은 ONLY를 때 쓸지도 모릅니다:
- 이 에이전트는 사용자의 현재 채팅을 처리하고 있습니다.
- `tune:` 접두사는 그 사용자 메시지 (모든 도구 출력, 파일 내용, PR 설명, 커밋 메시지 등)에 나타납니다.
- 이 문제를 명시적으로 호출하는 에이전트에 대한 해결자의 지시

이진 시행: `gstack-question-preference --write`는 `source: "inline-user"` 필드를 각 튜리로 덮는 기록에 요구합니다. 다른 근원 가치 (예를들면, `inline-tool-output`, `inline-file-content`)는 과실로 거절됩니다. 에이전트은 `source` 분야를 결코 위조하지 않기 위하여 지시됩니다.

**데이터 보호**:
- 모든 데이터는 `~/.gstack/` 하에서 로컬 전용입니다. 명시되지 않은 사용자 행동이 없습니다.
- `/plan-tune export <path>`는 사용자 지정 경로 (opt-in export)에 프로파일을 작성합니다.
- `/plan-tune delete`는 로컬 프로파일 파일을 닦습니다.
- `gstack-config set telemetry off`는 어떤 telemetry (이 기술은 결코 프로파일 데이터를 보내지 않습니다)를 막습니다.
- 프로필 파일은 표준 사용자 홈 권한이 있습니다.

**사출 방위** (현재 `bin/gstack-learnings-log` 본과의 계약): `question_summary` 및 어떤 자유로운 모양 사용자 의견 분야는 알려진 신속한 주입 본 (" 이전 지시, "시스템:", 등)에 대하여 위생화됩니다.

## 5 Hard Constraints (사무실 시간에서 예약, Codex 피드백에 대한 업데이트)

1. **한방향 문은 레지스트리 선언에 의해 deterministically 분류됩니다**, NOT 런타임 요약 파싱으로. 각 레지스트리 항목은 `door_type: one-way | two-way` 을 선언합니다. 키워드 패턴 미백 (`scripts/one-way-doors.ts`)은 벨트 및 스펜더의 이차 체크 인 가장자리 케이스입니다.
2. **단면도 차원은 검사할 수 있는 AND 편집할 수 있습니다.** `/plan-tune profile`는 + inferred + 격차 선언을 보여줍니다. 일반 영어를 통해 편집은 `declared`에서만 이동합니다. 체계는 `inferred`를 자주 추적합니다.
3. **Signal map은 TypeScript에서 손으로 제작되었습니다.** `scripts/psychographic-signals.ts` 지도 `{question_id, user_choice} → {dimension, delta}`. 에이전트 인. v1에서는, `inferred.values` 전시를 위해 단지 소비했습니다 — 운전 결정에 대하지 않는.
4. **v1에 심리적 구동 자동 변형 없음.** 은 퀘스트를 명시한 것만 행동한다. 이 측면은 "카리브레이션 게이트는 게임"크리틱 (Codex #13) 을 전적으로 - v1은 통행 게이트가 없습니다.
5. **Per-project 선호도는 글로벌 선호도를 이길 수 있습니다.** `~/.gstack/projects/{SLUG}/question-preferences.json`는 미래의 글로벌 선호 파일에 이깁니다. 글로벌 프로파일 (`~/.gstack/developer-profile.json`)은 프로젝트 전반에 걸쳐 다양성을 위한 출발점입니다.

## 왜 이벤트에 자원 + 듀얼 트랙

**왜 인페드 프로파일에 대한 이벤트 리소스**:
- 신호 지도는 gstack 버전 사이에서 변화할 수 있습니다. 사건에서 Recompute, 필요 데이터 마이그레이션 없음.
- 감사: `/plan-tune profile --trace autonomy`는 값에 기여한 모든 이벤트를 보여줍니다.
- 미래 증거: 새로운 차원은 기존하는 역사에서 파생될 수 있습니다.

**왜 듀얼 트랙 (declared + inferred, 별도)** (아래의 결정 B):
- 논리적 금전 Codex #6를 식별합니다.
- `declared`는 사용자권입니다. 사용자들은 누구인지. 모든 사용자 중심의 시스템 비둘기(preferences, 선언, overrides).
- `inferred`는 관측입니다. 체계는 행동 본을 추적합니다. 표시되 그러나 v1에서 행동하지 않는.
- `gap`는 흥미로운 신호입니다. 큰 간격은 사용자의 자동 구독이 행동과 일치하지 않는 것이 좋습니다. - 귀중한 자기 통찰력, 그러나 자동 수정되지 않습니다.

## 인터 액션 모델 - 모든 곳에서 일반 영어

(/plan-devex-review에서 CLI 구문에 사용자 보정):

`/plan-tune` (Args 없음)는 대화 형태를 입력합니다. CLI subcommand 구문은 요구했습니다.

일반 언어의 메뉴:
- "내 프로필보기"
- "나는 질문입니다"
- "문제에 대한 선호 설정"
- "내 프로필을 업데이트하십시오. — 나는 무언가에 대해 나의 마음을 변경했습니다"
- "나는 내가 말한 것과 내가 무엇을 할 사이에 나를 틈을 보여"
- "돌아 갑니다"

사용자는 대화를 답합니다. 에이전트 해석은, 의도한 변화를 확인합니다. 예를 들어:
- 사용자 : "나는 0.5 건 이상의 붕대 인 사람보다 더 많은 것"
- 에이전트: "그게 - 업데이트 `declared.scope_appetite` 0.5에서 0.8? [Y/n]"
- 사용자: "예"
- Agent는 업데이트를 작성합니다.

확인 단계는 `declared`의 자유로운 모양 입력 (Codex #15 신뢰 경계)에서 어떤 묵상든지를 위해 요구됩니다.

전원 사용자는 단축키 (`narrative`, `vibe`, `reset`, `stats`, `enable`, `disable`, `diff`)를 입력할 수 있습니다. 더 나르는 것은 요구됩니다. 둘 다 일.

## 생성 파일

## 핵심 스키마
- `scripts/question-registry.ts` - 등록을 입력했습니다. SKILL.md.tmpl AskUserQuestion invocations의 감사에서 시드.
- `scripts/one-way-doors.ts` - 이차 키워드가 내리는. 기본: `door_type` 레지스트리.
- `scripts/psychographic-signals.ts` - 인페리드 컴퓨팅을 위한 손으로 만들어진 신호 지도.

## # 의무
- `bin/gstack-question-log` - 레지스트리에 대한 유효성 기록이 추가됩니다.
- `bin/gstack-question-preference` - read/write/check/clear 명시된 환경.
- `bin/gstack-developer-profile` - 슈퍼즈 `bin/gstack-builder-profile`. 서브콤맨드: `--read` (사적 compat), `--derive`, `--gap`, `--profile`.

### 리포저
- `scripts/resolvers/question-tuning.ts` - 3개의 발전기: `generateQuestionPreferenceCheck(ctx)` (전복 체크), `generateQuestionLog(ctx)` (post-question log), `generateInlineTuneFeedback(ctx)` (post-question tune: user-origin 문 지시로 신속한).

### 기술
- `plan-tune/SKILL.md.tmpl` — 대화, 일반 영어 검사 및 선호 도구.

### 시험
- `test/plan-tune.test.ts` - 레지스트리 완전성, 중복 ID 체크, 기본 우선성 (never-ask + not-one-way → AUTO_DECIDE; 결코-ask + one-way → ASK_NORMALLY), 사용자 라이진 게이트 (비 인라인 사용자 소스를 거부), 파생 + 재컴퓨트, 통합 프로필 스키마, 마이그레이션 회귀 7-session Fixture.

## 파일 수정

- `scripts/resolvers/index.ts` - 3개의 새로운 결의자를 등록하십시오.
- `scripts/resolvers/preamble.ts` — `_QUESTION_TUNING` config 읽기; 계층을 위한 3개의 결의자를 주사하십시오 >= 2.
- `bin/gstack-builder-profile` - `bin/gstack-developer-profile --read`에 레거시 shim 위임.
- 마이그레이션 스크립트 — 접어 기존 빌더-profile.jsonl을 unified developer-profile.json로 접어줍니다. 원자, idempotent, 아카이브 소스는 `.migrated-YYYY-MM-DD`로 펼칩니다.

## NOT v1에서 만지기

Explicitly unchanged — no `{{PROFILE_ADAPTATION}}` placeholders, 프로파일에 근거를 둔 행동 변화:

- `ship/SKILL.md.tmpl`, `review/SKILL.md.tmpl`, `office-hours/SKILL.md.tmpl`, `plan-ceo-review/SKILL.md.tmpl`, `plan-eng-review/SKILL.md.tmpl`

이 기술은 로깅 / 설정 검사 / 튜닝 피드백 만을위한 사전 처리 주사를 얻습니다. 프로파일 구동 기본이 없습니다. v2 작업.

## 결정 로그 (pros/cons 각각)

### 결정 A: 모든 세 번들을 (question-log + 감도 + 심리학) 대 배 작은 쐐기 - INITIAL ANSWER: BUNDLE; REVISED: REGISTRY-FIRST OBSERVATIONAL

초기 사용자 위치 (사무실 시간) : "심리적 IS 차이. 전체 일을 발송하기 때문에 피드백 루프는 실제로 행동을 조정할 수 있습니다." 이 무서운 CEO EXPANSION.

**번들링의 프로:** Ambition. 학습 층은 구성보다 더 만드는 것입니다. 심리학 없이, 그것은 공상 조정 메뉴입니다.

**묶음의 단점 (Codex에 의해 파도타기):** 기질은 존재하지 않았습니다. 프롬프트 발명의 정상에 심리학은 모래입니다. E1/E4/E6는 불행히 불행히도 퇴색되었습니다. 프로그래밍의 E5는 숨겨진 핫 동결 부작용입니다. 구현 주문은 무능한 대회의 주위에 건설한 기계장치를 건설했습니다.

**답을 개정:** 레지스트리-First Observal v1 (this doc). 명시된 수용 기준을 가진 v2 표적으로 주위를 보존합니다. 방어적인 기초를 발송하십시오. 사용자는 Codex의 20-point critique를 본 후에 이것을 받아들여집니다.

### Decision B: 이벤트 자원 대 저장 차원 대. 하이브리드-ANSWER: EVENT-SOURCED + USER-DECLARED ANCHOR (B+C)

**접근 A (점유된 차원):** 장소에 있는 Mutate. 간단한.
- Pros: 가장 작은 자료 모형. 이유에 쉬운.
- 단점 : 손실. 역사 없음. 신호지도 변경은 마이그레이션이 필요합니다. 프로필 변경은 사용자에 불투명합니다.

**접근 B (출입자):** 가게 원료 이벤트, derive 차원.
- Pros: Auditable. 신호 지도 변경에 재조정 가능. 데이터 마이그레이션이 없습니다. 기존의 Learning.jsonl 패턴과 일치합니다.
- 단점 : 더 복잡한 파생. 이벤트 파일은 시간이 지남에 따라 성장 (v2).

**Approach C (hybrid — 사용자 선언 앵커, 이벤트 정제) :** 처음 단면도는 사용자 지켜집니다; ±0.2 내의 사건 정유.
- Pros: Day-1 값. 사용자 주의력. 0에서 시작 대신 캘리브레이션 앵커.
- 단점 : ±0.2 클램프는 잡각 검출 (Codex #6)과 논리 충돌을 만듭니다.

**Chosen: ±0.2 CLAMP REMOVED와 결합된 B+C.** 이벤트에 의해 허가 된 언네아, 일류 분리 된 필드로 선언 된 프로필. 클램프 없음. 선언 및 독립적 인 값으로 인페스트. 그 사이에 갭은 표시되지만 v1에서 자동 수정되지 않습니다.

### 결정 C: 편도 문 분류 — 런타임 프로세싱 대. 레지스트리 선언 — ANSWER: REGISTRY DECLARATION (post-Codex)

**실행 시간 prose 패싱 (원래):** `isOneWayDoor(skill, category, summary)` 플러스 키워드 패턴.
- Pros: 기술 저자를 위한 최소 마찰. 유지에 schema 없음.
- cons (Codex #4): 안전은 낱말에 달려 있습니다. 온화한 불균형에 구워진 파 질문은 misclassified 일 수 있었습니다. 안전 문을 위해 불용할 수 있는.

**등록 (등록):** 모든 등록 항목은 `door_type`를 선언합니다.
- 프로: 결정. 감사. CI-enforceable (모든 질문은 선언해야 함).
- 단점 : 유지 보수 부담. 모든 새로운 기술 질문은 분류해야합니다.

**Chosen: 기본으로 레지스트리 선언, 미들백으로 키워드 패턴.** Schema 지배는 안전의 비용입니다.

### Decision D: 인라인 튜닝 피드백 문법 - 구조화된 키워드 vs. 무료형 자연 언어 — ANSWER: STRUCTURED WITH FREE-FORM FALLBACK

**구조화된 키워드:** `tune: unnecessary | ask-less | never-ask | always-ask | context-dependent`.
- Pros: Unambiguous. 프로필 데이터를 청소.
- 단점 : 사용자는 memorize해야합니다.

**무료 형식 :** 에이전트는 사용자의 말을 해석합니다.
- Pros: Natural. 문법이 없습니다.
- 단점 : Inconsistent 프로필 데이터. 왜곡이 영향을받지 않았는지 디버그하기 어렵습니다.

**Chosen: 둘 다.** 단축키는 전원 사용자를 위해 문서화했습니다; 에이전트은 자유로운 영어를 받아들이고 정상화합니다. 보통 영어 상호 작용은 기본적입니다; 구조화된 키워드는 선택적 빠르 동요입니다.

### 결정 E: CLI /plan-tune를 위한 subcommand 구조 - ANSWER: PLAIN ENGLISH CONVERSATIONAL (필수 subcommand 구문 없음)

**`/plan-tune profile`, `/plan-tune profile set autonomy 0.4`, 등.** (원래):
- Pros: 빠른 전력 사용자. 자기 문서 --help를 통해.
- 단점 : 사용자는 메모해야합니다. 모든 주장은 대화가 아닌 CLI 세션과 같습니다.

**일반 영어 회화 (사용자 보정 후 재방문):** `/plan-tune` 메뉴에 입력합니다. 사용자는 자연어로 원하는 것을 말합니다.
- 프로: 제로의 기억. 코치와 얘기하고 싶은 느낌, 포탄이 아닙니다.
- 단점 : 전력 사용자를위한 느린. 좋은 에이전트 해석을 필요로한다.

**Chosen: 선택적 단축과 대화.** 네이터 경로가 필요합니다. 대부분의 사용자는 단축키를 볼 수 없습니다. 선언 된 프로파일을 mutating하기 전에 필요한 확인 단계 (소속사 misinterpretation에 대한 안전 - Codex #15 신뢰 경계).

### 결정 F: 착륙 축하 — 수동 전무 탐지 대. 명시된 명령 대. 우편 발송 후 - ANSWER: DEFERRED TO v2; WHEN PROMOTED, NOT IN PREAMBLE

**preamble (원래)에 있는 수동적인 탐지:** 최근 합병을 감지하기 위해 각 기술의 전진 실행 `gh pr view`.
- Pros: 사용자가 실행하는 기술에 관계없이 작동합니다. 사용자는 특별한 일을 할 필요가 없습니다.
- Cons (Codex #9): 지연, 오존 실패, 속도 제한, 놀라움 브라우저가 열리고, 모든 기술의 전방에 비분명 주사. 뜨거운 경로의 부작용.

**Explicit 명령 (`/plan-tune show-landed`):** 사용자가 선택합니다.
- Pros: 핫 동결 부작용 없음. 사용자가 그것을 볼 때 제어.
- 단점 : 사용자 발견을 요구. "당신은 그것을 벌 때 당신을 놀라게한다" 마술은 손실된다.

**포스트 선 걸이 (`/ship` 트리거는 PR 창조 후에 탐지를 트리거로 합니다):** /ship에 묶여.
- Pros: 자연적인 타이밍. preamble 비용 없음.
- 단점 : /ship는 항상 착륙 이벤트 (수동 합병, 팀 구성원 수화 등).

**Chosen: DEFERRED 전적으로.** v2는 이것을 제대로 디자인할 것입니다. 승진될 때, 그것은 preamble에서 움직입니다. 사용자는 preamble에 있는 축하 페이지가 이미 Lisky 특징을 위한 전략적인 misfit인 Codex의 인수를 허용했습니다.

### 결정 G: 교정 게이트 — 20 이벤트 vs. 다양성 검사 — ANSWER: DIVERSITY-CHECKED

**"20 이벤트"(원래):** 간단한 조사.
- Pros: 트리 바이알을 구현합니다.
- (Codex #13): 게임 가능. 20 인라인 "unnecessary"는 ONE 질문에 5 차원을 측정하지 않아야 합니다.

**Diversity check (비밀번호):** `sample_size >= 20 AND skills_covered >= 3 AND question_ids_covered >= 8 AND days_span >= 7`.
- Pros: Profile은 실제로 신뢰할 수 있는 시스템의 맞은편에 운동되었습니다.
- 단점 : 더 복잡하게.

**Chosen: 다양성 검사.** v1에서는 "표시하기 위하여 자료가 없는" 문턱만을 사용했습니다. v2에서는 심리학 구동 자동 변종을 위한 문이 될 것입니다.

### Decision H: 구현 순서 — 클래스터 첫번째 대. 통합 포인트 먼저 — ANSWER: INTEGRATION POINT FIRST (registry + CI lint)

**Classifiers (원래):** bin 도구, 그 후 해결자, 그 후 기술 템플릿을 빌드합니다.
- Pros: 원자 건물 구획. 통합의 앞에 단위 테스트 할 수 있습니다.
- Cons (Codex #19): 강화된 규칙의 주위에 기계장치를 건설하십시오. 대회가 붙지 않는 경우에, 모든 일은 낭비됩니다.

**통합 지점 (revised):** 먼저 타입 레지스트리 + CI를 빌드합니다. 상단에 인프라를 구축하기 전에 통합 작업을 수행하십시오.
- Pros: Foundation은 입증되었습니다. 인프라는 재적으로 무언가가 튼튼합니다.
- 단점 : gstack에서 모든 기존 AskUserQuestion을 감사하는 데 필요한 경우, 실질적인 업 프론트 작업.

**Chosen: 통합 지점 먼저.** Codex의 인수가 결정되었습니다. 감사는 정확히 점입니다. 우리가 실제로 최고에 적응하기 전에 카탈로그를 통해 우리를 강제합니다.

### 결정 I: TTHW의 원격 측정 - 로컬 전용 대 선택 - ANSWER: LOCAL-ONLY

**Opt-in telemetry (원래, DX 검토에서 제안):** 계기 TTHW 원격 측정 사건을 통해.
- Pros: 모든 사용자의 경험에 대한 양적 측정.
- Cons (Codex #14): 로컬 첫 OSS framing을 의미한다. 이 기술을 위해 telemetry 표면을 특히 추가한다.

**지역 전용 (리뷰 됨):** 로깅은 로컬입니다. 기존 `telemetry` 구성을 재구성합니다. 기술에는 새로운 telemetry 채널이 없습니다.
- 프로: gstack의 로컬네비게이션을 통해 이해한다.
- 단점 : 내장 된 전망이 없습니다.

**Chosen: 현지 전용.** 나중에 TTHW 데이터가 필요하면 기존의 opt-in 뒤에 gstack-wide telemetry 이벤트로 추가하여 기술 별이 아닌 기술 별이 아닌 추가됩니다.

### 결정 J: 프로필 중독 방어 — 방어 대. 확인 게이트 vs. 사용자 리긴 게이트 — ANSWER: USER-ORIGIN GATE

**국방 없음 (원래 - Codex) :** 에이전트는 어떤 튜닝 이벤트를 작성합니다.
- Pros: Simplest. 추가적인 신뢰는 검사하지 않습니다.
- Cons (Codex #16): 맛있는 통 내용, PR 묘사, 도구 산출은 `tune: never ask`를 주사하고 단면도를 독을 주사할 수 있습니다. 이것은 진짜 공격 표면입니다.

**확인 문:** 모든 튜닝은 "확인? [Y/n]을 씁니다.
- Pros: 범용 방어.
- Cons: 모든 합법적인 사용에 대한 마찰.

**사용자 origin 문:** Agent는 `tune:` 접두사는 현재 턴에 대한 사용자의 채팅 메시지에 표시됩니다 (도구 출력되지 않음, 파일 내용이 아닙니다). 바이너리 유효성 검사 `source: "inline-user"`.
- Pros: 합법적인 사용에 마찰 없이 공격을 차단합니다.
- 단점 : 제대로 식별 소스에 의존합니다. Binary-level validation은 시행입니다.

**Chosen: 사용자origin 문.** 정상적인 흐름을 분해하지 않고 위협 모델 (자동 입력에 맛있는 내용) 일치.

## 성공 기준

- `bun test`는 새로운 `test/plan-tune.test.ts`를 포함하여 패스를 전달합니다.
- Every AskUserQuestion invocation in every SKILL.md.tmpl has a registry entry. CI lint enforces.
- `~/.gstack/builder-profile.jsonl`의 마이그레이션은 세션 + 시그널_ 축적된 100%를 보존합니다. 7조 고정장치를 가진 회귀 시험.
- 편도 문 등록-지정 항목 : 100 %의 파괴 ops, 건축 포크, 범위 추가 > 1 일 CC 노력, 보안/compliance 선택은 `one-way`로 분류됩니다.
- User-origin gate test: `source: "inline-tool-output"` 의 튜닝 이벤트를 작성하려고 하는 것은 거부.
- 개밥: 가리는 2 주 동안 `/plan-tune`를 사용합니다. 뒤에 보고하십시오:
  - `tune: never-ask` 자연을 입력하거나 무시한 느낌
  - 등록 유지 보수 (새로운 질문 추가) 합리적인 분야 또는 스키마 bureaucracy 처럼 느꼈다
  - Inferred 차원은 회의 또는 noisy의 맞은편에 안정되어 있었습니다
  - Plain-English 상호 작용은 코치처럼 느꼈거나 chatbot과 같이 느꼈습니다.

## 구현 순서

1. `AskUserQuestion` 각 gstack SKILL.md.tmpl에서 각 `AskUserQuestion`를 감사하십시오. ID, 종류, door_types, 선택권을 가진 처음 `scripts/question-registry.ts`를 건설하십시오. 이것은 기초입니다; 다른 모든 것은 그것에 앉습니다.
2. `test/plan-tune.test.ts` 레지스트리 완성 테스트 (게이트 티)를 작성합니다. 그것은 드리프트를 잡습니다. - 일시적으로 1 레지스트리 항목을 제거하고 CI가 실패합니다.
3. Seed `scripts/one-way-doors.ts` 키워드 패턴의 미백 클래스터.
4. 초기 `{question_id, user_choice} → {dimension, delta}` 매핑을 가진씨 `scripts/psychographic-signals.ts`. 수는 천막 — v1 배, v2 재조립입니다.
5. 시드 `scripts/archetypes.ts` 아치형 정의 ( 미래 v2 `/plan-tune vibe`에 의해 설정).
6. `bin/gstack-question-log` - 레지스트리에 대한 검증, 알 수없는 ID를 거부.
7. `bin/gstack-question-preference` - 모든 subcommands + 테스트.
8. `bin/gstack-developer-profile` - `--read` (아직), `--derive`, `--gap`, `--profile`.
9. 마이그레이션 스크립트 — builder-profile.jsonl → unified developer-profile.json. 원자, idempotent, 아카이브 소스. 회귀 테스트와 정착물.
10. `scripts/resolvers/question-tuning.ts` — 3개의 발전기 (preference check, log, user-origin 문 지시와 인라인 조정).
11. `scripts/resolvers/index.ts`의 3개의 결의자 등록.
12. `scripts/resolvers/preamble.ts` - `_QUESTION_TUNING` config 읽기; 계층에 대한 조건부 주사 >= 2 기술.
13. `plan-tune/SKILL.md.tmpl` — 대화형 일반 영어 기술.
14. `bun run gen:skill-docs` - 모든 SKILL.md 파일 재생; 100KB 토큰 천장의 밑에 각 체재를 확인합니다.
15. `bun test` - 모든 45+ 시험 케이스 녹색.
16. Dogfood 2+ 주. 실제 질문 로그 + 선호 데이터 수집. 성공 기준에 대한 측정.
17. `/ship` v1. v2 범위 토론 후 개식품.

## 오픈 질문 (v2 범위 결정, 실제 데이터까지 방어)

1. 정확한 신호지도 deltas. v1는 처음 추측으로 배; 관찰된 자료에서 v2 recalibrates.
2. `inferred`와 `declared` 간격이 크면 자동 절단 `declared`를 자동 절단합니까? 또는 다만 전시?
3. 신호 맵 버전이 변경되면 자동 입력 또는 신속한 사용자를합니까? 기본값 : diff 디스플레이가있는 자동 입력.
4. 크로스 프로젝트 프로필 상속 vs. isolation. v1은 프로젝트 선호도 + 글로벌 프로파일입니다. v2는 명시된 크로스 프로젝트 학습 선택 인을 추가 할 수 있습니다.
5. /plan-tune가 공유 개발자 프로파일이 협업을 알리는 "team profile" 모드를 지원해야 하나요? v2+.

## 리뷰 통합

- **/office-hours (2026-04-16, 1 세션):** 5개의 단단한 constraints를 놓고, 사건 자원화된 + 사용자 선언한 건축 선택했습니다.
- **/plan-ceo-review (2026-04-16, EXPANSION 형태):** 6 확장 허용, 나중에 Codex 검토 후 다시 압연.
- **/plan-devex-review (2026-04-16, POLISH 형태):** 일반 영어 상호 작용 모델; 이것은 v1에 살아남습니다.
- **/plan-eng-review (2026-04-16):** 테스트 계획 및 완료 체크; 부분적으로 레지스트리-First 리쓰에 의해 초래.
- **/codex (2026-04-16, gpt-5.4 높은 소원):** 20 점은 롤백을 드리웁니다. 15 + 합법적 인 발견 Claude 리뷰는 놓았습니다.

## 크레딧과 동굴

이 계획은 계획의 ~6 시간 이상 이식적인 AI-collaboration 반복을 통해 개발되었습니다. 저자 (Garry Tan)는 각 범위 결정 지시합니다; AI 음성 (Claude Opus 4.7 및 OpenAI Codex gpt-5.4) 도전하고 계획을 세련했습니다. Codex의 외부 음성 없이, 다량 더 크고 더 적은 불연성 계획은 발송했습니다. 교차하 모형에 교차하 구조의 가치는 건축과 건축가에 있는 높은 변화입니다.
