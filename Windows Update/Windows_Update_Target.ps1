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

$path   = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate'
$key    = Get-Item -Path $path -ErrorAction SilentlyContinue
$value  = Get-ItemProperty -Path $path -Name TargetReleaseVersion -ErrorAction SilentlyContinue
$build  = Get-ComputerInfo | Select-Object -ExpandProperty OsBuildNumber
$number = [int]$build

if ($key -eq $null){
    New-Item -Path $Path -ItemType Directory
}
if ($value -eq $null){
    New-ItemProperty -Path $Path -Name TargetReleaseVersion -Value 1 -PropertyType DWORD
}
if ($number -le 19041){
    New-ItemProperty -Path $Path -Name TargetReleaseVersionInfo -Value '2004' -PropertyType String -Force
    exit 0
}
elseif ($number -le 19042){
    New-ItemProperty -Path $Path -Name TargetReleaseVersionInfo -Value '20H2' -PropertyType String -Force
    exit 0
}
elseif ($number -le 19043){
    New-ItemProperty -Path $Path -Name TargetReleaseVersionInfo -Value '21H1' -PropertyType String -Force
    exit 0
}