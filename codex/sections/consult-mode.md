<!-- AUTO-GENERATED from consult-mode.md.tmpl — do not edit directly -->
<!-- Regenerate: bun run gen:skill-docs -->
## 단계 2C: 상담 형태

Codex 코드베이스에 대해 아무것도 묻습니다. 다음 단계에 대한 세션 연속성을 지원합니다.

1. **기존 세션에 대한 확인:**
```bash
cat .context/codex-session-id 2>/dev/null || echo "NO_SESSION"
```

세션 파일이 존재하는 경우 (`NO_SESSION`), AskUserQuestion를 사용한다:
```
You have an active Codex conversation from earlier. Continue it or start fresh?
A) Continue the conversation (Codex remembers the prior context)
B) Start a new conversation
```

2. 임시 직원 파일을 창조하십시오:
```bash
TMPRESP=$(mktemp "$TMP_ROOT/codex-resp-XXXXXX")
TMPERR=$(mktemp "$TMP_ROOT/codex-err-XXXXXX")
```

3. **계획 검토 자동 탐지:** 사용자의 프롬프트가 계획 검토에 관한 경우,
또는 플랜 파일이 존재하고 사용자가 `/codex`를 인수하지 않는다면:
```bash
setopt +o nomatch 2>/dev/null || true  # zsh compat
ls -t "$PLAN_ROOT"/*.md 2>/dev/null | xargs grep -l "$(basename $(pwd))" 2>/dev/null | head -1
```
프로젝트의 경기가 없다면 `ls -t "$PLAN_ROOT"/*.md 2>/dev/null | head -1`로 돌아갑니다. 그러나 warn : "주의 :이 계획은 다른 프로젝트에서 일 수 있습니다. — Codex로 보내기 전에 확인."

**IMPORTANT - embed content, 참조 경로가 없습니다.** Codex는 repo 루트에 sandboxed를 달고 `~/.claude/plans/` 또는 repo 밖에 어떤 파일도 접근할 수 없습니다. MUST는 계획 파일을 직접 읽고 아래 프롬프트에서 FULL CONTENT를 삽입했습니다. NOT는 Codex 파일 경로 또는 계획 파일을 읽을 것을 요구합니까 — 그것은 10+ 도구 호출 검색 및 실패를 낭비할 것입니다.

또한: 참고된 소스 파일 경로에 대한 계획 내용을 스캔 (`src/foo.ts`, `lib/bar.py`, repo에 존재하는 `/` 포함 경로). 발견되면, 그 목록에서 프롬프트 그래서 Codex rg/find를 통해 그들을 발견하는 대신 직접 그들을 읽으십시오.

**항상 filesystem 경계 지시를 미리 준비** 의 기술 Filesystem 경계 섹션 (알로 로드 스켈레톤) 을 통해 각 프롬프트에 전송 Codex, 계획 리뷰 및 무료 양식 상담 질문을 포함.

사용자의 프롬프트에 경계와 인내를 미리 설치하십시오: "IMPORTANT: NOT는 ~/.claude/, ~/.agents/, .claude/skills/, 또는 에이전트/의 밑에 어떤 파일을 읽고 또는 실행합니다. 이들은 Claude Code 기술 정의는 다른 AI 체계를 의미합니다. NOT는/openai.yaml를 수정합니다. 저장소 코드에 집중하십시오.

당신은 잔인하게 정직한 기술 검토자입니다. 이 계획을 검토하십시오: 논리적인 간격 및 unstated assumptions, 누락된 과실 취급 또는 가장자리 상자, overcomplexity (단단한 접근이 있습니까?), 무관한 위험 (무엇이 잘못될 수 있었습니까?), 및 누락된 종점 또는 sequencing 문제점. 직접적. terse 없음. 다만 문제. 또한 계획에서 언급된 이 근원 파일 검토: <list of referenced files, if any>.

THE PLAN: <full plan content, embedded verbatim>"

비 계획은 프롬프트 (사용자 유형 `/codex <question>`)를 참조하거나 ~/.claude/, ~/.agents/, .claude/skills/, 또는 에이전트 / 아래 모든 파일을 읽고, "IMPORTANT: Do NOT를 미리 작성하거나 실행합니다. 이것은 Claude Code 기술 정의는 다른 AI 시스템을 의미하지 않습니다. NOT는 Agent/openai.yaml를 수정합니다. 저장소 코드에만 집중하십시오.

<user's question>"

4. **JSONL 출력**로 코드 실행을 실행하여, 의문을 캡처합니다. 사용
`timeout: 660000` Bash 통화 (새로운 및 재시작 세션 모두) - 게이트는 ABOVE 600s 래퍼를 앉아서 래퍼가 명시된 섀시 메시지로 먼저 불을 덮습니다.

`--xhigh`를 통과한 경우 `"medium"` 대신 `"xhigh"`를 사용하십시오.

**새로운 세션:**를 위해
```bash
_REPO_ROOT=$(git rev-parse --show-toplevel) || { echo "ERROR: not in a git repo" >&2; exit 1; }
PYTHON_CMD=$(command -v python3 2>/dev/null || command -v python 2>/dev/null || true)
if [ -z "$PYTHON_CMD" ]; then
  echo "ERROR: Python 3 is required to parse Codex JSON output. Install python3 or python and retry." >&2
  exit 1
fi
# Fix 1: wrap with timeout (gtimeout/timeout fallback chain via probe helper)
_gstack_codex_timeout_wrapper 600 codex exec "<prompt>" -C "$_REPO_ROOT" -s read-only -c 'model_reasoning_effort="medium"' -c 'web_search="cached"' --json < /dev/null 2>"$TMPERR" | PYTHONUNBUFFERED=1 "$PYTHON_CMD" -u -c "
import sys, json
turn_completed_count = 0
turn_failed = False
for line in sys.stdin:
    line = line.strip()
    if not line: continue
    try:
        obj = json.loads(line)
        t = obj.get('type','')
        if t == 'thread.started':
            tid = obj.get('thread_id','')
            if tid: print(f'SESSION_ID:{tid}', flush=True)
        elif t == 'item.completed' and 'item' in obj:
            item = obj['item']
            itype = item.get('type','')
            text = item.get('text','')
            if itype == 'reasoning' and text:
                print(f'[codex thinking] {text}', flush=True)
                print(flush=True)
            elif itype == 'agent_message' and text:
                print(text, flush=True)
            elif itype == 'command_execution':
                cmd = item.get('command','')
                if cmd: print(f'[codex ran] {cmd}', flush=True)
        elif t == 'turn.completed':
            turn_completed_count += 1
            usage = obj.get('usage',{})
            tokens = usage.get('input_tokens',0) + usage.get('output_tokens',0)
            if tokens: print(f'\ntokens used: {tokens}', flush=True)
        elif t == 'turn.failed':
            turn_failed = True
            err = obj.get('error',{}).get('message','') or 'no error message in event'
            print(f'[codex turn FAILED] {err}', flush=True, file=sys.stderr)
    except: pass
# Three-way completeness check (#2671; consult previously had NONE): a STATED
# failure is a failure, not a network problem; only silence is a disconnect.
if turn_failed:
    print('[codex] turn.failed received — the turn errored (reason above), not a disconnect.', flush=True, file=sys.stderr)
elif turn_completed_count == 0:
    print('[codex warning] No turn.completed event received — possible mid-stream disconnect.', flush=True, file=sys.stderr)
"
# Fix 1: hang detection for Consult new-session (mirrors Challenge + resume)
_CODEX_EXIT=${PIPESTATUS[0]:-${pipestatus[1]}}  # bash sets PIPESTATUS; zsh (lowercase, 1-indexed) falls through (#2669)
if [ "$_CODEX_EXIT" = "124" ]; then
  _gstack_codex_log_event "codex_timeout" "600"
  _gstack_codex_log_hang "consult" "$(wc -c < "$TMPERR" 2>/dev/null || echo 0)"
  echo "Codex stalled past 10 minutes. Common causes: model API stall, long prompt, network issue. Try re-running. If persistent, split the prompt or check ~/.codex/logs/."
elif [ "$_CODEX_EXIT" != "0" ]; then
  # Surface non-zero exits so the calling agent doesn't read "no output" as
  # a silent model/API stall. See #1327.
  echo "[codex exit $_CODEX_EXIT] $(head -1 "$TMPERR" 2>/dev/null || echo "no stderr captured")"
  head -20 "$TMPERR" 2>/dev/null | sed 's/^/  /' || true
  _gstack_codex_log_event "codex_nonzero_exit" "consult:$_CODEX_EXIT"
fi
```

