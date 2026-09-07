<!-- AUTO-GENERATED from review-sections.md.tmpl — do not edit directly -->
<!-- Regenerate: bun run gen:skill-docs -->
## 검토 섹션 (7 패스, 범위가 동의한 후)

**반대로 스키 규칙:** 결코 집광, 약어, 또는 어떤 리뷰 패스 (1-7) 계획 유형 (전략, 사양, 코드, 인프라)에 관계없이 건너 뛰기. 이 존재 기술에 모든 패스는 이유에 대한. "이것은 전략 문서 그래서 디자인 패스는 적용되지 않습니다" 항상 잘못 - 디자인 간격은 구현이 중단되는 곳. 패스가 실제로 0 발견되면, "문제가 발견되지 않음"라고 말하지만, 평가해야합니다.

**반대로 단락:** The plan file is the OUTPUT of the interactive review, not a substitute for it. Writing every finding into one plan write and calling ExitPlanMode without firing AskUserQuestion is the precise failure mode of the May 2026 transcript bug — the model explored, found issues, and dumped them into a deliverable rather than walking the user through them. If you have ANY non-trivial finding in any review section, the path from finding to ExitPlanMode goes THROUGH AskUserQuestion. 모든 섹션에서 Zero 찾기는 AskUserQuestion을 우회하는 ExitPlanMode의 유일한 경로입니다. 요청하기 전에 발견 계획을 작성하고, 중지하고 AskUserQuestion를 호출하기 위해 원하는 경우, 버그가 인식됩니다.

## 사전 학습

이전 세션에서 관련 학습 검색:

```bash
_CROSS_PROJ=$(~/.claude/skills/gstack/bin/gstack-config get cross_project_learnings 2>/dev/null || echo "unset")
echo "CROSS_PROJECT: $_CROSS_PROJ"
if [ "$_CROSS_PROJ" = "true" ]; then
  ~/.claude/skills/gstack/bin/gstack-learnings-search --limit 10 --cross-project 2>/dev/null || true
else
  ~/.claude/skills/gstack/bin/gstack-learnings-search --limit 10 2>/dev/null || true
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

## 패스 1: 정보 아키텍처 비율 0-10: 계획은 사용자가 처음, 두 번째, 세 번째를 볼 수 있는지 정의합니까? FIX TO 10 : 계획에 대한 정보 계층을 추가하십시오. 화면의 ASCII 다이어그램/page 구조 및 탐색 흐름을 포함하십시오. "콘트 숭배"를 적용하십시오. 3 가지만 표시 할 수 있다면? **STOP.** AskUserQuestion 문제가 한 번. NOT 배치. NOT <7> /> 배치. <7> 사용자가 작동하지 않을 때까지, 또는 문제로 이동하십시오.

## Pass 2: Interaction State Coverage Rate 0-10: 계획은 로딩, 빈, 오류, 성공, 부분 상태입니까? FIX TO 10: 계획에 상호 작용을 추가하십시오:
```
  FEATURE              | LOADING | EMPTY | ERROR | SUCCESS | PARTIAL
  ---------------------|---------|-------|-------|---------|--------
  [each UI feature]    | [spec]  | [spec]| [spec]| [spec]  | [spec]
```
각 국가: 사용자 SEES, backend 동작을 설명합니다. 빈 상태는 특징입니다. - 열악한, 1 차적인 행동, 컨텍스트를 지정합니다. **STOP.** AskUserQuestion는 문제 당 한 번. NOT 배치를 하십시오. 추천 + WHY.

## Pass 3: 사용자 여행 & 감정적인 Arc Rate 0-10: 계획은 사용자의 정서적 경험을 고려합니까? FIX TO 10: 사용자 여행 스토리를 추가하십시오:
```
  STEP | USER DOES        | USER FEELS      | PLAN SPECIFIES?
  -----|------------------|-----------------|----------------
  1    | Lands on page    | [what emotion?] | [what supports it?]
  ...
