$application = Get-WmiObject -Class win32_product -ErrorAction SilentlyContinue | Where-Object -Property Name -EQ "Application Name" | Select-Object -ExpandProperty IdentifyingNumber

start-process msiexec -ArgumentList /x, "$application", /qn, /norestart -wait
