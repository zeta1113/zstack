# Testing Specialist 후기 목록

범위: 항상 (모든 리뷰) 출력: JSON 개체, 선 당 하나 발견. Schema: {"severity":"CRITICAL|INFORMATIONAL","confidence":N,"path":"file","line":N,"category":"testing","summary":"...","fix":"...","fingerprint":"path:line:testing","specialist":"testing"} 선택: 선, 고정, 지문, 증거, test_stub.ph를 발견하지 않는 경우: <3/> 출력: </>

---

## 카테고리

### 미싱 부정 - 종이 테스트
- 오류, 거부, 또는 NO 대응 테스트와 잘못된 입력을 처리하는 새로운 코드 경로
- Guard 절과 초기 반환은 검증되지 않습니다
- 시험에 오류 branch/catch, 구조, 또는 오류 경계가 실패 경로 테스트 없이
- Permission/auth 코드에 asserted 은 체크하지만 "denied" 케이스에 테스트되지 않습니다.

## Missing Edge-Case 적용
- 경계 값: 0, 부정적인, 최대 인, 빈 문자열, 빈 배열, nil/null/undefined
- 단일 배치 컬렉션 ( 루프에 한 대)
- 사용자 인터페이스 입력의 유니코드 및 특수 문자
- Concurrent 접근 패턴 없음 경주 조건 테스트

### 시험 고립 위반
- mutable 국가 (클래식 변수, 글로벌 싱글턴, DB 레코드를 공유하지 않음)
- 주문 의존 테스트 (수수수수입, 임의화시 실패)
- 시스템 클럭, 시간대, 또는 locale에 따라 테스트
- stubs/mocks를 사용 대신 실제 네트워크 호출을 만드는 테스트

### Flaky 시험 본
- 타이밍 의존하는 주장 (잠자는, setTimeout, 꽉 타임 아웃을 기다립니다)
- 주문되지 않은 결과의 주문에 대한 지원 (시각 키, 설정 반복, 동기화 해상도 주문)
- 외부 서비스에 의존하는 테스트 (APIs, 데이터베이스) fallback
- 무작위로 시험 자료 없이씨 통제

## 보안 강화 테스트 Missing
- Auth/authz는 "수출" 케이스를 위한 시험 없이 관제사에 있는 체크
- 율 제한 논리없이 테스트가 실제로 블록을 프로빙하지
- 악의적인 입력을 위한 시험 없이 입안
- CSRF/CORS 통합 테스트 없이 구성

### 적용 개스
- 새로운 공공 방법/functions 0 테스트 적용
- 기존의 테스트만 오래된 행동을 다루고 새로운 branch가 아닌 변경된 방법
- 여러 곳에서 호출된 유틸리티 함수는 간접적으로 테스트
