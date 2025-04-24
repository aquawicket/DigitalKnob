# Get commandline of a running process
# https://www.robvanderwoude.com/powershellsnippets.php#GetProcessCommandline
$process = 'cmd.exe'
Get-CimInstance -ClassName Win32_Process -Filter "Name='$process'" | ForEach-Object { $_.CommandLine }