```
시간 호르몬 디자인을 적용하십시오: 5-sec visceral, 5-min 행동, 5-year 사려깊은. **STOP.** AskUserQuestion는 문제점 당 한 번. NOT 배치를 하십시오. 추천 + WHY.

## Pass 4: AI 슬로프 위험률 0-10: 계획은 특정, 의도적인 UI 또는 일반적인 본을 묘사합니까? FIX TO 10: 특정 대안과 vague UI 묘사를 씁니다.

## 디자인 하드 규칙

**Classifier — evaluating 전에 규칙을 결정하십시오:**
- **MARKETING/LANDING PAGE** (영역, 브랜드 포워드, 전환 중심) → 랜딩 페이지 규칙 적용
- **APP UI** (작업대 구동, 데이터 밀도, 작업대 집중: 대시보드, 관리자, 설정) → 앱 UI 규칙 적용
- **HYBRID** (앱 같은 섹션으로 쉘을 배치) → 영웅에게 Landing Page Rules를 적용/marketing 섹션, App UI 기능 섹션에 규칙

**단단한 거절 기준** (instant-fail 패턴 - ANY 적용시 플래그):
1. Genric SaaS 카드 그리드 첫 인상
2. 약한 상표를 가진 아름다운 이미지
3. 강한 headline 와 no clear 활동
4. Busy 이미지 뒤에 text
5. 같은 정취 문 반복하는 단면도
6. narrative 목적이 없는 Carousel
7. 앱 UI 배치 대신에 쌓인 카드로 만든

**Litmus 검사** (각을 위해 사용되는 enwer YES/NO):
1. 브랜드/product 첫 화면에서 무효?
2. 한 강력한 시각 앵커 선물?
3. headlines를 스캔하여 이해하는 페이지?
4. 각 섹션에는 하나의 작업이 있습니까?
5. 카드는 실제로 필요한가요?
6. 모션은 hierarchy 또는 대기를 개선합니까?
7. 모든 장식 그림자에 프리미엄을 디자인 할 수 있습니까?

**착륙 페이지 규칙** (클래식 = MARKETING/LANDING) :
- First viewport는 대쉬보드가 아닌 한 구성으로 읽습니다.
- 브랜드-최초의 hierarchy: 브랜드 > 헤드라인 > 바디 > CTA
- Typography: 표현, 목적이 있는 — 과태 더미 없음 (Inter, Roboto, Arial, 체계)
- 플랫 단색 배경이 없습니다. - gradients, 이미지, 미묘한 패턴을 사용하십시오.
- 영웅: 풀-백, 가장자리-엣지, inset/tiled/rounded 변종
- 영웅 예산 : 브랜드, 한 헤드 라인, 하나의 지원 문장, 하나 CTA 그룹, 하나의 이미지
- 영웅 카드 없음. 카드만 카드 IS
- 1개의 단면도 당 일: 1개의 목적, 1개의 머리, 1개의 짧은 지원 문장
- 모션: 2-3 의도적인 모션 최소 (입력, 스크롤링, hover/reveal)
- 색상: CSS 변수 정의, 보라색에 흰색 기본을 피, 하나의 악센트 색상 기본
- 복사: 제품 언어는 논평을 디자인하지 않습니다. "30%를 삭제하면 삭제를 계속합니다"
- 아름다운 기본: 구성-첫째, 가장 큰 텍스트로 브랜드, 두 개의 형식표 max, 기본적으로 무색, 첫 번째 뷰 포트로 포스터 문서

**앱 UI 규칙** (클래식 = APP UI):
- Calm 표면 hierarchy, 강한 전기, 몇 가지 색상
- Dense 하지만 읽기, 최소 크롬
- 구성: 기본 작업 공간, 탐색, 이차적 맥락, 한 악센트
- 피: 대쉬보드 카드 모자이크, 두꺼운 국경, 장식적인 gradients, 장식적인 아이콘
- 복사: 유틸리티 언어 — 오리엔테이션, 상태, 행동. mood/brand/aspiration
- 카드 IS가 상호 작용할 때만 카드만
- 영역이 무엇인지 또는 사용자가 할 수있는 것은 섹션 헤드링 ("KPI 선택", "Plan status")

**우주 규칙** (ALL 유형에 적용):
- CSS 변수를 정의하여 색상 시스템
- 기본 글꼴 스택 없음 (Inter, Roboto, Arial, system)
- 1개의 일 단면도 당
- "보내기의 30 %를 삭제하면 삭제를 계속합니다"
- 카드는 존재를 적립 — 장식 카드 그리드
- NEVER 사용 작은, 낮은 대조 유형 (체 텍스트 < 16px 또는 대조 비율 < 4.5:1 몸 원본에)
- NEVER는 상표 (주사 상표 본 - 상표는 분야가 내용이 있을 때 눈에 보일 것을 나타냅니다)
- ALWAYS 보존은 대 비견적 링크 (방문 링크는 다른 색상을 가지고 있어야 함)
- NEVER 단락 사이 부유물 머리말 (머리가 단면도에 가깝게 그것 소개되어야 합니다)

**AI 슬로프 블랙리스트** (크림 "AI-generated")의 10 패턴 :
1. Purple/violet/indigo gradient 배경 또는 파란에 자주색 색깔 계획
2. **3 열 특징 격자:** 아이콘 - 인 컬러 - 크리클 + 대담한 제목 + 2 선 묘사, 반복된 3x 대칭으로. THE 가장 인식할 수 있는 AI 배치.
3. 섹션 장식으로 색의 원에 아이콘 (SaaS 스타터 템플릿 보기)
4. 모든 헤드에 모든 것을 중심으로 (`text-align: center`, 설명, 카드)
5. 모든 요소에 균일 한 bubbly 국경 반경 (모든 모든 것에 큰 반경)
6. 장식적인 blobs, 뜨 원형, wavy SVG 분배자 (단면이 빈 느낌을, 그것 필요로 합니다 더 나은 내용, 훈장)
7. 디자인 요소로 Emoji (머리에 있는 로켓, 탄알 점으로 이모티콘)
8. 카드에 왼쪽 국경을 색으로 (`border-left: 3px solid <accent>`)
9. 일반 영웅 복사 ("Welcome to [X]", "잠금 해제의 힘...", "당신의 모든 하나 솔루션 ...")
10. 쿠키 커터 섹션 리듬 (hero → 3 기능 → 평가 → 가격 → CTA, 모든 섹션 같은 높이)
11. PRIMARY display/body font - "나는 태전" 신호에 포기했다. 실제 typeface를 선택합니다.

출처: [OpenAI "Designing Delightful Frontends with GPT-5.4"](https://developers.openai.com/blog/designing-delightful-frontends-with-gpt-5-4) (Mar 2026) + gstack 디자인 방법론.
- "카드 아이콘" → 모든 SaaS 템플릿에서 이러한 차별화?
- "Hero section" → 이 영웅은 THIS 제품처럼 느껴지는 것?
- "Clean, 현대 UI" → 의미없는. 실제 디자인 결정과 대체.
- " 위젯과 함께 돌리 보드" →이 NOT 모든 다른 대시 보드?
AI slop blacklist 위에서 시각적으로 생성된 경우, AI slop blacklist에 대해 평가합니다. Read tool을 사용하여 각 조업 이미지를 읽으십시오. 조업은 일반 패턴 (3-column grid, 중심 영웅, 재고 사진 느낌)으로 떨어졌습니까? 그렇다면 `$D iterate --feedback "..."`를 통해 더 구체적인 방향으로 재생하고 제안하십시오. **STOP.** AskUserQuestion는 문제 당 한 번에. NOT 배치를 하십시오. 추천 + <5/>

## 패스 5: 디자인 시스템 정렬 비율 0-10: 계획은 DESIGN.md과 일치합니까? FIX TO 10: DESIGN.md가 존재하는 경우, 특정 토큰/components과 일치합니다. DESIGN.md가 없다면, 간격을 플래그하고 `/design-consultation`를 추천합니다. 새로운 구성 요소를 플래그하십시오. 기존의 어휘에 맞는 것입니까? **STOP.** AskUserQuestion는 문제 당 한 번. NOT 배치 NOT.

## 패스 6: 책임 & 접근성 비율 0-10: 계획은 mobile/tablet, keyboard nav, screen readers? FIX TO 10: 뷰포트 당 응답 사양을 추가합니다. "모바일에서 태우는"하지만 의도적 레이아웃 변경. a11y: keyboard nav 패턴, ARIA 랜드마크, 터치 대상 크기 (44px min), 색상 대조 요구 사항. **STOP.** AskUserQuestion <7/> <7/> <7/> 배치 당 <7> <7> <7>.

## Pass 7: Unresolved Design Decisions 표면 주변의 구현을 끊을 것이다:
```
  DECISION NEEDED              | IF DEFERRED, WHAT HAPPENS
  -----------------------------|---------------------------
  What does empty state look like? | Engineer ships "No items found."
  Mobile nav pattern?          | Desktop nav hides behind hamburger
  ...
