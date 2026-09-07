# Slop-scan : 해결하는 방법, 떠나는 것

CLAUDE.md (token-load reduce)에서 동사. 어떤 사면든지 찾아내기 전에 읽으십시오.

### 수정하는 것 (genuine 질 개선)

- **파일 ops 주위에 빈 캐치** - `safeUnlink()` (ignores ENOENT, 재화
  EPERM/EIO). EPERM를 세키게 되며, 클린업에서는 침묵 데이터 손실이 발생합니다.
- **빈 캐치 주위에 프로세스 죽이** - `safeKill()` (ignores ESRCH, 재화
  EPERM). 삼키는 EPERM는 당신이 당신이 하지 않은 무언가를 살해한다는 것을 의미합니다.
- **중복 `return await`** - no를 호출하면 제거하십시오. 저장
  microtask, 신호 의도.
- **유형 예외 캐치** — `catch (err) { if (!(err instanceof TypeError)) throw err }`
  시험 구획이 URL 파싱 또는 DOM 일 때 `catch {}` 보다는 진짜로 더 낫습니다. 당신은 당신이 예상한 어떤 과실을 알고 있습니다, 그래서 이렇게 말하십시오.

### NOT 수정 (리터 게임, 품질)

- **오류 메시지에 문자열 매칭** - `err.message.includes('closed')`는 흉부입니다.
  Playwright/Chrome는 언제든지 단어를 변경할 수 있습니다. 불독 작업이 ANY 이유에 실패할 수 있고, `catch {}`는 올바른 패턴입니다.
- **패스트로 래퍼를 면제하는 의견 추가** — 위의 "동의 세션 별"
  여행의 slop-scan의 면제 규칙은 소음이 아닌 문서입니다.
- **확장 파일 캐치 및 로그 변환** — Chrome 확장 충돌
  완전히 실패 오류. 캐치 로그가 계속되면, IS 확장 코드에 대한 올바른 패턴. 그것을 던지지 마십시오.
- **최상의 청결을 꽉 쥔다** - 폐쇄, 비상 정리 및 차단
  코드는 `safeUnlinkQuiet()` (swallows ALL 오류)를 사용해야합니다. EPERM에 던지는 깨끗한 경로는 정리가 실행되지 않습니다. 그것은 더 악화됩니다.

### `browse/src/error-handling.ts`의 유틸리티

| 의 특징 | 사용시 | Behavior |
|----------|----------|----------|
| `safeUnlink(path)` | 일반 파일 deletion | Ignores ENOENT, 다른 사람을 재화 |
| `safeUnlinkQuiet(path)` | Shutdown/emergency 정리 | 모든 오류를 삼키다 |
| `safeKill(pid, signal)` | 신호 전송 | Ignores ESRCH, 다른 사람을 재화 |
| `isProcessAlive(pid)` | Boolean 공정 검사 | true/false를 반환하지 않고 |

### 점수 추적

기본 (2026-04-09, 정리하기 전에) : 100 개의 발견, 432.8 점수, 2.38 점수/file. 정리 후 : 90 개의 발견, 358.1 점수, 1.96 점수/file.

숫자를 쫓지 마십시오. 실제 코드 품질 문제를 나타내는 패턴을 수정하십시오. "sloppy" 패턴이 올바른 엔지니어링 선택 인 검색을 수락하십시오.
