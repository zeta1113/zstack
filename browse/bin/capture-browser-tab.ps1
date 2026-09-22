param([string]$TargetTitle)

# 창 찾기
$chromeProcesses = Get-Process chrome | Where-Object { $_.MainWindowTitle -ne "" }
$targetProc = $chromeProcesses | Where-Object { $_.MainWindowTitle -like "*$TargetTitle*" }

if ($targetProc) {
    # 탭 활성화: AppActivate와 SendKeys 활용 (탭 전환 키 Ctrl+Tab 시뮬레이션 예시)
    $wshell = New-Object -ComObject WScript.Shell
    $wshell.AppActivate($targetProc.Id)
    Start-Sleep -Seconds 1
    # 여기서는 창 제목이 바뀌길 기대하며, 실제 탭 제어는 자동화가 어려움.
    # 하지만 윈도우 타이틀이 활성 탭으로 바뀐다면 캡처 스크립트가 그대로 동작.
}
