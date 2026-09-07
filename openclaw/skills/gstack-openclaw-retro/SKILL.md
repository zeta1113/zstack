---
name: gstack-openclaw-retro
description: "Weekly engineering retrospective. Analyzes commit history, work patterns, and code quality metrics with persistent history and trend tracking. Team-aware with per-person contributions, praise, and growth areas. Use when asked for weekly retro, what shipped this week, or engineering retrospective."
---

# 주간 엔지니어링 복도

종합 엔지니어링 복도 분석 commit 역사, 작업 패턴 및 코드 품질 미터를 생성. 팀 인식: 사용자를 실행 명령을 식별, 다음 각 기여자를 분석 per-person 칭찬과 성장 기회.

## 분류

- Default: 지난 7일
- `24h`: 24시간 지속
- `14d`: 14일 지속
- `30d`: 30일 지속
- `compare`: 이전 같은 길이 창 대 비교

## 지시

시간 창을 결정하는 인수를 파. Default 에 7 일. 모든 시간은 사용자의 **현지 시간**에보고되어야한다.

**Midnight 정렬 창:** 하루 단위의 경우, 로컬 자정에서 절대 시작 날짜를 계산합니다. 예를 들어, 오늘 2026-03-18이고 창이 7 일이라면 시작 날짜는 2026-03-11입니다. git log 쿼리의 `--since="2026-03-11T00:00:00"`를 사용하십시오. 시간 단위의 경우 `--since="N hours ago"`를 사용하십시오.

---

### 단계 1: 가더 원료

첫째, fetch origin 그리고 현재 사용자를 식별:

```bash
git fetch origin main --quiet
git config user.name
git config user.email
```

`git config user.name` 으로 반환된 이름은 **"당신은"** ...이 복고풍을 읽는 사람. 다른 모든 저자는 팀메이트입니다.

이 git 명령의 ALL 실행 (그들은 독립적으로):

```bash
# All commits with timestamps, subject, hash, author, files changed
git log origin/main --since="<window>" --format="%H|%aN|%ae|%ai|%s" --shortstat

# Per-commit test vs total LOC breakdown with author
git log origin/main --since="<window>" --format="COMMIT:%H|%aN" --numstat

# Commit timestamps for session detection and hourly distribution
git log origin/main --since="<window>" --format="%at|%aN|%ai|%s" | sort -n

# Files most frequently changed (hotspot analysis)
git log origin/main --since="<window>" --format="" --name-only | grep -v '^$' | sort | uniq -c | sort -rn

# PR numbers from commit messages
git log origin/main --since="<window>" --format="%s" | grep -oE '[#!][0-9]+' | sort -t'#' -k1 | uniq

# Per-author file hotspots
git log origin/main --since="<window>" --format="AUTHOR:%aN" --name-only

# Per-author commit counts
git shortlog origin/main --since="<window>" -sn --no-merges

# Test file count
git ls-files 2>/dev/null | grep -E '(\.test\.|\.spec\.|_test\.|_spec\.)' | wc -l

# Test files changed in window
git log origin/main --since="<window>" --format="" --name-only | grep -E '\.(test|spec)\.' | sort -u | wc -l
```

---

### 단계 2: 컴퓨터 미터

계산하고 요약의이 메트릭을 제시:

- **주요에 Commits:** N
- **기여자:** N
- **PRs 합병:** N
- **총 삽입:** N
- **총 삭제:** N
- **Net LOC 추가:** N
- **시험 LOC (인출):** N
- **LOC 비율을 시험하십시오:** N%
- **버전 범위:** vX.Y.Z → vX.Y.Z
- **활동 일:** N
- **감지 세션:** N
- **Avg LOC/session-hour:** N

다음 아래 **per-author 리더보드**를 즉시 보여줍니다:

```
Contributor         Commits   +/-          Top area
You (garry)              32   +2400/-300   browse/
alice                    12   +800/-150    app/services/
bob                       3   +120/-40     tests/
```

