{
  "push": {
    "vcs": true
  },
  "builders": [
    {
      "type": "vmware-iso",
      {{template "builder" .}}
      "guest_os_type": "{{.VmwareGuestOsType}}",
      "tools_upload_flavor": "windows",
      "vnc_port_min": 5900,
      "vnc_port_max": 5980,
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
      {{template "builder" .}}
      "guest_os_type": "{{.VirtualboxGuestOsType}}",
      "guest_additions_mode": "attach",
      "vboxmanage": [
        [ "modifyvm", "{{"{{"}}.Name{{"}}"}}", "--memory", "{{.RAM}}" ],
        [ "modifyvm", "{{"{{"}}.Name{{"}}"}}", "--cpus", "{{.CPU}}" ]
        {{if eq .OSName "nano"}}
        ,[ "modifyvm", "{{.Name}}", "--hardwareuuid", "fc81141d-9beb-4ca3-87df-0770d1b8b64b" ]
        {{end}}
      ]
    }
  ],
  "provisioners": [
    {{template "provisioners" .}}
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
