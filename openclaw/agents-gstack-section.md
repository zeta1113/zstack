## 코딩 작업 (gstack)

## 규칙 (비 협상 가능)

1. **항상 spawn, 결코 리디렉션하지.** 사용자가 ANY gstack 기술을 사용하도록 요청할 때,
   ALWAYS 세션을 통해 Claude Code 세션을 종료했습니다. Claude Code를 열려면 절대로 Claude 코드를 실행해야 합니다. "이 필요는 Claude 코드가 필요하지 않습니다."라고 말하면 "당신은 그에 대해 Claude Code를 열 필요가 없습니다."라고 말하십시오.

2. **repo를 해결합니다.** 사용자가 repo 또는 프로젝트를 이름을 지정하면 작업 설정
   repo 경로에 디렉토리. repo 경로가 알려지지 않은 경우, repo - 사용자가 Claude 코드를 열지 않도록 punt하지 마십시오.

3. **Autoplan은 종료됩니다.** /autoplan를 위해 특별히: 세션을 쫓아,
   전체 리뷰 파이프라인 (CEO → 디자인 → eng)을 실행하고, 완료되면, 여기에서 채팅에서 계획을 다시보고. 메모리에 계획을 작성하여 사용자가 나중에 찾을 수 있도록. 사용자는 Telegram을 떠나지 않아도됩니다.

### 멸치 래스팅

코딩 작업에 대해 물었을 때, 파견 계층을 선택하십시오.

**SIMPLE:** "이 태풍을 고정" "config," 단 하나 파일 변경 → session_spawn (runtime : "acp", prompt : "<just the task>")

**MEDIUM:** 멀티파일 기능, 재공장, 기술 편집 → 세션_스파이드(런타임: "acp", 프롬프트: "<gstack-lite content>\n\n<task>")

**HEAVY:**는 특정 gstack 방법론 → sessions_spawn (실행 시간: "acp", 프롬프트: "짐 gstack. 실행 /qa https://...") 기술: /cso, /review, /qa, /ship, /investigate, /design-review, /benchmark, /gstack-upgrade

**FULL:** 전체 기능을 구축, 멀티데이 범위, 계획 + 검토 → sessions_spawn(런타임: "acp", 프롬프트: "<gstack-full content>\n\n<task>") Claude Code 실행: /autoplan → 구현 → /ship → 보고

**PLAN:** 사용자는 Claude Code 프로젝트를 계획하고, 특징을 spec, 또는 어떤 코드든지 쓰기 전에 무언가를 디자인하고 싶습니까 → sessions_spawn (runtime: "acp", prompt: "<gstack-plan content>\n\n<task>") Claude Code 뛰기: /office-hours → /autoplan → 득점 계획 파일 → 보고 다시는 계획 연결을 기억/knowledge 상점에 보고합니다. 사용자가 새로운 공간에 실행할 준비가 될 때 FULL

### 결정 허리

- Can it be done in <10 lines of code? → **SIMPLE**
- 여러 파일을 만지고 있지만 접근은 명백합니까? → **MEDIUM**
- 사용자명은 특정 기술(/cso, /review, /qa)? → **HEAVY**
- "업그레이드 gstack", "업데이트 gstack" → **HEAVY** 와 `Run /gstack-upgrade`
- 기능, 프로젝트, 또는 목적(작업이 아닌)입니까? → **FULL**
- 사용자가 아직 구현하지 않고 PLAN 뭔가를 원합니까? → **PLAN**
