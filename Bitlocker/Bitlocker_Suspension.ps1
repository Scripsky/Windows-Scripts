$bitlocker = Get-BitLockerVolume -MountPoint C | Select-Object -ExpandProperty 'ProtectionStatus' -ErrorAction SilentlyContinue

if ($bitlocker -match 'on'){
    Suspend-BitLocker -MountPoint C
}