<!-- AUTO-GENERATED from review-sections.md.tmpl — do not edit directly -->
<!-- Regenerate: bun run gen:skill-docs -->
## 후기 섹션 (11 섹션, 범위 및 모드가 동의 한 후)

**반대로 스키 규칙:** 결코 집광, 약어, 또는 계획 유형 (전략, spec, 코드, 인프라)에 관계없이 모든 리뷰 섹션 (1-11)을 건너 뛰지 마십시오. 이 모든 섹션은 이유에 대한 기술이 존재합니다. "이것은 전략 문서이므로 구현 섹션이 적용되지 않습니다"는 항상 잘못 - 구현 세부 사항이 전략이 중단되는 곳입니다. 실제로 0 개의 발견이 있다면 "문제가 발견되지 않음"라고 말하지만 평가해야합니다.

**반대로 단락:** The plan file is the OUTPUT of the interactive review, not a substitute for it. Writing every finding into one plan write and calling ExitPlanMode without firing AskUserQuestion is the precise failure mode of the May 2026 transcript bug — the model explored, found issues, and dumped them into a deliverable rather than walking the user through them. If you have ANY non-trivial finding in any review section, the path from finding to ExitPlanMode goes THROUGH AskUserQuestion. 모든 섹션에서 Zero 찾기는 AskUserQuestion을 우회하는 ExitPlanMode의 유일한 경로입니다. 요청하기 전에 발견 계획을 작성하고, 중지하고 AskUserQuestion를 호출하기 위해 원하는 경우, 버그가 인식됩니다.

## 섹션 1: 건축 검토 Evaluate 및 다이어그램:
* 전체 시스템 설계 및 구성 요소 경계. 신뢰성 그래프를 그리십시오.
* 데이터 흐름 - 모든 4 경로. 모든 새로운 데이터 흐름에 대 한, ASCII 다이어그램:
    * 행복한 경로 (데이터가 올바르게 흐릅니다)
    * Nil 경로 (입력은 nil/missing — 무슨 일이?)
    * 빈 경로 (입력은 현재이지만 빈/zero-length — 무슨 일이?)
    * 오류 경로 (업스트림 호출 실패 — 무슨 일이?)
* 주 기계. ASCII 모든 새로운 stateful 객체에 대한 다이어그램. 불가능한/invalid 전환을 포함 하 고 그들을 방지.
* 연결 문제. 이제 어떤 구성 요소가 이전에 없었던 것은? 연결이 단결되었습니까? 앞에 /after 의존성 그래프를 그리십시오.
* 특성을 확장. 10x 부하의 첫 번째는 무엇입니까? 100x 미만?
* 실패의 단일 지점. 지도 그들.
* 보안 아키텍처. Auth 경계, 데이터 액세스 패턴, API 표면. 각 새로운 엔드 포인트 또는 데이터 뮤테이션에 대한: 누가 그것을 호출 할 수, 그들이 얻을 수있는, 그들은 무엇을 변경할 수?
* 생산 실패 시나리오. 각 새로운 통합 지점을 위해, 그것을 위한 계획 계정이 있는지 여부를 분석하는 1개의 현실적인 생산 실패 (시간, 폭포, 자료 손상) 및 1개의 실제적인 생산 실패를 설명합니다.
* 롤백 자세. 이 배와 즉시 휴식, 롤백 절차는 무엇입니까? Git 역? 특징 플래그? DB 이동 롤백? 얼마나?

**EXPANSION 및 SELECTIVE EXPANSION 추가:**
* 이 건축은 아름다운 것일까요? 그냥 정확하지 않습니다. 우아한. 6 개월에 가입 한 새로운 엔지니어가 "오, 그 clever와 같은 시간에 분명하다"라고 말합니까?
* 어떤 인프라가 다른 기능들이 구축 할 수있는 플랫폼을 만들 것입니까?

**SELECTIVE EXPANSION:** Step 0D에서 체리픽스가 건축에 영향을 미치는 경우, 건축에 맞는 평가를 해 주십시오. 연결 문제를 만들거나 깨끗하게 통합하지 않는 플래그는 - 새로운 정보와 결정을 다시 볼 수있는 기회입니다.

ASCII 다이어그램: 새로운 구성 요소와 기존의 관계들을 보여주는 전체 시스템 아키텍처. **STOP.** AskUserQuestion 문제가 발생하면 됩니다. NOT 배치를 추천하십시오. + WHY를 추천하십시오. 이 섹션이 0개의 발견을 하게 되면, state "No issues, move on" 및 진행이 진행됩니다. 섹션이 발견되면 MUST는 도구_use로 AskUserQuestion를 호출합니다. "obvious fix"를 찾는 것은 여전히 사용자의 동의서가 될 때까지 계속됩니다. MUST는 도구가 변경 될 때까지 계속됩니다. NOT는 어떤 코드 변경을 만듭니다. 리뷰만.**

## 섹션 2: 오류 및 구조지도 이것은 침묵 장애를 잡는 섹션입니다. 그것은 옵션이 아닙니다. 실패 할 수있는 모든 새로운 방법, 서비스, 또는 코콜을 들어,이 테이블에 채우기 :
```
  METHOD/CODEPATH          | WHAT CAN GO WRONG           | EXCEPTION CLASS
  -------------------------|-----------------------------|-----------------
  ExampleService#call      | API timeout                 | TimeoutError
                           | API returns 429             | RateLimitError
                           | API returns malformed JSON  | JSONParseError
                           | DB connection pool exhausted| ConnectionPoolExhausted
                           | Record not found            | RecordNotFound
  -------------------------|-----------------------------|-----------------

  EXCEPTION CLASS              | RESCUED?  | RESCUE ACTION          | USER SEES
  -----------------------------|-----------|------------------------|------------------
  TimeoutError                 | Y         | Retry 2x, then raise   | "Service temporarily unavailable"
  RateLimitError               | Y         | Backoff + retry         | Nothing (transparent)
  JSONParseError               | N ← GAP   | —                      | 500 error ← BAD
  ConnectionPoolExhausted      | N ← GAP   | —                      | 500 error ← BAD
  RecordNotFound               | Y         | Return nil, log warning | "Not found" message
```
이 섹션의 규칙:
* Catch-all 오류 처리 (`rescue StandardError`, `catch (Exception e)`, `except Exception`)는 ALWAYS 냄새입니다. 특정 예외를 명명하십시오.
* 일반적인 로그 메시지만 넣는 오류를 촉구하는 것은 충분합니다. 전체 컨텍스트를 로그: 어떤 인수와 함께 시도한 것은, 어떤 user/request.
* 모든 구조 오류는 다음과 같습니다. backoff, 사용자의 눈에 띄는 메시지로 우아한 또는 추가 된 컨텍스트로 재 정렬. "Swallow and keep"는 거의 허용되지 않습니다.
* 각 GAP (구출되는 오류가 발생): 구조 동작을 지정하고 사용자가 볼 수 있는지.
* LLM/AI 서비스는 특히 호출합니다: 응답이 변형될 때 무슨 일이 일어나는가? 그것이 비어있을 때? 그것이 홀로그램이 유효하지 않은 JSON를 삭제할 때? 모델이 거부를 반환하면? 이 각각의 것은 명백한 실패 형태입니다.
**STOP.** AskUserQuestion 문제가 발생하면 됩니다. NOT 배치를 하십시오. 추천 + WHY. 이 섹션이 0개의 발견, 국가 "문제가 발생하지 않는 경우," 진행 중입니다. 섹션이 발견되면, MUST 호출 AskUserQuestion 도구로 - "obvious fix"를 찾는 것은 여전히 계획의 변화 땅의 앞에 사용자 승인을 찾는 것입니다. NOT가 사용자에 반응할 때까지 진행합니다.

## Section 3: Security & Threat Model Security는 건축의 하위 구부러지지 않습니다. 그것은 자신의 섹션을 가져옵니다. Evaluate :
* 공격 표면 확장. 새로운 공격 벡터는이 계획이 소개됩니까? 새로운 엔드포인트, 새로운 퍼머, 새로운 파일 경로, 새로운 배경 작업?
* 입력 검증. 모든 새로운 사용자 입력: 그것은 유효, 위생, 실패에 크게 거부? 어떤 일이 발생: nil, 빈 문자열, 문자열을 integer 예상, 문자열을 초과 최대 길이, unicode 가장자리 케이스, HTML/script 주입 시도?
* 권한. 모든 새로운 데이터 액세스 : 올바른 user/role에 따라 되나요? 직접 객체 참조 취약점이 있습니까? 사용자 접근 사용자 B의 데이터가 ID를 조작하여 접근 할 수 있습니까?
* 비밀과 자격. 새로운 비밀? env vars에서, 하드 코딩되지? Rotatable?
* 위험. 새로운 보석/npm 패키지? 보안 트랙 기록?
* 데이터 분류. PII, 결제 데이터, 자격? 기존 패턴으로 일관된 처리?
* 주입 벡터. SQL, 명령, 템플릿, LLM 프롬프트 주사 — 모두 검사.
* 감사 로깅. 민감한 작업 : 감사 흔적이 있습니까?

각 발견의 경우: 위협, likelihood (High/Med/Low), 충격 (High/Med/Low), 그리고 계획이 그것을 미량화한다는 것을. **STOP.** AskUserQuestion는 문제점 당 한 번. NOT 배치를 하십시오. 추천 + WHY. 이 단면도가 0개의 발견을 돌리면, 국가 "문제 없음, 이동" 및 진행. 단면도가 발견되면, 당신은 MUST는 도구로 AskUserQuestion를 호출합니다. — 를 가진 것은 “ob/m”를 찾아내기 전에 아직도 어떤 문제든지 해결하는지, 봅니다. NOT는 어떤 코드 변경을 만듭니다. 리뷰만.**