```
만약 시각적인 조업이 단계 0.5에서 생성된다면, 의심의 여지없이 결심을 끄는 경우를 참조하세요. 조업은 콘크리트를 결정합니다. 예를 들어, "당신의 승인된 조업은 사이드바를 보여줍니다. 하지만, 계획은 모바일 행동을 지정하지 않습니다. 375px의 이 사이드바에 무슨 일이 있었습니까? 각 결정 = 하나 AskUserQuestion 권장 + WHY + 대안. 이 플랜을 수정하여 각 결정의 계획을 수정합니다.

### Post-Pass: Mockups 업데이트 ( 생성된 경우)

단계 0.5에서 생성 된 경우 리뷰는 상당한 디자인 결정 (정보 아키텍처 재구성, 새로운 상태, 레이아웃 변경)을 변경하여 재생산 (하나 샷, 루프가 아닌)을 제공합니다.

AskUserQuestion: "검토는 변경된 [list 메이저 디자인 변경]. 업데이트 된 계획을 반영하기 위해 조업을 재생하려면 저를 원하십니까? 이것은 우리가 실제로 구축하는 것을 시각적 참조 일치를 보장합니다."

예, `$D iterate`를 사용하여 피드백을 요약하면 변경 사항 또는 `$D variants`를 업데이트 된 간단한 설명으로 사용합니다. `$_DESIGN_DIR` 디렉토리와 동일하게 저장하십시오.

## CRITICAL RULE — 질문은 위에 Preamble에서 AskUserQuestion 형식을 따르는 방법. 계획 디자인 리뷰를 위한 추가 규칙:
* **하나의 문제 = 하나 AskUserQuestion 호출.** 여러 가지 문제를 하나의 문제로 결합하지 마십시오.
* 디자인 간격을 구체적으로 설명합니다 — 누락된 것은, 사용자가 지정하지 않는 경우에 경험할 것입니다.
* 현재 2-3 옵션. 각: 지금 지정하는 노력, 적격한 경우 위험.
* **위에 디자인 원리에 지도.** 특정 원칙에 대한 권고를 연결 한 문장.
* 문제 NUMBER + 옵션 LETTER (예: "3A", "3B").
* **Zero 발견 :** 섹션이 0개의 발견이 있는 경우, 국가 "문제가 없습니다."를 진행하고 진행합니다. 그렇지 않으면 각 간격의 AskUserQuestion를 사용하며, "obvious fix"의 간격은 여전히 갭이며, 여전히 플랜의 변화 토지 전에 사용자 승인을 필요로 합니다.
* **NEVER는 AskUserQuestion를 사용하여 사용자가 선호하는 것을 요구합니다.** 항상 비교 보드를 먼저 만들 (`$D compare --serve`) 브라우저에서 열 수 있습니다. 보드는 제어, 의견, remix/regenerate 버튼 및 구조화 된 피드백 출력을 평가했습니다. AskUserQuestion ONLY를 사용하여 사용자가 보드를 열고 완료 할 때까지 기다리십시오. 현재 변형이 인라인을 표시하지 않고 "당신이 선호합니까?"라는 데미지 않은 경험입니다.

## 필수 산출

## "NOT in 범위" 섹션 디자인 결정은 각각 한 줄 합리적으로 간주하고 명시적으로 적습니다.

### "여기있는 것은"섹션 Existing DESIGN.md, UI 패턴, 그리고 플랜이 재사용되어야 하는 구성 요소.

## TODOS.md 업데이트 모든 리뷰 패스가 완료되면, 각 잠재력 TODO 자신의 개별 AskUserQuestion로. 절대 배치 TODOs — 하나 당 질문. 절대 침묵이 단계를 건너.

디자인 부채: a11y를 누락해, 답답한 행동, 비난한 빈 국가를 녹였습니다. 각 TODO는 얻습니다:
* **이름:** 일의 원라인 설명.
* **왜:** 콘크리트 문제 해결 또는 그것을 잠금 해제.
* **프로 :** 이 일을 해서 얻는 것은 무엇입니까?
* **단점 :** 비용, 복잡성, 또는 그것을 하는 위험.
* **구성 :** 3개월 동안 이를 떠난 누군가가 동기를 이해하는 데 필요한 세부 사항.
* **/에 따라 달라집니다:** 모든 필수품.

그런 다음 현재 옵션 : **A)** TODOS.md **B) (아)** Skip에 추가 - 충분히 값이 좋지 않은 **C) (아)** 이 PR 대신 deferring.

## 구현 작업

이 검토를 닫기 전에, 빌드 액션 작업의 플랫 목록으로 위의 결과를 종합. 특정 검색에서 각 작업 파생 - 패딩 없음. 마크 다운 섹션을 이동 AND JSONL 단계 전반에 걸쳐 집계 할 수 있음을 `/autoplan` 식을 작성.

## Markdown 단면도 (직접 방출)

```markdown
## Implementation Tasks
Synthesized from this review's findings. Each task derives from a specific
finding above. Run with Claude Code or Codex; checkbox as you ship.

