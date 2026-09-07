# gbrain는 표면을 작성 — 어떤 땅, 그리고 확인하는 방법

이 문서는 두 명의 청중들을 제공합니다:

1. **의제**: 계획 기술이 콤팩트 `### Brain Context를 렌더링할 때
   Load` or `## 저장 결과 Brain` blocks, those blocks reference this doc. Read §Context Load or §Save Template here on-demand when you're actually using gbrain. Skip entirely if `gbrain`에 PATH이 아닙니다.
2. **한국어**: 실제 두뇌에 대한 계획 스킬을 실행한 후, 사용
   수동 조사 섹션은 실제로 페이지를 착륙 확인.

## 어떤 땅을 어디에

| Host + 검출 국가 | 계획 스킬 SKILL.md에서 어떤 렌더링 |
|---|---|
| 호스트 + `gstack-config gbrain-refresh` 보고서 `gbrain_local_status: "ok"` | 압축된 뇌 인식 블록 렌더링. 에이전트는 실제로 저장 할 때이 doc on-demand를 읽습니다. ~250 token 계획 기술 당 오버 헤드. |
| 어떤 호스트 + gbrain는 감지되지 않습니다 | gen-time에 억제되는 구획. 0 token 머리 위. 구경측정은 아직도 (separate 결심자, 주인 agnostic)를 가지고 갑니다. |
| GBrain 또는 Hermes 호스트 | 블록은 항상 감지에 관계없이 렌더링합니다. 이 호스트는 gbrain 통합을 일류적인 관심사로 배웁니다. |

`.gbrain-source` 핀 **읽기**만 - `~/.gbrain/config.json`에서 구성된 default 엔진에 쓰기. `bin/gstack-gbrain-sync.ts`에서 코드 전망 해결자를 위해 문서화; gstack는 artifact `put` semantics를 위해 짐 방위와 동일한 계약을 대우합니다. 사용자가 잘못된 근원에서 착륙하는 경우에, 여기에서 첫째로 보십시오.

Trust 정책 (`personal` vs `shared`, endpoint 해시 당) 게이트 자동 푸시 및 쓰기. `gstack-config set brain_trust_policy@<endpoint-hash> personal`를 통해 설정. 로컬 PGLite는 `personal`에 자동 기본값을 설치; 원격 MCP `/setup-gbrain` 단계 9.5 동안 프롬프트를 설치합니다.

## §Context Load (현금은 계획 기술을 실행할 때 이것을 읽습니다)

시작하기 전에 관련 상황에 대한 두뇌를 검색하십시오.

1. **2-4개의 키워드를 추출하십시오** 사용자 요청에서. 노운, 오류를 선택
   이름, 파일 경로, 기술 용어 - NOT 동사 또는 형용사. 예: "등록 페이지는 배포 후 깨어 났습니다"을 검색 `login broken deploy`.
2. **Search**: `gbrain search "<keyword1 keyword2>"`. 같은 선을 돌려보내
   `[slug] Title (score: 0.85) - first line of content...`.
3. **몇 가지 결과** (에서 3): 가장 특정한 단일에 넓히십시오
   키워드 및 검색 다시. 아직 몇 가지 경우, 뇌 컨텍스트없이 진행.
4. **상위 3건의 결과**: `gbrain get_page "<slug>"` 각. 정지
   3 이후 — 그 과거의 감소.
5. **context 사용** 분석에 대한 정보를 알려줍니다. Cite specific slugs in
   뇌 페이지가 생각을 변경할 때 출력을 출력합니다.

`gbrain search`가 비제로 출구(gbrain not on PATH, 네트워크 조각, throttle)를 반환하면 일시적으로 치료합니다. 뇌 컨텍스트없이 진행하십시오. 재발 인라인을 사용하지 마십시오. 사용자는 나중에 기술을 재발 할 수 있습니다.

## §Save Template (실험할 때이 읽기)

기술 완료 후 출력을 저장합니다. 컴팩트 한 해결자 블록은 이미 슬러그 프리픽스 + 제목 + 태그를 보여줍니다 (예 : `gbrain put "ceo-plans/<feature-slug>" ...`). 전체 템플릿 :