## 섹션 4: 데이터 흐름 & 인터 액션 에지 케이스 이 섹션은 adversarial thoroughness와 함께 UI를 통해 시스템 및 상호 작용을 통해 데이터를 추적합니다.

**자료 교류 Tracing:** 모든 새로운 자료 교류를 위해, ASCII 도표 전시를 일으키십시오:
```
  INPUT ──▶ VALIDATION ──▶ TRANSFORM ──▶ PERSIST ──▶ OUTPUT
    │            │              │            │           │
    ▼            ▼              ▼            ▼           ▼
  [nil?]    [invalid?]    [exception?]  [conflict?]  [stale?]
  [empty?]  [too long?]   [timeout?]    [dup key?]   [partial?]
  [wrong    [wrong type?] [OOM?]        [locked?]    [encoding?]
   type?]
```
각 노드의 경우: 각 그림자 경로에 무슨 일이 발생합니까? 테스트 되었습니까?

**상호 작용 가장자리 상자:** 모든 새로운 사용자 접근을 위해, 평가:
```
  INTERACTION          | EDGE CASE              | HANDLED? | HOW?
  ---------------------|------------------------|----------|--------
  Form submission      | Double-click submit    | ?        |
                       | Submit with stale CSRF | ?        |
                       | Submit during deploy   | ?        |
  Async operation      | User navigates away    | ?        |
                       | Operation times out    | ?        |
                       | Retry while in-flight  | ?        |
  List/table view      | Zero results           | ?        |
                       | 10,000 results         | ?        |
                       | Results change mid-page| ?        |
  Background job       | Job fails after 3 of   | ?        |
                       | 10 items processed     |          |
                       | Job runs twice (dup)   | ?        |
                       | Queue backs up 2 hours | ?        |
```
이 섹션은 "이러한"을 의미하는 "이러한"을 의미하는 "이러한"을 의미하는 "이러한"을 의미하는 "이러한"을 의미하는 "이러한"을 의미하는 "이러한"을 의미하는 "이러한"을 의미하는 "이러한"을 의미하는 "이러한"을 의미하는 "이러한"을 의미하는 "이러한"을 의미하는 "이러한"를 의미하는 "이러한"를 의미하는 "이러한"를 의미하는 "이러한"를 의미하는 "이러한"를 의미한다.

## 섹션 5: 코드 품질 검토 Evaluate:
* Code 조직 및 모듈 구조. 새로운 코드는 기존 패턴을 적합합니까? 탈선하면 이유가 있습니까?
* DRY 위반. 공격적. 같은 논리가 다른 곳에 존재한다면, 플래그와 참조 파일과 줄.
* Naming 품질. 새로운 클래스, 방법, 그리고 그들이 무엇을 의미하는 변수, 그들은 어떻게합니까?
* 오류 처리 패턴. (섹션 2과의 환경 설정 -이 섹션은 패턴을 검토; 섹션 2 특정지도.)
* 가장자리 케이스를 미스링. 목록은 명시적으로 : "X가 nil 때 어떻게됩니까?" "API가 429를 반환하면?"등.
* 오버 엔지니어링 검사. 새로운 요약은 아직 존재하지 않는 문제가 해결되지?
* 아래 엔지니어링 체크. 아무것도 fragile, 행복 한 경로 만, 또는 명백한 방어적인 체크를 누락?
* Cyclomatic 복잡성. 5 배 이상 branch하는 새로운 방법을 플래그. 다시 팩터를 버린다.
**STOP.** AskUserQuestion 문제가 발생하면 됩니다. NOT 배치를 하십시오. 추천 + WHY. 이 섹션이 0개의 발견, 국가 "문제가 발생하지 않는 경우," 진행 중입니다. 섹션이 발견되면, MUST 호출 AskUserQuestion 도구로 - "obvious fix"를 찾는 것은 여전히 계획의 변화 땅의 앞에 사용자 승인을 찾는 것입니다. NOT가 사용자에 반응할 때까지 진행합니다.

## 섹션 6: 테스트 검토는이 계획의 모든 새로운 것의 전체 다이어그램을 소개합니다:
```
  NEW UX FLOWS:
    [list each new user-visible interaction]

  NEW DATA FLOWS:
    [list each new path data takes through the system]

  NEW CODEPATHS:
    [list each new branch, condition, or execution path]

  NEW BACKGROUND JOBS / ASYNC WORK:
    [list each]

  NEW INTEGRATIONS / EXTERNAL CALLS:
    [list each]

  NEW ERROR/RESCUE PATHS:
    [list each — cross-reference Section 2]
```
도표에 있는 각 품목을 위해:
* 테스트의 종류는 무엇입니까? (단위 / 통합 / 시스템 / E2E)
* 이 플랜에 대한 테스트가 있습니까? 그렇지 않은 경우, 테스트 spec 헤더를 작성하십시오.
* 행복한 경로 테스트는 무엇입니까?
* 실패 경로 테스트는 무엇입니까? (특히 실패?)
* 가장자리 케이스 테스트는 무엇입니까? (nil, 빈, 경계 값, 동시 액세스)

테스트 주위 검사 (모든 모드): 각 새로운 기능에 대 한, 대답:
* 금요일 오전 2시에서 배송을 받으려면 어떤 테스트가 있습니까?
* 어떤 테스트는 hostile QA 엔지니어가 이것을 깰 수 있습니까?
* 카오스 테스트란?

pyramid 검사: 많은 단위, 몇몇 통합, 몇몇 E2E? 또는 거꾸로? 불경기 위험: 시각, 무작위, 외부 서비스, 또는 주문에 따라서 어떤 시험든지 깃발. 짐/stress 시험 필요조건: 자주 칭한 어떤 새로운 코파든지를 위해 또는 뜻깊은 자료 처리.

LLM/prompt 변경: CLAUDE.md를 "Prompt/LLM 변경"파일 패턴에 대해 확인하십시오. 이 계획이 ANY를 입력하면, eval suites가 실행되어야 하는 상태, 어떤 경우 추가되어야 하고, 어떤 기본 요소가 비교해야 합니다. **STOP.** AskUserQuestion를 문제 당 한 번에. NOT 배치를 하십시오. 추천 + WHY. 이 섹션이 0 state, 진행 및 진행을 찾지 못하면 "No 이동" 문제 및 문제 발생이 발생하지 않습니다. 섹션이 발견되면, MUST 호출 AskUserQuestion 도구로 - "obvious fix"를 찾는 것은 여전히 계획의 토지를 변경하기 전에 사용자 승인을 찾는 것입니다. NOT 사용자 응답까지 진행하십시오. **Reminder: NOT는 어떤 코드 변경을 만듭니다. 검토만 합니다.**

## 섹션 7: 성능 검토 에바루ate:
* N+1 쿼리. 모든 새로운 ActiveRecord 협회의 트레이널에 대 한: 포함 된/preload?
* 기억 사용. 모든 새로운 자료 구조를 위해: 생산에 있는 최대 크기는 무엇입니까?
* 데이터베이스 인덱스. 모든 새로운 쿼리에 대 한: 인덱스가 있다?
* 캐싱 기회. 모든 비싼 계산 또는 외부 통화에 대 한: 그것은 캐시 되어야 합니까?
* 배경 작업 sizing. 모든 새로운 작업에 대 한: 최악의 케이스 페이로드, 런타임, 재try 행동?
* 느린 경로. 최고 3 가장 느린 새로운 코파와 추정된 p99 대기 시간.
* 연결 풀 압력. 새로운 DB 연결, Redis 연결, HTTP 연결?
**STOP.** AskUserQuestion 문제가 발생하면 됩니다. NOT 배치를 하십시오. 추천 + WHY. 이 섹션이 0개의 발견, 국가 "문제가 발생하지 않는 경우," 진행 중입니다. 섹션이 발견되면, MUST 호출 AskUserQuestion 도구로 - "obvious fix"를 찾는 것은 여전히 계획의 변화 땅의 앞에 사용자 승인을 찾는 것입니다. NOT가 사용자에 반응할 때까지 진행합니다.

## 섹션 8: Observability & Debuggability Review 새로운 시스템 휴식. 이 섹션은 당신이 왜 볼 수 있도록. 에바루이트:
* 로깅. 모든 새로운 코로웨이의 경우: 입력, 출구 및 각 중요한 지점에서 구조화 된 로그 라인?
* 미터. 모든 새로운 기능 : 미터가 작동되는 것을 말해주는 것은 무엇입니까? 어떻게 깨어 났습니까?
* Tracing. 새로운 크로스 서비스 또는 크로스 작업 흐름: 추적 ID는 전파?
* 알러스팅. 새로운 경고가 존재하는가?
* 대시보드. 새로운 대시보드 패널은 1일을 원하십니까?
* 부유성. 버그가 3 주 후의 소식을 보고하면, 혼자 로그에서 무슨 일이 있었는지 재구성할 수 있습니까?
* 관리자 도구. 관리자 UI 또는 rake 작업을 필요로 하는 새로운 작업 작업?
* Runbooks. 각 새로운 실패 모드: 작업 응답은 무엇입니까?

**EXPANSION 및 SELECTIVE EXPANSION 추가:**
* 어떤 관찰력이 작동하기 위해 기쁨을 만들 것입니까? ( SELECTIVE EXPANSION의 경우 허용 된 체리 - 피크에 대한 관측 가능성을 포함한다.)
**STOP.** AskUserQuestion 문제가 발생하면 됩니다. NOT 배치를 하십시오. 추천 + WHY. 이 섹션이 0개의 발견, 국가 "문제가 발생하지 않는 경우," 진행 중입니다. 섹션이 발견되면, MUST 호출 AskUserQuestion 도구로 - "obvious fix"를 찾는 것은 여전히 계획의 변화 땅의 앞에 사용자 승인을 찾는 것입니다. NOT가 사용자에 반응할 때까지 진행합니다.