- [ ] **T1 (P1, human: ~2h / CC: ~15min)** — <component> — <imperative title>
  - Surfaced by: <section name> — <specific finding text or line reference>
  - Files: <paths to touch>
  - Verify: <test command or manual check>
- [ ] **T2 (P2, human: ~30min / CC: ~5min)** — ...
```

규칙:
- P1 구획 배; P2는 동일한 branch를 착륙해야 합니다; P3는 후속 TODO입니다.
- 작업이 작동하지 않는 것을 발견하면, 한 번 발명하지 마십시오.
- 섹션이 0개의 발견을 가지고 있다면, `_No new tasks from <section>._`를 방출
- Effort는 AI-압축 테이블을 CLAUDE.md에서 사용합니다.

## JSONL artifact (직접 쓰기, 0 작업 경우에도)

`/autoplan`는 단계의 골재에 이 파일을 읽습니다. 각 선을 `jq -nc`로 구축하여 인용, 신라인, 또는 backslashes serialize를 포함하는 원본과 근원 발견하십시오 - 결코 손으로 구른 `echo`/`printf`를 사용하지 마십시오.

```bash
eval "$(~/.claude/skills/gstack/bin/gstack-slug 2>/dev/null)"
TASKS_DIR="${HOME}/.gstack/projects/${SLUG:-unknown}"
mkdir -p "$TASKS_DIR"
TASKS_FILE="$TASKS_DIR/tasks-design-review-$(date +%Y%m%d-%H%M%S).jsonl"
COMMIT=$(git rev-parse HEAD 2>/dev/null || echo unknown)
BRANCH=$(git branch --show-current 2>/dev/null || echo unknown)
RUN_ID="$(date -u +%Y%m%dT%H%M%SZ)-$$"

# Repeat ONE jq invocation per task identified during this review.
# Substitute the placeholders inline with shell variables you set per task:
#   TASK_ID (T1, T2, ...), PRIORITY (P1/P2/P3), COMPONENT, TITLE,
#   SOURCE_FINDING, EFFORT_HUMAN, EFFORT_CC, FILES_JSON (a JSON array literal
#   like '["browse/src/sanitize.ts","browse/src/server.ts"]').
jq -nc \
  --arg phase 'design-review' \
  --arg run_id "$RUN_ID" \
  --arg branch "$BRANCH" \
  --arg commit "$COMMIT" \
  --arg id "$TASK_ID" \
  --arg priority "$PRIORITY" \
  --arg component "$COMPONENT" \
  --arg effort_human "$EFFORT_HUMAN" \
  --arg effort_cc "$EFFORT_CC" \
  --arg title "$TITLE" \
  --arg source_finding "$SOURCE_FINDING" \
  --argjson files "$FILES_JSON" \
  '{phase:$phase, run_id:$run_id, branch:$branch, commit:$commit, id:$id, priority:$priority, component:$component, files:$files, effort_human:$effort_human, effort_cc:$effort_cc, title:$title, source_finding:$source_finding}' \
  >> "$TASKS_FILE"
```

`jq`가 설치되지 않은 경우, JSONL 쓰기를 건너 뛰기 위하여 넘어가고 autoplan 집계를 위한 jq를 설치하기 위하여 사용자를 경고합니다. 절대로 손 목록 JSONL.

이 리뷰에서 0개의 작업을 확인한 경우, 여전히 JSONL 파일 (`: > "$TASKS_FILE"`)를 터치하여, 이 런닝을 출력하는 단계가 있음을 알 수 있습니다. (비어 있는 파일은 "ran, no finds"를 의미합니다. "didn't run"에서 구별하지 않습니다.)


### 완료 요약
```
  +====================================================================+
  |         DESIGN PLAN REVIEW — COMPLETION SUMMARY                    |
  +====================================================================+
  | System Audit         | [DESIGN.md status, UI scope]                |
  | Step 0               | [initial rating, focus areas]               |
  | Pass 1  (Info Arch)  | ___/10 → ___/10 after fixes                |
  | Pass 2  (States)     | ___/10 → ___/10 after fixes                |
  | Pass 3  (Journey)    | ___/10 → ___/10 after fixes                |
  | Pass 4  (AI Slop)    | ___/10 → ___/10 after fixes                |
  | Pass 5  (Design Sys) | ___/10 → ___/10 after fixes                |
  | Pass 6  (Responsive) | ___/10 → ___/10 after fixes                |
  | Pass 7  (Decisions)  | ___ resolved, ___ deferred                 |
  +--------------------------------------------------------------------+
  | NOT in scope         | written (___ items)                         |
  | What already exists  | written                                     |
  | TODOS.md updates     | ___ items proposed                          |
  | Approved Mockups     | ___ generated, ___ approved                  |
  | Decisions made       | ___ added to plan                           |
  | Decisions deferred   | ___ (listed below)                          |
  | Overall design score | ___/10 → ___/10                             |
  +====================================================================+
```

모든 패스 8 +: "플랜은 디자인 완료. /design-review를 실행한 후 QA를 실행합니다. 8 미만인 경우: 해결되지 않은 이유와 왜 (사용자가 defer를 선택했습니다).

### Unresolved Decisions if any AskUserQuestion unanswered, 여기에 주의. 절대로 기본적으로 옵션.

### 승인된 Mockups

이 리뷰에서 시각적 모멘트가 생성된 경우, 플랜 파일에 추가:

```
## Approved Mockups

