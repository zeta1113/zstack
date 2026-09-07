# iOS QA daemon의 ACL 예제

Mac-side daemon은 `--tailnet`를 통과할 때만 Tailscale 인터페이스를 결합합니다. 기본적으로 daemon은 로컬USB-만입니다. 이 문서는 iPhone을 원격 에이전트에 안전하게 노출하기 위해 단계를 통해 걸어가며, tailnet에서 iOS QA를 실행할 수 있습니다.

## 목 모형 recap

- **iOS 앱 상태Server:** 루프백 전용 항상. Mac에서 Mac에서 도달 가능
  CoreDevice IPv6 터널. 직접 tailnet에 바인딩하지 마십시오.
- **맥 데몬:**는 tailnet 공용영역을 소유합니다. 2명의 청취자 인 발라드백
  (전면, 결코 앞으로) 및 tailnet (기능 층을 가진 고정된 수당).
- **Auth:** 로컬 `tailscaled` 소켓을 통해 정해진 정체성 검증
  (`/var/run/tailscale.sock` LocalAPI WhoIs). `~/.gstack/ios-qa-allowlist.json`의 허용 목록 파일은 누가 할 수있는 진실의 단일 소스입니다.

## 단계 1: 설치 및 실행 Tailscale

```bash
brew install --cask tailscale
# Login + start tailscaled, then verify:
tailscale status
```

daemon 을 확인하면 LocalAPI 소켓을 읽을 수 있습니다.

```bash
test -S /var/run/tailscale.sock && echo "socket present" || echo "MISSING"
```

무관심이 없는 경우, daemon는 tailnet 청취자 (fail-closed)를 열지 않습니다.

## 단계 2: daemon의 ACL를 설정

daemon는 특정 기능 계층에 어떤 장치가 제어 할 수 있는지 알고 있어야합니다. 허용 목록 파일은 JSON입니다.

```json
{
  "version": 1,
  "entries": [
    {
      "identity": "you@example.com",
      "capabilities": ["restore"],
      "expires_at": null,
      "note": "Owner — full access"
    },
    {
      "identity": "ci@example.com",
      "capabilities": ["mutate"],
      "expires_at": "2026-12-31T00:00:00Z",
      "note": "CI runner — can write state but not full restore"
    },
    {
      "identity": "tag:claude-readonly",
      "capabilities": ["observe"],
      "expires_at": null,
      "note": "Agents that should only read"
    }
  ]
}
```

ID는 WhoIs를 통해 canonicalized:

- **사용자 OAuth:** `user@example.com` (`acct:`, 도메인 rewriting 없음).
- **태그 노드:** `tag:<tagname>` (낮은).
- **노드 키:** `node:<nodekey-hex>` (rare; 대신 태그를 사용하십시오).

기능 계층은 주문됩니다 : `observe` `interact` `mutate` `restore`. 부여 `restore` 모든 낮은 층을 의미한다.

## Step 3: 원격 에이전트에 대한 세션 토큰을 채굴

에이전트 자체 민트를 할 수 있습니다 (그의 ID가 허용되는 경우) 또는 서버 측을 축소 할 수 있습니다.

```bash
# Server-side mint (owner-only, runs locally on the Mac with the device):
gstack-ios-qa-mint --remote ci@example.com --capability mutate --ttl 1h

# Self-service mint (agent over tailnet):
curl -X POST http://<mac-tailnet-ip>:9999/auth/mint \
  -H "Content-Type: application/json" \
  -d '{"capability": "interact"}'
# → {"session_token": "...", "expires_at": "...", "capability": "interact"}
```

## 단계 4: 스태크 ACL (깊은 깊이에 있는 조밀한)를 꽉 죕니다

daemon의 수당은 1 차 액세스 제어입니다. 벨트 및 스스펜더 : *의 특징*도 할 수있는 한계에 tailnet ACL를 제한합니다.

```jsonc
// In your tailscale admin console:
{
  "acls": [
    // Allow CI runner to reach the iOS QA Mac on port 9999 only.
    {
      "action": "accept",
      "src": ["ci@example.com"],
      "dst": ["ios-qa-mac:9999"]
    },
    // Tagged Claude agents — observe tier only (enforced by daemon, not ACL).
    {
      "action": "accept",
      "src": ["tag:claude-readonly"],
      "dst": ["ios-qa-mac:9999"]
    },
    // Default deny.
    {
      "action": "drop",
      "src": ["*"],
      "dst": ["ios-qa-mac:9999"]
    }
  ]
}
```

## Step 5: 감사 트레일

tailnet 청취자를 통해 모든 정통한 mutating 요청은 `~/.gstack/security/ios-qa-audit.jsonl`에 행을 씁니다:

```jsonl
{"ts":"2026-05-18T14:23:00Z","identity":"ci@example.com","device_udid":"00008101-XXXX","endpoint":"/tap","session_id":"abc...","capability":"interact","request_id":"req_001","status":200}
```

Rejections ( 토큰 없음, 만료 된 토큰, 기능 부족, 정체성 허용되지 않음, 속도 제한 히트) `~/.gstack/security/attempts.jsonl`로 작성.

## 비율 한계

- `/auth/mint`: 10분 / 60분 / 정체성. 11회 반환 429.
- Per-tailnet-request 몸: 1MB 하드캡 (413 위).
- 스크린 샷 응답 : 10MB 하드 캡 (질화 오류가 500 위).

## 토큰 수명

- daemon 채굴 세션 토큰: 기본 1h TTL, 최대 24h via
  `--tailnet-session-ttl`.
- `POST /session/heartbeat`를 통해 새로 고침 가능 (`ttl_seconds`, capped에 의해 제외하십시오
  원래 최대).
- Boot Token (iOS 앱 출시 및 데몬 교체) : ~5s의 수명 -
  daemon는 첫 번째 스크랩에서 즉시 회전합니다.

## 실패 모드

| 의약 | 의 원인 | Action |
|---|---|---|
| daemon은 tailnet 청취자를 공개하지 않습니다 | `/var/run/tailscale.sock` 누락되거나 허가를 받지 않는 | Tailscale 설치; `tailscale status`는 사용자의 실행 daemon로 작동 |
| `403 identity_not_allowed` | Allowlist에서 누락된 ID | 소유자 민트: `gstack-ios-qa-mint --remote <identity>` |
| `403 capability_insufficient` | endpoint 요구의 밑에 토큰 층 | `--capability` tier와 함께 최소 |
| `429 rate_limited` | >10 mints/min 한 정체성에서 | 60s를 대기; 왜 에이전트이 재분해하는지 조사 |
| `409 schema_mismatch` `/state/restore` | 이전 앱 빌드에서 snapshot | 스냅샷을 덮어; 현재 앱 빌드에서 재 캡처 |
