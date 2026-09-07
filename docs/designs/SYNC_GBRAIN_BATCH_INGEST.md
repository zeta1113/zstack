# /sync-gbrain 배치는 이동을 혼잡합니다

**상태:** 가리탄에 구현/dublin-v1 (D1-D8 결정 토지 이 PR) **주요 특징:** 가리탄/dublin-v1 **이름:** 가리탄 **에 의해 트리거 :** /investigate 실행, 2026-05-09 **예상된 노력:** 인간 ~3 일 / CC+gstack ~2 hr **파일 연결:** 4 소스 + 1 = 총 5 (총 5)

## 결정 (post-review)

이 문서는 원래 건축술을 캡처합니다. 8 리뷰 당 최종 건축 땅은 `/Users/garrytan/.claude/plans/purrfect-tumbling-quiche.md`에서 캡처 한 결정 :

- **D1** 계층화 디디셔널 (mkdir -p per slug 세그먼트) - 유지
- **D2**는 PR (`--legacy-ingest` 플래그 없음)과 같은 레거시를 삭제합니다.
- **D3** 스캔 소스 파일 먼저, 단계 만 깨끗하게 — 유지
- **D4** ~~3주 OK/DEGRADED/ERR verdict~~ COLLAPSED 으로 OK/ERR 으로
  Codex 7을 찾는 (gbrain content_hash idempotency는 3개의 국가 중복을 만듭니다)
- **D5** ~~skip_reason 필드는 Codex 의 DROPPED 를 Codex 를 찾은 7
  (레-런은 저렴합니다; 영구적 인 Skip-tracking에 대한 필요 없음)
- **D6** 신뢰 gbrain의 content_hash idempotency; 드롭 북키핑
  비계 (skip_reason, 세 번째 상태, SIGTERM 체크 포인트)
- **D7** per-file 실패 검출을 통해 `~/.gbrain/sync-failures.jsonl`
  (byte-offset 스냅샷 + 부드런 읽기)
- **D8** 번들 3 in-scope pre-existing fixes: F6 원자 득점방해
  (tmp+rename), F8 절연식 벤치 마크, F9 전체 파일 sha256 해시 (더 이상 1MB 모자)

## gbrain 소스에서 검증

`~/git/gbrain/src/`를 읽는 3개의 재산:

- **Idempotency의 장점** `core/import-file.ts:242-243, :478` - content_hash
  체크, 변경된 경우, 덮어쓰기
- **Frontmatter 패티** `core/import-file.ts:228, 297, 410-422`에서
  title/type/tags 명예를 줬습니다; frontmatter absent 때 자동 출현.
- **Path-authoritative 슬러그** `core/sync.ts:260` (`slugifyPath`)에서,
  `core/import-file.ts:429`에 시행
- **Per-file 실패 표면** `commands/import.ts:308-310`,
  `:28`: "callers can gate state advances" — 의도적인 API 어떤 D7 용도에 대 한.

## 성능: 측정된 대 계획 (post 2026-05-10 perf 검토)

| Metric | 계획 대상 | 의제한 | Command |
|---|---|---|---|
| 5135 파일에 단계 준비 | — | <10s | FAST |
| `gbrain import` 5135 파일 | — | >10분 | gbrain-side perf 문제, 파일 |
| 루프 / 훅 (원래 버그) | 은지 | 은지 | FIXED |
| 메모리 ingest 종료 null 에 SIGTERM | 의 아니 | no - state writes 성공; 아이 gbrain dies 와 부모 | FIXED |
| FILE_TOO_LARGE 블록 last_commit | 의 아니 | no — D7을 통해 제외된 경로가 실패했습니다. | FIXED |

