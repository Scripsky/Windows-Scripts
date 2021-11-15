$totalSpace     = Get-CimInstance -Class CIM_LogicalDisk | Select-Object @{Name="Size(GB)";Expression={$_.size/1gb}}, @{Name="Free Space(GB)";Expression={$_.freespace/1gb}}, @{Name="Free (%)";Expression={"{0,6:P0}" -f(($_.freespace/1gb) / ($_.size/1gb))}}, DeviceID, DriveType | Where-Object -Property DeviceID -Match 'C:' | Select-Object -ExpandProperty 'Size(GB)'
$freeSpace      = Get-CimInstance -Class CIM_LogicalDisk | Select-Object @{Name="Size(GB)";Expression={$_.size/1gb}}, @{Name="Free Space(GB)";Expression={$_.freespace/1gb}}, @{Name="Free (%)";Expression={"{0,6:P0}" -f(($_.freespace/1gb) / ($_.size/1gb))}}, DeviceID, DriveType | Where-Object -Property DeviceID -Match 'C:' | Select-Object -ExpandProperty 'Free Space(GB)'
$windowsVersion = Get-ComputerInfo | Select-Object -ExpandProperty WindowsVersion

if ([int]$windowsVersion -le 1909){
    if ([int]$totalSpace -ge [int]$freeSpace + 20){
       
        $url      = 'https://go.microsoft.com/fwlink/?LinkID=799445'
        $path     = 'C:\Windows\Temp\Windows_Feature_Update'
        $testPath = Test-Path -Path $path

        if ($testPath -eq $false){
            New-Item -Path $path -ItemType Directory
        }

        wget -Uri $url -OutFile "$path\Windows10Upgrade9252.exe" -UseBasicParsing
        Start-Process -FilePath "$path\Windows10Upgrade9252.exe" -ArgumentList '/quietinstall /skipeula /auto upgrade /noreboot /copylogs $dir'
    }
    else{
        "Disk space is too low to Update to latest version of Windows 10" | Out-File -FilePath "$path\update.log"
    }
}