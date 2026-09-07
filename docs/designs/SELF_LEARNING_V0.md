# 디자인: GStack 자체 학습 인프라

생성됨 /office-hours + /plan-ceo-review + /plan-eng-review 에 2026-03-28 업데이트: 2026-04-01 (post-Session Intelligence, Codex) branch: garrytan/ce-features Repo: gstack 상태: ACTIVE 형태: 오픈 소스 / 커뮤니티

## 문제 문

GStack 세션을 통해 30+ 기술을 실행하지만 그 사이에 아무것도 배울 수 있습니다. /review 세션은 N+1 쿼리 패턴을 붙잡고, 같은 코베이스에서 시작되는 다음 /review를 긁습니다. /ship는 테스트 명령을 발견하고, 모든 미래 /ship는 그것을 다시 발견합니다. /investigate는 까다로운 레이스 상태를 찾아 향후 세션이 그것에 대해 알고 있습니다.

AI 코딩 도구는이 문제가 있습니다. 커서에는 사용자 메모리가 있습니다. Claude Code에는 CLAUDE.md이 있습니다. 윈드 서핑에는 지속적 인 컨텍스트가 있습니다. 그러나 그 화합물의 아무도. 그들은 무엇을 배울 수 없다는 구조. 그들은 기술 전반에 대한 지식을 공유하지 않습니다.

## 우리 빌딩은 무엇인가

세션과 기술 전반에 걸쳐 화합물을 다루기 위해 교육 기관 지식. 구조, 유형, 자신감을 갖는 학습은 모든 gstack 기술이 읽고 쓸 수 있다는 것을. 목표: 같은 코디에 20 세션 후, gstack 모든 건축 결정, 모든 과거 버그 패턴을 알고, 그리고 모든 시간 잘못되었다.

## 노스 스타

/autoship (개봉 5). 한개의 명령에 있는 가득 차있는 기술설계 팀. 특징을 설명하고, 계획, 다른 모든 것을 자동적 접근하십시오. /autoship는 학습 (R1) 없이 작동할 수 없습니다, 질 (R2), 회의 지속 (R3) 및 적응시키는 의식 (R4). 풀어 놓는 1-4는 실제로 일하는 인프라입니다.

## 관객

YC AI로 구축 된 설립자. 실제 코디에이터에서 gstack를 실행하는 사람들은 일주일에 20 + 번과 같은 질문을 두 번 묻을 때 통지합니다.

## 차이

| 의 특징 | 메모리 모델 | 범위 | 제품 설명 |
|------|-------------|-------|-----------|
| 의약 | Per-user 채팅 메모리 | - 연혁 | 의향 |
| CLAUDE.md | 정적 파일 | 프로젝트 | 의 특징 |
| 윈드 서핑 | Persistent 상태 | - 연혁 | 의향 |
| **GStack** | **프로젝트 JSONL** | **크로스백, 크로스스킬** | **유형, 득점, decaying** |

---

## 주 시스템

gstack에는 4개의 명백한 persistence 층이 있습니다. 그들은 저장 본을 공유합니다 (JSONL에서 `~/.gstack/projects/$SLUG/`) 그러나 다른 목적을 봉사합니다:

| 시스템 | File | 상점이 뭐지? | 글: | 으로 읽기 |
|--------|------|---------------|------------|---------|
| **학습 방법** | `learnings.jsonl` | 기관 지식 (방울, 패턴, 선호도) | 모든 기술 | 모든 기술 (preamble) |
| **의논문** | `timeline.jsonl` | 이벤트 내역 (스킬 시작/complete, 지점, 결과) | Preamble (자동) | /retro, preamble 컨텍스트 복구 |
| **의논하기** | `checkpoints/*.md` | 작업 상태 스냅 샷 (절차, 나머지 작업, 파일) | /checkpoint, /ship, /investigate | Preamble 컨텍스트 복구, /checkpoint 이력서 |
| **의약** | `health-history.jsonl` | 코드 품질 점수 시간 (per-tool, Composite) | /health | /retro, /ship (게이트), /health (trends) |

이 잉태는 안된다. 학습 = 당신이 알고있는 것. 타임 라인 = 무슨 일이. 체크 포인트 = 어디. 건강 = 좋은 코드는 얼마나. 각 질문에 대한 답변.

---

## 로드맵 출시

## 릴리즈 1: "GStack Learns" (v0.13-0.14) - SHIPPED

**헤드 라인:** 각 세션은 다음의 스마트한 것.

