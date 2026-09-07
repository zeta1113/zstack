<!-- AUTO-GENERATED from first-run-validation.md.tmpl — do not edit directly -->
<!-- Regenerate: bun run gen:skill-docs -->
## 단계 1.5 (건조한 교류): 첫번째 달리는/config 변화된 유효성

골격에 1.5의 검출이 `FIRST_RUN` 또는 `CONFIG_CHANGED` (`CONFIRMED`는 이 부분을 읽지 못하게 읽지 못합니다). 아무것도 합병되거나 배포되지 않았습니다.

**CONFIG_CHANGED:** 마지막 확인된 배치 이후 배포 구성이 변경되었습니다. 건조한 실행을 다시 트리거합니다. 사용자를 말합니다.

"나는이 프로젝트를 이전 배포했지만, 배포 구성은 마지막 시간부터 변경되었습니다. 즉 새로운 플랫폼, 다른 워크플로우 또는 업데이트 URL을 의미 할 수 있습니다. 나는 프로젝트가 배포하는 방법을 이해하는 데 빠른 건조 작업을 수행 할 것입니다."

그런 다음 FIRST_RUN 흐름을 (1.5e를 통해 1.5a를 밟으십시오).

**FIRST_RUN:** 이것은 첫번째로 `/land-and-deploy` 이 프로젝트를 위해 실행됩니다. 아무것도 할 수 없는 것을 하기 전에, 무슨 일이 일어나는지 정확하게 보여줍니다. 이것은 건조한 달리고 — 설명, 유효한, 및 확인합니다.

사용자를 말한다:

"이 프로젝트 배포 처음입니다. 그래서 나는 건조한 실행을 먼저 할 것입니다.

여기서는 다음과 같은 의미가 있습니다. 배포 인프라를 감지하고, 내 명령이 실제로 작동하고, 내가 모든 것을 터치하기 전에 단계로 정확히 무엇을 보여줍니다. 배포는 생산에 타격 할 때 결정되지 않습니다. 그래서 나는 merging을 시작하기 전에 신뢰를 적립하고 싶습니다.

설정에서 볼 수 있습니다."

## 1.5a: 인프라 탐지

배포 설정 bootstrap을 실행하여 플랫폼과 설정을 감지합니다:

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

`PERSISTED_PLATFORM` 및 `PERSISTED_URL`가 CLAUDE.md에서 발견된 경우, 수동 탐지를 직접 사용하고 건너뛰기 위하여 사용되었습니다. persisted config가 존재하지 않는 경우에, 배치 검증을 인도하기 위하여 자동 탐지 플랫폼을 이용합니다. 검출되지 않은 경우에, 결정 나무에서 AskUserQuestion를 통해 사용자를 요구하십시오.

향후 실행에 대한 persist 배포 설정에 원하는 경우, 사용자 실행 `/setup-deploy`을 제안한다.

출력 및 기록을 파: 검출된 플랫폼, 생산 URL, 워크플로우를 배치합니다. CLAUDE.md에서 모든 지속된 구성.

## 1.5b: 명령 검증

검출을 확인하기 위해 각 감지 명령을 테스트합니다. 유효성표를 만드십시오:

```bash
# Test gh auth (already passed in Step 1, but confirm)
gh auth status 2>&1 | head -3

# Test platform CLI if detected
# Fly.io: fly status --app {app} 2>/dev/null
# Heroku: heroku releases --app {app} -n 1 2>/dev/null
# Vercel: vercel ls 2>/dev/null | head -3

# Test production URL reachability
# curl -sf {production-url} -o /dev/null -w "%{http_code}" 2>/dev/null
```

어느 명령이 감지된 플랫폼에 따라 관련되어 있는지 실행하십시오. 이 테이블에 결과를 빌드하십시오.

