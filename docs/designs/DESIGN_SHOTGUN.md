# 디자인 : 디자인 샷건 - 브라우저 -에 - 일관된 피드백 루프

2026-03-27 지점에서 생성됨: garrytan/agent-design-tools 상태: LIVING DOCUMENT — 버그가 발견되고 고쳐지는 갱신

## 이 기능은 무엇을 합니까

디자인 샷건은 여러 AI 디자인의 모조를 생성하고, 비교 보드로 사용자의 실제 브라우저에서 측면을 열고 구조화 된 피드백을 수집합니다 (즐거워하고, 가격 대안을 핥고, 메모, 요청 재생을 남깁니다). 피드백은 코딩 에이전트로 돌아갑니다. 즉, 승인 된 변형으로 진행하거나 새로운 변형을 생성하고 보드를 다시로드합니다.

사용자는 브라우저 탭을 결코 나지 않습니다. 에이전트은 중복한 질문을 결코 요구하지 않습니다. 널은 의견 기계장치입니다.

## 핵심 문제: 두 세계는 말하는

```
  ┌─────────────────────┐          ┌──────────────────────┐
  │   USER'S BROWSER    │          │   CODING AGENT       │
  │   (real Chrome)     │          │   (Claude Code /     │
  │                     │          │    Conductor)         │
  │  Comparison board   │          │                      │
  │  with buttons:      │   ???    │  Needs to know:      │
  │  - Submit           │ ──────── │  - What was picked   │
  │  - Regenerate       │          │  - Star ratings      │
  │  - More like this   │          │  - Comments          │
  │  - Remix            │          │  - Regen requested?  │
  └─────────────────────┘          └──────────────────────┘
```

"???"은 단단한 부분입니다. 사용자는 크롬에서 버튼을 클릭합니다. 터미널에서 실행되는 에이전트는 그것에 대해 알아야합니다. 이들은 no 공유 메모리, no 공유 이벤트 버스, no WebSocket 연결과 두 개의 완전 분리 프로세스입니다.

## 건축술: Linkage 일하는 방법

```
  USER'S BROWSER                    $D serve (Bun HTTP)              AGENT
  ═══════════════                   ═══════════════════              ═════
       │                                   │                           │
       │  GET /                            │                           │
       │ ◄─────── serves board HTML ──────►│                           │
       │    (with __GSTACK_SERVER_URL      │                           │
       │     injected into <head>)         │                           │
       │                                   │                           │
       │  [user rates, picks, comments]    │                           │
       │                                   │                           │
       │  POST /api/feedback               │                           │
       │ ─────── {preferred:"A",...} ─────►│                           │
       │                                   │                           │
       │  ◄── {received:true} ────────────│                           │
       │                                   │── writes feedback.json ──►│
       │  [inputs disabled,                │   (or feedback-pending    │
       │   "Return to agent" shown]        │    .json for regen)       │
       │                                   │                           │
       │                                   │                  [agent polls
       │                                   │                   every 5s,
       │                                   │                   reads file]
```

### 세 파일

| File | 글 때 | Means | 에이전트 작업 |
|------|-------------|-------|-------------|
| `feedback.json` | 사용자 클릭 제출 | 최종 선택, 완료 | 읽다, 진행 |
| `feedback-pending.json` | 사용자는 이처럼 Regenerate/More를 클릭 | 새로운 옵션을 원합니다. | 그것을 읽고, 삭제, 새로운 변형을 생성, 다시로드 보드 |
| `feedback.json` (약 2+) | 사용자의 재생 후 제출 | 반복 후 최종 선택 | 읽다, 진행 |

### 국가 기계

```
  $D serve starts
       │
       ▼
  ┌──────────┐
  │ SERVING  │◄──────────────────────────────────────┐
  │          │                                        │
  │ Board is │  POST /api/feedback                    │
  │ live,    │  {regenerated: true}                   │
  │ waiting  │──────────────────►┌──────────────┐     │
  │          │                   │ REGENERATING │     │
  │          │                   │              │     │
  └────┬─────┘                   │ Agent has    │     │
       │                         │ 10 min to    │     │
       │  POST /api/feedback     │ POST new     │     │
       │  {regenerated: false}   │ board HTML   │     │
       │                         └──────┬───────┘     │
       ▼                                │             │
  ┌──────────┐                POST /api/reload        │
  │  DONE    │                {html: "/new/board"}    │
  │          │                          │             │
  │ exit 0   │                          ▼             │
  └──────────┘                   ┌──────────────┐     │
                                 │  RELOADING   │─────┘
                                 │              │
                                 │ Board auto-  │
                                 │ refreshes    │
                                 │ (same tab)   │
                                 └──────────────┘
```

