param (
  [switch]$AutoStart = $false
)

Write-Host "AutoStart: $AutoStart"
$is_64bit = [IntPtr]::size -eq 8

# setup openssh
$ssh_download_url = "http://www.mls-software.com/files/setupssh-6.6p1-1.exe"
if ($is_64bit) {
    Write-Host "64 bit OS found"
    $ssh_download_url = "http://www.mls-software.com/files/setupssh-6.6p1-1(x64).exe"
}

if (!(Test-Path "C:\Program Files\OpenSSH\bin\ssh.exe")) {
    Write-Host "Downloading $ssh_download_url"
    (New-Object System.Net.WebClient).DownloadFile($ssh_download_url, "C:\Windows\Temp\openssh.exe")
    Start-Process "C:\Windows\Temp\openssh.exe" "/S /port=22 /privsep=1 /password=D@rj33l1ng" -NoNewWindow -Wait
}

Stop-Service "OpenSSHd" -Force

# ensure vagrant can log in
Write-Host "Setting vagrant user file permissions"
New-Item -ItemType Directory -Force -Path "C:\Users\vagrant\.ssh"
C:\Windows\System32\icacls.exe "C:\Users\vagrant" /grant "vagrant:(OI)(CI)F"
C:\Windows\System32\icacls.exe "C:\Program Files\OpenSSH\bin" /grant "vagrant:(OI)RX"
C:\Windows\System32\icacls.exe "C:\Program Files\OpenSSH\usr\sbin" /grant "vagrant:(OI)RX"

Write-Host "Setting SSH home directories" 
    (Get-Content "C:\Program Files\OpenSSH\etc\passwd") |
    Foreach-Object { $_ -replace '/home/(\w+)', '/cygdrive/c/Users/$1' } |
    Set-Content 'C:\Program Files\OpenSSH\etc\passwd'

# Set shell to /bin/sh to return exit status
$passwd_file = Get-Content 'C:\Program Files\OpenSSH\etc\passwd'
$passwd_file = $passwd_file -replace '/bin/bash', '/bin/sh'
Set-Content 'C:\Program Files\OpenSSH\etc\passwd' $passwd_file

# fix opensshd to not be strict
Write-Host "Setting OpenSSH to be non-strict"
$sshd_config = Get-Content "C:\Program Files\OpenSSH\etc\sshd_config"
$sshd_config = $sshd_config -replace 'StrictModes yes', 'StrictModes no'
$sshd_config = $sshd_config -replace '#PubkeyAuthentication yes', 'PubkeyAuthentication yes'
$sshd_config = $sshd_config -replace '#PermitUserEnvironment no', 'PermitUserEnvironment yes'
# disable the use of DNS to speed up the time it takes to establish a connection
$sshd_config = $sshd_config -replace '#UseDNS yes', 'UseDNS no'
# disable the login banner
$sshd_config = $sshd_config -replace 'Banner /etc/banner.txt', '#Banner /etc/banner.txt'
Set-Content "C:\Program Files\OpenSSH\etc\sshd_config" $sshd_config

# use c:\Windows\Temp as /tmp location
Write-Host "Setting temp directory location"
Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "C:\Program Files\OpenSSH\tmp"
C:\Program` Files\OpenSSH\bin\junction.exe /accepteula "C:\Program Files\OpenSSH\tmp" "C:\Windows\Temp"
C:\Windows\System32\icacls.exe "C:\Windows\Temp" /grant "vagrant:(OI)(CI)F"

# add 64 bit environment variables missing from SSH
Write-Host "Setting SSH environment"
$sshenv = "TEMP=C:\Windows\Temp"
if ($is_64bit) {
    $env_vars = "ProgramFiles(x86)=C:\Program Files (x86)", `
        "ProgramW6432=C:\Program Files", `
        "CommonProgramFiles(x86)=C:\Program Files (x86)\Common Files", `
        "CommonProgramW6432=C:\Program Files\Common Files"
    $sshenv = $sshenv + "`r`n" + ($env_vars -join "`r`n")
}
Set-Content C:\Users\vagrant\.ssh\environment $sshenv

# record the path for provisioners (without the newline)
Write-Host "Recording PATH for provisioners"
Set-Content C:\Windows\Temp\PATH ([byte[]][char[]] $env:PATH) -Encoding Byte

# configure firewall
Write-Host "Configuring firewall"
netsh advfirewall firewall add rule name="SSHD" dir=in action=allow service=OpenSSHd enable=yes
netsh advfirewall firewall add rule name="SSHD" dir=in action=allow program="C:\Program Files\OpenSSH\usr\sbin\sshd.exe" enable=yes
netsh advfirewall firewall add rule name="ssh" dir=in action=allow protocol=TCP localport=22

if ($AutoStart -eq $true) {
    Start-Service "OpenSSHd"
}
