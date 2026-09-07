# Spike : Codex 계획 - 톤 성당을위한 세션 저장 형식

**상태:** 완료 (2026-05-27) **표면:** D5 (Codex 가져오기 구조화 된 파일, regex하지 않음) **Downstream 소비자:** T9 (gstack-codex-session-import)

## 이 스파이크 답변

Codex 세션의 실제적인 on-disk 형식이며, `gstack-codex-session-import`의 AskUserQuestion-shaped 이벤트를 어떻게 복구합니까?

## 저장 배치

```
~/.codex/
├── auth.json                     # Codex auth (do not touch)
├── config.toml                   # User config
├── goals_1.sqlite                # ~24KB, internal goals DB (not relevant)
├── logs_2.sqlite                 # ~16MB, structured logs (target=*, see schema)
├── history.jsonl                 # ~9KB, command history
└── sessions/
    └── 2026/05/27/
        └── rollout-<iso8601>-<uuid>.jsonl   # per-session transcript
```

세션 파일: `codex exec` 또는 대화식 세션 당 JSONL. `session_meta` 이벤트에 내장된 Cwd 경로. CLI 버전 기록.

## Session JSONL 이벤트 타입 (가리의 기계, 2026-05-27에 측정)

| type           | count | 이름 * |
|----------------|------:|---------|
| `response_item`|   382 | 모델의 응답 스트림 (~76%) |
| `event_msg`    |    97 | 고수준 세션 이벤트 (~19%) |
| `turn_context` |     6 | per-turn 컨텍스트 스냅샷 |
| `session_meta` |     6 | 세션 헤더 ( 세션당 1개) |

### response_item 서브타입

| subtype                  | count | 이름 * |
|--------------------------|------:|---------|
| `function_call`          | 148   | 모델 invoked a 도구 |
| `function_call_output`   | 148   | 도구 결과가 모델로 돌아 |
| `reasoning`              |  44   | 관련 기사 |
| `message`                |  40   | 텍스트 메시지 (input_텍스트 또는 출력_text) |
| `web_search_call`        |   2   | 웹 검색 도구 호출 |

## event_msg 서브타입

| subtype           | count | 이름 * |
|-------------------|------:|---------|
| `token_count`     | 55    | per-step 토큰 회계 |
| `agent_message`   | 22    | 에이전트의 prose 출력 |
| `user_message`    |  6    | 사용자의 prose 입력 |
| `task_started`    |  6    | 작업 시작 (상급 작업 당 1) |
| `task_complete`   |  6    | 작업 완료 |
| `web_search_end`  |  2    | 웹 검색 완료 |

## 긴요한 발견: Codex에는 `AskUserQuestion` 도구가 없습니다

Codex는 `response_item` 스트림의 도구 호출으로 AskUserQuestion를 표면 AskUserQuestion를 사용하지 않습니다. Codex에서 실행되는 Gstack 기술은 AskUserQuestion 모양 결정적인 뇌물을 `agent_message` 사건 (예를들면 `AskUserQuestion Format`) 안쪽에 묶습니다. 사용자의 대답은 다음 `user_message`에서 돌아옵니다.

This means importing AUQ events from Codex sessions is structurally different from importing them from Claude Code (where they ARE tool calls):

- **Claude Code:** 걸이는 구조상 `tool_input`/`tool_output`를 붙잡습니다
  `AskUserQuestion`. 문제 + 옵션 + 모두 분리된 응답.
- **Codex:** 파서는 `agent_message.text` 몸에서 추출해야 하고, 검출합니다
  D-numbered Decision Brief 패턴은, 그 후 `user_message` 응답에 대한 일치합니다.

## `gstack-codex-session-import`의 복구 전략

**2 층 추출:**

1. **Marker-first (D18 메커니즘).** 검색 `agent_message` 텍스트
   `<gstack-qid:foo-bar>` 마커. 현재, 우리는 정확한 질문_id가 있고 믿을 수 있는 회복을 할 수 있습니다. (일은 일단 T14는 마커를 상위 10개 레지스트리 질문과 Codex에 추가합니다 주인 인식 preamble 길을 통해 그(것)들을 방출합니다.)

