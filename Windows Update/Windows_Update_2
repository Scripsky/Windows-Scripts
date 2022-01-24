Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
Import-Module Nuget

Install-Module PSWindowsUpdate -AllowClobber -Force -SkipPublisherCheck
Import-Module PSWindowsUpdate
    
Install-WindowsUpdate -AcceptAll -ForceDownload -ForceInstall -AutoReboot
