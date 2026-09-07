<!-- AUTO-GENERATED from challenge-mode.md.tmpl — do not edit directly -->
<!-- Regenerate: bun run gen:skill-docs -->
## 단계 2B: 도전 (대략) 형태

Codex 코드를 깰 수 있습니다. — 가장자리 케이스, 인종 조건, 보안 구멍 및 실패 모드를 찾는 것은 일반 검토가 놓을 것입니다.

1. 옹호자 전달을 한다. **항상 filesystem 경계 지시를 미리 준비**
기술의 Filesystem 경계 섹션 (always-loaded skeleton)에서. 사용자가 초점 영역을 제공 한 경우 (예 : `/codex challenge security`), 경계 후 포함 :

기본 프롬프트 ( 초점 없음) : "IMPORTANT : NOT는 ~/.claude/, ~/.agents/, .claude/skills/, 또는 에이전트/에서 모든 파일을 읽고 또는 실행합니다. 이들은 Claude Code 기술 정의가 다른 AI 시스템에 대해 의미합니다. NOT는 Agent/openai.yaml를 수정합니다. 저장소 코드에만 집중하십시오.

기본 branch에 대한이 지점의 변경 사항을 검토합니다. diff를 볼 `git diff origin/<base>`를 실행하십시오. 작업은이 코드를 생산에 실패하는 방법을 찾는 것입니다. 공격자와 카오스 엔지니어와 같은 생각하십시오. 가장자리 케이스, 인종 조건, 보안 구멍, 자원 누출, 실패 모드 및 침묵 데이터 손상 경로 찾기. 모험이 될 수 있습니다. 철저한 것. 아무런 문제 없습니다.

초점 (예 : "보안") : "IMPORTANT : NOT는 ~/.claude/, ~/.agents/, .claude/skills/, 또는 에이전트/의 밑에 어떤 파일을 읽거나 실행합니다. 이들은 Claude Code 기술 정의가 다른 AI 체계를 의미하는 것입니다. NOT는 Agent/openai.yaml를 수정합니다. 저장소 코드에만 집중하십시오.

기본 branch에 대한이 지점의 변경 사항을 검토합니다. `git diff origin/<base>`를 실행하여 디프를 볼 수 있습니다. SECURITY에 특히 초점을 맞춥니다. 작업은 모든 방법을 발견하는 것입니다 공격자는이 코드를 악화 할 수 있습니다. 주입 벡터, 오순 우회, 특권 에스컬레이션, 데이터 노출 및 타이밍 공격에 대해 생각하십시오. 모험을하십시오."

2. **JSONL 출력**와 코드 실행을 실행하여 추적과 도구 호출을 캡처합니다.
Bash 통화에서 `timeout: 660000`를 사용하십시오. 게이트는 ABOVE를 앉습니다. 600s 래퍼는 래퍼가 명시된 섀시 메시지로 먼저 불을 덮습니다.

`--xhigh`를 통과한 경우 `"high"` 대신 `"xhigh"`를 사용하십시오.

