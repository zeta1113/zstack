# gbrain-sync 오류 조회

모든 오류 메시지 `gstack-brain-*`는 문제, 원인 및 수정과 함께 인쇄 할 수 있습니다.

`BRAIN_SYNC:` 또는 명령 출력의 이진명에 의해 접두사에 의해 이 파일을 검색하십시오.

---

## `BRAIN_SYNC: brain repo detected: <url>`

**문제.** `~/.gstack-artifacts-remote.txt` (또는 다른 기계에서 복사되는 유산 `~/.gstack-brain-remote.txt`)가 있는 기계에 있습니다 그러나 no 국부적으로 git repo `~/.gstack/.git`.

**의 원인.** 당신은 다른 곳에서 GBrain 동기화하고 gstack는 이 기계에 아직 복원되지 않았습니다.

**수정.**
```bash
gstack-brain-restore
```
repo를 `~/.gstack/`로 끌어서 merge 드라이버를 재등록합니다.

당신이 여기에 복원 할 필요가 없다면, 힌트를 버려:
```bash
gstack-config set artifacts_sync_mode_prompted true
```

---

## `BRAIN_SYNC: blocked: <pattern-family>:<snippet>`

**문제.** Sync는 비밀 스캐너가 단계별 파일에 있는 credential 모양 내용을 검출하기 때문에 멈추었습니다. 큐는 보존됩니다; 아무 것도 미끄러웠습니다.

**의 원인.** 파일 내용에 일치된 사전 행동 비밀 본의 한개 - AWS 열쇠, GitHub token, OpenAI 열쇠, PEM 구획, JWT, 또는 JSON에 끼워넣은 Bearer token.

**수정 (세 가지 옵션).**

1. **진짜 비밀이 있다면**: 비밀을 제거하기 위해 오프딩 파일을 편집합니다.
   그런 다음 재 실행할 수있는 기술.

