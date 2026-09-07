# 지휘자 세션 스트리밍 API 프로포스

## 문제

Claude가 CDP(gstack `$B connect`)를 통해 실제 브라우저를 제어할 때, **의 GSM**(Claude의 생각을 보시려면) **Chrome**(Claude의 동작을 보시려면)를 참조해 주세요.

gstack의 Chrome 확장 사이드 패널은 검색 활동을 보여줍니다. - 모든 명령, 결과, 오류. 그러나 *full* 세션 미러링 (Claude의 생각, 도구 호출, 코드 편집)의 경우 사이드 패널은 대화 스트림을 노출하기 위해 지휘자가 필요합니다.

## 이 활성화된 것

gstack Chrome 확장 사이드 패널에서 "Session"탭을 표시합니다.
- Claude의 생각/content (성과를 위해 truncated)
- 도구 호출 이름 + 아이콘 (Edit, Bash, 읽기, 기타)
- 비용 견적과 경계
- 실시간 업데이트 대화 진행

사용자는 한 곳에서 모든 것을 볼 수 있습니다. - Claude는 브라우저에서 동작 + Claude는 창을 전환하지 않고 사이드 패널에서 생각합니다.

## Proposed API

### `GET http://127.0.0.1:{PORT}/workspace/{ID}/session/stream`

Server-Sent Events는 Claude Code의 NDJSON 이벤트로 재작성된 Claude Code의 대화를 의미합니다.

**이벤트 유형** (Claude Code의 `--output-format stream-json` 체재를 재사용하십시오):

```
event: assistant
data: {"type":"assistant","content":"Let me check that page...","truncated":true}

event: tool_use
data: {"type":"tool_use","name":"Bash","input":"$B snapshot","truncated_input":true}

event: tool_result
data: {"type":"tool_result","name":"Bash","output":"[snapshot output...]","truncated_output":true}

event: turn_complete
data: {"type":"turn_complete","input_tokens":1234,"output_tokens":567,"cost_usd":0.02}
```

**내용 truncation:** 도구 입력/outputs는 시내 500개의 숯에 넣었습니다. 가득 차있는 자료는 지휘자의 UI에 체재합니다. 측 패널은 보충이, 아닙니다입니다.

### `GET http://127.0.0.1:{PORT}/api/workspaces`

Discovery endpoint 목록 활성 작업 공간.

```json
{
  "workspaces": [
    {
      "id": "abc123",
      "name": "gstack",
      "branch": "garrytan/chrome-extension-ctrl",
      "directory": "/Users/garry/gstack",
      "pid": 12345,
      "active": true
    }
  ]
}
```

Chrome 확장 자동 선택은 검색 서버의 git repo (`/health` 응답에서) 작업 공간의 디렉토리 또는 이름과 일치하여 작업 공간에 맞게 선택됩니다.

## 보안

- **로컬호스트 전용.** Claude Code의 자신의 디버그 산출으로 동일한 신뢰 모형.
- **No auth는 요구했습니다.** 지휘자가 auth를 원하면 Bearer token를 포함하십시오
  workspace는 SSE 요청을 확장 패스를 나열합니다.
- **내용 truncation**는 개인정보 보호 기능입니다 — 긴 코드 산출, 파일 내용 및
  민감한 도구 결과는 지휘자의 전체 UI를 떠나지 않습니다.

## gstack 빌드 (내선 측)

사이드 패널 "Session"탭에서 비계 (현재는 위주를 보여줍니다).

지휘자의 API가 유효할 때:
1. 옆 패널은 항구 probe 또는 수동 입장을 통해 지휘자를 발견합니다
2. Fetches `/api/workspaces`, 서버의 repo를 검색하는 경기
3. `EventSource`를 `/workspace/{id}/session/stream`로 엽니다.
4. 렌더링 : 조수 메시지, 도구 이름 + 아이콘, 경계를 끄, 비용
5. 뒤를 웅대하게 폭포 : "전체 세션보기에 대한 연결 도체"

예상된 노력: ~200 LOC `sidepanel.js`

## 어떤 지휘자는 (서버 측)를 건설합니다

1. SSE 엔드포인트는 작업 공간당 Claude Code의 스트림 json을 재조정합니다.
2. `/api/workspaces` 활성 작업 공간 목록과의 발견 endpoint
3. 콘텐츠 truncation (500 숯 모자 도구 입력/outputs)

예상된 노력: ~100-200 LOC 만약 지휘자가 이미 Claude Code 스트림을 내부적으로 캡처하면 (그것은 UI 렌더링).

## 디자인 결정

| 의약 | 의 특징 | 의원 |
|----------|--------|-----------|
| 의정부 | SSE (WebSocket 아닙니다) | Unidirectional, 자동 연결, 단순 |
| Format | Claude의 스트림 json | 이미이를 파고; no 새로운 스키마 |
| Discovery | HTTP 엔드포인트 (파일이 아닙니다) | Chrome 확장자는 filesystem을 읽을 수 없습니다. |
| 의제 | None (localhost) | 서버 검색과 동일, CDP 포트, Claude Code |
| 의약 | 500 숯 | 측 패널은 ~300px 넓게입니다; 긴 내용 쓸모 없는 |
