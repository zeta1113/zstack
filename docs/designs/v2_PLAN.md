# gstack v2 — 가장 가벼운 의견 기술 팩

## 텍스트

gstack는 외부 문서화 된 명성을 "fat"라고합니다. 제 3 자 리뷰 (dev.to, May 2026)는 명시적으로 gstack "모든 역할이 켜지면 bloated 느낌이있을 수 있습니다 ... 실제 코드가 작성되기 전에 잠재적으로 10K + 토큰을 소비하고 토큰을 통해 일일 사용은 빠르게... 스트레이트로프는 슬러기와 중복을 느낄 수 있습니다. Anthropic의 자신의 관능적 인 기술 지도는 "진행적 인 공개" 패턴 (`SKILL.md` skeleton + `references/` 수요에로드) - gstack 이에서 다이브 지는.

비판을 다시 번호:

- 31 기술, 2.1MB 총 생성 SKILL.md 파푸스
- 28개의 기술이 40KB 연질 천장을 초과합니다 (각 10K 토큰)
- ship.md는 164KB (~41K 토큰); ship.md.tmpl는 48KB - **115KB는 결심자 주사됩니다**, 가장 높은 leverage 압축 표적만입니다
- 항상 로드된 시스템의 카탈로그 : 50 + 기술 × 멀티 - 파라그 설명, 음성 트리거, proactive-suggest 단락

This plan ships gstack v2 in two coordinated releases: v1.45.0.0 lands the foundation + low-risk wins, then v2.0.0.0 ships the architectural break + marketing-grade repositioning 2-4 weeks later. The split came out of cross-model review: Codex argued v2 looks like posturing without real breakage; the hybrid shape gives the genuinely-breaking sections/ pattern the major bump it earns, while letting the risk-free wins ship immediately.

## 방출 모양

```
v1.45.0.0 (Foundation Release)          v2.0.0.0 (gstack v2 Launch)
─────────────────────────────           ─────────────────────────────
~1-2 weeks of CC work                   2-4 weeks later, coordinated
                                        
Phase 0: Eval coverage matrix           Phase B: sections/ pattern
  gate + periodic for all 31 skills       on 5 heavyweights
                                          (ship, plan-ceo, office-hours,
Phase A: Build-time compression           plan-eng, plan-design)
  conditional resolver injection
  jargon dedup                          Phase C: Eval annotations
  terse-mode actually compresses          + CI orphan check (WARN→FAIL)
                                        
Catalog trim (Codex high-leverage win)  Lighter-touch migration
  one-line skill descriptions             release note + auto-regenerate
  drop voice triggers/proactive blocks    on /gstack-upgrade
                                        
Hard token budgets defined              Marketing-grade CHANGELOG
  enforced via budget-regression          v1 vs v2 numbers table
                                          README v2 banner
Normal release voice                      "lightest opinionated skill pack"
```

## 전제 체크 (Step 0A 발견)

1. **이 권리는?** YES - 외부 검증. bloat 비판은 인용하고 실제 사용자 통증 (token 비용, 진통 세션)을 나타냅니다. 아무것도하지 않는 것은 "빛 접촉" 명성을 위해 Cursor/Codex에 사용자를 잃게됩니다.
2. **아무것도하지 않는다:** 비판 화합물. 최근 출시 (v1.38 → v1.44) 모든 추가 기능; no 릴리스는 다른 방향을 갔다. 명시적 역외, 명성은 calcify.
3. **행동의 위험 :** 게으른 단면도 본은 새로운 실패 종류로 침묵하 행동 손실을 소개합니다. eval-first 기초 + 기계적인 강제 + 운하 구출 (단계 B 무결성 단면도를 보십시오)에 의해 미화해.

## 이미 존재하는 것 (reuse-first 감사)

| - 연혁 | 의욕 |
|---|---|
| `scripts/gen-skill-docs.ts` 선 439-450 | 이미 문자열 대용과 per-host 억제; `appliesTo` 해결사 게이트 (~15 LOC)로 확장 |
| `scripts/resolvers/types.ts` | `ResolverEntry` 조합 유형 추가 |
| `scripts/resolvers/preamble.ts` | 이미 tier-gated 구성 (1-4); per-resolver gating 추가 |
| `scripts/jargon-list.json` | 이미 하나의 파일; 그냥 37 ×를 기울이는 중지 |
| `test/skill-e2e-budget-regression.test.ts` (내선 게이트 층) | per-skill 단단한 예산으로 확장 |
| Real-PTY v1.13.2.0에서 마구 | 행동 계약 evals에 대한 재사용 (~$0.50/eval) |
| SDK 마구 | 싼 모양 evals를 위한 재사용 (~$0/eval 가능한 한) |
| `gstack-upgrade/migrations/` | 패턴은 상태 정보 마이그레이션에 존재합니다. v2 자동 재생에 재사용 |
| `~/.gstack/analytics/skill-usage.jsonl` | Already collected; powers deferred `gstack budget` CLI |

우리는 Anthropic의 대장 기술 패턴을 잡고, 발명하지 않습니다.

## 꿈 상태 델타

```
TODAY                              v1.45.0.0                         v2.0.0.0
──────                             ─────────                         ────────
2.1MB corpus                       ~1.3MB corpus (-40%)              ~700KB corpus (-67%)
ship.md: 164KB                     ship.md: ~80KB (-50%)             ship.md: ~15KB skeleton
                                                                     + 5×~5KB sections
28/31 over 40KB ceiling            ~10/31 over ceiling                ~3/31 over ceiling
                                                                     (cso, document-release,
                                                                      design-consultation
                                                                      kept as monoliths)
Catalog: multi-paragraph           Catalog: one-line per skill        Catalog: one-line per skill
descriptions, voice triggers       (~70% catalog cut)                 (same)
No eval coverage matrix            Every skill: ≥1 gate eval          Section-level eval
                                   + ≥1 periodic eval                 annotations + CI orphan check
"Fat" reputation in third-party    "Compressed, eval-protected"       "Lightest opinionated skill
reviews                            internally measured                pack" externally measured
```

## 단계 0 - Eval 적용 매트릭스 (v1.45.0.0)

**목표 :** gstack의 모든 기술은 적어도 1개의 문 층 eval AND를 가진 선박에 의하여 1개의 주기적인 층 eval는 행동을 주장합니다. 이 타원형 스위트는 디자인 spec이 됩니다. 이것은 계획의 짐 방위 요구입니다 — 첫째로 옵니다.

**크로스 모델 긴장은 제외 :** Codex argued 이것은 번식 함정과 모양 보조는 얕은 것입니다. 사용자는 명시적으로 전체 계층 적용을 선택했습니다 (D9 = A), 합리적 : "eval suite IS 디자인 spec; 그 약속은 전체 계획의 부하 방위 주장이다." 우리는 더 큰 상향 투자를 받아들입니다.

**Codex의 "shape vs quality"의 부재 :** 관현악을 위해/judgment 기술 (계획소, 사무실 시간, autoplan), 이어야 합니다. 이어야 하는 것은 신중한 산출이 아닙니다 — 그것은 구조적 수락 (맞은 모양에서 AskUserQuestion이라고 부릅니다? 단면도 순서를 따르는 합니까? 그것은 persist artifacts?). Eval 디자인은 구조적인 계약을 붙잡고, 산출 내용이 아닙니다 붙잡아야 합니다. 구조상 타원형이 불가능하다면, 그 섹션은 "judgment-dependent"으로 명시적으로 표기되어 있지 않습니다. Codex의 #2의 NOT은 NOT에 의해 영예되어 있으며, 비보호 판결을 벗고 있습니다.

**현재 진행중인 기술이 E2E 적용** (예를들면):

| 스킬 | 게이트 eval (타겟) | 정기적 인 eval (target) | 평균 비용/run |
|---|---|---|---|
| 퀵메뉴 | 보고서 전용 플래그 트리거 | 풀 QA는 고침 반복을 가진 교류를 무겁게 합니다 | $0.30 / $1.50 |
| retro | 주간 집계는 오류없이 실행 | full retro는 출력을 평가했습니다 | $0.20 / $2.00 |
| 문서 릴리스 | CHANGELOG를 읽으려면 Diataxis 맵을 생성합니다. | 전체 포스트 - DOC 업데이트 | $0.30 / $1.80 |
| 문서 생성 | 4개의 doc 유형을 프롬프트에서 생성합니다 | E2E 세대는 품질바를 통과합니다 | $0.30 / $2.00 |
| 계정 관리 | 예상 경로에 대한 persists 상태 | Round-trip은 컨텍스트를 보존합니다. | $0.10 / $0.50 |
| 계정 관리 | 최신 저장을 읽고 세션에 적용 | cross-workspace 복원 작업 | $0.10 / $0.50 |
| gstack-upgrade의 특징 | install type을 감지하고, 업그레이드를 실행 | 전체 업그레이드 + 이동 왕복 | $0.20 / $1.00 |
| sync-gbrain의 특징 | 오류없이 인덱스를 새로 고침 | 전체 동기화 검색 가능 corpus | $0.20 / $1.50 |
| 설정-gbrain | 1-4 탐지는 작동합니다 | 각 경로에 대한 end-to-end 설정 | $0.20 / $2.00 |
| 설정 브로슈어-cookies | 테이너 UI 오류 없이 부하 | cookie 수입 라운드 트립 | $0.20 / $1.00 |
| 설정-deploy | config를 감지하고 예상된 파일을 작성합니다. | 전체 배포 설정 | $0.20 / $1.00 |
| 디자인 협력 | DESIGN.md 템플릿 렌더링 | 전체 설계 시스템 세대 | $0.30 / $2.50 |
| 디자인 샷건 | 생성 및 저장 | 전체 멀티-variant 탐험 | $0.30 / $2.00 |
| 오픈-그루터 | 오류없이 브라우저를 실행 | sidebar 부착 및 공연 | $0.20 / $0.80 |
| 쌍 에이전트 | 생성된 설정 키, 지시 인쇄 | 두 번째 에이전트와 전체 쌍 흐름 | $0.20 / $1.50 |
| 토지 및 디플로이 | merge 게이트 체크가 제대로 | 전체 merge → 배치 → 캐리 | $0.30 / $3.00 |
| 의례 | 포스트 배포 루프 실행, 깨끗하게 종료 | 경고 시뮬레이션을 가진 전체적인 운하주기 | $0.20 / $1.50 |
| 벤치 마크 | 실행 및 점수 생성 | 전체 회귀 검출 | $0.20 / $2.00 |
| 플랜-devex-review | 모드 라우팅 작품 | 전체 DX 득점과 함께 검토 | $0.40 / $3.00 |
| 딕스 - 리뷰 | live DX 감사는 scorecard를 생성합니다 | E2E DX 측정 대 계획 기본 | $0.40 / $2.50 |

