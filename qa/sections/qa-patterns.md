<!-- AUTO-GENERATED from qa-patterns.md.tmpl — do not edit directly -->
<!-- Regenerate: bun run gen:skill-docs -->
## 형태

### Diff-aware (자동으로 no URL를 가진 특징 branch에 때)

개발자가 작업을 확인하는 **주된 형태**입니다. URL 없이 `/qa`라는 유저가 repo가 branch가 자동으로 기능 branch에 표시됩니다.

1. **Analyze the branch diff**는 무엇을 변경하는지 이해합니다:
   ```bash
   git diff main...HEAD --name-only
   git log main..HEAD --oneline
   ```

2. **영향을받는 페이지를 식별/routes** 변경된 파일에서:
   - Controller/route 파일 → URL 경로가 있는 경우
   - View/template/component 파일 → 페이지가 렌더링하는
   - Model/service 파일 → 그 모델을 사용 (그것을 참조하는 체크 컨트롤러)
   - CSS/style 파일 → 해당 스타일의 시트를 포함
   - API 엔드포인트 → `$B js "await fetch('/api/...')"`로 직접 테스트
   - 정적 페이지 (markdown, HTML) → 직접 탐색

   **no 명백한 페이지/routes가 diff에서 확인된 경우:** 브라우저 테스트를 건너뛰지 마십시오. 브라우저 기반 검증을 원하기 때문에 사용자의 호출 /qa. 빠른 모드로 돌아가기 - 홈페이지로 이동하여 상위 5개의 탐색 대상을 따르고 오류를 확인하고 대화 형 요소를 테스트하십시오. 백엔드, 구성 및 인프라 변경은 앱 동작에 영향을 미칩니다. 항상 앱을 작동하게 합니다.

3. **실행 앱을 감지** — 일반적인 로컬 dev 포트를 확인:
   ```bash
   $B goto http://localhost:3000 2>/dev/null && echo "Found app on :3000" || \
   $B goto http://localhost:4000 2>/dev/null && echo "Found app on :4000" || \
   $B goto http://localhost:8080 2>/dev/null && echo "Found app on :8080"
   ```
   no 로컬 앱이 발견되면 PR 또는 환경의 staging/preview URL를 확인합니다. 아무 것도 작동하지 않으면 URL의 사용자를 요청하십시오.

4. **각 영향을받는 페이지를 테스트/route:**
   - 페이지에 Navigate
   - 스크린 샷을 찍다
   - 오류에 대한 콘솔 확인
   - 변경이 대화형 (forms, Button, flows)인 경우, 상호 작용 끝에 종료
   - `snapshot -D` 이전과 변경을 확인한 후 예상된 효과

5. **commit 메시지와 PR 설명과 교차 환경**는 *intent*를 이해하기 위해 - 어떤 변화가? 실제로 그것을 검증한다.

6. **TODOS.md를 체크하십시오** (이 경우) 알려진 버그 또는 변경된 파일과 관련된 문제. TODO이 branch가 수정해야 하는 버그를 설명하면 테스트 플랜에 추가합니다. QA 동안 새로운 버그를 발견하면 TODOS.md에 있지 않은 경우, 보고서에 참고하십시오.

7. **연구 결과** scoped branch의 변경:
   - "시험 변화 : N 페이지/routes이 branch"에 영향을 미치는
   - 각: 작동합니까? 스크린 샷 증거.
   - 인접한 페이지에 어떤 회귀?

**사용자가 diff-aware 모드를 가진 URL를 제공합니다:**는 URL를 기본으로 사용하지만 변경된 파일에 여전히 범위 테스트를 합니다.

## 전체 (default URL가 제공될 때) 체계적인 탐험. 각 도달가능한 페이지를 방문하십시오. 문서 5-10 잘 퇴비된 문제점. 건강 점수 생성. app 크기에 따라서 5-15 분을 가지고 가십시오.

## 빠른 (`--quick`) 30 초 연기 시험. 홈페이지 + 상위 5 탐색 대상을 방문하십시오. 체크 : 페이지로드? 콘솔 오류? 깨진 링크? 건강 점수 생성. No 상세한 문제 문서.

### 회귀 (`--regression <baseline>`) 전체 모드를 실행하고, 이전 실행에서 `baseline.json`를 로드합니다. 디프 : 문제가 고정되었습니까? 새로운 것은 무엇입니까? 점수 델타는 무엇입니까? 보고서에 회귀 섹션을 승인하십시오.

---

## 워크 플로우

### 단계 1: 초기화

1. 찾아보기 바이너리 (위 설정 참조)
2. 출력 디렉토리 생성
3. `qa/templates/qa-report-template.md`에서 출력 디폴트로 복사
4. 시간 추적을 위한 시작 timer

### 2 단계: 인증 (필요한 경우에)

**사용자 지정 auth 자격:**

```bash
$B goto <login-url>
$B snapshot -i                    # find the login form
$B fill @e3 "user@example.com"
$B fill @e4 "[REDACTED]"         # NEVER include real passwords in report
$B click @e5                      # submit
$B snapshot -D                    # verify login succeeded
```

