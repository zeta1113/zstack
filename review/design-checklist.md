# 디자인 리뷰 체크리스트 (Lite)

> **DESIGN_METHODOLOGY의 서브셋** - 여기에 항목을 추가 할 때, 또한 `generateDesignMethodology()`를 `scripts/gen-skill-docs.ts`, 그리고 vice versa.

## 지시

이 체크리스트는 **diff의 소스 코드**에 적용되며, 출력을 렌더링하지 않습니다. 각 변경된 frontend 파일 (전체 파일, 그냥 diff hunks) 및 플래그 안티 - 패턴을 읽으십시오.

**방아쇠:** diff가 frontend 파일을 만지지 않으면 체크리스트 만 실행합니다. `gstack-diff-scope`를 사용하여 감지합니다.

```bash
source <(~/.claude/skills/gstack/bin/gstack-diff-scope <base> 2>/dev/null)
```

`SCOPE_FRONTEND=false` 이라면, 전체 디자인 리뷰를 침묵으로 건너 뛰십시오.

**DESIGN.md 구경측정:** `DESIGN.md` 또는 `design-system.md`가 repo 루트에 존재한다면, 먼저 읽어 보세요. 모든 발견은 프로젝트의 명시된 디자인 시스템에 대해 측정됩니다. DESIGN.md에서 명시적으로 축복된 패턴은 NOT 파열입니다. DESIGN.md가 존재하지 않는 경우, 범용 디자인 원칙을 사용합니다.

---

## Confidence Tiers의 특성

각 항목은 탐지 신뢰 수준으로 태그됩니다 :

- **[HIGH]** - grep/pattern 경기를 통해 믿을 수 있는 탐지. 확실한 발견.
- **[MEDIUM]** - 패턴 집계 또는 허리즘을 통해 탐지 할 수 있습니다. 발견으로 플래그는 일부 소음을 기대합니다.
- **[LOW]** - 시각적인 의도를 이해하는 데 필요한. 현재: "Posssible Issue — 시각적으로 또는 실행 /design-review."

---

## 분류

**AUTO-FIX** (기계 CSS만 수정 — HIGH 신뢰, 디자인 판단 필요 없음):
- `outline: none` 교체 없이 → `outline: revert` 또는 `&:focus-visible { outline: 2px solid currentColor; }`를 추가하십시오
- `!important` in new CSS → 특성 제거 및 수정
- `font-size` < 16px on body text → 16px에 범프

**ASK** (다른 것을 이기십시오 — 디자인 판단을 요구합니다):
- 모든 AI 슬로프 발견, 전기 구조, 간격 선택, 상호 작용 국가 간격, DESIGN.md 위반

**LOW 신뢰 아이템** → 현재 "Possible: [description]. 시각적으로 실행하거나 /design-review를 실행하십시오. AUTO-FIX가 아닙니다.

---

## 출력 형식

```
Design Review: N issues (X auto-fixable, Y need input, Z possible)

**AUTO-FIXED:**
- [file:line] Problem → fix applied

**NEEDS INPUT:**
- [file:line] Problem description
  Recommended fix: suggested fix

**POSSIBLE (verify visually):**
- [file:line] Possible issue — verify with /design-review
```

선택 사항: `test_stub` — 프로젝트의 테스트 프레임워크를 사용하여 이 발견을 위한 골격 테스트 코드.

문제가 발견되지 않은 경우: `Design Review: No issues found.`

프론트엔드 파일이 변경되지 않는 경우: 똑똑하게, 출력 없음.

---

## 카테고리

##1. AI 슬로프 검출 (6개 항목) - 가장 높은 우선 순위

AI-generated UI의 이야기는 존중된 스튜디오에서 디자이너가 배를 내지 않는 것입니다.

- **[MEDIUM]** Purple/violet/indigo gradient 배경 또는 파란에 자주색 색깔 계획. `#6366f1`–`#8b5cf6` 범위에 있는 가치와 `linear-gradient`를 위해, 또는 CSS 자주색/violet에 재해하는 주문 재산.

- **[LOW]** 3 열 특징 격자: 아이콘에서 착색된 경적 + 대담한 제목 + 2 선 묘사, 반복된 3x 비대칭. 각을 포함하는 정확하게 3개의 아이들을 가진 grid/flex 콘테이너를 보십시오 원형 성분 + 두는 + 단락.

- **[LOW]** 섹션 장식으로 착색 된 원형에 아이콘. `border-radius: 50%` + 아이콘에 장식 용기로 사용되는 배경 색상을 찾습니다.

- **[HIGH]** 모든 것을 중심: `text-align: center` 모든 머리, 묘사, 카드에. `text-align: center` 조밀도를 위해 윤활 - >60%의 원본 콘테이너 사용 센터 줄맞춤의, 깃발 그것.

