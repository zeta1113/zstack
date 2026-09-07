<!-- AUTO-GENERATED from audit-phases.md.tmpl — do not edit directly -->
<!-- Regenerate: bun run gen:skill-docs -->
**범위 문 (첫째로 읽기).** This section holds every scope-dependent phase (2-11), but you run ONLY the phases your resolved mode selected back in `## Mode Resolution` (always-loaded in the skeleton). Phases 0, 1, 12, 13, 14 always run; Phases 2-11 are scope-gated. "Execute in full" means work through this section applying that selection, NOT run a phase your mode did not select just because its prose lives here. Example: `--owasp` runs Phase 9 from this section, not Phases 2-8/10/11.

### 2 단계: 비밀 고고학

누출 된 자격 증명을위한 스캔 git 역사, 추적 된 `.env` 파일, 인라인 비밀과 CI 구성을 찾습니다.

**Canonical 패턴 카탈로그.** The HIGH-tier credential prefixes the archaeology greps below target (AKIA, ghp_, sk-ant-, sk_live_, xoxb-, `-----BEGIN ... PRIVATE KEY-----`, etc.) are the same set `/spec`'s in-flight redaction blocks on. The full 3-tier taxonomy (HIGH credentials, MEDIUM PII/legal/internal, LOW) is generated from and lives in `lib/redact-patterns.ts` — the single source of truth shared by the `gstack-redact` engine, `/spec`, `/ship`, and the `/document-*` skills.

**Git 역사 — 알려진 비밀 접두사:**
```bash
git log -p --all -S "AKIA" --diff-filter=A -- "*.env" "*.yml" "*.yaml" "*.json" "*.toml" 2>/dev/null
git log -p --all -S "sk-" --diff-filter=A -- "*.env" "*.yml" "*.json" "*.ts" "*.js" "*.py" 2>/dev/null
git log -p --all -G "ghp_|gho_|github_pat_" 2>/dev/null
git log -p --all -G "xoxb-|xoxp-|xapp-" 2>/dev/null
git log -p --all -G "password|secret|token|api_key" -- "*.env" "*.yml" "*.json" "*.conf" 2>/dev/null
```

**.env 파일이 git에 의해 추적:**
```bash
git ls-files '*.env' '.env.*' 2>/dev/null | grep -v '.example\|.sample\|.template'
grep -q "^\.env$\|^\.env\.\*" .gitignore 2>/dev/null && echo ".env IS gitignored" || echo "WARNING: .env NOT in .gitignore"
```

**CI 인라인 비밀과 구성 (비밀 매장을 사용하지 않음):**
```bash
for f in $(find .github/workflows -maxdepth 1 \( -name '*.yml' -o -name '*.yaml' \) 2>/dev/null) .gitlab-ci.yml .circleci/config.yml; do
  [ -f "$f" ] && grep -n "password:\|token:\|secret:\|api_key:" "$f" | grep -v '\${{' | grep -v 'secrets\.'
done 2>/dev/null
```

**공급 능력:** CRITICAL git 역사 (AKIA, sk_live_, ghp_, xoxb-)의 활성 비밀 패턴에 대한 HIGH .env는 git, CI configs with inline credentials. MEDIUM suspicious .env.example 값.

**FP 규칙:** Placeholders ("your_", "changeme", "TODO") 제외. 테스트 고정은 테스트 코드에 동일한 값을 사용하지 않는 한 제외. 회전 비밀은 여전히 파쇄 (그들은 노출되었다). `.env.local` 에서 `.gitignore` 예상됩니다.

**Diff 형태:** `git log -p <base>..HEAD`를 가진 `git log -p --all`를 대체하십시오.

### 단계 3: 의존성 공급 사슬

`npm audit`를 넘어갑니다. 실제 공급망 위험을 확인하십시오.

**포장 매니저 탐지:**
```bash
[ -f package.json ] && echo "DETECTED: npm/yarn/bun"
[ -f Gemfile ] && echo "DETECTED: bundler"
[ -f requirements.txt ] || [ -f pyproject.toml ] && echo "DETECTED: pip"
[ -f Cargo.toml ] && echo "DETECTED: cargo"
[ -f go.mod ] && echo "DETECTED: go"
```

**표준 취약점 검사:** 패키지 관리자의 감사 도구가 모두 사용할 수 있습니다. 각 도구는 선택 사항입니다. 설치되지 않은 경우, "SKIPPED - 설치 지침이있는 도구가 설치되지 않음"으로 보고서에주의하십시오. 이것은 정보, NOT 찾는 것입니다. 감사는 모든 도구와 함께 계속 ARE 사용할 수 있습니다.