**초기 perf 놓기 + 보정.** 첫번째 찬 달리는 측정 (~12 분)는 ~256ms에 1841의 순차적인 gitleaks 이하 처리 천막에 의해 각각 - 중복 안전 문 지배되었습니다. 교차 기계 여과 경계는 `gstack-brain-sync` (bin/gstack-brain-sync:78-110, `git commit`의 앞에 단계 디프에 regex 근거한 비밀 검사입니다. LOCAL PGLite에 던져지기 전에 각 근원 파일을 검사하는 것은 이미 비정상적인 텍스처에 있는 비축에 있는 그러나, 이미 변화하지 않습니다. `--scan-secrets`를 통해 파일 gitleaks opt-in을 만들었습니다. 기본값은 꺼집니다. ~12 분에서 10 초 미만으로 준비 단계를 잘라냅니다.

나머지 찬 실행 비용은 `gbrain import` 자체이며, 큰 시효 디너 (10s 501 파일에 대한)보다 더 악화됩니다. >10 분 5031). 즉, gbrain-side perf 문제, gstack 아키텍처가 아닙니다. TODO로 Filed; gbrain의 content_hash 체크 루프 또는 자동 링크 재구성 단계에 대한 해결 가능성이 있습니다.

## F9 해시 마이그레이션 (일회 절)

F9 1MB-capped hash에서 전체 파일로 전환 `fileSha256`. 이 변경 전에 국가 항목을 기존하는 것은 오래된 1MB-capped hash를 수행. 어떤 파일에 대한 mtime hasn't 변경, `fileChangedSinceState` 반환 false mtime check and new hash is never computed — so unchanged files samely. 어떤 파일에 대 한 mtime DOES 업그레이드 후 변경, 전체 파일 recorly 변경 (). `gbrain doctor` 프로브 보고서 `updated_count`는 모든 접촉 파일이 알고리즘 경계를 교차하기 때문에 첫 번째 실행 포스트 업그레이드에 팽창 된 번호를 보여줄 수 있습니다. 데이터 손실이 없지만 알기 가치가 없습니다.

## 팔로우 (TODO로 파일)

1. **큰 디서에 gbrain 수입품 perf** — 5031 파일을 왜 조사
   501이 10s를 소요할 때 >10 분. 마찬가지로 culprits : N1 SQL `getPage(slug)` content_hash check, per-page auto-link reconciliation, FTS 배치없이 인덱스 업데이트. gbrain에서 라이브, gstack하지.
2. **선택 사항: 소스 파일 변경 감지 캐시** - 심지어
   5031 파일을 걸어 단계가면 시간이 걸립니다. 일괄 레벨(당 파일)의 "변화가 없어지"상태를 호출하면, 이 현상이 전혀 실행되지 않습니다.

## 문제

`/sync-gbrain` 메모리 스테이지는 신선한 PGLite 및 출구에서 35 분이 걸립니다. 결과적으로 동일한 35 분을 다시 실행합니다. 두 연속 실행 (gbrain 0.30.0 깨진 포스트 실행 : 712s 종료 - gbrain 0.31.2 PGLite 실행 : 2100s 501 페이지가 실제로 지속됩니다).

## 뿌리 원인 (/investigate에서)

`bin/gstack-memory-ingest.ts`의 두 개의 합성 버그:

1. **Subprocess-per-file 아키텍처.** 선 911 워크에서 가장 중요한 루프
   1,841 파일 `~/.gstack/projects/` 및 파일 당 두 하위 처리 :
   - `gitleaks detect --no-git --source <path>` - 46ms 콜드 시작 (`lib/gstack-memory-helpers.ts:157`)
   - `gbrain put <slug>` - 329ms 추운 시작 (`bin/gstack-memory-ingest.ts:823`)
   - 파일 층 : 375ms × 1841 = 690s (11.5 분) 순수한 하위 프로세스 시작
     실제 작업이 발생하기 전에.

2. **킬-노 득점 타임 아웃.** `bin/gstack-gbrain-sync.ts:442`의 오케스트라
   35 분의 타임 아웃을 시행합니다. 불이 켜지면 `spawnSync`가 `result.status === null`를 반환하면, 아이는 SIGTERM를 얻고, in-memory ingest state는 `~/.gstack/.transcript-ingest-state.json`로 플러시하지 않습니다. 다음 실행은 동일한 비발한 상태로 시작됩니다. - redo-everything 패턴을 설명합니다.

