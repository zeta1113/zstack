---
name: guard
version: 0.1.0
description: "Full safety mode: destructive command warnings + directory-scoped edits. (gstack)"
triggers:
  - full safety mode
  - guard against mistakes
  - maximum safety
allowed-tools:
  - Bash
  - Read
  - AskUserQuestion
hooks:
  PreToolUse:
    - matcher: "Bash"
      hooks:
        - type: command
          command: "bash $HOME/.claude/skills/gstack/careful/bin/check-careful.sh"
          statusMessage: "Checking for destructive commands..."
    - matcher: "Edit"
      hooks:
        - type: command
          command: "bash $HOME/.claude/skills/gstack/freeze/bin/check-freeze.sh"
          statusMessage: "Checking freeze boundary..."
    - matcher: "Write"
      hooks:
        - type: command
          command: "bash $HOME/.claude/skills/gstack/freeze/bin/check-freeze.sh"
          statusMessage: "Checking freeze boundary..."
---
<!-- AUTO-GENERATED from SKILL.md.tmpl — do not edit directly -->
<!-- Regenerate: bun run gen:skill-docs -->


## 이 기술을 호출할 때

/careful (rm -rf, DROP TABLE, force-push, etc.)를 /freeze (정확한 디렉토리 밖에서 편집을 막으십시오)와 결합하십시오. prod 또는 디버깅 살아있는 체계를 만질 때 최대 안전을 위해 사용하십시오. "guard 형태", "full safety", "lock it down", "maximum safety"에 물을 때 사용하십시오.

# /guard - 전체 안전 모드

두 개의 파괴 명령 경고와 디렉토리 복사 금지를 활성화합니다. 이것은 단일 명령에서 `/careful` + `/freeze`의 조합입니다.

**의존성 주의:** 이 기술 참조 훅 스크립트에서 sibling `/careful` 과 `/freeze` 기술 디렉터. 둘 다 설치되어야 합니다 (그들은 gstack 설정 스크립트에 의해 함께 설치됩니다).

```bash
mkdir -p ~/.gstack/analytics
echo '{"skill":"guard","ts":"'$(date -u +%Y-%m-%dT%H:%M:%SZ)'","repo":"'$(basename "$(git rev-parse --show-toplevel 2>/dev/null)" 2>/dev/null || echo "unknown")'"}'  >> ~/.gstack/analytics/skill-usage.jsonl 2>/dev/null || true
```

## 설치

편집을 제한하는 디렉토리를 요청합니다. AskUserQuestion를 사용하십시오.

- 문제: "Guard 모드: 어떤 디렉토리가 제한되어야합니까? 파괴적인 명령 경고는 항상 있습니다. 선택된 경로 이외의 파일은 편집에서 차단됩니다."
- 텍스트 입력 (다중 선택 없음) - 사용자 유형의 경로.

사용자가 디렉토리 경로를 제공하면:

1. 절대 경로에 해결:
```bash
FREEZE_DIR=$(cd "<user-provided-path>" 2>/dev/null && pwd)
echo "$FREEZE_DIR"
```

2. 트레일 슬래시를 확인하고 동결 국가 파일에 저장하십시오.
```bash
FREEZE_DIR="${FREEZE_DIR%/}/"
eval "$(~/.claude/skills/gstack/bin/gstack-paths)"
STATE_DIR="$GSTACK_STATE_ROOT"
mkdir -p "$STATE_DIR"
echo "$FREEZE_DIR" > "$STATE_DIR/freeze-dir.txt"
echo "Freeze boundary set: $FREEZE_DIR"
```

사용자를 말한다:
- "**Guard 모드 활성화.** 두 보호는 지금 실행됩니다:"
- "1. **명령 감시** — rm -rf, DROP TABLE, 힘 push, etc. warn before executing (overridable); catastrophic 모양 (/또는 ~의 반복적인 삭제, 기본 branch에 힘 push)는 열심히 던집니다"
- "2. **관련 기사** - `<path>/`에 제한된 파일 편집. 이 디렉토리 밖에 편집하면 됩니다."
- "편집을 제거하려면 `/unfreeze`를 실행하십시오. 모든 것을 비활성화하려면 세션을 종료하십시오."

## 보호되는 것

`/careful`를 참조하여, 파기 명령 패턴과 안전한 예외의 전체 목록. `/freeze`를 참조하여 경계 집행 작업을 편집합니다.
