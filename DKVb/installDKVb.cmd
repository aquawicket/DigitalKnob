@echo off

if "%~1" neq "" (goto:runDKVb)
:installDKVb
	echo Installing DKVb . . .
	
	::###### DKINIT ######
	call "..\DKBatch\functions\DK.cmd"
	
    call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
    ::call dk_validate WSCRIPT_EXE "call dk_installWScript"
	set "WSCRIPT_EXE=%SystemRoot%\System32\WScript.exe"
	set "DKVB_FUNCTIONS_DIR=..\DKVb\functions"

	::###### Git Bash ######::
	call dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.vbs
	ftype DKVb=cmd /c call "%~f0" "%DKVB_FUNCTIONS_DIR%" "%WSCRIPT_EXE%" "%%1" %*
	assoc .vbs=DKVb
	::call dk_registrySetKey "HKEY_CLASSES_ROOT\DKVb\DefaultIcon" "" "REG_SZ" "%MSVB_EXE%"
goto:eof


:runDKVb
	set "DKVB_FUNCTIONS_DIR=%~1"
	set "WSCRIPT_EXE=%~2"
	set "DKVB_FILE=%~3"


	echo ############### Digitalknob ##################
	start %WSCRIPT_EXE% %DKVB_FILE%
goto:eof