**cookie 파일을 제공한 경우:**

```bash
$B cookie-import cookies.json
$B goto <target-url>
```

**2FA/OTP가 필요한 경우:** 코드와 대기를 위해 사용자를 요청합니다.

**CAPTCHA 블록이면:** 사용자를 말하십시오: "브라우저에서 CAPTCHA를 완료하고, 계속 나를 알려주세요."

### 단계 3: 오리엔트

응용 프로그램의지도를 얻으십시오:

```bash
$B goto <target-url>
$B snapshot -i -a -o "$REPORT_DIR/screenshots/initial.png"
$B links                          # map navigation structure
$B console --errors               # any errors on landing?
```

**프레임을 감지** (보고 메타데이터에 기초):
- `__next` HTML 또는 `_next/data` 요청 → Next.js
- `csrf-token` 메타 태그 → Rails
- `wp-content` URL에서 → 워드프레스
- no 페이지 재부팅 → SPA로 클라이언트 측 여정

**온천장:** `links` 명령은 내비게이션이 클라이언트 측이기 때문에 몇 가지 결과를 반환할 수 있습니다. 대신 네브 요소 (버튼, 메뉴 항목)를 찾을 `snapshot -i`를 사용하십시오.

### 4 단계: 탐험

페이지 시스템의 방문. 각 페이지에서:

```bash
$B goto <page-url>
$B snapshot -i -a -o "$REPORT_DIR/screenshots/page-name.png"
$B console --errors
```

그런 다음 **per-page 탐험 체크리스트** (`qa/references/issue-taxonomy.md` 참조)를 따르십시오.

1. **Visual 스캔** - 레이아웃 문제의 주석 스크린 샷을 찾습니다.
2. **대화 형 요소** - 버튼, 링크, 컨트롤을 클릭합니다. 그들은 작동합니까?
3. **의 특징** - 채우고 제출하십시오. 빈번한 시험, 잘못된 경우, 가장자리 케이스
4. **의 특징** - 모든 경로와 밖으로 체크
5. **States** - 빈 상태, 로딩, 오류, 과잉
6. **의 특징** — 새로운 JS 에러가 상호 작용한 후?
7. **책임감** - 관련 모바일 뷰포트를 확인:
   ```bash
   $B viewport 375x812
   $B screenshot "$REPORT_DIR/screenshots/page-mobile.png"
   $B viewport 1280x720
   ```

**깊이 판:** 코어 기능에 더 많은 시간을 보내십시오 (homepage, 대시보드, 체크 아웃, 검색) 그리고 이차 페이지 (대략, 조건, 개인 정보 보호).

**빠른 형태:** Orient Phase에서 홈페이지 + 상위 5개의 네비게이션 대상만 방문합니다. per-page checklist를 건너 뛰기만 하면 됩니다.: loads? 콘솔 오류? Broken 링크가 표시되나요?

### 단계 5: 문서

각 문제 **즉시 발견** - 배치하지 마십시오.

**2개의 증거 층:**

**대화 형 버그** (부동액, 죽은 단추, 모양 실패):
1. 작업의 앞에 스크린 샷을 가져 가라.
2. 활동 수행
3. 결과 표시를 보여주는 스크린 샷을 찍으십시오
4. `snapshot -D`를 사용하여 변경된 내용을 표시하십시오
5. 스크린 샷을 참조하는 repro 단계 쓰기

```bash
$B screenshot "$REPORT_DIR/screenshots/issue-001-step-1.png"
$B click @e5
$B screenshot "$REPORT_DIR/screenshots/issue-001-result.png"
$B snapshot -D
```

**정적 버그** (typos, 레이아웃 문제, 누락 된 이미지) :
1. 문제를 보여주는 단일 주석 스크린 샷을 가져 가라.
2. 잘못된 것

```bash
$B snapshot -i -a -o "$REPORT_DIR/screenshots/issue-002.png"
```

**보고서에 각 문제점을 즉시 쓰십시오** `qa/templates/qa-report-template.md`에서 템플릿 형식을 사용하여 **보고서에 각 문제점을 즉시 쓰십시오**.

### 단계 6: 위로 포장

1. 아래 문질러 사용 **Compute 건강 점수**
2. **"정지 3 가지를 작성"** — 3개의 가장 높은 문제
3. **콘솔 건강 요약** - 페이지 전체에 보이는 모든 콘솔 오류를 집계
4. **업데이트 severity 카운트** 요약표
5. **메타데이터를 보고** — 날짜, 기간, 페이지 방문, 스크린 샷 카운트, 프레임 워크
6. **기본 정보** - `baseline.json`를 다음과 같이 작성:
   ```json
   {
     "date": "YYYY-MM-DD",
     "url": "<target>",
     "healthScore": N,
     "issues": [{ "id": "ISSUE-001", "title": "...", "severity": "...", "category": "..." }],
     "categoryScores": { "console": N, "links": N, ... }
   }
   ```

