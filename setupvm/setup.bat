set installerName=UiPathStudioSetup.exe
set uipathUrl=http://download.uipath.com/%installerName%
set downloadFile=%~DP0\%installerName%

if not exist %downloadFile% (
    REM Invoke-WebRequest�̓X���[�v����Ǝ~�܂邪bitsadmin�͌p������̂ŁA�傫�ȃt�@�C����bitsadmin���ǂ�����
    bitsadmin.exe /Transfer getWindows10Image /Download /Priority FOREGROUND %uipathUrl% %downloadFile%
)

%downloadFile%
