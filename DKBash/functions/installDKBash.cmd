@echo off

:install_cmake_fileAssociation
	if not "%*" == "" (goto:run_cmake_file)
	echo Associating .sh files with DKBash . . .
	
	set "DIGITALKNOB_DIR=%HOMEDRIVE%%HOMEPATH%\digitalknob"
	set "DKBRANCH_DIR=%DIGITALKNOB_DIR%\Development"
	call "%DKBRANCH_DIR%\DKBatch\functions\DK.cmd"
	call dk_load dk_validate
	call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
	call dk_validate GITBASH_EXE "call %DKIMPORTS_DIR%\git\dk_installGit"
	
	ftype dk_bash=cmd /c call "%~f0" "%DKBASH_FUNCTIONS_DIR%" "%GITBASH_EXE%" "%%1" %*
	assoc .sh=dk_bash
	call dk_registrySetKey "HKEY_CLASSES_ROOT\dk_bash\DefaultIcon" "" "REG_SZ" "%GITBASH_EXE%"
goto:eof


:run_cmake_file
	set "DKBASH_FUNCTIONS_DIR=%~1"
	set "GITBASH_EXE=%~2"
	set "SH_FILE=%~3"

	echo ############### Digitalknob ##################
	start %GITBASH_EXE% %SH_FILE%
goto:eof