## 포트 디스커버리

에이전트 배경 `$D serve` 및 포트에 대한 stderr를 읽습니다.

```
SERVE_STARTED: port=54321 html=/path/to/board.html
SERVE_BROWSER_OPENED: url=http://127.0.0.1:54321
```

에이전트는 stderr에서 `port=XXXXX`를 파로 씁니다. 이 포트는 나중에 POST `/api/reload`로 사용되며, 요청 재생시. 에이전트가 포트 번호를 잃으면, 보드를 다시로드 할 수 없습니다.

## 왜 127.0.0.1, 로컬 호스트가 아닌

`localhost`는 IPv4에서만 듣는 동안 몇몇 체계에 IPv6 `::1`에 해결할 수 있습니다. 더 중요하게, `localhost`는 개발자가 작동하고 있는 각 도메인을 위한 모든 dev 쿠키를 보냅니다. 많은 활동적인 회의를 가진 기계에, 이 불어는 Bun의 default 머리 크기 한계 (HTTP 431 과실)를입니다. `127.0.0.1`는 둘 다 문제점을 피합니다.

## 모든 가장자리 케이스 및 Pitfall

##1. 좀비 형태 문제

**이름:** 사용자는 피드백을 제출합니다. POST는 서버 종료를 성공합니다. 그러나 HTML 페이지는 여전히 Chrome에서 열립니다. 그것은 상호 작용합니다. 사용자는 피드백과 click를 다시 편집할 수 있습니다. 서버가 사라지기 때문에 아무 것도 일어나지 않습니다.

**수정 :** 성공적인 POST 후에, 널 JS:
- ALL 입력 (버튼, 라디오, textareas, 별 등급)
- Regenerate bar를 완전히 숨깁니다.
- 제출 버튼을 다음과 같이 대체하십시오. "Feedback 수신! 코딩 에이전트로 돌아갑니다."
- 쇼: "더 많은 변화를 만들기 위해 필요? `/design-shotgun`를 다시 실행하십시오."
- 페이지는 read-only 제출된 내용이 됩니다.

**에 구현:** `compare.ts:showPostSubmitState()` (선 484)

##2. 죽은 서버 문제

**이름:** 서버는 서버가 10분 default) 또는 충돌을 하면서 사용자가 여전히 보드가 열립니다. 사용자의 클릭 제출. fetch()는 조용히 실패합니다.

**수정 :** `postFeedback()` 함수는 `.catch()` 핸들러가 있다. 네트워크 실패에:
- red 오류 배너를 표시합니다. "연결 손실"
- 복사할 수 있는 `<pre>` 구획에 있는 수집된 의견 JSON를 표시합니다
- 사용자는 직접 코딩 에이전트로 복사 할 수 있습니다.

**에 구현:** `compare.ts:showPostFailure()` (선 546)

##3. 이야기 재생 스피너

**이름:** 사용자는 재생산을 클릭합니다. 보드는 회전자와 polls `/api/progress`를 매 2 초마다 보여줍니다. 에이전트 충돌 또는 새로운 변형을 생성하기 위해 너무 오래 걸립니다. 회전수는 영원히 회전합니다.

**수정 :** 진행 오염은 5분 간격으로 단 5분 간격으로 갖춰집니다. 5분 후:
- Spinner와 교체 : "Something이 잘못되었습니다."
- 쇼: "Run `/design-shotgun` 다시 코딩 에이전트에서."
- 투표 중지. 페이지가 정보를 얻게됩니다.

**에 구현:** `compare.ts:startProgressPolling()` (선 511)

##4. 파일:// URL 문제 (THE ORIGINAL BUG)

**이름:** 기술 템플릿은 원래 `$B goto file:///path/to/board.html`를 사용했습니다. 그러나 `browse/src/url-validation.ts:71` 블록 `file://` 보안 URL. fallback `open file://...`는 사용자 macOS 브라우저를 열고 `$B eval`는 Playwright의 headless 브라우저 (다른 프로세스를로드하지 않는 경우 페이지)를 사용합니다. 에이전트는 DOM를 영원히 비웁니다.

**수정 :** `$D serve`는 HTTP 이상 봉사합니다. 널을 위해 `file://`를 결코 사용하지 마십시오. `--serve` 플래그는 `$D compare`에 1개의 명령에서 널 세대와 HTTP 서빙을 결합합니다.

