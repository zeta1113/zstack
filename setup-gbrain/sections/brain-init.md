<!-- AUTO-GENERATED from brain-init.md.tmpl — do not edit directly -->
<!-- Regenerate: bun run gen:skill-docs -->
Path-specific. Run ONLY 단계 2에서 선택된 경로에 대한 하위 섹션 (또는 단계 2 선택된 엔진 마이그레이션 때 스위치 흐름).

## Path 1 (Supabase, 기존 URL)

비밀 독서 헬퍼를 소스, URL를 `read -s` + redacted 미리보기로 수집:

```bash
. ~/.claude/skills/gstack/bin/gstack-gbrain-lib.sh
read_secret_to_env GBRAIN_POOLER_URL "Paste Session Pooler URL: " \
  --echo-redacted 's#://[^@]*@#://***@#'
```

그런 다음 구조적으로 검증 :

```bash
printf '%s' "$GBRAIN_POOLER_URL" | ~/.claude/skills/gstack/bin/gstack-gbrain-supabase-verify -
```

확인 종료 코드가 3 (direct-connection URL)인 경우, verifier의 자체 메시지가 수정을 설명합니다. 표면은 세션 풀러 URL를 위해 다시 생성됩니다.

성공에, env var를 통해 gbrain에 손을 (D10, 결코 argv):

```bash
GBRAIN_DATABASE_URL="$GBRAIN_POOLER_URL" gbrain init --non-interactive --json
```

그런 다음 `unset GBRAIN_POOLER_URL GBRAIN_DATABASE_URL` 즉시. URL는 이제 gbrain 자체에 의해 모드 0600에서 `~/.gbrain/config.json`에서 주장됩니다.

## Path 2a (Supabase, 자동 감독 - D7)

D11 PAT 스코프가 저장하는 동사 BEFORE를 보여주기:

> *이 Supabase 개인 액세스 토큰은 전체 read/write/delete 액세스 권한을 부여합니다.
> Supabase 계정의 모든 프로젝트에는 `gbrain`가 아닌, 우리가
> 생성에 대해. Supabase는 현재 범위 토큰을 지원하지 않습니다. 우리는 사용
> 이 PAT만: 1개의 프로젝트를 창조하고, 건강할 때까지 그것을, 읽으십시오
> Session Pooler URL — 그 후 프로세스 메모리에서 삭제합니다. 토큰
> Supabase의 측에 유효하게 유지하면 수동으로 수정
> https://supabase.com/dashboard/account/tokens - 우리는 개정을 추천합니다
> 설정이 완료된 후 즉시.*

다음 :

```bash
. ~/.claude/skills/gstack/bin/gstack-gbrain-lib.sh
read_secret_to_env SUPABASE_ACCESS_TOKEN "Paste PAT: "
```

D17 tier prompt via AskUserQuestion: "Which Supabase tier?" 무료 (2 프로젝트 한계, 7d inactivity 후에 일시 중지) vs Pro ($25/mo, 실제 사용을위한 권장). 계층이 **org 레벨** (관리 API 계약당) 인 경우, 사용자는 현재 계층을 기반으로 org를 선택합니다. Pro는 supabase에서 org를 먼저 업그레이드해야 할 수 있습니다.

리스트 orgs, 선택 하나 (AskUserQuestion 여러 경우):

```bash
orgs=$(~/.claude/skills/gstack/bin/gstack-gbrain-supabase-provision list-orgs --json)
```

`.orgs` 배열이 빈 경우, 표면: "당신의 Supabase 계정은 조직이 없습니다. https://supabase.com/dashboard,에서 하나를 작성한 후 `/setup-gbrain`를 다시 실행하십시오." STOP.

