---
name: gstack-upgrade
version: 1.1.0
description: Upgrade gstack to the latest version.
triggers:
  - upgrade gstack
  - update gstack version
  - get latest gstack
allowed-tools:
  - Bash
  - Read
  - Write
  - AskUserQuestion
---
<!-- AUTO-GENERATED from SKILL.md.tmpl — do not edit directly -->
<!-- Regenerate: bun run gen:skill-docs -->


## 이 기술을 호출할 때

글로벌 vs 공급 업체 설치를 감지하고 업그레이드를 실행하고 새로운 것을 보여줍니다. "upgrade gstack", "update gstack", 또는 "get latest version"에 요청할 때 사용하십시오.

음성 트리거 (speech-to-text aliases) : "툴을 업그레이드", "업데이트 도구", "gee stack upgrade", "g stack upgrade"

# /gstack-upgrade

최신 버전으로 gstack을 업그레이드하고 새로운 것을 보여줍니다.

## 인라인 업그레이드 흐름

이 섹션은 `UPGRADE_AVAILABLE`를 감지할 때 모든 기술 preamble에 의해 참조됩니다.

### 단계 1: 사용자를 묻습니다 (또는 자동 업그레이드)

첫째, 자동 업그레이드가 활성화되면 확인:
```bash
_AUTO=""
[ "${GSTACK_AUTO_UPGRADE:-}" = "1" ] && _AUTO="true"
[ -z "$_AUTO" ] && _AUTO=$(~/.claude/skills/gstack/bin/gstack-config get auto_upgrade 2>/dev/null || true)
echo "AUTO_UPGRADE=$_AUTO"
```

**`AUTO_UPGRADE=true` 또는 `AUTO_UPGRADE=1`:** Skip AskUserQuestion. "Auto-upgrading gstack v{old} → v{new}..."를 로그로하고 직접 단계로 진행하십시오. `./setup`가 자동 업그레이드 중에 실패하면 백업 (`.bak` 디렉토리)에서 복원하고 사용자를 경고합니다. "자동 업그레이드 실패 — 이전 버전 복원. 다시 시도하려면 `/gstack-upgrade` 수동으로 실행하십시오."

**다른 쪽**, AskUserQuestion를 사용하십시오:
- 질문: "gstack **₢ 킹**는 (v{old})에서 유효합니다. 지금 업그레이드하십시오?"
- 옵션: ["예, 지금 업그레이드", "Always는 날짜까지 유지", "지금까지", "지금 다시 요청"]

**"예, 지금 업그레이드":** 2단계로 진행

**"Always가 날짜까지 나를 유지하십시오.":**
```bash
~/.claude/skills/gstack/bin/gstack-config set auto_upgrade true
```
사용자를 말한다: "자동 업그레이드 활성화. 미래 업데이트가 자동으로 설치됩니다." 그런 다음 단계로 진행 2.

**"지금까지:** 에스컬레이션 백오프(초청자 = 24h, second = 48h, Third+ = 1주)를 사용하여 스누즈 상태를 작성한 다음 현재 기술로 계속됩니다. 다시 업그레이드를 언급하지 마십시오.
```bash
_SNOOZE_FILE="$HOME/.gstack/update-snoozed"
_REMOTE_VER="{new}"
_CUR_LEVEL=0
if [ -f "$_SNOOZE_FILE" ]; then
  _SNOOZED_VER=$(awk '{print $1}' "$_SNOOZE_FILE")
  if [ "$_SNOOZED_VER" = "$_REMOTE_VER" ]; then
    _CUR_LEVEL=$(awk '{print $2}' "$_SNOOZE_FILE")
    case "$_CUR_LEVEL" in *[!0-9]*) _CUR_LEVEL=0 ;; esac
  fi
fi
_NEW_LEVEL=$((_CUR_LEVEL + 1))
[ "$_NEW_LEVEL" -gt 3 ] && _NEW_LEVEL=3
echo "$_REMOTE_VER $_NEW_LEVEL $(date +%s)" > "$_SNOOZE_FILE"
```
참고: `{new}`는 `UPGRADE_AVAILABLE` 출력에서 원격 버전입니다. - 업데이트 체크 결과에서 대체합니다.

