@echo off

if "%*" neq "" (goto:runDKHta)
:installDKHta
	echo Associating .hta files with DKHta . . .
	
	::###### DKINIT ######
	set "DKBRANCH_DIR=..\"
	set "DKBATCH_FUNCTIONS_DIR=..\DKBatch\functions"
	set "DKBATCH_FUNCTIONS_DIR_=%DKBATCH_FUNCTIONS_DIR%\"
	call "%DKBATCH_FUNCTIONS_DIR%\DK.cmd"
	
	call dk_load dk_validate
    call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
    ::call dk_validate MSHTA_EXE "call dk_installMshta"
	set "MSHTA_EXE=C:\Windows\SysWOW64\mshta.exe"
	set "DKHTA_FUNCTIONS_DIR=..\DKHta\functions"

	::###### Git Bash ######::
	call dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.hta
	::ftype dkhta=C:\Windows\SysWOW64\mshta.exe "%1" {1E460BD7-F1C3-4B2E-88BF-4E770A288AF5}%U{1E460BD7-F1C3-4B2E-88BF-4E770A288AF5} %*
	ftype dkhta=cmd /c call "%~f0" "%DKHTA_FUNCTIONS_DIR%" "%MSHTA_EXE%" "%%1" %*
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