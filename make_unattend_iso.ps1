# This builds the unattend ISOs needed for Generation 2 VMs with Hyper-V


$isoList = {
    @{
        FileName="windows_server_insider.iso";
        Files={
            "./answer_files/server_insider_uefi/autounattend.xml",
            "./scripts/disable-screensaver.ps1",
            "./scripts/disable-winrm.ps1",
            "./scripts/enable-winrm.ps1"
        }
    }
}



        #"{{user `autounattend`}}",
        "./scripts/disable-screensaver.ps1",
        "./scripts/disable-winrm.ps1",
        "./scripts/enable-winrm.ps1"