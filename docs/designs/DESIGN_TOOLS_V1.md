# 디자인 : gstack 비주얼 디자인 생성 (`design` 이진)

2026-03-26 지점의 /office-hours에 의해 생성됨: garrytan/agent-design-tools Repo: gstack 상태: DRAFT 형태: Intrapreneurship

## 텍스트

gstack의 디자인 기술 (/office-hours, /design-consultation, /plan-design-review, /design-review) 모든 생성 **텍스트 설명** 디자인의 — DESIGN.md 파일과 hex 코드, prose, ASCII 예술 wireframes에 있는 화소 specs를 가진 계획 문서. 제작자는 OmniGraffle에 있는 손으로 디자인한 HelloSign가 이 embarrasing를 찾아내는 디자이너입니다.

값의 단위는 잘못되어 있습니다. 사용자는 풍부한 디자인 언어를 필요로하지 않습니다. 그들은 "이 spec을 좋아하지 않습니까?"에서 "이 화면이 좋아합니까?"라는 대화를 변경할 수있는 시각적 인 해석이 필요합니까?

## 문제 문

디자인 기술 설명 텍스트 대신 그것을 보여주는. Argus UX 과잉 계획은 예입니다: 487 상세한 감정적인 아크 specs의 선, 전기 선택, 애니메이션 타이밍 — 0개의 시각적인 artifacts. "designs"가 무언가를 만들고 viscerally에 반응할 수 있는 무언가를 일으킬 것을 코딩 에이전트 AI.

## 수요 증거

제작자/primary 사용자는 현재 산출 embarrassing를 찾아냅니다. 각 디자인 기술 세션은 조업이 있어야 하는 prose로 끝납니다. GPT 이미지 API는 지금 정확한 원본 연출을 가진 화소 결함 UI 조업을 생성합니다 — 기능 간격은 단지 산출을 더 이상 존재하지 않습니다.

## 좁은 쐐기

OpenAI Images/Responses API를 감싸는 `design/dist/design` 바이너리 (`design/dist/design`)를 `$D`를 통해 기술 템플렛에서 호출할 수 있는 컴파일된 `$B`는 이진 본을 찾아봅니다). 우선순위 통합 순서: /office-hours → /plan-design-review → /design-consultation → /design-review.

## 동의한 약속

1. GPT 이미지 API (OpenAI 응답 API)는 적당한 엔진입니다. 구글 스티치 SDK는 백업입니다.
2. **Visual mockup은 디자인 기술에 대한 기본입니다.** 쉬운 건너뛰기 경로로 - 옵트인이 아닙니다. (Codex 도전에 따라 다시 시작)
3. 통합은 공유 유틸리티 (당킬의 리바이더가 아닙니다) - 어떤 기술이 호출 할 수 있는지 `design` 바이너리입니다.
4. 우선순위: /office-hours 첫째, /plan-design-review, /design-consultation, /design-review.

## 크로스 모델 관점 (Codex)

Codex는 독립적으로 핵심 이론을 검증했습니다. " 실패는 마침 내에서 품질을 출력하지 않습니다. 현재 값의 단위가 잘못되어 있습니다." 키 기여 :
- 도전된 전제 #2 (opt-in → default-on) - 허용
- Proposed Vision-based 품질 gate: 사용 GPT-4o 비전을 확인하는 생성된 모조를 읽을 수 있는 텍스트, 누락된 부분, 끊긴 배치, 자동 복원 한 번
- 스코프 48시간 프로토 타입: 공유 `visual_mockup.ts` 유틸리티, /office-hours + /plan-design-review 만, 영웅 조업 + 2 변종

## 추천된 접근: `design` 이진 (Approach B)

### 건축

**검색을 공유하는 바이너리의 컴파일 및 배포 패턴** (분 빌드 --compile, 설정 스크립트, $VARIABLE 기술 템플릿에 대한 해상도) 그러나 건축적으로 단순 - 무결성 daemon 서버 없음, no Chromium, 건강 체크 없음, 토큰 오. 디자인 바이너리는 OpenAI API 호출하고 PNG를 디스크에 쓰는 stateless CLI입니다. 세션 상태 (멀티턴 iteration)는 JSON 파일입니다.

**새로운 의존성:** `openai` npm 패키지 (`devDependencies`, NOT runtime deps에 추가). 이 디자인은 검색에서 별도로 컴파일 된 디자인이 openai는 검색 바이너리를 bloat하지 않습니다.

```
design/
├── src/
│   ├── cli.ts            # Entry point, command dispatch
│   ├── commands.ts        # Command registry (source of truth for docs + validation)
│   ├── generate.ts        # Generate mockups from structured brief
│   ├── iterate.ts         # Multi-turn iteration on existing mockups
│   ├── variants.ts        # Generate N design variants from brief
│   ├── check.ts           # Vision-based quality gate (GPT-4o)
│   ├── brief.ts           # Structured brief type + assembly helpers
│   └── session.ts         # Session state (response IDs for multi-turn)
├── dist/
│   ├── design             # Compiled binary
│   └── .version           # Git hash
└── test/
    └── design.test.ts     # Integration tests
```

## 명령

