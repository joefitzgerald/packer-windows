Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All -NoRestart

$username = $env:USERNAME
net localgroup "Hyper-V Administrators" $username /add
