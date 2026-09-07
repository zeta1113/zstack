# 세션 인텔리전스 레이어

## 문제

Claude Code의 컨텍스트 윈도우는 ephemeral입니다. 모든 세션은 신선한 시작. ~167K 토큰에서 자동 활동 화재가 발생하면 일반 요약을 보존하고 파일 읽기, 납땜 체인 및 중간 결정에 파괴합니다.

gstack 이미 디스크에 살아남는 귀중한 artifacts를 생성합니다: CEO 계획, eng 검토, 디자인 리뷰, QA 보고, 학습. 이 파일은 결정, 제약, 그리고 현재의 일을 형성한 상황에 포함. 그러나 Claude는 그들이 존재한다는 것을 모른다. 조밀한 후에, 계획 및 검토는 문맥에서 침묵하게 사라지는 각 결정에 주의했습니다.

생태계는이 작업을 수행하고 있습니다. claude-mem (9K + 별)은 도구 사용량을 캡처하고 향후 세션에 상황에 대처합니다. Claude HUD는 실시간 에이전트 상태를 보여줍니다. Anthropic의 자체 `claude-progress.txt` 패턴은 각 세션의 시작에 대해 읽는 진행 파일이 사용됩니다.

**기술 생산 artifacts**가 압축을 살아남는 특정 문제를 해결하는 것은 아무도 없습니다. 아무도 gstack의 artifact 건축이 없기 때문에.

## 통찰력

gstack 이미 `~/.gstack/projects/$SLUG/`에 구조화된 artifacts를 쓰십시요:
- CEO 계획: `ceo-plans/`
- 디자인 리뷰: `design-reviews/`
- ENG 리뷰: `eng-reviews/`
- 학습: `learnings.jsonl`
- 기술 사용: `../analytics/skill-usage.jsonl`

누락된 조각은 저장되지 않습니다. 그것은 인식입니다. 전방은 에이전트에게 말할 필요가 있습니다: "파일이 존재합니다. 그들은 당신이 이미 만든 결정을 포함합니다. 조밀 한 후, 그들을 다시 보라."

## 건축

```
                   ┌─────────────────────────────────────┐
                   │        Claude Context Window         │
                   │   (ephemeral, ~167K token limit)     │
                   │                                      │
                   │   Compaction fires ──► summary only   │
                   └──────────────┬──────────────────────┘
                                  │
                          reads on start / after compaction
                                  │
                   ┌──────────────▼──────────────────────┐
                   │    ~/.gstack/projects/$SLUG/         │
                   │    (persistent, survives everything) │
                   │                                      │
                   │  ceo-plans/         ← /plan-ceo-review
                   │  eng-reviews/       ← /plan-eng-review
                   │  design-reviews/    ← /plan-design-review
                   │  checkpoints/       ← /checkpoint (new)
                   │  timeline.jsonl     ← every skill (new)
                   │  learnings.jsonl    ← /learn
                   └─────────────────────────────────────┘
                                  │
                          rolled up weekly
                                  │
                   ┌──────────────▼──────────────────────┐
                   │           /retro                      │
                   │  Timeline: 3 /review, 2 /ship, ...   │
                   │  Health trends: compile 8/10 (↑2)     │
                   │  Learnings applied: 4 this week       │
                   └─────────────────────────────────────┘
```

## 특징

## 레이어 1: Context Recovery (preamble, 모든 기술) ~10 선의 선을 미리 침입. 컴팩트 또는 컨텍스트 분해 후, 에이전트는 최근 계획, 리뷰 및 체크포인트에 대한 `~/.gstack/projects/$SLUG/`를 확인합니다. 디렉토리를 나열하고 가장 최근의 파일을 읽으십시오.

비용: 가까운 zero. 혜택: 모든 기술 계획/reviews 압축을 살아.

## 레이어 2: 세션 타임라인(프리머블, 모든 기술) 각 기술은 JSONL 항목에 `timeline.jsonl`를 추가합니다: 타임스탬프, 기술명, 지점, 키아웃컴. `/retro` 렌더링.

프로젝트의 AI-assisted 작업 역사가 눈에 띄게 만듭니다. "이 주: 3 /review, 2 /ship, 1 /investigate, 지점 기능-auth 및 수정-비행에 따라."

## 레이어 3: 크로스 - 시동 주입 (전반, 모든 기술) 새로운 세션이 최근의 artifacts와 지점에서 시작될 때, preamble는 한 라이너를 인쇄합니다. "마지막 세션 : 구현 JWT 오, 3/5 작업 완료. 계획 : ~/.gstack/projects/$SLUG/checkpoints/latest.md"

에이전트는 어떤 파일을 읽기 전에 왼쪽을 알고 있습니다.

## 레이어 4: /checkpoint (opt-in Skill) 작업 상태의 수동 스냅 샷: 어떻게 수행되고, 편집 된 파일, 결정, 남아있는 것. 단지 작업 전에, 워크 스페이스 핸드오프, 또는 일 후에 다시 오.

## 레이어 5: /health (opt-in Skill) 코드 품질 대시보드: 유형 체크, lint, 테스트 스위트, 죽은 코드 스캔. 합성 0-10 점수. 시간이 지남에 추적. `/retro`는 동향을 보여줍니다. 구성 가능한 임계 값에 `/ship` 게이트.

## 합성 효과

각 기능은 독립적으로 유용합니다. 함께, 그들은 화합물을 만드는 무언가를 만듭니다:

세션 1: /plan-ceo-review 계획 생성. 디스크에 저장. 세션 2: 에이전트는 미리 계획 후 계획을 읽습니다. 재 작업 결정. 세션 3: /checkpoint 진행을 저장합니다. 타임 라인은 2 /review, 1 /ship를 보여줍니다. 세션 4: 압축 화재 중반 요소. 에이전트가 체크 포인트를 다시 읽습니다. 키 결정, 유형, 나머지 작업을 복구합니다. 계속. 5: <ph/4> 세션: 6/10/>. 일주일에 걸쳐 기술적인 역할.

프로젝트의 AI 역사는 더 이상 ephemeral 없습니다. 그것은 지속, 화합물, 그리고 각 미래 세션을 더 똑똑한 만듭니다. 그것은 세션 인텔리전스 층입니다.

## 이지 않는 것

- Claude의 내장형 조밀함(그 핸들링)에 대한 교체가 아닙니다.
  국가; 우리는 gstack artifacts를 취급합니다)
- claude-mem 같은 전체 메모리 시스템 (그는 횡단보도를 처리한다)
  SQLite를 통해 메모리; 우리는 구조화된 기술 artifacts를 취급합니다)
- 데이터베이스 또는 서비스 (디스크에 마크 다운 파일)

## 연구 소스

- [Anthropic : 긴 실행 에이전트에 효과적인 하네스](https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents)
- [Anthropic: 효과적인 컨텍스트 엔지니어링](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents)
- [claude-mem의 특징](https://github.com/thedotmack/claude-mem)
- [Claude HUD](https://github.com/jarrodwatts/claude-hud)
- [CodeScene: Agentic AI 코딩 모범 사례](https://codescene.com/blog/agentic-ai-coding-best-practice-patterns-for-speed-with-quality)
- [git-persisted state를 통해 포스트 활동 복구 (Beads)](https://dev.to/jeremy_longshore/building-post-compaction-recovery-for-ai-agent-workflows-with-beads-207l)
