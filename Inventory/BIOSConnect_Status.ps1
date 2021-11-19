$BIOSConnectStatus = Test-Path -Path C:\ProgramData\Quest\KACE\scripts\CustomInventory\BIOSConnect\DellRecommendsSettings_x64.txt
$BIOSConnectContents = Get-Content -Path C:\ProgramData\Quest\KACE\scripts\CustomInventory\BIOSConnect\BIOSConnect_Status.txt | Out-String -ErrorAction SilentlyContinue

if ($BIOSConnectStatus -eq $false){
    start "C:\ProgramData\Quest\KACE\scripts\CustomInventory\BIOSConnect\DellRecommendsSettings_x64.exe"

    while ($BIOSConnectStatus -eq $false){
        $BIOSConnectStatus = Test-Path -Path C:\ProgramData\Quest\KACE\scripts\CustomInventory\BIOSConnect\DellRecommendsSettings_x64.txt   
    }

    while ($BIOSConnect -notmatch "SUCCESS"){
        $BIOSConnect = Get-Content -Path C:\ProgramData\Quest\KACE\scripts\CustomInventory\BIOSConnect\DellRecommendsSettings_x64.txt | Select-String "cctk" | Out-String
        if ($BIOSConnect -match "FAILURE"){
            echo "BIOSConnect = Failure" | Out-File C:\ProgramData\Quest\KACE\scripts\CustomInventory\BIOSConnect\BIOSConnect_Status.txt -NoNewline
            exit
        }
    }

    $BIOSConnect.Trim() | Out-File C:\ProgramData\Quest\KACE\scripts\CustomInventory\BIOSConnect\BIOSConnect_Status.txt -NoNewline
    exit
}
elseif ($BIOSConnectContents -notmatch "SUCCESS"){
    start "C:\ProgramData\Quest\KACE\scripts\CustomInventory\BIOSConnect\DellRecommendsSettings_x64.exe"

    while ($BIOSConnectStatus -eq $false){
        $BIOSConnectStatus = Test-Path -Path C:\ProgramData\Quest\KACE\scripts\CustomInventory\BIOSConnect\DellRecommendsSettings_x64.txt   
    }

    while ($BIOSConnect -notmatch "SUCCESS"){
        $BIOSConnect = Get-Content -Path C:\ProgramData\Quest\KACE\scripts\CustomInventory\BIOSConnect\DellRecommendsSettings_x64.txt | Select-String "cctk" | Out-String
        if ($BIOSConnect -match "FAILURE"){
            echo "BIOSConnect = Failure" | Out-File C:\ProgramData\Quest\KACE\scripts\CustomInventory\BIOSConnect\BIOSConnect_Status.txt -NoNewline
            exit
        }
    }

    $BIOSConnect.Trim() | Out-File C:\ProgramData\Quest\KACE\scripts\CustomInventory\BIOSConnect\BIOSConnect_Status.txt -NoNewline
    exit
}
else{
    exit
}
