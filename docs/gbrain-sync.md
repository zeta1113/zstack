# GBrain 동기화를 가진 교차 기계 기억

gstack는 `~/.gstack/` - 학습, 복고풍, CEO 계획, 디자인 문서, 개발자 단면도에 유용한 국가를 많이 쓰입니다. 기본적으로, 노트북을 전환할 때 죽는 전부. **GBrain 동기화**는 개인 git repo에 curated subset를 밀어서 당신의 기억은 기계의 맞은편에 당신을 따르고 GBrain에 의해 색인을 붙이게 됩니다.

## 당신이 얻는 무엇

- 기계 A에 일, 기계 B에 이음새가 없는 픽업.
- 학습, 계획 및 설계는 GBrain (사용하면)에서 볼 수 있습니다.
- 데이터를 결코 만지지 않는 깨끗한 오프 램프 (`gstack-brain-uninstall`).
- 아무 daemon, 시스템 서비스 없음, 배경 과정 없음.

## NOT는 당신의 기계를 떠납니다

디자인에 의해, 이 체류 로컬 심지어 동기화가 켜질 때:

- 종류: `.auth.json`, `auth-token.json`, `sidebar-sessions/`,
  `security/device-salt`
- 기계 별 상태: Chromium 단면도, ONNX 모형 무게,
  캐시, eval 캐시, CDP-profile, 한 번의 프롬프트 마커 (`.welcome-seen`, `.telemetry-prompted`, `.vendoring-warned-*`, 등)
- 문제 환경: per-machine UX 환경
  (`question-preferences.json`, `question-log.jsonl`, `question-events.jsonl`).

정확한 수당은 `~/.gstack/.brain-allowlist`에 살고 있습니다. CLI는 그것을 처리합니다; 당신은 감적선의 밑에 당신의 자신의 입장을 부과할 수 있습니다.

## 첫 번째 실행 설정 (30-90 초)

```bash
gstack-artifacts-init
```

명령:

1. `~/.gstack/` git repo로 턴합니다.
2. 리모트 URL (기본값: `gh repo create --private
   gstack-artifacts-$USER`). 모든 git 리모트 작품 - GitHub, GitLab, JavaScript, 자체 호스팅.
3. config를 초기 커밋을 밀어줍니다.
4. `~/.gstack-artifacts-remote.txt` (URL-만, 비밀 없음 —
   다른 기계에 사본에 안전한).
5. 뇌 호스트의 `gbrain sources add` hookup 명령을 인쇄합니다.
   (자동 실행 - 스스로 실행, 또는 자신의 기계 `bin/gstack-gbrain-source-wireup` 동일한 배선을 수행) 그래서 `gbrain search`는 동기화 된 학습, 계획 및 디자인을 색인할 수 있습니다. 이전 `gstack-brain-reader add --ingest-url ...` HTTP 경로는 v1.15.1.0에서 제거되었다 — 그것은 `/ingest-repo` 엔드 포인트 gbrain에 의존하지 않는.

init 후, **다음 기술이 실행**는 개인 정보 보호 모드에 대해 ONE 질문을합니다.

- **모든 수당 (권장)**: 학습, 리뷰, 계획,
  디자인, 복고풍, 타임라인, 개발자 프로필 모두 동기화.
- **예술적**: 계획, 디자인, 복고풍, 학습 — Skip
  행동 데이터 (timelines, 개발자 프로필).
- **퀵메뉴**: 모든 로컬를 유지하십시오. 나중에 동기화를 나중에 다시 켜서 켤 수 있습니다
  `gstack-config set artifacts_sync_mode full`.

답변은 지속됩니다. 다시 물어볼 수 없습니다.

## Cross-machine 워크플로우

기계 A : 한 번 `gstack-artifacts-init`를 실행합니다. 즉, 모든 기술이 능숙하게 시작 및 끝 경계 (~200 ~ 800 ms 네트워크 일시 중지 기술 당)에서 동기화 큐를 배수합니다.

기계 B에:

1. Copy `~/.gstack-artifacts-remote.txt` from machine A to machine B
   (password manager, dotfile repo, USB stick - 귀하의 전화; 레거시 `~/.gstack-brain-remote.txt` 이름은 여전히 인식됩니다).
2. gstack 기술 실행. preamble은 URL 파일과 인쇄를 참조하십시오:
   ```
   BRAIN_SYNC: brain repo detected: <url>
   BRAIN_SYNC: run 'gstack-brain-restore' to pull your cross-machine memory
   ```
3. `gstack-brain-restore`를 실행하십시오. 그것은 repo를, rehydrates 당신의 복제합니다
   learnings/plans/retros, 및 git 병합 드라이버를 재등록합니다.
4. Next Skill: 어제 기계 학습 표면. 즉
   마법의 순간.

## 상태, 건강 및 대기 깊이

```bash
gstack-brain-sync --status
```

쇼: 마지막 성공적인 푸시, 보류 깊이, 어떤 동기화 블록 및 현재 개인 정보 보호 모드.

모든 기술 실행은 출력의 상단의 `BRAIN_SYNC:` 선을 인쇄합니다. 문제를 검사하십시오.

