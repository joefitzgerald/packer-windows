
@rem vagrant public key
mkdir "C:\Users\vagrant\.ssh"
if exist a:\vagrant.pub (
  copy a:\vagrant.pub C:\Users\vagrant\.ssh\authorized_keys
) else (
  powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub', 'C:\Users\vagrant\.ssh\authorized_keys')"
)