## 섹션 9: 배포 및 롤아웃 검토:
* 마이그레이션 안전. 모든 새로운 DB 마이그레이션: 백워드 호환? Zero-downtime? 테이블 잠금?
* 기능 플래그. 어떤 부분이 기능 플래그 뒤에 있어야?
* 롤아웃 순서. 정확한 순서: 먼저 마이그레이션, 두 번째 배포?
* 롤백 계획. Explicit 단계별.
* 배포 시간 위험 창. 이전 코드 및 새로운 코드 실행 동시에 — 무슨 휴식?
* 환경 불변. 시효에 테스트?
* 포스트 배포 검증 검사 목록. 첫 5 분? 첫 번째 시간?
* 연기 테스트. 자동 검사는 즉시 포스트 배포를 실행해야 합니까?

**EXPANSION 및 SELECTIVE EXPANSION 추가:**
* 인프라는 이 기능을 일상적으로 배송할 수 있을까요? (SELECTIVE EXPANSION 의 경우, 허용된 체리 픽크스가 배포 위험 프로파일을 변경할 수 있는지 평가합니다.)
**STOP.** AskUserQuestion 문제가 발생하면 됩니다. NOT 배치를 하십시오. 추천 + WHY. 이 섹션이 0개의 발견, 국가 "문제가 발생하지 않는 경우," 진행 중입니다. 섹션이 발견되면, MUST 호출 AskUserQuestion 도구로 - "obvious fix"를 찾는 것은 여전히 계획의 변화 땅의 앞에 사용자 승인을 찾는 것입니다. NOT가 사용자에 반응할 때까지 진행합니다.

## 섹션 10 : Long-Term Trajectory 검토 에바루ate :
* 기술 부채 도입. 코드 부채, 운영 부채, 테스트 부채, 문서 부채.
* Path Dependency. 이 변화는 더 열심히?
* 지식 농도. 새로운 엔지니어를 위해 충분한 문서?
* 신뢰성. 비율 1-5: 1 = 편도 문, 5 = 쉽게 뒤집을 수 있습니다.
* 에코시스템 적합. 철도/JS 생태계 방향을 가진 정렬?
* 1 년 질문. 12 개월 동안 새로운 엔지니어로이 계획을 읽으십시오. 명백?

**EXPANSION 및 SELECTIVE EXPANSION 추가:**
* 이 배 후에 무엇이 옵니다? 2 단계? 3 단계? trajectory가 건축 지원합니까?
* 플랫폼 잠재력. 이 기능을 다른 기능을 활용할 수 있습니까?
* (SELECTIVE EXPANSION만) 복고풍: 우리는 적당한 체리 픽크를 받아들입니까? 어떤 거부된 확장든지 받아들여진 것을 위해 짐 방위이기 위하여 밖으로 돌았습니다?
**STOP.** AskUserQuestion 문제가 발생하면 됩니다. NOT 배치를 하십시오. 추천 + WHY. 이 섹션이 0개의 발견, 국가 "문제가 발생하지 않는 경우," 진행 중입니다. 섹션이 발견되면, MUST 호출 AskUserQuestion 도구로 - "obvious fix"를 찾는 것은 여전히 계획의 변화 땅의 앞에 사용자 승인을 찾는 것입니다. NOT가 사용자에 반응할 때까지 진행합니다.

## 섹션 11: 디자인 & UX 검토 (UI 범위가 감지되지 않는 경우 스키) 디자이너에 호출하는 CEO. 픽셀 레벨 감사 - 그 /plan-design-review 및 /design-review. 이 계획은 의도적 디자인이 보장됩니다.

에바루이트:
* 정보 아키텍처 - 사용자가 먼저 볼 수있는 것은, 둘째, 세 번째?
* Interaction 상태 적용 지도:
  FEATURE | LOADING | EMPTY | ERROR | SUCCESS | PARTIAL
* 사용자 여행의 일관성 — 감정적인 아크를 이야기
* AI 슬로프 위험 - 계획은 일반 UI 패턴을 설명합니까?
* DESIGN.md 정렬 - 계획은 명시된 디자인 시스템을 일치합니까?
* 책임있는 의도 - 모바일 언급 또는 afterthought?
* 접근성 기본 - 키보드 네브, 스크린 리더, 대비, 터치 타겟

**EXPANSION 및 SELECTIVE EXPANSION 추가:**
* What would make this UI feel *의외선*?
* 30분 UI 터치가 사용자가 "좋아요, 그들은 그 생각을 만들 것"?

필요한 ASCII 다이어그램: 사용자 흐름 표시 화면/states 및 전환.

이 계획이 중요한 경우 UI 범위, 추천: "Consider running /plan-design-review 구현 전에이 계획의 깊은 디자인 검토에 대한." **STOP.** AskUserQuestion 문제가 한 번. 할 NOT 배치. 추천 + WHY. 이 섹션이 0 개 발견을 설정하면, 국가 "문제가 없습니다"및 진행. 섹션이 발견되면, MUST는 도구로 AskUserQuestion를 호출합니다. ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- NOT 사용자가 응답할 때까지 진행합니다. **Reminder: NOT는 어떤 코드 변경을 만듭니다. 검토만 합니다.**

## 외부 음성 — 독립 계획 도전 (과태에)

모든 리뷰 섹션이 완료되면, 다른 AI 시스템에서 독립적 인 두 번째 의견을 자동으로 실행하십시오. 계획 검토의 표준 부분이 아닌 선택 인 계획 검토가 아닙니다. 계획의 두 모델은 한 모델의 철저한 검토보다 강한 신호입니다. 사용자는 명시적으로 묻는 (`gstack-config set codex_reviews disabled`)에서만이 꺼집니다.

**Preflight — 외부 음성이 실행되는지 결정합니다:**

```bash
# Codex preflight: one block (functions sourced here don't persist to later blocks).
_TEL=$(~/.claude/skills/gstack/bin/gstack-config get telemetry 2>/dev/null || echo off)
_CODEX_CFG=$(~/.claude/skills/gstack/bin/gstack-config get codex_reviews 2>/dev/null || echo enabled)
source ~/.claude/skills/gstack/bin/gstack-codex-probe 2>/dev/null || true
if [ "$_CODEX_CFG" = "disabled" ]; then
  _CODEX_MODE="disabled"
# Running-under-Codex presence probe (#2519): a live Codex session exports
# CODEX_THREAD_ID / CODEX_SANDBOX into every shell it spawns (verified
# against a live `codex exec 'env | grep -i codex'` capture, codex 0.147.0).
# Nested codex spawns from inside a Codex host multiply token burn
# (observed: one /review = 15M tokens). GSTACK_FORCE_CODEX_REVIEW=1 forces
# the nested passes anyway.
elif [ "${GSTACK_FORCE_CODEX_REVIEW:-0}" != "1" ] && { [ -n "${CODEX_THREAD_ID:-}" ] || [ -n "${CODEX_SANDBOX:-}" ]; }; then
  _CODEX_MODE="under_codex"
elif ! command -v codex >/dev/null 2>&1; then
  _CODEX_MODE="not_installed"; _gstack_codex_log_event "codex_cli_missing" 2>/dev/null || true
elif ! _gstack_codex_auth_probe >/dev/null 2>&1; then
  _CODEX_MODE="not_authed"; _gstack_codex_log_event "codex_auth_failed" 2>/dev/null || true
else
  # Capture the probe's code: 2 means the CLI cannot execute at all, which is a
  # different problem (and a different fix) from a model the account can't use.
  _gstack_codex_model_probe; _CODEX_MP=$?
  if [ "$_CODEX_MP" -eq 2 ]; then
    _CODEX_MODE="broken_install"
  elif [ "$_CODEX_MP" -ne 0 ]; then
    _CODEX_MODE="model_unusable"
  else
    _CODEX_MODE="ready"; _gstack_codex_version_check 2>/dev/null || true
  fi
fi
echo "CODEX_MODE: $_CODEX_MODE"
```