배송 :
- `~/.gstack/projects/{slug}/learnings.jsonl`에서 학습 지속
- `/learn` 수동 검토, 검색, prune, 수출에 대한 기술
- 모든 리뷰에 대한 불만 교정 (1-10 표시 규칙 점수)
- 관찰을 위한 불평성 감퇴/inferred 학습 (1pt/30d)
- 크로스 프로젝트 학습 발견 (opt-in, AskUserQuestion 동의)
- "Learning Applied" 콜 아웃은 과거 학습에 대한 일치 할 때
- /review, /ship, /plan-*, /office-hours, /investigate, /retro로 통합

관장:
```json
{
  "ts": "2026-03-28T12:00:00Z",
  "skill": "review",
  "type": "pitfall",
  "key": "n-plus-one-activerecord",
  "insight": "Always check includes() for has_many in list endpoints",
  "confidence": 8,
  "source": "observed",
  "branch": "feature-x",
  "commit": "abc1234",
  "files": ["app/models/user.rb"]
}
```

유형: `pattern` | `pitfall` | `preference` | `architecture` | `tool` 출처: `observed` | `user-stated` | `inferred` | `cross-model`

건축: 부록 JSONL. 읽기 시간에 해결되는 복제 (" key+type 당 가장 우승자"). 쓰기 시간 뮤테이션 없음, 인종 조건 없음.

## 릴리스 2: "리뷰 육군" (v0.14.3-0.14.4) — SHIPPED

**헤드 라인:** 10명의 전문가 검토자 각 PR.

배송 :
- 7 병렬 전문가 에이전트 : 항상 (테스트, 유지 보수) +
  조건 (보안, 성능, 데이터 마이그레이션, API 계약, 디자인) + 레드 팀 (대형 디퓨즈 / 중요한 발견)
- JSON-지구적인 결과물에 대한 신뢰 점수 + 지문 dedup
- PR 품질 점수 (0-10)는 검토 당 기록했습니다 + /retro 유행
- 학습에 기반한 전문가가 도메인 당 pitfalls를 주입 한 후
- Multi-specialist consensus 강조, 확인 된 발견은 향상
- PLAN_COMPLETION_AUDIT를 통해 강화된 납품 Integrity
- Checklist 재발견: CRITICAL 범주는 메인 패스, 전문가에 머물
  Categories review/specialists/에 초점을 맞춘 체크리스트에 추출

### 릴리스 2.5: "리뷰 육군 확장" — NOT YET SHIPPED

**헤드 라인:** R2가 안정된 후에 배. 핵심 반복이 실행되는 방법에 있는 검사.

사전 검사: 검토 R2 품질 미터 (PR 품질 점수, 전문 히트율, 거짓 긍정적 인 비율, E2E 테스트 안정성). 핵심 루프가 문제가 있다면, 그 첫 번째를 수정하십시오.

어떤 배:
- E1: 0-finding 궤도 기록과 자동 스키 전문가를 짝지어주는 적응 전문가.
  gstack-learnings-log를 통해 프로젝트의 히트율. 사용자는 --security 등에서 강제 할 수 있습니다.
- E3: 의 각 전문가 산출 TEST_STUB를 시험하십시오.
  프로젝트에서 검출되는 프레임 워크 (Jest/Vitest/RSpec/pytest/Go 테스트). 수정-First로 흐름: AUTO-FIX는 수정 + 테스트 파일을 만듭니다.
- E5: 딜 업을 찾는 교차 리뷰, 사전 리뷰 항목에 대한 gstack-review-read.
  이전 사용자 스크린 검색과 일치하는 검색.
- E7: gstack-review-log를 통해 특수 성능 추적, 로그 per-specialist 메트릭.
  타임라인 통합: 전문가는 타임라인에 표시됩니다.jsonl for /retro 추세.

### 릴리즈 3: "Session Intelligence" (v0.15.0) - SHIPPED

**헤드 라인:** AI 세션은 무슨 일이 있었는지 기억합니다.

배송 :
- 세션 타임라인: 모든 기술 자동 로그 시작/complete 이벤트
  `~/.gstack/projects/$SLUG/timeline.jsonl`. 지역 전용, 결코 어디에서나, 항상 원격 측정 설정에 상관없이.
- Context Recovery: 컴팩트 또는 세션 시작 후, 최근 목록 이전 CEO
  계획, 체크포인트 및 리뷰. 에이전트는 가장 최근의 상황을 복구하는 것을 읽습니다.
- 교차하는 소유주: preamble 인쇄 LAST_SESSION와 LATEST_CHECKPOINT를 위해
  현재 branch. 당신은 아무것도 입력하기 전에 왼쪽을 볼.
- 예측 능력 제안 : 마지막 3 세션이 패턴을 따르는 경우
  (리뷰, 배, 리뷰), gstack는 당신이 아마 다음을 원하는 것을 제안합니다.
- "Welcome back" 세션 시작에 대한 컨텍스트 메시지 합성.
- `/checkpoint` 기술: save/resume/list 작동 국가 스냅샷. 교차점
  지휘자 workspace handoff를 위한 명부작성 에이전트 사이.