2. **패턴이 false 긍정적 인 경우** (예: 학습은 포함
   GitHub token *want*를 게시하려면 *want*를 token 패턴을 다음과 같이 정의합니다.
   ```bash
   gstack-brain-sync --skip-file <path>
   ```
   이 영구적으로 미래의 동기화에서 길을 제외합니다.

3. **이 동기화 배치를 완전히 포기하고 싶다면** (스타트 신선):
   ```bash
   gstack-brain-sync --drop-queue --yes
   ```
   이것은 커밋없이 큐를 지우지 않습니다. 미래 쓰기는 일반적으로 다시 채워질 것입니다.

---

## `BRAIN_SYNC: push failed: auth.`

**문제.** Git push는 리모트가 만료된 상태에서 auth가 누락되었기 때문에 거절되었습니다.

**의 원인.** 리모트는 현재 credentials에 불변합니다.

**수정.** auth를 원격으로 기반으로 합니다:

- **GitHub**: `gh auth status` (그 후에 `gh auth refresh` 필요하다면)
- **GitLab의**: `glab auth status`
- **의 의**: `git remote -v` + SSH 열쇠 또는 credential 돕는 사람 검사

auth를 수정한 후, 자동적으로 재try 동기화에 어떤 기술을 실행하십시오.

---

## `BRAIN_SYNC: push failed: <first-line-of-error>`

**문제.** 푸시는 오존보다 다른 이유에 실패했습니다. git의 오류의 첫 번째 라인은 식민지 이후에 나타납니다.

**의 원인.**는 네트워크 문제점, 거절될 수 있었습니다 push (전방), 서버 500, 또는 repo 접근은 재조정했습니다.

**수정.** 자세히 보기 `~/.gstack/.brain-sync-status.json`, 또는 실행:
```bash
cd ~/.gstack && git status && git push origin HEAD
```
git의 전체 오류를 볼 수 있습니다. 큐는 push 시도 후 명확하지만, 로컬 commit는 여전히 존재합니다. - 다음 기술 실행은 푸시를 다시 시도합니다.

---

## `gstack: brain-sync push NOT sent — the egress receipt could not be written`

**문제.** push는 어떤 것의 앞에 당신의 기계를 떠난다. 각 뇌sync push는 보내기 전에 egress ledger (`~/.gstack/security/egress.jsonl`)에 탐퍼 분명 영수증을, 실패 닫힙니다. 영수증은 기록될 수 없습니다, 그래서 아무것도 보내지 않았습니다, no 국부적으로 commit는, 수치는 보존됩니다 - 다음 런은 전체적인 하수구를 retries. `gstack-brain-sync --status`는 실패로 실패합니다.

**의 원인.** `~/.gstack/security/`는 writable (수입 작가가 누락될 때 그것을 창조하지 않습니다, 그래서 혼자가 원인이 아닙니다), 디스크는 가득 차거나 `GSTACK_HOME` 점에서 read-only 위치.

**수정.**
```bash
mkdir -p ~/.gstack/security && chmod -R u+w ~/.gstack/security
```
그런 다음 재발행에 기술 (또는 `gstack-brain-sync --once`)을 실행하십시오. `gstack-egress list`를 가진 ledger를 검사하십시오; `gstack-egress verify`를 가진 그것의 해시 사슬을 확인합니다.

---

## `gstack-artifacts-init: ~/.gstack/ is already a git repo pointing at: <url>`

**문제.** 기존의 것과 일치하지 않는 리모트 URL로 init하려고 합니다. 명령은 과실을 덮어주지 않습니다.

**의 원인.** 당신은 이미 다른 리모트를 가진 `gstack-artifacts-init`를 ran.

**수정.** 어느 것:

- 기존의 리모트를 사용하십시오: `--remote` 없이 `gstack-artifacts-init`, 또는 달리십시오
  일치 URL로.
- 스위치 리모트: `git -C ~/.gstack remote set-url origin <url>` (
  명령의 자신의 제안), 또는 `gstack-brain-uninstall` 먼저, 다음 새로운 URL로 재입력. 네이터는 데이터를 삭제합니다.

---

## `Remote not reachable via SSH: <url>`

**문제.** Init는 연결성을 확인하기 위해 git 리모트에 도달할 수 없었습니다.

**의 원인.** 잘못된 URL, 누락 auth, 네트워크 문제.

**수정.** 수동으로 시험하십시오:
```bash
git ls-remote <url>
```
실패한 경우, 확인:
- URL 맞춤법
- GitHub: `gh auth status`
- GitLab: `glab auth status`
- 개인 네트워크 / VPN / DNS

---

## `Failed to create or find '<name>'. Try --remote <url>.`

**문제.** `gh repo create`를 통해 자동 대포 확대 및 repo는 `gh repo view`를 통해서 발견되지 않습니다.

**의 원인.** `gh`는 이미 다른 사람에 의해 소유되는 repo와 repo, 또는 GitHub 계정이 할당량을 명중합니다.

**수정.**
```bash
gh auth status
```
unauth'd가 없다면 `gh auth login`를 실행하십시오. repo 이름은 콜드가면 다른 이름을 전달합니다.
```bash
gstack-artifacts-init --remote git@github.com:YOURUSER/custom-name.git
```

---

## `gstack-brain-restore: ~/.gstack/.git already points at <url>`

**문제.** 기존의 git config와 일치하지 않는 URL에서 복원하려고 합니다.

**의 원인.** Stale `.git` 이전 init에서 다른 리모트로.

**수정.** `gstack-brain-uninstall`, `gstack-brain-restore <url>`를 다시 실행합니다.

---

## `gstack-brain-restore: ~/.gstack/ has existing allowlisted files that would be clobbered`

**문제.** 복원하려고 하지만 `~/.gstack/` 이미 학습이나 계획이 포함되어 있습니다.

**의 원인.** 어느 쪽이든 (a)이 기계는 사전 동기화 gstack 세션에서 축적된 상태를 가지고 있거나 (b) 이전 실패한 복구는 부분 상태 왼쪽.

**수정 (세 가지 옵션).**

1. **이 기계의 상태가 새로운 진실이 된 경우에**: 실행
   `gstack-artifacts-init` 대신 복원 — 이것은 이 기계의 국가에서 상표 새로운 두뇌 repo를 창조합니다.

2. **원격 및 discard를 채택 하려는 경우이 기계의 상태를**:
   `~/.gstack/projects/`를 먼저 백업하고, 파일 및 재 실행 복원을 제거하십시오.

3. **merge를 원하면**: 이것에 대한 no 자동 merge가 있습니다. 수동으로
   `~/.gstack/`에서 이미 동기화를 가진 기계에 gstack를 실행하는 것과 같이 학습을 복사하고, 여기에서 회복하십시오.

---

## `gstack-brain-restore: <url> does not look like a gstack-brain repo`

**문제.** 클론이 성공했지만 repo는 `.brain-allowlist`와 `.gitattributes`가 누락되어 있습니다.

**의 원인.** 당신은 무작위 git repo에서 복원을 지적, 또는 누군가는 뇌의 복제 구성 파일을 삭제.

**수정.** URL를 검증합니다. 올바른 경우, `gstack-artifacts-init --remote <url>`를 실행하면 canonical config를 다시 세웁니다.

---

## 아무 것도 동기화하지만 나는 그것을 기대한다

**오류가 아니라 일반적인 gotcha.** 주문 확인:

1. `gstack-brain-sync --status` — 모드 `off`는?
2. `~/.gstack/.git`는 존재합니까?
3. `gstack-config get artifacts_sync_mode` - `full` 또는 `artifacts-only`이어야 합니다.
4. 동기화 할 것으로 예상되는 파일 - allowlist에서?
   `cat ~/.gstack/.brain-allowlist`
5. 개인 정보 보호 등급 필터 - 모드가 `artifacts-only`, 행동 파일
   (timelines, 개발자 프로파일)는 의도적으로 건너 뛰는 것입니다.

그 모든 것을 보면, 실행:
```bash
gstack-brain-sync --discover-new
gstack-brain-sync --once
```
배수를 강제로.
