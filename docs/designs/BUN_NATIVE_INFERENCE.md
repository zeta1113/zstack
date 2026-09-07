# Bun-Native Prompt Injection Classifier - 연구 계획

**상태:** P3 연구/초 시제품 **주요 특징:** `garrytan/prompt-injection-guard` **해골:** `browse/src/security-bunnative.ts` **TODOS 앵커:** "Bun-native 5ms DeBERTa inference (XL, P3/연구)"

## 이 문제 해결

컴파일된 `browse/dist/browse` 이진은 `onnxruntime-node` 의 `--compile` 는 `--compile` 의 온도 추출 디디르에서 의존성을 다루기 쉬운 단서 실행을 생성하고, 기본 .dylib 로딩은 그 디디드 (documented 오븐-sh/bun#3574, #18079 + CEO 계획 §-Impl Gate 1)에서 실패합니다.

오늘의 완화 (branch-2 아키텍처) : ML 클래스터는 `@huggingface/transformers`을 통해 `sidebar-agent.ts` (비 컴파일 된 번 스크립트)에서만 실행됩니다. Server.ts (컴퓨즈 됨)에는 0 ML가 있습니다. - 캐러리 + 건축 컨트롤 (XML framing + 명령 allowlist)에 의존합니다.

문제-2: classifier는 sidebar-agent가 보는 것을 검사할 수 있습니다. 컴파일된 바이너리 (직접 사용자 입력이 길어짐에 따라)에 남아있는 모든 콘텐츠 경로는 ML 층을 놓습니다.

에서 스크래치 분-native classifier — no 기본 모듈, no onnxruntime — 컴파일된 바이너리가 전체 ML 방어를 어디에나 실행할 수 있게 합니다.

## 대상 번호

| Metric | 현재 (WASM 비 컴파일 Bun) | 대상 (부정) |
|---|---|---|
| 콜드 스타트 | ~500ms (WASM init) | <100ms (조각 mmap'd) |
| Steady-state p50의 | 10~20ms(일) | ~5ms의 |
| Steady-state p95의 경우 | ~30ms의 | ~15ms · |
| 컴파일된 바이너리에서 작동합니다. | NO | YES (기본 목표) |
| macOS 팔64 | ok (WASM) (WASM) (WASM)) | 대상-첫째 |
| macOS x64> (주) | ok (WASM) (WASM) (WASM)) | stretch |
| Linux amd64>의 경우 | ok (WASM) (WASM) (WASM)) | stretch |

## 건축

3 개의 건물 블록, 레버리지 별 순위:

##1. Tokenizer (DONE - security-bunnative.ts에서 배송)

Pure-TS WordPiece encoder는 HuggingFace `tokenizer.json`를 직접 읽고 transformers.js BERT-small vocab>를 위해 `input_ids` 순서와 동일을 일으킵니다.

**왜 기본 토큰화기는 자체에 상관없이:** 토큰화는 transformers.js 경로에 있는 많은 작은 배열을 할당합니다. 우리의 순수한TS 버전은 Tensor-allocation overhead를 건너 뛰습니다. 모의 speedup (~5x Tokenizer 혼자), 그러나 더 중요하게: async 경계를 제거하십시오, 그래서 찬 경로는 0개의 동적인 수입품으로 시작합니다.

**시험 적용:** `browse/test/security-bunnative.test.ts`는 20개의 정착물 끈에 우리의 `input_ids` 경기 transformers.js 산출을 주장합니다.

##2. 앞으로 패스 (RESEARCH — 멀티 주)

단단한 부분. BERT-small에는:
  * 12 변압기 층
  * 숨겨진 크기 512, 관심 머리 8
  * ~30M 퍼짐 합계

각 앞으로 통행은:
  1. 삽입(ids → 512-dim 벡터)
  2. Positional 인코딩 추가
  3. 12 × (self-attention + FFN + LayerNorm)
  4. 풀러 (CLS token 투상)
  5. Classifier 머리 (2 방향 sigmoid)

뜨거운 경로는 변압기 층 당 12의 모물입니다. 각각은 ~512×512×{seq_len}. seq에서_len=128입니다 ~100 모양의 모물 (128, 512) @ (512, 512)입니다.

**두 개의 viable 접근법 :**

