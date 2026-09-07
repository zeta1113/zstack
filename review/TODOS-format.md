# TODOS.md 형식 참조

공법 TODOS.md 형식의 공유 참조. `/ship` (Step 5.5) 및 `/plan-ceo-review` (TODOS.md 갱신 단면도)에 의해 일관된 TODO 품목 구조를 지키기 위하여 참조했습니다.

---

## 파일 구조

```markdown
# TODOS

## <Skill/Component>     ← e.g., ## Browse, ## Ship, ## Review, ## Infrastructure
<items sorted P0 first, then P1, P2, P3, P4>

## Completed
<finished items with completion annotation>
```

**단면도:** 기술 또는 구성 요소에 의해 구성 (`## Browse`, `## Ship`, `## Review`, `## QA`, `## Retro`, `## Infrastructure`). 각 섹션 내에서, 우선 순위 (P0)에 따라 항목을 정렬합니다.

---

## TODO 항목 형식

각 항목은 H3 섹션에서 다음과 같습니다.

```markdown
### <Title>

**What:** One-line description of the work.

**Why:** The concrete problem it solves or value it unlocks.

**Context:** Enough detail that someone picking this up in 3 months understands the motivation, the current state, and where to start.

**Effort:** S / M / L / XL
**Priority:** P0 / P1 / P2 / P3 / P4
**Depends on:** <prerequisites, or "None">
```

**필수 필드:** 무엇, 왜, Context, Effort, 우선 순위 **선택적 분야:**에 따라, 막힌

---

## 우선 정의

- **P0** - 차단: 다음 릴리스 전에 수행해야 합니다.
- **P1** - 긴요한: 이 주기를 행해야 합니다
- **P2** — 중요: P0/P1가 명확하게 될 때
- **P3** — 니스에 득점: 채택/usage 자료 후에 revisit
- **P4** — Someday: 좋은 아이디어, 긴급

---

## 완성된 항목 형식

아이템이 완료되면 `## Completed` 섹션으로 이동하여 원래 내용과 승인:

```markdown
**Completed:** vX.Y.Z (YYYY-MM-DD)
```