| Screen/Section | Mockup Path | Direction | Notes |
|----------------|-------------|-----------|-------|
| [screen name]  | ~/.gstack/projects/$SLUG/designs/[folder]/[filename].png | [brief description] | [constraints from review] |
```

각 승인된 조업 (사용자가 선택한 변종)에 대한 전체 경로 포함, 방향의 한 줄 설명, 그리고 어떤 제약. 이 구현자는 정확히 어떤 시각에서 빌드를 알고. 이 대화와 작업 영역의 지속. 아무 조업이 생성되지 않은 경우, 이 섹션을 오스트.

## 리뷰 로그

위의 Completion Summary를 생산한 후, 검토 결과를 지속합니다.

**PLAN MODE EXCEPTION — ALWAYS RUN:** 이 명령은 메타데이터를 `~/.gstack/` (사용자 설정 디렉토리, 프로젝트 파일이 아닙니다)로 작성합니다. 기술 preamble은 이미 `~/.gstack/sessions/` 및 `~/.gstack/analytics/`로 작성합니다. 이 리뷰 대쉬보드는 이 데이터에 달려 있습니다. 이 명령을 건너는 것은 /ship의 검토 readiness 대쉬보드를 끊습니다.

```bash
~/.claude/skills/gstack/bin/gstack-review-log '{"skill":"plan-design-review","timestamp":"TIMESTAMP","status":"STATUS","initial_score":N,"overall_score":N,"unresolved":N,"decisions_made":N,"commit":"COMMIT"}'
```

Completion Summary의 값을 대체합니다.
- **TIMESTAMP**: 현재 ISO 8601 가동 시간
- **STATUS**: "클린" 전체 점수 8+ AND 0에 녹지 않는 경우에; 그렇지 않으면 "issues_open"
- **초기_score**: 고치기 전에 처음 전반적인 디자인 점수 (0-10)
- **전체_score**: 수정 후 최종 전체 설계 점수 (0-10)
- **해결되지 않음**: 해결되지 않은 디자인 결정의 수
- **의향_made**: 계획에 추가된 디자인 결정의 수
- **COMMIT**: `git rev-parse --short HEAD`의 산출

## 리뷰 Readiness 대시보드

검토 완료 후, 검토 로그 및 구성을 읽고 대시보드를 표시합니다.

```bash
~/.claude/skills/gstack/bin/gstack-review-read
```

Parse the output. Find the most recent entry for each skill (plan-ceo-review, plan-eng-review, review, plan-design-review, design-review-lite, adversarial-review, codex-review, codex-plan-review). Ignore entries with timestamps older than 7 days. For the Eng Review row, show whichever is more recent between `review` (diff-scoped pre-landing review) and `plan-eng-review` (plan-stage architecture review). Append "(DIFF)" or "(PLAN)" to the status to distinguish. Adversarial 행의 경우, `adversarial-review` (새로운 자동 확장)과 `codex-review` (아직) 사이에 더 최근 더 많은 것을 보여주는 보여줍니다. 디자인 검토를 위해, `plan-design-review` (전체 시각 감사)와 `design-review-lite` (코드 레벨 체크) 사이에서 더 최근 더 최근 더 많은 것을 보여줍니다. "(FULL)"또는 "(LITE)"를 상태에 명시하십시오. 외부 음성 행의 경우, 가장 최근 /plan-ceo-review (이번 입력된 /plan-ceo-review)를 표시합니다.

**근원 attribution:** 기술에 가장 최근의 항목이 \`"via"\` 필드를 가지고 있다면, 부모의 상태 라벨에 부합합니다. 예: `plan-eng-review` 와 `via:"autoplan"` 쇼는 CLEAR (PLAN 를 통해 /autoplan)"으로 보여줍니다. `review` 와 `via:"ship"` 는 CLEAR (DIFF 를 통해 /ship)" 를 보여줍니다. `via` (CLEAR) 의 `via` (CLEAR) 를 보여주기 전에 `via` 를 보여주십시오.

참고: `autoplan-voices` 및 `design-outside-voices` 항목은 감사철 전용 (크로스 모델 합의 분석을위한 법의 데이터)입니다. 그들은 대시보드에 나타나지 않으며 어떤 소비자가 검사하지 않습니다.

전시:

```
+====================================================================+
|                    REVIEW READINESS DASHBOARD                       |
+====================================================================+
| Review          | Runs | Last Run            | Status    | Required |
|-----------------|------|---------------------|-----------|----------|
| Eng Review      |  1   | 2026-03-16 15:00    | CLEAR     | YES      |
| CEO Review      |  0   | —                   | —         | no       |
| Design Review   |  0   | —                   | —         | no       |
| Adversarial     |  0   | —                   | —         | no       |
| Outside Voice   |  0   | —                   | —         | no       |
+--------------------------------------------------------------------+
| VERDICT: CLEARED — Eng Review passed                                |
+====================================================================+
```

**리뷰 계층:**
- **Eng Review (기본적으로 필요):** 문 발송하는 유일한 검토. 건축술, 코드 질, 시험, 성과 커버하십시오. \`gstack-config set skip_eng_review true\` (" 두번 저" 조정)에 전 세계적으로 비활성화될 수 있습니다.
- **CEO (선택) 검토:** 당신의 판단을 사용하십시오. 큰 제품/business 변경, 새로운 사용자 직면 특징, 또는 범위 결정에 그것을 추천합니다. 버그 수정, 재공장, 인프라 및 정리를 위해 건너 뛰십시오.
- **디자인 검토 (선택):** 당신의 판단을 사용하십시오. UI/UX 변경을 위해 그것을 추천하십시오. 배경 전용, 적외선, 또는 신속한 단지 변화를 위해 건너 뛰십시오.
- **Adversarial 검토 (자동):** 항상 모든 리뷰에 대 한. 모든 디프는 Claude adversarial subagent와 Codex adversarial 도전을 모두 얻을. 큰 디프 (200 + 라인) 추가로 얻을 Codex 구조화 검토와 P1 문. 필요 구성 없음.
- **외부 음성 (선택):** Codex가 유효할 때 다른 AI 모형에서 독립적인 계획 검토는 ( 동일한 가족 Claude subagent에 뒤에 가십시오 그렇지 않으면 — 신선한 컨텍스트, 십자가 모형 아닙니다). /plan-ceo-review 및 /plan-eng-review에서 완전한 모든 검토 단면도 후에 제안해. 선박을 결코 문이 아닙니다.

**Verdict 논리:**
- **CLEARED**: Eng Review has >= 1 항목 이내에 7 일 이내에 \`review\` 또는 \`plan-eng-review\` 상태 "클린" (또는 \`skip_eng_review\`는 \`true\`)
- **NOT CLEARED**: 잉여된 잉여, stale (>7일), 또는 문제점을 열지
- CEO, 디자인, Codex 리뷰는 상황에 따라 표시되지만 배송을 막지 못합니다.
- \`skip_eng_review\` 설정은 \`true\`, Eng Review show "SKIPPED (global)"이며 verdict는 CLEARED입니다.

**Staleness 탐지:** 대시보드를 표시한 후, 기존 리뷰가 stale일 수 있는 경우 확인:
- **내용-첫 번째 규칙 (디프스코프 행만: \`review\`, \`adversarial-review\`, \`codex-review\`, 배 단계 항목).** \`---WTREE---\`와 \`---DIRTY---\` bash 출력에서 섹션을 파. 항목이 \`wtree\` 필드 AND가 있는 경우 현재 \`---WTREE---\` 값과 동일하게 검토는 CURRENT - 동일한 내용, 커밋, 수정, 수정 또는 아직 (이렇게 equality 혼자 동일한 내용을 증명하는지 여부, 즉, 키스톤 속성). 그 항목에 대한 커밋 통계를 건너 뛰고 staleness 참고를 표시하십시오.
- 플랜티티티 행 (플랜티-세로-리뷰, 플랜-세리뷰) 플랜티 파일 등급, 리포 트리가 적용되지 않음 - 그에 대한 wtree 규칙을 적용하지 않습니다. 7일의 신선도 논리를 유지합니다. 이러한 항목은 \`plan_sha256\` 필드를 운반하면, 현재 플랜 파일의 sha256과 메모 "플랜 변경 이후"에 비교합니다.
- 가을 (no \`wtree\` on the entry, or wtree mismatch): \`---HEAD---\` 섹션을 파로 현재 HEAD 커밋 해시를 얻기 위해. 각 리뷰 항목에 대한 \`commit\` 필드가 있습니다: 현재의 HEAD에 대해 비교합니다. 다른 경우, elapsed commits: \`git rev-list --count STORED_COMMIT..HEAD\`를 계산하십시오. FAILS (저장된 커밋은 다시 시작되었습니다), UNKNOWN (저장된 커밋은 ")"는 {nl/> (저스트)에서 "nl"로 요약합니다.
- \`commit\` 필드가 없는 항목에 대해서는, "주의: {skill} 리뷰는 {date}에서 아무런 커밋트 추적이 없습니다. 정확한 staleness 탐지를 위해 다시 실행해야 합니다."
- 모든 리뷰 등급 CURRENT (위트 일치 또는 HEAD 일치), 어떤 staleness 메모 표시하지 않는 경우

## 계획 파일 검토 보고서

검토 읽기 후 Dashboard 대화 출력에서, 또한 업데이트 **계획 파일** 자체 그래서 검토 상태는 누구에게 계획을 읽는 것으로 볼 수 있습니다.

### 플랜 파일을 검색

1. 이 대화에서 활동 계획 파일이 있는지 확인 (주 호스트는 계획 파일을 제공합니다)
   시스템 메시지의 경로 — 대화 상황에 계획 파일 참조를 찾습니다.
2. 발견되지 않은 경우,이 섹션을 침묵적으로 건너 뛰기 — 모든 리뷰는 계획 모드에서 실행되지 않습니다.

### 보고서 생성

검토 로그 출력을 읽으십시오. 이미 리뷰 Readiness Dashboard 단계에서 있습니다. 각 JSONL 항목에 파십시오. 각 기술 로그는 다른 필드를 기록합니다.

- **플랜 일람**: \`status\`, \`unresolved\`, \`critical_gaps\`, \`mode\`, \`scope_proposed\`, \`scope_accepted\`, \`scope_deferred\`, \`commit\`
  → 찾기 : "{scope_제안됨_accepted} 허용, {scope_deferred} deferred" → 범위 필드가 0 또는 누락된 경우 (HOLD/REDUCTION 모드): "mode: {mode}, {critical_gaps} 중요 간격"
- **플랜 일람**: \`status\`, \`unresolved\`, \`critical_gaps\`, \`issues_found\`, \`mode\`, \`commit\`
  → 찾기 : "{issues_발견됨_gaps} 중요한 간격"
- **플랜트-디자인-리뷰**: \`status\`, \`initial_score\`, \`overall_score\`, \`unresolved\`, \`decisions_made\`, \`commit\`
  → 찾기: "스코어: {initial_점수}/10 → {overall_score}/10, {decisions_made} 결정"
- **플랜-devex-review**: \`status\`, \`initial_score\`, \`overall_score\`, \`product_type\`, \`tthw_current\`, \`tthw_target\`, \`mode\`, \`persona\`, \`competitive_tier\`, \`unresolved\`, \`commit\`
  → 찾기: "스코어: {initial_점수}/10 → {overall_score}/10, TTHW: {tthw_현재} → {tthw_target}"
- **딕스 - 리뷰**: \`status\`, \`overall_score\`, \`product_type\`, \`tthw_measured\`, \`dimensions_tested\`, \`dimensions_inferred\`, \`boomerang\`, \`commit\`
  → 찾기 : "스코어 : {overall_점수}/10, TTHW: {tthw_측정}, {dimensions_테스트됨: 테스트/{dimensions_inferred} inferred"
- **코엑스-리뷰**: \`status\`, \`gate\`, \`findings\`, \`findings_fixed\`
  → 찾기 : "{findings} 찾기, {findings_fixed}/{findings} 고정"

Findings 칼럼에 필요한 모든 필드는 이제 JSONL 항목에 있습니다. 리뷰에 대해 완료된 경우, 자신의 Completion Summary에서 부자 세부 정보를 사용할 수 있습니다. 사전 리뷰의 경우 JSONL 필드를 직접 사용하십시오. 필요한 모든 데이터를 포함합니다.

이 markdown 테이블을 생성하십시오:

\`\`\`markdown ## GSTACK REVIEW REPORT

| Review | Trigger의 | 이유 | Runs | Status | 의논하기 |
|--------|---------|-----|------|--------|----------|
| CEO 리뷰 | \`/plan-ceo-review\` | 범위 및 전략 | ... | {status} | {findings} |
| Codex 리뷰 | \`/codex review\` | 독립 제 2의 의견 | ... | {status} | {findings} |
| Eng 검토 | \`/plan-eng-review\` | 건축 및 테스트 (필수) | ... | {status} | {findings} |
| 디자인 리뷰 | \`/plan-design-review\` | UI/UX 간격 | ... | {status} | {findings} |
| DX 리뷰 | \`/plan-devex-review\` | 개발자 경험 gaps | ... | {status} | {findings} |
\`\`\`

테이블 아래,이 라인을 추가합니다. **CODEX** 및 **CROSS-MODEL**는 선택 사항입니다 (비어있을 때 미트); **VERDICT**는 항상 존재합니다:

- **CODEX:** (Codex-review ran만) - 코덱 수정의 한 줄 요약
- **CROSS-MODEL:** (Claude와 Codex 리뷰가 모두 있으면) - 오버랩 분석
- **VERDICT:** 목록 리뷰는 CLEAR (예: "CEO + ENG CLEARED - 구현 준비)입니다.
  만약 Eng Review가 CLEAR이 아닌 글로벌로 건너뛰지 않는다면, "eng review required"를 추가한다.

**해결되지 않은 절제 상태 (MANDATORY — 결코 무효; 보고서의 최종 비-whitespace 라인).** VERDICT 후, 보고서를 종료 (`## GSTACK REVIEW REPORT\` 헤더 - 대담한 라벨, 새로운 \`## \` 헤더; 정확히 한 "오미트" 규칙)과 정확히 한 번에 제외 : 정확한 unbolded line \`NO UNRESOLVED DECISIONS\` (대략한 것은 NOT 카운트), OR a \`**UNRESOLVED DECISIONS:**\` 헤더 + 열선 당 하나의 총알 (마지막 선 = 마지막 선; 마지막 선; \`+ N unresolved from prior reviews\`만 N > 0일 때만 추가합니다. 이 두 배 위탁을 피합니다: 목록 THIS는 문맥에서 열린 품목을 검토합니다; 이전 리뷰 합계를 위해 \`unresolved\`는 기술 당 최신 신선한 줄에 (dashboard 7 일 창) 당신이 DROP 현재 기술의 줄 후에; 둘 다 0일 때만 sentinel를 방출합니다.

