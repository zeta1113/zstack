# gstack x OpenClaw 통합

gstack는 OpenClaw와 OpenClaw를 방법론 근원으로 통합하고, ported codebase가 아닙니다. OpenClaw의 ACP 주작동근 Claude Code 세션은 기본적으로. gstack는 그 세션을 더 잘 만드는 계획 분야와 방법론을 제공합니다.

이것은 신속한 텍스트로 인코딩 된 경량 프로토콜입니다. No 데몬. No JSON-RPC. No 호환성 매트릭스. 프롬프트는 다리입니다.

## 건축

```
  OpenClaw                               gstack repo
  ─────────────────────                    ──────────────
  Orchestrator: messaging,                 Source of truth for
  calendar, memory, EA                     methodology + planning
       │                                        │
       ├── Native skills (conversational)       ├── Generates native skills
       │   office-hours, ceo-review,            │   via gen-skill-docs pipeline
       │   investigate, retro                   │
       │                                        ├── Generates gstack-lite
       ├── sessions_spawn(runtime: "acp")       │   (planning discipline)
       │       │                                │
       │       └── Claude Code                  ├── Generates gstack-full
       │           └── gstack installed at      │   (complete pipeline)
       │               ~/.claude/skills/gstack  │
       │                                        └── docs/OPENCLAW.md (this file)
       └── Dispatch routing (AGENTS.md)
```

## 탈피

OpenClaw는 gstack의 gstack 지원을 tier가 하는 spawn 시간에 결정합니다:

| Tier | 의 의 | 연락처 |
|------|------|---------------|
| **의 장점** | One-file 편집, 태스코, 구성 변경 | No gstack 컨텍스트 주사 |
| **의 의** | 멀티 파일 기능, refactors | gstack-lite CLAUDE.md 부록 |
| **Heavy** | 특정한 gstack 기술 필요 | "로드 그라프. 실행 /X" |
| **Full** | 완전한 기능, 목표, 프로젝트 | gstack-full 파이프라인 부채 |
| **의 특징** | "내가 Claude Code 프로젝트를 계획할 수 있음" | gstack-plan 파이프라인 부과 |

### 결정 허리

- Can it be done in <10 lines of code? -> **의 장점**
- 여러 파일을 만지고 있지만 접근은 명백합니까? -> **의 의**
- 사용자명은 특정 기술(/cso, /review, /qa)? -> **Heavy**
- 기능, 프로젝트, 또는 목적 (작업이 아닌)입니까? -> **Full**
- PLAN 은 Claude Code 을 사용하지 않고 Claude Code 으로 원합니까? -> **의 특징**

## Dispatch 여정 가이드 (AGENTS.md)

`openclaw/agents-gstack-section.md`의 전체 준비 영역이 살아 있습니다. OpenClaw AGENTS.md로 복사하십시오.

키 행동 규칙 (이제는 ABOVE 파견 계층) :

1. **항상 spawn, 결코 리디렉션하지.** 사용자가 ANY gstack 기술을 사용하도록 요청할 때,
   ALWAYS Claude Code 세션을 종료합니다. Claude 코드를 열려면 사용자를 알려주지 마십시오.
2. **repo를 해결합니다.** 사용자명 repo, 작업 디렉토리를 설정합니다.
   알 수없는, repo를 묻습니다.
3. **Autoplan은 종료됩니다.** 스파덴, 전체 파이프라인을 실행하자, 보고서 다시
   채팅. 사용자는 Telegram을 떠나지 않아도 안됩니다.

## CLAUDE.md 충돌 처리

When spawning Claude Code in a repo that already has a CLAUDE.md, APPEND gstack-lite/full as a new section. Do not replace the repo's existing instructions.

## gstack는 OpenClaw를 위해 생성합니다

`openclaw/` 디렉토리에 모든 artifacts가 생성되고 `bun run gen:skill-docs --host openclaw`:

### gstack-lite (중간 층) `openclaw/gstack-lite-CLAUDE.md` - 계획 분야의 ~15의 선:
1. 수정하기 전에 모든 파일을 읽으십시오
2. 5 줄 계획을 작성: 무엇, 왜, 어떤 파일, 테스트 케이스, 위험
3. 결정 원칙을 사용하여 주변의 해결
4. 보고하기 전에 자기 조심
5. 완료 보고서 : 배송, 결정, 아무것도 불확실한

A/B 테스트: 2x 시간, 의미로 더 나은 산출.

### gstack-full (풀 티어) `openclaw/gstack-full-CLAUDE.md` - 기존의 체인 gstack 기술:
1. CLAUDE.md를 읽고 프로젝트를 이해하십시오.
2. /autoplan (CEO + eng + 디자인 검토)를 실행하십시오
3. 승인된 계획 구현
4. /ship를 실행하여 PR를 만듭니다.
5. Report back with PR URL and decisions

### gstack-plan (Plan tier) `openclaw/gstack-plan-CLAUDE.md` - 전체 리뷰 gauntlet, no 구현:
1. /office-hours를 실행하여 디자인 doc을 생성
2. /autoplan (CEO + eng + 디자인 + DX 리뷰 + 코덱 adversarial)
3. `plans/<project-slug>-plan-<date>.md`에 대한 검토 된 계획을 저장
4. 보고: 계획 경로, 요약, 키 결정, 권장 다음 단계