## 필드 번호

| Metric | 의 값 | Source |
|---|---|---|
| walkAllSources의 파일 | 1,841 | `find ~/.gstack/projects -type f \( -name "*.md" -o -name "*.jsonl" \)` |
| `gbrain put` 찬 시작 | 329ms의 | `time (echo "test") \| gbrain 넣어 _ 벤치)` |
| `gitleaks detect` 찬 시작 | 46ms의 | `time gitleaks detect --no-git --source <small-file>` |
| 이론적인 층 (subprocess 전용) | 690 / 11.5 분 | 375ms × 1841년 |
| 관찰된 실행 시간 | 2100s / 35 분 | 오케스트라의 시간 |
| 페이지 실제로 persisted | 501 | gbrain 소스 목록 페이지_count |
| 실행 중 PGLite 성장 | 290 → 386 MB | `du -sh ~/.gbrain/brain.pglite` |

## 제안된 건축

**준비된 다음 배치** 파이프라인을 가진 per-file subprocess 반복을 대체하십시오:

```
walkAllSources(ctx)
  → prepareStage (in-process, fast):
       parse transcripts/artifacts
       build PageRecord with custom YAML frontmatter
       gitleaks scan (single subprocess on staging dir)
       write prepared .md to staging dir
  → gbrain import <staging-dir> --no-embed (single subprocess)
  → flush state file with all successes
  → cleanup staging dir
```

## 왜 `gbrain import <dir>`는 올바른 배치 경로입니다

- gbrain CLI (verified: `gbrain --help` 쇼 `import <dir> [--no-embed]`)에서 발송되는 이미.
- gbrain의 자체 실행 시간 내에서 dir in-process를 걸어 - 하위 처리 팬 아웃 없음.
- 명예 gbrain의 배치 크기 및 embedding 배치 조정.
- gbrain v0.31.2 가져오기 했다 501 페이지 + 2906 펑크 10 초 동안
  관찰된 달리; 느린 부분은 그것의 위 OUR per-file `gbrain put` 반복이었습니다.

### 현재 코드를 올바르게 유지해야 하는 것은

- **주문 YAML frontmatter 주입** (제목, 유형, 태그) - 보존
  .md 파일을 frontmatter로 staging dir로 작성했습니다.
- **비밀 검사** - 보존, 하지만 ONE `gitleaks detect --source <staging-dir>`로 이동
  gitleaks는 gitleaks의 gitleaks를 사용하여 gitleaks를 찾은 후, gitleaks는 gitleaks를 찾은 결과가 되도록 하였습니다.
- **Partial-transcript 검출** - 준비 단계에 보존; 부분
  파일은 여전히 frontmatter의 `partial: true` 필드를 얻습니다.
- **Unattributed-transcript 필터링** - 준비 단계에 보존.
- **파일 매시 + sha256 상태 추적** - 보존; 준비 단계
  무슨 주어진 단계, 수입 - success 결과 기록 어떤 착륙.
- **관련 제품** — `fileChangedSinceState` 체크는 정상에 체재합니다
  준비 루프.

## 마이그레이션 단계

### 단계 1: 현재 ingest 반복에서 `preparePages`를 추출하십시오

`ingestPass` (`bin/gstack-memory-ingest.ts`)에서 모든 것을 걷기와 `gbrainPutPage` 호출 사이 (라인 899-988). 새로운 기능으로 이동 `preparePages(args, ctx, state) → { staged: PreparedPage[], skipped, failed }`.

출력 : `{ slug, body, source_path, mtime_ns, sha256, partial }`의 목록은 `body`가 frontmatter를 포함한 전체 마커다운입니다.

### Step 2: dir 작가 추가

순수한 기능: `writeStaged(prepared, stagingDir) → { written, errors }`. 파일명: `${slug}.md`. Idempotent 과쓰기.

노화 dir 수명주기:
- `~/.gstack/.staging-ingest-${pid}-${ts}/`에서 생성
- `finally` 블록에서 SIGTERM
- 1개의 staging dir per ingest pass — 실행 중에도 재사용되지 않음

