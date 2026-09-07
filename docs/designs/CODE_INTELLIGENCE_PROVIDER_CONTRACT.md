# Code-Intelligence 공급자 계약

상태: 디자인 + 첫번째 구현 조각 소유자: 관리인 지시된 내부 일 관련: `runtime/context.js` (Context.dev 공급자 본), `scripts/gstack2/browser-provider-contract.ts` (가장 있는 공급자 계약 idiom), `lib/gstack-decision-semantic.ts` (degrade-to-null 신뢰성 계약)

## 문제

gstack는 가정 소유 코드 인지 접착제의 ~17k LOC를 나릅니다: 성적 ingestion (`bin/gstack-memory-ingest.ts`, ~1.9k), 통일된 동기화 동 (`bin/gstack-gbrain-sync.ts`, ~1.6k), 상황 선적 (`bin/gstack-brain-context-load.ts`), 3 층 계획 캐시 (`bin/gstack-brain-cache`), 근원 재구성, 엔진 통계 분류, 파괴적인 op 감시, `bin/gstack-brain-*` 및 항목. `bin/gstack-brain-*` 및 `bin/gstack-brain-*` 1개의 외부 도구 (GBrain)의 주위에 비스듬한 배선은 직접 CLI 포탄 밖으로 도달했습니다.

우리는 가정 소유 지수를 유지하고 싶지 않습니다. 우리는 gstack를 원하고 외부 공급자가 구현하는 **작은 옵션 계약**를 정의하기 위해, 그래서 indexing/search/graph는 공급자에 살고, gstack에.

하드 요구 사항, 비 협상 : **gstack는 공급자 OFF로 완전히 기능을 유지해야 합니다.** 파일 전용 경로 (결정점, Context Recovery, grep)는 신뢰할 수 있으며 공급자가 현재에 의존하지 않습니다. 이것은 기존의 의사 결정 상점 철학입니다 (`lib/gstack-decision.ts`는 0 gbrain imports; `lib/gstack-decision-semantic.ts` degrades to `null`). 계약은 강화, 절대 의존성.

## 디자인 결정: repo-지향, 문서 저장하지

정착 (relitigate가 아닙니다). 계약은 **repo-지향**입니다.

```
register_source(repo)   — required
refresh(source)         — required
search(query)           — required
status(source)          — required
```

`add` / `delete` / `export`는 **선택 기능** 공급자 MAY 광고입니다. GBrain는 그들을 광고합니다 (그것의 기본 원시는 문서에 의하여 접착제로 붙입니다: put/delete/get/export); 코드 연구 및 코드 도표 도구는 그(것)들을 쇠퇴합니다.

문서 저장 계약 (add / delete-by-id / export as **필수* ops)는 거절되었다: 그것은 잘못된 코드 검색 및 코드-graph 도구. Sourcebot는 전체 repo를 색인하고 검색을 노출; 그것은 no 개념의 "delete document id X". 문서 CRUD 표면을 구현하기 위해 모든 공급자를 강제로 우리는 가장 원하는 정확한 도구 (전체 그래프 인덱스)를 제외하고는, 또는 일반 도구는 일반 도구로 간주한다. GBrain의 문서 축은 계약의 모양과 같은 *옵션 정보* 기능으로 살아납니다.

## 계약

TypeScript `lib/code-intelligence/contract.ts`. 모양 (교대):

```ts
type CodeProviderCapability =
  | "register_source" | "refresh" | "search" | "status"   // required
  | "add" | "delete" | "export";                          // optional

interface CodeProvider {
  readonly id: "gbrain" | "sourcebot" | "graphify";
  readonly label: string;
  readonly capabilities: ReadonlySet<CodeProviderCapability>;
  readonly local: boolean;   // true = no repo content leaves the machine

  registerSource(repo: RepoRef, opts?: OpOptions): Promise<SourceStatus>;
  refresh(source: SourceRef, opts?: OpOptions): Promise<SourceStatus>;
  search(query: string, opts?: SearchOptions): Promise<CodeSearchHit[]>;
  status(source?: SourceRef, opts?: OpOptions): Promise<SourceStatus>;

  add?(doc: { slug: string; body: string }, opts?: OpOptions): Promise<SourceStatus>;
  delete?(slug: string, opts?: OpOptions): Promise<SourceStatus>;
  export?(source: SourceRef, opts?: OpOptions): Promise<string>;
}
```