사용자 스누즈 기간을 알려줍니다. "다음 24h에서 알림"(또는 48h 또는 1 주, 레벨에 따라). 팁 : "설정 `auto_upgrade: true` 자동 업그레이드를위한 `~/.gstack/config.yaml`"

**"그런 질문은 다시":**
```bash
~/.claude/skills/gstack/bin/gstack-config set update_check false
```
사용자를 말하십시오: "업데이트 체크 비활성화. 재 활성화하려면 `~/.claude/skills/gstack/bin/gstack-config set update_check true`를 실행하십시오." 현재 기술로 계속하십시오.

### Step 2: 설치 유형 검출

```bash
if [ -d "$HOME/.claude/skills/gstack/.git" ]; then
  INSTALL_TYPE="global-git"
  INSTALL_DIR="$HOME/.claude/skills/gstack"
elif [ -d "$HOME/.gstack/repos/gstack/.git" ]; then
  INSTALL_TYPE="global-git"
  INSTALL_DIR="$HOME/.gstack/repos/gstack"
elif [ -d ".claude/skills/gstack/.git" ]; then
  INSTALL_TYPE="local-git"
  INSTALL_DIR=".claude/skills/gstack"
elif [ -d ".agents/skills/gstack/.git" ]; then
  INSTALL_TYPE="local-git"
  INSTALL_DIR=".agents/skills/gstack"
elif [ -d ".claude/skills/gstack" ]; then
  INSTALL_TYPE="vendored"
  INSTALL_DIR=".claude/skills/gstack"
elif [ -d "$HOME/.claude/skills/gstack" ]; then
  INSTALL_TYPE="vendored-global"
  INSTALL_DIR="$HOME/.claude/skills/gstack"
else
  echo "ERROR: gstack not found"
  exit 1
fi
echo "Install type: $INSTALL_TYPE at $INSTALL_DIR"
```

위의 출력 유형과 디렉토리 경로가 모든 후속 단계에서 사용됩니다.

### Step 3: 오래된 버전을 저장하십시오

Step 2의 출력에서 설치 디렉토리를 사용하십시오.

```bash
OLD_VERSION=$(cat "$INSTALL_DIR/VERSION" 2>/dev/null || echo "unknown")
```

### 단계 4: 향상

단계 2에서 검출된 설치 유형 및 디렉토리를 사용하십시오:

**git installs에 대한** (글로벌 git, 로컬 git):

빠른 대면 (#2517) - 동일한 정책 세션 업데이트 자동 업그레이드 사용. `--autostash`는 당국 편집을 수행; 렌더링 지문 먼지는 regenerable과 독 스 스 스쿼시이기 때문에 먼저 버려집니다 (#2569):
```bash
cd "$INSTALL_DIR"
# Discard render-footprint dirt (#2569): pre-v1.67 gbrain-enabled installs
# ran gen:skill-docs:user IN PLACE, leaving generated SKILL.md / sections
# files permanently modified. They are regenerable (setup re-renders to
# ~/.gstack/render), so discarding is lossless.
git checkout -- 'SKILL.md' '*/SKILL.md' '*/sections/*.md' 2>/dev/null || true
git fetch origin
git pull --ff-only --autostash origin main && ./setup && echo "FF_OK"
```

출력이 `FF_OK`로 끝나면, 업그레이드가 완료됩니다. - 아래에서 fallback을 건너 뛰십시오.

**Fallback (ff-only 거부 - 지역 커밋 또는 다이버그런스).** `git reset --hard` DESTROYS 것들: 지방을 끊지 않는 깨끗한 나무는 여전히 그 커밋을 잃습니다. 그것을 문 (#2517):

1. `git status --porcelain`와 `git rev-list origin/main..HEAD --oneline`를 실행하십시오
   `$INSTALL_DIR`에서.
2. BOTH가 비어 있는 경우, 리셋은 유연하게 안전합니다 — fallback 구획을 달립니다
   요청없이 아래.
3. 그렇지 않으면 AskUserQuestion (편도 문 - 파괴), 목록으로 요청
   정확히 무슨 일이 나타날 것 이다: 각 더러운 파일과 각 unpushed 커맨드에 의해 하향 + 주제. 옵션: **A)** 그들을 흩어지고 (리셋) - 명시된 문자를 필요로; **B) (아)** 업그레이드를 압수 그래서 사용자는 자신의 작업을 먼저 구출 할 수 (국적 커맨드가 존재하는 경우). 결코 vague 대답에 진행.

