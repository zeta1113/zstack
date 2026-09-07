# 도메인 스킬

현장 노트는 에이전트가 스스로 작성합니다. 세션 전반에 걸쳐 화합물 : 웹 사이트에 대해 비 명백한 것을 한 번, 그것은 기술을 저장하고, 그 호스트에 대한 미래 세션은 자신의 신속한 상황에 따라주의를 기울입니다.

gstack의 빌링은 [브라우저 사용/browser-harness](https://github.com/browser-use/browser-harness)입니다. gstack는 per-site-notes pattern, NOT를 자체 수정 실행 시간 패턴으로 복사합니다. 기술은 마크다운 텍스트가 프롬프트로 로드되어 있습니다. 그들은 실행할 수 없습니다.

## 에이전트 사용 방법

```bash
# Agent wrote down what it learned about a site after a successful task.
# The host is taken from the active tab automatically (no agent argument).
echo "# LinkedIn Apply Button

The Apply button on /jobs/view pages is inside an iframe with a class
matching 'jobs-apply-button-iframe'. Use \$B frame --url 'apply' first,
then snapshot." | $B domain-skill save

# See what's saved
$B domain-skill list

# Read the body of a specific host's skill
$B domain-skill show linkedin.com

# Edit interactively in $EDITOR
$B domain-skill edit linkedin.com

# Promote an active per-project skill to global (cross-project)
$B domain-skill promote-to-global linkedin.com

# Roll back a recent edit
$B domain-skill rollback linkedin.com

# Delete (tombstone — recoverable via rollback)
$B domain-skill rm linkedin.com
```

## 주된 기계

```
  ┌──────────────┐  3 successful uses        ┌────────┐  promote-to-global   ┌────────┐
  │ quarantined  │ ─────────────────────▶  │ active │ ──────────────────▶  │ global │
  │ (per-project)│  (no classifier flags)   │(project)│  (manual command)    │        │
  └──────────────┘                          └────────┘                      └────────┘
         ▲                                       │
         │  classifier flag during use           │  rollback (version log)
         └───────────────────────────────────────┘
```

**의붓기**로 새 득점 토지를 저장하고 NOT를 프롬프트에서 자동 불을 합니다. L4 ML 클래스터가 기술 콘텐츠를 주력하지 않고이 호스트에 3개의 용도가 끝난 후, 프로젝트의 **active**에 기술 자동 전문가가 되었습니다. 그 호스트 이름에 대한 모든 새로운 사이드바 에이전트 세션에 능동 기술 화재.

프로젝트 전반에 걸쳐 기술 화재를 만들기 위해 (예를 들어, "나는 모든 gstack 프로젝트에서 링크드 인 기술을 원합니다. 즉 `$B domain-skill promote-to-global <host>`를 실행합니다. 이것은 디자인 (Codex T4 외부 청구서 검토)에 의해 선택됩니다. : 비관련 작업의 맞은편에 대한 괄호 교차 프로젝트 화합물 누출.

## 저장

두 곳에서 살 수있는 기술 :

- **프로젝트**: `~/.gstack/projects/<slug>/learnings.jsonl` — JSONL와 동일
  `/learn` 기술 사용 파일. 도메인 기술은 `type:"domain"` 행입니다.
- **- 연혁**: `~/.gstack/global-domain-skills.jsonl` - `state:"global"`만
  ...

두 파일 모두 append-only JSONL입니다. 삭제를 위한 묘비; idle compactor는 파일 주기적으로 재쓰기합니다. Tolerant 파서는 읽기에 부분적인 흔적을 삭제합니다 그래서 추락 중간 쓰기는 독이 읽지 않습니다.

## 보안 모델

기술은 미래의 프롬프트 컨텍스트로 로드된 에이전트가 된 콘텐츠입니다. 그로 인해 클래식 에이전트-투-시 프롬프트-인젝션 벡터를 만듭니다. 이 플랜은 여러 레이어로 명시적으로 주소합니다.

| Layer | 이란? | 의 위치 |
|-------|------|-------|
| L1-L3 | , 숨겨지은 표창 지구, ARIA regex, URL blocklist | `content-security.ts` (이익을 얻은 바이너리) |
| L4 | TestSavantAI ONNX 클래스터 | `security-classifier.ts` (바스 에이전트, 비 컴파일) |
| L4B의 | Claude 하이쿠 성적표 | `security-classifier.ts` (바스 에이전트) |
| L5 | Canary 토큰 누출 검출 | `security.ts` |

L1-L3 체크는 **시간 절약** (다몬에서)에서 실행합니다. L4 ML classifier는 **짐 시간** (사이드바 에이전트에서)에서 실행되므로, 각 세션은 기술이 신속하게 다시 유효하게 된 내용을 불러옵니다. 이 캐치는 클래스터 모델 업데이트 후만 나타낸 문제들을 파악합니다.

저장 명령은 에이전트 인수에서 **활성 탭의 최상위 기원**에서 호스트명을 derives한다. 이것은 혼란스러워 버그 Codex 파치가 닫습니다. 악의적인 페이지 리디렉션 체인은 다른 도메인을 독소로 속임할 수 있습니다.

## 오류 참조

| Error | 의 원인 | Action |
|-------|-------|--------|
| `Save blocked: classifier flagged content as potential injection` | L4 득점 ≥ 0.85 득점 | 을 읽는 기술 제거 명령 같은 prose; 재시. |
| `Save blocked: <L1-L3 message>` | URL blocklist 일치 또는 ARIA 주사위에 저장하십시오 | 의심스러운 패턴을 위한 기술 바디를 검토. |
| `Save failed: empty body` | stdin 또는 `--from-file`를 통해 내용 없음 | `$B domain-skill save`로 파이프 마크다운, 또는 `--from-file <path>`를 통과합니다. |
| `Cannot save domain-skill: no top-level URL on active tab` | 탭은 `about:blank` 또는 `chrome://...`입니다 | `$B goto <target-site>` 첫째, 저장합니다. |
| `Cannot promote: skill is in state "quarantined"` | 기술이 아직 자동 활성화되지 않았습니다 | 이 프로젝트에서 classifier 플래그없이 3 성공적인 실행까지 사용하십시오. |
| `Cannot rollback: <host> has fewer than 2 versions` | 1개의 버전만 존재합니다 | 대신 삭제하려면 `$B domain-skill rm`를 사용하십시오. |

## 원격 측정

원격 측정이 활성화되면 (기본 `community` 모드가 꺼지지 않는), 다음 이벤트는 `~/.gstack/analytics/browse-telemetry.jsonl`로 작성됩니다.

- `domain_skill_saved {host, scope, state, bytes}`
- `domain_skill_save_blocked {host, reason}`
- `domain_skill_fired {host, source, version}`
- `domain_skill_state_changed {host, from_state, to_state}` (예정)

호스트 이름만 — 몸 내용 없음, 에이전트 텍스트 없음. `gstack-config set telemetry off` 또는 `GSTACK_TELEMETRY_OFF=1`로 완전히 비활성화.
