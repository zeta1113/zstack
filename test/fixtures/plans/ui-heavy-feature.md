# 계획: 사용자 대시보드 페이지

## Context 최근의 활동, 알림 패널 및 빠른 액션 버튼을 보여주는 `/dashboard`의 새로운 사용자 대시보드를 발송하고 있습니다. 로그인 후 사용자 대시보드를 설치합니다.

## UI 범위
- `src/pages/`의 새로운 React 페이지 구성 요소 `UserDashboard.tsx`
- 세 가지 새로운 하위 구성 요소 : `ActivityFeed`, `NotificationsPanel`, `QuickActions`
- 레이아웃, 모바일-최초의 반응형(breakpoints: sm/md/lg)
- 빈 상태, 적재 skeleton, 각 패널을 위한 과실 국가
- Hover states + 모든 대화 형 요소에 중점을 두는 아웃라인
- 알림 패널에서 "Mark all as read"를 위한 Modal 대화 상자
- 행동 피드백을 위한 Toast 알림 시스템

## 백엔드
- 새로운 REST 엔드포인트 `GET /api/dashboard` `{ activity, notifications, quickActions }`를 반환합니다.
- 기존 PostgreSQL 테이블에 의해 백업; schema 변경 없음

## 범위의 아웃
- 어두운 모드 (separate 계획)
- 개인화 / 사용자 정의 (separate plan)
