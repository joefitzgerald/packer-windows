# https://msdn.microsoft.com/de-de/virtualization/windowscontainers/quick_start/quick_start_windows_10
Set-ExecutionPolicy Bypass -scope Process
New-Item -Type Directory -Path 'C:\Program Files\docker\'
Invoke-WebRequest https://aka.ms/tp5/b/dockerd -OutFile $env:ProgramFiles\docker\dockerd.exe
Invoke-WebRequest https://aka.ms/tp5/b/docker -OutFile $env:ProgramFiles\docker\docker.exe
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\Program Files\Docker", [EnvironmentVariableTarget]::Machine)
. 'C:\Program Files\docker\dockerd' --register-service -H npipe:// -H 0.0.0.0:2375 -G docker
Install-PackageProvider ContainerImage -Force
Install-ContainerImage -Name WindowsServerCore
Install-ContainerImage -Name NanoServer
Start-Service Docker

# TODO: this isn't working yet. Need to figure out these errors, but archiving for now

# ==> hyperv-iso: Provisioning with shell script: ./scripts/docker/add-docker-group.ps1
#     hyperv-iso: The command completed successfully.
#     hyperv-iso:
#     hyperv-iso: The command completed successfully.
#     hyperv-iso:
# ==> hyperv-iso: Provisioning with shell script: ./scripts/docker/install-docker.ps1
#     hyperv-iso:
#     hyperv-iso:
#     hyperv-iso: Directory: C:\Program Files
#     hyperv-iso:
#     hyperv-iso:
#     hyperv-iso: Mode                LastWriteTime         Length Name
#     hyperv-iso: ----                -------------         ------ ----
#     hyperv-iso: d-----        6/28/2016   2:20 PM                docker
#     hyperv-iso:
#     hyperv-iso: ProviderName      : PowerShellGet
#     hyperv-iso: Dependencies      : {}
#     hyperv-iso: Source            : PSGallery
#     hyperv-iso: Status            : Installed
#     hyperv-iso: SearchKey         : ContainerImage
#     hyperv-iso: FullPath          :
#     hyperv-iso: PackageFilename   : ContainerImage
#     hyperv-iso: FromTrustedSource : False
#     hyperv-iso: Summary           : This is a PackageManagement provider module which helps in discovering, downloading and installing