```bash
_REPO_ROOT=$(git rev-parse --show-toplevel) || { echo "ERROR: not in a git repo" >&2; exit 1; }
PYTHON_CMD=$(command -v python3 2>/dev/null || command -v python 2>/dev/null || true)
if [ -z "$PYTHON_CMD" ]; then
  echo "ERROR: Python 3 is required to parse Codex JSON output. Install python3 or python and retry." >&2
  exit 1
fi
# Fix 1+2: wrap with timeout (gtimeout/timeout fallback chain via probe helper),
# capture stderr to $TMPERR for auth error detection (was: 2>/dev/null).
TMPERR=${TMPERR:-$(mktemp "$TMP_ROOT/codex-err-XXXXXX")}
_gstack_codex_timeout_wrapper 600 codex exec "<prompt>" -C "$_REPO_ROOT" -s read-only -c 'model_reasoning_effort="high"' -c 'web_search="cached"' --json < /dev/null 2>"$TMPERR" | PYTHONUNBUFFERED=1 "$PYTHON_CMD" -u -c "
import sys, json
turn_completed_count = 0
turn_failed = False
for line in sys.stdin:
    line = line.strip()
    if not line: continue
    try:
        obj = json.loads(line)
        t = obj.get('type','')
        if t == 'item.completed' and 'item' in obj:
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
# Fix 2: three-way completeness check (#2671) — a STATED failure is a failure,
# not a network problem; only silence with no terminal event is a disconnect.
if turn_failed:
    print('[codex] turn.failed received — the turn errored (reason above), not a disconnect.', flush=True, file=sys.stderr)
elif turn_completed_count == 0:
    print('[codex warning] No turn.completed event received — possible mid-stream disconnect.', flush=True, file=sys.stderr)
"
_CODEX_EXIT=${PIPESTATUS[0]:-${pipestatus[1]}}  # bash sets PIPESTATUS; zsh (lowercase, 1-indexed) falls through (#2669)
# Fix 1: hang detection — log + surface actionable message
if [ "$_CODEX_EXIT" = "124" ]; then
  _gstack_codex_log_event "codex_timeout" "600"
  _gstack_codex_log_hang "challenge" "$(wc -c < "$TMPERR" 2>/dev/null || echo 0)"
  echo "Codex stalled past 10 minutes. Common causes: model API stall, long prompt, network issue. Try re-running. If persistent, split the prompt or check ~/.codex/logs/."
elif [ "$_CODEX_EXIT" != "0" ]; then
  # Surface non-zero exits so the calling agent doesn't read "no output" as
  # a silent model/API stall. See #1327.
  echo "[codex exit $_CODEX_EXIT] $(head -1 "$TMPERR" 2>/dev/null || echo "no stderr captured")"
  head -20 "$TMPERR" 2>/dev/null | sed 's/^/  /' || true
  _gstack_codex_log_event "codex_nonzero_exit" "challenge:$_CODEX_EXIT"
fi
# Fix 2: surface auth errors from captured stderr instead of dropping them
if grep -qiE "auth|login|unauthorized" "$TMPERR" 2>/dev/null; then
  echo "[codex auth error] $(head -1 "$TMPERR")"
  _gstack_codex_log_event "codex_auth_failed"
fi
```

이 파즈 코덱의 JSONL 이벤트는 추적, 도구 통화 및 최종 응답을 추출합니다. `[codex thinking]` 라인은 그 대답 전에 코덱이 왜곡했는지 보여줍니다.

3. 출력을 Streamed 현재:

```
CODEX SAYS (adversarial challenge):
════════════════════════════════════════════════════════════
<full output from above, verbatim>
════════════════════════════════════════════════════════════
Tokens: N | Est. cost: ~$X.XX
```

3a. **Synthesis 권고 (REQUIRED).** 전체적인 adversarial 출력을 제시한 후 ONE 권장 줄을 요약하면 사용자가 어떻게 해야 하는지, 수동적인 형식에서 AskUserQuestion 판사 등급:

```
Recommendation: <action> because <one-line reason that names the most exploitable finding>
```

예제 (강화한 이유는 발견 또는 수정 vs-ship에 따라 폭발 반경을 비교합니다) :
- `Recommendation: Fix the unbounded retry loop Codex flagged at queue.ts:78 because it DoSes the worker pool under sustained 429s, which is higher-blast-radius than the timing leak Codex also flagged that only touches a debug endpoint.`
- `Recommendation: Ship as-is because Codex's strongest finding is a theoretical race in cleanup that requires conditions we can't trigger in production, weaker than the runtime regressions a fix-now would risk.`

이 이유는 특정한 발견과 대안에 대한 비교를 (다른 발견, 수정-vs-ship). "안전"이 포맷을 실패하기 때문에 일반적인 이유. **절대로 떼어내고 선을 건너 뛰지 마십시오.**

---
