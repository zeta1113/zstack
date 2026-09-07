# Data Migration Specialist 리뷰 목록

Scope: When SCOPE_MIGRATIONS=true Output: JSON objects, one finding per line. Schema: {"severity":"CRITICAL|INFORMATIONAL","confidence":N,"path":"file","line":N,"category":"data-migration","summary":"...","fix":"...","fingerprint":"path:line:data-migration","specialist":"data-migration"} Optional: line, fix, fingerprint, evidence, test_stub. If no findings: output `NO FINDINGS` and nothing else.

---

## 카테고리

## # 재편성
- 이 마이그레이션은 데이터 손실없이 다시 구출 할 수 있습니까?
- 해당 down/rollback 마이그레이션이 있습니까?
- 롤백은 실제로 변경 또는 단지 no-op을하지 않습니다?
- 다시 회전 할 것 이다 현재 응용 프로그램 코드?

## 데이터 손실 위험
- 여전히 데이터가 포함 된 드롭핑 열 (최초의 추가 감축 기간)
- 데이터 (varchar(255) → varchar(50))를 truncate 하는 열 유형 변경
- 코드가 참조하지 않고 테이블 제거
- 모든 참조를 업데이트하지 않고 열을 이름 (ORM, 원시 SQL, 전망)
- NOT NULL constraints는 기존 NULL 값으로 열에 추가했습니다 (첫째로 다시 채우기)

## # 잠금 기간
- ALTER TABLE CONCURRENTLY (PostgreSQL)없이 큰 테이블에 TABLE
- CONCURRENTLY가 없는 인덱스를 >100K 행으로 테이블에 추가
- 다중 ALTER TABLE는 1개의 자물쇠 취득으로 결합될 수 있던 문
- 피크 트래픽 시간 동안 독점적 인 잠금을 취득하는 Schema 변화

## # 백필 전략
- NOT NULL 열 DEFAULT 값이 없는 NOT NULL 열 (변환의 앞에 backfill 필요)
- 일괄 인구가 필요한 기본을 계산 한 새로운 열
- backfill 스크립트를 하거나 기존의 레코드를  레이크 작업
- 일괄 처리 대신 한 번에 모든 행을 업데이트하는 백필 (locks table)

### 인덱스 생성
- CREATE INDEX CONCURRENTLY가 없는 INDEX
- 중복 색인 (새로운 색인은 기존의 것과 동일한 열을 포함합니다)
- 새로운 외국 키 열에 색인을 넣기
- 전체 인덱스가 더 유용할 것 (또는 vice versa)

### 다단계 안전
- Application code로 특정 주문에 배포해야 하는 Migrations
- Schema는 현재 실행 코드를 깰 변경 (코드를 먼저 배포, 다음 마이그레이션)
- 배포 경계를 가정하는 미그레이션 (old code + new schema = crash)
- 혼합 된 old/new 코드를 처리하는 기능 플래그를 밀어 배포
