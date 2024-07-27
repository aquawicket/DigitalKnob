@echo off

if "%*" neq "" (goto:runDKHta)
:installDKHta
	echo Associating .hta files with DKHta . . .
	
	::###### DKINIT ######
	set "DKHTA_FUNCTIONS_DIR_=%HOMEDRIVE%%HOMEPATH%\digitalknob\Development\DKHta\functions\"
	call "%DKHTA_FUNCTIONS_DIR_%DK.hta"
	
	call dk_load dk_validate
    call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
    ::call dk_validate MSHTA_EXE "call dk_installMshta"

	::###### Git Bash ######::
	call dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.hta
	ftype dkhta=C:\Windows\SysWOW64\mshta.exe "%1" {1E460BD7-F1C3-4B2E-88BF-4E770A288AF5}%U{1E460BD7-F1C3-4B2E-88BF-4E770A288AF5} %*
	assoc .hta=dkhta
	::call dk_registrySetKey "HKEY_CLASSES_ROOT\dkhta\DefaultIcon" "" "REG_SZ" "%MSHTA_EXE%"
goto:eof


:runDKHta
	set "DKHTA_FUNCTIONS_DIR=%~1"
	set "MSHTA_EXE=%~2"
	set "HTA_FILE=%~3"

	echo ############### Digitalknob ##################
	start %MSHTA_EXE% %HTA_FILE%
goto:eof