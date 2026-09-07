# Browser-Skills v1 — 반복된 브라우저 흐름을 조정

**상태:** 1 단계는 `garrytan/browserharness`에 발송했습니다. 2-4는 아래에 과잉했습니다. **업데이트:** 2026-04-26 **저자:** garrytan (/plan-eng-review와 /codex 외부 송장 검토에)

## 이 것

Browser-skills는 deterministic Playwright 스크립트로 반복된 브라우저 흐름을 공동화하는 per-task 감독입니다. 각 기술에는 다음과 같은 기능이 있습니다.

```
browser-skills/<name>/
├── SKILL.md                        # frontmatter + prose contract
├── script.ts                       # deterministic logic
├── _lib/browse-client.ts           # vendored copy of the SDK
├── fixtures/<host>-<date>.html     # captured page for tests
└── script.test.ts                  # parser tests against the fixture
```

사용자 (또는, 단계 2, 단지 흐름을 가지고있는 에이전트) 한 번 기술을 만듭니다. 미래 주장은 스크립트를 실행, 대신 30 초의 대신에 200ms에서 JSON 에이전트가 다시 탐험을 태울 것입니다 `$B` 원시.

배송된 참고는 `hackernews-frontpage`: HN 프론트 페이지에 스크랩을 스크랩으로, JSON 으로 30개의 이야기를 반환합니다. `$B skill list` 와 `$B skill run hackernews-frontpage` 를 사용해보십시오.

## 왜 이것은 도메인 스킬 (v1.8.0.0)과 다릅니다.

- **도메인-skills** = "현지가 사이트에 대한 사실을 기억한다." JSONL 메모 키 입력
  hostname에 의해, 세션 시작에 신속한으로 주사. 주 기계는 quarantine → 능동태 → 글로벌 프로모션을 처리한다.
- **브라우저 skills** = "현지가 정의된 스크립트로 절차를 조정합니다."
  `$B skill run`를 통해 실행된 Per-task 감독은, per-spawn 기능 고립을 위한 daemon에 있는 범위가 있는 토큰입니다.

두 가지는 동일한 정신 모델 (per-host, 세 계층 scoping)을 사용합니다. 절차 층은 늦게 공간에서 긁고 형성 자동화를 밀어서 재현 가능한 코드로 더 큰 생산성이 살아가는 곳이다.

## 왜 이것은 기존 P1 ("self-authoring `$B` 명령")이 아닙니다.

P1는 Codex의 T1 objection: 에이전트-authored TypeScript에 안전하게 달리할 수 없는 *내부의*에 daemon (근처적인 세계적인, 건축가 가제트, 승인과 실행 사이 top-level-await TOCTOU)에 막혔습니다. 적당한 디자인은 “기능 통과 IPC를 가진 처리 노동자 고립이었습니다. 그것은 결코 배선하지 않을 것이라는 단단한 프로젝트입니다.

브라우저 스킬은 실행 스크립트 *의외*를 실행하여 전체 문제를 멈춘다. 독립 Bun 프로세스로 daemon. daemon은 결코 수입하거나 evals 기술 코드를 가져옵니다. 스킬은 루프백 HTTP를 통해 데몬에 이야기합니다. - 어떤 외부 클라이언트가 사용할 수 있는 동일한 와이어 형식.

승인 된 플랜은 기존 P1를 대체합니다.

---

## 파싱

