---
name: freeze
version: 0.1.0
description: Restrict file edits to a specific directory for the session. (gstack)
triggers:
  - freeze edits to directory
  - lock editing scope
  - restrict file changes
allowed-tools:
  - Bash
  - Read
  - AskUserQuestion
hooks:
  PreToolUse:
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

블록 편집 및 허용 경로 밖에 쓰기. 실수로 "fixing"관련 코드를 방지하는 데 디버깅을 사용하거나, 하나의 모듈에 범위를 변경 할 때. "freeze", "restrict edit", "만 편집이 폴더"또는 "lock down edit"에 물었을 때 사용하십시오.

# /freeze - 디렉토리에 수정

특정 디렉토리에 파일을 편집합니다. 허용되는 경로 밖에 파일을 대상으로 한 모든 편집 또는 쓰기 작업은 **blocked** (만 경고되지 않음)입니다.

```bash
mkdir -p ~/.gstack/analytics
echo '{"skill":"freeze","ts":"'$(date -u +%Y-%m-%dT%H:%M:%SZ)'","repo":"'$(basename "$(git rev-parse --show-toplevel 2>/dev/null)" 2>/dev/null || echo "unknown")'"}'  >> ~/.gstack/analytics/skill-usage.jsonl 2>/dev/null || true
```

## 설치

편집을 제한하는 디렉토리를 요청합니다. AskUserQuestion를 사용하십시오.

- 질문: "어떤 디렉토리는 편집을 제한해야 합니까? 이 경로 밖에서 편집에서 차단 될 것입니다."
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

사용자를 말하십시오: "Edits는 이제 `<path>/`에 제한됩니다. 이 디렉토리 밖에서 편집하거나 쓰기가 차단됩니다. 경계를 바꾸려면 `/freeze`를 다시 실행하십시오. 제거하려면 `/unfreeze`를 실행하거나 세션을 종료하십시오."

## 어떻게 작동합니까?

Hook은 Edit/Write 도구 입력 JSON (JSON 추출기 /careful - 한 복사, 두 후크에 의해 소스), 다음 경로가 동 디렉토리로 시작했는지 확인하십시오. 그렇지 않으면, `hookSpecificOutput` 출력을 `permissionDecision: "deny"`로 반환하여 작동을 차단합니다 (`hookSpecificOutput` - Claude Code에서 제외됩니다. Claude Code는 최상위 `permissionDecision`를 무시합니다.

Polarity는 실패로 마감됩니다. Hook을 파싱할 수 없는 도구는 DENIED이고, 공개가 경계가 아닙니다. 파싱이 아니라 no `file_path` (비 파일 도구)가 허용되지 않는 한, 파싱이 허용됩니다. Symlinks는 FINAL 구성품을 통해 해결되므로 경계를 바깥으로 인바운드 symlink 포인팅이 대상에 대해 검사됩니다.

주 파일로 세션에 대한 동결 경계선. 후크 스크립트는 모든 Edit/Write invocation에 그것을 읽습니다. 공백이 포함 된 경계는 지원됩니다.

## 노트

- 동봉에 `/`를 덮는 것은 `/src`를 일치에서 `/src-old`를 방지합니다.
- 동결은 편집 및 쓰기 도구에만 적용됩니다. 읽기, Bash, Glob, Grep는 비범죄입니다.
- 이 실수로 편집을 방지, 보안 경계가 아닌 - Bash 명령은 `sed`와 같은 명령은 여전히 경계 밖에 파일을 수정할 수 있습니다.
- 비활성화하려면 `/unfreeze`를 실행하거나 대화를 종료하십시오.