**증거:** `.context/attachments/image-v2.png` — 실제 사용자는 이 정확한 버그를 명중합니다. 제대로 진단되는 에이전트: (1) `$B goto`는 `file://` URL, (2) no는 찾아낸 daemon과 조차 반복을 거절합니다.

##5. 더블 클릭 레이스

**이름:** 사용자는 두 번 신속하게 제출합니다. 두 개의 POST 요청은 서버에서 도착합니다. 첫 번째 세트는 "done"으로 상태와 100ms에서 출구(0)을 계획합니다. 두 번째는 100ms 창 중 하나가 도착합니다.

**현재 국가:** NOT는 완전히 감시했습니다. `handleFeedback()` 기능은 국가가 이미 가공하기 전에 "done"인 경우에 검사하지 않습니다. 두번째 POST는 성공하고 두번째 `feedback.json` (무무한, 동일한 자료)를 써야 합니다. 출구는 100ms 후에 아직도 불을 불립니다.

**위험:** 저. 널은 첫번째 성공적인 POST 응답에 모든 입력을, 이렇게 두번째 click는 ~1ms 안에 도착해야 할 것입니다. 그리고 둘 다 동일한 의견 자료를 포함할 것입니다.

**잠재적인 고침:** `handleFeedback()`의 상단에 `if (state === 'done') return Response.json({error: 'already submitted'}, {status: 409})`를 추가합니다.

##6. 포트 조정 문제

**이름:** 에이전트 배경 `$D serve` 및 `port=54321`를 stderr에서 파로 씁니다. 에이전트는 재생 중 POST `/api/reload`로 나중에 이 포트를 필요로 합니다. 에이전트가 컨텍스트를 잃으면 (변환 압축, 컨텍스트 윈도우 채우기), 포트를 기억할 수 없습니다.

**현재 국가:** 항구는 stderr에 한 번 인쇄됩니다. 에이전트은 그것을 기억해야 합니다. 디스크에 쓴 no 항구 파일이 있습니다.

**잠재적인 고침:** `serve.pid` 또는 `serve.port` 파일이 시작시 보드 HTML에 나옵니다. 에이전트는 언제든지 읽을 수 있습니다.
```bash
cat "$_DESIGN_DIR/serve.port"  # → 54321
```

##7. 피드백 파일 정리 문제

재생 라운드에서 **이름:** `feedback-pending.json`는 디스크에 남아 있습니다. 그 전에 에이전트가 충돌하면 다음 `$D serve` 세션은 stale 파일을 찾습니다.

**현재 국가:** 해결자 템플릿의 polling 루프는 `feedback-pending.json`를 읽고 읽은 후 삭제합니다. 그러나 이것은 완벽하게 지시를 따르는 에이전트에 달려 있습니다. Stale 파일은 새로운 세션을 혼란시킬 수 있습니다.

**잠재적인 고침:** `$D serve`는 시작에 stale 의견 파일을 검사하고 삭제할 수 있었습니다. 또는: 타임스탬프 (`feedback-pending-1711555200.json`)를 가진 이름 파일.

##8. 순차적 생성 규칙

**이름:** OpenAI GPT 이미지 API 비율 제한 동시 이미지 생성 요청. 3 `$D generate` 호출이 평행으로 실행되면 1개의 성공과 2는 낙관을 얻습니다.

**수정 :** 기술 템플릿은 명시적으로 말해야 합니다: "Generate mockups ONE AT A TIME. `$D generate` 호출을 병렬화하지 마십시오." 이것은 코드 레벨 잠금이 아닌 프롬프트 레벨 명령입니다. 디자인 바이너리는 순차적 실행을 시행하지 않습니다.

**위험:** 에이전트는 독립적 인 작업을 병렬화하기 위해 훈련됩니다. 명시적 인 명령없이, 그들은 동시에 3 생성을 실행하려고합니다. 이 폐기물 API 통화 및 돈.

### 9. AskUserQuestion 중복

**이름:** 사용자가 보드를 통해 피드백을 제출 한 후 (예를 들어, 평가, JSON)에서 모든 의견, 에이전트은 다시 묻습니다 : "그것을 싫어합니까?" 이것은 성가신입니다. 보드의 전체 지점은 이것을 피하기 위해 것입니다.

**수정 :** 기술 템플릿은 "Do NOT use AskUserQuestion to asked the user's preference. 읽기 `feedback.json`, 그것은 그들의 선택을 포함합니다. 단지 AskUserQuestion 당신이 제대로 이해하기 위하여, 재작업하지 않는 것을 확인하기 위하여."

