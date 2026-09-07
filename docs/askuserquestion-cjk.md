# AskUserQuestion - ASCII / CJK 문자

AskUserQuestion가 중국어(繁體/繁體), 일본어, 한국어, 기타 비ASCII 텍스트를 포함할 때 이 문서를 읽어 보세요. 수술 규칙은 항상 AskUserQuestion 자체 검사("Non-ASCII 문자가 직접 작성되어 있습니다. NOT \u-escaped"); 이 문서는 전체 정당화입니다.

## 규칙

문자열 필드 (퀘스트, 옵션 라벨, 옵션 설명)가 비ASCII 텍스트를 포함하면 JSON 문자열의 리터 UTF-8 문자를 방출합니다. **`\uXXXX`로 그(것)들을 결코 탈출하지 마십시오.**

Claude Code의 도구 모수 관은 UTF-8 고유이고 unchanged를 통해서 특성을 통과합니다. JSON-mandatory 탈출만 허용됩니다: `\n`, `\t`, `\"`, `\\`.

## 왜 escaping 실패

수동으로 escaping은 훈련에서 각 코포인트를 호출하는 데 필요한, 긴 CJK 문자열에 대한 신뢰할 수 - 모델은 정기적으로 잘못된 코포인트를 방출. 예: 쓰기 `㄃` 생각 는 DOC (U+7BA1), 하지만 `㄃` 실제로  ⁇ , 그래서 사용자는 `管理工具` `㄃3用箱`로 렌더링.

트리거는 수백 개의 CJK 문자를 가진 긴 다선 질문입니다: 그것은 정확하게 때 반사 escaping 킥을 안으로 그리고 정확하게 때 miscoding는 최대 damaging. 긴 IME 탈출. 문자를 지키십시오.

- 잘못된: `"question": "請選擇\uXXXX\uXXXX\uXXXX\uXXXX"`
- 오른쪽: `"question": "請選擇管理工具"`
