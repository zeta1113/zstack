<!-- AUTO-GENERATED from review-sections.md.tmpl — do not edit directly -->
<!-- Regenerate: bun run gen:skill-docs -->
## 리뷰 섹션 (8 패스, 단계 0이 완료된 후)

**반대로 스키 규칙:** 결코 집광, 약어, 또는 계획 유형 (전략, spec, 코드, infra)에 관계없이 모든 리뷰 패스를 건너 뛰십시오. 이 모든 패스는 이유에 대한 기술이 존재합니다. "이것은 전략 문서이므로 DX 패스가 적용되지 않습니다"는 항상 잘못 - DX 간격은 채택이 중단되는 곳입니다. 패스가 실제로 0 개의 발견을 가지고 있다면, "문제가 발견되지 않음"라고 말하지만, 평가해야 합니다.

**반대로 단락:** The plan file is the OUTPUT of the interactive review, not a substitute for it. Writing every finding into one plan write and calling ExitPlanMode without firing AskUserQuestion is the precise failure mode of the May 2026 transcript bug — the model explored, found issues, and dumped them into a deliverable rather than walking the user through them. If you have ANY non-trivial finding in any review section, the path from finding to ExitPlanMode goes THROUGH AskUserQuestion. 모든 섹션에서 Zero 찾기는 AskUserQuestion을 우회하는 ExitPlanMode의 유일한 경로입니다. 요청하기 전에 발견 계획을 작성하고, 중지하고 AskUserQuestion를 호출하기 위해 원하는 경우, 버그가 인식됩니다.

## 사전 학습

이전 세션에서 관련 학습 검색:

```bash
_CROSS_PROJ=$(~/.claude/skills/gstack/bin/gstack-config get cross_project_learnings 2>/dev/null || echo "unset")
echo "CROSS_PROJECT: $_CROSS_PROJ"
if [ "$_CROSS_PROJ" = "true" ]; then
  ~/.claude/skills/gstack/bin/gstack-learnings-search --limit 10 --cross-project 2>/dev/null || true
else
  ~/.claude/skills/gstack/bin/gstack-learnings-search --limit 10 2>/dev/null || true
fi
```

`CROSS_PROJECT`는 `unset` (첫번째로): AskUserQuestion를 사용하십시오:

> gstack는 이 기계에 당신의 다른 프로젝트에서 학습을 찾아낼 수 있습니다
> 여기에 적용 할 수있는 패턴. 이 지방을 유지 (데이터가 기계를 나타낸다).
> 개인 개발자를 위해 추천. 여러 클라이언트 codebase에서 작동하면 Skip
> 교차 오염이 우려가 될 것입니다.

옵션:
- A) 크로스 프로젝트 학습 (추천)
- B) 프로젝트-경쟁을 만드세요

A: `~/.claude/skills/gstack/bin/gstack-config set cross_project_learnings true` B: 실행 `~/.claude/skills/gstack/bin/gstack-config set cross_project_learnings false`

그런 다음 적절한 플래그를 검색하십시오.

학습이 발견되면 분석에 통합됩니다. 검토 결과가 과거 학습과 일치할 때 표시:

**"Prior Learning apply: [key] (confidence N/10, from [date])"**

이것은 합성을 볼 수 있습니다. 사용자는 gstack가 시간에 그들의 코디베이스에 더 똑똑하게 얻고 있다는 것을 볼 수 있습니다.

### DX 동향 검사

리뷰 시작 전에, 이 프로젝트에 대한 사전 DX 리뷰 확인:

```bash
eval "$(~/.claude/skills/gstack/bin/gstack-slug 2>/dev/null)"
~/.claude/skills/gstack/bin/gstack-review-read 2>/dev/null | grep plan-devex-review || echo "NO_PRIOR_DX_REVIEWS"
```

사전 리뷰가 존재하는 경우, 추세를 표시하십시오:
```
DX TREND (prior reviews):
  Dimension        | Prior Score | Notes
  Getting Started  | 4/10        | from 2026-03-15
  ...
```

## Pass 1: 시작된 경험 (Zero Friction)