### 10. CORS 문제

**이름:** 보드 HTML 참조 외부 리소스 (폰트, CDN)의 이미지, 브라우저는 `Origin: http://127.0.0.1:PORT`와 요청을 보냅니다. 대부분의 CDN은 이것을 허용하지만 일부가 차단할 수 있습니다.

**현재 국가:** 서버는 CORS 헤더를 설정하지 않습니다. 보드 HTML는 자체가 포함 된 (images base64-encoded, styles 인라인)이므로 연습에 문제가 없습니다.

**위험:** 낮은 현재 디자인을 위해. 널이 외부 자원 적재한 경우에 사정할 것입니다.

### 11. 큰 탑재량 문제

**이름:** No POST체에 `/api/feedback` 크기 한계. 널이 몇몇이 다MB 탑재량을 보내는 경우에, `req.json()`는 기억으로 그것을 파는 것입니다.

**현재 국가:** 실습에서, 피드백 JSON는 ~500 바이트 ~~2KB입니다. 위험은 이론적, 실제적이지 않습니다. 보드 JS는 고정 모양 JSON 객체를 건설합니다.

### 12. fs.writeFileSync 오류

**이름:** `feedback.json` `serve.ts:138`는 no try/catch를 가진 `fs.writeFileSync()`를 사용합니다. 디스크가 가득 차 있거나 디렉토리가 read-only인 경우, 이 던지기는 서버가 충돌합니다. 사용자는 척수가 영원히 보이고 있습니다 (서버는 죽지만, 널은 모른다).

**위험:** 저 연습 (보드 HTML는 동일한 디렉토리에 작성되었으며, writable입니다). 그러나 500 응답으로 /catch를 시도하면 클리너가 될 것입니다.

## 완전한 흐름 (단계별 단계)

## 행복한 경로: 사용자는 첫 번째 시도에 선택합니다

```
1. Agent runs: $D compare --images "A.png,B.png,C.png" --output board.html --serve &
2. $D serve starts Bun.serve() on random port (e.g. 54321)
3. $D serve opens http://127.0.0.1:54321 in user's browser
4. $D serve prints to stderr: SERVE_STARTED: port=54321 html=/path/board.html
5. $D serve writes board HTML with injected __GSTACK_SERVER_URL
6. User sees comparison board with 3 variants side by side
7. User picks Option B, rates A: 3/5, B: 5/5, C: 2/5
8. User writes "B has better spacing, go with that" in overall feedback
9. User clicks Submit
10. Board JS POSTs to http://127.0.0.1:54321/api/feedback
    Body: {"preferred":"B","ratings":{"A":3,"B":5,"C":2},"overall":"B has better spacing","regenerated":false}
11. Server writes feedback.json to disk (next to board.html)
12. Server prints feedback JSON to stdout
13. Server responds {received:true, action:"submitted"}
14. Board disables all inputs, shows "Return to your coding agent"
15. Server exits with code 0 after 100ms
16. Agent's polling loop finds feedback.json
17. Agent reads it, summarizes to user, proceeds
```

### 재생 경로: 사용자는 다른 선택권을 원합니다

```
1-6.  Same as above
7.  User clicks "Totally different" chiclet
8.  User clicks Regenerate
9.  Board JS POSTs to /api/feedback
    Body: {"regenerated":true,"regenerateAction":"different","preferred":"","ratings":{},...}
10. Server writes feedback-pending.json to disk
11. Server state → "regenerating"
12. Server responds {received:true, action:"regenerate"}
13. Board shows spinner: "Generating new designs..."
14. Board starts polling GET /api/progress every 2s

    Meanwhile, in the agent:
15. Agent's polling loop finds feedback-pending.json
16. Agent reads it, deletes it
17. Agent runs: $D variants --brief "totally different direction" --count 3
    (ONE AT A TIME, not parallel)
18. Agent runs: $D compare --images "new-A.png,new-B.png,new-C.png" --output board-v2.html
19. Agent POSTs: curl -X POST http://127.0.0.1:54321/api/reload -d '{"html":"/path/board-v2.html"}'
20. Server swaps htmlContent to new board
21. Server state → "serving" (from reloading)
22. Board's next /api/progress poll returns {"status":"serving"}
23. Board auto-refreshes: window.location.reload()
24. User sees new board with 3 fresh variants
25. User picks one, clicks Submit → happy path from step 10
```

### "더 좋아"길

