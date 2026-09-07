---
name: careful
version: 0.1.0
description: Safety guardrails for destructive commands. (gstack)
triggers:
  - be careful
  - warn before destructive
  - safety mode
allowed-tools:
  - Bash
  - Read
hooks:
  PreToolUse:
    - matcher: "Bash"
      hooks:
        - type: command
          command: "bash $HOME/.claude/skills/gstack/careful/bin/check-careful.sh"
          statusMessage: "Checking for destructive commands..."
---
<!-- AUTO-GENERATED from SKILL.md.tmpl — do not edit directly -->
<!-- Regenerate: bun run gen:skill-docs -->


## 이 기술을 호출할 때

rm -rf, DROP TABLE, force-push, git reset --hard, kubectl delete, 및 유사한 파괴적인 가동의 앞에 Warns. 사용자는 각 경고를 과도하게 할 수 있습니다. prod, 디버깅 라이브 시스템을 접촉하거나 공유한 환경에서 일할 때 사용하십시오. "be 주의" "안전 모드", "보호 모드", "보존 모드"또는 "보존 모드"에 물린 경우 사용하십시오.

# /careful - 파괴적인 명령 난간

안전 모드는 이제 **active**입니다. 모든 bash 명령은 실행하기 전에 파괴적인 패턴을 검사합니다. 파괴적인 명령이 감지되면 경고를 받게되며 진행하거나 취소할 수 있습니다.

```bash
mkdir -p ~/.gstack/analytics
echo '{"skill":"careful","ts":"'$(date -u +%Y-%m-%dT%H:%M:%SZ)'","repo":"'$(basename "$(git rev-parse --show-toplevel 2>/dev/null)" 2>/dev/null || echo "unknown")'"}'  >> ~/.gstack/analytics/skill-usage.jsonl 2>/dev/null || true
```

## 보호되는 것

| 제품 정보 | 이름 * | 위험 위험 |
|---------|---------|------|
| `rm -rf` / `rm -r` / `rm --recursive` | `rm -rf /var/data` | Recursive 삭제 |
| `DROP TABLE` / `DROP DATABASE` | `DROP TABLE users;` | 데이터 손실 |
| `TRUNCATE` | `TRUNCATE orders;` | 데이터 손실 |
| `git push --force` / `-f` | `git push -f origin main` | 관련 기사 |
| `git reset --hard` | `git reset --hard HEAD~3` | 드문 작업 손실 |
| `git checkout .` / `git restore .` | `git checkout .` | 드문 작업 손실 |
| `kubectl delete` | `kubectl delete pod` | 생산 충격 |
| `docker rm -f` / `docker system prune` | `docker system prune -a` | container/image 손실 |

## 안전 예외

이 본은 경고 없이 허용됩니다:
- `rm -rf node_modules` / `.next` / `dist` / `__pycache__` / `.cache` / `build` / `.turbo` / `coverage`

## 어떻게 작동합니까?

Hook은 도구 입력 JSON에서 명령을 읽고 위의 패턴에 대해 확인하고 `hookSpecificOutput`를 반환하고 `permissionDecision: "ask"`과 일치가 발견되면 경고 이유 (예 : 결정은 `hookSpecificOutput` - Claude Code에서 배열되어야한다. top-level `permissionDecision`). 항상 MEDIUM 경고 및 진행을 무시할 수 있습니다.

## HIGH tier (하드 데이니)

Two catastrophic shapes are **denied**, not asked: `rm -r`/`-R` of exactly `/`, `~`, or `$HOME`, and force-push to the repo's **default branch**. SIMPLE commands only (no `;`, `&&`, `||`, `|`, newline) — compound shapes fall through to the MEDIUM ask; `--force-with-lease` is never HIGH. A best-effort advisory hard-stop, not a policy boundary: the escape hatch is ending the opt-in, session-scoped /careful session.

## 프로젝트 패턴 (자유한)

warn 규칙을 추가하십시오 - 1개의 POSIX ERE 선 당, `#` 댓글 OK — `~/.gstack/careful-patterns.txt` (세계) 또는 `~/.gstack/projects/<slug>/careful-patterns.txt` (프로젝트 당). 붙박이 가족 후에 상담해, 그래서 구성은 단지 ADD 규칙만 할 수 있습니다, 지형 경고를 억압하지 않습니다. 부당한 regex 선은 건너 뛰기 입니다.

비활성화하려면 대화를 종료하거나 새로운 것을 시작합니다. Hooks는 세션이 표시됩니다.