0-10 비율: 개발자가 5 분 미만에서 hello world로 이동할 수 있습니까?

**증거 회신:** 0C (target tier)에서 경쟁적인 벤치 마크를 참조하고, 0D (delivery 차량)에서 마술 순간, 그리고 0F에서 설치/Hello 세계 마찰 점.

짐 참고: `~/.claude/skills/gstack/plan-devex-review/dx-hall-of-fame.md`에서 "## Pass 1"섹션을 읽으십시오.

에바루이트:
- **설치하기**: 한 개의 명령? 한 번 클릭? 사전 예약이 없습니까?
- **첫 번째 실행**: 첫번째 명령은 눈에 보이는, 의미 있는 산출을 일으키는 원인이 되었습니까?
- **Sandbox/Playground**: 개발자가 설치하기 전에 시도할 수 있습니까?
- **무료 계층**: 신용 카드 없음, 판매 외침, 회사 이메일 없음?
- **빠른 시작 가이드**: 복사 효력은 완료합니까? 진짜 산출을 보여주십시오?
- **Auth/credential 부츠 스트랩**: "나는 시도하고 싶다"와 "그 작품"의 몇 단계는?
- **매직 순간 납품**: 실제로 계획에서 0D에서 선택된 차량은입니까?
- **경쟁 갭**: 0C에서 선택된 대상 계층에서 TTHW는 얼마입니까?

FIX TO 10: 이상적인 얻은 시작 순서 쓰기. 정확한 명령, 예상된 산출 및 단계 당 시간 예산을 지정하십시오. 표적: 3 단계 또는 몇몇, 0C에서 선택된 시간의 밑에.

줄무늬 테스트 : [0A에서 사람]에서 이동 "이"에 "그런 말은 끝을 떠나지 않고 한 터미널 세션에서 작동합니까?

**STOP.** AskUserQuestion 문제가 발생하면 됩니다. 추천 + WHY. 참고 인사를 참조하세요.

## Pass 2: API/CLI/SDK 디자인 (사용 가능한 + 유용한)

비율 0-10: 직관적이고, 일관된, 그리고 완료하는 공용영역은입니까?

**증거 회신:** API 표면 일치 [0A에서 사람]의 정신 모델? YC 설립자는 `tool.do(thing)`를 예상합니다. 플랫폼 엔지니어는 `tool.configure(options).execute(thing)`를 예상합니다.

짐 참고: `~/.claude/skills/gstack/plan-devex-review/dx-hall-of-fame.md`에서 "## 통행 2" 단면도를 읽으십시오.

에바루이트:
- **Naming**: 문서 없이 구제 가능? 일관된 문법?
- **기본 사항**: 각 모수에는 민감하는 과태가 있습니까? 가장 간단한 전화는 유용한 결과를 줍니다?
- **관련 제품**: 전체 API 표면의 맞은편에 동일한 본?
- **의성**: 100% 적용 또는 가장자리 케이스를 위한 익지않는 HTTP에 하락합니까?
- **의 특징**: docs 없이 CLI/playground에서 탐구할 수 있습니까?
- **Reliability/trust**: 지연, 정지, 속도 제한, idempotency, 오프라인 행동?
- **진보적인 disclosure**: 간단한 케이스는 생산 ready, 복잡성 점차적으로 계시됩니까?
- **Persona 적합**: 인터페이스는 어떻게 일치합니까 [persona] 문제에 대해 생각합니까?

좋은 API 디자인 시험: [persona]는 1개의 보기를 보자마자 이것을 API 올바르게 사용할 수 있습니까?

**STOP.** AskUserQuestion 문제가 발생하면 됩니다. 추천 + WHY.

## 패스 3: 오류 메시지 및 디버깅 (Fight Uncertainty)

비율 0-10: 뭔가 잘못되면, 개발자는 무슨 일이 있었는지 알고, 왜, 그리고 어떻게 그것을 해결?

**증거 회신:** 0F에서 오류 관련 마찰점 및 0G에서 혼동점 참조.

짐 참고: `~/.claude/skills/gstack/plan-devex-review/dx-hall-of-fame.md`에서 "## 통행 3" 단면도를 읽으십시오.

