---
name: hackernews-frontpage
description: Scrape the Hacker News front page (titles, points, comment counts).
host: news.ycombinator.com
trusted: true
source: human
version: 1.0.0
args: []
triggers:
  - scrape hacker news frontpage
  - scrape hn frontpage
  - get hn top stories
  - latest hacker news stories
---

# 해커 뉴스 프론트 페이지 스크랩

해커 뉴스 (`news.ycombinator.com`) 프론트 페이지에 대한 스크랩과 JSON로 상위 30 이야기를 반환합니다. 각 이야기는 순위, 제목, 링크 URL, 포인트 카운트 및 코멘트 수를 가지고 있습니다.

## 사용법

```
$ $B skill run hackernews-frontpage
{
  "stories": [
    { "rank": 1, "title": "...", "url": "...", "points": 412, "comments": 87 },
    ...
  ],
  "count": 30
}
```

## 어떻게 작동합니까?

1. `https://news.ycombinator.com`으로 다몬을 통해 이동합니다.
2. 페이지 HTML를 읽습니다.
3. 각 이야기 행을 파기 (HN의 안정 `tr.athing` 구조) 타입으로
   `Story` 기록.
4. stdout에 단일 JSON 문서가 있습니다.

## 왜 이 참조 기술입니다

`hackernews-frontpage`는 가장 작은 재미있는 브라우저 skill입니다: auth, 안정되어 있는 HTML, deterministic 산출, 파일 연결 친절한. 각 단계 1 성분 (SDK, 범위가 있는 토큰, 3 층 보기, spawn 생활 주기)는 `$B skill run hackernews-frontpage` 및 번들어진 `script.test.ts`에 의해 운동됩니다.

HN HTML가 회전하고 우리의 선택자 틈이 때, 시험은 사용자의 고시의 앞에 붙잡힌 정착물에 대하여 실패합니다. 그것은 점입니다.