```bash
cd "$INSTALL_DIR"
STASH_OUTPUT=$(git stash 2>&1)
git reset --hard origin/main
./setup
```
`$STASH_OUTPUT` 에는 "Saved working directory"가 포함되어 있으며, 사용자가 경고합니다. "주의: 로컬 변경은 stashed (모든 수정 된 생성 된 SKILL.md/sections 파일은 먼저 삭제되었습니다. - 설정에서 재생). 기술 디렉토리에서 `git stash pop` 을 실행하여 자신의 변경을 복원합니다."

**공급 업체의 설치** (선명, 납품상):
```bash
PARENT=$(dirname "$INSTALL_DIR")
# A stale .bak from a previously crashed upgrade would make the mv below NEST
# the live install inside it and the failure-restore arm would "restore" the
# stale backup. It may also be the only good copy from that crashed run —
# abort and let the human inspect, never delete it silently.
[ -e "$INSTALL_DIR.bak" ] && { echo "ERROR: stale backup exists at $INSTALL_DIR.bak (from a previous failed upgrade?) — inspect it, salvage/remove it, then re-run." >&2; exit 1; }
TMP_DIR=$(mktemp -d) || { echo "ERROR: mktemp failed — aborting upgrade (install untouched)." >&2; exit 1; }
git clone --depth 1 https://github.com/garrytan/gstack.git "$TMP_DIR/gstack" || { echo "ERROR: clone failed — aborting upgrade (install untouched)." >&2; rm -rf "$TMP_DIR"; exit 1; }
mv "$INSTALL_DIR" "$INSTALL_DIR.bak"
if mv "$TMP_DIR/gstack" "$INSTALL_DIR"; then
  cd "$INSTALL_DIR" && ./setup
  rm -rf "$INSTALL_DIR.bak" "$TMP_DIR"
else
  mv "$INSTALL_DIR.bak" "$INSTALL_DIR"
  echo "ERROR: swap failed — previous install restored; upgrade aborted." >&2
  rm -rf "$TMP_DIR"
  exit 1
fi
```

### Step 4.5: 현지 공급 업체 사본을 취급

Step 2.에서 설치 디렉토리를 사용하여 로컬 공급 업체 사본이 있는지 확인하고 팀 모드가 활성화되는지 확인하십시오.

```bash
_ROOT=$(git rev-parse --show-toplevel 2>/dev/null)
LOCAL_GSTACK=""
if [ -n "$_ROOT" ] && [ -d "$_ROOT/.claude/skills/gstack" ]; then
  _RESOLVED_LOCAL=$(cd "$_ROOT/.claude/skills/gstack" && pwd -P)
  _RESOLVED_PRIMARY=$(cd "$INSTALL_DIR" && pwd -P)
  if [ "$_RESOLVED_LOCAL" != "$_RESOLVED_PRIMARY" ]; then
    LOCAL_GSTACK="$_ROOT/.claude/skills/gstack"
  fi
fi
_TEAM_MODE=$(~/.claude/skills/gstack/bin/gstack-config get team_mode 2>/dev/null || echo "false")
echo "LOCAL_GSTACK=$LOCAL_GSTACK"
echo "TEAM_MODE=$_TEAM_MODE"
```

