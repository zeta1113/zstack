<!-- AUTO-GENERATED from report-format.md.tmpl — do not edit directly -->
<!-- Regenerate: bun run gen:skill-docs -->
산출을 구조:

---

**Tweetable 요약** (첫 줄, 다른 모든 것의 앞에):
```
Week of Mar 1: 47 commits (3 contributors), 3.2k LOC, 38% tests, 12 PRs, peak: 10pm | Streak: 47d
```

## 엔지니어링 복도: [일부 범위]

### 요약표(단계 2)

### Trends vs Last Retro (단계 12에서 저장하기 전에 로드됨 — 처음 복고풍이 닿는 경우 건너뛰기)

### 시간 & 세션 패턴 (단계 3-4에서)

팀 전체 패턴이 의미하는 것을 의미하는 표현 :
- 가장 생산적인 시간은 언제이고 그(것)들을 몰아들
- 세션이 더 길거나 더 짧은 시간 동안
- 활성 코딩 일당 예상 시간 (팀 집계)
- 주목할만한 패턴 : 동시에 팀 구성원 코드를하거나 교대에서?

### 배송 속도 (단계 5-7에서)

관련 링크:
- Commit type mix and 그것이 밝혀지는 것
- PR 크기 배급과 선박 Cadence에 관하여 계시하는 것
- Fix-chain 탐지 (고정의 순서는 동일한 하위 시스템에 커밋)
- 버전 범람 분야

### 코드 질 신호
- 시험 LOC 비율 동향
- Hotspot 분석 (같은 파일 churning이 있습니까?)
- Greptile 신호 비율과 추세 (전력이 존재하는 경우) : "Greptile : X % 신호 (Y 유효한 캐치, Z 거짓 긍정적 인)"

### 시험 건강
- 총 테스트 파일: N (`TEST_FILES_TOTAL`)
- 테스트는이 기간을 추가: M (`TEST_FILES_CHANGED` — 테스트 파일이 창에서 변경)
- 회귀 시험은 `REGRESSION_COMMIT` 선 (`test(qa):`, `test(design):`, `test: coverage` 커밋)를 목록으로 만듭니다.
- 이전 복고풍이 존재하고 `test_health`: delta "테스트 카운트: {last} → {now} (+{delta})"를 표시하십시오.
- 테스트 비율 < 20%: 성장 영역으로 플래그 — "100% 테스트 적용은 목표입니다. 테스트는 vibe 코딩 안전"을 만든다.

### 플랜 완료 체크 검토 JSONL /ship에서 플랜 완료 데이터를 위한 로그는 이 기간을 실행합니다:

```bash
setopt +o nomatch 2>/dev/null || true  # zsh compat
eval "$(~/.claude/skills/gstack/bin/gstack-slug 2>/dev/null)"
cat ~/.gstack/projects/$SLUG/*-reviews.jsonl 2>/dev/null | grep '"skill":"ship"' | grep '"plan_items_total"' || echo "NO_PLAN_DATA"
```

계획 완료 데이터가 복고풍 시간 창 내에서 존재하면:
- 계획으로 배송되는 카운트 지점 (`plan_items_total` > 0)
- Compute 평균 완료: `plan_items_done`의 합계 `plan_items_total`의 합계
- 데이터가 지원되는 경우 대부분의 skipped 항목 범주를 식별

산출:
```
Plan Completion This Period:
  {N} branches shipped with plans
  Average completion: {X}% ({done}/{total} items)
```

no 플랜 데이터가 존재하면, 이 섹션을 침묵으로 건너 뛰게 됩니다.

### 초점 & 하이라이트 (단계 8에서)
- 해석과 초점 점수
- 주 콜아웃의 배

### 당신의 주 (개인적인 깊은 파생) (단계 9에서, 현재 사용자를 위해)

이것은 사용자의 대부분을 돌보는 섹션입니다. 포함:
- commit 조사, LOC, 시험 비율
- 그들의 세션 패턴과 피크 시간
- 그들의 초점 지역
- 가장 큰 배
- **잘 했습니까?** (조정에 묶인 2-3개의 특정한 것)
- **어디까지 레벨 업** (1-2 특정한, 실행할 수 있는 제안)

## 팀 Breakdown (단계 9에서 각 팀메이트에 대해 - 솔로 repo)를 건너뛰기

각 팀원 (자락에 의해 정렬), 섹션을 작성:

#### [이름]
- **그들은 무엇을 배송**: 그들의 기여, 초점의 지역, 및 commit 본에 2-3개의 문장
- **Praise**: 1-2 특정 것들이 잘 했으므로 실제 커밋에 고정되었습니다. 사실 — 실제로 1 : 1에서 말하는 것입니까? 예 :
  - "3 작은 3 개의 작은, 검토 가능한 PR에 전체 auth 모듈을 정리했습니다. - textbook decomposition"
  - "모든 새로운 엔드 포인트에 대한 통합 테스트 추가, 그냥 행복 경로"
  - "대시보드에서 2s로드 시간을 발생시킨 N+1 쿼리를 Fixed"
- **성장 기회**: 1개의 특정한, 건설적인 제안. 투자로 구조, 비판성. 예:
  - "결제 모듈의 테스트 범위는 8%에 있으며, 다음 기능 땅의 위에 투자할 가치가 있습니다"
  - "일부의 공격을 겪는 것은 한 번에 땅을 옮깁니다. "
  - "모든 1-4am 사이의 땅을 커밋합니다. — 지속 가능한 속도는 코드 품질 장기에 대한 문제"

**AI 협력 주:** 많은 커밋이 `Co-Authored-By` AI 트레일러 (예: Claude, Copilot)가 있다면 AI를 참고하여 팀 메트릭으로 commit 비율을 아끼게 됩니다. 커밋의 %는 AI-assisted"가 되었고, 판결 없이는 commit 비율을 갖게 되었습니다.

### Top 3 Team은 전체 팀의 창에서 배송 된 3 가지 가장 높은 충격을 확인합니다. 각 :
- 그것은 무엇입니까?
- 누가 그것을 배송
- 왜 (제품/architecture 충격)

##3 특정, 행동, 실제 커밋에 고정 된 것을 개선하는 것들. 개인 및 팀 수준의 제안을 혼합합니다. "더 나은 얻을 수 있도록하는 것은 팀이 될 수 있습니다 ..."

##3 다음 주 소, 실제, 현실적을위한 Habits. 각은 <5 분이 채택되어야합니다. 적어도 하나는 팀 중심이어야합니다 (예 : "각 다른 PR을 당일 검토하십시오.")

### Week-over-Week Trends (단계 10에서 적용 가능한 경우)
