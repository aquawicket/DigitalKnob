@echo off&::###### DK.cmd #########################################################################################################################
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::set "dk_callDKBash_ENV=GIT"
::set "dk_callDKBash_ENV=MSYS2"
::set "dk_callDKBash_ENV=WSL"
::####################################################################
::# dk_callDKBash(function, arguments..., rtn_var)
::#
::#   Reference: https://stackoverflow.com/questions/34451444/how-to-get-a-returned-value-from-powershell-and-get-it-in-a-batch-file
::#
:dk_callDKBash
%setlocal%
	%dk_call% dk_debugFunc 1 99

	%dk_call% dk_validate BASH_EXE "%dk_call% dk_depend bash %dk_callDKBash_ENV%"
	
	::### Get DKBASH_FUNCTIONS_DIR
	%dk_call% dk_validate DKBASH_FUNCTIONS_DIR "%dk_call% dk_DKBRANCH_DIR"

	::### Get DKHTTP_DKBASH_FUNCTIONS_DIR
	if NOT defined DKHTTP_DKBASH_DIR			(set "DKHTTP_DKBASH_DIR=%DKHTTP_DKBRANCH_DIR%/DKBash")
	if NOT defined DKHTTP_DKBASH_FUNCTIONS_DIR  (set "DKHTTP_DKBASH_FUNCTIONS_DIR=%DKHTTP_DKBASH_DIR%/functions")

	::### Download files if missing
	if NOT EXIST %DKBASH_FUNCTIONS_DIR%/DK.sh	(%dk_call% dk_download "%DKHTTP_DKBASH_FUNCTIONS_DIR%/DK.sh" "%DKBASH_FUNCTIONS_DIR%/DK.sh")
	if NOT EXIST %DKBASH_FUNCTIONS_DIR%/%~1.sh	(%dk_call% dk_download "%DKHTTP_DKBASH_FUNCTIONS_DIR%/%~1.sh" "%DKBASH_FUNCTIONS_DIR%/%~1.sh")

	::### All but first Args ###
	%dk_call% dk_allButFirstArgs %*

	set "DKSCRIPT_PATH=%DKSCRIPT_PATH:C:=/c%"
	if "%dk_callDKBash_ENV%" equ "WSL" (set "DKSCRIPT_PATH=%DKSCRIPT_PATH:/c/=/mnt/c/%")

	set "DKBASH_FUNCTIONS_DIR=%DKBASH_FUNCTIONS_DIR:C:=/c%"
	if "%dk_callDKBash_ENV%" equ "WSL" (set "DKBASH_FUNCTIONS_DIR=%DKBASH_FUNCTIONS_DIR:/c/=/mnt/c/%")	
	set "DKBASH_FUNCTIONS_DIR_=%DKBASH_FUNCTIONS_DIR%/"

	set "PAUSE_ON_EXIT=0"
	if "%dk_callDKBash_ENV%" equ "WSL" (set WSLENV=DKSCRIPT_PATH/u:DKBASH_FUNCTIONS_DIR_/u:PAUSE_ON_EXIT/u)

	set "bash_file=%DKBASH_FUNCTIONS_DIR:\=/%/%~1.sh"
	
	::###### run command ######
	set DKCOMMAND=%BASH_EXE% -c '%bash_file% %dk_allButFirstArgs%'
	
	::############ DKBash function call ############
	::set "dk_exec_ECHO_OUTPUT=1"
	::set "dk_exec_ECHO_ERROR=1"
	::set "dk_exec_PRINT_CALL=1" 		&:: dk_exec_call
	::set "dk_exec_PRINT_COMMAND=1" 	&:: dk_exec_command
	::set "dk_exec_PRINT_EXITCODES=1"	&:: dk_exec_exitcodes
	::set "dk_exec_PRINT_EXITCODE=1"	&:: dk_exec_exitcode
	::set "dk_exec_PRINT_STDERR=1"		&:: dk_exec_stderr[]
	::set "dk_exec_PRINT_STDOUT=1"		&:: dk_exec_stdout[]
	::set "dk_exec_PRINT_OUTPUT=1"		&:: dk_exec
		
	%dk_call% dk_exec %DKCOMMAND%
	endlocal & (
		set "dk_callDKBash=%dk_exec%"
		set "%~1=%dk_exec%"
	)
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_callDKBash dk_testReturn inputA
	%dk_call% dk_echo
	%dk_call% dk_echo "dk_callDKBash = %dk_callDKBash%"
	%dk_call% dk_echo "dk_testReturn = %dk_testReturn%"
%endfunction%