## 개인정보 보호정책

| * 이름 | 동기화 기능 |
|------|------------|
| `off` | 아무것도 (과태). |
| `artifacts-only` | 계획, 디자인, 복고풍, 학습, 리뷰. 타임 라인 + 개발자 프로필을 건너 뛰기. |
| `full` | 관할구역을 포함한 모든 수당. |

언제든지 변경 :
```bash
gstack-config set artifacts_sync_mode full
gstack-config set artifacts_sync_mode off
```

## 비밀 보호

모든 커밋은 기계가 나기 전에 압도적인 모양의 콘텐츠를 스캔합니다. 블록 패턴은 다음과 같습니다.

- AWS 접근 열쇠 (`AKIA…`)
- GitHub 토큰 (`ghp_`, `gho_`, `ghu_`, `ghs_`, `ghr_`, `github_pat_`)
- OpenAI 키 (`sk-…`)
- PEM 블록 (`-----BEGIN …-----`)
- JWTs (`eyJ…`)
- JSON (`"authorization": "…"`, `"api_key": "…"`, 등)의 Bearer 토큰

스캔이 보이지 않는 경우, 동기화 중지, 큐는 보존되고, 당신의 preamble 인쇄:

```
BRAIN_SYNC: blocked: <pattern-family>:<snippet>
```

관련 기사:

1. 파일 다운로드
2. 일치하면 명시적으로 원하는 콘텐츠에 false 긍정적입니다.
   동기화, 실행 `gstack-brain-sync --skip-file <path>` 영구적으로 그 경로 제외.
3. 그렇지 않으면, 파일을 편집하여 비밀을 제거하고 모든 기술을 다시 실행하십시오.

`~/.gstack/.git/hooks/pre-commit`에서 방어형 인 심층 걸이가 있습니다.

별도 (v1.63.0.0+), 각 푸시는 egress ledger (`~/.gstack/security/egress.jsonl`) *의 전*에 탐퍼 분명 영수증을 쓰며, 실패 닫히는 것은 실패합니다. 영수증이 작성되지 않는 경우, 푸시는 거부되며 큐는 보존됩니다. `gstack-egress list`를 가진 원장 검사하고 `gstack-egress verify`를 가진 해시 사슬을 확인합니다.

## 2 기계 충돌

기계 A 및 기계 B에 같은 날을 쓰는 경우 두 개의 부목이 투입됩니다. Git의 기본은 파일 꼬리에 충돌하지만 `.jsonl` 및 Markdown 파일은 사용자 정의 병합 드라이버에 등록됩니다.

- JSONL 파일 사용은 ISO에 의해 부과되는 분류 및 dedup 드라이버를 사용합니다.
  타임 탬프 (세터미즘을 위한 각 선의 SHA-256 해시로 돌아가십시오).
- Markdown artifacts (retros, 계획, 디자인)는 조합 병합 운전사를 이용합니다
  그 양쪽을 넓히는 것.

충돌 프롬프트를 볼 수 없습니다. (실제적인 하수인 충돌, 같은 계획 편집 두 기계와 같은), git은 멈추고 신속한.

## 크로스 머신 풀 캐비언

전진은 24시간당 `git fetch` + `git merge --ff-only`를 한 번 실행합니다. 이 생각을 하지 않아도 됩니다. — 매일 첫 번째 기술인이 자동으로 발생합니다.

역사 참고 (#2516): 매일 풀은 `~/.gstack` 자체만 재생했습니다 — NOT는 `~/.gstack-brain-worktree`에 분리된 worktree에 gbrain 실제로 색인, 그래서 뇌는 다음 설정 GBrain/sync-gbrain 실행까지 stale 페이지를 침묵하게 봉사했습니다. 이 고침부터, 매일 동기화는 또한 뇌 worktree (`gstack-gbrain-source-wireup --advance-only`, `~/.gstack/.brain-worktree-last-advance`를 통해 throttled); 대신 경고를 실패했습니다.

## 제거

```bash
gstack-brain-uninstall
```

이:

- `~/.gstack/.git/` 및 `.brain-*` 구성 파일을 제거합니다.
- `gstack-config`에서 `artifacts_sync_mode`를 지우십시오.
- NOT 학습, 계획, 복고풍, 개발자 프로필을 만드세요.

`--delete-remote`를 추가하여 GitHub를 삭제합니다. GitHub는 `gh repo delete`를 사용합니다.

`gstack-artifacts-init`를 가진 언제든지 재입력하십시오.

## 문제 해결

[gbrain-sync-errors.md](gbrain-sync-errors.md)를 참조하여 모든 오류 메시지의 인덱스를 위해 gstack-brain을 인쇄할 수 있으며 문제 / 원인 / 수정이 각각 있습니다.

## 두건 아래

이 기능 뒤에 건축 결정: denylist에 허용하는 (기본적으로 현지에 의하여 알려진 파일 체재), daemon (아기에게 배경 과정 없음)에 전방행동 sync, JSONL 병합 운전사를 결합하십시오 그래서 동시 기계는 충돌 대신에, 그리고 어떤 syncs의 앞에 한 번 요구한 개인 정보 보호 정지 문을 조합합니다.
