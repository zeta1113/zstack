# 계획 조정 v1 — 디자인 도크

**상태:** 구현에 승인 (2026-04-18) **주요 특징:** garrytan/plan-tune-skill **저자:** Garry Tan (user), AI-sisted review from Claude Opus 4.7 + OpenAI Codex gpt-5.4 **Supersedes 범위:** add 서면 스타일 + LOC-receipts layer on top of [PLAN_TUNING_V0.md](./PLAN_TUNING_V0.md) (비압용 기판) V0 (비변형) **관련 :** (비변형). <12/>는 <12/>에 남아 있지 않은 경우 <12/>.

## 이 문서는 무엇입니까?

/plan-tune v1이 무엇인지의 공명 기록은 NOT, 우리가 고려한 것, 왜 우리는 각 전화를 만들었습니다. repo에 적합 그래서 미래 기여자 (그리고 미래 가르리) 고고학없이 소감을 추적 할 수 있습니다. 어떤 per-user 로컬 계획의 해석을 슈퍼.

## 크레딧

이 계획은 **[루이 드 Sadeleer](https://x.com/LouiseDSadeleer/status/2045139351227478199)**로 인해 존재하며, gstack는 비 기술적인 사용자로서 실행되며, 그 느낌에 대한 진실을 알려줍니다. 그녀의 특정 피드백 :

1. "나는 잠시 후 조금 피곤하고 조금 단단히 느꼈다." — *pacing/fatigue*
2. "나는 단지 예 예라고 말할거야" (건축 검토를 진행). — *관련 제품*
3. "나는 재미를 발견하는 것은 그가 생산하는 코드의 많은 라인에 중점을두고 있습니다. AI는 물론 그를 위해 생산되었습니다." — *LOC 튀기*
4. "이 비 엔지니어는 이해하는 조금 복잡합니다." — *jargon 조밀도 + outcome 짜맞추기*

V1 주소 #3와 #4 직접: jargon-glossing + outcome-framed 쓰기는 독자를 위해 그것을 썼다, 그리고 현명한 LOC 구조. Louise의 #1 및 #2 (pacing/fatigue)는 [PACING_UPDATES_V0.md](./PACING_UPDATES_V0.md)로 추출한 분리된 디자인 둥근 - V1.1 계획으로.

## 한 단락에서 기능

gstack skill output is the product. If the prose doesn't read well for a non-technical founder, they check out of the review and click "yes yes yes." V1 adds a writing-style standard that applies to every tier ≥ 2 skill: jargon glossed on first use (from a curated ~50-term list), questions framed in outcome terms ("what breaks for your users if...") not implementation terms, short sentences, concrete nouns. Power users who want the tighter V0 prose can set `gstack-config set explain_level terse`. 이진 스위치, 부분 모드 없음. 플러스: README의 "600,000+ 생산 코드의 라인" 프램핑 - 오른쪽으로 호출 LOC 루이에 의한 허영 - 실제 computed 2013-vs-2026 pro-rata 여러 `scc`-backed 스크립트, 공개 vs-private repo 가시에 대한 솔직한 동굴.

## 왜 우리는 더 작은 버전을 건축하고 있습니다

V1는 여러 리뷰 패스에 4개의 실질적인 범위 개정을 통해 갔다. 각 리뷰가 실제 문제를 붙잡기 때문에 최종 범위는 어떤 중간 버전든지 더 작습니다.

**개정 1 - 4 레벨의 경험 축 (출).** Original 제안: 경험있는 dev, 엔지니어 - 안솔로 경험, 비 기술 - 팀, 또는 비 기술 - 기술 - 팀, 또는 비 과학적 - 본질적으로 인 여부를 처음 실행하는 것에 사용자를 요구하십시오. 기술 수준 당 적응. CEO 검토의 전제 challenge 단계 도중 거절하는 것은 (a) onboarding는 정확하게 순간 V1에 마찰을 추가합니다 그것을 감소시키기 위하여 시도하고 있습니다, (b) “어떤 수준 나는?”는 대부분의 필요 도움, (c) 기술적인 전문 지식이 1 차원 (설계 수준 A에 CSS, 배치에 수준 D), (d) 엔지니어는 동일한 서면으로 비독성 사용자에게서 이득을 얻습니다.

**Revision 2 - ELI10 기본으로, terse opt-out (accepted).** 각 기술의 출력은 쓰기 표준에 기본을 출력한다. V0 prose set `explain_level: terse`를 원한 힘 사용자. Codex 1개의 붙잡힌 긴요한 간격 (정치 마침, 주인 인식 경로, README 갱신 기계장치) - 모든 3개의 통합을 통과하십시오.

**개정 3 - ELI10 + 검토 - 포장 overhaul (제공, 범위가 뒤로).** 파싱 워크스트림 추가: 랭크된 파싱 워크스트림: 랭크된 파싱, 자동 포클 문, 최대 3 AskUserQuestion 프롬프트, 스플립 커맨드를 가진 침묵하는 Decisions 블록. Louise의 #1 및 #2를 직접 해결하는 데 주력. Eng review Pass 2 붙잡는 scoring-formula 및 경로 일관성 버그. Eng review Pass 3 + Codex Pass 2 표면 10+ 구조의 간격을 통해 수정할 수 있었습니다.

**개정 4 - ELI10 + LOC (final).** 사용자는 범위를 감소를 선택했습니다: [PACING_UPDATES_V0.md](./PACING_UPDATES_V0.md)를 통해 V1.1에 [PACING_UPDATES_V0.md](./PACING_UPDATES_V0.md)를 덮는 쓰기 작풍 + LOC 영수증을 가진 배 V1. 이것은 찬성된 V1 범위입니다.

를 통하여 선: 모든 검토는 나머지 범위가 구조상 간격이 없었다 때까지 제대로 좁히는 주위를 통과합니다. 일치 CEO 검토 기술 SCOPE REDUCTION 형태, 전략적인 선택을 통해 일찍 엔지니어링 검토를 통해 도착했습니다.

## v1 범위 (지금 우리는 건물이)

1. **preamble에 있는 쓰기 작풍 단면도** (`scripts/resolvers/preamble.ts`). 6개의 규칙: 기술 invocation, outcome framing, 짧은 문장/ 콘크리트 nouns/활동적인 음성, 사용자 충격, 광택에 첫번째 사용 조건 (사용자가 기간을 과거로 되었더라도), 사용자 회전 override (사용자는 "be terse"를 말하고 그 응답을 위해 건너뛰기 위하여).
2. **Repo-owned 목록을 통해 Jargon 경계** (`scripts/jargon-list.json`). ~50 curated 고주파 기술적인 기간. 목록에 아닙니다 조건은 충분히 일반 영어를 가정합니다. SKILL.md에 의하여 생성된 SKILL.md로 일렬로 세웁니다 (조각 런타임 비용).
3. **Terse 선택 아웃** (`gstack-config set explain_level terse`). 이진: `default` 대 `terse`. Terse는 쓰기 작풍 구획을 전적으로 건너뛰고 V0 prose 작풍을 이용합니다.
4. **호스트 인식 preamble echo.** `_EXPLAIN_LEVEL=$(${binDir}/gstack-config get explain_level 2>/dev/null || echo "default")`. 기존 V0 `ctx.paths.binDir` 패턴을 통해 호스트 가능.
5. **gstack-config 검증.** Document `explain_level: default|terse` 헤더에. 화이트리스트 값. `default`에 특정 메시지 + 기본값으로 알 수 없는 워n.
6. **LOC reframe in README.** Remove "600,000+ lines of production code" hero framing. Insert `<!-- GSTACK-THROUGHPUT-PLACEHOLDER -->` anchor. Build-time script replaces anchor with computed multiple + caveat.
7. **`scc`-backed 처리량 스크립트** (`scripts/garry-output-comparison.ts`). 2013년 + 2026년 각각을 위해, Garry-authored 공중 투입, `git diff`에서 추가된 선을, `scc --stdin`를 통해 분류하십시오 (또는 regex fallback). 산출 `docs/throughput-2013-vs-2026.json` 당 언어 고장 + caveats를 가진.
8. **`scc` 독립 설치 스크립트** (`scripts/setup-scc.sh`). `package.json` 의존도 (선택적 - 사용자의 95 %는 처리량을 결코 달리지 않습니다). OS 탐지 및 실행 `brew install scc` / `apt install scc` / 인쇄 GitHub 릴리스 링크.
9. **README 업데이트 파이프라인** (`scripts/update-readme-throughput.ts`). 현재 `docs/throughput-2013-vs-2026.json`를 읽으면, 계산된 수를 가진 닻을 대체합니다. 누락된 경우에, `GSTACK-THROUGHPUT-PENDING`가 CI가 주사하는 감적을 쓰면, 커밋하기 전에 스크립트를 실행하는 힘 기여자.
10. **/retro는 원시 LOC의 위 논리 SLOC + 무게를 다는 투입을 추가합니다.** Raw LOC은 컨텍스트에 머물지만 시각적으로 데모됩니다.
11. **업그레이드** (`gstack-upgrade/migrations/v<VERSION>.sh`). 그것을 선호하는 사용자를 위한 V0 prose를 통해 `explain_level: terse`를 복구하는 1 시간 포스트 고급 상호 작용하는 신속한 제안. 깃발 파일 문.
12. **관련 기사** CLAUDE.md는 쓰기 스타일 섹션 (프로젝트 컨벤션)을 얻습니다. CHANGELOG.md는 V1 입력 (사용자 회의, 언급 범위 감소 + V1.1 pacing)를 가져옵니다. README.md는 쓰기 작풍 감응작용 단면도 (~80 단어)를 가져옵니다. CONTRIBUTING.md는 단지 명부 정비 (PRs에 주의를 얻습니다/remove 기간).
13. **시험.** 6개의 새로운 시험 파일 + 기존 `gen-skill-docs.test.ts`의 연장. LLM-judge E2E (periodic)를 제외하고 모든 문 층.
14. **V0 기숙사 부정적인 시험.** Assert 5D 차원 이름과 8개의 아치 유형 이름은 과태 형태 기술 산출에서 나타나지 않습니다. V1로 새기에서 V0 심리학 기계장치를 방지하십시오.
15. **V1 및 V1.1 디자인 문서.** PLAN_TUNING_V1.md (이 파일). PACING_UPDATES_V0.md (V1.1 계획, V1 추출된 부록에서 구현). TODOS.md P0 입력.

## 철거

**V1.1 (특별한 디자인 문서와 더불어,):**
- overhaul (ranking, 자동 허가, 최대 3 상, 침묵하는 Decisions 구획, 손가락으로 튀김 기계장치)를 포장하는 검토. Reasoning: [PACING_UPDATES_V0.md](./PACING_UPDATES_V0.md) §" 추출되는 왜 보십시오." prose 전용 변화를 통해 불고 있는 10+ 구조상 간격이 있습니다.
- 우선 시위 메타 프롬프트 감사 (레이크 인트로, 원격 측정, 능동, 라우팅). 루이는 첫 번째 실행에 그들 모두를 보았다; 그들은 피로에 대한 계산. V1.1 세션 N까지 억제 고려.

**V2 (또는 나중에):**
- 질문 로그에서 혼란 서명 감지는 on-the-fly 번역 제공.
- 5D 심리학 구동 기술 적응 (V0 E1 항목).
- /plan-tune narrative + /plan-tune vibe (V0 E3 품목).
- Per-skill 또는 per-topic은 레벨을 설명합니다.
- 팀 프로필.
- AST 기반 "배달 된 기능"미터.

## 전반적으로 거부 (지난하지 않음)

- **4단계 선언된 경험 축 (A/B/C/D).** CEO 검토 전제 - challenge 도중 거절. "왜 우리는 더 작은 버전을 건축하고 있습니다"를 위에 보십시오.
- **ELI10 새 해결자 파일로 (`scripts/resolvers/eli10-writing.ts`).** Codex 1은 기존의 "스마트 16세"패밍과 충돌을 프리 캐블의 AskUserQuestion 형식 섹션에서 잡았습니다. 대신 기존의 프리 캐블로폴로 펼칩니다.
- **Writing Style Block의 실행 시간 억제.** Codex 1은 `gen-skill-docs`가 정적 Markdown를 생성하는 것을 붙잡음을 잡음을 잡음 수 없습니다. 해결책: 조건부 보호 문 (V0의 `QUESTION_TUNING` 문과 같은 종류).
- **과 terse 사이 중간 쓰기 형태.** 개정 3 제안 "terse = 광택이 없지만 파밍을 유지." Codex 2는 이동 메시징으로 피할 수 있습니다. 이진 승리 : terse = V0 prose, 전체 정지.
- **사용자 편집 가능한 jargon list at runtime.** Revision 3은 사용자의 배부로 `~/.gstack/jargon-list.json`를 제안했습니다. Codex는 2를 gen 시간 inlining로 금전을 붙 잡았습니다. 해결하는: repo-owned only, PRs to add/remove, 효력을 가지고 가기 위하여 재생산합니다.
- **`devDependencies.optional` 필드는 package.json입니다.** 실제 npm/bun 필드가 아닙니다. 2개의 붙잡음을 챙기세요. 독립은 대신 스크립트를 설치합니다.
- **AND CI-reject marker와 같은 문자열을 README로 사용.** Eng review Pass 2 / Codex Pass 2는 이 파이프 라인이 자체 업데이트 경로를 파괴한다는 것을 잡았습니다. 두 문자열 솔루션 : `GSTACK-THROUGHPUT-PLACEHOLDER` (주요, 실행 중 유지) 대 `GSTACK-THROUGHPUT-PENDING` (explicit "build not't run" Marker 그 CI 거부).
- **"모든 기술 용어는 광택을 얻는다" 합격 선결.** Codex 2는 큐레이터 목록 규칙과 피할 수 있습니다. 규칙과 일치하도록 허용: "그것이 gloss를 얻은 `scripts/jargon-list.json`에 대한 모든 용어."
- **합격 선명한 "≤ 12 AskUserQuestion는 /autoplan 당 프롬프트를 초래합니다."** V1에서 제거됨 - 그 대상은 V1.1에서 파싱을 요구한다.

## 건축

```
~/.gstack/
  developer-profile.json           # unchanged from V0
  config.yaml                       # + explain_level key (default | terse)

scripts/
  jargon-list.json                  # NEW: ~50 repo-owned terms (gen-time inlined)
  garry-output-comparison.ts        # NEW: scc + git per-year, author-scoped
  update-readme-throughput.ts       # NEW: README anchor replacement
  setup-scc.sh                      # NEW: OS-detecting scc installer
  resolvers/preamble.ts             # MODIFIED: Writing Style section + EXPLAIN_LEVEL echo

docs/
  designs/PLAN_TUNING_V1.md         # NEW: this file
  designs/PACING_UPDATES_V0.md      # NEW: V1.1 plan (extracted)
  throughput-2013-vs-2026.json      # NEW: computed, committed

~/.claude/skills/gstack/bin/
  gstack-config                     # MODIFIED: explain_level header + validation

gstack-upgrade/migrations/
  v<VERSION>.sh                     # NEW: V0 → V1 interactive prompt
```

### 자료 교류

```
User runs tier-≥2 skill
       │
       ▼
Preamble bash (per-invocation):
  _EXPLAIN_LEVEL=$(${binDir}/gstack-config get explain_level 2>/dev/null || "default")
  echo "EXPLAIN_LEVEL: $_EXPLAIN_LEVEL"
       │
       ▼
Generated SKILL.md body (static Markdown, baked at gen-skill-docs):
  - AskUserQuestion Format section (existing V0)
  - Writing Style section (NEW, conditional prose gate)
       │
       ├── "Skip if EXPLAIN_LEVEL: terse OR user says 'be terse' this turn"
       ├── 6 writing rules (jargon, outcome, short, impact, first-use, override)
       └── Jargon list inlined from scripts/jargon-list.json
       │
       ▼
Agent applies or skips based on runtime EXPLAIN_LEVEL + user-turn signal
       │
       ▼
V0 QUESTION_TUNING + question-log + preferences unchanged
       │
       ▼
Output to user (gloss-on-first-use, outcome-framed, short sentences; or V0 prose if terse)
```

## 데이터 흐름: 처리량 스크립트 (build-time)

```
bun run build
   │
   ├── gen:skill-docs (regenerates SKILL.md files with jargon list inlined)
   ├── update-readme-throughput (reads JSON if present; replaces anchor OR writes PENDING marker)
   └── other steps (binary compilation, etc.)

Separately, on-demand:
bun run scripts/garry-output-comparison.ts
   │
   ├── scc preflight (if missing → exit with setup-scc.sh hint)
   ├── For 2013 + 2026: enumerate Garry-authored commits in public garrytan/* repos
   ├── For each commit: git diff, extract ADDED lines, classify via scc --stdin
   └── Write docs/throughput-2013-vs-2026.json (per-language + caveats)
```

## 보안 + 개인 정보 보호

- **새로운 사용자 데이터 없음.** V1는 preamble prose + config 열쇠를 확장합니다. 수집된 새로운 개인적인 자료 없음.
- **runtime 파일이 민감한 데이터의 읽지 않습니다.** Jargon list는 repo-committed curated 리스트입니다.
- **마이그레이션 스크립트는 원샷입니다.** 플래그 파일은 재파이프를 방지합니다.
- **scc는 공개 저장소에서만 실행됩니다.** 개인 업무에 대한 액세스 없음.

## 결정 로그 (pros/cons)

### 결정 A: 4단계 경험 축선 대. ELI10 기본적으로 — ANSWER: ELI10 BY DEFAULT

**4단계 축선 (출시되는):** 사용자에게 먼저 실행중인 A/B/C/D로 자기 식별을 요청합니다. 기술은 레벨당 적응합니다.
- Pros: Explicit 사용자권. 전원 사용자는 V0 동작을 얻습니다.
- 단점 : 내장 마찰을 추가합니다. 힘 사용자는 스스로 라벨을 붙일 수 있습니다. 기술 전문 지식은 한 차원이 아닙니다. 엔지니어는 동일한 서면 표준 비 기술 사용자에서 혜택을받습니다.

**ELI10 terse opt-out (chosen)과 기본으로:** 각 기술의 출력은 쓰기 기준에 과태를 출력합니다. 힘 사용자는 `explain_level: terse`를 놓습니다.
- Pros: 아무 onboarding 질문 없음. 좋은 쓰기 이익 모두. 힘 사용자는 아직도 탈출 해치가 있습니다.
- 단점 : 자동 변경 V0 업그레이드 동작 → 마이그레이션 프롬프트가 필요합니다.

### Decision B: 새로운 결의자 파일 대. 기존의 preamble 확장 — ANSWER: EXTEND EXISTING

**새로운 결의자 (출시):** `scripts/resolvers/eli10-writing.ts` 별도의 발전기로.
- Pros: 모듈.
- Cons (Codex #7): 기존의 "스마트 16세"를 접어낸 플리츠를 접어 AskUserQuestion 형식 섹션으로 움직입니다. 진실의 두 소스.

**preamble (초센)를 확장하십시오:** AskUserQuestion 형식의 밑에 `scripts/resolvers/preamble.ts`에 직접 추가되는 쓰기 작풍 단면도.
- Pros: 진실의 한 소스. 기존 규칙과 비교.
- 단점 : `preamble.ts` 성장.

### 결정 C: 런타임 억제 대 조건부 간접 게이트 — ANSWER: CONDITIONAL PROSE GATE

**(출시되는) Runtime 억제:** `explain_level` 방아쇠 억제 논리의 Preamble 읽음.
- Pros: 단순한 정신 모델.
- cons (Codex #1): `gen-skill-docs`는 정체되는 감속을 일으킵니다. 구워진 일단, 내용은 복고하게 숨길 수 없습니다. 런타임 억제는 소설입니다.

**조건부 장문 (chosen):** "EXPLAIN_LEVEL: terse OR user는 'be terse' this turn"라고 합니다. Prose Convention; 에이전트 obey 또는 disobey at runtime.
- Pros: 테스트 가능. 일치 V0의 `QUESTION_TUNING` 본. 기계장치에 관하여 정직.
- 단점 : 에이전트 prose 준수에 따라 (무선 실행 게이트 없음).

### 결정 D: Jargon 목록 위치 — 런타임 사용자 편집 가능한 대. repo 소유 gen-time — ANSWER: REPO-OWNED GEN-TIME

**runtime (rejected)에서 사용자 편집 가능:** `~/.gstack/jargon-list.json`는 `scripts/jargon-list.json`를 과소합니다.
- Pros: 사용자는 자신의 도메인에 특정한 용어를 추가할 수 있습니다.
- Cons (Codex #4, Pass 2): Gen-time inlining은 사용자가 재생을 필요로 합니다. 예측.

**Repo-owned, gen-time 인라인 (초센):** `scripts/jargon-list.json`만. PRs to add/remove. `bun run gen:skill-docs`는 미리 골목으로 조건을 인라인으로 합니다.
- Pros: 진실의 1개의 근원. 영 주 시간 비용. 기존하는 구조에 Composable.
- 단점 : 사용자는 로컬로 용어를 추가 할 수 없습니다. 부채 : CONTRIBUTING.md; PR은 허용됩니다.

### 결정 E: V1 대 V1.1 - ANSWER: V1.1 (extracted)

**V1 (출시)에 있는 간격:** 뭉치 랭킹 + 자동 받아들이는 + 침묵하는 결정 + 최대 3 상 모자 + 손가락으로 튀김 기계장치.
- Pros: 루이의 피로를 직접 불러옵니다.
- 컨소시엄(Eng review Pass 3 + Codex Pass 2): 10+ 구조적 격차 계획 텍스트 편집을 통해 비접촉할 수 있습니다. 세션 스테이트 모델은 정의되지 않습니다. `phase` 필드는 문제로 누락되었습니다. 레지스트리는 동적 검토 결과를 덮지 않습니다. 플립 메커니즘은 구현이 없습니다. 마이그레이션 프롬프트는 또한 중단됩니다. 첫 번째 실행된 preamble 프롬프트도 계산합니다. 프로스로 패싱은 기존의 요청 섹션 실행 명령을 읽을 수 없습니다.

**V1.1 (chosen)에 추출:** 배 ELI10 + LOC in V1. Pacing는 그것의 자신의 디자인 둥근 가득 차있는 검토 주기를 가져옵니다.
- 프로: 선박 V1 솔직히. V1.1 실제 기본 데이터를 V1 사용 (Louise's V1 성적표)에서 제공합니다. SCOPE REDUCTION 모드 CEO 검토에서 일치합니다.
- Cons: 루이의 피로 불평은 V1.1까지 완전히 해결되지 않습니다. 완화: V1는 아직도 쓰기 질을 통해 그녀의 경험을 개량합니다; V1.1는 pacing로 위로 따릅니다.

### Decision F: README 업데이트 메커니즘 — 단일 문자열 대. 두 문자열 — ANSWER: TWO-STRING

**Single string (rejected):** `<!-- GSTACK-THROUGHPUT-MULTIPLE: N× -->` as both replacement anchor AND CI-reject marker.
- Pros: 단순.
- Cons (Codex Pass 2): Pipeline은 자체에 틈을 깰 — CI는 마커를 포함, 그러나 마커 IS 앵커를 거부합니다.

**2 끈 (초):** `GSTACK-THROUGHPUT-PLACEHOLDER` (연속, 안정) + `GSTACK-THROUGHPUT-PENDING` (확산한 누락한 구조 감적, CI 거절).
- Pros: 앵커 persists; CI 실제 실패 상태를 잡아.
- 단점 : 기억하는 두 가지 상징.

## 리뷰 기록

| Review | Runs | Status | 통합된 Key Finds |
|---|---|---|---|
| CEO 리뷰 | 1 | CLEAR (HOLD SCOPE) | 전제 피벗: 4단계 축선 → ELI10 기본적으로. 명시적인 사용자 선택을 통해 해결된 크로스 모델 긴장. |
| Codex 리뷰 | 2 | ISSUES_FOUND + 드리버 범위 감소 | 1: 25개의 발견, 3개의 긴요한 차단제 (정전 표, 주인paths, README 기계장치)를 통과하십시오. 2를 통과하십시오: 개정된 계획, drove V1.1 적출에 20의 발견. |
| Eng 검토 | 3 | CLEAR (SCOPE_REDUCED) | 1 : 중요한 격차 + 3 결정 (모든 A). 통과 2 : scoring-formula 버그, 경로 금전, 가짜 `devDependencies.optional` 필드. 3을 통과 : 구조 격차를 식별, 파괴 추출. |
| DX 리뷰 | 1 | CLEAR (TRIAGE) | 3 중요한 (docs 계획, 업그레이드 마이그레이션, 영웅 순간). 9 자동 동의 DX 결정. |

`gstack-review-log`를 통해 `~/.gstack/`에서 persisted. `~/.claude/plans/system-instruction-you-are-working-transient-sunbeam.md`의 전체 역사와 함께 유지되는 플랜 파일.
