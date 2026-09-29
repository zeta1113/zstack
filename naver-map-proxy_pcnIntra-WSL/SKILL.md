---
name: naver-map-proxy_pcnIntra-WSL
version: 1.0.0
description: pcnIntra 호스트 크롬에서 네이버 지도 API(oapi.map.naver.com 등)가 뜨도록, pcnDev를 경유하는 도메인 화이트리스트 프록시를 구성·점검한다.
triggers:
  - naver map api 안 뜸
  - 네이버 지도 안 뜸
  - pcnIntra 프록시
---

# naver-map-proxy_pcnIntra-WSL

**이 스킬은 `_pcnIntra-WSL` 가지다 — 다른 머신엔 대응하는 일반판이 없다.** pcnIntra는 정책상
일반 인터넷이 막혀있고 `oapi.map.naver.com` 딱 하나만 예외로 뚫려있는, 이 머신에만 있는 제약이라
가지를 칠 필요가 있었다(다른 머신은 인터넷이 되니 이 문제 자체가 없음).

## 왜 필요한가

pcnIntra 호스트에서 네이버 지도 API를 쓰는 웹페이지를 크롬으로 열면 지도가 안 뜬다. 확인해보니:

- `oapi.map.naver.com`(API 로더 스크립트)만 예외적으로 뚫려있고
- 지도가 실제로 그려지려면 필요한 `map.pstatic.net`(타일), `naveropenapi.apigw.ntruss.com`(geocoding 등
  신규 API)은 전부 막혀있었다.

즉 스크립트는 로드되는데 그 다음 리소스들이 전부 실패해서 지도가 안 그려지는 것 — 순수 네트워크
정책 문제지 API 키·구현 문제가 아니었다.

## 구성 (2026-09-29, pcnDev-WSL-claude가 구축)

```
pcnIntra 크롬 (PAC 적용)
  --proxy-pac-url=http://192.168.101.200:8899/proxy.pac
  PAC: map.naver.com/map.naver.net/pstatic.net/ntruss.com → PROXY, 나머지 → DIRECT
       ↓ (해당 도메인만)
Windows 호스트 192.168.101.200:8899
  (netsh portproxy: 0.0.0.0:8899 → pcnDev WSL 172.24.8.106:8899, 관리자 권한 1회 필요)
  (방화벽 인바운드 허용 규칙, 관리자 권한 1회 필요)
       ↓
pcnDev WSL 172.24.8.106:8899 — naver-map-proxy 서비스(화이트리스트 CONNECT 프록시)
  ~/service/naver-map-proxy/proxy.py (사용자 systemd 서비스 naver-map-proxy.service)
  ALLOWED_SUFFIXES = map.naver.com / map.naver.net / pstatic.net / ntruss.com
  그 외 도메인은 전부 403으로 거부(pcnIntra 인터넷 차단 정책을 일반적으로 우회하는 통로가
  되지 않도록 하는 안전장치 — 절대 완화하지 말 것)
       ↓
실제 인터넷 (pcnDev는 제약 없음)
```

같은 서버가 `GET /proxy.pac`(또는 `/naver-map-proxy.pac`) 요청에도 응답해서 PAC 스크립트 자체를
서빙한다 — CONNECT 프록시와 PAC 서버가 같은 포트를 공유하는 구조.

## 평소 쓰는(자동화 전용이 아닌) 크롬에도 적용하기 — 시스템 프록시 자동구성

위 `--proxy-pac-url` 크롬 실행 플래그는 **GATEONE 자동화 전용 프로필(`C:\gateone-profile`)에만** 적용된다.
사용자가 평소 쓰는 일반 크롬(시스템 프로필)에도 같은 PAC을 태우려면 **Windows "인터넷 옵션 > 연결 >
LAN 설정 > 자동 구성 스크립트 사용"**에 같은 PAC URL을 등록하면 된다 — 이게 `HKCU`(사용자별)
레지스트리라 **관리자 권한이 필요 없다**(2026-09-29 pcnDev-WSL-claude가 직접 설정 성공).

```powershell
# 등록 (관리자 권한 불필요)
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings' -Name AutoConfigURL -Value 'http://192.168.101.200:8899/proxy.pac'

# 바로 적용되게 시스템에 알림(안 해도 새 브라우저/탭에는 대부분 곧 반영되지만, 확실히 하려면)
Add-Type @"
using System;
using System.Runtime.InteropServices;
public class WinInet {
    [DllImport("wininet.dll", SetLastError = true)]
    public static extern bool InternetSetOption(IntPtr hInternet, int dwOption, IntPtr lpBuffer, int dwBufferLength);
}
"@
[WinInet]::InternetSetOption([IntPtr]::Zero, 39, [IntPtr]::Zero, 0) | Out-Null  # INTERNET_OPTION_SETTINGS_CHANGED
[WinInet]::InternetSetOption([IntPtr]::Zero, 37, [IntPtr]::Zero, 0) | Out-Null  # INTERNET_OPTION_REFRESH
```

**되돌리기(원복):**
```powershell
Remove-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings' -Name AutoConfigURL -ErrorAction SilentlyContinue
# 위와 같은 InternetSetOption 알림 두 줄을 다시 실행해서 즉시 반영
```

**검증(브라우저 안 띄우고 확인):**
```powershell
$proxy = [System.Net.WebRequest]::GetSystemWebProxy()
$proxy.GetProxy([Uri]"https://map.pstatic.net/")   # -> http://192.168.101.200:8899/ 가 나와야 정상
$proxy.GetProxy([Uri]"https://www.google.com/")    # -> 그대로(프록시 안 탐)여야 정상 — 다르면 화이트리스트가 새고 있는 것
```

