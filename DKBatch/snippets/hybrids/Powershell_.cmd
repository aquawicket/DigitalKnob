<# ::
@echo off
powershell -c "iex ((Get-Content '%~f0') -join [Environment]::Newline); iex 'main'"
set exit_code=%ERRORLEVEL%
echo exit_code = %exit_code%
pause
exit /b %exit_code%
#>
########################### Powershell #######################################
function main {

	Write-Host 'PowerShell:  main()'
	exit 13
}