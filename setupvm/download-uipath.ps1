$uipathUrl = "http://download.uipath.com/UiPathStudioSetup.exe"

# Invoke-WebRequestはスリープすると止まるがbitsadminは継続するので、大きなファイルはbitsadminが良さそう
bitsadmin.exe /Transfer getWindows10Image /Download /Priority FOREGROUND $uipathUrl $PSScriptRoot

$PSScriptRoot\UiPathStudioSetup.exe