**세션 코스트 리얼(#2387, 측정):** 각 `codex exec` 호출 — 재시작 또는 신선한 — 지불 Codex의 ~21K-token 세션은 (그것의 기술 카탈로그 + 지시); `resume`는 NOT amortize 그것 (측정된 이력서는 약간 ABOVE 신선한 외침에 왔다). 이력서는 대화 연속성을 구입하고, 결코 저축하지 않습니다. 이렇게: 워크플로우가 허용하는 기술 당 ONE 코덱 호출을 선호하고, 배치 질문은 즉시 회의를 위한 응답을 위한 질문과 일치할 수 있는 경우에만 대답합니다.

**재시작** (사용자는 "Continue")를 선택했습니다.
```bash
_REPO_ROOT=$(git rev-parse --show-toplevel) || { echo "ERROR: not in a git repo" >&2; exit 1; }
PYTHON_CMD=$(command -v python3 2>/dev/null || command -v python 2>/dev/null || true)
if [ -z "$PYTHON_CMD" ]; then
  echo "ERROR: Python 3 is required to parse Codex JSON output. Install python3 or python and retry." >&2
  exit 1
fi
cd "$_REPO_ROOT" || exit 1
# Fix 1: wrap with timeout (gtimeout/timeout fallback chain via probe helper)
_gstack_codex_timeout_wrapper 600 codex exec resume <session-id> "<prompt>" -c 'sandbox_mode="read-only"' -c 'model_reasoning_effort="medium"' -c 'web_search="cached"' --json < /dev/null 2>"$TMPERR" | PYTHONUNBUFFERED=1 "$PYTHON_CMD" -u -c "
<same python streaming parser as above, with flush=True on all print() calls>
"
# Fix 1: same hang detection pattern as new-session block
_CODEX_EXIT=${PIPESTATUS[0]:-${pipestatus[1]}}  # bash sets PIPESTATUS; zsh (lowercase, 1-indexed) falls through (#2669)
if [ "$_CODEX_EXIT" = "124" ]; then
  _gstack_codex_log_event "codex_timeout" "600"
  _gstack_codex_log_hang "consult-resume" "$(wc -c < "$TMPERR" 2>/dev/null || echo 0)"
  echo "Codex stalled past 10 minutes. Common causes: model API stall, long prompt, network issue. Try re-running. If persistent, split the prompt or check ~/.codex/logs/."
elif [ "$_CODEX_EXIT" != "0" ]; then
  # Surface non-zero exits so the calling agent doesn't read "no output" as
  # a silent model/API stall. See #1327.
  echo "[codex exit $_CODEX_EXIT] $(head -1 "$TMPERR" 2>/dev/null || echo "no stderr captured")"
  head -20 "$TMPERR" 2>/dev/null | sed 's/^/  /' || true
  _gstack_codex_log_event "codex_nonzero_exit" "consult-resume:$_CODEX_EXIT"
fi
```

5. 캡처 세션 ID 스트림 출력에서. 파서 인쇄 `SESSION_ID:<id>`
   `thread.started` 이벤트에서. 다음을 위해 저장:
```bash
mkdir -p .context
```
`.context/codex-session-id`로 파서(`SESSION_ID:`)를 시작으로 `.context/codex-session-id`로 인쇄한 세션 ID를 저장합니다.

6. 출력을 Streamed 현재:

```
CODEX SAYS (consult):
════════════════════════════════════════════════════════════
<full output, verbatim — includes [codex thinking] traces>
════════════════════════════════════════════════════════════
Tokens: N | Est. cost: ~$X.XX
Session saved — run /codex again to continue this conversation.
```

7. 현재 진행중인 후 Codex의 분석이 자기와 다를 점에 주의하십시오.
   이해. 불분명이 있는 경우, "주의: Claude Code는 Y 때문에 X에 불분명한다."

8. **Synthesis 권고 (REQUIRED).** Emit ONE 권장라인
사용자가 Codex의 계산 출력을 기준으로해야 하는 것을 요약해서, canonical 형식에서 AskUserQuestion 판사 급료:

```
Recommendation: <action> because <one-line reason that names the most actionable insight from Codex>
```

예 (강한 이유는 대안에 대한 Codex의 통찰력을 비교합니다. - 다른 권고, 상태 쿼, 또는 다른 Codex 점) :
- `Recommendation: Adopt Codex's sharding suggestion because it eliminates the head-of-line blocking the current writer-pool has, while the cache-layer alternative Codex also floated still has a single-writer hot path.`
- `Recommendation: Reject Codex's "use SQLite instead" suggestion because the team's Postgres operational experience outweighs the simplicity gain at the projected scale, and Codex's secondary suggestion (read replicas) handles the read-load concern that motivated the SQLite pivot.`
- `Recommendation: Investigate Codex's flagged migration ordering before D3 lands because it surfaces a real foreign-key cycle that the in-house schema review missed, while the styling concern Codex also raised can wait for a follow-up.`

Codex 통찰력과 관련해야 하며, 대안에 대한 비교 (다른 권고, 상태 쿼, 또는 다른 Codex 점). 일반적인 종합 ("Codex가 좋은 점을 올리기")는 형식을 실패합니다. **절대로 자동 변형; 항상 선을 방출.**

---
