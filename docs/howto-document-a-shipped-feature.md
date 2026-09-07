# 방금 배송 한 기능에 대한 문서

이 게시물의 워크플로입니다: PR, docs는 stale이며, 한 패스에 커버된 갭을 원할 수 있습니다. `/document-release`를 감사하기 위해 `/document-generate`를 실행하면 갭을 채우기 위해 `/document-generate`를 실행할 수 있습니다.

## 필수품

- gstack 설치 (`./setup` 완료; `which gstack` 또는 Claude Code에서 `/`를 입력하여 기술 목록으로 보기)
- 배송된 기능이있는 지점은 체크 아웃됩니다.
- PR는 GitHub 또는 GitLab (recommended — 워크플로우 업데이트 PR체를 적용 맵으로 업데이트)

PR가 아직 존재하지 않는 경우, `/ship`를 먼저 실행하여 `/document-release`가 런던 것을 디자인했습니다.

## 단계

##1. 감사 현재 적용

실행:

```
/document-release
```

기술은 기본 branch에 대한 디퓨트를 걸으며 새로운 공공 표면 (스킬, CLI 플래그, 구성 옵션, API 엔드포인트, 새로운 모듈)을 추출하고, 4 Diataxis 사분면에 각 엔티티를 점수합니다. 다음과 같은 적용지도를 볼 수 있습니다.

```
Coverage map:
  [entity]         [reference?] [how-to?] [tutorial?] [explanation?]
  /new-skill       ✅ AGENTS.md  ❌        ❌          ❌
  --new-flag       ✅ README     ✅ README  ❌          ❌
  FooProcessor     ❌            ❌        ❌          ❌
```

0개의 적용을 가진 품목은 **긴 수명**입니다. 단지 참고 적용을 가진 품목은 **common gaps**입니다. PR 몸에 있는 둘 다에 있는 둘 다에 의하여 `### Documentation Debt` 이하 단면도 그래서 검토자는 그(것)들을 보십시오.

`/document-release`가 모든 것을 덮고 있다면, 당신은 행해집니다. 이 방법의 나머지를 건너 뛰십시오.

##2. PR체에 대한 문서 채무 섹션을 읽어

PR (기술은 URL)를 인쇄합니다. `## Documentation` → `### Documentation Debt`로 스크롤하십시오. 각 품목은 Diataxis를 채우는 quadrant로 태그됩니다:

```
### Documentation Debt

- ⚠️ /new-skill — has reference in AGENTS.md but no how-to example in README. Diataxis quadrant: how-to.
- ⚠️ FooProcessor — zero coverage. Diataxis quadrants: reference, explanation.
```

이것은 다음 단계에 입력입니다. 각 라인은 당신이 누락하고 중등이 그것을 채우는 것을 말해줍니다.

##3. /document-generate로 격차를 채우십시오.

실행:

```
/document-generate
```

기술이 범위에 대해 묻을 때 부채 섹션에서 특정 엔티티티가 파쇄됩니다. 기술은 코디베이스 (its Step 1 archaeology phase is required), Diataxis 사만에 파티션을 읽고 누락 된 docs를 작성합니다.

또한 기술 자동 발견을 할 수 있습니다 : /document-release가 명시적으로 적으로 간격을 통과하면 (이 경우 체인질), `/document-generate` 이미 작성하는 것을 알고 있습니다.

##4. 틈을 닫아

재 실행 `/document-release`:

```
/document-release
```

적용 지도는 이전에 면제 사만에 녹색 표시를 가진 이전에 flagged entities를 보여주어야 합니다. PR 몸의 문서 변호는 비어있거나 의도적으로 방어하는 품목으로 감소되어야 합니다.

## 인증

PR를 열고 확인:

1. PR 몸에는 doc-diff 미리보기가 있는 `## Documentation` 섹션이 있습니다.
2. `### Documentation Debt` 하위 섹션은 0개의 긴 간격을 나열합니다 (또는 당신이 알고있는 항목 만).
3. `docs/`의 각 생성된 doc 파일은 siblings (reference → how-to → tutorial → description)에 깨끗하고 교차 링크가 열립니다.
4. `grep -rE '\]\([^)]*\.md\)' docs/`를 실행하고 누락된 파일에 연결점을 확인한다.

모든 4개의 체크가 있다면, PR는 완전한 문서로 땅에 준비되어 있습니다.

## 문제 해결

**`/document-release` "공공 표면이 감지되지 않음"을 보고합니다.** diff는 내부 전용 (반점, 시험, 적외선)입니다. 아무 문서도 필요하지 않습니다. 착륙을 건너 뛰십시오.

**Diataxis 격차 태그는 당신이 기대하는 것 같아.** 기술에는 사소한 물질 (CLI 플래그가 참조 + 방법-to를 원한다고 결정하는 엔티티티티 세무제를 사용합니다. 내부 모듈은 참조 + 설명을 원합니다. 사용자 인터페이스는 모두 4를 원합니다. 동의하면 생성 후 docs를 편집하여 처리 할 수 있습니다. 감사는 가이드, 제약이 아닙니다.

**`/document-generate`는 8단계를 가지고 있는 튜토리얼을 작성하여 작업결과에 도달합니다.** 자습서는 3 단계 또는 몇몇에 있는 작동 결과를 명중해야 합니다. 기술을 재 실행하고 압축, 또는 손 편집에 그것을 요구하십시오. 단계 8 질 각자 Review는 이 그러나 전혀 붙잡습니다.

**PR가 아직 존재하지 않는 기능을 문서화하고 싶습니다.** `/ship`를 처음 실행하면 PR를 생성하고, 이 워크플로우가 됩니다. PR 없이 `/document-release`는 여전히 감사를 할 수 있지만 PR-body update를 건너뛰게 됩니다.

**생성된 참고 doc에는 API 서명이 있습니다.** 버그를 파일. 기술 단계 1 아카이브는 구현 파일이 종료되지 않는, 이 방지하기 위해 특별히이 서명을 읽는 것입니다. 생성 된 텍스트와 실제 코드를 포함하므로 고고학이 놓은 이유를 추적 할 수 있습니다.

## 관련

- **튜토리얼: `/document-generate`를 사용하는 첫 번째 시간:** [tutorial-document-generate.md](./tutorial-document-generate.md)
- **gstack는 Diataxis 프레임워크를 사용합니다.** [explanation-diataxis-in-gstack.md](./explanation-diataxis-in-gstack.md)
- **감사 기술에 대한 참조 :** [`document-release/SKILL.md`](../document-release/SKILL.md)
- **세대 기술에 대한 참조 :** [`document-generate/SKILL.md`](../document-generate/SKILL.md)