**회귀 형태:** 보고서를 작성한 후 baseline 파일을로드합니다. 비교:
- 건강 점수 delta
- 고정 된 문제 (기본값이지만 현재)
- 새로운 문제 (현재하지만 기본하지 않음)
- 회귀 섹션을 보고서에 승인

---

## 건강 점수 루비

Compute 각 범주 점수 (0-100), 그 다음 무게 평균을.

## 콘솔 (무게: 15%)
- 0 오류 → 100
- 1-3 오류 → 70
- 4-10 오류 → 40
- 10+ 오류 → 10

## 링크 (무게: 10%)
- 0 깨진 → 100
- 각 부서지는 링크 → -15 (최소 0)

### Per-Category Scoring (Visual, Functional, UX, 내용, 성과, 접근가능성) 각 범주는 100에서 시작합니다. 찾기 당 공제:
- 긴요한 문제 → -25
- 높은 문제 → -15
- 중간 문제 → -8
- 낮은 문제 → -3
최소 0 카테고리.

## 무게
| Category | 무게: |
|----------|--------|
| 의 특징 | 15% |
| Links | 10% |
| 의 특징 | 10% |
| 기능상 | 20% |
| UX | 15% |
| 의 특징 | 10% |
| Content | 5% |
| 의 특징 | 15% |

### 최종 점수 `score = Σ (category_score × weight)`

---

## 프레임 워크-Specific Guidance

### Next.js
- 수화 오류에 대한 콘솔을 확인 (`Hydration failed`, `Text content did not match`)
- 네트워크의 `_next/data` 요청 - 404s는 부서지는 데이터 fetching을 나타냅니다
- 클라이언트 측 내비게이션 테스트 (click 링크, `goto`) - 문제 래핑
- 동적 콘텐츠로 페이지에 CLS (Cumulative Layout Shift)을 체크하십시오.

### Rails
- 콘솔에서 N+1 쿼리 경고 확인 (개발 모드 경우)
- CSRF token 형태에 존재를 검증
- Turbo/Stimulus 통합을 테스트합니다. - 페이지 전환은 원활하게 작동합니까?
- 표시된 플래시 메시지에 대한 확인 및 올바르게 해지

## 워드 프레스
- 플러그인 충돌 확인 (JS 다른 플러그인에서 오류)
- 로그인 사용자를위한 관리자 바 가시성 검증
- REST API 엔드포인트 테스트 (`/wp-json/`)
- 혼합 내용 경고를 확인 (WP)

## 일반 SPA (React, Vue, 모난)
- `snapshot -i` 탐색을 위해 - `links` 명령은 클라이언트 측 노선을 놓습니다.
- stale state를 확인 (나비게이트를 멀리 뒤로 — 데이터가 새로워진가요?)
- 브라우저를 테스트 back/forward — 앱 핸들 역사를 올바르게 수행합니까?
- 메모리 누출 검사 (확장된 사용 후 임의 콘솔)

---

## 중요 규칙

1. **Repro는 모든 것입니다.** 각 문제는 적어도 1개의 스크린 샷을 필요로 합니다. No 예외.
2. **문서화하기 전에 검증.** 한 번 문제가 발생하면, 굴절이 아닌 재회할 수 있습니다.
3. **자격은 없습니다.** `[REDACTED]`를 다시 프로 단계에 암호로 작성합니다.
4. **incrementally 쓰기.** 보고서에 각 문제점을 통보하십시오. 일괄 처리하지 마십시오.
5. **소스 코드를 읽지 마십시오.** 사용자로 테스트, 개발자가 아닙니다.
6. **모든 상호 작용 후 콘솔을 확인.** JS 에러가 발생하지 않는 오류는 여전히 버그가 있습니다.
7. **사용자와 같은 테스트.** 실제 데이터를 사용합니다. 워크플로우를 완료한 후, 워크플로우를 종료합니다.
8. **빵 위에 깊이.** 5-10 잘 문서화 된 문제 > 20 vague 설명.
9. **출력 파일을 삭제하지 마십시오.** 스크린 샷 및 보고서 축적 - 그 의도적.
10. **까다로운 UI를 위해 `snapshot -C`를 사용합니다.** divs 를 찾아 접근가능성 트리를 놓습니다.
11. **스크린 샷을 사용자에 표시합니다.** `$B screenshot`, `$B snapshot -a -o`, 또는 `$B responsive` 명령은 출력 파일 (s)에 읽힌 도구를 사용하여 사용자가 인라인을 볼 수 있습니다. `responsive` (3개의 파일)를 위해, 모든 3개의 것을 읽으십시오. 이것은 중요하 — 없이, 스크린샷은 사용자에게 보이지 않습니다.
12. **브라우저를 사용하지 마십시오.** 사용자가 /qa 또는 /qa-only를 호출할 때, 그들은 브라우저 기반 테스트를 요청하고 있습니다. 이차, 단위 테스트 또는 대체로 다른 대안을 제안하지 마십시오. diff가 no UI 변경 사항이 있을 경우, 백엔드 변경은 앱 행동에 영향을 미치지 않습니다. 브라우저와 테스트를 항상 엽니다.
