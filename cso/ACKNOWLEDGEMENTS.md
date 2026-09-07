# Acknowledgements의 장점

/cso v2는 보안 감사 풍경을 통해 연구에 의해 알려졌습니다. 크레딧 :

- **[Sentry Security 리뷰](https://github.com/getsentry/skills)** - 신뢰 기반 보고 시스템 (HIGH 신뢰 발견만 보고) 및 "research before reporting" 방법론 (데이터 흐름, 체크 업스트림 검증) 우리의 8/10 매일 신뢰 게이트를 검증. TimOnWeb 테스트 5 테스트 중 만 보안 기술 평가.
- **[비트 스킬의 길](https://github.com/trailofbits/skills)** — 감사-콘텍스 건축 방법론 (헌팅 버그 전에 정신 모델을 구축) 직접 단계 0. 그들의 변형 분석 개념 (한 vuln을 설립? 같은 패턴에 대한 전체 코베이스 검색) 단계 12의 변형 분석 단계.
- **[샨논 으로 Keygraph](https://github.com/KeygraphHQ/shannon)** - 자율 AI pentester 달성 96.15% XBOW 벤치 마크 (100/104 악용). AI가 실제 보안 테스트를 수행 할 수 있음을 검증, 그냥 체크리스트 스캔. 우리의 단계 12 활성 검증은 어떤 산포가 살고있는 정적 분석 버전입니다.
- **[afiqiqmal/claude-security-audit](https://github.com/afiqiqmal/claude-security-audit)** — AI/LLM-specific 보안 검사 (보호 주사, RAG 독소, 허가를 부르는 도구)는 단계 7. 그들의 기구 수준 자동 탐지 (검출 “Next.js”를 “Node/TypeScript”)에 의하여 고무로 덮는 단계 0의 기구 탐지 단계.
- **[Snyk ToxicSkills 연구](https://snyk.io/blog/toxicskills-malicious-ai-agent-skills-clawhub/)** — AI 에이전트 기술의 36%가 보안 결함과 13.4%는 악의적인 단계 8 (Skill Supply Chain 스캐닝)입니다.
- **[Daniel Miessler의 개인 AI 인프라](https://github.com/danielmiessler/Personal_AI_Infrastructure)** - 사건 응답 playbooks 및 보호 파일 개념은 재약 및 LLM 안전 단계에 알렸습니다.
- **[McGo/claude-code-security-audit](https://github.com/McGo/claude-code-security-audit)** — 공유 가능한 보고서 생성 및 행동 가능한 epics의 아이디어는 우리의 보고서 형식 진화를 알려줍니다.
- **[Claude Code 보안 팩](https://dev.to/myougatheaxo/automate-owasp-security-audits-with-claude-code-security-pack-4mah)** - 모듈 접근법 (/security-audit, /secret-scanner, /deps-check 기술)은 이러한 특정한 관심사임을 검증했습니다. 우리의 통일된 접근법은 크로스 위상 소싱을 위한 모듈성을 희생합니다.
- **[Anthropic Claude Code 보안](https://www.anthropic.com/news/claude-code-security)** — 다단계 검증 및 신뢰는 우리의 평행한 발견 검증 접근을 검증했습니다. 열려있는 근원에 있는 500+ 0days를 발견했습니다.
- **[@gus_argon의](https://x.com/gus_aragon/status/2035841289602904360)** - 식별된 중요한 v1 눈 먼 반점: 더미 탐지 (모든 언어 본을 실행하십시오), 대신 Claude Code의 윤활 도구, `| head -20`의 대신에 bash grep를 이용합니다, truncates 결과가 침묵적으로, 그리고 preamble bloat를. 이 직접 모양 v2의 더미 첫번째 접근 및 Grep 도구 위임.