- `/health` 기술: 프로젝트 도구 (tsc, biome, 코드 질 scorekeeper 감싸기
  knip, shellcheck, test). 컴포지트 0-10 점수, 추세 추적, 점수 드롭시 개선 제안.
- 타임라인: `bin/gstack-timeline-log` 및 `bin/gstack-timeline-read`.
- 규칙을 추적: /checkpoint 및 /health는 기술 여정을 전방하기 위하여 추가했습니다.

디자인 문서: `docs/designs/SESSION_INTELLIGENCE.md`

### 릴리스 4: " 적응식"- NOT YET SHIPPED

**헤드 라인:** GStack는 당신의 안전을 손상 없이 당신의 시간을 존중합니다.

의식과 신뢰는 별도의 문제입니다. 식 = review/test/QA 단계 PR 를 통해 진행합니다. Trust = 이 식 수준이 적용된 정책 엔진을 결정합니다. 그들은 상호 작용하지만 합병하지 않습니다.

어떤 배:

**식도:**
- FULL: 모든 전문가, adversarial, Codex 구조화 검토, 적용 감사, 계획
  완료. 큰 디프, 새로운 기능, 마이그레이션, 오즈 변경.
- STANDARD: adversarial + Codex의 적용 감사, 계획 완료. 중간 diffs를 위해,
  일반적인 기능 일.
- FAST: adversarial만. 작고, 믿을 수 있는 프로젝트에 잘 시험된 변화를 위해.

**신뢰 정책 엔진:**
- 범위 인식 신뢰. 신뢰는 변화 클래스 당 적립, 글로벌하지. 깨끗한 역사에
  docs-only PRs는 마이그레이션 PR에 대한 신뢰를 살지 않습니다.
- 클래스 감지 변경: docs, 테스트, 구성, frontend, backend, 마이그레이션, 오,
  infra. 각 클래스는 자체 신뢰 임계값을 가지고 있습니다.
- 신뢰 신호: 연속적인 청결한 리뷰 (클래스 당), /health 점수 안정성,
  회귀 빈도, 시험 적용 동향.
- 신뢰할 수 없는 빠른 트랙: 마이그레이션, auth/permission 변경, 새로운 API 엔드포인트,
  인프라 변경. 이러한 항상 FULL의 신뢰 수준에 관계없이 행사를 얻을 수 있습니다.
- 중력적인 분해, 바이너리 리셋. 단일 회귀는 모든 신뢰를 재설정하지 않습니다.
  그것은 1 수준에 의해 그 변화 클래스에 대한 신뢰를 degrades.

**범위 평가:**
- TINY/SMALL/MEDIUM/LARGE /review, /ship, /autoplan 에 따라 분류
  diff 크기, 파일 터치, 및 변경 클래스.
- 식 수준 = f (경, 신뢰, 변화 클래스).

**TODO 수명주기:**
- /triage 의 상호적인 승인
- 평행한 에이전트을 통해 배치 해결책을 위한 /resolve

### 릴리스 5: "/autoship — 한 명령, 전체 기능" — NOT YET SHIPPED

**헤드 라인:** 기능 설명. 계획 적용. 다른 모든 것은 자동입니다.

/autoship는 선형 파이프라인이 아닌 재섬성 국가 기계입니다. 검토 및 QA는 build/fix를 다시 보낼 수 있습니다. 압축은 어떤 단계든지 방해할 수 있습니다. 체계는 우아한 재해를 해야 합니다.

```
                    ┌──────────┐
                    │  START   │
                    └────┬─────┘
                         │
                    ┌────▼─────┐
                    │ /office- │
                    │  hours   │
                    └────┬─────┘
                         │
                    ┌────▼─────┐
                    │/autoplan │ ◄── single approval gate
                    └────┬─────┘
                         │
              ┌──────────▼──────────┐
              │       BUILD         │ ◄── /checkpoint auto-save
              └──────────┬──────────┘
                         │
              ┌──────────▼──────────┐
              │      /health        │ ◄── quality gate
              │   (score >= 7.0)    │
              └──────────┬──────────┘
                         │ fail → back to BUILD
              ┌──────────▼──────────┐
              │      /review        │
              └──────────┬──────────┘
                         │ ASK items → back to BUILD
              ┌──────────▼──────────┐
              │        /qa          │
              └──────────┬──────────┘
                         │ bugs found → back to BUILD
              ┌──────────▼──────────┐
              │       /ship         │
              └──────────┬──────────┘
                         │
              ┌──────────▼──────────┐
              │ /checkpoint archive │ ◄── preserve, don't destroy
              └─────────────────────┘
```

