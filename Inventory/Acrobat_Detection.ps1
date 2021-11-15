$statusPath = "C:\ProgramData\Quest\KACE\scripts\Adobe Acrobat DC Detection\status.txt"
$acrobatPath = "C:\ProgramData\Quest\KACE\scripts\Adobe Acrobat DC Detection\Acrobat.txt"
$statusTestPath = Test-Path -Path "C:\ProgramData\Quest\KACE\scripts\Adobe Acrobat DC Detection\status.txt"
$acrobatTestPath = Test-Path -Path "C:\ProgramData\Quest\KACE\scripts\Adobe Acrobat DC Detection\Acrobat.txt"
$process = Get-Process -Name Acrobat -ErrorAction SilentlyContinue | Select-Object -ExpandProperty ProcessName

if ($statusTestPath -eq $false){
    New-Item -Path $statusPath -ItemType File -Value "undetected"
}

if ($acrobatTestPath -eq $false){
    new-item -Path $acrobatPath -ItemType File -Value "$(Get-Date) - undetected"
}

$status = Get-Content -Path $statusPath
$acrobat = Get-Content -Path $acrobatPath

if ($process -match "Acrobat" -and $status -match "undetected"){
    "$(Get-Date) - Adobe Acrobat Pro DC was launched" | Out-File -FilePath $acrobatPath -Encoding utf8
    "1" | Out-File -FilePath $statusPath
}

elseif ($process -match "Acrobat" -and $status -match "0"){
    "$(Get-Date) - Adobe Acrobat Pro DC was launched" | Out-File -FilePath $acrobatPath -Encoding utf8 -Append
    "1" | Out-File -FilePath $statusPath
}   
 
elseif ($process -eq $null -and $status -match "undetected"){
    "$(Get-Date) - Adobe Acrobat Pro DC is not running" | Out-File -FilePath $acrobatPath -Encoding utf8
    "0" | Out-File -FilePath $statusPath
}

elseif ($process -eq $null -and $status -match "1"){
    "$(Get-Date) - Adobe Acrobat Pro DC is not running" | Out-File -FilePath $acrobatPath -Encoding utf8 -Append
    "0" | Out-File -FilePath $statusPath
}