**Trace 3 특정 오류 경로** 플랜 또는 코디베이스에서. 각각, 명예의 홀에서 세 계층 시스템에 대한 평가:
- **층 1 (Elm):** 대화, 첫 번째 사람, 정확한 위치, 제안 된 수정
- **층 2 (Rust):** 튜토리얼, 1 차 + 이차 라벨에 오류 코드 링크, 도움말 섹션
- **Tier 3 (Stripe API):** 구조 JSON 유형, 코드, 메시지, param, doc_url

각 오류 경로에 대한, 개발자가 현재 vs. 그들이 볼 것을 볼 수 있는지 보여줍니다.

또한 평가:
- **Permission/sandbox/safety 모델**: 무엇이 잘못될 수 있습니까? 명확한 것은 폭발 반경입니까?
- **Debug 모드**: 유효한 Verbose 산출?
- **쌓기 추적**: 유용한 내부 기구 소음?

**STOP.** AskUserQuestion 문제가 발생하면 됩니다. 추천 + WHY.

## Pass 4: 문서 및 학습 (Findable + Doing에서 알아보세요)

0-10 비율: 개발자가 필요한 것을 찾아서 공부할 수 있습니까?

**증거 회신:** docs 아키텍처는 0A에서 [persona]의 학습 스타일입니까? YC 설립자는 사본 파스 예를 정면과 센터 필요로 합니다. 플랫폼 엔지니어는 건축 문서와 API 참조를 필요로 합니다.

짐 참고: `~/.claude/skills/gstack/plan-devex-review/dx-hall-of-fame.md`에서 "## Pass 4"섹션을 읽으십시오.

에바루이트:
- **정보 건축**: 2 분 미만의 필요는 무엇입니까?
- **진보적인 disclosure**: 초보자는 간단하고 전문가가 고급을 찾는다?
- **코드 예제**: 복사 - 파스 ? 완전? 일 as-is? 실제 상황에?
- **대화 형 요소**: 운동장, 사면함, "try it" 단추?
- **Command**: Docs는 버전 dev를 사용합니까?
- **튜토리얼 vs 참고**: 둘 다 존재합니까?

**STOP.** AskUserQuestion 문제가 발생하면 됩니다. 추천 + WHY.

## Pass 5: 업그레이드 및 마이그레이션 경로 (수용 가능)

비율 0-10: 공포 없이 개발자 향상할 수 있습니까?

짐 참고: `~/.claude/skills/gstack/plan-devex-review/dx-hall-of-fame.md`에서 "## 통행 5" 단면도를 읽으십시오.