| Phase | 팟캐스트 | 범위 |
|-------|--------|-------|
| **1** | `garrytan/browserharness` | SDK, 저장, `$B skill list/run/show/test/rm` subcommands, 범위가 있는 모형, 묶인 `hackernews-frontpage` 참고. **선박 (v1.19.0.0, 단계 2a로 통합).** |
| **2아** | `garrytan/browserharness` (지속) | `/scrape <intent>` (읽 전용, 경기/prototype 경로와 단일 항목 포인트) + `/skillify` (영속 기술로 프로토타입을 지정합니다). `browse/src/browser-skill-write.ts` D3 원자 씁니다 돕기 추가하십시오. **배송 v1.19.0.0.** |
| **2b의** | 새로운 (`browser-skills-automate`) | `/automate` 기술 템플릿 (`/scrape`의 mutating-flow sibling). `/skillify`와 D3 돕는 사람을 재사용합니다. 비 응집을 실행할 때 Per-mutating-step 확인 문. P0 TODOS. |
| **3** | 새로운 (`browser-skills-resolver`) | 세션 시작 (per-host browser-skill discovery)에서 해결사 주입. 거울 도메인-skill 주입. `gstack-config browser_skillify_prompts` 손잡이. |
| **4** | 의 새로운 | Eval 테스트 인프라 (LLM-judge), 고정식-staleness detection, 라이브 페이지에 대한 정기적인 재효율, OS-level FS 샌드박스 for untrusted spawn. |

---

## 1단계 건축

### 결정 고정 (13)

1. **단계 1 = 전체 저장 + SDK + subcommands + 번들 된 참조.** 에이전트 없음
   아직 승인. 2위 `/scrape` 및 `/automate`를 단계로 합니다.
2. **2단계: `/scrape` (읽기 전용) 및 `/automate` (변이).**
   기술 승인 게이트 기계와 함께 살아남을 수 있습니다.
3. **TODOS.md의 P1 P1를 대체합니다.** 동일
   사용자 가능 목표, 아니 in-daemon 고립 문제.
4. **SDK 배포: 각 기술 내부의 파일 활성화 (Option E).** The
   canonical SDK는 `browse/src/browse-client.ts` (~250 LOC)에 생명을 줍니다. 각 기술은 `<skill>/_lib/browse-client.ts`에 사본을 발송합니다. 단계 2의 발전기는 각 생성한 스크립트를 따라서 현재 SDK를 복사합니다. 각 기술은 완전히 각자 포함합니다: 어디에서나, 그것 달리는 디렉토리를 복사하십시오. 버전 무해한 (SDK는 버전에 기술에 의해 허가되었습니다). 디스크 비용: ~3KB 기술 당.
5. **세 계층의 조회: 번들 → 글로벌 → 프로젝트.** 번들 기술 배
   gstack install (`<gstack-install>/browser-skills/<name>/`)와 함께 읽기 전용. `~/.gstack/browser-skills/<name>/`의 글로벌. `<project>/.gstack/browser-skills/<name>/`의 프로젝트. 우선순위 프로젝트 → 글로벌 → 번들; 처음 승리를 걸었다. **`$B skill list` 각 기술 이름을 따라 해결된 계층을 인쇄** 그래서 "왜 그것을 실행 했습니까?"는 벌레잡기 미스터리가 결코 없다.
6. **신뢰 모델: 스파크 시간에 범위 토큰, NOT env-scrub-as-sandbox.**
   아래 "Trust model"을 참조하십시오. (Codex 이후 원래 env-scrub 플랜에서 보안 극장으로 가져 오기.)
7. **진실의 단 하나 근원: SKILL.md frontmatter 전용.** `meta.json` 없음.
   Frontmatter는 호스트, 트리거, args, 버전, 소스, 신뢰할 수 있습니다. SHA256/staleness는 4 단계로 모든 토지에 착륙하면 별도의 `.checksum` 사이드카로 묶습니다.
8. **INDEX.json. 디렉토리를 걸어.** `$B skill list`는
   세 개의 계층과 각 SKILL.md frontmatter를 파로합니다. 50의 기술을 위해 ~5-10ms. 전체 "디스크에서 드리프트 된 인덱스" 버그 클래스를 제거하십시오.
9. **`$B skill run` 산출 의정서.** stdout = JSON. stderr = 스트리밍
   logs. Exit 0 / nonzero. Default 60s timeout, override via `--timeout=Ns`. Max stdout 1MB (truncate + nonzero exit if exceeded). Matches `gh` / `kubectl` / `docker` conventions.
