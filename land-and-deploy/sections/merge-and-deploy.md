<!-- AUTO-GENERATED from merge-and-deploy.md.tmpl — do not edit directly -->
<!-- Regenerate: bun run gen:skill-docs -->
## 단계 4: PR를 옮길

타이밍 데이터의 시작 타임스탬프를 기록합니다. 또한 merge 경로가 배치 보고서에 대한 (자동 - 수르지 vs direct)를 기록합니다.

Try auto-merge first (respects repo merge settings and merge queues):

```bash
gh pr merge --squash --auto --delete-branch
```

`--auto`가 성공하면 `MERGE_PATH=auto`를 기록합니다. repo는 자동 수지를 활성화하고 merge 큐를 사용할 수 있습니다.

`--auto`는 두 가지 관련 이유에 실패합니다. 둘 다 아래 직접 merge로 떨어지기 때문에 흐름은 비범죄가되지 않습니다. 그러나 "자동 - 수은 비활성화"로 두 번째를보고하지 마십시오.

1. **자동 수은 repo에 대한 사용 불가** — `Auto-merge is not allowed for this repository`.
2. **PR는 아무것도 기다리지 않습니다.** `--auto` *쿼츠* merge
   필요한 체크. 필요한 모든 체크가 이미 정착되었거나 repo 선언 no 모든 상태 체크 - GitHub는 PR를 즉시 병합하고 류큐를 거부합니다. `Pull request is in clean status` (녹색을 모두) 또는 `Pull request is in unstable status` (빨간색하지만 아무것도 필요). repo 0 필수 상태 체크를 가진 repo는 따라서 시간 no (자동)의 직접 100 % 경로가 소요되는지, 이 단계는 어떻게 어떤 단계든지 실행하기 전에, 그래서 어떤 단계든지 실행하는지.

```bash
gh pr merge --squash --delete-branch
```

merge가 성공하면 `MERGE_PATH=direct`를 기록합니다. "PR가 성공적으로 합병되었습니다. branch는 정리되었습니다."

merge는 권한 오류가 발생했습니다. **STOP.** "나는 merge이 PR에 권한이 없습니다. merge에 유지자가 필요하거나 repo의 branch 보호 규칙을 확인하십시오."

### 4a-postfail: 포스트 실패 PR-state check

**보편적인 invariant:** ANY `gh pr merge`에서 비소 출구, 재시동하거나 멈추기 전에 질의 PR 국가를 조회하십시오. NOT 재시동 `gh pr merge`를 하십시오. 관련: cli/cli#3442, cli/cli#13380.

```bash
gh pr view --json state,mergeCommit,mergedAt,mergedBy
```

**`state == "MERGED"`:**

서버 측 merge 성공 (지역 정리 단계가 실패하기 전에 완료된 경우, 또는 동시 merge 착륙). 사용자를 말합니다 : "PR는 GitHub에 병합됩니다." (NOT는 "merge 성공"라고 말합니다. 이것은 동시 대장 케이스를 처리합니다.)

캡처 merge SHA:
```bash
gh pr view --json mergeCommit -q .mergeCommit.oid
```

Squash/rebase merge readback 가드:
- **not**는 PR 머리 SHA를 요구하는 성공이 기본 branch의 조율이기 위하여 증명합니다. GitHub 돌진과 rebase는 deliberately 새로운 commit를 창조합니다, 그래서 `git merge-base --is-ancestor <head_sha> origin/<base>`는 PR가 합병될 때 실패할 수 있습니다.
- GitHub는 `state == "MERGED"`를 비누 `mergeCommit.oid`로 보고하면, 권한으로 그 대우합니다. merge SHA를 기록하고 계속하십시오.
- 로컬 클렌징 또는 읽는 것이 필요하다면 branch과 merge commit에 대한 PR branch commit와 비교 /sync를 표를 붙입니다.
```bash
BASE=$(gh pr view --json baseRefName -q .baseRefName)
MERGE_SHA=$(gh pr view --json mergeCommit -q .mergeCommit.oid)
git fetch origin "$BASE"
git diff --quiet "$MERGE_SHA" origin/"$BASE" || git log --oneline --decorate -1 "$MERGE_SHA" origin/"$BASE"
```
- worktree가 깨끗하고 만 스쿼시 merge 이후 다이빙을 중지해야 하는 경우, merge commit의 이름을 지정한 로컬 branch를, 예를 들면 `git switch -c "codex/post-merge-pr-$PR_NUMBER" "$MERGE_SHA"`를 위해 `git switch -c "codex/post-merge-pr-$PR_NUMBER" "$MERGE_SHA"`를 선택합니다. Codex 데스크탑 워크 트리에서 `git symbolic-ref --short HEAD`를 호출하여 지점을 반환하기 위해 `git symbolic-ref --short HEAD`를 기대합니다. 힘 펄시 또는 사용자 branch를 다시 놓지 마십시오.