지역 사용자 (기본 `us-east-1`; 유효 값은 Supabase Management API의 18의 enum 값이며, 몇 가지 공통점을 나열하여 전체 목록의 "Other"를 선택합니다.

DB 비밀번호 생성 (사용자에 표시되지 않음):

```bash
export DB_PASS=$(openssl rand -base64 24)
```

SIGINT 트랩 설정 (D12 기본 복구):

```bash
trap 'echo ""; echo "gstack-gbrain: interrupted. In-flight ref: $INFLIGHT_REF"; \
      echo "Resume: /setup-gbrain --resume-provision $INFLIGHT_REF"; \
      echo "Delete: https://supabase.com/dashboard/project/$INFLIGHT_REF"; \
      unset SUPABASE_ACCESS_TOKEN DB_PASS; exit 130' INT TERM
```

+ + 흠을 뚫기:

```bash
result=$(~/.claude/skills/gstack/bin/gstack-gbrain-supabase-provision \
  create gbrain "$REGION" "$ORG_SLUG" --json)
INFLIGHT_REF=$(echo "$result" | jq -r .ref)
~/.claude/skills/gstack/bin/gstack-gbrain-supabase-provision wait "$INFLIGHT_REF" --json
pooler=$(~/.claude/skills/gstack/bin/gstack-gbrain-supabase-provision \
  pooler-url "$INFLIGHT_REF" --json)
GBRAIN_DATABASE_URL=$(echo "$pooler" | jq -r .pooler_url)
export GBRAIN_DATABASE_URL
gbrain init --non-interactive --json
unset SUPABASE_ACCESS_TOKEN DB_PASS GBRAIN_DATABASE_URL INFLIGHT_REF
trap - INT TERM
```

성공 후 PAT 재직 알림을 방출합니다.

> "설정 완료. PAT를 다시 복사
> https://supabase.com/dashboard/account/tokens — 우리는 이미 버려진
> 그것은 기억에서 그것을 다시 필요로 하지 않습니다. gbrain 프로젝트는 계속할 것입니다
> 자체 내장된 데이터베이스 암호를 사용했기 때문에 작업.

## Path 2b (스페인, 설명서)

supabase.com 단계를 통해 사용자를 걸어:
1. https://supabase.com/dashboard에 로그인
2. "New Project"라는 이름을 `gbrain`, 지역을 선택, 생성 복사
   데이터베이스 암호 (당신은 페이스백에 대해 필요? 아니 — 그것은 Pooler URL에 내장되어 있습니다 우리는 다음을 수집합니다)
3. ~2분의 프로젝트를 초기화
4. 설정 → 데이터베이스 → 연결 풀러 → 세션 → 복사 URL (포트
   6543)

그런 다음 동일한 비밀을 따르십시오 + 경로로 + init 흐름을 확인합니다.

## Path 3 (PGLite 로컬)

```bash
# gstack default: voyage-code-3 (1024d) when VOYAGE_API_KEY is set — code
# retrieval beats general-purpose embeddings on real code queries (validated
# A/B). Without the key, gbrain auto-selects (OpenAI 1536d when available).
# Never select gbrain's legacy zeroentropyai recipe for a new brain: the hosted
# API sunsets September 4, 2026 (#2365); the wireup helper warns existing installs.
set --  # flags ride the positional params — unquoted $VAR breaks under zsh word-splitting (#1798)
if [ -n "${VOYAGE_API_KEY:-}" ]; then
  set -- --embedding-model voyage:voyage-code-3 --embedding-dimensions 1024
fi
gbrain init --pglite --json "$@"
```

Done. 네트워크 없음, 비밀 없음 (Vyond Voyage embedding API 호출 중 동기화, `VOYAGE_API_KEY` 설정된 경우 - ~ $0.18 1M 토큰 당, repo 당 pennies).

### Path 4 (레모드 gbrain MCP — HTTP 바이어 토큰과 함께 수송)

다른 기계 (Tailscale, ngrok, 내부 LAN, 또는 팀메이트의 서버)에 뇌가 실행되는 사용자를 위해. 로컬 gbrain CLI 설치 없음, 로컬 DB. 이 기술은 원격 MCP 및 중지를 기록합니다. 뇌 호스트에 ingestion + 색인이 발생합니다.

**4a. MCP URL를 수집합니다.** 사용자를 Prompt:

```
Paste your gbrain MCP URL (e.g. https://wintermute.tail554574.ts.net:3131/mcp):
```

`read -r` (비밀 위생이 필요하지 않음 - URL 혼자는 credential이 아닙니다). 유효하다 `https://` (무선 호스트에 대한 TLS 필요); 비-localhost에 대한 `http://`를 거부합니다.

**4b. 비밀 보행 돕기 (D10, 절대 argv)를 통해 곰기 토큰을 수집합니다.**

```bash
. ~/.claude/skills/gstack/bin/gstack-gbrain-lib.sh
read_secret_to_env GBRAIN_MCP_TOKEN "Paste bearer token: " \
  --echo-redacted 's/.\{6\}$/***REDACTED***/'
```

**4c. gstack-gbrain-mcp-verify를 통해 검증합니다.** Run the helper; capture the classified JSON output:

```bash
verify_json=$(GBRAIN_MCP_TOKEN="$GBRAIN_MCP_TOKEN" \
  ~/.claude/skills/gstack/bin/gstack-gbrain-mcp-verify "$MCP_URL")
status=$(echo "$verify_json" | jq -r .status)
```

`status != "success"`인 경우, 돕는 이미 NETWORK/ AUTH/ MALFORMED로 실패를 분류하고 원라인 구제 힌트를 방출했습니다. `error_text`와 **STOP**에서 원시 오류를 상기시키면, /setup-gbrain" 메시지가 명확하게 "fix와 re-run /setup-gbrain"로 NOT가 실패한 것으로 5a를 계속합니다. 부분 등록은 반 깨진 상태로 사용자를 떠날 것입니다.

downstream 단계에 대한 검증 출력에서 두 값을 캡처:
- `SERVER_VERSION` (예: `0.27.1`) - 단계 8에 CLAUDE.md 구획에 기록했습니다.
- `URL_FORM_SUPPORTED` (`true|false`) - `gstack-artifacts-init`로 전달
  7 단계 뇌 관리자 Hookup 명령의 형태를 제어하는 것은 인쇄됩니다.

**4d. (Path 4) 코드 검색에 대한 로컬 PGLite 제공.** 플랜 당 D10/D11, 요청:

> D# — 이 기계에서 기호 인식 코드 수색을 원합니까?
> Project/branch/task: <one-sentence grounding using detected slug + branch>
> ELI10: `<MCP_URL>`에 먼 뇌는 교차 기계 지식,
> 하지만 `gbrain code-def`/ `code-refs`/ `code-callers`와 같은 상징 쿼리는 필요
> THIS 기계의 코드의 국부적으로 색인. 우리는 작은 고립된 PGLite를 회전해서 좋습니다
> 데이터베이스 (~30 초, 계정 없음, ~120 MB 디스크) 코드만, 별도
> 당신의 원격 뇌에서. Transcripts와 artifacts는 계속 routing를 통해
> 원격 뇌에 대한 artifacts repo - 로컬 PGLite는 코드 전용을 유지합니다.
> Stakes: 그것없이, semantic 코드는 이 repo의 worktrees 가을에 검색
> Grep로 돌아가기.
> 추천: A — 30 초, 지속적인 비용, 기호 도구를 잠금 해제.
> 완충: A=10/10 (완전한 쪼개는 엔진), B=7/10 (remote-only).
> A) 예, 코드에 대한 로컬 PGLite 설정 (추천)
>   ✅ `gbrain code-def`, `code-refs`, `code-callers`를 worktree 당 자물쇠로 엽니다
>   ✅ 독립적 인 엔진 - 원격 뇌를 방해하지 않거나 성적표를 공유하지 않습니다.
> B) 아니, 먼 MCP 단지
>   ✅ 제로 로컬 상태 — `~/.claude.json` MCP 등록
>   ❌ 기호 코드 쿼리는 이 repo의 worktrees에서 Grep로 돌아갑니다
> 그물: A = 가득 차있는 쪼개는 엔진; B = 리모트 전용.

