#############################################################################
#If Powershell is running the 32-bit version on a 64-bit machine, we 
#need to force powershell to run in 64-bit mode .
#############################################################################
if ($env:PROCESSOR_ARCHITEW6432 -eq "AMD64") {
    write-warning "Y'arg Matey, we're off to 64-bit land....."
    if ($myInvocation.Line) {
        &"$env:WINDIR\sysnative\windowspowershell\v1.0\powershell.exe" -NonInteractive -NoProfile $myInvocation.Line
    }else{
        &"$env:WINDIR\sysnative\windowspowershell\v1.0\powershell.exe" -NonInteractive -NoProfile -file "$($myInvocation.InvocationName)" $args
    }
exit $lastexitcode
}

write-host "Main script body"

#############################################################################
#End
#############################################################################

$regPath = Test-Path -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP"

if ($regpath -eq $false){
    New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion" -Name 'PersonalizationCSP'
}

$regPath               = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP"
$imagePath             = "C:\WINDOWS\Personalization\LockScreenImage"
$testImagePath         = Test-Path 'C:\WINDOWS\Personalization\LockScreenImage'
$Property              = Get-ItemProperty -Path $regPath -ErrorAction SilentlyContinue
$lockScreenImagePath   = $Property.LockScreenImagePath | Out-String
$lockScreenImageStatus = $Property.LockScreenImageStatus | Out-String
$lockScreenImageUrl    = $Property.LockScreenImageUrl | Out-String
$url                   = 'URLTOIMAGE'

if ($lockScreenImagePath -notmatch ".jpeg"){
    if ($testImagePath -eq $false){
        New-Item -Path $imagePath -ItemType Directory -Force
    } 
    wget -Uri $url -OutFile "$imagePath\LockScreenImage.jpeg" -UseBasicParsing
    New-ItemProperty -Path $regPath -Name 'LockScreenImagePath' -Value "$imagePath\LockScreenImage.jpeg" -PropertyType String -Force
}

if ($lockScreenImageStatus -notmatch 1){
    New-ItemProperty -Path $regPath -Name 'LockScreenImageStatus' -Value 1 -PropertyType DWORD -Force
}

if ($lockScreenImageUrl -notmatch $url){
    New-ItemProperty -Path $regPath -Name 'LockScreenImageUrl' -Value $url -PropertyType String -Force
}