`CODEX_MODE` 에 분기:
- **`disabled`** - 사용자가 Codex (`codex_reviews=disabled`)를 끄는 것을 돕습니다. 이 단면도를 전적으로 건너십시오; NOT는 Claude subagent에 뒤떨어졌습니다 - 추가 검토 단계가 아닙니다. 인쇄: "Codex 검토 건너뛰기 (codex_리뷰 사용 가능). 재사용 가능: `gstack-config set codex_reviews 활성화된 것"을."
- **`not_installed`** — Codex CLI absent. 인쇄: "Codex 설치되지 않음 - Claude subagent (fresh context, 하지만 SAME 모델 가족- 외부 모델)로 다시 떨어지십시오. Codex를 실제 외부 모델에 읽습니다: `npm install -g @openai/codex`." Claude subagent 경로로 돌아갑니다.
- **`under_codex`** - 이 세션은 이미 INSIDE를 Codex 호스트로 실행하고, 그래서 코드를 다시 복사하는 같은 모델은 멀티플린 토큰 비용 (#2519)에서 자체를 검토하는 동일 모델입니다. Codex 아래에서 실행하는 GSTACK_FORCE_CODEX_REVIEW=1를 강제로 설정하고 아래 코덱 주장을 건너 뛰십시오. 대신 섹션의 무료 호스트 패스를 실행하면 하나 정의를 정의합니다.
- **`not_authed`** - 설치하지만, 자격 증명이 없습니다. 인쇄 : "Codex 설치되었지만 인증되지 않은 - Claude 에이전트 (모델 가족, 외부 모델)로 다시 떨어지십시오. `codex login` 또는 `$CODEX_API_KEY`를 실행하십시오. Claude 에이전트 경로로 돌아갑니다.
- **`broken_install`** - CLI는 PATH에 이고, (ENOENT, 비 executable 바이너리, 누락된 납품업자 탑재)를 실행할 수 없습니다. 인쇄: "Codex는 설치되 그러나 그것의 이진은 실행할 수 없습니다 — Codex는 건너뛰기. 재설치: `npm install -g @openai/codex`." 릴레이 조사 HINT 선은 Claude 에이전트 경로로 돌아갑니다. 이 상태는 이진이 이진 때문에, 이진은 이렇게 뛰기 위하여, 이렇게 `ready`를 통과하고, 이렇게 뛰기 위하여, 이렇게 갔습니다.
- **`model_unusable`** - authed 하지만 계정은 구성 된 모델을 사용할 수 없습니다 (#2477: HTTP 400 모든 호출에, 보통 stale `model =` 핀 `~/.codex/config.toml`). 프로브의 HINT 라인을 릴레이, 사용자를 알려줍니다. 한 줄 수정 (핀을 업데이트; `[notice.model_migrations]` 이름 교체), 그리고 Claude 에이전트 경로로 돌아갑니다. ~10s 라운드 여행은 1 시간 동안 열리기; `[notice.model_migrations]`는 교체를 의미한다.
- **`ready`** - 아래 Codex 패스를 실행합니다.

모드가 `ready`, `not_installed`, 또는 `not_authed`일 때, off-switch가 발견될 때: "외부 음성을 자동적으로 (표준 단계) 놓기. 비활성화: `gstack-config set codex_reviews disabled`."

**계획 검토를 지시** ( `ready`, `not_installed`, `not_authed` - `disabled`에서만 건너뛰기). 검토되는 계획 파일을 읽으십시오 (파일 사용자는 이 검토를, 또는 branch 디프 범위에 지적했습니다). CEO 계획 문서가 단계 0D-POST에서 기록된 경우에, 이렇게 읽으십시오 — 범위 결정 및 시각을 포함합니다.

이 프롬프트를 구축 (실제 계획 내용에 따라 - 계획 내용이 30KB를 초과하면, 첫 30KB에 truncate 및 "플랜 크기에 대한 truncated"). **항상 filesystem 경계 지시와 시작:**

"IMPORTANT: NOT는 ~/.claude/, ~/.agents/, .claude/skills/, 또는 에이전트/의 밑에 어떤 파일을 읽거나 실행합니다. 이들은 Claude Code 기술 정의가 다른 AI 체계를 의미하지 않습니다. 그들은 bash 스크립트와 신속한 템플릿을 포함해 당신의 시간을 낭비하. 그것을 완전하게 무시하십시오. NOT는 Agent/openai.yaml를 수정합니다. 저장소 코드 only.\n\nYou를 통해서 집중된 유지하십시오. 기술적인 검토는 이미 기술적인 계획이 있는 경우에, 우리의 기술적인 검토가 있습니다. 이 웹 사이트는 귀하가 웹 사이트를 탐색하는 동안 귀하의 경험을 향상시키기 위해 쿠키를 사용합니다. 이 쿠키들 중에서 필요에 따라 분류 된 쿠키는 웹 사이트의 기본적인 기능을 수행하는 데 필수적이므로 브라우저에 저장됩니다. 또한이 웹 사이트의 사용 방식을 분석하고 이해하는 데 도움이되는 제 3 자 쿠키를 사용합니다. 이 쿠키는 귀하의 동의하에 만 브라우저에 저장됩니다. 이러한 쿠키를 거부 할 수도 있습니다. 이러한 쿠키 중 일부를 선택 해제하면 검색 환경에 영향을 미칠 수 있습니다.

THE PLAN: <plan content>"

**`CODEX_MODE: ready` - Codex 실행:**

```bash
TMPERR_PV=$(mktemp /tmp/codex-planreview-XXXXXXXX)
_REPO_ROOT=$(git rev-parse --show-toplevel) || { echo "ERROR: not in a git repo" >&2; exit 1; }
codex exec "<prompt>" -C "$_REPO_ROOT" -s read-only -c 'model_reasoning_effort="high"' -c 'web_search="cached"' < /dev/null 2>"$TMPERR_PV"
```

5분 간격을 사용하십시오 (`timeout: 300000`). 명령이 완료된 후, stderr를 읽으십시오:
```bash
cat "$TMPERR_PV"
```

출력 동사:

```
CODEX SAYS (plan review — outside voice):
════════════════════════════════════════════════════════════
<full codex output, verbatim — do not truncate or summarize>
════════════════════════════════════════════════════════════
```

**오류 처리 :** 모든 오류는 비 차단되지 않습니다. - 외부 음성은 정보입니다.
- Auth 실패 (stderr는 "auth", "login", " 무단") : "Codex auth 실패. \`codex login\`를 실행하여 인증."아래 Claude 에이전트으로 돌아갑니다.
- 타임아웃: "Codex 5분 후 시간. Claude 이하로 돌아갑니다.
- 빈 응답: "Codex 응답을 반환하지." 아래 Claude 에이전트에 다시.

**`CODEX_MODE: not_installed` 또는 `not_authed` (또는 Codex)가 runtime에 과실된 경우:**

`run_in_background: false` (Claude Code v2.1.198 이후 배경에 따라 기본 사항)와 에이전트 도구를 통해 Dispatch; 결과는 워크플로가 계속되기 전에 착륙해야 합니다. 서브 에이전트에는 신선한 컨텍스트와 대화 비스듬한이 있지만, 외부 모델이 아닌 SAME 모델 가족입니다. Codex와 같은 방식으로 무게를 다십시오. "never blocking"은 "never blocking"도 "never blocking"도 "never blocking"도 "never blocking"으로 파견하십시오."

Subagent 신속한: 위의 것과 동일한 계획 검토 신속한.

`OUTSIDE VOICE (Claude subagent):` 헤더에 대한 현재 발견.

에이전트이 실패하거나 밖으로 시간: "아웃사이드 목소리는 사용할 수 없습니다. 출력에 계속."

(`CODEX_MODE: disabled`에 이미 이 섹션을 건너 뛰고 있습니다. - 여기에 도달하지 마십시오.)

**크로스 모델 긴장:**

외부 음성 발견을 제시 한 후, 외부 음성이 이전 섹션에서 발견 한 리뷰와 관련하여 방해하는 점을 참고하십시오. 다음과 같이 플래그 :

```
CROSS-MODEL TENSION:
  [Topic]: Review said X. Outside voice says Y. [Present both perspectives neutrally.
  State what context you might be missing that would change the answer.]
```

**사용자 Sovereignty:** Do NOT는 외부 음성 권고를 계획으로 자동화합니다. 사용자가 결정합니다. 크로스 모델 계약은 강한 신호입니다. 그런 다음 NOT는 행동 권한을 부여합니다. 더 많은 칭찬을 발견 할 수 있지만 MUST NOT는 명시적 사용자 승인없이 변경을 적용합니다.

각 substantive 긴장 점을 위해, 사용 AskUserQuestion:

> "Cross-model disagreement on [topic]. 리뷰는 [X]를 찾았지만 외부 목소리
> argues [Y]. [누락 할 수있는 어떤 상황에 대한 하나의 문장.]"
>
> RECOMMENDATION: [A 또는 B]를 선택하기 때문에 [한 줄의 인수를 설명하는 이유
> 더 칭찬하고 왜]. 완료: A=X/10, B=Y/10.

옵션:
- A) 외부 음성의 권고 (나는이 변경을 적용 할 것입니다)
- B) 현재 접근을 유지 (외부 음성을 거부)
- C) 더 많은 것을 감소시키기 전에 투자하십시오
- D) TODOS.md에 나중에 추가하십시오

사용자의 응답을 기다립니다. NOT 기본적으로 외부 목소리에 동의하기 때문에 허용. 사용자가 B를 선택하면 현재 접근 방식을 의미합니다. - 다시 -argue하지 마십시오.

긴장이 없는 경우, 주의: "크로스 모델 텐션 없음 — 모두 검토자 동의."

**결과의 결과 :**
```bash
~/.claude/skills/gstack/bin/gstack-review-log '{"skill":"codex-plan-review","timestamp":"'"$(date -u +%Y-%m-%dT%H:%M:%SZ)"'","status":"STATUS","source":"SOURCE","commit":"'"$(git rev-parse --short HEAD)"'"}'
```

대칭: STATUS = "클린" 찾는 경우, "issues_found"를 찾을 수 없습니다. SOURCE = "codex" if Codex ran, "claude" if subagent ran.

**청소:** 처리 후 `rm -f "$TMPERR_PV"` 실행 (Codex가 사용되었는지).

---

## 외부 음성 통합 규칙

외부 음성 검색은 INFORMATIONAL 으로 사용자가 명시적으로 각 것을 승인할 때까지. NOT 외부 음성 권고를 AskUserQuestion 을 통해 각 발견을 제시하지 않고 계획 외부 음성 권고를 통합하고 명시적 승인을 얻게 됩니다. 이 적용은 외부 음성에 동의할 때도 적용됩니다. Cross-model consensus는 강력한 신호입니다. — 이러한 존재를 나타내지만 사용자는 결정이 됩니다.

## Post-Implementation Design Audit (UI 범위가 감지된 경우) 구현 후, 렌더링 된 출력으로 평가 될 수있는 시각적 문제를 파악하는 라이브 사이트에 `/design-review`를 실행합니다.

