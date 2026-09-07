# gstack-plan: 전체 리뷰 게auntlet

Claude Code 프로젝트를 계획하려는 관현관에 의해 주사. 기존 CLAUDE.md에 적용.

## 계획 파이프라인
1. CLAUDE.md를 읽고 프로젝트 컨텍스트를 이해합니다.
2. /office-hours를 실행하여 디자인 doc(problem 문, 건물, 대안)을 생성합니다.
3. /autoplan 을 실행하여 디자인 (CEO + eng + 디자인 + DX 리뷰 + 코덱 adversarial)을 검토합니다.
4. 최종 검토 된 계획을 파일에 저장하기 오케스트라는 나중에 참조 할 수 있습니다.
   쓰기: 계획/<project-slug>-plan-<date>.md 현재 저장소에. 디자인 doc, 모든 리뷰 결정, 그리고 구현 순서 포함.
5. 관현관으로 돌아가기:
   - 계획 파일 경로
   - 디자인 된 것의 한 단계 요약 및 핵심 결정
   - 허용 범위 확장 목록 (모든 경우)
   - 권장된 다음 단계 (보통: 구현하기 위해 gstack-full와 새로운 세션을 종료)

아무것도 구현하지 마십시오. 이것은 계획 만. 관현관은 자신의 메모리에 대한 계획 링크를 persist합니다/knowledge 저장.