모든 공급자 MUST는 4가지 필수 방법 및 MUST를 실행합니다 정확하게 기능을 뒤로 (`assertRequiredCapabilities`는 건축에 요구되는 4를 시행합니다; 시험은 그것을 핀으로 꼿습니다). 선택적인 방법은 일치하는 기능 광고됩니다. 비광고되지 않은 선택적인 op를 부르는 `CAPABILITY_UNSUPPORTED`를 부르는 것은 결코 침묵하지 않습니다.

## 유형 실패

거울 `runtime/context.js`의 `ContextError` 분야 (닫힌 코드 세트, 생성자는 알 수없는 코드에 던집니다):

| 의 특징 | 의약 |
|------|---------|
| `PROVIDER_UNAVAILABLE` | CLI/MCP 수송 absent - 파일 전용에 degrade |
| `PROVIDER_NOT_CONSENTED` | repo 동의하지 않고 내용이 기계를 떠날 것 |
| `CAPABILITY_UNSUPPORTED` | 공급자는이 op를 쇠퇴 |
| `SOURCE_NOT_REGISTERED` | op는 등록된 소스가 필요 |
| `PROVIDER_TIMEOUT` | 공급자는 op timeout를 초과했습니다 |
| `PROVIDER_ERROR` | 공급자 ran 및 실패 |

`PROVIDER_UNAVAILABLE`는 로드 베어링입니다. 호출자는 그것을 잡습니다 (또는 피프의 null 해상도를 사용) 그리고 grep / 파일 전용으로 돌아갑니다. 그것은 결코 치명적입니다.

### 단점

두 개의 직각적 인 동의 축, 두 명시, 자동 과립되지 않음 :

1. **네트워크 / 콘텐츠 승인 동의 (repo-scoped).** repo 내용의 앞에
   기계, 색인을 남기는 것은 *repo에 의하여*를 동의해야 합니다. 계약은 `registerSource`/`refresh`/`add`에서 이것을 시행합니다: `provider.local === false`와 `opts.consented !== true`일 때, `PROVIDER_NOT_CONSENTED`를 던졌습니다. 현지 공급자 (도표)는 이 축선을 건너 뛰지 않습니다 — 기계를 나타낸 아무 말도.
2. **동의를 설치하십시오 (그래픽 만).** Graphify는 자동 설치되지 않습니다.
   `options`/`status` 디스플레이는 CLI가 현재일 때만 사용할 수 있으며 gstack는 Graphify 설치 프로그램을 실행합니다. 설치는 사용자 행동입니다 (`pip install graphifyy && graphify install`).

이 일치 Context.dev 모델: egress 동의를 부여하지 않고 선택 persists; egress 별도의 명시 단계가 필요합니다.

## Per-provider 기능 매트릭스

| 팟캐스트 | GBrain (첫번째로 완료) | 소스봇 | 그라프 |
|----|--------------------------|-----------|----------|
| `register_source` | ✓ `sources add --federated` | ✓ local `git` connection in config.json | ✓ `graphify update <dir>` (현지, no LLM) |
| `refresh` | ✓ `sync` + `sync --strategy code --full` | ✓ 자동 (config 변경 + reindexIntervalMs) | ✓ `graphify update <dir>` |
| `search` | ✓ `gbrain search` (폭포된 corpora) | ✓ `POST /api/search` (keyless w/ 익명 액세스를; Bearer 키 옵션) | ✓ `graphify query "<q>" --graph <graph.json>` |
| `status` | ✓ `sources list` + 페이지_count | ~ 부분 (서버 liveness) | ~ 부분 (graph.json 현재 + 노드 수) |
| `add` | ✓ `put <slug>` | ο 회원 관리 | ο 회원 관리 |
| `delete` | ✓ `delete <slug>` | ο 회원 관리 | ο 회원 관리 |
| `export` | ✓ `export` | ο 회원 관리 | ✓ `graphify-out/graph.json`를 읽으십시오 |
| `local` (no egress) | no (피드 DB) | 루프백 → **yes**; 원격 호스트 → no | **yes** (현지 전용) |

모든 세는 실행 시간에서 직접 구동됩니다 — no MCP 클라이언트:

