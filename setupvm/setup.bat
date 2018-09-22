set installerName=UiPathStudioSetup.exe
set uipathUrl=http://download.uipath.com/%installerName%
set downloadFile=%~DP0\%installerName%

if not exist %downloadFile% (
    REM Invoke-WebRequestはスリープすると止まるがbitsadminは継続するので、大きなファイルはbitsadminが良さそう
    bitsadmin.exe /Transfer getWindows10Image /Download /Priority FOREGROUND %uipathUrl% %downloadFile%
)

%downloadFile%
