# 새 호스트를 gstack에 추가

gstack는 declarative 호스트 구성 시스템을 사용합니다. 각 지원 AI 코딩 에이전트 (Claude, Codex, 공장, Kiro, OpenCode, Slate, Cursor, OpenClaw, Hermes, GBrain)는 `defineHost()` 공장에 의해 건설된 유형 TypeScript 구성 객체로 정의됩니다. 새 호스트가 하나의 파일 생성을 의미하고 다시 내보내는 것을 의미합니다. Zerocode, 생성 도구 또는 도구로 변경하십시오.

## 어떻게 작동합니까?

```
hosts/
├── define-host.ts   # defineHost() factory: shared defaults + derived fields
├── claude.ts        # Primary host
├── codex.ts         # OpenAI Codex CLI
├── factory.ts       # Factory Droid
├── kiro.ts          # Amazon Kiro
├── opencode.ts      # OpenCode
├── slate.ts         # Slate (Random Labs)
├── cursor.ts        # Cursor
├── openclaw.ts      # OpenClaw
├── hermes.ts        # Hermes (Nous Research)
├── gbrain.ts        # GBrain
└── index.ts         # Registry: imports all, derives Host type
```

각 구성 파일 호출 `defineHost()` 그리고 생성기를 말하는 `HostConfig` 객체를 내보내기:
- 생성된 기술을 넣는 곳 (paths)
- frontmatter (allowlist/denylist 필드)를 변환하는 방법
- 의문자에 대한 글을 읽는 것 (paths, tool name)
- 자동 설치를 위해 검출하는 어떤 바이너리
- 어떤 결선을 억제하는
- 설치 시간에 symlink에 어떤 자산

발전기, 설정 스크립트, 플랫폼 감지, 제거, 건강 검사, 워크 트리 복사, 그리고이 구성에서 모든 읽기 테스트. 그들 중 아무도 per-host 코드.

## Step-by-step: 새로운 호스트 추가

##1. 설정파일 만들기

Configs는 `hosts/define-host.ts` 공장 `hosts/define-host.ts`에 내장되어 있습니다. 일반적인 외부 호스트 기본과는 달리 필드를 작성하고 다른 모든 것은 호스트 이름에서 파생됩니다. 완전히 기본 호스트는 두 개의 필드 (`hosts/slate.ts` 또는 `hosts/cursor.ts` 참조)입니다.

```typescript
import { defineHost } from './define-host';

const myhost = defineHost({
  name: 'myhost',
  displayName: 'MyHost',
});

export default myhost;
```

이 기본값으로 `HostConfig` 으로 확장한다.

- `cliCommand: 'myhost'` (이름; `command -v` 탐지를 위한 이진)
- `cliAliases: []`
- `defaultModel: 'claude'` (생물이 명시되지 않은 경우 사용 된 모델 오버레이 `--model`; `'gpt'`)에 코드 오버라이드
- `globalRoot` / `localSkillRoot`: `.myhost/skills/gstack`, `hostSubdir`: `.myhost`
- `usesEnvVars: true` (Claude만 사용), 리터럴 `~` 경로 사용)
- `frontmatter`: `name` + `description`를 유지하는 수당은, 묘사 한계 없음
- `generation`: 메타데이터 파일 없음, `skipSkills: ['codex']` (codex 기술은 Claude-only입니다)
- `pathRewrites`: 해결된 경로에서 파생된 표준 trio
  (`~/.claude/skills/gstack` → `~/{globalRoot}`, `.claude/skills/gstack` → `{localSkillRoot}`, `.claude/skills` → `{hostSubdir}/skills`)
- `suppressedResolvers`: GBrain 쌍 (`GBRAIN_CONTEXT_LOAD`, `GBRAIN_SAVE_RESULTS`)
- `runtimeRoot`: 공유 자산 목록 (`bin`, `browse/dist`, `browse/bin`,
  `gstack-upgrade`, `ETHOS.md` + 리뷰 체크리스트 파일)
- `install`: `{ linkingStrategy: 'symlink-generated' }`
- `learningsMode: 'basic'`

`defineHost()`로 전달하여 필드를 무시합니다. 두 개의 경로로 변환 옵션:

- `extraPathRewrites`: appends 항목 AFTER 파생된 트리오 (e.g. kiro's
  codex-path cleanup, 또는 `{ from: 'CLAUDE.md', to: 'AGENTS.md' }` for AGENTS.md host). 표준 trio가 맞을 때 이것을 사용하지만 더 많은 것을 필요로 합니다.
- `pathRewrites`: 전적으로 파생된 명부를 대체합니다. 비 기계성만을 위해
  case - codex 및 공장은 `$GSTACK_ROOT`에 글로벌 경로를 다시 작성하고 추가 검토-path 리깅을 추가합니다. claude에는 빈 목록이 있습니다.

