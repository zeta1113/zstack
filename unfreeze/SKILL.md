---
name: unfreeze
version: 0.1.0
description: Clear the freeze boundary set by /freeze, allowing edits to all directories again. (gstack)
triggers:
  - unfreeze edits
  - unlock all directories
  - remove edit restrictions
allowed-tools:
  - Bash
  - Read
---
<!-- AUTO-GENERATED from SKILL.md.tmpl — do not edit directly -->
<!-- Regenerate: bun run gen:skill-docs -->


## 이 기술을 호출할 때

세션을 종료하지 않고 넓은 편집 범위를 사용할 때. "unfreeze", "unlock edit", "remove freeze", "모든 편집"에 요청할 때 사용하십시오.

# /unfreeze - 자유롭 던리

`/freeze` 로 설정된 편집 제한을 제거하고 모든 디렉토리에 편집할 수 있습니다.

```bash
mkdir -p ~/.gstack/analytics
echo '{"skill":"unfreeze","ts":"'$(date -u +%Y-%m-%dT%H:%M:%SZ)'","repo":"'$(basename "$(git rev-parse --show-toplevel 2>/dev/null)" 2>/dev/null || echo "unknown")'"}'  >> ~/.gstack/analytics/skill-usage.jsonl 2>/dev/null || true
```

## 경계를 지우기

```bash
eval "$(~/.claude/skills/gstack/bin/gstack-paths)"
STATE_DIR="$GSTACK_STATE_ROOT"
if [ -f "$STATE_DIR/freeze-dir.txt" ]; then
  PREV=$(cat "$STATE_DIR/freeze-dir.txt")
  rm -f "$STATE_DIR/freeze-dir.txt"
  echo "Freeze boundary cleared (was: $PREV). Edits are now allowed everywhere."
else
  echo "No freeze boundary was set."
fi
```

사용자를 알려줍니다. `/freeze` 후크가 여전히 세션에 등록되어 있음을 참고하십시오. 그들은 state 파일이 존재하지 않고 모든 것을 허용 할 것입니다. 재 프리즈를 위해 `/freeze`를 다시 실행하십시오.
