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

Also make sure to add the `./scripts/unattend.xml` file to the `floppy_files`.

On the first `vagrant up` the box will boot with an out-of-box-experience (OOBE)

## Windows Server 2016

On newer systems like Windows 10 and Windows Server 2016 this shutdown_command is not enough.
We also have to stop the "tiledatamodelsvc" service to make sysprep work. So we use a small cmd script.

```json
   "shutdown_command": "a:/sysprep.bat"
```

Also make sure to add the files `./scripts/unattend.xml` and `./scripts/sysprep.bat` to the `floppy_files`.

On the first `vagrant up` the box will boot with an out-of-box-experience (OOBE)
