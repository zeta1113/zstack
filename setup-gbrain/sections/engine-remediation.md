<!-- AUTO-GENERATED from engine-remediation.md.tmpl — do not edit directly -->
<!-- Regenerate: bun run gen:skill-docs -->
### 단계 1.5 구제: 부서지는 엔진 AskUserQuestion + 수리 지점

사용자는 비작업 로컬 엔진 (Garry의 재개발 : `~/.gbrain/config.json`는 죽은 Postgres URL)에 점이 있습니다. 대상 AskUserQuestion BEFORE 2 단계 :

> D# — 당신의 국부적으로 gbrain 엔진은 반응하지 않습니다. 당신이 그것을 고치는 방법?
> Project/branch/task: <one-sentence grounding using detected slug + branch>
> ELI10: gbrain에는 `~/.gbrain/config.json`에 구성이 있습니다 그러나 엔진 그것은 점
> 그것은 도달 할 수 없습니다. 즉 일시적 정전 (Postgres container)
> 중지, 스태프 다운) OR 당신이 포기하고 싶은 stale config. 다른
> 각 경우의 구제.
> 잘못된 것을 선택하면 stakes : "PGLite로 전환"은 기존 구성을 덮어
> (사용자가 실제로 깨진 엔진을 원하면 한 방향 문). "Retry"보존
> 일시적인 경우의 기존 상태.
> 추천: A (레트리) - 항상 싼 옵션을 시도 먼저; 엔진이라면
> 그냥 일시적으로 그것은 어떤 파괴적인 변화없이 다시 올 것이다.
> 참고: 옵션은 다른 종류, 적용되지 않음 - 완전한 점수.
> A) Retry - 엔진 재 조사 (추천; ~80ms)
>   ✅ 가장 싼 시험: 엔진이 뒤 있는지 보기 위하여 재 실행 `gbrain sources list`
>   ✅ Zero 부작용; 기존 구성 보존
>   ❌ 엔진이 영구적으로 죽으면, 영원히 retries; 사용자는 다른 옵션을 선택해야합니다
> B) 로컬 PGLite로 전환 (편도 - 기존 config를 .bak로 이동)
>   ✅ 사용자가 오래된 것을 포기 한 경우 작업 지역 엔진에 가장 빠른 경로
>   ✅ ~30s; 계정 없음; 이 기계에 개인
>   ❌ 파기 - 기존 설정은 ~/.gbrain/config.json.gstack-bak-{ts}로 이동
> C) 뇌 모드 전환 (단계 2 경로 선택기로 계속)
>   ✅ 사용자 선택 경로 1/2/3/4 스크래치에서 재입력
>   ✅ 기존 구성을 명시적으로 새로운 것을 보존합니다.
>   ❌ 사용자가 PGLite에 대한 수리를 원하면 더 긴 흐름
> D) Quit (무엇이 없습니다)
>   ✅ 아니 cons — 이것은 hard-stop 선택입니다
>   ❌ N/A
> 그물: A는 오른쪽 시작 이동입니다; B/C는 명시된 파괴적인 경로입니다; D bails.

**A (레트리)**: `GSTACK_DETECT_NO_CACHE=1` (60s 캐시를 연소하십시오)를 가진 재 실행 `~/.claude/skills/gstack/bin/gstack-gbrain-detect`. 새로운 `gbrain_local_status`가 `ok`인 경우에, 단계 2. 아직도 `broken-db` 또는 `broken-config`인 경우에, 다시 동일한 AskUserQuestion를 불을 붙입니다 (사용자는 다시 선택합니다).

**B (PGLite로 전환)** - 롤백 안전 init 순서 실행 (플랜 D7):

```bash
BACKUP="$HOME/.gbrain/config.json.gstack-bak-$(date +%s)"
mv "$HOME/.gbrain/config.json" "$BACKUP"
# gstack default: voyage-code-3 (1024d) when VOYAGE_API_KEY is set — best for
# code retrieval. Without the key, fall back to gbrain's own auto-selected
# embedding provider chain (OpenAI 1536d when OPENAI_API_KEY is present, etc.).
# Never select gbrain's legacy zeroentropyai recipe for a new brain: the hosted
# API sunsets September 4, 2026 (#2365); the wireup helper warns existing installs.
set --  # flags ride the positional params — unquoted $VAR breaks under zsh word-splitting (#1798)
if [ -n "${VOYAGE_API_KEY:-}" ]; then
  set -- --embedding-model voyage:voyage-code-3 --embedding-dimensions 1024
fi
if ! gbrain init --pglite --json "$@"; then
  # Restore on failure
  mv "$BACKUP" "$HOME/.gbrain/config.json"
  echo "gbrain init failed. Your previous config was restored at $HOME/.gbrain/config.json." >&2
  echo "PGLite directory at ~/.gbrain/pglite/ may be in a partial state — \`rm -rf ~/.gbrain/pglite\` if needed before retrying." >&2
  exit 1
fi
echo "Switched to local PGLite. Previous config saved at $BACKUP — review before deleting."
```

그런 다음 단계 5a (MCP 등록; 새로운 PGLite 엔진은 로컬 스트디오로 등록됩니다).

**C (Switch 뇌 모드)**: 2단계 정상적인 경로 선택기로 계속.

**D (Quit)를 사용하는 경우**: STOP 기술은 청결하게.