### 계획 파일에 쓰기

**PLAN MODE EXCEPTION — ALWAYS RUN:** 이 플랜 파일에 쓰여져 플랜 모드로 편집할 수 있는 파일입니다. 플랜 파일 리뷰 보고서는 플랜의 생활 상태의 일부입니다.

보고서는 항상 계획 파일의 LAST 섹션이어야 합니다. - 결코 중간 파일. 단일 삭제-그 다음-부드 흐름을 사용하십시오.

1. 전체 현재 내용을 보려면 계획 파일 (읽기 도구)를 읽으십시오. 읽기
   파일에 있는 `## GSTACK REVIEW REPORT\`를 위해 출력하는.
2. 발견되면, 편집 도구를 DELETE 전체의 기존 섹션에 사용합니다.
   \`## GSTACK REVIEW REPORT\` 를 통해 다음 \`## \` 를 통해 먼저 나온 파일의 끝을 머리에 넣거나, 빈 문자열로 대체합니다. 이 부분은 현재 영역의 부분과 관계없이 적용됩니다. - 중간 파일 삭제는 의도적, 특별한 경우 아닙니다. 편집이 실패하면 (예 : 동시 편집은 내용을 변경), 계획 파일 및 재시를 다시 한번 다시 읽습니다.
3. 삭제 후 (또는 건너뛰기, 어떤 섹션이 존재하지 않는 경우), 새 추가
   \`## GSTACK REVIEW REPORT\` 파일의 END 섹션. 파일의 현재 마지막 단락과 섹션을 추가하려면 편집 도구를 사용하여, 또는 끝에 섹션을 전체 파일을 다시 시작 씁니다.
4. \`## GSTACK REVIEW REPORT\`가 마지막 것 같은 읽기 도구로 정의
   \`## \` 계속하기 전에 파일에 두기. 그것이 아니라면 반복 단계 2-3를 한 번 반복하십시오.

NOT는 장소에 있는 부분을 대체합니다. 이전 보고서가 이미 살 때 "파일을 바꾸는" 경로는 이전 버전이 이전의 보고서를 남겨두기 전에 허용됩니다. 사용자는 그 후, 검토 보고서가 바닥에 있지 않은 계획을 볼 수 있습니다 (현재).

# 캡처 학습

이 세션 중 비 명백한 패턴, pitfall, 또는 건축 통찰력을 발견하면 향후 세션에 로그인하십시오.

```bash
~/.claude/skills/gstack/bin/gstack-learnings-log '{"skill":"plan-design-review","type":"TYPE","key":"SHORT_KEY","insight":"DESCRIPTION","confidence":N,"source":"SOURCE","files":["path/to/relevant/file"]}'
```

**유형:** `pattern` (재사용 가능한 접근), `pitfall` (일 NOT), `preference` (사용자 명시), `architecture` (구 결정), `tool` (library/framework 통찰력), `operational` (프로젝트 environment/CLI/workflow 지식).

**근원:** `observed` (코드에서 이것을 발견했습니다), `user-stated` (사용자가 당신을 말했습니다), `inferred` (AI 감응작용), `cross-model` (Claude 및 Codex 동의).

**구성:** 1-10. 정직. 코드를 확인한 관찰 패턴은 8-9입니다. 의도적으로는 4-5입니다. 명시적으로 명시된 사용자 선호도는 10입니다.

**파일 :** 이 학습 참조를 특정 파일 경로 포함. 이 활성화 staleness 검출: 그 파일이 나중에 삭제되면, 학습은 떨어질 수 있습니다.

**로그인 하세요.** 분명한 것들을 로그하지 마십시오. 이미 사용자를 알 수 없습니다. 좋은 테스트 :이 통찰력은 향후 세션에서 시간을 절약 할 것인가? 예, 로그.



## 뇌 교정 쓰기 백 (상 2 / 문)

기술이 추적하는 유형의 예측을 할 때 (경찰 결정, TTHW 대상, 건축 베팅, 쐐기 약속), 그것은 MAY는 `kind=bet`를 씁니다 뇌에 이렇게 구경측정 단면도는 시간 이상 건설합니다.

**두 가지에 갇혀 :**
1. 활성 엔드포인트의 두뇌 신뢰 정책은 `personal` (을 통해 확인
   `~/.claude/skills/gstack/bin/gstack-config get brain_trust_policy@<endpoint-hash>`). 공유 뇌는 투표 팀 교정을 피하기 위해 쓰기 등을 건너 뛰고 있습니다.
2. 기능 플래그 `BRAIN_CALIBRATION_WRITEBACK` 설정 (일: false; 플립
   gbrain v0.42+가 `takes_add` MCP op)를 발송할 때 true에.

양쪽 게이트 패스가 모두되면, 쓰기 백 경로는 `mcp__gbrain__takes_add`를 사용하여 무게 0.5 (SKILL_CALIBRATION_WEIGHTS당)로 가져갑니다. MCP op가 사용되지 않는 경우 `mcp__gbrain__put_page` 와 gstack:takes Fence block (documented but uglier path)로 다시 떨어졌습니다.

필수 입력 frontmatter 모양:
```yaml
kind: bet
holder: <user identity from whoami>
claim: <one-line prediction the skill is making>
weight: 0.5
since_date: <today's date>
expected_resolution: <date in 1-3 months depending on skill>
source_skill: plan-design-review
```

쓰기 후, 영향을받은 소화를 무효하여 다음의 preflight는 새로운 상태를 반영합니다.

```bash
eval "$(~/.claude/skills/gstack/bin/gstack-slug 2>/dev/null)" 2>/dev/null || true
  ~/.claude/skills/gstack/bin/gstack-brain-cache invalidate brand --project "$SLUG" 2>/dev/null || true
