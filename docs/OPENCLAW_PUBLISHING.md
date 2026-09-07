# ClawHub에 Native OpenClaw 기술 출판

CLAUDE.md (토큰 로드 감소)에서 동사.

## 워크 플로우

OpenClaw 기술은 `openclaw/skills/gstack-openclaw-*/SKILL.md`에서 살고 있습니다. 이들은 ClawHub에 간행된 손 만들어진 방법론 기술입니다 그래서 어떤 OpenClaw 사용자는 그(것)들을 설치할 수 있습니다.

**출판 :** 명령은 `clawhub publish` (NOT `clawhub skill publish`)입니다:

```bash
clawhub publish openclaw/skills/gstack-openclaw-office-hours \
  --slug gstack-openclaw-office-hours --name "gstack Office Hours" \
  --version 1.0.0 --changelog "description of changes"
```

각 기술을 반복하십시오: `gstack-openclaw-ceo-review`, `gstack-openclaw-investigate`, `gstack-openclaw-retro`. 각 갱신에 `--version`를 덤불로 둘러싸기.

**Auth:** `clawhub login` (GitHub auth를 위한 브라우저를 엽니다). `clawhub whoami`는 확인합니다.

**공급 능력:** `clawhub publish` 명령어와 `--version`와 `--changelog`를 더 높게 합니다.

**인증:** `clawhub search gstack`는 그들이 살고 있는지 확인합니다.
