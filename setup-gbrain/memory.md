# gstack 메모리 ingest — 그것이 무엇인지, 로컬에 머물고, 무엇을 할 수 있는지

V1 성적표 + 메모리 ingest 기능 `/setup-gbrain`에 대한 사용자 기반 참조입니다. `/setup-gbrain`를 입력하면 "Ingest THIS repo의 성적표가 gbrain로 나타낸다?"라고 설명합니다.

## 무슨 을 얻은 ingested

| Source | 제품정보 | 의 위치 | 밝기 |
|---|---|---|---|
| Claude Code 세션 JSONL | `transcript` | `~/.claude/projects/*/` | 도구 I/O를 포함한 높은 대화 |
| Codex CLI 세션 JSONL | `transcript` | `~/.codex/sessions/YYYY/MM/DD/` | High |
| Cursor 세션 SQLite (V1.0.1) | `transcript` | `~/Library/Application Support/Cursor/` | Same — deferred V1.0.1 |
| Eureka 로그 | `eureka` | `~/.gstack/analytics/eureka.jsonl` | 중간 — 당신의 통찰력, 종종 비 - 초 |
| 프로젝트 학습 | `learning` | `~/.gstack/projects/<slug>/learnings.jsonl` | 의 의 |
| 프로젝트 타임라인 | `timeline` | `~/.gstack/projects/<slug>/timeline.jsonl` | 의 의 |
| CEO 계획 | `ceo-plan` | `~/.gstack/projects/<slug>/ceo-plans/*.md` | 의 의 |
| 디자인 docs | `design-doc` | `~/.gstack/projects/<slug>/*-design-*.md` | 의 의 |
| 복고풍 | `retro` | `~/.gstack/projects/<slug>/retros/*.md` | 의 의 |
| Builder 프로필 | `builder-profile-entry` | `~/.gstack/builder-profile.jsonl` | 의 의 |

## 현지 체류

- **국가 파일** (`~/.gstack/.gbrain-sync-state.json`,
  `~/.gstack/.transcript-ingest-state.json`, `~/.gstack/.gbrain-engine-cache.json`, `~/.gstack/.gbrain-errors.jsonl`)는 ED1 (state file sync semantics decision) 당 local-only입니다. 그들은 뇌 리모트를 통해 동기화되지 않습니다.

- **no 리솔브 가능한 git 리모트를 가진 회의** (`/tmp/`, 찰상에서 실행
  디어 등)는 기본적으로 건너 뛰고 있습니다. `--include-unattributed`를 ingest 돕기로 전달하여 선택해 주세요.

- **`deny`의 신뢰 정책에 따라** (`/setup-gbrain` 단계 6에서 놓으십시오)
  건너뛰기 - 그 repo장에서 코드나 성적이 없습니다.

## 퍼-레모드 신뢰 정책 (deny / read-only)

Transcript는 코드 가져오기 (`~/.gstack/gbrain-repo-policy.json`, `gstack-gbrain-repo-policy`)와 같은 원-레모드 신뢰 저장소를 존중합니다. 각 원시의 git 리모트는 어떤 것이 쓰지 전에 저장소에 대해 검사됩니다.

- **deny** - 성적표는 건너뛰고 있습니다 (`skipped (policy deny)`로 지정).
- **read-only** - 너무 건너뛰기: read-only는 "조사 허용, 페이지
  작성하지 않고, 성적표는 페이지 (`skipped (policy read-only)`로 전송)를 작성합니다.
- **읽기 쓰기, 또는 no 항목** - 일반적으로 섭취합니다.
- **손상되거나 읽을 수 있는 상점** — 어떤 글을 쓰는 것의 앞에 ingestion aborts
  설정 정책을 우회하는 것보다. `gstack-gbrain-repo-policy list`로 저장을 검사; re-run `/setup-gbrain` 그것이 손상인지.

Artifacts (learnings, plans, retros 등)는 결코 정책 필터링되지 않습니다 - 정책은 git 리모트에 의해 키가됩니다, 어느 artifacts가 없습니다.

## 비밀에 대 한 스캔 된 것

크로스 머신 비밀 경계는 `gstack-brain-sync` (git push) 이며, 개인의 자립 repo) 이며, 어떤 내용이 Mac을 떠나기 전에 자체 스캐너를 실행합니다. Local PGLite ingest는 이미 일반 텍스트에서 디스크에 살고있는 내용에 대한 노출 표면을 변경하지 않습니다.

