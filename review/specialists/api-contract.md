# API 계약 전문가 리뷰 목록

Scope: When SCOPE_API=true Output: JSON objects, one finding per line. Schema: {"severity":"CRITICAL|INFORMATIONAL","confidence":N,"path":"file","line":N,"category":"api-contract","summary":"...","fix":"...","fingerprint":"path:line:api-contract","specialist":"api-contract"} Optional: line, fix, fingerprint, evidence, test_stub. If no findings: output `NO FINDINGS` and nothing else.

---

## 카테고리

## # # 파손 변화
- 응답체에서 제거된 필드 (클라이언트는 그에 따라 달라집니다)
- 고정된 필드 타입(string → number, object → array)
- 기존의 엔드포인트에 추가된 새로운 필수 매개 변수
- HTTP 메서드 (GET → POST) 또는 상태 코드 (200 → 201)를 변경했습니다
- 이전 경로 유지 없이 이름을 변경/alias
- 인증 요건 변경 (public → 인증)

## 버전 전략
- 버전 범프없이 변경 (v1 → v2)
- 같은 API (URL 대 헤더 대 쿼리 파라m)에서 혼합 된 여러 버전 전략
- 일몰 타임라인이나 이동 가이드없이 출발점
- 중앙화 대신 컨트롤러를 통해 버전별 논리가 분산되었습니다.

### 오류 응답 일관성
- 새로운 endpoints는 기존의 것보다 다른 오류 형식을 반환
- 오류 응답 누락 표준 필드 (error code, 메시지, 세부 사항)
- HTTP 오류 유형과 일치하지 않는 상태 코드 (200 오류, 유효성 검사를 위해 500)
- 내부 구현 세부 사항을 누출하는 오류 메시지 (stack trace, SQL)

### 비율 제한 & 질
- 비슷한 엔드포인트가 있을 때 새로운 엔드포인트 누락된 비율
- Pagination 변경 (offset → cursor) 뒤로 호환성 없이
- 문서 없이 페이지 크기 또는 기본 제한 변경
- 질의 응답에 있는 총 조사 또는 다음 페이지 지시자를 미스

### 문서 Drift
- OpenAPI/Swagger spec는 새로운 엔드포인트와 변경된 파라미스에 업데이트되지 않습니다
- README 또는 API 변경 후 오래된 동작을 설명하는 문서
- 더 이상 작동하지 않는 경우의 예제 request/responses
- 새 엔드포인트에 대한 문서 작성 또는 변경된 매개 변수

### 뒤로 겸용성
- 이전 버전의 클라이언트: 그들은 끊을 것 이다?
- 강제 업데이트 할 수없는 모바일 앱 : API는 여전히 작동합니까?
- Webhook 페이로드는 가입없이 변경
- SDK 또는 클라이언트 라이브러리 변경은 새로운 기능을 사용해야 합니다.
