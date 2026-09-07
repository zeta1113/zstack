# GCOMPACTION.md - 디자인 및 건축 (TABLED)

**승인 대상 경로:** `docs/designs/GCOMPACTION.md`

`gstack compact`에 대한 보존 된 디자인의 해석입니다. 아래 첫 번째 `---` 배당자는 플랜 승인에 대해 `docs/designs/GCOMPACTION.md`로 동사를 추출합니다. 배당 후 모든 것은 아카이브 연구 (사무실 시간 + 경쟁력있는 심층 + eng-review 노트 + 코덱 검토 + 연구 결과)로 설계를 알립니다.

---

## 상태: TABLED (2026-04-17) - 구출 구출 구출 구출 구출 `updatedBuiltinToolOutput` API

**왜 테이블.** v1 아키텍처는 Claude Code `PostToolUse` 후크가 REPLACE가 내장 도구에 대한 모델의 컨텍스트를 입력하는 도구 출력을 가정했습니다 (Bash, 읽기, Grep, Glob, WebFetch). 2026-04-17에 대한 연구는 오늘이 불가능합니다.

**증거:**

1. **공식 문서** (https://code.claude.com/docs/en/hooks): `PostToolUse`를 위해 문서화된 유일한 산출 위치 분야는 `hookSpecificOutput.updatedMCPToolOutput`이고, 명시적으로 국가를 docs: *"MCP 도구만: 제공된 값으로 도구의 출력을 대체합니다."* No 동등한 분야는 붙박이 도구를 위해 존재합니다.
2. **안토픽 이슈 [#36843](https://github.com/anthropics/claude-code/issues/36843)** (OPEN): 아나톨릭은 갭을 인정한다. *"PostToolUse Hook은 `updatedMCPToolOutput`를 통해 MCP 도구 출력을 대체 할 수 있지만 내장 도구 (WebFetch, WebSearch, Bash, 읽기 등)에 해당하는 no가 있습니다. 그들은 `decision: block` (이러 문자열을 주사) 또는 `additionalContext`를 통해 경고를 추가 할 수 있습니다. 원래 악명 높은 내용은 여전히 모델에 도달합니다."*
3. **RTK 기계장치** (`src/hooks/init.rs:906-912` 및 `hooks/claude/rtk-rewrite.sh:83-100`): RTK는 NOT를 PostToolUse 조밀합니다. **PreToolUse의 장점** Bash matcher를 재쓰는 `tool_input.command` (예를들면 `git status` → `rtk git status`)입니다. 감싸인 명령은 콤팩트 stdout를 자체 생성합니다. RTK README는 다음을 확인합니다: Bash는 단지 훅/>를 갖습니다. Claude Code는 읽기, Grep, Glob와 같은 붙박이 도구는 Bash 걸이를 통해서 통과하지 않습니다, 그래서 자동 rewritten가 아닙니다." * RTK는 선택에 의해 건축 constraint에 의해 Bash-only 입니다.
4. **Tokenjuice 메커니즘** (`src/core/claude-code.ts:160, 491, 540-549`): Tokenjuice DOES는 `matcher: "Bash"`를 가진 `PostToolUse`를 등록하고 그러나 no를 유효한 진짜 산출 장소 API - 압축된 원본을 주사하기 위하여 hijacks `decision: "block"` + `reason`를 가진 `PostToolUse`를, 가지고 있습니다. 실제로 모형 콘텍스트 토큰 또는 다만 오버레이 UI 산출은 분쟁됩니다. 토큰은 또한 Bash만입니다.
5. **Read/Grep/Glob 내부에서 처리 실행 Claude Code**와 바이패스 후크 전체. 쐐기 (ii) "native-tool 적용"은 교체 API에 관계없이 하루에서 건축 불가능했습니다.

**의제.** 두 쐐기는 원래 형태로 죽입니다:
- 쐐기 (i) "Conditional LLM verifier"- 아직도 기술적으로 가능하지만 PreToolUse 명령 감싸기 (RTK의 메커니즘)을 통해 Bash 출력에만 사용됩니다. 정선은 우리가 Bash-only라고하면 서로 다른 점이 멈추지 않습니다.
- 쐐기 (ii) "Native-tool 적용"- 오늘 불가능. Read/Grep/Glob 불 후크가 없습니다. 그들이 한 경우에도 no 출력 영역이 존재합니다.

**의욕.** 선반 `gstack compact` 완전히. `updatedBuiltinToolOutput` (또는 동등)의 도착을 위한 Anthropic 문제점 #36843를 추적하십시오. 그 때 API 배, 이 디자인 doc + 바닥에 있는 연구 아치드는 신선한 실시 sprint를 위한 막는 artifacts가 됩니다.

**의 경우:** 아래 계획 --eng-review" 구획 도중 잠긴 “Decisions에서 시작하십시오 - 가장 유효하 남아 있습니다. 다음 새로 shipped API에 대하여 걸이 참고를 재확인하고, 진짜 산출 장소가 존재하고, 코드화하기 전에 개정된 계획에 대하여 `/codex review`를 재 실행하십시오.

**우리가 하는 NOT:**
- Bash-only PreToolUse 래퍼를 배송하지 않습니다. 즉 RTK의 제품; 그들은 28K 별과 3 년 규칙 흉터에 있습니다. No 쐐기.
- `decision: block` + `reason` 해킹을 발송하지 마십시오. 문서화 된 행동, Anthropic은 그것을 깨질 수 있으며 모델은 여전히 컴팩트 한 오버레이와 함께 원시 출력을 볼 수 있습니다. - 컨텍스트 저축은 분쟁입니다.
- 고립에 있는 B 시리즈 벤치 마크를 발송하지 마십시오. 일 조밀함 없이, 벤치 마크에 아무것도 없습니다.

**탭의 비용:** ~0. No 코드가 작성되었습니다. 디자인 doc + 연구 + 결정은 준비 블록 포뮬레이션으로 남아 있습니다.

---

## 계획-eng- (2026-04-17) 동안 잠긴 결정

/when Anthropic가 내장된 --in-tool 출력-replace API를 발송하는 경우의 탐지를 위해 보존했습니다.

엔지니어링 검토 중 모든 결정의 개요. 전체 합리적은 아래의 섹션에서 보존됩니다; 이 블록은 다른 모든 편이 무려하는 경우 진리의 단일 소스입니다.

**범위 (Section 0):**
1. **클로드-첫 번째 v1.** 배 콤팩트 + 규칙 + 예선 Claude Code에서만. Codex + OpenClaw 땅은 쐐기가 1 차적인 주인에 입증된 후에 v1.1에. ~2 일의 주인 통합과 derisks 발사를 삭감합니다. 본래 "쐐기 (ii) 기본 도구 적용"는 v1에 Claude Code에 적용합니다; 우리는 v1.1까지 no 크로스 호스트 주장을 만듭니다.
2. **13-rule 발사 도서관.** v1 배 테스트 (jest/vitest/pytest/cargo-test/go-test/rspec) + git (diff/log/status) + 설치 (npm/pnpm/pip/cargo). Build/lint/log 가족이 실제 사용자로부터 `gstack compact discover` 원격 측정으로 구동한다.
3. **v1.0에서 default ON를 입력합니다.** `failureCompaction` 방아쇠 (exit►0 AND >50% 감소)는 상자에서 활성화됩니다. verifier IS 쐐기 - 기본적으로 다른 특징을 숨깁니다. 방아쇠는 이미 도구 전화의 예상한 불 비율 ≤10%를 지킵니다.

**건축 (Section 1):**
4. **Haiku 산출을 위한 정확한 선 잡아당기기 sanitization.** `\n`에 의해 원시 출력을 분할, 세트에 있는 선을, 그 세트에 있는 verbatim를 나타나는 Haiku에서 단지 부록합니다. 가장 단단한 adversarial 계약; 신속한 주입 시도는 소설 원본에서 미끄러짐할 수 없습니다.
5. **layered failureCompaction 신호.**는 봉투에서 `exitCode`를 예리합니다; 주인이 그것을, 출력에 `/FAIL|Error|Traceback|panic/` regex로 떨어뜨리면. `meta.failureSignal` ("exit" | "pattern" | "none"). 이전 작업 #1는 Claude Code의 봉투 empirically, 하지만 시스템 no는 더 긴 그것이 아닙니다.
6. **딥 머지 규칙 해결책.** User/project 규칙은 내장 필드를 상속하지 않습니다. 해치 탈출: 규칙 파일에 있는 `"extends": null`는 전체 교체 semantics를 방아쇠를 칩니다. eslint/tsconfig/.gitignore의 정신 모델을 일치시키면 나머지를 잃지 않고 조각을 덮습니다.

**코드 질 (Section 2):**
7. **퍼-룰 레렉스 타임 아웃, no RE2 dep.** 각 규칙의 regex를 실행 50ms AbortSignal 예산; 타임 아웃에 규칙을 건너 뛰고 `meta.regexTimedOut: [ruleId]`를 기록합니다. WASM 의존성을 피하고 규칙을 준수합니다.
8. **사전 컴파일된 규칙 번들.** `gstack compact install`와 `gstack compact reload` 생성 `~/.gstack/compact/rules.bundle.json` (deep-merged, regex-compiled metadata cached). Hook은 N 소스 파일 대신 단일 파일을 읽습니다.
9. **자동 로드 mtime 편류.** 훅 통계는 시작에 소스 파일입니다. 묶음보다 더 새로운 소스 파일이 있다면, 응용하기 전에 인라인을 다시 구축하십시오. ~0.5ms/invocation를 추가하지만 "나는 규칙과 변경하지 않는"발군을 편집합니다.
10. **확장된 v1 적색 설정.** Tee files redact: AWS keys, GitHub tokens (`ghp_/gho_/ghs_/ghu_`), GitLab tokens (`glpat-`), Slack webhooks, generic JWT (three base64 segments), generic bearer tokens, SSH private-key headers (`-----BEGIN * PRIVATE KEY-----`). Credit cards / SSNs / per-key env-pairs deferred to a full DLP layer in v2.

**테스트 (Section 3):**
11. **P 시리즈 게이트 서브셋.** v1 gate-tier P-tests: P1 (binary garbage), P3 (empty output), P6 (RTK-killer critical stack frame), P8 (secrets to tee), P15 (hook timeout), P18 (prompt injection), P26 (malformed user rule JSON), P28 (regex DoS), P30 (Haiku hallucination). Remaining 21 P-cases grow R-series as real bugs hit.
12. **정착물 버전 표본 추출.** 모든 황금 정착물에는 `toolVersion:` frontmatter가 있습니다. CI warns when Fixture toolVersion ►는 현재 설치했습니다. No 달력 근거한 교체.
13. **B 시리즈 실제 벤치 마크 테스트 벤치 (하드 v1 게이트).** 새로운 구성 요소 `compact/benchmark/` 스캔 `~/.claude/projects/**/*.jsonl`, 가장 쉬운 도구 호출을 순위, 그에 대한 압축을 재생, 그리고 감소 - 바이 - 룰 가족을보고. v1는 저자의 자신의 30 일 corpus 쇼에 B 시리즈까지 배 할 수 없습니다 ≥15% 감소 AND 0의 긴축 손실에 심은 버그. 지역 전용; 결코 업로드하지 않습니다. 커뮤니티 공유 코르푸는 v2입니다.

**성과 (Section 4):**
14. **대기시간 예산을 개정합니다.** Bun macOS ARM는 15-25ms입니다; 본래 10ms p50 표적은 비현실이었습니다. 새로운 예산: <30ms p50/<80ms p99> macOS ARM, <20ms p50/<60ms p99> Linux (방충)에. Verifier-fires 예산은 <600ms p50/<2s p99>에 달합니다. b-start는 B-start 회의에서 선택권을 보여주고 있습니다.
15. **라인 중심의 스트리밍 파이프라인.** stdin → 필터 → 그룹 → dedupe → 반지 버퍼 꼬리 truncation → stdout에 읽는. 어떤 단 하나 선 >1MB는 P9 (`[... truncated ...]` 감적을 가진 1KB에 truncate)를 보였습니다. 총 산출 크기에 관계 없이 64MB에 모자 기억.

위의 모든 행은 구현의 `MUST`입니다. 드리프트는 새로운 eng-review를 요구합니다.

---

## 요약

`gstack compact`는 AI 기호화 창에 도달하기 전에 도구 산출 소음을 감소시키는 `PostToolUse` 걸이로 디자인되었습니다. Deterministic JSON 규칙은 noisy 시험 주자, 구조 통나무, git diffs 및 포장은 설치합니다. 조건 Claude Haiku verifier는 지나치게 행동 위험이 높을 때 안전 그물로 작동할 것입니다.

**현재 상태: TABLED.** 위의 "Status"섹션을 참조하십시오. 아키텍처는 Claude Code API (`updatedBuiltinToolOutput` 또는 내장 도구에 해당)에 따라 2026-04-17로 존재하지 않는 것입니다. Anthropic Issue #36843는 간격을 추적합니다.

**대상 목표 (무선 스캔에 대한 사전):** 15–30% tool-output token reduction per long session, with zero increase in task-failure rate.

**원본 쐐기 (vs RTK, 28K-star incumbent) - 연구에 의해 무효화되는 둘 다:**
1. ~~**Conditional LLM verifier.**~~ 아직 기술적으로 프리 툴 사용 명령 래핑을 통해 비할 수 있지만, Bash만 사용할 수 있습니다. 일단 다른 사람이 Bash-only인 경우를 중지합니다. 내장된 API가 도착하면 다시 알림을 합니다.
2. ~~**기본 기능**~~ 건축적으로 오늘 불가능합니다. Read/Grep/Glob는 Claude Code 안쪽에 가공을 실행하고 걸이를 불지 않습니다. 불 `PostToolUse`, no 산출 위치 분야가 비MCP 도구를 위해 존재한다는 도구를 위해 조차.

**원래 위치 (현재 moot):** *"RTK는 빠릅니다. gstack 콤팩트는 빠른 AND 안전이고, 툴박스에 있는 모든 도구를, 다만 Bash 아닙니다 덮습니다."*

## 비 목표

- 사용자 메시지 또는 사전 에이전트 회전을 요약 (Claude의 자체 압축 API는 그 소유).
- 에이전트 응답 출력 압축 (caveman의 층).
- 재조절 방지(token-optimizer-mcp's layer)를 호출합니다.
- 범용 로그 분석기로 행동.
- `GSTACK_RAW=1` 명령을 재 실행할 때 에이전트의 자체 판단을 수정합니다.

## 왜이 건물이 가치가 있는지

**문제는, hypothetical 아닙니다 측정됩니다.**

- [크로마 연구 (2025)](https://research.trychroma.com/context-rot) 테스트 18 국경 모델. 모든 모델은 컨텍스트 성장. 회전은 윈도우 제한 전에 잘 시작 — 50K에서 200K 모델 rots.
- 코딩 에이전트는 최악의 경우입니다: 축적된 컨텍스트 + 높은 분산 밀도 + 긴 작업 수평선. 도구 출력은 1 차적인 소음 소스로 명시적으로 명명됩니다.
- 시장은 투표했습니다: Anthropic는 Opus 4.6 Compaction API를 발송했습니다; OpenAI는 압축 가이드를 발송했습니다; 구글 ADK는 컨텍스트 압축을 발송했습니다; LangChain는 자율 압축을 발송했습니다; sst/opencode는 압축을 비치하고 있습니다. 잡종 deterministic + LLM 본은 기업 consensus입니다.

**기존의 필드 (gstack 컴팩트한 결합 및 차별화):**

| 의정부 | Stars | 의정부 | Layer | Threat | Note |
|---------|-------|---------|-------|--------|------|
| **RTK (rtk-ai/rtk)** | **28K ·** | 아파치 2.0 | 도구 산출 | 1 차적인 벤치 마크 | 순수한 Rust, 비만, 0 LLM |
| 강릉출장샵 | 34.8K(주) | MIT | 산출 토큰 | 다른 축선 | 터 닝 시스템 프롬프트; 쌍 WITH 우리 |
| claude-token-efficient의 이점 | 4.3K에 | MIT | 응답 동사성 | 다른 축선 | Single CLAUDE.md |
| 토큰 최적화기-mcp | 49 | MIT | MCP 캐싱 | 다른 축선 | 출력 압축 보다는 오히려 호출을 방지하십시오 |
| 토큰쥬스 | ~12 | MIT | 도구 산출 | 토토사이트 | 2 days old; inspired our JSON envelope |
| 6 층 토큰 저장 스택 | — | 공공 gist | Recipe | 으로 | 문서; stacked compaction thesis를 검증 |

RTK는 유일한 직접적인 경쟁자입니다. 다른 모든 것은 다른 token 근원을 압축합니다.

**면허 겸용성:** 각 참조된 프로젝트는 MIT 또는 Apache-2.0)과 gstack의 MIT 라이센스와 호환됩니다. No AGPL, GPL, 또는 다른 copyleft 종속성. 클린 룸 정책에 따라 "License & attribution"섹션을 참조하십시오.

## 건축

### 자료 교류

```
┌─────────────────────────────────────────────────────────────────┐
│  Host (Claude Code / Codex / OpenClaw)                          │
│  ─────────────────────────────────────────                      │
│  1. Agent requests tool call: Bash|Read|Grep|Glob|MCP           │
│  2. Host executes tool                                          │
│  3. Host invokes PostToolUse hook with: {tool, input, output}   │
└────────────────────┬────────────────────────────────────────────┘
                     │ stdin (JSON envelope)
                     ▼
┌─────────────────────────────────────────────────────────────────┐
│  gstack-compact hook binary                                     │
│  ───────────────────────────                                    │
│  a. Parse envelope                                              │
│  b. Match rule by (tool, command, pattern)                      │
│  c. Apply rule primitives: filter / group / truncate / dedupe   │
│  d. Record reduction metadata                                   │
│  e. Evaluate verifier triggers                                  │
│  f. If trigger met: call Haiku, append preserved lines          │
│  g. On failure exit code: tee raw to ~/.gstack/compact/tee/...  │
│  h. Emit JSON envelope to stdout                                │
└────────────────────┬────────────────────────────────────────────┘
                     │ stdout (JSON envelope)
                     ▼
              Host substitutes compacted output into agent context
```

### 규칙 해결책

세 계층 계층 계층 (최고의 선구적 승리), 같은 패턴 Tokenjuice 및 gstack의 기존 호스트 구성 수출 모델:

1. 내장 규칙: `compact/rules/` gstack로 배송
2. 사용자 규칙: `~/.config/gstack/compact-rules/`
3. 프로젝트 규칙: `.gstack/compact-rules/`

규칙 ID에 의해 규칙 일치 도구 호출. ID `tests/jest`를 가진 프로젝트 규칙은 완전히 붙박이 `tests/jest`를 과량합니다. No merging — 간단한 이유를 지키는 semantics를 대체하십시오.

## JSON 봉투 계약 (토큰쥬스에서 채택)

입력 :
```json
{
  "tool": "Bash",
  "command": "bun test test/billing.test.ts",
  "argv": ["bun", "test", "test/billing.test.ts"],
  "combinedText": "...",
  "exitCode": 1,
  "cwd": "/Users/garry/proj",
  "host": "claude-code"
}
```

산출:
```json
{
  "reduced": "compacted output with [gstack-compact: N → M lines, rule: X] header",
  "meta": {
    "rule": "tests/jest",
    "linesBefore": 247,
    "linesAfter": 18,
    "bytesBefore": 18234,
    "bytesAfter": 892,
    "verifierFired": false,
    "teeFile": null,
    "durationMs": 8
  }
}
```

## 규칙 스키마

소형, 최소. 총 규칙-payload는 디스크에 <5KB (claude-token-efficient에서 제외)를 유지해야합니다. 모든 세션에서 자체 토큰을 소비하는 규칙).

```json
{
  "id": "tests/jest",
  "family": "test-results",
  "description": "Jest/Vitest output — preserve failures and summary counts",
  "match": {
    "tools": ["Bash"],
    "commands": ["jest", "vitest", "bun test"],
    "patterns": ["jest", "vitest", "PASS", "FAIL"]
  },
  "primitives": {
    "filter": {
      "strip": ["\\x1b\\[[0-9;]*m", "^\\s*at .+node_modules"],
      "keep": ["FAIL", "PASS", "Error:", "Expected:", "Received:", "✓", "✗", "Tests:"]
    },
    "group": {
      "by": "error-kind",
      "header": "Errors grouped by type:"
    },
    "truncate": {
      "headLines": 5,
      "tailLines": 15,
      "onFailure": { "headLines": 20, "tailLines": 30 }
    },
    "dedupe": {
      "pattern": "^\\s*$",
      "format": "[... {count} blank lines ...]"
    }
  },
  "tee": {
    "onExit": "nonzero",
    "maxBytes": 1048576
  },
  "counters": [
    { "name": "failed", "pattern": "^FAIL\\s", "flags": "m" },
    { "name": "passed", "pattern": "^PASS\\s", "flags": "m" }
  ]
}
```

4개의 원시법 — `filter`, `group`, `truncate`, `dedupe` — RTK의 기술 세정법 (각 심각한 조밀함이 손잡이에 필요로 하는 것만)에서 직접 들어갑니다. 모든 규칙은 4의 어떤 하위 집합든지 결합할 수 있습니다; omitted 원시법은 no-ops입니다.

## Verifier layer (단면, 선택)

정선은 특정 트리거의 밑에 불이 불이 불이 싼 Haiku 전화입니다. 모든 도구 통화에 결코.

**방아쇠 matrix (사용자 구성):**

| Trigger의 | Default | (주) |
|---------|---------|-----------|
| `failureCompaction` | **ON** | 코드 출구 0 △ AND 감소 >50% (위험에 진단) |
| `aggressiveReduction` | off | 감소 >80% AND 본래 >200의 선 |
| `largeNoMatch` | off | no 규칙 일치 AND 산출 >500 선 |
| `userOptIn` | (env-gated)에 | `GSTACK_COMPACT_VERIFY=1` 그 호출에 대한 힘의 정선자 |

Default config는 `failureCompaction`만 배를 갖는다. 가장 높은 leverage case (에이전트은 디버깅이다; 규칙은 중요한 더미 구조를 거르는지도 모른다).

**Haiku의 일 (행선):**

```
Here is raw output (truncated to first 2000 lines) and a compacted version.
Return any important lines from the raw that are missing from the compacted,
or `NONE` if nothing critical is missing.
```

verifier는 압축된 출력을 다시 씁니다. 그것은 헤더의 누락된 줄만 appends:

```
[gstack-compact: 247 → 18 lines, rule: tests/jest]
[gstack-verify: 2 additional lines preserved by Haiku]
  TypeError: Cannot read property 'foo' of undefined
    at parseConfig (src/config.ts:42:18)
```

**왜 Haiku, Sonnet가 아닌가:** ~1/12th 비용, ~500ms 대 ~2s, 작업은 간단한 하위 문자열 분류, 이유가 없습니다.

**Verifier 설정 (`compact/rules/_verifier.json`):**

```json
{
  "verifier": {
    "enabled": true,
    "model": "claude-haiku-4-5-20251001",
    "maxInputLines": 2000,
    "triggers": {
      "aggressiveReduction": { "enabled": false, "thresholdPct": 80, "minLines": 200 },
      "failureCompaction":   { "enabled": true,  "minReductionPct": 50 },
      "largeNoMatch":        { "enabled": false, "minLines": 500 },
      "userOptIn":           { "enabled": true, "envVar": "GSTACK_COMPACT_VERIFY" }
    },
    "fallback": "passthrough"
  }
}
```

**실패 모드 (버터는 엄격하게 첨가제 - 결코 기본을 깰) :**

- No `ANTHROPIC_API_KEY` → 건너뛰기 verifier, 사용 순수한 규칙 산출.
- Haiku 통화 시간 (>5s) → 건너뛰기 수증기, 사용 순수한 규칙 산출.
- Haiku는 JSON → 건너뛰기, 순수한 규칙 산출을 이용합니다.
- Haiku는 신속한 주입 시도 → sanitize를 돌려줍니다. 원래 원시 출력의 substring-matches 인 유일한 부트 라인.
- Haiku는 복류 라인 (원료에 제시하지 않음)을 반환 → 그들을 떨어뜨립니다.

## 티 모드 (RTK에서 입력)

종료 코드 △ 0을 가진 어떤 명령든지, 가득 차있는 unfiltered 산출은 `~/.gstack/compact/tee/{timestamp}_{cmd-slug}.log`에 기록됩니다. 압축한 산출은 티 파일 포인터를 포함합니다:

```
[gstack-compact: 247 → 18 lines, rule: tests/jest, tee: ~/.gstack/compact/tee/20260416-143022_bun-test.log]
```

에이전트은 직접 티 파일을 읽을 수 있습니다 경우에 전체 더미 추적을 필요로 합니다. 이것은 더 청결한 디자인을 가진 이전 `onFailure.preserveFull` 기계화를 대체합니다: 압축된 산출은 항상 작을 유지합니다; 원료 산출은 항상 1개의 `cat` 떨어져 있습니다.

**티 안전:**

- 파일 모드 `0600` — 세계 읽기.
- 내장 비밀 - Regex 설정 redacts AWS 키, Bearer 토큰 및 일반적인 자격 패턴 쓰기 전에.
- 실패한 쓰기 (read-only 파일 시스템, 권한 거부) 은밀하게 해: 여전히 압축된 출력, 기록 `meta.teeFailed: true`.
- 7 일 후에 자동 폭발기 (후크 시작에 청소).

### Host 통합 모체

| Host | 걸이 유형 | 지원되는 matchers | Config 경로 |
|------|-----------|-------------------|-------------|
| Claude Code | `PostToolUse` | Bash, 읽기, 그랩, Glob, 편집, 쓰기, WebFetch, WebSearch, mcp__* | `~/.claude/settings.json` |
| Codex (v1.1) | `PostToolUse` 동등한 것 | Bash (기본); 도구 subset TBD - empirical 검증은 v1.1 prereq입니다 | `~/.codex/hooks.json` |
| OpenClaw (v1.1) | 네이처 후크 API | Bash + MCP | OpenClaw 설정 |

**v1은 Claude-first입니다.** 쐐기 (ii) - 기본 도구 적용 - [걸이 참고](https://code.claude.com/docs/en/hooks)를 통해 Claude Code에 확인됩니다. Codex와 OpenClaw 쐐기가 B 시리즈 벤치 마크 데이터를 통해 1 차 호스트에 입증 된 후 v1.1에서 통합 배. CHANGELOG v1의 경우 Claude-only 범위가 명시되어 있습니다.

### Config 표면

사용자 설정 (`~/.config/gstack/compact.toml`):

```toml
[compact]
enabled = true
level = "normal"                            # minimal | normal | aggressive (caveman pattern)
exclude_commands = ["curl", "playwright"]   # RTK pattern

[compact.bundle]
auto_reload_on_mtime_drift = true           # hook rebuilds bundle if source rule files are newer
bundle_path = "~/.gstack/compact/rules.bundle.json"

[compact.regex]
per_rule_timeout_ms = 50                    # AbortSignal budget per regex; timeout → skip rule

[compact.verifier]
enabled = true
trigger_failure_compaction = true
trigger_aggressive_reduction = false
trigger_large_no_match = false
failure_signal_fallback = true              # use /FAIL|Error|Traceback|panic/ when exitCode missing
sanitization = "exact-line-match"           # only append lines present verbatim in raw output

[compact.tee]
on_exit = "nonzero"
max_bytes = 1048576
redact_patterns = ["aws", "github", "gitlab", "slack", "jwt", "bearer", "ssh-private-key"]
cleanup_days = 7

[compact.benchmark]
local_only = true                           # hard-coded; config is documentary, cannot be changed
transcript_root = "~/.claude/projects"
output_dir = "~/.gstack/compact/benchmark"
scenario_cap = 20                           # top-N clusters by aggregate output volume
```

**강렬 (caveman 본):**

- **최소:** `filter` + `dedupe`; no truncation. 가장 안전한.
- **정상:** `filter` + `dedupe` + `truncate`. 과태.
- **공격:** `group`; 더 저축, 더 가장자리 케이스 위험 추가하십시오.

### CLI 표면

| Command | 의논하기 | Source |
|---------|---------|--------|
| `gstack compact install <host>` | 호스트 설정에 PostToolUse Hook을 등록하십시오. `rules.bundle.json`를 빌드하십시오. | 의 새로운 |
| `gstack compact uninstall <host>` | Idempotent 제거 | 의 새로운 |
| `gstack compact reload` | user/project 규칙을 편집한 후 `rules.bundle.json`를 다시 컴파일 | 의 새로운 |
| `gstack compact doctor` | drift / 깨진 후크 구성을 감지, 수리 제안 | 토큰쥬스 |
| `gstack compact gain` | token/dollar 시간을 절약하십시오 (자외 고장) | RTK |
| `gstack compact discover` | no 일치하는 규칙을 가진 명령을 찾아, 소음 부피에 의해 평가해 | RTK |
| `gstack compact verify <rule-id>` | 고정장치에 건조시 | 의 새로운 |
| `gstack compact list-rules` | 딥 머지 (build-in + user + project) 후 효과적인 규칙을 표시합니다. | 의 새로운 |
| `gstack compact test <rule-id> <fixture>` | 고정에 규칙을 적용하고 diff를 보여줍니다 | 의 새로운 |
| `gstack compact benchmark` | 로컬 성적표에 대한 B 시리즈 Testbench를 실행 ( 벤치 마크 섹션 참조) | 의 새로운 |

해치 탈출 : `GSTACK_RAW=1` env var는 명령의 지속 시간 동안 훅을 완전히 우회합니다 (토큰쥬스의 `--raw` 플래그와 같은 패턴). Hook은 또한 묶음 파일의 매번이 묶음 파일보다 더 새로운 경우 번들을 자동로드합니다.

## 파일 레이아웃

```
compact/
├── SKILL.md.tmpl              # template; regen via `bun run gen:skill-docs`
├── src/
│   ├── hook.ts                # entry point; reads stdin, writes stdout; mtime-checks bundle
│   ├── engine.ts              # rule matching + reduction metadata
│   ├── apply.ts               # primitive application (line-oriented streaming pipeline)
│   ├── merge.ts               # deep-merge of built-in/user/project rules; honors `extends: null`
│   ├── bundle.ts              # compile source rules → rules.bundle.json (install/reload)
│   ├── primitives/
│   │   ├── filter.ts
│   │   ├── group.ts
│   │   ├── truncate.ts        # ring-buffered tail; safe for arbitrary input size
│   │   └── dedupe.ts
│   ├── regex-sandbox.ts       # AbortSignal-bounded regex execution (50ms budget per rule)
│   ├── verifier.ts            # Haiku integration (triggers + failure-signal fallback + sanitization)
│   ├── sanitize.ts            # exact-line-match filter for verifier output
│   ├── tee.ts                 # raw-output archival with secret redaction + 7-day cleanup
│   ├── redact.ts              # secret-pattern set (AWS/GitHub/GitLab/Slack/JWT/bearer/SSH)
│   ├── envelope.ts            # JSON I/O contract parsing + validation
│   ├── doctor.ts              # hook drift detection + repair
│   ├── analytics.ts           # gain + discover queries against local metadata
│   └── cli.ts                 # argv dispatch; one thin dispatch per subcommand
├── benchmark/                 # B-series testbench (hard v1 gate)
│   └── src/
│       ├── scanner.ts         # walk ~/.claude/projects/**/*.jsonl; pair tool_use × tool_result
│       ├── sizer.ts           # tokens per call (ceil(len/4) heuristic); rank heavy tail
│       ├── cluster.ts         # group high-leverage calls by (tool, command pattern)
│       ├── scenarios.ts       # emit B1-Bn real-world scenario fixtures
│       ├── replay.ts          # run compactor against scenarios; measure reduction
│       ├── pathology.ts       # layer planted-bug P-cases on top of real scenarios
│       └── report.ts          # dashboard: per-scenario before/after + overall reduction
├── rules/                     # v1 built-in JSON rule library (13 rules)
│   ├── tests/
│   │   ├── jest.json
│   │   ├── vitest.json
│   │   ├── pytest.json
│   │   ├── cargo-test.json
│   │   ├── go-test.json
│   │   └── rspec.json
│   ├── install/
│   │   ├── npm.json
│   │   ├── pnpm.json
│   │   ├── pip.json
│   │   └── cargo.json
│   ├── git/
│   │   ├── diff.json
│   │   ├── log.json
│   │   └── status.json
│   ├── _verifier.json         # verifier config (not a rule per se)
│   └── _HOLD/                 # v1.1 rule families (not shipped at v1; kept for reference)
│       ├── build/
│       ├── lint/
│       └── log/
└── test/
    ├── unit/
    ├── golden/
    ├── fuzz/                  # P-series — v1 gate subset only (P1/P3/P6/P8/P15/P18/P26/P28/P30)
    ├── cross-host/            # v1: claude-code.test.ts only; codex/openclaw stub files
    ├── adversarial/           # R-series — grows with shipped bugs
    ├── benchmark/             # B-series scenario fixtures + expected reduction ranges
    ├── fixtures/              # version-stamped golden inputs (toolVersion: frontmatter)
    └── evals/
```

## 테스트 전략

테스트 계획은 디자인에 의해 포괄적인. 28K-star 인큐베이트가 세 년의 레렉스 전투-스카를 가지고있는 공간으로 배송, 우리의 웨지 (Haiku verifier + native-tool 적용) 새로운 실패 표면을 도입, 우리가 얻을 의미 ONE 샷에서 " 컴팩트 내 에이전트 dumb"가 바이러스를했다. 그에 대한 Zero appetite.

### 시험 층

| Tier | Cost | Frequency | 블록 merge |
|------|------|-----------|--------------|
| Unit | 무료, <1s | every PR | yes |
| 골든 파일 (`toolVersion:` frontmatter) | 무료, <1s | every PR | yes |
| 규칙 schema 유효성 | 무료, <1s | every PR | yes |
| Fuzz (P 시리즈 게이트 서브셋: P1/P3/P6/P8/P15/P18/P26/P28/P30) | 무료, <10s> | every PR | yes |
| 크로스 호스트 E2E - Claude Code v1에서만 | 무료, 1분 | PR (표 층) | yes |
| E2E (하이쿠) | 무료, ~15s | every PR | yes |
| E2E (실제 Haiku) | 지불, ~ $0.10/run | PR 터치버터 파일 | yes |
| **B 시리즈 벤치 마크 (실내 세계 시나리오)** | **무료, ~2분** | **사전 릴리스 게이트** | **yes (v1)를 위한 단단한 문** |
| 토큰 절약 eval (E1-E4 합성) | paid, ~$4/run | 정기적인 주간 | no (정보) |
| Adversarial 회귀 (R 시리즈) | 무료, <5s | every PR | yes |
| Tool-version 경고 | 무료, <1s | every PR | 경고 만 |

시험 파일 배치:

```
compact/test/
├── unit/
│   ├── engine.test.ts         # rule matching + primitive application
│   ├── primitives.test.ts     # filter / group / truncate / dedupe
│   ├── envelope.test.ts       # JSON input/output contract
│   ├── triggers.test.ts       # verifier trigger evaluation
│   └── verifier.test.ts       # Haiku call (mocked)
├── golden/
│   ├── tests/                 # one fixture per test runner
│   │   ├── jest-success.input.txt
│   │   ├── jest-success.expected.txt
│   │   ├── jest-fail.input.txt
│   │   ├── jest-fail.expected.txt
│   │   └── ... (vitest, pytest, cargo-test, go-test, rspec)
│   ├── install/
│   ├── git/
│   ├── build/
│   ├── lint/
│   └── log/
├── fuzz/
│   └── pathological.test.ts   # P-series
├── cross-host/
│   ├── claude-code.test.ts
│   ├── codex.test.ts
│   └── openclaw.test.ts
├── adversarial/
│   └── regression.test.ts     # R-series; past bugs that must never recur
├── fixtures/
│   └── {tool}/                # shared raw output fixtures
└── evals/
    └── token-savings.eval.ts  # periodic-tier; measures real reduction
```

### G-series: 좋은 케이스 ( 예상되는 감소를 일으키십시오)

| ID | 팟캐스트 | 예상된 감소 |
|----|----------|-------------------|
| G1 | `jest` 47 통과 시험, 깨끗한 실행 | 150+ 선 → ≤10 선 |
| G2 | `jest` 47 테스트 2 실패 | 200+ 라인 → 실패를 모두 유지 + 요약 |
| G3 | `vitest` `--reporter=verbose`로 실행 | 300+ 선 → ≤15 선 |
| G4 | `pytest` 수집을 실행 | 실패 추적을 보존 |
| G5 | `cargo test` 1개의 공황 |  ⁇  위치 보존 동사 |
| G6 | `go test -v` 200개의 subtests 통과 | collapse to `PASS: 200 subtests` |
| G7 | `git diff` 파일에 2개의 덩크가 500개의 선의 컨텍스트로 | hunks, 드롭 컨텍스트를 유지 |
| G8 | `git log -50` | SHA + 주제 + 저자, 드롭 바디 |
| G9 | `git status` 30개의 수정된 파일 | 그룹으로 directory |
| G10 | `pnpm install` 신선한 | 최종수정 + 경고; 해결된 패키지 |
| G11 | `pip install -r requirements.txt` | 드롭 다운로드 진행; 최종 설치 목록 + 오류 유지 |
| G12 | `cargo build` 성공 | 드롭 컴파일 진행; 최종 대상 유지 |
| G13 | `docker build` 성공 | 드롭 레이어 끌어; 최종 이미지 digest 유지 |
| G14 | `tsc --noEmit` 청소 | `tsc: 0 errors`에 콤팩트 |
| G15 | `tsc --noEmit` 3 오류 | 위치와 모든 3 오류 유지 |
| G16 | `eslint .` 청소 | `eslint: 0 problems`에 콤팩트 |
| G17 | `eslint .` 위반 | 그룹 규칙; 보존 위치 + 수정 제안 |
| G18 | 1000 반복 선을 가진 `docker logs -f` | 조사를 가진 dedupe: `[last message repeated 973 times]` |
| G19 | `kubectl get pods -A` | 그룹 by namespace |
| G20 | `ls -la` 깊은 나무 | 디렉토리 그룹화 (RTK 패턴) |
| G21 | `find . -type f` 10K 파일 | 그룹 확장으로 counts |
| G22 | `grep -r "foo" .` 와 500 조회 | cap at 50; suffix `[... 450 more matches; use --ripgrep for full]` |
| G23 | `curl -v https://api.example.com` | 지구 verbose 우두머리; 응답 몸을 지킵니다 |
| G24 | `aws ec2 describe-instances` 50개의 인스턴스 | 열 요약 |

### P-series: 병리학적인 사례 (근 NOT는 에이전트을 끊습니다)

이 차례로 "nice feature" 으로 "catastrophic regression" 우리가 잘못 된 모든 것을 얻을 경우.

| ID | 팟캐스트 | 관련 기사 |
|----|----------|-------------------|
| P1 | 출력의 바이너리 쓰레기 (non-UTF8 바이트) | 변경되지 않고 통과하지 마십시오. 충돌하지 마십시오. |
| P2 | ANSI 방사 폭발 (10K+ 코드) | 깨끗하게 스트립, choke regex하지 마십시오 |
| P3 | 빈 출력 (`""`) | 빈을 통해 전달; NOT 주사 헤더 |
| P4 | Stdout+stderr 은폐 | 모두의 스트림에 따라 규칙 일치 |
| P5 | 출력 (SIGPIPE 중류) | 잘못된 부분 출력을 하지 마십시오 |
| P6 | **실패 테스트, 200 라인의 긴 스택 프레임** | NOT 프레임 필터 (RTK-killer case) |
| P7 | 0번 출구로, 출력에서 `ERROR:` | 규칙은 혼자서 출구 코드를 신뢰하지 않아야 합니다 |
| P8 | 산출은 AWS 열쇠/곰꾼 token/암호를 포함합니다 | 티 파일은 NOT 세계 읽기가되어야 합니다; 압축된 산출에 있는 redact |
| P9 | 단선 분량 JS 과실 (40KB 1 선) | 1KB에 대해 간략한 설명; `[... truncated ...]` |
| P10 | 유니코드 (emoji, RTL, chars, CJK) | Byte-safe truncation; 코드 포인트를 분할하지 마십시오 |
| P11 | 두 가지 규칙은 동일한 명령과 일치합니다. | 신분 우선순위: 가장 긴 `match.commands` 접두사 승리; 동점 → 규칙 ID 알파벳 |
| P12 | 규칙의 압축 된 출력은 다른 규칙의 패턴을 일치 | No 재수집 응용 프로그램; 걸이는 도구 통화 당 한 번 달 뛰습니다 |
| P13 | 명령은 인용 된 arg에 내장 된 신라인이 포함되어 있습니다. | 규칙은 잘못하지 않습니다. args |
| P14 | 동시 도구 호출 (parallel Bash invocations) | No 훅에서 공유된 점적 상태; 각 호출은 격리됩니다 |
| P15 | 후크 실행 >5s | 원료를 통과하십시오; 방출 `meta.timedOut: true` |
| P16 | 하이쿠 API 오프라인/rate-limited | 똑똑하게 건너뛰기; 순수한 규칙 산출을 사용하십시오 |
| P17 | Haiku는 변형 된 JSON를 반환 | 배압기; do NOT 에이전트에 익지않는 응답을 먹이십시오 |
| P18 | Haiku 응답은 신속한 주사 (`"Ignore all prior instructions..."`)를 포함합니다 | Sanitize: 원래의 원시 출력의 하위 문자열 일치는 단지 부트 라인 |
| P19 | 1M 선 산출 | Stream-process, 64MB의 캡 메모리; 맑게함으로 truncate |
| P20 | Rapid-fire: 50 도구 호출 / SEC | 후크 레이턴시 체류 <15ms p99 |
| P21 | 쉘 리디렉션 명령 (`cmd >file 2>&1`) | 아래 명령어 이름에 일치하지 않고 리디렉터 래퍼가 아닌 |
| P22 | 명령 문자열에서 /escapes을 곱합니다. | 튼튼한 arg 파서; no 포탄 주입 가능 |
| P23 | NULL 출력에 바이트 | 안전 지구; truncate는 하지 않습니다 |
| P24 | 종료한 명령은 stderr 로 더 많은 것을 씁니다. | Hook은 최종 결합 출력을받습니다. 우아한 핸들 |
| P25 | 읽기 전용 파일시스템 / no 티 쓰기 권한 | 분명히 말하십시오; 아직도 압축된 산출을 방출하십시오; `meta.teeFailed: true`를 기록하십시오 |
| P26 | 사용자의 규칙 JSON는 변형됩니다 | 규칙을 훔치는; stderr에 경고를 방출; 틈 걸이 |
| P27 | 규칙은 비 유능한 원시적 필드를 참조합니다. | Ignore unknown field; 규칙의 나머지를 적용 |
| P28 | 규칙 regex는 catastrophic backtracking를 비치하고 있습니다 | RE2- 호환 엔진 (no 백트랙) OR per-rule timeout |
| P29 | 코드 137번 출구 (OOM kill) | 규칙은 일반적인 실패와 동일합니다; 가득 차있는 산출을 보존합니다 |
| P30 | Haiku는 선을 반환합니다 NOT는 익지않는 산출 (hallucination)에서 선물합니다 | Drop Hallucinated 라인; 단지 substring 일치 유지 |

### CH-시리즈: 크로스 호스트 E2E

각 지원된 호스트의 각 시나리오를 실행합니다. 동일한 입력, 동일한 예상 출력. 호스트가 일치를 지원하지 않는 경우, 테스트는 업스트림 제한을 연결하는 코멘트 `skip-on-{host}`로 표시됩니다.

| ID | 팟캐스트 | 의정부 |
|----|----------|-------|
| CH1 | `gstack compact install <host>`를 통해 걸이를 설치하십시오 | Claude Code, Codex, OpenClaw |
| CH2 | Uninstall Hook은 idempotent입니다. | 의 모든 |
| CH3 | 재설치는 중복 항목이 없습니다. | 의 모든 |
| CH4 | 사용자의 다른 PostToolUse 걸이와 걸이 co-exists | 의 모든 |
| CH5 | Bash 도구에 걸이 불 | 의 모든 |
| CH6 | 읽힌 도구에 걸이 불 | Claude Code (확인); Codex/OpenClaw 확인 후 |
| CH7 | 그랩 도구에 훅 화재 | CH6와 같 |
| CH8 | Glob 도구에 후크 화재 | CH6와 같 |
| CH9 | MCP 도구에 후크 화재 (`mcp__*` matcher) | Claude Code; 다른 사람에 확인 |
| CH10 | Config precedence: 프로젝트 > 사용자 > 내장 | 의 모든 |
| CH11 | `GSTACK_RAW=1` env var 바이패스 후크 | 의 모든 |
| CH12 | 규칙 ID override 작품 (프로젝트 규칙은 내장을 대체합니다) | 의 모든 |
| CH13 | `gstack compact doctor` 각 호스트에 드리프트를 감지 | 의 모든 |
| CH14 | Hook error는 에이전트 세션을 충돌하지 않습니다. | 의 모든 |

구현 참고 : 크로스 호스트 테스트는 `golden/` 나무에서 정착물 손상을 재사용; 마구는 호스트 별 후크 인발 봉투에 각 고정물을 감싸고 출력을 무시합니다 (`host` 필드를 모방).

## V-series: 정선 테스트 (유료)

| ID | 팟캐스트 | Expected |
|----|----------|----------|
| V1 | 규칙은 5개의 선, Exit=1에 200 선 시험 산출을 감소시킵니다 | Verifier Fires (failure + >50% 감소), 누락 된 긴요한 선을 추가 |
| V2 | 규칙은 9개의 선, Exit=1에 10 선 산출을 감소시킵니다 | Verifier는 NOT 불 (소형 감소) |
| V3 | 규칙은 5개의 선, Exit=0에 200 선 산출을 감소시킵니다 | Verifier는 NOT 불 (교육 경로, default 구성) |
| V4 | `aggressiveReduction` 방아쇠 활성화, 300의 선 → 20의 선, exit=0 | 불꽃놀이 |
| V5 | `GSTACK_COMPACT_VERIFY=1` env var set(수입) | 그 호출에 한 번의 불 |
| V6 | `ANTHROPIC_API_KEY` 누락 | Verifier가 자동으로 건너 뛰었습니다. 원료의 출력이 반환되었습니다. |
| V7 | "NONE"를 반환하는 정박한 정박 | Pure-rule 경로와 동일하게 출력 |
| V8 | Verifier는 신속한 주입을 돌려줍니다. | 주입 discarded; 단지 substring 일치한 선 부록 |
| V9 | 정박식 >5s | 드리프트; `meta.verifierTimedOut: true` |
| V10 | 500 오류를 반환하는 Verifier | Skipped; 규칙 산출은 돌려보냅니다 |

## R-series: 모험 회귀

v1 배가 영구 R 시리즈 테스트를 얻은 후 모든 버그가 잡았습니다. 빈번한 시작; 흉터로 성장합니다. 템플릿:

```
R{N}: {commit-sha} — {1-line summary}
Scenario: {reproducer}
Fix: {PR link}
```

### 성능 예산 (CI; 현실적인 Bun 냉전을 위해 개정하는)

| Metric | 의논하기 | 단단한 한계 |
|--------|--------|-----------|
| 걸이 머리 위 macOS ARM (번쩍이는) | <30ms p50> | <80ms p99> |
| 걸이 오버 헤드 Linux (번쩍이는) | <20ms p50>(으)로 | <60ms p99> |
| 훅 오버 헤드 (버터 불) | <600ms p50>의 경우 | <2s p99> |
| 탈선을 묶으십시오 (rules.bundle.json) | <2ms> | <10ms |
| mtime drift check (소스 파일의 통계) | <0.5ms> | <3ms> |
| Single-regex 실행 예산 (레벨당) | <5ms> | <50ms (하드 복스) |
| Hook invocation(라인스트림) 당 메모리 | <16MB 전형 | 최대 <64MB |
| 디스크에 총 규칙 탑재량 크기 (source file) | <5KB> | <15KB> |
| 디스크에 묶인 번들 크기 | <25KB> | <80KB> |

daemon 모드는 v2 최적화입니다. 저자의 파푸 쇼에 B 시리즈 벤치 마크가 콜드 스타트가 의미적으로 세션 총 절감을 상처 (예 : 총 후크 오버 헤드 >5% 저장 토큰의 벽 시간), v1.1에 촉진.

## B 시리즈 실제 벤치 마크 테스트 벤치 (하드 v1 게이트)

**왜 존재한다.** 각 competing 소형 배는 손으로 한 정착물 수로를 배웁니다. B 시리즈는 사용자가 걸이를 가능하게 하기 전에 사용자 *의 의* 기호화 회의에 조밀하게 작동한다는 것을 증명합니다. 그것은 배 문과 마케팅 artifact 둘 다입니다.

**아키텍처** (`compact/benchmark/src/`의 성분):

```
┌──────────────────────────────────────────────────────────────┐
│  1. SCAN     scanner.ts walks ~/.claude/projects/**/*.jsonl  │
│              → pairs tool_use × tool_result blocks           │
│              → emits {tool, command, outputBytes, lineCount, │
│                estimatedTokens, sessionId, timestamp}        │
├──────────────────────────────────────────────────────────────┤
│  2. RANK     sizer.ts sorts corpus by estimatedTokens desc   │
│              → cluster.ts groups by (tool, command-pattern)  │
│              → identifies heavy-tail: which 10% of calls     │
│                produced 80% of the tokens?                   │
├──────────────────────────────────────────────────────────────┤
│  3. SCENARIO scenarios.ts emits fixture files:               │
│              B1_bun_test_heavy.jsonl                         │
│              B2_git_diff_huge.jsonl                          │
│              B3_tsc_errors_production.jsonl                  │
│              B4_pnpm_install_fresh.jsonl ... (one per        │
│              high-leverage cluster, up to ~20 scenarios)     │
├──────────────────────────────────────────────────────────────┤
│  4. REPLAY   replay.ts runs compactor against each scenario, │
│              measures token reduction + diff of dropped lines│
│              → per-rule reduction numbers                    │
│              → per-scenario before/after token counts        │
├──────────────────────────────────────────────────────────────┤
│  5. PATHOLOGY pathology.ts injects planted critical lines    │
│              (line 4 of 200 in a failing test fixture) into  │
│              real B-scenarios. Confirms verifier restores    │
│              them. Real data + real threats = real proof.    │
├──────────────────────────────────────────────────────────────┤
│  6. REPORT   report.ts emits HTML + JSON dashboard to        │
│              ~/.gstack/compact/benchmark/latest/              │
│              "On YOUR 30 days of Claude Code data, gstack    │
│              compact would save X tokens in Y scenarios."    │
└──────────────────────────────────────────────────────────────┘
```

**v1 배 문 (하드):**
- 저자의 자신의 30 일 성적표에 총계 달성된 시나리오 손상의 맞은편에 ≥15% 총 달성 감소.
- Planted-bug 시나리오에 대한 Zero Critical-line 손실 (모든 심층적 인 스택 프레임은 규칙 또는 정적을 살아야 함).
- No 시나리오는 새로운 규칙의 밑에 <5% 감소를 회귀합니다 (작동 가장자리 상자).

**개인정보 (non-negotiable):**
- `~/.claude/projects/**/*.jsonl` 로컬로 읽어 보세요. 절대 업로드하지 마십시오. 절대 공유하지 마십시오. 대칭을 읽지 마십시오.
- 출력 파일 모드 `0600`와 `~/.gstack/compact/benchmark/`에서 라이브.
- 명령은 확인 배너를 인쇄합니다. *"~/.claude/projects/ (local-only; 이 기계를 나타낸 것은 아닙니다)"*
- 미래의 커뮤니티 코푸는 손분해, OSS 프로젝트의 비밀분해된 고정물에서 건설된 별도의 v2 작업스트림입니다.

**analysis_transcripts (TypeScript의 재조정; 하위 처리 호출이 아닌)의 포트:**
- JSONL 파싱 + 도구_/tool를 사용_result 페어링 패턴 (`event_extractor.rb`).
- 토큰 견적 `ceil(len/4)` (사임 숯-ratio heuristic; 순위에 충분).
- 이벤트 타입의 세무성(`bash_command`, `file_read`, `test_run`, `error_encountered`), 시나리오 클러스터링.
- 병원층의 스트레스 고정형 패턴.

**우리가 NOT 항구를 하는 무슨:** 행동 득점, pgvector embeddings, 결정 교환 도표, 각측정속도 미터, Rails/ActiveRecord 층. 범위의 밖으로; 우리가 측정하는 것은 아닙니다.

### 합성 토큰 절약 evals (E-series, periodic/informational 전용)

원래 플랜에서 유지하지만 이제 B 시리즈가 실제 게이트이기 때문에 정보 만.

- **E1:**는 중간 TypeScript 프로젝트에서 30 분 코딩 세션을 시뮬레이션했습니다. /without gstack 콤팩트 활성화를 가진 총 토큰을 측정하십시오. 표적: ≥15% 감소.
- **E2:** `level=aggressive`에 동일한 회의. 표적: ≥25% 감소, 0 시험 실패 증가.
- **E3:** `failureCompaction`에서만 verifier와 동일한 세션. 도구 호출의 수화기 불 비율 ≤10%.
- **E4:** adversarial — 테스트 출력에 심어 놓은 버그를 주사하고 정적 스택 프레임을 복원합니다.

### 시험 corpus sourcing

각 규칙 가족을 위해, 3+ 진짜 산출을 붙잡으십시오:

1. 실제 프로젝트에 대한 도구를 실행 (gstack TS; Rust/Go/Python).
2. stdout+stderr+exit 코드를 `toolVersion:` frontmatter (e.g., `jest@29.7.0`)로 고정 파일로 붙잡습니다.
3. 한 번에 예상되는 압축된 산출을 손으로 하십시오.
4. Golden file test: 은 byte-identical output을 생성해야 합니다.
5. CI 경고: 설치된 도구 버전이 정착물의 `toolVersion:`, CI 경고에서 다를 경우에. Drift-warning 대쉬보드는 미리 풀어 놓입니다.

Draw에서:
- Tokenjuice의 고정 디렉토리 패턴 (`tests/fixtures/`)
- RTK의 per-command 예제 (README 목록 실제 앞에/after 미터; 자주적으로 확인)
- gstack의 자체 테스트 출력 (우리의 자신의 개 음식을 먹으십시오)
- `~/.gstack/compact/tee/` (입사지원금 지원)
- **B-series 실제 시나리오는 감소 측정을 위한 1 차적인 corpus입니다.**

## 패턴 채택 테이블

경쟁적인 풍경에서 본 콘크리트 빌린:

| 으로 | 으로 | 이유 |
|------|----------|-----|
| RTK | 4개의 감소 원시 (filter/group/truncate/dedupe) as JSON 규칙 동사 | 심각한 조밀함을 위한 표 지분 |
| RTK | `gstack compact tee` 실패 형태 익지않는 득점방해를 위해 | 원래 `onFailure.preserveFull` 디자인보다 더 나은 |
| RTK | `gstack compact gain` + `gstack compact discover` | 신뢰 + 지속적인 개선 |
| RTK | `exclude_commands` per-user 차단 | config를 컴파일 |
| 토큰쥬스 | JSON 후크 I/O를 위한 봉투 계약 | Clean 기계 어댑터 |
| 토큰쥬스 | `gstack compact doctor` | Hooks 편류; 자기 수리 문제 |
| 강릉출장샵 | 인텐스 레벨 (minimal/normal/aggressive) | 사용자 튜닝 안전/savings 손잡이 |
| claude-token-efficient의 이점 | 규칙 파일 크기 예산 (<5KB 합계) | bloat 컨텍스트가 없습니다. |

## 롤아웃 플랜

**ALL PHASES TABLED 보류 Anthropic `updatedBuiltinToolOutput` API.** 이 문서의 상단에 상태 섹션을 참조하십시오. 아래 롤아웃은 /when API 배와이 디자인의 불안정한 경우의 의도한 순서입니다.

### Un-tabling checklist (API가 도착했을 때 순서로)

1. **새로운 API의 모양을 확인합니다.** 업데이트된 Claude Code 걸이 참고를 읽으십시오. Bash, 읽기, Grep, Glob를 위한 새로운 산출 대체 분야를 포함하는 진짜 봉투를 붙잡으십시오. `docs/designs/GCOMPACTION_envelope.md`에 있는 기록.
2. **쐐기를 재 유효성.** 새로운 API 덮개 Read/Grep/Glob (지금 `PostToolUse`를 불도우십시오), 또는 Bash/WebFetch? Bash-only 경우에, 쐐기 (ii)는 죽은 이고 제품은 새로운 피치를 실행하기 전에 필요로 합니다.
3. **재 실행 `/plan-eng-review`**는 새로운 API를 가진 개정된 계획에 대하여. 15의 고정된 결정의 대부분은 앞으로 나아야 합니다; 건축 자료 교류를 조정하고 어떤 봉투 의존하는 결정.
4. **재 실행 `/codex review`**는 개정된 계획에 대하여. 이전 BLOCK는 걸이 대용에 관하여 의문은 API가 존재한다; 나머지 긴요한 (B 시리즈 개인 정보 보호, regex DoS, JSON-envelope 스트리밍) 아직도 적용합니다.
5. **아래에서 원래 롤아웃을 실행합니다.**

### Original rollout (무선에 대한 예약)

모든 게이트 계층 테스트를 통과하는 각 계층 블록. Claude-first — Codex 및 OpenClaw 쐐기가 기본 호스트에서 입증 된 후 v1.1에 착륙.

1. **v0.0 (1 일):** 규칙 엔진 + 4 primitives + 선 중심 스트리밍 파이프라인 + 깊은 - merge + 번들 컴파일러 + envelope 계약 + 황금 테스트 `tests/*` 가족 전용. No 호스트 통합 아직. 오프라인 정착물에 대한 절감.
2. **v0.1 (1 일):** Claude Code 걸이 통합 + `gstack compact install` + mtime 기반 자동 부하. 선택에서 배; 기본적으로 떨어져. 그것을 시도하는 10 gstack 힘 사용자를 물어; 의견을 모으십시오.
3. **v0.5 (1 일):** B 시리즈 벤치 마크 테스트 벤치 (`compact/benchmark/`). 배 `gstack compact benchmark` 그래서 사용자는 자신의 데이터를 측정할 수 있습니다. 익명의 -에서 - 스타트 (노스팅 업로드) 개 식품의 감소 번호 수집.
4. **v1.0 (1 일):** 베터링 레이어 `failureCompaction` 트리거 default + 정확한 라인 매치 질화 + 레이어로 종료코드/pattern fallback + 확장된 티 액화 세트. **단단한 배 문:** 저자의 30 일 로컬 코푸스 쇼 ≥15% 총 감소 AND 0개의 임계 값 손실에 대한. 쐐기 짜맞추는 (<7ph>)와 주요한 CHANGELOG 항목 (<7ph> v1).1.
5. **v1.1 (+1 일):** Codex + OpenClaw 걸이 통합. 크로스 호스트 E2E 스위트 그린. Build/lint/log 규칙 가족 토지 `gstack compact discover`- 파생 우선 순위.
6. **v1.2+:**는 규칙 가족, 지역 B 시리즈에서 분리되는 지역 B-series에서 규칙 기여 워크플로우, 지역 사회 중심 벤치 마크 (hand-authored public 정착물)를 확장합니다.

## 위험 분석

| 위험 위험 | 의욕 | 관련 기사 |
|------|----------|------------|
| RTK 응답에 LLM verifier 추가 | 의 의 | Creator는 Zero-dependency Rust에 대해 보컬어. 첫 번째 배, 패턴 라이브러리를 구축합니다. |
| 플랫폼 조밀함은 Claude Code에서 (Anthropic Compaction API)를 대체합니다. | 의 의 | 우리는 다른 층 (각각각각 출력 대 전체 텍스트)에서 작동. 보완으로 위치. |
| 규칙은 중요한 무언가를 떨어뜨립니다 → "복사는 내 에이전트 dumb를 만들었습니다" | High | B-series는 하드 배 게이트로 실제 세계 벤치 마크; 티 모드는 항상 사용할 수; 실패를 위한 과태에 과태; 정확한 선 배치 위생. |
| Haiku 비용 크레프 (가구보다 더 많은 불을 떨어뜨릴 것) | 의 의 | E3 eval + B 시리즈 불 비율 미터; `gstack compact gain`에서 볼 비용; 비율 >10%가 v1.1에 있는 각 소유 비율 모자. |
| 규칙 유지 부채 (jest/vitest 출력 형식 변경) | 의 의 | `toolVersion:` 정착물 frontmatter + CI 무인 경고; 지역 규칙 PRs; `discover` 깃발 우회 명령. |
| 규칙 파일 bloats context | 의 의 | CI- 강화된 <5KB 소스 + <25KB 컴파일된 번들 예산; schema-validation에 per-rule 크기 경고. |
| Regex DoS는 에이전트을 막습니다 | 의 의 | 50ms Abort법당의 예산; timeout은 `meta.regexTimedOut`; 반복 실패에 정당화 된 규칙에 기록. |
| 번들 staleness 조용히 휴식 사용자 편집 | 의 의 | 각 걸이 invocation 자동 재건에 mtime-check; `gstack compact reload`는 지원이 필요조건 아닙니다. |
| Benchmark 누출 사용자의 개인 데이터 | High | 건설에 의해 로컬 전용 : no 네트워크 전화, mode-0600 출력, 정적 배너 실행 시간에. v1 배의 앞에 개인 리뷰. |

## 질문 열기

1. ~~Codex의 Read/Grep/Glob를 위한 PostToolUse 걸이 지원 matchers?~~ (v1.1에 deferred — v1에 Claude-first.)
2. ~~OpenClaw의 후크 API 지원 PostToolUse 특히?~~ (v1.1에 나타낸.)
3. 정류기 모델이 핀으로 덮여있거나 gstack의 다른 AI 호출과 같이 버전 추적해야 하나요? (`claude-haiku-4-5-20251001`를 핀으로 엮어 CHANGELOG에서 명시적으로 범프로 덮어 봅니다.)
4. ~~Built-in secret-redaction regex set for tee files~~ **( 해결: 확장 세트 — AWS/GitHub/GitLab/Slack/JWT/bearer/SSH-private-key. 결정 #10.)**
5. `gstack compact discover`는 Haiku를 통해 자동 생성된 규칙을 제안합니까? (v2에 철거하십시오; 기술 크리프 위험.)
6. **새로운:** Claude Code의 PostToolUse 봉투는 `exitCode`를 포함합니까? (이전 작업 #1 당 empirical 검증을 필요로 합니다; 체계에는 지금 층이 없는 돌진된 돌진이 있습니다.)
7. **새로운:** B 시리즈의 오른쪽 시나리오 카운트 캡은 무엇입니까? Cluster.ts는 5-50 대의 시나리오를 중세형에 따라 생성할 수 있습니다. 계획 : 총 출력량으로 20 대의 클러스터에서 캡.

## 사전-implementation 할당 (코드 코딩 전에 완료)

1. **Claude Code의 PostToolUse envelope 내용이 적정하게 검증합니다.** 배 no-op 걸이; `exitCode`, `command`, `argv`, `combinedText`는 모두 선물됩니다. 이것은 실패를 위한 쐐기 (ii) 원동 도구 적용 AND를 위한 pivot입니다. 산출: `docs/designs/GCOMPACTION_envelope.md`를 가진 진짜 붙잡힌 봉투를 가진 Bash + Grep + Glob를 읽으십시오.
2. **RTK의 규칙 정의 읽기** (`ARCHITECTURE.md`, `src/rules/`)를 입력하고 4개의 원시의 1개의 트로피 요약을 작성하여 가장 잘 처리합니다. 우리의 v1 규칙 세트를 Inform하십시오. 이것은 층을 건축하기 전에 수색입니다.
3. **포트 분석_transcripts JSONL 파서에서 TypeScript로 변환합니다.** `compact/benchmark/src/scanner.ts`. 저자 `~/.claude/projects/`에 가장 중요한 도구 통화를 나열하는 빠른 전망 산출을 씁니다. 우리가 재생 반복을 건설하기 전에 testbench premise를 확인하십시오. 이것은 B 시리즈 기초입니다.
4. **CHANGELOG 항목 FIRST를 작성합니다.** 대상 문장: *"모든 도구에서 에이전트의 도구 상자에 Claude Code 이제는 더 적은 소음을 생산합니다 - 테스트 런너, git diffs, 패키지 설치 - 우리의 규칙이 오버컴이 될 때 중요한 스택 프레임을 복원하는 지능형 Haiku 안전 그물과 로컬 벤치 마크 코딩 세션의 실제 30 일에 절약을 증명합니다. Codex + OpenClaw v1.1의 토지."* 우리가 솔직히 문장을 쓸 수 없는 경우, 쐐기는 아직 없습니다.
5. **규칙 전용 v0을 발송** (no Haiku verifier, no benchmark). 현재 gstack evals + Early B-series prototype을 사용하여 실제 token 절감을 측정합니다. <10% 현지 corpus에서 전체적인 전제는 주장보다 약합니다.

## 라이센스 및 권한

gstack는 MIT의 밑에 발송합니다. 허가를 내리는 것을 지키기 위하여는, 이 프로젝트는 경쟁적인 조경에서 빌린 모든 것을 위한 엄격한 청정실 정책을 따릅니다:

- **위 각 프로젝트는 permissive-licensed입니다** (MIT 또는 Apache-2.0). No AGPL, GPL, SSPL, 또는 다른 복사열 노출.
  - RTK (rtk-ai/rtk): **아파치 2.0** — MIT-compatible; Apache 특허 보조금은 저희를 위한 보너스입니다.
  - 토큰쥬이스, 동굴맨, claude-token-efficient, 토큰-optimizer-mcp, sst/opencode: **MIT**.
- **패턴, 코드가 없습니다.** 우리는 그들이 해결하고 왜 이해하기 위하여 이 프로젝트를 읽었습니다. 우리는 `compact/src/` 안쪽에 TypeScript에서 자주적으로 실행합니다. 우리는 근원 파일을, 번역 근원 파일 선 선 선 선을 위해, 또는 상승 시험 정착물 verbatim를 복사하지 않습니다.
- **관련 기사** 패턴이 직접 빌려있는 곳 (RTK, JSON envelope from tokenjuice, caveman, claude-token-efficient의 규칙 파일 크기 예산에서 강도 수준), 우리는 의견에 소스 인라인을 신용하고 위의 "Pattern 채택 테이블". 프로젝트의 `README` 및 `NOTICE` 파일 (하나를 추가하면) 영감 목록.
- **정착물 sourcing.** 골든 파일 고정장치는 실제 프로젝트에 대한 실제 도구를 실행 중부터 온다. 그들은 RTK 또는 Tokenjuice에서 수입되지 않은 우리의 자신의 캡처입니다. 이것은 라이센스 - 엉뚱한 콘텐츠의 테스트 손상을 유지합니다.
- **Forbidden 소스.** 새 참조 프로젝트를 추가하기 전에 `gh api repos/OWNER/REPO --jq '.license'`를 실행하고 라이센스 키가 하나 인 `mit`, `apache-2.0`, `bsd-2-clause`, `bsd-3-clause`, `isc`, `cc0-1.0`, `unlicense`의 인증 키를 확인합니다. 프로젝트가 no 라이센스 필드를 가지고 있다면, "all rights reserved"로 그것을 취급하고 그에서 그리지 마십시오. `agpl-3.0`, `gpl-*`, `gpl-*`, 또는 사용자 정의 소스.

CI 시행: `scripts/check-references.ts` 스크립트는 `docs/designs/GCOMPACTION.md`를 GitHub URL로 파고, 라이센스 체크를 재 실행하고, 참조된 프로젝트의 라이선스가 허용 목록에 이동하면 실패합니다.

## 참고

- [RTK (Rust 토큰 킬러) - rtk-ai/rtk](https://github.com/rtk-ai/rtk)
- [RTK 문제 #538 - 기본 간격](https://github.com/rtk-ai/rtk/issues/538)
- [토큰쥬이스 — vincentkoc/tokenjuice](https://github.com/vincentkoc/tokenjuice)
- [동굴만 — juliusbrussee/caveman](https://github.com/juliusbrussee/caveman)
- [claude-token-efficient - 무소속23](https://github.com/drona23/claude-token-efficient)
- [토큰 최적화기 - mcp - ooples](https://github.com/ooples/token-optimizer-mcp)
- [6 층 토큰 저장 스택 — doobidoo gist](https://gist.github.com/doobidoo/e5500be6b59e47cadc39e0b7c5cd9871)
- [Claude Code 걸이 참고](https://code.claude.com/docs/en/hooks)
- [Chroma 컨텍스트 rot 연구](https://research.trychroma.com/context-rot)
- [Morph: 왜 LLMs는 Context로 향상합니다](https://www.morphllm.com/context-rot)
- [Anthropic Opus 4.6 Compaction API — InfoQ](https://www.infoq.com/news/2026/03/opus-4-6-context-compaction/)
- [OpenAI 압축 문서](https://developers.openai.com/api/docs/guides/compaction)
- [Google ADK 컨텍스트 압축](https://google.github.io/adk-docs/context/compaction/)
- [LangChain 자율적 인 맥락 압축](https://blog.langchain.com/autonomous-context-compression/)
- [sst/opencode 컨텍스트 관리](https://deepwiki.com/sst/opencode/2.4-context-management-and-compaction)
- [DEV: 세례 대 LLM 증발기 — 2026 무역 떨어져 학문](https://dev.to/anshd_12/deterministic-vs-llm-evaluators-a-2026-technical-trade-off-study-11h)
- [MadPlay: RTK 80% token 감소 실험](https://madplay.github.io/en/post/rtk-reduce-ai-coding-agent-token-usage)
- [에스테바 Estrada: RTK 70% Claude Code 감소](https://codestz.dev/experiments/rtk-rust-token-killer)

**GCOMPACTION.md canonical 단면도의 끝.** 계획 승인에, 위의 모든 것은 **테이블 디자인 artifact**로 `docs/designs/GCOMPACTION.md`에 동사막을 복사됩니다. No 코드는 쓰입니다; no 걸이는 설치됩니다; no CHANGELOG 입장은 추가됩니다. doc는 Anthropic가 붙박이 발판 산출 장소 API를 발송할 때 미래 sprint가 빨리 막을 수 있습니다.
