$ErrorActionPreference = 'Stop'

$files = @(Get-ChildItem *.json)

foreach ($file in $files) {
  Write-Host "`n`nValidate $file"
  packer validate $file
}