예상된 추가 CI 비용: **~$5/run 게이트, ~$30/run 주기.** 기존 E2E 스위트 (~$15/gate, ~$30/periodic), 총: ~$20/gate (모든 PR), ~$60/periodic (주). 수락가능한.

**Eval matrix는 다음과 같이 살아 있습니다.** `test/helpers/skill-coverage-matrix.ts` — 문 + 정기적인 eval 시험 파일에 각 기술을 매핑하는 진실의 단 하나 근원. CI는 `test/skill-coverage-matrix.test.ts`에서 검사합니다 어떤 기술든지 입장을 누락한 경우에 구조 실패합니다.

**추가 할 중요한 파일:**
- `test/skill-coverage-matrix.ts` - 레지스트리 매핑 기술 → eval 경로
- `test/skill-e2e-*.test.ts` — 20개의 새로운 시험 파일 (게이트 층 잠수함은 문 config, 주기적인 구성에 있는 주기적인 층 subset에서 시작합니다)
- `test/helpers/touchfiles.ts` - diff 기반 선택에 대한 새로운 테스트를 등록

## 단계 A — Build-time 압축 (v1.45.0.0)

**A.1 조건부 결산기 주입** - `scripts/gen-skill-docs.ts`와 `scripts/resolvers/`를 확장합니다:

```ts
// scripts/resolvers/types.ts
export type ResolverFn = (ctx: TemplateContext, args?: string[]) => string;
export type ResolverEntry = ResolverFn | {
  resolve: ResolverFn;
  appliesTo?: (ctx: TemplateContext) => boolean;
};
```

```ts
// scripts/resolvers/index.ts — gate the heavy ones
QUESTION_TUNING: {
  resolve: generateQuestionTuning,
  appliesTo: (ctx) => ['plan-ceo-review','plan-eng-review','office-hours'].includes(ctx.skillName),
},
REVIEW_ARMY: {
  resolve: generateReviewArmy,
  appliesTo: (ctx) => ['ship','review'].includes(ctx.skillName),
},
REVIEW_DASHBOARD: {
  resolve: generateReviewDashboard,
  appliesTo: (ctx) => ['ship','plan-ceo-review','plan-eng-review','plan-design-review','plan-devex-review','devex-review'].includes(ctx.skillName),
},
// ... audit all 21 resolvers, gate per actual usage
```

```ts
// scripts/gen-skill-docs.ts (~line 444) — check the gate
const entry = RESOLVERS[resolverName];
const resolver = typeof entry === 'function' ? entry : entry.resolve;
const gate = typeof entry === 'function' ? undefined : entry.appliesTo;
if (gate && !gate(ctx)) return '';
return args.length > 0 ? resolver(ctx, args) : resolver(ctx);
```

**A.2 항만 목록 dedup** — 현재 `scripts/resolvers/preamble/generate-writing-style.ts`는 37개의 기술로 가득 차있는 1.8KB jargon 광택을 일렬로 세웁니다. 참고로 인라인을 대체하십시오: "수직적인 단지 명부를 위해, 첫째로 사용에 `~/.claude/skills/gstack/scripts/jargon-list.json`를 읽으십시오." 득점 ~66KB 합계 corpus를 저장하십시오.

**A.3 Terse-mode 실제로 압축** — read `~/.gstack/config.yaml` once in `gen-skill-docs.ts`, pass `explainLevel` into `TemplateContext`, and have `generate-writing-style.ts` / `generate-completeness.ts` / `generate-confusion-protocol.ts` / `generate-context-health.ts` return `''` when terse. Today the bytes ship regardless of config — the flag only changes runtime model behavior. Add `--explain-level=terse` build flag for benchmarking.

