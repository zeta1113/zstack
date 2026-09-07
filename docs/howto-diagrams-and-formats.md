# 문서에서 도표를 넣어하는 방법 (PDF를 넘어 수출)

이 가이드는 `/make-pdf`와 `/diagram` (v1.58.0.0+)로 발송하는 도표 + 다 체재 엔진을 포함합니다. 여기에서 모두는 완전히 따로따로 달리습니다: mermaid와 excalidraw 주근깨는 `lib/diagram-render/`에서 납품되고, 찾아낸 찾아낸 daemon의 크롬. No CDN, 연출 시간에 no 네트워크.

## Render PDF 내부의 mermaid 다이어그램

당신의 마진에 있는 담을 두십시오. 그것은 그것입니다.

````markdown
```mermaid title="Render pipeline"
그래프 LR A[markdown] --> B[prepass] B --> C[Chromium] C --> D[PDF]
```
````

```bash
make-pdf generate doc.md out.pdf
```

울타리는 **벡터 벡터** 다이어그램 (모든 줌, 선택 가능한 텍스트에서 충돌)으로 렌더링됩니다. `title` 캡션 및 액세스성 라벨로. 원시 mermaid 소스는 `data-gstack-source` 디버깅 및 라운드 스트립에 대한 그림에 인코딩 된 base64-encoded입니다 (an HTML 코멘트는 mermaid의 `-->` 화살표를 손상시킬 것입니다). 한 캐치 : 울타리는 **열 0** (일반적으로)에 의해 시작된 코드에 따라 시작해야합니다.

**울타리 옵션** (정보 문자열에 있는 공간 격리):

| * * * | 의약 |
|---|---|
| `title="..."` | 도표의 밑에 caption + `aria-label` |
| `render=false` | 일반 코드 블록으로 울타리를 유지 |
| `page=landscape` | 그것의 자신의 풍경 페이지로이 도표를 강제하십시오 |
| `page=portrait` | 이 다이어그램의 자동 조경 |

파스 오류와 소스 발췌를 가진 큰 빨간 진단 구획으로 파스 렌더링을 실패하는 울타리 - 문서는 여전히 빌드를 구축하고 오류는 놓치지 않습니다.

