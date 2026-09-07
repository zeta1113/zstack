# Spike : Claude Code 계획 - 톤 성당을위한 후크 뮤테이션

**상태:** 완료 (2026-05-27) **표면:** D10 (AUQ 입력을 mutating 허용합니까?), D19/Codex (매터는 MCP 변종을 덮어야 합니다) **Downstream 소비자:** T3, T5, T6, T8

## 이 스파이크 답변

`AskUserQuestion`에 PreToolUse 걸이는 실제로 `updatedInput`를 통해 사용자의 대답을 대체할 수 있습니까? yes가면, 정확한 의정서는 무엇입니까?

## 답변

**예.** `updatedInput`는 지원된 기계장치입니다. 근원: https://code.claude.com/docs/en/hooks (확인된 2026-04 참고).

## 후크 stdin 스키마 (PreToolUse + PostToolUse)

```json
{
  "session_id": "abc123",
  "transcript_path": "/path/to/transcript.jsonl",
  "cwd": "/current/working/dir",
  "permission_mode": "default",
  "effort": { "level": "medium" },
  "hook_event_name": "PreToolUse",
  "tool_name": "AskUserQuestion",
  "tool_input": { /* tool-specific */ },
  "tool_use_id": "unique-id-12345"
}
```

에이전트 상황에 선택: `agent_id`, `agent_type`.

## PreToolUse 걸이 stdout `allow + updatedInput`를 위한 스키마

```json
{
  "hookSpecificOutput": {
    "hookEventName": "PreToolUse",
    "permissionDecision": "allow",
    "permissionDecisionReason": "auto-decided by plan-tune preference",
    "updatedInput": { /* shallow-merged into original tool_input */ },
    "additionalContext": "optional context for Claude"
  }
}
```

**permissionDecision 값:**
- `"allow"` - `updatedInput`와 선택적으로 진행
- `"deny"` - 블록 (Claude, NOT에 먹이는 것 Codex 당 합성 대답
  D-prefixed 결정에 대한 수정)