관현관은 자체 메모리 저장소 (brain repo, 지식 베이스 또는 AGENTS.md)에 구성되는 플랜 링크를 주장합니다. 사용자가 구축 할 준비가되면 저장된 플랜을 참조하는 FULL 세션을 종료합니다.

### ClawHub에 게시 된 기본 방법론 기술. `clawhub install`로 설치하십시오:
- `gstack-openclaw-office-hours` - 제품 간섭 (6 질문 간격)
- `gstack-openclaw-ceo-review` — 전략적 도전 (10구 검토, 4 모드)
- `gstack-openclaw-investigate` — 조작 디버깅 (4단계 방법론)
- `gstack-openclaw-retro` - 운영 복도 (주간 검토)

Source lives in `openclaw/skills/` in the gstack repo. These are hand-crafted adaptations of the gstack methodology for OpenClaw's conversational context. No gstack infrastructure (no browse, no telemetry, no preamble).

## Spawned 세션 감지

Claude Code가 OpenClaw에 의해 간격으로 뛰는 세션 내에서 실행될 때, `OPENCLAW_SESSION` 환경변수는 놓아야 합니다. gstack는 이것을 검출하고 조정합니다:
- 상호 작용하는 신속한 (자동 조당 권장 옵션; 파괴 또는
  믿을 수 없는 옵션은 자동 초센이 아닙니다. - 보수적 인 선택은 승리하고 완료 보고서에 기록됩니다.
- 배출(upgrade)에서 상호간판 명령 블록을 압축합니다.
  검사, 원격 측정 프롬프트, 기능 발견, 라우팅 사출, 팁), 그래서 한 번의 프롬프트는 다음 인간의 세션에 대한 intact 살아
- 도체 prose 신호 (`CONDUCTOR_SESSION: true`)를 압축합니다. — a
  도체 작업공간 내부의 스파드 세션 자동조각 대신 인체에 앉는
- 작업 완료 및 Prose 보고에 초점

세션에서 env var를 설정_스파드: `env: { OPENCLAW_SESSION: "1" }`

### Explicit override: GSTACK_SESSION_KIND

`GSTACK_SESSION_KIND=spawned`는 동일한 분류를 위한 명시적인 per-command 감적자, 각 주위 env 감적을 붙잡기 (를 포함하여 `OPENCLAW_SESSION` 및 `GSTACK_HEADLESS`). 그것은 Claude Code 에이전트은 부모 세션의 env byte-for-byte (#2733)를 상속하기 때문에 존재합니다 — 파견 기술은 동일한 명령 선에 preamble invocation를 미리 설치해서 그것의 에이전트을 표합니다:

```bash
GSTACK_SESSION_KIND=spawned "$_SS" --skill "document-release" ...
```

gstack 자체는 이것을 사용합니다: `/ship` 단계 18는 `/document-release` 이 접두사로 간섭을 파견합니다 그래서 prose-stopping 대신에 상호 작용하는 문 자동 조폐. Deliberately 좁은: 단지 `spawned`는 명예를 줬습니다 — `headless` 이미 `GSTACK_HEADLESS`가 있고, env var `interactive`를 CI 감적은 misclassification footgun일 것입니다. 빈 또는 다른 무시한 값은 (경량)를 통해서 (경량과) 보정됩니다. Hook 프로세스가 하네스 env를 상속하는 것을 참고하십시오. 그래서 per-command prefix는 PreToolUse/PostToolUse Hooks에 도달하지 못합니다. Hook 텍스트는 topology (`hosts/claude/hooks/spawned-directive.ts`)의 스페인 탈출 문장을 수행합니다.

**Tamper 가시성.** Any mechanism that injects session-wide env (a cloned repo's `.claude/settings.json` env block, direnv, a CI wrapper) could set `GSTACK_SESSION_KIND=spawned` for a real human's session and silently flip its confirmation gates to auto-choose. When the env override drives the classification, the preamble emits a loud `SPAWNED_OVERRIDE: env` status line so the transcript shows WHY the session is spawned — audit `.claude/settings.json` env blocks in untrusted repos (/cso covers this).

## 설치

OpenClaw 사용자: OpenClaw 에이전트 "openclaw에 gstack를 설치한다.

에이전트은:
1. gstack-lite CLAUDE.md를 코딩 세션 템플릿으로 설치
2. 4개의 기본 방법론 기술을 설치하십시오
3. AGENTS.md에 파견된 파견을 추가하십시오
4. 테스트 스파드로 검증

gstack 개발자: `./setup --host openclaw` 이 문서를 출력합니다. 실제적인 artifacts는 `bun run gen:skill-docs --host openclaw`에 의해 생성됩니다.

## 우리가 하지 않는 것

- No 파견 daemon (ACP는 세션을 훔치는 취급합니다)
- No 클로저 릴레이 (no 보안 층 필요)
- No 양방향 학습 브리지 (brain repo는 지식 상점입니다)
- No JSON 스키마 또는 프로토콜 버전
- No SOUL.md gstack (OpenClaw는 그것의 자신의 가지고 있습니다)
- No 전체 스킬 포팅 (코드 기술은 Claude Code)