## CRITICAL RULE — 위의 Preamble에서 AskUserQuestion 형식을 따르는 방법. 플랜 리뷰에 대한 추가 규칙:
* **하나의 문제 = 하나 AskUserQuestion 호출.** 여러 가지 문제를 하나의 문제로 결합하지 마십시오.
* 문제 구체적으로 설명, 파일 및 라인 참조.
* 합리적인 곳에 "do nothing"을 포함하여 2-3 가지 옵션이 있습니다.
* 각 옵션: 노력, 위험, 유지 보수 부담 1 선.
* **위의 엔지니어링 선호도에 대한 이유를 알아보세요.** 특정한 선호도에 대한 권고를 연결 한 문장.
* 문제 NUMBER + 옵션 LETTER (예: "3A", "3B").
* **Zero 발견 :** 섹션이 0개의 발견이 있는 경우, 국가 "문제가 없습니다."를 진행하고 진행합니다. 그렇지 않으면, 각 발견을 위해 AskUserQuestion를 사용하십시오. "obvious fix"를 찾는 것은 여전히 계획의 어떤 변화 땅의 앞에 사용자 승인을 필요로 합니다.

## 필수 산출

### "NOT in 범위" 섹션 목록은 각각 한 줄 합리적으로 간주하고 명시적으로 적습니다.

### "여기있는 것은"섹션 목록 기존의 code/flows 부분적으로 하위 프로블럼을 해결하고 계획이 거부 여부를 결정합니다.

### "Dream state delta"섹션이 계획이 12 개월 이상에 관계되는 것을 나타낸다.

### Error & Rescue Registry (from Section 2) 실패 할 수있는 모든 방법의 전체 테이블, 모든 예외 클래스, 구조 상태, 구조 동작, 사용자 영향.

### 실패 모드 레지스트리
```
  CODEPATH | FAILURE MODE   | RESCUED? | TEST? | USER SEES?     | LOGGED?
  ---------|----------------|----------|-------|----------------|--------
```
RESCUED=N, TEST=N, USER SEES=Silent → **CRITICAL GAP**를 가진 어떤 줄.

### TODOS.md 업데이트는 각각의 잠재적인 TODO를 자신의 개별 AskUserQuestion로 업데이트합니다. 절대로 배치하지 마십시오. 절대로 이 단계를 건너 뛰지 마십시오. `~/.claude/skills/gstack/review/TODOS-format.md`의 형식을 따르십시오.

각 TODO를 위해, 묘사:
* **이름:** 일의 원라인 설명.
* **왜:** 콘크리트 문제 해결 또는 그것을 잠금 해제.
* **프로 :** 이 일을 해서 얻는 것은 무엇입니까?
* **단점 :** 비용, 복잡성, 또는 그것을 하는 위험.
* **구성 :** 3개월 동안 이를 선택한 사람이 동기, 현재 상태, 그리고 시작을 이해하는 것을 충분히 세부합니다.
* **Effort 견적:** S/M/L/XL (human 팀) → CC+gstack: S→S, M→S, L→M, XL→L
* **우선 순위:** P1/P2/P3
* **/에 따라 달라집니다:** 어떤 전제든지 또는 주문 constraints.

그런 다음 현재 옵션 : **A)** TODOS.md **B) (아)** Skip에 추가 - 충분히 값이 좋지 않은 **C) (아)** 이 PR 대신 deferring.

### 범위 확장 결정 (EXPANSION 및 SELECTIVE EXPANSION 전용) EXPANSION 및 SELECTIVE EXPANSION 모드: 확장 기회와 즐거움 항목은 표면 처리되고 단계 0D (opt-in/cherry-pick 행사)에서 결정했습니다. 결정은 CEO 계획 문서에 지속됩니다. 전체 기록을위한 CEO 계획을 참조하십시오. 확장 목록을 위해 확장 목록을 다시 표시하지 마십시오.
* 허용 : {list 항목은 범위에 추가}
* Deferred: {list 항목은 TODOS.md}로 전송
* Skipped: {list 항목 거부}

## # Diagrams (필수, 적용하는 모든 생산)
1. 시스템 아키텍처
2. Data Flow (그림자 경로 포함)
3. 주 기계
4. 오류 흐름
5. 배포 순서
6. 롤백 Flowchart

### Stale Diagram 감사는 이 계획 접촉에 있는 각 ASCII 도표를 목록으로 만듭니다. 아직도 정확합니까?

## 구현 작업

이 검토를 닫기 전에, 빌드 액션 작업의 플랫 목록으로 위의 결과를 종합. 특정 검색에서 각 작업 파생 - 패딩 없음. 마크 다운 섹션을 이동 AND JSONL 단계 전반에 걸쳐 집계 할 수 있음을 `/autoplan` 식을 작성.

## Markdown 단면도 (직접 방출)

```markdown
## Implementation Tasks
Synthesized from this review's findings. Each task derives from a specific
finding above. Run with Claude Code or Codex; checkbox as you ship.

- [ ] **T1 (P1, human: ~2h / CC: ~15min)** — <component> — <imperative title>
  - Surfaced by: <section name> — <specific finding text or line reference>
  - Files: <paths to touch>
  - Verify: <test command or manual check>
- [ ] **T2 (P2, human: ~30min / CC: ~5min)** — ...
```

규칙:
- P1 구획 배; P2는 동일한 branch를 착륙해야 합니다; P3는 후속 TODO입니다.
- 작업이 작동하지 않는 것을 발견하면, 한 번 발명하지 마십시오.
- 섹션이 0개의 발견을 가지고 있다면, `_No new tasks from <section>._`를 방출
- Effort는 AI-압축 테이블을 CLAUDE.md에서 사용합니다.

## JSONL artifact (직접 쓰기, 0 작업 경우에도)

`/autoplan`는 단계의 골재에 이 파일을 읽습니다. 각 선을 `jq -nc`로 구축하여 인용, 신라인, 또는 backslashes serialize를 포함하는 원본과 근원 발견하십시오 - 결코 손으로 구른 `echo`/`printf`를 사용하지 마십시오.

```bash
eval "$(~/.claude/skills/gstack/bin/gstack-slug 2>/dev/null)"
TASKS_DIR="${HOME}/.gstack/projects/${SLUG:-unknown}"
mkdir -p "$TASKS_DIR"
TASKS_FILE="$TASKS_DIR/tasks-ceo-review-$(date +%Y%m%d-%H%M%S).jsonl"
COMMIT=$(git rev-parse HEAD 2>/dev/null || echo unknown)
BRANCH=$(git branch --show-current 2>/dev/null || echo unknown)
RUN_ID="$(date -u +%Y%m%dT%H%M%SZ)-$$"

# Repeat ONE jq invocation per task identified during this review.
# Substitute the placeholders inline with shell variables you set per task:
#   TASK_ID (T1, T2, ...), PRIORITY (P1/P2/P3), COMPONENT, TITLE,
#   SOURCE_FINDING, EFFORT_HUMAN, EFFORT_CC, FILES_JSON (a JSON array literal
#   like '["browse/src/sanitize.ts","browse/src/server.ts"]').
jq -nc \
  --arg phase 'ceo-review' \
  --arg run_id "$RUN_ID" \
  --arg branch "$BRANCH" \
  --arg commit "$COMMIT" \
  --arg id "$TASK_ID" \
  --arg priority "$PRIORITY" \
  --arg component "$COMPONENT" \
  --arg effort_human "$EFFORT_HUMAN" \
  --arg effort_cc "$EFFORT_CC" \
  --arg title "$TITLE" \
  --arg source_finding "$SOURCE_FINDING" \
  --argjson files "$FILES_JSON" \
  '{phase:$phase, run_id:$run_id, branch:$branch, commit:$commit, id:$id, priority:$priority, component:$component, files:$files, effort_human:$effort_human, effort_cc:$effort_cc, title:$title, source_finding:$source_finding}' \
  >> "$TASKS_FILE"
```

`jq`가 설치되지 않은 경우, JSONL 쓰기를 건너 뛰기 위하여 넘어가고 autoplan 집계를 위한 jq를 설치하기 위하여 사용자를 경고합니다. 절대로 손 목록 JSONL.

이 리뷰에서 0개의 작업을 확인한 경우, 여전히 JSONL 파일 (`: > "$TASKS_FILE"`)를 터치하여, 이 런닝을 출력하는 단계가 있음을 알 수 있습니다. (비어 있는 파일은 "ran, no finds"를 의미합니다. "didn't run"에서 구별하지 않습니다.)


### 완료 요약
```
  +====================================================================+
  |            MEGA PLAN REVIEW — COMPLETION SUMMARY                   |
  +====================================================================+
  | Mode selected        | EXPANSION / SELECTIVE / HOLD / REDUCTION     |
  | System Audit         | [key findings]                              |
  | Step 0               | [mode + key decisions]                      |
  | Section 1  (Arch)    | ___ issues found                            |
  | Section 2  (Errors)  | ___ error paths mapped, ___ GAPS            |
  | Section 3  (Security)| ___ issues found, ___ High severity         |
  | Section 4  (Data/UX) | ___ edge cases mapped, ___ unhandled        |
  | Section 5  (Quality) | ___ issues found                            |
  | Section 6  (Tests)   | Diagram produced, ___ gaps                  |
  | Section 7  (Perf)    | ___ issues found                            |
  | Section 8  (Observ)  | ___ gaps found                              |
  | Section 9  (Deploy)  | ___ risks flagged                           |
  | Section 10 (Future)  | Reversibility: _/5, debt items: ___         |
  | Section 11 (Design)  | ___ issues / SKIPPED (no UI scope)          |
  +--------------------------------------------------------------------+
  | NOT in scope         | written (___ items)                          |
  | What already exists  | written                                     |
  | Dream state delta    | written                                     |
  | Error/rescue registry| ___ methods, ___ CRITICAL GAPS              |
  | Failure modes        | ___ total, ___ CRITICAL GAPS                |
  | TODOS.md updates     | ___ items proposed                          |
  | Scope proposals      | ___ proposed, ___ accepted (EXP + SEL)      |
  | CEO plan             | written / skipped (HOLD/REDUCTION)           |
  | Outside voice        | ran (codex/claude) / skipped                 |
  | Lake Score           | X/Y recommendations chose complete option   |
  | Diagrams produced    | ___ (list types)                            |
  | Stale diagrams found | ___                                         |
  | Unresolved decisions | ___ (listed below)                          |
  +====================================================================+
```