에바루이트:
- **Backward 호환성**: 어떤 틈? 폭발 반경 한정?
- **경고 경고**: 사전 통지? 행동? (" 대신 newMethod()를 사용)
- **기타 관련**: 각 끊는 변화를 위한 단계 별 단계?
- **Command**: 자동화된 이동 스크립트?
- **버전 전략**: Semantic versioning? 명확한 정책?

**STOP.** AskUserQuestion 문제가 발생하면 됩니다. 추천 + WHY.

## Pass 6: 개발자 환경 & 도구로 만들기 (유효한 + 접근 가능)

0-10 비율: 개발자의 기존 워크플로우에 통합합니까?

**증거 회신:**는 0A에서 [persona]의 전형적인 환경에서 국부적으로 dev 체제 일을 합니까?

짐 참고: `~/.claude/skills/gstack/plan-devex-review/dx-hall-of-fame.md`에서 "## 통행 6" 단면도를 읽으십시오.

에바루이트:
- **Editor 통합**: 언어 서버? 자동 완성? 인라인 문서?
- **CI/CD**: GitHub 활동, GitLab CI에서 작동합니까? 비동기 형태?
- **TypeScript 지원**: 포함되는 유형? 좋은 IntelliSense?
- **시험 지원**: 쉽게 모이는? utilities를 시험하십시오?
- **지역 개발**: 뜨거운 재부하? 시계 형태? 빠른 의견?
- **크로스 플랫폼**: 맥, 리눅스, 윈도우? 도커? ARM/x86?
- **지역 env 재현성**: OS, 패키지 관리자, 컨테이너, 프록시를 통해 작동?
- **관찰성/testability**: 건조한 달리는 형태? Verbose 산출? 표본 앱? 정착물?

**STOP.** AskUserQuestion 문제가 발생하면 됩니다. 추천 + WHY.

## Pass 7: 커뮤니티 & 생태계 (Findable + Desirable)

0-10 비율 : 커뮤니티가 있고, 생태계 건강에 투자 할 계획입니까?

짐 참고: `~/.claude/skills/gstack/plan-devex-review/dx-hall-of-fame.md`에서 "## Pass 7"섹션을 읽으십시오.

에바루이트:
- **관련 기사**: 코드가 열리나요? 허용된 라이센스?
- **커뮤니티 채널**: devs는 질문합니까? 누군가 대답?
- **예시**: 현실 세상, 실행할 수 있습니까? 그냥 hello world?
- **Plugin/extension 생태계**: 그것을 확장할 수 있습니까?
- **관련 기사**: 프로세스가 명확합니까?
- **가격 투명성**: 놀람 청구서 없음?

**STOP.** AskUserQuestion 문제가 발생하면 됩니다. 추천 + WHY.

## Pass 8: DX 측정 & 피드백 루프 (Implement + Refine)

요금 0-10 : 계획은 시간이 지남에 DX을 측정하고 개선하는 방법을 포함합니까?

짐 참고: `~/.claude/skills/gstack/plan-devex-review/dx-hall-of-fame.md`에서 "## Pass 8"섹션을 읽으십시오.

에바루이트:
- **TTHW 추적**: 당신은 시작 시간을 측정할 수 있습니까? 그것은 기계로 가공됩니까?
- **여행 분석**: 어디 devs 떨어져 떨어지는?
- **관련 기사**: 버그 보고서? NPS? 피드백 버튼?
- **마찰 감사**: 정기적인 리뷰 계획?
- **붐 랑 읽기**: /devex-review는 현실 대를 측정할 수 있을 것입니까?

**STOP.** AskUserQuestion 문제가 발생하면 됩니다. 추천 + WHY.

### Appendix: Claude Code 기술 DX 검사 목록

**조건: 제품 유형이 "Claude Code 기술"을 포함할 때만 달리십시오.**

NOT는 점수가 주어진 패스입니다. gstack의 DX에서 입증된 패턴의 체크리스트입니다.

짐 참고: `~/.claude/skills/gstack/plan-devex-review/dx-hall-of-fame.md`에서 "## Claude Code 기술 DX 검사표" 단면도를 읽으십시오.

각 항목을 확인합니다. 체크하지 않은 품목을 위해, 누락 된 것을 설명하고 수정을 제안.

**STOP.** AskUserQuestion 디자인 결정이 필요한 모든 항목에 대해.

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

외부 음성 프롬프트를 구성할 때, 단계 0A 및 단계 0C에서 경쟁 벤치 마크에서 개발자 인 Persona를 포함합니다. 외부 음성은 그것을 사용하고 그들이 반대하는 것을 누구의 상황에 있는 계획을 비례해야 합니다.

## CRITICAL RULE — 질문하는 방법

위의 Preamble에서 AskUserQuestion 형식을 따르십시오. DX 리뷰에 대한 추가 규칙:

* **하나의 문제 = 하나 AskUserQuestion 호출.** 여러 가지 문제를 결합하지 마십시오.
* **증거에 대한 모든 질문.** 참고 인사, 경쟁적인 벤치 마크,
  동종 요법, 마찰 추적. 초록에 질문을하지 마십시오.
* **사람의 관점에서 구조 통증.** "개발자는 좌절 될 것"
  그러나 "[0A에서 사람]는 자신의 얻은 흐름의 분 [N]에 이것을 명중하고 [특히 결과 : 버려, 문제, 해머를 해킹]."
* 현재 2-3 옵션. 각: 해결, 개발자 채택에 영향을 미치는 노력.
* **DX 위의 첫 번째 원칙으로 맵을 붙여 넣으십시오.** 한 문장을 연결해 권고를 연결
  특정 원칙 (예 : "이 violates 'zero 마찰 T0'에서 "이 violates"는 "사람들]는 첫 번째 API 호출 전에 3 개의 추가 구성 단계를 필요로한다.
* **Zero 발견 :** 섹션이 0개의 발견이 있는 경우, state "No issues, move on"
  그리고 진행합니다. 그렇지 않으면 각 간격의 AskUserQuestion를 사용하며, "obvious fix"의 간격은 여전히 간격이며, 여전히 계획의 변화가 있는 토지의 변경 전에 사용자 승인을 필요로 합니다.
* 사용자를 20 분 안에 이 창에서 살펴 보지 마십시오. 모든 질문에 대한 답변.

## 필수 산출

## 개발자 인 Persona Card Step 0A에서 인가 카드. 이것은 플랜의 DX 섹션의 상단에 간다.

## 개발자 Empathy Narrative 단계 0B에서 첫 번째 사람의 narrative, 사용자 보정으로 업데이트.

## 경쟁력있는 DX 벤치 마크 단계 0C에서 벤치 마크 테이블, 제품의 포스트 리뷰 점수로 업데이트.

### Magical Moment 명세 단계 0D에서 선택된 납품 차량은 구현 필요조건으로.

## 개발자 여행지도 Step 0F에서 여행지도, 모든 마찰점 해결책으로 업데이트.

### First-Time Developer Confusion Report Step 0G의 역할극 보고서는 해당 항목이 주소로 표기된 것으로 표기됩니다.

### "NOT 범위에서"섹션 DX 개선은 각각 한 줄 합리적으로 간주되고 명시적으로 적습니다.

### "여기있는 것은"섹션 Existing docs, 예제, 오류 처리 및 계획이 재사용되어야하는 DX 패턴을 설명합니다.

## TODOS.md 업데이트 모든 리뷰 패스가 완료되면, 각 잠재력 TODO 자신의 개별 AskUserQuestion로. 절대 배치하지 마십시오. DX 부채 : 오류 메시지, 불특정 된 업그레이드 경로, 문서 간격, 누락 된 SDK 언어. 각 TODO 을 얻다:
* **이름:** 원라인 설명
* **왜:** 콘크리트 개발자가 원인을 겪고 있습니다.
* **프로 :** 당신이 얻는 무슨 (adoption, 보유, 만족)
* **단점 :** 비용, 복잡성, 또는 위험
* **구성 :** 3개월 동안 이를 선택하기 위해 누군가를 위한 충분한 세부사항
* **/에 따라 달라집니다:** 필수품

옵션: **A)** TODOS.md **B) (아)** Skip **C) (아)** 지금 빌드하십시오