정렬 명령 하 여 후손. 현재 사용자는 항상 먼저 나타나고, "You (name)"을 표시.

---

### 단계 3: 시작 시간 배급

현지 시간의 시간당 histogram을 표시합니다.

```
Hour  Commits  ████████████████
 00:    4      ████
 07:    5      █████
 ...
```

인증:
- 피크 시간
- 죽은 영역
- Bimodal 패턴 (morning/evening) vs 연속
- 늦은 밤 코딩 클러스터 (10pm 이후)

---

### Step 4: 작업 세션 감지

연속 커밋 사이 **45분 간격** 임계값을 사용하여 세션을 감지합니다.

수업료:
- **딥 세션** (50+ 분)
- **중간 세션** (20-50 분)
- **Micro 세션** (<20분, 단 하나 모방)

계산:
- 총 활성 코딩 시간
- 평균 세션 길이
- LOC 활성 시간 당

---

### 단계 5: 유형을 끊기십시오

기존 commit 접두사 (feat/fix/refactor/test/chore/docs). 쇼 백분율 표시:

```
feat:     20  (40%)  ████████████████████
fix:      27  (54%)  ███████████████████████████
refactor:  2  ( 4%)  ██
```

수정 비율이 50%를 초과하면 플래그 ... "선급, 빠른 수정" 패턴을 표시 할 수 있습니다 검토 간격.

---

### 단계 6: 핫스팟 분석

상위 10개 파일 보기. 플래그:
- 파일 변경 5+ 시간 (churn hotspots)
- Hotspot 목록에서 생산 파일 vs 테스트
- VERSION/CHANGELOG 주파수

---

### 단계 7: PR 크기 배급

예상 PR 크기와 물통 그:
- **의 의** (<100 LOC)
- **의 의** (100-500 LOC)
- **의 의** (500-1500 LOC)
- **XL** (1500+ LOC)

---

### 단계 8: 초점 점수 + 주의 배

**초점 점수:** 커밋의 퍼센트는 단일의 가장 변화된 최상위 디렉토리를 만드. 더 높은 = 심층적 인 작업. 더 낮은 = 스프레더 컨텍스트 전환.

**주의 배:** 창에서 단 하나 가장 높은LOC PR. 하이라이트 PR 수, LOC 변경, 그리고 왜 그것은 사정.

---

### Step 9: 팀 멤버 분석

각 기여자 (현재 사용자 포함)에 대한, 계산:

1. **옥수수 속과 LOC** ... 총 커밋, 삽입, 탈레, 그물 LOC
2. **초점의 지역** ... 감독 /files 그들은 가장 터치 (위 3)
3. **Commit 유형 혼합** ... 개인 feat/fix/refactor/test 고장
4. **세션 패턴** ... 그들이 코드 (시간을 말) 때, 세션 수
5. **시험 분야** ... 개인 시험 LOC 비율
6. **가장 큰 배** ... 그들의 단일 가장 높은 충격 commit 또는 PR

**현재 사용자 ( "You")의 경우:** 가장 깊은 처리. 모든 세션 분석, 시간 패턴, 초점 점수를 포함. 첫 번째 사람에 프레임.

**각 teammate를 위해:** 그들이 발송하고 그들의 본을 덮는 2-3개의 문장. 그 후에:

- **Praise** (1-2 특정한 것): 실제적인 투입에 있는 닻. "그것은 일" 아닙니다 ... 정확하게 무슨이 좋은 말하십시오.
- **성장 기회** (1개의 특정한 것): 수평하게 하기 위, 비판하지 않기로 구조. 실제적인 자료에 있는 닻.

**repo:** 팀 고장을 건너 뛰기.

**AI 협력:** 커밋이 `Co-Authored-By` AI 트레일러를 가지고 있다면, 별도의 메트릭으로 "AI-assisted commits"를 추적합니다.

---

### 단계 10: 주간 이상 - 주말 동향 (창 >= 14d)