### Unresolved Decisions if any AskUserQuestion unanswered, 여기에 주의. 절대로 침묵적으로 기본값.

## Handoff 참고 정리

완료 요약을 생성 한 후, 이 지점의 모든 손전등 메모를 정리합니다. 리뷰가 완료되고 상황에 더 이상 필요하지 않습니다.

```bash
setopt +o nomatch 2>/dev/null || true  # zsh compat
eval "$(~/.claude/skills/gstack/bin/gstack-slug 2>/dev/null)"
rm -f ~/.gstack/projects/$SLUG/*-$BRANCH-ceo-handoff-*.md 2>/dev/null || true
```

## 리뷰 로그

위의 Completion Summary를 생산한 후, 검토 결과를 지속합니다.

**PLAN MODE EXCEPTION — ALWAYS RUN:** 이 명령은 메타데이터를 `~/.gstack/` (사용자 설정 디렉토리, 프로젝트 파일이 아닙니다)로 작성합니다. 기술 preamble은 이미 `~/.gstack/sessions/` 및 `~/.gstack/analytics/`로 작성합니다. 이 리뷰 대쉬보드는 이 데이터에 달려 있습니다. 이 명령을 건너는 것은 /ship의 검토 readiness 대쉬보드를 끊습니다.

```bash
~/.claude/skills/gstack/bin/gstack-review-log '{"skill":"plan-ceo-review","timestamp":"TIMESTAMP","status":"STATUS","unresolved":N,"critical_gaps":N,"mode":"MODE","scope_proposed":N,"scope_accepted":N,"scope_deferred":N,"commit":"COMMIT"}'
~/.claude/skills/gstack/bin/gstack-decision-log '{"decision":"CEO review (MODE): SCOPE_SUMMARY","rationale":"VERDICT","scope":"branch","source":"skill","confidence":8}' 2>/dev/null || true
```

The second command records the accepted scope as a durable cross-session decision so the next session sees what was settled (and why) without re-litigating it. It writes to `~/.gstack/` (same pattern as review-log), is non-interactive, and is best-effort (`|| true` — never blocks the review). Substitute `SCOPE_SUMMARY` (e.g. "accepted 4 of 6 proposals" for expansion, or "held scope" / "cut 3 items" for HOLD/REDUCTION) and `VERDICT` (the one-line verdict from the summary).

이 명령을 실행하기 전에, 컴파일된 컴파일 요약에서 placeholder 값을 대체합니다:
- **TIMESTAMP**: 현재 ISO 8601 일시 (예: 2026-03-16T14:30:00)
- **STATUS**: "클린" 0개의 결산 결정 AND 0개의 긴요한 간격; 그렇지 않으면 "issues_open"
- **해결되지 않음**: 요약에서 "Unresolved decisions"의 수
- **의 확장**: 요약에서 " 실패 형태: ___ CRITICAL GAPS"
- **MODE**: 사용자가 선택한 모드(SCOPE_EXPANSION / SELECTIVE_EXPANSION / HOLD_SCOPE / SCOPE_REDUCTION)
- **범위_proposed**: 요약에서 "Scope 제안: ___ 제안"(HOLD/REDUCTION)의 수
- **범위_accepted**: 요약에서 "Scope 제안: ___ 허용"(HOLD/REDUCTION)
- **범위_deferred**: 범위 결정에서 TODOS.md에 흩어지는 항목의 수 (0 HOLD/REDUCTION)
- **COMMIT**: `git rev-parse --short HEAD`의 산출

## 리뷰 Readiness 대시보드

검토 완료 후, 검토 로그 및 구성을 읽고 대시보드를 표시합니다.

```bash
~/.claude/skills/gstack/bin/gstack-review-read
```

Parse the output. Find the most recent entry for each skill (plan-ceo-review, plan-eng-review, review, plan-design-review, design-review-lite, adversarial-review, codex-review, codex-plan-review). Ignore entries with timestamps older than 7 days. For the Eng Review row, show whichever is more recent between `review` (diff-scoped pre-landing review) and `plan-eng-review` (plan-stage architecture review). Append "(DIFF)" or "(PLAN)" to the status to distinguish. Adversarial 행의 경우, `adversarial-review` (새로운 자동 확장)과 `codex-review` (아직) 사이에 더 최근 더 많은 것을 보여주는 보여줍니다. 디자인 검토를 위해, `plan-design-review` (전체 시각 감사)와 `design-review-lite` (코드 레벨 체크) 사이에서 더 최근 더 최근 더 많은 것을 보여줍니다. "(FULL)"또는 "(LITE)"를 상태에 명시하십시오. 외부 음성 행의 경우, 가장 최근 /plan-ceo-review (이번 입력된 /plan-ceo-review)를 표시합니다.