## DX 득점 카드

```
+====================================================================+
|              DX PLAN REVIEW — SCORECARD                             |
+====================================================================+
| Dimension            | Score  | Prior  | Trend  |
|----------------------|--------|--------|--------|
| Getting Started      | __/10  | __/10  | __ ↑↓  |
| API/CLI/SDK          | __/10  | __/10  | __ ↑↓  |
| Error Messages       | __/10  | __/10  | __ ↑↓  |
| Documentation        | __/10  | __/10  | __ ↑↓  |
| Upgrade Path         | __/10  | __/10  | __ ↑↓  |
| Dev Environment      | __/10  | __/10  | __ ↑↓  |
| Community            | __/10  | __/10  | __ ↑↓  |
| DX Measurement       | __/10  | __/10  | __ ↑↓  |
+--------------------------------------------------------------------+
| TTHW                 | __ min | __ min | __ ↑↓  |
| Competitive Rank     | [Champion/Competitive/Needs Work/Red Flag]   |
| Magical Moment       | [designed/missing] via [delivery vehicle]    |
| Product Type         | [type]                                      |
| Mode                 | [EXPANSION/POLISH/TRIAGE]                    |
| Overall DX           | __/10  | __/10  | __ ↑↓  |
+====================================================================+
| DX PRINCIPLE COVERAGE                                               |
| Zero Friction      | [covered/gap]                                  |
| Learn by Doing     | [covered/gap]                                  |
| Fight Uncertainty  | [covered/gap]                                  |
| Opinionated + Escape Hatches | [covered/gap]                       |
| Code in Context    | [covered/gap]                                  |
| Magical Moments    | [covered/gap]                                  |
+====================================================================+
```

