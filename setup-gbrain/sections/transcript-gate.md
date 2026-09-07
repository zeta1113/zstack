<!-- AUTO-GENERATED from transcript-gate.md.tmpl — do not edit directly -->
<!-- Regenerate: bun run gen:skill-docs -->
메모리 동기화가 유선 (Step 7)이지만 CLAUDE.md 구성 (Step 8)을 인식하기 전에이 Mac의 코딩 에이전트 성적을 가져 오는 제안 + gbrain로 `~/.gstack/` artifacts를 gbrain로 큐레이터를 가져다 주므로 Retrieval 표면 (per-skill 나타날, salience 블록)은 표면에 데이터가 있습니다.

작업 크기를 조정하는 조사를 실행하십시오:
```bash
bun run ~/.claude/skills/gstack/bin/gstack-memory-ingest.ts --probe
```

출력을 읽으십시오. `Total files in window: 0`, 건너뛰기 - 소화에 아무것도 없습니다. `gstack-config set transcript_ingest_mode incremental`를 침묵하게 설정하고 8 단계로 계속하십시오.

`New (never ingested)`는 < 200 AND 총 바이트는 <100MB: `bun run ~/.claude/skills/gstack/bin/gstack-memory-ingest.ts --bulk --quiet`를 통해 침묵하는 부피입니다. `transcript_ingest_mode=incremental`를 놓고 계속하십시오.

그렇지 않으면 (디스크의 "만디 성적표" 경로) : AskUserQuestion 정확한 수 AND 값 약속. 기본 범위는 **현재 repo 만, 90 일 지속**입니다.

> <N_repo> 마지막에 THIS repo (<repo-slug>)에 있는 성적표
> 90 days, plus <N_other> across other repos on this machine (<bytes>
> 모두 섭취하면 합계. THIS repo의 성적표는 gbrain로?
>
> 이 후에 얻는 무엇: 각 gstack 기술 자동 짐 최근 salience
> 이 repo에서 지난 세션에서, 그래서 에이전트는 당신의 사전을 찾습니다
> 그것을 설명하지 않고 작업. 당신은 할 수 있습니다 '내가 내가 할 일
> day X' and get a real Answer. 한 페이지는 검색 할 수 있습니다,
> taggable, 그리고 deletable. 비밀 스캐닝은 어떤 강요의 앞에 달립니다.
>
> 무엇 동일하: gbrain sync 없는 아무 말도 당신의 기계를 나타낸다
> 활성화 (Step 7). Per-repo 신뢰 정책은 여전히 적용됩니다.
>
> 멀티맥 노트: HAVE 활성화된 뇌 동기화 (Step 7), 이러한 경우
> 성적표는 Macs에서 동기화됩니다. Caveat : 삭제
> gbrain 하지만 git history 유지에서 나중에 의문을 제거
> 우선 커밋에서. `gstack-transcript-prune`를 사용하여 대량으로 삭제합니다.
> use `git filter-repo` 에 대한 뇌 원격에서 hard-delete에서
> 역사."

옵션:
- A) 예 -이 repo, 90 일 (추천; ~est min)
- B) 예 -이 repo, ALL 역사
- C) 예 -이 기계에이 repo + 다른 저장소
- D) 역사 건너, 지금부터 새로운 트랙 (`transcript_ingest_mode=incremental`)
- E) 절대로 성적표 (`transcript_ingest_mode=off`)

답변 후:
```bash
~/.claude/skills/gstack/bin/gstack-config set transcript_ingest_mode <choice>
bun run ~/.claude/skills/gstack/bin/gstack-gbrain-sync.ts --full --no-brain-sync
```
(`--no-brain-sync` 단계 7 이미 그 경로에 유선; 이것은 단지 코드 가져 오기 + 메모리 ingest 단계. 두뇌 동기화 다음 preamble 후크에 실행됩니다.)

A/D/E, ingest가 이 시점에서 증가하는 경우; 모든 기술 시작 (cheap mtime fast-path)에 preamble-boundary 걸이는 `bun run ~/.claude/skills/gstack/bin/gstack-gbrain-sync.ts --incremental --quiet`를 실행합니다.

사용자를 위한 참조 doc: `setup-gbrain/memory.md` (CLAUDE.md 8 단계에서 연결됨).
