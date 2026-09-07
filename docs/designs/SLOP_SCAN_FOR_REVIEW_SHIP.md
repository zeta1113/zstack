# 디자인: /review 및 /ship에 있는 사면할 수 있는 통합

상태: 생성된 deferred: 2026-04-09 에 따라: 슬로프 디프 스크립트 (scripts/slop-diff.ts, 이미 착륙)

## 문제

slop-scan 발견은 수동으로 `bun run slop:diff`를 실행하는 경우에만 눈에 보입니다. 그들은 코드 검토와 선박 도중 표면을 자동적으로, 동일한 방법 SQL 안전과 신뢰 경계 검사를 해야 합니다.

## 통합점

## /review (표시 후 4 단계)

`bun run slop:diff`를 실행하면 /informational 체크리스트 패스가 표시됩니다. 다른 리뷰 출력으로 새로운 발견을 표시하십시오.

```
Pre-Landing Review: 3 issues (1 critical, 2 informational)

AI Slop: +2 new findings, -0 removed
  browse/src/new-feature.ts
    defensive.empty-catch: 2 locations
      line 42: empty catch, boundary=filesystem
      line 87: empty catch, boundary=process
```

분류: INFORMATIONAL (단 하나 구획 합병, 다만 표면 본).

수정-First heuristic apply: 찾는 것은 파일 op의 주위에 빈 캐치, `safeUnlink()`를 가진 자동 고침입니다. 확장 코드에 있는 캐치 앤로인 경우에, 건너뛰기 (CLAUDE.md 가이드라인 당 정확한 본입니다).

## /ship (Step 3.5, 사전 착륙 검토 + PR 몸)

/review와 동일한 통합. 또한 PR 몸에 있는 1 선 요약을 보여주십시오:

```markdown
## Pre-Landing Review
- 2 issues auto-fixed, 0 needs input
- AI Slop: +0 new / -3 removed ✓
```

### 리뷰 Readiness 대시보드

NOT 행을 추가하십시오. 사면은 diff에 진단, 독립적으로 "뛰기"를 얻는 검토가 아닙니다. 그것은 자체 대쉬보드 항목으로, Eng Review 출력 내부를 보여줍니다.

## 자동 수정 대 건너뛰기

CLAUDE.md "Slop-scan"섹션을 따르십시오. 요약 :

**Auto-fix (질량 개선):**
- `fs.unlinkSync`의 빈 캐치 → `safeUnlink()`로 대체
- `process.kill`의 빈 캐치 → `safeKill()`로 대체
- `return await` enclosing 시도 없이 → `await`를 제거하십시오
- URL 파싱을 갖는 untyped 캐치 → `instanceof TypeError` 체크 추가

**Skip (팔레트의 패턴은 슬로프 수 플래그):**
- `.catch(() => {})` 불독 브라우저 ops (page.close, takeToFront)
- Chrome 확장 코드에서 캐치 앤 로그 (실행 오류가 충돌 확장)
- `safeUnlinkQuiet` 종료/emergency 경로 (모든 오류가 정확할 수 있도록)
- 활성 세션에 delegate를 갖는 Pass-through 래퍼 (API 안정성 층)

## 구현 노트

- `scripts/slop-diff.ts` 이미 무거운 리프팅을 처리 (worktree 기반베이스
  비교, 선 수 과민한 지문, 우아한 fallback)
- review/ship 기술 실행 버쉬 블록. 통합은: 스크립트를 실행, 파스
  출력은 검토 결과에 포함
- 슬로프 수 없는 경우 (`npx slop-scan` 실패), 조용히 건너뛰기
- 스크립트는 항상 0을 종료 (진료, 문이 없습니다)

## 노력 견적

| Task | - 한국어 | CC+gstack |
|------|-------|-----------|
| review/SKILL.md.tmpl에 추가 | 2시간 | 10분 |
| ship/SKILL.md.tmpl에 추가 | 2시간 | 10분 |
| review/checklist.md에 추가 | 1시간 | 5분 |
| 실제 PR을 통한 테스트 | 2시간 | 15분 |
| 재생 SKILL.md 파일 | — | 1분 |