10. **정착물 재생: 2개의 시험 유형을 위한 2개의 본.** SDK 단위 시험
    in-test 모조 HTTP 서버가 서 있습니다. 스크립트의 수출된 파서 기능 (no daemon required)를 통해 end-to-end 기술 시험 파스 번들 HTML 정착물을 통해. 단계 1 정착물 전용은 `hackernews-frontpage`를 위해 적절합니다; 단계 2 `/automate`는 부자 정착물이 필요로 할 것입니다.
11. **참조 기술 : `hackernews-frontpage`.**스크랩 HN 프론트 페이지
    (제목, 포인트, 의견). 오, 안정된 HTML, 이상적인 고정 테스트 대상 없음.
12. **토큰/port 발견: 스패딩 기술에 대한 범위가 있는 env-only;
    독립 디버그 실행을 위한 state-file fallback.** `$B skill run`를 통해 스파게팅할 때 SDK는 env에서 `GSTACK_PORT` + `GSTACK_SKILL_TOKEN`를 읽습니다. 독립 `bun run script.ts`를 위해 SDK는 `<project>/.gstack/browse.json` (`config.ts:50` 당 실제적인 state-file 경로)로 돌아갑니다.
13. **CHANGELOG 솔직히.** 단계 1 지도: 인간은 deterministic를 씁니다
    gstack가 실행되는 브라우저 스크립트. 그 다음 릴리스의 토지를 승인하는 에이전트가 명시적으로 1 단계. No fabricated perf number — Phase 1은 이전이 없습니다/after.

## Trust 모델 (예시 #6)

2개의 직각 축:

| 의 확장 | 의례 | 의 기본 |
|------|-----------|---------|
| **daemon사이드 기능** | `read+write` 범위에 묶는 Per-spawn 범위 토큰 (17 cmd 브라우저 건조 표면, minus admin 명령은 `eval`/`js`/`cookies`/`storage`)와 같은 명령을 붙입니다. 단일 용도 clientId 인코딩 기술 이름 + 스파드 ID. 스파드 출구 때 레크리에이션. | 항상 범위 (다에몽 루트 토큰). |
| **Process-side env 액세스** | SKILL.md frontmatter `trusted: true` passes `process.env` minus `GSTACK_TOKEN`. `trusted: false` (default) drops everything except a minimal allowlist (LANG, LC_ALL, TERM, TZ, locked PATH) and explicitly strips secret-pattern keys (TOKEN/KEY/SECRET/PASSWORD, AWS_*, AZURE_*, GCP_*, ANTHROPIC_*, OPENAI_*, GITHUB_*, etc.). | 위탁 (무엇을 선택). |

`GSTACK_PORT`와 `GSTACK_SKILL_TOKEN`는 항상 마지막 주사되기 때문에 부모 과정은 env에서 그(것)들을 놓기 위하여 그(것)들을 과도하게 할 수 없습니다.

**이 얻은 것:** daemon-side ranged 토큰은 daemon에 의해 시행됩니다. `eval` (admin 범위)를 호출하는 기술은 SDK가 노출되었더라도 403을 얻습니다. 기능 경계는 오른쪽에 있습니다.

**NOT 닫기는 다음과 같습니다:** Bun는 FS sandbox에서 건축되지 않았습니다. 위탁한 기술은 아직도 `import 'fs'`를 할 수 있고 OS 사용자는 (예를들면 `~/.ssh/id_rsa`)를 읽을 수 있습니다. env는 위생, sandbox 아닙니다. OS 수준 고립 (`sandbox-exec`, namespaces)는 4개 일이고 기존의 신뢰/untrusted 계약의 뒤에 청결하게 하락합니다.