- `"ask"` - 사용자에 대한 에스컬레이트
- `"defer"` - EXTERNAL 재개용 도구 호출을 일시 중지 (Claude Code
  v2.1.89+, a headless feature: resume with `-p --resume` to re-evaluate). NEVER emit this to mean "no opinion" — in an interactive session nothing resumes the paused call and the tool dies with "Tool result missing due to internal error" (#2035, #2006). To abstain, exit 0 with EMPTY stdout (optionally `hookSpecificOutput` with `additionalContext` only, no `permissionDecision`).

**`updatedInput` semantics:** 얕은 merge 필드의 원래 `tool_input`에 반환된 객체에 존재하는. `permissionDecision: "allow"`에서만 유효한. 이것은 우리가 `never-ask` 선호도를 위한 자동 유래된 대답을 대체하는 무슨이 이다.

## 일치자 스키마

`matcher` 필드는 `~/.claude/settings.json` JS-regex 구문 **regex metacharacters를 포함했을 때**를 지원합니다. 문자/ 밑줄만 가진 성냥자는 정확한 일치입니다.

네이티브를 다 커버하기 위해 + MCP `AskUserQuestion`:
```json
"matcher": "(AskUserQuestion|mcp__.*__AskUserQuestion)"
```

`--disallowedTools`를 통해 `AskUserQuestion`를 무능하게 하고 `mcp__conductor__AskUserQuestion`를 통해서 노선을 - MCP suffix는 우리의 걸이를 위해 거기 불을 요구됩니다.

## 다중훅 컨커런트 동굴

> 모든 일치하는 걸이는 평행한에서 실행하고, 동일한 핸들러는 입니다
> 자동 deduplicated.

**우리의 사용 케이스를 위해:**
- gstack는 정확하게 1개의 PreToolUse 걸이 및 1개의 PostToolUse 걸이를 기록합니다
  AUQ- 모양 도구 이름.
- THEIR 은 Hook을 가지고 있다면 `updatedInput` 를 반환합니다.
  AskUserQuestion, merge 순서는 정의되지 않습니다.
- Mitigation: `bin/gstack-settings-hook`에서 이 제약을 문서화
  신속한 설치. 사용자는 허용하기 전에 diff 미리보기에서 충돌을 감지 할 수 있습니다.

**`permissionDecision` 선행 (다중 걸이 결정한 때):** `deny > ask > allow > defer` - 가장 제한적인 승리.

## 구현 HookSpecificOutput 예제

**자동 변형 (PreToolUse, `never-ask` 환경 + 비 편도) :**
```json
{
  "hookSpecificOutput": {
    "hookEventName": "PreToolUse",
    "permissionDecision": "allow",
    "permissionDecisionReason": "plan-tune: never-ask preference on ship-test-failure-triage",
    "updatedInput": {
      "questions": [{ /* same as input, but with auto-selected answer */ }]
    }
  }
}
```

**Pass-through (no 선호, 또는 1방향 안전 override):** 종료 0 와 EMPTY stdout. 이 경우 주사 (계획 태니 메모리 누클), 방출 `additionalContext` WITHOUT `permissionDecision`:
```json
{
  "hookSpecificOutput": {
    "hookEventName": "PreToolUse",
    "additionalContext": "[plan-tune memory] Past answers suggest: ..."
  }
}
```
(행성주의: 이 예는 `permissionDecision: "defer"`를 방출한 AskUserQuestion를 CC v2.1.89가 'defer' 일시 정지를 위해 - #2035를 끊는 #2035를 방출했습니다.)

**PostToolUse 캡처 (알웨이) :**
```json
{
  "hookSpecificOutput": {
    "hookEventName": "PostToolUse"
  }
}
```
(PostToolUse 걸이는 또한 도구 결과에 부합하기 위하여 `additionalContext`를 놓을 수 있습니다; 우리는 v1 붙잡음을 위해 이것을 필요로 하지 않습니다.)

## PostToolUse 도구 오류 (AUQ-failure fallback, OV3:B) - UNVERIFIED

AUQ-failure prose fallback은 AskUserQuestion 호출이 오류 / 누락 된 결과를 반환 할 때, `additionalContext`가 `SESSION_KIND` 당 prose fallback을 실행하는 모델을 상기시키는 것을 `additionalContext`를 호출 할 때, 의 `additionalContext` 메커니즘을 사용합니다.

**우리가 할 수있는 질문을 열고 NOT 하네스에 정착 :**는 MCP 도구 호출이 수송/missing-result 과실 (도체벌레 표면 `[Tool result missing due to internal error]`)를 반환할 때 Claude Code invoke PostToolUse 걸이를 합니까? *의 의*에 덮개 PostToolUse의 위 docs. 우리는 그것을 관찰하기 위하여 수요에 지휘자 내부 MCP 실패를 강제할 수 있었습니다.

**결정 (OV3:B = A):**는 훅을 끊어도 어쨌든 만듭니다.
- **성공에 대한 경고** (`isErrorResponse(tool_response)`일 때만 불이 켜집니다
  true) 과 **플랫폼이 결코 잘못하지 않는 경우** 오류 경로.
- `generate-ask-user-format.ts`의 신속한 수준 fallback은 케이스를 덮습니다
  관계 없이 - 걸이는 기계장치가 아닙니다 믿을 수 있는 *layer*입니다.
- 그것의 결정 논리는 단종 deterministically 입니다
  (`test/auq-error-fallback-hook.test.ts`): 합성 오류 `tool_response`를 주었다.
  + 각 `SESSION_KIND`, 그것은 정확한 지시를 방출합니다; 진짜 대답을 그것에게 주었다
  defers.

**권장 설명서 / 부분 스파이크 (갭을 나중에 닫는) :**는 불에 로그를 치는 throwaway PostToolUse Hook을 등록하고, (a)는 정상적인 도구 오류를 트리거합니다 (예를들면 실패 `Bash` 외침)는 도구 오류에 PostToolUse 불을 모두 확인하기 위해, (b)는 지휘자 MCP AUQ 실패를 재현하고 로그를 확인합니다. (b) 불을 확인하면, "defensive/inert"에서 "verified"로 걸이를 촉진합니다. 그 후에, 턴턴턴은 턴을 보장하기 위하여, 턴을 막기 위하여 최선의 노력을 다룹니다.

## Settings.json T8 걸이 설치자를 위한 스니펫

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "(AskUserQuestion|mcp__.*__AskUserQuestion)",
        "hooks": [
          {
            "type": "command",
            "command": "$CLAUDE_PROJECT_DIR/.claude/skills/gstack/hosts/claude/hooks/question-preference-hook",
            "timeout": 5
          }
        ]
      }
    ],
    "PostToolUse": [
      {
        "matcher": "(AskUserQuestion|mcp__.*__AskUserQuestion)",
        "hooks": [
          {
            "type": "command",
            "command": "$CLAUDE_PROJECT_DIR/.claude/skills/gstack/hosts/claude/hooks/question-log-hook",
            "timeout": 5
          }
        ]
      }
    ]
  }
}
```

Hook 명령은 `bun` 후드 아래에 호출합니다. 절대 경로 (또는 `$CLAUDE_PROJECT_DIR` 대용)는 Claude Code의 후크 주자에 의해 요구됩니다. 걸이는 TypeScript 파일이 번으로 뭉치 래퍼 포탄을 그립니다.

## 구현에 대한 질문 공개

1. **추천 옵션 파싱 범위.** D2 `(recommended)`는 파스 `(recommended)`를 말한다
   먼저 라벨. 라벨은 AskUserQuestion 형식당 옵션 `label` 필드에 있습니다. 구현은 라벨 스프릭스를 찾고 `tool_input. questions[*].options[*]`를 걸어야합니다. 작업 예 : ship/SKILL.md.tmpl는 `"A) Fix now" (recommended)`와 같은 옵션을 방출합니다.

2. **자동 파생된 사건 tagging.** 걸이가 `updatedInput`를, 돌려보낼 때
   PostToolUse Hook은 해결된 입력을 보고 정상 이벤트를 기록합니다. PostToolUse payload (예 : `was_auto_decided: true`)에 추가 필드가 세션 상태 추적을 통해 설정할 수 있음을 확인해야 합니다. PreToolUse에서 `~/.gstack/sessions/<id>/.auto-decided-<tool_use_id>`의 마커 파일을 작성하고 PostToolUse에서 삭제하십시오.

3. **타임아웃 행동.** Default 걸이 운동은 60s 그러나 문서는 입니다
   timeout에서 무슨 일이 일어나는지. 명시 `timeout: 5`를 설정하면 사용자가 후크 불에 >5s를 기다릴 수 없습니다. 통과를 뒤로 폭포.

## 참고

- https://code.claude.com/docs/en/hooks (현재 2026-04 현재)
- 웹페이지 결과 2026-05-27
- `bin/gstack-settings-hook` (SessionStart-only impl, 되기 위하여
  T3 스코마웨어 재쓰기로 초소화