**근원 attribution:** 기술에 가장 최근의 항목이 \`"via"\` 필드를 가지고 있다면, 부모의 상태 라벨에 부합합니다. 예: `plan-eng-review` 와 `via:"autoplan"` 쇼는 CLEAR (PLAN 를 통해 /autoplan)"으로 보여줍니다. `review` 와 `via:"ship"` 는 CLEAR (DIFF 를 통해 /ship)" 를 보여줍니다. `via` (CLEAR) 의 `via` (CLEAR) 를 보여주기 전에 `via` 를 보여주십시오.

참고: `autoplan-voices` 및 `design-outside-voices` 항목은 감사철 전용 (크로스 모델 합의 분석을위한 법의 데이터)입니다. 그들은 대시보드에 나타나지 않으며 어떤 소비자가 검사하지 않습니다.

전시:

```
+====================================================================+
|                    REVIEW READINESS DASHBOARD                       |
+====================================================================+
| Review          | Runs | Last Run            | Status    | Required |
|-----------------|------|---------------------|-----------|----------|
| Eng Review      |  1   | 2026-03-16 15:00    | CLEAR     | YES      |
| CEO Review      |  0   | —                   | —         | no       |
| Design Review   |  0   | —                   | —         | no       |
| Adversarial     |  0   | —                   | —         | no       |
| Outside Voice   |  0   | —                   | —         | no       |
+--------------------------------------------------------------------+
| VERDICT: CLEARED — Eng Review passed                                |
+====================================================================+
```

**리뷰 계층:**
- **Eng Review (기본적으로 필요):** 문 발송하는 유일한 검토. 건축술, 코드 질, 시험, 성과 커버하십시오. \`gstack-config set skip_eng_review true\` (" 두번 저" 조정)에 전 세계적으로 비활성화될 수 있습니다.
- **CEO (선택) 검토:** 당신의 판단을 사용하십시오. 큰 제품/business 변경, 새로운 사용자 직면 특징, 또는 범위 결정에 그것을 추천합니다. 버그 수정, 재공장, 인프라 및 정리를 위해 건너 뛰십시오.
- **디자인 검토 (선택):** 당신의 판단을 사용하십시오. UI/UX 변경을 위해 그것을 추천하십시오. 배경 전용, 적외선, 또는 신속한 단지 변화를 위해 건너 뛰십시오.
- **Adversarial 검토 (자동):** 항상 모든 리뷰에 대 한. 모든 디프는 Claude adversarial subagent와 Codex adversarial 도전을 모두 얻을. 큰 디프 (200 + 라인) 추가로 얻을 Codex 구조화 검토와 P1 문. 필요 구성 없음.
- **외부 음성 (선택):** Codex가 유효할 때 다른 AI 모형에서 독립적인 계획 검토는 ( 동일한 가족 Claude subagent에 뒤에 가십시오 그렇지 않으면 — 신선한 컨텍스트, 십자가 모형 아닙니다). /plan-ceo-review 및 /plan-eng-review에서 완전한 모든 검토 단면도 후에 제안해. 선박을 결코 문이 아닙니다.

**Verdict 논리:**
- **CLEARED**: Eng Review has >= 1 항목 이내에 7 일 이내에 \`review\` 또는 \`plan-eng-review\` 상태 "클린" (또는 \`skip_eng_review\`는 \`true\`)
- **NOT CLEARED**: 잉여된 잉여, stale (>7일), 또는 문제점을 열지
- CEO, 디자인, Codex 리뷰는 상황에 따라 표시되지만 배송을 막지 못합니다.
- \`skip_eng_review\` 설정은 \`true\`, Eng Review show "SKIPPED (global)"이며 verdict는 CLEARED입니다.

**Staleness 탐지:** 대시보드를 표시한 후, 기존 리뷰가 stale일 수 있는 경우 확인:
- **내용-첫 번째 규칙 (디프스코프 행만: \`review\`, \`adversarial-review\`, \`codex-review\`, 배 단계 항목).** \`---WTREE---\`와 \`---DIRTY---\` bash 출력에서 섹션을 파. 항목이 \`wtree\` 필드 AND가 있는 경우 현재 \`---WTREE---\` 값과 동일하게 검토는 CURRENT - 동일한 내용, 커밋, 수정, 수정 또는 아직 (이렇게 equality 혼자 동일한 내용을 증명하는지 여부, 즉, 키스톤 속성). 그 항목에 대한 커밋 통계를 건너 뛰고 staleness 참고를 표시하십시오.
- 플랜티티티 행 (플랜티-세로-리뷰, 플랜-세리뷰) 플랜티 파일 등급, 리포 트리가 적용되지 않음 - 그에 대한 wtree 규칙을 적용하지 않습니다. 7일의 신선도 논리를 유지합니다. 이러한 항목은 \`plan_sha256\` 필드를 운반하면, 현재 플랜 파일의 sha256과 메모 "플랜 변경 이후"에 비교합니다.
- 가을 (no \`wtree\` on the entry, or wtree mismatch): \`---HEAD---\` 섹션을 파로 현재 HEAD 커밋 해시를 얻기 위해. 각 리뷰 항목에 대한 \`commit\` 필드가 있습니다: 현재의 HEAD에 대해 비교합니다. 다른 경우, elapsed commits: \`git rev-list --count STORED_COMMIT..HEAD\`를 계산하십시오. FAILS (저장된 커밋은 다시 시작되었습니다), UNKNOWN (저장된 커밋은 ")"는 {nl/> (저스트)에서 "nl"로 요약합니다.
- \`commit\` 필드가 없는 항목에 대해서는, "주의: {skill} 리뷰는 {date}에서 아무런 커밋트 추적이 없습니다. 정확한 staleness 탐지를 위해 다시 실행해야 합니다."
- 모든 리뷰 등급 CURRENT (위트 일치 또는 HEAD 일치), 어떤 staleness 메모 표시하지 않는 경우

## 계획 파일 검토 보고서

검토 읽기 후 Dashboard 대화 출력에서, 또한 업데이트 **계획 파일** 자체 그래서 검토 상태는 누구에게 계획을 읽는 것으로 볼 수 있습니다.

### 플랜 파일을 검색

1. 이 대화에서 활동 계획 파일이 있는지 확인 (주 호스트는 계획 파일을 제공합니다)
   시스템 메시지의 경로 — 대화 상황에 계획 파일 참조를 찾습니다.
2. 발견되지 않은 경우,이 섹션을 침묵적으로 건너 뛰기 — 모든 리뷰는 계획 모드에서 실행되지 않습니다.

### 보고서 생성

검토 로그 출력을 읽으십시오. 이미 리뷰 Readiness Dashboard 단계에서 있습니다. 각 JSONL 항목에 파십시오. 각 기술 로그는 다른 필드를 기록합니다.

- **플랜 일람**: \`status\`, \`unresolved\`, \`critical_gaps\`, \`mode\`, \`scope_proposed\`, \`scope_accepted\`, \`scope_deferred\`, \`commit\`
  → 찾기 : "{scope_제안됨_accepted} 허용, {scope_deferred} deferred" → 범위 필드가 0 또는 누락된 경우 (HOLD/REDUCTION 모드): "mode: {mode}, {critical_gaps} 중요 간격"
- **플랜 일람**: \`status\`, \`unresolved\`, \`critical_gaps\`, \`issues_found\`, \`mode\`, \`commit\`
  → 찾기 : "{issues_발견됨_gaps} 중요한 간격"
- **플랜트-디자인-리뷰**: \`status\`, \`initial_score\`, \`overall_score\`, \`unresolved\`, \`decisions_made\`, \`commit\`
  → 찾기: "스코어: {initial_점수}/10 → {overall_score}/10, {decisions_made} 결정"
- **플랜-devex-review**: \`status\`, \`initial_score\`, \`overall_score\`, \`product_type\`, \`tthw_current\`, \`tthw_target\`, \`mode\`, \`persona\`, \`competitive_tier\`, \`unresolved\`, \`commit\`
  → 찾기: "스코어: {initial_점수}/10 → {overall_score}/10, TTHW: {tthw_현재} → {tthw_target}"
- **딕스 - 리뷰**: \`status\`, \`overall_score\`, \`product_type\`, \`tthw_measured\`, \`dimensions_tested\`, \`dimensions_inferred\`, \`boomerang\`, \`commit\`
  → 찾기 : "스코어 : {overall_점수}/10, TTHW: {tthw_측정}, {dimensions_테스트됨: 테스트/{dimensions_inferred} inferred"
- **코엑스-리뷰**: \`status\`, \`gate\`, \`findings\`, \`findings_fixed\`
  → 찾기 : "{findings} 찾기, {findings_fixed}/{findings} 고정"

Findings 칼럼에 필요한 모든 필드는 이제 JSONL 항목에 있습니다. 리뷰에 대해 완료된 경우, 자신의 Completion Summary에서 부자 세부 정보를 사용할 수 있습니다. 사전 리뷰의 경우 JSONL 필드를 직접 사용하십시오. 필요한 모든 데이터를 포함합니다.

이 markdown 테이블을 생성하십시오:

\`\`\`markdown ## GSTACK REVIEW REPORT

| Review | Trigger의 | 이유 | Runs | Status | 의논하기 |
|--------|---------|-----|------|--------|----------|
| CEO 리뷰 | \`/plan-ceo-review\` | 범위 및 전략 | ... | {status} | {findings} |
| Codex 리뷰 | \`/codex review\` | 독립 제 2의 의견 | ... | {status} | {findings} |
| Eng 검토 | \`/plan-eng-review\` | 건축 및 테스트 (필수) | ... | {status} | {findings} |
| 디자인 리뷰 | \`/plan-design-review\` | UI/UX 간격 | ... | {status} | {findings} |
| DX 리뷰 | \`/plan-devex-review\` | 개발자 경험 gaps | ... | {status} | {findings} |
\`\`\`

테이블 아래,이 라인을 추가합니다. **CODEX** 및 **CROSS-MODEL**는 선택 사항입니다 (비어있을 때 미트); **VERDICT**는 항상 존재합니다:

- **CODEX:** (Codex-review ran만) - 코덱 수정의 한 줄 요약
- **CROSS-MODEL:** (Claude와 Codex 리뷰가 모두 있으면) - 오버랩 분석
- **VERDICT:** 목록 리뷰는 CLEAR (예: "CEO + ENG CLEARED - 구현 준비)입니다.
  만약 Eng Review가 CLEAR이 아닌 글로벌로 건너뛰지 않는다면, "eng review required"를 추가한다.

**해결되지 않은 절제 상태 (MANDATORY — 결코 무효; 보고서의 최종 비-whitespace 라인).** VERDICT 후, 보고서를 종료 (`## GSTACK REVIEW REPORT\` 헤더 - 대담한 라벨, 새로운 \`## \` 헤더; 정확히 한 "오미트" 규칙)과 정확히 한 번에 제외 : 정확한 unbolded line \`NO UNRESOLVED DECISIONS\` (대략한 것은 NOT 카운트), OR a \`**UNRESOLVED DECISIONS:**\` 헤더 + 열선 당 하나의 총알 (마지막 선 = 마지막 선; 마지막 선; \`+ N unresolved from prior reviews\`만 N > 0일 때만 추가합니다. 이 두 배 위탁을 피합니다: 목록 THIS는 문맥에서 열린 품목을 검토합니다; 이전 리뷰 합계를 위해 \`unresolved\`는 기술 당 최신 신선한 줄에 (dashboard 7 일 창) 당신이 DROP 현재 기술의 줄 후에; 둘 다 0일 때만 sentinel를 방출합니다.

### 계획 파일에 쓰기

**PLAN MODE EXCEPTION — ALWAYS RUN:** 이 플랜 파일에 쓰여져 플랜 모드로 편집할 수 있는 파일입니다. 플랜 파일 리뷰 보고서는 플랜의 생활 상태의 일부입니다.

보고서는 항상 계획 파일의 LAST 섹션이어야 합니다. - 결코 중간 파일. 단일 삭제-그 다음-부드 흐름을 사용하십시오.

