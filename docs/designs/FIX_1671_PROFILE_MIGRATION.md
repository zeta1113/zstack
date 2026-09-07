# #1671 수정 : `/office-hours` 항상 SESSION_COUNT : 0을보고

**상태:** SHIPPED **주요 특징:** Fix-1671-profile-migration **일:** 2026-05-23 **제품 설명:** https://github.com/garrytan/gstack/issues/1671 **버그를 도입한 PR:** garrytan/gstack#1039 / `0a803f9` / v1.0.0.0 / 2026-04-18

## 문제

`/office-hours`는 `SESSION_COUNT: 0`와 `TIER: introduction`를 각 invocation에 보고하고, 많은 시간을 운영하고 있는 사용자를 위해 조차. 사용자가 불변할 수 없는 반환을 위한 닫히는 피치를 건너는 존재되는 `welcome_back` 층 (`bin/gstack-developer-profile:165-169`). v1.0.0.0부터 각 신선한`$HOME` 사용자에 살아있는 ~5 주.

## 뿌리 원인

v1.0.0.0 마이그레이션은 `~/.gstack/developer-profile.json`로 읽는 경로를 이동하지만 `office-hours/SKILL.md.tmpl`의 작가를 레거시 `~/.gstack/builder-profile.jsonl`로 남겼습니다. `ensure_profile`의 stub는 처음 읽는 `sessions: []`를 가지고 있습니다. 이후는 독자가 재읽을 수 없는 파일로 이동합니다. 독자와 작가는 저장에 불명합니다.

분석 (RC2/RC3 후속 포함): https://github.com/garrytan/gstack/issues/1671

## 수정

같은 파일이 독자를 사용합니다.

### 변경

1. **`bin/gstack-developer-profile`** - `--log-session '<json>'` subcommand를 추가하십시오:
   - 필수 필드 (`date`, `mode`), 잘못된 입력에 침묵 스키 (매트 `bin/gstack-timeline-log:22-26`).
   - `bun -e`를 통해 기존 `developer-profile.json`를 읽습니다.
   - `sessions[]`에 입력을 승인합니다. `signals_accumulated` (`do_migrate:67-69`와 동일), 조합 `resources_shown` 및 `topics`와 같은 갱신 `signals_accumulated` (표시 끈 증가).
   - 원자 mktemp+mv 쓰기 (라인에 존재하는 패턴을 54).
   - `gstack-brain-enqueue "developer-profile.json"` 을 씁니다.

2. **`bin/gstack-developer-profile:do_read`** - `mode:"resources"`/ LAST_ASSIGNMENT/ LAST_DESIGN_TITLE/ CROSS_PROJECT/ DESIGN_*를 선택할 때 필터 `mode:"resources"` 항목. 단계 6 자원 자동 추가는 동일한 /office-hours invocation에 있는 실제 세션 후에 일어나; 여과기 없이, 자원 입장은 사용자의 다음 세션을 위한 진짜 소유 국가를 붙입니다. 부서진 작가에 의해 복종된 이른 버그; 수정에 의해 활성화.

3. **`office-hours/SKILL.md.tmpl`** - 490과 893 라인의 스왑 작가:
   - 에서: `echo '{...}' >> "$GSTACK_STATE_ROOT/builder-profile.jsonl"`
   - To: `~/.claude/skills/gstack/bin/gstack-developer-profile --log-session '{...}' 2>/dev/null || true`
   - `bun run gen:skill-docs`를 실행하여 `office-hours/SKILL.md`를 재생합니다.

## NOT 수정에서 (intentionally)

