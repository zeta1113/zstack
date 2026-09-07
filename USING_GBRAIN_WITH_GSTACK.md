# Using GBrain with GStack

당신의 코딩 에이전트, 메모리와 함께 실제로 유지.

[GBrain](https://github.com/garrytan/gbrain)는 AI 에이전트을 위해 디자인된 지속적인 지식 기초입니다. 그것은 당신이 결정한 무슨, 무슨 일하고 무엇, 하지 않았다 무엇이건, 그리고 요구에 그것 전부를 찾아내는 에이전트을 저장합니다. GStack는 0에서 "gbrain가 달리고, 나의 에이전트은 그것을 부를 수 있습니다" - 시험 지역, 공유하에 당신 팀, 그리고 사이 모든 것을 몫으로 갖춰집니다.

이것은 전체 monty입니다: 모든 시나리오, 모든 플래그, 모든 돕기 궤, 모든 문제 해결 단계. 빠른 피치에 대 한, [README의 GBrain 단면도](README.md#gbrain--persistent-knowledge-for-your-coding-agent)를 참조하십시오. 오류 코드 및 동기화 특정 문제를 위해, [docs/gbrain-sync.md](docs/gbrain-sync.md)를 참조하십시오.

---

## 한컴파일 설치

```bash
/setup-gbrain
```

즉, 기술이 현재 상태를 감지하고, 3 가지 질문을 가장 많이 묻고, 설치를 통해 당신을 걸어, init, MCP 등록을 통해 Claude Code, 그리고 per-repo 신뢰 정책. 5 분 미만의 완료를 설치하지 않는 깨끗한 Mac에서. Mac에서 이미 설정 한 몇 초 (그는 기존 상태와 건너뛰기 작업을 감지).

## 설치 후 얻을 것

`/setup-gbrain` 끝이면 코딩 에이전트는 앞에 없었던 두 가지의 리트리발 표면을 가지고 있습니다.

- **이 repo에서 Semantic 코드 검색.** `gbrain search "browser security canary"`는 랭크된 파일 지구를, 정확하게 잡아 당기는 grep를 돌려보냅니다. `gbrain code-def`, `code-refs`, `code-callers`, `code-callees`는 기호에 의하여 호출 도표를 걸었습니다 — 당신이 이 파일을 붙들지 않는 것을 알게 되었는지 알게 될 때 유용합니다. 에이전트은 그랩에 이을 때 semantic; CLAUDE.md는 그것을 여정 규칙 가르침을 가르칩니다 `## GBrain Search Guidance` 구획을 가져옵니다.
- **교차 기억.** 계획, 복고풍, 결정, 그리고 과거 세션에서 학습은 `~/.gstack/` 에서 살고 (당신이 sync에 선택된 경우) 개인 git repo gbrain 색인에 밀어. `gbrain search "what did we decide about auth?"` 실제로 모든 세션을 재검토 대신 이전 CEO 계획을 발견.

또한 원격 MCP (아래 4장)을 활성화하면 다른 컴퓨터가 쓰기 할 수있는 공유 뇌 서버에 뇌 쿼리 경로 - 노트북, 데스크탑 및 팀메이트의 기계 모두 같은 메모리를 볼 수 있습니다.

## 네 경로

기술이 "당신의 두뇌가 살아야?"라고 묻을 때 하나를 선택하면됩니다.

### Path 1: Supabase, 당신은 이미 연결 문자열이 있습니다

가장 좋은 : 당신은 (또는 팀메이트의 클라우드 에이전트) 이미 Supabase 뇌를 제공하고 동일한 데이터를 사용하는이 로컬 기계를 원합니다.

**어떤 일이 발생:** 세션 풀러 URL (설정 → 데이터베이스 → 연결 풀러 → 세션 → 복사 URI, 포트 6543)를 붙여 넣으십시오. 이 기술은 echo를 읽고, redacted 미리보기 (`aws-0-us-east-1.pooler.supabase.com:6543/postgres` — 호스트가 눈에 보이는 암호로 덮여)를 보여 주며 `gbrain init` 환경 변수를 통해 URL를 통해 `gbrain init`를 읽습니다. URL는 argv 또는 쉘에 기록되지 않습니다.

**신뢰 경고:** 이 URL는 공유된 뇌의 모든 페이지에 대한 귀하의 로컬 Claude Code 전체 읽기/write 액세스를 제공합니다. 원하는 신뢰 수준이 아닌 경우, PGLite 로컬 (Path 3)를 선택하고 뇌를 떼어내십시오.

### Path 2a: Supabase, 새로운 프로젝트 자동 감독

가장 좋은 : 신선한 Supabase 계정, 당신은 0 클릭으로 깨끗한 새로운 프로젝트를 원합니다.

**어떤 일이 발생:** Supabase 개인 액세스 토큰 (PAT)을 붙여 넣으십시오. 기술은 범위를 공개합니다. 먼저 *token는 Supabase 계정에서 모든 프로젝트에 대한 전체 액세스를 부여하고, 우리가 만드는 것에 대해 이야기하지 않습니다.*. 그것은 조직을 나열, 하나와 어느 지역 (default `us-east-1`), 데이터베이스 암호를 생성, `POST /v1/projects`, 프로젝트가 `ACTIVE_HEALTHY` (180s timeout)까지 5 초마다 `GET /v1/projects/{ref}`를 투표, 풀러 URL, `gbrain init`에 손을 잡습니다. 종료 : ~90 초.

끝에: PAT https://supabase.com/dashboard/account/tokens.에서 PAT를 새롭게 하기 위하여 명시된 알림은 기억에서 그것을 쫓아냅니다.

**만약 Ctrl-C 중간 프로비저닝:** SIGINT 트랩은 인프라이트 프로젝트 ref + 이력서 명령을 인쇄합니다. Supabase 대시보드에서 orphan를 삭제하거나 `/setup-gbrain --resume-provision <ref>`를 실행하여 왼쪽으로 픽업하십시오.

### Path 2b: Supabase, 수동으로 만듭니다

가장 좋은 : PAT를 통해 supabase.com을 통해 PAT를 붙여 넣기보다는 충분합니다.

**어떤 일이 발생:** 기술은 4개의 수동 단계 (신호 → 새로운 프로젝트 → 대기 ~2 분 → 복사 세션 풀러 URL)를 통해 당신을, 그 후에 길 1의 풀 단계에서 가지고 갑니다. 경로 1로 동일한 안전 처리.

### Path 3: PGLite 현지

베스트 : 시도 - 우선, no 계정, no 클라우드, no 공유. 또는 모든 클라우드 에이전트에서 고립 된 전용 "이 맥의 두뇌".

**어떤 일이 발생:** `gbrain init --pglite`. `~/.gbrain/brain.pglite`에서 뇌 생활. No 네트워크 호출은 init 자체에. 30 초에 있는 단 하나.

**모형을 엠베딩.** `VOYAGE_API_KEY`가 설정되면 gstack는 `voyage-code-3` (1024-dim)와 PGLite - Voyage의 코드 특수 embedding 모델로 일반 목적 `voyage-4-large`과 OpenAI `text-embedding-3-large` 이 코드베이스의 상징 쿼리에 머리에 닿을 수 있습니다. `VOYAGE_API_KEY` 없이, gbrain 자동 선택 (OpenAI 1536->는 현재 그 중 하나가 될 때, 그 중에는 현재는 그 중에는 현재는 그 중에는 현재는 그 중에는 현재는 그 중에는 현재는 약 1만 개가 있습니다. 어느 방법, embeddings는 sync 도중 선택된 공급자의 API에  부르습니다 - 당신이 `/sync-gbrain`를 달리기 전에 원하는 공급자를 위한 열쇠를 놓으십시오.

이것은 당신이 단지 구름에 투입하기 전에 어떤 gbrain 느낌을 보는 것을 보고 싶은 경우에 제일 첫번째 선택입니다. 당신은 `/setup-gbrain --switch`로 나중에 항상 migrate 할 수 있습니다.

### 경로 4: 먼 gbrain MCP (분쇄 엔진)

최고의: 당신의 두뇌는 다른 기계에 실행 (Tailscale, ngrok, 내부 LAN) 또는 팀 동료의 서버. 당신은 지역 데이터베이스를 서 있지 않고 크로스 기계 메모리 혜택을 원하고, 여전히이 Mac에서 기호 인식 코드 검색을 원합니다.

**어떤 일이 발생:** URL (예: `https://wintermute.tail554574.ts.net:3131/mcp`)와 곰수기 토큰을 붙여 넣으십시오. 기술은 철사에 URL를, 기록합니다 사용자 범위에 `~/.claude.json`에서 MCP로 gbrain를, 그리고 코드 수색 (30 초, ~120 MB 디스크)를 위한 작은 국부적으로 PGLite를 서 있는, 그리고 제안합니다.

로컬 PGLite를 수락하면 **Split-engine 모드**에서 끝납니다.

- **Brain/context 쿼리** (`mcp__gbrain__search`, `mcp__gbrain__query`, `mcp__gbrain__get_page`) 리모트 MCP에 노선. 계획, 복고풍, 학습, 크로스 머신 메모리 — 모두 공유 서버.
- **코드 쿼리** (`gbrain code-def`, `code-refs`, `code-callers`, `code-callees`, `gbrain search` 코드) 를 로컬 PGLite로 경로로 로컬 PGLite로 변환합니다. 로컬로 색인을 붙인, 빠른, 기계를 결코 나타냈습니다.

두 엔진은 독립적입니다. 로컬 PGLite를 Wiping 원격 뇌를 터치하지 않습니다. 원격 MCP Bearer를 회전은 로컬 코드 검색에 영향을 미치지 않습니다. 또한 원격 뇌 관리자가 (또는 반드시)를 색인 할 수 없다면 올바른 구성입니다. 개발자의 체크 아웃 - 로컬 코드는 로컬에 머물 수 있습니다.

## MCP Claude Code 등록

default 기술에 의해 "Give Claude Code gbrain의 유형 도구 표면?"를 묻습니다. yes, 그것은 실행합니다.

```bash
claude mcp add gbrain -- gbrain serve
```

즉, Claude 코드가 있는 gbrain's stdio MCP 서버를 등록합니다. 이제 `gbrain search`, `gbrain put`, `gbrain get`, 등은 각 세션에서 일류 도구로 표시되어 bash shell-outs가 아닙니다.

**`claude`가 PATH에 있지 않다면**, 기술은 수동 등록힌트로 MCP 등록을 확립합니다. CLI 결의자는 `gbrain` - MCP가 격상하지 않는 어떤 기술든지에서 아직도 작동됩니다.

**다른 지역 에이전트** (Cursor, Codex CLI, 등)는 그들의 자신의 MCP 등록을 필요로 합니다. 기술은 v1를 위해 Claude-Code-targeted입니다; 다른 주인은 그들의 자신의 MCP 구성에서 `gbrain serve` 수동으로 등록할 수 있습니다.

## Per-remote 신뢰 정책 (삼각)

기계에 각 repo는 정책 결정이 납니다: **읽기**, **read-only**, 또는 **deny**.

- **읽기** - 에이전트는 `gbrain search`이 repo의 context AND가 뇌로 돌아오는 새 페이지를 작성할 수 있습니다. Default는 자신의 프로젝트에 대해.
- **read-only** - 에이전트는 뇌를 검색 할 수 있지만이 repo의 세션에서 새 페이지를 작성하지 않습니다. 멀티 클라이언트 컨설턴트에 이상적입니다. 공유 두뇌를 검색하고 클라이언트 A의 코드를 사용하여 오염시키지 마십시오. 클라이언트 B의 repo.
- **deny** — no gbrain 상호 작용. repo는 gbrain 장식새김에 보이지 않습니다.

기술이 repo 당 한 번에 묻습니다. gstack 기술을 실행하는 첫 번째 시간. 결정이 끈적한 후 - 동일한 git 리모트의 각 worktree + branch는 동일한 정책을 공유하므로 한 번 설정하고 다음을 수행합니다.

SSH와 HTTPS 먼 변종은 동일한 열쇠에 붕괴합니다: `https://github.com/foo/bar.git`와 `git@github.com:foo/bar.git`는 동일한 repo입니다.

**정책 변경:**

```bash
/setup-gbrain --repo      # re-prompt for this repo only

# Or directly:
~/.claude/skills/gstack/bin/gstack-gbrain-repo-policy set "github.com/foo/bar" read-only
```

**모든 정책 보기:**

```bash
~/.claude/skills/gstack/bin/gstack-gbrain-repo-policy list
```

저장: `~/.gstack/gbrain-repo-policy.json`, 형태 0600의 schema-versioned 그래서 미래 이동은 세례를 체재합니다.

## `/sync-gbrain`로 뇌 전류 유지

`/setup-gbrain`는 1회 온보드입니다. `/sync-gbrain`는 이 repo의 코드에 신선한 변화를 볼 수 있도록 gbrain를 원할 때마다 실행되는 동사입니다.

```bash
/sync-gbrain                # incremental: mtime fast-path, ~seconds on a clean tree
/sync-gbrain --full         # full reindex (~25-35 minutes on a big Mac)
/sync-gbrain --code-only    # only the code stage; skip memory + brain-sync
/sync-gbrain --dry-run      # preview what would sync; no writes
```

기술은 세 단계가 실행됩니다. 코드, 메모리, 두뇌 동기화 - 독립적으로. 실패는 다른 사람을 차단하지 않습니다. 상태는 `~/.gstack/.gbrain-sync-state.json`로 작동하므로 다시 실행은 깨끗하게 선택합니다.

데이터 오프 머신 (code sync into a possibly-remote gbrain DB, 메모리 ingest, 뇌 동기화 push) 각 쓰기 a tamper-evident 영수증을 egress ledger (`~/.gstack/security/egress.jsonl`) 전송 하기 전에, 실패 닫히는: 영수증을 작성할 수 없는 경우에, 단계는 `EGRESS_RECEIPT_FAILED` 대신 동기화 비결. 수정은 보통 `mkdir -p ~/.gstack/security && chmod -R u+w ~/.gstack/security`, 그 후에 다시 `gstack-egress list`를 다시 검사합니다. 영수증을 가진 영수증을 가진 `EGRESS_RECEIPT_FAILED`.

**신선한 worktree에 무엇을:**

1. **사전 기쁨.** `gbrain_local_status` (지방 엔진의 건강)를 검사합니다. 엔진이 `broken-db` 또는 `broken-config`인 경우, 재약 메뉴를 가진 기술 STOPs - 그것은 침묵하게 degrade를 거부합니다. 국부적으로 엔진이 누락되고 당신은 리모트에서 인 경우에MCP 형태 (Path 4), 코드 단계 SKIPs는 청결하게 그리고 뇌 sync 뛰기만 실행합니다.
2. **코드 단계.** `gbrain sources add`를 통해 증식된 근원으로 cwd를 기록하고 `.gbrain-source` 핀 파일을 repo 루트 (kubectl-style context — 각 worktree는 그것의 자신의 핀을, 그래서 지휘자 sibling worktrees는 콜드를 씁니다), 달립니다 `gbrain sync --strategy code`를 기록합니다.
3. **기억 단계.**는 `~/.gstack/` 성적표 + curated 기억을 단계로 합니다. 로컬 스트로디 MCP 형태에서, 국부적으로 엔진으로 소화합니다. 원격 http MCP 형태에서는, 원격 뇌 관리자의 pull 파이프라인을 위해 `~/.gstack/transcripts/run-<pid>-<ts>/`에 단계로 감속을 주장합니다. 섭취 시간은 default에 의하여 30 분입니다; `GSTACK_INGEST_TIMEOUT_MS` (`GSTACK_INGEST_TIMEOUT_MS`를 가진 큰 두뇌를 위해 올리십시오, 대신에 `GSTACK_INGEST_TIMEOUT_MS` (-24/>를 재기하십시오)는, 이렇게, 다음 분기 검사를 통해, 이렇게 주의합니다.
4. **뇌 동기화 단계.** curated artifacts (계획, 디자인, 복고풍)을 개인의 artifacts repo에 밀어넣습니다.
5. **CLAUDE.md 지도.** Capability-checks the round-trip (page → search → find it). 녹색 경우 프로젝트의 CLAUDE.md에 `## GBrain Search Guidance` 블록을 쓰십시오. 빨간색 경우, REMOVES 블록 - 에이전트가 설치되지 않는 도구를 사용하지 말아야합니다.

**워터 마크.** Sync 상태는 commit 해시로 전진합니다. gbrain가 파일 당 5 MB 단단한 한계를 색인할 수 없는 경우에, 또는 파일에 의하여 사라진 중간 동기화), 워터마크는 뒀고 그 후에 동기화 재기합니다. 비접촉 실패를 인식하고 그것을 지나서 움직이기 위하여:

```bash
gbrain sync --source <source-id> --skip-failed
```

재 실행 가능, idempotent, 같은 기계 (`~/.gstack/.sync-gbrain.lock`에 잠금)에 여러 터미널에서 실행하는 안전.

## 전환 엔진 나중에

PGLite를 선택하고 이제 팀 두뇌에 가입하고 싶습니까? 한 개의 명령:

```bash
/setup-gbrain --switch
```

The skill runs `gbrain migrate --to supabase --url "$URL"` wrapped in `timeout 180s`. Migration is bidirectional (Supabase → PGLite also works) and lossless — pages, chunks, embeddings, links, tags, and timeline all copy. Your original brain is preserved as a backup.

**이동이 걸려있는 경우:** 또 다른 gstack 세션은 소스 뇌에 잠금을 붙들 수 있습니다. 행동 메시지로 3 분 동안의 타임 아웃 화재. 다른 작업 공간과 재 실행을 닫습니다.

## GStack 메모리 동기화 (별한 관심사)

이것은 gbrain 자체와 다릅니다. gstack state (`~/.gstack/` - 학습, 계획, 복고풍, 타임 라인, 개발자 프로파일)는 기본적으로 기계 로컬입니다. "GStack 메모리 동기화" 옵션으로 curated, secret-scanned subset to the private git repo so your memory follow you follow machine — and, if you're running gbrain, that git repo indexable.

그것을 켜기:

```bash
gstack-artifacts-init
```

한 번의 개인 정보 보호 프롬프트를 얻을 것이다: **모든 수당** / **artifacts만** (계획, 디자인, 복고풍, 학습 - 타임라인과 같은 건너뛰기 데이터) / **off**. 모든 기술은 시작과 끝에서 큐를 동기화합니다. no daemon, no 배경 프로세스.

비밀 모양 내용 (AWS 키, GitHub 토큰, PEM 블록, JWTs, Bearer 토큰)는 기계가 나기 전에 동기화에서 차단됩니다.

**새로운 기계에:** 복사 `~/.gstack-artifacts-remote.txt` (법률 `~/.gstack-brain-remote.txt` 이름은 여전히 작동), `gstack-brain-restore`를 실행하고, 어제의 노트북에 표면을 학습합니다.

전체 가이드 : [docs/gbrain-sync.md](docs/gbrain-sync.md). 오류 인덱스 : [docs/gbrain-sync-errors.md](docs/gbrain-sync-errors.md).

`/setup-gbrain`는 초기 설정 끝에 당신을 위해 이것을 철사에 제안합니다 — 그것은 1개 더 AskUserQuestion이고, 동일한 개인 저장소 인프라와 통합합니다.

## 클린업 orphan 프로젝트

Ctrl-C의 중간 감독이면, 하나에 설정하기 전에 세 가지 다른 이름을 시도하거나 그렇지 않으면 gbrain 모양의 Supabase 프로젝트를 축적하면 사용되지 않습니다. 그에 대한 하위 command가 있습니다.

```bash
/setup-gbrain --cleanup-orphans
```

PAT (일회, 후 버려진), Supabase 계정에서 모든 프로젝트를 `gbrain`로 시작하며 ref가 활성화되지 않는 `~/.gbrain/config.json` 풀러 URL로 나옵니다. 각 orphan를 위해, 프로젝트 당 *"Delete orphan 프로젝트 `<ref>` (`<name>`, `<date>`)를 생성합니까?* — no 배치, no "모든" 단축키를 요청합니다. 뇌관은 결코 유효하지 않습니다.

## 명령 + 플래그 참조

## `/setup-gbrain` 입력 모드

| 의논하기 | 역할 |
|---|---|
| `/setup-gbrain` | 가득 차있는 교류: 국가, 선택 경로, 설치, init, MCP, 정책, 선택적인 기억 sync를 검출하십시오 |
| `/setup-gbrain --repo` | 현재 repo에 대한 per-remote trust policy을 플러시 |
| `/setup-gbrain --switch` | 엔진(PGLite ↔ Supabase)을 재회하지 않고 다른 단계 |
| `/setup-gbrain --resume-provision <ref>` | 오염 중에 중단 된 path-2a 자동 감독을 재량 |
| `/setup-gbrain --cleanup-orphans` | 목록 + orphan의 프로젝트 삭제 Supabase 프로젝트 |

## 빈 돕기 (스크립팅을 위해)

| Bin | 의논하기 |
|---|---|
| `gstack-gbrain-detect` | JSON: PATH, version, config engine, doctor status, sync mode에 gbrain로 현재 상태를 이동 |
| `gstack-gbrain-install` | 검출 첫번째 설치기 (probes `~/git/gbrain`, `~/gbrain`, 그 후에 신선한 복제). 있습니다 `--dry-run` 및 `--validate-only` 깃발. PATH 그림자 체크 출구 3와 재약 메뉴. |
| `gstack-gbrain-lib.sh` | 소스가 실행되지 않습니다. `read_secret_to_env VARNAME "prompt" [--echo-redacted "<sed-expr>"]` 제공 |
| `gstack-gbrain-supabase-verify` | 구조 URL 체크. 출구 3로 직접 연결 URL (`db.*.supabase.co:5432`)를 거부합니다. |
| `gstack-gbrain-supabase-provision` | 관리 API 포장공. Subcommands: `list-orgs`, `create`, `wait`, `pooler-url`, `list-orphans`, `delete-project`. 모두 env에 `SUPABASE_ACCESS_TOKEN`를 요구합니다. `create` 및 `pooler-url`는 또한 `DB_PASS`를 요구합니다. `--json` 형태는 각 subcommand에 유효합니다. |
| `gstack-gbrain-repo-policy` | 퍼-레모드 신뢰 삼대. 서브콤마드: `get`, `set`, `list`, `normalize` |
| `gstack-gbrain-source-wireup` | `gbrain sources add` + `git worktree`를 통해 gbrain로 repo 뇌 repo를 기록한 다음 초기 `gbrain sync`를 실행합니다. Idempotent. V1.12.x. 플래그에서 죽은 `consumers.json + /ingest-repo` HTTP wireup을 대체하십시오: `--strict`, `--source-id <id>`, `--no-pull`, `--uninstall`, `--probe`. |

### gbrain CLI (상류 도구)

그 gstack 포장과 함께 그 자체 배를 .

| Command | 의논하기 |
|---|---|
| `gbrain init --pglite` | PGLite 뇌를 초기화 |
| `gbrain init --non-interactive` | env (`GBRAIN_DATABASE_URL` 또는 `DATABASE_URL`)를 통해 초기화하십시오. argv로 URL를 전달하지 마십시오. 그것은 포탄 역사에 누출할 것입니다. |
| `gbrain doctor --json` | 건강 검사. '{status: "ok"를 반환합니다.|"워닝"|"error", 건강_score: 0-100, 체크: [...]}` |
| `gbrain migrate --to supabase --url ...` | PGLite 뇌를 Supabase로 이동 (손실, 백업으로 소스 보존) |
| `gbrain migrate --to pglite` | 역동적 인 |
| `gbrain search "query"` | 뇌를 검색 |
| `gbrain put "<slug>" --content "<markdown-with-frontmatter>"` | `--content` 안쪽에 YAML frontmatter에서 페이지 (title/tags 가십시오)를 씁니다 |
| `gbrain get "<slug>"` | 을 읽다 |
| `gbrain serve` | MCP stdio 서버 시작 (`claude mcp add`에 의해 사용) |

### Config 파일 + 국가

| Path | 어떤 삶 |
|---|---|
| `~/.gbrain/config.json` | 엔진 (pglite/postgres), 데이타베이스 URL 또는 경로, API 열쇠. 형태 0600. `gbrain init`에 의해 작성. |
| `~/.gstack/gbrain-repo-policy.json` | 퍼-레모드 신뢰. Schema v2. 모드 0600. |
| `~/.gstack/.setup-gbrain.lock.d` | 동시 실행 자물쇠 (원뿔 mkdir). 정상 출구 + SIGINT에 풀어 놓습니다. |
| `~/.gstack/.brain-queue.d/` | gstack 메모리 동기화에 대한 sync 레코드를 종료 - maildir-style spool, 레코드 당 하나의 파일. 이전 릴리스에서 레거시 `.brain-queue.jsonl`는 다음 배수구에서 자동으로 마이그레이션합니다. |
| `~/.gstack/.brain-last-push` | 마지막 동기화의 타임 스탬프 push (`/health` 득점용) |
| `~/.gstack-artifacts-remote.txt` | URL 의 gstack 기억 sync 리모트 (기계 사이 복사하기 위하여 안전; 유산 이름 `~/.gstack-brain-remote.txt`는 아직도 읽었습니다) |
| `~/.gstack/.setup-gbrain-inflight.json` | 미래 `--resume-provision` 지속된 상태 |

## 환경 변수

| 의 특징 | 그것은 어디에 읽는 | 역할 |
|---|---|---|
| `SUPABASE_ACCESS_TOKEN` | `gstack-gbrain-supabase-provision` | PAT 관리 API 호출. 각 설정 실행 후 삭제. |
| `DB_PASS` | `gstack-gbrain-supabase-provision` (창조, 풀러 URL) | DB 암호를 생성. argv에서 절대로. |
| `GBRAIN_DATABASE_URL` | `gbrain init`, `gbrain doctor`, 등. | Postgres 연결 문자열 (Supabase pooler URL for us). Env는 `~/.gbrain/config.json`를 통해 우선적으로 걸립니다. |
| `DATABASE_URL` | `gbrain init` (폴백) | `GBRAIN_DATABASE_URL`와 같은 semantics; 두번째를 검사하십시오. |
| `SUPABASE_API_BASE` | `gstack-gbrain-supabase-provision` | 관리 API 호스트를 무시합니다. 테스트에 의해 사용해, 모네 서버에서 포인트를 가집니다. |
| `GBRAIN_INSTALL_DIR` | `gstack-gbrain-install` | 오버라이드 default 설치 경로 (`~/gbrain`) |
| `GSTACK_HOME` | 모든 bin 돕기 | Override `~/.gstack` 상태 디디. 무거운 시험 사용. |
| `VOYAGE_API_KEY` | `gbrain embed` 이하 처리; gstack PGLite init | 설정할 때 gstack inits PGLite 와 `voyage-code-3` (1024-dim), Voyage's code-specialized embedding model. Beats `voyage-4-large` 과 OpenAI `text-embedding-3-large` 이 codebase의 기호 쿼리에 머리에 머리에 머리에 머리에 머리에. A/B v1.43.1.0 을 참조하십시오. |
| `OPENAI_API_KEY` | `gbrain embed` 하위처리 | `gbrain sync` / `/sync-gbrain` `VOYAGE_API_KEY`가 설정되지 않을 때 `gbrain sync`/ `/sync-gbrain` 도중 embeddings를 위해 사용하는 (gbrain's 자동 선택된 fallback, `text-embedding-3-large` 1536-dim). 열쇠 없이, 페이지는 구조상으로 수입됩니다 (symbol 테이블, 펑크) 그러나 semantic 수색 degrades — 당신은 동기화 로그에 있는 `[gbrain] embedding failed for code file ...`를 볼 것입니다. |
| `ANTHROPIC_API_KEY` | `claude-agent-sdk`, 유료 evals | `bun run test:evals` 및 `query()`에 대한 호출을 위해 필요한 경우. |
| `GSTACK_OPENAI_API_KEY` | `lib/conductor-env-shim.ts` | 도체 주사된 fallback. canonical 이름이 빈 때 `OPENAI_API_KEY`로 승진했습니다. |
| `GSTACK_ANTHROPIC_API_KEY` | `lib/conductor-env-shim.ts` | Anthropic의 위와 같은 패턴. |

## 지휘자 + GSTACK_* env vars

If you run gstack inside a [의 GSM](https://conductor.build) workspace, **도체는 명시적으로 작업 공간 env에서 `ANTHROPIC_API_KEY`와 `OPENAI_API_KEY`를 벗깁니다.** Setting them in `~/.zshrc` or `.env` won't help — the strip happens after env inheritance. To get a usable API key into a workspace, set `GSTACK_ANTHROPIC_API_KEY` and `GSTACK_OPENAI_API_KEY` in Conductor's workspace env config instead. Conductor passes those through untouched.

`lib/conductor-env-shim.ts`는 gstack 측에 간격을 다리를 칩니다: 측 효력 (`import "../lib/conductor-env-shim";`)로 수입될 때, 그것은 canonical 이름을 볼지 않는 어떤 subprocess든지를 위한 `GSTACK_FOO_API_KEY`를 승진시킵니다. shim는 이미로 타전됩니다:

- `bin/gstack-gbrain-sync.ts` — 그래서 `/sync-gbrain`는 embeddings를 위한 OpenAI를 위로 줍습니다
- `bin/gstack-model-benchmark` — 그래서 `--judge`는 수동 env mapping 없이 작동을 달립니다
- `scripts/preflight-agent-sdk.ts` — 이렇게 유료 비율 auth 조사 일
- `test/helpers/e2e-helpers.ts` — 그래서 `bun run test:evals`는 Anthropic을 찾아냅니다

TS 입력점을 추가하면 유료 API를 보거나 gbrain embeddings를 필요로 하고, 정상에 동일한 원라인 가져오기를 추가합니다. 기여자 체크리스트를 위해 [CONTRIBUTING.md "컨덕터 워크스페이스"](CONTRIBUTING.md#conductor-workspaces)를 참조하십시오.

`bin/gstack-codex-probe`는 bash이고 이것을 직접 읽지 않습니다 — `~/.codex/` auth CLI에 의해 관리된 CLI에 의존합니다.

## 보안 모델

모든 비밀이 기술 접촉에 대한 하나의 규칙 : **env var 만, argv가 아니었다, 절대로 우리를 통해 디스크에 기록하지.** 유일한 지속 저장은 gbrain의 자체 `~/.gbrain/config.json` 모드 0600, gbrain의 분야는 우리의 없습니다.

**코드에 따라:**

- CI grep test in `test/skill-validation.test.ts`는 `$SUPABASE_ACCESS_TOKEN` 또는 `$GBRAIN_DATABASE_URL`가 argv 위치에 나타나는 경우에 빌드를 실패합니다
- CI grep 테스트는 `--insecure`, `-k`, `NODE_TLS_REJECT_UNAUTHORIZED=0`가 `bin/gstack-gbrain-supabase-provision`에 나타날 경우 실패합니다
- `set +x` 프로비저닝 연구원의 상단에 PAT를 누출하여 디버그를 방지
- Telemetry payload는 categorical 값 (scenario, install result, MCP opt-in, trust tier)만 포함하지만, 비밀을 포함 할 수있는 무료 형식 문자열이 없습니다.

**테스트를 통해 강화:**

- `test/secret-sink-harness.test.ts`는 씨앗이 은폐된 비밀과 종자가 있는 모든 비밀 핸들링 빈을 실행하고, 씨앗은 캡처된 채널(stdout, stderr, `$HOME`, telemetry JSONL)에서 나타나지 않는 모든 캡쳐된 채널에 나타나지 않습니다. 씨앗당 4개의 일치 규칙: 정확한, URL-decoded, first-12-char prefix, base64.
- 동일한 테스트 파일에 긍정적 인 제어는 모든 커버 된 채널에서 씨앗을 분리하고 마구가 각 것을 잡습니다. 긍정적 인 제어없이, 침묵 하네스는 작업 하네스와 동일하게 보일 것입니다.

**아직도 누출 할 수 있는 것** (v1)의 정직한 한계:

- `read -s` 외의 정상적인 채팅 메시지에 비밀을 붙여 넣으면 대화의 성적과 호스트 측 로그인이 됩니다.
- 누출 하네스는 하위 프로세스 환경을 덤프하지 않습니다. `env >> ~/.log`는 v1의 evade 검출 (no bin이; grep 테스트는 그것을 방지)
- 쉘의 자신의 `HISTFILE` 동작은 쉘의, 우리의 - 우리는 우리의 코드를 통해 거기에 착륙하지 않도록 argv에 비밀을 통과하지 않습니다, 그러나 아무것도 원시 `curl` 명령으로 당신을 종료

## 문제 해결

### "PATH SHADOWING DETECTED" 설치 중

또 다른 `gbrain` 이진은 PATH 로 연결되는 것 보다는 더 이른다. 설치자의 버전 체크는 그것을 붙잡았다. 한 가지를 고치십시오:

- `rm $(which gbrain)` 다른 것을 필요로 하지 않는 경우에
- `~/.bun/bin` 에 PATH 의 쉘 rc에 연결 된 바이너리 승리
- `GBRAIN_INSTALL_DIR`를 그림자에 놓는 바이너리의 설치 디렉토리와 재 실행

Then re-run `/setup-gbrain`.

### "직접 연결 URL"

`db.<ref>.supabase.co:5432` URL를 붙여넣었습니다. 이들은 대부분의 환경에서 IPv6-only이고 실패합니다. 세션 풀러 URL를 대신 사용하십시오: Supabase 대쉬보드 → 설정 → 데이터베이스 → 연결 풀러 → **- 연혁** → 복사 URI (포트 6543).

## 자동 감독은 180s에서 밖으로 시간

Supabase 프로젝트는 여전히 초기화됩니다. ref는 종료 메시지로 인쇄되었습니다. 잠시 기다리십시오.

```bash
/setup-gbrain --resume-provision <ref>
```

기술이 PAT을 재 수집하고 프로젝트 생성을 건너 뛰고, 투표를 다시 시작합니다.

## "다른 `/setup-gbrain` 인스턴스가 실행됩니다"

당신은 stale 자물쇠 디렉토리가 있습니다. no 다른 인스턴스가 실제로 실행되는 경우:

```bash
rm -rf ~/.gstack/.setup-gbrain.lock.d
```

다음 다시 실행.

### "No 정책 파일에 크로스 모델 텐션"

`~/.gstack/gbrain-repo-policy.json`를 레거시 `allow` 값으로 손으로 편집했습니다. No 문제. 다음 읽기에서 gstack 자동 마이그레이션 `allow` → `read-write`를 자동 마이그레이션하고 `_schema_version: 2`를 추가합니다. stderr, idempotent, deterministic에 대한 하나의 로그 라인.

## `gbrain doctor` 라고 "워닝"

`/health`는 노란색, 빨간색이 아닌 것을 대우합니다. `gbrain doctor --json | jq .checks`를 체크하면 하위 검사가 경고가 표시됩니다. 전형적인 원인: 해결자 MECE 과잉 (스킬 이름 충돌) 또는 DB 연결은 아직 형성되지 않았습니다.

## `/sync-gbrain` 보고서 `OK` 하지만 `gbrain search`는 아무것도 semantic를 반환

수입 중에 실패했습니다. 기호 쿼리 (`code-def`, `code-refs`)는 여전히 embeddings가 필요 없기 때문에 작동하지만 `gbrain search "<terms>"`는 degraded BM25 경로로 돌아갑니다. 같은 라인의 동기화 출력을 보면 다음과 같습니다.

```
[gbrain] embedding failed for code file <name>: OpenAI embedding requires OPENAI_API_KEY
```

수정은 재 실행하기 전에 프로세스 env의 공급자 API 열쇠를 넣어 것입니다. `VOYAGE_API_KEY`는 코드 (gstack 과태 PGLite에 `voyage-code-3` 설정할 때); 그렇지 않으면 `OPENAI_API_KEY`는 `text-embedding-3-large`로 돌아갑니다. 베어 맥 쉘에서는 호출하기 전에 `~/.zshrc`에서 열쇠를 소스로 보냅니다. 지휘자에서는 `lib/conductor-env-shim.ts` shim는 `GSTACK_ANTHROPIC_API_KEY`/>/<9/>를 자동으로 이름을 붙일 수 있습니다. `VOYAGE_API_KEY`를 위해, 당신의 지휘자 workspace env에서 직접 놓으십시오. 재 실행 `/sync-gbrain --code-only`는 이미 허가한 페이지에 뒤집을 삽입하는 것을.

## `gbrain sync`는 commit 해시에서 막힌 `FILE_TOO_LARGE`

나무의 파일은 gbrain의 5 MB 하드 한계 (`MAX_FILE_SIZE` in `gbrain/src/core/import-file.ts`)를 초과합니다. 일반적인 culprits: 응답 재생 캐시, 캡처 된 스크린 샷, 큰 JSON 정착물. Gbrain은 `.gitignore`-style exclude 코드 동기화를 위한 명부를 명예를 줬습니다; 유일한 손잡이는 실패를 ackledging입니다:

```bash
gbrain sync --source <source-id> --skip-failed
```

워터 마크는 오프 종료 커런트를 통해 전진합니다. 동일한 파일이 변경되면 다시 실패합니다. 그 일이 일어날 때 다시 스키프를 다시 시작합니다.

## ZeroEntropy embeddings 중지 일 후 9월 4, 2026

ZeroEntropy는 Notion와 일몰에 의해 인수되었다 **9월 4, 2026** (새로운 가입이 이미 비활성화). `zeroentropyai` embedding 조리법으로 구성된 gbrain는 그 날짜 후 페이지를 수입 유지, 그러나 침묵적으로 실패 - 페이지 토지 구조적으로 no semantic 검색. 당신의 `~/.gbrain/config.json` 이름이 조리법을 의미 할 때 철근 돕기; 다른 공급자에 마이그레이션 (Voyageage, `OPENAI_API_KEY`를 통해 `OPENAI_API_KEY`를 통해). 세부 사항, 자기 호스팅 동굴, 그리고 마이그레이션 토론 : [글리세린/gstack#2365](https://github.com/garrytan/gstack/issues/2365).

### 전환 PGLite → Supabase 걸림새

다른 gstack 세션은 sibling 지휘자 작업 공간에 있는 당신의 지역 PGLite 파일에 그것의 preamble's `gstack-brain-sync` 전화를 통해서 자물쇠를 붙들 수 있습니다. 다른 작업 공간, 재 실행 `/setup-gbrain --switch`를 닫으십시오. 타임아웃은 180s에 따라서 당신은 실제로 영원히 기다리지 않을 것입니다.

## 왜 이 디자인

**왜 per-remote 신뢰는 트리아드를 믿지 않고 바이너리 허용/deny?** 멀티클라이언트 컨설턴트는 작성 후 검색이 필요 합니다. 오후에 클라이언트 A에서 클라이언트 A를 실행하고 클라이언트 B에서 작동 하는 프리랜서는 두뇌 클라이언트 B로 누출 된 코드 통찰력을 검색할 수 없습니다. 읽기 전용은 청소하게 해결합니다.

**왜 gstack에 묶지 않는가?** Gbrain은 자체 출시 cadence, schema migrations 및 MCP 표면과 함께 개별적이고 적극적으로 개발된 프로젝트입니다. Bundling은 gstack가 게이트 gbrain 업데이트를 의미하며, 이는 gbrain 개선을 도달 사용자로부터 느리게 합니다. 분리형 단종은 각 선박을 자체 캐비테이션에 전달합니다.

**왜 `gbrain init --non-interactive` env var를 통해 플래그가 아닌가?** 연결 끈에는 데이터베이스 암호가 포함되어 있습니다. argv가 `ps`, 쉘 역사 및 프로세스 목록에서 암호를 착륙함에 따라 패스링합니다. Env-var handoff는 프로세스 메모리에만 비밀을 유지합니다. Gbrain은 `GBRAIN_DATABASE_URL`와 `DATABASE_URL` 모두 지원; 우리는 비 GBrain 툴링과 충돌을 방지하기 위해 전을 사용합니다.

**왜 PATH shadowing에 실패하곤 하고 계속?** 그림자 `gbrain`는 각 후속 명령은 우리가 다만 설치한 것보다 다른 이진을 호출합니다. 즉, 신비한 기능 간격으로 표면이 주를 나중에 갭으로 갖는 침묵하는 버전 도둑질 버그입니다. 설치 기술은 일하는 환경이 있습니다. 깨진 것으로 해결하는 것은 설정 충돌 방지 행동입니다.

**왜 자동이송하지 않는 모든 repo?** 개인정보 + 소음. 자동 이동식 이동식 후크는 각 repo를 입력하면 접촉할 것입니다: (a) 누출 작업 코드는 동의 없이 공유된 두뇌로, 그리고 (b)는 throwaway 저장소로 검색합니다. per-remote 정책은 명시적으로, per-repo 결정에 영향을 줍니다. `/setup-gbrain`는 오늘 어떤 자동 이동식 후크를 설치하지 않습니다. 그러나 정책 저장소는 나중에 1개에 대한 기대치입니다.

## 관련 기술 + 다음 단계

- `/health` - 0-10 복합 점수에서 GBrain 차원 (도ctor 상태, 동기화 큐 깊이, 마지막 push 나이)를 포함합니다. 차원은 gbrain가 설치되지 않을 때 부유됩니다; 비 GBrain 기계에 `/health`를 달리는 것은 그 선택이 확증되지 않습니다.
- `/gstack-upgrade` - gstack를 최신 상태로 유지하십시오. NOT 업그레이드는 독립적으로 gbrain를 사용합니다. default에 의해 최신 HEAD에 gbrain 설치; gbrain clone (default `~/gbrain`) 및 재 실행 `/setup-gbrain`에서 `gstack-gbrain-install --pinned-commit <sha>`를 새로 고침해야 하는 경우에 commit를 가진 특정 commit를 핀으로 꼿습니다. 설치 버전은 시험된 버전의 밑에 시험된 버전의 밑에 시험됩니다.
- `/retro` - 주간 복도 풀 학습 및 메모리 동기화가 켜지면 gbrain에서 계획, 복도 참조 크로스 머신 역사를 시켰습니다.

`/setup-gbrain`를 실행하고 스틱을 볼 수 있습니다.