모든 패스 8 +: "DX 계획은 고체입니다. 개발자는 좋은 경험이 있을 것입니다." 아래 6: 특정 영향력을 가진 중요한 DX 부채로 플래그가 들어갑니다. TTHW > 10 분: 문제 차단으로 플래그.

### DX 구현 체크리스트

```
DX IMPLEMENTATION CHECKLIST
============================
[ ] Time to hello world < [target from 0C]
[ ] Installation is one command
[ ] First run produces meaningful output
[ ] Magical moment delivered via [vehicle from 0D]
[ ] Every error message has: problem + cause + fix + docs link
[ ] API/CLI naming is guessable without docs
[ ] Every parameter has a sensible default
[ ] Docs have copy-paste examples that actually work
[ ] Examples show real use cases, not just hello world
[ ] Upgrade path documented with migration guide
[ ] Breaking changes have deprecation warnings + codemods
[ ] TypeScript types included (if applicable)
[ ] Works in CI/CD without special configuration
[ ] Free tier available, no credit card required
[ ] Changelog exists and is maintained
[ ] Search works in documentation
[ ] Community channel exists and is monitored
```

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
TASKS_FILE="$TASKS_DIR/tasks-devex-review-$(date +%Y%m%d-%H%M%S).jsonl"
COMMIT=$(git rev-parse HEAD 2>/dev/null || echo unknown)
BRANCH=$(git branch --show-current 2>/dev/null || echo unknown)
RUN_ID="$(date -u +%Y%m%dT%H%M%SZ)-$$"

# Repeat ONE jq invocation per task identified during this review.
# Substitute the placeholders inline with shell variables you set per task:
#   TASK_ID (T1, T2, ...), PRIORITY (P1/P2/P3), COMPONENT, TITLE,
#   SOURCE_FINDING, EFFORT_HUMAN, EFFORT_CC, FILES_JSON (a JSON array literal
#   like '["browse/src/sanitize.ts","browse/src/server.ts"]').
jq -nc \
  --arg phase 'devex-review' \
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


### Unresolved Decisions if any AskUserQuestion 는 unanswered, 여기에 메모. 절대로 침묵적으로 기본값.

## 리뷰 로그

DX Scorecard — 대시보드, GSTACK REVIEW REPORT, EXIT PLAN MODE GATE의 "review log"라고 함)가 체크에 따라 결정한 후, **PLAN MODE EXCEPTION — ALWAYS RUN** (`~/.gstack/`로 씁니다, 프로젝트 파일이 아닙니다):

```bash
~/.claude/skills/gstack/bin/gstack-review-log '{"skill":"plan-devex-review","timestamp":"TIMESTAMP","status":"STATUS","initial_score":N,"overall_score":N,"product_type":"PRODUCT_TYPE","tthw_current":"TTHW_CURRENT","tthw_target":"TTHW_TARGET","mode":"MODE","persona":"PERSONA","competitive_tier":"COMPETITIVE_TIER","unresolved":N,"commit":"COMMIT"}'
```

TIMESTAMP = 현재 ISO 8601 datetime; STATUS = "클린" 점수 8+ AND 0에 녹이는 경우에, 다른 "issues_open"; DX Scorecard + Step 0; COMMIT = `git rev-parse --short HEAD`에서 다른 분야.

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

# 캡처 학습

이 세션 중 비 명백한 패턴, pitfall, 또는 건축 통찰력을 발견하면 향후 세션에 로그인하십시오.