```
╔══════════════════════════════════════════════════════════╗
║         DEPLOY INFRASTRUCTURE VALIDATION                  ║
╠══════════════════════════════════════════════════════════╣
║                                                            ║
║  Platform:    {platform} (from {source})                   ║
║  App:         {app name or "N/A"}                          ║
║  Prod URL:    {url or "not configured"}                    ║
║                                                            ║
║  COMMAND VALIDATION                                        ║
║  ├─ gh auth status:     ✓ PASS                             ║
║  ├─ {platform CLI}:     ✓ PASS / ⚠ NOT INSTALLED / ✗ FAIL ║
║  ├─ curl prod URL:      ✓ PASS (200 OK) / ⚠ UNREACHABLE   ║
║  └─ deploy workflow:    {file or "none detected"}          ║
║                                                            ║
║  STAGING DETECTION                                         ║
║  ├─ Staging URL:        {url or "not configured"}          ║
║  ├─ Staging workflow:   {file or "not found"}              ║
║  └─ Preview deploys:    {detected or "not detected"}       ║
║                                                            ║
║  WHAT WILL HAPPEN                                          ║
║  1. Run pre-merge readiness checks (reviews, tests, docs)  ║
║  2. Wait for CI if pending                                 ║
║  3. Merge PR via {merge method}                            ║
║  4. {Wait for deploy workflow / Wait 60s / Skip}           ║
║  5. {Run canary verification / Skip (no URL)}              ║
║                                                            ║
║  MERGE METHOD: {squash/merge/rebase} (from repo settings)  ║
║  MERGE QUEUE:  {detected / not detected}                   ║
╚══════════════════════════════════════════════════════════╝
```

**유효성 검사는 잠그고, BLOCKERs 아닙니다** (여기서는 이미 단계 1)에 실패한 `gh auth status`를 제외하고. `curl`가 실패한 경우에, "나는 그 URL가 네트워크 문제일지도 모르다, VPN 필요조건, 또는 잘못된 주소일지도 모릅니다. 나는 아직도 배치할 수 있을 것입니다, 그러나 나는 사이트가 건강한 afterward를 확인할 수 없을 것입니다." 플랫폼 CLI가 설치되지 않는 경우에, 주의 "{platform CLI는 이 기계에 설치되지 않습니다. GitHub를 통해 배포할 수 있지만, 배포가 작동하도록 HTTP의 건강 체크를 대신하여 CLI를 사용할 수 있습니다.

## 1.5c: 노후화 탐지

이 순서에 있는 staging 환경을 검사하십시오:

1. **CLAUDE.md persisted 구성:** 디플로이 구성 섹션에서 URL를 staging URL를 확인합니다.
```bash
grep -i "staging" CLAUDE.md 2>/dev/null | head -3
```

2. **GitHub 작업의 작업 흐름을 완화:** 이름과 내용에 "staging"를 가진 워크플로우 파일을 검사합니다.
```bash
for f in $(find .github/workflows -maxdepth 1 \( -name '*.yml' -o -name '*.yaml' \) 2>/dev/null); do
  [ -f "$f" ] && grep -qiE "staging" "$f" 2>/dev/null && echo "STAGING_WORKFLOW:$f"
done
```

3. **Vercel/Netlify 미리보기 배치:** 미리보기 URL에 대한 PR 상태 체크:
```bash
gh pr checks --json name,targetUrl 2>/dev/null | head -20
```
"vercel", "netlify", "preview"를 포함한 체크 이름을 찾아 대상 URL을 추출하십시오.

발견된 모든 시효 표적을 기록하십시오. 이들은 단계 5.에서 제안될 것입니다

## 1.5d: 읽기 미리보기

사용자를 말하십시오 : "내가 PR를 병합하기 전에 일련의 읽기 체크를 실행합니다. - 코드 리뷰, 테스트, 문서, PR 정확도. 이 프로젝트에 대해 어떻게 생겼는지 보여줍니다. "

단계 3.5에서 실행되는 읽음 검사를 미리보기 (재 실행 테스트없이) :

```bash
~/.claude/skills/gstack/bin/gstack-review-read 2>/dev/null
```

리뷰 상태 요약보기 : 리뷰가 실행 된 경우, 그들이 어떻게되는지. 또한 CHANGELOG.md 및 VERSION가 업데이트 된 경우 확인.

일반 영어에 대한 설명 : "합계 할 때, 나는 체크 할 것이다 : 코드가 최근에 검토 된? 테스트 패스를합니까? CHANGELOG 업데이트입니까? PR 설명은 정확합니까? 어떤 모습이 나면, 나는 해산하기 전에 플래그를 것입니다."