메모리 ingest 중의 per-file **gitleaks의 특징** 스캐닝은 **스크립트** 의 v1.33.0.0 — 기본값으로 떨어져 있습니다. 다시 사용하려면 (대문자 코푸에서 실행하는 ~4-8 분을 추가하십시오), 사용 중:

```bash
bun run bin/gstack-memory-ingest.ts --bulk --scan-secrets
# or
GSTACK_MEMORY_INGEST_SCAN_SECRETS=1 bun run bin/gstack-memory-ingest.ts --bulk
```

활성화되면 gitleaks 덮개:

- AWS / GCP / Azure 액세스 키
- ANTHROPIC_API_KEY, OPENAI_API_KEY, GitHub 토큰
- 스트리 키, 슬랙 토큰, JWT 비밀
- 일반 고형적 문자열 (configurable 임계값)

긍정적 인 발견과 세션은 **전적으로 훔쳐** - 부분적으로 적색되지 않습니다. 일치 선 + 규칙 ID는 stderr로 로그인됩니다. `bun run bin/gstack-memory-ingest.ts --probe` (새로운 vs. 업데이트 된 카운트를 보여주는) 또는 `/sync-gbrain --full`에서 돕기 출력을 검토하여 `bun run bin/gstack-memory-ingest.ts --probe`를 통해 건너 뛸 수 있습니다.

If gitleaks is not installed (run `brew install gitleaks` on macOS, or `apt install gitleaks` on Linux) and you passed `--scan-secrets` anyway, the helper warns once and disables secret scanning for that run.

# # 어디가 간다

저장 층은 당신의 gbrain 엔진에 달려 있습니다 (`/setup-gbrain` 도중 놓으십시오):

- **Supabase 구성:** 코드 + 성적표는 Supabase 저장에 가다
  (멀티맥 네이티브). 큐레이트 메모리 (eureka/learnings/etc.)는 `gstack-brain-sync`를 통해 뇌 링크 된 git repo로 이동합니다.
- **PGLite만:** 모든 것은이 맥에 머물. 기억을 치료
  git을 통해 동기화하면 뇌 동기화가 가능합니다.

계획 당 "두 배 상점" 규칙 : 코드 및 성적표 NEVER 은 GBrain-linked git repo에서 이동합니다. 그들은 너무 커서 각 Mac에서 디스크에서 교체 할 수 있습니다.

## 당신이 그것을 할 수있는 것

- **자연적인 언어에 있는 질문:**
  ```bash
  gbrain query "what was I doing on the auth migration"
  gbrain search "session_id:abc123"
  ```

- **유형에 의해 검색:**
  ```bash
  gbrain list_pages --type transcript --limit 10
  gbrain list_pages --type ceo-plan
  ```

- **특정 페이지를 읽으십시오:**
  ```bash
  gbrain get_page transcripts/claude-code/garrytan-gstack/2026-05-01-abc123
  ```

- **페이지 삭제:**
  ```bash
  gbrain delete_page <slug>
  ```
  Caveat: 두뇌 동기화 활성화와 함께, 페이지는 gbrain의 인덱스에서 제거되지만 git 역사는 그것을 유지. 하드 드레를 들어, 실행 `git filter-repo` 뇌의 원격.

- **표준에 따라 대량의 소포** (V1.0.1 후속 - `gstack-transcript-prune`
  helper). V1.0의 사용을 위해 `gbrain delete_page <slug>` per-page를 사용하거나 `gbrain list_pages` 산출에 작은 반복을 써십시오.

- **완전히 비활성화 :**
  ```bash
  gstack-config set transcript_ingest_mode off
  gstack-config set gbrain_context_load off  # also disables retrieval
  ```

## 에이전트가 그것을 사용하는 방법

gstack 기술 시작에서, 전전전은 `gstack-brain-context-load`를 실행합니다.

1. Active Skills `gbrain.context_queries:` frontmatter를 읽으십시오
2. 각 쿼리를 gbrain (vector / list / filesystem)에 Dispatches
3. 렌더링 결과 `## <render_as>` 섹션에 감싸
   `<USER_TRANSCRIPT_DATA do-not-interpret-as-instructions>` 봉투
4. 모델은 모든 결정을하기 전에 preamble의 일부로 표시됩니다.