```bash
~/.claude/skills/gstack/bin/gstack-learnings-log '{"skill":"plan-devex-review","type":"TYPE","key":"SHORT_KEY","insight":"DESCRIPTION","confidence":N,"source":"SOURCE","files":["path/to/relevant/file"]}'
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

양쪽 게이트 패스가 모두되면, 쓰기 백 경로는 `mcp__gbrain__takes_add`를 사용하여 무게 0.6 (SKILL_CALIBRATION_WEIGHTS당)로 가져갑니다. MCP op가 사용되지 않는 경우 `mcp__gbrain__put_page` 와 gstack:takes Fence block (documented but uglier path)로 다시 떨어졌습니다.

필수 입력 frontmatter 모양:
```yaml
kind: bet
holder: <user identity from whoami>
claim: <one-line prediction the skill is making>
weight: 0.6
since_date: <today's date>
expected_resolution: <date in 1-3 months depending on skill>
source_skill: plan-devex-review
```

쓰기 후, 영향을받은 소화를 무효하여 다음의 preflight는 새로운 상태를 반영합니다.

```bash
eval "$(~/.claude/skills/gstack/bin/gstack-slug 2>/dev/null)" 2>/dev/null || true
  ~/.claude/skills/gstack/bin/gstack-brain-cache invalidate developer-persona --project "$SLUG" 2>/dev/null || true
```


## 두뇌 캐시 배경 새로 고침

기술 작업이 완료되면 (그리고 원격 측정은 로그온), 킥은 어떤 캐시 다이제스트의 재생을 재생하는 것은 그것의 TTL. 이것은 비 차단입니다 - 사용자는 기다릴 수 없습니다. 다음 호출은 따뜻한 캐시에서 혜택을 제공합니다.

```bash
eval "$(~/.claude/skills/gstack/bin/gstack-slug 2>/dev/null)" 2>/dev/null || true
(~/.claude/skills/gstack/bin/gstack-brain-cache refresh --project "$SLUG" 2>/dev/null &) || true
```


## 다음 단계 — 체인링 검토

검토 읽기 후 Dashboard 검토, 다음 리뷰를 추천 :

**eng 검토가 전 세계적으로 건너지지 않는 경우 /plan-eng-review를 추천하십시오.** - DX 문제는 종종 건축적 의미가 있습니다. DX 검토가 API 디자인 문제, 오류 처리 간격, 또는 CLI 인체 공학적 문제, eng 검토가 수정을 검증해야합니다.

**/plan-design-review 사용자를 강제로 하면 UI가 존재합니다.** — DX 검토는 개발자 직면 표면에 초점; 디자인 검토는 끝 사용자 파싱 UI를 포함합니다.

**/devex-review를 구현한 후** — Boomerang. 계획은 TTHW가 0C에서 [target]일 것이라고 말했습니다. 현실 경기가 있었습니까? 살아있는 제품에 /devex-review를 실행하십시오. 경쟁적인 벤치 마크가 떨어져 지불하는 곳입니다: 당신은 측정하는 구체적인 표적이 있습니다.

적용 가능한 옵션과 AskUserQuestion를 사용하십시오:
- **A)** 실행 /plan-eng-review 다음 (필수 문)
- **B) (아)** 실행 /plan-design-review (UI 범위가 검출된 경우에만)
- **C) (아)** 구현을 준비, 선박 후 /devex-review 실행
- **(주)** Skip, 다음 단계가 수동으로 처리됩니다.

## 모드 빠른 참조
```
             | DX EXPANSION     | DX POLISH          | DX TRIAGE
Scope        | Push UP (opt-in) | Maintain           | Critical only
Posture      | Enthusiastic     | Rigorous           | Surgical
Competitive  | Full benchmark   | Full benchmark     | Skip
Magical      | Full design      | Verify exists      | Skip
Journey      | All stages +     | All stages         | Install + Hello
             | best-in-class    |                    | World only
Passes       | All 8, expanded  | All 8, standard    | Pass 1 + 3 only
Outside voice| Recommended      | Recommended        | Skip
```

## 형식 규칙

* NUMBER 문제 (1, 2, 3...) 및 옵션에 대한 LETTERS (A, B, C ...).
* NUMBER + LETTER (예: "3A", "3B").
* 옵션당 최대 1개의 문장.
* 각 통행 후에, 일시 중지는 위에 이동하는의 앞에 의견을 기다립니다.
* 검사를 위한 각 통행의 앞에 그리고 후에 비율.