Worktree cleanup - 비파괴, 후보자 기반:
```bash
git worktree list --porcelain
```
후보자 식별 : worktree는 기본 branch, AND (b)에서 체크 아웃하면 사용자의 현재 주요 작업 나무, AND (c) `git status --porcelain` (빈 (no uncommitted work)이 아닌 경우 stale입니다.

- 각 깨끗한 후보자 : OFFER 제거. 말 : "`<path>`에서 stale worktree가 `<branch>`에서 no로 체크 아웃되었습니다. 제거?" 사용자가 확인하는 경우에만 제거하십시오 (`git worktree remove <path> && git worktree prune`).
- 어떤 후보자가 무효한 작업이 있다면: 파일을 나열하고, 사용자를 말해, STOP worktree cleanup은 제거하지 않고.
- NOT 사용 `--force`. NOT는 사용자의 1 차적인 작동 나무를 제거합니다.

원격 브레이크 재조합 — 실패 `gh pr merge` 수행 `--delete-branch`, 그리고이 복구 경로는 침묵적으로 절반을 떨어뜨리지 않아야한다. 위의 성공 경로는 "The branch가 정리되었습니다"라고 말한다; 이 경로는 branch가 침묵하는 대신 명시적으로 명시적으로 나옵니다:

```bash
# NB: gh leaves .headRepository.nameWithOwner EMPTY (verified against gh
# 2.83); compose owner/name from headRepositoryOwner.login + headRepository.name.
gh pr view --json headRepositoryOwner,headRepository,headRefName \
  --jq '"\(.headRepositoryOwner.login)/\(.headRepository.name)\t\(.headRefName)"'
git ls-remote --heads "https://github.com/<head-repository>.git" "<head-branch>"
```

`<head-repository>` (`owner/name`)와 `<head-branch>`로 두 번째로 `git ls-remote`로 두 번째로 기록하면 됩니다. PR 머리 저장소는 저자 branch 위치: 동일한 저장소 PRs를 위해 기본 저장소입니다; 포크 PRs는 포크입니다. 체크 아웃의 `origin`를 대체하지 마십시오. 메타 데이터가 표시되면, `/`는 비명 또는 비명이 아닌 필드를 사용하지 않습니다. `/`는 `/`를 갖는 것이 아니라, `/`는 `/`를 갖는 것이 아니라, `/`를 갖는 것을 포함합니다.

세 가지 결과 - 깨끗한 branch로 실패한 체크를 읽지 마십시오.

- **0번 출구, 빈 출력** - 리모트 branch는 이미 사라집니다 (GitHub의 포스트 수탉 탈수 또는 동시 배우는 거기 가지고 갔습니다). 사용자를 말하십시오: " 먼 branch는 이미 청소되었습니다." 이것은 회복 idempotent의 재 실행합니다.
- **0번 출구, ref 선** - branch 생존: 실패 merge 명령은 `--delete-branch` 반에 도달하지 않았습니다. `<head-repository>`가 BASE 저장소인 OFFER 탈수, 체크-first (작업 트리클 업 자세를 매칭)인 경우: "리드 branch `<head-branch>`는 `<head-repository>`에 아직도 존재합니다. 실패 merge는 그 merge를 삭제하지 않습니다. `git push "https://github.com/<head-repository>.git" --delete "<head-branch>"`는 절반-branche-le-에서만 확인됩니다. `<head-repository>` 은 FORK 이며, branch 는 기여자에 속하며, 일반적으로 no push 의 권리를 가지고 있다. 대신 branch 는 기여자의 포크 `<head-repository>` 의 삶에 대한 branch 의 동일한 이름이 존재한다면, `git branch -d "<head-branch>"` 의 `git branch -d "<head-branch>"` 를 (`-d` ) 의 `<head-repository>` 를 `<head-repository>` 의 `<head-repository>` 를 갖지 않는다.
- **비소 출구** — 체크 ITSELF 실패 (네트워크, auth). 사용자를 말하십시오: "자외로 떠나는 먼 branch 국가를 검사하지 마십시오." 그리고 탈letion 제안을 전직하십시오; 실패한 체크는 불행한 국가, 청결한 branch 아닙니다.

`MERGE_PATH=direct`를 기록한 다음, §4a (CI 자동 배치 탐지)에 계속하십시오.

**`state == "OPEN"`:**

자동 수선이 활성화된지 확인:
```bash
gh pr view --json autoMergeRequest -q .autoMergeRequest
```

- 비-null: 자동-merge가 활성화되거나 merge 큐가 사용중인 경우. 오픈 상태는 예상됩니다. — §4a의 병합 대기 경로로 진행합니다.
- null: 정품 실패. 표면 모두 오류 — `gh pr merge` stderr AND 현재 PR 오픈 상태 — **STOP**.

**`state == "CLOSED"`:** PR는 수은 없이 닫혔습니다. **STOP.**

**단단한 규칙: 결코 `gh pr merge`를 두번째로 부르지 마십시오** 비 제로 출구 후. 서버 상태는 권한입니다.

### 4a: Merge 큐 검출과 메시징

`MERGE_PATH=auto`와 PR 상태가 `MERGED`가 되면 **merge 큐**가 됩니다. 사용자를 말합니다:

"당신의 repo는 merge 큐를 사용합니다. 즉 GitHub는 CI를 실제로 합병하기 전에 최종 merge commit에 더 많은 시간을 실행합니다. 이것은 좋은 일입니다 (마지막 분 충돌을 붙잡습니다), 그러나 우리가 대기합니다. 나는 그것을 통해 갈 때까지 검사를 계속할 것입니다."

PR의 merge의 오염:

```bash
gh pr view --json state -q .state
```

30 초마다 오염. 진행 상황을 표시 2 분: "merge queue... ({X}m 지금까지)"

PR 상태가 `MERGED`로 변경되면 merge commit SHA를 캡처합니다. 사용자를 말해줍니다. "Merge queue가 완성되었습니다. - PR는 합병되었습니다. Took {duration}."

If the PR is removed from the queue (state goes back to `OPEN`): **STOP.** "The PR was removed from the merge queue — this usually means a CI check failed on the merge commit, or another PR in the queue caused a conflict. Check the GitHub merge queue page to see what happened." If timeout (30 min): **STOP.** "The merge queue has been processing for 30 minutes. Something might be stuck — check the GitHub Actions tab and the merge queue page."

### 4b: CI 자동 배치 탐지

PR가 합병되면 배포 워크플로가 merge에 의해 트리거된 경우 확인:

```bash
gh run list --branch <base> --limit 5 --json name,status,workflowName,headSha
```

merge commit SHA와 일치하는 동작을 찾습니다. 배포 워크플로가 발견되면:
- 사용자를 말합니다 : "PR 병합. 배포 워크플로우 ('{workflow-name}')가 자동으로 킥을 볼 수 있습니다. 나는 모니터하고 완료되면 알려줍니다.

no 배치 작업 흐름이 merge 이후 발견되면:
- 사용자를 말하십시오: "PR 합병. 배포 워크플로우가 보이지 않습니다. 프로젝트는 다른 방법을 배포하거나 배포 단계가 아니라는 라이브러리/CLI일 수 있습니다. 다음 단계에서 올바른 검증을 파악할 수 있습니다."

`MERGE_PATH=auto` 및 repo는 merge queues AND를 배치 워크플로우가 존재합니다.
- 사용자를 말합니다 : "PR는 merge 큐를 통해 만들어졌으며 배포 워크플로가 실행됩니다. 모니터링이 이제."

merge 타임스탬프, 기간, merge 배포 보고서 경로.

---

## Step 5: 배포 전략 감지

프로젝트의 어떤 종류의 결정이 되며 배포를 확인하는 방법.

먼저, 배포 구성 부트 스트랩을 실행하거나 persisted 배포 설정을 읽으십시오.

```bash
# Check for persisted deploy config in CLAUDE.md
DEPLOY_CONFIG=$(grep -A 20 "## Deploy Configuration" CLAUDE.md 2>/dev/null || echo "NO_CONFIG")
echo "$DEPLOY_CONFIG"

# If config exists, parse it
if [ "$DEPLOY_CONFIG" != "NO_CONFIG" ]; then
  # Cut at the FIRST ": ", not the last. A greedy 's/.*: *//' ate the scheme of
  # any URL: "Production URL: https://x.com" became "//x.com", because the last
  # ":" belongs to "https:".
  PROD_URL=$(echo "$DEPLOY_CONFIG" | grep -i "production.*url" | head -1 | sed 's/^[^:]*: *//')
  PLATFORM=$(echo "$DEPLOY_CONFIG" | grep -i "platform" | head -1 | sed 's/^[^:]*: *//')
  echo "PERSISTED_PLATFORM:$PLATFORM"
  echo "PERSISTED_URL:$PROD_URL"
fi

# Auto-detect platform from config files
[ -f fly.toml ] && echo "PLATFORM:fly"
[ -f render.yaml ] && echo "PLATFORM:render"
([ -f vercel.json ] || [ -d .vercel ]) && echo "PLATFORM:vercel"
[ -f netlify.toml ] && echo "PLATFORM:netlify"
[ -f Procfile ] && echo "PLATFORM:heroku"
([ -f railway.json ] || [ -f railway.toml ]) && echo "PLATFORM:railway"

# Detect deploy workflows
for f in $(find .github/workflows -maxdepth 1 \( -name '*.yml' -o -name '*.yaml' \) 2>/dev/null); do
  [ -f "$f" ] && grep -qiE "deploy|release|production|cd" "$f" 2>/dev/null && echo "DEPLOY_WORKFLOW:$f"
  [ -f "$f" ] && grep -qiE "staging" "$f" 2>/dev/null && echo "STAGING_WORKFLOW:$f"
done
```

`PERSISTED_PLATFORM` 및 `PERSISTED_URL`가 CLAUDE.md에서 발견된 경우, 수동 탐지를 직접 사용하고 건너뛰기 위하여 사용되었습니다. no가 존재하면, 자동 탐지 플랫폼을 사용하여 배포 검증을 안내합니다. 검출되지 않은 경우, 아래 결정 트리에서 AskUserQuestion를 통해 사용자를 요청하십시오.

향후 실행에 대한 persist 배포 설정에 원하는 경우, 사용자 실행 `/setup-deploy`을 제안한다.

그런 다음 `gstack-diff-scope`를 실행하여 변경 사항을 분류합니다.

```bash
eval $(~/.claude/skills/gstack/bin/gstack-diff-scope $(gh pr view --json baseRefName -q .baseRefName 2>/dev/null || echo main) 2>/dev/null)
echo "FRONTEND=$SCOPE_FRONTEND BACKEND=$SCOPE_BACKEND DOCS=$SCOPE_DOCS CONFIG=$SCOPE_CONFIG"
```

**Decision 나무 (순서에 evaluate):**

1. user가 URL를 인수로 제공한 경우, canary 검증을 위해 사용하세요. 또한, 워크플로우를 일괄 처리할 수 있습니다.

2. GitHub 작업 배치 작업 흐름을 확인:
```bash
gh run list --branch <base> --limit 5 --json name,status,conclusion,headSha,workflowName
```
"deploy", "release", "production", "cd"를 포함하는 워크플로우 이름을 찾습니다. 발견되면, 워크플로우를 단계 6로 계산한 다음 캐시를 실행합니다.

3. SCOPE_DOCS 은 true (no frontend, no backend, no config) 의 범위입니다. 전적으로 검증된 경로를 건너 뛰십시오. 사용자를 말합니다. "이것은 docs-only change — 배포 또는 확인하지 않습니다. 모든 설정이 있습니다." 단계로 이동

4. no 배치 작업 흐름 감지 및 no URL 제공: 사용 AskUserQuestion 한 번:
   - **재 배경:** "PR는 합병되었지만, 배포 워크플로 또는 생산 URL이 프로젝트에 대해 볼 수 없습니다. 웹 앱이면 URL를 내면 배포를 확인할 수 있습니다. 라이브러리나 CLI 도구인 경우, 확인할 수 없습니다.
   - **RECOMMENDATION:** 라이브러리/CLI 도구인 경우 B를 선택하세요. 이 웹 앱이면 A를 선택하세요.
   - A) 여기서 생산 URL: {let them type}
   - B) No 배치가 필요합니다. 이것은 웹 앱이 아닙니다.

