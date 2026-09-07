<!-- AUTO-GENERATED from claude-md-persist.md.tmpl — do not edit directly -->
<!-- Regenerate: bun run gen:skill-docs -->
찾기 및 위치 (또는 부록) 섹션. 블록 형식은 모드에 따라 다릅니다.

### 경로 4 (레모드 MCP)

```markdown
## GBrain Configuration (configured by /setup-gbrain)
- Mode: remote-http
- MCP URL: {MCP_URL}
- Server version: gbrain v{SERVER_VERSION}  (from Step 4c verify)
- Setup date: {today}
- MCP registered: yes (user scope)
- Token: stored in ~/.claude.json (do not commit; never written to CLAUDE.md)
- Artifacts repo: {gstack_artifacts_remote URL or "none"}
- Artifacts sync: {off|artifacts-only|full}
- Current repo policy: {read-write|read-only|deny|unset}
```

The bearer token is **은지** written to CLAUDE.md (CLAUDE.md is checked in to git in many projects). It lives only in `~/.claude.json` where `claude mcp add` placed it.

## 경로 1, 2a, 2b, 3 (Local stdio)

```markdown
## GBrain Configuration (configured by /setup-gbrain)
- Mode: local-stdio
- Engine: {pglite|postgres}
- Config file: ~/.gbrain/config.json (mode 0600)
- Setup date: {today}
- MCP registered: {yes/no}
- Artifacts sync: {off|artifacts-only|full}
- Current repo policy: {read-write|read-only|deny|unset}
```

**단계 9 (스무크 테스트) 패스 후, 또한 `## GBrain Search Guidance` 블록을 작성** 그래서 코딩 에이전트는 Grep에 `gbrain`를 선호할 때 배웁니다. 이 구획은 연기 시험 합격에 문질러 입니다 — 구성 구획을 첫째로 써 (그래서 사용자가 연기 시험이 실패하더라도 어떤 국가를 알고 있습니다), 그 후에 여기 단계 9 후에 돌려보내고 연기 시험이 성공한 경우에 지도 구획을 만 쓰십시오.

단계 9 패스, 발견 및 장소 (또는 부록)이 블록. 사용 HTML-comment delimiters 그래서 제거 regex는 비명적이지 않으며 사용자 콘텐츠를 결코 먹지 않습니다. 블록 내용은 기계입니다-AGNOSTIC - 엔진 유형 없음, 페이지 수 없음, 마지막 동기화 시간. 기계 상태는 위의 구성 블록에 머물.

```markdown
## GBrain Search Guidance (configured by /sync-gbrain)
<!-- gstack-gbrain-search-guidance:start -->

GBrain is set up and synced on this machine. The agent should prefer gbrain
over Grep when the question is semantic or when you don't know the exact
identifier yet. Two indexed corpora available via the `gbrain` CLI:
- This repo's code (registered as `gstack-code-<repo>` source).
- `~/.gstack/` curated memory (registered as `gstack-brain-<user>` source via
  the existing federation pipeline).

Prefer gbrain when:
- "Where is X handled?" / semantic intent, no exact string yet:
    `gbrain search "<terms>"` or `gbrain query "<question>"`
- "Where is symbol Y defined?" / symbol-based code questions:
    `gbrain code-def <symbol>` or `gbrain code-refs <symbol>`
- "What calls Y?" / "What does Y depend on?":
    `gbrain code-callers <symbol>` / `gbrain code-callees <symbol>`
- "What did we decide last time?" / past plans, retros, learnings:
    `gbrain search "<terms>" --source gstack-brain-<user>`

Grep is still right for known exact strings, regex, multiline patterns, and
file globs. The brain auto-syncs incrementally on every gstack skill start.
Run `/sync-gbrain` to force-refresh, `/sync-gbrain --full` for full reindex.

<!-- gstack-gbrain-search-guidance:end -->
```

Step 9 연기 테스트가 실패하면 지도 블록이 완전히 쓰여집니다. 다음 `/sync-gbrain` 실행은 다시 평가 기능을하고 라운드 스트립 작동을 할 때 블록을 작성합니다.
