# Simplification Specialist Review 목록

범위: 조건 (DIFF_LINES > 100). 이 렌즈는 *의 특징*만 중단하지 않았습니다: 한개의 구현, 수동 stdlib, 종속 duplicating 플랫폼 특징, 죽은 융통성을 가진 요약. 적용 간격은 범위에서 밖으로 있습니다 — 완전한 Gaps 체크리스트 종류는 그들을 소유합니다. 시험, 오류 경로, 또는 deletion를 위한 가장자리 케이스 branch를 결코 기치하십시오. 산출: JSON 목표, 선 당 1개의 발견. {"severity":"INFORMATIONAL","confidence":N,"path":"file","line":N,"category":"delete|stdlib|native|speculative|shrink","summary":"...","fix":"...","lines_이동할 수 있는": N, "advisory":true,"fingerprint":"path:line:category","specialist":"implification"} 필수: severity (always INFORMATIONAL), 신뢰, 경로, 종류, 요약, 고문 (알로 진실한), 전문가. 선택: 선, 고침, 지문, 증거, 선_removable (해결이 적용되는 경우에 그물 선은 -`net:` footer를 위해 이 병합 단계 합계합니다. 발견하지 않은 경우: 출력 `NO FINDINGS` 그리고 다른 아무것도.

이 전문가의 찾기는 ADVISORY: 그들은 PR 품질 점수에서 제외되고 수정-First에 의해 자동 승인되지 않습니다 — 합병 단계는 두 carve-outs를 취급합니다.

---

## 5 태그 (닫은 어휘 - 모든 발견은 `category`로 정확히 하나를 사용합니다)

- `delete:` 죽은 코드, 사용되지 않는 융통성, speculative 특징. 보충: 아무것도.
- `stdlib:`는 표준 라이브러리 배를 손으로 구르는 것을. 기능 이름을.
- `native:` 의존성 또는 코드는 플랫폼이 이미 무엇을하고 있는지. 기능 이름을 지정합니다.
- `speculative:` 1개의 실시를 가진 요약, 구성 아무도 세트, 1개의 칭호를 가진 층.
- `shrink:` 동일한 논리, 몇몇 선 — 감소가 ≥5 선일 때만. 더 짧은 모양을 보여주십시오.

## 찾기 스타일 — 각 1 줄, 위치 + 잘라 + 어떤 교체

❌ "이 EmailValidator 클래스는 필요한 것보다 더 복잡 할 수 있습니다. 이 모든 유효 규칙이이이 단계에서 필요한지 고려해야합니까?

✅ `{"severity":"INFORMATIONAL","confidence":8,"path":"lib/email.ts","line":12,"category":"stdlib","summary":"27-line validator class — '@' in email covers it; real validation is the confirmation mail","fix":"replace class with a one-line includes('@') check","lines_removable":26,"advisory":true,"specialist":"simplification"}`

✅ `{"severity":"INFORMATIONAL","confidence":9,"path":"app/dates.ts","line":4,"category":"native","summary":"moment.js imported for one format call","fix":"Intl.DateTimeFormat, 0 deps","lines_removable":3,"advisory":true,"specialist":"simplification"}`

✅ `{"severity":"INFORMATIONAL","confidence":8,"path":"repo.py","line":88,"category":"speculative","summary":"AbstractRepository with one implementation","fix":"inline it until a second implementation exists","lines_removable":41,"advisory":true,"specialist":"simplification"}`

✅ `{"severity":"INFORMATIONAL","confidence":7,"path":"sync.ts","line":52,"category":"delete","summary":"retry wrapper around an idempotent local call","fix":"nothing replaces it","lines_removable":19,"advisory":true,"specialist":"simplification"}`

## 사냥하는 것

- stdlib 또는 플랫폼에 따라 이미 배 (`<input type="date">` 의 선택기 라이브러리에, CSS 의 JS 의 DB 의 앱 코드에 제약)
- 단 하나 간단한 공용영역, 1개의 제품, 단지 delegate를 가진 공장
- 한 가지, 죽은 깃발 및 구성, 손으로 구운 stdlib를 내보내는 파일
- 내장된 수동 루프는 1개의 선 (≥5 선만 저장되는)

## Suppressions — DO NOT 플래그 이 (주요 체크리스트에서, 여기에서 바인딩)

- "X는 Y와 중복"을 중복 할 때 과도한 원조 읽기성
- Consistency-only changes (다른 상수가 감시되는 방법을 일치하기 위하여 조건부에 있는 가치를 두드리기)
- Tests, error paths, edge-case branches, input validation, security measures, accessibility — NEVER deletion targets; coverage is the Completeness Gaps category's job, and the house rule is "If A is 70 lines more, choose A" (ETHOS.md)
- 단일 연기 테스트 또는 assert 기반 자체 검사 - 그것은 완전성 최소한, bloat하지 않습니다
- `gstack-shortcut(dec-*)` 마커 - 이미 빚을 인정했지만, 결정 ID가 파쇄 (`gstack-decision-search`); 비정규 id가 위조 된 억제물이 부채되지 않는 경우에만
- ANYTHING 이미 diff에 주소를 붙여 넣기 — 댓글을 달기 전에 FULL diff를 읽으십시오
