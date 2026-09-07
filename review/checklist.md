# 사전 등록 리뷰 Checklist

## 지시

아래 나열된 문제의 `git diff origin/main` 출력을 검토하십시오. 특정 - `file:line`를 인용하고 수정을 제안합니다. 벌금이 있는지를 건너십시오. 만 플래그 실제 문제.

**두 개의 패스 리뷰 :**
- **1 (CRITICAL)를 통과하십시오:** 실행 SQL & 자료 안전, 인종 조건, LLM 출력 신뢰 경계, 포탄 주입 및 Enum 완전성 첫째로. 가장 높은 severity.
- **2번 (INFORMATIONAL)를 통과하십시오:** 아래 나머지 카테고리를 실행합니다. 더 낮은 severity 하지만 여전히 행동.
- **특수 범주 (병렬 에이전트에 의해 처리, NOT 이 체크리스트):** 테스트 게이지, 데드 코드, 매직 번호, 조건부 사이드 효과, 성능 및 번들 충격, 암호화 & Entropy, 단순화 (지정 구조). 이들을 위해 `review/specialists/`를 참조하십시오.

완전한 개스 및 단순화는 정교하고, 피임약 아닙니다: 완전한 푸시 적용 UP (테스트, 가장자리 케이스, 오류 경로), 간단한 푸시는 비례없는 구조 DOWN (단간 요약, 손 목록으로 만들어진 stdlib, 죽은 융통성)를 밀어줍니다. 동일한 diff는 합법적으로 둘 다 받을 수 있습니다.

모든 발견은 수정-First 검토를 통해 작용을 얻습니다: 명백한 기계적인 고침은 자동적으로 적용되고, 진짜로 주위 문제점은 단 하나 사용자 질문으로 배치됩니다.

**산출 체재:**

```
Pre-Landing Review: N issues (X critical, Y informational)

**AUTO-FIXED:**
- [file:line] Problem → fix applied

**NEEDS INPUT:**
- [file:line] Problem description
  Recommended fix: suggested fix
```

no 문제가 발견되면 `Pre-Landing Review: No issues found.`

terse. 각 문제점을 위해: 문제, 고침을 가진 1개의 선을 설명하는 1개의 선. No preamble, no summaries, no " 좋은 전반적인 보기."

---

## 리뷰 카테고리

## 1번 패스 - CRITICAL

#### SQL & 자료 안전
- SQL (값이 `.to_i`/`.to_f`인 경우)의 문자열 교환 (Rails: sanitize_sql_array/Arel; Node: 준비된 문; Python: 매개 변수화된 쿼리))
- TOCTOU 레이스: 원자 `WHERE` + `update_all`이어야 하는 검사 그 후에 세트 본
- 직접 DB 쓰기에 대한 모델 검증을 우회합니다 (Rails: update_column; Django: QuerySet.update(); Prisma: raw queries)
- N+1 쿼리: 미스링 엘리저 로딩 (Rails: .includes(); SQLAlchemy: joinload(); Prisma: include) 에 사용된 협회에 대 한 루프/views

#### 레이스 조건 및 통화
- 독특성 제약 없이 읽기 체크 쓰기 또는 중복 키 오류 및 재시동을 잡기 (예를들면 `where(hash:).first` 그 다음 `save!` concurrent insert를 처리하지 않고)
- DB 인덱스 없이 찾아서 생성하기 — 동시 호출은 중복을 만들 수 있습니다
- atomic `WHERE old_status = ? UPDATE SET new_status`를 사용하지 않는 상태 전환 - 동시 업데이트는 건너뛰거나 이중으로 전환 할 수 있습니다.
- HTML 렌더링 (Rails: .html_안전/raw(); React: dangerouslySetInnerHTML; Vue: v-html; Django: |safe/mark_safe) 사용자 제어 데이터 (XSS)

#### LLM 산출 신뢰 경계
- LLM-generated 값 (이메일, URL, 이름) DB 또는 형식 검증없이 우송자로 전달. persisting 전에 경량 가드 (`EMAIL_REGEXP`, `URI.parse`, `.strip`)를 추가하십시오.
- Structured tool output (arrays, hashes)는 type/shape 체크가 데이터베이스 쓰기 전에 허용했습니다.
- LLM-allowlist- SSRF 위험 없이 태칭된 URL을 URL 내부 네트워크에 포인트 (Python: `urllib.parse.urlparse` → 체크 hostname against blocklist before `requests.get`/`httpx.get`)
- LLM 출력은 위생 없이 지식 기초 또는 벡터 DBs에서 저장했습니다 — 저장된 신속한 주입 위험

#### 포탄 주입 (Python 명세)
- `subprocess.run()` / `subprocess.call()` / `subprocess.Popen()` 와 `shell=True` AND f-string/`.format()` 명령어 문자열의 개입 - 대신 인수 배열을 사용한다.
- `os.system()` 변수의 인터폴레이션 - 인수 배열을 사용하여 `subprocess.run()`로 대체
- `eval()` / `exec()` 에 LLM-산화 코드 없이 sandboxing

