# 계획: Snapshot Dropdown/Autocomplete 대화 형 요소 탐지

## 문제

`snapshot -i`는 dropdown/autocomplete를 현대 웹 앱에 놓습니다. 이 요소:
1. 종종 `<div>`/`<li>` 을 클릭하여 핸들러가 아니라 semantic ARIA 역할이 없습니다.
2. 동적으로 만들어진 포털/popovers (플러그인 컨테이너) 내부 라이브
3. Playwright의 접근성 트리에 나타나지 마십시오 (`ariaSnapshot()`)

`-C` 플래그 (cursor-interactive scan)는 이것을 위해 디자인되었지만:
- 별도의 플래그가 필요 — `-i`를 사용하여 에이전트가 자동으로 얻지 못합니다.
- HAVE ARIA 역할(ARIA 트리가 놓은 경우)
- 팝업을 우선 순위/portal 컨테이너를 드롭다운 아이템이 살아있는

## 뿌리 원인

Playwright의 `ariaSnapshot()`는 브라우저의 접근성 트리에서 구축합니다. 동적 렌더링 팝업 (리터 포털, Radix Popover 등)는 액세스 가능성 트리에있을 수 있습니다.
- 구성품은 ARIA 역할을 설정하지 않습니다.
- 포털은 범위 `body` 로케이터의 하위 트리 타이밍 밖에서 렌더링합니다.
- 브라우저는 DOM 뮤테이션 후 액세스성 트리를 업데이트하지 않습니다.

## 변경

##1. `-i` 플래그를 가진 자동 가능하게 하는 커서 인터랙티브 검사

**파일 :** `browse/src/snapshot.ts`

`-i` (interactive)가 전달될 때, 자동적으로 커서 인터랙티브 스캔을 포함합니다. 이것은 에이전트가 항상 대화형 요소에 대해 요청할 때 clickable non-ARIA 요소를 볼 수 있습니다.

`-C` 플래그는 비동기 스냅샷의 독립 옵션으로 남아 있습니다.

```
if (opts.interactive) {
  opts.cursorInteractive = true;
}
```

##2. popover/portal 우선 스캔 추가

**파일 :** `browse/src/snapshot.ts` (cursor-interactive 평가 구획 안쪽에)

일반 커서 전에: 점퍼 스캔, 특히 볼 수 있는 플로팅 컨테이너 (팝 오버, 드롭다운, 메뉴)를 스캔하고 ALL를 대화식으로 직접 아이들을 포함한다:

떠오르는 콘테이너를 위한 탐지 heuristics:
- `position: fixed` 또는 `position: absolute` 와 `z-index >= 10`
- `role="listbox"`, `role="menu"`, `role="dialog"`, `role="tooltip"`, `[data-radix-popper-content-wrapper]`, `[data-floating-ui-portal]`, 등.
- DOM (초기 페이지 부하에 아닙니다)에서 최근 등장
- 가시 (`offsetParent !== null` 또는 `position: fixed`)

각 뜨 콘테이너를 위해, 다음을 포함하는 아이 성분:
- 본문내용 바로가기
- 은밀한
- 커서가 있다:포인트 OR onclick OR role="option" OR role="menuitem"
- clarity에 대한 `popover-child` 태그

##3. 커서 인터랙티브 스캔에서 `hasRole` 건너뛰기

**파일 :** `browse/src/snapshot.ts`

현재: `if (hasRole) continue;` — ARIA 역할과 어떤 요소를 건너 뛰고, ARIA 나무를 이미 캡처했습니다.

문제: ARIA 나무 MISSED 요소 (티밍, 포털, 나쁜 DOM 구조)가 두 시스템을 통해 떨어졌다면.

수정: 요소의 역할이 `INTERACTIVE_ROLES` AND에서 인 경우에만 건너뛰기만, 실제로 주된 refMap에 붙잡았다. 그렇지 않으면 그것을 포함합니다.

`page.evaluate()` 내부에서 refMap을 쉽게 확인할 수 없기 때문에 간단한 수정 : `hasRole`는 완전히 부동 컨테이너 내부에 요소에 대해 건너 뛰기. 부동 용기 이외의 요소에 대해서는 `hasRole`가 정상적인 페이지 내용에 복제를 방지하기 위해) 를 뺍니다.

##4. 드롭다운 테스트 정착물 및 시험 추가

**파일 :** `browse/test/fixtures/dropdown.html`

HTML 페이지:
- 초점에 드롭다운을 보여주는 빗 상자 입력/type
- `<div>` 으로 드롭다운 아이템을 클릭 핸들러 (ARIA 역할 없음)
- Dropdown items as `<li>` with `role="option"`
- React-portal-style 컨테이너(`position: fixed`, 높은 z-index)

**파일 :** `browse/test/snapshot.test.ts`

새로운 시험 상자:
- `snapshot -i` 드롭다운 페이지에서 드롭다운 아이템을 찾아서 커서 스캔을 통해
- `snapshot -i` 드롭다운 페이지에서는 팝업-아이 엘리먼트가 포함되어 있습니다.
- `@c` dropdown 검사에서 refs는 clickable 입니다
- ARIA 역할과 플로팅 컨테이너 내부 요소는 ARIA 트리가 놓을 때도 캡처됩니다.

## 롤아웃 위험

**...** `-C` 검사는 첨가물입니다 — 그것은 단지 `@c` refs만, 결코 제거합니다 `@e` refs를 추가합니다. 자동 가능하게 하는 변화는 `-i`로 산출 크기를 증가합니다 그러나 에이전트은 이미 혼합 정제 유형을 취급합니다.

**1개의 관심사:** `-C`는 무거운 페이지에 느릴 수 있는 ALL 성분 (`document.querySelectorAll('*')`)를 검사합니다. 팝업 특정한 검사를 위해, 우리는 빨리 (작은 subtree)인 검출한 뜨 콘테이너 안쪽에 성분에 제한합니다.

## 테스트

```bash
cd /data/gstack/browse && bun test snapshot
```

## 파일 변경

1. `browse/src/snapshot.ts` - 자동 사용 가능 -C with -i, 팝업 스캐닝, 부동 용기에 hasRole 건너뛰기 제거
2. `browse/test/fixtures/dropdown.html` - 새로운 시험 정착물
3. `browse/test/snapshot.test.ts` — 새로운 dropdown/popover 시험 케이스
