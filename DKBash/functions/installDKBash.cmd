@echo off

:installDKBash
	if not "%*" == "" (goto:runDKBash)
	echo Associating .sh files with DKBash . . .
	
	::###### DKINIT ######
	set "DIGITALKNOB_DIR=%HOMEDRIVE%%HOMEPATH%\digitalknob"
	set "DKBRANCH_DIR=%DIGITALKNOB_DIR%\Development"
	set "DKBATCH_FUNCTION_DIR=%DKBRANCH_DIR%\DKBatch\functions"
	set "DKBATCH_FUNCTION_DIR_=%DKBATCH_FUNCTION_DIR%\"
	call "%DKBATCH_FUNCTION_DIR_%DK.cmd"
	
	call dk_load dk_validate
	call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
	call dk_validate GITBASH_EXE "call %DKIMPORTS_DIR%\git\dk_installGit"
	call dk_validate CLANG64_EXE "call %DKIMPORTS_DIR%\msys2\dk_installMsys2"
	
	::###### Git Bash ######::
	ftype dk_bash=cmd /c call "%~f0" "%DKBASH_FUNCTIONS_DIR%" "%GITBASH_EXE%" "%%1" %*
	assoc .sh=dk_bash
	call dk_registrySetKey "HKEY_CLASSES_ROOT\dk_bash\DefaultIcon" "" "REG_SZ" "%GITBASH_EXE%"
	
	::###### Msys2 Bash ######
::	ftype dk_bash=cmd /c call "%~f0" "%DKBASH_FUNCTIONS_DIR%" "%CLANG64_EXE%" "%%1" %*
::	assoc .sh=dk_bash
::	call dk_registrySetKey "HKEY_CLASSES_ROOT\dk_bash\DefaultIcon" "" "REG_SZ" "%CLANG64_EXE%"
	
goto:eof


:runDKBash
	set "DKBASH_FUNCTIONS_DIR=%~1"
	set "GITBASH_EXE=%~2"
::	set "CLANG64_EXE=%~2"
	set "SH_FILE=%~3"

	echo ############### Digitalknob ##################
	start %GITBASH_EXE% %SH_FILE%
::	start %CLANG64_EXE% %SH_FILE%
goto:eof