**(예)**: 롤백 안전 세망 (D7)를 가진 + init 국부적으로 PGLite를 설치하십시오:

```bash
~/.claude/skills/gstack/bin/gstack-gbrain-install || exit $?
# At this point the local gbrain CLI is on PATH. Init PGLite, but back up any
# existing ~/.gbrain/config.json first (rollback if init fails).
if [ -f "$HOME/.gbrain/config.json" ]; then
  BACKUP="$HOME/.gbrain/config.json.gstack-bak-$(date +%s)"
  mv "$HOME/.gbrain/config.json" "$BACKUP"
fi
# gstack default for local code-search PGLite: voyage-code-3 (1024d) when
# VOYAGE_API_KEY is set. It wins the A/B over voyage-4-large and OpenAI
# text-embedding-3-large on this codebase's symbol queries. Falls back to
# gbrain's auto-selected provider when the key isn't present.
set --  # flags ride the positional params — unquoted $VAR breaks under zsh word-splitting (#1798)
if [ -n "${VOYAGE_API_KEY:-}" ]; then
  set -- --embedding-model voyage:voyage-code-3 --embedding-dimensions 1024
fi
if ! gbrain init --pglite --json "$@"; then
  if [ -n "${BACKUP:-}" ] && [ -f "$BACKUP" ]; then mv "$BACKUP" "$HOME/.gbrain/config.json"; fi
  echo "gbrain init failed. Existing config (if any) was restored. PGLite at ~/.gbrain/pglite/ may be in a partial state — \`rm -rf ~/.gbrain/pglite\` to reset." >&2
  echo "Continuing setup without local code search; you can re-run /setup-gbrain to retry." >&2
fi
```