```


## 두뇌 캐시 배경 새로 고침

기술 작업이 완료되면 (그리고 원격 측정은 로그온), 킥은 어떤 캐시 다이제스트의 재생을 재생하는 것은 그것의 TTL. 이것은 비 차단입니다 - 사용자는 기다릴 수 없습니다. 다음 호출은 따뜻한 캐시에서 혜택을 제공합니다.

```bash
eval "$(~/.claude/skills/gstack/bin/gstack-slug 2>/dev/null)" 2>/dev/null || true
(~/.claude/skills/gstack/bin/gstack-brain-cache refresh --project "$SLUG" 2>/dev/null &) || true
```


## 다음 단계 — 체인링 검토

검토 읽기보기 Dashboard를 표시 한 후,이 디자인 검토가 발견 된 것을 기반으로 다음 검토 (들)를 권장합니다. 리뷰가 이미 실행되고 있는지 여부를 볼 수있는 대시보드 출력을 읽으십시오.

**eng 검토가 전 세계적으로 건너지지 않는 경우 /plan-eng-review를 추천하십시오.** - `skip_eng_review`의 대시보드 출력을 확인합니다. `true`인 경우, eng 검토가 선택되지 않습니다. 그렇지 않으면, eng 검토는 필수 배송 게이트입니다. 이 디자인 검토가 중요한 상호 작용 사양을 추가하면, 새로운 사용자 흐름 또는 정보 아키텍처를 변경하면, eng 검토가 건축적 의미를 검증해야 합니다. eng 검토 이미 존재하지만 커밋 해시가이 디자인 검토를 미리 보여 주면 stale이 될 수 있으며 다시 실행해야합니다.

**추천하는 것 /plan-ceo-review** — 하지만 이 디자인 검토가 기본 제품 방향 격차를 밝혀졌다면. 특히: 전체 설계 점수가 4/10 이하로 시작된 경우, 정보 아키텍처가 주요 구조 문제가 발생하거나, 올바른 문제 해결 여부에 대한 검토 표면적 질문을했다면. AND no CEO review 가 대시보드에 존재한다. 이것은 선택적 권장 사항입니다. 대부분의 디자인 리뷰는 NOT 트리거 CEO 검토.

**모두 필요하다면 eng 리뷰를 먼저 추천합니다.** (필수 문).

**적절한 경우 디자인 탐험 능력을 추천** - /design-shotgun 및 /design-html는 디자인 artifacts (mockups, HTML 시사)를, 신청 코드 아닙니다 생성합니다. 그들은 계획 형태에 안쪽에 속합니다 리뷰. 이 디자인 검토가 새로운 방향을 탐구하는 것을 찾은 시각적인 문제점이 발견한 경우에, 추천합니다 /design-shotgun. 승인한 모조가 존재하고 일 HTML로 돌릴 필요가 있는 경우에, 추천하십시오 /design-html.

AskUserQuestion를 사용하여 다음 단계에 제시합니다. 적용 가능한 옵션만 포함하십시오.
- **A)** 실행 /plan-eng-review 다음 (필수 문)
- **B) (아)** 실행 /plan-ceo-review (기본 제품 간격이 발견된 경우에만)
- **C) (아)** 실행 /design-shotgun — 발견된 문제점을 위한 시각적인 디자인 변종을 탐구하십시오
- **(주)** 실행 /design-html - 승인된 모조에서 Pretext-native HTML를 생성합니다
- **E)** Skip — 수동으로 다음 단계를 처리할 것입니다.

## 형식 규칙
* NUMBER 문제 (1, 2, 3...) 및 옵션에 대한 LETTERS (A, B, C ...).
* NUMBER + LETTER (예: "3A", "3B").
* 옵션당 최대 1개의 문장.
* 각 통행 후에, 일시 중지 및 의견을 기다리십시오.
* 검사를 위한 각 통행의 앞에 그리고 후에 비율.