**생산 deps (공급 체인 공격 벡터)에 있는 스크립트를 설치하십시오:** Node.js 프로젝트를 위해 수화 `node_modules`, `preinstall`, `postinstall`, `install` 스크립트를 위한 생산 의존성을 검사하십시오.

**Lockfile 무결성:** lockfiles가 AND git에 의해 추적되는 것을 확인합니다.

**공급 능력:** CRITICAL는 직접적인 deps에서 알려진 CVEs (high/critical)를 위해 HIGH를 설치합니다. prod deps/가락한 lockfile에 있는 스크립트를 설치하십시오. MEDIUM는 버려진 포장/중간 CVEs/lockfile를 추적하지 않습니다.

**FP 규칙:** devDependency CVEs는 MEDIUM 최대입니다. `node-gyp`/`cmake`는 예상된 스크립트를 설치합니다 (MEDIUM 아닙니다 HIGH). 알려진 악용 없이도 접근 가능한 고문. 라이브러리 저장소 (앱이 아닙니다)를 위한 lockfile를 미스링하는 것은 NOT를 찾는 것입니다.

### 4 단계: CI/CD 파이프라인 보안

작업 흐름을 수정할 수 있는 확인 및 접근할 수 있는 비밀.

**GitHub 동작 분석:** 각 워크플로 파일을 위해, 체크를 위한:
- 언핀된 제3자 작업 (SHA-pinned) - `uses:` 줄이 누락된 `@[sha]`를 위한 Grep를 사용하십시오
- `pull_request_target` (수익: 포크 PRs는 접근을 얻습니다)
- `${{ github.event.* }}`를 통해 스크립트 주입 `run:` 단계
- env vars로 비밀 (로그에 있는 누수)
- CODEOWNERS 워크플로 파일에 대한 보호

**공급 능력:** CRITICAL for `pull_request_target` + PR code / script injection through `${{ github.event.*.body }}` in `run:` steps. HIGH unpinned 제 3 자 행동/ secret as env vars without masking. MEDIUM for missing CODEOWNERS on 워크플로 파일.