### 단계 3: 단 하나 gitleaks 통행

per-file `secretScanFile(path)`를 준비한 후 호출합니다. `gitleaks detect --no-git --source <staging-dir> --report-format json --report-path -`.

Parse JSON 출력, 빌드 `Map<slug, findings[]>`. 검색을 가진 파일은 가져오기 전에 staging dir에서 제거됩니다 (또는 `lib/gstack-memory-helpers.ts`에 있는 기존하는 중복 정책 당 장소에서 질화해.

### 단계 4: 단 하나 수입품 외침을 가진 `gbrainPutPage` 반복을 대체하십시오

```typescript
const importResult = spawnSync("gbrain", ["import", stagingDir], {
  stdio: ["ignore", "inherit", "inherit"],
  timeout: 30 * 60 * 1000, // generous; whole batch
});
```

`Import complete` 라인과 `failed` 카운트를 위한 파스 stdout.

### 단계 5: 부분적인 성공에 persist 국가

gbrain import report `imported=N, failed=M` 이라면 N 성공적인 슬러그를 위한 state를 저장합니다. 실패는 다음 실행을 재발하지 않도록 실패합니다. 그러나 성공은 다시하지 않습니다.

### 단계 6: SIGTERM 핸들러 `gstack-memory-ingest.ts`

안으로 `main()`를 포장하십시오:
```typescript
let interrupted = false;
const flush = () => {
  if (interrupted) return;
  interrupted = true;
  saveState(state); // best-effort flush of whatever's accumulated
  cleanupStagingDir();
  process.exit(143);
};
process.on("SIGTERM", flush);
process.on("SIGINT", flush);
```

이 무서운 버그를 독립적으로 차단 - 일괄 수입이 관현관 시간 아웃을 통해 실행되는 경우에도, 준비 단계에서의 상태는 생존.

### Step 7: 관현관 업데이트

`bin/gstack-gbrain-sync.ts:444`에서:
- `result.status === 0`를 `result.status === 0 || (parsedSummary.imported > 0 && parsedSummary.imported >= parsedSummary.skipped + parsedSummary.failed)`로 변경하십시오.
  OK로 부분적 성공 (최대 페이지 수입)을, ERR 아닙니다 대우하십시오.
- 표면 `failed_count` 및 `partial_blockers` 단계 요약에서 그래서
  user sees `Memory ... OK 487/501 imported (14 FILE_TOO_LARGE)` instead of `ERR exited null`.

### 단계 8: 특별히 취급하십시오 FILE_TOO_LARGE

gbrain가 FILE_TOO_LARGE를 보고하면, 새 `~/.gstack/.ingest-skip-list.json`로 로그인하여 다음 단계가 완전히 파일로 건너뛰는 것을 막습니다. 항상 실패할 파일 재감시를 피하십시오. 사용자는 새로운 `gstack-memory-ingest --skip-list` 플래그와 건너뛰기 목록을 검토 할 수 있습니다.

## 시험 계획

1. **단위 (무료, `bun test`에서 실행):**
   - 50 파일의 정착물 corpus에 대하여 `preparePages`: assert YAML 정확하고,
     부분 검출 작품, unattributed 필터링.
   - `writeStaged` idempotency를 덮어쓰기.
   - SIGTERM 핸들러는 아이프로세스 테스트 하네스를 사용하여 동작합니다.

2. **통합 (무료, `bun test`에서 실행):**
   - 종료 : 준비 → gitleaks → gbrain 가져 오기 온도 PGLite,
     assert page_count 일치 수입된 수.
   - 부분 교육 경로: deliberate FILE_TOO_LARGE를 주사합니다; assert
     성공은 여전히 상태, 실패는 목록 건너뛰기.
   - SIGTERM: spawn이드 ingest, 중점에서 죽일,
     재시작, assert는 국가를 재시작.

3. **벤치 마크 게이트 (기간, 지불) :**
   - 1841 파일 고정 장치에서 냉각 런 : 8 분 미만의 assert.
   - 증가 런 (변경 없음) : 60 초 미만의 주장.
   - 시험 정착물: 반복할 수 있는 타이밍을 위한 `~/.gstack/projects/` 스냅샷의 사본.

## 롤백 전략

- `--legacy-ingest` 플래그 `gstack-memory-ingest` 은 이전을 유지
  1개의 방출 주기를 위해 callable per-file 경로.
- 일괄 경로가 실제 corpus에 회귀하면 설정
  `gstack-config set memory_ingest_path legacy`는 redeploy 없이 반전합니다.
- 플래그 + 레거시 경로 확인 후 1 개의 미성년자 버전이 안정됩니다.

## 위험 및 계획 - eng-review에 대한 질문

1. **gbrain 수입 idempotency overlapping slugs.** 이전 실행 시
   slug X를 PGLite로 이전 콘텐츠로 작성한 후, `gbrain import`를 업데이트-X를 덮거나 복제할 수 있습니까? 그것을 재적으로 테스트하기 전에 테스트해야 합니다.

2. **`gbrain import` 파서 안쪽에 Frontmatter 주입.** 현재 코드
   title/type/tags를 기존 frontmatter 블록으로 주사하는 방법을 알고 (라인 794-821). `gbrain import`는 동일한 방식으로 `gbrain put`를 경청합니까? 단위 시험에서 검증하십시오.

3. **dir 디스크 압력의 안정성** 1841 파일 × avg ~50KB = ~92MB의
   staging .md 콘텐츠. dev 기계에 허용하지만 알 가치가 있습니다. 대안 : 스트림은 가져올 수있는 관형에 콘텐츠를 준비 (gbrain이 지원하는 경우) - 가능성이, V1를 무시합니다.

4. **Cross-worktree 통화.** `~/.gstack/.staging-ingest-${pid}-${ts}/`
   pid-namespaced이므로 두 개의 동시 /sync-gbrain가 콜라보레이션하지 않습니다. 그러나 관현관은 이미 `~/.gstack/.sync-gbrain.lock`에서 자물쇠를 붙였습니다. 이렇게 벨트와 스우스펜더입니다. 그것을 유지하십시오.

5. **"문자 ingest Exited null" 메시지.** 이 변화 후,
   관현악은 여전히 실제 OOM 죽이거나 SIGKILL에 status=null을 볼 수 있습니다. verdict 블록이 더 솔직히 되어야 할까요? E.g., `ERR memory: killed by signal SIGTERM at 35:00 (timeout)`.

6. **우리는 완전히 기억을 위해 `gbrain put`를 deprecate해야 합니까?** 유산
   경로는 V1.5's `put_file` 마이그레이션 계획에 존재합니다. 일괄 수입 작업으로, 우리는 여전히 광고 - 호크 섭취를위한 낙하로 한 단일 페이지가 필요합니까? 아마도 예 (`~/.gstack/.transcript-ingest-state.json` 업데이트는 관현관 밖에 방아쇠), 그러나 확인 가치가 있습니다.

## 이 아니지 않는 것

- gbrain CLI 변경이 아닙니다. 모든 일은 gstack에 있습니다.
- CLAUDE.md 음성/UX 변경.
- 새로운 사용자 인터페이스 기능. CHANGELOG 항목은 "Memory ingest
  ~10×가 빠르게 추운 실행과 중단을 살아남습니다."

## 합격 기준

- 1841 파일에 찬 `/sync-gbrain`는 8 분의 밑에 완료합니다.
- 증가 `/sync-gbrain` (파일 변경 없음)는 60 초 미만으로 완료합니다.
- SIGTERM 중간 실행 플러시 상태; 다음 실행 재시작 없이 재시작
  성공적으로 제출된 파일.
- FILE_TOO_LARGE 실패는 sync.last_commit 전진을 막지 않습니다.
- 모든 기존 테스트 설비 (transcripts, 학습, 디자인 문서, ceo-plans)
  전체 frontmatter에 올바르게 ingest.
- 부분적 성적 또는 미적 성적에 대한 회귀 없음.
