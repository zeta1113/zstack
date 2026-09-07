# 슬레이트 호스트 통합 - 연구 및 디자인 Doc

**일:** 2026-04-02 **주요 특징:** garrytan/slate-agent-support **상태:** 연구는, 호스트 구성 재공장 **슈퍼 :**에 막힌 완전히 합니다

## 슬레이트는 무엇인가

슬레이트는 랜덤 랩에서 독점적 인 코딩 에이전트 CLI입니다. 설치 : `npm i -g @randomlabs/slate` 또는 `brew install anthropic/tap/slate`. 라이센스 : proprietary. 85MB 컴파일 Bun 바이너리 (arm64/x64, darwin/linux/windows). npm 패키지 : `@randomlabs/slate@1.0.25` (8.8KB 발사기 + 플랫폼 별 옵션 deps).

멀티 모델: 역동적으로 Claude Sonnet/Opus/Haiku,와 다른 모델. 확장 멀티 시간 세션으로 "swarm Orchestration"를 위해 내장.

## 슬레이트는 OpenCode 포크입니다.

**Binary strings 분석을 통해 확인** 85MB Mach-O arm64 바이너리의:

- 내부 이름: `name: "opencode"` (이진에 있는 리터 문자열)
- 모든 `OPENCODE_*` env vars는 `SLATE_*` 동등물과 함께 선물합니다
- OpenCode의 도구/skill 아키텍처, LSP 통합, 터미널 관리
- 브랜딩, API 엔드포인트 (`api.randomlabs.ai`, `agent-worker-prod.randomlabs.workers.dev`), config 경로

통합에 대한이 문제: OpenCode 컨벤션은 주로 적용되지만 Slate는 자체 경로와 env vars를 상단에 추가합니다.

## Skill Discovery (이진에서 확인)

슬레이트 스캔 ALL 4 디렉토리 가족을위한 기술. 바이너리의 오류 메시지는 확인합니다 :

```
"failed .slate directory scan for skills"
"failed .claude directory scan for skills"
"failed .agents directory scan for skills"
"failed .opencode directory scan for skills"
```

**Discovery path (슬레이트 문서에서 선명한 순서):**

1. `.slate/skills/<name>/SKILL.md` — 프로젝트 수준, 가장 높은 우선 순위
2. `~/.slate/skills/<name>/SKILL.md` - 글로벌
3. `.opencode/skills/`, `.agents/skills/` - 호환성 fallback
4. `.claude/skills/` — Claude Code 겸용성 fallback (낮은)
5. `slate.json`를 통해 사용자 정의 경로

**Glob 본:** `**/SKILL.md`와 `{skill,skills}/**/SKILL.md`

**명령:** `commands/` subdirs: `/.slate/commands/`, `/.claude/commands/`, `/.agents/commands/`, `/.opencode/commands/`

**기술 frontmatter:** YAML 와 `name` 와 `description` 필드 (슬레이트 문서 당). 필드에 문서 길이 제한 없음.

## 프로젝트 지침

슬레이트는 프로젝트 지침에 대한 `CLAUDE.md` 및 `AGENTS.md` 둘 다 읽습니다. 이진에서 확인된 두 리터 문자열. 기존 gstack 프로젝트에 필요한 변경 사항이 없습니다 ... CLAUDE.md는 것과 동일합니다.

## 구성

**Config 파일:** `slate.json` / `slate.jsonc` (NOT opencode.json)

**Config 옵션 (슬레이트 문서에서):**
- `privacy` (불린) - telemetry/logging를 비활성화
- 허가: `allow`, `ask`, `deny` 도구 당 (`read`, `edit`, `bash`, `grep`, `webfetch`, `websearch`, `*`)
- 모형 구멍: `models.main`, `models.subagent`, `models.search`, `models.reasoning`
- MCP 서버: 사용자 지정 명령 및 헤더와 로컬 또는 원격
- 사용자 지정 명령: `/commands` 템플릿

설정 스크립트는 NOT `slate.json` 을 작성해야 합니다. 사용자는 자신의 권한을 구성합니다.

## CLI 플래그 (헤드리스 모드)