어떤 배:
- /autoship 위 주 기계를 가진 자율적인 파이프라인.
  각 단계는 timeline.jsonl에 쓰기. 각 단계의 앞에 자동 득점을 검사하십시오. 압축 회복: 컨텍스트 회복은 체크포인트 + 타임라인을 읽고, 마지막 완료된 단계에 재개합니다.
- 완료에 체크포인트 아카이브 (deletion). 복구 상태는 보존됩니다
  디버깅 실패 자동 실행을 위해.
- /ideate 뇌하수체 기술 (파렐 다이버그런트 에이전트 + adversarial 필터링)
- /plan-eng-review (codebase analyst, 역사 분석가,
  모범 사례 연구자, 학습 연구자)

에 따라: R1 (연구 에이전트에 대한 학습), R2 (품질에 대한 검토 군대), R3 (보존주의에 대한 기사), R4 (속도를위한 적응식).

### 릴리스 6: "Execution Studio" — NOT YET SHIPPED

**헤드 라인:** 병렬 실행 인프라.

어떤 배:
- Swarm Orchestration: 멀티 워크 트리 평행한 구조. 지휘자에 구조
  workspace는 /checkpoint (R3)에서 손전등합니다. 관현악 기술은 독립적인 workstreams를 평행한 에이전트으로 파견하고, 각자 자신의 worktree로 파견합니다.
- Codex 빌드 위임: Codex에 구현할 때 자동 탐지
  CLI 작업 유형에 따라 (boilerplate, 시험 발생, 기계적인 refactors).
- PR 피드백 해상도: 검토 플랫폼의 병렬한 코멘트 해결자.
- /onboard: codebase 분석에서 자동 생성한 기여자 가이드.
- /triage-prs: 정비자를 위한 배치 PR 삼기.

### 릴리스 7: "Design & Media" — NOT YET SHIPPED

**헤드 라인:** 시각적인 디자인 통합.

어떤 배:
- Figma 디자인 동기화 (pixel-matching 반복)
- 기능 비디오 녹화 (자동 생성 PR 데모)
- 크로스 플랫폼의 패시브 (Copilot, Kiro, Windsurf 출력)

---

## 위험 등록

### Proxy 신호는 scrutiny를 건너뛰기 위해 허가 (Codex 검토, 2026-04-01에 의해 식별)

/health 점수, 깨끗한 검토 역사, 타임 라인 패턴은 유용한 신호입니다. 그들은 안전의 증거가 아닙니다. 그 신호 피드 식 감소 AND /autoship의 경우, 실패 모드는 드물고, 침묵하고, 높은 심각성 실수입니다. 완화 :
- 특정 변경 클래스는 빠른 트랙 (이민, 오, 인프라, 새로운 엔드포인트).
- 신뢰는 점차적으로, 바이너리 재설정하지 않습니다.
- /autoship는 프로젝트 당 첫 번째 실행에 FULL 행사를 항상 실행합니다. 신뢰는 적립됩니다.

### Stale context Recovery (Codex 리뷰, 2026-04-01)에 의해 식별 됨

Context Recovery는 잘못된 벤치 상태를 주입 할 수 있습니다, 구제 계획, 또는 잘못된 체크 포인트. 소송 :
- 체크포인트는 YAML frontmatter에 있는 branch 이름을 포함합니다. Context 회복 여과기
  현재 branch으로.
- LAST_SESSION를 보여주기 전에 branch에 의하여 타임라인 윤활 필터.
- Stale artifact 탐지: 체크포인트가 >7 일인 경우에, 잠재적으로 주의하십시오
  현재로 현재를 나타내는 것보다 stale.

### 유효성 측정 필요 (Codex 검토, 2026-04-01에 의해 식별 됨)

R4 ( 적응식) 발송하기 전에, 측정:
- 예측적 제안 정확도 (사용자가 제안 된 기술을 실행합니까?)
- Trust 정책 false-skip rate (did fast-tracked PR은 포스트-merge 문제가 있습니까?)
- Context Recovery 정확도 (did는 컨텍스트 일치 실제 상태 복구?)
- /health 실제 코드 품질에 대한 상관 관계 점수 (높은 점수는 예측
  몇몇 생산 버그?)

이 메트릭은 R3 사용 중에 수집되어야 하며 R4 배 전에 검토되어야 합니다.

---

## Acknowledged 영감

자체 학습 로드맵은 Nico Bailon의 [복합 공학](https://github.com/nicobailon/compound-engineering) 프로젝트에서 아이디어로 영감을 얻었다. 학습 지속, 병렬 검토 에이전트 및 자율 파이프라인의 탐험은 GStack의 접근 방식의 디자인을 촉매화했다. 우리는 GStack의 템플릿 시스템, 음성 및 아키텍처에 맞게 모든 개념을 적용했습니다.