` ```excalidraw ` fences work the same way; the body is a full `.excalidraw` 장면 파일 (excalidraw.com 파일과 저장 → 저장).

## 제어 이미지 크기 및 방향

로컬 이미지는 자동으로 줄어듭니다 (문자 파일에 대한 해결) 그리고 **결코 truncate** - 콘텐츠 상자에 모든 이미지 캡. 해상도를 인쇄하기 위해 크기가 큰 사진 다운 스케일 (내용 폭 300dpi), 그래서 전화 사진은 문서에 bloat하지 않습니다.

이미지 안전 기본: 원격 (http/https) 이미지는 **눈에 보이는 위주로 차단**를 통과하지 않는 한 `--allow-network`입니다. 마크다운의 디렉토리 밖에서 해결하는 이미지 경로 (symlink를 통해 조차)는 아직도 inlines 그러나 크게 경고합니다. 64MB 이상 파일과 비 규칙 파일 (fifos, 장치)는 렌더링을 거는 대신 위주로 degrade.

이미지가 끝난 후 즉시 이동:

```markdown
![quarterly chart](chart.png){width=full}
![logo](logo.png){width=2in}
![wide architecture](arch.png){page=landscape}
![wide screenshot](shot.png){page=portrait}
```

`width=`는 `full`, 비율 (`50%`), 또는 차원 (`3in`, `8cm`, `200px`)를 받아들입니다. `page=` 힘 또는 헌신적인 조경 페이지.

**자동차 조경:**는 넓고 작은 텍스트, 다이어그램 같은 이미지는 다른 초상화 문서 안쪽에 그들의 수직으로 중심의 풍경 페이지를 자동적으로 가져옵니다. heuristic는 deliberately 보수 (경도 비율 ≥ 1.8, 내용 상자 이상 인trinsic 폭, 그리고 다이어그램-ish alt 단어: 도표/건축/흐름/전/ 그래프)입니다. 당신이 그것을 원할 때 불이거나, `{page=landscape}`를 추가하지 않는 경우에; 불이 불을 때 **자동차 조경:**를 추가하십시오.

## 수출 단 하나 파일 HTML 또는 단어

```bash
make-pdf generate doc.md out.html --to html
make-pdf generate doc.md out.docx --to docx
```

- **`--to html`**는 ONE 각자 달성한 파일을 씁니다: 인라인 SVG로 도표,
  데이터 URI, 0 네트워크 참조 (default 오프라인 자세 - `--allow-network` deliberately 원격 이미지 태그 라이브 유지), 플러스 화면 읽기 레이어 (중앙 측정, 패딩). 이메일, 그것을 첨부, 어디로 엽니 다.
- **`--to docx`**는 내용 불순 수출입니다: 표, 코드를 두는
  블록, 목록 및 다이어그램 (alt 텍스트가있는 300dpi PNG로 조립 됨)이 수행됩니다. 페이지 결함 레이아웃은 없습니다. 즉, Word의 작업이 열립니다.

Heads-up: `--to`는 출력 형식입니다. `--format`는 `--page-size`를 위한 오래된 별명입니다 — 다른 것.

## 영어로 다이어그램 생성

```
/diagram make a flowchart of our deploy pipeline: build, test, canary, promote
```

기술 저자는 mermaid를 방출하고 **triplet**를 방출합니다:

| File | 사용하기 |
|---|---|
| `<slug>.mmd` | 진실의 근원 — 편집과 재 렌더링 |
| `<slug>.excalidraw` | excalidraw.com (파일 → 열기), 이동 상자, 손 뒤로 |
| `<slug>.svg` / `<slug>.png` | docs, 문제, READMEs, 채팅 |

Flowcharts는 완전히 편집 가능한 excalidraw 장면으로 변환합니다. 다른 mermaid 유형 (수, 국가, gantt)는 SVG/PNG 벌금으로 렌더링하지만 `.excalidraw` artifact를 건너 뛰기 - 상류 변환기 제한 기술에 대해 알려줍니다.

문서의 경우 PNG 대신 `.mmd` 소스를 삽입합니다. `/make-pdf`는 벡터로 렌더링되며, 다이어그램은 영원히 편집할 수 있습니다.

## CI: 운송주 대신 큰 실패

```bash
make-pdf generate docs.md --strict
```

로컬 이미지, 차단된 원격 이미지, 아웃-of-tree 이미지 읽기 (경우 또는 symlink는 마크 다운의 디렉토리 밖에 해결), 대형 파일 (>64MB) 및 비 규칙 파일이 경고 또는 위주로 분해하지 않고 모든 출구 비 소문 - 깨진 이미지가 빌드를 깨야 할 docs 파이프라인에 대한 문서.

## 문제 해결

- **"배터리 묶음"** → `bun run build:diagram-render` 실행
  gstack repo 또는 `./setup`를 재 실행하십시오.
- **다이어그램 렌더링하지만 스쿼시 인라인보기** → 넓은; 그것을 방을 주십시오
  담에 `page=landscape`로.
- **두 줄 "racetrack" 루프 대신 한 긴 라인:** mermaid 하위
  `flowchart TB`, `direction LR`와 `direction RL`를 가진 2개의 subgraphs는, *subgraphs* (미래 경계를 맞댄 끝 가장자리를 침묵하게 `direction`) 연결합니다.
- **"[remote image blocked]"주저** → 원격 이미지는 결코 fetched
  default (오프라인 자세); 태그는 표시된 위주자로 대체됩니다. Chromium는 인쇄 시간에 그것을 흠뻑 취할 수 없습니다. `--allow-network`를 선택하여 선택합니다.
