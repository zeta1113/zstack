# 계획: 팀 Velocity 대시보드

## 텍스트

우리는 엔지니어 당 팀 코드 각측정속도를 추적하기 위하여 기술설계 매니저를 위한 대쉬보드를 건설하고 있습니다 — 엔지니어, PR 주기 시간, 검토 대기권, CI 통행 비율. 자료는 이미 GitHub에서 생활합니다; 우리는 매니저의 단 하나 팬 전망을 위해 그것을 집계하고 있습니다.

## 변경

1. `src/dashboard/`의 새로운 반응 성분 `TeamVelocityDashboard`
2. REST API 엔드포인트 `GET /api/team/velocity?days=30` 리턴 컨트 미터
3. GitHub 데이터를 매 15분마다 포스트그레에 끌어 당기는 배경 작업
4. 간단한 필터 UI: 팀, 날짜 범위, 미터

## 건축

- 프론트엔드: React + shadcn/ui
- 백엔드: Express + PostgreSQL
- 자료원: GitHub REST API (15min를 냉각하는)

## 질문 열기

- 우리는 팀 당 다수 저장소를 지원해야 합니까?
- 우리는 개별 엔지니어 이름 또는 집계를 보여줍니다?
