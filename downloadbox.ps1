﻿# https://developer.microsoft.com/en-us/microsoft-edge/tools/vms/ のダウンロードリンクのURL
$imageUrl = "https://az792536.vo.msecnd.net/vms/VMBuild_20180425/Vagrant/MSEdge/MSEdge.Win10.Vagrant.zip"

$workDir = Join-Path $PSScriptRoot 'work\'
$zipPath = Join-Path $workDir 'box.zip'
$destDir = Join-Path $PSScriptRoot 'dest\'
$boxPath = Join-Path $destDir 'MSEdge - Win10.box'

if (Test-Path $boxPath) {
    Write-Output "すでに「$boxPath」が存在するので何も行いません。"
    break
}

if (-not (Test-Path $zipPath)) {
    if (-not (Test-Path $workDir)) {
        mkdir $workDir
    }
    # Invoke-WebRequestはスリープすると止まるがbitsadminは継続するので、大きなファイルはbitsadminが良さそう
    bitsadmin.exe /Transfer getWindows10Image /Download /Priority FOREGROUND $imageUrl $zipPath
}

if (-not (Test-Path $destDir)) {
    mkdir $destDir
}

Expand-Archive $zipPath $destDir
