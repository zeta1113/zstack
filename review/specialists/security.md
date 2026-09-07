# Security Specialist 리뷰 목록

범위: SCOPE_AUTH=true OR (SCOPE_BACKEND=true AND diff > 100개의 선) 산출: JSON 목표, 선 당 1개의 발견. Schema: {"severity":"CRITICAL|INFORMATIONAL","confidence":N,"path":"file","line":N,"category":"security","summary":"...","fix":"...","finger":"printpath::`NO FINDINGS`, scurity:Not; , 그리고 다른 어떤 선을 찾아내지 않습니다.

---

이 체크리스트는 메인 CRITICAL 패스보다 더 깊어집니다. 주요 에이전트는 이미 SQL 주입, 인종 조건, LLM 신뢰 및 enum completeness를 확인합니다. 이 전문가는 auth/authz 패턴, 암호화 된 오용 및 공격 표면 확장에 중점을 둡니다.

## 카테고리

### Trust Boundaries에서 입력 검증
- 컨트롤러/handler 레벨에서 유효하지 않는 사용자 입력
- Query 매개 변수는 데이터베이스 쿼리 또는 파일 경로에서 직접 사용
- 체내장은 유형 검사 또는 스키마 유효성 검사 없이 허용
- type/size/content 유효성 검사없이 파일 업로드
- Webhook 페이로드 서명 검증 없이 처리

### Auth & 권한이 부여
- Endpoints 누락된 인증 미들웨어 (check route 정의)
- "deny" 대신 "allow"로 기본값이 확인
- 역할 확장 경로 (사용자는 자신의 역할/permissions)
- 직접 객체 참조 취약점 (사용자는 ID를 변경하여 사용자 B의 데이터에 액세스합니다)
- 세션 고정 또는 세션 납치 기회
- Token/API 만료를 확인하지 않는 키 검증

### Injection Vectors (beyond SQL)
- 하위 처리 통화를 통해 명령 주입은 user-controlled 인수를 호출합니다.
- 사용자 입력으로 Template Injection (Jinja2, ERB, Handlebars)
- LDAP 디렉토리 쿼리에 주입
- SSRF 사용자 제어 URL을 통해 (그림, 리디렉션, webhook 대상)
- 사용자 제어 파일 경로 (../../etc/passwd)
- HTTP 헤더의 사용자 제어 값을 통해 헤더 주입

## # Cryptographic 미사용
- 보안 감지 작업에 대한 Weak 해싱 알고리즘 (MD5, SHA1)
- 토큰 또는 비밀에 대한 예측 가능한 랜덤 (Math.random, rand())
- 비소정상 시간 비교 (==) 비밀, 토큰 또는 소화
- 하드 코딩된 암호화 키 또는 IV
- 비밀번호 해시

## 비밀 노출
- API 키, 토큰, 또는 소스 코드의 암호 (덧글 중)
- 로그인한 비밀번호 또는 오류 메시지
- URL의 Credentials (URL의 query 매개변수 또는 기본 오)
- 오류 응답에 민감한 데이터는 사용자에게 반환
- PII 암호화가 예상될 때 일반 텍스트에 저장

## XSS 탈출 하치
- Rails: .html_safe, raw() 사용자 제어 데이터에
- React: user content를 가진 dangerouslySetInnerHTML
- Vue: 사용자 콘텐츠 v-html
- Django: |안전, mark_safe() 사용자 입력
- 일반: unsanitized 자료로 innerHTML 할당

### 탈선화
- 무신뢰 데이터(피클, 마샬, YAML.load, JSON.parse of executable type)
- 사용자 입력 또는 외부 API에서 직렬화 된 개체를 schema 유효성없이 허용