```bash
# Generate a hero mockup from a structured brief
$D generate --brief "Dashboard for a coding assessment tool. Dark theme, cream accents. Shows: builder name, score badge, narrative letter, score cards. Target: technical users." --output /tmp/mockup-hero.png

# Generate 3 design variants
$D variants --brief "..." --count 3 --output-dir /tmp/mockups/

# Iterate on an existing mockup with feedback
$D iterate --session /tmp/design-session.json --feedback "Make the score cards larger, move the narrative above the scores" --output /tmp/mockup-v2.png

# Vision-based quality check (returns PASS/FAIL + issues)
$D check --image /tmp/mockup-hero.png --brief "Dashboard with builder name, score badge, narrative"

# One-shot with quality gate + auto-retry
$D generate --brief "..." --output /tmp/mockup.png --check --retry 1

# Pass a structured brief via JSON file
$D generate --brief-file /tmp/brief.json --output /tmp/mockup.png

# Generate comparison board HTML for user review
$D compare --images /tmp/mockups/variant-*.png --output /tmp/design-board.html

# Guided API key setup + smoke test
$D setup
```

**입력 모드:**
- `--brief "plain text"` - 무료 텍스트 프롬프트 (간단한 모드)
- `--brief-file path.json` - JSON 일치하는 `DesignBrief` 공용영역 (rich 형태) 구조화했습니다
- 스킬은 JSON 간단한 파일을 구성하고 /tmp로 작성하고 `--brief-file`를 전달합니다.

`--check`와 `--retry`를 `generate`에 플래그로 포함해 **모든 명령은 `commands.ts`에 등록됩니다.**를 `--check`를 `--retry`를 포함해 **모든 명령은 `commands.ts`에 등록됩니다.**를 뺍니다.

### 디자인 탐험 워크플로우 (eng 리뷰에서)

워크플로는 상수도가 아니라, 평행하지 않습니다. PNG는 시각적 탐사(human-facing), HTML 와이어프레임이 구현(agent-facing)에 대한 것입니다.

```
1. $D variants --brief "..." --count 3 --output-dir /tmp/mockups/
   → Generates 2-5 PNG mockup variations

2. $D compare --images /tmp/mockups/*.png --output /tmp/design-board.html
   → Generates HTML comparison board (spec below)

3. $B goto file:///tmp/design-board.html
   → User reviews all variants in headed Chrome

4. User picks favorite, rates, comments, clicks [Submit]
   Agent polls: $B eval document.getElementById('status').textContent
   Agent reads: $B eval document.getElementById('feedback-result').textContent
   → No clipboard, no pasting. Agent reads feedback directly from the page.

5. Claude generates HTML wireframe via DESIGN_SKETCH matching approved direction
   → Agent implements from the inspectable HTML, not the opaque PNG
```

## 비교 보드 디자인 Spec (/plan-design-review에서)

**분류기: APP UI** (task-focused, 유틸리티 페이지). 제품 상표가 붙지 않습니다.

**레이아웃: 단일 열, 전체 폭 조끼.** 각 변종은 최대 이미지의 불평을 위한 전체적인 전망 항구 폭을 가져옵니다. 사용자는 변종을 통해서 수직으로 스크롤합니다.

```
┌─────────────────────────────────────────────────────────────┐
│  HEADER BAR                                                 │
│  "Design Exploration" . project name . "3 variants"         │
│  Mode indicator: [Wide exploration] | [Matching DESIGN.md]  │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  ┌───────────────────────────────────────────────────────┐  │
│  │              VARIANT A (full width)                    │  │
│  │         [ mockup PNG, max-width: 1200px ]              │  │
│  ├───────────────────────────────────────────────────────┤  │
│  │ (●) Pick   ★★★★☆   [What do you like/dislike?____]   │  │
│  │            [More like this]                            │  │
│  └───────────────────────────────────────────────────────┘  │
│                                                             │
│  ┌───────────────────────────────────────────────────────┐  │
│  │              VARIANT B (full width)                    │  │
│  │         [ mockup PNG, max-width: 1200px ]              │  │
│  ├───────────────────────────────────────────────────────┤  │
│  │ ( ) Pick   ★★★☆☆   [What do you like/dislike?____]   │  │
│  │            [More like this]                            │  │
│  └───────────────────────────────────────────────────────┘  │
│                                                             │
│  ... (scroll for more variants)                             │
│                                                             │
│  ─── separator ─────────────────────────────────────────    │
│  Overall direction (optional, collapsed by default)         │
│  [textarea, 3 lines, expand on focus]                       │
│                                                             │
│  ─── REGENERATE BAR (#f7f7f7 bg) ───────────────────────    │
│  "Want to explore more?"                                    │
│  [Totally different]  [Match my design]  [Custom: ______]   │
│                                          [Regenerate ->]    │
│  ─────────────────────────────────────────────────────────  │
│                                        [ ✓ Submit ]         │
└─────────────────────────────────────────────────────────────┘
```

**시각적인 spec:**
- 배경: #fff. 그림자 없음, 카드 경계 없음. 채식 분리: 1px #e5e5e5 선.
- 전기: 체계 글꼴 더미. 우두머리: 16px 반bold. 상표: 14px 반bold. 의견 placeholder: 13px 일정한 #999.
- 별 등급: 5개의 clickable 별, fill=#000, unfilled=#ddd. 변색하지 않는, 애니메이션.
- Radio button "Pick": 좋아하는 선택. 변종 당 하나, 상호 독점.
- "더는"버튼: per-variant, 트리거는 종자로서의 변형 스타일로 재생합니다.
- 제출 버튼: #000 배경, 흰색 텍스트, 오른쪽 정렬. 단일 CTA.
- 재생 막대기: #f7f7f7 배경, 의견 지역에서 시각적으로 명백한.
- 최대 폭: 1200px는 모이업 이미지를 중심으로합니다. 마진: 24px 측.

