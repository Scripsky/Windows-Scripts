$Monitors   = Get-WmiObject WmiMonitorID -Namespace root\wmi
$LogFile    = "C:\ProgramData\Quest\KACE\scripts\CustomInventory\monitor_serial_numbers.txt"

 function Decode {
     If ($args[0] -is [System.Array]) {
         [System.Text.Encoding]::ASCII.GetString($args[0])
     }
     Else {
         "Not Found"
     }
 }

 ForEach ($Monitor in $Monitors) {  
     $Manufacturer = Decode $Monitor.ManufacturerName -notmatch 0
     $Name         = Decode $Monitor.UserFriendlyName -notmatch 0
     $Serial       = Decode $Monitor.SerialNumberID -notmatch 0
    
     "$Manufacturer, $Name, $Serial" | Out-File -FilePath $LogFile
 }