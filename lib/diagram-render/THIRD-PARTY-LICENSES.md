# 제3자 라이센스 - 다이어그램 렌더링 번들

`dist/diagram-render.html`는 다음과 같은 패키지를 묶습니다 (`package.json`; `bun.lock`를 통해 해결된 전동 의존성:

| Package | Version | 의정부 | Source |
|---|---|---|---|
| 메르어 | 11.12.2 | MIT | https://github.com/mermaid-js/mermaid |
| @excalidraw/excalidraw | 0.18.0 | MIT | https://github.com/excalidraw/excalidraw |
| @excalidraw/mermaid-to-excalidraw | 1.1.2 | MIT | https://github.com/excalidraw/mermaid-to-excalidraw |
| 의논하기 | 18.3.1 | MIT | https://github.com/facebook/react |
| 반응 돔 | 18.3.1 | MIT | https://github.com/facebook/react |

번들 또한 @excalidraw/excalidraw (Excalifont 및 관련 얼굴) 내부에 배송 된 글꼴을 포함, SIL excalidraw 저장소 당 글꼴 라이센스 1.1을 엽니 다.

핀을 범퍼 할 때 라이센스 필드를 다시 인증 (`bun pm ls` 또는 패키지의 LICENSE 파일)과 동일한 커밋에서이 테이블을 업데이트합니다.
