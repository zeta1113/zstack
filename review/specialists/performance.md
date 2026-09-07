# 공연 스페셜리스트 리뷰 Checklist

Scope: When SCOPE_BACKEND=true OR SCOPE_FRONTEND=true Output: JSON objects, one finding per line. Schema: {"severity":"CRITICAL|INFORMATIONAL","confidence":N,"path":"file","line":N,"category":"performance","summary":"...","fix":"...","fingerprint":"path:line:performance","specialist":"performance"} Optional: line, fix, fingerprint, evidence, test_stub. If no findings: output `NO FINDINGS` and nothing else.

---

## 카테고리

### N+1 쿼리
- ActiveRecord/ORM 협회는 eager 로딩 없이 루프에서 트래버스를 횡단합니다 (.includes, joinload, include)
- 배치 될 수 있는 이탈 구획 (각, 지도, forEach) 안쪽에 데이타베이스 쿼리
- 게으른-부하된 협회를 트리거하는 일련제
- GraphQL의 해결자는 일괄 처리 대신 per-field를 쿼리합니다 (DataLoader 사용을위한 체크)

### Missing Database 인덱스
- 새로운 WHERE 인덱스 없이 열에 항목 (확인 마이그레이션 파일 또는 스키마)
- ORDER BY 비 색인된 열에
- 복합 지수가 없는 복합 쿼리(WHERE a AND b)
- 인덱스 없이 추가되는 외국 열쇠 란

## # 알고리즘
- O(n^2) 또는 더 나쁜 패턴: 모음에 배열된 루프, Array.find 내부 Array.map
- hash/map/set 보기를 사용할 수 있는 선형 검색을 반복했습니다.
- 루프에 있는 문자열 concatenation (사용은 Join 또는 StringBuilder를 사용)
- 한 번에 큰 컬렉션을 여러 번 필터링하면 suffice

### 번들 크기 충격 (Frontend)
- 알려진 하비 (moment.js, lodash full, jquery)의 새로운 생산 의존성
- 배럴 수입 (library '에서 이동) 대신 깊은 수입 (library/specific에서 이동)
- 최적화 없이 큰 정적 자산(이미지, 폰트)
- 코드 분할 경로 수준 펑크

## 렌더링 성능 (Frontend)
- 볶음 폭포 : 상수 API는 평행 (Promise.all) 일 수 있음
- 불안정한 참고서(새로운 개체/arrays)에서 재 렌더링)
- React.memo, useMemo 또는 useCallback을 비싼 계산에 넣기
- 레이아웃 읽기에서 thrashing 다음 DOM 속성을 작성한 루프
- Missing Load="lazy" 에 아래의 이미지

### 질의 미끄러운
- unbounded 결과를 반환하는 엔드포인트 목록 (LIMIT, 질 params 없음)
- 데이터 볼륨으로 성장하는 LIMIT없이 데이터베이스 쿼리
- API 확장 ID 대신 전체 배열 객체를 포함 하는 응답

### Async Contexts에서 차단
- 동기화 함수 내부의 동기화 I/O (파일 읽기, 서브프로세스, HTTP 요청)
- time.sleep() / Thread.sleep() 내부 이벤트 루프 기반 핸들러
- CPU-일부적인 계산은 노동자 offload 없이 주요 실을 막습니다