**A.4 카탈로그 트림** (Codex #6) - 기술 당 1개의 선에 항상 적재된 체계에 있는 기술 묘사를 간략히 제거했습니다. 음성 방아쇠는 카탈로그 묘사에서 in-skill 내용으로 이동합니다. Proactive-suggest 단락은 에이전트이 여정 지도를 필요로 할 때만 분리된 `~/.claude/skills/gstack/scripts/proactive-suggestions.json`로 이동합니다. Per-skill 묘사 체재:

```
- <skill-name>: <one-line outcome description, ≤80 chars> (gstack)
```

견적 카탈로그 컷 : ~ 70 % (대일 단일 항상로드 감소).

**A.5 cso/대상 압축** (Codex #9) - cso는 결심자 dedup + 카탈로그 손질을 얻습니다. 안전 지도 prose는 단계 B 감사가 특정한 단면도를 안전하게 eval 적용과 단면도에 이동할 수 있을 때까지 uncompressed monolithically 체재합니다. "exempt" — 다만 순서로 마지막으로.

**A.6 Hard token 예산** (Codex #10) - `test/skill-e2e-budget-regression.test.ts`에서 정의하고 시행:

| 의 모든 것 | v1.44 실제 | v1.45 대상 | v2.0 대상 |
|---|---|---|---|
| Max 시스템 보호 카탈로그 토큰 | ~25K(일) | ~8K(대) | ~6K(주) |
| 최대 per-skill SKILL.md 크기 | 164KB (선) | 100KB의 | 30KB (무게) |
| 최대 corpus 총 | 2.1MB의 | 1.3MB의 | 700KB |
| 최대 일류 대기 시간 (중량) | ~중급 | ~중급 | <500ms 섹션 읽기 |

CI는 예산이 초과된 경우 실패합니다. 기존 예산 회귀 jsonl을 통해 시간이 지남에 따라 추적됩니다.

## 단계 B - 중체에 대한 섹션 / 패턴 (v2.0.0.0)

5 헤비급을 Anthropic-canon skeleton + `sections/*.md`로 변환하십시오:

```
ship/
├── SKILL.md              # 12-15KB decision-tree skeleton + section manifest
├── SKILL.md.tmpl         # source for the skeleton
├── sections/
│   ├── manifest.json     # NEW: structured section registry (Codex #3 mitigation)
│   ├── version-bump.md
│   ├── changelog.md
│   ├── review-army.md
│   ├── todos-cleanup.md
│   ├── pr-body.md
│   └── ...
```

**Silent-behavior-loss mitigations – 품질 협력 업체 중국에서** (Codex #3) - 단면 방어, 단지 자기 검사:

1. **Section manifest** (`sections/manifest.json`) - 구조화된 레지스트리: `{section_file, applies_when, required_for}`. ID에 의하여 결정적인 나무 골격선 참고 항목은, 자유로운 모양 prose 아닙니다.
2. **부정 골격 phrasing** — "STOP. `sections/version-bump.md`를 읽으십시오. "자세한 내용은 ..."를 참조하십시오.
3. **Top-of-file 섹션 인덱스 테이블** - 상황 → 섹션 파일 매핑.
4. **End-of-skill 자기 검사** — "모든 섹션을 확인하면 결정적인 트리가 지적합니다. 목록." (잘게 층, 가을으로 유지.)
5. **Eval 하네스 `requiredReads` 선언** - E2E는 지정된 정착물을 위한 transcript 읽기 호출에서 보이는 단면도를 시험합니다. 시험 층에 기계적인 강제, 다만 신속한 층.
6. **카나리아 코호트의 Transcript 검사** — 첫번째 주 포스트 선박, 실제로 실제 세션에 의해 읽는 것을 막는 기록; 표시된 필수 단면도를 위한 읽으십시오.

**변환 순서** (시간에 한 번, 다음의 각 유효):
1. `ship/` - 가장 큰 직업, 가장 큰 비용, 가장 위험한. 혼자 땅, 관찰 1 주.
2. `plan-ceo-review/` — 대화; 흐름을 끊는 위험. 땅 두 번째, 주의 깊게 관찰.
3. `office-hours/` - 가장 대화. 1+2가 청소한 경우에만 땅 3.
4. `plan-eng-review/` 및 `plan-design-review/` — 뭉치, 유사한 모양.

**변환하지 않음** 명시적으로 승인되지 않는 한 나중에 : `autoplan` (이 이미 체인 기술에 대한 오르체), `design-review` (UI는 이미 꽉 꽉 흘렀다), `qa` (단용), `investigate` (단용).

## Phase C - Eval 표기 + CI orphan 체크 (v2.0.0.0)

Codex #4 - 경고 - 대피소 진전, 즉시 엄격한 문이 아닙니다.

```md
<!-- eval: test/skill-e2e-ship-version-bump.test.ts -->
<!-- coverage: asserts the queue-aware bump picks the next available version when the claimed version is taken -->
```

주석은 **적용 semantics** (무엇 행동은 보호됩니다) Codex #5, 단지 경로가 아닙니다. 경로 전용은 false 신뢰가 될 것입니다.

CI `gen-skill-docs.ts` 워커에서 확인:
- v2.0.0.0 WARN 모드로 배송 - PR 요약에 기록된 orphans는 그러나 빌드 패스를 빌드합니다
- v2.1.0.0 (또는 v2.0 후에 2개의 방출 주기): WARN FAIL에 에스칼레이트
- Waiver: `<!-- eval: none — accept loss, reviewed YYYY-MM-DD by @user -->`

no semantics를 가진 필수 표기의 "주요 극장"을 피하고, 사용자의 전환 창을 제공합니다.

## 마이그레이션 접근 (v2.0.0.0, D11 당 점화기 접촉)

- v2.0.0.0 CHANGELOG의 릴리즈 노트는 섹션/ 형식 변경 및 콘크리트 사용자 영향에 대해 설명합니다. forks/copy-pasted SKILL.md 파일이 다시 그림이 필요합니다. 중량 기술의 첫 번째 주장은 ~200-500ms 섹션-읽는 대기 시간이 추가되었습니다.
- `/gstack-upgrade` 다음 invocation에 자동 재생. No 대화식 마이그레이션 프롬프트.
- 공급 설치는 세션에서 단일 한 줄 경고를 시작 첫 번째 v2 접촉 (기술 preamble에서 기존 공급 업체 제거 경고 패턴을 사용).
- `gstack-upgrade --explain-v2`는 수요에 대한 전체 설명을 원하는 사용자를 위한 플래그입니다.

## 포크 / 사용자 정의 호환성 (Codex #11)

v2.0.0.0 릴리스 노트에 문서화:

- reads/copies/edits가 중량 SKILL.md 파일을 직접 입력한 경우, 파일이 이제 골격이다; `sections/*.md`의 동작은 생명이다. 그들은 블랙 박스 (추천) 또는 `sections/`를 포함한 전체 `skill/` 디렉토리로 기술을 치료해야 한다.
- 로컬 SKILL.md.tmpl를 가진 누구나 포크에 편집합니다. 템플릿은 작습니다. 재 생성에 가능성이 높습니다. 이동 지도로 업데이트 된 포크 docs.
- 생성된 SKILL.md의 특정 줄에 링크하는 docs/blog 게시물을 가진 누구나: 줄 번호가 이동할 것입니다; 대신 템플릿 + 섹션 이름에 연결하는 것이 좋습니다.

## 롤아웃 전략 (Codex #12)

v1.45.0.0:
- PR의 땅; 기존 예산 회귀 테스트는 모든 per-skill 크기 회귀를 잡습니다; eval matrix CI는 어떤 기술든지 evals를 누락했습니다.
- Dogfood: 1 주 동안의 Garry의 작업 공간의 모든 맞은편에 사용.

v2.0.0.0:
- **수의 cohort**: v2.0.0-rc.1 태그를 통해 먼저 개식품 사용자 (Garry + active Agent)로 배송됩니다. Real-PTY 하네스 로그 섹션은 5 워크플로우 (`/ship`, `/qa`, `/review`, `/plan-ceo-review`, `/autoplan`); 필요한 섹션을 위한 읽을 수 있는 경고를 나타냅니다.
- **수동 검증**: 수동으로 상위 5개의 워크플로우가 v2.0.0.0 최종을 태깅하기 전에 실행됩니다./after 전문자열이 eval 기본으로 저장되었습니다.
- **Regression 대시보드**: 기존 `bun run eval:summary` v1 vs v2 per-skill token + 행동 준수 비교로 확장되었습니다.
- **롤백**: PR + `bun run gen:skill-docs` 재생 오래된 모양. CONTRIBUTING.md에서 문서화하는.

## 검토 단면도 발견 (집합되는 1-11년)

| Section | 의논하기 | Status |
|---|---|---|
| 1. 건축 | 건장한 습지 위험; 위 6 층 방어를 통해 mitigated | 계획에서 주소 찾기 |
| 2. 오류/Rescues | gen-skill-docs gate-fail 확성; 누락된 단면도는 skeleton로 돌아갑니다; CI orphan 체크 확성 | 자주 묻는 질문 |
| 3. 보안 | cso 대상 dedup not블랑켓 면제 (Codex #9); 마이그레이션 스크립트는 사용자 쉘 신뢰 경계에서 실행, 기존 마이그레이션과 동일 | 자주 묻는 질문 |
| 4. Data/UX 가장자리 케이스 | v1→v2 근육 메모리 휴식은 릴리스 노트에서 경고; 공급 업체는 한 줄 경고를 얻을; 동시 dev-symlink 세션 위험은 기존 CLAUDE.md caveat | 자주 묻는 질문 |
| 5. 코드 질 | ~150 LOC 첨가물 gen-skill-docs/types/index; ~20 새로운 eval 시험 파일; 단면도 적출은 기계적인 기계입니다 | OK |
| 6. 시험 | 단계 0 IS 시험 계획. 적용 모체 CI 문은 각 기술에는 그것의 evals가 있습니다 | 자주 묻는 질문 |
| 7. 성과 | 시간을 건설하십시오 <2× 현재; 주근깨는 단면도 중량을 위한 200-500ms 첫번째 주장을 추가합니다; 카탈로그 손질은 각 회의에 항상 적재한 신속한 크기를 감소시킵니다 | 의논문 |
| 8. 관측성 | 예산 회귀 시험은 이미 존재한다; 단계 B에서 교과식 조끼 성적표 기록; ~/.gstack/analytics/migrations.jsonl에 기록된 이동 결과 | 자주 묻는 질문 |
| 9. 배포 | 2 릴리스 분할 + warn-before-fail eval annotations + 롤백 반전 | 자주 묻는 질문 |
| 10. 장기 trajectory | Reversibility 3/5; 단면도/ 본은 미래 기술을 위한 템플렛이 됩니다; 방어적인 TODOs는 v2.1+를 위해 v2 narrative를 확장합니다 | OK |
| 11. 디자인/UX | README v2 기치 + CHANGELOG v2.0.0.0에 있는 숫자 테이블 땅; 구체적인 수, gstack 음성, no AI 사면 | OK |

## NOT 범위

- **기술 제거.** 사용자는 "모든 기능을." qa-only, 디자인-shotgun, 쌍 에이전트, 열려있는 gstack-browser 모든 체재 말했다. 그들은 evals + 카탈로그 손질을 다른 모든 것 같이 얻습니다.
- **기술 이름.** No `qa` → `qa-fix` 붕괴. CLI 표면 안정을 지키십시오.
- **gstack lite/pro 프로파일을 설치합니다.** 포스트 v2를 위해 TODOS에 Deferred.
- **gstack 예산 CLI.** 포스트 v2를 위해 TODOS에 Deferred.
- **README의 퍼스킬 eval 적용 배지.** TODOS에 Deferred.
- **크로스툴의 패시브 테스트/demo (Codex/Cursor compat).** TODOS에 Deferred.
- **토큰 코스트 미리보기 invocation.** TODOS에 Deferred.
- **기술 autoload 원격 측정.** TODOS에 Deferred.
- **gstack diff PR 댓글.** TODOS에 Deferred.

## TODOS.md 업데이트 (상품, 대량 추가 포스트 수지를 권장합니다)

| TODO | 주요연혁 | 노력 (인간 / CC) | 에 따라 |
|---|---|---|---|
| `gstack lite` 프로파일 설치 (5-skill 코어) | P2 | 2 일 / 3-4 시간 | 0.0.0.0의 |
| `gstack pro` 옵트인 업그레이드 경로 | P2 | 1일/1시간 | gstack 라이트 |
| `gstack budget` CLI (per-skill token 사용법 telemetry) | P2 | 1일/1시간 | 0.0.0.0의 |
| `gstack-skills list` + README의 퍼스킬 eval 적용 배지 | P3 | 1일/1시간 | 단계 0 |
| 크로스툴 포동성 시험/demo (Codex CLI, Cursor) | P3 | 2일 / 2시간 | 0.0.0.0의 |
| 기술 invocation에 대한 토큰 코스트 미리보기 | P3 | 1일/1시간 | gstack 예산 CLI |
| 기술 autoload 원격 측정 (dead-weight detection) | P3 | 2일 / 2시간 | 0.0.0.0의 |
| `gstack diff` PR 댓글 (PR 예산 델타 당) | P3 | 1일/1시간 | 예산 회귀 확장 |
| 사용자에 볼 수 있는 단면(confidence Signal) | P3 | 반일/30분 | C 단계 |

## 긴요한 파일

| Path | Change | Phase |
|---|---|---|
| `scripts/gen-skill-docs.ts` | 해결사 게이트 체크 (~line 444) 추가; config에서 설명_level을 읽으십시오; CI orphan walker를 추가하십시오 | A, C |
| `scripts/resolvers/types.ts` | `ResolverEntry` 조합 유형 추가 | ₢ 킹 |
| `scripts/resolvers/index.ts` | `appliesTo`를 가진 무거운 결실을 미리 짜십시오 (모든 21를 보십시오) | ₢ 킹 |
| `scripts/resolvers/preamble/generate-writing-style.ts` | 인라인 항아리를 대체하십시오; terse에 `''`를 돌려보냅니다 | ₢ 킹 |
| `scripts/resolvers/preamble/generate-completeness.ts` | terse에서 `''`를 반환합니다 | ₢ 킹 |
| `scripts/resolvers/preamble/generate-confusion-protocol.ts` | terse에서 `''`를 반환합니다 | ₢ 킹 |
| `scripts/resolvers/preamble/generate-context-health.ts` | terse에서 `''`를 반환합니다 | ₢ 킹 |
| `scripts/skill-catalog.ts` (새로운 또는 gen-skill-docs에서) | 원라인 카탈로그 발전기 + 음성 트리거 JSON 스플리터 | A.4.(아) |
| `scripts/proactive-suggestions.json` (새로운) | 음성 트리거 + proactive 제안, 수요에로드 | A.4.(아) |
| `test/skill-coverage-matrix.ts` (새로운) | 단일 소스 -of-truth eval 레지스트리 | 단계 0 |
| `test/skill-coverage-matrix.test.ts` (새로운) | CI 문: 각 기술에는 입장이 있습니다 | 단계 0 |
| `test/skill-e2e-*.test.ts` (~20개의 새로운 파일) | 현재 부족한 기술에 대한 새로운 evals | 단계 0 |
| `test/skill-e2e-budget-regression.test.ts` | per-skill 단단한 예산으로 확장 | A.6의 |
| `test/helpers/touchfiles.ts` | diff 기반 선택에 대한 새로운 테스트 등록 | 단계 0 |
| `ship/SKILL.md.tmpl` → `ship/sections/manifest.json` + `ship/sections/*.md` | Skeleton 추출 | ₢ 킹 |
| `plan-ceo-review/SKILL.md.tmpl` → 섹션/ | Skeleton 추출 | ₢ 킹 |
| `office-hours/SKILL.md.tmpl` → 섹션/ | Skeleton 추출 | ₢ 킹 |
| `plan-eng-review/SKILL.md.tmpl` → 섹션/ | Skeleton 추출 | ₢ 킹 |
| `plan-design-review/SKILL.md.tmpl` → 섹션/ | Skeleton 추출 | ₢ 킹 |
| `gstack-upgrade/migrations/v2.0.0.0.sh` (새로운) | 자동 재생 + 공급 업체 경고 | ₢ 킹 |
| `CHANGELOG.md` | v1.45.0.0 항목 (일반), v2.0.0.0 항목 (마케팅 등급 w / 숫자 테이블) | A, B |
| `README.md` | v2.0.0.0 배너; "가벼운 의견 기술 팩" 위치 | ₢ 킹 |
| `CONTRIBUTING.md` | 문서 섹션/ 패턴 + 롤백 절차 | ₢ 킹 |

## 인증

**v1.45.0.0:**
1. `bun run gen:skill-docs`는 no 오류로 성공
2. `bun test` 패스 (skill-validation, gen-skill-docs.test.ts, 통합 검색, NEW skill-coverage-matrix.test.ts)
3. `bun run test:evals` 패스 - 모든 새로운 게이트 evals 녹색; no 기존의 evals에 회귀
4. `bun run test:evals:periodic` 패스 — 새로운 시대의 시대 녹색
5. 카탈로그 시스템 검사 크기 측정 : 대상 ≤8K 토큰 (vs ~ 25K 현재). PR 본체의 앞에 캡처.
6. 총 SKILL.md 코푸 바이트 수: 대상 ≤1.3MB (vs 2.1MB). PR 몸에 붙잡음.
7. 100KB 이하의 3대 기술.
8. 수동 연기: `/ship`, `/plan-ceo-review`, `/office-hours` 신선한 Claude Code 회의에서; no 누락된 행동을 확인하십시오. v1.45 기본으로 transcript를 저장하십시오.

**v2.0.0.0:**
1. 모든 v1.45 체크 패스
2. 단면도 기술: 총 corpus ≤700KB; 중량 골격판 ≤30KB 각각
3. `test/skill-e2e-ship-section-loading.test.ts` (새로운): asserts `/ship` 결정 나무 당 예상된 단면도를 읽으십시오
4. 수의학: v2.0.0-rc.1에 1 주 개밥은 성적 기록으로; 표를 요구한 단면도를 위한 0개의 읽으십시오
5. 수동으로 확인된 상위 5개 워크플로; v1.45 기본에 비해 성적표
6. 마이그레이션: `gstack-upgrade` v1.45에 설치는 성공적으로 시프트없이 재생; 공급 업체 설치 경고 한번 나타납니다
7. CHANGELOG 숫자표 일치 측정된 현실
8. WARN-mode orphan check: PR 요약은 orphan 명부를 보여줍니다; 빌드 패스

## Cross-model 계약은 구운

Codex의 리뷰에서 항목은 위에서 승인 및 통합됩니다.

- #4 워튼 베포에 파일 이벌 연고 (상 C)
- #5 음소거 주석에 덮음 semantics, 단지 경로
- #6 카탈로그 손질은 단계 A (섹터 후에 매장된)로 이동했습니다
- #9 cso get resolver dedup + 카탈로그 트림 (보통 제외)
- #10 하드 token 예산 정의 + 시행 (상 A.6)
- #11 포크/customization 호환성 문서화 (Migration 단면도)
- #12 카나리아 코호트 + 수동 top-5-workflows 검증 (Rollout section)과 롤아웃 전략

Codex의 리뷰에서 명시적으로 거부된 사용자 (D9, D10):
- #1 Eval-first 범위: 사용자는 전체 계층 적용을 유지. 구조적 eval 지도 (출력 내용 아닙니다)에 의해 orphan/judgment 기술에 의해 마이그레이션.
- #7 v2.0.0.0 vs v1.x: 사용자는 HYBRID를 선택했습니다. v1.45는 낮은 잔류물 승리를 흡수합니다; v2.0.0.0는 진짜로 끊는 단면도/변화를 나릅니다.

사용자가 원본 픽업에 Codex를 허용하는 항목:
- #8 마이그레이션 접근: 사용자는 더 가벼운 접촉에 단단한 커트 (D7)에서 한 번 v1.45에 한 번 v1.45에 움직입니다 낮잠 일.

## 구현 작업

이 리뷰의 결과에서 합성. 특정 단계/finding에서 각 작업 파생. T1-T8 v1.45.0.0의 토지; T9-T16 토지 v2.0.0.0.

- [ ] **T1 (P1, 인간: ~3 일/CC: ~7 시간)** - 단계 0/범위 매트릭스 - 범위 부족 모든 20개의 기술에 대한 gate+periodic evals를 작성
  - 표면 처리: 단계 0 단면도
  - 파일: `test/skill-coverage-matrix.ts`, `test/skill-coverage-matrix.test.ts`, ~20 새로운 `test/skill-e2e-*.test.ts`, `test/helpers/touchfiles.ts`
  - 검증: `bun test test/skill-coverage-matrix.test.ts`와 `bun run test:evals` 두 패스 모두 새로운 evals
- [ ] **T2 (P1, 인간: ~1 일/CC: ~1 시간)** — A.1 상태 해결사 주입 - `appliesTo` 문을 추가하십시오
  - 표면: 단계 A 단면도, Codex #10 (건축의 앞에 측정)
  - 파일: `scripts/resolvers/types.ts`, `scripts/gen-skill-docs.ts:444`, `scripts/resolvers/index.ts`
  - 검증: `bun run gen:skill-docs`는 SKILL.md 파일을 더 작게 생성합니다; `bun test`는 통과합니다
- [ ] **T3 (P1, 인간: ~half 일/CC: ~30 분)** — A.2 + A.3 jargon dedup + terse-mode gen-time 압축
  - 표면 처리: 단계 A 단면도
  - 파일: `scripts/resolvers/preamble/generate-writing-style.ts`, `generate-completeness.ts`, `generate-confusion-protocol.ts`, `generate-context-health.ts`
  - 검증: jargon-list no는 생성된 SKILL.md에서 더 긴 것에서 일렬로 세웁니다; `gstack-config set explain_level terse && bun run gen:skill-docs`는 더 짧은 파일을 일으킵니다
- [ ] **T4 (P1, 인간: ~1 일/CC: ~2 시간)** — A.4 카탈로그 트림 - 일렬로 기술 설명; 음성 트리거 + 유동 단락은 JSON로 이동
  - 표면 처리: Codex #6 (최고 leverage), 단계 A.4
  - 파일: `scripts/skill-catalog.ts` (새로운), `scripts/proactive-suggestions.json` (새로운), per-skill SKILL.md.tmpl frontmatter for one-line description field
  - 검증: 카탈로그 시스템-prompt 크기 <8K 토큰; 음성-triggered invocation 여전히 작품
- [ ] **T5 (P1, 인간: ~half 일/CC: ~30 분)** — 예산 회귀에 있는 A.6 단단한 token 예산
  - Surfaced by: Codex #10
  - 파일: `test/skill-e2e-budget-regression.test.ts`
  - 검증: 인공 팽창된 시험 SKILL.md가 예산을 초과할 때 예산 회귀가 실패
- [ ] **T6 (P1, 인간: ~1 일/CC: ~1 시간)** — A.5 cso 결심자 dedup + 카탈로그 손질 (NOT 더 넓은 압축)
  - Surfaced by: Codex #9
  - 파일 : `cso/SKILL.md.tmpl` (no 구조 변경, 만 해결자 문 감사)
  - 검증: cso SKILL.md 크기 하락 20-30%; cso E2E evals는 아직도 통행을 떨어뜨립니다
- [ ] **T7 (P1, 인간: ~1 일/CC: ~1 시간)** - 모든 SKILL.md 원자로 + 측정 재생
  - 표면 처리: 단계 A
  - 파일: 모든 `*/SKILL.md` 재생
  - 검증: PR 본체는 이전 /after corpus 크기, 최고 10의 기술 크기, 카탈로그 크기가 포함되어 있습니다; 예산 회귀는 목표가 만나는 것을 확인합니다
- [ ] **T8 (P2, 인간: ~half 일/CC: ~30 분)** — v1.45.0.0 CHANGELOG 입력 (정상적인 음성; 착륙되는 단계 0 + 단계)
  - 표면 처리: 방출 모양 단면도
  - 파일: `CHANGELOG.md`, `VERSION`
  - 검증: CHANGELOG lints clean; 역 크로노 주문 보존; 항목은 diff를 다룹니다

- [ ] **T9 (P1, 인간: ~2 일/CC: ~3 시간)** - 단계 B.1는 선을 개조하고/Shelton + 단면도에/
  - 표면 처리: 단계 B 단면도
  - 파일: `ship/SKILL.md.tmpl` → 골격; `ship/sections/manifest.json` + `ship/sections/*.md`
  - 검증: 새로운 `test/skill-e2e-ship-section-loading.test.ts` asserts 예상된 결정 나무 당 읽습니다; 기존의 배 evals 통행; ship.md skeleton <15KB
- [ ] **T10 (P1, 인간: ~1 일/CC: ~1 시간)** — 배를 위한 군집 조끼/ (v2.0.0-rc.1)에 1 주 개음식
  - 표면 처리: 롤아웃 전략 섹션, Codex #12
  - 파일: `test/helpers/transcript-section-logger.ts` (새로운)
  - 검증: 0 개식품 성적표에 대한 읽기 - 계산
- [ ] **T11 (P1, 인간: ~2 일/CC: ~3 시간)** - B.2 단계는 계획 -ceo-review/ (선생 후에)를 개조합니다
  - 표면 처리: 단계 B 단면도
  - 파일: `plan-ceo-review/SKILL.md.tmpl` + `plan-ceo-review/sections/`
  - 검증: 단면 로드 테스트 그린; 계획-ceo evals 패스
- [ ] **T12 (P2, 인간: ~3 일/CC: ~4 시간)** - B.3 + B.4는 사무실 시간 + 계획 - eng-review/+ 계획 설계 -review/를 개조합니다
  - 표면 처리: 단계 B 단면도
  - 파일: 각각 `SKILL.md.tmpl` + `sections/` 디렉토리
  - 검증: 단말 로드 테스트 녹색; 각 evals 패스
- [ ] **T13 (P1, 인간: ~1 일/CC: ~1 시간)** - C eval 표기 + WARN-mode CI orphan check
  - 표면: 단계 C 단면도, Codex #4 + #5
  - 파일: `scripts/gen-skill-docs.ts` (또는phan walker), 모든 `sections/*.md` (지속 하수구를 가진 표기)
  - 검증: orphan check report 정확하게 PR 요약; 빌드는 여전히 WARN 모드로 전달
- [ ] **T14 (P1, 인간: ~half 일/CC: ~30 분)** — `gstack-upgrade/migrations/v2.0.0.0.sh` 점화기 접촉 자동 재생
  - 표면 처리 : 마이그레이션 접근 섹션
  - 파일: `gstack-upgrade/migrations/v2.0.0.0.sh`
  - 검증: v1.45에서 업그레이드는 프롬프트없이 깨끗한 v2 상태를 생성합니다. 공급 업체는 한 줄 경고를 가져옵니다.
- [ ] **T15 (P1, 인간: ~half 일/CC: ~1 시간)** — v2.0.0.0 마케팅 등급 CHANGELOG v1 대 v2 숫자 테이블
  - 표면 처리 : D5, 릴리스 모양, Codex #7 (실내 파손 문서화)
  - 파일: `CHANGELOG.md`, `VERSION`, `README.md` (v2 기치)
  - 검증: 숫자 표 일치 측정된 corpus; 방출 주 문서 콘크리트 파손 (구/ 체재 변화, 첫번째 invocation latency, 납품업자 설치 deprecation); 위치 과거 tenses bloat 명성
- [ ] **T16 (P2, 인간: ~1 일/CC: ~1 시간)** - TODOS.md (gstack 빛, gstack 예산, 등)에 부피 추가 9 deferred TODOS
  - 표면 처리: TODOS.md 업데이트 섹션
  - 파일: `TODOS.md`
  - 검증: TODOS 형식 일치 `.claude/skills/review/TODOS-format.md`

## 실패 모드 레지스트리

| 비밀번호 | 실패 형태 | 구출? | 시험? | 사용자 참조 | Logged |
|---|---|---|---|---|---|
| gen-skill-docs.ts 게이트 체크 | 해결자 `appliesTo` 던지기 | Y — try/catch 로그 + 스트립터 건너뛰기 | Y (test/gen-skill-docs.test.ts 확장) | "resolver X 오류, Skipped" 내장 출력 | stderr |
| 부분/런타임에 읽기 | 섹션 파일 누락 | Y - 에이전트는 skeleton-only 행동으로 돌아갑니다. | Y (/skill-e2e-ship-section-loading.test.ts) | 의약 prose | 세션 성적표 |
| CI 또는 판 워커 | 섹션/*.md 누락된 eval 주석 | WARN 모드 v2.0; FAIL v2.1+ | Y (/skill-coverage-matrix.test.ts) | PR 요약 목록 orphans | PR 댓글 |
| 마이그레이션 스크립트 v2.0.0.0.sh | regenerate 손상된 설치에 실패 | Y — 스크립트 aborts, 수리 단계 인쇄 | Y (이동 시험) | clear error + 수리 단계 | ~/.gstack/analytics/migrations.jsonl |
| 카탈로그 1 선 발전기 | 기술이 frontmatter에 대한 원라인 설명이 누락되었습니다. | Y — gen-skill-docs는 크게 구축하지 못했습니다. | Y (gen-skill-docs.test.ts 확장) | 오류 수정 | stderr |
| Canary 단면도-읽기 logger | 중력 기술에 대한 로거 누락 | Y — 조용히 건너 뛰고, 갭은 대쉬보드에서 볼 | Y (transcript-logger 테스트) | none 직접; canary 대쉬보드에서 표면 처리 | ~/.gstack/analytics/section-reads.jsonl |

No 긴요한 간격 — 각 실패 형태에는 구조, 시험 및 시정이 있습니다.

# # # 다이어그램

시스템 아키텍처 (빌리티 파이프라인):
```
  CONFIG (~/.gstack/config.yaml)
     |
     v
  +-----------------+      +--------------------+
  | gen-skill-docs  | <--- | resolvers/*.ts     |
  | (with gate)     |      | (w/ appliesTo)     |
  +-----------------+      +--------------------+
     |
     v
  +--------------------------+
  | SKILL.md.tmpl per skill  |
  | + sections/manifest.json | (heavyweights only, v2)
  | + sections/*.md          | (heavyweights only, v2)
  +--------------------------+
     |
     v
  +--------------------+         +--------------------------+
  | generated SKILL.md | <-----> | scripts/jargon-list.json |
  | (skeleton for      |         | (referenced, not inlined)|
  |  heavyweights v2)  |         +--------------------------+
  +--------------------+
     |
     v
  +-------------------+      +----------------------+
  | catalog (system   | <--- | proactive-suggestions|
  |  prompt, one-line |      | .json (loaded on     |
  |  per skill)       |      |  demand only)        |
  +-------------------+      +----------------------+
```

단면도 독서 교류 (v2 주작동 시간):
```
  USER /ship
     |
     v
  +-----------------------+
  | ship/SKILL.md         |
  | (12-15KB skeleton)    |
  | reads:                |
  |  - manifest.json      |
  |  - decision tree      |
  +-----------------------+
     |
     v  Agent walks decision tree, identifies which sections apply
     |
     +-----> Read sections/version-bump.md   (if bumping)
     +-----> Read sections/changelog.md      (if writing entry)
     +-----> Read sections/review-army.md    (if pre-ship review)
     +-----> ... only sections that apply
     |
     v
  +-------------------------+
  | end-of-skill self-check |
  | "list sections I read"  |
  +-------------------------+
     |
     v  Canary cohort: transcript-section-logger compares
     |  actual Reads vs manifest's required_for declarations
     |  alerts on miss
```

## Stale 다이어그램 감사

ASCII CLAUDE.md/ ARCHITECTURE.md 이 계획은 영향을 미칩니다:

| 디아그램 | File | 아직도 정확한 포스트 v2? |
|---|---|---|
| Sidebar 메시지 흐름 | `docs/designs/SIDEBAR_MESSAGE_FLOW.md` | YES (관련 하위 시스템) |
| 이중 감속기 터널 건축 | `ARCHITECTURE.md` | YES (관련) |
| 서버 egress에서 Unicode 위생 | `ARCHITECTURE.md` | YES (관련) |
| (none 기술 구축 파이프라인) | — | 위의 새로운 다이어그램은 NEW, 업데이트되지 않습니다. |

No stale 다이어그램을 수정합니다.

## 완료 요약

```
+====================================================================+
|            MEGA PLAN REVIEW — COMPLETION SUMMARY                   |
+====================================================================+
| Mode selected        | SCOPE EXPANSION                              |
| System Audit         | bloat externally documented; prior design   |
|                      | doc unrelated; budget-regression infra exists|
| Step 0               | EXPANSION + Approach C + eval-first +       |
|                      | hybrid v1.45/v2.0 split + lighter migration |
| Section 1  (Arch)    | 1 finding — silent-loss risk, 6-layer mit   |
| Section 2  (Errors)  | 6 failure modes mapped, 0 CRITICAL GAPS     |
| Section 3  (Security)| cso targeted dedup (Codex #9 absorbed)      |
| Section 4  (Data/UX) | v1→v2 muscle memory warned, vendored noted  |
| Section 5  (Quality) | ~150 LOC additive, mechanical extraction    |
| Section 6  (Tests)   | Phase 0 IS the test plan                    |
| Section 7  (Perf)    | <2× build time; +200-500ms first-invoke v2  |
| Section 8  (Observ)  | budget-regression + canary + migrations.log |
| Section 9  (Deploy)  | 2-release split + warn-before-fail + revert |
| Section 10 (Future)  | Reversibility 3/5; sections/ becomes template|
| Section 11 (Design)  | README banner + numbers table              |
+--------------------------------------------------------------------+
| NOT in scope         | written (9 items deferred)                   |
| What already exists  | written (9 reuse points)                    |
| Dream state delta    | written (TODAY / v1.45 / v2.0)              |
| Error/rescue registry| 6 modes, 0 CRITICAL GAPS                    |
| Failure modes        | covered in registry                         |
| TODOS.md updates     | 9 items, bulk-add post-merge                |
| Scope proposals      | 3 surfaced, 1 accepted (launch positioning) |
| CEO plan             | this plan IS the CEO plan                   |
| Outside voice        | ran (codex); 3 tensions surfaced            |
| Lake Score           | 11/11 recommendations chose complete option |
| Diagrams produced    | 2 (build pipeline, section-read flow)       |
| Stale diagrams found | 0                                           |
| Unresolved decisions | 0                                           |
+====================================================================+
```

## Eng-review 추가(/plan-eng-review 세션에서)

## # 건축 결정은 잠겨

- **D1 (manifest 체재):** `sections/manifest.json` is the structured per-heavyweight registry (JSON, machine-readable for gen-skill-docs CI checks). SKILL.md skeleton is markdown headers + imperative prose blocks ("STOP. If X, Read `sections/Y.md`"). Matches Anthropic's documented `references/` style. No invented DSL.
- **D2 (drift 통제):** `sections/*.md.tmpl`는 진실의 근원입니다; `sections/*.md`는 생성됩니다. gen-skill-docs는 `<skill>/sections/*.tmpl`를 걸고 SKILL.md로 동일한 결심관을 사용하여 `<skill>/sections/*.md`를 쓰습니다. 비용: ~30 LOC에서 `scripts/gen-skill-docs.ts`. `test/ship-version-sync.test.ts`가 이미 고통 받는 편류 종류 상승합니다 (TODOS:1120).
- **D3 (CI 비용 모자):** `EVALS_BUDGET_HARD_CAP=$30` env var `test/skill-e2e-budget-regression.test.ts`; 빌드는 단 하나가 초과하는 경우에 실패합니다. 단면도 선적 시험 (단계 B) 사용은 (각 0.30를) 그것 assert STRUCTURAL 행동 때문에 최소한 배치 정착물 (~ $ 0.30를) 이용합니다 (맞는 파일 보기를 읽으십시오?) 산출 질.

### Adjacent TODOS 표면 처리 (작용하지 않는,)

- **TODOS:161** - 브라우저 스킬 (P2)에 대한 "반응자 주사" 계획. 이 계획의 `appliesTo` predicate와 함께 건축 오버랩이 있습니다. 결정: 이제 별도 유지 - 브라우저 스킬 해결자 주입은 실행 시간 (제목 별 호스트 이름 일치); 우리의 `appliesTo`는 빌드 시간 (gen-skill-docs.ts)입니다. 다른 생명주기, 다른 우려. 브라우저 스킬의 사전 스킬에 대한 필요성만 다시 볼 수 있습니다.
- **TODOS:1120** — `test/ship-version-sync.test.ts`는 ship/SKILL.md.tmpl 단계 12 bash를 다시 간단히 합니다. D2 (sections/*.md.tmpl 파이프라인)는 구조적인 고침입니다. 단계 B는 이 TODO를 비난합니다; 배 적출 땅 때 해결되는 표.
- **TODOS:1136** — `git show`는 ship/SKILL.md.tmpl 단계 12 선 409에 있는 내리. 단계 B는 이것을 접촉합니다; 묶습니다 `git rev-parse --verify`는 버전 범프 단면도 적출으로 고침.

### 시험 계획 artifact

`~/.gstack/projects/garrytan-gstack/garrytan-garrytan-slim-skill-tokens-eng-review-test-plan-<timestamp>.md`로 작성된 테스트 계획. `/qa`와 `/qa-only`는 1 차적인 시험 입력으로 이것을 소모합니다. 덮개: 상한 시험 적용 표적, 단면도 적재 시험을 위한 정착물 디자인, CI 예산 강제 검사, 이동 둥근 지구 시험.

### 실패 모드 추가

§Failure Modes (읽힌 완전한; 새로운 행)의 레지스트리에 추가:

| 비밀번호 | 실패 형태 | 구출? | 시험? | 사용자 참조 | Logged |
|---|---|---|---|---|---|
| 섹션/*.md.tmpl 발전기 | 템플릿 참조 누락 된 해결자 | Y — gen-skill-docs는 크게 구축하지 못했습니다. | Y (gen-skill-docs.test.ts 확장) | 오류 수정 | stderr |
| Manifest ↔ 파일 시스템 | 존재하지 않는 참조 섹션 파일 | Y - CI 체크 실패 | Y (새로운 `test/section-manifest-consistency.test.ts`) | 오류 수정 | PR 요약 |
| Manifest ↔ 파일 시스템 | 섹션 파일은 존재하지 않지만 (orphan) | WARN v2.0; FAIL v2.1+ | Y (사임 테스트) | PR 요약 | PR 댓글 |
| 예산 캡 초과 | 단일 테스트 또는 골재는 `EVALS_BUDGET_HARD_CAP`를 초과합니다. | Y - CI 실패 | Y (확장-재격 연장) | 오류 w/비용 고장 | stderr |

아직도 0개의 긴요한 간격. 모든 새로운 실패 형태는 + 시험 + 시정을 구출합니다.

## 실행 sequencing (sequential v1.45, 통합 브레이크 v2.0)

v1.45 runs **의논하기** in a single branch, T1 → T8. The parallelization map was reconsidered after codex's second-pass critique flagged that T2 (gen-skill-docs.ts TemplateContext changes) and T4 (catalog frontmatter additions) almost certainly touch each other at compile time — both branches passing alone, failing at integration. Sequential lands cleaner and avoids 3-way merge surprise. AI compression makes the wall-clock cost of sequential acceptable.

| Step | 모듈 터치 | 에 따라 |
|---|---|---|
| T1 단계 0 evals (~20 파일) | `test/skill-e2e-*.test.ts`, `test/skill-coverage-matrix.ts`, `test/helpers/touchfiles.ts` | — |
| T2 조건부 결선 문 | `scripts/gen-skill-docs.ts`, `scripts/resolvers/types.ts`, `scripts/resolvers/index.ts` | T1 |
| T3 jargon dedup + terse 압축 | `scripts/resolvers/preamble/*` | T2 |
| T4 카탈로그 트림 | `scripts/skill-catalog.ts`, `scripts/proactive-suggestions.json`, SKILL.md.tmpl frontmatter | T2 |
| T5 단단한 token 예산 + 과다한 경로 | `test/skill-e2e-budget-regression.test.ts` (퍼 스위트 캡 + `EVALS_BUDGET_OVERRIDE_REASON`) | T1 |
| T6 cso 대상 탈춤 | `cso/SKILL.md.tmpl` | T2, T3 |
| T7 모든 SKILL.md 원자로 재생 | 모든 `*/SKILL.md` | T1-T6 |
| T8 v1.45 CHANGELOG | `CHANGELOG.md`, `VERSION` | T7 |
| **— v1.45.0.0 배 경계 —** |  |  |
| T9 배/섹션/출산 | `ship/SKILL.md.tmpl`, `ship/sections/*`, gen-skill-docs (구스프롤 w/ TemplateContext 컨트랙트) | T8 + 섹션 파이프 (T2/D2) |
| T10 배/캐나다 cohort | `test/helpers/transcript-section-logger.ts` | T9 |
| T11 플랜소매장/ | `plan-ceo-review/SKILL.md.tmpl` + 섹션 | T10 (선생/신생) |
| T12 사무실 시간 + 계획 - eng + 계획 디자인 단면도/ | 각 감독 | T11 |
| T13 단계 C eval 표기 + 3 층 orphan 체크 | gen-skill-docs.ts orphan walker, 모든 섹션/*.md | T9-T12 |
| T14 마이그레이션 스크립트 | `gstack-upgrade/migrations/v2.0.0.0.sh` | T13 |
| T15 v2.0.0.0 CHANGELOG + README 배너 | `CHANGELOG.md`, `README.md`, `VERSION` | T14 |
| T16 TODOS 부피 추가 | `TODOS.md` | - 언제나 |

**실행 권고:** v1.45 (T1→T8)와 v2.0 (T9→T15) 둘 다를 위한 단 하나 worktree 순차. T16 땅은 할 때마다. CC speedup는 수직 분대에서 (각 단계는 인간 일 대 ~1 시간입니다), 평행한 분대에서 옵니다.

## Codex 추가 상담 (두 번째 패스, eng-review)

## 대성당 패리티 - 타원형 스위트 (상 0 추가, "11"로 확장)

사용자는 "그것을 좋아하지 않는 11, 단지 10. 최대 그것 밖으로 그리고 그 후에 몇몇" 라고 말했습니다. 최대 밖으로 범위:

- **ALL 31 기술** 황금베이스 성적표 (위 5)를 얻으십시오
- **기술 당 다수 정착물** (각 3-5명의 대표직업 경로)
- **양이 많은 + qualitative 득점:** LLM-as-judge similarity score (1-10) AND transcript-diff 하이라이트 (added/removed 단면도, 누락된)
- **측정되는 토큰 효율성 비율:** 품질에 의하여 = 판단_점수 / 토큰_consumed (v2를 measurably MORE 능률적으로, 다만 더 작지 않기 위하여 강화하십시오)
- **"token 예산과 함께 "품질 예산"":** 둘 다 CI에서 시행했습니다. 절반 크기로 압축되는 v2 기술은 9/10 질에서 6/10에 문이 실패합니다.
- **Side-by-side PR comment:** 모든 PR는 중량 기술 자동 포스트를 PR 요약에 있는 현재 동위 비교를 위한 v1.45 기초 대를 자동 포스트합니다
- **공중 벤치 마크 페이지:** `gstack.benchmarks.md` (새로운), 지속적으로 업데이트. 퀄리티: "v2 평균 파열 점수: 9.2/10, 평균 token 감소: 67%."
- **지속적인 감시:** 패리티 스위트는 주중에 매주 실행됩니다. 기본 라인 아래 기술 무인 경우 경고 (Discord webhook 또는 이와 유사한)
- **Baseline-capture 스크립트:** `test/helpers/capture-parity-baseline.ts` — v1.44 HEAD에서 한 번 실행하여 어떤 단계 A 작업 땅의 앞에 황금 성적에 잠그십시오

Effort: 인간 ~3-4 일/CC ~6-8 시간 일회성 + ~$30/week 지속적인 지속적인 감시. 비용은 단화됩니다 — 이것은 “녹색을 붙잡는 것”을 붙잡는 ONLY 기계장치, 더 나쁜 것” 침묵하는 회귀는 단면도 적재하고 예산 시험 둘 다 놓습니다. 새로운 작업 T0a (기초 붙잡음) 및 T0b (대기 eval 마구) BEFORE T1를 추가하십시오.

### codex 상담에서 정유소를 흡수 (no 더 많은 사용자 결정 필요)

1. **TemplateContext 계약 섹션 파이프 라인 (codex D2 critique):** T9에 요구되는 명시된 spec. 단면도 발생은 SAME `TemplateContext`로 SKILL.md 발생과 같은 `skillName`, 동일한 호스트 억제, 동일한 `explainLevel`, 동일한 층 등급으로 사용됩니다. 코드 의견에 문서화 + `test/template-context-parity.test.ts` (새로운)에 의해 asserted.
2. **3-tier orphan 분류 (codex orphan-semantics critique):** CI 체크 (T13)는 구별합니다:
   - **운영 및** (`sections/foo.md`는, no `sections/foo.md.tmpl`) → FAIL 즉시, 각 방출 존재합니다
   - **맨투맨** (`sections/foo.md.tmpl`는 `manifest.json`) WARN v2.0에서 FAIL, v2.1+에 있는 FAIL에서 존재하지 않는 존재합니다
   - **손 편집 된 생성 된 파일** (`sections/foo.md` diverges from what regen would produce) → FAIL immediately, with "this file is generated, edit `.tmpl` instead" message
3. **예산 캡 오버라이드 경로 (codex D3 critique):** `EVALS_BUDGET_HARD_CAP=$30`는 default; `EVALS_BUDGET_HARD_CAP_GATE=$25`, `EVALS_BUDGET_HARD_CAP_PERIODIC=$70`를 통해 각 스위트 캡; 모자를 초과해야 하는 역률 `EVALS_BUDGET_OVERRIDE_REASON="<text>"` env를 초과하는 것을 요구했습니다 (CI는 감사 흔적을 위한 산출에 있는 이유를 인쇄합니다); 기존 분석 (`~/.gstack/analytics/skill-usage.jsonl` 집계를 통해 매일 org 수준 급여 경고.
4. **수동 데이터로 Manifest (codex D1 critique):** `manifest.json` 필드는 ID, 파일 경로 및 인간 읽기 쉬운 트리거 텍스트 ONLY입니다. No `applies_when` 사전. 기술 골격의 결정 트리 프로세스는 ONLY 장소 "X를 읽을 때" 결정됩니다. 계층 - 게팅 + `appliesTo` + `requiredReads`와 함께 네 번째 조건 언어를 발명하지 마십시오.
5. **T7 통합 브레이크 흐름 (codex 평행화, 이제 순차적으로 비난):** 순차적 실행은 T7는 단 하나 v1.45 branch 내에 원자 재생됩니다." 통합 브레이크 댄스가 필요하지 않습니다. critique의 의도 (no 3-way merge 놀람)는 순차적으로 갈아서 명명됩니다.

## 새로운 실패 모드 (참고자)

| 비밀번호 | 실패 형태 | 구출? | 시험? | 사용자 참조 | Logged |
|---|---|---|---|---|---|
| 섹션 파이프라인 TemplateContext | divergent ctx (예: 잘못된 기술 이름)로 생성 된 섹션 | Y - 패리티 테스트 실패 | Y (`test/template-context-parity.test.ts`) | 오류 수정 | stderr |
| 손 편집 된 생성 된 섹션 | `sections/foo.md`를 `.tmpl` 대신 직접 편집합니다. | Y - CI는 명시된 메시지로 실패 | Y (orphan-check 3-tier 분류) | "이 파일은 생성되어 `.tmpl`를 대신 편집합니다" | PR 요약 |
| 품질 예산 초과 | v2 기술은 압축하지만 떨어졌다 >2 포인트에 LLM-judge 패티 | Y - CI 실패 | Y (파리티 - 타원형 스위트) | "v2 X.md 9.2에서 6.4 대 v1.45 기본"로 떨어졌다 | PR diff로 댓글을 달기 |
| 예산 캡 override 감사 | EVALS_BUDGET_OVERRIDE_REASON 사용 | N (실내 탈출 밸브) | Y (audit-log 테스트) | CI 출력에서 인쇄된 이유, 지출에 기록된 jsonl | analytics/spend-overrides.jsonl |
| 주요에 Parity 기본선 편류 | 주간 연속 모니터는 회귀를 감지 | Y — Discord alert + 티켓 | Y (지속성 모니터 테스트) | 팀 채널에 경고 | analytics/parity-drift.jsonl |

아직도 0 긴요한 격차.

## v2 발사 사본 specs (/plan-devex-review에서)

이 초안은 v2.0.0.0 출시 톤에 대한 진실의 소스가되었습니다. T15는 동사적 (배 시간에 워크샵을하지 않는 것은 상당히 더 나은 걸릴을 생산합니다. 이 경우 잠금 단계에서 계획과 구현을 업데이트하십시오).

## JUST_UPGRADED 공지 (Persona A — 기존 사용자 업그레이드)

`JUST_UPGRADED v1.x v2.0.0.0`를 보여주는 `gstack-update-check`에 의해 트리거. 일반적인 v1 "Running gstack v{to} (단일 업데이트!)"를 대신하여 인식 속도 승리 AND 신호를 "당신의 근육 기억은 여전히 작동"이라는 이름의 인가 A-aware 복사를 사용합니다.

```
Running gstack v2.0.0.0 (just updated!) — your sessions are now ~67% lighter.
Heavyweight skills load only the sections they need; the catalog dropped to
one line per skill. Everything still works the same way — your /ship, /qa,
/review commands haven't changed. Run `/gstack-upgrade --explain-v2` for the
full migration story, or just keep working.
```

음성 규칙은 다음과 같습니다. 승리 ("67% 점화기"); 콘크리트 번호; 워크플로우가 변경되지 않는 재조절 ("이제는 여전히 같은 방법을 작동"); 해치 탈출 (`--explain-v2`). No 엠 dashes. 5 초에 참석.

구현 : 업데이트 `~/.claude/skills/gstack/gstack-upgrade/SKILL.md.tmpl` v2-aware 메시지와 인라인 업그레이드 흐름; 기존 `JUST_UPGRADED <from> <to>` 기술에 대한 감지가 불을 움직입니다.

## CHANGELOG 숫자표 (페소나 A의 마법 순간 + Persona B의 평가 증거)

`## [v2.0.0.0]` 항목의 CHANGELOG.md, 즉시 헤드 라인 아래. 측정된 v1.44 실제 (기본값은 `test/helpers/capture-parity-baseline.ts` BEFORE 단계 A 시작) vs v2.0.0.0 측정. 숫자는 REAL, 예상되지 않음; T15 동안 위주를 대체하십시오.

| Metric | v1.44.1 (기본) | v2.0.0.0 (측정되는) | Δ |
|---|---|---|---|
| 총 SKILL.md 코푸 | 2.1 MB | ~700 KB | **−67%** |
| ship.md (가장) | 164 KB | ~15 KB 골격 + 5×~5 KB 단면도 | **−76% 첫 번째-독** |
| plan-ceo-review.md | 131 KB | ~12 KB 골격 + 수요에 대한 섹션 | **−68% 첫 번째-독** |
| office-hours.md | 111 KB | ~10 KB 골격 + 수요에 단면도 | **−71% 첫 번째-독** |
| 카탈로그 토큰 (always-loaded system prompt) | ~25K 토큰 | ~6K 토큰 | **−76%** |
| 퍼-인크 토큰 (일반 /ship 세션) | ~41K(일) | ~14K 스켈레톤 + 주문형 섹션 | **~60% 하락** |
| Eval 적용 (E2E 보호와 함께 skills) | ~16 의 31 | **31 + 패리티 기본** | 품질문 활성화 |
| 비만 점수 vs v1.44 기본 (LLM 심사위원, 모든 31 기술) | — | **≥9.0/10 floor** | (CI-enforced; parity-eval suite)를 참조하세요. |

테이블 아래, gstack 음성의 한 단락: "v1는 가장 무거운 의견 기술 팩이었다. v2는 가장 가벼워. 압축은 자유롭지 않습니다 - 양쪽 게이트 계층과 정기적 계층 E2E evals, 연속 패리티 모니터 잡음 모두와 모든 기술 배. 위의 숫자는 `test/helpers/parity-baseline-v1.44.1/`에 대해 측정하고 `bun run eval:parity`에 의해 재제작된다.

### README v2 배너

배치: README.md의 정상, 기존 Karpathy 잡아당기기 인용의 밑에, “카를로비가 이것을 말할 때...” 60 일 포스트 발사를 위한 장소에 있는 체재, 그 후에 빠른 시작 단면도에 있는 1 선 “v2 풀어 놓는 5월 2026” 입장에 붕괴합니다.

```markdown
> **gstack v2.0.0.0 — the lightest opinionated skill pack (May 2026)**
>
> Heavyweight skills now load only the sections they need. Total SKILL.md
> corpus dropped from 2.1 MB to ~700 KB. Every skill ships with E2E eval
> protection and a continuous parity-monitor against v1.44 baselines.
> See the [v2.0.0.0 release notes](CHANGELOG.md) for per-skill numbers and
> the migration story. Existing users: `/gstack-upgrade` auto-regenerates.
```

음성 규칙은 명예를 줬습니다: 위치 (" 가장 가벼운 의견 기술 팩"로 지도하십시오); 구체적인 수 (2.1 MB → 700 KB); 의장 (eval 보호 + parity 감시자); migration 경로는 표현했습니다. No em dashes. 10 초에 원조해.

### 구현 노트 (T15)

- 실제 v1.44 기본 번호를 `test/helpers/parity-baseline-v1.44.1/` BEFORE 단계 재생 시작으로 잠금하십시오. v1.44가 동일한 단위에서 측정 된 경우 "v1 vs v2" delta 만 인용하면됩니다 (token 을 통해 `wc -c`, `test/skill-coverage-matrix.ts`를 통해 eval 적용을 통해 byte 수.
- 측정된 v2 숫자가 LESS에 있는 경우에 (예를들면, ship.md는 15 KB 대신 25 KB에서 끝납니다), 를 반영하는 초안을 새롭게 합니다. 결코 발명한 수; 마케팅 급료 배 순간은 순간 독자가 `wc -c`로 쫓을 수 있는 수를 찾아낼 수 있는 수를 찾아냅니다.
- JUST_UPGRADED 기존 `gstack-upgrade` 검출을 통해 자동으로 화재를 발견합니다. no 새로운 메커니즘이 필요합니다.
- 기존 Karpathy 인용 위의 README 배너 배치는 의도적이다 : persona B (새로운 증발기)는 V2 승리를 참조하십시오 BEFORE Karpathy framing, 앵커 "이 5 월 2026의 최대 전류의 자루입니다."

## GSTACK REVIEW REPORT

| Review | Trigger의 | 이유 | Runs | Status | 의논하기 |
|---|---|---|---|---|---|
| CEO 리뷰 | `/plan-ceo-review` | 범위 및 전략 | 1 | CLEAR | SCOPE_EXPANSION 모드; 3개의 확장 제안 (1개의 받아들여지는: v2 발사 포지셔닝; 2개의 deferred: gstack 라이트, gstack 예산); 11/11 단면도 검토되는; 0개의 긴요한 간격 |
| Codex 리뷰 | `/codex review` | 독립 제 2의 의견 (outside voice) | 1 | 문제_found | 12 과제 표면; 7 계획 (#4, #5, #6, #9, #10, #11, #12); 3 표면 사용자 정의 (#1 사용자 지정, #7 하이브리드 분할 채택, #8 사용자 허용 코덱) |
| Eng 검토 | `/plan-eng-review` | 건축 및 테스트 (필수) | 1 | CLEAR | 3 건축 결정은 잠긴 (D1 JSON는, D2 단면도/*.md.tmpl 파이프라인, D3 CI 비용 모자를 답니다); 4개의 새로운 실패 형태 추가했습니다 (모든 Rescued+tested); 시험 계획 artifact는, v1.45에 있는 3개의 차선 평행한, v2.0에 있는 순차적으로 생성했습니다); 0개의 긴요한 간격; 0개의 녹은 결정 |
| Codex 상담(2차 패스) | `/codex` (eng- 추가 리뷰에 대한 내용) | D1/D2/D3 + 병렬화 | 1 | 문제_found | eng-review 추가 기능에 7 추가적인 발견; 5 흡수하는 (TemplateContext 계약, 3 층 orphan 분류, 예산 모자 override 경로, 수동 데이터로 나타나지 않는, T7 순차적으로 비난된 통합 교류로); 2 표면 사용자 결정 (attention-architecture risk → 대성당 parity-eval suite 추가 "11"; 평행화는 코드 critique 당 순차적 v1.45로 붕괴) |
| 디자인 리뷰 | `/plan-design-review` | UI/UX 간격 | 0 | — | (no 뜻깊은 UI 범위; README/CHANGELOG만) |
| DX 리뷰 | `/plan-devex-review` | 개발자 경험 gaps | 1 | CLEAR | DX POLISH 모드; 제품 유형 = Claude Code 기술; 2명의 사람 궤도로 동등하게 (확장 사용자 격상기 + 새로운 사용자 증발기); 처음 7.9/10 → 9.0/10 발사 사본 specs가 계획 (JUST_UPGRADED 고시, CHANGELOG 숫자 테이블, README v2 기치에 의하여 모든 초안된 T15 배달 가능한 빨리; 모든 8개의 평가된 기술; DX는 검사합니다 DX 체크리스트를 통과했습니다 |

**CODEX:** First pass (CEO): 12 findings, 7 absorbed, 3 cross-model user-decided, 2 baked into tasks. Second pass (post eng-review): 7 findings on the new D1/D2/D3 additions, 5 absorbed, 2 user-decided. Both passes preserved as audit trail. 19 total codex findings → 12 absorbed without friction, 5 user-decided across both passes, 2 quality-of-life refinements baked into tasks. DX review skipped fresh codex pass (3 prior passes already covered structural blind spots; 나머지 DX 작업은 복사 제작이며, 코드가 사용자 취향보다 더 적은 값을 추가합니다.

**CROSS-MODEL:** (a) phasing (catalog 손질 일찍, 단면도 나중에), (b) 측정 첫번째 (hard token 예산 + 과급 감사 흔적), (c) 포크/rollout-strategy 간격. 모든 패스를 통해 해결되는 긴장: eval-first scope (user kept), v2 vs v1.x (HYBRID adopted), migration heaviness (lighter touch adopted), parallelization (user accepted codex's sequential critique), attention-architecture risk (user expanded scope to cathedral parity-eval suite covering ALL 31 skills with quality budget alongside token budget), launch copy artifacts (user drafted all three in plan vs deferring to T15 implementation).

**UNRESOLVED:** 0은 모든 5 리뷰에 걸맞는 결정입니다.

**VERDICT:** CEO + ENG + CODEX×2 + DX CLEARED — ready to implement. The hybrid v1.45/v2.0 split de-risks the bloat-reputation fix; the sections/*.md.tmpl pipeline (D2) prevents drift; the CI cost cap with override audit (D3 + codex absorbed refinement) prevents runaway eval spend; the cathedral parity-eval suite (codex 2nd pass) catches silent attention-architecture regressions that section-loading + budget tests alone would miss; sequential v1.45 execution (codex absorbed) trades wall-clock for integration safety; v2 실행 복사 specs (DX 검토)는 마케팅 등급 배 순간 땅을 모두 위해 사람 A (확장 향상기) 및 persona B (새로운 증발기) 만듭니다. 계획은 지금 실행할 수 있습니다.