env-scrub a sandbox라는 원래 계획. Codex 정확하게 극장으로 옮겼다. 개정 된 계획은 그것이 무엇인지 호출 : 최고의 노력 위생 플러스 방어 심도, daemon-side 범위 토큰에서 실제 경계와.

## 파일 레이아웃

```
browse/src/
├── browse-client.ts                # canonical SDK (~250 LOC)
├── browser-skills.ts               # 3-tier walk + frontmatter parser + tombstones
├── browser-skill-commands.ts       # $B skill list/show/run/test/rm + spawnSkill
└── skill-token.ts                  # mintSkillToken / revokeSkillToken wrappers

browser-skills/
└── hackernews-frontpage/           # bundled reference skill
    ├── SKILL.md
    ├── script.ts
    ├── _lib/browse-client.ts        # byte-identical copy of canonical
    ├── fixtures/hn-2026-04-26.html
    └── script.test.ts

browse/test/
├── skill-token.test.ts              # mint/revoke lifecycle, scope assertions
├── browse-client.test.ts            # mock HTTP server, wire format, auth
├── browser-skills-storage.test.ts   # 3-tier walk, frontmatter, tombstones
└── browser-skill-commands.test.ts   # parseRunArgs, dispatch, env scrub, spawn

test/skill-validation.test.ts       # extended: bundled-skill contract checks
```

### NOT 변경은 무엇입니까?

- 도메인-스킬 저장, 주 기계, 또는 주입. Untouched.
- Tunnel-surface 수당 (`server.ts:118-123`). 17개의 명령과 동일합니다.
- L1-L6 보안 스택. 브라우저-skills는 텍스트를 프롬프트로 주사하지 않습니다.
  단계 1; 단계 3의 결심자 주입은 기존의 UNTRUSTED 봉투를 탈 것입니다.
- `cli.ts` HTTP 클라이언트 `sendCommand()`. SDK는 분리된 단위입니다
  다른 관심사 (리브레 대 CLI 과정).

---

## Codex 외부 송장 발견 (post-review responses)

/codex 검토는 8개의 발견을 뜹니다. 계획은 다음과 같이 그(것)들을 요구합니다:

| # | Finding | 단계 1 응답 |
|---|---------|------------------|
| 1 | 신뢰 모델은 FS sandbox없이 가짜입니다. | **Closed** 은 위의 #6 (경찰 토큰)에 의해 결정됩니다. |
| 2 | 1 단계는 1 번들 기술 (lookup 계층, 묘비 등)에 대 한 overbuilt | **자주 묻는 질문** 사용자는 단계 2개의 땅 에이전트 허가의 앞에 건축술을 잠그기 위하여 전 단계 1를 선택했습니다. 각 subsystem는 자료가 나중에 그것을 사용하지 않는 경우에 청결한 제거하게 작습니다. |
| 3 | `cli.ts:398`의 클라이언트 패턴을 주장하는 SDK 중복 | **인증된 false.** 선 398는 `extractTabId()` ( 플래그-파서)의 끝입니다. 실제 HTTP 클라이언트는 cli.ts에 `sendCommand()`입니다: 401-467, 그러나 CLI 결합된 (`process.stdout.write`, `process.exit`, 서버-스트 회복)입니다. 도서관으로 재사용하지 마십시오. 새로운 `browse-client.ts`는 그것의 철사 체재를 거울하지만 도서관 모양입니다. |
| 4 | "첫 번째 히트 승리"참조는 opaque입니다 | **의논하기** `$B skill list` 및 `$B skill show`에서 해결된 계층 인라인을 나열하여. 미래: 옵션 `--source Bundled\|글로벌 \|프로젝트` 플래그 if tier override는 혼란을 증명합니다. |
| 5 | 원자 기술 포장은 색인 질문 보다는 좀더 사정합니다; symlink 방위 | **1단계 정기휴일**: gstack 설치의 일환으로 번들 기술 배 (라이브 쓰기 없음; 설치 디디에 있는 읽기 전용 파일의 virtue에 의하여 원자). 단계 2's `writeBrowserSkill`는 임시 직원 디디에 그 때 이름을 쓰고, `realpath`/`lstat` 분야를 사용하십시오 (`browse/src/path-security.ts`를 제외하고). |
| 6 | 2단계 활성 피드의 합성은 약합니다 (lossy ring buffer) | **2단계 디자인의 오픈 이슈.** 활동 피드는 원격 측정법, 재생 IR 아닙니다. 2 단계는 구조화한 레코더 OR가 자체 컨텍스트를 사용하여 찰상에서 스크립트를 작성하는 것을 다시 프로mpting해야 합니다. 단계 2의 디자인 패스에 결정하십시오. |
| 7 | Bun 런타임 회귀: 스킬 스크립트는 독립 Bun 런타임 요구 사항을 재분해합니다. | **2단계 배포를 위한 오픈 이슈.** 단계 1는 gstack 설치 (이렇게 Bun) 안쪽에 묶인 참조 기술 배 때문에 이것에 묶인 단계 1 측 단계. 단계 2는 `cli.ts`의 HTTP 본을 가진 Bun 이진 사이에서 결정하는 것을 요구합니다, (b) 각자 달성한 실행 가능한, 또는 (c)에 기술을 비교합니다. |
| 8 | `file://` 정착물은 timing/auth/navigation/lazy 수화를 증명하지 않습니다 | **문서 제한.** `hackernews-frontpage`를 위해 적절합니다. 2 단계 `/automate`는 타이밍을 가진 더 부유한 정착물 (매우 daemon, 기록된 HAR 재생, 등)를 필요로 할 것입니다. |