```
--stream-json / --output-format stream-json  — JSONL output, "compatible with Anthropic Claude Code SDK"
--dangerously-skip-permissions               — bypass all permission checks (CI/automation)
--input-format stream-json                   — programmatic input
-q                                           — non-interactive mode
-w <dir>                                     — workspace directory
--output-format text                         — plain text output (default)
```

**스트림-JSON 형식:** 슬레이트 문서는 Anthropic Claude Code SDK와 호환됩니다. 아직 empirically 검증되지 않았습니다. OpenCode 유산을 주기 위해서는 Claude Code NDJSON 이벤트 스키마 (유형: "assistant", 유형: "tool_result", 유형: "result").

**인증:** 런 `slate -q "hello" --stream-json` 런타임 런너 파서 구축하기 전에 유효 크레딧과 캡처 실제 JSONL 이벤트.

## 환경 변수 (이진 문자열에서)

### 슬레이트 별
```
SLATE_API_KEY                              — API key
SLATE_AGENT                                — agent selection
SLATE_AUTO_SHARE                           — auto-share setting
SLATE_CLIENT                               — client identifier
SLATE_CONFIG                               — config override
SLATE_CONFIG_CONTENT                       — inline config
SLATE_CONFIG_DIR                           — config directory
SLATE_DANGEROUSLY_SKIP_PERMISSIONS         — bypass permissions
SLATE_DIR                                  — data directory override
SLATE_DISABLE_AUTOUPDATE                   — disable auto-update
SLATE_DISABLE_CLAUDE_CODE                  — disable Claude Code integration entirely
SLATE_DISABLE_CLAUDE_CODE_PROMPT           — disable Claude Code prompt loading
SLATE_DISABLE_CLAUDE_CODE_SKILLS           — disable .claude/skills/ loading
SLATE_DISABLE_DEFAULT_PLUGINS              — disable default plugins
SLATE_DISABLE_FILETIME_CHECK               — disable file time checks
SLATE_DISABLE_LSP_DOWNLOAD                 — disable LSP auto-download
SLATE_DISABLE_MODELS_FETCH                 — disable models config fetch
SLATE_DISABLE_PROJECT_CONFIG               — disable project-level config
SLATE_DISABLE_PRUNE                        — disable session pruning
SLATE_DISABLE_TERMINAL_TITLE               — disable terminal title updates
SLATE_ENABLE_EXA                           — enable Exa search
SLATE_ENABLE_EXPERIMENTAL_MODELS           — enable experimental models
SLATE_EXPERIMENTAL                         — enable experimental features
SLATE_EXPERIMENTAL_BASH_DEFAULT_TIMEOUT_MS — bash timeout override
SLATE_EXPERIMENTAL_DISABLE_COPY_ON_SELECT  — disable copy on select
SLATE_EXPERIMENTAL_DISABLE_FILEWATCHER     — disable file watcher
SLATE_EXPERIMENTAL_EXA                     — Exa search (alt flag)
SLATE_EXPERIMENTAL_FILEWATCHER             — enable file watcher
SLATE_EXPERIMENTAL_ICON_DISCOVERY          — icon discovery
SLATE_EXPERIMENTAL_LSP_TOOL               — LSP tool
SLATE_EXPERIMENTAL_LSP_TY                 — LSP type checking
SLATE_EXPERIMENTAL_MARKDOWN               — markdown mode
SLATE_EXPERIMENTAL_OUTPUT_TOKEN_MAX       — output token limit
SLATE_EXPERIMENTAL_OXFMT                  — oxfmt integration
SLATE_EXPERIMENTAL_PLAN_MODE              — plan mode
SLATE_FAKE_VCS                            — fake VCS for testing
SLATE_GIT_BASH_PATH                       — git bash path (Windows)
SLATE_MODELS_URL                          — models config URL
SLATE_PERMISSION                          — permission override
SLATE_SERVER_PASSWORD                     — server auth
SLATE_SERVER_USERNAME                     — server auth
SLATE_TELEMETRY_DISABLED                  — disable telemetry
SLATE_TEST_HOME                           — test home directory
SLATE_TOKEN_DIR                           — token storage directory
```

