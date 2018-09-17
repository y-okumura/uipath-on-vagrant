# https://developer.microsoft.com/ja-jp/windows/downloads/virtual-machines のダウンロードリンクのURL
$imageUrl = "https://aka.ms/windev_VM_hyperv"

# 作業ルート。この配下にworkやdestフォルダを作って作業する
$root = $PSScriptRoot

#　生成するboxファイルのファイル名
$boxFile = "windows10.box"

$metadata = @{
    "name" = "okumura/windows10";
    "provider" = "hyperv";
}


$workDir = "$root\work"
$destDir = "$root\dest"
$imageZip = "$workDir\image.zip"

# imageが未ダウンロードならダウンロードする
if (-not (Test-Path $imageZip)) {
    mkdir $workDir
    # Invoke-WebRequestはスリープすると止まるがbitsadminは継続するので、大きなファイルはbitsadminが良さそう
    bitsadmin.exe /Transfer getWindows10Image /Download $imageUrl $imageZip
}

# fixme: mkdir -Forceで常に空で作ってほしいけど、すでに有るとなぜかそのままになってしまう
Remove-Item $destDir -Recurse -Force
mkdir $destDir -Force

# boxファイル（zipファイル）の作成
Add-Type -AssemblyName System.IO.Compression
$imageArchive = New-Object IO.Compression.ZipArchive(New-Object IO.FileStream($imageZip, [IO.FileMode]::Open))
try {
    $boxZip = "$destDir\box.zip"

    $boxArchive = New-Object IO.Compression.ZipArchive(
        (New-Object IO.FileStream($boxZip, [IO.FileMode]::Create)),
        [IO.Compression.ZipArchiveMode]::Create)
    try {
        # イメージファイルのトップディレクトリの中身を一階層上げてzip直下にコピー
        $imageArchive.Entries | Where-Object {
            -not $_.FullName.EndsWith('/')
        } | ForEach-Object {
            $newEntryPath = $_.FullName.Substring($_.FullName.indexOf('/') + 1)
            $in = $_.Open()
            $out = $boxArchive.CreateEntry($newEntryPath).Open()
            try {
                $in.CopyTo($out)
            } finally {
                $out.Close()
                $in.Close()
            }
        }

        # メタデータファイルをboxファイル直下に作成
        $writer = New-Object IO.StreamWriter($boxArchive.CreateEntry("metadata.json").Open())
        try {
            $metadata | ConvertTo-Json | ForEach-Object { $writer.WriteLine($_) }
        } finally {
            $writer.Close()
        }
    } finally {
        $boxArchive.dispose()
    }

    # 作成中は拡張子「.zip」でないとzip操作ができないので、最後に拡張子を「.box」に変更
    Rename-Item -Path $boxZip -NewName $boxFile
} finally {
    $imageArchive.Dispose()
}
