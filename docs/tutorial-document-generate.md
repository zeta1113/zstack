# 자습서 : 90 초의 기능에 대한 docs를 생성합니다.

이미 프로젝트에 대해 `/document-generate`를 실행할 수 있습니다. 튜토리얼 / 방법 / 참조 / 설명 docs를 올바른 장소에 기록하고, PR로 드롭 할 수있는 적용지도로 끝납니다. 결국 네 움직임을 알 수 있습니다. 범위, 고고학, 파티션, 쓰기.

## 당신이 필요로 할 것

- gstack 설치 (`git clone --single-branch --depth 1 https://github.com/garrytan/gstack.git ~/.claude/skills/gstack && cd ~/.claude/skills/gstack && ./setup`)
- Claude Code 공개 표면의 적어도 한 조각이 있는 어떤 프로젝트에서 달리는 (CLI 명령, 수출한 기능, 구성 선택권, 기술, API 엔드포인트)
- 약 90초

`docs/` 디렉토리가 미리 필요하지 않습니다. 기술이 누락되면 하나를 만듭니다. Diataxis 용어를 알 필요가 없습니다. 기술이 출력을 라벨합니다.

## Step 1: 어떤 프로젝트에서 기술에 참여

문서로 원하는 프로젝트에서 Claude Code를 엽니다. 유형:

```
/document-generate
```

기술이 1개의 질문을 출력 대상에 대해 물어볼 수 있습니다:

```
A) Write documentation inline in existing files (README, ARCHITECTURE, etc.)
B) Create standalone documentation files (e.g., docs/ directory)
C) Both — inline summaries in existing files + deep docs in standalone files

RECOMMENDATION: Choose C because it maximizes both discoverability and depth.
```

C를 선택하면 README 포인터와 독립 문서의 전체 세트를 얻을 수 있습니다.

## Step 2: 고고학 실행을 시청

기술이 ~30 초 동안 침묵을 갖게됩니다. 이 의도는 단계 1 "Codebase Archaeology"단계가 작업 흐름에서 가장 중요한 단계입니다. 기술이 읽기입니다.

- 전체 저장소 구조
- README, ARCHITECTURE, CONTRIBUTING, CLAUDE.md (입력점)
- 문서화(전체 파일, 서명하지 않음)에 대한 구현 파일
- 시험 (지표와 의도한 행동을 밝혀)
- 인라인 코멘트 태그 `// NOTE:`, `// DESIGN:`, `// WHY:`

끝낼 때, 당신은 같이 선을 볼 것입니다:

```
Researched 47 files, identified 12 public surface items, 8 concepts, and 4 design decisions.
```

그 숫자는 기술이 실제로 파일명에서 추측하는 것보다 코드를 읽습니다.

## 단계 3: Diataxis 파티션 계획 보기

기술은 그 중성인을 위해 쓰일 것이다, 그것을 보여주는 분할 계획을 인쇄합니다:

```
Documentation plan:
  [entity]              [tutorial] [how-to] [reference] [explanation]
  WidgetService         ✅ new     ✅ new   ✅ new      ✅ new
  --verbose flag        ❌        ✅ new   ✅ inline   ❌
  Bayesian scheduler    ❌        ❌       ✅ new      ✅ new
```

모든 법인은 모든 4개의 사분자를 필요로 하지 않습니다. CLI 플래그는 참고 + 방법 을 얻습니다. 내부 모듈은 참고 + 설명을 얻습니다. 사용자 인터페이스 기능은 모두 4를 얻습니다. 기술은 법인 유형에 근거를 둔 선택합니다.

계획이 5 개 이상의 문서가 있다면, 기술이 진행하기 전에 확인하도록 요청합니다. 그렇지 않으면 그것은 간다.

## 단계 4: 토지를 먼저 doc을 읽으십시오

참조 docs 토지 먼저 그들이 항해를 수정하기 때문에. 당신은 같은 라인을 볼 수 있습니다:

```
GENERATED: docs/reference-widget-service.md
```

파일을 엽니다. 엄격한 구조가 있습니다. 한 단계의 인트로, 유형과 기본으로 목록 API, 2-3 실행 가능한 예, 그리고 다음 땅에 착륙하는 방법 및 튜토리얼과 연결 관련 섹션.