## OpenCode 레거시 (실습 기능)
```
OPENCODE_DISABLE_LSP_DOWNLOAD
OPENCODE_EXPERIMENTAL_DISABLE_FILEWATCHER
OPENCODE_EXPERIMENTAL_FILEWATCHER
OPENCODE_EXPERIMENTAL_ICON_DISCOVERY
OPENCODE_EXPERIMENTAL_LSP_TY
OPENCODE_EXPERIMENTAL_OXFMT
OPENCODE_FAKE_VCS
OPENCODE_GIT_BASH_PATH
OPENCODE_LIBC
OPENCODE_TERMINAL
```

## gstack 통합을 위한 긴 env vars

**`SLATE_DISABLE_CLAUDE_CODE_SKILLS`** - 설정할 때, `.claude/skills/` 로드가 비활성화됩니다. 이 플래그가 설정될 때 `.slate/skills/` 로드 베어링에 게시하는 것이 좋습니다. `.slate/` 출판 없이 gstack 기술이 바인트가 설정될 때.

**`SLATE_TEST_HOME`** - E2E 테스트를 위해 유용한. Codex 시험이 온도 HOME를 사용하는 방법과 유사한 고립된 임시 직원 디렉토리에 슬레이트의 홈 디렉토리를 리디렉션할 수 있습니다.

**`SLATE_DANGEROUSLY_SKIP_PERMISSIONS`** - headless E2E 테스트를 위해 요구되는.

## 모델 참조 (이진에서)

```
anthropic/claude-sonnet-4.6
anthropic/claude-opus-4
anthropic/claude-haiku-4
anthropic/slate              — Slate's own model routing
openai/gpt-5.3-codex
google/nano-banana
randomlabs/fast-default-alpha
```

## API 엔드포인트 (이진에서)

```
https://api.randomlabs.ai                          — main API
https://api.randomlabs.ai/exaproxy                 — Exa search proxy
https://agent-worker-prod.randomlabs.workers.dev   — production worker
https://agent-worker-dev.randomlabs.workers.dev    — dev worker
https://dashboard.randomlabs.ai                    — dashboard
https://docs.randomlabs.ai                         — documentation
https://randomlabs.ai/config.json                  — remote config
```

Brew tap: `anthropic/tap/slate` (notable: Anthropic의 탭의 밑에, 무작위 실험실 아닙니다)

## npm 패키지 구조

```
@randomlabs/slate (8.8 kB, thin launcher)
├── bin/slate           — Node.js launcher (finds platform binary in node_modules)
├── bin/slate1          — Bun launcher (same logic, import.meta.filename)
├── postinstall.mjs     — Verifies platform binary exists, symlinks if needed
└── package.json        — Declares optionalDependencies for all platforms

Platform packages (85MB each):
├── @randomlabs/slate-darwin-arm64
├── @randomlabs/slate-darwin-x64
├── @randomlabs/slate-linux-arm64
├── @randomlabs/slate-linux-x64
├── @randomlabs/slate-linux-x64-musl
├── @randomlabs/slate-linux-arm64-musl
├── @randomlabs/slate-linux-x64-baseline
├── @randomlabs/slate-linux-x64-baseline-musl
├── @randomlabs/slate-darwin-x64-baseline
├── @randomlabs/slate-windows-x64
└── @randomlabs/slate-windows-x64-baseline
```

바이너리 override: `SLATE_BIN_PATH` env var는 모든 발견을 건너 뛰고, 지정된 바이너리를 직접 실행합니다.

## 오늘 알레디 작품

gstack 기술은 `.claude/skills/` fallback 경로를 통해 슬레이트에서 이미 작동합니다. 기본 기능을 위해 필요한 변경 사항이 없습니다. gstack를 Claude Code에 설치한 사용자들은 Slate를 사용하여 에이전트에서 사용할 수 있는 기술을 찾을 수 있습니다.

## 첫 클래스 지원 추가

1. **신뢰성** — `.slate/skills/`는 슬레이트의 가장 높은 선명한 경로입니다. 면역성이
   `SLATE_DISABLE_CLAUDE_CODE_SKILLS`.