---

## 단계 2a — `/scrape` + `/skillify` (선박 v1.19.0.0)

Two skill templates plus one helper module. `/scrape <intent>` is the single entry point for pulling page data; first call on a new intent prototypes via `$B` primitives and returns JSON, subsequent calls on a matching intent route to a codified browser-skill in ~200ms. `/skillify` codifies the most recent successful prototype into a permanent browser-skill on disk. Mutating-flow sibling `/automate` deferred to Phase 2b (P0 in TODOS).

## v1.19.0.0 플랜 검토 중 잠긴 결정 (`/plan-eng-review`)

| ID | 의약 | Locked 행동 |
|----|----------|-----------------|
| **D1** | `/skillify` 검증된 감시 | 다시 걸어 ≤10 에이전트 명확하게 반란 `/scrape` invocation (실험자의 의도 라인 + 그것의 트레일 JSON 출력)을 찾고. 발견되지 않은 경우, 거부 : *"최근 /scrape이 대화에서 발견 된 결과. /scrape <intent>를 먼저 실행하면 /skillify라고 말했습니다.* 침묵의 미백. |
| **D2** | Synthesis 입력 슬라이스 | 템플릿은 ONLY를 추출하는 에이전트를 지시합니다. JSON를 생성한 최종 호출은 허용된, 사용자의 의도한 문자열을 제외하고, JSON를 호출합니다. 드롭은 선택자 시도, 관련 채팅을 드롭하고, 이전 세션 내용을 삭제합니다. Codex를 찾는 것은 #6를 선택하여 옵션을 (b) (통제의 자체 컨텍스트에서 제거, 구조화 된 레코더가 아닙니다). |
| **D3** | Atomic 쓰기 분야 | `/skillify`는 `~/.gstack/.tmp/skillify-<spawnId>/`로 쓰여져, 임시 dir에 대하여 `$B skill test`를 실행하고, 성공 + 사용자 승인에 마지막 층 경로로 만 이름을 붙여 넣습니다. 시험 실패 또는 승인 거부: `rm -rf`는 전적으로 (무반적으로 승인되는 기술을 위한 묘비 없음)를 부인합니다. 새로운 단위 `browse/src/browser-skill-write.ts` (`stageSkill`/`commitSkill`/`discardStaged`)를 `realpath`/`lstat`/>/`lstat`/>를 찾은 분야를 찾아봅니다. |
| **D4** | 시험 범위 | 5 문 층 E2E (스크랩 일치, 스크랩, 기술적인 행복, 기술적인 입증된 refusal, 승인 문 거부) + 1 단위 시험 (원료 쓰기 돕기 실패 정리) + 1개의 손 확증된 연기 (mutating-intent refusal). `test/helpers/touchfiles.ts`에 등록하십시오. |

## # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

- **기본 계층: 글로벌.** Lean 글로벌 절차, per-project
  `/skillify` 시간 (mirrors 도메인 - skill 범위)에 과도. 단계 1 저장 돕는 두 개의 룩업 경로 지원.
- **Bun 런타임 배포.** Codex #7 를 찾는 것은 열려있습니다. 2a 단계는 가정합니다
  Bun는 PATH (gstack 이미 `setup:6-15`)를 통해 그것을 요구합니다. `/skillify` SKILL.md "Limits"에서 문서화했습니다. 단계 4.에 있는 진짜 고침 땅.

## 단계 2b — `/automate` 스케치

Mutating-flow sibling of `/scrape`. Same skillify pattern (reuses `/skillify` and the D3 helper as-is). Difference: per-mutating-step UNTRUSTED-wrapped summary + `AskUserQuestion` confirmation gate when run non-codified. After codification, the skill runs unattended (the codified script enumerates exactly which `$B click`/`fill`/`type` calls run). See P0 entry in `TODOS.md`.

## 3 단계 스케치

세션 시작에 해결사 주입. `server.ts:722-743`에서 도메인 스킬 주입을 미러:

```ts
const browserSkillsBlock = await renderBrowserSkillsForHost(hostname, projectSlug);
if (browserSkillsBlock) {
  systemPrompt += `\n\n${browserSkillsBlock}`;
}
```

`renderBrowserSkillsForHost()`는 3개의 층을 읽고, `host` 분야 경기를 기술하는 여과기는, 그리고 그(것)들을 목록으로 만드는 UNTRUSTED 주름을 잡는 구획을 방출합니다.

`gstack-config browser_skillify_prompts` (과태 떨어져): 때, `/qa`, `/design-review`, 등에서 end-of-task nudges에, 활동 급식 쇼 ≥N 명령을 단일 호스트 AND에 보여주면 그 host+intent를 위해 아무 기술도 존재합니다.

## 4 단계 스케치

- LLM-judge eval ("재수술 대신 기술에 대한 에이전트 도달을 습득합니까?").
- Fixture-staleness detection - 실시간 페이지에 대한 번들 된 고정물을 비교합니다.
- OS-level FS 샌드박스 for untrusted spawns (`sandbox-exec` on macOS,
  네임스페이스 / Linux에서 seccomp).
- `$B skill upgrade <name>` - SDK 복사를 재생
  canonical SDK 변경.

---

## 검증 (상 1)

`bun test`는 새로운 시험 파일을 전달합니다:
- `browse/test/skill-token.test.ts` - 15개의 주장
- `browse/test/browse-client.test.ts` — 26개의 주장
- `browse/test/browser-skills-storage.test.ts` - 31개의 주장
- `browse/test/browser-skill-commands.test.ts` - 29개의 주장
- `browser-skills/hackernews-frontpage/script.test.ts` - 13개의 주장
- `test/skill-validation.test.ts` — 7개의 새로운 번들 skill assertions

daemon 실행에 종료:

```bash
$B skill list                            # shows hackernews-frontpage (bundled)
$B skill show hackernews-frontpage       # prints SKILL.md
$B skill run hackernews-frontpage        # returns JSON of 30 stories
$B skill test hackernews-frontpage       # runs script.test.ts
```