1. 전체 현재 내용을 보려면 계획 파일 (읽기 도구)를 읽으십시오. 읽기
   파일에 있는 `## GSTACK REVIEW REPORT\`를 위해 출력하는.
2. 발견되면, 편집 도구를 DELETE 전체의 기존 섹션에 사용합니다.
   \`## GSTACK REVIEW REPORT\` 를 통해 다음 \`## \` 를 통해 먼저 나온 파일의 끝을 머리에 넣거나, 빈 문자열로 대체합니다. 이 부분은 현재 영역의 부분과 관계없이 적용됩니다. - 중간 파일 삭제는 의도적, 특별한 경우 아닙니다. 편집이 실패하면 (예 : 동시 편집은 내용을 변경), 계획 파일 및 재시를 다시 한번 다시 읽습니다.
3. 삭제 후 (또는 건너뛰기, 어떤 섹션이 존재하지 않는 경우), 새 추가
   \`## GSTACK REVIEW REPORT\` 파일의 END 섹션. 파일의 현재 마지막 단락과 섹션을 추가하려면 편집 도구를 사용하여, 또는 끝에 섹션을 전체 파일을 다시 시작 씁니다.
4. \`## GSTACK REVIEW REPORT\`가 마지막 것 같은 읽기 도구로 정의
   \`## \` 계속하기 전에 파일에 두기. 그것이 아니라면 반복 단계 2-3를 한 번 반복하십시오.

NOT는 장소에 있는 부분을 대체합니다. 이전 보고서가 이미 살 때 "파일을 바꾸는" 경로는 이전 버전이 이전의 보고서를 남겨두기 전에 허용됩니다. 사용자는 그 후, 검토 보고서가 바닥에 있지 않은 계획을 볼 수 있습니다 (현재).

## 다음 단계 — 체인링 검토

검토 읽기보기 돌진 보드를 표시 한 후,이 CEO 검토가 발견 된 것을 기준으로 다음 검토 (들)을 권장합니다. 이미 실행되고 있는지 볼 수있는 대시보드 출력을 읽으십시오. stale.

**eng 검토가 전 세계적으로 건너지지 않는 경우 /plan-eng-review를 추천하십시오.** - `skip_eng_review`의 대시보드 출력을 확인합니다. `true`인 경우, eng 검토가 선택되지 않습니다. 그렇지 않으면, eng 검토는 필수 배송 게이트입니다. 이 CEO 검토 확장 범위, 변경된 건축 방향, 또는 허용 범위 확장, 신선한 eng 검토가 필요합니다 강조. eng 검토가 대쉬보드에 이미 존재하지만 커밋 해시가이 CEO 검토를 미리 보여 주면 stale이 될 수 있으며 다시 실행해야합니다.

**/plan-design-review UI 범위가 감지된 경우** — 섹션 11 (Design & UX Review)이 NOT 건너뛰거나, 허용된 범위 확장이 UI-facing 기능 포함되는 경우에 특히. 기존의 디자인 검토가 stale (commit hash drift)인 경우에, 주의하십시오. SCOPE REDUCTION 형태에서는, 이 권고를 건너뛰십시오 — 디자인 검토는 범위 커트에 대하와 관련이 없습니다.

**모두 필요하다면 eng 리뷰를 먼저 추천합니다.** (필수 문), 그 때 디자인 검토.

AskUserQuestion를 사용하여 다음 단계에 제시합니다. 적용 가능한 옵션만 포함하십시오.
- **A)** 실행 /plan-eng-review 다음 (필수 문)
- **B) (아)** 실행 /plan-design-review 다음 (UI 범위가 감지된 경우에만)
- **C) (아)** Skip — 수동으로 리뷰 처리

## docs/designs 프로모션 (EXPANSION 및 SELECTIVE EXPANSION만)

검토의 끝에, 비전이 compelling 기능 방향을 생산하는 경우, 프로젝트 repo에 CEO 계획을 홍보하는 제안. AskUserQuestion:

"이 리뷰의 비전은 {N} 범위를 확장했다. repo에서 디자인 문서에 홍보하고 싶습니까?"
- **A)** `docs/designs/{FEATURE}.md` (팀에 보이는 repo에, 적합)
- **B) (아)** `~/.gstack/projects/`만 유지 (현지, 개인 참조)
- **C) (아)** 건너뛰기

홍보를 한다면 CEO 플랜 내용 `docs/designs/{FEATURE}.md` (필요한 경우 디렉토리 생성) `status` 필드를 `ACTIVE`에서 `PROMOTED`로 변경합니다.

## 형식 규칙
* NUMBER 문제 (1, 2, 3...) 및 옵션에 대한 LETTERS (A, B, C ...).
* NUMBER + LETTER (예: "3A", "3B").
* 옵션당 최대 1개의 문장.
* 각 단면도 후에, 일시 중지 및 의견을 기다리십시오.
* **CRITICAL GAP** / **WARNING** / **OK**를 스캔 가능

# 캡처 학습

이 세션 중 비 명백한 패턴, pitfall, 또는 건축 통찰력을 발견하면 향후 세션에 로그인하십시오.

```bash
~/.claude/skills/gstack/bin/gstack-learnings-log '{"skill":"plan-ceo-review","type":"TYPE","key":"SHORT_KEY","insight":"DESCRIPTION","confidence":N,"source":"SOURCE","files":["path/to/relevant/file"]}'
```

**유형:** `pattern` (재사용 가능한 접근), `pitfall` (일 NOT), `preference` (사용자 명시), `architecture` (구 결정), `tool` (library/framework 통찰력), `operational` (프로젝트 environment/CLI/workflow 지식).

**근원:** `observed` (코드에서 이것을 발견했습니다), `user-stated` (사용자가 당신을 말했습니다), `inferred` (AI 감응작용), `cross-model` (Claude 및 Codex 동의).

**구성:** 1-10. 정직. 코드를 확인한 관찰 패턴은 8-9입니다. 의도적으로는 4-5입니다. 명시적으로 명시된 사용자 선호도는 10입니다.

**파일 :** 이 학습 참조를 특정 파일 경로 포함. 이 활성화 staleness 검출: 그 파일이 나중에 삭제되면, 학습은 떨어질 수 있습니다.

**로그인 하세요.** 분명한 것들을 로그하지 마십시오. 이미 사용자를 알 수 없습니다. 좋은 테스트 :이 통찰력은 향후 세션에서 시간을 절약 할 것인가? 예, 로그.



## 뇌 교정 쓰기 백 (상 2 / 문)

기술이 추적하는 유형의 예측을 할 때 (경찰 결정, TTHW 대상, 건축 베팅, 쐐기 약속), 그것은 MAY는 `kind=bet`를 씁니다 뇌에 이렇게 구경측정 단면도는 시간 이상 건설합니다.

**두 가지에 갇혀 :**
1. 활성 엔드포인트의 두뇌 신뢰 정책은 `personal` (을 통해 확인
   `~/.claude/skills/gstack/bin/gstack-config get brain_trust_policy@<endpoint-hash>`). 공유 뇌는 투표 팀 교정을 피하기 위해 쓰기 등을 건너 뛰고 있습니다.
2. 기능 플래그 `BRAIN_CALIBRATION_WRITEBACK` 설정 (일: false; 플립
   gbrain v0.42+가 `takes_add` MCP op)를 발송할 때 true에.

양쪽 게이트 패스가 모두되면, 쓰기 백 경로는 `mcp__gbrain__takes_add`를 사용하여 무게 0.8 (SKILL_CALIBRATION_WEIGHTS당)로 가져갑니다. MCP op가 사용되지 않는 경우 `mcp__gbrain__put_page` 와 gstack:takes Fence block (documented but uglier path)로 다시 떨어졌습니다.

필수 입력 frontmatter 모양:
```yaml
kind: bet
holder: <user identity from whoami>
claim: <one-line prediction the skill is making>
weight: 0.8
since_date: <today's date>
expected_resolution: <date in 1-3 months depending on skill>
source_skill: plan-ceo-review
```

쓰기 후, 영향을받은 소화를 무효하여 다음의 preflight는 새로운 상태를 반영합니다.

```bash
eval "$(~/.claude/skills/gstack/bin/gstack-slug 2>/dev/null)" 2>/dev/null || true
  ~/.claude/skills/gstack/bin/gstack-brain-cache invalidate product --project "$SLUG" 2>/dev/null || true
  ~/.claude/skills/gstack/bin/gstack-brain-cache invalidate goals --project "$SLUG" 2>/dev/null || true
  ~/.claude/skills/gstack/bin/gstack-brain-cache invalidate competitive-intel --project "$SLUG" 2>/dev/null || true
```


## 두뇌 캐시 배경 새로 고침

기술 작업이 완료되면 (그리고 원격 측정은 로그온), 킥은 어떤 캐시 다이제스트의 재생을 재생하는 것은 그것의 TTL. 이것은 비 차단입니다 - 사용자는 기다릴 수 없습니다. 다음 호출은 따뜻한 캐시에서 혜택을 제공합니다.

```bash
eval "$(~/.claude/skills/gstack/bin/gstack-slug 2>/dev/null)" 2>/dev/null || true
(~/.claude/skills/gstack/bin/gstack-brain-cache refresh --project "$SLUG" 2>/dev/null &) || true
```


## 모드 빠른 참조
```
  ┌────────────────────────────────────────────────────────────────────────────────┐
  │                            MODE COMPARISON                                     │
  ├─────────────┬──────────────┬──────────────┬──────────────┬────────────────────┤
  │             │  EXPANSION   │  SELECTIVE   │  HOLD SCOPE  │  REDUCTION         │
  ├─────────────┼──────────────┼──────────────┼──────────────┼────────────────────┤
  │ Scope       │ Push UP      │ Hold + offer │ Maintain     │ Push DOWN          │
  │             │ (opt-in)     │              │              │                    │
  │ Recommend   │ Enthusiastic │ Neutral      │ N/A          │ N/A                │
  │ posture     │              │              │              │                    │
  │ 10x check   │ Mandatory    │ Surface as   │ Optional     │ Skip               │
  │             │              │ cherry-pick  │              │                    │
  │ Platonic    │ Yes          │ No           │ No           │ No                 │
  │ ideal       │              │              │              │                    │
  │ Delight     │ Opt-in       │ Cherry-pick  │ Note if seen │ Skip               │
  │ opps        │ ceremony     │ ceremony     │              │                    │
  │ Complexity  │ "Is it big   │ "Is it right │ "Is it too   │ "Is it the bare    │
  │ question    │  enough?"    │  + what else │  complex?"   │  minimum?"         │
  │             │              │  is tempting"│              │                    │
  │ Taste       │ Yes          │ Yes          │ No           │ No                 │
  │ calibration │              │              │              │                    │
  │ Temporal    │ Full (hr 1-6)│ Full (hr 1-6)│ Key decisions│ Skip               │
  │ interrogate │              │              │  only        │                    │
  │ Observ.     │ "Joy to      │ "Joy to      │ "Can we      │ "Can we see if     │
  │ standard    │  operate"    │  operate"    │  debug it?"  │  it's broken?"     │
  │ Deploy      │ Infra as     │ Safe deploy  │ Safe deploy  │ Simplest possible  │
  │ standard    │ feature scope│ + cherry-pick│  + rollback  │  deploy            │
  │             │              │  risk check  │              │                    │
  │ Error map   │ Full + chaos │ Full + chaos │ Full         │ Critical paths     │
  │             │  scenarios   │ for accepted │              │  only              │
  │ CEO plan    │ Written      │ Written      │ Skipped      │ Skipped            │
  │ Phase 2/3   │ Map accepted │ Map accepted │ Note it      │ Skip               │
  │ planning    │              │ cherry-picks │              │                    │
  │ Design      │ "Inevitable" │ If UI scope  │ If UI scope  │ Skip               │
  │ (Sec 11)    │  UI review   │  detected    │  detected    │                    │
  └─────────────┴──────────────┴──────────────┴──────────────┴────────────────────┘
```
