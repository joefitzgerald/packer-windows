# install chocolatey
iex (wget 'https://chocolatey.org/install.ps1' -UseBasicParsing)
choco feature disable --name showDownloadProgress

choco install -y packer
choco install -y vagrant
choco install -y docker
choco install -y docker-machine