```bash
gbrain put "<slug-prefix>/<feature-slug>" --content "$(cat <<'EOF'
---
title: "<Title>: <feature name>"
tags: [<tag>, <feature-slug>]
---
<skill output in markdown — the actual deliverable, not a summary>
EOF
)"
```

**Slug 지도**: `<feature-slug>`는 접두사 안에 kebab-case, 더 낮은 케이스 및 유일한이어야 합니다. Prefer 구체적인 프로젝트/feature는 요약 상표에 이름. 보기: `auth-rate-limit` 아닙니다 `security-fix`.

**제목 안내**: 일정한 접두사 (예: "CEO 계획", "Eng Review")는 조정됩니다; suffix는 feature/topic의 인간 읽기 쉬운 이름입니다.

**태그 안내**: 첫번째 꼬리표는 기술의 메타데이터 (예를들면 `ceo-plan`, `eng-review`)에서 일정한 `<tag>`입니다. 두번째 꼬리표는 `<feature-slug>` 이렇게 교차 페이지 traversal 일입니다. 명백한 관계가 존재하는 경우에 더 많은 꼬리표를 추가하십시오 (예를들면 `[ceo-plan, auth-rate-limit, security]`).

### 엔티티스-스텁 농축

메인 페이지를 저장 한 후, 출력에 언급 한 사람 및 조직 이름을 추출합니다. 각 경우:

```bash
# Check if a page exists first
gbrain search "<entity name>"

# If no match, create a stub
gbrain put "entities/<entity-slug>" --content "$(cat <<'EOF'
---
title: "<Person or Company Name>"
tags: [entity, person]
---
Stub page. Mentioned in <skill name> output. Replace with real bio when relevant.
EOF
)"
```

**이름만 추출** - 실제 이름 (예: "Garry Tan") 및 회사/organization 이름 (예: "Y Combinator"). 제품명, 기능명, 섹션 제목, 기술 용어 (CSS 클래스명, 기능명), 파일 경로를 건너뛰십시오. 의심할 여지없이 건너뛰기.

`tags: [entity, person]`, `tags: [entity, organization]` 기업 /teams.

### 오류 처리

- **Throttle**: `throttle`를 포함하는 stderr를 가진 종료 코드 1, `rate
  limit`, `capacity`, or `busy`. 저장을 거부하고 이동 - 뇌가 바쁘다; 내용이 손실되지 않습니다, 그냥이 실행을 주장하지.
- **다른 비 제로 출구**: 일시적인 실패로 대우하십시오. 재발하지 마십시오
  인라인 — 사용자는 gbrain 자체가 잘못 구성되는 경우 `gstack-config gbrain-refresh`를 실행하거나 `gstack-config gbrain-refresh`를 재 실행할 수 있습니다.
- **`gbrain: command not found`**: gbrain는 PATH에 아닙니다. 콤팩트
  해결자 블록은 건너뛰기 말했습니다. 이 코드를 도달하지 못했습니다. 당신이 어떻게 했는지, 침묵적으로 건너뛰고 계속.

## # 백링크

저장 출력이 이름이나 주제로 다른 뇌 페이지를 언급하면, Markdown 몸의 하단에 백링크 라인을 추가합니다.

```
Related: [[other-page-slug]], [[another-slug]]
```