2. **패턴 fallback.** 마커가 없을 때, 파스를 위해:
   - `D<N> — <title>` 라인 (AskUserQuestion 형식의 D-number)
   - `Recommendation: ...` 선
   - 선택권 구획 `A) ...`, `B) ...`, 등.
   - 다음 `user_message` 선택된 옵션 라벨 이벤트

   해시 기반 질문을 포용하는 것이만 사용_id (같은 `hook-<sha1(skill+text+sorted)_options)[:10]>` shape Layer 1 uses on Claude). Tagged `source: "codex-pattern-fallback"`, 절대 사용되지 않음(D18 해시 드립 안내).

## Schema 우리는 Codex 수입품에서 질문-log.jsonl에 쓸 것입니다

기존 `bin/gstack-question-log` 스키마 당, 증강 :
- `source: "codex-import-marker"` (Qid 감적 발견했을 때)
- `source: "codex-import-pattern"` (사용되는 가을 뒤 regex 때)
- `codex_session_id` (UUID 의 session_meta)
- `codex_cwd` ( session_meta에서 dir를 일 - 프로젝트의 디비게이션)
- `codex_ts` (행사에서 타임 스탬프)

## Sqlite 로그_2.sqlite 스키마

```sql
CREATE TABLE logs (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  ts INTEGER NOT NULL,
  ts_nanos INTEGER NOT NULL,
  level TEXT NOT NULL,
  target TEXT NOT NULL,
  feedback_log_body TEXT,
  module_path TEXT,
  file TEXT,
  line INTEGER,
  thread_id TEXT,
  process_uuid TEXT,
  estimated_bytes INTEGER NOT NULL DEFAULT 0
);
```

`logs_2.sqlite`는 내부 telemetry, 세션 내용이 아닙니다. **AUQ 추출에 사용하지 마십시오.** 세션 JSONL는 권한이 있습니다.

## 프로젝트-slug 파생

`session_meta.payload.cwd` - cwd 경로에 기존 `bin/gstack-slug` 논리를 통해 파생됩니다. 지휘자 worktrees에는 cwd에 인코딩된 그들의 자신의 슬러그 남동 대회가 있습니다; 궤는 이미 이것을 취급합니다.

## 버전 안전

`session_meta.payload.cli_version`는 Codex CLI version (e.g. `0.130.0`)를 기록합니다. 수입자가 알 수없는 버전을 만날 때, stderr에 경고를 기록하지만 계속 - schema는 JSONL에서 일반적으로 뒤로 호환됩니다.

`type` 또는 `payload.type` 값이 미래 버전에서 변경되면, 수입인의 감사 로그에 `unknown`로 볼 수 있습니다. 재시험 시 수입 및 범퍼에 상수된 `KNOWN_VERSIONS = ["0.130.x", "0.131.x", ...]`를 상수합니다.

## 구현을위한 질문 열기

1. **Codex는 "user's Answer"를 정확히 저장합니까?** 시험 필요
   실제 `codex exec`는 Decision Brief를 트리거하고 다음 이벤트를 검사한다. `user_message` 또는 `message`의 `message`의 `message`의 T9 구현 중 T9 구현에서 확인한다.

2. **"기타"에 대한 무료 텍스트 추출.** 결정적인 간결
   구조상으로 분리되지 않습니다 “다른” 이름 선택권에서 응답. 본 fallback는 “다른 것을 검출할 필요가 있을 것입니다: <text>” 대답에서 낱말. T10 (꿈 주기 증류) 근원이 `codex-import-marker`일 때 이에 단지 불만 불은 자료를 신뢰해서 좋습니다.

3. **지휘자 cwd 취급.** 지휘자 worktrees는 프로젝트 국가를 공유합니다
   하지만 명백한 cwds가 있다. import는 프로젝트 슬러그에 의해 버킷 이벤트를 직접 쫓아서, 그래서 같은 프로젝트 보기로 축적된 작업 트리에서 이벤트를 sibling.

## 참고

- `~/.codex/sessions/2026/05/*/`의 실시간 검사
- `sqlite3 ~/.codex/logs_2.sqlite ".schema"` (2026-05-27)
- Codex CLI 0.130.0 (매우 매끄럽게)
- 참조 : D5 계획 파일에 크로스 모델 텐션 결정.
