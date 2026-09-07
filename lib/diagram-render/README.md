# 다이어그램 렌더링

make-pdf 및 /diagram를 위한 따로 잇기 도표 연출. 1개의 각자 -에 의하여 거치되는 HTML 페이지 (`dist/diagram-render.html`, ~9MB) 뭉치 mermaid, excalidraw 수출 utilities 및 공식 mermaid→excalidraw 변환기. 찾아낸 daemon는 `load-html`로 그것을 적재합니다; 외침은 `browse js`를 통해서 그것을 몰고 `js --out`로 바이트 뒤를 당깁니다.

내장된 페이지는 **committed** (eng- <reviewD2): 설치 시간 및 연출 시간에 0개의 네트워크와 가진 연출 일, 그리고 `./setup`에 있는 npm 공급 사슬 표면이 없습니다. (`test/diagram-render-drift.test.ts`)는 CI가 손으로 편집되거나 `BUILD_INFO.json`와 동기화에서 떨어지는 경우에 `dist/` 실패합니다.

## 페이지 API (창 기능)

| 의 특징 | → 밖으로 |
|---|---|
| `__renderMermaid(id, text)` | mermaid 텍스트 → SVG 문자열. `id`는 울타리 (`mermaid-fence-<n>`) 당 독특해야합니다. - 모든 내부 SVG ID를 명함. |
| `__mermaidToExcalidraw(text)` | mermaid text → `.excalidraw` 장면 JSON (완전히 순서; 다른 유형은 상류를 등급을 매깁니다). |
| `__excalidrawToSvg(sceneJson)` | JSON → SVG 문자열 (내선 내장, 오프라인). |
| `__rasterize(svg, targetWidthPx)` | SVG → PNG 데이터 URL. DPI 수학을 소유하고 있는 통화: `targetWidthPx = placed width (in) × 300`. tainted 화포에 던지기. |
| `__downscaleRaster(dataUri, targetWidthPx, mime)` | raster data URI → `targetWidthPx` (same mime)에 작은 자료 URI. make-pdf는 그것을 인쇄 해결책에 대형 사진을 정상화하기 위하여 이용합니다. |
| `__mountForScreenshot(svg, px)` | taint-proof fallback: `browse screenshot --selector`를 위한 `#raster-stage`에 SVG를 거치하십시오. |
| `__probeImage(src)` | URI/URL → `{width, height}` JSON. |
| `__bundleInfo` | `{ name, deps }` - 빌드에서 구운 신뢰할 수 있는 버전. |

Readiness: `#status` 텍스트가 `ready` (또는 `browse wait '#done'`)까지 투표합니다. `window.__errors`에서 누락된 페이지 오류.

## 업데이트

```bash
# 1. edit the exact pin in package.json
cd lib/diagram-render && bun install
# 2. rebuild (deterministic; build twice → same sha)
bun run build
# 3. commit package.json + bun.lock + dist/ together
```

계약 세부 사항 렌더링 (securityLevel strict, htmlLabels false, print-css font lock, `<base href>` + `</scri` escaping)은 `src/entry.ts` 및 `scripts/build.ts`에 문서화되어 있습니다.
