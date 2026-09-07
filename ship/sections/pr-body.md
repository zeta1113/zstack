<!-- AUTO-GENERATED from pr-body.md.tmpl — do not edit directly -->
<!-- Regenerate: bun run gen:skill-docs -->
## 단계 18: 문서 동기화 (PR 생성 전에 에이전트을 통해)

에이전트 도구를 사용하여 **에이전트으로 /document-release를 Dispatch** - 문서 릴리스가 `subagent_type: "general-purpose"`와 함께 기술 목록에 나타나더라도, 기술 도구가 결코 없습니다. 서브 에이전트은 신선한 컨텍스트 창을 가져옵니다. - 17 단계의 전진에서 0 rot. 그것은 또한 **full** `/document-release` 워크플로우 (CHANGELOG clobber 보호, doc exclusions, 위험 변화 게이트, staging, race-safe PR 바디 편집)를 실행합니다. 파견된 프롬프트는 스패딩(`GSTACK_SESSION_KIND=spawned`)으로 에이전트 세션을 표시하므로 문서 릴리스의 대화형 게이트 자동 선택은 프로세스 스탑핑 대신 권장된 옵션으로 자동 선택됩니다. 에이전트 내부의 prose-STOP는 부모의 LAST-line JSON 파시와 문서 섹션을 삭제합니다. (#2733).

**필요한 경우:** 패스 `run_in_background: false` 에이전트 호출에서 - 서브 에이전트은 BACKGROUND 로 default 로 Claude Code v2.1.198. (이 플래그 no를 더 이상 생성하는 것은 전경 실행; 그것은 명시적으로 false이어야한다.) 파견은 에이전트 도구를 통해 ONLY를 발생합니다. 기술로 목표를 불러오거나, 자신의 상황에 있는 워크플로 인라인을 실행하는 것은 WRONG이지만, 기술이 사용 가능한 스킬 목록에 나타나는 경우에도 - 신선한 컨텍스트 격리를 금지하는 인라인 실행은 이 파견이 존재하고, 명시된 플래그는 이미 에이전트 통화 블록을 만듭니다. (단계 정의는 인라인 FALLBACK, 그것은 파견된 에이전트이 실패한 후에만 적용합니다.) 단계 19는 이 에이전트의 LAST-line JSON를, 이렇게 파견해야 합니다 구획을 - 배경으로 한 파견은 전체 배 달리는 (#497, #2440: 이 종류의 제 3의 반복)를 좌초합니다. 기록 `git rev-parse HEAD`는 즉시 파견하기 전에; 회복 branch의 밑에 재조정합니다.

**공급 능력:** 이 단계는 AFTER 단계 17 (푸시)와 BEFORE 단계 19 (PR를 선택하십시오)를 달립니다. PR는 처음 몸으로 구운 `## Documentation` 단면도를 가진 마지막 HEAD에서 한 번 창조됩니다. No는 그 후에 수정한 춤을 창조합니다.

**에이전트 프롬프트:**

> You are executing the /document-release workflow after a code push, as a SPAWNED subagent: no human reads your output mid-run, and only the LAST line of your response is machine-parsed by the parent /ship session. Read the full skill file `${HOME}/.claude/skills/gstack/document-release/SKILL.md` and execute its complete workflow end-to-end as narrowed by the Scope guard below, including CHANGELOG clobber protection, doc exclusions, risky-change gates, and named staging. NOT PR체를 편집하려고 시도 - no PR는 아직 존재합니다. 지점: `<branch>`, 기초: `<base>`.
>
> 세션 표시: 기술의 골무가 `gstack-skill-start`을 실행할 때, 동일한 명령 줄 (예를들면 `GSTACK_SESSION_KIND=spawned "$_SS" --skill "document-release" ...`)에 `GSTACK_SESSION_KIND=spawned `를 가진 정확한 명령을 미리 설정한다 - bash 블록은 분리된 포탄에서 실행되므로, 이전 블록에서 내보내진 변수는 NOT persist; 접두사는 그 자체를 타고 있어야 한다. 접두는 다음 echo `SESSION_KIND: spawned`와 `SPAWNED_SESSION: true`를 실행한다.
>
> 결정 게이트: EVERY 워크플로우의 결정점 (리 스키 문서 업데이트, CHANGELOG 수정 및 음성 리쓰기, narrative contradictions, TODO 업데이트, VERSION-bump 질문, doc-review apply decisions), do NOT call AskUserQuestion and do NOT stop to 렌더링하는 prose decision short — auto-choose the RECOMMENDED-choose>-car-choose; this spa-AskUserQuestion; stop to use the use the use the use the use the use the use the use the use the use the use the use the use the use the use. no 옵션이 권장되면 가장 보수적 인 선택 (skip/defer)을 취하십시오. 파괴적 또는 비유적 옵션을 자동 선택하지 마십시오. 대신 보수적 인 비 파괴적 선택을 취하십시오. 응답 대기를 끝내지 마십시오. 마지막 JSON의 `decisions` 배열에서 1 행으로 각 자동 초원 결정이 기록됩니다. `documentation_section` (문자 public).
>
> Scope guard — docs sync ONLY: you are updating documentation, nothing else. Do NOT merge or pull the base branch, do NOT renumber versions or resolve version collisions, and do NOT change VERSION: at the workflow's VERSION gates (Step 8), choose the Skip / leave-as-is option regardless of the stated recommendation — /ship owns VERSION and derives the PR title from it; record what you would have flagged in `decisions` instead. Leave CHANGELOG.md entirely alone — the parent authored the release entry this run: skip Step 5 (voice polish) and resolve any CHANGELOG-touching gate to its leave-as-is option. Skip the "Codex Documentation Review" section entirely — the parent /ship run owns review passes. If `git push` is rejected because the remote moved (non-fast-forward), do NOT pull, merge, rebase, or force-push: leave the docs commit local, set `"pushed":false` in the final JSON, and note the rejection in `decisions` — the parent will handle it.
>
> 워크플로를 완료한 후 응답체의 기술 문서 건강 요약을 포함해, LAST LINE의 no의 no를 입력한 후, 응답체의 단일 JSON 객체를 출력한다.
> `{"files_updated":["README.md","CLAUDE.md",...],"commit_sha":"abc1234","pushed":true,"documentation_section":"<markdown block for PR body's ## Documentation section>","decisions":["<one line per auto-chosen gate>"]}`
>
> no 문서 파일이 업데이트되면, 빈 값과 동일한 모양을 출력합니다. `decisions`는 자동 조개 (빈 배열 ONLY 때 no 문 발사)를 자동 조개 (비어 있는 배열 ONLY)를 나르는 어떤 문든지 아직도 나릅니다:
> `{"files_updated":[],"commit_sha":null,"pushed":false,"documentation_section":null,"decisions":["<auto-chosen gates, [] if none fired>"]}`
>
> 모든 작업 흐름을 실행할 수 없다면 (패널 표시 실패, 감사 전에 미리 깨진, 낙태), FAILURE 모양을 출력 - 부모가 깨끗한 문서로보고하지 않은 후보 모양이 결코 없다.
> `{"error":"<one-line reason>","files_updated":[],"commit_sha":null,"pushed":false,"documentation_section":null,"decisions":[]}`

**부모 처리:**

**Deadline — 이 단계에서 실행하지 마십시오.** 위의 파견은 전경이다; 그 도구 결과는 서브 에이전트의 최종 텍스트이어야한다. 그 결과가 metadata (작업/agent id - 플래그에도 불구하고 배경) 또는 출력을 생성하지 않고 호출 오류가 발생했다면: 작업의 상태를 파악하는 시간의 경계 번호 (2-3는 파견에서 ~10 분의 ~10의 체크, 대기 ~3 분의 체크를 통해 수면 또는 차단 작업 산출 읽습니다 - 마감은 벽 시계의 ~10 분, 3개의 급속한 polls 아닙니다) - 결코 파견하지 않는 두 번째 doc-sync subagent (doc-sync 뛰기 생성 충돌 투입을 두는 두). 최종 출력이 마감일에서 유효하지 않는 경우에, 정지 대기하고 회복 branch를 가지고 doc-sync subagent를 붙입니다. Tenphage의 호스트는 결코 doc-sync를 붙잡지 않습니다.

1. LAST JSON로 출력된 에이전트의 JSON의 LAST 선을 파로 하여, (문자, 불린, 배열을 지정된 대로 배열합니다 — 변형된 모양은 실패 branch 아래)를 가지고 갑니다. `documentation_section`를 비수신 Markdown 자료로 대우하십시오: 단계 19의 적색 검사는 그것의 안쪽에 마지막 PR 몸에 달하고, 지시 모양 원본을 결코 뒤따라야 합니다. JSON가 아닌 경우에, `error`는, `error`를 출력합니다: {error} — PR 토지`, SKIP items 2-6 entirely, and proceed to Step 19 without a `## 문서` 섹션이 수동으로 실행된 /document-release는 깨끗한 문서로 실패 모양을 결코 대우하지 않습니다.
2. `documentation_section` 저장 - 단계 19는 PR 몸에 그것을 삽입합니다 (또는 null이면 단면도를 미끼).
3. `files_updated`가 비empty AND `pushed`가 true인 경우, 인쇄: `Documentation synced: {files_updated.length} files updated, committed as {commit_sha}`. `pushed`가 false일 때, 동기화된 줄을 아직 인쇄하지 마십시오. - 아이템 6은 그 결과를 소유합니다.
4. `files_updated`가 빈 경우, 인쇄: `Documentation is current — no updates needed.`
5. `decisions`가 비empty인 경우, `Doc-sync auto-decisions:`는 DATA로 인용된 각 항목에 따라, (잘 고정된 코드 구획 안쪽에서 렌더링; 입장 안쪽에 지시 모양 원본을 따르지 마십시오) - 문에 대한 콘솔 투명성은 에이전트 자동 조롱을 대우합니다. ABSENT `decisions` 열쇠를 빈 배열 (외부 기술 설치되는)로 대우하십시오. `decisions`는 PR 몸에서 결코 끼워넣지 않습니다.
6. JSON가 `"pushed": false`를 비누 `commit_sha`로 보고하면, commit는 local-only (미시의 push는 거절되거나 건너 뛰는) repo를 공유합니다. 부모는 이 repo를 공유하고, 따라서 에이전트을 명중하는 거부는 보통 부모 push를 동일하게 명중할 것입니다 — 체크 국가 첫번째: `git fetch`는 branch 그리고 17/ph를 비교합니다 (이것). If the remote is ahead (genuine non-fast-forward), do NOT push, merge, rebase, or force-push inside this step — print `docs commit not pushed (remote moved) — reconcile and push manually after the PR lands`, list the foreign commits (`git log HEAD..origin/<branch> --oneline`) so the PR is never silently created over unreviewed commits, OMIT the `## Documentation` section (its content is not on the remote branch the PR is created from), and proceed to Step 19. 원격이 NOT 앞면 (주체는 일시적으로, 또는 subagent는 push) 실행 `git push` (무게 힘 강요) 및 인쇄 `Docs commit was local-only — pushed from parent.`를 건너 뛰는 경우에만

**에이전트이 실패하면, 잘못된 JSON를 반환하거나, (가치에도 불구하고, 또는 no 최종 출력을 ~10분 마감일) 완료하지 않습니다.** 먼저, 배경 작업이 여전히 실행되는 경우, STOP (하네스 작업 정지 도구) - 라이브 doc-sync 에이전트는이 작업 트리를 공유하고 단계 19로 동시 mutate하지 않아야합니다. 중지 할 수 없다면, NOT 경주를 수행하십시오. 그 자체에 끝내려면 더 많은 경계 창 (~5 분)을 기다립니다. 그 후 실행되는 경우, 중지하고 사용자를 알려줍니다. 작업 나무의 동시 뮤테이션은 일시적으로 일시적으로 배보다 나쁘다. 그런 다음 사전 디퓨처 HEAD에 대한 재구성을 기록했습니다. HEAD가 과거에 진행된 경우, 디디링 전에 진행되는 서브 에이전트 - `git show --stat <sha>`를 가진 첫 번째 vet 각 새로운 commit를 `git show --stat <sha>`로 설정하고 문서 파일 (never VERSION, package.json, package.json 또는 <6/>, <6/>, 3개의 부모 모두 실행됩니다. commit는 조상을 밀어 넣는다. ANY new commit가 파일에 push NONE를 터치하면 콘솔 메시지에서 모든 로컬 및 이름을 붙여 넣는다. 모든 문서 전용 시퀀스만 푸시됩니다 (단력; 거부에 항목 6's second-failure branch). 그런 다음 `git status`를 실행하십시오. 실패한 실행이 끝나거나 PR를 수정하지 않은 경우 PR를 수정하지 마십시오. PR는 PR를 닫지 않습니다. if they were left staged, unstage them but NEVER discard the content (no checkout/clean) — and name them in the console message. Print `document-release did not complete — run /document-release manually after the PR lands`, then proceed to Step 19 without a `## Documentation` section. Do not block /ship on subagent failure or slowness — a missing Documentation section is recoverable after the PR lands; a stranded ship run is not. The user can run `/document-release` manually after the PR lands.

---

## 단계 19: PR/MR를 만듭니다

**Idempotency 검사:** PR/MR가 이미 이 지점에 존재하면 확인.

**GitHub:**
```bash
gh pr view --json url,number,state -q 'if .state == "OPEN" then "PR #\(.number): \(.url)" else "NO_PR" end' 2>/dev/null || echo "NO_PR"
```

**GitLab의 경우:**
```bash
glab mr view -F json 2>/dev/null | jq -r 'if .state == "opened" then "MR_EXISTS" else "NO_MR" end' 2>/dev/null || echo "NO_MR"
```

**open** PR/MR 이미 존재한다면: **update** `gh pr edit --body-file "$PR_BODY_FILE"` (GitHub) 또는 `glab mr update -d ...` (GitLab)를 사용하여 PR 몸이 존재합니다. 항상 PR 몸이 런의 신선한 결과를 사용하여 긁힘 (테스트 출력, 적용 감사, 리뷰, 청약 검토, TODOS 요약, documentation_section from Step 18). PR 이전에 내용이 실행되지 않았습니다. PR **동일한 중복 스캔 - 잉크 (PR체 + 제목)를 만들기 전에 경로 (Step 19)로 실행 - 임시 파일을 스캔 한 다음 `gh pr edit --body-file`에서.**

**REST 떨어짐 (#1079):** 일부 repo장 `gh pr edit` GraphQL deprecation 언급 `repository.pullRequest.projectCards` ("프로젝트 (클래식)는 deprecated...")입니다. `gh` GraphQL-path 문제이며, 허가 문제가 아닙니다. auth에 대한 재작업이 없습니다. REST endpoint로 돌아올 때, SAME 를 사용하여 탈선된 필드를 결코 만지지 않습니다. `PR_NUMBER=$(gh pr view --json number -q .number)` 그 다음 `gh api "repos/{owner}/{repo}/pulls/$PR_NUMBER" -X PATCH -F body=@"$PR_BODY_FILE"` 몸에 대한, 그리고 `gh api "repos/{owner}/{repo}/pulls/$PR_NUMBER" -X PATCH -f title="$NEW_TITLE"` 제목은 다음과 같은 오류를 보였다. 동일한 자동 검사와 같은 경로로 검증.

**Always update the PR title to start with `v$NEW_VERSION`.** PR 제목은 workspace-aware 형식 `v<NEW_VERSION> <type>: <summary>` - 버전 ALWAYS 첫째로, no 예외, no "custom title은 의도적으로" 탈출 해치를 사용. 공유 헬퍼 `bin/gstack-pr-title-rewrite.sh`는 규칙을 위한 진실의 단 하나 근원입니다.

1. 현재 제목을 읽으십시오: `CURRENT=$(gh pr view --json title -q .title)` (또는 `glab mr view -F json | jq -r .title`).
2. 올바른 제목을 Compute: `NEW_TITLE=$(~/.claude/skills/gstack/bin/gstack-pr-title-rewrite.sh "$NEW_VERSION" "$CURRENT")`. 돕는자는 3개의 케이스를 취급합니다: 제목은 이미 (no-op), 제목에는 다른 `v<X.Y.Z.W>` 접두사 (replace it)가, 또는 제목에는 no 버전 접두사 (prepend 하나)가 있습니다.
3. `NEW_TITLE`가 `CURRENT`와 다를 경우 `gh pr edit --title "$NEW_TITLE"` (또는 `glab mr update -t "$NEW_TITLE"`)를 실행합니다.
4. **셀프 체크:**는 제목을 재 표를 재 표를 붙이고 `v$NEW_VERSION `로 시작합니다. 그것이 아닙니다, 편집을 한 번 재기하는 경우에. 아직도 잘못되면, 사용자에 실패를 지상에 놓으십시오.

이 제목을 유지하면 단계 12의 큐 - 밀도 검출은 stale 버전을 다시 빚고, 그것을없이 생성 된 PR에 형식을 강제.

기존 URL를 인쇄하고 20단계로 계속합니다.

no PR/MR 가 존재하면 pull 요청 (GitHub) 또는 merge 요청 (GitLab) 을 단계 0 에 감지하여 만듭니다.

PR/MR 몸은 이 단면도를 포함해야 합니다:

```
## Summary
<Summarize ALL changes being shipped. Run `git log <base>..HEAD --oneline` to enumerate
every commit. Exclude the VERSION/CHANGELOG metadata commit (that's this PR's bookkeeping,
not a substantive change). Group the remaining commits into logical sections (e.g.,
"**Performance**", "**Dead Code Removal**", "**Infrastructure**"). Every substantive commit
must appear in at least one section. If a commit's work isn't reflected in the summary,
you missed it.>

## Test Coverage
<coverage diagram from Step 7, or "All new code paths have test coverage.">
<If Step 7 ran: "Tests: {before} → {after} (+{delta} new)">

## Pre-Landing Review
<findings from Step 9 code review, or "No issues found.">

## Design Review
<If design review ran: "Design Review (lite): N findings — M auto-fixed, K skipped. AI Slop: clean/N issues.">
<If no frontend files changed: "No frontend files changed — design review skipped.">

## Eval Results
<If evals ran: suite names, pass/fail counts, cost dashboard summary. If skipped: "No prompt-related files changed — evals skipped.">

## Greptile Review
<If Greptile comments were found: bullet list with [FIXED] / [FALSE POSITIVE] / [ALREADY FIXED] tag + one-line summary per comment>
<If no Greptile comments found: "No Greptile comments.">
<If no PR existed during Step 10: omit this section entirely>

## Scope Drift
<If scope drift ran: "Scope Check: CLEAN" or list of drift/creep findings>
<If no scope drift: omit this section>

## Plan Completion
<If plan file found: completion checklist summary from Step 8>
<If no plan file: "No plan file detected.">
<If plan items deferred: list deferred items>

## Linked Spec
<Auto-detect: look for /spec archives matching this branch via:
  eval "$(~/.claude/skills/gstack/bin/gstack-paths)"
  eval "$(~/.claude/skills/gstack/bin/gstack-slug)"
  CURRENT_BRANCH=$(git branch --show-current)
  SPEC_ARCHIVES="$GSTACK_STATE_ROOT/projects/$SLUG/specs"
  # Find newest archive whose spec_branch frontmatter matches current branch (or one of its
  # parents — if spec spawned worktree spec/<slug>-$$, the spawned worktree IS where /ship runs).
  SPEC_FILE=$(grep -l "^spec_branch: $CURRENT_BRANCH$" "$SPEC_ARCHIVES"/*.md 2>/dev/null | head -1)
  [ -z "$SPEC_FILE" ] && exit  # no spec; omit this section entirely
  SPEC_ISSUE=$(grep "^spec_issue_number:" "$SPEC_FILE" | cut -d' ' -f2)
  [ -z "$SPEC_ISSUE" ] && exit  # spec archive exists but no issue number; omit

  # CONDITIONAL Closes #N (codex F4): only add when Plan Completion above is "complete".
  # If the plan completion gate from Step 8 reports any deferred or failed items, emit:
  #   "Linked to #$SPEC_ISSUE (partial delivery — NOT auto-closing; close manually after follow-up)"
  # If Plan Completion is fully complete, emit:
  #   "Closes #$SPEC_ISSUE"
  # and include the Closes #N line in the PR body so GitHub auto-closes on merge.>

<Format:
  Closes #<N>

  This PR delivers the spec at <archive path relative to repo root>.
  Spec filed: <spec_filed_at from frontmatter>>

<If partial delivery, emit instead:
  Linked to #<N> (partial delivery — not auto-closing).
  Deferred items: <list from Plan Completion>.
  Close #<N> manually after follow-up lands.>

<If no /spec archive matches this branch: omit this entire section.>

## Verification Results
<If verification ran: summary from Step 8.1 (N PASS, M FAIL, K SKIPPED)>
<If skipped: reason (no plan, no server, no verification section)>
<If not applicable: omit this section>

## TODOS
<If items marked complete: bullet list of completed items with version>
<If no items completed: "No TODO items completed in this PR.">
<If TODOS.md created or reorganized: note that>
<If TODOS.md doesn't exist and user skipped: omit this section>

## Documentation
<Embed the `documentation_section` string returned by Step 18's subagent here, verbatim.>
<If Step 18 returned `documentation_section: null` (no docs updated), omit this section entirely.>

## Test plan
- [x] All Rails tests pass (N runs, 0 failures)
- [x] All Vitest tests pass (N tests)

🤖 Generated with [Claude Code](https://claude.com/claude-code)
```

#### Redaction scan (PR body + title) - AND 편집하기 전에 실행

The PR body is world-readable on a public repo. Scan-at-sink before sending: write the composed body to a temp file, scan THAT file with the shared engine, and pass the same file to `gh`/`glab`. Wrap any Codex / Greptile / eval output sections in tool-attributed fences (` ```codex-review ` / ` ```greptile `) so the engine WARN-degrades the example credentials those tools quote instead of blocking the PR (a live-format credential inside the fence still blocks).

```bash
REDACT_VIS=$(~/.claude/skills/gstack/bin/gstack-config get redact_repo_visibility 2>/dev/null)
[ -z "$REDACT_VIS" ] && REDACT_VIS=$(gh repo view --json visibility -q .visibility 2>/dev/null | tr 'A-Z' 'a-z')
REDACT_VIS="${REDACT_VIS:-unknown}"
PR_BODY_FILE=$(mktemp) || { echo "ERROR: mktemp failed — cannot scan the PR body; refusing to create the PR unscanned." >&2; exit 1; }
cat > "$PR_BODY_FILE" <<'PR_BODY_EOF'
<PR body from above>
PR_BODY_EOF
~/.claude/skills/gstack/bin/gstack-redact --from-file "$PR_BODY_FILE" --repo-visibility "$REDACT_VIS" --self-email "$(git config user.email 2>/dev/null)" --json
case $? in
  3) echo "BLOCKED — credential in PR body. Rotate + redact, do not create the PR."; exit 1 ;;
  2) echo "MEDIUM findings — confirm per finding (sterner on public) before proceeding." ;;
esac
# Also scan the title (short, single-line):
printf '%s' "v$NEW_VERSION <type>: <summary>" | ~/.claude/skills/gstack/bin/gstack-redact --repo-visibility "$REDACT_VIS" --json
```

HIGH 블록 (예를들면 3, no 건너뛰기). MEDIUM → AskUserQuestion (PII subset 제안 `--auto-redact`). `gh pr edit --body` 경로 (Step 17) 이전에 동일한 검사 실행.

**GitHub:**는 SCANNED 파일 (검사되는 바이트 = 바이트를 제외하고)에서 창조합니다. `$PR_BODY_FILE`는 위의 검사 구획에서 옵니다 — 구획이 따로따로 ran 경우에 이 포탄에서 그것을, 결코 빈 파일로 진행하지 않습니다:

```bash
# PR title MUST start with v$NEW_VERSION — enforced on every run, no exceptions.
# (See Step 19 idempotency block + bin/gstack-pr-title-rewrite.sh for the rule.)
[ -s "$PR_BODY_FILE" ] || { echo "ERROR: scanned body file missing/empty — re-run the scan block." >&2; exit 1; }
gh pr create --base <base> --title "v$NEW_VERSION <type>: <summary>" --body-file "$PR_BODY_FILE"
rm -f "$PR_BODY_FILE"
```

**GitLab의 경우:**

```bash
# MR title MUST start with v$NEW_VERSION — enforced on every run, no exceptions.
# (See Step 19 idempotency block + bin/gstack-pr-title-rewrite.sh for the rule.)
# Send the SCANNED file's bytes — scan-at-sink means never re-render the body
# from a fresh heredoc (that reopens the scan-vs-send gap). $PR_BODY_FILE comes
# from the scan block above; never proceed with an empty file.
[ -s "$PR_BODY_FILE" ] || { echo "ERROR: scanned body file missing/empty — re-run the scan block." >&2; exit 1; }
glab mr create -b <base> -t "v$NEW_VERSION <type>: <summary>" -d "$(cat "$PR_BODY_FILE")"
rm -f "$PR_BODY_FILE"
```

**CLI는 사용할 수 없는 경우:** branch 이름, 리모트 URL를 인쇄하고, PR/MR를 웹 UI를 통해 수동으로 창조하는 사용자를 지시합니다. 멈추지 마십시오 — 코드는 밀어지고 준비되어 있습니다.

**PR/MR URL 출력** — 그 후 단계 20로 진행합니다.

---
