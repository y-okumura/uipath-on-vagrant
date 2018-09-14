DISM /Online /Enable-Feature /All /FeatureName:Microsoft-Hyper-V
@powershell -NoProfile -ExecutionPolicy Bypass -Command "iex (new-object net.webclient).downloadstring('https://get.scoop.sh')"

scoop install vagrant
