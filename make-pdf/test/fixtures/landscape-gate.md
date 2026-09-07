# 조경 문

첫 번째 제목 아래 소개.

## Negative: 스크린 샷은 초상화 유지

![앱의 스크린 샷](./diagram-assets/wide-screenshot.png)

## Positive: alt-hinted 넓은 이미지 승진

![시스템의 건축 다이어그램](./diagram-assets/wide-arch.png)

## Positive: 지시어는 작은 이미지를 강제한다.

![작은 힘](./diagram-assets/red-box.png){page=landscape}

## Positive: 넓은 다이어그램 자동 프로토 타입

```mermaid title="Wide sequence"
sequenceDiagram
  participant A as seqalpha
  participant B as seqbeta
  participant C as seqgamma
  participant D as seqdelta
  participant E as seqepsilon
  participant F as seqzeta
  participant G as seqeta
  participant H as seqtheta
  participant I as seqiota
  participant J as seqkappa
  A->>J: long hop
  B->>I: cross
```

## Negative: 지시는 넓은 도표를 vetoes

```mermaid page=portrait
sequenceDiagram
  participant A as vetoalpha
  participant B as vetobeta
  participant C as vetogamma
  participant D as vetodelta
  participant E as vetoepsilon
  participant F as vetozeta
  participant G as vetoeta
  participant H as vetotheta
  participant I as vetoiota
  participant J as vetokappa
  A->>J: long hop
```

닫기 텍스트.
