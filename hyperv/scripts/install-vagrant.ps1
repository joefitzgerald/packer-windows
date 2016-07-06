choco install -y vagrant

# TODO patch Vagrant 1.8.4 as described in https://github.com/PatrickLang/packer-windows/issues/1#issuecomment-230151622

if (Test-Path c:\hashicorp\vagrant\embedded\gems\specifications\vagrant-1.8.4.gemspec) {
  Write-Host "Patching vagrant to use latest winrm-fs gem"
  (Get-Content c:\hashicorp\vagrant\embedded\gems\specifications\vagrant-1.8.4.gemspec) -replace '%q<winrm-fs>, \["~> 0.3.0"\]', '%q<winrm-fs>, ["> 0.3.0"]' | Set-Content c:\hashicorp\vagrant\embedded\gems\specifications\vagrant-1.8.4.gemspec
  $env:PATH += ";c:\hashicorp\vagrant\bin"
  vagrant plugin install winrm-fs
}

if (Test-Path C:\HashiCorp\Vagrant\embedded\gems\gems\vagrant-1.8.4\plugins\providers\hyperv\scripts\get_vm_status.ps1) {
  Write-Host "Patching vagrant hyperv get_vm_status.ps1 script"
  wget -uri https://raw.githubusercontent.com/codekaizen/vagrant/d3859a33aa37aa238fd4022a3ad4e7546f149570/plugins/providers/hyperv/scripts/get_vm_status.ps1 -outfile C:\HashiCorp\Vagrant\embedded\gems\gems\vagrant-1.8.4\plugins\providers\hyperv\scripts\get_vm_status.ps1
}