두는 상호적으로 독점적입니다 (공장은 둘 다 통과하면 던집니다).

퍼짐 구획을 위해 `define-host.ts`에서 수출되는 공유 일정: `CROSS_MODEL_RESOLVERS` (다른 모형을 invoke 할 수 없는 주인에 억압된 5개의 코덱에서), `GBRAIN_RESOLVERS` (기본 억제 쌍), `EXEC_STYLE_TOOL_REWRITES` (OpenClaw 작풍 더 낮은 케이스 발판은 openclaw와 raingb에 의해 공유했습니다).

좋은 예 : `hosts/opencode.ts` (path + runtimeRoot overrides), `hosts/factory.ts` (tool rewrites and conditional field), `hosts/hermes.ts` (AGENTS.md 호스트 사용자 정의 도구 재 작성 및 해결 구성).

##2. 인덱스에 등록

`hosts/index.ts` 편집:

```typescript
import myhost from './myhost';

// Add to ALL_HOST_CONFIGS array:
export const ALL_HOST_CONFIGS: HostConfig[] = [
  claude, codex, factory, kiro, opencode, slate, cursor, openclaw, hermes, gbrain, myhost
];

// Add to re-exports:
export { claude, codex, factory, kiro, opencode, slate, cursor, openclaw, hermes, gbrain, myhost };
```

##3. .gitignore에 추가

`.myhost/`를 `.gitignore` (진격된 기술 문서는 gitignored)에 추가하십시오.

##4. 생성 및 검증

```bash
# Generate skill docs for the new host
bun run gen:skill-docs --host myhost

# Verify output exists and has no .claude/skills leakage
ls .myhost/skills/gstack-*/SKILL.md
grep -r ".claude/skills" .myhost/skills/ | head -5
# (should be empty)

# Generate for all hosts (includes the new one)
bun run gen:skill-docs --host all

# Health dashboard shows the new host
bun run skill:check
```

##5. 실행 테스트

```bash
bun test test/gen-skill-docs.test.ts
bun test test/host-config.test.ts
```

매개 변수화된 연기 테스트는 새 호스트를 자동으로 선택합니다. 0 테스트 코드는 쓰기. 그들은 확인: 출력은 존재, 경로 누설 없음, 유효한 frontmatter, 신선도 체크 패스, 코덱 기술 제외.

##6 업데이트 README.md

적절한 섹션에서 새로운 호스트에 대한 설치 지침을 추가합니다.

## Config 필드 참조

`scripts/host-config.ts`를 참조하세요. `HostConfig` 인터페이스는 JSDoc의 모든 필드에 댓글을 보냅니다.

주요 분야:

| Field | 의논하기 |
|-------|---------|
| `defaultModel` | 모델 오버레이 렌더링 때 세대가 명시되지 않은 `--model` (`scripts/models.ts`에서 `ALL_MODEL_NAMES`에 대해 유효) |
| `frontmatter.mode` | `allowlist` (만 목록으로 만들어지는) 또는 `denylist` (목록으로 만들어지는 지구) |
| `frontmatter.descriptionLimit` | 최대 차, 제한 없음을 위한 `null` |
| `frontmatter.descriptionLimitBehavior` | `error` (실축), `truncate`, `warn` |
| `frontmatter.conditionalFields` | 템플릿 값에 근거한 필드를 추가하십시오 (예: 민감하는 → disable-model-invocation) |
| `frontmatter.renameFields` | 템플릿 필드를 이름 (예 : 음성 트리거 → 트리거) |
| `pathRewrites` | 문학은 모든 콘텐츠를 대체합니다. 주문 문제. 파생 된 트리오를 대체합니다. |
| `extraPathRewrites` | (defineHost 입력 전용) 파생 된 트리오 후 승인. |
| `toolRewrites` | Claude 도구 이름 바꾸기 (예: "Bash 도구"를 사용함 → "이 명령 실행") |
| `suppressedResolvers` | 이 호스트에 빈을 돌려주는 Resolver 함수 |
| `coAuthorTrailer` | Git co-author string for 커밋 |
| `boundaryInstruction` | 크로스 모델 인발 경고를 위한 항진출 |

## 유효성

`validateHostConfig()` 함수는 `scripts/host-config.ts` 체크:
- 이름: hyphens를 가진 Lowercase 알파누클
- CLI 명령: hyphens/underscores를 가진 영숫자
- `defaultModel`: `scripts/models.ts` `ALL_MODEL_NAMES`에서 알려진 모델 가족이어야 합니다.
- 경로: 안전한 문자만 (경쟁, `.`, `/`, `$`, `{}`, `~`, `-`, `_`)
- configs의 중복 이름, hostSubdirs, 또는 globalRoots 없음

`bun run scripts/host-config-export.ts validate`를 실행하여 모든 구성을 확인합니다.
