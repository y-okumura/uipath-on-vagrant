# https://developer.microsoft.com/en-us/microsoft-edge/tools/vms/ のダウンロードリンクのURL
$imageUrl = "https://az792536.vo.msecnd.net/vms/VMBuild_20180425/Vagrant/MSEdge/MSEdge.Win10.Vagrant.zip"

$zipPath = "$PSScriptRoot\work\box.zip"
$destPath = "$PSScriptRoot\dest\"

if (-not (Test-Path $zipPath)) {
    # Invoke-WebRequestはスリープすると止まるがbitsadminは継続するので、大きなファイルはbitsadminが良さそう
    bitsadmin.exe /Transfer getWindows10Image /Download /Priority FOREGROUND $imageUrl $zipPath
}

Expand-Archive $zipPath $destPath