#     hyperv-iso: Windows Container OS images.
#     hyperv-iso:
#     hyperv-iso: For more details and examples refer to our project site at
#     hyperv-iso: https://github.com/PowerShell/ContainerProvider.
#     hyperv-iso: SwidTags          : {ContainerImage}
#     hyperv-iso: CanonicalId       : powershellget:ContainerImage/0.6.4.0#PSGallery
#     hyperv-iso: Metadata          : {summary,versionDownloadCount,ItemType,copyright,PackageManagementProvider,CompanyName,SourceName,
# d
#     hyperv-iso: escription,Type,created,published,developmentDependency,NormalizedVersion,downloadCount,GUID,tags,P
#     hyperv-iso: owerShellVersion,updated,installeddate,isLatestVersion,InstalledLocation,IsPrerelease,isAbsoluteLat
#     hyperv-iso: estVersion,packageSize,lastEdited,FileList,requireLicenseAcceptance}
#     hyperv-iso: SwidTagText       : <?xml version="1.0" encoding="utf-16" standalone="yes"?>
#     hyperv-iso: <SoftwareIdentity
#     hyperv-iso: name="ContainerImage"
#     hyperv-iso: version="0.6.4.0"
#     hyperv-iso: versionScheme="MultiPartNumeric" xmlns="http://standards.iso.org/iso/19770/-2/2015/schema.xsd">
#     hyperv-iso: <Meta
#     hyperv-iso: summary="This is a PackageManagement provider module which helps in discovering, downloading
#     hyperv-iso: and installing Windows Container OS images.&#xD;&#xA;&#xD;&#xA;For more details and examples refer
#     hyperv-iso: to our project site at https://github.com/PowerShell/ContainerProvider."
#     hyperv-iso: versionDownloadCount="12411"
#     hyperv-iso: ItemType="Module"
#     hyperv-iso: copyright="(c) 2016 Microsoft. All rights reserved."
#     hyperv-iso: PackageManagementProvider="NuGet"
#     hyperv-iso: CompanyName="Microsoft"
#     hyperv-iso: SourceName="PSGallery"
#     hyperv-iso: description="This is a PackageManagement provider module which helps in discovering,
#     hyperv-iso: downloading and installing Windows Container OS images.&#xD;&#xA;&#xD;&#xA;For more details and
#     hyperv-iso: examples refer to our project site at https://github.com/PowerShell/ContainerProvider."
#     hyperv-iso: Type="Module"
#     hyperv-iso: created="4/27/2016 5:10:00 AM -07:00"
#     hyperv-iso: published="4/27/2016 5:10:00 AM -07:00"
#     hyperv-iso: developmentDependency="False"
#     hyperv-iso: NormalizedVersion="0.6.4"
#     hyperv-iso: downloadCount="12411"
#     hyperv-iso: GUID="4c70a576-6620-425b-b5f7-ddaf0f30923c"
#     hyperv-iso: tags="PackageManagement Provider PSModule Nano AzureAutomationNotSupported
#     hyperv-iso: PSFunction_Find-ContainerImage PSCommand_Find-ContainerImage PSFunction_Save-ContainerImage
#     hyperv-iso: PSCommand_Save-ContainerImage PSFunction_Install-ContainerImage PSCommand_Install-ContainerImage
#     hyperv-iso: PSIncludes_Function"
#     hyperv-iso: PowerShellVersion="5.1"
#     hyperv-iso: updated="2016-06-28T21:07:07Z"
#     hyperv-iso: installeddate="6/28/2016 2:22:21 PM"
#     hyperv-iso: isLatestVersion="True"
#     hyperv-iso: InstalledLocation="C:\Program Files\WindowsPowerShell\Modules\ContainerImage\0.6.4.0"
#     hyperv-iso: IsPrerelease="false"
#     hyperv-iso: isAbsoluteLatestVersion="True"
#     hyperv-iso: packageSize="87331"
#     hyperv-iso: lastEdited="5/19/2016 10:34:31 PM -07:00"
#     hyperv-iso: FileList="ContainerImage.nuspec|BitsOnNano.exe|ContainerImage.ps1xml|ContainerImage.psd1|Contai
#     hyperv-iso: nerImage.psm1|Json.coreclr.dll|LICENSE|PSGetModuleInfo.xml|README.md|SaveHTTPItemUsingBITS.psm1|Tes
#     hyperv-iso: t\ContainerProvider.Tests.ps1"
#     hyperv-iso: requireLicenseAcceptance="False" />
#     hyperv-iso: <Entity
#     hyperv-iso: name="Microsoft Corporation"
#     hyperv-iso: regId="Microsoft Corporation"
#     hyperv-iso: role="author" />
#     hyperv-iso: <Entity
#     hyperv-iso: name="jayshah"
#     hyperv-iso: regId="jayshah"
#     hyperv-iso: role="owner" />
#     hyperv-iso: <Entity
#     hyperv-iso: name="quoct"
#     hyperv-iso: regId="quoct"
#     hyperv-iso: role="owner" />
#     hyperv-iso: <Link
#     hyperv-iso: href="https://github.com/PowerShell/ContainerProvider"
#     hyperv-iso: rel="project" />
#     hyperv-iso: </SoftwareIdentity>
#     hyperv-iso: IsCorpus          :
#     hyperv-iso: Name              : ContainerImage
#     hyperv-iso: Version           : 0.6.4.0
#     hyperv-iso: VersionScheme     : MultiPartNumeric
#     hyperv-iso: TagVersion        :
#     hyperv-iso: TagId             :
#     hyperv-iso: IsPatch           :
#     hyperv-iso: IsSupplemental    :
#     hyperv-iso: AppliesToMedia    :
#     hyperv-iso: Meta              : {{summary,versionDownloadCount,ItemType,copyright,PackageManagementProvider,CompanyName,SourceName
# ,
#     hyperv-iso: description,Type,created,published,developmentDependency,NormalizedVersion,downloadCount,GUID,tags,
#     hyperv-iso: PowerShellVersion,updated,installeddate,isLatestVersion,InstalledLocation,IsPrerelease,isAbsoluteLa
#     hyperv-iso: testVersion,packageSize,lastEdited,FileList,requireLicenseAcceptance}}
#     hyperv-iso: Links             : {project:https://github.com/PowerShell/ContainerProvider}
#     hyperv-iso: Entities          : {Microsoft Corporation, jayshah, quoct}
#     hyperv-iso: Payload           :
#     hyperv-iso: Evidence          :
#     hyperv-iso: Culture           :
#     hyperv-iso: Attributes        : {name,version,versionScheme}
#     hyperv-iso:
#     hyperv-iso: WARNING: Cannot bind argument to parameter 'fastPackageReference' because it is an empty string.
#     hyperv-iso: WARNING: The property 'version' cannot be found on this object. Verify that the property exists.
#     hyperv-iso: WARNING: The property 'Name' cannot be found on this object. Verify that the property exists.
#     hyperv-iso: PackageManagement\Save-Package : No match was found for the specified search criteria and package name
#     hyperv-iso: 'WindowsServerCore'. Try Get-PackageSource to see all available registered package sources.
#     hyperv-iso: WARNING: Cannot find path
#     hyperv-iso: At C:\Program Files\WindowsPowerShell\Modules\ContainerImage\0.6.4.0\ContainerImage.psm1:492 char:23
#     hyperv-iso: 'C:\Users\vagrant\AppData\Local\ContainerImage\ContainerImageGallery_ContainerImageSearchIndex.txt' because it does no
# t
#     hyperv-iso: exist.
#     hyperv-iso: WARNING: Cannot find drive. A drive with the name 'CleanUp' does not exist.
#     hyperv-iso: + ...   $downloadOutput = PackageManagement\Save-Package @PSBoundParameters
#     hyperv-iso: +                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#     hyperv-iso: WARNING: Save-HTTPItem: Bits Transfer failed. Job State:  ExitCode = -2147023651
#     hyperv-iso: + CategoryInfo          : ObjectNotFound: (Microsoft.Power...ets.SavePackage:SavePackage) [Save-Package], Exceptio
#     hyperv-iso: n
#     hyperv-iso: + FullyQualifiedErrorId : NoMatchFoundForCriteria,Microsoft.PowerShell.PackageManagement.Cmdlets.SavePackage
#     hyperv-iso:
#     hyperv-iso: The property 'Name' cannot be found on this object. Verify that the property exists.
#     hyperv-iso: At C:\Program Files\WindowsPowerShell\Modules\ContainerImage\0.6.4.0\ContainerImage.psm1:494 char:5
#     hyperv-iso: +     $Destination = GenerateFullPath -Location $Location `
#     hyperv-iso: +     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#     hyperv-iso: + CategoryInfo          : NotSpecified: (:) [], PropertyNotFoundException
#     hyperv-iso: + FullyQualifiedErrorId : PropertyNotFoundStrict
#     hyperv-iso:
#     hyperv-iso: WARNING: Based on customer feedback, we are updating the Containers PowerShell module to better align with Docker. As
#     hyperv-iso: Install-ContainerOSImage : Cannot bind argument to parameter 'WimPath' because it is an empty string.
#     hyperv-iso: part of that some cmdlet and parameter names may change in future releases. To learn more about these changes as well
#     hyperv-iso: as to join in the design process or provide usage feedback please refer to http://aka.ms/windowscontainers/powershell
#     hyperv-iso: At C:\Program Files\WindowsPowerShell\Modules\ContainerImage\0.6.4.0\ContainerImage.psm1:502 char:39
#     hyperv-iso: +     Install-ContainerOSImage -WimPath $Destination `
#     hyperv-iso: +                                       ~~~~~~~~~~~~
#     hyperv-iso: + CategoryInfo          : InvalidData: (:) [Install-ContainerOSImage], ParameterBindingValidationException
#     hyperv-iso: + FullyQualifiedErrorId : ParameterArgumentValidationErrorEmptyStringNotAllowed,Install-ContainerOSImage
#     hyperv-iso:
#     hyperv-iso: Remove-Item : Cannot bind argument to parameter 'Path' because it is null.
#     hyperv-iso: At C:\Program Files\WindowsPowerShell\Modules\ContainerImage\0.6.4.0\ContainerImage.psm1:512 char:8
#     hyperv-iso: +     rm $Destination
#     hyperv-iso: +        ~~~~~~~~~~~~
#     hyperv-iso: + CategoryInfo          : InvalidData: (:) [Remove-Item], ParameterBindingValidationException
#     hyperv-iso: + FullyQualifiedErrorId : ParameterArgumentValidationErrorNullNotAllowed,Microsoft.PowerShell.Commands.RemoveItemC
#     hyperv-iso: ommand
#     hyperv-iso:
#     hyperv-iso: PackageManagement\Save-Package : No match was found for the specified search criteria and package name 'NanoServer'.
#     hyperv-iso: WARNING: Cannot bind argument to parameter 'fastPackageReference' because it is an empty string.
#     hyperv-iso: WARNING: The property 'version' cannot be found on this object. Verify that the property exists.
#     hyperv-iso: WARNING: The property 'Name' cannot be found on this object. Verify that the property exists.
#     hyperv-iso: WARNING: Cannot find path
#     hyperv-iso: 'C:\Users\vagrant\AppData\Local\ContainerImage\ContainerImageGallery_ContainerImageSearchIndex.txt' because it does no
# t
#     hyperv-iso: Try Get-PackageSource to see all available registered package sources.
#     hyperv-iso: At C:\Program Files\WindowsPowerShell\Modules\ContainerImage\0.6.4.0\ContainerImage.psm1:492 char:23
#     hyperv-iso: + ...   $downloadOutput = PackageManagement\Save-Package @PSBoundParameters
#     hyperv-iso: +                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#     hyperv-iso: exist.
#     hyperv-iso: WARNING: Cannot find drive. A drive with the name 'CleanUp' does not exist.
#     hyperv-iso: + CategoryInfo          : ObjectNotFound: (Microsoft.Power...ets.SavePackage:SavePackage) [Save-Package], Exceptio
#     hyperv-iso: WARNING: Save-HTTPItem: Bits Transfer failed. Job State:  ExitCode = -2147023651
#     hyperv-iso: n
#     hyperv-iso: + FullyQualifiedErrorId : NoMatchFoundForCriteria,Microsoft.PowerShell.PackageManagement.Cmdlets.SavePackage
#     hyperv-iso:
#     hyperv-iso: The property 'Name' cannot be found on this object. Verify that the property exists.
#     hyperv-iso: At C:\Program Files\WindowsPowerShell\Modules\ContainerImage\0.6.4.0\ContainerImage.psm1:494 char:5
#     hyperv-iso: +     $Destination = GenerateFullPath -Location $Location `
#     hyperv-iso: +     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#     hyperv-iso: + CategoryInfo          : NotSpecified: (:) [], PropertyNotFoundException
#     hyperv-iso: + FullyQualifiedErrorId : PropertyNotFoundStrict
#     hyperv-iso:
#     hyperv-iso: Install-ContainerOSImage : Cannot bind argument to parameter 'WimPath' because it is an empty string.
#     hyperv-iso: At C:\Program Files\WindowsPowerShell\Modules\ContainerImage\0.6.4.0\ContainerImage.psm1:502 char:39
#     hyperv-iso: +     Install-ContainerOSImage -WimPath $Destination `
#     hyperv-iso: +                                       ~~~~~~~~~~~~
#     hyperv-iso: + CategoryInfo          : InvalidData: (:) [Install-ContainerOSImage], ParameterBindingValidationException
#     hyperv-iso: + FullyQualifiedErrorId : ParameterArgumentValidationErrorEmptyStringNotAllowed,Install-ContainerOSImage
#     hyperv-iso:
#     hyperv-iso: Remove-Item : Cannot bind argument to parameter 'Path' because it is null.
#     hyperv-iso: At C:\Program Files\WindowsPowerShell\Modules\ContainerImage\0.6.4.0\ContainerImage.psm1:512 char:8
#     hyperv-iso: +     rm $Destination
#     hyperv-iso: +        ~~~~~~~~~~~~
#     hyperv-iso: + CategoryInfo          : InvalidData: (:) [Remove-Item], ParameterBindingValidationException
#     hyperv-iso: + FullyQualifiedErrorId : ParameterArgumentValidationErrorNullNotAllowed,Microsoft.PowerShell.Commands.RemoveItemC
#     hyperv-iso: ommand
#     hyperv-iso:
#     hyperv-iso: WARNING: Waiting for service 'Docker Engine (Docker)' to start...
# ==> hyperv-iso: Provisioning with shell script: ./scripts/docker/enable-docker-insecure.ps1
#     hyperv-iso: WARNING: DO NOT USE DOCKER IN PRODUCTION WITHOUT TLS
#     hyperv-iso: Opening Docker insecure port 2375
#     hyperv-iso:
#     hyperv-iso:
#     hyperv-iso: Name                  : Dockerinsecure2375
#     hyperv-iso: DisplayName           : Docker insecure on TCP/2375
#     hyperv-iso: Description           :
#     hyperv-iso: DisplayGroup          :
#     hyperv-iso: Group                 :
#     hyperv-iso: Enabled               : True
#     hyperv-iso: Profile               : Any
#     hyperv-iso: Platform              : {}
#     hyperv-iso: Direction             : Inbound
#     hyperv-iso: Action                : Allow
#     hyperv-iso: EdgeTraversalPolicy   : Block
#     hyperv-iso: LooseSourceMapping    : False
#     hyperv-iso: LocalOnlyMapping      : False
#     hyperv-iso: Owner                 :
#     hyperv-iso: PrimaryStatus         : OK
#     hyperv-iso: Status                : The rule was parsed successfully from the store. (65536)
#     hyperv-iso: EnforcementStatus     : NotApplicable
#     hyperv-iso: PolicyStoreSource     : PersistentStore
#     hyperv-iso: PolicyStoreSourceType : Local
#     hyperv-iso: