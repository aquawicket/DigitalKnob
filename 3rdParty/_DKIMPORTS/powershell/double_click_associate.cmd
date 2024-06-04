@echo off
call ../../../DKBatch/functions/DK.cmd


::	Computer\HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts
::	Seems to be a better place to change file associations. They take precidence over ftype and assoc commands
	
call dk_validate DKIMPORTS_DIR dk_validateBranch
call dk_validate POWERSHELL_EXE "call %DKIMPORTS_DIR%\powershell\dk_install"
call dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.ps1"
call dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.psm1"
ftype dk_powershell=%POWERSHELL_EXE% "%%1"
assoc .ps1=dk_powershell
assoc .psm1=dk_powershell

call dk_pause
echo done
