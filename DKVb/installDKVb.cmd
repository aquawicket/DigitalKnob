@echo off

if "%*" neq "" (goto:runDKVb)
:installDKVb
	echo Installing DKVb . . .
	
	::###### DKINIT ######
	set "DKBRANCH_DIR=..\"
	set "DKBATCH_FUNCTIONS_DIR=..\DKBatch\functions"
	set "DKBATCH_FUNCTIONS_DIR_=%DKBATCH_FUNCTIONS_DIR%\"
	call "%DKBATCH_FUNCTIONS_DIR%\DK.cmd"
	
	call dk_load dk_validate
    call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
    ::call dk_validate WSCRIPT_EXE "call dk_installWScript"
	::call dk_validate CSCRIPT_EXE "call dk_installCScript"
	::set "WSCRIPT_EXE=%SystemRoot%\System32\WScript.exe"
	set "CSCRIPT_EXE=%SystemRoot%\System32\CScript.exe"
	set "DKVB_FUNCTIONS_DIR=..\DKVb\functions"

	::###### Git Bash ######::
	call dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.vbs
	::ftype dkvb=cmd /c call "%~f0" "%DKVB_FUNCTIONS_DIR%" "%WSCRIPT_EXE%" "%%1" %*
	ftype dkvb=cmd /c call "%~f0" "%DKVB_FUNCTIONS_DIR%" "%CSCRIPT_EXE%" "%%1" %*
	assoc .vbs=dkvb
	::call dk_registrySetKey "HKEY_CLASSES_ROOT\dkvb\DefaultIcon" "" "REG_SZ" "%MSVB_EXE%"
goto:eof


:runDKVb
	set "DKVB_FUNCTIONS_DIR=%~1"
	::set "WSCRIPT_EXE=%~2"
	set "CSCRIPT_EXE=%~2"
	set "VB_FILE=%~3"

	echo ############### Digitalknob ##################
	::start %WSCRIPT_EXE% %VB_FILE%
	start %CSCRIPT_EXE% %VB_FILE%
goto:eof