# 유지 가능성 전문가 리뷰 Checklist

Scope: Always-on (every review) Output: JSON objects, one finding per line. Schema: {"severity":"INFORMATIONAL","confidence":N,"path":"file","line":N,"category":"maintainability","summary":"...","fix":"...","fingerprint":"path:line:maintainability","specialist":"maintainability"} Optional: line, fix, fingerprint, evidence, test_stub. If no findings: output `NO FINDINGS` and nothing else.

---

## 카테고리

## # # Dead Code & 사용되지 않은 수입
- 지정된 변수는 아니지만 변경된 파일에서 읽지 못합니다.
- Functions/methods 정의하지만 절대 호출되지 않습니다 (Repo에서 Grep와 체크)
- 변경 후 더 이상 참조되지 않는 imports/requires
- Commented-out 코드 블록 (이더 제거 또는 왜 그들은 존재했는지 설명)

### 마술 수 & 끈 연결
- 논리 (thresholds, limits, retry counts)에서 사용되는 벌브 수치 - 상수도 이름을 지정해야
- 오류 메시지 문자열은 쿼리 필터 또는 다른 상태로 사용
- config를 컴파일해야 하는 URL, 포트, 호스트명
- 여러 파일에 걸쳐 중복된 리터럴 값

## # Stale 댓글 & Docstrings
- 이 디프에서 코드가 변경된 후 오래된 행동을 설명하는 댓글
- TODO/FIXME 참고 완료된 작품
- 현재 함수 서명과 일치하지 않는 매개변수 리스트를 가진 Docstrings
- ASCII 코드 흐름에 더 이상 일치하지 않는 의견에 도표

## DRY 폭로
- diff 안에 여러 번 나타나는 비슷한 코드 블록 (3 + 라인)
- 공유 헬퍼가 더 깨끗한 패턴을
- 테스트 파일에 걸쳐 구성 또는 설정 논리 중복
- 반복된 조건부 체인은 표 또는 지도일 수 있었습니다

### 조건부 측 효력
- 상태에 분기 하는 코드 경로는 하지만 한 분에 부작용을 잊지
- 행동을 주장하는 메시지가 나타났지만 행동은 조건부로 건너 뛰었다.
- 국가 전환 한 지점 업데이트 관련 기록하지만 다른 것은 아닙니다
- 행복한 경로에 불을 넣는 이벤트 배출, 누락된 error/edge 경로

## 모듈 경계 위반
- 다른 모듈의 내부 구현에 도달 (개인의 참여 방법 접근)
- 컨트롤러의 직접 데이터베이스 쿼리/views 그것은 service/model를 통해 이동해야
- 인터페이스를 통해 통신해야 하는 구성 요소의 꽉 연결