### 5a: Staging-first 선택권

staging이 Step 1.5c (또는 CLAUDE.md 배치 설정에서)에서 검출 된 경우, 변경은 코드 (docs-only)를 포함하며, staging-first 옵션을 제공합니다.

AskUserQuestion를 사용하십시오:
- **재 배경:** "나는 {staging URL 또는 워크플로에서 노후화 환경을 발견했습니다. 이 배포에는 코드 변경이 포함되어 있기 때문에, 먼저 노후화 작업에 대해 모든 작업을 확인할 수 있습니다. 이것은 가장 안전한 경로입니다. 노후화에 뭔가가 깨지면 생산이 비접촉되지 않습니다."
- **RECOMMENDATION:** 최대 안전을 위해 A를 선택하십시오. B를 선택하십시오.
- A) 먼저 시효를 하게 하고, 그 작품을 확인한 후, 생산에 가다 (완전성: 10/10)
- B) 스킵 스케이팅 - 생산에 직진 (컴플트 : 7/10)
- C) 단지를 자극하는 배포 - 나중에 생산 검사합니다 (완전성: 8/10)

**(첫째로 노화):** 사용자를 말하십시오: "첫째로 침착하기 위하여 배치. 나는 생산을 실행하는 경우에 동일한 건강 체크를 실행할 것입니다 — 좋은 시끄러운 것, 나는 생산에 자동적으로 이동할 것입니다."

단계 6-7 첫 번째 시효 목표에 대해. 시효 URL 또는 배치 검증 및 운하 검사에 대한 작업 흐름을 staging. 시효 패스 후, 사용자를 말한다: "Staging is Healthy — your changes are working. Now deploying to production." 그때 단계 6-7 생산 목표에 대한 다시.

**B (스키프 시효)를 한다면:** 사용자를 말하십시오: "Skipping staging — 생산에 곧 갑니다." 정상으로 생산 배치로 시험해.

**C (만약):** 사용자를 말하십시오: "만약을 불러오는 배포. 나는 그것을 작동하고 거기 멈추게 할 것입니다."

단계 6-7를 시효 대상에 대해. 검증 후, 배치 보고서를 인쇄 (Step 9) verdict "STAGING VERIFIED - 생산 배치 권고." 그런 다음 사용자를 알려줍니다. "Staging looks good. 생산 준비가되면 `/land-and-deploy` 다시 실행하십시오." **STOP.** 사용자는 다시 실행할 수 있습니다 `/land-and-deploy` 나중에 생산.

**no 시효가 검출된 경우:** 이 하위 단계를 완전히 건너 뛰기. No 질문은 물었다.

---
