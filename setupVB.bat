@powershell -NoProfile -ExecutionPolicy RemoteSigned "$s=[scriptblock]::create((gc \"%~f0\"|?{$_.readcount -gt 1})-join\"`n\");&$s" %*&goto:eof

iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))
cinst -y vagrant virtualbox

if ((Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V).State -eq 'Enabled') {
    Disable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V
}
