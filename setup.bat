@powershell -ExecutionPolicy RemoteSigned -NoProfile -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))"
cinst -y vagrant

DISM /Online /Enable-Feature /All /FeatureName:Microsoft-Hyper-V