- **새로운 바이너리 없음.** `developer-profile.json`의 소유자 이진은 `gstack-developer-profile`입니다. 작가는 하위 command로 속합니다. `--log-session`는 이진의 기존 `--migrate`/ `--derive` 쓰기 측 subcommand 경계를 결합합니다. `gstack-*-log` 사건 작가 가족이 아닙니다. Verb 이름은 여전히 `gstack-*-log` 일치합니다.
- **mkdir-locks는 없습니다.** Concurrent /office-hours 호출은 `developer-profile.json`에 읽기 modify 쓰기 인종이 있습니다. codebase는 `gstack-config` (r-m-w on YAML, 자물쇠 없음)에서 동일한 레이스를 받아들입니다. 이 고침에 의해 소개되지 않기 위하여; 범위에서.
- **삽입 없음** Schema는 `schema_version: 1`에 체재합니다. 고침은 schema를 바꾸지 않으며, 다만 작가가 그것을 이용합니다.
- **영향을받는 사용자를 위한 자동 재조정 없음.** 가닥을 가진 기존 사용자는 `builder-profile.jsonl` 항목은 `developer-profile.json`로 자동 merged 그들의 과거 역사를 얻지 않습니다. 그 다음 /office-hours 실행에, `welcome_back`의 첫 번째 새로운 세션 땅; 과거 자료는 유산 파일에 체재합니다 (예를들면 다른 도구에 의해 읽기 쉬운). 대부분의 영향을 받은 사용자는 단지 좌초된 회의의 경편한이 이렇게 손실은 주로 미적. 하나의 릴리스 전용 리콘 멸망 통로를 순 잡음으로 떨어뜨렸다. - Garry의 "right-size diff" 목소리.
- **autoplan 타임라인 롤업 없음 (RC2).** 분리된 관심사, 분리되는 PR.
- **프로젝트-경쟁점 선택 없음 (RC3).** 분리된 관심사, 분리되는 PR.
- **gbrain glob 변화 없음.** 사무실 시간은 아직도 글로브 `~/.gstack/builder-profile.jsonl`를 뜻합니다. 일단 새로운 쓰기는 거기 착륙을 멈추고, 스냅샷은 감기를 갑니다. UX 문제점이 되는 경우에 따라 위로에 있는 갱신.

## 시험 (모든 문 층, 무료, 세균성)

1. **회귀 시험** `test/gstack-developer-profile.test.ts`:
   - Fresh `$HOME`.
   - /office-hours preamble: gstack-developer-profile은 빈 텁을 만듭니다.
   - `--log-session`를 호출하여 시작 상태 JSON를 호출합니다.
   - `--read`를 다시 실행하십시오. `SESSION_COUNT: 1`, `TIER: welcome_back`를 원조하십시오.
   - 현재 메인 실패 (subcommand는 존재하지 않습니다). 수정을 통과합니다.

2. **`do_read` 형태 필터 시험:** 는 자원 항목에 따라 시작 세션을 기록한 후 `--read` 는 LAST_PROJECT / LAST_ASSIGNMENT / LAST_DESIGN_TITLE 을 실제 세션에서, 자원 항목에서 제외합니다. RESOURCES_SHOWN 는 여전히 올바르게 집계합니다.

3. **검증 + 집계 시험:** `--log-session`는 JSON/가입된 필수 필드를 침묵적으로 건너뛰고, `ts`를 누락하면, 사용자가 `ts`를 보존하고, 여러 세션에 걸쳐 signals/resources/topics를 올바르게 집계합니다.

4. **정체되는 윤활 invariant** (새로운): 각 기술 디디렉터를 걸고, 생산 코드 경로가 `builder-profile.jsonl`로 작성되지 않는 경우, 허용된 리더를 제외하고 (`gstack-developer-profile`, `gstack-memory-ingest.ts`, `gstack-artifacts-init`, doc 파일). 레거시 파일에 회귀하는 미래 작가를 방지합니다.

### 합격 기준

- 두번째 `/office-hours` 신선한 `$HOME`에 invocation는 `TIER: welcome_back`를 반환합니다.
- `bun test`는 고립에 있는 접촉한 파일에 전달합니다.
- `bun run gen:skill-docs`는 `.tmpl` 편집과 일치하는 청결한 디퓨밍을 일으킵니다.

## # 롤아웃

- PATCH 버전의 범퍼 CHANGELOG 스타일 가이드.
- CHANGELOG `/ship` 에 의해 작성된 항목. 사용자 직면 음성: 그들이 이전에 없었던 것을 경험하는 것을 가진 지도 (welcome_back 층은 두번째 방문에 킥).

## 팔로우

- `builder-profile.jsonl`를 전적으로 (작가 + shim + Memory-ingest type)를 1개의 릴리스 후에 전합니다.
- RC2 (자동 계획 인라인 서브 스킬, 타임 라인 로그 preambles를 우회) 수정.
- `GSTACK_PROFILE_SCOPE` 여러 에이전트 식별 (RC3)를 사용하여 전원 사용자에 대한 선택 인을 추가하십시오.
- /plan-tune는 현재 `--derive`이라고 부릅니다, 그래서 `inferred`/`gap`는 (pre-existing, #1671와 관련이 없는)를 무능하게 할 수 있습니다.
- `mode:"resources"` 항목은 #1671 루트 원인과 관련되지 않는 기존 계층 집단 (pre-existing, #1671)의 SESSION_COUNT를 포함.
