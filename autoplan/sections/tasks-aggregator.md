<!-- AUTO-GENERATED from tasks-aggregator.md.tmpl — do not edit directly -->
<!-- Regenerate: bun run gen:skill-docs -->
## 구현 작업 집계

아래 최종 승인 게이트 출력 블록을 렌더링하기 전에, 각 리뷰 기술이 썼습니다.

```bash
eval "$(~/.claude/skills/gstack/bin/gstack-slug 2>/dev/null)"
TASKS_DIR="${HOME}/.gstack/projects/${SLUG:-unknown}"
BRANCH=$(git branch --show-current 2>/dev/null || echo unknown)
# Commit window: last 5 commits on this branch. Drops stale standalone reviews.
COMMITS_RECENT=$(git log --format=%H -n 5 2>/dev/null | tr '\n' '|' | sed 's/|$//')

AGGREGATED_TASKS=""
if command -v jq >/dev/null 2>&1; then
  # Collect entries from all 4 phases, scoped to current branch + commit window.
  # For each phase, keep only the latest run_id. Within the surviving set,
  # dedupe by (component, sorted(files), title) — exact match only.
  # Sort by priority (P1 > P2 > P3) then by phase order.
  ALL_JSONL=$(mktemp -t autoplan-tasks.XXXXXXXX)
  for phase in ceo-review design-review eng-review devex-review; do
    # Use find instead of glob expansion — zsh nomatch errors otherwise when
    # a phase produced no JSONL files. Sorting by name keeps the order stable.
    while IFS= read -r f; do
      [ -f "$f" ] || continue
      # Filter to current branch + recent commits, then keep records for the
      # latest run_id only. (Single phase may have multiple files if the user
      # re-ran the review; aggregator takes the newest.)
      # .commit must be bound BEFORE piping to the split commit array: a
      # pipe rebinds jq's context, so a bare .commit after it indexes the
      # ARRAY with a string, every line errors into 2>/dev/null, and the
      # aggregate is empty forever — the #2018 zero-tasks bug.
      jq -c --arg branch "$BRANCH" --arg commits "$COMMITS_RECENT" \
        '.commit as $c | select(.branch == $branch and ($commits | split("|") | index($c) != null))' \
        "$f" 2>/dev/null >> "$ALL_JSONL" || true
    done < <(find "$TASKS_DIR" -maxdepth 1 -name "tasks-$phase-*.jsonl" 2>/dev/null | sort)
    # Reduce to latest run_id per phase
    if [ -s "$ALL_JSONL" ]; then
      jq -sc --arg phase "$phase" \
        '[.[] | select(.phase == $phase)] | (max_by(.run_id) // null) as $latest_run | if $latest_run then map(select(.run_id == $latest_run.run_id)) else [] end | .[]' \
        "$ALL_JSONL" > "$ALL_JSONL.phase" 2>/dev/null || true
      # Replace with reduced version for this phase, accumulating others
      jq -c --arg phase "$phase" 'select(.phase != $phase)' "$ALL_JSONL" > "$ALL_JSONL.other" 2>/dev/null || true
      cat "$ALL_JSONL.other" "$ALL_JSONL.phase" > "$ALL_JSONL"
      rm -f "$ALL_JSONL.phase" "$ALL_JSONL.other"
    fi
  done

  # Exact-match dedup by (component, sorted(files), title). Non-matches kept
  # separately with a possible-duplicate marker injected by the renderer.
  AGGREGATED_TASKS=$(jq -s \
    'group_by([.component, (.files | sort), .title])
     | map(
         # Take the highest-priority entry per group; tie-break by phase order
         sort_by({P1:0,P2:1,P3:2}[.priority] // 99, {"ceo-review":0,"design-review":1,"eng-review":2,"devex-review":3}[.phase] // 99) | .[0]
       )
     | sort_by({P1:0,P2:1,P3:2}[.priority] // 99, {"ceo-review":0,"design-review":1,"eng-review":2,"devex-review":3}[.phase] // 99)
     | if length == 0 then "_No actionable tasks emitted from any phase._" else
         map("- [ ] **\(.id) (\(.priority), human: \(.effort_human) / CC: \(.effort_cc)) — \(.component)** — \(.title)\n  - Surfaced by: \(.phase) — \(.source_finding)\n  - Files: \(.files | join(", "))") | join("\n")
       end' "$ALL_JSONL" 2>/dev/null | sed 's/^"//;s/"$//;s/\\n/\n/g')
  rm -f "$ALL_JSONL"
else
  AGGREGATED_TASKS="_jq not installed — install jq to aggregate per-phase task lists. Skipping._"
fi
```

아래 최종 승인 게이트 출력 템플릿 내부에서 `### Implementation Tasks (aggregated across phases)` 섹션에서 골재된 마커를 렌더링합니다. `$AGGREGATED_TASKS`(위의 bash 변수 설정)의 내용을 사용자에 메시지를 인쇄하기 전에 사용합니다. 이것은 NOT 템플릿 위주인 - 에이전트는 런타임에 대 한 하위 대용을 수행, 빌드 시간에 gen-skill-docs.

`$AGGREGATED_TASKS`가 빈 경우 (JSONL 파일이 발견되지 않았습니다. - 이 세션에서 검토 기술이 ran의 아무도), 렌더링 :

`_No per-phase task lists found in $TASKS_DIR for branch $BRANCH. Each review skill writes its own; if you ran one of them but no list appears here, check that jq is installed and the tasks-<phase>-*.jsonl files exist._`

