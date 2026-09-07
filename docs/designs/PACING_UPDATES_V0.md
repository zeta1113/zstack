# Pacing 업데이트 v0 - 디자인 도크

**상태:** V1.1 plan (not yet implemented). **추출:** [PLAN_TUNING_V1.md](./PLAN_TUNING_V1.md) during implementation, when review rigor revealed the pacing workstream had structural gaps unfixable via plan-text editing. **저자:** Garry Tan (user), with AI-assisted reviews from Claude Opus 4.7 + OpenAI Codex gpt-5.4. **리뷰 계획:** CEO + Codex + DX + Eng cycle, same rigor as V1.

## 크레딧

이 계획은 **[루이 드 Sadeleer](https://x.com/LouiseDSadeleer/status/2045139351227478199)** 때문에 존재합니다. 건축 검토 중 "예 예"는 단지 단지 단지 단지 jargon (V1 주소) - 그것은 일시 중지 및 기관이었다. 너무 긴 검토에 많은 중단 결정. V1.1는 반을 포장한다.

## 문제

Louise의 피로 읽기 gstack 리뷰 출력은 두 소스에서 왔습니다.

1. **항생제 밀도** - 기술 용어는 설명없이 나타났습니다. *V1 (ELI10 작성)에 있는 주소가 붙습니다.*
2. **Interruption 양** — `/autoplan` ran 4 단계 (CEO + 디자인 + Eng + DX), 각각 5–10 AskUserQuestion 프롬프트. 총 ≈ 30–50 프롬프트 ~45 분. 비 기술적인 사용자는 ~10-15-15 스로디션에서 체크 아웃. **V1.1입니다.**

번역은 단호한 볼륨을 수정하지 않습니다. 번역된 중단은 여전히 중단입니다. 수정은 WHEN 표면을 변경해야 하며 HOW는 단어를 쓰지 않습니다.

## 왜 추출 (V1의 세 번째 eng 검토 + Codex 패스 2)에서 파괴 간격

V1 계획 중, 파싱 작업스트림은 초안되었습니다. , 자동 입구 2 방향 문, 최대 3 AskUserQuestion는 검토 단계 당 신속한, 자동 입구 항목에 대한 Silent Decisions 블록, "flip <id>" 명령을 다시 열 자동 인식 결정 후 - 호크. 세 번째 eng-review 패스 + Second <secondCodex 패스 표면 10 간격 계획과 닫힐 수 없습니다. 편집 : 편집 :

1. **세션-state 모델 undefined.** Pacing은 상한 국가 (사용자가 튀길 수 있는 자동 받아들이는, 찾아내는) 필요로 합니다. V1에는 광택을 달기를 위한 per-skill-invocation 국가가 있고 그러나 상한 포장 기억을 위한 역행 상점 없음.
2. **단계 식별자 문제 로그에서 누락.** Silent Eng #8는 1단계 내에서 3개의 프롬프트를 경고할 때 원했습니다. V0의 `question-log.jsonl`에는 `phase` 필드가 없습니다. V1는 " schema 변화 없음"을 주장했습니다. - 강제적인 표적을 피합니다.
3. **의논문은 등록을 찾은 것입니다.** V0의 `scripts/question-registry.ts` 덮개 *의논하기* (기술 정의 시간에 등록하는). 검토 결과는 *의 의* (런타임에 발견되는) 입니다. 레지스트리를 통해 `door_type: one-way` 강제적인 것은 광고 호크 발견을 커버하지 않습니다. 1 방법 문 안전은 에이전트이 중간 전망을 일으키는 것을 찾는 것을 위해 강제하지 않습니다.
4. **prose로 pacing는 기존의 통제 교류를 invert 할 수 없습니다.** V1는 "랭크된 발견을 추가하기 위하여 계획된, 그 후에 prose를 전방하기 위하여 규칙을 요구합니다. 그러나 `plan-eng-review/SKILL.md.tmpl` 같이 기존하는 기술 템플렛에는 단면도 STOP/AskUserQuestion 순서 당이 있습니다. preamble에 있는 prose 규칙은 수직으로 수평으로 구분한 단면도 STOP를 과도하게 override 할 수 없습니다. 행동 변화는 sequencing, 표적으로 말하지 않습니다.
5. **Flip 메커니즘은 구현이 없습니다.** "변경하려면 `flip <id>`를 곱합니다. 명령 파서, state store, replay 동작이 없습니다. 대화가 콤팩트하고 Silent Decisions 블록이 컨텍스트를 나타낸다면, 원래 결정이 손실됩니다.
6. **마이그레이션 프롬프트는 중단입니다.** V1의 포스트 업그레이드 마이그레이션 프롬프트 (V0 prose 복원)는 중단 예산에 대한 계산 V1.1 감소하려고합니다. V1.1는 예산에서 면제하거나, Inter-1-of-N과 같이 포함해야 합니까?
7. **첫 번째 실행 preamble 프롬프트도 계산합니다.** 레이크 인트로, 원격 측정, 유동, 라우팅 주사 — 루이는 첫 번째 실행에 그들 모두를 보았다. 그들은 첫 번째 실제 기술 실행 전에 중단된다. V1.1은 이러한 새로운 사용자 대에 대한 로드 베어링을 감사해야합니다. 세션 N까지 방어 할 수 있습니다.
8. **실제 데이터에 대해 평가되지 않은 순위 수식.** V1는 `product 0-8` (broken: `{0,1,2,4,8}` 배급), 그 후에 `sum 0-6` 문턱 ≥ 4.를 가진 그러나 실제적인 발견 배급에 대하여 유효하지 않았습니다. V1.1는 계기 V0 질문으로 실제적인 발견 보기를, 그 후에 측정하는 것을 측정해야 합니다.
9. **"모든 편도 문 표면" vs "최대 3 단계"골격.** 원웨이 캡 = uncapped (안전); 양방향 캡 = 3. 그러나 계획은 명시적 선행없이 규칙을 모두 가지고 있었다. V1.1는 상태이어야한다 : 한 방향 문 표면은 단계 예산에 관계없이 캡핑.
10. **정의된 검증 값.** V1 계획은 N를 가진 "Silent Decisions 구획 ≥ N 입장"가 결코 정의되지 않으며, `active: true`는 처리한 처리 JSON에 있는 분야 결코 정의하지 않았습니다. V1.1는 구체적인 가치를 가져옵니다.

## V1.1를 위한 범위

1. **세션 상태 모델 정의.** per-skill-invocation vs per-phase vs per-conversation. 백킹 스토어: JSON file at `~/.gstack/sessions/<session_id>/pacing-state.json` that record which find the surfaced vs. auto-accepted per phase. Cleanup: 같은 TTL preamble에서 기존 세션 추적.

2. **`phase` 필드를 덧붙여서-log.jsonl schema를 추가하십시오.** 각 AskUserQuestion를 분류하여, (CEO/Design/ Eng/DX/기타)에서 온 단계에 대한 리뷰가 있습니다. 마이그레이션: 기존 항목은 `"unknown"`로 기본값으로 변경됩니다. 비 발산 스키마 확장.

3. **동적 검색에 대한 레지스트리 적용을 확장합니다.** 두 가지 옵션, CEO 리뷰 중 선택:
   - (a) 런타임 등록을 허용하기 위해 Widen `scripts/question-registry.ts` (ad-hoc ID는 여전히 로그 + 분류됩니다).
   - (b) 텍스트를 찾는 데 사용되는 보조 런타임 클래스터 `scripts/finding-classifier.ts` → 패턴 매칭을 사용하여 위험 계층을 추가합니다.

4. **사전 조립에서 테이크아웃을 기술 템플릿 컨트롤 플로우로 이동** 각 검토 기술 템플릿을 업데이트하십시오. (i)는 내부적으로 단계 완료, (ii)는 `gstack-pacing-rank` 이진, (iii)는 최대 3 AskUserQuestion 프롬프트, (iv)는 나머지와 침묵의 결정 블록을 방출합니다. preamble 규칙이 아닙니다 - 각 템플릿에 명시되어 있습니다.

5. **Flip 메커니즘 구현.** 새로운 바이너리 `bin/gstack-flip-decision`. 명령 파서는 `flip <id>` 사용자 메시지에서 허용한다. pacing-state.json의 원래 결정을 찾습니다. 명시된 AskUserQuestion로 다시 열 수 있습니다. 새로운 선택 persists.

6. **Migration-prompt 예산 결정.** Explicit 규칙: 1발 이동 프롬프트는 상한 중단 예산에서 면제됩니다. Rationale: 그들은 검토 단계 시작, 도중 아닙니다 전에 불.

7. **첫 번째 실행 감사.** 감사 호수 소개, 원격 측정, 유동, 라우팅 주사. 각: 이 로드 베어링은 처음 사용자, 또는 방어? 마찬가지로 결과: 모든 것을 억제하지만, 호수 소개까지 세션 2+. 사용자가 배로 갈 수 있는 `/plan-tune first-run` 명령을 통해 나머지 하나를 제공.

8. **순위 임계 값 교정.** 계기 V0의 질문으로 (읽힌 달리는, 역사가 있습니다). 최근 CEO + Eng + DX + Design review를 통하여 `severity × irreversibility × user-decision-matters`의 실제적인 배급을 측정하십시오. 진짜 자료에 근거를 둔 임계값을 선택하십시오. 표적: ~20%의 발견 표면, ~80% 자동 받아들이기의.

9. **Explicit 규칙: 1 방법 문은 capped.** 기술 템플릿에서 하드 코딩 : "단계 중단 예산에 관계없이 한 방향 도어 표면." 2 방향은 3 단계당 캡을 찾습니다.

10. **구체적인 검증 값.** `N` Silent Decisions (e.g., 비 트리 바이알 플랜에 예상되는 ≥ 5 항목)를 정의하고, 콘크리트 필드 이름과 처리량 JSON schema를 정의합니다.

## V1.1에 대한 수용 기준

- **중단 조사:** 루이 (또는 유사한 비 기술적인 collaborator)는 V0-baseline에 비교할 계획에 `/autoplan` 끝에 `/autoplan`를 재회합니다. AskUserQuestion 조사 ≤ 50%의 V0 기본선. (V1는 V1.1 구경측정을 위한 이 기본 성적 성적 성적 성적을 붙잡습니다.)
- **1방향 문 적용:** 안전-신호 결정의 100% (`door_type: one-way` OR classifier-flagged dynamic finds) 표면은 완전히 기술적인 세부사항에 개별적으로 덮습니다. Uncapped.
- **플립 라운드 스트립:** 사용자 유형 `flip test-coverage-bookclub-form`. AskUserQuestion로 본래 자동 허가된 결정 재개. 사용자의 새로운 선택은 침묵하는 결정 구획에 지속합니다 (또는 사용자가 surfacing를 비추는 경우에 제거됩니다).
- **상부 관측성:** `/plan-tune`는 어떤 세션든지를 위해, 질문을 log.jsonl의 새로운 `phase` 분야를 읽는 단계 AskUserQuestion 조사 당을 표시할 수 있습니다.
- **첫 번째 실행 감소:** 새로운 사용자는 그들의 첫번째 진짜 기술 뛰기 전에 ≤ 1개의 메타프로엠트 (레이크 인트로)를, 대 보. V1's 4 (레이크 + 원격 측정 + 능동태 + 여정).
- **인간 재런:** 루이 + 가리 독립적인 qualitative 리뷰, V1와 같은 본.

## V1에 따라 다름

V1.1 V1의 인프라 구축:
- `explain_level` 구성 키 + preamble echo 패턴 (A4).
- Jargon list + Writing Style Section (V1.1의 중단 언어는 ELI10 규칙을 존중해야 합니다).
- V0 기숙사 부정적인 시험 (V1.1는 5D 심리학 기계장치를 둘 다 모지 않을 것입니다).
- V1의 캡처 된 Louise transcript (응용 선명한 교정을위한 기초).

V1.1는 NOT 어떤 V2 품목 (E1 기질 배선, narrative/vibe, 등)에 달려 있습니다.

## 리뷰 계획

- **전 일:** 현재 V0 자료에서 실제 질문 로그 배포를 캡처합니다. 범위 #8의 교정 입력으로 사용하십시오.
- **CEO 리뷰.** 전제 도전: 올바른 수정을 일시적으로 파거나 V1.1이 전제 단계 제거를 고려해야 하나요? (E.g., 붕괴 CEO + Design + Eng + DX 단일 통합 검토 패스로.) 범위 모드: SELECTIVE EXPANSION 가능성이 (포장은 핵심, 관련 개선은 체리 그림입니다).
- **Codex 리뷰.** V1.1 계획에 독립 패스. 해당 영역 V1가 투쟁 한 이래 제어 흐름 변화 (스코프 #4)에 특정 스루티를 기대합니다.
- **DX 리뷰.** 플립 메커니즘의 DX에 초점은 `flip <id>` 발견할 수 있는, 명령 구문 자연, 오류 경로는 명확합니까?
- **ENG 검토 ×N.**는 V1와 같은 다수 통행을 예상합니다.

## NOT V1.1에 만져

V2 항목은 무시됩니다:
- Confusion-signal 검출
- 5D 심리학 구동 기술 적응 (V0 E1)
- /plan-tune narrative + /plan-tune vibe (V0 E3)
- Per-skill 또는 per-topic은 레벨을 설명합니다.
- 팀 프로필
- AST 기반 "배달 된 기능" 메트릭

## 포크 포트 파에서 폴더 2 (2026-08-14)

시간 - 낙하/gstack 포크는 보완 축에서 동일한 질문 피로를 공격했습니다 : 구조 스케일 분류 (session/hobby/project/제품/venture)는 기계장치를, 플러스 CHAIN-WIDE 질문 예산을 노래합니다. 승인 된 결정 (CEO 2026-08-14) : 포크의 ACCOUNTING 판결을 이 디자인 라운드로 접으십시오. 예산은 체인에 의해 (왼쪽, 결코 재설정되지 않는 것에서 사슬로 처리 된 검토 공제), handoffs는 질문 - 알레디 목, 승인/mutation 문은 그것을 조사하지 않으며 예산은 가장 어려운 결정에 먼저 보냈다. NOT는 포크의 5/8/12 숫자 일정을 채택한다 - 예산은 예산을 대체하고 예산을 대체 할 수 있습니다. pacing (this doc) 예산이 지출되는 것을 순위.
