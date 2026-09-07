# DX 명예의 전당

ONLY 현재 검토 패스의 섹션을 읽어보십시오. NOT 전체 파일을로드하십시오.

## Pass 1: 시작하기

**금 기준:**
- **스트라이프**: 카드 충전을 위한 코드의 7개의 선. 문서 pre-fill YOUR 시험 API 기록될 때 열쇠. 줄무늬 포탄은 docs 페이지 안쪽에 CLI를 달립니다. 국부적으로 설치 필요 없음.
- **팟캐스트**: `git push` = HTTPS와 CDN의 글로벌 사이트. PR는 URL를 미리 가져옵니다. CLI 명령: `vercel`.
- **팟캐스트**: `<SignIn />`, `<SignUp />`, `<UserButton />`. 3 JSX 성분, 이메일, 사회, MFA를 가진 일 오를 상자에서.
- **스파베이스**: 포스트그레스 테이블을 창조하고, 자동 생성 REST API + 즉시 + 자동 문서화 docs를 창조하십시오.
- **관련 기사**: `onSnapshot()`. 오프라인 지속을 가진 모든 클라이언트를 위한 3개의 선.
- **텔리오**: 콘솔의 가상 전화. 번호, 신용 카드를 구입하지 않고 /receive SMS를 보내십시오. 결과: 활성화에 있는 62% 개선.

**반대로 patterns:**
- 모든 값의 이메일 검증 (breaks flow)
- sandbox의 앞에 요구되는 신용 카드
- "당신의 모험을 선택" 여러 경로 (절감 피로; 한 황금 경로 승리)
- API 키가 설정에 숨겨지게 (코드 예로 미리 채워)
- 언어 전환 없이 정적 코드 예
- 대시보드에서 별도의 docs 사이트 (context switching)

## Pass 2: API/CLI/SDK 디자인

**금 기준:**
- **연락처**: `ch_`는 요금을 위해, 고객을 위한 `cus_`. 자동 문서화. 잘못된 ID 유형을 통과하는 것은 불가능합니다.
- **Stripe 확장 가능한 객체**: 기본은 ID 문자열을 반환합니다. `expand[]`는 전체 객체 인라인을 가져옵니다. 4개의 수준까지 배열된 확장.
- **줄무늬 idempotency 열쇠**: mutations에 `Idempotency-Key` 헤더를 통과하십시오. 안전한retries. "did I double-charge?" 불안 없음.
- **줄무늬 API versioning**: 그날의 버전에 첫번째 외침 핀 계정. `Stripe-Version` 헤더를 통해 새로운 버전 per-request를 시험하십시오.
- **GitHub CLI**: 자동 탐지 맨끝 대 관. 맨끝에서 인간 읽을 수 있는, 관할 때 탭 분리되는. `gh pr <tab>`는 전부 PR 활동을 보여줍니다.
- **SwiftUI 진보적인 공개**: `Button("Save") { save() }`는 각 수준에 가득 차있는 주문화, 동일한 API에.
- **htmx의 특징**: HTML 속성은 JS를 대체합니다. 14KB 합계. `hx-get="/search" hx-trigger="keyup changed delay:300ms"`. 0 빌드 단계.
- **shadcn/ui**: 당신의 프로젝트에 소스 코드를 복사합니다. 당신은 각 선을 소유합니다. 신뢰성 없음, 버전 충돌 없음.

**반대로 patterns:**
- Chatty API: 1명의 사용자 접근 가능한 활동을 위한 5개의 전화를 요구
- 영명: `/users` (plural) 대 `/user/123` (singular) 대 `/create-order` (URL에 있는 verb)
- 임플란트 실패: 200 OK 과 오류 응답 몸에 배열
- God endpoint: 47 매개변수는 subset 당 다른 행동과 조화합니다
- 문서 필요 API: 첫 번째 호출 전에 문서의 3 페이지 = 너무 많은 행사

## 패스 3: 오류 메시지 및 디버깅

**오류 품질의 세 계층 :**

**Tier 1, Elm (통역적 컴파일러):**
```
-- TYPE MISMATCH ---- src/Main.elm
I cannot do addition with String values like this one:
42|   "hello" + 1
     ^^^^^^^
Hint: To put strings together, use the (++) operator instead.
```
첫 번째 사람, 완전한 문장, 정확한 위치, 제안 된 수정, 더 읽기.

**Tier 2, Rust (노화 소스):**
```
error[E0308]: mismatched types
 --> src/main.rs:4:20
help: consider borrowing here
  |
4 |     let name: &str = &get_name();
  |                       +
```
튜토리얼에 오류 코드 링크. 1 차 + 이차 라벨. 도움말 섹션은 정확한 편집을 보여줍니다.

**Tier 3, Stripe API (doc_url과 함께 스크루):**
```json
{"error":{"type":"invalid_request_error","code":"resource_missing","message":"No such customer: 'cus_nonexistent'","param":"customer","doc_url":"https://stripe.com/docs/error-codes/resource-missing"}}
```
다섯개의 분야, 영 주변.