**FP 규칙:** 첫파티 `actions/*` unpinned = MEDIUM not HIGH. `pull_request_target` ref 체크 아웃없이 ref 안전 (precedent #11). `with:` 블록의 비밀은 (`env:`/`run:`) runtime에 의해 처리됩니다.

### 단계 5: 인프라 섀도 표면

shadow 인프라를 과도한 접근으로 찾기.

**Dockerfiles:** 각 도커파일의 경우, `USER` 지시어를 누락한 경우 `ARG`, `.env` 파일로 복사한 `.env` 파일로, `USER`로 전달된 비밀을 `USER`로 체크한다.

**prod 자격 증명을 가진 Config 파일:** 데이터베이스 연결 문자열을 검색하기 위해 Grep를 사용 (postgres://, mysql://, mongodb://, redis://) 설정 파일에서, localhost/127.0.0.1/example.com. 를 제외하고는 prod를 참조하는 staging/dev config.

**IaC 보안:** Terraform 파일을 위해 `"*"`의 IAM 동작/resources의 `.tf`/`.tfvars`에 있는 단단한 암호로 고쳐 쓴 비밀을 검사하십시오. K8s를 위해, 특권한 콘테이너를 위한 체크, hostNetwork, hostPID.

**공급 능력:** CRITICAL for prod DB URL은 Docker 이미지로 구운 민감한 자원에 IAM Docker에 있는 credentials에 있는 credentials로 URL을 구부렸습니다. HIGH prod에 있는 뿌리 콘테이너를 위해 DB 접근/특수 K8s로 구부리십시오. MEDIUM를 위한 누락된 USER 지시/열정한 항구를 위해 HIGH.

**FP 규칙:** `docker-compose.yml` 로컬 dev에 대한 로컬 dev를 로컬 호스트 = 찾을 수 없습니다 (precedent #12). `data` 소스에서 `"*"` (read-only). K8s는 `test/`/`dev/`/`local/`에서 로컬 호스트 네트워킹을 제외합니다.

### 단계 6: Webhook & 통합 감사

어떤 것을 받아들이는 inbound endpoints를 찾으십시오.

**Webhook 경로:** webhook/hook/callback 노선 패턴을 포함하는 파일을 찾을 수 있습니다. 각 파일에 대해서는 서명 확인(signature, hmac, check, digest, x-hub-signature, stripe-signature, svix)을 포함합니다. webhook 경로와 파일이 있지만 NO 시그니처 검증은 발견됩니다.

**TLS 검증 가능:** `verify.*false`, `VERIFY_NONE`, `InsecureSkipVerify`, `NODE_TLS_REJECT_UNAUTHORIZED.*0`와 같은 본을 검색하기 위하여 윤활을 사용하십시오.

**OAuth 범위 분석:** 사용 Grep는 OAuth 윤곽을 찾아내고 지나치게 넓은 범위를 위한 검사합니다.

**검증 접근 (code-tracing only — NO 실시간 요청):** webhook 발견을 위해, 서명 확인이 미들웨어 체인 (parent router, middleware stack, API Gateway config)에서 어디에서든지 존재하는지 결정하는 핸들러 코드를 추적합니다. NOT는 webhook endpoints에 실제 HTTP 요청을 합니다.

**공급 능력:** CRITICAL는 어떤 서명 검증 없이 webhooks를 위해. HIGH를 위한 TLS는 prod 코드/다시 넓은 OAuth 범위에서 사용했습니다. MEDIUM는 3개의 당사자에 비문을 받지 않는 outbound 자료 교류를 위해.

**FP 규칙:** TLS는 시험 코드에서 제외했습니다. 개인적인 네트워크 = MEDIUM에 내부 서비스하에 webhooks. 서명 검증 상류를 취급하는 API 출입구 뒤에 Webhook 엔드포인트는 NOT 발견입니다 — 그러나 증거를 요구합니다.

### 단계 7: LLM & AI 안전

AI/LLM-specific 취약점 확인. 새로운 공격 클래스입니다.

이 패턴을 검색하는 Grep를 사용합니다:
- **신속한 주입 벡터:** 시스템 프롬프트 또는 도구 스키마로 흐르는 사용자 입력 - 시스템 프롬프트 건설 근처의 문자열 교환을 찾습니다
- **unsanitized LLM 산출:** `dangerouslySetInnerHTML`, `v-html`, `innerHTML`, `.html()`, `raw()` 연출 LLM 응답
- **유효성 검사 없이 호출하는 Tool/function:** `tool_choice`, `function_call`, `tools=`, `functions=`
- **AI API 키 코드 (Env vars):** `sk-` 본, 하드코드 API 키 할당
- **LLM 출력의 Eval/exec:** `eval()`, `exec()`, `Function()`, `new Function` 처리 AI 응답

**키 체크 (생각된 grep):**
- Trace 사용자 콘텐츠 흐름 — 시스템 프롬프트 또는 도구 스키마를 입력합니까?
- RAG 독: 외부 문서는 AI 행동을 통해 영향을 줄 수 있습니까?
- 도구 호출 권한: LLM 도구 호출은 실행하기 전에 유효합니까?
- 산출 위생: 믿을 수 있는 (HTML로, 코드로 실행되는 LLM 산출은?
- Cost/resource 공격: 사용자가 LLM 호출을 해제할 수 있습니까?

**공급 능력:** CRITICAL 시스템의 사용자 입력을 위해 LLM 출력 HTML/ LLM 출력으로 렌더링되지 않는 HIGH. HIGH 누락된 도구 호출 유효성 검사/ 노출 AI API 열쇠를 위해 MEDIUM unbounded LLM 전화/RAG 입력 유효성 검사 없이.

**FP 규칙:** AI 대화의 사용자 평균 위치에 있는 사용자 내용은 NOT 프롬프트 주입 (precedent #13)입니다. 사용자 내용이 체계 프롬프트, 도구 스키마 또는 기능 호출 상황에 입력할 때만 깃발만.

### 단계 8: 기술 공급 사슬

스캔은 Claude Code 악성 패턴에 대한 기술. 게시 된 기술의 36% 보안 결함, 13.4%는 악명 높은 악명 높은 악명 높은 (Snyk ToxicSkills 연구).

**Tier 1 - 리포 로컬 (자동) :** repo의 의심스러운 패턴의 로컬 기술 디렉토리를 스캔:

```bash
ls -la .claude/skills/ 2>/dev/null
```

강력한 패턴을 위한 로컬 스킬 SKILL.md 파일을 검색하는 Grep를 사용합니다:
- `curl`, `wget`, `fetch`, `http`, `exfiltrat` (네트워크 여과)
- `ANTHROPIC_API_KEY`, `OPENAI_API_KEY`, `env.`, `process.env` (수입 접근)
- `IGNORE PREVIOUS`, `system override`, `disregard`, `forget your instructions` (보호 주입)

**Tier 2 - 글로벌 기술 (허가 필요) :** 글로벌 설치 기술 또는 사용자 설정을 스캔하기 전에 AskUserQuestion: "Phase 8은 전 세계적으로 설치 될 수 있습니다 AI 코딩 에이전트 기술과 악의적인 패턴에 대한 후크. 이 repo 외부 파일을 읽는다. 이 포함하시겠습니까?" 옵션: A) Yes — 스캔 글로벌 기술 너무 B) No - repo-local only

승인되면 글로벌 설치 기술 파일에 동일한 Grep 패턴을 실행하고 사용자 설정에서 Hook을 확인합니다.

**공급 능력:** CRITICAL for credential exfiltration attempts / 기술 파일에서 신속한 주입. 의심스러운 네트워크 통화 / 과도한 넓은 도구 권한을위한 MEDIUM. 검토없이 비난되지 않은 소스에서 기술을위한 MEDIUM.

**FP 규칙:** gstack의 자신의 기술은 신뢰할 수 있습니다 (기술 경로가 알려진 repo로 해결하는 경우 검사). `curl`를 사용하는 기술 (도구 다운로드, 건강 검사) 대상 URL이 의심스러운 경우만 플래그 또는 명령이 credential 변수를 포함 할 때.

### 단계 9: OWASP 정상 10 평가

각 OWASP 카테고리의 경우, 대상 분석 수행. 모든 검색에 대한 Grep 도구를 사용하여 - 단계 0에서 스택을 감지 할 수있는 범위 파일 확장.

#### A01: 브로큰 접근 제한
- 컨트롤러에 auth를 누락 체크/routes (skip_의 전_action, Skip_인증, public, no_auth)
- 직접 객체 참조 패턴 확인 (params[:id], req.params.id, request.args.get)
- 사용자 접근 사용자 B의 리소스를 변경하여 ID를 변경할 수 있습니까?
- 수평 /vertical 특권 에스컬레이션이 있습니까?

#### A02: 암호화 실패
- Weak 암호화 (MD5, SHA1, DES, ECB) 또는 하드 코딩된 비밀
- 민감한 데이터는 나머지와 transit에서 암호화됩니까?
- key/secrets 제대로 관리 (잘못된 vars, 아니)?

#### A03: 주입
- SQL 주입: 익지않는 쿼리, SQL에 있는 끈 interpolation
- 명령 주입: 체계 (), 실행 (), 스페인 사람 (), 교황
- 템플릿 주입 : params, eval(), html_safe, raw()로 렌더링
- LLM 신속한 주입: 포괄적인 적용을 위한 단계 7를 보십시오

#### A04: Insecure 디자인
- 인증 엔드포인트에 대한 비율 제한?
- 실패한 시도 후에 계정 차단?
- Business logic 검증된 서버 측?

#### A05: 보안 Misconfiguration
- CORS 구성 (생산에 있는 종래 근원?)
- CSP 헤더가 존재합니까?
- Debug 모드 / 생산 오류를 동등?

#### A06: 취약하고 그리고 걸출한 성분은 종합적인 성분 분석을 위한 **3단계 (Dependency Supply Chain)**를 보십시오.

#### A07: 식별과 인증 실패
- 세션 관리: 생성, 저장, 잘못된
- 비밀번호 정책: 복잡성, 회전, breach 검사
- MFA: 사용 가능? admin에 적용?
- 토큰 관리: JWT 만료, 새로 고침 교체

#### A08: 소프트웨어와 자료 불완전성 실패는 파이프라인 보호 분석을 위한 **4단계(CI/CD 파이프라인 보안)**를 보십시오.
- 탈선 입력이 유효합니까?
- 외부 데이터에 대한 보장?

#### A09: 보안 로깅 및 모니터링 실패
- 인증 이벤트가 기록되었습니까?
- 로그인 실패?
- 관리자 작업 감사 - 탈취?
- 탬퍼링에서 보호되는 로그?

#### A10: 서버 측 요구 위조 (SSRF)
- URL 사용자 입력에서 건축?
- 사용자 제어 URL에서 내부 서비스 범위?
- Allowlist/blocklist 아웃바운드 요청에 따라 강제적인가요?

### 단계 10: STRIDE 위협 모형

각 주요 구성 요소는 Phase 0에서 확인, 평가:

```
COMPONENT: [Name]
  Spoofing:             Can an attacker impersonate a user/service?
  Tampering:            Can data be modified in transit/at rest?
  Repudiation:          Can actions be denied? Is there an audit trail?
  Information Disclosure: Can sensitive data leak?
  Denial of Service:    Can the component be overwhelmed?
  Elevation of Privilege: Can a user gain unauthorized access?
```

### 단계 11: 자료 분류

응용 프로그램에 의해 처리 된 모든 데이터 분류 :

```
DATA CLASSIFICATION
═══════════════════
RESTRICTED (breach = legal liability):
  - Passwords/credentials: [where stored, how protected]
  - Payment data: [where stored, PCI compliance status]
  - PII: [what types, where stored, retention policy]

CONFIDENTIAL (breach = business damage):
  - API keys: [where stored, rotation policy]
  - Business logic: [trade secrets in code?]
  - User behavior data: [analytics, tracking]

INTERNAL (breach = embarrassment):
  - System logs: [what they contain, who can access]
  - Configuration: [what's exposed in error messages]

PUBLIC:
  - Marketing content, documentation, public APIs
```