**`LOCAL_GSTACK`가 비empty AND `TEAM_MODE`가 `true`인 경우:** 공급 업체 사본을 제거하십시오. 팀 모드는 글로벌이 진실의 단일 소스로 설치합니다.

```bash
cd "$_ROOT"
git rm -r --cached .claude/skills/gstack/ 2>/dev/null || true
if ! grep -qF '.claude/skills/gstack/' .gitignore 2>/dev/null; then
  echo '.claude/skills/gstack/' >> .gitignore
fi
rm -rf "$LOCAL_GSTACK"
```
사용자를 말하십시오: "`$LOCAL_GSTACK` (팀 모드 활성화 - 글로벌 설치는 진실의 근원입니다)에 납품업자 사본을 제거했습니다. 준비할 때 `.gitignore` 변화를 올립니다."

**`LOCAL_GSTACK`는 비empty AND `TEAM_MODE`는 NOT `true`입니다:** 새로 업그레이드된 기본 설치에서 복사하여 업데이트하십시오. (README 공급 업체 설치로 동일한 접근):
```bash
mv "$LOCAL_GSTACK" "$LOCAL_GSTACK.bak"
cp -Rf "$INSTALL_DIR" "$LOCAL_GSTACK"
rm -rf "$LOCAL_GSTACK/.git"
cd "$LOCAL_GSTACK" && ./setup
rm -rf "$LOCAL_GSTACK.bak"
```
사용자를 말하십시오: "Also는 `$LOCAL_GSTACK`에서 납품업자 사본을 업데이트했습니다. `.claude/skills/gstack/`를 준비할 때 "

`./setup`가 실패하면 백업에서 복원하고 사용자를 경고합니다.
```bash
rm -rf "$LOCAL_GSTACK"
mv "$LOCAL_GSTACK.bak" "$LOCAL_GSTACK"
```
사용자를 말하십시오: "Sync failed — `$LOCAL_GSTACK`에서 이전 버전을 복원했습니다. `/gstack-upgrade`를 다시 재발행하기 위해 수동으로 실행하십시오."

### Step 4.75: 버전 마이그레이션 실행

`./setup`가 완료된 후, 이전 버전과 새 버전 사이의 버전의 마이그레이션 스크립트를 실행합니다. 미그레이션 핸들 state는 `./setup`가 혼자 커버 할 수 없습니다 (숨겨진 설정, 또는판된 파일, 디렉토리 구조 변경).

```bash
MIGRATIONS_DIR="$INSTALL_DIR/gstack-upgrade/migrations"
if [ -d "$MIGRATIONS_DIR" ]; then
  for migration in $(find "$MIGRATIONS_DIR" -maxdepth 1 -name 'v*.sh' -type f 2>/dev/null | sort -V); do
    # Extract version from filename: v0.15.2.0.sh → 0.15.2.0
    m_ver="$(basename "$migration" .sh | sed 's/^v//')"
    # Run if this migration version is newer than old version
    # (simple string compare works for dotted versions with same segment count)
    if [ "$OLD_VERSION" != "unknown" ] && [ "$(printf '%s\n%s' "$OLD_VERSION" "$m_ver" | sort -V | head -1)" = "$OLD_VERSION" ] && [ "$OLD_VERSION" != "$m_ver" ]; then
      echo "Running migration $m_ver..."
      # GSTACK_INSTALL_DIR: migrations that clean the INSTALL (not just
      # ~/.gstack state) default to ~/.claude/skills/gstack when unset —
      # a repo-local install would silently no-op without this.
      GSTACK_INSTALL_DIR="$INSTALL_DIR" bash "$migration" || echo "  Warning: migration $m_ver had errors (non-fatal)"
    fi
  done
fi
```