**접근 A: Float32Array + SIMD를 가진 순수한TS**
  * Bun의 타입 배열 지원 + SIMD 인트로닉스 (그것의 땅이 안으로 사용하되)
    Bun 안정 - 현재 wasm-only)
  * Implementation: ~2000 LOC of careful numerics. LayerNorm, GELU,
    softmax, 스케일 업 제품 관심 모든 손-위트.
  * 대기 시간 견적 : M-series에 30-50ms (매우 느린보다
    WebAssembly SIMD를 사용하는 WASM
  * VERDICT: 그것은 독립 가치가 없습니다. 순수한TS는 매트에 WASM를 이길 수 없습니다.

**접근 B: Bun FFI + 애플 가속**
  * Apple의 가속 프레임 워크 (cblas_sgemm)로 호출하려면 `bun:ffi`를 사용하십시오.
    M-series에서 cblas_sgemm는 768 × 768 매트멀이 ~0.5ms입니다.
  * Float32Array로 저장되는 무게 (ONNX 초기화기 10sors에서 적재하는
    시작), TS의 Tokenizer, FFI를 통해 매트, 순수한 TS에 있는 활성화.
  * 구현 : ~ 1000 LOC. 숫자는 동일하지만 대량
    작업은 BLAS에 해제됩니다.
  * 대기 시간 견적 : 3-6ms p50 (메타 대상).
  * RISK: macOS 전용. Linux는 FFI (다른 것)를 통해 OpenBLAS가 필요할 것입니다
    기호 레이아웃). Windows는 전체적인 별도의 이야기입니다.
  * VERDICT: macOS-first gstack에 사용할 수 있습니다. 기존의 배에 매치하세요.
    자세 (다윈 팔에만 컴파일 된 조력자).

**접근 C: Bun에 있는 WebGPU**
  * Bun 1.1.x에서 WebGPU 지원을 얻었다. transformers.js 이미 가지고 있다
    WebGPU 백엔드. 우리는 그것을 통해 네이티브 Bun를 경로를 경로를 수 있었습니까?
  * RISK: headless 서버 컨텍스트 macOS에 WebGPU는 적당한 것을 요구합니다
    표시 context. 컴파일된 bun 바이너리에서 작동 하는 경우.
  * STATUS: unexplored. 매치의 가치가 있는 승리 경로가 되십시오.

##3. 무게 로딩 (EASY — 배송)

ONNX 초기화제 tensors는 `bun:ffi`가 `mmap()`일 수 있는 편평한 이진 blob로 한 번 구조에 한 번 추출될 수 있습니다. 순중량 로더가 한 번에 빌드하는 것이 좋습니다. 골격은 아직 (transformers.js를 통해 적재하지 않습니다), 그러나 계획은 무게 로더가 한 번 접근 B가 선택되면 빌드하는 것이 간단한 것 입니다.

## 마일스톤

1. **Tokenizer + 벤치 하네스** (SHIPPED)
   Tokenizer는 정확한 테스트를 통과합니다. 벤치 마크는 10ms p50의 현재 WASM 기본을 기록합니다.

2. **Bun FFI 방호제** — `cblas_sgemm` 애플 가속에서,
   768×768의 매물이 되도록 합니다. <1ms 대기시간>을 확인해주세요.

3. **FFI에 있는 단 하나 변압기 층** - Q/K/V를 위한 cblas_sgemm 호출
   projections, layerNorm + softmax in TS를 구현합니다. 같은 input_ids에 onnxruntime에 대한 출력을 비교하십시오. 1e-4 절대 오류 내에서 일치해야합니다.

4. **전체 패스** - 모든 12개의 층 + 풀러 + 분류기 철사.
   100개의 고정 문자열을 통해 onnxruntime에 대한 정확한.

5. **회사연혁** - `classify()`체를 안으로 대체하십시오
   security-bunnative.ts. WASM의 삭제.

6. **분기별** — int8 매트릭스를 통해 가속의 cblas_sgemv, 영국_u8s8
   (사용 가능한 경우) 또는 onnxruntime-extensions로 돌아갑니다. ~50% 기억 감소, 마진 속도 승리.

## 왜 v1에서이를 발송하지?

정확한 점은 문제점입니다. 전단된 변압기의 뜨 점 reimplementation는 MULTI-WEEK 각 op가 참조를 가진 epsilon 수준 계약을 필요로 하는 기술설계 노력입니다. 층 Norm epsilon를 잘못하고 정확도 drifts를 조용히 얻으십시오. 틀린 취급을 그리고 분류하는 softmax 과잉을 얻으십시오 긴 입력에 쓰레기를 일으킵니다.

P0 보안 기능의 PR의 밑에 발송은 잘못된 위험 할당입니다. WASM 경로가 지금 발송하십시오 (done), 그것의 자신의 정정 시험 스위트를 가진 그 후에 위로 PR로 반전적으로 착륙한 공용영역을 증명하십시오.

## 벤치 마크

현재 기본 (`browse/test/security-bunnative.test.ts` 벤치 마크 모드에서 Apple M-series에 측정 된 - 다른 하드웨어의 YMMV) :

| 의논하기 | ◄ 제 50 편 | 149, 000 원 | 149, 000 원 | 참고 |
|---|---|---|---|---|
| transformers.js (WASM) | 10~20ms(일) | ~30ms의 | ~80ms의 | 따뜻한 후 |
| bun-native (stub — 대표) | WASM와 동일 |  |  | 디자인에 의해 일치 |

Approach B (Accelerate FFI) 땅을 때, 이 행은 새로운 숫자로 새로 고침되고 commit 메시지에 있는 델타 끌기로 옵니다.