매주 물통으로 분할하고 동향을 보여줍니다:
- 주당 Commits (총과 주당)
- LOC 주당
- 주당 시험 비율
- 주당 고정 비율
- 주당 세션 수

---

### 단계 11: Streak 추적

적어도 1 commit를 가진 연속 일, 오늘에서 돌아 가기:

```bash
# Team streak
git log origin/main --format="%ad" --date=format:"%Y-%m-%d" | sort -u

# Personal streak
git log origin/main --author="<user_name>" --format="%ad" --date=format:"%Y-%m-%d" | sort -u
```

두 번 표시:
- "팀 배송 streak : 47 연속 일"
- "당신의 배송 streak : 32 연속 일"

---

### 단계 12: 로드 역사 & 비교

`memory/`의 이전 복고풍 역사에 대한 확인:

이전 복고풍이 존재하는 경우, 가장 최근의 것을로드하고 deltas를 계산하십시오.

```
                    Last        Now         Delta
Test ratio:         22%    →    41%         ↑19pp
Sessions:           10     →    14          ↑4
LOC/hour:           200    →    350         ↑75%
Fix ratio:          54%    →    30%         ↓24pp (improving)
```

no 이전 복고풍이 존재하면, "첫 복고풍이 기록되어, 다음 주에 다시 시작해 동향을 볼 수 있습니다."

---

### 단계 13: Retro 역사를 저장하십시오

JSON snapshot를 `memory/retro-YYYY-MM-DD.json`로 메트릭, 저자, 버전 범위, streak, 그리고 tweetable 요약 저장하십시오.

---

### 단계 14: 협상을 쓰기

**Telegram의 형식** (bullets, 대담한, 마지막 산출에 있는 no markdown 테이블).

구조:

**Tweetable 요약** (첫번째 선):
> 3월 1일 주: 47 커밋 (3 기여자), 3.2k LOC, 38% 테스트, 12 PRs, 피크: 10pm | Streak: 47d

다음 섹션:

- **Summary** ... 키 메트릭
- **최근 Retro** ... deltas (스키프가 처음 복고풍이라면)
- **시간 & 회의 본** ... 팀 코드, 세션 길이, 마이크로 vs
- **배송 속도** ... commit 유형, PR 크기, 수정 체인 탐지
- **Code 품질 신호** ... 테스트 비율, 핫스팟, churn
- **초점 & 하이라이트** ... 포커스 점수, 주 배
- **당신의 주** ... 현재 사용자를 위해 개인의 심층적
- **팀 고장** ... 칭찬 + 성장과 per-teammate 분석 (독자면 스키)
- **상위 3팀 우승** ... 배송된 가장 높은 물건
- **3 개선의 것들** ... 특정, 행동, 커밋에 고정
- **다음 주 3 Habits** ... 작고 실용적인 현실적인 (<5 min to 채택합니다)

---

## 형태 비교

사용자가 "compare"라고 말하면
- 현재 창에 복고풍을 실행
- 이전 같은 길이 창에 복고풍을 실행
- 개선을 보여주는 화살표로 현재 측면 방향 미터/regression
- 가장 큰 변화에 대한 간략한 판단

---

## 중요 규칙

- **현지 시간대의 모든 시간.** `TZ`를 설정하지 마십시오.
- **Telegram의 형식.** 총알과 대담한 사용. 최종 출력에서 표 다운 테이블을 피하십시오.
- **커밋에 고정 된 Praise.** "그런 일을"하지 말하지 않고 좋은 일.
- **데이터에 고정 된 성장 영역.** 증거가 없는 절대로 비판하지 않습니다.
- **의 역사** 각 복고풍은 동향 추적을 위해 `memory/`에 저장합니다.
- **완료 상태:**
  - DONE ... 개조 생성, 저장 된 역사
  - DONE_WITH_CONCERNS ... 생성되었지만 누락된 데이터 (예: no 이전의 복고풍 비교)
  - BLOCKED ... git repo 또는 no 창에 커밋하지 않음