- **[MEDIUM]** 각 성분에 획일한 bubbly 국경 반경: 카드, 단추, 입력, 콘테이너에 적용된 동일한 큰 반경 (16px+)는 균등하게 입력합니다. >80%가 동일한 가치 ≥16px를 사용하는 경우에, `border-radius` 가치 -를 분류하십시오.

- **[MEDIUM]** 일반 영웅 복사: "X에 오신 것을 환영합니다", "의 힘을 차단 ...", "당신의 모든 하나 솔루션에 대한...", "당신의...", "당신의 워크플로우를 간소화". 그랩 HTML/JSX 이 패턴에 대한 내용.

##2. 전기 (4개의 품목)

- **[HIGH]** 바디 텍스트 `font-size` < 16px. `font-size` 선언 `p`, `.text`, 또는 기본 스타일. 16px 미만 값 (또는 1rem 때 기본 16px) 조각입니다.

- **[HIGH]** 디프에 소개된 3개 이상의 폰트 제품군. `font-family` 선언을 계산합니다. >3개의 독특한 가족이 변경된 파일에 따라 나타날 경우 플래그를 지정합니다.

- **[HIGH]** 헤드링 계층 건너뛰기 레벨: `h1` `h3` 와 같은 파일/component 의 `h2` 를 제외한 `h3` 를 따랐습니다. HTML/JSX 를 체크하고 태그를 붙입니다.

- **[HIGH]** 블랙리스트 글꼴: Papyrus, Comic Sans, Lobster, Impact, Jokerman. Grep `font-family` 이 이름에 대한.

##3. 스파싱 & 레이아웃 (4 항목)

- **[MEDIUM]** 4px 또는 8px 스케일에 없는 임의 간격 값은 DESIGN.md가 간격 스케일을 지정할 때입니다. `margin`, `padding`, `gap` 값이 명시된 스케일에 대해 확인하십시오. DESIGN.md가 스케일을 정의할 때만 플래그만 지정합니다.

- **[MEDIUM]** 반응형 처리 없이 폭을 고쳤습니다: `max-width` 또는 `@media` 고장 없는 콘테이너에 `width: NNNpx`. 이동할 것이다 수평한 스크롤의 위험.

- **[MEDIUM]** 텍스트 컨테이너에 `max-width` 미스링: `max-width` 을 가진 몸 텍스트 또는 단락 용기, 줄 >75 문자를 허용. 텍스트 래퍼에 `max-width` 을 확인 합니다.

- **[HIGH]** `!important` 의 새로운 CSS 규칙. `!important` 의 추가 라인에 대한 Grep. 거의 항상 특정 탈출 해치가 제대로 고정되어야합니다.

##4. 상호 작용 미국 (3개의 품목)

- **[MEDIUM]** 대화형 요소 (버튼, 링크, 입력) 누락된 hover/focus 주. `:hover` 및 `:focus` 또는 `:focus-visible` 가짜 클래스가 새로운 대화형 요소 스타일에 존재하면 확인.

- **[HIGH]** `outline: none` 또는 `outline: 0` 교체 초점 지시자 없이. `outline:\s*none` 또는 `outline:\s*0`를 위한 윤활. 이것은 키보드 접근가능성을 제거합니다.

- **[LOW]** 터치 대상 < 44px on interactive elements. `min-height`/`min-width`/`padding` 버튼과 링크. 여러 속성에서 컴파일 유효 크기를 요구한다 — 코드에서 낮은 신뢰 혼자.

##5. DESIGN.md 위반 (3개의 품목, 조건부)

`DESIGN.md` 또는 `design-system.md`가 존재하는 경우만 적용한다.

- **[MEDIUM]**는 명시된 팔레트에 있지 않습니다. DESIGN.md에서 정의된 팔레트에 대해 CSS를 변경한 색상 값과 비교합니다.

- **[MEDIUM]** 명시된 타이포그래피 섹션에 있지 않는 글꼴. DESIGN.md의 글꼴 목록에 대한 `font-family` 값과 비교.

- **[MEDIUM]** 명시된 스케일 밖에서 값을 간격으로 넣으십시오. `margin`/`padding`/`gap` 값을 DESIGN.md의 간격 스케일에 비교하십시오.

---

## 억제

NOT 플래그를 수행하십시오:
- DESIGN.md에서 의도적인 선택으로 명시적으로 문서화
- 제3자/vendor CSS 파일 (node_modules, 공급 업체 디렉토리)
- CSS 리셋 또는 정상적인 stylesheets
- 시험 정착물 파일
- 생성됨/minified CSS
