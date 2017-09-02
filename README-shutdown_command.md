# Packer shutdown_command
There is an alternative for the normal Windows shutdown command.
Normally we use something like this to shutdown the VM in packer.

```json
   "shutdown_command": "shutdown /s /t 10 /f /d p:4:1 /c \"Packer Shutdown\"",
```

Replace it with

```json
   "shutdown_command": "c:/windows/system32/sysprep/sysprep.exe /generalize /oobe /quiet /shutdown /unattend:a:/unattend.xml",
```

and on the first `vagrant up` the box will boot with an out-of-box-experience (OOBE)
