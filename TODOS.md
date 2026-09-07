# TODOS

## NEXT PRIORITY

## P1: ZeroEntropy 일몰 — gbrain's default embedding 공급자는 Sept 4, 2026 (#2365) 죽습니다

**이름:** ZeroEntropy (노션에 의해 요구)는 9 월 4, 2026을 종료합니다. gbrain의 Zeroentropyai 조리법은 이전 경로가 필요합니다 ( 레시피 + 게이트웨이는 gbrain-internal - 절대로 제공되지 않습니다. gstack 공급자를 권장했습니다.

**왜:** 단단한 외부 마감일. 9월 4일 후에, 조리법 정지에 뇌는 새 페이지를 조용히 삽입했습니다.

**(gstack 측, v1.69.0.0):** wireup warns when ~/.gbrain/config.json는 조리법 (실열한 grep), 설정-gbrain 공급자 의견이 그것을 선정하지 말하지 말, USING_GBRAIN_WITH_GSTACK.md는 문제 해결 항목 (#2365)을 얻었다.

**노력:** M (주요 일은 gbrain 측 공급자 지원입니다). **우선 순위:** P1 (주요 몬). **에 따라:** gbrain 상류 공급자 지원.

## P2: v1.67 고정파 수식 — 다음 파 수

v1.67.0.0 구현 시간 (파 계획의 "이 파에서 계산 참조)에 Filed. 각 합리적으로 합리적으로 떨어졌다, 떨어졌다:

- **#2522 Windows omnibus 광업** - 대상 Windows는 착륙
  v1.67 (#2414/#2510/#2561/#2542/#2452-half); omnibus PR는 아직도 의사/migration 지상 추출물을 나르고 있습니다. CC를 가진 노력 M→S.
- **#2443 AskUserQuestion 재설계** - 실제 잡화 (brief Letter)
  호스트 렌더링 번호), 하지만 신속한 행동의 기본을 이동 하는 신속한 비동기 재 설계; 기본 새로 고침으로 자신의 PR 필요. Effort S.
- **#2447 typecheck infra를 입력합니다.** - tsconfig + repo-wide typecheck 스크립트 + 미스트nt
  유형 수정. 높 가치, repo 넓은 폭발 반경, 자신의 PR 굽기 시간. 현재 주요에 Re-derive (그 때문에 고정의 심각).
- **#2492 프로젝트 Chromium 프로필** - On-disk 마이그레이션을 필요로 합니다.
  기계 넓은 단면도 default와 SingletonLock scoping를 위해. Effort M.
- **#2286 `triggers:` frontmatter** — Claude Code 라우터는 결코 읽지 않습니다
  키; 설명 비용 카탈로그 토큰에 음성 트리거를 접. 유지 보수가 필요 토큰 - 판결 결정 (catalog 캡은 시행). Effort S.
- **#2378 출시 태그 업그레이드** - 업데이트 체크 게이트
  main:VERSION 업그레이드는 메인 HEAD를 설치하고, 릴리스 사이에 앉아. 디자인 결정: 태그 핀 설치 대 HEAD. Effort M.
- **기능-PR 삼기 큐** — #2564 (/deck), #2497 (브로이스 기록 — 베스트 오브
  the batch), #2476 (a11y review, unblocked by the CDP media-emulation entry landed in v1.67), #2446 (Cua), #2448 (tiered outside voice), #2412 (lens layer), #2241 (/grok), #2507 (pi host), #2298 (Kimi host), #2438+#2436 (gbrain doc-sync pair, ordered), #2442 (portable skill roots), #2534 (gbrain MCP routing), #2535 (outside voice for /investigate,/cso,/devex), #2576 (fast-ship rework — re-evaluate against v1.66's CI speedup), #2580 (land-and-deploy CI tiers — human-gate UX needs maintainer call).

## P2/P3: v1.78 고정파 방어 (파시 시간에 파일, 합리적으로 각 방어)

- **mermaid 10→11 클래스의 주요 범프 lib/diagram-render** - 파의
  dependency pass cleared 102 of 105 OSV advisories via in-range bumps + overrides; the residual ignores (image-size no-fix, @anthropic-ai/sdk under the harness-pinned agent-sdk) carry `ignoreUntil` expiries (~2026-11-30) and re-justify themselves on expiry. When the agent-sdk pin next moves, drop the GHSA-p7fg ignore. Effort S. **우선 순위:** P3.
- **#2701 쿠키-import 프로필 알 약 (Local State info_cache)** — 확인
  버그 + 최소 수정 알려진, 하지만 PR #2658 동일한 파일을 다시 작성; 토지 또는 거부 #2658 첫째, 다음 info_cache 읽기 + 숫자 인식 정렬을 적용. 불편 S. **우선 순위:** P3. **에 의해 차단:** #2658 분해.
- **#2750 쪼개지는 흡수** - 레코드 수거 Codex JSONL 파서 (실행)
  fix; current Codex streams interleave envelopes so sessions vanish from /retro global) should be absorbed once the author splits it from the bundled schema additions + 1 MiB scan-budget change (asked in the wave's disposition comment). Effort S (review). **우선 순위:** P3.
- **#2709 macOS 실시간 검증** — GPU 플래그 세트는 리포터가 유효하다
  그리고 GSTACK_DISABLE_GPU=off 탈출과 함께 darwin-gated; 정지 경로는 리눅스 테스트입니다. 실제 애플 실리콘 하드웨어 모두 검증 (예를 들어 회전을 0%, 스크린 샷 여전히 작업, M-series 박스에 첫 번째 액세스에 survivor를 죽이는). Effort S. **우선 순위:** P3.
- **정기적일자 안정화 (#2756)** — v1.77의 주간 레인
  shape (73-shard sharded runner, pinned CLI, EVALS_ALL census) has never been green; the v1.78 wave killed the deterministic v1.76 AUQ collapse but the residual set churns (band-edge variance, the pre-existing exited/hits=[] startup class, known flakes). Evidence table + suggested direction (band recalibration against a fresh pinned-container distribution) in the issue. Effort M. **우선 순위:** P2.
- **외부-voice 해결모델 인쇄** — #2735의 두 번째 제안 (인쇄
  파견 시간에 콘크리트 낙하 모형)는 preflight에 있는 기능적인 변화 필요 모형 해결책입니다; 사본 고침에서 descoped. Effort S. **우선 순위:** P3.

### P2: v1.69 고침 파 잔여 (파 시간에, 각각은 합리적으로 묶습니다)

- **`cleanup_prefixed_claude_symlinks` 비대칭 변환** - PR #2634 고정
  `cleanup_old_claude_symlinks` (destination scan, dangling-symlink aware, path-segment provenance); the prefixed-mode sibling still iterates the payload dir (same structural hole: can't reap orphans once the payload is gone) and still uses a bare `*gstack*` substring match the sibling's own tests forbid. Kept out of the contributor's absorbed commit for scope discipline. Effort S→S with CC. **우선 순위:** P2.
- **#2163 레거시-slug 체크포인트 치유** — gstack-slug 재발견
  save/restore 슬러그, 하지만 미리 고정된 슬러그 아래에 작성된 체크 포인트는 여전히 보이지 않는; `bin/gstack-slug`의 자신의 MIGRATION NOTE defers data moves. 싼 치유: NO_CHECKPOINTS를 인쇄하기 전에 교체 슬러그 디드의 probe를 복원합니다. 노력 S. **우선 순위:** P3.
- **#2657 개발자 프로필 `--reconcile`** - 사무실 시간 열렬한 undercounts
  ~3x (상 4.5 전용 로깅; no 타임 라인.jsonl 재구성). arithmetic reproduces; 기자는 문제에 초대 된 PR를 제안했습니다. 트랙 및 리뷰 때 착륙합니다. Effort S (리뷰). **우선 순위:** P3.
- **`hosts/index.ts`에서 테이블 구동 설정 호스트 파견** — 루트 때문에 수정
  #2361 뒤에 허용되는 명부/dispatch 편류 종류; v1.69.0.0는 interim ratchet (accept-list 李俊億 파견 팔 십자가 체크 시험 + 큰 0 dispatch 감시)를 발송합니다. refactor는 그것의 자신의 PR를 굽기 시간 (설정은 repo에 있는 가장 위험한 파일입니다)로 필요로 합니다. Effort M. **우선 순위:** P3.

## P2: v1.67 adversarial-review residuals (확대하고, 합리적으로 쫓아)

Codex + Claude adversarial 패스에서 v1.67 배 시간에 신청하십시오. v1.68 담파 (brain-sync spool-dir 큐, 쌍 에이전트 동의 문, bin-context 도보 파, per-project MCP scoping + precedence 플립, 다음 버전 ls-remote fallback + 폭 핀, 정지 후크 세계적인 지시 + 재점: 재점: 재점: 재점:

- **iOS 탭 창에서 라우팅** - 브리지 템플릿의 frontmostWindow는 할 수 있습니다
  keyboard/menu/transparent 오버레이 창이 가장 높을 때 삼키는 탭은 조정을 처리하지 않습니다. hit-test-aware routing + real-device 검증이 필요합니다. Effort M. (Related: 멀티 윈도우 리깅은 no 정적 핀이 있습니다. - 아래의 테스트-gap backlog를 참조하십시오.)
- **설정:1601 CLAUDE_CONFIG_DIR 정렬** — 기술 설치 프로그램 하드코드
  `$HOME/.claude/skills` settings.json와 후크 등록 명예 `CLAUDE_CONFIG_DIR`; override를 가진 사용자는 쪼개지는 뇌관을 설치합니다. v1.68.1 (가로 가정 경로에 수소 낙하에서, 그러나 설치자는 그 자체를 상속하게 하기 위하여 명예를 줬습니다. **우선 순위:** P3. Effort S.
- **플랜_tune_hooks bool 패싱 + gstack-config 키 검증** —
  `n|no|false|skip|off|0` 부정적인 가치 세트는 triplicated (gstack-settings-hook prune-stale, 설정 치유 주의, 설정 PT_DECISION) 및 gstack-config는 키 유효성 차단의 세 동사적 사본을 나릅니다 (get/has/set).는 `gstack-config` 불 헬퍼 + `validate_key()`를 추출합니다; locale 핀 테스트를 업데이트하십시오. /ship 검토 군대 (주요성)를 통해 신청하십시오. P3 불행성>. P3
- **위협 모델 노트 (documented, no action 계획)를 허용 :**
  redact-prepush는 이미 왼쪽 (경력 전용 위협 모델)으로 ANY 개인 리모트에 밀어넣는 내용이 대우합니다; 400 숯 내의 소포 모양 쌍둥이는 전화 적색 (WARN 층 본, 공격적인 영향 허용); codex-probe's 400 명 중류는 MODEL_UNUSABLE (대략 15 분 부정 캐시 TTL)로 transient 프록시 400를 잘못읽을 수 있습니다.

## P2: 구조화 (v1.68 파 리뷰에서 파일)

**이름:** /skillify는 디스크에 튼튼한 실행할 수 있는 기술 코드로 긁힌 페이지 내용을 켭니다. v1.68 파는 그것의 prose (#2441)에 불신명한 내용 경고를 추가했습니다, 그러나 경고는 지인 페이지 내용 필요 구조상 고립에서 파생된 생성한 행동, 합성한 selectors/names의 sanitization, 또는 생성한 코드에 명시한 승인 단계 scoped.

**왜:** 독된 페이지는 사용자가 결코 검토하지 않는 행동으로 생성된 script.ts를 자극할 수 있었습니다; 현재 문은 단계 9 승인, 코드를 보여주기 위하여 그러나 페이지 파생한 끈을 강조하지 않습니다.

**노력:** M → S CC. **우선 순위:** P2. **에 따라:** none.

## P2: 슬러그 스토어 마이그레이션 — merge 사전 설정 `projects/garrytan/` 데이터 (v1.68 후속)

**이름:** The v1.68 slug-parity fix (gstack-slug now matches remote-slug's owner-repo form) means machines that hit the degraded-slug bug (stray strong marker above a repo, e.g. an empty ~/.git) have historical decisions / timeline / ceo-plans / learnings filed under the marker-basename store (observed: `~/.gstack/projects/garrytan/`) instead of per-repo stores. Define and ship the merge/alias: attribute each misfiled record to its repo where derivable (timeline entries carry branch; 결정은 범위를 수행), 다른 점퍼 파일로 장소에두고.

**왜:** 포스트픽스 세션은 CORRECT 저장을 읽습니다, 그래서 미리 고침 역사는 개조될 때까지 Context 회복에 보이지 않습니다.

**노력:** M → S CC. **우선 순위:** P2. **에 따라:** v1.68 파 (고정 + 패리티 테스트를 발송).

## P3: gstack-slug degraded-heal probe 캐시에 비용 (v1.68 검토 팔리기 발견)

**이름:** v1.68 캐시 자체 치유 프로브 `_resolve_remote` (1-3 git forks)는 EVERY 캐시가 캐쉬드 슬러그가 마커 루트 기본 이름을 동등할 때마다 충돌합니다. 원격 및 레디 스틱 프로젝트의 영구적 인 안정 상태, per-preamble 핫 경로. 캐시 항목 당 단일 샷 sentinel을 추가하십시오. 치유 probe는 한 번 실행하지 않습니다.

**왜:** "Cache hits stay git-spawn-free" only holds for owner-repo slugs today. Cost is bounded (1-3 forks) but paid at every skill start on affected projects. Also next-touch notes from the same review: extract a makeResult helper for BulkResult's 11 hand-copied literals in bin/gstack-memory-ingest.ts; dedup the brain-worktree default-path literal between bin/gstack-brain-sync and bin/gstack-gbrain-source-wireup.

**노력:** S. **우선 순위:** P3. **에 따라:** 캐시 형식 호환성 (이전 독자를 깰 필요가 없습니다).

## P2: v1.67 적용audit 테스트갭 백로 (5 에이전트 스위프트, 등급)

파의 단계-7 적용 감사 (5 하위 시스템 에이전트, ~700 변경 경로, ~84% 덮여) 이러한 잔여 간격을 순위. None 블록 v1.67 (손 또는 인접한 테스트에 의해 확인된 행동); 각각은 침묵 회귀에 대한 저렴 한 핀입니다:

- **설정 Playwright 부츠 스트랩 블록** — `_clear_playwright_quarantine`,
  `_PW_LOCK` stale-holder reclaim, `_kill_tree`/`_wait_with_deadline`, Ubuntu 26.04 플랫폼 override: 0 테스트 참조. P0 #2554 heal's shell Half. Effort S 각각.
- **적정 prepush `scanAddedLines` 접합** — >1MiB 캐치 업 디프 펑크
  경로 (기능이 존재합니다)는 unexercised; 의 회귀 reintroduces 차단-while-unscanned. Effort S.
- **supabase telemetry-ingest 가장자리 기능** - 제로 시험; 생산자 모자에
  200 chars vs ingest's 500 (dead server cap); no column↔migration pin.
- **gbrain-repo-policy-클라이언트** — no 직접 테스트 파일; 스파드 풀드 대
  읽을 수 있는 분할 (그 raison d'être)와 win32 bash-wrapping는 unpinned.
- **확장 클라이언트 절반의 token 부츠 스트랩** — `POST /extension-token` 403
  → 단선 경로 (서버 반은 소각 핀으로 꼿습니다); 또한 핀은 `key` ↔ `GSTACK_EXTENSION_ID`를 통해 extension-id.ts를 나타냈습니다. Effort S.
- **`assertJsOriginAllowed`** - 이 파는 js/eval origin 문을 만들었습니다
  필수; 게이트 자체는 0 직접 테스트가 있습니다. Effort S.
- **`runBoundedChromiumReinstall`** - 모든 치유 시험은 그것을 붓습니다; 120s
  마감 + 공정 그룹 SIGKILL + 스파드 - 오류 branch 결코 실행되지 않습니다.
- **CI 3방향 이미지 태그 편류** — ci-image.yml + evals.yml +
  evals-periodic.yml 각각 hashFiles 태그 표현을 수행, 코멘트에 의해 동기화. 하나의 테스트는 모든 세를 읽습니다. Effort S.
- **evals.yml 모체스 인구** - 침묵-never-ran 클래스 (두 개의 참조)
  이 파는 다시 추가해야 함)에는 no 회원 시험이 있습니다.
- **디자인 문서-discovery 해결자** — 새로운 도난 방지 구획, 0개의 시험
  -nt 신선도 규칙 또는 교차 렌더링 ID.
- **Bridges.swift 멀티 윈도우 리깅** — no 정체되는 핀을 위한
  명령Windows/searchRoots 주문; DebugBridgeTouch의 `#if !defined(DEBUG)` 가드와 Package.swift의 `.define("DEBUG")`에는 no 삼각 (단에 있는 가이드 라인 2.5.1 노출); 패리티 테스트는 주기적인 Lane만 실행합니다.
- **더 작은 핀:** gstack-egress `sanitizeForDisplay`; 동결 디르 tilde
  expansion; gstack-config `pair_agent` key + space-bearing values; session-cookie-store tripwire scope (points at the wrapper, not the factory); redact-patterns `/^pass(word)?$/i` placeholder loosening + compact-timestamp negative; fs-atomic adoption tripwire; tracker-guard `safeSource`; eval-watch `PARTIAL_PATH`; `killProcessGroup`; make-pdf orchestrator `PAYLOAD_TMP_DIR` + CJK stack + smartypants NUL; gbrain-guards `gbrainHome()`; gbrain-local-status `"timeout"` exclusion; 메타컴맨드스 주하운드 와이어 재점;플러시버/audit 0600 인구조사; openclaw `version:` frontmatter drop (pre-wave, main-side — restore extraFields or record as 의도적); terse-build's stale "all 4" set (main-side 5th terse-gated reasonr).

## P2: v1.67 검토-fix-batch 국방 (post-wave 검토 육군 발견)

검토 고정 시간에 파일, 합리적으로 묶음:

- **설정 호스트 기능 dedup** - 4개의 근접 배율 `create_*_runtime_root`
  + `link_*_skill_dirs` 복사 (codex/factory/opencode/cursor) 편
  독립적으로 (#2142 소유권 게이트는 모든 사이트에서 패치되어야 함). 호스트 이름 + 기술 디디렉션에 매개 변수화. CC와 Effort S.
- **cmd.exe `%VAR%` gbrainInvocation 인용에 확장** - Windows 전용,
  검색된 에스컬레이션 (필수 공격자 제어 env var 이름), 하지만 인용은 cmd.exe-safe 되지 않습니다. 방향을 수정: 경로 win32 스패드를 통해 크로스-스패드 (dependency decision — bun-polyfill.cjs 이미 검색 daemon)에 대 한 그것을 운반. Effort S.
- **make-pdf 플래그 레지스트리 메타데이터** — commands.ts 플래그는 문자열을 묶습니다.
  의 범위와 DERIVE cli.ts의 BOOLEAN_FLAGS를 레지스트리에서 추가하십시오 (이 배치에서 추가되는 구조 `--no-*` 시험은 응고 모양만 포함합니다). Effort S.
- **legacy host-glob uninstall 검증된 gating** - gstack-uninstall's
  codex/factory/kiro `gstack*` globs는 여전히 입증된 체크 없이 rm -rf를 rm -rf; 이 배치 (v1.67에 의하여 추가된 커서 기치 문에 동등하게  가져옵니다; 유산 3는 상속한 행동입니다). Effort S.
- **cursor 자동 탐지 빵** - `-d ~/.cursor`는 전체 여분의 트리거
  렌더링 + 모든 ./setup (디버는 IDE를 시작 한 사람에 대한 존재)에 Cursor-having dev에 대한 설치. 제품 호출에 좁은에 CLI 검출 (`command -v cursor`) 또는 선택 플래그. Effort S, 필요 유지 관리 결정에 대한 탐지 계약.

## P2: Persona-fleet hostile-user 마구 (포크 항구 파 2 방어적인)

**이름:** 포트 타임-attack/gstack의 87-hostile-user 필드 실행 (418개의 결과): append-only run.jsonl (예를들면 시간 측정, 절대 자기 허가), 각 메트릭 재해를 기계 검사 캡(300s to first useful output, 900s total, 40KK, 그리고 3/F)과 함께 처리 가능한 계약 체결 (예를 들어, 3/F).
+ `evals/fleet/ABANDONMENT.md` (methodology only — no 주자 코드가 존재합니다.
포트; 이것은 빌드입니다).

**왜:** OUR 44-skill 나무에 대한 정기적인 hostile-user 라운드는 동일한 첫 번째 - 분 실패 클래스를 포크 폐쇄 418의. 새로운 주자로서 기존의 eval-store/e2e 하네스를 적합합니다.

**노력:** L (human ~2wk) → M CC. **우선 순위:** P2. **에 따라:** 비용은 천장 + 저널 저장에 결정합니다.

## P3: 대답 키 eval 방법론 (인테나-fleet 일을 rides)

**이름:** 사전등록된 답변 키 (fork `evals/answer-keys/` — codex-decorrelation, health-trending)는 /codex와 /health를 판사 vibes 대신 심층 진실로 평가했습니다.

**왜:** LLM-judge drift가 알려진 실패 모드인 표면의 결정적인 득점. **노력:** M → S CC. **우선 순위:** P3. **에 따라:** persona-fleet 마구 (shared 주자 모양).

## P3: 분기별 Apple-journey 라이브 재인증

**이름:** 실제 (TestFlight-only)에 대한 /ship Apple release adapter를 실행하면 1/4 또는 첫 번째 사용자 버그 보고서에 대한 첫 번째 사용자 버그 보고서에 대한, 그리고 드립을 수정합니다. Apple의 APIs 이동 (fork 잡은 fastlane price_tier live); 어댑터의 주장은 증거 백업 오늘이며 자체 증거 사본 인용 규칙 당 그 방법을 유지해야합니다.

**노력:** S 런당 **우선 순위:** P3. **에 따라:** 유료 ADP 계정.

## P2: Eval-run 증거 기록 (내용 바인딩 격자를 E2E/evals로 제외)

**이름:** 철사 `bin/gstack-evidence run` eval 엔트리 포인트 (`eval:bg*`, `scripts/test-paid-shards.ts`)로 E2E/eval 주장은 동일한 작업 트리 핀 묶음을 무료로 테스트, 그리고 /land-and-deploy 3.5b 대신 증거 레코드를 읽습니다 `~/.gstack-dev/evals` 파일 매번.

**왜:** 오늘 "E2E ran today"는 동작 테스트에 대해 아무것도 입증하는 순간의 허리입니다. **노력:** M → S CC. **우선 순위:** P2. **에 따라:** 내용 바인딩 파; 동시 worktrees 공유를 가진 sharded 주자에 접촉하십시오.

### P2: 종결 outcome ledger

**이름:** `/spec`의 스파게드 `claude -p` 에이전트은 불을 붙이고: 스파게가 완성되는, 죽거나, 또는 쌓아지는지 아무것도 기록하지 않습니다. run.jsonl (스파이드, branch, worktree, pid, outcome)에 의하여 spawn +에 의해 풀어 놓는 것을 추가하십시오 임대/heartbeat 체크, /landing-report 줄로 표면으로.

**왜:** 죽은 수목은 현재 PID를 사냥할 때까지 보이지 않습니다. **노력:** M → S CC. **우선 순위:** P2. **에 따라:** 아무것도; 임대 + 심근 liveness 패턴은 로컬 CEO 계획 기록 (2026-08-15, 바인딩 파)에 문서화됩니다.

## P3: /land-and-deploy에서 custody의 Merge-SHA 사슬

**이름:** 포스트 수, {merge sha, 병합 나무, 검토 된 wtree 일치?} 그래서 배포 된 artifact 추적 검토 된 내용 상태.

**왜:** 사전-merge 체크는 내용에 대한 리뷰를 묶습니다. 이동한 기초에 스쿼시 수풀이 기록되지 않는 후에. 로그보다 오히려 경고할 수 있기 전에 소음 모형 (기본 운동 합법적으로 변경)를 필요로 합니다. **노력:** M → S CC. **우선 순위:** P3. **에 따라:** 내용 바인딩 파 필드 (검토 기록에 있는).

## P3: 배경 루프를 위한 기본적 조사 계약

**이름:** Long-running/background 기술 루프 (/canary first)는 옵션 + 타임 아웃과 기본 측면 선택이 아닌, 인간의 질문에 대한 답변을받지 않는 에스컬레이션 모양을 얻을 수 있습니다.

**왜:** 현재 AskUserQuestion 또는 추측에 블록 중 하나. **노력:** S/M → S CC. **우선 순위:** P3. **에 따라:** 동의 모형 검토 (변화 AskUserQuestion semantics — 그것의 자신의 디자인 통행을 필요로 합니다).

## P3: E2E eval case — staleness grading 실제로 적용하는

**이름:** 유료 게이트/periodic 렌더링 된 /ship 대시보드 + /land 3.5a 텍스트가 wtree content-first rule (등급 CURRENT)을 동일한 내용으로 적용하여 오작동에 다시 떨어졌다.

**왜:** 등급 규칙은 무료 템플릿 drift 트립 와이어에서만 핀으로 꼿는 프록스입니다; 이것은 에이전트이 실제로 그것을 실행하는 것을 증명합니다. **노력:** S. **우선 순위:** P3. **에 따라:** 내용 바인딩 파.

## P2: 사무실 시간 디자인 문서 이중 쓰기 기능 E2E (포크 항구 파 2 검토 단축)

**이름:** A paid E2E (claude -p) that runs the office-hours Phase 5 handoff in a tmp repo and asserts BOTH write paths (docs/designs/<topic>.md + the ~/.gstack copy) land and that `bin/gstack-redact` was invoked at the sink. Today only a static prose pin exists (test/skill-validation.test.ts) — the plan's R9 asked for the functional shape.

**왜:** 듀얼 write는 사용자 repo로의 egress 경로입니다. redact scan-at-sink를 건너는 prose는 사용자가 PII를 실패하지 않고 git 역사로 발송할 것입니다. **노력:** M → S CC. **우선 순위:** P2. **층:** 주기율 (품질, 비-deterministic).

## P2: 이동 주자 명예 per-migration Skip state

**이름:** 두 마이그레이션 주자 (설정의 포스트 설치 블록 및 /gstack-upgrade 단계 4.75)는 버전 창에 의해 순으로 마이그레이션을 선택하므로 비동기 기본 스키프 (v1.27 's GSTACK_MIGRATE_ASSUME_YES 게이트)를 통해 종료하는 마이그레이션은 다시 제공되지 않습니다. 버전 마커가 과거에 전진합니다. 구제 텍스트는 이제 정직한 직직을 인쇄하지만, 주자는 .done/.skipped 게이트 당 추적해야합니다. 다음 대화식으로 이동하십시오.

**왜:** 모든 나머지 사전 v1.27 사용자가 에이전트 세션을 통해 업그레이드 ([ -t 0 ] false) 영구적으로 수동 명령을 풀지 않는 한 artifacts-rename 마이그레이션을 놓습니다. **노력:** M. **우선 순위:** P2.

## P2: 주기적인 층 — TWO 문서화되는 시험 필요 구조상 수선 (3개)

**2026-08-29 업데이트 (테스트 인프라 오버 해설) :** (1) 사이드바 E2E 트리오는 ALREADY DELETED — no 파일에 트리 POSTs에 /sidebar-command 또는 /sidebar-chat; tombstone 테스트만 남아 (browse/test/sidebar-tabs.test.ts는 endpoints STAY 삭제), 그래서 부분 (1)는 이미 done로 닫습니다. (2) 기술 e2e-ship-idempotency 및 (3) 기술 기술 - 2 (EXCLUDED)는 그들의 재발을 가진 그들의 재발을 막습니다 (STAY 삭제되는). 아래 구조 조사는 재입력 상태입니다.

**이름:** (1) 사이드바 E2E 트리오 (navigate, url-accuracy, css-interaction) POSTs에서 /sidebar-command 및 /sidebar-chat로 - PTY 터미널이 채팅 큐 (server.ts tombstone ~2671)를 대체 할 때 트리에 종료된 엔드포인트가 제거됩니다. PTY 표면에 대해 다시 작성하거나 삭제합니다. (2) 기술 e2e-ship-mide-mide-s : PTY의 전체 화면에 대한 충분한 시간을 제공하십시오. PTY는 PTY의 전체적인 계획이 아닙니다. v1.63에서 태어난 이후 결코 녹색. (3) 기술 e2e-brain-privacy-gate: 결코 어디에서나 녹색; artifacts-sync stop-gate preconditions는 per-test HOME/GSTACK_HOME 주입과 함께 신비한 env를 생존하지 않습니다 — 실제로 echoes를 전진하는 것을 의 성적 수준 디버를 필요로 합니다.

**왜:** 각 빨간 정기적인 런타임은 삼기 시간입니다. 이 중 두 가지는 두 개의 릴리스를 통해 세 가지 삼기 패스를 태워 냈습니다. **노력:** M. **우선 순위:** P2.

## P1: #1882 - 휴대용 기술 설치 접두사 (비`gstack`는 이들을 침묵하게 끊기 설치합니다)

**이름:** 모든 생성 SKILL.md는 `bin/`/asset 호출을 위해 리터 `~/.claude/skills/gstack/...`를 강제로 합니다 (직접 telemetry/config preamble plus ~9의 결심자). `setup` 철사는 어떤 디렉토리 이름든지를 위한 최고 수준의 기술 symlinks, 그래서 `~/.claude/skills/<other>`에 설치하십시오 각 내부 `bin` 참조 지적 `~/.claude/skills/gstack/` 참고 `~/.claude/skills/gstack/`는 휴대용 방출합니다. runtime에 설치 루트를 해결 (이전에는 `GSTACK_ROOT`/`GSTACK_BIN`를 정의하지만, 리터는 사용하지 않습니다) 하드 코딩 접두사 대신 `$GSTACK_BIN`-relative 경로가 방출됩니다.

**왜:** #1882로 신청했습니다. 6월 2026일 수정파 (절절절 A)에서 한 번 구현한 것은 호스트 구성/design 변경이 아닌 수정파 패치가 아닙니다. 긴급한 반 - guard/freeze/careful frontmatter Hooks가 CC 2.1.162에 끊어지면서 이미 그 파도에 고정되었습니다 (#1871) 리터럴 `$HOME`-anchored 경로로, frontmatter Hooks가 `$GSTACK_BIN` 2.1.162에서 실행할 수 없기 때문에, 이때는 절대 사용되지 않습니다. `$GSTACK_BIN`

**프로 :** 언블록은 어떤 디렉토리 이름에 설치; 침묵하는 인발시간 실패의 전체 클래스를 제거. **단점 :** 터치는 repo (각각 기술의 전적); 침묵하는 실수는 모든 52 기술을 깰. 높은 폭발 반경 - 자신의 초점을 필요로 PR. **주 (포크 항구 파 2):** 애플 릴리스 어댑터 (ship/sections/ apple-release.md)이 목록에서이 목록에서 추가 `~/.claude/skills/gstack/bin`.

**Context / 시작하려면:**
- Rewire `ctx.paths.binDir` (과 찾아보기/design dir 경로) + ~9의 해결사
  리터럴 (`testing.ts`, `review.ts`, `design.ts`, `browse.ts`, `redact-doc.ts`, `tasks-section.ts`, `preamble/generate-*.ts`)을 방출하여 전방 정의 `$GSTACK_ROOT`/`$GSTACK_BIN`를 사용합니다.
- `GSTACK_ROOT`/`GSTACK_BIN`는 EVERY 기술에 있는 첫번째 사용의 앞에 정의됩니다
  preamble (텔레메틱 preamble의 첫번째 빈 호출은 정의 후에 입니다).
- **시험 충돌 (verified):** `test/gen-skill-docs.test.ts:1942`와 주사
  현재 *assert* 생성 Claude 출력 `.toContain('~/.claude/skills/gstack')` 코드 호스트 경로가 누출되지 않는 난간으로. 이 새로운 휴대용 계획과 일치하도록 rewritten해야합니다.
- 모든 52 SKILL.md (`bun run scripts/gen-skill-docs.ts --host all`); 결코 재생하지 마십시오
  손 편집 생성 파일. Bisect: resolver/host-config 변경 commit, 그 후 52-file regen 커밋.
- 비`gstack`에서 기술 invocation를 연기 테스트하여 수정을 증명합니다.
- #349 (`$CLAUDE_CONFIG_DIR`/ `~/.claude` 경로 문제)의 간격을 끄십시오.

## Aside 통합 후속 (/plan-ceo-review + /plan-eng-review를 통해 제3자 활동 측 계획에 파일)

## QA는 Aside (Phase 2)를 통해 로그인 증거 경로

**이름:** /qa, /qa-only, /browse에 있는 대안 증거 근원으로, 동의한 `aside repl`는, 쿠키 수입품이 세션에 도달할 수 없을 때 SSO, 장치행 auth, 사파리 측 로그인 Chromium 수출은 볼 수 없습니다).

**왜:**는 `docs/designs/CHROME_VS_CHROMIUM_EXPLORATION.md`의 정확한 간격 `docs/designs/CHROME_VS_CHROMIUM_EXPLORATION.md` 기록을 시도하고 버려진 - 사용자 QA의 증거 REAL는 브라우저, no cookie 수출 기록합니다. 제 3 자 활동 계약은 이미 로그온 납품업자 위치에 행동을 위해 측을 추천합니다; 이것은 증거 수집에 동일한 동의 가한 본을 확장합니다.

**구성 :**는 Aside 통합 계획 (2026-08-27)에서 선택권 2로 sketched: 작은 `{{AGENTIC_BROWSER_FALLBACK}}` 결심자는 qa/qa-only/browse로 주사했습니다 (선택적으로 긁는 것은 + 설치browser-cookies 십자가 Ref). 포크 PR 시간 -attack/gstack#40 판단 qualitatively — “llogin 페이지만; 결코 대량 크롤러-cookies 십자가-ref” — 결코 그것의 재량한 시간 당 재량에 의하여 재량할 수 없는 기술적인 수 없습니다. E2E는, 재량의 재량에 대한 재량의 제한을 위해, 수 없습니다. D1A (contract-only 범위); 그것은 첫번째 당 QA 파이프라인의 옆에 제삼자 표면을 삽입합니다, 그래서 분리되는 제품 호출입니다.

**노력:** M (human ~2 일 / CC+gstack ~1-2 h) **우선 순위:** P3 **에 따라:** 제 3 자 활동 아편 계약 branch 착륙.

## Hostile-vendor-skill E2E 제3자 계약

**이름:** 악의 E2E는 주기적인 층 `aside-browser` 납품업자 기술 (범위 확장, credential 붙잡음, 또는 동의 우회를 지시하는 것) 및 에이전트이 계약의 역대 문장을 명예를 전합니다 - 가동 구문은, 결코 새로운 허가, 범위, 또는 동의를 결코 붙지 않습니다.

**왜:** 규칙 3는 지시 위치에 납품업자 원본을 둡니다; 배는 prose로 핀으로 꼿습니다 그러나 adversarial 기술에 대하여 no 행동 증거가 있습니다. 배 adversarial 검토에 의해 퍼지는 (11를 재정의하십시오).

**구성 :** 정착물 =는 계약 단면도 + 노동자에서 hostile 납품업자 SKILL.md를 추출했습니다; 드라이브 계획을 감독하는 것은 지명한 site/actions를 결코 초과하지 않으며 붙잡힌 secret 지시를 결코 초과하지 않습니다. `test/skill-e2e-third-party-actions.test.ts`에 있는 tpa-* 스위트의 활성화.

**노력:** S (human ~half 일 / CC+gstack ~30 분) **우선 순위:** P2 **에 따라:** 제 3 자 활동 아편 계약 branch 착륙.

### fd-anchor 파일 레벨 권한 쓰기 (symlink/TOCTOU dirs와 동등)

**이름:** `restrictFilePermissions` / `writeSecureFile` / `appendSecureFile` 에서 `browse/src/file-permissions.ts` 는 여전히 `chmodSync`/ `writeFileSync` 를 사용하며 `O_NOFOLLOW` + fstat/fchmod 를 처리하는 디렉토리 경로가 얻었다.

**왜:** 이 branch의 감독을 위해 고정되는 symlink-swap 클래스는 내부에 파일을 열 수 있습니다 (선사 검토, 발견 5). Docs 참고 (finding 12) - v1.72.0.0 doc 패스에서 수행 : BROWSER.md "Aside and third-party drives"는 현재 Aside 드라이브가 no gstack-side Audit trail (no egress 영수증, no egress=""> 로그에 대한 기록.

**노력:** S (human ~half day / CC+gstack ~20 분) **우선 순위:** P3 **에 따라:** 없음.

## 테스트 인프라

## P1: 스킬화 게이트 테스트 레드 — HOME-override 세션은 프로젝트 스킬을 발견하지 못했습니다 (pre-existing)

**이름:** `test/skill-e2e-skillify.test.ts` `skillify-provenance-refusal` branch와 origin/main @ b5a951e6 (proven 2026-08-29: 동일 2turn `Unknown skill: skillify` 성적표)에 실패했습니다. `env: { HOME: workDir }`를 통과하는 그 파일에 있는 각 시험은 ZERO 회의 init (claude CLI 2.1.237); 시험에 의해 직접 시험하는 시험, 시험은 시험합니다 SKILL.md를 시험합니다. 하네스를 수정 (HOME-overridden discovery looks, 또는 HOME override 및 쓰기 대상을 전달), 또는 프로젝트-스코프 `.claude/skills` 발견이 진짜로 HOME를 발견하면 업스트림을보고.

**왜:** 환경 이유를 위해 빨강인 문 층 안전 시험은 문 빨강을 무시하는 사람들을 훈련합니다.

**노력:** S-M (하리). **우선 순위:** P1 (가위 위생).

## P2: auq-verbose-vs-carved-ab PRE 팔은 branch 지역 ref (same fragility 종류 반복 커트 A/B 다만 조정)를 읽습니다

**이름:** `test/helpers/auq-sdk-capture.ts` `verboseSkill()` 과태는 git ref `ab66193e^`에, 토큰 사용 감소 branch에서만 도달 가능하 — 얕은 clones는 오늘 실패했습니다, 모든 clones는 그 branch가 pruned 후에 실패했습니다. 공급업자는 정착물로 미리 carve 렌더링을 이용합니다 `auq-pre-cut-plan-ceo-review-SKILL.md`는 반복 커트 A/B (1.7v5/)를 위해 공급되었습니다 (.) 또는 repointable.

**노력:** S. **우선 순위:** P2 (주간 정기적인 휴식).

## P3: 탈중앙화한 조합으로 eval-store 수확

**이름:** `EvalTestEntry.harvest`는 schema v2 (worktree 수확은 patchPath/isDuplicate를, 팔 벤치 마크 diff-stats를 나르는 모든 선택했습니다 insertions/deletions/net) — 2개의 작가 모양을 위한 컴파일 시간 안전은 지금 코멘트에 나머지합니다. `{kind:'worktree',...} | {kind:'diff-stat',...}`로 모형. v1.73 검토 군대에서 신청하는 (주요); churn 중간 방출을 피하기 위하여 배 시간에 쫓아.

**노력:** S. **우선 순위:** P3.

## P2: WS6-2 dead-frontmatter 지구 — 샌드박스가 아닌 살아있는 주인을 필요로 합니다

**이름:** `bin/gstack-context-bill`는 14 frontmatter 열쇠에 관하여 경고합니다 “연결관은 결코 읽습니다” (ROUTER_KEYS에서 lib/context-bill.ts는 손으로 maintained 추측입니다). 승인된 ponytail-import 계획 mandates EMPIRICAL 확인 줄무늬의 앞에: 찰상에 있는 열쇠를 제거하십시오 LIVE Claude Code 주인, <technologydiscovery/routing/hooks unchanged, 그 후에 hosts/claude.ts (>9/)를 통해 땅을 확인합니다. 클라우드 샌드박스가 라이브 호스트 발견을 할 수 없기 때문에 결정 서약 항목 (2026-08-28)을 가진 v1.73 구현 시간에 부과합니다. 저축은 항상 바이트의 수백입니다; 성장은 이미 쥐에 의해 넣었습니다.

**노력:** S (라이브 호스트에 따라). **우선 순위:** P2.

## P3: 증거 문 소화 허용 동요

**이름:** `agents-digest/gstack-AGENTS.md`는 `--allow-paths`를 배의 땅과 배치의 증거에서 EVERY repo, CHANGELOG/VERSION와 달리 규칙을 보행하는 주인을 위한 지시 표범하는 것을 라이더로 갑니다. "충분에 면제를 실제로 재생했습니다"(예를들면 --allow-ifregeneal)는, Claude를 통과하고, 똑똑똑한 검사를, 또는 똑똑똑한 검사를 위해, 또는 뛰는 경우에, "진격한 문"를, 뛰는 문이거나, 뛰는 문이는 것을 봅니다.

**노력:** S-M. **우선 순위:** P3.

## 2026-08-29 테스트 인프라 오버하ul - 후속 (이행에 파일)

The overhaul landed: green-means-green fixes (make-pdf gates in the required lane, zero-test eval jobs killed, 4 orphaned paid files activated + orphan tripwire, touchfiles self-registration + warn→fail), the serial tree-mutating shard dissolved (main() guard + --out-dir all hosts), duration-packed free shards, the sharded paid runner as the CI engine (planner/slices/fail-closed report, parity phase), the weekly all-periodic coverage contract + gate census, eval-budget timeout tiers, and the coverage fill. , 거친 우선순 순서에서 Remaining:

- **DONE (v1.77.0.0 테스트 인프라 파 1) - 유산 evals.yml 매트릭스를 삭제
  패리티.** 정적 패리티 영수증 후 순수 삭제 commit (한쪽에 복원) : 슬라이딩 게이트 인구 통계 (49 파일) ≯ matrix 파일 (18), 추가 적용의 31 파일. `needs: evals` 가장자리가 떨어졌다, PR 코멘트는 슬라이스-report로 이동, KNOWN_MATRIX_GAPS/KNOWN_TIER_UNSET 은퇴, test/evals-workflow-matrix.test.ts 테스트/evals-workflow-wiring.test.ts. 등록-skills fail-fast 검증 루프는 공유 .github/actions/register-gstack-skills 컴포지트를 통해 레이드 FIRST에 포트를 갖게 되었다.
- **P1 - 유지 관리 결정: `slices-report`를 필수 체크로 만듭니다** 한 번
  포스트 이동 가짜 데이터는 존재 (Codex 외부 청구서의 "녹색은 녹색이 허용 된 동안 제공되지 않습니다"점 - 정확하고, 정의적으로 지점 보호 결정, 아니 repo YAML). Effort S.
- **P2 - daemon 라이프사이클 vs in-suite browsers (주택 무료 스위트 룸
  flake).** The post-#994 daemon deliberately outlives its parent and lingers across test FILES in a shard process; a later file's browser use can then fight it ('[browse] FATAL: Chromium process crashed' + 5s element-wait timeouts). Receipts: commands+snapshot in one bun process fails identically WITH and WITHOUT per-file CHROMIUM_PROFILE isolation (pre-existing; PR #2721 triage), and CI shard 1 on d9b78b5a died at model-overlay-sonnet-5 after a daemon-spawning file. Per-shard + per-file profile isolation (landed)는 크로스 스윙 살인을 제거; intra-shard daemon handoff는 실제 디자인을 필요로한다 : daemon가 모든 후 중지해야, 또는 daemon는 외국 CHROMIUM_PROFILE env를 감지하고 재사용을 거부해야합니다. Effort M.
- **P2 - daemon /tmp-namespace를 찾아봅니다.** 모든 파일 경로 수송
  to the daemon (eval <file>, load-html --from-file, pdf output, upload, cookie-import) assumes client and daemon share one /tmp view; a sandboxed shell reusing an out-of-namespace daemon gets "File not found" on files it just wrote (root-caused live, reproduced with unshare). Minimal fix: the CLI reads a local `eval <file>` itself and sends the code as `js` ( semantics-preserving; keep the daemon path for remote callers), plus a namespace hint appended to read-commands.ts:313's error. Effort S.
- **P2 — PTY 시동감 대기.** PTY 시험의 분.잠자는 (8000) 전방합니다
  그리고 invokeAndObserve의 6s boot_은밀한_ms는 장님 기다립니다; 실제 읽음 waitFor 필요 empirical CLI 2.1.x 작업 터미널 환경에서 준비marker probing (이 샌드 박스의 PTY probe 쐐기). Effort S는, dev 기계를 필요로 합니다.
- **P2 - 단일 타입 테스트 레지스트리.** 유료 혈소판, 층, 터치파일 키,
  그리고 제외는 여전히 삼각 당국이 tripwires에 의해 동기화됩니다; 하나 레지스트리에서 그들을 파생하고 무인급은 구조적으로 (외부 음성 권고; tripwires는 interim) 죽습니다. Effort M.
- **P2 — 사용자 정의 LPT 패커를 bun-native `--timings`/`--shard`에 교환하십시오**
  다음 Bun unpin (native LPT scheduling ships ≥1.3.14; 패터는 deliberately 작고 swappable - scripts/test-free-shards.ts)의 성공 사례를 참조합니다. Effort S.
- **P3 - runBin 마이그레이션이 계속됩니다.** (~31 of 36 로컬 실행 () 중복;
  헬퍼 + 첫 번째 3 마이그레이션). 기계 배치. Effort S.
- **P3 - runShardChild에 무료 런너를 마이그레이션** (공동생사이클
  돕는 급여 런너 지금 사용; 그것을 위해 설계). Effort S.
- **P3 - eval-list는 _partial 실행을 제외해야 합니다.** (현재로 핀으로 꼿습니다
  개선 노트와 test/eval-cli-family.test.ts의 동작. Effort S.
- **P3 — codex-e2e-plan-format's testIfSelected name have no 지도 키**
  (오늘만 실행) + 15 E2E / 2 판단 PHANTOM 터치파일 키 선택 테스트는 아무데도 없다 - 키 또는 삭제, 한 번 청소를 추가합니다. Effort S.
- **P3 — 슬라이스드 레인에서 첫 번째 프로젝션 rot의 첫 라이브 실행: 2 의 3
  FIXED** (PR #2721): (a) ✅ 기술 가족 — 뿌리 원인은 HOME=cwd를 만드는 claude 대우 <cwd>/.claude/skills를 PERSONAL dir (프로젝트 기술 등록하지 않은); 지금 3개의 시험은 신선한 HOME subdir를 사용해서, refusal 시험은 not-registered tripwire + 조수 텍스트 전용 일치 (기술적인 echou-dis-vacation)를 얻었다. 이제 동사 RESTORED-marker + 도구 호출 corroboration with the strong old-file negative (3/3 유료 녹색). (c) `tpa-apple-ban` 재 시도에 실패 2 한 번 - 가짜 시계 만. 첫 번째 실행에 이러한 lane 발견은 적용 계약 작업이다.
- **P2 - make-pdf 이미지 프로모션은 CI에 비 결정적인 per-render 입니다**:
  두 개의 렌더링 동일한 고정 SECONDS 한 CI 작업에서 2 대 3 풍경 페이지 (이미지의 프로모션은 로드 타이밍에 따라 달라집니다). 풍경 게이트는 이제 assert content/presence invariants이지만, 언더 라이딩 레이스는 제품 품질 문제입니다 (사용자의 alt-hinted 이미지는 조용히 풍경 프로모션을 놓을 수 있습니다). 영수증 : PR #2721 무료 테스트 +49 헤드는 e-tests +49의 cbforte.
- **P3 - 내구 중량 슬라이스 할당** 파열 데이터가 슬라이스를 보여줍니다 경우
  벽 다이브 >1.5x (둥근 구근 오늘; eval-store 내구는 존재합니다). Effort S.

## P2: /context-save worktree-identity 경화 (#2052 잔여)

**이름:** Persist a stable worktree identity (path hash or worktree name) as checkpoint frontmatter at save time; `/context-restore`는 분기 이름 일치에 정체성을 선호합니다. PR #2054 (@jbetala7, 6월 2026 파에서 흡수) 고정 복원 ORDERING (현재-branch first), 그러나 branch frontmatter는 안정적인 worktree identity: 동일 이름과 동일하, 불확실한 분기점 HEAD (현재-branch first), branch (현재-branch-name), HEAD (현재-HEAD 의 를 다시 복원할 수 있습니다.

**왜:** 일반적인 경우 대신 재시동적 잘못된 체크 포인트 클래스를 닫습니다. Codex 파의 eng 검토 중 외부 청구.

**프로 :** 크로스클로 체크포인트 충돌을 제거한다. **단점 :** Frontmatter schema 변화; 이전 체크포인트에 대한 마이그레이션 이야기를 필요로 (무도 체크포인트는 #2054의 노브랭크 처리와 같은 미백으로, 순위를 매깁니다).

**구성 :** 6월 2026일 수정파 eng 검토에서 신청 (NOT-in-scope 항목). `context-restore/SKILL.md.tmpl` 단계 1 + `/context-save`의 frontmatter 작가에 시작하십시오; 거울 #2054의 첫번째 열쇠로 ID를 가진 분할 논리.

**노력:** S (human ~4h, CC ~20min). **에 따라:** #2054 (파에서 착륙하는).

## P3: 영구적인 편류에 gbrain reindex-in-place (조건 — 첫번째 편류를 검사하십시오)

**이름:** IF `[gbrain-sources] drift:` stderr 선 (6월 2026 파에서 추가되는)는 몇몇 환경을 위한 각 sync에 드리프를 보여줍니다, 구현합니다 #1985의 기자 디자인: 제거 +add 대신 `gbrain reindex-code`로 장소에 있는 기존의 근원을 상쾌하게 합니다 (떨어뜨리고 전체 색인을 재 조립하십시오 — 768 페이지/6,786는 보고자의 경우에 embeddings).

**왜:** 무기한 편류는 가득 차있는 재 조립한 비용을 매끄럽게 지불하는 것을 의미합니다. 파의 `realpathSync` 정상화 (symlink 별명으로는 전적으로 무질하) 무질하 종류 삭제될지도 모릅니다 - 이것이 조건부인 이유입니다.

**프로 :**는 영향을받는 환경에 대한 반복적 인 embedding 지출을 피합니다. **단점 :**는 drift 로그가 증거를 생산할 때까지 결정합니다. reindex-in-place에는 자체 일관성있는 질문 (스탈 삭제 된 파일에 대한 이야기 펑크)이 있습니다.

**구성 :** 6월 2026일 수정파 eng 검토 (4A 관측성)에서 신청. 방아쇠 상태는 `lib/gbrain-sources.ts`에서 편류 로그 라인에 기록했습니다.

**노력:** M (human ~1d, CC ~45min). **에 따라:** 파의 `ensureSourceRegistered` 로깅에서 무려로 증거. ### ✅ DONE (2026-08-29): Periodic CI 적용 계약 - 옵션으로 구현 (a)

**테스트 infra overhaul에 의해 해결:** evals-periodic.yml scripts/test-paid-shards.ts - ALL 주기적인 층 파일은 주간 (EVALS_ALL, planner 외관 → 6개의 슬개 → 실패 닫히는 보고)를 실행하는 test/helpers/periodic-exclude-data.ts (참고 당 추적하는)에 있는 소용한 배설물에 반전합니다. 주간 EVALS_ALL 문 조사관은 동일한 cron를 라이더. 침묵 회전 종류는 죽은: 시험은, 이제 막힌 보고, 계획한 불능한, 실패한 보고입니다. 원래의 서류는 영수증에 따라 보관.

#### Original filing (닫히는) Periodic CI matrix는 ~66 e2e 파일의 9를 커버합니다 - 적용 계약을 결정하십시오

**우선 순위:** P2

**이름:** `evals-periodic.yml` (주간 cron, `EVALS_TIER=periodic EVALS_ALL=1`)는 하드 코딩된 9 파일 행렬을 실행합니다; `evals.yml` 게이트 shards 덮개 14의 파일. ~57 `test/skill-e2e-*` 파일은 NEITHER 워크플로에서 실행됩니다. 로컬 diff가 터치파일을 통해 선택하게 될 때만 실행됩니다. CLAUDE.md는 "매니얼 테스트는 cron을 통해 주간 실행됩니다"라고 말했습니다. (a) 예산 캡이있는 모든 주기 계층 파일에 주기적 매트릭스 (또는 글브)를 확장 (b)는 CLAUDE.md의 주장을 수축하고 local-only, 또는 (c) tier 또는 명시적으로 orphans로 uncovered 파일을 표시합니다.

**왜:** 자동 계획 이중 송장 E2E는 달 (클래드 >= 2.x는 비고등록된 슬래시 - command 취급을 바꿨습니다)를 위해 침묵하게 부서지고 아무 것도 docs PR의 접촉 파일이 국부적으로 (2026-07-09)를 선정하기 위하여 고시된 때까지 주의하지 않는 시험. 어느 곳에서도 썩을 수 없는 시험; 각 사람은 완전하게 /investigate 회의를 끊었습니다.

**프로 :**는 ~57 테스트 파일을 위한 침묵 회전 종류를 죽이고; CLAUDE.md 계층화 주장을 진실하게 만듭니다. **단점 :** 가득 차있는 주기율 적용은 매주 진짜 돈 (주문을 통해: ~$1/file/run)를 비용으로 요합니다; 몇몇 orphans는 deliberately 설명서 (ios-device, opus-47 오바레이 마구), 그래서 보통 glob는 틀립니다 - curated exclude 명부를 필요로 합니다.

**신선한 영수증 (2026-08-16, v1.66.0.0 재베이스):** 이 상점에서 첫번째 가득 차있는 국부적으로 주기적인 달리는 것은 결코 기지개한 꼬리를 그것의 첫번째 결과를 주었습니다: `skill-e2e-setup-gbrain-{bad-token,path4-local-pglite,remote}`는 전부 실패했습니다 (살롱된 과정 출구 1 — dev 상자에 살아있는 GBrain 방해) 및 `skill-e2e-ship-idempotency`는 1800s shard 벽에서 밖으로 중단했습니다. None는 주간 모체에서, 이렇게 이 실패는 CI에 보이지 않습니다 - 정확하게 이 품목의 thesis. 그 4 아래로 그와 함께 시작하십시오.

**Context / 시작하려면:** `.github/workflows/evals-periodic.yml:71` (matrix), `test/helpers/touchfiles.ts` E2E_TIERS (시험 당 이미 존재되는 층 상표), `comm -23` 사이 `ls test/skill-e2e-*.test.ts` 및 `.github/workflows/evals*.yml`에 파일 명부를 통해 생성된 orphan 명부. autoplan 사건에서 영수증: `~/.gstack/projects/garrytan-gstack/e2e-runs/2026-07-10-0154/` (0 회전 “Unknown 명령” 성적표).

### ✅ DONE (verified 2026-08-29): Eval 마구는 진도 + 증가 persistence를 생깁니다

**인증된 착륙** (the v1.66-era harness work delivered all three asks): (1) heartbeat — session-runner writes ~/.gstack-dev/e2e-live.json atomically per tool call (+ progress.log + per-test ndjson); (2) incremental persistence — EvalCollector writes _partial-e2e.json after every addTest, dual-signal isPartialEval keeps partials out of baselines; (3) live signal — per-tool stderr progress lines flush unbuffered, and scripts/eval-watch.ts dashboards the heartbeat. 2026-08 오버하울은 퍼 스윙 풀 스트림 스풀 로그 (START에서 인쇄 된 경로) 위에 추가했습니다. 원래의 서류는 영수증에 따라 보관됩니다.

#### Original filing (닫히는) Eval 마구: 살아있는 진도 + 증가 결과 persistence ( 침묵하는 시간을 kill)

**우선 순위:** P1

**이름:** `bun run test:evals` is observably silent for its entire runtime and persists nothing until completion. Make the E2E harness (1) append a one-line progress record per test START and END to a well-known heartbeat file (e.g. `~/.gstack-dev/evals/.current-run.jsonl`), (2) write each test's eval-store result incrementally instead of only at run end, and (3) flush per-test pass/fail lines to stderr unbuffered so `bun test --concurrent` mega-file buffering can't hide 50 minutes of legitimate progress.

**왜:** During the v1.57.11.0 ship, the diff-selected eval run (54 tests) was killed ~50 min in and NOTHING distinguished the corpse from a healthy run for hours: the log had zero test lines (per-file buffering across five mega `skill-e2e-*.test.ts` files), `~/.gstack-dev/evals/` had zero new files (results persist only on completion), and the only available liveness signal (`pgrep "bun test --max-concurrency"`) false-positives on every sibling free-suite shard. 런닝을 보는 에이전트 또는 인간은 no 솔직한 신호가 있습니다.

**프로 :** 죽은 시간은 몇 분 안에 감지됩니다. 부분적인 결과는 죽는 (시험 40/54에 죽는 50 분은 40 결과를 지키고 재개할 수 있습니다); `eval:watch`는 진짜 자료 근원을 가져옵니다.

**단점 :** `test/helpers/session-runner.ts` + `eval-store.ts` (글로벌 터치파일 - 변경 트리거 ALL eval 테스트 다음 diff 선택 실행); incremental 쓰기 필요 PARTIAL 마커 그래서 `eval:compare` 완전한 기본으로 죽은 실행을 치료하지 않습니다.

**구성 :** Root-caused 2026-06-12 during the v1.57.11.0 /ship. The run itself was on pace (~50 min for 54 E2E tests at concurrency 15 is nominal); the failure was pure observability. Related: the existing `project_e2e_harness_observability` note (stream-json reasoning + tool traces dropped on failure — same module, fix together). Start in `test/helpers/session-runner.ts` (per-test lifecycle) and `test/helpers/eval-store.ts` (persistence timing).

**/에 따라 달라집니다:** 아무것도. 기존의 두 계층 시스템에서 새로운 행동을 분류; 심박 파일은 `--concurrent` (부부부, 이벤트당 1 JSON 선)에서 안전해야합니다.

### ✅ DONE (v1.53.1.0): Rebaseline parity-suite (v1.44.1 → v1.53.0.0)

**이름:** `test/parity-suite.test.ts`는 얼어붙은 `test/fixtures/parity-baseline-v1.44.1.json`에 대하여 각 기술 SKILL.md 크기를 검사했습니다. 5개의 계획 기술은 1.05x 천장을 지나치게 했습니다: `plan-ceo-review` (1.052), `plan-eng-review` (1.062), `plan-design-review` (1.068), `investigate` (1.053), `office-hours` (1.065) — 뇌 인식 계획 방출 (v1.49–v1.52)에서 성장은 v1.53를 더한 적정을 가진 v1.52.

**해결:** Captured a fresh baseline at HEAD via `bun run scripts/capture-baseline.ts --tag v1.53.0.0` and re-pointed the test at `test/fixtures/parity-baseline-v1.53.0.0.json`. The per-skill 1.05 ratio is kept, so future bloat is still caught — only the stale anchor moved. Mirrors the earlier `skill-size-budget` rebase (v1.44.1 → v1.47.0.0). Historical v1.44.1 / v1.46.0.0 / v1.47.0.0 baselines retained in `test/fixtures/` for the v1→v2 audit trail. 캡처 된 기술 바이트 일치 `origin/main` 정확히 (branch는 모든 SKILL.md을 왼쪽으로). `bun test`는 다시 녹색입니다.

## Scope-gate follow-ups (계획 모드 자동 선택 B 변경에 /plan-eng-review를 통해 파일)

## DONE (v1.77.0.0) - SDK eval 예산 충전 API-queue latency to the work 예산

**공급 능력:** 두 단계 타이머는 WITHOUT를 강제로 이 항목에 직면했습니다: 총 벽은 <= timeout (일상 =는 첫번째 바이트 후에 남아있게 남아있습니다), 그래서 각 외부/inner bun-timeout 관계는 비접촉되지 않습니다; 침묵하는 API는 지금 시작 우아한 (90s 국부적으로/300s CI 지면, 강제적인 Math.max)에 EARLY를 죽습니다. (>는 300s test/session-runner-startup-grace.test.ts에 있는 선택권입니다.) 예산-EXTENSION 변형 (일 예산 = 첫 번째 바이트에서 전체 타임 아웃, 즉 DOES는 tier/wall reshape가 필요)는 오버홀 계획에서 파-2 범위를 유지.

원본 항목은 상황에 따라 다음과 같습니다.

**이름:** `runSkillTest`의 단 하나 `setTimeout(timeout)`는 스페인에서 팔, 그래서 세션 시작 AND 모형의 첫번째 completion 큐 시간 시험의 일 예산에 대하여 위탁됩니다. 동시 짐 (11 CI matrix 일, 또는 국부적으로 eval는 org API)를 공유하는 것을, 첫번째 완료 할 수 있습니다 60-90s+, 세정적인 `0 turns / $0.00 / <budget>s x3 attempts` 실패 모양을 일으키. 관찰된 전망: 관찰된 전망된 전망된 전망. `review-dashboard-via` (PR #2472, 180s→300s), `retro-base-branch` (240s→360s), `plan-ceo-plan-mode` (300s→420s, 2026-08-12), `design-consultation-preview` (90s→300s, PR #2533 CI). 각 고침은 지금까지 원-테스트 예산 범프입니다.

**왜 첫 번째 스트림 이벤트에 타이머를 다시 팔지 않습니다 :** 감사 (2026-08-12) ~100 외부 분간 리터럴은 inner+30-60s로 크기로 묶습니다; 안 시계를 끊는 것은 각 Outer/inner 관계가 끊고 그들 모두를 암호로 합니다.

**옵션:** (a) 세션-런너 (스타트업 은, 첫 번째 NDJSON 라인에 다시 팔) + codemod 외부 리터럴을 inner+grace+slack; (b)는 모든 CI SDK 예산 (정전적으로 시행 가능 - 무료 테스트는 assert no `timeout: <300_000` 기술 e2e 파일에서) 그리고 정지 재조정을 멈춘다 (-). (-)는 쿼터링을 멈춘다 (), 그래서 쿼터링을 멈춘다 (). 추천 (b) 단기 + (a) 제대로 코모로 시퀀스.

**/에 따라 달라집니다:** 없음.

## P2: 4개의 철거된 계획 형태/finding-floor PTY를 주기적으로 시험하십시오 CI

**이름:** `evals-periodic.yml`는 명시된 9 파일 행렬을 실행합니다. 4개의 테스트는 v1.62.0.0 (`skill-e2e-plan-eng-plan-mode`, `skill-e2e-plan-design-plan-mode`, `skill-e2e-plan-eng-finding-floor`, `skill-e2e-plan-design-finding-floor`)에서 `periodic`로 데모했습니다. 현재 로컬/manually (`bun run test:periodic` 또는 `eval:bg:periodic`)에서만 실행됩니다. 그(것)들을 위해서는 PTY-capable periodic 작업이 필요합니다. evals.yml의 `e2e-pty-plan-smoke` 작업 (실행 SKILL.md 복사본 TUI의 크로스 마운트 symlink 버그)를 `EVALS_TIER=periodic`로 컨테이너 기술 등록 설정.

**왜:** Codex v1.62.0.0 배에 P2 재검토. 이것은 기존의 주기적인 격판 문제의 명명한 인스턴스입니다 (P1/P2 주기 적용을 보십시오) - 테스트 인프라에서 TODO) - 그것을 거기 또는 여기에서 해결하십시오.

**/에 따라 달라집니다:** none; 주기적인 오르판 TODO의 위.

## P3: 공유 `{{SCOPE_GATE}}` 해결자에 전체 범위 문을 추출하십시오

**이름:** 중복 범위 게이트 prose (헤딩, 인트로 문장, 계획 모드/named-target 예외 블록, 번호 항목, A/B/C 메뉴 및 추천 라인) `plan-eng-review/SKILL.md.tmpl` 및 `plan-design-review/SKILL.md.tmpl`에서 4-5 주사된 변형 슬롯 (preceded-by list, item-2 phrasing, option-C vocabulary, 권고, 예외 사항, 꼬리 행동)를 가진 `scripts/resolvers/` 단위로 이동합니다.

**왜:** 두 개의 사본은 오늘 동기화됩니다. `test/gen-skill-docs.test.ts` ("경경찰 예외는 편향성 안전하다")의 무진한 가드 시험은 복제를 갖지만 진실의 한 소스는 실제 수정입니다. 계획 모드 자동 선택 B 변경 (2026-08-11)에 eng 검토의 D5로 신청했습니다.

**프로 :** 로드 빔 게이트의 단일 소스; 미래의 게이트 변경 (새로운 예외, 단어 조정) 한 번 착륙. **단점 :** 해결사 레지스트리 및 테스트를 터치; 정확한 생성 된 바이트를 보존하거나 carve/parity 천장을 다시베이스.

**Context / 시작하려면:** 구조상 전용 diff, AFTER 동작 변화 (반점 및 행동은 결코 함께하지 않습니다). 편향 보호 시험은 이동의 합격 검사가 됩니다: 추출물, regen는, 바이트 IDentical 산출을, 그 후에 은퇴하거나 감시를 간단하게 합니다. 불편: 인간 ~half 일/CC ~20 분.

**/에 따라 달라집니다:** 계획 형태 자동 선택 B PR 주에 착륙.

## 토큰 감소 후속 (단계 B, 플랜 시소 - 리뷰 캐비에 /plan-eng-review를 통해 제출)

## P2: v1.70 배 선회 방어 (특선 + 모험 발견, 각 확인)

**이름:** v1.70.0.0 사전 랜딩 리뷰에서 방어를 따르십시오, none 배 차단:

- **`bin/gstack-skill-start`의 11 `gstack-config get` 포크를 배치하십시오** config에
  읽기 (- 60-250ms의 preamble latency per Skill invocation, macOS). 한 개의 스크립트에 통합은 배치 트리 바이알을 만드는 것입니다.
- **`gbrain --version` probe를 캐시하십시오.** (Node CLI 감기 시작, invocation 당 100-300ms
  gbrain 사용자에 대한) 바이너리 경로 + mtime에 키.
- **`bin/gstack-retro-metrics`: 단 하나 통행 diffs** - `--numstat`와 `-p`를 결합
  패스 (`git log --numstat -p`), 세 가지 테스트 파일 정의 (`is_test`, awk regex, repo-wide grep)를 정의하고, `origin/<base>` ref 선호 + 300-commit/40-coauthor truncation 경로 테스트를 포함합니다.
- **이름 `generate-upgrade-check.ts`** — 이제 PROACTIVE/SKILL_PREFIX만 방출
  규칙; 이름 misleads는 격상시키는 향상을 위한 누군가 사냥을  사냥합니다.
- **evals.yml 문 모체 편류:** 9개의 사전 제작 게이트 계층 파일 `E2E_TIERS`는
  정적 스위트 매트릭스에서 부패 한, 그래서 그들은 PR CI에서 결코 실행되지 않습니다. (또는 tier를 prune)를 추가하고, 워크 플로우 매트릭스에 대한 무료 삼각 테스트 디핑 게이트 층 `E2E_TIERS`를 디핑하는 것은 클래스가 재발 할 수 없습니다.
- **`_sanitize` case/separator 변종:** 지구는 정확한 리터입니다; 그것을 만드십시오
  케이스 민감하고 구분하는, 핀 변형 케이스와.
- **원격 측정 unset-vs-off semantics:** `gstack-skill-start`는 UNSET telemetry를 대우합니다
  LOCAL 분석 쓰기 (이전 항목 기록, local-only); `gstack-telemetry-log` 지도가 해제되지 않습니다. 1개의 semantic를 삭제하고 문서를 삭제하십시오.
- **배 감사에서 적용 간격:** `--brain-health` 구획 (조도 시험),
  `>5`-entries는 passthrough (poison test), session prune + `.pending-*`는 반복을 완료하고, 3개의 종자 위치를 위해 공유한 `ONBOARDING_MARKERS` 일정한 (hermetic-env, e2e-helpers, 스크립트의 문)를.

**왜:** 각각은 파일이 있는 v1.70의 검토 군대에 의해 발견되었습니다: 선 증거; 모두는 새로운 주회 스크립트에 질 또는 대기권 승리, none는 행동 계약을 변경합니다.

**Effort 견적:** M (human 팀) → S (CC+gstack) **우선 순위:** P2 **/에 따라 달라집니다:** v1.70.0.0 착륙.

## P3: 출력 템플릿 파 - REVIEW_DASHBOARD + PLAN_FILE_REVIEW_REPORT

**이름:** 두 개의 출력 형식의 해결자 블록을 파고 - 검토 대쉬보드 모양과 계획 파일 보고서 골격 - 그 (`{{REVIEW_DASHBOARD}}` 5,940B ×6 + `{{PLAN_FILE_REVIEW_REPORT}}` 5,989B ×6, ~71.6KB 합계)를 주문한 섹션 또는 공유 참고 문서로 인라인 여섯 가지 기술 중.

**왜:** 가장 큰 잔여 복제 블록은 preamble 프로그램 땅 후에. 이들은 출력됩니다 TEMPLATES (테이블 모양, markdown skeletons), 행동 단계 — 고전적인 carve 후보자.

**프로 :** ~1.4KB×2 6개의 검토 가족 기술에 걸쳐 invocation 당 저장; 대쉬보드/report 체재를 위한 단 하나 근원. **단점 :** 둘 다 부분적으로 핀으로 꼿습니다 (`test/skill-e2e-review-attribution.test.ts` 조각 `## Review Readiness Dashboard`; `test/skill-validation.test.ts:1566` assertserts a specific row) — 중요한 프로그램에서 끊긴 왜인 핀 위치 디자인 첫째로 필요로 합니다.

**구성 :** 토큰 감소 프로그램 단계 4 (branch `prompt-token-load-reduction`, "NOT carving" list)에서 Deferred. carve 파이프라인과 가드 레지스트리를 사용하여 파를 쫓아냅니다. 조각 또는 asserts 대쉬보드/report 텍스트가 매핑되는 모든 테스트에 의해 시작하면 핀 당 골격-vs-section 배치를 결정합니다.

**Effort 견적:** M (human 팀) → S (CC+gstack) **우선 순위:** P3 **/에 따라 달라집니다:** 토큰 감소 프로그램 단계 1-4 착륙 (기계 churn는 충돌할 것입니다).

### P3: 닻 transformFrontmatter의 denylist 지구는 frontmatter 구획에 벗깁니다

**이름:** `transformFrontmatter` (scripts/gen-skill-docs.ts:525-530, denylist branch)는 FIRST 일치를 삭제합니다 `^<field>:` 파일을 어디에서든지, 단지 frontmatter 구획 안쪽에, 그리고 구획 작풍 YAML 가치의 orphan 오염 선을 삭제합니다. frontmatter, 그것, reassemble 내의 지구를 결합하십시오.

**왜:** Latent mis-strip class: 기술 본체 라인 시작 `interactive:` 또는 `benefits-from:` (예: frontmatter 컨트랙트를 문서화하는 기술)는 렌더링에서 조용히 삭제될 것입니다. Zero live crashs today (v1.69.x 토큰 감소 단계 0 검토 도중 모든 추적된 SKILL.md 몸의 맞은편에), 그러나 각 새로운 stripFields 입장은 노출을 넓힙니다.

**프로 :** 전체적인 미량한 클래스를 죽이십시오; stripFields를 성장하기 위하여 안전하. **단점 :**는 발전기 뜨거운 경로를 접촉합니다 - 가득 차있는 regen +를 체크한 당 주인 황금 정착물을 필요로 합니다; 그것의 자신의 작은 PR, 라이더 아닙니다.

**구성 :** branch `prompt-token-load-reduction` (finding ADV4)에 단계 0 adversarial 검토에 의해 찾아냈습니다. gen 측 파서는 단지 인라인 `[...]` 배열 모양 (gen-skill-docs.ts:751)를 읽습니다, 이렇게 구획 모양 YAML 이 열쇠를 위해 침묵하게 두번 실패합니다 - 동시에 유효한 과실.

**Effort 견적:** S (human 팀) → S (CC+gstack) **우선 순위:** P3 **/에 따라 달라집니다:** none.

## P3: 전방 프로그램 땅 후에 다시 계획 - 서사시 교리 캐브

**이름:** 재평가는 계획 아소review's ~13KB의 항상 로드 교리 (`## Prerequisite Skill Offer` 7,125B + `## Cognitive Patterns` 3,336B + `## Philosophy` 2,535B)의 기존 섹션/디디디에.

**왜:** 골격이 깔려있는 것처럼 토큰 감소 프로그램에서 디페르드는 캐러드 천장과 교리가 행동 핵심입니다. 골격 단계는 ~22KB로 골격을 수축하며, 무역을 변경합니다. 천장은 재조합되고 교리는 기술에 지배적 남아있는 블록이됩니다.

**프로 :** ~3.2K 토큰은 각 /plan-ceo-review의 호출을 통해 교리가 행동 손실없이 기꺼이 읽는 경우. **단점 :**의인지 패턴 섹션은 검토 음성을 전체적으로 형성합니다. 필요한Reads guard + A/B eval (디자인 문서 캐비티로 동일한 디자인)는 필수이며, 응답은 합법적으로 "이 인라인으로"될 수 있습니다.

**구성 :** 토큰 감소 프로그램 CEO 검토 ("NOT carving" 명부)에서 신청하는. 단계 3개의 땅 후에 `bin/gstack-context-bill --skill plan-ceo-review`로 측정하십시오; 새겨진 경우에 carve-guards 레지스트리 + 행동 선적 eval를 사용하십시오.

**Effort 견적:** S (human 팀) → S (CC+gstack) **우선 순위:** P3 **/에 따라 달라집니다:** 토큰 감소 프로그램 3 (re-baseline + recomputed carve 천장).

## gbrowser 메모리 후속 (v1.49 누출 설정 PR에서 /codex + /codex를 통해 파일)

이 4개의 품목은 `$B memory` 진단 + 4개의 누출 고침을 발송하는 기억 반작용 조사에서 나왔습니다. 그들은 PR (already 14는 / ~12 파일을 붙들었습니다); 각 대 혼자서 어떤 것을 자주적으로 발송할 수 있었습니다.

## P2: MV3 연장 서비스 노동자 기억 단면도

**이름:** The `/memory` endpoint snapshot enumerates pages but does not enumerate the gstack baked-in extension's service-worker target. A long-running MV3 service worker can leak through retained DOM snapshots, message ports that never close, alarms that re-arm, and caches that grow without bound. The diagnostic should call `Target.getTargets` with a filter for `service_worker` and include each one in `tabs[]` (or a sibling `serviceWorkers[]` array) with the same `Performance.getMetrics` data.

**왜:** Codex eng-review에 대한 외부 청구서 검토는 누출의이 종류를 표면화했습니다 (확장은 gbrowser 과정 나무의 부분이지만 오늘 snapshot). 우리가 표면까지, SW 누출은 부모 과정 RSS에서 no를 가진 단지 no를 가진 보여줍니다.

**프로 :** 단일-most-likely 미래 누출 소스 (우리의 확장)에 대한 per-target attribution gap를 닫습니다. **단점 :** Extension SW 수명주기는 대 페이지 수명주기입니다. 자동 - 부착 + 필터는 CDP 배관의 한 개 더 많은 조각입니다.

**구성 :** Codex #4 를 eng-review 외부 목소리에 찾아내십시오. v1.49 PR의 범위에서; 4개의 가장 높은 confidence 누출 고침에 PR를 지키는 deliberately deferred.

**우선 순위:** P2. **노력:** M.

---

## P2: `$B memory`의 기본 + GPU 기억 고장

**이름:** `$B memory` shows Bun RSS + per-tab JS heap + Chromium process tree (PIDs + types + CPU time) but the per-process RSS is absent — `SystemInfo.getProcessInfo` doesn't expose RSS and the eng review (D2 USE_CDP) explicitly chose CDP over shelling to `ps`. The honest next step is to surface what CDP DOES give for the other memory categories: `Memory.getDOMCounters` per target (node + listener counts), `SystemInfo.getInfo` for GPU memory, `Memory.getAllTimeSamplingProfile` for a sampled native estimate.

**왜:** Codex의 외부 송장 검토는 `Performance.getMetrics`가 기본 기억, GPU 기억, 영상 완충기, Skia, 네트워크 캐시, 연장 과정 RSS 및 브라우저 과정 RSS가 - 160 GB 누출이 실제로 살 것이다 모든 종류에 의하여 끌어 당깁니다. 누출 종류가 자체를 살아 있는 종류를 놓는 진단.

**프로 :** Per-process 카테고리 고장은 "Activity Monitor는 160 GB"라고 불리며 진단이 어떻게 생겼는지 알 수 있습니다. **단점 :** 각 CDP 방법은 자체 quirks가 있습니다. 이것은 실제 구현 패스이며, 한 줄 추가가 아닙니다.

**구성 :** Codex #5를 eng-review 외부 목소리에 찾아내기. v1.49 PR의 범위에서; deliberately deferred.

**우선 순위:** P2. **노력:** M.

---

## P3: 네트워크 부하를 위한 단일 콘텍스 CDP 청취자

**이름:** `wirePageEvents`는 `page.on('requestfinished')` 청취자 PER PAGE를 붙입니다. D10는 청취자 내부의 몸 물자화 누출을 제거하고 탭 당첨자 건축 (7명의 청취자 붙어 있었습니다 — 닫히고, 짜맞춰진 대화 상자, 콘솔, 요구, 응답, requestfinished) 제거했습니다. D10에서 뻗어가는 것은 `requestfinished`를 통해 `requestfinished` 청취자, CDP를 대체하기 위하여, CDP를 통해, CDP를 기다리는 것을 허용합니다: true})` and a browser-wide `Network.loadingFinished` 이벤트 핸들러.

**왜:** 요청 크기 캡처에 대한 N에서 1 청취자는 구조적으로 올바른 아키텍처이며, per-tab 메모리 압력의 한 조각을 제거합니다. 바디 소재화 수정은 이미 급성 누출을 해결했습니다. 이것은 동일한 클래스의 유사한 누출을 방지하는 건축 정리입니다.

**프로 :** 탭당 브라우저당 한 청취자. **단점 :** `Target.setAutoAttach` 배관은 직선의 턴터보다 더 많은 코드입니다. 마진 메모리 승리는 이미 착륙 한 신체의 핑거 수정의 상단에 작습니다.

**구성 :** D10 eng-review에 뻗어 있는 목표. v1.49에서 발송되는 최소 리스크 수정 (`await res.body()`를 `await req.sizes()`로 바꾸고, per-page 청취자 보존); 이것은 건축 후속입니다.

**우선 순위:** P3. **노력:** M-L.

---

## P3: Real-Chromium peak-RSS 재개발 (기간 계층)

**이름:** 문 층 재조절 (`browse/test/memory-leak-reproducer.test.ts`)는 `res.body()`가 `requestfinished` 사건의 파열 도중 불린 무분명한 지 어느 것이 지 어느 것이 지 어느 것이나. 가짜 페이지를 사용합니다; 그것은 NOT는 진짜 Chromium를 회전하고 진짜 동시 fetch 파열 도중 Bun RSS를 측정합니다. 주기적인 층 후속은 이어야 합니다: 실제 headless Chromium를 회전시키면, 동시 fetches 500의 혼합 응답 (작은 JSON, 100 KB 이미지, 10 MB chunked, gzip-compressed 2 MB), 샘플 `process.memoryUsage().heapUsed`를 100 ms 동안 파열, assert `peak_heap < 200 MB above baseline` AND `post-gc_heap < 30 MB above baseline`를 회전시키십시오. 또한 단일-abtert>를 포함하는 웹마스터 MB를 증가시키십시오.

**왜:** Codex는 누출의 진짜 실패 형태가 동시적인 증폭이 응축되지 않는 누출을 유지하지 않는 것을 떨어뜨렸습니다 — 꾸준한 상태 heap 시험은 그것을 놓습니다. 가짜 페이지 문 층 시험은 청취자 아치 나이트크 회귀를 붙잡습니다; 주기적인 진짜 뇌관 시험은 실제적인 첨단RSS 종류를 붙잡습니다.

**프로 :**는 "did를 닫습니다. 실제로 OOM는 단단한 수를 가진 고정된" 질문을 보여줍니다. ANGLE_B_NUMBERS CHANGELOG 방출 summary 테이블을 먹이십시오. **단점 :** Periodic 층은 CI 시간과 돈의 분을 운영하고 있습니다; 진짜 뇌관 기억 시험은 불쾌하게 합니다.

**구성 :** Codex eng-review에 대한 외부 청구서; D7 ANGLE_B_NUMBERS CHANGELOG framing는 /ship 시간의 앞에 이 재개발자의 수를 필요로 합니다.

**우선 순위:** P3. **노력:** M.

---

## 디자인 daemon: 후속 (/ship 검토 군대를 통해 파일 v1.45.0.0)

### ✅ DONE (v1.45.0.0): daemon 시험 적용을 단단히 하십시오

**commit `6b037c55` (same PR)에서 해결하는:** 착륙하기 전에 채워진 모든 5개의 시험 간격. 후에 파일 합계: 봉사 16, daemon 34, daemon-discovery 23, 의견-roundtrip-daemon 4 = 77 (+10 처음 배에서). 구체적으로:
- Idle-shutdown 실제로 화재 (스파이네트 기반, daemon 프로세스가 출구를 관찰,
  state 파일 제거).
- 베어 GET 오염은 재개 (배경 `/api/progress`)를 재설정하지 않습니다.
  daemon는 아직도 밖으로 idles.
- 이들-에-액티브-보드 확장, 그 후 강제-슈트 후 MAX_EXTENSIONS
  (`DESIGN_DAEMON_EXTENSION_MS=1500` + `MAX_EXTENSIONS=2`)에.
- 동시 `ensureDaemon()` 레이스는 daemon (잠금 승리)에 융합합니다.
- Stale-lock reclaim (dead PID 성공, 살아 있는 관련 PID 거부).
- Malformed-JSON + 비폭포 + 배열 몸 + un-html 부정적인
  `POST /api/boards`와 `POST /boards/<id>/api/reload`.

### P3: /ship 리뷰에서 최소 유지성 nits

- `design/src/cli.ts`와 `design/src/serve.ts` 둘 다 작은 `openBrowser`가 있습니다
  동일한 darwin/linux/else branch와 돕는 사람. 공유된 `design/src/open-browser.ts`를 추출하십시오.
- `design/src/daemon-client.ts:320` (`AbortSignal.timeout(2000)`) 및 `:357`
  (`delay(50)`)는 타임아웃을 하게 되면, bare numeric 리터럴을 사용합니다. `SHUTDOWN_POST_TIMEOUT_MS`와 `ALIVE_POLL_INTERVAL_MS`로 승진시킵니다.
- `design/src/daemon-state.ts:21` `serverPath` 필드는 작성되었습니다
  (`daemon.ts:541`) 하지만 생산 코드에 의해 읽지 못했습니다. 제거 또는 forensic intent 문서.

## P3: daemon 범위는 v1.45.0.0 계획에서 곱했습니다

플랜의 "TODOs는 나중에 표면"섹션에 나열 :

- Per-daemon scoped auth 토큰 (만 해당되는 경우 터널/share 사용 사례가 나타납니다).
- 디스크에 대한 옵션 영구 보드 역사
  `~/.gstack/projects/$SLUG/designs/history/` 그래서 제출된 널은 daemon 재시작을 살아남습니다.
- Windows spawn branch (V1 daemon는 macOS + Linux입니다;
  Windows 사용자는 레거시 `--no-daemon` per-process 서버로 돌아갑니다.
- `$D board list` / `$D board stop <id>` per-board ops CLI (V1는 단지 가지고 있습니다
  `$D daemon status` / `stop`).
- Cross-worktree daemon 부착물 (연속자 sibling worktrees 의 동일
  repo 현재 각 종은 daemon - 경기 검색; 마찰을 일으키는 경우에 revisit.

---

## Codex 모델 프로필: 후속 (/ship 검토 군대를 통해 v1.67.2.0을 파일)

## P2: Codex를 위한 단일 소유자는 모형을 만듭니다 (대략한 단면도를 가져옵니다)

**이름:** `./setup`는 Codex 생성 모형을 각 런에 config.toml에서, 그러나 각 OTHER 재생 표면 (`bun run build`, 직접 `gen:skill-docs --host codex`, 자유로운 스위트의 나무 돌연변이 shard)는 호스트 default (gpt)를, 침묵적으로 뒤집는 솔 사용자의 살아있는 symlinked는 다음 체제까지 렌더링합니다. 결의된 모형 (gpt-config)를 주장하는 것은 이렇게 `--model` (gpt)를 위해 동의한 경우에, 이렇게 표시된 코드를 위해 이렇게 표시하는 경우에, 이렇게 표시된 코드를 위해 동의한 것입니다. **왜:** A Sol-using contributor cannot keep both a correct install and a green free suite in one tree; CLAUDE.md's "Deploying to the active skill" flow (bun run build) downgrades the profile. Cross-model consensus finding (Claude adversarial M4, Codex adversarial P2, red team C-70). **우선 순위:** P2. **노력:** S (human ~half day / CC ~20min).

## P3: Codex 주기 CI shards는 Dockerfile.ci에서 (no codex CLI)를 결코 실행하지 않습니다

**이름:** `evals-periodic.yml` carries `e2e-codex`, and now `e2e-codex-sol-scope`, but the CI image installs only claude-code, so both shards boot, skip everything, and report green weekly. Either bake `@openai/codex` + an auth strategy into the image, or prune both matrix entries and document codex evals as local-only. **왜:** A green all-skip shard reads as coverage that does not exist. **우선 순위:** P3. **노력:** M (auth strategy is the hard part).

## P3: `--model` 업그레이드를 통한 지속성

**이름:** `./setup --host codex --model <id>` applies to that run only; the upgrade flow re-resolves from config.toml. Setup now prints the persistence hint (set `model` in config.toml). If users keep tripping on it, persist the override in `~/.gstack/config.yaml` and read it between `--explicit` and the TOML lookup. **왜:** Explicit user choices should survive upgrades or say loudly that they will not (the hint covers the second half today). **우선 순위:** P3. **노력:** S.

---

## 서버 검색: 터미널 에이전트 눈물다운 후속 (/plan-eng-review를 통해 파일 v1.41)

### ✅ DONE (v1.44.0.0): Identity 근거한 맨끝 에이전트 죽이기 (PID를 가진 pkill regex를 대체하십시오)

**해결:** Bundled into the v1.44.0.0 long-lived-sidebar PR as Commit 0. `browse/src/terminal-agent-control.ts` is the new home for `readAgentRecord`, `writeAgentRecord`, `clearAgentRecord`, and `killAgentByRecord`. The agent writes `<stateDir>/terminal-agent-pid` (JSON `{pid, gen, startedAt}`) at boot and clears it on SIGTERM/SIGINT. `cli.ts` and `server.ts` both route through `killAgentByRecord` instead of `pkill -f terminal-agent\.ts`. 새로운 `browse/test/terminal-agent-pid-identity.test.ts`는 CI가 아닌 `pkill ... terminal-agent` 또는 `spawnSync('pkill', ...)`가 어떤 소스 파일에 있는 reappears를 실패하는 정체되는 지프 삼각선입니다.

---

## P3: 종료 () 단위 수준 `config`, `cfg.config` (구부 간격)를 읽으십시오

**이름:** `browse/src/server.ts:shutdown()` `config`는 `buildFetchHandler`로 통과된 `cfg.config`가 아닌 수입 시간에 해결된 단위 수준 가치입니다. 동일한 간격은 `cleanSingletonLocks(resolveChromiumProfile())`에 server.ts:1298에 `cfg.chromiumProfile`에 `cleanSingletonLocks(resolveChromiumProfile())`에 적용합니다.

**왜:** Embedders는 오늘 CLI (같은 env에 대하여 `resolveConfig()`를 통해서 갑니다), 이렇게 이것 조금이 아닙니다. 그러나 embedder가 이제까지 divergent `cfg.config` (예를들면, 임시 dir에 점이는 시험 마구를, 폐쇄하는 것은 틀린 경로에 작동할 것입니다. `ownsTerminalAgent` 깃발은 고치지 않고 문제를 드러냅니다.

**프로 :** embedder-composition 이야기를 제대로 닫습니다. 단 하나 coherent "이 공장 눈물다운 존경 cfg"계약을주는 `cfg.chromiumProfile`와 쌍.

**단점 :** 사전 - 발음 - 회귀가 아닙니다. 오늘 두 개의 전화 사이트 (1285 터미널 파일, 크롬 잠금 용 1298). `cfg.config` 및 `cfg.chromiumProfile` 오른쪽 폐쇄에 묶는 것은 직행하지만 v1.41 수정보다 더 넓습니다.

**구성 :** Codex와 Claude /plan-eng-review 이중 음성에 있는 subagent 둘 다에 의해 퍼집니다. v1.41 계획에 있는 out-of-scope로 문서화해; `chromiumProfile` PR-body 주의와 같은 모양은 gbrowser 팀에.

**에 따라:** 없음.

---

## P3: 4번째 칭호 소유의 눈물방울 문이 나타나는 경우에 소유권의 개입 재공장

**이름:** Today `ServerConfig` has three caller-owned teardown gates: `xvfb?` (presence ⇒ don't close), `proxyBridge?` (same), and now `ownsTerminalAgent` (explicit boolean). If a 4th gate appears, collapse to `cfg.callerOwns?: Set<'terminalAgent' | 'xvfb' | 'proxyBridge' | ...>` or similar.

**왜:** 3개의 독립적인 깃발은 refactor 문턱의 밑에 있습니다 - 각 분야는 명확하고, 명백한 semantics 및 JSDoc 음성은 일관되게 합니다. 4개의 끝 비용 균형: 원필드 표면은 noisy를 얻고, “이 공장은 어디에 있습니까?”는 당신이 1개의 명시한 세트 대신에 3개 4개의 흩어져 있는 분야의 요구해야 하는 질문이 됩니다.

**프로 :** "what gstack 눈물을 위한 진실의 단 하나 근원. 미래 칭호 소유한 자원을 위한 삼극관 연장 표면. 시험에 있는 assert에 에세이리 (" 세트는 X, Y를 포함해야 합니다).

**단점 :** 오늘 조기. `ownsTerminalAgent` JSDoc의 극성 변환은 약간 아프다 — 그것은 한 개의 무독한, 패턴이 아닙니다. 소유권 개체가 모든 임계를 접촉하기 위해 지금 다시 시작.

**구성 :** Claude /plan-ceo-review 이중 음성 (autoplan) 도중에 추천하는. 방아쇠: 이 동일한 `ServerConfig` 모양에 있는 4개의 칭거 소유한 눈물방울 문.

**에 따라:** 재공장을 동기 부여하는 4 문.

---

## /sync-gbrain 메모리 스테이지 perf 후속

## P2: 큰 노후화 디너에 조사 `gbrain import` perf

**이름:** Cold-run time on a 5131-file staging dir is >10 min in `gbrain import` alone (after gstack's prepare phase, which is now <10s after dropping per-file gitleaks). On 501 files it took 10s. The scaling is worse than linear and the bottleneck is inside gbrain, not the gstack orchestrator.

**왜:** 메모리-ingest의 준비 단계로 이제 빠르게, 나머지 찬 실행 비용은 gbrain 측에 완전히. 큰 corpora (5K+ 파일)를 가진 사용자는 지금 ~15-30 분을 첫번째 ingest에 지불합니다. `~/git/gbrain/src/core/import-file.ts`에 있는 culprits:

- N+1 SQL 쿼리: `engine.getPage(slug)` 각 파일의 content_hash 체크에 대 한
  (line 242 + 478) - 단일 쿼리에 배치되어야한다
- 불변의 콘텐츠를 위해 불을 불이 켜지는 자동 연결 재구성
- FTS / 일괄 거래 없이 벡터 인덱스 업데이트

**프로 :** gbrain (클린저 분리)에서 라이브. gbrain 혜택에 수정 다른 gbrain 호출기 (`gbrain sync`, MCP `put_page` 워크 플로우). 혼자 배치 된 쿼리에서 10-50x speedup 처럼.

**단점 :** 크로스-레포 변경은 새 배치 된 경로에 대한 GBrain 테스트 범위를 필요로합니다. gstack 중요한 경로에 아닙니다; gstack의 아키텍처는 이미 정확합니다.

**구성 :** 실제 corpus 2026-05-10에서 확인. `--scan-secrets` 오프 실행 <10s에서 gstack 측 준비. 동일한 단계 디디에 전체 GBrain 가져 오기는 100 % CPU를 사용 >10 분. `runGbrainImport` 호출에 도달하는 `bin/gstack-memory-ingest.ts:ingestPass`의 두 관측은, 그 후에 벽 시간의 부피를 가지고하는 아이 과정.

**에 따라:** None — gstack의 일괄 처리 건축 (D1-D8에서 `docs/designs/SYNC_GBRAIN_BATCH_INGEST.md`)는 이미 발송되고 정확합니다.

---

## P3: Cache "no가 준비 배치 수준에서 마지막 수입" 이후 변경

**이름:** 준비 단계가 빠르지만 (<10s for 5135 files), 걷기 및 mtime-stat'ing 각 파일에 true no-op run adds a few seconds and create spurious staging dirs. Cache the most-recent-source-mtime per-source in the state file; if no source dir has a newer mtime, Skip the walk + stage + import totally.

**왜:** 대부분의 `/sync-gbrain` invocations에는 신이 없습니다. 가장 빠른 경로는 "무엇도, 빠른"입니다. `gbrain doctor`는 아직도 국가를 보고해야 합니다, 그러나 실제적인 ingest 파이프라인은 마지막_full_walk가 최근이고 no 근원 나무 mtime는 이동했습니다.

**프로 :** Trivial 구현 (~ 20 라인 `ingestPass`). 초기 계획에서 "<30s"까지 증가하는 증가 빠른 동종을 만듭니다.

**단점 :** 캐시 유효성 검사 표면을 추가합니다. 사용자가 파일을 편집하는 경우 부모 디디의 가동 시간은 업데이트되지 않습니다 (macOS APFS), 변경은 놓습니다. 완화 : 마지막 _full_walk가 최근 (예 : 1 분 전).

**구성 :** Filed during 2026-05-10 perf testing after `--scan-secrets` was made opt-in. Lower priority than the gbrain-side perf issue above.

---

## 브라우저 - 스킬 따라 (단계 2-4)

## P1: 브라우저 스킬 2 단계 — `/scrape` 및 `/skillify` 기술 템플릿

**이름:** 브라우저 스킬 디자인의 단계 2a (`docs/designs/BROWSER_SKILLS_V1.md`). 두 개의 새로운 gstack 기술: `/scrape <intent>` (read-only)는 페이지 데이터를 끌어 당기는 단일 항목 점입니다. `$B` 원시를 통해 첫 번째 호출 시제품은 ~200ms에 통합된 브라우저 스킬에 매칭 된 의도적인 경로에 연속 호출됩니다. `/skillify`는 최근의 프로토 타입에 성공했습니다. `script.ts` + `script.test.ts` + 물질의 자체 컨텍스트 (final-attempt $B 통화 전용)에서 고정 된 온도 디디렉트의 테스트를 실행하고, 커밋하기 전에 요청, `~/.gstack/browser-skills/<name>/`에 원자 이름을 요청합니다. mutating-flow sibling `/automate`는 자체 P0 (아래)로 나뉩니다. - 동일한 기술 패턴, 다른 신뢰 프로필.

**왜:** 단계 1은 runtime을 발송했습니다. 인간은 gstack가 실행되는 것을 결정적인 브라우저 스크립트를 손으로 씁니다. 단계 2a는 생산성 이득을 자물쇠로 엽니다: 20+ `$B` 명령을 통해 한 번 흐르는 액체를 얻는 에이전트은 `/skillify`를 말한다고 스크립트는 뒤에 영원히 200ms 호출됩니다. 동일한 기술적인 본 Garry의 기사는, read-only 브라우저 활동 (찰기)에 적용해 deministic 압축에 가장 쓸모 있는. 실패 모드 (언제 쓰기)가 더 강한 문을 필요로하기 때문에 `/automate`와 같은 동작 배를 짝지어주는.

**프로 :** 100x 생산성이 여기에 있습니다. 반복을 닫습니다. 에이전트 프로토 타입, codify, 다음 다시 탐험 대신 미래의 세션에서 통합 된 기술을 도달합니다. 원래 "자기-오토링 `$B` 명령" P1 - 동일한 사용자 가능 목표, no in-daemon 고립 문제 (스킬 스크립트는 독립 Bun 프로세스로 실행되지 않습니다. daemon 프로세스로 수입되지 않았습니다. Synthesis 질문 (Codex 찾는 #6)는 에이전트의 자신의 대화 상황 (디자인 문서에 있는 선택권 b)에서 재제작에 의해, `/plan-eng-review` D2 당 마지막에 비난 `$B` 호출에 경계를 두었습니다.

**단점 :** **Bun 런타임 배포** (Codex finding #7). Phase 1 sidesteps this because the bundled reference skill ships inside the gstack install. User-authored skills land on machines without Bun unless we ship a runtime alongside, compile to a self-contained binary, or use Node + the existing `cli.ts` pattern. Deferred to Phase 4 — `/skillify` documents the assumption that gstack is installed (which means Bun is on PATH).

**구성 :** 단계 1 건축술 (3 층 보기, scoped 토큰, sibling SDK, frontmatter 계약)는 번들 `hackernews-frontpage` 참고 기술에 의해 잠겨지고 운동됩니다. 단계 2a는 `/plan-eng-review` `/skillify`를 2개의 기술 템플렛을 통해 그런타임으로 그리고 1개의 새로운 돕er (`browse/src/browser-skill-write.ts`를 통해 이고`/plan-eng-review` D3 no no no를 위한 `browse/src/browser-skill-write.ts`를 새 읽습니다.

**노력:** M (인간: ~1 주/CC: ~1 일) **우선 순위:** P1 (이 branch — `garrytan/browserharness` v1.19.0.0로 발송) **에 따라:** 단계 1 발송 (이 branch).

---

### P2: 브라우저 skills Phase 3 — 세션 시작에 해결사 주입

**이름:** Mirror the domain-skill resolver at `browse/src/server.ts:722-743`. When a sidebar-agent session starts on a host with matching browser-skills, inject a list block telling the agent which skills exist for that host and how to invoke them (`$B skill run <name> --arg ...`). UNTRUSTED-wrapped via the existing L1-L6 security stack. Add `gstack-config browser_skillify_prompts` knob (default `off`) controlling end-of-task nudges in `/qa`, `/design-review`, etc. 활동 피드가 단일 호스트 AND no 기술에 ≥N 명령을 표시하면 호스트 +intent가 아직 존재합니다.

**왜:** 해결자 없이, 브라우저-skills는 사용자의 명시적으로 유형 `$B skill run <name>`일 때만 작동합니다. 해결자로, 에이전트는 현재 호스트에 대한 기존 기술을 자동 발견하고 재 탐구 대신에 도달합니다. 도메인-스킬과 동일한 합성 패턴.

**프로 :** 발견 간격을 닫습니다. 기술이 현재 시스템에서 자동으로 볼 수 없는 에이전트. End-of-task nudges (knob을 통해 채택) 기술이 가장 가치있는 순간을 잡아.

**단점 :** 해결자는 시스템 프롬프트에서 생명을 차단하고 프롬프트 예산에 대한 다른 해결자 블록과 경쟁합니다. 조심스럽게 문을 닫을 필요가 있으므로 기술이 현재 작업과 매우 관련이있을 때 기술이 모든 호스트에 불을 수 없습니다. v1.8.0.0 도메인 스킬은 활성 탭의 호스트 이름에만 발사하여이를 처리합니다. 이 패턴은 여기에 있습니다.

**노력:** S (인간: ~3 일/CC: ~4 시간) **우선 순위:** P2 **에 따라:** 2 단계

---

## P2: 브라우저 skills Phase 4 - eval 인프라 + 고정  staleness + OS 샌드박스

**이름:** 세 느슨하게 결합 된 확장 : (a) LLM-judge eval (" re-exploring 대신 기술에 대한 에이전트 도달을 습득?"), 분류 `periodic` 당 `test/helpers/touchfiles.ts`. (b) 고정 장치 - staleness 탐지 - 라이브 페이지에 대한 번들 된 정착물의 주기적인 비교, 그들은 침묵 테스트 전에 flagging mismatches. (c) OS-level FS->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->-> 기존의 신뢰할 수있는/untrusted 계약 (상 1 단 줄무늬 env; 단계 4는 실제 FS 고립을 추가합니다)를 제거합니다.

**왜:** 단계 1의 신뢰 모형에는 daemon 측 기능 경계 권리 (scoped 토큰)가 있습니다 그러나 과정 측 env는 위생, 모래 상자 (Codex를 찾아내는 #1) 아닙니다. 진짜로 위탁한 기술을 위해 (단계 2 에이전트authored), 진짜 FS 고립 사정. Eval + 정착물 staleness는 흐르는 drift로 솔질한 기술 질 막대기를 지킵니다.

**프로 :** #1 (FS 읽는 `~/.ssh/id_rsa` 등)를 찾아내는 Codex에서 마지막 주름을 잡는 공격 표면 닫습니다. Eval 자료는 결심 주입이 실제로 작동한다는 것을 저희에게 말합니다. 정착물 staleness는 사용자의 앞에 HTML 편류를 붙잡습니다.

**단점 :** 3개의 다른 관심사, 3개의 다른 디자인 통행. 뭉치에 임시로. 저항: 각각은 자주적으로 발송할 수 있습니다. OS sandbox는 가장 단단한 조각입니다 (macOS `sandbox-exec`는 애플 개인화 그러나 안정되어 있습니다; Linux는 namespaces + 묶는 산을 요구합니다).

**노력:** L (인간: ~2-3 주/CC: ~3-5 일) **우선 순위:** P2 **에 따라:** 2 단계 (샌드박스를 동기를 부여하는 에이전트 오존 기술); 3 단계 (예측 필요 결심사 주입).

---

## P2: SQLite에 `/learn`를 마이그레이션

**이름:** The current `~/.gstack/projects/<slug>/learnings.jsonl` storage works (append-only, tolerant parser, idle compactor) but Codex outside-voice (T5) flagged JSONL as "the wrong primitive" for multi-writer canonical state: lost-update on rewrite, partial-line corruption on crash, no transactions. v1.8.0.0 hardened JSONL with flock + O_APPEND but the right long-term primitive is SQLite (which Bun has built in via `bun:sqlite`).

**왜:** 도메인 기술은 이제 같은 `learnings.jsonl` (CEO D1 unification)에서 살았습니다. 볼륨이 성장함에 따라 JSONL는 컴팩트한 패서저 접근이 긴 극이 됩니다. SQLite는 원자 트랜잭션, 지수 (주호표 조회를 위한 부분), 그리고 사용자 지정 조밀함 없이 충돌 안전합니다.

**프로 :** 원자는 쓰입니다. 진짜 스키마. hostname/key/type. 충돌 안전에 의해 빠른 색인된 보기.

**단점 :** 마이그레이션은 `learnings.jsonl` — `/learn` 스크립트 (`gstack-learnings-log`, `gstack-learnings-search`), domain-skills.ts read/write, gbrain-sync (현재 플랫 파일로 처리)의 모든 소비자에게 접촉합니다. 야생의 이전 `learnings.jsonl` 파일에는 1 샷 마이그레이션 스크립트가 필요합니다.

**구성 :** v1.8.0.0에서 경화하는 JSONL는 그 릴리스 범위 (보일-대양이 아닌)에 대한 올바른 호출이었다. 그러나 실패 모드는 경계, 제거되지 않습니다. SQLite는 끓는-대양 수정입니다.

**노력:** M (인간: ~1 주/CC: ~1 일) **우선 순위:** P2 **에 따라:** v1.8.0.0 ~1 달 동안 생산에서 JSONL 고통 (범주 빈도, 부분 선 하락, 쓰기 내용).

---

## P2: `/plan-devex-review` SKILL.md.tmpl에서 계획 형태 핸디크 제거

**이름:** `/plan-devex-review`는 "계획 형태 Handshake"부분의 섹션을 가지고 있으며, 프리빌드의 "계획 모드 동안의 스킬 인 직업"계약 (AskUserQuestion satisfies plan mode's end-of-turn requirements). Handhake는 no 다른 대화 형 검토 기술 필요가 요구되는 여분의 출구 계획 형태 단계를 강제합니다. `/plan-ceo-review`, `/plan-eng-review`, `/plan-design-review` 모든 실행없이 미세한 계획 모드를 실행합니다.

**왜:** v1.8.0.0 DevEx 검토 중 발견. 일관성은 차례로 비용이 들며 흐름을 혼란스럽게 시켰습니다. `plan-devex-review` (클린 수정, 권장) OR에서 핸디크를 제거하면 일관성에 대한 모든 상호 작용 기술에 추가합니다.

**프로 :**는 계획 모드에서 `/plan-devex-review`를 실행하는 사람의 실제 DX 버그를 수정합니다. 5 분 변경.

**단점 :** WHY 에 대해 생각해야 하는 것은 첫 번째 장소에서 추가되었습니다. TODO 은 누락될 수 있습니다.

**구성 :** `plan-devex-review/SKILL.md.tmpl`의 핸디케이 섹션은 계획 모드가 "이 슈퍼가 다른 지침" 경고를 무시할 수 있기 때문에 필요한 것이 아니라 기술의 퍼 핀딩 STOP 게이트를 우회할 수 있습니다. 그러나 동일한 경고는 다른 검토 기술에 존재하며, 그들은 모두 AskUserQuestion가 종료 된 계약에 만족하기 때문에 잘 작동합니다.

**노력:** S (인간: ~15 분/CC: ~5 분) **우선 순위:** P2 **에 따라:** 아무것도.

---

## P2: gstack 기억 기능 방출 (#1305 부분 2)를 가진 lockstep에 있는 범프 gbrain 설치 핀

**이름:** `bin/gstack-gbrain-install` 핀은 commit `08b3698` (v0.18.2)에 gbrain를 또는 schema (e.g. v1.26.0는 + `code-def`/`code-refs`/`reindex-code`)에 달려 있는 특징을, 핀으로 움직이지 않습니다. 신선한 `/setup-gbrain`는 오래된 gbrain를 설치합니다 `gbrain doctor`는 사용자의 최신 버전까지, 32/>/>/`gbrain doctor`를 검사합니다.

**왜:** `put_page` CLI 버그와 함께 #1305에 Filed. v1.26.5.0 수정 파 (세판 발표 - 조정 관심사 : 우리가 대를 설치하는 gbrain 버전. 우리가 그것을 호출하는 방법). 설치 핀은 gstack 방출 기능에 따라 (a) 자동 범프를해야 합니다. 새로운 gbrain, 또는 (b)는 preamble 및 hcl 또는 hcl-up-up-up-up-up-up-up-up-up-up-up-up-up->에 대한 stale 핀을 감지합니다.

**프로 :**는 "fresh-install paper-cut" 경로로 닫습니다. 새로운 사용자들은 건강한 스키마에 착륙합니다. `/setup-gbrain` 흐름에 대한 지원 소음을 줄입니다. gstack/gbrain 릴리스 계약이 표시된 것을 확인합니다.

**단점 :** gstack와 gbrain 사이 방출 Cadence 연결 추가. 정책이 필요: 핀 = "minimum version that still works" vs "latest known good." gbrain ships break change to `put` 모양과 gstack 새로운 방법으로 핀을 업데이트하지 않습니다.

**구성 :** 문제 #1305 부분 1 (`put_page` CLI 동사 버그)는 v1.26.5.0에서 취급되었습니다. 2 (이 TODO)는 설치 핀 staleness입니다. 핀은 `bin/gstack-gbrain-install`에서 정상의 일정으로 취급했습니다. 가장 작은 고침: 추적된 방출 artifact로 핀을 발송하십시오 (예를들면 `package.json`에서 건축 시간) 그리고 의사 prestyle를 추가하십시오.

**노력:** S (인간: ~2 일/CC: ~3 시간) **우선 순위:** P2 **에 따라:** 아무것도.

---

## P3: `deriveCodeSourceId`의 소스 ID 호스트 충돌 위험 (cross-host duplicate org/repo)

**이름:** v1.26.5.0의 `deriveCodeSourceId`는 gbrain의 32-char 근원 ID 예산을 적합하기 위하여 주인 세그먼트를 방울합니다. 이것은 `github.com/acme/foo`와 `gitlab.com/acme/foo`와 동일한 `gstack-code-acme-foo`에 붕괴를 의미합니다. `bin/gstack-gbrain-sync.ts:323`에서 `ensureSourceRegisteredSync()`는 `local_path`가, 1개의 측을 이기기 때 근원을 침묵적으로 재등록할 것입니다.

**왜:** 연습에서 거의 드물게 드물게 — 동일한 기계에 github.com와 gitlab.com 둘 다의 모양과 거의 결코 일어나지 않는 거의. 그러나 실패 형태는 침묵합니다 (뇌에서 다른 1개의 repo), 사용자는 no 신호가 무엇이든 틀립니다.

**프로 :** 침묵의 가장자리를 닫습니다. 두 개의 viable 접근법 : 짧은 호스트 마커 (`gh-` / `gl-` / `bb-`)는 3 개의 숯을 먹지만 크로스 호스트 고유성을 유지; OR는 org-repo와 함께 호스트의 3 개의 char 해시가 있습니다.

**단점 :** 소스 IDs 변경 모양 다시 — v1.26.5.0에 기존 등록을 가진 사람은 한 번 등록을 가져옵니다. 현재 계획이 v1.26.4.0에서 변경되기 때문에 그물 파손 일.

**구성 :** #1320 / #1322 / #1323 / #1331 (출처-id validation bugs)에 출원되어 호스트 세그먼트 + 해시-truncating로 v1.26.5.0에 주소를 붙였습니다. 크로스 호스트 충돌은 PR #1330의 디자인 (" 밴싱하게 연습에서 드문")에서 알려진 허용 된 거래였습니다. Codex 외부-voice 계획은 표면-경찰을 위해 긴 관심으로 캡처합니다. TODO TODO

**노력:** XS (인간: ~4 시간/CC: ~30 분) **우선 순위:** P3 **에 따라:** 아무것도.

---

### P3: GBrain 도메인 기술에 대한 기술 패키지 출판

**이름:** 도메인 기술은 호스트 이름 당 에이전트 승인된 노트입니다. 지금 그들은 per-machine 또는 per-agent-repo입니다. 자연적인 합성 연장: curated 기술 팩을 GBrain (`gstack-brain-sync`)로 출판해서 다른 사람은 구독할 수 있습니다. "Louise's LinkedIn 기술" 또는 "Garry's GitHub 기술"는 누군가를 당길 수 있는 팩이 됩니다.

**왜:** v1.8.0.0는 우리 per-machine 화합물을 가져옵니다. 교차하 사용자는 화합물은 네트워크 효력입니다 — 각 사용자는, 각 사용자 이익 공헌합니다.

**프로 :** 대규모 합성 잠재력. 단단한 부분은 신뢰/moderation (오래된 문제 GBrain-sync는 통해 생각했습니다)입니다.

**단점 :** 출판 인프라, 시그니처/redaction 모델, 팩이 나쁘게 이동할 때 모의 형태. 필요한 실제 계획.

**구성 :** GBrain-sync infra (v1.7.0.0) 이미 사용자의 데이터에 대한 개인 크로스 머신 동기화를 수행합니다. Skillpack 출판은 public/shared 레이어의 상단에 있습니다.

**노력:** M (인간: ~1 주/CC: ~1 일) **우선 순위:** P3 **에 따라:** GBrain-sync는 생산에서 안정되어 있습니다. 몇몇 사용자 수요 신호는 첫째로.

---

## P3: Replay/record는 도메인 스킬에 흐름을 설명했습니다.

**이름:** 사이트가 한 번에 구동되는 것을 시청하십시오 (DOM 이벤트 + 스크린 샷 + 네브), 도메인 스킬에 대한 종합. "보내기로 가르쳐." v1.8.0.0의 현장 노트보다 다른 연구 꿈.

**왜:** 가장 높은 품질의 기술 콘텐츠는 인간이 입증되지 않은 한, 스크래치에서 파악된 에이전트입니다. 기술 패키지 출판과 쌍 - 기록 된 흐름은 가장 소중한 팩입니다.

**프로 :** 기술 품질 점프. 몇몇 사이트는 혼자서 파악하기 위하여 에이전트을 위해 너무 복잡합니다 (다단계 OAuth, captcha gated 모양).

**단점 :** 기록적인 불능 대. 선별기 안정성 시간. DOM 변화는 기록합니다. 실제적인 연구는 필요로 합니다.

**구성 :** 브라우저 사용은 실험했습니다. Playwright에는 레코더가 있습니다. Codeception/Cypress 레코더가 존재합니다. None는 "문자막주의로 기록 생성"단계를 합니다.

**노력:** L (인간: ~2-3 주/CC: ~2-3 일) **우선 순위:** P3 **에 따라:**는 eng 시간을 투입하기 전에 그것의 자신의 `/office-hours` 회의를 전적으로 입증했습니다.

---

## P3: `$B commands review` 배치 형태 UX

**이름:** 원래의 첫 번째 사용 승인 게이트 (DevEx D6 대안 C)에 대한 대안. 대신 각 에이전트 승인 명령을 처음 주장에 승인 대신, 배치: 에이전트 비계 많은, 인간 리뷰 `$B commands review` 편리한 시간에, approves/rejects 한 패스.

**왜:** 만약 자기선명이 이제 배를 갖는 경우 (P1 위), 첫 번째 사용의 인라인 승인은 에이전트 중간 작업 중단을 할 수 있습니다. 일괄 검토는 인간을위한 우연입니다.

**프로 :**는 중단 빈도를 감소시킵니다. 인간은 가득 차있는 상황에 검토를 하자.

**단점 :** Defers 승인 - 에이전트는 인간의 이전이 될 때까지 새로운 명령을 사용할 수 없습니다. 에이전트가 명령을 즉시 필요로한다면, 이것은 인라인보다 더 나쁘다.

**구성 :** 위의 P1로 묶습니다. 그 전에 배를 하지 않습니다.

**노력:** S (인간: ~half 일/CC: ~30 분) **우선 순위:** P3 **에 따라:** P1 각자 오싱 `$B` 명령.

---

## P3: 허리즘 명령갭 watcher

**이름:** Sidebar-agent는 활동 피드를 보며, 에이전트가 비슷한 동작을 반복할 때(예를 들어, `$B js`를 구조적으로 유사한 인수로 호출), 명령을 비계하는 것을 제안합니다. DevEx D4 대안 C에서.

**왜:** 자기오류 명령에 대한 발견성 루프를 닫습니다. 에이전트는 동일한 마찰을 여러 번 입력하면 명령을 쓰는 것이 가장 가능성이 높습니다.

**프로 :** 수술. 명령이 치명적으로 도움이 될 때만 불. 실제적인 telemetry를 사용, heuristics.

**단점 :** False 긍정적 (절대적 반복된 행동)는 intrusive 느낌. 원격 측정 없이 디자인하는 단단한.

**구성 :** v1.8.0.0 (`cdp_method_called`, `cdp_method_denied` 카운터)에서 텔레메틱스는 이 잘 디자인하는 자료를 줍니다. 우리가 생산 자료의 ~1 달이 있을 때까지 디자인하지 마십시오.

**노력:** M (인간: ~1 주/CC: ~1 일) **우선 순위:** P3 **에 따라:** v1.8.0.0 생산에 있는 telemetry. P1 각자 오싱 명령.

---
## 사이드바 터미널 (cc-pty-import follow-ups)

## v1.1: PTY 세션은 사이드바 재로드를 생존

**이름:** 오늘 터미널 탭의 PTY는 WebSocket와 함께 죽는다. 사이드바 재부하, 측면 패널 닫기, 심지어 다른 탭에서 빠른 탐색이 세션을 닫습니다. v1.1은 탭 /session에서 PTY를 키해야 기존의 claude 프로세스에 다시로드를 다시로드하고 `/resume` 역사를 유지해야합니다.

**왜:** Mid-task 탄력. 20 분 동안 claude와 함께 페어 프로그래밍을하고 사고 Cmd-R가 멀리 불어 났을 때, 비용은 실제입니다.

**프로 :** 더 나은 UX, 몇몇 중단된 회의. **단점 :** 세션 추적 국가, 유령 처리 위험, lifecycle 버그 (DOES PTY 실제로 멀리 떨어져 있?). v1는 WS" 모형 deliberately와 간단한 “PTY 거푸집을 선택했습니다.

**구성 :** /plan-eng-review 문제 1C 결정 (cc-pty-import branch, 2026-04-25). phoenix의 수명주기를 가진 v1 배. **에 따라:** cc-pty-import 착륙.

**우선 순위:** P2 (nice-to-have). **노력:** M. 마찬가지로 크롬에 의해 키 입력된 per-tab 세션 맵이 필요 합니다. TTL 그래서 PTYs를 포기 결국 종료.

---

## 테스트

## P2: /plan-ceo-review를 위한 퍼핀 AskUserQuestion 조사 assertion

**이름:** PTY E2E는 단계 0을 통해 단계 0을 구동하는 시험은, 계획_ready의 앞에 N 알려진 발견을 포함하는 안정되어 있는 정착물 diff를, 정확하게 N 명백한 AskUserQuestions 불 (찾은 당)를 포함하는 assertserts를 포함하는 안정되어 있는 정착물 diff를 가진 시험합니다.

**왜:** 기술 템플릿은 "One issue = one AskUserQuestion call. 는 여러 가지 문제로 결합하지 않습니다." 모든 리뷰 체크 포인트. No 테스트는 시행합니다. 현재 `skill-e2e-plan-ceo-plan-mode.test.ts` Smoke (post-v1.21.1.0)는 "에이전트 건너 뛰는 단계 0"을 완전히 붙잡습니다. 배팅은 한 가지 질문으로 갖춰서 침묵으로 움직입니다.

**프로 :** 가장 강한 계약에 있는 자물쇠 기술 위임. 진짜 실패 형태를 캐치하십시오 (원래 부착은 0개의 질문으로 배치된 2개의 발견을 보여주었습니다). **단점 :**는 계수 세분화 (~1 일 인간/~30 분 CC)를 찾아내기 위하여 안정되어 있는 정착물 diff를 필요로 합니다. Opus는 이유가 2개의 관련 결과를 통합할지도 모르다, 그래서 assertion는 더 낮은 경계 (.g., `>= ceil(N * 0.6)`) 보다는 오히려 엄격한 질에 강제할 필요가 있습니다.

**구성 :** PTY 하네스 (`runPlanSkillObservation`)는 V2를 위해 첫번째 맨끝 결과에 반환합니다. 우리는 `plan_ready`까지 전체적인 회의를 통하여 AskUserQuestions를 조사하는 스트리밍 변종이 필요합니다. `runPlanSkillObservation`와 함께 새로운 돕는 사람.

**에 따라:** 안정 설비 diff (`test/fixtures/plans/multi-finding.diff` 또는 이와 유사한) 모든 4개의 검토 단면도를 방아쇠를 갖는 문제점의 작은 알려진 세트.

**우선 순위:** P2. **노력:** S (CC: ~30 분 한 번 정착물이 존재합니다). v1.21.1.0 계획 - eng-review D2에서 붙잡히십시오.

---

## P3: gstack-config의 명예 env vars (그래서 QUESTION_TUNING/EXPLAIN_LEVEL 실제로 고립된 시험)

**이름:** `gstack-config get <key>`는 `~/.gstack/config.yaml`를 읽습니다. `runPlanSkillObservation` 배관 `env: { QUESTION_TUNING: 'false', EXPLAIN_LEVEL: 'default' }`는 스파게드 `claude` 과정에 통해서 — 그러나 기술 preamble bash는 env에 결코 봅니다 `gstack-config get question_tuning`를, 이용합니다. env passthrough는 현재 코드에 극장입니다.

**왜:** 명예를 받지 않고, v1.21.1.0 계획소 검토 연기는 YAML에서 놓인 `question_tuning: true`를 가진 기계에 아직도 flaky입니다. AUTO_DECIDE 선호는 연출한 AskUserQuestion 명부를 건너, 잡기 위하여 회귀를 마주고 싶습니다.

**프로 :**는 기계의 맞은편에 문 시험 신비를 만듭니다. env 배선은 이미 장소에서 - 단지 `gstack-config`는 env를 첫째로 읽고, YAML로 떨어뜨릴 필요가 있습니다. **단점 :**는 모든 3개의 플랫폼 (linux/darwin/windows). 교차 결합 refactor를 맞댄 gstack-config 바이너리를 만납니다.

**구성 :** v1.21.1.0 adversarial 검토에서 캡처. 알려진 제한으로 테스트 docstring에서 솔직히 문서화.

**우선 순위:** P3. **노력:** S. 단 하나 파일 편집 `bin/gstack-config` (~10 LOC env-first lookup).

---

## P3: SANCTIONED_WRITE_SUBSTRINGS에 강하게 하는 경로 혼란

**이름:** `runPlanSkillObservation`의 침묵하는 표를 검출하는 감지기는 몇몇 sanctioned 경로 (`.gstack/`, `CHANGELOG.md`, `TODOS.md`, 등)에 일치하는 substring를 이용합니다. `node_modules/some-pkg/CHANGELOG.md` 또는 `src/foo/.gstack/leak.ts`에 쓰기는 현재 경로에서 빼는 substring 경기 때문에 sanctioned.

**왜:** 방어 — no 현재 버그는 이것을 악화하지만 악의적 인 기술이나 고정은 `.gstack/` 또는 `CHANGELOG.md`를 포함시키는 경로로 쓸 수 있으며, 침묵 감지를 통해 스트레이트를 씁니다.

**프로 :** 미래의 기술 misbehavior에 대한 하네스를 강화. 자신의 의도와 함께 Aligns substring 규칙. **단점 :** 기계 전체에 테스트가 적은 휴대용을 만드는 절대 접두사 (`os.homedir() + '/.gstack/'`, worktree 루트)에 대한 앵커 필요.

**구성 :** v1.21.1.0의 adversarial 검토에서 캡처 (HIGH/FIXABLE 찾는, 사전 노출). v1.21.1.0에서 `SANCTIONED_WRITE_SUBSTRINGS` 상수로 재발견되었지만, substring-includes logic은 전부터 변경되지 않습니다.

**우선 순위:** P3. **노력:** S.

---

## P1: 구조상 STOP-모든 기술을 통하여 기능을 강제하는 것

**이름:** 디자인과 기술이 조직 AskUserQuestion 하지만 모델이 조용히 배치 합성을 대체할 때 잡을 수있는 구조적 인 기능을 구현합니다. 후보 메커니즘 : 질문 - 계정 assertion (skill은 frontmatter에서 예상된 질문 카운트를 선언합니다; 모델이 <N) 인 경우 포스트 실행 감사 로그, 유형화 된 질문 템플릿 (모델이 사전 제작 된 AskUserQuestion 유료로드를 무시하거나, 사용 지침보다는 .-Fired-Toold-Toold-Toold-Toold-Toold-Toold-Toold-Toold-fired-Toold-Toold-Toold-

**왜:** (확장 위치 1)는 모형 AskUserQuestion satisfies 계획 형태의 끝의 회전 필요조건을 말했습니다. 그것은 계획 형태 입장을 고치고, 그러나 NOT 실패의 더 넓은 종류: 모형은 침묵하게 다른 규칙과 조화할 때 STOP-Ask 반복을 위해 배치 합성을 대체합니다. 구조상 시행 없이, STOP-per-issue 컨트랙트를 가진 각 기술은 취약합니다.

**프로 :** 은 클래스의 벌레를 갖는다. STOP 게이트를 선언하는 모든 기술에 적용됩니다. `canUseTool` `test/helpers/agent-sdk-runner.ts`의 원시적을 구축합니다.

**단점 :** 실제 설계 작업. 기술 선언 예상된 질문 수 - frontmatter의 정적 값, 또는 표면 검색에 대한 리뷰 섹션의 수를 기반으로? 감사 인라인 (블록킹, 같은 회전) 또는 포스트 - 호크 (기술 완료 후)? 예상 Vs-actual 임계 값의 교정은 실제 V0 문제 로그 데이터에 따라 달라집니다.

**구성 :** 관련 파일 - `scripts/question-registry.ts` (유효한 질문 카탈로그), `scripts/resolvers/question-tuning.ts` (기본 분류), `bin/gstack-question-log` (유효한 통나무), `bin/gstack-question-preference` (읽은/write 선호), `test/helpers/agent-sdk-runner.ts` (canUseTool 마구). 기존의 질문-로그는 이미 불 사건을 붙잡습니다; 간격은 예상한 조사 및 감사를 선언합니다.

**노력:** L (인간: ~1-2 주/CC+gstack: ~2-3 시간 디자인 doc + 첫번째 통행 실시를 위한 시간). **우선 순위:** P1 만약 대화식 skill 양이 성장하고 있는 경우에; P2 그렇지 않으면. **/에 따라 달라집니다:** 디자인 doc — 그것의 자신의 `docs/designs/STOP_ASK_ENFORCEMENT_V0.md`. ## 콘텍스트 기술

## `/context-save --lane` + `/context-restore --lane` 평행한 일류를 위해

**이름:** 사용자가 저장하고 복원 할 수 있도록 per-workstream (lane) 자주적으로. 저장 : `/context-save --lane A "backend refactor"`는 lane-tag 파일을 작성합니다. 또는 `/context-save lanes`는 가장 최근 계획 파일의 "Parallelization Strategy"섹션을 읽고 차선에 저장된 컨텍스트를 자동 생성합니다. 복원 : `/context-restore --lane A`는 lane의 컨텍스트를로드합니다. 계획이 3 독립적 인 워크스트림과 사용자가 3 개의 지휘자를 선택할 때 유용합니다.

**왜:** 플랜은 `/plan-eng-review` 이미 레인 테이블을 방출 (Lane A : 접촉 `models/` 및 `controllers/` 순차적으로; Lane B : 접촉 `api/` 자주; 등). 지금 no가 재소용 가능한 저장된 상태로 구조로 이동하는 방법. 사용자는 수동으로 각 창에서 범위를 다시 투표합니다. 레인 - 저장/restore는 "hereree"와 "AI"의 "I"계획" 사이에 다리가 될 것입니다.

**프로 :**는 `/plan-eng-review`의 병렬화 출력을 실행 가능한 이력서 상태로 도는. 다 workstream 계획을 위한 지휘자 workspace handoffs의 주위에 상황에 의하여 손실 감소시킵니다.

**단점 :** 그물 새로운 기능 (이전 `/checkpoint` 기술에서 항구 아닙니다). "새로운 지휘자 창" 부분은 지휘자가 스파덴 CLI가 있는지에 연구합니다. 또한 득점 단계 (수동하거나 추출한)에 있는 차체 함 분야를 요구합니다.

**구성 :** 라네 데이터 모델의 소스는 `plan-eng-review/SKILL.md.tmpl:240-249` (Lane A/B/C 의존성 테이블과 충돌 깃발으로 출력되는 "Parallelization Strategy"입니다). v0.18.5.0 이름 PR에서 디퍼링하여 이름이 꽉, 저강삭 수정으로 착륙 할 수 있습니다. 현재 `~/.gstack/projects/$SLUG/checkpoints/YYYYMMDD-HHMMSS-<title>.md`에서 YAML frontmatter (branch, timestamp, etc.)를 사용하여 `lane:`를 저장 한 파일이 모두 `lane:`의 앞광택이 있습니다. `lane:`는 앞광택이 없는 기술에 추가될 것입니다.

**노력:** M (인간: ~1-2 일/CC: ~45-60 분) **우선 순위:** P3 (이렇게 차단하지 않는, 자유로운에 처한) **에 따라:** `/context-save` + `/context-restore` 생산에서 안정되어 있는 이름을 바꾸십시오 (v1.0.1.0+). 연구: 지휘자는 천막 일 공간 CLI를 드러냅니다?

## P0: 브라우저 스킬 단계 2 후속 - `/automate` 기술

**이름:** `/scrape` (단계 2b)의 mutating-flow sibling. `/automate <intent>`는 형태 채우기, click 순서 및 영구 브라우저 skills로 다중 단계 상호 작용을 공동화합니다. 단계 2a의 기술화 기계장치를 재사용하십시오 (`/skillify`는 공유됩니다) 그리고 D3 원자 씁니다 돕기. 추가: mutating-step UNTRUSTED-wrapat-codated 기술 후에 `AskUserQuestion`는 인간적인 확인 기술을 실행할 때 (`AskUserQuestion`). 1단계당 false` - env-scrubbed spawn, 범위화된 토큰 기능, no admin 범위.

**왜:** 읽기 전용 스크랩은 스킬화 패턴 (실험 모드 : 잘못된 데이터 = benign)을 검증하는 더 안전한 쐐기입니다. 작업은 100x 생산성 이득의 다른 절반입니다. "log into example.com → click 설정 → toggle X"는 모든 미래 세션에서 실시간으로 저장합니다. 단계 2a에서 분할하면 생산성 루프를 먼저 발송하고 아키텍처를 검증 한 다음 자신감과 높은 표면을 추가합니다.

**프로 :**는 자체 사용 안전 문제 없이 세련적인 자동화 허가를 자물쇠로 엽니다 — 단계 1's 범위가 톡 모델은 mutating 기술에 동등하게 적용합니다. 공동화된 스크립트는 `$B click`/`$B fill`/`$B type` 외침 실행을 정확하게 enumerates; 다른 것은 가동 시간에 가능합니다. `/skillify`, D3 돕기, 저장 층의 100%를 재사용하십시오. 그들이 운영하는 시간의 앞에 문에 단계 확인.

**단점 :** 의문자에는 더 높은 폭발 반경이 있습니다 (잘못된 선택자는 "Delete Comment" 대신 "Delete Account"를 클릭하십시오. 4 OS 의 FS sandbox는 더 강한 대답입니다; 그 때, 사용자 신뢰 부담은 진짜입니다. 확인 문 UX 요구 관리 - 너무 많은 신속한 및 사용자는 "yes"를 명중합니다. 부채 : 단지 문은 첫째로 뛰습니다; `/skillify`는 기술이 달리는 후에, 기술이 실행되지 않는 후에.

**구성 :** Original Phase 2 plan in `docs/designs/BROWSER_SKILLS_V1.md` bundled `/scrape` + `/automate`. Split during the v1.19.0.0 plan review (`/plan-eng-review` on `garrytan/browserharness`) — the user's source doc framed both as primary, but in practice scraping is where users start because the failure mode is benign. Ship `/scrape` + `/skillify` first (this branch), validate the skillify pattern works, then `/automate` lands on top of the same machinery.

**노력:** M (인간: ~3-5 일/CC: ~1 일) **우선 순위:** P0 (v1.19.0.0 후에 옆 branch) **에 따라:** 단계 2a (`/scrape` + `/skillify`) v1.19.0.0에서 발송되는 D3 원자 씁니다 돕기 (`browse/src/browser-skill-write.ts`) 및 번들 SDK는 본과 같이 재사용됩니다.

---

## P0: PACING_UPDATES_V0 — 루이의 피로 뿌리 원인 (V1.1)

**이름:** PLAN_TUNING_V1에서 추출한 파싱 overhaul 구현. `docs/designs/PACING_UPDATES_V0.md`의 전체 설계. 요구: 세션 상태 모델, `phase` 의 필드에 대한 질문으로 학자, 동적 발견에 대한 레지스트리 확장, 기술 템플릿 제어 흐름으로 포장 (예를 들어), `bin/gstack-flip-decision` 명령, 마이그레이션 조달 예산 규칙, 첫 번째 실행된 preamble 감사, 실제 V0 데이터의 순위 임계값 보정, 하나의 구체적인 검증, 구체적인 데이터의 정의.

**왜:** Louise de Sadeleer's "yes yes yes" during `/autoplan` was pacing + agency, not (only) jargon density. V1 addresses jargon (ELI10 writing). V1.1 addresses the interruption-volume half. Without this, V1 only gets halfway to the HOLY SHIT outcome.

**프로 :** 루이의 피드백에 대한 엔드 투 엔드 응답. V1 사용법에서 실제 교정 데이터를 발송합니다. V0 → V2 파싱 아크를 PLAN_TUNING_V0에서 시작 완료하십시오.

**단점 :** 기질 범위 (10 항목 `docs/designs/PACING_UPDATES_V0.md`). 자신의 CEO + Codex + DX + Eng review 주기가 필요합니다. 교정은 실제 V0 문제 로그 배포에 따라 다릅니다.

**구성 :** PLAN_TUNING_V1 묶음에 시도. 세 eng-review 패스 + 2 Codex는 계획 원본 편집을 통해 편향할 수 없는 10개의 구조적인 간격을 전달합니다. 전용 계획으로 V1.1에 추출하는.

**/에 따라 달라집니다:** V1 배송 (캘리브레이션을 위한 루이의 기본 성적 성적 성적 성적).

## 계획 Tune (v2는 v0.19.0.0 롤백에서 방어)

모든 6 항목은 v1 개 식품 결과에 게이트 및 `docs/designs/PLAN_TUNING_V0.md`의 수용 기준입니다. 그들은 Codex의 외부 청구서 검토가 CEO EXPANSION 계획에서 범위를 롤백을 드리기 후에 명시적으로 적으로 멸종되었습니다. v1는 관측 기판 만 배; v2는 행동 적응을 추가합니다.

### E1 - 기판 배선 (5개의 기술이 단면도를 소모합니다)

**이름:** `{{PROFILE_ADAPTATION:<skill>}}` 위주자 배, 검토, 사무실 시간, 계획 - ceo -review, 계획 - eng -review SKILL.md.tmpl 파일 추가. 구현 `scripts/resolvers/profile-consumer.ts` 당 - skill 적응 레지스트리 (`scripts/profile-adaptations/{skill}.ts`). 각 소비자는 preamble에 `~/.gstack/developer-profile.json`를 읽고 기술 별 기본 (verbosity, 모드 선택, 심각성 문턱, 푸시백 강도)을 적응시킵니다.

**왜:** v1 관측 프로파일은 파일 아무도를 읽습니다. 기판은 실제로 그것을 소비 할 때 실제적으로만 주장합니다. 이없이 /plan-tune는 공상 구성 페이지입니다.

**프로 :** gstack는 개인을 느낍니다. 각 기술은 중간 도로에 과태 대신 사용자의 조타 작풍에 적응시킵니다.

**단점 :** 프로필이 아니면 심리적 편심의 위험. 측정된 프로필 (v1 합격 기준: 90+ 일 3의 기술에 걸쳐 안정)을 요구합니다.

**구성 :** `docs/designs/PLAN_TUNING_V0.md` §Deferred to v2. v1는 신호 지도 + inferred 계산을 발송합니다; 그것은 /plan-tune에서 표시되고 그러나 no 기술은 아직 읽습니다.

**노력:** L (인간: ~1 주/CC: ~4h) **우선 순위:** P0 **에 따라:** **90 + V1 개 식품의 일 3+ 기술 전체에 걸쳐 안정** (`docs/designs/PLAN_TUNING_V0.md` §" v2에 deferred" E1 합격 기준). /plan-tune에서 사용되는 경량 다양성 전시 문 (`sample_size >= 20 AND skills_covered >= 3 AND question_ids_covered >= 8 AND days_span >= 7`)에서 찡그림 열을 렌더링하기 위해 사용됩니다. 디스플레이는 UI 감당, E1에 촉진하는 E1에 대한 촉진은 행동 적응이 일관성과 뒤집기 때문에 훨씬 더 높은 막대가 필요합니다. 이 카드의 이전 버전은 V0와 충돌 한 "2+ 주"를 인용했습니다. V0 승리.

**위험 (Codex 외부 청구서, 단계 A 검토 2026-05-26):** 생성됨 기술 prose는 에이전트 고분고분한 근거입니다. 시험은 템플렛이 `~/.gstack/developer-profile.json`의 적당한 읽을 수 있고, 적당한 결정 점은, 그러나 시험은 실행 시간에 그(것)들을 비둘기 증명할 수 없습니다. E1는 **AskUserQuestion 권고** (" 당신의 단면도를 통해 개정합니다: <choice>") 단단한 런타임 실행 경로가 있을 때까지. NOT 문 E1의 v1에서 단지 인페드 프로파일에 AUTO_DECIDE; 명시된 권한은 AUTO_DECIDE 소스만 남아 있습니다.

### E3 — `/plan-tune narrative` + `/plan-tune vibe`

**이름:** Event-anchored narrative ("You accepted 7 scope expansions, overrode test_의논문_triage 4 times, called every PR 'boil the lake'") + one-word vibe archetype (Cathedral Builder, Ship-It Pragmatist, Deep Craft, etc). scripts/archetypes.ts is ALREADY SHIPPED in v1 (8 archetypes + Polymath fallback). v2 work is the narrative generator + /plan-tune skill wiring.

**왜:** 프로필을 묶고 공유할 수 있습니다. 스크린 샷 가능.

**프로 :** 킬러 기쁨 특징. gstack를 위한 사회적인 표면. 구체적인, 특정한 산출은 실제 사건에서 닻했습니다 (일반적인 AI 사면 아닙니다).

**단점 :** 안정된 인페레드 프로파일을 요구합니다. 캘리브레이션 없이는 일반 단락을 생성합니다. Gen-tests는 no-slop를 검증해야 합니다.

**구성 :** 이미 정의된 Archetypes. 다만 /plan-tune narrative subcommand + slop-check 시험이 필요합니다.

**노력:** S+ (인간: ~1 일/ CC: ~1h) **우선 순위:** P0 **에 따라:** 측정된 단면도 (>= 20의 사건, 3+ 기술, 7+ 일 경간).

### E4 - 블라인드 스팟 코치

**이름:** Preamble Injection은 tier >= 2개의 기술 당 세션 당 사용자의 프로필의 OPPOSITE를 표면으로 처리합니다. Boil-the-ocean 사용자는 범위 ("80% 버전은 무엇입니까?"에 도전합니다; 작은-경우 사용자는 주위에 도전됩니다. `scripts/resolvers/blind-spot-coach.ts`. 세션 dedup에 대한 Marker 파일. `gstack-config set blind_spot_coach false`를 통해 Opt-out.

**왜:** 거울 대신 gstack 코치 (challenges you)를 만듭니다. killer differentiation 대. 설정 메뉴.

**프로 :** 가리처럼 gstack 느낌을 주는 특징. 표면은 사용자가 도전하지 않는 것이 특징입니다.

**단점 :** E1 (TO profile)와 E6 (이 플래그 잡기)와 논리 충돌. 상호 작용 판자 디자인 요구: 글로벌 세션 예산 + 에스컬레이션 규칙 + 잘못 잡아 탐지에서 명시된 배설. 불이 잘못되면 nag와 같은 느낌의 위험.

**구성 :** v2는 E1/E4/E6 구성 문제 Codex 잡힌 문제를 해결하기 위하여 재설계되어야 합니다. 빈도를 측정하는 데 필요한 개식품.

**노력:** M (인간: ~3 일/CC: ~2h 디자인 + ~1h impl) **우선 순위:** P0 **에 따라:** E1 + 상호작용 판자 디자인 spec.

### E5 — LANDED 축하 HTML 페이지

**이름:** PR가 사용자에 의해 승인되면 기본 branch로 새로 합병되어 브라우저에서 애니메이션 HTML 축하 페이지를 엽니다. Confetti + typewriter headline + stats 카운터. 쇼 : 우리가 내장 한 것 (PR 통계 + CHANGELOG 항목), 도로 여행 (경쟁 결정 CEO 계획), 도로 여행 (열매 항목), (참조 항목), (HTML), (CSS (>), (CSS), (> (>), (>) (>) (>) (>) (>) (>) (>) (>))) () ()) () () ()) () () ())) () ())) () () () () () () ()) () ()))))) () () ())) () ())))) () () ()) () () ())))) () ()) () () ())) ()))))) ())))) () () () () () () ())) () () ())) () () ()) () () () () () () () () () () () (

**CRITICAL REVISION v0 계획에서:** 수동 탐지는 전방 (Codex #9)에서 NOT 살아있는이어야 합니다. 승진될 때, `/plan-tune show-landed` OR 포스트 선 걸이를 명시하기 위하여 이동하십시오 - 뜨거운 경로에 있는 수동 탐지 아닙니다.

**왜:** 은밀한 성격 순간. "당신이 이것을 건설한 이유를 기억하는 한 단어 일"

**프로 :** 스크린 샷 가치. 공유. 도파민의 종류는 전도자들에 전원 사용자를 전환.

**단점 :** 기판이 고체가 아닌 경우 제품 극장. /design-shotgun → /design-html가 시각 방향에 따라 필요합니다. E2는 narrative/vibe 자료에 대한 통합 프로파일을 요구합니다.

**구성 :** /land-and-deploy trust/adoption는 낮습니다, 그래서 수동 탐지는 적당한 방아쇠 모양입니다. `~/.gstack/.landed-celebrated-*`에 있는 PR 당 Dedup 감적. squash/merge-commit/rebase/co-author/fresh-clone/dedup 변종을 위한 E2E 시험.

**노력:** M+ (인간: ~1 주/CC: ~3h 합계) **우선 순위:** P0 **에 따라:** E3 발송되는 달리/vibe. /design-shotgun는 실제 PR 자료에 시각 방향을, 그 후에 /design-html를 완성하기 위하여 달립니다.

## E6 - 선언된 ↔ 불임의 자동 조정

**이름:** 현재 `/plan-tune`는 선언된과 인페레드 사이의 간격을 보여줍니다 (v1 관측). v2 자동 조끼 선언 업데이트가 간격이 임계값을 초과 할 때 ("당신의 프로필은 손을 떨어져 그러나 추천의 40 %를 지나치게했습니다 - 당신은 실제로 맛 중심입니다. 업데이트는 0.8에서 0.5까지 자율성을 선언합니까?"). 어떤 뮤테이션 (Codex 신뢰 반행 #15 이미 구운 v1로 명시된 사용자 확인을 요구합니다.

**왜:** 단면도는 개정 없이 조용히 드리웁니다. 각자 정확한 단면도는 정직하게 체재합니다.

**프로 :** 프로필은 시간이 더 정확합니다. 사용자는 간격을보고 결정합니다.

**단점 :** 안정된 인페리레드 프로파일(diversity check)를 요구합니다. False 긍정적 인 것은 사용자를 나눕니다.

**구성 :** v1에는 `--check-mismatch`가 플래그 > 0.3 간격이 있지만 수정을 제안하지 않습니다. v2는 실제 데이터에서 제안 UX + per-dimension 임계 값을 추가합니다.

**노력:** S (human: ~1 일/CC: ~45min) **우선 순위:** P0 **에 따라:** 측정된 단면도 + v1 개식품에서 진짜 mismatch 자료.

## E7 - 심리학 자동 변형

**이름:** 인퍼링 프로파일이 AND를 측정할 때, 이 질문은 두 방향 AND의 사용자 차원 강하게 호의한 선택권, 자동 조폐 (접근 가능한 annotation: "프로필을 통해 자동 발산. /plan-tune로 변화하십시오."). v1는 EXPLICIT per-question preferences를 통해 자동 변형; v2는 단면도 몬 자동 이형을 추가합니다.

**왜:** 심리학의 전체적인 점. 침묵하고, 사용자 IS를 기반으로 한 기본을 수정하는 것은, 그들이 말하는 것 아닙니다.

**프로 :** 캘리브레이션 파워 사용자를 위한 프리션 프리 스킬 인발. 시간이 지남에, gstack는 당신의 마음을 읽는 것 같이 느낍니다.

**단점 :** 가장 높은 강약 방어. 잘못된 자동 변형은 비용이 많이 들지 않습니다. 신호 지도 AND 구경측정 문에 있는 아주 높은 신뢰를 요구합니다.

**구성 :** v1 다양성 문은 `sample_size >= 20 AND skills_covered >= 3 AND question_ids_covered >= 8 AND days_span >= 7`입니다. v2는 이 문이 실제로 발송하기 전에 noisy 단면도를 붙잡는 것을 증명해야 합니다.

**노력:** M (인간: ~3 일/CC: ~2h) **우선 순위:** P0 **에 따라:** E1 (skill consuming profile) + 구경측정 문이 믿을 수 있는 보여주는 진짜 관찰된 자료.

## 블로우

### Scope sidebar-agent는 세션 PID, `pkill -f sidebar-agent\.ts`에 죽이고

**이름:** `shutdown()` `browse/src/server.ts:1193`는 `pkill -f sidebar-agent\.ts`를 사용하여 sidebar-agent daemon를 죽이기 위하여, 다만 1개의 이 서버가 spawned 기계에 각 sidebar 에이전트 일치를 일치하. `cli.ts`가 `shutdown()`에 있는 `process.kill(pid, 'SIGTERM')`로 대체하십시오.

**왜:** 사용자는 두 개의 지휘자 worktrees (또는 모든 다소 설정)를 실행, 자신의 `$B connect`, 한 브라우저 창을 닫습니다 ... 다른 worktree의 sidebar-agent는 너무 죽었습니다. 폭발 반경이 이전이 있었지만, v0.18.1.0 단면 수정이 더 많은 도달 할 수 있습니다. 모든 사용자 폐쇄는 이제 전체 `shutdown()` 경로가 실행되며, 사용자가 닫히는 전에 우회전합니다.

**구성 :** Surfaced by /ship's adversarial review on v0.18.1.0. Pre-existing code, not introduced by the fix. Fix requires propagating the sidebar-agent PID from `cli.ts` spawn site (~line 885) into the server's state file so `shutdown()` can target just this session's agent. Related: `browse/src/cli.ts` spawns with `Bun.spawn(...).unref()` and already captures `agentProc.pid`.

**노력:** S (인간: ~2h/CC: ~15min) **우선 순위:** P2 **에 따라:** None

## 사이드바 보안

### ML 프롬프트 주입 분류기 — v1 SHIPPED (branch garrytan/prompt-injection-guard)

**상태:** IN PROGRESS branch `garrytan/prompt-injection-guard`. Classifier swap: **TestSavantAI의 장점**는 개발자 내용에 대하여 DeBERTa (더 나은 - HN/Reddit/Wikipedia/tech 블로그 모든 점수 SAFE 0.98+, 공격 점수 INJECTION 0.99+)를 대체합니다. 간단히 말하면 3 (벤드 코푸 건조 런)이 피벗을 강제로 합니다. `~/.gstack/projects/garrytan-gstack/ceo-plans/2026-04-19-prompt-injection-guard.md`

**v1에서 배송되는 것 :**
- `browse/src/security.ts` - 대포 주입 + 체크, verdict 결합자 (ensemble 규칙),
  회전, 크로스 프로세스 세션 상태, 상태 보고와 공격 로그
- `browse/src/security-classifier.ts` - TestSavantAI ONNX 클래스터 + 하이쿠 성적표
  classifier (거주고 맹세), 우아한 degradation 모두
- 수류는 끝에서 흘립니다: server.ts 주사, sidebar-agent.ts는 각 상행을 검사합니다
  수로 (텍스트, 도구 args, URL, 파일 쓰기) 및 누출 세션을 죽이
- Pre-spawn ML ensemble 규칙을 가진 사용자 메시지 스캔 (BLOCK는 모두 classifiers를 요구합니다)
- `/health` 엔드포인트는 방패 아이콘을 위한 보안 상태를 노출합니다.
- 25 단위 시험 + 12 회귀 시험 모든 통과

**지점 2 건축 (이전 게이트에서 파생 1) :** ML classifier ONLY는 `sidebar-agent.ts` (non-compiled bun script)에서 실행합니다. 컴파일된 검색 바이너리는 onnxruntime-node를 연결할 수 없습니다. 건축 제어 (XML framing + allowlist)는 컴파일된 측 진입을 방어합니다.

## ML Prompt 주입 분류기 — v2는 위로를 따릅니다

#### ~~Cut Haiku 긍정 비율은 44%에서 ~15% (P0)~~ — v1.5.2.0에서 SHIPPED로 옵니다

측정 결과 (500-case BrowseSafe-Bench 연기) : 검출 67.3% → **56.2%**, FP 44.1% → **22.9%**. 게이트 패스 (검출 ≥ 55%, FP ≤ 25%). 착륙 한 손잡이 : 라벨-최초 앙상블 투표 (문자 라벨 trumps 숫자 신뢰를 원시 레이어), 홀로그램 가드 (`verdict=block` conf < 0.40 → warn-vote), 새로운 `THRESHOLDS.SOLO_CONTENT_BLOCK = 0.92` 라벨이 없는 콘텐츠 클래스터, 도구 출력 경로, 더 단단한 Haiku 신속한 + 8 몇몇 샷 exemplars, 핀 Haiku 모델, `claude -p`에서 스파드 `os.tmpdir()` 등 45/4번 게이트에서 클럭을 넣을 수 있습니다. `browse/test/security-bench-ensemble.test.ts` 재생 정착물, 누락된 정착물 + 안전 층 디프에 실패했습니다. 본래 계획의 정지 손실 뒤틀림 순서는 FP 바늘 (FPs는 단 하나 층 BLOCK 경로에서, ensemble 아닙니다 옵니다); 진짜 레버는 건축 (상표 첫번째) 및 새로운 분리한 문턱일 수 있었습니다 밖으로 돌았습니다.

CHANGELOG.md [1.5.2.0]를 전체 배송 요약에 대해 참조하십시오.

#### Original spec (전선, 아카이브에 유지)

**이름:** v1는 모든 도구 산출 (Read/Grep/Bash/Glob/WebFetch). BrowseSafe-Bench 연기 측정된 탐지 67.3% + FP 44.1% — L4-only에서 4.4x 탐지 상승, 그러나 Haiku가 가장자리 케이스 (그림 작풍 benign 내용, 국경 사회 공학)에 L4 보다는 더 공격하기 때문에 FP 세겹으로 FPs 회복할 수 있는 그러나, FPs는 44%를 위해 너무 즐겁습니다.

**왜:** 사용자는 검토 배너를 대략 각 다른 도구 산출 = 진짜 UX 마찰을 클릭합니다. 이 4개의 손잡이를 함께 조정하는 것은 60-70% 범위에 있는 탐지를 지키기 동안 FP에 ~15-20% 삭감해야 합니다:

1. **Haiku의 `verdict` 필드에 계산하는 ensemble를 `confidence`.** 지금 `combineVerdict`는 Haiku warn-at-0.6을 BLOCK 투표로 대우합니다. Haiku는 `verdict: "block"`를 명확하 커트 케이스를 위해 예비하고 `"warn"`를 해방합니다. BLOCK 투표로 `verdict === "block"`만 조사하십시오; `warn`는 2의 N 앙금에 참여하는 연약한 신호가 그러나 단 하나 잡히지 않습니다 BLOCK.
2. **Haiku의 급증기 프롬프트를 꽉 얹습니다.** 현재 프롬프트는 일반적입니다. "문자가 명시된 명령을 포함하면 "Return `block`만, 역할 재설정, exfil 요청, 악성 코드 실행을 포함합니다. `warn`를 반환하면 소셜 엔지니어링을 위해 에이전트를 납치하지 않습니다. `safe`를 반환하십시오. 다른 "더 구체적인 지침 → 몇몇 false 플래그.
3. **Haiku의 신속한 6-8의 몇 샷 exemplars를 추가하십시오.** 쌍의 (주사 텍스트 → 구획) 및 (위험하 안전 →). LLM 몇몇 탄은 분류에 영발을 일관되게 합니다.
4. **덩어리 Haiku의 WARN 임계값에서 0.6에서 0.75로.** 국경 화재가 ensemble 풀에서 떨어지게됩니다.

함께 4 개를 발송, 재 실행 BrowseSafe-Bench 연기, 전에 기록/after. 대상 : 60-70% 탐지 / 15-25% FP.

**노력:** S (인간: ~1 일/CC: ~30-45 분 + ~45min 벤치) **우선 순위:** P0 (직접 UX 충격 포스트 선박; 배 v1 as-is 검토 기치, 즉시 후속으로 이 파일을) **에 따라:** v1.4.0.0 신속한 주사 가드 branch 합병

#### Cache 검토 결정 (도메인, 페이로드 - 해시 - 프레픽) (P1)

**이름:** Haiku 화재가 동일한 세션에서 두 번씩 페이지에 불면 (예 : 사용자는 Bash를 사용하며 동일한 의심 파일에 Grep를) 두 번째 화재가 재발하지 않아야합니다. 사용자가 정해진 세션에 의해 키워하는 사용자의 결정 (도메인, payloadHash-prefix) 쌍. 작은 LRU, ~100 항목, 세션 - 촬영 (사이드바에서 지속되지 않음) 새로운 세션을 원합니다.

**왜:**는 다른 도구를 통해 sketchy 내용의 동일한 비트가 검사한 다수 시간을 얻을 때 검토 배너 피로를 감소시킵니다. v1에 44% FP에서, 이 문제 대부분.

**노력:** S (인간: ~0.5 일/CC: ~20 분) **우선 순위:** P1

#### BrowseSafe-Bench + Qualifire + xxz224 (P2 연구)에 작은 분류기를 미세 조정하십시오.

**이름:** TestSavantAI는 브라우저 에이전트 공격에 대한 직접 주입 텍스트, 잘못된 배포에 훈련되었습니다 (측정 된 15 % 회). BrowseSafe-Bench (3,680 케이스) + Qualifire 신속한 주입 - 벤치 마크 (5k) + xxz224 (3.7k) 결합 된, 배 ~/.gstack/models / 교체 L4 클래스터로 배.

**왜:** 예상된 15% → 70%+ 하이쿠가 필요없는 실제 위협 배급에 회귀. 또한 대기 시간 (no CLI 이하 처리)를 삭감하고 Haiku 비용을 떨어뜨릴 것입니다.

**노력:** XL (인간: ~3-5 일 + ~$50 GPU/ CC: ~4-6 시간 설정 + ~$50 GPU) **우선 순위:** P2 연구 - TestSavant를 대체하기 전에 열린 밖으로 시험 세트에 상승을 검증하십시오

#### DeBERTa-v3 ensemble 으로 default (P2)

**이름:** 플립 `GSTACK_SECURITY_ENSEMBLE=deberta` 의 선택에서 기본으로. 3번째 ML 투표를 추가합니다; 2-of-3 계약 규칙은 FP를 감소시키고 공격을 공격하는 동안 DeBERTa가 볼 수 있습니다.

**왜:** 더 많은 투표 = 더 나은 구경측정. 현재 721MB가 큰 첫 번째 실행 다운로드이기 때문에 선택했습니다; default로 묶는 것은 게으른 다운로드 UX를 요구합니다.

**단점 :** 721MB는 모든 사용자를 위한 첫번째 런 다운로드를 실행합니다. 사용자 대역폭 + 디스크를 요합니다.

**노력:** M (인간: ~2 일 / CC: ~1 시간 + UX) **우선 순위:** P2 (#1 튜닝 후 방이 얼마나 남아 있는지)

#### 사용자 Feedback flywheel — 의사 결정은 훈련 데이터 (P3)

**이름:** 각 허용/Block click는 자료로 레테르를 붙입니다. 로그인 (suspected_text hash, 층 점수, 사용자 결정, ts)에 ~/.gstack/security/feedback.jsonl. `telemetry: community`가 커뮤니티 맥박을 통해 골로 구분합니다. 기간별 상수도는 응대 피드백에 달려 있습니다.

**왜:** 시스템은 더 나은 사용. 사용자 현실과 방어 품질 사이의 루프를 닫습니다.

**단점 :** 피드백 루프는 공격자가 충분한 장치를 통제하는 경우에 독될 수 있습니다. 경비 (지정된 표본 추출, 검토자 검증, 훈련 배치에 k-anon 최소한)를 필요로 합니다.

**노력:** L (인간: ~1 주 현지 로깅 + 집계관, 재기차 cron/ CC를 위한 또 다른 주: ~2-4 분 이하 당) **우선 순위:** P3 — v2 튜닝 후에 건축이 맞은 모양인 것을 증명하는 단지

#### ~~Shield 아이콘 + 캐러리 누출 배너 UI (P0)~ — SHIPPED

배너는 a9f702a7 (HTML+CSS, 조업 변형) + ffb064af (JS 배선 + security_event routing + a11y + Escape-to-dismiss)을 투입했습니다. 방패 아이콘은 3 주 (protected/degraded/inactive), custom SVG + mono SEC 디자인 검토 당 상표를 가진 59e0635e에서 착륙했습니다.

log as follow-up: connect에서만 업데이트할 수 있는 보안 기능 — 위의 "Shield icon Continuous polling"을 참조하세요.

#### ~~Shield 아이콘 연속 파싱 (P2)~~ — SHIPPED

Commit 06002a82: `/sidebar-chat` 응답은 이제 `security: getSecurityStatus()`, sidepanel.js 호출 `updateSecurityShield(data.security)`를 각 poll tick에 포함합니다. 방패는 classifier warmup가 완료한 대로 'protected'로 묶습니다 (첫째로에 연결한 후에 전형적으로 ~30s), no 다시 로드가 필요했습니다.

#### ~~Gstack-telemetry-log를 통해 ttack telemetry (P1)~~ — SHIPPED

28ce883c (binary) + f68fa4a9 (security.ts 배선)에 착륙했습니다. 이차적 바이너리는 이제 `--event-type attack_attempt --url-domain --payload-hash --confidence --layer --verdict`를 받아들입니다. `logAttempt()`는 이진 불 및 용제를 향합니다. tier gating는 사건을 나릅니다.

다운스트림 후속은 여전히 열려 있습니다. `community-pulse` Supabase 가장자리 함수를 업데이트하여 새 이벤트 유형과 저장을 입력 `security_attempts` 테이블에 저장합니다. 대시보드 읽기 경로는 별도의 TODO ("Cross-user grege attack 대시보드")입니다.

#### 문 층 (P2)에 가득 차있는 BrowseSafe 벤치

**이름:** 연기 연기 연기 - 200 (게이트)에서 풀 - 3680 (게이트)에 `browse/test/security-bench.test.ts` 연기는 측정됩니다 (~2 주 포스트 선).

**왜:** BrowseSafe-Bench는 Perplexity의 3,680 케이스 브라우저 에이전트 주입 벤치 마크입니다. 연기 - 200는 표본입니다; 가득 차있는 적용은 긴 꼬리를 붙잡습니다. 시간을 ~5min 신비하십시오.

**노력:** S (CC: ~45min) **우선 순위:** P2 **에 따라:** v1는 + ~2 주 진짜 자료 발송했습니다

#### ~~Cross-user grege 공격 대시보드 (P2)~~ — CLI SHIPPED, 웹 UI는 남아 있습니다

CLI 대시보드는 커밋 a5588ec0 (schema migration) + 2d107978 (community-pulse edge function security gregion) + 756875a7 (bin/gstack- security-dashboard)에서 발송했습니다. 사용자는 이제 `gstack-security-dashboard`를 실행하여 공격을 지속 7 일, 상위 공격 도메인, 탐지 층 분포 및 베라딕 수를 볼 수 있습니다. Supabase 커뮤니티 펄스 파이프에서 모든 골동품.

gstack.gg/dashboard/security에서 웹 UI는 여전히 열려있습니다 — 이 repo의 범위 밖에 분리된 webapp 프로젝트입니다.

#### TestSavantAI ensemble → DeBERTa-v3 ensemble (P2) - SHIPPED (opt-in)

Commits b4e49d08 + 8e9ec52d + 4e051603 + 7a815fa7: DeBERTa-v3-base-injection-onnx is now wired as an opt-in L4c ensemble classifier. Enable via `GSTACK_SECURITY_ENSEMBLE=deberta` — sidebar-agent warmup downloads the 721MB model to ~/.gstack/models/deberta-v3-injection/ on first run. combineVerdict becomes a 2-of-3 agreement rule (testsavant + deberta + transcript) when enabled. Default behavior unchanged (2-of-2 testsavant + transcript).

#### ~~TestSavantAI + DeBERTa-v3 ensemble~~ — SHIPPED 옵트인 (위 항목 참조)

#### ~~Read/Glob/Grep 도구 산출 주입 적용 (P2) ~~ — SHIPPED

Commits f2e80dd7 + 0098d574: sidebar-agent.ts now scans tool outputs from Read, Glob, Grep, WebFetch, and Bash via `SCANNED_TOOLS` set. Content >= 32 chars runs through the ML ensemble; BLOCK verdict kills the session and emits security_event. The content-security.ts envelope path was already wrapping browse-command output; this extension closes the non-browse path Codex flagged.

v1.4.0.0의 /ship 이 경로에는 추가 경화 (commit 407c36b4 + 88b12c2b + c51ebdf4)가 있습니다. 이 경로는 도구 출력 텍스트 (이전의 빈으로)를 수신하고, 결합Verdict는 `toolOutput: true` BLOCK 임계 값 (사용자 입력 default SO FP FP)에서 단일 ML 분류기를 차단하는 `toolOutput: true`를 허용합니다.

#### ~~Adversarial + 통합 + 연기 벤치 테스트 스위트 (P1) ~ ~ — SHIPPED

4개의 시험 파일이 둥근 발송했습니다:
  * `browse/test/security-adversarial.test.ts` (94a83c50) - 23개의 운하 수로
    + verdict-combiner 공격 모양 테스트
  * `browse/test/security-integration.test.ts` (07745e04) — 10개의 층 coexistence
    + 방어적인 회귀 감시
  * `browse/test/security-live-playwright.test.ts` (b9677519) — 7 라이브 크롬
    정착물 시험 (5개의 deterministic + 2 ML는, 모형 캐시가 absent를 움직인 경우에 건너 뛰었습니다)
  * `browse/test/security-bench.test.ts` (afc6661f) - BrowseSafe-Bench 200 케이스
    신비한 dataset 캐시 + v1 기본 메트릭과 연기 하네스

#### Bun-native 5ms inference (P3 연구) — SKELETON SHIPPED, 앞으로 통행은 엽니다

연구 골격은이 라운드를 착륙 (browse/src/security-bunnative.ts, docs/designs/BUN_NATIVE_INFERENCE.md, browse/test/security-bunnative.test.ts):

  * Pure-TS WordPiece Tokenizer — HF tokenizer.json를 직접 읽어, 일치
    transformers.js 고정 문자열에 출력 (CI에서 정확한 테스트)
  * 안정 `classify()` API 현재 외침은 오늘에 대하여 철사 할 수 있습니다
  * 벤치 마크 하네스 p50/p95/p99 보고 — 앵커 v1 WASM 기본
    for future regressions

디자인 doc는 로드맵을 캡처합니다.
  * 접근 A: 순수한TS + Float32Array SIMD - 밖으로 통치하십시오 (WASM를 이길 수 없습니다)
  * 접근 B: Bun FFI + Apple 가속 cblas_sgemm - 표적 ~3-6ms p50,
    macOS 전용, ~1000 LOC
  * 접근 C: Bun WebGPU — 탐험, 스파이크의 가치

작동을 재개 (XL, 다중 주):
  * FFI cblas_sgemm를 위한 증거의 동의
  * 단일 변압기 층 구현 + 정정 체크 대 onnxruntime
  * 전진 통행 + 무게 장전기 + 정정 회귀 정착물
  * security-bunnative.ts `classify()` 몸에 있는 생산 교체

## 빌더 Ethos

### 건물 소개 전에 처음 검색

**이름:** `generateSearchIntro()` 함수를 추가합니다. (`generateLakeIntro()`와 같이), 블로그 에세이에 링크와 함께 첫 번째 사용의 원칙을 구축하기 전에 검색을 소개합니다.

**왜:** 호수에는 에세이와 표 `.completeness-intro-seen`에 대한 링크가 소개되는 인트로 흐름이 있습니다. 건물 전에 검색은 발견 가능성을 위해 동일한 패턴을해야합니다.

**구성 :** 블로그 게시물에 링크를 차단했습니다. 에세이가 존재하는 경우 `.search-intro-seen` 마커 파일과 인트로 플로우를 추가합니다. 패턴 : `generateLakeIntro()` gen-skill-docs.ts:176.

**노력:** S **우선 순위:** P2 **에 따라:** 건물 전에 검색에 대한 블로그 게시물

## Chrome DevTools MCP 통합

## Real Chrome 세션 액세스

**이름:** Chrome DevTools MCP를 통합하여 실제 쿠키, 실제 상태, no Playwright 중간에 사용자의 실제 Chrome 세션에 연결하십시오.

**왜:** 지금, headed 모드는 신선한 Chromium 단면도를 발사합니다. 사용자는 수동으로 또는 수입품 과자에서 기록해야 합니다. Chrome DevTools MCP는 사용자의 실제 Chrome에 연결하고, 각 정정한 위치에 즉시 접근합니다. 이것은 AI 에이전트을 위한 브라우저 자동화의 미래입니다.

**구성 :** Google은 Chrome DevTools MCP in Chrome 146+ (6월 2025)에 Chrome . 스크린 샷, 콘솔 메시지, 성능 추적, 라이트하우스 감사 및 사용자의 실제 브라우저를 통해 전체 페이지 상호 작용을 제공합니다. gstack는 Playwright를 headless CI/testing 워크플로를 위해 실제 접속에 사용해야 합니다.

잠재적 인 새로운 기술:
- `/debug-browser`: JS 소스 맵핑된 더미 추적으로 tracing
- `/perf-debug`: 성능 추적, 핵심 웹 비틀, 네트워크 폭포

`/setup-browser-cookies`를 사용자의 실제 쿠키가 이미 있기 때문에 대부분의 사용 사례를 대체할 수 있습니다.

**노력:** L (인간: ~2 주/CC: ~2 시간) **우선 순위:** P0 **에 따라:** Chrome 146+, DevTools MCP 서버 설치

## 블로우

### 번들 server.ts 컴파일된 바이너리

**이름:** `resolveServerScript()` fallback chain을 완전히 제거 - 번들 server.ts를 컴파일된 검색 바이너리로 묶습니다.

**왜:** 현재 fallback chain (cli.ts에 접한 체크, 글로벌 설치 체크)는 v0.3.2에 있는 fragile 그리고 기인한 버그입니다. 단 하나에 의하여 컴파일된 바이너리는 더 간단하고 믿을 수 있습니다.

**구성 :** Bun의 `--compile` 플래그는 여러 항목 지점을 묶을 수 있습니다. 서버는 현재 파일 경로 조회를 통해 실행 시간에 해결됩니다. 그것을 묶는 것은 해결책 단계 완전히 제거합니다.

**노력:** M **우선 순위:** P2 **에 따라:** None

## 세션 (실행된 브라우저 인스턴스)

**이름:** 분리된 cookies/storage/history,를 가진 브라우저 인스턴스를 이름을 지정합니다.

**왜:** 다른 사용자 역할의 평행한 테스트, A/B 시험 검증 및 청결한 auth 국가 관리.

**구성 :** Playwright 브라우저 컨텍스트가 필요합니다. 각 세션은 독립적 인 쿠키/localStorage로 자신의 컨텍스트를 가져옵니다. 비디오 레코딩 (클립 컨텍스트 라이프 사이클) 및 auth vault에 대한 필수 조건.

**노력:** L **우선 순위:** P3

## 비디오 녹화

**이름:** 비디오로 기록 브라우저 상호 작용 (start/stop 제어).

**왜:** QA 보고서 및 PR체에 있는 영상 증거. 현재 `recreateContext()`가 페이지 상태를 파괴하기 때문에 끊어지는.

**구성 :**는 깨끗한 컨텍스트 라이프사이클에 대한 세션이 필요합니다. Playwright는 컨텍스트당 비디오 레코딩을 지원합니다. 또한 WebM → GIF 변환이 필요하며 PR 임베딩을 위해 PR 변환이 필요합니다.

**노력:** M **우선 순위:** P3 **에 따라:** 세션

## v20 암호화 형식 지원

**이름:** AES-256-GCM 미래 Chromium cookie DB 버전 (현재 v10)를 위한 지원.

**왜:** 미래 Chromium 버전은 암호화 형식을 변경할 수 있습니다. Proactive 지원은 파손을 방지합니다.

**노력:** S **우선 순위:** P3

### 국가 지속 — SHIPPED

~~**이름:** Save/load 쿠키 + 로컬저장 JSON 파일에 대한 재현성 테스트 세션.~~

`$B state save/load` v0.12.1.0에서 배. V1는 쿠키 + URL을 저장합니다 (부속에 틈이 아닙니다, 로드-베포-나비게이트). 파일 `.gstack/browse-states/{name}.json` 0o600 권한을 가진. 로드는 세션을 대체합니다 (첫 페이지 모두 닫습니다). 이름 `[a-zA-Z0-9_-]`에 질화.

**공급 능력:** V2 로컬저장 지원 (전사사 주입 전략). **완료:** v0.12.1.0 (2026-03-26)

### Auth vault의 확장 파일

**이름:** 암호화된 자격 저장, 이름에 의해 참조. LLM 암호를 결코 볼 수 없습니다.

**왜:** Security — 현재 auth credentials는 LLM context를 통해 흐릅니다. Vault는 AI의 전망에서 비밀을 유지합니다.

**노력:** L **우선 순위:** P3 **에 따라:** 세션, 주 지속

### Iframe 지원 - SHIPPED

~~**이름:** `frame <sel>` 및 `frame main` 교차 프레임 상호 작용을 위한 명령.~~

`$B frame` v0.12.1.0의 배. 지원 CSS selector, @ref, `--name`, `--url` 본 일치. 모든 read/write/snapshot 명령에 걸쳐 대상 요약 (`getActiveFrameOrPage()`) 실행. 프레임은 항법, 탭 스위치, 이력서에 명확하게. Detached 구조 자동 회복. 페이지 전용 작업 (goto, 스크린 샷, 뷰 포트) 프레임에서 명확한 오류를 던집니다.

**완료:** v0.12.1.0 (2026-03-26)

### Semantic 위치

**이름:** `find role/label/text/placeholder/testid` 부착된 동작.

**왜:** CSS selectors 또는 ref 숫자보다 더 탄력적인 요소 선택.

**노력:** M **우선 순위:** P4

## 장치 에뮬레이션 presets

**이름:** `set device "iPhone 16 Pro"` for mobile/tablet 테스트를 합니다.

**왜:** 수동 viewport resizing 없이 응답 레이아웃 테스트.

**노력:** S **우선 순위:** P4

## 네트워크 조이닝/routing

**이름:** 인터셉트, 블록, 그리고 모의 네트워크 요청.

**왜:** 테스트 오류 상태, 로드 상태, 오프라인 동작.

**노력:** M **우선 순위:** P4

### 다운로드 처리

**이름:** 경로 제어를 클릭-to-download.

**왜:** 파일 다운로드는 종료합니다.

**노력:** S **우선 순위:** P4

### 내용 안전

**이름:** `--max-output` truncation, `--allowed-domains` 필터링.

**왜:**는 문맥 창 과잉 량을 방지하고 안전한 도메인에 항법을 제한합니다.

**노력:** S **우선 순위:** P4

## 스트리밍 (WebSocket 라이브 미리보기)

**이름:** WebSocket 기반 라이브 미리보기 쌍 검색 세션.

**왜:** 실시간 협업 가능 — 인간의 시계 AI 검색.

**노력:** L **우선 순위:** P4

## Headed 모드 Chrome 확장 - SHIPPED

`$B connect`는 gstack Chrome 확장 자동 로드를 가진 headed 형태에 Chromium의 번들된 Chromium를 발사합니다. `$B handoff`는 지금 동일한 결과를 일으킵니다 (확장 + 측 패널). `--chat` 깃발 뒤에 측바 대화 문질.

### `$B watch` — SHIPPED

Claude는 주기적인 스냅샷을 가진 수동 read-only 형태에 있는 사용자 브라우징을 관찰합니다. `$B watch stop`는 요약으로 출구를 둡니다. 돌연변이 명령은 시계 도중 막았습니다.

### 사이드바 scout / 파일 드롭 릴레이 - SHIPPED

Sidebar 에이전트는 `.context/sidebar-inbox/`에 구조화된 메시지를 씁니다. Workspace 에이전트는 `$B inbox`를 통해 읽습니다. 메시지 형식: `{type, timestamp, page, userMessage, sidebarSessionId}`.

### 멀티 에이전트 탭 고립

**이름:** 두 Claude 세션은 같은 브라우저에 연결되며, 각 탭에서 동작합니다. No 교차 오염.

**왜:** 같은 브라우저의 다른 탭에서 평행 /qa + /design-review을 활성화합니다.

**구성 :** concurrent headed 연결을 위한 탭 소유권 모델을 요구합니다. Playwright는 두개의 지속 가능한 컨텍스트를 청소하지 않을지도 모릅니다. 조사가 필요하십시오.

**노력:** L (인간: ~2 주/CC: ~2 시간) **우선 순위:** P3 **에 따라:** Headed 형태 (돌아 낸)

### Sidebar 에이전트는 도구 + 더 나은 오류 가시성 - SHIPPED를 작성해야 합니다.

**이름:** 사이드바 에이전트와 두 가지 문제 (`sidebar-agent.ts`): (1) `--allowedTools`는 `Bash,Read,Glob,Grep`, 누락된 `Write`에 하드 코딩됩니다. Claude는 요청할 때 파일 (예: CSV)를 만들 수 없습니다. (2) Claude 오류 또는 빈번하게 반환하면, sidebar UI는 아무것도 보여줍니다, 녹색 점을 보여줍니다. No 오류 메시지, no "나는 시도하지만 실패하지 않았다.

**완료:** v0.15.4.0 (2026-04-04). 허용되는Tool에 추가된 도구를 쓰기. 40+ 빈 캐치 블록은 `[gstack sidebar]`, `[gstack bg]`, `[browse]`, `[sidebar-agent]` 모든 4 파일 (sidepanel.js, background.js, server.ts, sidebar-agent.ts)에 대체됩니다. 오류 위주 텍스트는 이제 빨간색으로 보여줍니다. Auth token stale-reesh 버그 수정.

### Sidebar 직접 API 호출 (claude -p 시작 세금 제거)

**이름:** 각 사이드바 메시지는 신선한 `claude -p` 과정 (~2-3s 찬 시작 머리 위)를 향합니다. “click @e24”를 위해 그 absurd. 직접 Anthropic API는 이하 두번째일 것입니다.

**왜:** `claude -p` 시작 비용: 가공 스파일 (~100ms) + CLI init (~500ms-1s) + API 연결 (~200ms) + 첫 번째 토큰. 모델 라우팅 (작업용)은 도움이되지만 CLI 오버헤드를 수정하지 않습니다.

**구성 :** `server.ts:spawnClaude()`는 args를 건설하고 큐 파일에 쓰기. `sidebar-agent.ts:askClaude()`는 `claude -p`를 스파게 썹니다. 도구 사용과 직접 `fetch('https://api.anthropic.com/...')`로 대체하십시오. 검색 서버에 접근할 `ANTHROPIC_API_KEY`를 요구합니다.

**노력:** M (인간: ~1 주/CC: ~30min) **우선 순위:** P2 **에 따라:** None

### Chrome 웹 스토어 출판

**이름:** gstack Chrome 확장을 Chrome 웹 스토어에 쉽게 설치합니다.

**왜:** 현재 크롬을 통해 sideloaded://extensions. 웹 스토어는 클릭을 설치합니다.

**노력:** S **우선 순위:** P4 **에 따라:** Chrome 확장은 sideloading를 통해 가치를 넓히기

## Linux cookie 해독 — PARTIALLY SHIPPED

~~**이름:** GNOME 열쇠 고리/kwallet/ DPAPI 비 macOS cookie 수입품을 위한 지원.~~

Linux cookie 수입은 v0.11.11.0 (위로 3)에서 발송했습니다. Chrome, Chromium, Brave, Linux에 가장자리를 GNOME 열쇠 고리 (libsecret) 및 “peanuts” 가을백 지원합니다. Windows DPAPI 지원은 deferred 남아 있습니다.

**공급 능력:** Windows cookie 해독 (DPAPI). 완전한 재쓰기가 필요 합니다 — PR #64는 1346의 선 및 stale이었습니다.

**노력:** L (Windows 전용) **우선 순위:** P4 **완료 (Linux):** v0.11.11.0 (2026-03-23)

## 배

### 전경 파견의 실행 시간 시행 (PreToolUse 걸이)

**이름:** PreToolUse Hook (settings.json)는 gstack 작업 흐름 안쪽에 만들어진 에이전트 도구 호출에 `run_in_background: false`를 강제하거나 #497/#2440 버그 클래스 구조적으로 prose-pinned 대신 Claude Code에서 불가능하게 합니다.

**왜:** v1.79.0.0 prose+test layer에서 클래스를 고정 (모든 동기 파견 사이트는 플래그를 운반, `test/run-in-background-guidance.test.ts`)에 의해 핀으로 꼿지만, 구문 존재 핀은 파일 수준이며, 호출 수준이 아닌, 그리고 실제로 이 지상 호출을 차단하는 것은 여전히 prose에 의해 중단 될 수 없습니다. 실행은 구조적 수정입니다; prose 지도는 무시한 모델이 살아남을 수 없습니다.

**구성 :** 3 단계의 재발생 (#497 → #2440 → /ship 단계 18 좌초). 걸이는 gstack 기술 세션 (다른 곳에서는 합법적인 배경 에이전트 사용)에 범위를 갖춰, Claude-host 만 (다른 호스트는 그것에서 아무것도 얻을 수 없습니다), 그리고 `bin/gstack-settings-hook*`에 있는 기존의 질문 환경 PreToolUse 걸이 배선을 거울. v1.79.0.0 CEO (clibaba)에서 신청하는 것은, Clibabas (clibaba)를 위한 시간 분할 계획 (clibaba)를 위한 계획합니다.

**노력:** M (human) / S (CC) **우선 순위:** P1 **에 따라:** None

*우선 순위는 P2 → P1 v1.79.0.0 adversarial 검토에 의해 제기: 스페인의 신뢰 사슬은 에이전트 각자 보조 (이초는 에이전트이 env prefix를 지시하기 때문에 존재합니다), 그래서 전방이 상호 작용하는 뛰기로 가득 차기 개조하기 전에 읽는 지시 텍스트를 읽습니다. Prose는 이것을 닫을 수 없습니다; 걸이는 할 수 있습니다.*

### 구조용 배 모드 문서 릴리스

**이름:** /document-release (VERSION를 범프할 수 없습니다, push) 대신 /ship의 파견 프린트를 통해 전체 워크플로를 좁은 대신 검토 패스 또는 push를 실행하십시오; 부모 /ship는 모든 git 가동을 소유합니다.

**왜:** v1.79.0.0 범위 가드는 에이전트을 말하는 것에 의해 작동; 구조적인 형태는 금지된 보다는 오히려 유효한 금지 가동을 만듭니다. Codex 외부 음성 (v1.79.0.0 eng 검토)는 현재 모양 “큰 워크플로를 달고 그 후에 prose를 통해서 그것의 반을 해제하고” - 수정하는 장기, 회귀 고침으로 접하게 잘못.

**구성 :** #2733 JSON 계약 (files_updated/commit_sha/pushed/documentation_section/decisions), 이렇게 베이킹 시간으로 PR를 자신의 필요. `ship/sections/pr-body.md.tmpl` 단계 18 및 `document-release/SKILL.md.tmpl`의 스파드 계약에서 시작; 형태가 파견된 모수 또는 `GSTACK_DOC_RELEASE_MODE`가 preamble echoes를 env하는 것을 결정하십시오.

**노력:** L (인간) / M (CC) **우선 순위:** P3 **에 따라:** None

## Cross-host 파견 semantics 감사

**이름:** 감사는 비 캐번 호스트 (codex, 공장, openclaw, hermes)에 각 서브 에이전트 파견 사이트 렌더링을 평가하고 호스트 당 결정합니다. 호스트의 기본 위임 원시, 인라인 - 번거로움, 또는 그것을 건너뛰기.

**왜:** 코드 호스트 배 렌더링 inlines 단계 18 Codex는 수행 할 수 없습니다 에이전트-tool 파견을 지시 (no 에이전트 도구, no run_으로_background). 사전 - 컴파일 (predates v1.79.0.0), 외부 목소리에 eng-review에 의해 표면. Host는 정확한 문자열에 현재 키를 다시 작성 ' Agent tool', 즉 none, 찰기, 찰기, 찰기를 통해 전달되는 지시를 통해 전달합니다.

**구성 :** `hosts/define-host.ts:55`, `hosts/factory.ts:34`, `hosts/hermes.ts:15` 기존의 리깅 메커니즘 및 `test/fixtures/golden/codex-ship-SKILL.md`를 참조하여 코드가 실제로 오늘 수신됩니다. v1.79.0.0 `{{FOREGROUND_DISPATCH_NOTE}}` 해결자는 호스트 브라이징을 시작하는 자연 장소입니다.

**노력:** M (human) / S (CC) **우선 순위:** P3 **에 따라:** None

## /ship 단계 12 시험 마구는 실제적인 템플렛 bash를 실행해야, reimplementation 아닙니다

**이름:** `test/ship-version-sync.test.ts`는 현재 `ship/SKILL.md.tmpl` 단계 12에서 템플릿 리터럴 안쪽에 bash를 다시 옮깁니다. 템플릿 변경이 있을 때, 양쪽 모두 업데이트되어야 합니다 — 정확하게 drift-risk 패턴을 방지하기 위해 단계 12 수정이 의미됩니다. 테스트 시간에 템플릿에서 담긴 배쉬 블록을 추출하는 돕는 대신, 동사적을 실행합니다 (`skill-parser.ts` 패턴에 모방).

**왜:** v1.0.1.0 배 동안 Claude adversarial subagent에 의해 표면 처리. 오늘 테스트는 테스트와 템플릿과 같은 오류 메시지 문자열이 이미 다르기 때문에 템플릿이 회귀하는 동안 녹색을 유지 할 것입니다. 그것은 침묵의 도둑 버그가 일어날 때까지 기다리는 것입니다.

**구성 :** 고정 시험 파일은 `test/ship-version-sync.test.ts` (garrytan/ship-version-sync)에 있습니다. 추출에서 skill-md를 위한 전례를 전하는 것은 `test/helpers/skill-parser.ts`에 입니다. 본: 템플렛을, 다음 `---`에, grep 담 bash, 먹이는, 대용한 정착물을 가진 `/bin/bash`에 `/bin/bash`에 새기고 읽으십시오.

**노력:** S (인간: ~2h/CC: ~30min) **우선 순위:** P2 **에 따라:** 없음.

## /ship 단계 12 BASE_VERSION git show가 실패할 때 0.0.0.0에 침묵하는 fallback

**이름:** `BASE_VERSION=$(git show origin/<base>:VERSION 2>/dev/null || echo "0.0.0.0")` silently defaults to `0.0.0.0` in any failure mode — detached HEAD, no origin, offline, base branch renamed. In such states, a real drift could be misclassified or silently repaired with the wrong value. Distinguish "origin/<base> unreachable" from "origin/<base>:VERSION absent" and fail loudly on the former.

**왜:** CRITICAL (confidence 8/10)으로 퍼지는 Claude v1.0.1.0 배 동안 adversarial subagent. 저 실제 위험. `/ship` 단계 3 이미 fetches origin 단계 12의 실행 전에 - 어떤 도달 실패는 이 코드가 실행하기 전에 3 긴 단계로 구출할 것입니다. 여전히, 방어력: 누군가가 전체 /ship 파이프라인 밖에 서 12의 bash를 호출하면 (예를 들어, 실제 마스크를 통해).

**구성 :** 수정: `git rev-parse --verify origin/<base>` probe로 감싸기; 실패하면, 과태 보다는 오히려 과실. 접촉 `ship/SKILL.md.tmpl` 단계 12 idempotency 구획 (선 409)를 접촉하십시오. 시험은 `git show`가 실패한 경우에 필요로 합니다.

**노력:** S (인간: ~1h/CC: ~15min) **우선 순위:** P3 **에 따라:** 없음.

### /land-and-deploy를 위한 GitLab 지원

**이름:** MR merge + CI `/land-and-deploy` 기술에 대한 조사 지원 추가. 현재 `gh pr view`, `gh pr checks`, `gh pr merge`, `gh run list/view`를 15+ 장소로 사용합니다. 각각 `glab ci status`, `glab mr merge`, 등을 사용하는 GitLab 조건 경로가 필요합니다.

**왜:** 이 없는 GitLab 사용자는 `/ship` (MR를 창조할 수 있습니다) 그러나 `/land-and-deploy` (merge + 검증)일 수 없습니다. GitLab 이야기에 끝을 완료하십시오.

**구성 :** `/retro`, `/ship`, and `/document-release` now support GitLab via the multi-platform `BASE_BRANCH_DETECT` resolver. `/land-and-deploy` has deeper GitHub-specific semantics (merge queues, required checks via `gh pr checks`, deploy workflow polling) that have different shapes on GitLab. The `glab` CLI (v1.90.0) supports `glab mr merge`, `glab ci status`, `glab ci view` but with different output formats and no merge queue concept.

**노력:** L **우선 순위:** P2 **에 따라:** None (BASE_BRANCH_DETECT 다 플랫폼 결산기는 이미 행해집니다)

## 멀티-컴밋 CHANGELOG 완전성 eval

**이름:** 5+를 가진 branch를 창조하는 주기적인 E2E eval를 추가하십시오 3개의 테마 (features, cleanup, infra)를, 달리십시오 /ship의 단계 5 CHANGELOG 발생을, 그리고 CHANGELOG를 모든 테마를 언급합니다.

**왜:** v0.11.22 (garrytan/ship-full-commit-coverage)에서 고정된 버그는 /ship의 CHANGELOG 발생이 긴 branch에 최근 투입을 향해 비스듬히 비스듬히 비스듬히 비스듬히 비스듬히 밝히는 것을 보여주었습니다. 신속한 수정은 십자가 검사를 추가하지만 no 시험은 다소 실패 형태를 운동합니다. 기존 `ship-local-workflow` E2E는 단 하나 질량 branch를 사용합니다.

**구성 :**는 `periodic` 층 시험 (~$4/run, LLM 지시를 따르기) 시험하기 때문에 비 결정적일 것입니다. 체제: 가시 원격, 복제, 특징 branch에 다른 주제의 맞은편에 5+ 교제, CHANGELOG 산출 덮개를 통해 단계 5를 실행하십시오 모든 주제를 확인하십시오. 본: `ship-local-workflow`에서 `test/skill-e2e-workflow.test.ts`.

**노력:** M **우선 순위:** P3 **에 따라:** None

### Ship log — /ship의 지속 기록

**이름:** 구조화 JSON 각 /ship 실행 (버전, 날짜, branch, PR URL, 검토 결과, Greptile 통계, 완료된 토도, 시험 결과)의 끝에서 `.gstack/ship-log.json` 입력을 적용합니다.

**왜:** /retro에는 no 구조화된 자료가 있습니다. 선박 통나무는 다음을 가능하게 합니다: PRs-per-week 동향, 검토 결과 비율, Greptile 신호, 시험 스위트 성장.

**구성 :** /retro 이미 greptile-history.md — 동일한 본을 읽습니다. Eval persistence (eval-store.ts)는 JSON 부록 패턴이 코베이스에 존재합니다. 배 템플릿에 있는 ~15개의 선.

**노력:** S **우선 순위:** P2 **에 따라:** None


## PR체에 스크린 샷으로 시각적 검증

**이름:** /ship 단계 7.5: push 후에 스크린 키 페이지, PR 몸에서 포함해.

**왜:** PRs의 시각적인 증거. 검토자는 현지 배포 없이 무슨 변경을 볼 수 있습니다.

**구성 :** 단계 3.6의 부분. S3 이미지 호스팅 업로드가 필요합니다.

**노력:** M **우선 순위:** P2 **에 따라:** /setup-gstack-upload

## 리뷰

### 인라인 PR 표기

**이름:** /ship 및 /review 포스트 인라인 검토 댓글 특정 파일에 댓글: `gh api`를 사용하여 라인 위치는 pull 요청 검토 의견을 만듭니다.

**왜:** 라인 레벨 표기는 최상위 의견보다 더 많은 작용이 가능합니다. PR 스레드는 Greptile, Claude, 인간적인 검토자 간의 선행 대화가 됩니다.

**구성 :** GitHub는 `gh api repos/$REPO/pulls/$PR/reviews`를 통해 인라인 검토 의견을 지원합니다. 단계 3.6 시각적인 표기와 함께 자연적으로 쌍을 합니다.

**노력:** S **우선 순위:** P2 **에 따라:** None

### Greptile 훈련 의견 수출

**이름:**는 기계 읽기 쉬운 JSON로 Greptile 모형 개선을 위한 Greptile 팀에 수출할 수 있는 틀린 긍정적인 본의 요약을 Aggregate greptile-history.md로 greptile-history.md를 분류합니다.

**왜:** 피드백 루프를 닫습니다. Greptile는 FP 데이터를 사용하여 코드베이스에 동일한 실수를 중지 할 수 있습니다.

**구성 :**는 P3 미래 아이디어였습니다. P2가 greptile-history.md 데이터 인프라가 존재한다는 것을 업그레이드했습니다. 신호 데이터는 이미 수집되고 있습니다. 이것은 단지 그것을 수출할 수 있습니다. ~40 선.

**노력:** S **우선 순위:** P2 **에 따라:** Enough FP 자료 축적 (10+ 항목)

### 스크린 샷과의 비주얼 리뷰

**이름:** /review Step 4.5: PR의 미리보기 배치를 찾아서, 변경된 페이지의 주석 스크린 샷, 생산에 대한 비교, 응답 레이아웃 확인, 접근성 트리를 확인합니다.

**왜:** Visual diff 코드 리뷰가 놓는 레이아웃 회귀를 잡습니다.

**구성 :** 단계 3.6의 부분. S3 이미지 호스팅 업로드가 필요합니다.

**노력:** M **우선 순위:** P2 **에 따라:** /setup-gstack-upload

## QA

### QA 동향 추적

**이름:** baseline.json 과 시간, QA 의 동작을 통해 회귀를 감지합니다.

**왜:** Spot quality 동향 - 앱이 더 나아지게 되었습니까?

**구성 :** QA 이미 구조화 된 보고서를 작성합니다. 이것은 크로스 실행 비교를 추가합니다.

**노력:** S **우선 순위:** P2

## CI/CD QA 통합

**이름:** `/qa` GitHub 작용 단계로, 건강 점수 하락이 있는 경우에 PR 실패합니다.

**왜:** CI의 자동화된 품질 문. 합병하기 전에 표절 회귀.

**노력:** M **우선 순위:** P2

## 스마트 default QA 층

**이름:** 몇 번 실행 후, index.md를 확인하여 사용자의 일반 계층 선택, AskUserQuestion를 건너 뛰십시오.

**왜:** 반복 사용자를 위한 마찰을 감소시킵니다.

**노력:** S **우선 순위:** P2

### 접근성 감사 모드

**이름:** `--a11y` 주력으로 집중된 접근성 테스트를 위한 플래그.

**왜:** 일반 QA 체크리스트를 넘어 전용 접근성 테스트.

**노력:** S **우선 순위:** P3

## CI/CD 비 GitHub 제공 업체용 세대

**이름:** 확장 CI/CD GitLab CI (`.gitlab-ci.yml`), CircleCI (`.circleci/config.yml`), Bitrise 파이프라인 생성을 위한 부트 스트랩.

**왜:** 모든 프로젝트가 GitHub 동작을 사용하지 않습니다. 유니버설 CI/CD 부츠 스트랩은 모든 사람에게 테스트 부츠 스트랩 작업을 할 것입니다.

**구성 :** v1는 GitHub 동작을 가진 배를 단지 발송합니다. 이미 `.gitlab-ci.yml`, `.circleci/`, `bitrise.yml`를 위한 검사를 검출하고 정보주를 가진 건너뛰기. 각 공급자는 `generateTestBootstrap()`에 있는 템플렛 원본의 ~20의 선을 필요로 합니다.

**노력:** M **우선 순위:** P3 **에 따라:** 시험 부트 스트랩 (선봉)

### 자동 업그레이드 약한 시험 (★) 강한 시험에 (★★★)

**이름:** 7단계 적용 감사가 기존의 ★ 등급 시험(smoke/trivial assertions)을 식별할 때 향상된 버전 테스트 가장자리 케이스 및 오류 경로 생성.

**왜:** 많은 코덱에는 기술적으로 존재하지만 실제 버그를 잡지 않는 테스트가 있습니다. `expect(component).toBeDefined()`는 동작을 테스트하지 않습니다. 이러한 확장은 "테스트"와 "좋은 테스트" 사이에 격차를 닫습니다.

**구성 :** 테스트 적용 감사에서 품질 득점 루퍼를 요구합니다. 기존 테스트 파일을 개조하는 것은 새로운 것을 창조하는 것보다 위험합니다 — 업그레이드 된 테스트를 여전히 통과하기 위해 조심해야 합니다. 원래 수정보다는 동반자 테스트 파일을 만드는 것을 고려하십시오.

**노력:** M **우선 순위:** P3 **에 따라:** 시험 질 득점 (shipped)

## 복고풍

## # Deployment 건강 추적 (retro + 검색)

**이름:** 스크린 샷 생산 상태, perf 메트릭 (페이지로드 시간), 키 페이지의 각 콘솔 오류, 복고풍 창에 대한 트랙 트렌드.

**왜:** Retro는 생산 건강을 포함해야 코드 미터와 함께.

**구성 :** Requires 검색 통합. 스크린샷 + 미터는 복고풍 출력으로 갔다.

**노력:** L **우선 순위:** P3 **에 따라:** 블로깅 세션

## 인프라

## /setup-gstack-upload 기술 (S3 물통)

**이름:** S3 이미지 호스팅을 위한 물통을 구성하십시오. 시각 PR annotations를 위한 1 시간 체제.

**왜:** /ship와 /review의 PR 표기에 대한 예선.

**노력:** M **우선 순위:** P2

### gstack-upload 도움자

**이름:** `browse/bin/gstack-upload` - S3, public URL로 파일 업로드.

**왜:** PR에 이미지를 삽입해야 하는 모든 기술에 대한 공유 유틸리티.

**노력:** S **우선 순위:** P2 **에 따라:** /setup-gstack-upload

## WebM 에 GIF 변환

**이름:** ffmpeg 기반 WebM → GIF PRs의 비디오 증거에 대한 변환.

**왜:** GitHub PR 몸은 GIF를 렌더링하지만 WebM. 비디오 레코딩 증거에 필요한.

**노력:** S **우선 순위:** P3 **에 따라:** 비디오 녹화



### Claude E2E 시험에 worktree 고립을 확장하십시오

**이름:** `useWorktree?: boolean` 옵션을 `runSkillTest()`로 추가하면 Claude E2E 테스트가 풀 repo 컨텍스트 대신 tmpdir 정착물에 대해 worktree 모드로 선택 할 수 있습니다.

**왜:** 일부 Claude E2E 테스트 (CSO 감사, 검토-sql-injection) 최소 가짜 리포지를 만들지만 전체 repo 컨텍스트로 더 현실적인 결과를 생성합니다. 인프라는 e2e-helpers.ts에서 `describeWithWorktree()`)가 존재합니다. 이것은 세션 실행기 수준에 그것을 확장합니다.

**구성 :** WorktreeManager는 v0.11.12.0에서 발송했습니다. 현재 Gemini/Codex 테스트는 worktrees를 사용합니다. Claude 테스트는 그들의 목적을 위해 정확하고, 진짜 repo 컨텍스트를 원하는 새로운 시험은 `describeWithWorktree()`를 오늘 사용할 수 있습니다. 이 TODO는 `runSkillTest()`에 깃발을 통해 더 쉽게 만들기에 관하여 입니다.

**노력:** M (인간: ~2 일/CC: ~20 분) **우선 순위:** P3 **에 따라:** 워크 트리 고립 (돌진 v0.11.12.0)

## E2E 모델 핀닝 - SHIPPED

~ ~ **이름:** 핀 E2E는 비용 효율성을 위해 claude-sonnet-4-6에 시험, 리트리를 추가합니다: 2 flaky LLM 응답을 위해. ~~

발송: Default 모형은 구조 시험을 위해 Sonnet로 바뀐 (~30), Opus는 질 시험을 위해 유지합니다 (10). `--retry 2` 추가되는. `EVALS_MODEL` env var override를 위해. `test:e2e:fast` 층 추가되는. 비율 한계 telemetry (first_response_ms, max_inter_turn_ms)와 벽_clock_ms 추적은 eval 상점에 추가했습니다.

## Eval 웹 대시보드

**이름:** `bun run eval:dashboard`는 도표를 가진 국부적으로 HTML를 봉사합니다: 비용 동향, 탐지 비율, pass/fail 역사.

**왜:** CLI 도구보다 트렌드를 강조하기 위해 시각적 차트가 더 좋습니다.

**구성 :** `~/.gstack-dev/evals/*.json` 을 읽습니다. ~200 라인 HTML + chart.js Bun HTTP 서버를 통해 Bun.

**노력:** M **우선 순위:** P3 **에 따라:** Eval persistence (v0.3.6에서 발송하는)

## CI/CD QA 품질문

**이름:** GitHub 동작 단계로 `/qa` 실행, PR 상태의 경우 임계값을 떨어뜨릴 경우 실패.

**왜:** 병합하기 전에 자동화된 품질 게이트 캐치 회귀. 현재 QA는 수동입니다 - CI 통합은 표준 워크플로우의 일부가 만듭니다.

**구성 :** headless CI에서 이진을 찾아봅니다. `/qa` 기술은 이미 `baseline.json`를 건강 점수로 생산합니다. CI 단계는 주 branch 기본선과 점수 하락이 있는 경우에 실패할 것입니다. CI에서 `ANTHROPIC_API_KEY`를 CI 비밀에서 필요로 하게 하거든 `/qa`는 클로드를 이용합니다.

**노력:** M **우선 순위:** P2 **에 따라:** None

## # Cross-platform URL 오픈 돕기

**이름:** `gstack-open-url`  헬퍼 스크립트 — 플랫폼, 사용 `open` (macOS) 또는 `xdg-open` (Linux).

**왜:** 처음에는 완전성 원리 인트로는 macOS `open`를 사용하여 에세이를 발사합니다. gstack가 Linux를 지원할 경우, 이 침묵으로 실패합니다.

**노력:** S (인간: ~30 분/CC: ~2 분) **우선 순위:** P4 **에 따라:** 아무것도

## CDP- DOM ref staleness를 위한 돌연변이 탐지

**이름:** Chrome DevTools Protocol `DOM.documentUpdated` / MutationObserver 이벤트를 사용하여 DOM 변경이 명시되지 않고 `snapshot` 호출을 비효율적으로 무효화합니다.

**왜:** 현재 ref staleness 탐지 (동시적인 조사) 체크)는 활동 시간에 stale refs를 붙잡습니다. CDP mutation 탐지는 refs가 stale일 때, SPA 재 렌더링을 위해 전적으로 5 초 시간의 끊기 방지할 것입니다.

**구성 :**는 ref staleness 고침 (수 ()를 통해 재팬 대사 메타데이터 + eager 검증의 1+2를 발송합니다. 이것은 부분 3입니다 — 가장 야심한 조각. Playwright, MutationObserver 교량과 함께 CDP 세션을 요구하고, 각 DOM 변화에 머리말을 피하기 위하여 주의깊은 성과 조정.

**노력:** L **우선 순위:** P3 **에 따라:** Ref staleness는 1+2 (돌아 지는) 분해합니다

## 사무실 시간/디자인

## 디자인 문서 → Supabase 팀 저장소 동기화

**이름:** Supabase sync 파이프라인에 디자인 docs (`*-design-*.md`)을 추가하여 테스트 계획, 복고풍 스냅샷 및 QA 보고서를 포함합니다.

**왜:** 스케일에서 크로스 팀 디자인 발견. 로컬 `~/.gstack/projects/$SLUG/` 키워드 -grep discovery는 같은 기계 사용자를 위해 지금 작동하지만 Supabase 동기화는 전체 팀에서 작동한다. 중복 아이디어 표면, 모두가 탐구 된 것을 볼 수 있습니다.

**구성 :** /office-hours는 `~/.gstack/projects/$SLUG/`에 디자인 docs를 쓰습니다. 팀은 이미 시험 계획을 동기화하고, 개조 스냅샷, QA 보고를 syncs 합니다. 디자인 docs는 동일한 본을 따릅니다 — 다만 sync 접합기를 추가합니다.

**노력:** S **우선 순위:** P2 **에 따라:** `garrytan/team-supabase-store` branch 주요 착륙

## /yc-prep 기술

**이름:** 기술이 창시자가 YC 응용 프로그램을 /office-hours가 강력한 신호를 식별하는 데 도움이되는 것입니다. 디자인 문서에서 풀, 구조는 YC 앱 질문에 대한 답변을 실행하고, 모의 인터뷰를 실행합니다.

**왜:** 루프를 닫습니다. /office-hours는 창시자를 식별하고, /yc-prep는 잘 적용할 것을 돕습니다. 디자인 문서는 이미 YC 신청을 위한 원료의 대부분을 포함합니다.

**노력:** M (인간: ~2주/CC: ~2시간) **우선 순위:** P2 **에 따라:** 사무실 시간 설립자 발견 엔진 선박 첫번째

## 디자인 리뷰

### /plan-design-review + /qa-design-review + /design-consultation — SHIPPED

메인에 v0.5.0로 발송. `/plan-design-review` (반전 디자인 감사), `/qa-design-review` (오전 + 고침 반복), 및 `/design-consultation` (동전 DESIGN.md 창조)를 포함합니다. `{{DESIGN_METHODOLOGY}}` 결심자는 공유한 80-item 디자인 감사 체크리스트를 제공합니다.

## /plan-eng-review의 외부 목소리 디자인

**이름:** 평행한 이중 음성 본을 확장하십시오 (Codex + Claude subagent)에 /plan-eng-review의 건축 검토 단면도.

**왜:** 디자인 비치헤드 (v0.11.3.0)은 크로스 모델 컨센서스가 주제별 리뷰를 위해 작동합니다. 건축 리뷰는 무역 결정에 유사한 주제를 가지고 있습니다.

**구성 :** 디자인 비치헤드에서 학습에 따라 달라집니다. litmus scorecard 형식이 유용하게 입증되면 건축 차원 (구두, 스케일링, 역성)에 적합합니다.

**노력:** S **우선 순위:** P3 **에 따라:** 외부 음성을 발송하는 디자인 (v0.11.3.0)

## /qa 시각 회귀 검출에 있는 외부 음성

**이름:** 버그 수정 검증 중에 Codex 디자인 음성을 /qa로 추가합니다.

**왜:** 버그 수정 시 수정이 코드 레벨 체크가 놓는 시각 회귀를 소개할 수 있습니다. Codex는 재 테스트 중 "반응된 레이아웃"을 플래그로 만들 수 있습니다.

**구성 :**는 /qa에 디자인 인식을 갖춰집니다. 현재 /qa는 기능적인 테스트에 집중합니다.

**노력:** M **우선 순위:** P3 **에 따라:** 외부 음성을 발송하는 디자인 (v0.11.3.0)

## 문서-관련

### Spawned-session 자동 초이스는 /plan-tune에 보이지 않습니다

**이름:** 캡처 자동 초원 결정은 스패딩 세션 (OPENCLAW_SESSION 또는 GSTACK_SESSION_KIND=spawned)에서 `gstack-question-log`로 결정합니다. `/plan-tune` 학습은 그(것)들을 볼 수 있습니다.

**왜:** 은신 세션에서 모델은 AskUserQuestion (이 자동 수집은 스페인 소유 블록 당 권장 옵션)를 호출하지 않고 PostToolUse 캡처 후크가 불을 붙지 않고 no 은신처가 기록되지 않습니다. /ship 단계 18 문서 릴리스 에이전트 내부의 모든 게이트 결정은 질문 조정 코르푸에서 누락됩니다.

**구성 :** #2733는 Claude Code subagents (현재는 지휘자를 호스팅했습니다 /ship에서 접근 가능한 한 spawned 회의를 한) 만들었습니다. subagent는 JSON 계약 `decisions` 배열 (배 콘솔에서 사용자 접근 가능)에 자동 초콜렛 결정, 그러나 `~/.gstack/` 질문 분석에 그(것)들을 쓰지 않습니다. `bin/gstack-skill-start`의 spawn이드 세션에서 시작 - "bin/gstack-question-log" 문장과 각 자동 초원 결정에 "log를 추가하고 `source` 값은 인간을 만든 경우 기계 선택에 결코 훈련하지 않도록 자동 초원을 구별합니다.

**노력:** S **우선 순위:** P3 **에 따라:** #2733 고침 (GSTACK_SESSION_KIND=spawned 감적기) 착륙.

### 자동 호출 /document-release /ship — SHIPPED

Shipped in v0.8.4; redesigned twice since. Current design (v0.18.2.0+, carved in v1.54.0.0): `/ship` Step 18 (`ship/sections/pr-body.md`) dispatches `/document-release` as a general-purpose subagent AFTER Step 17 (push) and BEFORE Step 19 (PR creation); the subagent's JSON contract (`files_updated`, `commit_sha`, `pushed`, `documentation_section`, `decisions` since v1.76.0.0) is baked into the initial PR body — except `decisions`, which prints to the ship console and never enters PR markdown. v1.76.0.0 (#2733) 이후 파견은 subagent `GSTACK_SESSION_KIND=spawned`를 표시하므로 대화 형 게이트 자동 선택이 권장되는 옵션입니다. 에이전트 실패는 비 차단입니다. 스켈레톤 이름은 세 개의 터치 포인트 (섹시 트리거 + STOP 포인터, 단계 17 핸드오프, 호이 doc-sync invariant)에서 "/document-release 에이전트"을 의미합니다. `test/ship-document-release-dispatch.test.ts` + carve-guards 앵커에 의해 핀; 앵커; `ship-docsync` 게이트 E2E (`test/skill-e2e-ship-docsync.test.ts`) 및 스파드 디퓨처 게이트 E2E (`test/skill-e2e-docsync-spawned.test.ts`)에 의해 입증된 행동.

## 기계 검사 단계 18 /ship의 단면도 자동 검사에 있는 파견 영수증

**이름:**는 선박의 "Section self-check"를 확인하여 문서 릴리스 파견을 실제로 발생했습니다 (기계 검사 마커/receipt), 대신에 프롬프트 레벨 invariants에 의존하는.

**왜:** Prompt wording deters skipping but can't prove the dispatch happened. Two residual gaps from the v1.69 review are folded into this scope: (1) an agent invoking `/document-release` inline via the Skill tool bypasses the fresh-context subagent + JSON contract and no test can see it; (2) the ship RE-RUN path names document-release in the re-run list but no test asserts doc-sync on re-run.

**구성 :** `ship-docsync` E2E는 1차 경로에 파견 도구 외침을 주장합니다; 이 TODO는 단어를 넘어서는 강제적인 층입니다. 배의 단면도 각자 검사에서 시작하십시오 (ship/SKILL.md.tmpl)와 ship/sections/pr-body.md.tmpl.에 있는 단계 18 부모 가공

**노력:** M (human) → S (CC+gstack) **우선 순위:** P3 **에 따라:** 배독 E2E 착륙

###는 파견 핀 + E2E 본을 /land-and-deploy → /canary에 적용합니다

**이름:** 동일한 처리 ship→document-release는 얻었습니다: 골격 결정 점에, carve-guards 닻 + 자유로운 삼각대를 가진 핀, 도구로 증명하십시오Calls 보조 E2E.

**왜:** 신입 장애 클래스 - 캐비드 또는 레이워드는 항상 로드된 골격을 끄고, 오늘 테스트하지 못합니다.

**구성 :** 모델 파일: `test/ship-document-release-dispatch.test.ts` (무료 핀) 및 `test/skill-e2e-ship-docsync.test.ts` (dispatch E2E, 문 층).

**노력:** M (human) → S (CC+gstack) **우선 순위:** P3 **에 따라:** None

## CI 문 레인 빈 표지 화상 아래로 (evals.yml 모체)

**이름:** `test/evals-workflow-matrix.test.ts` (added v1.70.1.0) 래치드 2개의 전 확증 CI 적용 구멍; 그(것)들을 점화하십시오. (1) 8개의 문 주인 시험 파일에는 no `evals.yml` 행이 있습니다, 그래서 CI는 그(`KNOWN_MATRIX_GAPS`)를 시험에서 실행하지 않습니다 — 계획 형태 및 발견 지면 연기 및 AUQ 체재 AUQ는 `tier:`를 가진 각자를, 그러나 4개의 점으로 놓지 않습니다. `codex-e2e`/`gemini-e2e`는 ZERO 시험과 보고 녹색을 각 PR (vestigial 줄에 뛰기 위하여 뛰기; 주기적인 cron 차선은 그(것)들을 소유하고 있습니다 — 줄을 삭제하는 것을 고려하고, `e2e-pty-plan-smoke`는 설치에 ~7 분을 그 후에 각 묘사를 건너 뛰습니다 (파일이 `describeE2ETier('gate')`를 채택한 후에, 재활성화하는 줄에 `tier: gate`를 놓습니다).

**왜:** "Gate tier block merge"는 이 파일을 위해 조용히 거꾸로 합니다. 각 고침은 deliberate cost/flake 결정 (각 PR에 지불된 스위트를 활성화하는), 그래서 드라이브에 의해 두드러지게 하는 대신에 격리됩니다. 기계장치는 이미 존재합니다: 뛰기 단계에 의해 `tier:` 재산, 수출되는 per-row `tier:`.

**구성 :** PR #2700에 2026-08-26을 찾아 `ship-docsync` 줄을 추가하면서 `ship-docsync`를 추가합니다. 수정 = add/adjust는 행을, 그 후에 DELETE 대응 화상 아래로 입장 (여행 철사는 stale 입장에 실패합니다, 그래서 정리는 강제됩니다).

**노력:** S 파일 (기계적) + 녹색 **우선 순위:** P2 **에 따라:** None를 확인하기 위하여 1개의 화상에서 뛰기

## Periodic 유료 테스트 shard 인구 통계는 detach-timeout floor에서 한 개의 ungated 파일입니다.

**이름:** The periodic tier's shard census is 67 files — one ungated slot below the 68-file (17×4) ceiling. The next paid `skill-e2e-*` file WITHOUT a whole-file `describeE2ETier` self-gate lands at 68 (still 17 waves, floor 32,130s ≤ 32,400s — passes); the SECOND ungated file trips 18 waves → 34,020s floor > the 32,400s configured detach timeout, and `test/eval-detach-timeout-floor.test.ts` fails with a confusing message.

**왜:** 누구든지 두 번째 ungated periodic E2E는 바닥 실패를 그들의 변화와 관련이 없습니다. 옵션을 수정하십시오: 주기적인 detach timeout를 올리거나, 모든 유료 파일에 전체 파일 계층 자체 게이트를 강제하십시오 (단면 전사 전사 전사적으로 물통에서 단단한 invariant에 격상시키고, 보너스 — tierless `bun run test:evals` 적용 결정을 혼자서 복원하십시오.

**구성 :** `scripts/test-paid-shards.ts` `classifyPaidTestFile`는 층 둘 다에 있는 ungated 파일을 조사합니다; `ship-docsync`는 diff를 가진 `describeE2ETier('gate')`를 마지막으로 자유로운 구멍을 바꾸기 위하여 특별히 구성했습니다.

**노력:** S **우선 순위:** P3 **에 따라:** None

## `{{DOC_VOICE}}` 공유된 해결자

**이름:** gen-skill-docs.ts 인코딩에 있는 위주자 결심자를 창조하십시오 gstack 음성 가이드 (친절한, 사용자를 위해, 이익과 지도). /ship 단계 5, /document-release 단계 5 및 CLAUDE.md에서 참고.

**왜:** DRY - 음성 규칙은 현재 3개의 장소 (CLAUDE.md CHANGELOG 작풍 단면도, /ship 단계 5, /document-release 단계 5)에 있는 인라인으로 살. 음성이 진화할 때, 모든 3개의 편류.

**구성 :** `{{QA_METHODOLOGY}}`와 같은 패턴 - 여러 템플릿으로 주입하여 gen-skill-docs.ts의 ~20 줄을 방지합니다.

**노력:** S **우선 순위:** P2 **에 따라:** None

## 선박 Confidence 대시보드

## 스마트 리뷰 리베이트 탐지 — PARTIALLY SHIPPED

~~**이름:** 자동검출은 branch 변경에 따라 4개의 리뷰가 관련되어 있습니다. (no CSS/view 변경이면, 코드 검토를 계획할 경우).~~

`bin/gstack-diff-scope` 배송 - SCOPE_FRONTEND, SCOPE_BACKEND, SCOPE_PROMPTS, SCOPE_TESTS, SCOPE_DOCS, SCOPE_CONFIG로 분류 diff. no 파일을 변경할 때 건너뛰기 위하여 디자인 전망 빛에 의해 사용하는. 조건 행 전시를 위한 대쉬보드 통합은 후속입니다.

**공급 능력:** 대시보드 조건 행 디스플레이 ( "Design Review : NOT YET RUN"일 경우 SCOPE_FRONTEND=false). Eng Review (docs-only 용 스키) 및 CEO Review (config-only 용 스키)로 확장하십시오.

**노력:** S **우선 순위:** P3 **에 따라:** gstack-diff-scope (돌아 낸)


## Codex

### Codex→Claude 역 버디 체크 기술

**이름:** `claude -p`를 실행하는 Codex-native 기술 (`.agents/skills/gstack-claude/SKILL.md`)는 Claude에서 독립적인 두번째 의견을 얻는 것을 - `/codex`의 반전은 Claude 코드에서 오늘 합니다.

**왜:** Codex 사용자는 Claude 사용자가 `/codex`를 통해 얻는 동일한 크로스 모델 도전을 요구할 것입니다. 현재는 1방향 (Claude→Codex)입니다. Codex 사용자는 no를 얻는 방법 Claude 두번째 의견이 있습니다.

**구성 :** `/codex` 기술 템플릿 (`codex/SKILL.md.tmpl`)은 패턴을 보여줍니다. `codex exec`를 JSONL 파싱, 타임 아웃 핸들링, 구조 출력으로 감싸고 있습니다. 역 기술은 유사한 인프라를 가진 `claude -p`를 감싸는 것입니다. `.agents/skills/gstack-claude/`로 `gen-skill-docs --host codex`로 생성될 것입니다.

**노력:** M (인간: ~2주/CC: ~30분) **우선 순위:** P1 **에 따라:** None

## 완료

### Completeness 메트릭 대시보드

**이름:** 자주 Claude는 gstack 세션을 통해 완전한 옵션을 선택합니다. 시간이 지남에 걸쳐 완성 추세를 보여주는 대쉬보드로 집계하십시오.

**왜:** Without measurement, we can't know if the Completeness Principle is working. Could surface patterns (e.g., certain skills still bias toward shortcuts).

**구성 :** 로깅 선택 (예: JSONL 파일에 AskUserQuestion가 해결될 때), 그들을 파싱하고, 동향을 표시하는 JSONL 파일에 부합하십시오. eval persistence에 유사한 본.

**노력:** M (human) / S (CC) **우선 순위:** P3 **에 따라:** 호수를 발송하는 기름 (v0.6.1)

## 안전 & 관찰성

### On-demand Hook 기술 (/careful, /freeze, /guard) - SHIPPED

~~**이름:** 3개의 새로운 기술 Claude Code의 세션-경찰된 PreToolUse 걸이를 사용하여 수요에 안전 난간을 추가하십시오.~

`/careful`, `/freeze`, `/guard`, `/unfreeze`, v0.6.5에서 발송하는. 걸이 불 비율 telemetry (pattern 이름, no 명령 내용) 및 인라인 기술 활성화 telemetry를 포함합니다.

### Skill 사용 원격 측정 — SHIPPED

~~**이름:** 테크놀로지가 맹세하는 트랙, 얼마나 자주, 어느 repo.~~~

v0.6.5에서 발송. TemplateContext에 gen-skill-docs.ts 베이킹 스킬 이름 사전 전술 선으로. 쿼리에 대 한 분석 CLI (`bun run analytics`). /retro 통합은 기술 사용-이-주를 보여줍니다.

### /investigate scoped 디버깅 향상 (텔레메틱에 가해)

**이름:** 6개의 증진은 /investigate 자동 동결에, 동결 걸이를 실제로 진짜 벌레잡기 회의에서 불 보여주는 telemetry에 계속합니다.

**왜:** /investigate v0.7.1 자동 냉동은 모듈에 debugged 편집합니다. 원격 측정이 걸이 불을 자주 보여줍니다 경우, 이러한 개선은 더 똑똑한 경험을 만듭니다. 불이 없으면 문제는 실제적이지 않았고 이러한 것은 건물 가치가 없습니다.

**구성 :** 모든 항목은 `investigate/SKILL.md.tmpl`에 추가됩니다. No 새로운 스크립트.

**제품:**
1. Stack trace 자동 검출 동결 디렉토리 (parse deepest app frame)
2. Freeze 경계 폭 넓은 (걸려 할 때 하드 블록 대신 넓은)
3. Post-fix 자동 동결 + 풀 테스트 스위트 실행
4. 디버그 계측청정 (DEBUG-TEMP, commit 이전에 제거)
5. 디버그 세션 지속 (~/.gstack/investigate-sessions/ — 재사용을 위한 조사 저장)
6. 디버그 보고서에 투자 타임라인 (타이밍과 관련된 논문)

**노력:** M (모든 6 결합) **우선 순위:** P3 **에 따라:** 실제 /investigate 세션에서 동봉 불을 보여주는 전도 자료

## 컨텍스트 인텔리전스

## Context 복구 preamble

**이름:** 읽기 gstack 의 읽기 (CEO 계획, 디자인 리뷰, eng 후기, 체크포인트)를 압축 또는 컨텍스트 분해 후 읽기위한 에이전트를 말하는 preamble에 prose의 ~10 줄을 추가하십시오.

**왜:** gstack 기술은 `~/.gstack/projects/$SLUG/`에 저장된 귀중한 artifacts를 생성합니다. Claude의 자동 활동 불 때, 그것은 일반적인 요약을 보존하고 그러나 이 artifacts가 존재한다는 것을 결코 알 수 없습니다. 계획과 검토는 현재 작동을 침묵하게 하고, 디스크에 아직도 아직도 있더라도,. 이것은 Claude Code 생태계에서 다른 것 아무 것도, 다른 gstack 예술이 있는 경우에, gstack 건축술은 있더라도, 해결됩니다.

**구성 :** 오랜 시간 에이전트에 대한 Anthropic의 `claude-progress.txt` 패턴에 영감을 주었습니다. 또한 claude-mem의 "진행적 인 공개" 접근법에 의해 알려줍니다. 더 넓은 비전에 `docs/designs/SESSION_INTELLIGENCE.md`를 참조하십시오. CEO 계획 : `~/.gstack/projects/garrytan-gstack/ceo-plans/2026-03-31-session-intelligence-layer.md`.

**노력:** S (인간: ~30 분/CC: ~5 분) **우선 순위:** P1 **에 따라:** None **주요 파일:** `scripts/resolvers/preamble.ts`

## 세션 타임라인

**이름:** 각 기술 실행 후 `~/.gstack/projects/$SLUG/timeline.jsonl`에 1 선 JSONL 항목을 승인 (시간 스탬프, 기술, branch, outcome). `/retro` 타임 라인 렌더링.

**왜:** AI-assisted work history 가 보였습니다. `/retro`는 이번 주 /review, 2 /ship, 1 /investigate를 보여줄 수 있습니다. 세션 인텔리전스 아키텍처를 위한 Observability layer를 제공합니다.

**노력:** S (인간: ~1h/CC: ~5 분) **우선 순위:** P1 **에 따라:** None **주요 파일:** `scripts/resolvers/preamble.ts`, `retro/SKILL.md.tmpl`

## # Cross-session 컨텍스트 주입

**이름:** 새 gstack 세션이 branch에서 최근 체크포인트 또는 계획이 시작될 때, 선행 요약을 인쇄합니다. "마지막 세션: 구현 JWT auth, 3/5 작업 완료." 에이전트는 어떤 파일을 읽기 전에 왼쪽 위치를 알고 있습니다.

**왜:** Claude는 각 세션을 신선한 시작한다. 이 1 라이너는 즉시 에이전트를 일시적으로 사용합니다. claude-mem의 SessionStart Hook 패턴과 유사하지만 단순하고 통합.

**노력:** S (인간: ~2h/CC: ~10 분) **우선 순위:** P2 **에 따라:** Context 회복 전무

## /checkpoint 기술

**이름:** 수동 기술 snapshot 현재 근무 상태: 무엇이 수행되고 왜, 편집되고, 결정 (과 합리적), 무슨 행한 대 남아있는 것, 긴요한 유형/signatures. `~/.gstack/projects/$SLUG/checkpoints/<timestamp>.md`에 저장.

**왜:**는 긴 세션에서 멀리 밟기 전에 유용한, 압축을 유발할 수 있는 알려진 컴퓨팅 작업, 다른 에이전트에 컨텍스트를 끄는 경우/workspace, 또는 일 후에 프로젝트에 다시 오.

**노력:** M (인간: ~1 주/CC: ~30 분) **우선 순위:** P2 **에 따라:** 콘텍스트 복구 preamble **주요 파일:** 새로운 `checkpoint/SKILL.md.tmpl`, `scripts/gen-skill-docs.ts`

### 세션 인텔리전스 레이어 디자인 doc

**이름:** `docs/designs/SESSION_INTELLIGENCE.md` 건축 비전 설명: gstack Claude의 ephemeral 컨텍스트 생존의 지속성 뇌로 `docs/designs/SESSION_INTELLIGENCE.md`. 각 기술은 `~/.gstack/projects/$SLUG/`, preamble re-reads, `/retro`롤로 쓰입니다.

**왜:** 컨텍스트 복구, 건강, 체크포인트 및 타임라인은 코헤드 아키텍처에 대한 기능을 연결한다. 생태계의 다른 사람은이 건물을 짓고 있다.

**노력:** S (인간: ~2h/CC: ~15 분) **우선 순위:** P1 **에 따라:** None

## 건강

### /health — 프로젝트 건강 대시보드

**이름:** 유형 체크, lint, 시험 스위트 및 죽은 코드 검사를 실행하는 기술, 다음 카테고리에 의해 고장으로 복합 0-10 건강 점수를보고. 동향 탐지를 위해 `~/.gstack/health/<project-slug>/`에서 시간을 추적. 선택적으로 더 깊은 complexity/cohesion/coupling 분석을위한 CodeScene MCP를 통합합니다.

**왜:** No 빠른 방법은 시작 일의 앞에 "코드베이스의 상태"를 얻는 것입니다. CodeScene 동료 검토 연구는 AI 생성한 코드를 30%, 코드 단지 41%에 의하여, 그리고 30%에 의하여 변화 실패 비율 증가합니다. 사용자는 난간을 필요로 합니다. `/qa` 같이 그러나 브라우저 행동 보다는 오히려 코드 질에 대하.

**구성 :** 프로젝트 별 명령 (platform-agnostic 원리)에 대한 CLAUDE.md를 읽습니다. 평행한 검사를 실행하십시오. `/retro`는 동향 불꽃 선을 위한 건강 역사에서 pull를 할 수 있습니다.

**노력:** M (인간: ~1 주/CC: ~30 분) **우선 순위:** P1 **에 따라:** None **주요 파일:** 새로운 `health/SKILL.md.tmpl`, `scripts/gen-skill-docs.ts`

## /health /ship 문

**이름:** 건강 점수가 존재하고 구성 가능한 임계값의 밑에 방울 경우 PR를 만들기 전에 PR: "건강은 8/10에서 5/10로 떨어졌다" branch — 3개의 새로운 힌트 경고, 1개의 시험 실패. 어쨌든 발송?"

**왜:** 배송 시료 코드를 방지하는 품질 게이트. 구성 가능한 임계 값 그래서 그것은 `/health`를 사용하지 않는 팀에 대 한 차단 하지 않습니다.

**노력:** S (인간: ~1h/CC: ~5 분) **우선 순위:** P2 **에 따라:** /health 기술

## 스와 팔

### Swarm primitive — 재사용 가능한 다중 에이전트 파견

**이름:** 추출물 검토 육군의 파견 본은 재사용 가능한 결심자 (`scripts/resolvers/swarm.ts`)로. 평행한 선 검사를 위한 `/ship`로 철사 (유형 체크 + lint + 평행한 에이전트에 있는 시험). `/qa`, `/investigate`, `/health`에 유효한 만드십시오.

**왜:** 검토 육군은 평행한 sub-agents 일 화려한 (5개의 에이전트 = 835K 토큰의 작동 기억 대를 위해 167K) 증명했습니다. 본은 `review-army.ts` 안쪽에 잠깁니다. 다른 기술 필요 그것. Claude Code 에이전트 팀 (공식, 2월 2026)는 팀 지도 대표적인 본을 유효하게 합니다. Gartner: 1 년에 있는 다중 에이전트 조회에 의하여, 445%.

**구성 :** 특정 `/ship` 사용 사례로 시작하십시오. 2+ 소비자가 구성 매개 변수가 실제로 필요한지 알 수 있는 것처럼 보이는 것처럼 보이는 것처럼, 공유된 부품을 추출하십시오. 기존의 WorktreeManager를 고립시키기 위해 활용할 수 있습니다.

**노력:** L (인간: ~2 주/CC: ~2 시간) **우선 순위:** P2 **에 따라:** None **주요 파일:** `scripts/resolvers/review-army.ts`, 새로운 `scripts/resolvers/swarm.ts`, `ship/SKILL.md.tmpl`, `lib/worktree.ts`

## 재공장

## /refactor-prep - Pre-Refactor 토큰 위생

**이름:** 프로젝트 언어/framework를 감지하는 기술로 TS/JS, Python, /deadcode, Rust를 위한 staticcheck/deadcode, Rust를 위한 화물 udeps, 지구 죽은 imports/exports/props/console.logs,를 위한 적절한 죽은 코드 탐지 (knip/ts-prune)를 실행하고, 정리를 따로따로 붙입니다.

**왜:** 더러운 코디베이스는 컨텍스트 조밀함을 가속화합니다. 죽은 수입, 사용되지 않은 수출, 또는 판화 된 코드는 조밀 한 중간 요인을 트리거하는 데 아무것도 기여하는 토큰을 먹는다. 첫 번째 청소는 컨텍스트 예산의 20 % +를 다시 구입합니다. 라인 제거 및 견적 token 저축.

**노력:** M (인간: ~1 주/CC: ~30 분) **우선 순위:** P2 **에 따라:** None **주요 파일:** 새로운 `refactor-prep/SKILL.md.tmpl`, `scripts/gen-skill-docs.ts`

## Factory Droid

## MCP 서버 Factory Droid

**이름:** 노출 gstack는 MCP 서버로 이진과 키 워크플로우를 Factory Droid가 기본적으로 연결한다. 공장 사용자는 /mcp를 실행하고 gstack 서버를 추가하고, 검색, QA 및 공장 도구로 검토 기능을 얻을 것이다.

**왜:** 공장은 이미 40+ MCP 서버를 레지스트리에서 지원합니다. gstack의 검색 바이너리를 얻는 것은 배포 놀이가 있습니다. 다른 사람은 MCP 도구로 실제 컴파일된 브라우저 바이너리를 가지고 있습니다. 이것은 gstack를 만드는 것은 Factory Droid에 독특하게 귀중한 것입니다.

**구성 :** 옵션 A (-host 공장 호환성 shim)는 v0.13.4.0에서 처음 배송합니다. 옵션 B는 더 깊은 통합을 제공하는 후속입니다. 검색 바이너리는 이미 stateless CLI이므로 MCP 서버로 포장하는 것은 straightforward (stdin/stdout JSON-RPC)입니다. 각 검색 명령은 MCP 도구가 됩니다.

**노력:** L (인간: ~1 주/CC: ~5 시간) **우선 순위:** P1 **에 따라:** --host 공장 (선택권 A, v0.13.4.0에서 발송)

## .agent/skills/ 크로스 에이전트 호환성을 위한 이중 산출

**이름:** 공장은 또한 단서 에이전트 겸용 경로로 `<repo>/.agent/skills/`에서 읽습니다. `.agent` 규칙을 사용하는 다른 에이전트의 맞은편에 더 넓은 도달을 위해 `.factory/skills/` 이외에 거기 출력할 수 있었습니다.

**왜:** 공장 저쪽에 다수 AI 에이전트은 `.agent/skills/` 규칙을 채택합니다. 산출은 또한 자유로운 겸용성을 줄 것입니다.

**노력:** S **우선 순위:** P3 **에 따라:** --host 공장

### 사용자 정의 Droid 정의와 함께 기술

**이름:** 공장은 "사용자 정의 드 로이드"(도구 제한, 모델 선택, 자율 수준과 함께 서브 에이전트)을 가지고 있습니다. read-only + 안전을위한 실행 도구 제한 도구와 함께 `gstack-qa.md` droid configs를 발송할 수 있습니다.

**왜:** Deeper 공장 통합. 갑상선 구성은 어떤 gstack 기술이 할 수 있는지에 공장 사용자 더 단단한 통제를 줍니다.

**노력:** M **우선 순위:** P3 **에 따라:** --host 공장

## GStack 브라우저

### Anti-bot 훔치는: Playwright CDP 패치 (rebrowser-style)

**이름:** Playwright의 CDP 층을 패치하는 포스트 설치 스크립트를 작성하고 `addBinding`을 사용하여 ID 발견, rebrowser-patches와 같은 접근을 위해 `navigator.webdriver`, `cdc_` 마커 및 기타 CDP를 사용하여, Google이 자동화를 감지하는 것을 사용하는 사이트가 검색합니다.

**왜:** v1.58.3.0의 우리의 JS 층은 "Layer C"입니다 - 항상 `navigator.webdriver` 가면 + `window.chrome.*` 모양 + `Notification.permission`/Permissions 정렬 + per-install `hardwareConcurrency`/`deviceMemory` + `Function.prototype.toString` 프록시 + 자동화-글로벌 스윕 + 크롬 드라이버 `cdc_`/`__webdriver` 클린업 (실험실 `deviceMemory`)보다는 가짜 플러그인보다 훨씬 더 많은 것을 인정합니다. That closes most JS-observable tells, but Google still triggers captchas because the deepest detection is at the CDP protocol level, which a page-world init script can't reach. rebrowser-patches proved the CDP approach works but their patches target Playwright 1.52.0 and don't apply to our 1.58.2. We need our own patcher using string matching instead of line-number diffs. 6 files, ~200 lines of patches total. (Layer C's toString proxy still has descriptor/Reflect.ownKeys surfaces; CDP 억제 또는 Chromium 포크를 통해 기본 코드에 스푸프를 밀어 JS 레이어가 안됨.)

**구성 :** rebrowser-patches 소스의 전체 분석 : `playwright-core/lib/server/` (crConnection.js, crDevTools.js, crPage.js, crServiceWorker.js, frames.js, page.js)에서 6 파일을 패치합니다. 주요 기술: `Runtime.enable` (주요 CDP 검출), 사용 `Runtime.addBinding` + `CustomEvent`는 실행되지 않고 실행되는 컨텍스트 ID를 발견하기 위하여. 확장 Chrome를 통해 실행되지 않은 경우 Chrome (이번에 의해 실행되지 않음), 이렇게 Chrome를 통해 테스트해야 합니다. (1) 확장 아직도 로드 및 연결, (2) captcha, (3) 사이드 바 채팅이 여전히 작동하지 않고 Google.com로드.

**노력:** L (인간: ~2 주/CC: ~3 시간) **우선 순위:** P1 **에 따라:** None

### Chromium 포크 (CDP 패치에 장기적인 대안)

**이름:**는 Chromium fork where anti-bot stealth, GStack Browser branding, 그리고 근원 코드에서 살아있는 본래 sidebar 지원, 런타임 원숭이 손가락으로 튀김으로.

**왜:** CDP 패치는 브리틀입니다. Playwright 업그레이드 및 타겟이 일치하는 fragile 문자열을 가진 JS를 컴파일했습니다. 적절한 포크 수단은 (1) 스텔스가 영구적 인 패치되지 않는, (2) 브랜딩은 기본 (no plist hacking at launch), (3) 네이티브 사이드바는 확장을 대체합니다 (단계 4의 V0 로드맵), (4) 사용자 정의 프로토콜 (gstack), 내부 V7/>를 유지하고, 큰 그룹을 유지하고, Chromium를 위한 작은 그룹 유지 보수를 유지하십시오.

**구성 :** V0 디자인 문서에서 방아쇠 기준: 연장 측 패널이 병목이 될 때 포크, 반대로 봇 패치가 CDP 보다는 더 깊은 생활할 필요가 있을 때, 또는 본래 UI 통합 (바, 상태 막대기) 연장을 통해 행해질 수 있을 때 포크. Chromium 구조는 32 핵심 기계에 ~4 시간을 가지고 가고 건축 artifacts의 ~50GB를 일으킵니다. CI는 <fra6/>를 위한 전 단계 분석에 전담한 분석이 있을 것입니다.

**노력:** XL (인간: ~1 분기/CC: ~2-3 주 집중된 일) **우선 순위:** P2 **에 따라:** CDP 패치는 반대로 봇의 가치를 훔치는 첫번째를 훔치는

## /spec 후속 (/plan-ceo-review SCOPE EXPANSION를 통해 v1.47.0.0에서 철저히)

## P2: `/spec --epic` 형태 (부모 + 아이 문제 + 종속성 도표)

**우선 순위:** P2

**이름:** Epic Issue(parent)과 N 아동문제를 명시한 종속성 그래프와 topological order로 제작한 `--epic` 플래그를 추가합니다. 여러 `gh issue create`는 육아체의 부모의 링크를 담고 있습니다.

**왜:** Multi-week 이니셔티브는 종종 상황에 공유하는 3-5 specs를 경간하지만 순차적으로 배. 오늘 `/spec --epic`는 사용자가 한 세션에서 전체 이니셔티브를 저자하고 모든 링크 된 문제의 원자로를 파일 할 수 있습니다. Epic 템플릿은 `spec/SKILL.md.tmpl` (PR #1698에서 제외)에 이미 존재합니다. 단지 flag routing + 멀티 워크 `gh` 오케스트라가 누락됩니다.

**프로 :**
- `/spec` v1이 커버하지 않는 다중 조직 워크플로우 간격을 닫습니다.
- 학부모 + 아동 연계는 프로젝트 보드가 전체적인 이니셔티브를 보여줍니다.
- 기존 `--execute` (모성 epic에 에이전트를 닦아; 에이전트 파일 어린이가 작동).

**단점 :**
- gh API 표면 (아이, 부모 연결 편집 통행 당 1개 창조).
- Markdown의 의존성 그래프 렌더링은 GitHub vs GitLab 렌더링자에서 치명적으로 나타났습니다.

**구성 :** `/plan-ceo-review` SCOPE EXPANSION (D5)에서 고려해, 5개의 긴요한 동종 확장 (---execute, --dedupe, 아카이브, 질 문, --audit)를 발송하는 호의 2026-05-25를 발송하는 호의를 베푸는. 일단 v1.47 배를 재평가하고 우리는 얼마나 자주 사용자가 진짜 /spec 회의에서 "이것이어야 하는지 보십시요.

**에 따라:** v1.47.0.0 `/spec`는 첫째로 착륙합니다; 다중 조직 표면을 측정하는 실제 사용 자료가 필요하십시오.

## P3: `/spec --dedupe` v1.1를 위한 semantic 일치 (LLM 근거한)

**우선 순위:** P3

**이름:** 업그레이드 `--dedupe`의 문자열 일치 `gh issue list --search` 에 LLM 기반 semantic 유사성. 오늘의 v1 선택 문자열 오버랩 제목 키워드; semantic 일치는 "반바 터미널 조각에 다시로드" 일치하는 기존 문제 제목 "PTY 재연결 후 실패"를 일치시키는 키워드 오버랩 0입니다.

**왜:** 문자열 일치는 높은 정밀도 그러나 낮은 회귀가 있습니다. 그것은 다른 어휘와 가까운 duplicates를 놓습니다. LLM semantic 경기는 더 많은 dupes를 붙잡고 그러나 spec 파견 당 ~$0.01-0.05를 요하고 5-10s 대기권을 추가합니다.

**프로 :**
- Catches dupes 문자열 일치 미사일.
- 더 많은 이유 `/spec`는 자유로워서 더 유용합니다.

**단점 :**
- 유료 + 느리게. 대부분의 v1 사용자는 아마도 비용을 정당화하기 위해 충분한 거짓 부정을 명중하지 않습니다.
- 또 다른 LLM-judged 결정은 이미 품질문을 가지고 있는 기술에.

**구성 :** `/plan-ceo-review` 빌드 타임 결정에 고려; v1에 대한 문자열 일치를 선택하여 dedupe 경로 무료 + 빠른 유지. v1이 실제 사용의 의미있는 거짓 부정적인 비율을 생산하는 경우 다시비스.

**에 따라:** v1.47.0.0 배; v1 문자열 매치에서 실제 false-negative 데이터를 수집합니다.

## Test/evals/CI speedup 후속 (/ship 검토 군대를 통해 파일 v1.66.0.0)

## P2: 안정 해시 대신 LPT를 기록한 기간에 의해 자유로운 스위트 shard 균형을 잡습니다

**이름:** Full-suite shard assignment is a stable hash; measured shard durations spread 69.5s-168.5s (max 2.4x min), so ~35-40s of every run is idle tail. Local full-suite mode doesn't need deterministic indices (only the CI --shards matrix does) — bin-pack by recorded per-file durations (bun prints them in the logs the runner already captures), keep assignFilesToShards untouched for --shard mode. **위치:** scripts/test-free-shards.ts main() full-suite path. **노력:** S (human ~4h, CC ~20min).

## P2: shard 어린이에게 부모의 eval 선택 (EVALS_SELECTION_JSON)

**이름:** sharded 유료 주자 계산 선택 한 번 부모에서, 하지만 각 shard 아이 재 파생 e2e-helpers 모듈 부하 (shard 당 git 스페인; 플러스 bun 아이 evaluating 이전 터치 파일 데이터를 지도-diff가 활성화 될 때). 직렬 부모의 선택 아이 env에 따라 선택 및 computeDiffSelection, 유지 아이 자기-증명 (선택)을 통해 비열. (선택) 및 비열 시험에 대한 선택. (선택) **위치:** scripts/test-paid-shards.ts runPaidShards env 구획; test/helpers/e2e-helpers.ts. **노력:** S (human ~4h, CC ~20min).

## P2: evals.yml 모체스 투수선 - 문 파일은 CI 모체로 나타야 합니다

**이름:** The branch's headline incident (two rehomed gate files silently never ran for 48 versions because the monolith's filename missed the hand-listed evals.yml matrix) has no tripwire binding gate-tier skill-e2e files to the matrix. e2e-tier-alignment covers the LOCAL sharded runner's mapper; the CI matrix can still drift. Parse the workflow YAML in a free test and diff against E2E_TIERS gate files (curated exclude list for deliberately-manual files). **위치:** new test beside test/e2e-tier-alignment.test.ts; .github/workflows/evals.yml. **노력:** S (human ~3h, CC ~15min).

## P2: E2E dep-list 자체등록 청소 — 129 177 키의 자신의 테스트 파일을 omit

**이름:** Editing only a test's assertions/prompt selects nothing for most keys (the adversarial review measured 129/177), and parent-side shard skipping makes the hole cheaper to hit. This branch fixed the rehomed files' keys; sweep the rest mechanically (each key's dep list appends the file that declares it) and upgrade e2e-tier-alignment's report-only mode to enforce self-registration. **위치:** test/helpers/touchfiles-data.ts; test/e2e-tier-alignment.test.ts. **노력:** S (human ~3h, CC ~15min).

## P3: RAM 대신 디스크에 비 살아있는 shard 산출을 지불한 주자

**이름:** 비 라이브 샤드 버퍼 그들의 전체 30 분 스트림 json stdout+stderr 메모리 (Buffer[]), x 작업 동시 shards. 스풀은 무료 러너의 per-run 로그와 같은 임시 파일에 스풀. **위치:** scripts/test-paid-shards.ts runPaidShard 버퍼 경로. **노력:** S (human ~2h, CC ~10min).

## P3: Eval Docker 이미지 신선도 삼각대

**이름:** The cache-key trio means the image rebuilds only when Dockerfile/bun.lock change; freshness of the baked unpinned claude CLI now rides entirely on ci-image.yml's cron. If the cron silently fails or is disabled, eval CI pins to an ever-older CLI with no signal. Add an image-age check (fail the eval workflow when the image tag's created date exceeds N days) or a cron-liveness alert. **위치:** .github/workflows/ci-image.yml, evals.yml. **노력:** S (human ~2h, CC ~10min).

## P3: 런타임 손잡이에 대한 Detach-floor 셀프 체크 (EVALS_JOBS)

**이름:** test/eval-detach-timeout-floor.test.ts computes the worst case from constants; an operator exporting EVALS_JOBS=2 doubles the gate worst case past the 25,200s watchdog and healthy tail shards report never-started. Add a runtime self-check in test-paid-shards main(): warn/fail when the computed worst case with LIVE options exceeds a GSTACK_DETACH_TIMEOUT env exported by gstack-detach. **위치:** scripts/test-paid-shards.ts; bin/gstack-detach. **노력:** S (human ~2h, CC ~10min).

## P3: Eval 저장소는 유효 판단/capture 모형을 기록합니다

**이름:** Model defaults moved (capture Opus→Sonnet) and GSTACK_EVAL_MODEL_JUDGE can silently change graders; eval:compare deltas across a model boundary conflate model swap with skill regressions. Record the resolved models in the eval-store record and surface them in eval:compare. **위치:** test/helpers/eval-store.ts, llm-judge.ts, eval-compare. **노력:** S (human ~2h, CC ~10min).

### P3: SECURITY_BENCH 정기적인 차선 - classifier 행동 적용은 아무 것도 실행하지 않습니다

**이름:** Gating the live L4 classifier tests on SECURITY_BENCH=1 fixed local suite speed but left the prompt-injection classifier with no scheduled lane. Add SECURITY_BENCH=1 (with model-cache warmup, 112MB first run) to evals-periodic.yml so behavioral coverage exists weekly. **위치:** .github/workflows/evals-periodic.yml; browse/test/security-live-playwright.test.ts. **노력:** S (human ~2h, CC ~10min).

## P3: 두 개의 shard 주자를위한 공유 어린이 라이프 사이클 돕기

**이름:** runFreeShard와 runPaidShard duplicate ~35 라인의 spawn/group-kill/ 벽 타이머 비계 verbatim (그리고 ShardCommand 유형). 스크립트에 추출/test-strict-output.ts, 이미 공유된 라이프 사이클 원시, 주자당 스트림 정책을 남겨. **위치:** scripts/test-free-shards.ts, scripts/test-paid-shards.ts. **노력:**.ts>. **노력:**.CC.

## P3: DI-refactor gstack-gbrain-detect-mcp-mode 시험 (~40s 스파크네임 비용, 흡수되었지만 진짜)

**이름:** Plan item 5 of the v1.66.0.0 pass, deferred: the test spawns the real binary repeatedly. Refactor to import the module with a DI-injected exec seam (never env-set-before-import), keep 1-2 spawn smokes. Cost is currently absorbed by shard parallelism; the per-file wall cost remains. **위치:** test/gstack-gbrain-detect-mcp-mode.test.ts. **노력:** S (human ~2h, CC ~15min).

## P2: In-shard eval concurrency (40)은 타임 아웃 - 레이크 가족의 공유 루트입니다

**이름:** PR #2593 (document-release 180s->300s, review-dashboard-via 300s->360s after PR #2472's 180s->300s, retro-base-branch 240s->360s)는 한 이야기를 공유합니다: claude session STARTUP queues behind up to 39 siblings under evals.yml, s7/>, 턴테이블의 첫 번째 옵션은, 첫 번째 옵션은, 첫 번째 옵션은, 첫 번째 옵션은, 첫 번째 옵션은, 첫 번째 옵션은, 첫 번째 옵션은, 첫 번째 옵션은, 첫 번째 옵션은, 첫 번째 옵션은, 즉, 첫 번째 옵션의 경우, 첫 번째 옵션의 경우, 첫 번째 옵션은, 마지막에 대한, 즉, 즉, 마지막 단계, 마지막 단계, 마지막 단계, 마지막 단계, 마지막 단계, 마지막 단계, 마지막 단계, 마지막 단계, 마지막 단계, 마지막 단계, 마지막 단계, 마지막 단계, 마지막 단계, 마지막 단계, 마지막 단계, 마지막 단계, 마지막 단계, 마지막 단계, 마지막 단계, 마지막 단계, 마지막 단계, 마지막 단계, 마지막 단계, 마지막 단계, 마지막 단계, 마지막 단계, 마지막 단계, 마지막 단계, 마지막 단계, 마지막 단계, 마지막 단계, 마지막 단계, 마지막 단계, 마지막 단계, 마지막 단계, 마지막 단계, 마지막 단계, 마지막 단계, 마지막 단계, 마지막 단계, 마지막 단계, 마지막 단계, 마지막 단계, (a) drop in-shard concurrency to ~15-20 and measure the wall-clock cost, (b) startup-aware budgets (start the timer at first turn, not spawn), (c) per-row concurrency overrides like the retries field. Receipts: the PR #2593 flake ledger comment. **위치:** .github/workflows/evals.yml:309 (--max-concurrency 40); test/helpers/session-runner.ts (budget start point). **노력:** M (human ~1d, CC ~45min + measurement rounds).

### P2: 계획 설계 전망 범위 문 발견자는 CI contention의 밑에 마진입니다

**이름:** `plan-design-review reaches a terminal outcome outside plan mode` (test/skill-e2e-plan-mode-no-op.test.ts)는 ONLY를 `scopeGateQuestionObserved` unchanged 코드에 체크 실패했습니다 — PR #2593 CI: 실패한 둥근 3/11 + 1개의 재런, 통과된 둥근 5/6, 모든 시도는 no 계획 형태 누출을 가진 맨끝 outcome에 도달합니다. Hypothesis: PTY 감지기는 40-hards에서 또는 40-hards에 있는 모양을 밖으로 닻을 냅니다. assertion는 이제 WITH 마지막 2KB 증거 꼬리를 던졌습니다. 그래서 다음 CI 실패는 스크린 내용을 나릅니다; 검출기를 고치십시오 (전체 스크롤 백, 또는 닻 모양을 넓히십시오) 그 자료에서.

**위치:** test/helpers/claude-pty-runner.ts (scopeGateQuestionObserved detector), test/skill-e2e-plan-mode-no-op.test.ts. **노력:** S (human ~3h, CC ~20min + 1 CI .

## P3: 창-latest에 브라우저 관리 단위 쐐기를 진단하십시오

**이름:** The expanded Windows lane wedges to its wall deadline inside browse/test/browser-manager-unit.test.ts (in-flight at kill, PR #2593 run 31919227507); the file is green on macOS and Linux. Excluded from the Windows curation with a receipt; needs a Windows repro to find which describe hangs (fake-timer/unref semantics under bun-windows are the suspects). **위치:** browse/test/browser-manager-unit.test.ts; scripts/test-free-shards.ts KNOWN_WINDOWS_INCOMPATIBLE (remove the entry once fixed). **노력:** S (Windows 상자, CC ~15min + CI 둥근을 가진 인간 ~2h).

### P3: 기술 검열 Windows 겸용성

**이름:** skillCensus() throws at module load on windows-latest (test/helpers/skill-census.ts:63) — the skills-tree symlink layout needs Developer Mode CI runners lack. Either branch the census walk on win32 (treat copy-dirs as the setup script's _link_or_copy fallback produces) or keep the exclusion. Consumers (catalog budget, coverage matrix) currently have no Windows signal. **위치:** test/helpers/skill-census.ts; test/skill-census.test.ts. **노력:** S (human ~3h, CC ~20min + CI rounds).

## P3: 꽉 개정된 적용audit E2E assertions

**이름:** The revived skill-e2e-coverage-audit tests assert hasGap OR hasTested (near-vacuous) and reference skill sections their own DRIFT WARNING says moved. Tighten to conjunctive assertions and retarget the prompts at live sections; needs one paid run to validate, so it didn't ride the ship. **위치:** test/skill-e2e-coverage-audit.test.ts. **노력:** S (human ~2h, CC ~15min + one paid run).

## 완료

## P3: 항상 로드된 `{{PREAMBLE}}` 참조 블록을 on-demand doc에 붙여넣기

**이름:** per-skill 섹션 carves (`/ship` v1.54, `/plan-ceo-review` v1.56) 수율 진짜 그러나 결합된 승리 (- 42%에서 -59%에 새겨진 기술에) 공유하기 때문에 `{{PREAMBLE}}` (~40-50KB 각 층 -3/4 기술에)는 지배적 항상 적재한 비용이고 인라인을 체재합니다. REFERENCE 블록 (AskUserQuestion 분할 및 CJK / lone-surrogate escaping reference)를 on-demand section-style doc에 드문 미리 정렬 된 골무를 이동하면 해당 가장자리 케이스를 표시 할 때 에이전트가 읽을 수 있습니다. (voice, completeness Principle, 권고 형식) 인라인.

**왜:** 가장 높은 ROI 나머지 token 표적. 1개의 전단 캐비드는 EVERY tier-≥2 기술이 한 번에, PR 당 1개의 기술 아닙니다. 계획 칼라오 캐비에 eng-review는 그 per-skill carves 체재가 항상 적재한 표면을 지배하기 때문에 정확하게 모세관을 체재하는 것을 돕습니다.

**프로 :** 단일 변경은 전체적인 기술 팩의 맞은 비용을 항상 감소시킵니다. **단점 :** 전단은 짐 방위 및 공유입니다; botched 새기는 각 기술을 회귀합니다. 동일한 조합 투명도 + per-push 신선도가 단면도 맹세 사용, 적용되는 corpus 넓은을 감시하십시오.

**구성 :** v2 단면도 파이프라인 (`scripts/resolvers/sections.ts`, `{{SECTION:id}}`/ `{{SECTION_INDEX}}`)에 구조. 전방 근원은 `scripts/resolvers/preamble.ts`입니다. 이하 구획이 감기 (참고 참고, 균열) 절단의 앞에 뜨거운 (서류, 권고 체재)를 측정하는 측정. 1개의 기술에 유효하게 한, 그 후에 corpus를 넓게 구릅니다.

**Effort 견적:** L (human 팀) → M (CC+gstack) **우선 순위:** P3 **/에 따라 달라집니다:** 섹션 파이프라인 (shipped v1.54). No 하드 블록. **완료:** v1.70.0.0 (2026-08-25) - 토큰 감소 프로그램에 의해 더 강한 형태로 전달되는: preamble bash는 `bin/gstack-skill-start`/`-end`, 1->, 1->, 1->, 1->, 1->, 10->, 1->, 10->, 1->, 10->, 10->에 의해 고정되는 문은, 20->에 의해 고정된 문에 의해 요구된 문에 의해 요구된 문에 의해 요구된 문에 의해 요구된.


### ✅ DONE (v1.69.0.0): `./setup --host slate`는 받아들이지 만 아무 것도 설치하지 않습니다

**우선 순위:** P4 (슬레이트 전용으로 신청 - 전체적인 편류 종류로 발송하는)

**이름:** `slate`는 호스트-arg 유효성을 통과했지만 no INSTALL_* 플래그를 설정하므로 실행은 아무것도 구성하고 0을 종료했습니다. 이제 `--host claude`의 정보 팔 (포인트; docs/designs/SLATE_HOST.md Slate 은 `.claude/skills` 을 호환성 fallback 으로 읽습니다. 그리고 0-dispatch 가드를 사용하면 설치 팔 없이 허용되는 경우, 크로스-팔 검사를 받아 들일 수 있습니다. hosts/index.ts 은 hosts/index.ts 를 갖는 것입니다.

**완료:** v1.69.0.0 (2026-08-22)

## ✅ DONE (v1.69.0.0, gstack 측): ZeroEntropy 일몰 검출 + 자문가

**우선 순위:** P1 (주행자 중심; gbrain 측 이동은 열려있을 것입니다 — NEXT PRIORITY를 보십시오)

**이름:** ~/.gbrain/config.json가 0entropyai 조리법 (실 열려있는 grep - 결코 작업 설정을 차단하지 않는)을 이름 때 Wireup warns; 설정 GBrain 공급자 의견은 유산 조리법을 선택하지 말하지 말; USING_GBRAIN_WITH_GSTACK.md 9월 4, 2026 마감일 및 #2365의 문제 해결 항목 이름.

**완료:** v1.69.0.0 (2026-08-22)

## ✅ DONE (v1.68.1.0): 정지 후크 등록 핀 설정 시간 절대 경로

**우선 순위:** P1 (위험한 Effort S, scoped를 정지 걸이에 신청했습니다 - 가득 차있는 결점 종류로 발송하는)

**이름:** dev worktree에서 Hooks를 등록하면 worktree의 물리적 경로가 글로벌 settings.json로 구워집니다. worktree가 AskUserQuestion/session 정지에서 오류를 남긴 후 죽은 후크를 삭제합니다. ALL gstack 걸이를 위해 고정하십시오. `_hook_command_path`, KNOWN_HOOKS (Claude Code stripping `_gstack_source` tags), `prune-stale [--repoint|--all]` 각 `./setup`, per-item mutation safety, mutation lock, 실패 닫히는 헛간, 그리고 uninstall/no-team 눈물다운에 heal-first를 달리는 각자 healer를 통해 canonical-only 등록.

**완료:** v1.68.1.0 (2026-08-18)

## ✅ DONE (v1.66.0.0): 무료 스위트 종료 코드는 무수합니다 - 처리 힘 exits 가면 실패

**우선 순위:** P1

**이름:** 적어도 5개의 찾아낸 시험 파일 끝 `setTimeout(() => process.exit(0), 500)` (browse/test/commands.test.ts:101, snapshot.test.ts:36, batch.test.ts:47, handoff.test.ts:31, content-security.test.ts:465). SHARED `bun test` 과정 안쪽 타이머 불은, bun의 앞에 0을, 그 마지막 요약을 인쇄합니다 - 그래서 `bun test`는 0를 미리 일관되게 할 수 있는 동안 진짜 시험 실패를 시험하는 동안 보고할 수 있습니다. 힘의 제거와 언더링 핸들 누출을 수정 (링 Playwright/daemon 핸들을 한 번 스위트 걸프를 만들었습니다), 또는 스파크링 아이 프로세스 출구를 범위.

**왜:** Observed 2026-08-07: three genuinely failing tests (eval-list-cli, benchmark-cli, observability check 11) rode green `bun test` exit codes across multiple runs; the failures only surfaced by grepping logs for "(fail)" lines. A test suite that exits 0 on failure is worse than no suite — it manufactures false confidence at commit time and in any CI job that trusts the exit code.

**프로 :** Restores the one contract everything (CI, /ship, humans) relies on: exit code == truth. Also un-hides the missing final summary block. **단점 :** The force-exits exist because the suite once hung on leaked handles; removing them without fixing the leaks trades silent failure for hangs. Needs a focused pass: find each leaked handle (daemon children, PTY, Playwright contexts), close them in afterAll, then delete the exits one file at a time.

**Context / 시작하려면:** `grep -rn "process.exit(0)" browse/test/` — setTimeout 변형은 오프 엔드 엔드 엔드 (server-no-import-side-effects.test.ts:62는 스파드 아이 probe, 벌금)입니다. Repro: 전체 무료 스위트를 실행하고 로그는 no "Ran N test" 요약을 사용하여 검색 파일에서 끝납니다. 영수증 : ~/.gstack-dev/logs/free-suite-main-check.log (3 마스크 실패, 종료 0).

**완료:** v1.66.0.0 (2026-08-15) - 주요 v1.64는 힘 exits를 제거했습니다; v1.66.0.0는 주자 수준 엄격한 산출 분류 (분의 맨끝 요약 FAILS 없이 shard), 크기 확장한 벽 마감 및 실패naming epilogue를 추가합니다, 그래서 종료 코드 == 진실은 주자에 의해, 대회에 의해 아닙니다 강제됩니다.

## 슬림 프리 캐블 + 실제 PTY 계획 모드 E2E 하네스 (v1.13.1.0)

- 압축 18 프리앰블 해결자; 총 `SKILL.md` 코푸는 3.08 MB에서 2.30 MB 47 출력 (-25.5%, ~196K 토큰 저장)의 맞은 편에 떨어졌다.
- `test/helpers/claude-pty-runner.ts` - `Bun.spawn({terminal:})` (Bun 1.3.10+는 PTY, no `node-pty`를 사용하여 진짜PTY 마구를 건설했습니다).
- Rewrote 5 계획 모드 E2E 테스트 (`plan-ceo`, `plan-eng`, `plan-design`, `plan-devex`, `plan-mode-no-op`); 처음 5 패스 (790s 순차).
- 동일한 테스트는 `origin/main`, v1.0.0.0, 그리고 SDK 마구를 가진 branch에 0/5이었습니다 — SDK는 Claude의 계획 형태 확인 UI를 관찰할 수 없었습니다.
- `scripts/skill-check.ts` sidecar-symlink 돕기, `test/skill-validation.test.ts` 의 `browse/test/fixtures/security-bench-haiku-responses.json` 의 <ph를 위한 면제를 접히는 측 고침은 (주요의 전단성 변환에서 크기 워닝 소음을 녹입니다).

**완료:** v1.13.1.0 (2026-04-25)

---

### v1.12.0.0 배에서 표면이 전 확고한 시험 실패 — RESOLVED

- `test/brain-sync.test.ts` GSTACK_HOME 고립은 v1.13.0.0에서 요점에 조정했습니다.
- `test/model-overlay-opus-4-7.test.ts` 새 오버레이 컨텐츠와 일치하기 위해 메인 업데이트 (V1.10.1.0 제거 "Fan out 명시적으로"정확했다 - 측정 −60pp fanout 대 기본).

**완료:** v1.13.0.0 (2026-04-25, 메인)

---

## `security-bench-haiku-responses.json` 크기 문 - RESOLVED

- 메인은 V1.13.0.0에서 전단적으로 경고하는 2 MB 트랙 파일 게이트를 변환했습니다.
- v1.13.1.0은 `knownLargeFixtures`이 특정한 의도적인 정착물을 위한 경고를 억제하는 면제를 추가했습니다.

**완료:** v1.13.1.0 (2026-04-25)

---

### Bearer-token 비밀 가짜 회귀 고정 + E2E 개인 정보 보호 게이트에 추가 + gh 자동 생성 (v1.12.0.0)

- **`bearer-token-json` 회귀 `bin/gstack-brain-sync`** - 값 charset `[A-Za-z0-9_./+=-]{16,}`는 공백을 허용하지 않았으므로 auth 헤더는 표준 `Bearer <token>` 형태 (현체 이름 후에 리터 공간) 스캐너를 통해 끄는 것입니다. 선택 `(Bearer |Basic |Token )?` 접두사에 추가하십시오. 5개의 긍정적인 케이스 (회복 정착물을 포함하여)에 대하여 유효하게 + 3개의 부정적인 케이스 (짧은 토큰, 비 분열 열쇠, 무작위 JSON). 7-pattern 비밀 스캐너는 이제 Bearer-json을 포함한 모든 고정 장치를 통과합니다.
- **`test/gstack-brain-init-gh-mock.test.ts` 추가** — 8개의 시험은 `gh` CLI를 전진한 자동 창조 경로가 이전 0 적용을 가지고 있었습니다. PATH에 `gh`를, 각 호출을 기록하기 위하여, 주장합니다 `gh repo create --private --description "..." --source <GSTACK_HOME>`를 가진 불을 `gstack-brain-<user>` default 이름. 덮개: 이미 노출되면, 이미 프로비저닝-URL-bypasses-gh, gh-not-on-path가 URL, gh-not-authed prompt for URL, idempotent `--remote` re-runs, 분쟁-remote rejection.
- **`test/skill-e2e-brain-privacy-gate.test.ts` 추가** - 정기적인 계층 E2E (~$0.30-$0.50/run).는 PATH + `gbrain_sync_mode_prompted=false`에 가짜 `gbrain`를 단계로 하여, `runAgentSdkTest`를 통해 실제 기술을 실행하고, `canUseTool`를 통해 도구 사용, 그리고 전방 불을 주장합니다 3-option privacy AskUserQuestion는 canonical prose ("publish session Memory"/"/ifactintests/`prompted=true`를 가진 두번째 문헌 시험입니다.
- **`test/helpers/touchfiles.ts` 에서 `brain-privacy-gate`로 등록** (기간표) `scripts/resolvers/preamble/generate-brain-sync-block.ts`, `bin/gstack-brain-sync`, `bin/gstack-brain-init`, `bin/gstack-config`, 그리고 에이전트 SDK 주자에 의존하는 추적을 가진. Diff 근거한 선택은 그 변화의 무엇이든 할 때마다 E2E를 재 실행할 것입니다.

**완료:** v1.12.0.0 (2026-04-24)

---

### 오버레이 효능 하네스 + Opus 4.7 팬아웃 판독 제거 (v1.10.1.0)
- `test/skill-e2e-overlay-harness.test.ts`, `@anthropic-ai/claude-agent-sdk`를 구동하는 기하학적 주기율과, 등록된 정착물에 대하여 ON 대 overlay-OFF)를 위한 첫번째 회전 팬아웃 비율을 측정하는 파라미터 주기율
- 원래 "Fan out 명시적으로" 오버레이 판 : 기본 Opus 4.7 = 70 % 첫 번째 회전 팬 아웃은 우리의 판결 = 10 %, Anthropic의 자신의 운하와 함께, 텍스트 = 0%
- `model-overlays/opus-4-7.md`에서 위조된 가설물 제거
- SDK 주자 + 엄격한 정착물 validator를 위한 36 시험 자유로운 층 단위 스위트를 발송하는
- E2E_TOUCHFILES 및 E2E_TIERS에서 `overlay-harness-opus-4-7-fanout-{toy,realistic}`를 등록하십시오
- 총 조사 비용 : ~ $ 7 3 eval 실행
**완료:** v1.10.1.0

## CI eval 파이프라인 (v0.9.9.0)
- GitHub Ubicloud runners의 eval 업로드 ($0.006/run)
- 파일내의 테스트 concurrency (test() → testConcurrentIfSelected()
- Eval artifact 업로드 + PR 패스로 댓글/fail + 비용
- 기본 비교를 통해 artifact 다운로드에서 주요
- EVALS_CONCURRENCY=40 ~6min 벽 시계 (와 ~18min)
**완료:** v0.9.9.0

## 배포 파이프 라인 (v0.9.8.0)
- /land-and-deploy — merge PR, CI/deploy, 수의 검증을 기다립니다
- /canary - anomaly detection를 가진 포스트 배치 감시 반복
- /benchmark - 핵심 웹 비틀림과 성능 회귀 감지
- /setup-deploy — 한 번 배치 플랫폼 구성
- /review 성능 및 번들 충격 통행
- E2E 모형 핀으로 꼿기 (Sonnet default, 질 시험을 위한 Opus)
- E2E 타이밍 전도 (첫번째_response_ms, max_inter_turn_ms, 벽_clock_ms)
- 테스트:e2e:fast 계층, --retry 2 모든 E2E 스크립트에
**완료:** v0.9.8.0

### 단계 1: 기초 (v0.2.0)
- gstack로 이름을 바꾸십시오
- monorepo 레이아웃에 대한 재 구조
- 기술 symlinks에 대한 설정 스크립트
- Snapshot 명령을 사용하여 정유 기반 요소 선택
- Snapshot 테스트
**완료:** v0.2.0

### 2 단계: 강화된 브라우저 (v0.2.0)
- 스크린 샷, snapshot 디핑, 대화 상자 처리, 파일 업로드
- Cursor-interactive 요소, 요소 상태 체크
- CircularBuffer, async 버퍼 플러시, 건강 체크
- Playwright 오류 포장, useragent 수정
- 148 통합 테스트
**완료:** v0.2.0

### 단계 3: QA 테스트 에이전트 (v0.3.0)
- /qa SKILL.md 6단계 워크플로우, 3개의 모드 (full/quick/regression)
- 문제 세법, 엄격 분류, 탐험 checklist
- 템플릿, 건강 점수 루비, 프레임 워크 감지
- wait/console/cookie-import 명령, 찾기 버리지 바이너리
**완료:** v0.3.0

### 단계 3.5: 브라우저 쿠키 가져오기 (v0.3.x)
- 쿠키-import-browser 명령 (Chromium cookie DB 해독)
- 쿠키 테이너 웹 UI, /setup-browser-cookies 기술
- 18 단위 테스트, 브라우저 레지스트리 (Comet, Chrome, 아크, 브라브, 가장자리)
**완료:** v0.3.1

### E2E 시험 비용 추적
- 누적 API를 추적, 임계값을 초과하면 경고
**완료:** v0.3.6

### 자동 업그레이드 모드 + 스마트 업데이트 체크
- Config CLI (`bin/gstack-config`), `~/.gstack/config.yaml`, 12h 캐시 TTL, 폭발 snooze 백오프 (24h→48h→1wk)를 통해 자동 업그레이드, "never asked again" 선택권, 업그레이드에 납품된 복사 동기화
**완료:** v0.3.8

---

## Brain-aware 계획 후속 (/plan-ceo-review + /plan-eng-review를 통해 파일 v1.48.0.0)

이들은 `~/.claude/plans/hm-interesting-well-why-dapper-eagle.md`의 v1.48 뇌 인식 계획 계획에서 deferred 체리 피크 (E2/E3/E4)입니다. 기초 (단계 0개의 법인 모형 + 단계 0.5 시렁 + 단계 1 preflight
+ 단계 1.5 신뢰 정책 + 단계 2 쓰기 백 비계) 배에
v1.48.0.0. 이 후속은 그것을 확장합니다.

## P2: /gstack-reflect 밤 종합 기술 (E2)

**이름:** 주간 `gstack/skill-run` +가 + `get_recent_salience`를 읽고 다음 기술에 표면 `gstack/insight` 페이지를 종합합니다.

**왜:** 교차 시간 패턴 감지는 합성 이동입니다. "이 주에 적외선에 4 계획소를 ran 았고, 0 제품은 작동이 생길 수 있습니까?" 표면 패턴이 사용자가 통지되지 않을 것입니다.

**프로 :** 뇌 화합물은 TIME의 맞은편에 기술에 맞지 않습니다. 본은 작용할 수 있습니다.

**단점 :** "당신은 제품을 만드는 것은"고분화 영토입니다; 프로젝트 당 선택 아웃, 주의적인 통찰력 템플릿을 필요로 합니다.

**구성 :** v1.48.0.0 벚꽃 핑크 (D4)에서 Deferred — 실제 `gstack/skill-run` 데이터를 위한 4-6 주를 기다리는 것은 상상된 것 대신 진짜 본에 대하여 반사 층을 디자인하기 전에 축적했습니다.

**노력:** L (인간 ~1-2 일, CC ~4-6h)

**에 따라:** 단계 0 (gstack/skill-run 페이지 유형 v1.48.0.0) + 축적된 자료의 6 주

## P3: 크로스 머신 뇌 캐시 동기화 (E3)

**이름:** 압축 다이제스트를 gstack-brain-sync git 파이프라인을 통해 압축을 밀어넣기 때문에 뇌 캐시는 Macs / 지휘자 작업 공간 사이에서 이동할 수 있습니다.

**왜:** 각 새로운 기계에 찬 표세를 삭제합니다 (일 당 기계 당 ~ 1-2s).

**프로 :** 새로운 기계에 즉시 온난한 캐시.

**단점 :** 주의를 기울이지 않는 경우에 Cache 독합 위험 (hash invariants, endpoint-binding, 분쟁 해결).

**구성 :** v1.48.0.0 벚꽃 펑크 (D5)에서 Deferred - 단일 기계 캐시는 V1; 정확한 위험은 그것의 자신의 디자인 통행을 필요로 합니다.

**노력:** M (후만 ~4h, CC ~30min)

**에 따라:** v1.48.0.0에서 뇌 캐시 층

## P3: /gstack-onboarding 전용 기술 (E4)

**이름:**는 새로운 gstack를 위한 5 분 체제 기술을 가이드했습니다 설치합니다: 읽기 CLAUDE.md + README를 통해 사용자를 걸고 + 최근 `gstack/product`를 건설하고 명시된 AUQs를 가진 활동적인 목표.

**왜:** 더 나은 UX 인라인 부츠 스트랩보다 (기획 기술이 부각 될 때 불만).

**프로 :** 클리너 냉연, 정형식.

**단점 :** 인라인 부츠 스트랩 (v1.48) 이미 찬 스타트 경로 적절하게 커버.

**구성 :** v1.48.0.0 Cherry-pick (D6)에서 Deferred - inline bootstrap 성능을 먼저 관찰하십시오; 마찰이 진짜 경우에 전용 기술을 추가하십시오.

**노력:** S (후만 ~2h, CC ~15min)

**에 따라:** 인라인 부츠 스트랩 서브콤맨드 v1.48.0.0

### P2: 상류 gbrain는_+ 추가_resolve MCP ops

**이름:** `mcp__gbrain__takes_add`와 `mcp__gbrain__takes_resolve` ops in `~/git/gbrain/src/core/operations.ts`를 추가하십시오. `commands/takes.ts:570`에서 재사용 가능한 `engine.resolveTake()` 돕기로 감속 거울 논리를 추출하십시오.

**왜:**는 담 구획 가을 없는 단계 2 구경측정 쓰기 뒤를 자물쇠로 엽니다. ~150 LOC. gbrain의 v0.31.x 로드맵에 이미.

**프로 :** 클린 Phase 2 경로는 "폴백을 넣어_page"냄새를 제거합니다.

**단점 :** 업스트림 gbrain repo, helsinki - 별도 PR.

**구성 :** 단계 2 쓰기 백은 이미 BRAIN_CALIBRATION_WRITEBACK 기능 플래그 (default off) 뒤에 v1.48.0.0에서 타전됩니다. 깃발은 진실한 한 번 상류 gbrain 배에 이 ops. ~50 LOC는 선호한 op를 위한 내리막을 교환하기 위하여 헬스인키에서 후속을 따릅니다.

**노력:** S (human ~1d, CC ~1h) gbrain repo; 헬기에서 삼극관 철사 위로.

**에 따라:** None (v1.48.0.0에서 풀 트랙)

## P3: 배경 공기 후크 감독

**이름:** Codex 외부 송장은 "기술 END"에서 재생한 배경은 손 파도치는 입니다. 적당한 과정 감독을 추가하십시오: PID 파일, 운동, 실패 기록, 크로스 플랫폼은 좌초합니다.

**왜:** 새로 고침이 실패할 때 `&`를 실행하는 `&`로 현재 구현 배경.

**구성 :** v1.48.0.0 코덱 텐션 T3에서 디퍼링. 사용자가 스테이플 다이제스트를 보고할 때까지 낮은 우선 순위를 유지해서 배경이 완전히 사라집니다.

**노력:** S (후만 ~2h, CC ~20min)

## P2: gbrain v0.42+ 땅을 재 검증하는 구경측정은

**이름:** 업스트림 gbrain 배 `takes_add` MCP op를 발송하고 FALSE에서 TRUE에 probe에 `/office-hours`에 대하여 `docs/gbrain-write-surfaces.md`에서 수동 probe를 재 실행하고 `gbrain takes_list`를 표면으로 `kind=bet`를 예상된 무게 (0.9를 가진 사무실 시간, 당 `scripts/brain-cache-spec.ts:151-157`)로 `kind=bet` 입장을 확인합니다.

**왜:** 오늘 구경측정은 경로가 `gbrain put` 담 구획 안쪽에 쓰기 위하여 뒤를 떨어뜨립니다 `takes_add`는 아직 유효하지 않습니다. 일단 v0.42+ 배가면, 에이전트은 `takes_add`를 직접 부르게 됩니다 — 우리는 새로운 경로가 실제로 촉감 가능한 가지고 있 검사해야 합니다.

**구성 :** v1.50.0.0 계획 §" 범위에서NOT". 담 구획 fallback 시험 (`test/takes-fence-fallback.test.ts`)는 두 경로 전부를 위한 배선을 덮습니다; 이 TODO는 유효할 때 선호한 경로의 살아있는 검증에 관하여 입니다.

**노력:** XS (인간 ~15min, CC ~5min)

**에 따라:** 업스트림 gbrain v0.42+ 출시 선박 `takes_add` MCP op (위에 TODO를 두십시오).

## P2: 다른 4개의 계획 기술에 뇌 writeback E2E를 확장하십시오

**이름:** `test/skill-e2e-office-hours-brain-writeback.test.ts`는 `/office-hours`만을 위한 뇌 writeback 경로를 포함합니다. `/plan-ceo-review`, `/plan-eng-review`, `/plan-design-review`, `/plan-devex-review`를 위한 평행한 시험 추가는 결심자 단위 시험 (`test/resolvers-gbrain-save-results.test.ts`, 모든 5)를 위한 배선을 커버하는 결심자 단위 시험 (`test/resolvers-gbrain-save-results.test.ts`를 가진 동등물에 per-skill 에이전트 폭력 적용을 가져올 것입니다.

**왜:** 해결사 테스트는 올바른 지침을 입증; E2E는 에이전트가 실제로 비오는 것을 증명합니다. 오늘 우리는 단지 5 계획 기술 중 하나에 대한 최종 신호를 가지고 있습니다.

**구성 :** v1.50.0.0 계획 §" 범위에서NOT". `makeFakeGbrain`를 `test/helpers/fake-gbrain.ts`로 추출하면 두 번째 소비자가 (YAGNI)에 도착하면 됩니다.

**노력:** S (human ~1d, CC ~1h). 4개의 뛰기를 위한 주기적인 층 (~$2-4 합계).

**에 따라:** 없음.

## P2: Real-session carve canary (E3, carve-guard 계획에서 방어)

**이름:** 와이어는 가시적 기술의 상단에 실제 세션을 읽어 놓습니다. 실제 사용자 세션이 가시적 인 기술을 구동하고 에이전트는 NOT 섹션을 읽어 skeleton의 STOP 지시어는 `~/.gstack/analytics/section-reads.jsonl` 및 `bun run eval:summary`를 통해 표면 편류에 (대략, 내용없는)을 기록합니다. 비 차단 경고, 절대 merge 문 (실현상 데이터는 비소).

**왜:** 정적 (E2) + 행동 (T2) 가드는 구조적으로 소리가 있고 실제 에이전트이 통제되는 eval에 있는 단면도를 읽는다는 것을 증명합니다. 그들은 NOT 생산 편류를 보십시오 — 살아있는 에이전트이 단면도를 건너뛰기 시작을 하는 신속한 콘텍스 변화. 캐러리는 실제 사용법에서 그 붙잡는 유일한 기계장치입니다.

**구성 :** 캐비드-경화 계획 (D5→T2, codex 외부-voice #7)에서 Deferred. `test/helpers/transcript-section-logger.ts`는 존재하지만 세례적인 시험 성적표 + 배 활동 지문, NOT 진짜 소유 편류를 위해 건축됩니다 — 그것은 이을 다시 할 수 있기 전에 rework를 필요로 합니다. 세례적인 감시를 첫째로 발송하십시오; 이 것을 한 번 추가하십시오. 그들은 입증된 유용한 것. 그 후에 `test/helpers/carve-guards.ts`는, 이미 그 자리에 놓인 것에서, 그래서 거기에서, 거기 `test/helpers/carve-guards.ts`는, 이렇게, 거기에서 설명합니다.

**노력:** M (후만 ~2d, CC ~4h).

**에 따라:** `transcript-section-logger.ts` 실제 소유 간격 재작업.

## P2: 열심히 행동 단면도 적재 시험 hermeticity

**이름:** `captureSectionReads`는 ANY 의 경로 일치 `sections/<file>.md`를 읽습니다. 골격의 STOP-더 gstack-root install path (`scripts/resolvers/sections.ts`는 `ctx.paths.skillRoot`)에서, 심은 정착물 사본이 아닙니다. 따라서 실행은 GLOBAL install's 단면도를 대신하는 단면도 독서 assertion를 만족시킬 수 있습니다.

**왜:** 글로벌 설치를 읽는 것은 전달하는 행동 테스트는 THIS branch의 새겨진 단면도 짐 증명하지 않습니다. 정착물의 단면도가 부서졌던 경우에 그러나 세계적인 설치가 끊지 않는 경우에, 시험은 아직도 통과할 것입니다.

**구성 :** Codex 캐비드 가드 배 (v1.57.0.0)에 대한 외부 청구서를 찾는. `auq-sdk-capture.ts`에서 사전 - 수출 - `skill-e2e-ship-section-loading`, `skill-e2e-plan-ceo-review-section-loading` 및 새로운 `carve-section-loading.test.ts`에 영향을 미칩니다. 수정 : 정착물의 ABSOLUTE 섹션 경로 (`planDir` 복사)와 일치하여 벌거벗은 `sections/<file>.md` regex; 또는 STOP를 읽으십시오. 정착물의 ABSOLUTE 섹션 경로에 일치하십시오.

**노력:** S (human ~3h, CC ~30min). **에 따라:** 없음.

### P3: Content-hash 다이어그램은 Make-pdf를 위한 캐시를 렌더링합니다

**이름:** 캐시 렌더링 다이어그램 SVG/PNG `~/.gstack/cache/diagram-render/`, `sha256(fence source + bundle version + render options)`에 키로 변경되어 `make-pdf`는 변경되지 않은 다이어그램에 대한 검색 렌더링 탭을 건너뛰고 있습니다.

**왜:** 각 런은 현재 각 울타리 (~150-300ms)를 렌더링합니다. 10 + 다이어그램이있는 문서는 쓰기 -preview 루프 중 반복 당 초를 지불합니다. Codex 외부 서지는 다이어그램 엔진 계획 (2006-06-11, D7)의 eng 검토 동안 누락 된 캐시 이야기를 떨어 뜨립니다.

**구성 :** 다이어그램 렌더링 번들은 `BUILD_INFO.json`를 내용 해시로 발송합니다 (`lib/diagram-render/`를 보십시오) - 번들 버전 캐시 키 구성 요소로 사용하므로 번들 범프가 깨끗하게 유효하게 해집니다. 유효성 표면은 주요 위험입니다. mermaid 테마 변경 후 stale 렌더링은 살아야 합니다. 한 번만 사용자가 멀티 다이어그램 문서를 명중하는 만; 쐐기 퍼프는 그치지 않고 잘합니다.

**노력:** S (human ~1d, CC ~30min). **에 따라:** 다이어그램 엔진 쐐기 선박 (lib/diagram-render 뭉치 버전).

## P3: Make-pdf e2e 문 시험 마구를 dedupe

**이름:** 5개의 e2e 파일 (`combined-gate`, `emoji-gate`, `diagram-gate`, `landscape-gate`, `format-gate`) 각각 같은 prerequisite probe (binary/browse/poppler)를 가진 체크 CI 단단한 파밀 대 국부적으로 건너뛰기), mkdtemp/rm 생활 주기, 그리고 아이 타임아웃 일정을 추출하십시오. 공유한 `make-pdf/test/e2e/helpers.ts` (presite, G) (Gir)를 가진 공유한 `make-pdf/test/e2e/helpers.ts` (presite, Gir)를, 뛰기십시오.

**왜:** v1.58.0.0에서 발견하는 검토 육군 정비 기능 — 보일러판은 각 새로운 문 (diagram 문은 지금 Bun.spawnSync를 통해 stderr를 붙잡습니다 다른 사람은 execFileSync를 사용하고 있습니다), 그리고 CI 단단한 거품 계약에 미래 고침은 5배 땅에 가지고 있습니다.

**구성 :** 배 시간에 Deferred (D8.2)는 방출의 꼬리에 5개의 녹색 파일의 맞은편에 시험 전용 churn이기 때문에. 0 사용자 방위 가치; 순수한 DRY.

**노력:** S (human ~3h, CC ~20min). **에 따라:** 없음.

## Egress-receipt follow-ups (v1.63 포트 파에서 /plan-eng-review + /codex를 통해 파일)

### P2: 사슬 발생 기록과 가진 egress ledger 교체

**이름:** 로테이트 `~/.gstack/security/egress.jsonl` 크기 임계 값 (`attempts.jsonl`의 10MB/5-generation pattern in `browse/src/security.ts`)에서, 각 새로운 세대 FIRST 기록이 이전 파일의 꼬리 해시를 포함해 `gstack-egress verify`는 세대를 가로 질러 갈 수 있습니다.

**왜:** v1.63는 WARN-at-25MB (시동적 성장)를 발송하지만, 파일에 바인딩되지 않았습니다. 교체는 deliberately deferred: 그것은 확인 계약을 변경하고, 잘못된 구현은 건강한 ledgers는 "부동"로 확인합니다.

**프로 :** 영원히 경계 디스크; 생성에 걸쳐 의미 있는 상태를 확인합니다. **단점 :** 사슬 발생 하수구는 미묘합니다; 그것의 자신의 집중한 시험 (크로스 세대는, 중간 회전 추락)를 필요로 합니다.

**구성 :** `lib/egress-receipt.ts` (`appendChained`/`verifyLedger`)는 그것의 교체 TODO 의견에 있는 디자인 스케치를 나릅니다. `attempts.jsonl` 교체 precedent에서 시작하십시오.

**노력:** S (human ~4h, CC ~25min). **에 따라:** v1.63 항구 파 착륙.

## P3: 발사 후 token 부트 스트랩 (현지 처리 임인)

**이름:** `/extension-token` 부트 스트랩에 발사 시간 비를 추가하십시오: `browse`는 headed 발사에 비례를, 그것 확장 (CDP `chrome.storage` 주입 또는 발사기 - 휘트 sidecar)로 씨를 뿌리고, 그 엔드포인트는 핀이 지는 근원을 따라서 요구합니다.

**왜:** v1.63의 핀으로 origin 체크는 브라우저 상황에 정정합니다; 어떤 국부적으로 PROCESS는 여전히 컬을 가진 근원 우두머리를 강제할 수 있습니다. 그것은 현재 모형 (모든 지역 과정이 항구 어쨌든 명중할 수 있습니다) 외부 - 이 TODO 문서는 그것을 통하여 deliberate 경계선 그리고 디자인한 경로입니다.

**프로 :** 로컬 프로세스 임의 경로 닫습니다 (v1.63 계획 검토에서 평가되는 세 가지 옵션의 가장 강한). **단점 :** 가장 큰 부츠 스트랩 변경; CDP 묘목은 세 가지 시작 경로 (`--load-extension`, baked-in Browser.app, real-Chrome fallback); 낮은 현재 일 값.

**구성 :** `browse/src/server.ts` `/extension-token` 핸들러 + `GSTACK_EXTENSION_ID`; `browse/src/browser-manager.ts` (~358, ~455, ~1562)에 있는 발사 경로; `extension/background.js` 부츠 스트랩.

**노력:** M (human ~2 일, CC ~1h). **에 따라:** none.

## P3: eval-watch shard-awareness

**이름:** Teach `scripts/eval-watch.ts` (hardcoded `_partial-e2e.json` 경로 ~line 17)에 대한 스윙 레이아웃: `<evalDir>/shards/*/_partial-e2e.json`를보고 shard subdirs의 전체 진행을 집계.

**왜:** v1.63의 sharded 주자 각은 자신의 이전에 대하여 자체적인 eval subdir (그래서 그 앞에 shards 지하실); `findPreviousRun`, `eval-compare`, `eval-list`, `eval-summary`는 모두 shard-aware를 만들었습니다, 그러나 살아있는 watcher 의도적으로 평평하게 체재 — 그것은 sharded 뛰기 도중 아무것도 보여줍니다.

**프로 :** `eval:bg:gate` sharded가 다시 실행 중 라이브 진행. **단점 :** 멀티 파일 시계 + 집계 UI; 낮은 지분 (런-경계 detach 로그 이미 스트림 per-shard 결과).

**구성 :** `scripts/eval-watch.ts`; `scripts/test-paid-shards.ts` (slug = test filename); `listEvalJsonFiles`에서 `test/helpers/eval-store.ts`에서 정의된 단단한 배치는 이미 레이아웃을 enumerates — 그것을 재사용합니다.

**노력:** S (human ~2h, CC ~15min). **에 따라:** v1.63 항구 파 착륙.

## v1.63 포트 웨이브 검토 후속 (/ship 검토 군대에서 철저히 차단 폴란드어)

정품 리뷰는 정보/polish이므로 v1.63 배에서 흩어져서, 수정이 아닌, 몇 가지 테스트를 원합니다. 이렇게 그들은 추적되지 않습니다.

- **P2 - 원격 측정 HTTP-status outcome는 죽은 코드입니다.** `_GSTACK_EGRESS_LAST_RECEIPT`
  `bin/gstack-telemetry-sync`의 명령 대용 대용 대용 대용사 중 하나에 설정되어, 영수증에 HTTP 상태를 불이 붙지 않을 것입니다. 일반 `exit:N` outcome는 여전히 기록되어 있으므로, 파열은 정확합니다. 수정: 콜러-읽을 수 있는 임시 임시 직원 파일에 영수증 ID를 부여하거나, 하위 쉘의 호출을 재구성합니다. (전문가 3 리뷰에 의해 확인)
- **P2 — 맥락비 "TOTAL 디스크에"더블-counts child skills** 루트-as-container
  트리 (이 repo의 자신의 레이아웃) : `buildBill`는 루트 기술 전체 트리 워크를 요약하고 각 어린이 서브 트리 (~2x TOTAL 라인). ALWAYS-ON / EAGER / --diff / --budget는 모든 비범죄입니다. 정보 TOTAL는 잘못되어 있습니다. 수정 : 단일 depldu`walkMd(root)`의 트리를 계산합니다. `walkMd(root)`는 `walkMd(root)` 또는 `walkMd(root)`의 트리를 제외합니다.
- **P3 - DRY/robustness 폴란드어:** 공유 `_gstack_egress_host_of` 도움자
  ~11개의 손 압연된 URL-to-host 추출은 egress 포탄 수채를 통하여; 복제한 터널 열려있는 `writeReceipt` 구획을 `browse/src/server.ts` (2개의 위치); 씩 반복 `SharedArrayBuffer` alloc를 egress-receipt 자물쇠 회전의 밖으로 호이스트하십시오; 명시한 깃발을 가진 context-bill's 정확한 형태 `errorPct === 0` sentinel를 대체하십시오; `frontmatterName()`에서 `skill-census.ts` in `skill-census.ts`.
- **P3 - 평가 표지판은 다음과 같이 설명합니다.** `PAID_TEST_GLOBS` ↔ `package.json`
  `test:gate` 패성 시험; `GSTACK_EXTENSION_ID` ↔ `manifest.json` 열쇠 derivation parity 시험 (`browse/scripts/extension-id.ts`); 각 shard 아이를 asserting 주자 시험은 `shards/<slug>`의 밑에 그것의 자신의 `GSTACK_EVAL_DIR`를 가져옵니다; supabase-provision/gbrain-sync/메모리-ingest를 위한 영수증 refusal branch 시험.

## P2: 하드 또는 리 계층 기술 e2e 계획 디자인 -이 PTY 탐지

**이름:** 문 층 `test/skill-e2e-plan-design-with-ui.test.ts`는 처음 v1.63의 `seedSkills`에 의하여 등록된 기술에 대한 실행을 시작되었습니다 신비한 PTY 아이들에 있는 PTY (포크는 이 파일을 삭제했습니다; 그것은 전에 아무것도 측정했습니다). 그것은 지금 믿을 수 있는 TIMES OUT 기술이 제대로 달더라도: 의 범위 게이트 AskUserQuestion (5 옵션, `<gstack-qid:plan-design-review-scope-gate>` 마커 현재)에 도달하는 성적표는 `isNumberedOptionListVisible`/`parseNumberedOptions` 스크랩을 긁는 것은 PTY 버퍼의 밖으로 분류할 수 없습니다. 스피너 프레임 (`[?25l✻Sprouting… still thinking`)는 옵션 텍스트로 문자 별표가 덮여 있습니다.

**왜:** Shipped 동작은 정확합니다 - 이것은 테스트 하향 탐지 제한, 제품 버그가 아닙니다. 그러나 항상 밖으로 문 테스트는 no 시험보다 나쁘다.

**수정 옵션:** (a)는 일치하기 전에 꼬리 찰상 (drop DEC 개인 모드 + 스피너 잔류물을 강하게 합니다; widen/clean 창); (b)는 LLM-judge fallback classifier (파일의 자신의 의견 참고 regex 발견자는 "PTY 연출 quirks"에 brittle입니다); 또는 (c)는 주기적인 때까지 이 시험을 이동하십시오 (b)/(b) 땅.

**구성 :** `test/skill-e2e-plan-design-with-ui.test.ts`, `test/helpers/claude-pty-runner.ts:308` (`isNumberedOptionListVisible`). 배분: `~/.gstack-dev/eval-runs/pdwu-verify-*.log`. **노력:** M (human ~half 일/CC ~30min).

## P3: 2026-08-14 추적기 부착 파도의 잔류물 (v1.67.0.0에서 주로 발송되는)

The four deferred waves (A: browse-daemon lifecycle, B: install integrity, C: gbrain trust boundary, D: ship/version allocator) LANDED in the v1.67.0.0 fix wave: XProtect self-heal + Playwright bump + busy-daemon iron rule + signal policy (A); alias shadowing + cursor slice + runtime assets + Windows refresh (B); brain-sync disposition model + source pins + thin-client detection (C); version allocator end-state + subdir manifests + diff-scope globs (D). What remains, re-filed individually:

- 워치독은 headed 핸드오프 세션 (PRs 2565/2405/2346)와 세 세 가지를 죽이고 있습니다.
  browse/test/handoff.test.ts의 darwin-skipped handoff 테스트 - v1.67 XProtect + rebrand 작업이 차단되지 않는지 확인, 그 다음 스키 또는 수정. Effort S.
- Transcript trust/scope/source 고립 (PR 2232, 문제 2140) - 필요
  결코 두 배 상점 검토. Effort M.
- Versionless-repo 온보드 (#1474, 2343/2334) — #2501 JSON
  버전 경로 반 착륙; no-version-file-at-all 흐름이 아니었다.
- Playwright 부츠 스트랩 abort/timeout 흡수 (PRs 2233/2359, 문제
  1902/2136) — 부분적으로 v1.67의 경계된 부트 스트랩에 의해 초래; 확인 및 닫기 또는 나머지를 추출.
