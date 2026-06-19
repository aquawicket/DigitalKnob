<# ::###################### BATCH #######################
@echo off
powershell.exe -c "iex ((Get-Content '%~f0') -join [Environment]::Newline); iex"
exit /b %errorlevel%
::####################### END BATCH #####################>
#>

###################### POWRSHELL ########################
Write-Host "PowerShell hybrid";
Read-Host;
Exit;
#################### END POWRSHELL ######################