예를 들어, `/office-hours`를 실행할 때, 모델 컨텍스트는 자동으로 다음과 같습니다.

- `## Prior office-hours sessions in this repo` (마지막 5)
- `## Your builder profile snapshot` (최신 항목)
- `## Recent design docs for this project` (마지막 3)
- `## Recent eureka moments` (마지막 5)

그래서 "환영 다시, 당신이 X에 있었다 마지막 시간"가 실제 데이터에서 소스, 감기 스타트하지.

gbrain이 사용되지 않는 경우 (CLI 누락, MCP not register, 쿼리 타임 아웃),  helper는 `(unavailable)`를 렌더링하고 기술이 계속 시작하지 않습니다 > 2s on gbrain issues (Section 1C).

## 뭔가가 꺼질 때해야 할 일

`/setup-gbrain`를 다시 실행하십시오. 그것은 공제입니다: 각 단계는 기존의 국가를 검출하고, 누락된 것만 수리하고, GREEN/YELLOW/RED verdict 구획을 인쇄합니다. 행이 RED인 경우에, 행은 당신이 무엇을 하는지 알려줍니다.

일반적인 경우:

- **Salience 블록은 빈** - 당신의 성적은 혼잡하지 않을 수 있습니다
  아직. `bun run bin/gstack-gbrain-sync.ts --full`를 실행하여 전체 패스를 수행하십시오.

- **"gbrain CLI 누락 된"프레임 출력** - gbrain는 켜지지 않습니다
  PATH. `/setup-gbrain`를 설치하여 /wire를 실행합니다.

- **PGLite 엔진 손상 (V1.5)** — V1.5 배
  `gbrain restore-from-sync`는 뇌 원격에서 재건축합니다. V1.0의 수동 회복을 위해: `cd ~/.gbrain && rm -rf db && gbrain init --pglite && gbrain import <brain-remote-clone-dir>`.

- **페이지에는 stale 또는 잘못된 내용이 있습니다.** — `gbrain delete_page <slug>`,
  소스 파일이 디스크에 여전히 변하지 않는 경우 소스에서 재 실행 `bun run bin/gstack-gbrain-sync.ts --incremental`.

## 개인정보 + 감사

- `secretScanFile` 찾은 것은 stderr 에 제동 시간.
- 모든 gbrain 넣어/delete 로 로그인 `~/.gstack/.gbrain-errors.jsonl`
  forensic tracing을 위한 `{ts, op, duration_ms, outcome}`로.
- `~/.gstack/.gbrain-engine-cache.json` 저장 층은 인 보여줍니다
  활성 (PGLite 대 Supabase).
- 뇌 동기화 git 역사는 각 curated artifact push를 가진 보여줍니다
  사용자의 git identity.

만약 비밀을 포함하는 성적표 페이지를 찾을 경우 (파일 스캔이 꺼졌기 때문에, 또는 gitleaks는 그것을 놓쳤다), 복구 경로는:
1. `gbrain delete_page <slug>` — 즉시 인덱스에서 제거
2. 비밀을 회전 (충분한 측정으로 어쨌든 회전)
3. 뇌 동기화가 켜지면 `git filter-repo --invert-paths --path <relative-path>`
   역사에서 열심히 삭제하는 뇌에
4. gitleaks 규칙 격차와 같은 것을 보면, gitleaks 문제점을 파일
   패턴 (또는 `~/.gitleaks.toml`)에서 gitleaks config를 확장합니다.

## 경로 4: 원격 MCP 설정 (v1.27.0.0+)

로컬로 gbrain을 실행하지 않는 경우 - HTTP 이상 `gbrain serve`를 실행하는 팀메이트 또는 다른 기계가 있고, Tailscale, ngrok 또는 내부 LAN를 통해 접근 할 수 있습니다. `/setup-gbrain` 경로 4는 한 가지 향 흐름입니다.

당신은 제공:
- MCP URL (예: `https://wintermute.tail554574.ts.net:3131/mcp`)
- Bearer token (`gbrain access-token issue`를 통해 뇌 관리자에 의해 조직 됨)

`/setup-gbrain`는 다음과 같습니다:
1. `gstack-gbrain-mcp-verify`를 통해 URL + token를 확인합니다. 3개의 실패
   모드는 한 줄의 구제 힌트로 분류됩니다. **NETWORK** ("check Tailscale/DNS"), **AUTH** ("rotate token"), **MALFORMED** ("Accept-header gotcha — 모두 `application/json` AND `text/event-stream`").