**상호 작용 국가:**
- 로드 (페이지는 이미지 준비 전에 열립니다) : 카드 당 "Generating 변형 A ..."과 함께 골격 펄스. Stars/textarea/pick 비활성화.
- 부분 실패 (3의 성공) : 좋은 것을 보여, 과도한 [재고] 실패 오류 카드.
- 포스트-submit: "필드백 제출! 코딩 에이전트로 돌아갑니다." 페이지는 열려 있습니다.
- 재생: 매끄러운 전환, 오래된 변종, 골격 맥박, 새로운에서 퇴색합니다. 정상에 재시동. 이전 의견은 분명히했습니다.

**피드백 JSON 구조** (숨겨진 #feedback-result 성분에 따라 다름):
```json
{
  "preferred": "A",
  "ratings": { "A": 4, "B": 3, "C": 2 },
  "comments": {
    "A": "Love the spacing, header feels right",
    "B": "Too busy, but good color palette",
    "C": "Wrong mood entirely"
  },
  "overall": "Go with A, make the CTA bigger",
  "regenerated": false
}
```

**접근성:** 별 등급 키보드 항해 (수직 키). Textareas는 상표를 붙였습니다 ("Variant A를 위한 Feedback"). /Regenerate 키보드를 볼 수 있는 초점 반지에 접근하십시오. 모든 원본 #333+ 백색에.

**책임:** > 1200px: 편안한 마진. 768-1200px: 더 단단한 마진. <768px: 완전 폭, 수평 스크롤 없음.

**스크린 샷 동의 (최초 $D 진화에만 해당) :** "이것은 디자인 진화를 위해 OpenAI에 라이브 사이트의 스크린 샷을 보낼 것입니다. [Proceed] [Don't asked again]" 디자인 _스크랩_consent로 ~/.gstack/config.yaml에 저장.

왜 순차적 인: Codex 의논리적 검토는 raster PNGs가 에이전트 (DOM, 아니 상태, diffable 구조 없음)에 불투명한 opaque이다는 것을 확인했습니다. HTML 유선 프레임은 코드로 다리를 다시 보존합니다. PNG는 인간에게 "예, 그 권리"라고 말합니다. HTML는 에이전트을 위해 "나는 이것을 건설하는 방법을 알고 있습니다."

## 키 디자인 결정

**1. 무수 CLI, 무도** 블로깅은 지속 Chromium 인스턴스를 필요로 합니다. 디자인은 서버의 API 호출이 아니므로 서버의 경우도 마찬가지입니다. 멀티턴 이탈의 세션 상태는 JSON 파일 `/tmp/design-session-{id}.json` 으로 작성된 `previous_response_id` 으로 `previous_response_id` 으로 작성됩니다.
- **세션 ID:** `${PID}-${timestamp}`에서 생성된 `--session` 플래그를 통해 전달
- **발견:** `generate` 명령은 세션 파일을 만들고 경로를 인쇄합니다. `iterate`는 `--session`를 통해 그것을 읽습니다
- **청소:** 세션 파일 /tmp는 ephemeral (OS가 위로 청소합니다); 필요 없는 명시한 정리

**2. 구조상 간접 입력** 간단한 기술은 기술 prose와 이미지 생성 사이의 인터페이스입니다. 기술은 디자인 컨텍스트에서 구성합니다.
```typescript
interface DesignBrief {
  goal: string;           // "Dashboard for coding assessment tool"
  audience: string;       // "Technical users, YC partners"
  style: string;          // "Dark theme, cream accents, minimal"
  elements: string[];     // ["builder name", "score badge", "narrative letter"]
  constraints?: string;   // "Max width 1024px, mobile-first"
  reference?: string;     // Path to existing screenshot or DESIGN.md excerpt
  screenType: string;     // "desktop-dashboard" | "mobile-app" | "landing-page" | etc.
}
```

**3. 디자인 기술에 있는 과태에** Skills는 기본적으로 모의 생성을 생성합니다. 템플릿에는 건너뛰기 언어가 포함됩니다.
```
Generating visual mockup of the proposed design... (say "skip" if you don't need visuals)
```

**4. 시각 질 문** 생성 후, 선택적으로 GPT-4o vision을 통해 이미지를 전달합니다.
- 텍스트 읽을 수 (가장 상표/headings 가능합니까?)
- 레이아웃 완료 (모든 요청된 요소가 현재 있습니까?)
- 비주얼 코헤어스 (실제 UI, 충돌하지?)
실패에 한 번 자동 복원. 여전히 실패하면 경고로 어쨌든 제시.

**5. 산출 위치: /tmp에 있는 탐험, `docs/designs/`에 있는 승인된 마지막**
- 탐험 변형은 `/tmp/gstack-mockups-{session}/` (ephemeral, not commit)로 이동
- **사용자 승인 완료**의 조업은 `docs/designs/` (체크인)에 저장됩니다.
- CLAUDE.md `design_output_dir` 설정을 통해 기본 출력 디렉토리 설정 가능
- 파일 이름 패턴: `{skill}-{description}-{timestamp}.png`
- `docs/designs/` 를 생성하면 존재하지 않는다 (mkdir -p)
- Design doc은 최상의 이미지 경로 참조
- 항상 Read tool을 통해 사용자에게 보여준다 (Claude Code의 이미지 인라인 렌더링)
- 이것은 repo bloat를 피합니다: 단지 승인된 디자인은, 각 탐험 변종 아닙니다, 투입됩니다
- Fallback: git repo에 없다면 `/tmp/gstack-mockup-{timestamp}.png` 로 저장하십시오.

**6. 신뢰 경계 acknowledgment** Default-on generation sends design brief text to OpenAI. This is a new external data flow vs. the existing HTML wireframe path which is entirely local. The brief contains only abstract design descriptions (goal, style, elements), never source code or user data. Screenshots from $B are NOT sent to OpenAI (the reference field in DesignBrief is a local file path used by the agent, not uploaded to the API). Document this in CLAUDE.md.

**7. 비율 한계 mitigation** Variant 발생은 비틀어진 평행을 사용합니다: 각 API를 시작하십시오 지연으로 `Promise.allSettled()`를 통해 1 초 떨어져. 이것은 이미지 발생에 5-7 RPM 비율 한계를 완전히 일관되게 하는 동안 아직도 지킵니다. 어떤 전화든지 429s의 exponential 백오프 (2s, 4s, 8s)를 가진 재기.

### 템플릿 통합

**기존의 해결사에 추가:** `scripts/resolvers/design.ts` (NOT 새 파일)
- `generateDesignSetup()`를 `{{DESIGN_SETUP}}` 위주자 (mirrors `generateBrowseSetup()`)에 추가하십시오
- `generateDesignMockup()` for `{{DESIGN_MOCKUP}}` placeholder (전체 탐험 워크플로우)
- 하나의 파일에 모든 디자인 해설기를 유지 ( 기존의 codebase 컨벤션과 일관성)

**새로운 HostPaths 항목 :** `types.ts`
```typescript
// claude host:
designDir: '~/.claude/skills/gstack/design/dist'
// codex host:
designDir: '$GSTACK_DESIGN'
```
참고 : Codex 실행 시간 설정 (`setup` 스크립트)는 `GSTACK_DESIGN` env var를 내보내야하며 `GSTACK_BROWSE`가 설정되는 방식과 유사합니다.

**`$D` 해결책 bash 구획** (`{{DESIGN_SETUP}}`에 의해 생성하는):
```bash
_ROOT=$(git rev-parse --show-toplevel 2>/dev/null)
D=""
[ -n "$_ROOT" ] && [ -x "$_ROOT/.claude/skills/gstack/design/dist/design" ] && D="$_ROOT/.claude/skills/gstack/design/dist/design"
[ -z "$D" ] && D=~/.claude/skills/gstack/design/dist/design
if [ -x "$D" ]; then
  echo "DESIGN_READY: $D"
else
  echo "DESIGN_NOT_AVAILABLE"
fi
```
`DESIGN_NOT_AVAILABLE`: 기술은 HTML 전선 세대 (`DESIGN_SKETCH` 본을 덮는)에 뒤떨어졌습니다. 디자인 조업은 진보적인 증진, 단단한 필요조건 아닙니다입니다.

**기존의 해결자에 대한 새로운 기능:** `scripts/resolvers/design.ts`
- `{{DESIGN_SETUP}}`용 `generateDesignSetup()`를 추가합니다. `generateBrowseSetup()` 패턴을 미러링합니다.
- `generateDesignMockup()` 를 `{{DESIGN_MOCKUP}}` 에 추가합니다. - 전체 생성 + 체크 + 현재 작업 흐름
- 하나의 파일에 모든 디자인 해설기를 유지 ( 기존의 codebase 컨벤션과 일관성)

### Skill Integration (특허권)

**1. /office-hours** - Visual 스케치 섹션을 대체
- 접근 선택 후 (상 4), 영웅의 조업을 생성 + 2 변형
- Read Tool을 통해 3가지를 제시하고, 사용자가 선택하도록 요청
- 요청 시
- 선택된 모조를 사용하여 디자인 doc

**2. /plan-design-review** — "더 나은 모습"
- 디자인 치수를 평가할 때 <7/10>, 10/10가 어떻게 보일지 보여주는 조업을 생성
- 사이드 바이 사이드: 현재 ($B를 통해 스크린 샷) vs. 제안 ($D를 통해 Mockup)

**3. /design-consultation** - 디자인 시스템 미리보기
- 제안된 디자인 시스템의 시각적인 미리보기 생성 (인쇄, 색깔, 성분)
- /tmp HTML 적절한 모조로 미리보기 페이지를 대체하십시오.

**4. /design-review** - 디자인 의도적인 비교
- plan/DESIGN.md specs에서 "design intent"를 모방합니다.
- 라이브 사이트 스크린 샷에 대한 비교 시각적 delta

### 파일 만들기

| File | 의논하기 |
|------|---------|
| `design/src/cli.ts` | 입력점, 명령 파견 |
| `design/src/commands.ts` | 명령 레지스트리 |
| `design/src/generate.ts` | GPT 응답을 통해 이미지 생성 API |
| `design/src/iterate.ts` | 세션 상태에 대한 멀티턴 반복 |
| `design/src/variants.ts` | N 디자인 변형 생성 |
| `design/src/check.ts` | 비전 기반 품질 문 |
| `design/src/brief.ts` | 구조형 간결형 + 헬퍼 |
| `design/src/session.ts` | 세션 상태 관리 |
| `design/src/compare.ts` | HTML 비교판 발전기 |
| `design/test/design.test.ts` | 통합 테스트 (mock OpenAI API) |
| (none - 기존 `scripts/resolvers/design.ts`에 추가) | `{{DESIGN_SETUP}}` + `{{DESIGN_MOCKUP}}` 해결사 |

## 파일 수정

| File | Change |
|------|--------|
| `scripts/resolvers/types.ts` | `designDir`를 `HostPaths`로 추가하십시오 |
| `scripts/resolvers/index.ts` | DESIGN_SETUP + DESIGN_MOCKUP 해결사 |
| `package.json` | `design` 빌드 명령 |
| `setup` | 디자인 바이너리를 찾아보기 |
| `scripts/resolvers/preamble.ts` | `GSTACK_DESIGN` env var export for Codex 호스트에 추가 |
| `test/gen-skill-docs.test.ts` | 새로운 해결사에 대한 DESIGN_SKETCH 테스트 스위트 업데이트 |
| `setup` | 디자인 바이너리 빌드 + Codex/Kiro 자산 연결 추가 |
| `office-hours/SKILL.md.tmpl` | `{{DESIGN_MOCKUP}}`로 Visual Sketch 섹션을 대체 |
| `plan-design-review/SKILL.md.tmpl` | `{{DESIGN_SETUP}}` + 낮은 득점 차원을 위한 조업 세대를 추가하십시오 |

### Reuse에 대한 기존 코드

| 의 특징 | Location | 사용 |
|------|----------|----------|
| Browse CLI pattern | `browse/src/cli.ts` | 명령 파견 건축 |
| `commands.ts` 레지스트리 | `browse/src/commands.ts` | 진실 본의 단 하나 근원 |
| `generateBrowseSetup()` | `scripts/resolvers/browse.ts` | `generateDesignSetup()`를 위한 템플릿 |
| `DESIGN_SKETCH` 해결자 | `scripts/resolvers/design.ts` | `DESIGN_MOCKUP` 해결자를 위한 템플릿 |
| HostPaths 시스템 | `scripts/resolvers/types.ts` | Multi-host 경로 해결 |
| 파이프 라인 | `package.json` 스크립트 구축 | `bun build --compile` 패턴 |

### API 상세

**생성:** OpenAI 응답 API 와 `image_generation` 도구
```typescript
const response = await openai.responses.create({
  model: "gpt-4o",
  input: briefToPrompt(brief),
  tools: [{ type: "image_generation", size: "1536x1024", quality: "high" }],
});
// Extract image from response output items
const imageItem = response.output.find(item => item.type === "image_generation_call");
const base64Data = imageItem.result; // base64-encoded PNG
fs.writeFileSync(outputPath, Buffer.from(base64Data, "base64"));
```

**공급 능력:** `previous_response_id`와 API와 같음
```typescript
const response = await openai.responses.create({
  model: "gpt-4o",
  input: feedback,
  previous_response_id: session.lastResponseId,
  tools: [{ type: "image_generation" }],
});
```
**NOTE:** `previous_response_id`를 통해 다 회전 이미지 이탈은 시제품 검증을 필요로 하는 가정입니다. 응답 API는 대화 실을 꿰기를 지원하지만, 편집 작풍 이탈을 위한 생성한 이미지의 시각적인 맥락을 통해서는 문서에서 확인되지 않습니다. **가을:**는 다 회전이 작동하지 않는 경우에, `iterate`는 단 하나 신속한에 있는 본래 간결 + 축적된 의견으로 다시 생성하는 것을 떨어뜨립니다.

**의 특징:** GPT-4o 시각
```typescript
const check = await openai.chat.completions.create({
  model: "gpt-4o",
  messages: [{
    role: "user",
    content: [
      { type: "image_url", image_url: { url: `data:image/png;base64,${imageData}` } },
      { type: "text", text: `Check this UI mockup. Brief: ${brief}. Is text readable? Are all elements present? Does it look like a real UI? Return PASS or FAIL with issues.` }
    ]
  }]
});
```

**가격 :** ~ $0.10-$0.40 디자인 세션 당 (1 영웅 + 2 변종 + 1 품질 검사 + 1 이탈). LLM에 대한 다음을 무시하면 각 기술이 이미 발생합니다.

### Auth (연료를 통해 유효하게 함)

**Codex OAuth 토큰 DO NOT 이미지 생성 작업.** 2026-03-26 테스트: 이미지 API와 응답 API는 `~/.codex/auth.json` access_token을 "Missing 범위로 주사합니다: api.model.images.request"로 바꾸십시오. Codex CLI는 또한 본래 심상 기능이 없습니다.

**Auth 해결책 순서:**
1. `~/.gstack/openai.json` → `{ "api_key": "sk-..." }` (파일 권한 0600)
2. `OPENAI_API_KEY` 환경변수로 돌아가기
3. 존재하지 않는 경우 → 가이드 설정 흐름:
   - 사용자를 말하십시오: "디자인 조업은 이미지 생성 허가를 가진 OpenAI API 열쇠를 필요로 합니다. platform.openai.com/api-keys에서 하나 얻으십시오
   - Prompt 사용자를 붙여 키
   - `~/.gstack/openai.json` 으로 0600 허가
   - 연기 시험을 실행 ( 1024x1024 테스트 이미지를 생성) 키 작업을 확인
   - 연기 테스트가 통과되면 진행합니다. 실패하면 오류를 표시하고 DESIGN_SKETCH로 돌아갑니다.
4. auth가 존재하는 경우, API 호출은 DESIGN_SKETCH (HTML wireframe 접근을 제외)로 돌아갑니다. 디자인 조업은 진보적인 증진, 결코 단단한 필요조건입니다.

**새로운 명령:** `$D setup` — API 열쇠 체제 + 연기 시험 안내했습니다. 열쇠를 새롭게 하기 위하여 언제든지 달릴 수 있습니다.

## Prototype에서 검증하는 가정

1. **이미지 질:** "Pixel-perfect UI 조업"은 영감입니다. GPT 이미지 생성은 정확한 텍스트 렌더링, 정렬 및 진정한 UI 불평을 믿을 수 없을지도 모릅니다. 시각 품질 문 도움, 그러나 성공 크리티온 "좋은"는 충분히 완전한 기술 통합의 앞에 시제품 유효성을 필요로 합니다.
2. **다 회전 iteration:** `previous_response_id`는 시각적인 맥락이 비공개 (API 세부사항 단면도를 보십시오).
3. **비용 모형:** 예상 $0.10-$0.40/session는 실제 검증을 필요로 합니다.

**Prototype 검증 계획:** 빌드 컴밋 1 (핵심 생성 + 체크), 실행 10 다른 화면 유형의 주위에 디자인 간략한, 기술 통합에 진행하기 전에 출력 품질을 평가합니다.

## CEO 확장 범위 (/plan-ceo-review SCOPE EXPANSION를 통해 받아들이는)

##1. 디자인 기억 + 탐험 폭 통제
- 승인된 모조에서 DESIGN.md로 자동 추출 시각 언어
- DESIGN.md가 존재하면, 디자인 언어를 설치하기 위한 constrain Future mockup
- DESIGN.md (bootstrap)이 없다면, WIDE를 다양한 방향으로 탐험하십시오.
- 진보적인 제약: 더 설치된 디자인 = 더 좁은 탐험 밴드
- 비교 널은 탐험 통제를 가진 REGENERATE 단면도를 얻습니다:
  - "완전히 다른"(넓은 탐험)
  - "더 많은 옵션 ___" (즐거운 주변)
  - "내 기존의 디자인"(DESIGN.md에 따라)
  - 특정 방향 변경에 대한 무료 텍스트 입력
  - 재생 목록, 새로운 제출에 대한 에이전트 설문 조사

##2. 매직 디핑
- `$D diff --before old.png --after new.png`는 시각적인 diff를 생성합니다
- 변경된 지역과 함께 사이드 바이 사이드
- GPT-4o 차이를 식별하기 위한 비전을 사용합니다.
- 에서 사용하는: /design-review, iteration 의견, PR 검토

##3. 스크린 샷 - 투 - 매킹 진화
- `$D evolve --screenshot current.png --brief "make it calmer"`
- Takes live site screenshot, generates mockup showing how it SHOULD look
- 현실에서 시작, 빈 캔버스가 아닌
- /design-review 사이 교량은과 시각적인 고침 제안을 고쳤습니다

##4. 디자인 의도 검증
- /design-review 동안, 오버레이는 모의 모의 스크린 샷을 승인했습니다 (docs/designs/) 라이브 스크린 샷에
- 하이라이트: "당신은 X를 설계, 당신은 Y를 구축, 여기의 간격"
- 전체 루프를 닫습니다 : 디자인 -> 구현 -> 시각적으로 확인
- $B 스크린 샷 + $D 디퓨프 + 비전 분석

##5. 책임의 반란
- `$D variants --brief "..." --viewports desktop,tablet,mobile`
- 다중 뷰포트 크기에서 자동 생성된 조업
- 비교 보드는 동시 승인을위한 반응형 그리드를 보여줍니다.
- responsive design a first-class 관심사 from 모조 단계

##6. 디자인에 코드 Prompt
- 비교표 승인 후 자동 생성 구조 구현 시 신속한
- 색상, 태전, 시력 분석을 통해 승인 된 PNG의 레이아웃
- DESIGN.md와 HTML 구조화된 spec로 구조상과 결합
- "approved design"을 0 해석 간격으로 "에이전트 시작 코딩"으로 브릿지

### 미래엔진(NOT 이 플랜의 범위)
- Magic Patterns 통합 ( 기존 디자인의 추가 패턴)
- Variant API (그런 것일 때, 다각화 반응 코드 + 시사)
- Figma MCP (비방향 디자인 파일 접근)
- Google Stitch SDK (무료 TypeScript 대안)

## 질문 열기

1. Variant가 API를 발송할 때, 통합 경로는 무엇입니까? (설계 바이너리의 세분화 엔진, 또는 독립 채식 바이너리?)
2. Magic Patterns가 통합되어야 하는 방법? (다른 엔진은 $D 또는 별도의 도구로 구성됩니까?)
3. 어떤 시점에서 디자인 바이너리가 플러그인/engine 아키텍처를 필요로 하는 것은 여러 세대의 백엔드를 지원합니까?

## 성공 기준

- UI 아이디어에서 PNG를 실행하면 디자인 doc과 함께 실제 PNG의 조업을 생성합니다.
- `/plan-design-review`는 "더 나은 모습"을 모방으로 보여줍니다.
- Mockups는 개발자가 그들에서 구현할 수 있음을 충분히 잘합니다.
- 품질 문은 명백하게 부서진 조업 및 retries를 붙잡습니다
- 디자인 세션 당 비용 $0.50 미만의 체류

## 배포 계획

디자인 바이너리는 컴파일하고 배포되는 것과 함께 검색 바이너리:
- `bun build --compile design/src/cli.ts --outfile design/dist/design`
- `./setup` 및 `bun run build` 도중 건축하는
- 기존 `~/.claude/skills/gstack/`를 통해 링크를 넣으면 경로가 설치

## 다음 단계 (임시 주문)

## Commit 0: Prototype validation (MUST PASS 건물 인프라 전에)
- Single-file 프로토 타입 스크립트 (~50 라인)는 GPT 이미지 API로 3개의 다른 디자인 간결을 보냅니다
- Validates: text 렌더링 품질, 레이아웃 정확도, 시각적인 일관성
- If output is "embarrassingly bad AI art" for UI mockups, STOP. Re-evaluate approach.
- 이것은 가장 저렴한 방법으로 8개의 인프라를 구축하기 전에 핵심 가정을 검증합니다.

## Commit 1: 디자인 이진 코어 (작성 + 체크 + 비교)
- `design/src/` cli.ts, commands.ts, generate.ts, check.ts, brief.ts, session.ts, compare.ts
- Auth 단위 (읽는 ~/.gstack/openai.json,는 env var, 가이드 설정 교류에 fallback를 떨어뜨립니다)
- `compare` 명령은 HTML 비교표로 per-variant Feedback textareas를 생성합니다.
- `package.json` build 명령 (검색에서 `bun build --compile`를 입력)
- `setup` 스크립트 통합 (Codex + Kiro Asset linking 포함)
- 모의 OpenAI API 서버로 단위 테스트

## # Commit 2: 배아 + 이데레이트
- `design/src/variants.ts`, `design/src/iterate.ts`
- 비틀어진 병렬 생성 (1s 지연 시작, 429)에 exponential backoff
- 멀티턴을 위한 Session state 관리
- 이탈류 흐름 + 속도 제한 처리 테스트

## Commit 3: 템플릿 통합
- `generateDesignSetup()` + `generateDesignMockup()`를 기존 `scripts/resolvers/design.ts`로 추가
- `designDir` 에 `HostPaths` 에 `scripts/resolvers/types.ts` 추가
- DESIGN_SETUP + DESIGN_MOCKUP 에 `scripts/resolvers/index.ts`
- GSTACK_DESIGN env var export를 `scripts/resolvers/preamble.ts` (Codex 호스트)에 추가합니다.
- 업데이트 `test/gen-skill-docs.test.ts` (DESIGN_SKETCH 테스트 스위트)
- 재생 SKILL.md 파일

## # Commit 4: /office-hours 통합
- `{{DESIGN_MOCKUP}}`로 Visual Sketch 섹션을 대체
- 순차적 워크플로우: 변형 → $D 비교 → 사용자 피드백 → DESIGN_SKETCH HTML wireframe
- docs/designs/ (만 승인된 것만, 탐험하지 않음)에 승인된 조업을 저장하십시오

## # Commit 5: /plan-design-review 통합
- `{{DESIGN_SETUP}}` 및 저비용 치수를 위한 조업 세대 추가
- "10/10처럼 보이는"모자 비교

## Commit 6: 디자인 메모리 + 탐험 폭 통제 (CEO 확장)
- 모의 승인 후 GPT-4o vision을 통해 시각적인 언어를 추출하십시오.
- write/update DESIGN.md 추출된 색상, 태전, 간격, 레이아웃 패턴
- DESIGN.md가 존재하면, 모든 미래에 대한 제약이 틀린 상황에 따라 공급
- REGENERATE 섹션을 비교하여 보드 HTML (chiclets + 무료 텍스트 + 새로 고침 루프)
- 간략한 constraint 논리

## # Commit 7: Mockup Diffing + 디자인 의도 검증 (CEO 확장)
- `$D diff` 명령: 두 개의 PNG를 사용, GPT-4o 비전을 사용하여 차이를 식별하고, 오버레이를 생성합니다.
- `$D verify` 명령: 스크린 샷 실시간 사이트 $B를 통해, docs/designs/에서 승인된 모의 확산
- /design-review 템플릿에 통합: 승인된 모조가 존재할 때 자동 검증

## Commit 8: 스크린 샷 - 투 - 매킹 진화 (CEO 확장)
- `$D evolve` 명령: 스크린 샷 + 간단한을 가져 와서 "어떻게 볼 수"를 생성
- GPT 이미지 API에 참고 이미지로 스크린 샷을 보내십시오
- /design-review로 통합: "그는 수정이 어떻게 생겼는지" 시각적 제안

## Commit 9: 책임있는 배리제 + 디자인 코드 Prompt (CEO 확장)
- `--viewports` 멀티사이즈 세대의 `$D variants` 플래그
- 비교 보드 응답 그리드 레이아웃
- Auto-generate 구조 구현 승인 후 신속한
- 승인 된 PNG의 비전 분석은 색상, 태전, 신속한 레이아웃을 추출합니다.

## 할당

API를 구축하기 위해 Variant를 말하십시오. 투자자로서 AI 에이전트가 시각적 디자인 프로그램을 프로그래밍적으로 생성하는 워크플로를 구축하고 있습니다. GPT Image API는 오늘 작동하지만, 멀티 가변 접근 방식이 설계 탐험에 더 낫기 때문에 Variant를 사용하는 것이 좋습니다. API endpoint: prompt in, React code + 미리보기 이미지가 나옵니다. 나는 첫 번째 통합 파트너가 될 것입니다."

## 인증

1. `bun run build` 컴파일 `design/dist/design` 이진
2. `$D generate --brief "Landing page for a developer tool" --output /tmp/test.png`는 실제 PNG를 생성합니다
3. `$D check --image /tmp/test.png --brief "Landing page"` PASS/FAIL를 반환합니다.
4. `$D variants --brief "..." --count 3 --output-dir /tmp/variants/`는 3개의 PNG를 생성합니다
5. `/office-hours` 을 UI 에 실행하면,
6. `bun test` 패스 (skill validation, gen-skill-docs)
7. `bun run test:evals` 패스 (E2E 테스트)

## 당신이 생각하는 방법에 대해 무엇을 알

- 텍스트 설명과 ASCII 예술에 대한 "그는 디자인이 아닙니다. 디자이너의 의도입니다. 당신은 일을 설명하고 일을 보여주는 차이를 알고 있습니다. 대부분의 사람들은 AI 도구를 구축하지 않습니다. 디자이너가없는 때문에이 틈을주의하지 않습니다.
- 우선 /office-hours 첫째 - 업스트림 레버리지 포인트. 뇌하수체가 실제적인 모조를 생산하는 경우, 모든 다운스트림 기술 (/plan-design-review, /design-review)은 재해석 대신 참조하는 시각적 인 예술적 요소가 있습니다.
- Variant를 자금을 자금을 얻고 즉시 "they는 API"을 생각했습니다. 투자자 - 사용자 생각입니다. 회사 평가를 못하게하지 않고 워크플로우에 어떻게 적합한지 설계하고 있습니다.
- Codex가 옵트인 전제에 도전하면 즉시 받아 들였습니다. 고구 방어가 없습니다. 즉, 가장 빠른 경로는 올바른 대답입니다.

## Spec 리뷰 결과

Doc는 1 라운드의 adversarial 검토를 생존했습니다. 11 문제 잡았고 고정. 품질 점수 : 7/10 → 수정 후 예상 8.5/10.

고정 된 문제:
1. OpenAI SDK 종속성 선언
2. 이미지 데이터 추출 경로 지정 (response.output 항목 모양)
3. --check 및 --retry 플래그는 명령 레지스트리에 공식적으로 등록
4. 입력 모드 지정 (필문 텍스트 대 JSON 파일)
5. 해결 파일 금전 고정 ( 기존 design.ts에 추가)
6. HostPaths Codex env var 설정이 표기되지 않음
7. "미러 검색" "shares 컴파일/distribution 패턴"으로 재구성
8. 세션 상태 지정 (ID 생성, 발견, 정리)
9. "Pixel-perfect"는 assumption needing 프로토 타입 검증으로 끌어
10. 다 회전 침략은 떨어지는 계획으로 unproven
11. $D 발견 bash 블록은 DESIGN_SKETCH에 fallback으로 완전히 지정됩니다.

## Eng Review 완료 요약

- 단계 0: 범위 도전 — 범위는 as-is (완전한 바이너리, 사용자 overrode 감소 권고)를 받아들였습니다
- 아키텍처 검토 : 5 가지 문제가 발견 (openai dep 별거, 우아한 degrade, 출력 디디 config, auth 모델, 신뢰 경계)
- 코드 품질 검토 : 1 문제가 발견 된 (8 파일 대 5, 8을 유지)
- 시험 검토: 생성되는 도표, 42의 간격은, 시험 계획 쓴
- 성능 검토 : 1 개의 문제가 발견 (눈에 띄는 시작으로 변종)
- 범위의 NOT: 구글 스티치 SDK 통합, Figma MCP, Variant API (deferred)
- 이미 존재하는 것은: CLI 패턴, DESIGN_SKETCH 해결자, HostPaths 시스템, gen-skill-docs 파이프라인을 찾아봅니다.
- 외부 음성: 4 패스 (Claude 구조 12 문제, Codex 구조 8 문제, Claude adversarial 1 지방 결함, Codex adversarial 1 지방 결함). 중요한 통찰력: 순차적인 PNG→HTML 워크플로우는 "opaque raster"지방 하자.
- 실패 모드: 0개의 긴요한 간격 (모든 식별된 실패 형태에는 계획된 과실 취급 + 시험이 있습니다)
- Lake Score: 7/7 권고는 완전한 옵션을 선택했습니다

## GSTACK REVIEW REPORT

| Review | Trigger의 | 이유 | Runs | Status | 의논하기 |
|--------|---------|-----|------|--------|----------|
| 영업시간 | `/office-hours` | 뇌 폭풍 | 1 | DONE | 4개, 1개 개정 (Codex: 선택->default-on) |
| CEO 리뷰 | `/plan-ceo-review` | 범위 및 전략 | 1 | CLEAR | EXPANSION: 제안되는 6, 받아들여지는 6, 0개의 deferred |
| Eng 검토 | `/plan-eng-review` | 건축 및 테스트 (필수) | 1 | CLEAR | 7 문제, 0 중요한 간격, 4 외부 목소리 |
| 디자인 리뷰 | `/plan-design-review` | UI/UX 간격 | 1 | CLEAR | 점수: 2/10 -> 8/10, 5 결정 |
| 외부 목소리 | 구조 + adversarial | 자주 묻는 질문 | 4 | DONE | 순차적 PNG->HTML 워크플로우, 신뢰 경계가 주목 |

**CEO EXPANSIONS:** Design Memory + Exploration Width, Mockup Diffing, Screenshot Evolution, Design Intent Verification, Responsive Variants, Design-to-Code Prompt. **DESIGN DECISIONS:** Single-column full-width layout, per-card "More like this", explicit radio Pick, smooth fade regeneration, skeleton loading states. **UNRESOLVED:** 0 **VERDICT:** CEO + ENG + DESIGN CLEARED. Ready to implement. Start with Commit 0 (prototype validation).