**주의**: 이건 이 사용자 계정 전체(모든 WinINet/WinHTTP 기반 앱 — 크롬 기본 프로필, Edge, 대부분의
Windows 앱)에 적용된다. `--proxy-pac-url` 플래그를 쓰는 GATEONE 자동화 크롬은 이미 자기 프록시
설정을 쓰므로 이것과 무관하게 독립적으로 동작한다(서로 간섭 없음).

## 빠진 것 — 다시 만들 때 반드시 짚을 함정

**PAC을 `file:///C:/...pac` 로컬 파일로 주면 크롬이 제대로 안 읽는다** (DIRECT로 계속 폴백돼서
타임아웃만 남). 원인을 끝까지 못 밝혔지만, **PAC을 HTTP로 서빙하면 바로 해결된다** — 그래서 프록시
서버 자체가 `/proxy.pac`도 서빙하도록 만들었다. 다음에 또 이 증상(PAC 설정했는데 안 먹음)을 보면
file:// 대신 HTTP 서빙부터 의심할 것.

**`maps.apigw.ntruss.com`(reverse geocode) 요청이 간헐적으로 `ERR_CONNECTION_TIMED_OUT`나면 —
프록시 코드를 손대기 전에 먼저 pcnDev에서 직접(프록시 없이) `curl`로 같은 URL을 5~10번 반복해서
쳐보고 재현되는지부터 확인할 것.** 한 번 이 증상이 나서 "DNS 라운드로빈 IP 중 하나가 죽었다"고
오판하고 프록시에 멀티 IP 페일오버/병렬 연결 로직을 추가했었는데, **그게 오히려 새 버그였다**(직접
curl은 10/10 성공, "고친" 프록시는 3~5/10 실패). 원인 규명 없이 되돌렸더니(단순히
`asyncio.wait_for(asyncio.open_connection(host, port), timeout=10)` 한 줄로) 다시 10/10 성공했다.
**교훈: 이 프록시는 TCP CONNECT 터널만 뜨고 그 안의 TLS/HTTP는 전혀 건드리지 않으니, 특정 API가
간헐적으로 안 되면 거의 항상 원인은 프록시 코드가 아니라 (a) 그 시점의 CDP 브리지/크롬 상태 또는
(b) Naver 서버 쪽의 일시적 지연이다 — 성급하게 프록시 연결 로직을 복잡하게 만들지 말 것.** 실제
이 세션에서 최종 재현 실패의 진짜 원인은 CDP 브리지가 도중에 죽어있었던 것(크롬 CDP 프로세스가
알 수 없는 이유로 내려가 있었음 — `schtasks /run`으로 재기동 후 5/5 성공, `status=200`).

## 재현/점검 절차

1. pcnDev: `systemctl --user status naver-map-proxy.service` — 떠 있는지 확인.
2. pcnDev: `curl -s http://127.0.0.1:8899/proxy.pac` — PAC 텍스트가 나오는지.
3. pcnIntra(WSL) → pcnDev 경로 확인: `curl -x http://192.168.101.200:8899 -o /dev/null -w '%{http_code}\n' https://map.pstatic.net/` → `403`이 나오면 정상(네이버 서버가 실제로 응답했다는 뜻).
   같은 방식으로 `https://www.google.com/`은 프록시를 통해서도 `000`(거부)이어야 한다 — 이게 실패해서
   200이 나오면 화이트리스트가 뚫린 것이니 즉시 조치.
4. 호스트 크롬이 실제로 이 PAC을 쓰고 있는지: 예약 작업(`GateOneChromeCDP`)의 커맨드라인에
   `--proxy-pac-url=http://192.168.101.200:8899/proxy.pac`가 들어있는지 확인.
   (크롬 실행 플래그를 바꿨는데 기존 크롬이 떠 있으면 반영 안 됨 — `taskkill /F /IM chrome.exe /T`
   후 `schtasks /run /tn GateOneChromeCDP`로 재기동해야 한다. **주의**: 이 taskkill은 그 프로필의
   크롬 전체를 죽인다 — 사용자가 그 안에서 다른 작업 중이면 미리 확인할 것.)
5. CDP 브리지(`127.0.0.1:9223`)로 Playwright 연결해서 실제 페이지 goto로 200/403(정상 네이버 응답)이
   뜨는지 최종 확인. 관련 배경(mirrored 네트워킹, CDP 브리지 자체의 설계)은
   [[gateone-terminal-pipeline]] SKILL.md 참고 — 이 프록시와는 별개 주제지만 같은 호스트의 같은
   크롬/CDP 인프라를 공유한다.

## 도메인 허용 목록을 넓혀야 할 때

`~/service/naver-map-proxy/proxy.py`의 `ALLOWED_SUFFIXES`와 `PAC_SCRIPT`(pcnDev)를 같이 고쳐야
한다 — 하나만 고치면 프록시는 막는데 PAC은 그리로 보내거나(먹통), 반대로 PAC은 안 보내는데 프록시만
열어둔(무의미) 상태가 된다. 고친 뒤 `systemctl --user restart naver-map-proxy.service`.

## 관련 파일 (pcnDev)

- `~/service/naver-map-proxy/proxy.py` — 화이트리스트 CONNECT 프록시 + PAC 서버
- `~/.config/systemd/user/naver-map-proxy.service` — 사용자 systemd 서비스
- `~/ai/claude-agent/scripts/naver-map-forward-proxy.py` — 위 스크립트의 백업 사본