```
Same as regeneration, except:
- regenerateAction is "more_like_B" (references the variant)
- Agent uses $D iterate --image B.png --brief "more like this, keep the spacing"
  instead of $D variants
```

## # Fallback Path: $D는 실패를 봉사

```
1. Agent tries $D compare --serve, it fails (binary missing, port error, etc.)
2. Agent falls back to: open file:///path/board.html
3. Agent uses AskUserQuestion: "I've opened the design board. Which variant
   do you prefer? Any feedback?"
4. User responds in text
5. Agent proceeds with text feedback (no structured JSON)
```

## 이 구현하는 파일

| File | - 연혁 |
|------|------|
| `design/src/serve.ts` | HTTP 서버, 주 기계, 파일 쓰기, 브라우저 시작 |
| `design/src/compare.ts` | HTML 세대 JS ratings/picks/regen, POST 논리, 포스트 서브 수명주기를 위한 널 HTML 발생 |
| `design/src/cli.ts` | CLI 입력점, 철사 `serve` 및 `compare --serve` 명령 |
| `design/src/commands.ts` | 명령 레지스트리, 정의 `serve` 그리고 `compare` 그들의 args |
| `scripts/resolvers/design.ts` | `generateDesignShotgunLoop()` — polling loop 및 reload 지시를 출력하는 템플릿 해결자 |
| `design-shotgun/SKILL.md.tmpl` | 전체 흐름을 오케스트라 스킬 템플릿: 컨텍스트 모임, 변종 발생, `{{DESIGN_SHOTGUN_LOOP}}`, 피드백 확인 |
| `design/test/serve.test.ts` | HTTP 엔드포인트 및 상태 전환을 위한 단위 테스트 |
| `design/test/feedback-roundtrip.test.ts` | E2E 테스트: 브라우저 click → JS fetch → HTTP POST → 디스크에 파일 |
| `browse/test/compare-board.test.ts` | DOM- 비교표에 대한 레벨 테스트 UI |

## 아직도 무슨 일도 걸릴 수 있었습니다

## # Known Risks (예: 안젤리후드에 의해 주문 됨)

1. **에이전트는 순차적 생성 규칙을 따르지 않습니다.** - 대부분의 LLMs는 평행으로 원합니다. 이진에 있는 강제 없이, 이것은 무시될 수 있는 신속한 수준 지시입니다.

2. **에이전트는 포트 번호를 잃** - context 압축은 stderr 출력을 떨어뜨립니다. 에이전트은 널을 재부팅할 수 없습니다. 부록: 파일에 항구를 쓰십시오.

3. **Stale 의견 파일** - 충돌 세션에서 `feedback-pending.json`가 다음 실행을 끊습니다. 부채: 시작을 청소합니다.

4. **fs.writeFileSync 충돌** — no try/catch 에 대한 피드백 파일 쓰기. 디스크가 가득 차면 침묵 서버 죽음. 사용자는 무한한 스피너를 참조하십시오.

5. **진행 오염 드리프트** — `setInterval(fn, 2000)` 5분 이상. 실제로 JavaScript 타이머는 충분히 정확합니다. 그러나 브라우저 탭이 배경인 경우 Chrome는 분 당 한 번에 흉한 간격을 펼칠 수 있습니다.

### 잘 일하는 것들

1. **듀얼 채널 피드백** — stdout 이 지상 모드의 경우, 배경 모드의 파일. 모두 항상 능동적. 에이전트는 어느 쪽이든 작동을 사용할 수 있습니다.

2. **Self-contained HTML** - 널은 모든 CSS, JS 및 base64 인코딩된 이미지 인라인을 비치하고 있습니다. No 외부 의존성. 오프라인으로 작동합니다.

3. **횡령화** - 사용자는 한 탭에 머물. `/api/progress` polling + `window.location.reload()`를 통해 자동 재흡입. No 탭 폭발.

4. **그라프의 쾌감** — POST 실패는 복사 가능한 JSON를 보여줍니다. 진행 timeout는 명확한 과실 메시지를 보여줍니다. No 침묵하는 실패.

5. **포스트 서브 수명주기** - 보드는 read-only를 제출한 후입니다. No 좀비 형태. "다음을 할 것"이라고 해서는 안 됩니다.

## 시험 적용

### 시험되는 것은 무엇입니까

