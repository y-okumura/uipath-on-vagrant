# https://developer.microsoft.com/ja-jp/windows/downloads/virtual-machines のダウンロードリンクのURL
$imageUrl = "https://aka.ms/windev_VM_hyperv"

#　生成するboxファイルのファイル名
$boxFile = "windows10.box"

$metadata = @{
    "name" = "okumura/windows10";
    "provider" = "hyperv";
}


$zipPath = "$PSScriptRoot\box.zip"

# Invoke-WebRequestはスリープすると止まるがbitsadminは継続するので、大きなファイルはbitsadminが良さそう
bitsadmin.exe /Transfer getWindows10Image /Download $imageUrl $zipPath

# TODO: zipPathのWinDev1808Eval\Virtual MachinesとWinDev1808Eval\Virtual Hard Disksをトップに移して
# metadata.jsonを加えて$boxFileに改名

Rename-Item -Path $zipPath -NewName $boxFile
