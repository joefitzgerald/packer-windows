{
  "builders": [
    {
      "type": "vmware-iso",
      "iso_url": "{{.IsoURL}}",
      "iso_checksum_type": "{{.IsoChecksumType}}",
      "iso_checksum": "{{.IsoChecksum}}",
      "headless": {{.Headless}},
      "boot_wait": "2m",
      "ssh_username": "{{.Username}}",
      "ssh_password": "{{.Password}}",
      "ssh_wait_timeout": "8h",
      "shutdown_command": "shutdown /s /t 10 /f /d p:4:1 /c \"Packer Shutdown\"",
      "guest_os_type": "{{.VmwareGuestOsType}}",
      "tools_upload_flavor": "windows",
      "disk_size": {{.DiskSize}},
      "vnc_port_min": 5900,
      "vnc_port_max": 5980,
      "floppy_files": [
        "./Autounattend.xml",
        "./scripts/hotfix-KB3102810.bat",
        "./scripts/fixnetwork.ps1",
        "./scripts/microsoft-updates.bat",
        "./scripts/win-updates.ps1",
        "./scripts/openssh.ps1"
      ],
      "vmx_data": {
        "RemoteDisplay.vnc.enabled": "false",
        "RemoteDisplay.vnc.port": "5900",
        "memsize": "{{.RAM}}",
        "numvcpus": "{{.CPU}}",
        "scsi0.virtualDev": "lsisas1068"
      }
    },
    {
      "type": "virtualbox-iso",
      "iso_url": "{{.IsoURL}}",
      "iso_checksum_type": "{{.IsoChecksumType}}",
      "iso_checksum": "{{.IsoChecksum}}",
      "headless": {{.Headless}},
      "boot_wait": "2m",
      "ssh_username": "{{.Username}}",
      "ssh_password": "{{.Password}}",
      "ssh_wait_timeout": "8h",
      "shutdown_command": "shutdown /s /t 10 /f /d p:4:1 /c \"Packer Shutdown\"",
      "guest_os_type": "{{.VirtualboxGuestOsType}}",
      "disk_size": {{.DiskSize}},
      "floppy_files": [
        "./Autounattend.xml",
        "./scripts/hotfix-KB3102810.bat",
        "./scripts/fixnetwork.ps1",
        "./scripts/microsoft-updates.bat",
        "./scripts/win-updates.ps1",
        "./scripts/openssh.ps1",
        "./scripts/oracle-cert.cer"
      ],
      "vboxmanage": [
        [
          "modifyvm",
          "{{"{{"}}.Name{{"}}"}}",
          "--memory",
          "{{.RAM}}"
        ],
        [
          "modifyvm",
          "{{"{{"}}.Name{{"}}"}}",
          "--cpus",
          "{{.CPU}}"
        ]
      ]
    }
  ],
  "provisioners": [
    {
      "type": "shell",
      "remote_path": "/tmp/script.bat",
      "execute_command": "{{"{{"}}.Vars{{"}}"}} cmd /c C:/Windows/Temp/script.bat",
      "scripts": [
        "./scripts/vm-guest-tools.bat",
        "./scripts/vagrant-ssh.bat",
        "./scripts/disable-auto-logon.bat",
        "./scripts/enable-rdp.bat",
        "./scripts/compile-dotnet-assemblies.bat",
        "./scripts/compact.bat"
      ]
    }
  ],
  "post-processors": [
    {
      "type": "vagrant",
      "keep_input_artifact": false,
      "output": "{{.OSName}}_{{"{{"}}.Provider{{"}}"}}.box",
      "vagrantfile_template": "Vagrantfile"
    }
  ]
}