| Flow | 의 특징 | File |
|------|------|------|
| 디스크에 → feedback.json 제출 | 브라우저 click → 파일 | `feedback-roundtrip.test.ts` |
| Post-submit UI lockdown | 입력 비활성화, 성공 표시 | `feedback-roundtrip.test.ts` |
| Regenerate → feedback-pending.json | 스칼렛 + 레겐 click → 파일 | `feedback-roundtrip.test.ts` |
| "더 좋아" → 특정 행동 | _은_B 에서 JSON | `feedback-roundtrip.test.ts` |
| 재 생성 후 Spinner | DOM 로딩 텍스트를 보여줍니다 | `feedback-roundtrip.test.ts` |
| 완전 재원 → 재부하 → submit | 2라운드 여행 | `feedback-roundtrip.test.ts` |
| Server는 임의 포트에서 시작합니다. | 항구 0 바인딩 | `serve.test.ts` |
| HTML 서버의 주입 URL | __GSTACK_SERVER_URL 체크 | `serve.test.ts` |
| JSON 거절 | 400 응답 | `serve.test.ts` |
| HTML 파일 검증 | 종료 1 누락된 경우 | `serve.test.ts` |
| Timeout 행동 | 1번 출구 | `serve.test.ts` |
| 널 DOM 구조 | 라디오, 별, chiclets | `compare-board.test.ts` |

### NOT 테스트

| Gap | 위험 위험 | 주요연혁 |
|-----|------|----------|
| 더블 클릭 submit 레이스 | 낮은 - 첫 번째 응답에 비활성화 입력 | P3 |
| 진행 오염 시간 (150 상승) | 중간 — 5 분은 시험에서 기다리는 길 | P2 |
| 재생 중에 서버 충돌 | Medium - 사용자는 무한한 회전자를 볼 수 있습니다. | P2 |
| POST 중 네트워크 타임아웃 | 낮은 — localhost는 빠른 | P3 |
| 배경 Chrome 탭 스로틀링 간격 | 중간 - 5 분의 타임 아웃을 30 + 분으로 연장 할 수 있습니다 | P2 |
| 큰 의견 payload | Low — board constructs fixed-shape JSON | P3 |
| 동시 세션 (두 개의 보드, 한 서버) | 낮은 — 각 $D는 자체 포트를 가져옵니다 | P3 |
| 이전 세션에서 Stale 피드백 파일 | 중간 — 새로운 polling 루프를 혼란시킬 수 있었습니다 | P2 |

## 잠재적 개선

### Short-term (this branch)

1. **파일에 포트 쓰기** — `serve.ts`는 `serve.port`를 시작에 디스크에 쓰입니다. 에이전트는 언제나 읽습니다. 5개의 선.
2. **Clean stale 파일 시작** — `serve.ts` 시작하기 전에 `feedback*.json`를 삭제합니다. 3개의 선.
3. **Guard 더블 클릭** - `handleFeedback()`의 상단에 `state === 'done'`를 확인합니다. 2개의 선.
4. **try/catch 파일 쓰기** - `fs.writeFileSync`를 시도 /catch에서 포장하고, 실패에 500를 돌려줍니다. 5개의 선.

### 중간단계 (follow-up)

5. **WebSocket 대신 오염** — `setInterval` + `GET /api/progress`를 WebSocket 연결으로 대체하십시오. 널은 새로운 HTML가 준비되어 있을 때 즉시 통보를 얻습니다. 오염 물질 및 배경이 있는 tab throttling을 삭제하십시오. serve.ts + ~20의 선 compare.ts에 있는 ~50의 선.

6. **항만증제** — `{"port": 54321, "pid": 12345, "html": "/path/board.html"}`를 `$_DESIGN_DIR/serve.json`로 쓰십시오. 에이전트은 파싱 stderr 대신 이것을 읽습니다. 체계가 더 튼튼한 경우에 컨텍스트 손실.

7. **피드백 schema 검증** - 쓰기 전에 JSON schema에 대하여 POST 몸에 유효한. 응집은 에이전트 하류를 혼란시키기 대신에 의견 일찍 변형했습니다.

### 장기 (디자인 방향)

8. **Persistent 디자인 서버** — 세션당 `$D serve`를 실행하는 대신, 긴 수명 디자인 daemon (검색 daemon와 같이)를 실행합니다. 다수 널은 1개의 서버를 공유합니다. 찬 시작을 삭제하십시오. 그러나 daemon 수명주기 관리 복잡성을 추가하십시오.

9. **실시간 협업** — 두 에이전트 (또는 하나의 에이전트 + 하나의 인간) 동시에 동일한 보드에서 작업. 서버는 WebSocket을 통해 국가 변경 방송. 피드백에 충돌 해결.