마이그레이션은 `gstack-upgrade/migrations/`의 idempotent bash 스크립트입니다. 각 이름은 `v{VERSION}.sh`이며, 이전 버전에서 업그레이드 할 때만 실행됩니다. CONTRIBUTING.md를 참조하여 새로운 마이그레이션을 추가하는 방법을 참조하십시오.

### 단계 4.8: 어떤 stale daemon를 멈추십시오 (조건)

검색 daemon 시작 전에 업그레이드는 OLD 이진의 코드를 중지까지 유지 - 그것은 살아남기 때문에 `git reset --hard` 그리고 `./setup` 실행 프로세스는 이전 실행 가능한 (#2551)를 보유. 항상이 단계를 실행, 설치 디렉토리를 사용하여 단계 2.

```bash
INSTALL_DIR_PLACEHOLDER="<install dir from Step 2>"
NEW_HASH=$(cat "$INSTALL_DIR_PLACEHOLDER/browse/dist/.version" 2>/dev/null || echo "")
_STATE_FILE="${BROWSE_STATE_FILE:-$(git rev-parse --show-toplevel 2>/dev/null || pwd)/.gstack/browse.json}"
if [ -z "$NEW_HASH" ] || [ ! -f "$_STATE_FILE" ]; then
  echo "DAEMON_CHECK=none (no state file or no fresh build hash)"
else
  DAEMON_PID=$(sed -n 's/.*"pid"[[:space:]]*:[[:space:]]*\([0-9][0-9]*\).*/\1/p' "$_STATE_FILE" | head -1)
  DAEMON_PORT=$(sed -n 's/.*"port"[[:space:]]*:[[:space:]]*\([0-9][0-9]*\).*/\1/p' "$_STATE_FILE" | head -1)
  OLD_HASH=$(sed -n 's/.*"binaryVersion"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' "$_STATE_FILE" | head -1)
  if [ -z "$DAEMON_PID" ] || ! kill -0 "$DAEMON_PID" 2>/dev/null; then
    echo "DAEMON_CHECK=dead (no live daemon to stop)"
  elif [ "$OLD_HASH" = "$NEW_HASH" ]; then
    echo "DAEMON_CHECK=current (daemon already runs the new binary)"
  elif curl -fsS --max-time 2 "http://127.0.0.1:$DAEMON_PORT/health" 2>/dev/null | grep -q '"status":"healthy"'; then
    echo "DAEMON_CHECK=stale-responsive pid=$DAEMON_PID hash=${OLD_HASH:-unknown} -> $NEW_HASH"
    "$INSTALL_DIR_PLACEHOLDER/browse/dist/browse" stop && echo "DAEMON_STOPPED=yes"
  else
    echo "DAEMON_CHECK=stale-busy pid=$DAEMON_PID hash=${OLD_HASH:-unknown} -> $NEW_HASH"
  fi
fi
```

`<install dir from Step 2>`를 실행하기 전에 실제 설치 디렉토리로 바꾸십시오. `DAEMON_CHECK` 결과를 해석하십시오:

1. **`stale-responsive` + `DAEMON_STOPPED=yes`:** 사용자에게 "정지
   오래된 검색 daemon (binary {OLD_HASH} → {NEW_HASH}). 다음 검색 명령은 새로운 바이너리에 신선한 데몬을 시작합니다.
2. **`stale-busy`:** 데몬은 오래된 바이너리를 실행하지만 중간 작업 - DEFER
   그것은, 업그레이드 중 바쁜 데몬을 죽일 수 없습니다. "A search daemon is still running pre-upgrade binary ({OLD_HASH} → {NEW_HASH}) 하지만 지금 바로 바쁘다. 그것은 완료하면, `browse stop`로 중지하거나 `browse --force-restart stop` ( 세션 tabs/cookies/logins)."로 즉시 강제하십시오.
3. **`none` / `dead` / `current`:** 아무것도 할 수 없습니다. — 아무것도 말하지 않습니다.

### 단계 5: 글쓰기 마커 + 캐시

```bash
mkdir -p ~/.gstack
echo "$OLD_VERSION" > ~/.gstack/just-upgraded-from
rm -f ~/.gstack/last-update-check
rm -f ~/.gstack/update-snoozed
```

### 단계 6: 새로운 것의 쇼

`$INSTALL_DIR/CHANGELOG.md`를 읽으십시오. 이전 버전과 새로운 버전 사이의 모든 버전 항목을 찾으십시오. 테마로 분류 된 5-7 개의 총알로 요약하십시오. 압도적 인 것은 아니지만 사용자의 변화에 중점을 둡니다. 중요한 것은 아닙니다.

체재:
```
gstack v{new} — v{old}에서 업그레이드되었습니다!

새로운 내용:
- [bullet 1]
- [bullet 2]
- ...

즐겁게 ship하세요!
```

### 단계 7: 계속

새로운 것을 보여주는 후, 어떤 기술이 사용자를 원래 호출하는 것을 계속. 업그레이드는 완료되지 않습니다 - 더 이상 작업이 필요하지 않습니다.

---

## 독립 사용법

`/gstack-upgrade` (예를 들면)로 직접 호출 할 때:

1. 신선한 업데이트 체크를 강제하십시오 (암호 캐시):
```bash
~/.claude/skills/gstack/bin/gstack-update-check --force 2>/dev/null || \
.claude/skills/gstack/bin/gstack-update-check --force 2>/dev/null || true
```
출력을 사용하여 업그레이드가 가능하면 결정합니다.

2. `UPGRADE_AVAILABLE <old> <new>`: 단계 2-6를 위 따르십시오.

3. 출력이 없다면 (기본은 현재까지): stale 현지 공급 업체 사본을 확인.

단계 2 버쉬 블록을 실행하여 기본 설치 유형과 디렉토리 (`INSTALL_TYPE` 및 `INSTALL_DIR`)를 감지합니다. 그런 다음 단계 4.5 검출 버쉬 블록을 실행하여 로컬 공급 업체 사본 (`LOCAL_GSTACK`) 및 팀 모드 상태 (`TEAM_MODE`)를 확인합니다.

**`LOCAL_GSTACK`가 비어 있는 경우** (국적 공급 업체 사본 없음): 사용자 "당신은 최신 버전 (v{version})에 이미 있습니다."

**`LOCAL_GSTACK`가 비empty AND `TEAM_MODE`가 `true`인 경우:** 위의 단계 4.5 팀 모드 제거 버쉬 블록을 사용하여 공급 업체 사본을 제거하십시오. "Global v{version}는 최신 상태로 유지됩니다. stale 공급 업체 사본 제거 (팀 모드 활성화). 준비 될 때 `.gitignore` 변경을 시작합니다.

**`LOCAL_GSTACK`는 비empty AND `TEAM_MODE`는 NOT `true`입니다**, 비교 버전:
```bash
PRIMARY_VER=$(cat "$INSTALL_DIR/VERSION" 2>/dev/null || echo "unknown")
LOCAL_VER=$(cat "$LOCAL_GSTACK/VERSION" 2>/dev/null || echo "unknown")
echo "PRIMARY=$PRIMARY_VER LOCAL=$LOCAL_VER"
```

**버전이 다릅니다:**는 단계 4.5 sync bash 블록을 따라 1 차에서 로컬 복사를 업데이트합니다. "Global v{PRIMARY_VER}는 최신 상태로 제공됩니다. v{LOCAL_VER} → v{PRIMARY_VER}에서 로컬 공급 업체 사본을 업데이트하십시오. 준비되면 `.claude/skills/gstack/`를 시작합니다.

**버전 일치시:**는 사용자 "최신 버전 (v{PRIMARY_VER})에 있습니다. 글로벌 및 로컬 공급업체 사본은 모두 최신 버전입니다."