## 1.5e: 건조하 실행 확인

사용자를 말하십시오 : "그런 모든 것은 내가 감지했습니다. 위의 테이블을 살펴 보십시오. -이 경기는 실제로 프로젝트를 배포하는 방법을합니까?

AskUserQuestion를 통해 사용자에 대한 전체 건조 실행 결과를 나타냅니다.

- **재 배경:** "첫 번째는 지점 [branch]에 건조 실행을 배치합니다. 위의은 배포 인프라에 대해 감지하는 것입니다. 아무것도 합병되거나 배포되지 않았습니다. 그러나 이것은 단지 설치에 대한 이해입니다."
- 위 1.5b에서 인프라 검증 테이블을 표시합니다.
- 일반 영어 설명과 더불어 명령 유효성 검사에서 경고를 나열합니다.
- 시술이 감지되면, 참고: "나는 {url/workflow}에서 시술 환경을 발견했습니다. 우리가 합병한 후, 나는 먼저 배포할 것을 제안할 것입니다. 그래서 생산 전에 모든 작업을 확인할 수 있습니다."
- 시술이 감지되지 않은 경우, 참고: "나는 시술 환경을 찾을 수 없습니다. 배포는 생산에 곧 갈 것입니다. 나는 모든 것을 잘 본지 확인 후 건강 검사를 실행합니다."
- **RECOMMENDATION:** 모든 유효성 검사가 통과된 경우를 선택하십시오. 수정할 문제가 있는 경우 B를 선택하십시오. C를 사용하여 /setup-deploy를 더 철저한 구성으로 실행하십시오.
- A) 그게 바로 —이 프로젝트가 배포하는 방법이다. 가자. (완전성: 10/10)
- B) 뭔가 꺼짐 - 잘못되었는지 말해주십시오 (완전성: 10/10)
- C) 나는 이것을 더 주의깊게 첫째로 구성하고 싶습니다 (/setup-deploy를 달으십시오) (완전성: 10/10)

**A:** 사용자를 말하십시오: "Great — 나는이 윤곽을 저장했습니다. 다음으로 당신은 `/land-and-deploy`를 실행하고 건조 런을 건너 뛸 것입니다. 준비 체크를 읽을 수 있도록 스트레이트 실행을 건너 뛸 것입니다. 배치 설정 변경 (새로운 플랫폼, 다른 워크플로우, 업데이트 URL)이 있으면, 나는 아직도 그것을 올바르게 가지고 있는지 확인하기 위해 건조 런을 자동으로 다시 실행할 것입니다."

배포 설정 지문을 저장하므로 향후 변경 사항을 감지 할 수 있습니다.
```bash
eval "$(~/.claude/skills/gstack/bin/gstack-slug 2>/dev/null)"
mkdir -p ~/.gstack/projects/$SLUG
CURRENT_HASH=$(sed -n '/## Deploy Configuration/,/^## /p' CLAUDE.md 2>/dev/null | shasum -a 256 | cut -d' ' -f1)
WORKFLOW_HASH=$(find .github/workflows -maxdepth 1 \( -name '*deploy*' -o -name '*cd*' \) 2>/dev/null | xargs cat 2>/dev/null | shasum -a 256 | cut -d' ' -f1)
echo "${CURRENT_HASH}-${WORKFLOW_HASH}" > ~/.gstack/projects/$SLUG/land-deploy-confirmed
```
2 단계로 계속.

**B:** **STOP.** "설정에 대해 다른 것을 밝히고 조정할 것입니다. 전체 구성을 통해 `/setup-deploy`를 걷기 위해 `/setup-deploy`를 실행할 수도 있습니다."

**C:를** **STOP.** "Running `/setup-deploy`는 배치 플랫폼, 생산 URL, 건강 검사를 세부적으로 통해 걸을 것입니다. 그것은 CLAUDE.md에 모든 것을 저장합니다 그래서 나는 그 때 정확히 무슨을 알릴 것입니다. 그 행할 때 `/land-and-deploy`를 다시 실행하십시오."

---
