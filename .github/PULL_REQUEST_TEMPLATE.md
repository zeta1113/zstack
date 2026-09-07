<!--
gstack는 AI로 코딩되었고, 그 사실을 자랑스럽게 여깁니다. 기준은 코드 줄 수가 아니라
실제 사용 증거입니다. 아무리 깔끔한 PR이라도 근거가 없으면 닫힙니다.
아래 모든 섹션을 채우세요. CONTRIBUTING.md → "The evidence bar"를 참고하세요.
-->

## 왜 (본인 말로)

<!-- 현재 사용자에게 무엇이 깨져 있고, 이 변경이 그것을 어떻게 해결하는지 한 문단으로 적으세요.
diff를 다시 설명하는 문장이 아니어야 합니다. -->

## 라이브 증거

<!-- 필수. 실제로 실행한 command와 real output을 붙여 넣으세요. before와 after를 모두 포함합니다.
bug라면 재현, 실패 상태, 수정 후 상태를 보여 주세요. skill 변경이라면 실제 transcript 또는
`claude -p` output을 포함하세요. 시각 변경이라면 before/after screenshot을 첨부하세요.
"bun test passes"만으로는 충분하지 않습니다. 바꾼 behavior를 보여 주세요. -->

```
# 실행한 command와 그 결과
```

## 범위

- **변경됨:**
- **실제 검증:**
- **테스트하지 않음:**

## Liveness Evidence (필수)

<!-- 본인 machine에서 `GSTACK PR` text를 live로 입력한 screenshot을 첨부하세요.
terminal prompt, shell command, browser address/search bar, editor buffer처럼 실제 surface에 직접 입력해야 합니다.
image에 그리거나 overlay하거나 편집해 넣은 것은 안 됩니다. 덧칠된 `GSTACK PR`은 automatic close 대상입니다.
이 PR을 사람이 열었다는 것을 확인하기 위한 절차입니다. -->

## 체크리스트

- [ ] Liveness screenshot 첨부: `GSTACK PR`을 실제 live surface에 직접 입력함(image edit 아님)
- [ ] generated file 전용 diff가 아님(source/template과 regenerated output을 함께 수정함)
- [ ] ETHOS.md를 수정하지 않았고 voice/founder POV/YC reference를 변경하지 않음
- [ ] 새 public command/external service/major adapter에는 연결된 accepted issue가 있음(또는 N/A)
- [ ] 연결된 issue 또는 재현: #