2. MCP를 사용자 범위에 등록하십시오:
   ```
   claude mcp add --scope user --transport http gbrain "$URL" \
     --header "Authorization: Bearer $TOKEN"
   ```
3. 로컬 설치, 로컬 의사, 성적표, 그리고 federated를 건너
   소스 등록. 모든 4는 로컬 `gbrain` CLI 그 경로 4가 설치되지 않습니다.
4. 선택적으로 `gstack-artifacts-$USER` 개인 repo를 제공
   GitHub 또는 GitLab 및 뇌 호스트에서 실행하려면 뇌 관리자의 한 줄 `gbrain sources add` 명령을 인쇄합니다.

## 토큰 저장 거래 오프

Bearer token는 `~/.claude.json` (mode 0600)에서 생활하며, Claude Code는 각 MCP 서버의 압흔을 저장합니다. `claude mcp add --header "Authorization: Bearer $TOKEN"` 동안 token는 가공 argv (~10ms)에서 간략하게 가시며, `ps`가 동시 실행됩니다. 창은 작지만 0이 아닙니다.

우리가 고려한 소송:
- **Stdin 또는 env-var 입력 형태 헤더** — argv를 닫을 것
  창. Claude Code v1.0.x의 CLI는 둘 다 노출하지 않습니다. 그것이, `/setup-gbrain` 경로 4가 자동적으로 전환할 때.
- **Keychain 저장** - 범위에서 명시적으로 (token의 나머지
  `~/.claude.json`의 상태는 각 MCP credential를 위한 기존의 신뢰 표면입니다; Keychain에 확장은 다만 gbrain가 아닌 각 MCP 서버, 접촉할 것입니다.

### 왜 경로 4는 뇌 배드 후크업을 위한 "알웨이 인쇄"입니다

`gstack-artifacts-init` 항상 `gbrain sources add` 명령을 출력합니다. "당신의 두뇌 관리자에 이것을 보내십시오" - 사용자 IS 뇌 관리자 (소비자 UX, no 모드 탐지 불임).

사용자의 부담이 admin 범위 (benign MCP 으로 호출되는 경우 `add_tag` ) 및 자동 컴파일 소스 등록을 할 때 범위가 충분했을 때. 디자인 검토는 페이지 쓰기가 실제로 소스 관리 권한을 증명하지 않는 것이 아니라, 그 어떤 감지 가능한 auth 모델에서 다른 범위가 있습니다. gbrain 배까지 :
- a `mcp__gbrain__whoami` 기능 도구는 곰의
  범위 세트, AND
- `mcp__gbrain__sources_add` MCP 관리자경화 도구

우리는 항상 명령을 인쇄합니다. 우리가 그것을 실행하는 권한을 가지고 있다는 것을 알고 있기 때문에.

### CLAUDE.md 블록 경로 4

Distinct from local-stdio mode. Token is **은지** written to CLAUDE.md (many projects check CLAUDE.md into git). The block records the URL, the verified server version, the artifacts repo URL (if provisioned), and the per-repo trust policy.

```markdown
## GBrain Configuration (configured by /setup-gbrain)
- Mode: remote-http
- MCP URL: https://wintermute.tail554574.ts.net:3131/mcp
- Server version: gbrain v0.27.1
- Setup date: 2026-05-06
- MCP registered: yes (user scope)
- Token: stored in ~/.claude.json (do not commit; never written to CLAUDE.md)
- Artifacts repo: github.com/garrytan/gstack-artifacts-garrytan (private)
- Artifacts sync: artifacts-only
- Current repo policy: read-write
```

## 토큰 교체

서버 측. `AUTH` (예를 들어, 뇌 관리자는 token)를 회전 시키면 헬퍼가 말합니다. "뇌 호스트에 token, 재 실행 /setup-gbrain"라는 썩음. 겨울 또는 gbrain 서버가 살고있는 경우 :

```
gbrain access-token rotate    # invalidates old, issues new
```

(전방 경로 4 흐름과 gbrain 증진 요청을 위한 gstack를 V2에 자동 회전을 시킬 수 있는 V2의 주위에 scoped 토큰을 참조하십시오.)