**공식:** 무슨 일이 + 왜 + + + 고치는 방법 + 더 많은 것을 배우는 곳 + 실제적인 가치는 일으키는 원인이 되었는지.

**반대로 단락:** TypeScript buries "당신의 뜻을 의미합니까?" 긴 오류 사슬의 BOTTOM. 대부분의 행동 가능한 정보는 FIRST를 나타야 합니다.

## Pass 4: 문서 및 학습

**금 기준:**
- **스트리트 docs**: 3 열 레이아웃 (nav / content / live code). API 키가 로그인되었을 때 주사되었습니다. ALL 페이지의 언어 스위퍼 persists. Hover-to-highlight. in-browser API 호출에 대한 스트립 쉘. 내장 및 오픈 소스 마크 문서. 기능은 최종적으로 발송하지 않습니다. Docs 기여는 성능 리뷰에 영향을 미칩니다.
- 개발자의 52%는 문서 부족으로 차단했습니다 (Postman 2023)
- 세계 최고 수준의 문서와 기업은 채택에 2.5x 증가를 참조하십시오
- "제품으로 손상": 기능 또는 기능으로 배송하지 않습니다

## Pass 5: 업그레이드 및 마이그레이션 경로

**금 기준:**
- **Next.js**: `npx @next/codemod upgrade major`. 1개의 명령은 Next.js, React, React DOM를 격상시키고, 모든 관련 코모를 실행합니다.
- **AG 격자**: v31+의 모든 방출은 codemod를 포함합니다.
- **줄무늬 API versioning**: 내부로 1개의 코디멘트. 계정 당 버전 핀닝. 변화를 끊기지 마십시오. 당신을 놀라지 마십시오.
- **Martin Fowler의 파이프라인 패턴**: 작은, 1개의 monolithic codemod 보다는 오히려 시험할 수 있는 변환을 완료하십시오.
- Maven Central의 끊어지는 21.9%는 문서화되지 않았습니다 (Ochoa et al., 2021)

## Pass 6: 개발자 환경 & 도구

**금 기준:**
- **Bun**: npm 설치 보다는 100x 빠르, Node.js 가동 시간 보다는 4x 더 빠른. 속도 IS DX.
- 평균 일당 87 회 중단; 25 분마다 복구. 코드를 2-4 시간/day.
- 각 1점 DXI 개선 = 주당 개발자당 13분 저장
- **GitHub 코파이로**: 55.8% 빠른 작업 완료. PR 9.6 일에서 2.4 일.

## Pass 7: 커뮤니티 & 생태계

- Dev 도구는 구매하기 전에 ~14 노출이 필요합니다 (Matt Biilmann, Netlify). 1/4 OKR 사이클과 호환됩니다.
- 강력한 개발자 경험 (DevEx Framework)을 가진 팀을위한 4-5x 성능 멀티 플라이어.

## 8을 통과하십시오: DX 측정

**3개의 학문적인 기구:**
1. **SPACE** (Microsoft Research, 2021): Satisfaction, Performance, Activity, Communication, Efficiency. 최소 3 차원 측정.
2. **DevEx 정보** (ACM Queue, 2023): 피드백 루프, 일관성 있는 부하, 흐름 상태. 영구적 + 워크플로 데이터를 결합합니다.
3. **Fagerholm & 런치** (IEEE, 2012) : 인지, 감정, 감정. 심리적 "심리적"

## Claude Code 기술 DX 검사 목록

Claude Code 기술, MCP 서버, AI 에이전트 도구에 대한 플랜을 검토 할 때 사용.

- [ ] **AskUserQuestion 디자인**: 전화 당 1개의 문제점. 배경 상황 (프로젝트, branch, 일). 시각적인 의견을 위한 브라우저 handoff.
- [ ] **국가 저장**: 글로벌 (~/.tool/) vs per-project ($SLUG/) vs per-session. 감사 트레일에 대한 JSONL를 승인합니다.
- [ ] **관련 기사**: 마커 파일로 한 번의 프롬프트. 재작업. 재작업. 재작업. 재작업.
- [ ] **자동 업그레이드**: 캐시 + 스누즈 백오프로 버전 체크. 마이그레이션 스크립트. 인라인 제공.
- [ ] **기술 구성**: chains에서 이득. 검토 chaining. 단면도 건너뛰기와 인라인 invocation.
- [ ] **오류 복구**: 실패에서 재량. 부분적인 결과 보존. 체크포인트 안전.
- [ ] **세션 연속성**: 타임라인 이벤트. 컴팩트 복구. 크로스 세션 학습.
- [ ] **Bounded 자율성**: 명확한 조작 한계. 파괴적인 행동을 위한 필수 에스컬레이션. 감사 길.

참고 구현 : gstack의 디자인 샷건 루프, 자동 업그레이드 흐름, 진보적 인 동의, 계층 저장.
