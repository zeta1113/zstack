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

## 빠진 것 — 다시 만들 때 반드시 짚을 함정

**PAC을 `file:///C:/...pac` 로컬 파일로 주면 크롬이 제대로 안 읽는다** (DIRECT로 계속 폴백돼서
타임아웃만 남). 원인을 끝까지 못 밝혔지만, **PAC을 HTTP로 서빙하면 바로 해결된다** — 그래서 프록시
서버 자체가 `/proxy.pac`도 서빙하도록 만들었다. 다음에 또 이 증상(PAC 설정했는데 안 먹음)을 보면
file:// 대신 HTTP 서빙부터 의심할 것.

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