gbrain 자동 용해 `[[slug]]` 구문은 렌더링 된 페이지의 클릭 가능한 링크로. 관계가 콘크리트 (예 : "이 CEO 계획은 `eng-reviews/auth-rate-limit`)에 eng 검토에 따라 달라집니다. 직물 연결이 없습니다.

### 완료 요약

최종 기술 출력에서 뇌 활용을 한 줄에 주목하십시오. "Brain : 3 페이지를 읽고 1 페이지가 저장되어 2 개의 엔티티티티 스텁, 0 개의 스로틀을 낳습니다." 이것은 사용자가 뇌의 범위를 시간이 지남에 따라 증가하는 데 도움이됩니다.

## Persistence 검증 (자동화)

일치 쌍 "우리는 실제로 저장되기를 희망하는 데이터입니다?" 질문은 `test/skill-e2e-gbrain-roundtrip-local.test.ts`에 의해 덮여있다: 실제 `gbrain init --pglite` + `gbrain put` + `gbrain get` 격리 된 임시 직원 HOME에 대한 왕복. 정기적 계층. `VOYAGE_API_KEY`가 설정되지 않거나 gbrain CLI가 PATH에서 누락됩니다.

해결자를 접촉하는 PR를 열어서 실행하십시오:

```bash
EVALS=1 EVALS_TIER=periodic VOYAGE_API_KEY=$VOYAGE_API_KEY \
  bun test test/skill-e2e-gbrain-roundtrip-local.test.ts
```

실제 계획-스킬 실행 후 자신의 두뇌에 대한 손으로 스포트 체크를 원하면 (이제가 저장되어야 특정 페이지를 디버깅) :

```bash
gbrain get "<prefix>/<slug>"           # expect markdown + frontmatter
gbrain search "<slug fragment>"        # expect slug in top results
gbrain sources list                    # confirm gstack-brain-<user> source
gbrain get "entities/<person>"         # expect stub per named person
```

## 리모트/Supabase/얇 클라이언트MCP 여정

해결자는 단일 CLI 모양을 방출합니다. `gbrain put "<slug>" --content "..."` - 모든 엔진 gbrain 지원에 대해 작동한다는 것은. CLI는 내부적으로 로컬 PGLite, 리모트 Supabase, 또는 사용자의 `~/.gbrain/config.json`에 따라 먼 MCP 엔드포인트에 대한 경로. **gstack는 여정을 시험하지 않습니다**: 저장 층은 gbrain의 계약으로 명예를 주고, 동일한 CLI invocation는 로컬 PGLite에 대한 테스트입니다. 다른 엔진은 다른 엔진에 대한 다른 엔진입니다.

Supabase 또는 얇은 클라이언트 MCP에 있는 경우에 당신은 착륙하지 않습니다:

1. `gbrain doctor --fast --json` - 엔진 건강 검사. 어떤 것
   `error`를 보고, 그 첫번째를 고칠.
2. `gstack-config get brain_trust_policy@<endpoint-hash>`는 반드시 있어야 합니다
   `personal` 자동 쓰기. `gstack-config endpoint-hash`를 실행하면 활성 해시를 얻을 수 있습니다. `shared`가면, 쓰기 전에 에이전트 프롬프트가 발생하면, 기술을 다시 실행합니다.
3. 신뢰 정책이 `personal`이고 `gbrain doctor`는 청결하지만
   페이지는 여전히 존재하지 않습니다, gbrain에 대한 문제가 파일 - gstack의 CLI 호출 모양은 T11 (`gbrain-roundtrip-local`) 운동과 동일합니다.

## 자동화로 검증된 NOT이란 무엇입니까?

- **교정이 필요합니다 (`takes_add`)**: 오늘 이 가을에
  fence-block writes inside a `gbrain put` because `BRAIN_CALIBRATION_WRITEBACK` is FALSE pending gbrain v0.42+ shipping the `takes_add` MCP op. When the flag flips, re-run the probe in this doc against `/office-hours` and confirm `gbrain takes_list` surfaces a `kind=bet` entry with the expected weight (0.9 for office-hours, per `scripts/brain-cache-spec.ts:151-157`).
- **다른 4 계획 기술에 대한 Per-skill E2E**: `/office-hours`만
  가짜 CLI E2E 적용 (`test/skill-e2e-office-hours-brain-writeback.test.ts`). 결심자 단위 시험 (`test/resolvers-gbrain-save-results.test.ts`)는 모두를 위한 배선을 포함합니다 5. Per-skill E2E 확장은 TODOS.md에서 추적됩니다.
- **`.gbrain-source` 쓰기 semantics**: gstack는 문서화
  로드 베어링으로만 계약이 읽지 만, gbrain CLI가 핀에 근거를 둔 루트가 쓰지 않는 것을 독립적으로 검증하지 않습니다. 만약 당신이 그 경우를 찾을 경우, 그 gbrain 버그 파일 업스트림.
