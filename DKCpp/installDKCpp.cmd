@echo off

if "%*" neq "" (goto:runDKCpp)
:installDKCpp
	echo Installing DKCpp . . .
	
	::###### DKINIT ######
	set "DKBRANCH_DIR=..\"
	set "DKBATCH_FUNCTIONS_DIR=..\DKBatch\functions"
	set "DKBATCH_FUNCTIONS_DIR_=%DKBATCH_FUNCTIONS_DIR%\"
	call "%DKBATCH_FUNCTIONS_DIR%\DK.cmd"
	
	call dk_load dk_validate
    call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
    ::call dk_validate CL_EXE "call dk_installCl"
	set "CL_EXE=%SystemRoot%\System32\cl.exe"
	set "DKCPP_FUNCTIONS_DIR=..\DKCpp\functions"

	::###### Git Bash ######::
	call dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.vbs
	ftype DKCpp=cmd /c call "%~f0" "%DKCPP_FUNCTIONS_DIR%" "%CL_EXE%" "%%1" %*
	assoc .cpp=DKCpp
	::call dk_registrySetKey "HKEY_CLASSES_ROOT\DKCpp\DefaultIcon" "" "REG_SZ" "%MSVB_EXE%"
	pause
goto:eof


:runDKCpp
	set "DKVB_FUNCTIONS_DIR=%~1"
	set "CL_EXE=%~2"
	set "DKCPP_FILE=%~3"


	echo ############### Digitalknob ##################
	start %CL_EXE% %DKCPP_FILE%
goto:eof