이것은 Diataxis: 실제로, 소진, narrative에서 같은 참조 문서는 입니다. *왜?*를 설명하는 것을 직접 보고하는 경우에, 그 묘사에 속한 doc 기술이 다음을 쓸 것입니다.

## Step 5: 설명, 방법, 자습서가 나타납니다

빠른 성공 (각 ~5-10 초)에서, 기술은 나머지 사분자를 씁니다:

```
GENERATED: docs/explanation-widget-architecture.md
GENERATED: docs/howto-create-a-custom-widget.md
GENERATED: docs/tutorial-build-your-first-widget.md
```

각 것을 엽니다. 그들은 각 다른 반복하지 않습니다:

- **의약**는 문제로 이어, 그 접근, 그 다음 무역 떨어져 및 대안으로 간주됩니다
- **으로**는 정확한 명령, 검증 섹션 및 문제 해결 섹션을 가진 우선 순위, 번호 단계가 있습니다.
- **의논하기** 3단계에서 작업결과를 얻고, "What you built"로 종료

기술이 이 구조를 시행합니다. 검증 섹션을 누락한 방법이라면 Step 8 Quality Self-Review가 커밋하기 전에 잡았습니다.

## Step 6: 크로스링크 확인

다른 사람에게 모든 doc 링크. 참조 doc 관련 섹션 : 방법 및 자습서에 대한 링크. 관련 섹션 : 참조 링크. 자습서 "당신이 내장 된"섹션 : 더 깊은 탐험에 대한 참조 링크.

끊긴 링크를 확인하기 위해 grep을 실행하십시오:

```bash
grep -rE '\]\([^)]*\.md\)' docs/ | head -10
```

모든 연결 파일이 존재해야 합니다. 기술 단계 7 "Cross-Document Linking & Discoverability"는 이 작업을 커밋하기 전에 확인합니다.

## Step 7: PR 몸에 적용 요약을 참조하십시오

PR를 열고 있는 기능 분기에 있는 경우, PR 몸은 `## Documentation Generated` 테이블을 가진 PR 몸을 새롭게 합니다:

```
## Documentation Generated

| File | Quadrant | Description |
|------|----------|-------------|
| docs/tutorial-build-your-first-widget.md | Tutorial | Walk-through from install to first working widget |
| docs/reference-widget-service.md | Reference | Complete widget API with types, defaults, examples |
| docs/explanation-widget-architecture.md | Explanation | Why widgets are isolated services |
| docs/howto-create-a-custom-widget.md | How-to | Creating and registering custom widgets |
```

PR를 여는 검토자는 테이블을보고 즉시 어떤 종류의 적용이 발송되는지 알 수 있습니다.

## 당신이 내장 된 것

이제 4 개의 다른 독자를 제공하는 4 개의 문서가 있습니다.

- 프로젝트에 새로운 기능은 `tutorial-*.md`를 읽고, 작업하는 것을 얻을 수 있습니다
- 경험있는 사용자는 특정 작업을 수행 할 `howto-*.md`를 읽을 수 있습니다.
- API 콜러는 `reference-*.md`를 정확한 서명을 위해 읽을 수 있습니다
- 코드 검토자는 `explanation-*.md`를 읽을 수 있습니다.

각 하나는 유지에 충분합니다. 각 하나는 단일 작업이 있습니다. PR 본체는 보조가 덮여있는 보여줍니다. `/document-release`를 나중에 실행하면 Diataxis 적용지도는 완전히 덮여있는 (4/4개의 사만)로이 엔티티티를보고합니다.

## 다음을 할 것

- **당신은 격침이 있는 경우에** /document-release 은폐하지만 채우지 않았습니다. `/document-generate`를 다시 실행하고, 그 엔티티티에 특히 적용되었습니다.
- **4개의 사분자가 왜 존재했는지 이해하기를 원하면:** [explanation-diataxis-in-gstack.md](./explanation-diataxis-in-gstack.md)를 읽으십시오.
- **특정 배송 기능에 대해 궁금한 점이 있으시면** (전체 프로젝트가 아닙니다): [howto-document-a-shipped-feature.md](./howto-document-a-shipped-feature.md)를 읽으십시오.
- **기술 자체에 대한 참조 :** [`document-generate/SKILL.md`](../document-generate/SKILL.md).