- **GBrain** (`garrytan/gbrain`, gstack-ecosystem 도구): 전체 계약 적합,
  기존 `gbrain` CLI chokepoint (`lib/gbrain-exec.ts`)를 통해 구동됩니다. 기본 원시는 문서 별표입니다 (put/delete/get/export) PLUS repo 축선 (`sources add`/`sync`). 모든 7개의 기능을 광고하십시오. **추천된 첫 번째.**
- **소스봇** (`github.com/sourcebot-dev/sourcebot`, YC 가을 2025): 각자 호스팅하는
  전체-repo regex 검색, Docker 컴파일 (bundled server + Postgres를 통해 배포
  + Redis; no 지원되지 않은 경로). `register_source`는 로컬 `{"type":를 추가합니다.
  "git", "url": "file:///path" }` connection to the server's `config.json` (it re-indexes on config change; a local repo needs a `remote.origin.url` or it is skipped); `search` is `POST {baseUrl}/api/search`; `status` probes that endpoint. Declines `add`/`delete`/`export`. It is a **local** tool — indexed code stays on your machine — and an **API key is optional**: a local instance with anonymous access (`FORCE_ENABLE_ANONYMOUS_ACCESS=true`) serves `/api/search` keyless. The adapter sends `Authorization: Bearer <SOURCEBOT_API_KEY>` only when a key is set. A loopback `baseUrl`는 기계 (local=true); 원격에 내용을 유지한다.
- **그라프** (`github.com/Graphify-Labs/graphify`, YC-backed): 현지
  `graphify` CLI를 통해 트리 시터 코드 그래프. 어댑터는 **`graphify update <dir>`**를 사용하며, 로컬, no-LLM 빌드 (쓰기 `graphify-out/graph.json`); 그것은 deliberately `graphify <dir>` 빌드를 피합니다. LLM 추출 백엔드가 필요하면 API 키 + 네트워크가 필요합니다. `graphify query "<q>" --graph <graph.json>` 검색 (its `NODE ...`/`EDGE ...`) `at=` 그래프는 `at=` 출력되지 않습니다. `at=`는 <f> <f> <f>를 출력합니다. 선택, **명시된 사용자 행동만 설치** (`pip install graphifyy && graphify install`, 필요 Python >= 3.10); 자동 설치하지 않는.

**No 로컬 인덱스 옵션이 제공됩니다.** (deliberately 제외 - naive Local index degrades result quality; 우리는 실제 공급자 또는 파일 전용 grep로, 반으로 배치 된 사내 인덱스).

### 통합 표면 (no MCP 필요)

각 공급자는 런타임 제거 가능한 표면을 노출합니다. gstack는 CLI 포탄 밖으로 또는 평야 HTTP로 그(것)들을 몰고 있습니다. MCP는 결코 말하지 않습니다:

- **GBrain / 그래프: CLI.** 포탄 밖으로 (`spawnSync`), 동일한 모양 및 동일
  ENOENT→`PROVIDER_UNAVAILABLE`는 기존의 gbrain 접착제로 degrade.
- **Sourcebot: HTTP + 구성 파일 편집.** `POST /api/search` 쿼리 및 a
  JSON 서버의 `config.json`의 편집은 repo를 등록하기 위하여. `fetch`는 그루브, no 살아있는 서버에 대하여 실행하는 주사 가능한 주사 가능한.

Sourcebot과 Graphify는 에이전트 사용을위한 MCP 서버를 발송합니다. 계약은 CLI/HTTP 표면이 런타임에서 인덱스 및 검색에 충분하기 때문에 그들에 따라 달라지지 않습니다.

## Picker: GBrain를 처음 추천합니다

`lib/code-intelligence/picker.ts` + `selection.ts`. 사용자는 `gstack-code-intelligence select <provider>`, `$GSTACK_HOME/code-intelligence.json`에 persisted를 가진 공급자를 선택합니다. `resolveSelectedProvider()`는 선택된 공급자를 건설하거나, `null`를 선정할 때 반환합니다 - 공급자OFF 경로는, 그라프/파일 전용 결정 상점에 degrade를 degrade. 가용성은 호출 시간에 입증됩니다: CLI/server가 `PROVIDER_UNAVAILABLE`를 던지는 선택된 공급자는, 호출자 잡음과 degrade에 던집니다.