그런 다음 5a 단계로 계속됩니다. 5a의 원격 http MCP 등록은 오늘부터 실행됩니다. 로컬 PGLite는 MCP 등록 (Claude Code는 쿼리에 대한 MCP를 통해 원격 두뇌에 이야기합니다. `gbrain` CLI는 code-def/refs/callers).를 위한 로컬 PGLite에 이야기합니다.

**B (아니)**: 설치 + init를 건너 뛰십시오. 국부적으로 엔진은 absent를 체재합니다. `gbrain_local_status`는 `missing-config` (또는 `no-cli` 만약 gbrain가 설치되지 않는 경우에) 일 것입니다. `/sync-gbrain`는 계획 D12 당 코드 단계 청결하게 할 것입니다.

**4e. B가 선택되었을 때 3, 4 (다른 경로) 및 5 (현지 의사)를 건너 뛰십시오.** A가 선택되었을 때, 3 단계 이미 ran (gstack-gbrain-install)과 4 단계 이미 ran (`gbrain init --pglite`를 통해)를 얻었다. 5a 단계로 똑바로 점프. B가 선택되었을 때, 단계 3/4/5는 no-ops; 또한 계획 D11 당 원격 http 형태에 있는 artifacts 파이프라인을 통해서 기억 단계 노선을 통해 단계 7.5 (문자 ingest)를 건너 뛰기.

Bearer 토큰 (`GBRAIN_MCP_TOKEN`)은 단계 5a의 `claude mcp add --header`가 그것을 소비할 때까지 프로세스 env에 머물; 그 다음 `unset GBRAIN_MCP_TOKEN` 즉시. 토큰 보안 거래 오프 `setup-gbrain/memory.md`: `claude mcp add` 동안 노출을 간단히 말하면 나머지 상태는 `~/.claude.json` 모드 0600입니다.

## 스위치 (감시의 기존 엔진 상태에서)

```bash
# Going PGLite → Supabase, collect URL first (Path 1 flow), then:
timeout 180s gbrain migrate --to supabase --url "$URL" --json
# Going Supabase → PGLite:
timeout 180s gbrain migrate --to pglite --json
```

`timeout`가 124(시간아웃에 대한 일반적인 코드)를 반환하면, D9 메시지("Migration은 3분 안에 완료되지 않았습니다. gstack 세션은 소스 뇌에서 잠금을 유지할 수 있습니다. 다른 작업 공간과 재 실행 `/setup-gbrain --switch`. 당신의 원래 뇌는 비접촉되지 않습니다."). STOP.
