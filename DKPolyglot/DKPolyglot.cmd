echo \" <<'BATCH_SCRIPT' >/dev/null ">NUL "\" \`" <#"
@echo OFF


REM ===== Batch Script Begin =====
echo I'm PolyShell, a batch script!
pause
REM ====== Batch Script End ======
goto :eof
type CON >NUL
BATCH_SCRIPT
#> | Out-Null


echo \" <<'POWERSHELL_SCRIPT' >/dev/null # " | Out-Null
# ===== PowerShell Script Begin =====
echo "... but also a PowerShell script!"
Read-Host;
# ====== PowerShell Script End ======
while ( ! $MyInvocation.MyCommand.Source ) { $input_line = Read-Host }
exit
<#
POWERSHELL_SCRIPT


set +o histexpand 2>/dev/null
# ===== Bash Script Begin =====
echo "... and a Unix shell script!"
read -rp ''
# ====== Bash Script End ======
case $- in *"i"*) cat /dev/stdin >/dev/null ;; esac
exit
#>