#### Enum & Value Completeness diff가 새로운 enum 값, 상태 문자열, 계층 이름, 또는 유형 상수를 소개할 때:
- **모든 소비자를 추적.** 읽기 (그렇지 않은 그냥 grep — READ)에 스위치, 필터에 의해, 또는 값을 표시하는 각 파일. 어떤 소비자가 새로운 가치를 처리하지 않는 경우, 플래그. 일반적인 놓기: frontend dropdown에 값을 추가하지만 backend model/compute 방법은 그것을 주장하지 않습니다.
- **수당/filter 배열을 체크하십시오.** 배열 또는 `%w[]` 목록에 대한 검색은 sibling 값 (예를 들어, "revise"를 층에 추가하면, 각 `%w[quick lfg mega]`를 찾아 필요한 경우 "revise"를 확인합니다.
- **`case`/`if-elsif` 사슬을 검사하십시오.** enum에 기존 코드 branch가 있다면, 새로운 값이 잘못 default로 떨어졌습니까?
이를 수행하려면 Grep를 사용하여 모든 계층 소비자를 찾는 "lfg"또는 "mega"에 대한 sibling 값 (예 : "lfg" 또는 "mega"를 모두 참조)에 대한 모든 참조를 찾으십시오. 각 일치를 읽으십시오. 이 단계는 디퓨프를 읽는 코드 OUTSIDE를 요구합니다.

## 패스 2 - INFORMATIONAL

#### Async/Sync 섞기 (Python-specific)
- `async def` 내의 `requests.get()`, `open()`, `requests.get()` 내의 동시 `subprocess.run()`, `aiofiles`, `httpx.AsyncClient`를 대신 사용합니다.
- `time.sleep()` 내부 동기화 기능 — `asyncio.sleep()` 사용
- DB는 `run_in_executor()` 래핑 없이 동기화 컨텍스트에서 호출합니다

#### Column/Field 이름 안전
- ORM 쿼리의 열명 확인 (`.select()`, `.eq()`, `.gte()`, `.order()`) 실제 DB 스키마에 대하여 DB simon - 잘못된 열명은 빈 결과를 잃거나 삼키는 과실을 던졌습니다
- `.get()` 을 체크해 쿼리 결과가 실제로 선택된 열명을 사용합니다.
- 사용할 때 schema 문서에 대한 Cross-reference

#### Dead Code & Consistency (version/changelog만 해당)
- PR 제목과 VERSION/CHANGELOG 파일 사이 버전 잡기
- CHANGELOG x에서 존재하지 않는 X로 변경되는 경우 inaccurately (e.g., "X에서 Y로 변경)

### LLM 프롬프트 이슈
- 0-표시된 목록 (LLMs는 1-indexed를 재반송합니다)
- Prompt 텍스트 목록 사용 가능한 도구/capabilities 실제로 `tool_classes`/`tools` 배열에서 와이어가없는 것
- Word/token 한계는 드리프트 할 수있는 여러 곳에서 명시

#### 완전한 격자
- 완전한 버전이 <30분 CC 시간(예: 부분적 enum handling, incomplete error paths, missing edge case that are straightforward to add)를 요하는 단축키 구현
- 인간 팀 노력 견적으로 제시된 옵션 — 인간과 CC+gstack 시간 모두 보여야 합니다.
- 누락된 테스트를 추가하는 테스트 범위 간격은 "스케이프"(예: 누락된 부정적인 방향 테스트, 누락된 가장자리 케이스 테스트는 행복향도 구조)
- 80-90%에서 구현된 기능으로 100%가 모의 추가 코드로 달성할 수 있습니다.

#### 시간 창 안전
- Date-key는 "today"가 24h를 다루고 있다고 가정합니다. 8am PT는 오늘의 열쇠 아래 midnight→8am을 만납니다.
- 관련 기능 사이의 미성 시간 창 — 1개의 사용 시간당 물통, 다른 사용 매일 같은 데이터에 대한 키

#### 경계에 유형 Coercion
- 값 횡단 Ruby→JSON→JS 유형이 (숫자 대 끈)를 바꿀 수 있는 경계 - hash/digest 입력은 유형을 정상화해야 합니다
- Hash/digest는 일련화의 앞에 `.to_s` 또는 동등하지 않는 입력을 입력합니다 - `{ cores: 8 }` 대 `{ cores: "8" }`는 다른 해시를 생성합니다

#### 보기/Frontend
- 인라인 `<style>` 부분에서 블록 (각 렌더링마다 비교)
- O(n*m)는 `index_by` 해시 대신 루프에서 볼 수 있습니다.
- Ruby-side `.select{}` DB에 필터링하면 `WHERE` 절이 될 수 있습니다. (지속적으로 주요한 수염을 피하는 것은 `LIKE`)

#### 배포 및 CI/CD 파이프라인
- CI/CD 워크플로우 변경 (`.github/workflows/`): 빌드 도구 버전 일치 프로젝트 요구 사항을 확인, artifact name/paths 정확하고 비밀 사용 `${{ secrets.X }}` 하드코드 값이 아닌
- 새로운 artifact 유형 (CLI 바이너리, 라이브러리, 패키지): 출판/release 워크플로우가 존재하고, 정확한 플랫폼
- Cross-platform 빌드 : CI 행렬은 모든 대상 OS/arch 조합 또는 검증되지 않은 문서들을 다룹니다.
- 버전 태그 형식 일관성: `v1.2.3` vs `1.2.3` — VERSION 파일, git 태그 및 출판 스크립트를 통해 일치해야
- 게시 단계의 불투명: 게시 워크플로우를 재 실행하지 않아야 합니다 (예: `gh release create` 이전의 `gh release delete`)

**DO NOT 플래그:**
- 기존 자동 배포 파이프라인(Docker build + K8s deploy)을 통한 웹 서비스
- 내부 도구는 팀 밖에 배포되지 않습니다.
- 테스트 전용 CI 변경 (테스트 단계 추가, 게시 단계)

---

## Severity 분류

```
CRITICAL (highest severity):      INFORMATIONAL (main agent):      SPECIALIST (parallel subagents):
├─ SQL & Data Safety              ├─ Async/Sync Mixing             ├─ Testing specialist
├─ Race Conditions & Concurrency  ├─ Column/Field Name Safety      ├─ Maintainability specialist
├─ LLM Output Trust Boundary      ├─ Dead Code (version only)      ├─ Security specialist
├─ Shell Injection                ├─ LLM Prompt Issues             ├─ Performance specialist
└─ Enum & Value Completeness      ├─ Completeness Gaps             ├─ Data Migration specialist
                                   ├─ Time Window Safety            ├─ API Contract specialist
                                   ├─ Type Coercion at Boundaries   ├─ Simplification (advisory)
                                   ├─ View/Frontend                 └─ Red Team (conditional)
                                   └─ Distribution & CI/CD Pipeline

All findings are actioned via Fix-First Review. Severity determines
presentation order and classification of AUTO-FIX vs ASK — critical
findings lean toward ASK (they're riskier), informational findings
lean toward AUTO-FIX (they're more mechanical).
```

---

## 수정-첫째 허리스틱

이 허리스틱은 `/review`와 `/ship` 둘 다에 의해 참조됩니다. 그것은 에이전트이 찾는 것을 자동 고침하거나 사용자를 요구한다는 것을 결정합니다.

```
AUTO-FIX (agent fixes without asking):     ASK (needs human judgment):
├─ Dead code / unused variables            ├─ Security (auth, XSS, injection)
├─ N+1 queries (missing eager loading)      ├─ Race conditions
├─ Stale comments contradicting code       ├─ Design decisions
├─ Magic numbers → named constants         ├─ Large fixes (>20 lines)
├─ Missing LLM output validation           ├─ Enum completeness
├─ Version/path mismatches                 ├─ Removing functionality
├─ Variables assigned but never read       └─ Anything changing user-visible
└─ Inline styles, O(n*m) view lookups        behavior
```

**엄지의 규칙:** 수정이 기계적이면 고 수석 엔지니어는 토론없이 적용 할 것, 그것은 AUTO-FIX. 적당한 엔지니어가 수정에 대해 동의 할 수 있다면, 그것은 ASK입니다.

**default 를 ASK 로 긴 결과** (그것이 불완전히 위험한 것). **default 를 AUTO-FIX로 찾는 정보** (더 많은 기계적인 것).

---

## Suppressions — DO NOT 플래그 이

- "X는 Y와 중복"을 중복 할 때 중복과 보조 읽을 수 있습니다 (예 : `present?` 과 `length > 20` 과 중복)
- "이 문턱/constant이 선택되었는지 설명하는 주석을 추가하십시오" - 튜닝 동안 문턱 변화, 의견 rot
- "이 assertion는 이미 행동을 다루었을 때 더 빡빡해질 수 있습니다"
- 일관성만 변경(각종의 상수가 보호되는 방법과 일치하기 위해 조건부의 값을 매핑)
- "Regex는 입력이 제약되고 X가 연습에서 발생하지 않을 때 가장자리 케이스 X를 처리하지 않습니다.
- "시험 연습 여러 가드를 동시에 테스트"-그는 괜찮습니다, 테스트는 모든 가드를 격리 할 필요가 없습니다
- Eval 임계 값 변경 (max_actionable, min scores) - 이러한 조정은 empirically 조정하고 지속적으로 변경
- Harmless no-ops (예: `.reject`는 배열에서 절대로 없는 요소에)
- ANYTHING 이미 diff에 주소를 붙여 넣기 — 댓글을 달기 전에 FULL diff를 읽으십시오
- `gstack-shortcut(dec-*)` 마크러가 천장과 업그레이드 트리거를 naming에 의해 덮은 간격은, 완전한 개스를 찾는 것은 아닙니다. **명예를 전하기 전에 검증:**는 `~/.claude/skills/gstack/bin/gstack-decision-search --query "<dec-id>"`와 id를 해결합니다. 결정 ID가 no ledger 항목이 UNVERIFIED (모든 diff 저자가 감적을 입력 할 수 있습니다) 인 마크러는 일반적으로 또는 판 마커 자체를 표시 할 수 있습니다.