`RECOMMENDED_ORDER`는 정적 **GBrain → Sourcebot → 그래프** 사실입니다 - GBrain는 항상 처음 추천됩니다. `detectAvailable()` 조사는 `options`/`status` 전시 (GBrain를 위한 각 공급자를 진짜 `localEngineStatus()`를 통해 Graphify; 그것의 CLI/graph 존재를 통해 Graphify; HTTP liveness probe)를 통해 Sourcebot. 피커는 결코 침묵하지 않는 도구를 결코 선호하지 않습니다.

## 이 현재 GBrain 접착제를 대체하는 방법

계약은 솔기입니다; 비스듬한 접착제는 그것에 붕괴합니다. 모자를 씌우기:

| 오늘 (아침) | 계약의 밑에 |
|-----------------|--------------------|
| `bin/gstack-gbrain-sync.ts` (`sync`/`reindex-code`/`sources`) | `provider.registerSource` / `provider.refresh` |
| `lib/gstack-decision-semantic.ts` `semanticRecall` | `provider.search` (scoped) → 동일한 degrade-to-null |
| `bin/gstack-brain-context-load.ts` (`query`/`list_pages`) | `provider.search` / `provider.status` |
| `bin/gstack-memory-ingest.ts` (`import`, 넣어) | `provider.add` (선택적인 모자; GBrain 전용) |
| `lib/gbrain-sources.ts` (`ensureSourceRegistered`, `probeSource`) | GBrain 어댑터 내부 |
| `lib/gbrain-local-status.ts` | GBrain 어댑터 사용 가능 probe (kept, 재사용) |
| `bin/gstack-gbrain-detect` / `-install` / `-source-wireup` / `-repo-policy` | 공급자 설정 + 피커 + 동의 (저녁 식사) |

포인트는 1 commit에서 17k LOC를 삭제하지 않습니다. 모든 소비자가 계약을 호출하는 것입니다. 그 뒤에있는 bespoke 경로 공급자 -by-provider를 은퇴합니다. "내 코드를 검색하거나 degrade"가 완전히 gbrain 특성을 가져 중지하는 소비자.

## 롤아웃

단계적으로, 각 단계는 독립적으로 반전할 수 있습니다. Skill-template 편집은 나중에 단계로 정확하게 파열되어 있기 때문에 첫 번째 슬라이스는 `gen:gstack2`/파리 re-baseline 주기를 트리거하지 않습니다.

- **단계 1 (이 슬라이스): 계약, 세 가지 실제 어댑터, 그리고 사용 가능한 CLI.**
  `contract.ts` + 완전하게 제거 GBrain (CLI), Graphify (CLI), Sourcebot (HTTP + config) 어댑터 + 선택 저장소 + `gstack-code-intelligence` CLI (`options`/`status`/`select`/`consent`/`index`/`search`) + 테스트. 사용자는 `options`/>/`status`/`select`/`consent`/`index`/>/`search`를 선택할 수 있습니다.
- **2단계: 계약을 통해 내부 소비자를 경로.** 포인트
  `gstack-decision-semantic` 및 `gstack-brain-context-load` `resolveSelectedProvider()`, 정확하게 degrade-to-null를 보존합니다. 파일 전용 경로에 대한 Behavior-neutral.
- **3 단계 : 기술에 표면 선택.** 현재의 피커를 제공합니다.
  기술은 `context` 명령의 정당화 동의 프롬프트를 반영하여 색인 검색에서 혜택을 받을 수 있습니다. 재생 기술 (`bun run gen:gstack2`), 재 실행 `bun run test:gstack2`, 재베이스 패리티 의도적으로.
- **단계 4: 은퇴 bespoke 접착제.** 각 소비자가 계약에 한 번,
  sync/ingest/cache 엔트리포인트 및 테스트 제공업체by-provider를 삭제합니다.

## 실제 환경에 대해 검증

모든 세 개의 어댑터는 격리 된 환경에서 실제 도구에 대해 구동되었다 (파넬 에이전트, 하나의 워크 트리 각), 그리고 모든 세 개의 인덱스 + 실제 repo 종료. 두 라운드 ran, 첫 라운드의 고정은 실수를 포함했기 때문에 실제 실행이 잡힌 - 여기에 정직하게 기록.