2. **Optimized frontmatter의 특징** - 스트립 클로드 별 필드 (수입 형, 후크, 버전)
   슬레이트는 사용하지 않습니다. `name`과 `description`만 유지하십시오.
3. **설정 스크립트** - 자동 탐지 `slate` 이진, `~/.slate/skills/`에 기술을 설치하십시오.
4. **E2E 테스트** - 슬레이트에 의해 직접 호출 할 때 기술 작업을 검증합니다.

## Blocked On: 호스트 구성 요소

Codex의 외부 음성 검토는 4번째 주인으로 슬레이트를 추가하는 것을 확인했습니다 (Claude, Codex, 공장)는 "단거리 별명을 위한 주인 폭발"입니다. 현재 건축에는:

- `type Host = 'claude' | 'codex' | 'factory'`의 하드 코딩 호스트 이름
- `transformFrontmatter()`의 Per-host 지점을 근절시키는 논리
- `EXTERNAL_HOST_CONFIG`의 `EXTERNAL_HOST_CONFIG`와 유사한 패턴으로
- 설정 스크립트의 Per-host 함수 (`create_codex_runtime_root`, `link_codex_skill_dirs`)
- 호스트 이름 `bin/gstack-platform-detect` (지문자 삭제 — 호스트
  `hosts/` 레지스트리에서 감지하면 `scripts/host-config-export.ts`를 통해 쉘에 수출, `bin/gstack-uninstall`, `bin/dev-setup`

Slate를 추가하면이 패턴의 모든 복사를 의미합니다. 호스트 데이터 구동 (config object 대신 if/else branch)를 설정하려면 Slate 통합 트리 바이알 AND를 만들면 향후 호스트 (새 OpenCode 포크, 새로운 에이전트) 0-effort를 만듭니다.

## 계획에서 미링 (Codex에 의해 식별 됨)

- `lib/worktree.ts`만 복사 `.agents/`, `.slate/` — E2E worktrees에서 테스트가 되지 않습니다.
  슬레이트 기술
- `bin/gstack-uninstall` `.slate/`에 대해 알 수 없습니다.
- `bin/dev-setup`는 contributor dev 형태를 위한 철사 `.slate/`가 아닙니다
- `bin/gstack-platform-detect` 슬레이트를 감지하지 않습니다 (오용되지 않음 : 빈은
  삭제; 호스트 감지는 이제 `hosts/` 레지스트리를 통해 `scripts/host-config-export.ts` — `hosts/slate.ts`는 슬레이트가 살아 있는 곳이다.
- E2E 테스트는 `SLATE_DISABLE_CLAUDE_CODE_SKILLS=1`를 `.slate/` 경로 증명하기 위하여 놓아야 합니다
  실제로 작동 (`.claude/`로 다시 떨어지지 않음)

## 세션 러너 디자인 ( 나중에)

JSONL 형식이 확인되면 세션 실행자는 다음과 같습니다.

- Spawn: `slate -q "<prompt>" --stream-json --dangerously-skip-permissions -w <dir>`
- 파스 : Claude Code SDK- 호환 NDJSON (소형, 필요 검증)
- 기술: 시험 정착물에서 `.slate/skills/`에 설치하십시오 (`.claude/skills/` 아닙니다)
- Auth: `SLATE_API_KEY` 또는 기존 `~/.slate/` credentials를 사용하십시오
- 고립: 가정 디렉토리 고립을 위한 `SLATE_TEST_HOME`를 사용하십시오
- 타임아웃: 300s 기본 (Codex와 동일)

```typescript
export interface SlateResult {
  output: string;
  toolCalls: string[];
  tokens: number;
  exitCode: number;
  durationMs: number;
  sessionId: string | null;
  rawLines: string[];
  stderr: string;
}
```

## 문서 참조

- 슬레이트 문서: https://docs.randomlabs.ai
- Quickstart: https://docs.randomlabs.ai/en/getting-started/quickstart
- Skills: https://docs.randomlabs.ai/en/using-slate/skills
- 윤곽: https://docs.randomlabs.ai/en/using-slate/configuration
- 단축키: https://docs.randomlabs.ai/en/using-slate/hotkey_reference
