@powershell -ExecutionPolicy RemoteSigned -NoProfile -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))"
cinst -y vagrant virtualbox

REM vagrant upの時だけでいいかも
bcdedit /set hypervisorlaunchtype off