- **GBrain - 실제 Postgres+pgvector (Docker), gbrain 0.42.56 - PROVEN.** The
  default pglite/WASM 엔진은 macOS (upstream garrytan/gbrain#223)에서 끊어지므로, `DATABASE_URL`를 통해 실제 Postgres에서 작업하는 레시피 포인트 gbrain을 사용합니다. 실제 코드 정의 (`[0.88] src-checksum-ts … export statement computeChecksum`)를 반환합니다. 실제 실행은 **내가 소개 한 회귀**를 붙였습니다. `refresh` `--help`를 기반으로 `refresh`에서 `--strategy code`를 제거했습니다. 검증된 두 패스(`sync`, `sync --strategy code --full`); `--federated` 등록은 글로벌 검색에 대한 로드 베어링입니다. 또한, 이전 수정: `PROVIDER_UNAVAILABLE` (일대 메시지) 대신 `PROVIDER_ERROR` + WASM 스택 덤프로 엔진다운을 업그레이드합니다.
- **Sourcebot — 라이브 v6.5.0 (Docker) — PROVEN 열쇠가 없는.** 엔드포인트, 몸, 그리고
  응답 파싱은 실제 서버에 대해 정확했습니다. 먼저 잘못된 결론을 수정하십시오. Sourcebot은 **not**가 로컬 사용을위한 API키가 필요합니다. 익명 액세스를 가능하게하는 (`FORCE_ENABLE_ANONYMOUS_ACCESS=true`)은 `/api/search`키리스를 제공하며, CLI를 no키 세트로 실제 히트로 확인했습니다. 주요 선택 사항; 유일한 수정은 메시징 (포인트 사용자 익명 액세스를 먼저, ramback) 플러스 로컬 no키 세트로 로컬 입력해야합니다. `remote.origin.url`키 설정의 핵심은 선택 사항입니다. 로컬 도구 (코드는 기계에 체재; `SOURCEBOT_TELEMETRY_DISABLED=true`를 제외하고 부트 telemetry ping.
- **graphify — 실제 설치, graphify 0.9.23 — PROVEN.** 이전 수정
  wrong claim of mine: for **의 특징**, `graphify <dir>` and `graphify update <dir>` produce the identical AST graph with **no LLM 호출**; the LLM only renames community clusters and ingests non-code docs, adding zero nodes/edges, and our parser discards the field it touches. So there is deliberately no LLM mode, and `local=true` is correct. The adapter uses `graphify update`; real `index`+search returned correct `file:line` refs. Also fixed: `search`는 이제 repo의 그래프(퍼스트 루트)를 읽어보고, `options`는 설치된 공급자를 볼 수 있습니다.

더 큰 수업은 기록에 보관: `--help` 독서 또는 단일 에이전트의 결론은 실제 도구가 실행되지 않습니다. 그것은 내 첫 라운드 통화의 두 역방향 (gbrain flag removal and graphify LLM claim).

## NOT 변경은 무엇입니까?

GStack 2개의 운하 계약과 CLAUDE.md 경계: no 구름 브라우저, no 교체 iOS 드라이버, no 로컬 이미지 모델, no 제공 업체 마켓 플레이스, no 워크플로우 엔진, **no 새로운 국가 데이터베이스**. Context.dev는 웹 컨텍스트를 위한 유일한 새로 허가한 외부 서비스를 유지합니다; 이 계약은 코드 인텔리전스, 별도의 축을 지배합니다. 기존의 저장소 결정 및 컨텍스트 복구 파일 및 의존성 공급자.

## 테스트

`test/code-intelligence.test.ts` (19 테스트, no 살아있는 도구): 기능 매트릭스 invariants (모든 공급자는 4를 요구했습니다 광고합니다; 단지 GBrain는 문서 ops를 광고합니다; `local` 깃발, 루프백 vs-remote Sourcebot을 포함하여); 결과 패서저; 선택 상점 + per-repo 동의 + 공급자-OFF (`null`); 동의하는 gating (GBrain 비 지역 없음-> 제외); 지방은 `gbrain`를 위해, GBrain를 위해, GBrain를 버려집니다; Graphify 어댑터에 대한 가짜 `graphify` shim (index는 그래프를 구축, 검색은 표시, 상태 카운트 노드를 반환); 주사 `fetch` + 임시 `config.json` (등록은 로컬 git 연결을 작성, 검색지도 `files[]`를 검색); 그리고 도구`PROVIDER_UNAVAILABLE`에 각 어댑터를 분해하는 경우 `PROVIDER_UNAVAILABLE`. `gstack-code-intelligence` <7/> (내선) → Graphify → 로컬 Graphify → Graphify → Graphify → Graphify → Graphify → shim (내선)
