$value = 0

do{
    $application = Get-WmiObject -Class win32_product -ErrorAction SilentlyContinue | Where-Object -Property Name -EQ "Symantec Endpoint Protection" | Select-Object -ExpandProperty IdentifyingNumber

    if ($application -ne $null -and $value -eq 0){
        msiexec /x "$application" /q
    }

    if ($value -ge 15){
        Write-Host "Maximimum Attempted Retries Reached"
        exit 1
    }

    $value++
    start-sleep 10
}while($application -ne $null)