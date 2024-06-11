@echo off

:DKTEST
:install_cmd_fileAssociation
	if not "%*" == "" (goto:run_file)
	echo Associating .cmd files with DKBatch . . .
	
	set "DIGITALKNOB_DIR=%HOMEDRIVE%%HOMEPATH%\digitalknob"
	set "DKBRANCH_DIR=%DIGITALKNOB_DIR%\Development"
	call "%DKBRANCH_DIR%\DKBatch\functions\DK.cmd"
	call dk_load dk_validate
	call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
	
	ftype dk_batch=cmd /c call "%~f0" "%DKBATCH_FUNCTIONS_DIR%" "%%1" %*
	assoc .cmd=dk_batch
goto:eof

:run_file
	set "DKBATCH_FUNCTIONS_DIR=%~1"
	set "CMD_FILE=%~2"
	
	echo ############### Digitalknob ##################
::	echo * = %*
::	echo 1 = %1
::	echo 2 = %2
::	echo DKBATCH_FUNCTIONS_DIR = %DKBATCH_FUNCTIONS_DIR%
::	echo CMD_FILE = %CMD_FILE%
	cmd /c call %CMD_FILE%

::	pause
goto:eof
