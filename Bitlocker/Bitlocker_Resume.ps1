$bitlocker = Get-BitLockerVolume -MountPoint C | Select-Object -Property ProtectionStatus, VolumeStatus -ErrorAction SilentlyContinue

if ($bitlocker.ProtectionStatus -match 'off' -and $bitlocker.VolumeStatus -match 'FullyEncrypted'){
    Resume-BitLocker -MountPoint C
}