@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
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

	set "_func_=%~1"
	set "_path_=%DKBASH_FUNCTIONS_DIR:\=/%/%_func_%.sh"
	
	%dk_call% dk_validate bash_exe "%dk_call% dk_depend bash %dk_callDKBash_ENV%"
	
	::### Get DKBASH_FUNCTIONS_DIR
	%dk_call% dk_validate DKBASH_FUNCTIONS_DIR "%dk_call% dk_DKBRANCH_DIR"

	::### Get DKHTTP_DKBASH_FUNCTIONS_DIR
	if NOT defined DKHTTP_DKBASH_DIR			(set "DKHTTP_DKBASH_DIR=%DKHTTP_DKBRANCH_DIR%/DKBash")
	if NOT defined DKHTTP_DKBASH_FUNCTIONS_DIR  (set "DKHTTP_DKBASH_FUNCTIONS_DIR=%DKHTTP_DKBASH_DIR%/functions")

	::### Download files if missing
	if NOT EXIST "%DKBASH_FUNCTIONS_DIR%/DK.sh"	(%dk_call% dk_download "%DKHTTP_DKBASH_FUNCTIONS_DIR%/DK.sh" "%DKBASH_FUNCTIONS_DIR%/DK.sh")
	if NOT EXIST "%_path_%"						(%dk_call% dk_download "%DKHTTP_DKBASH_FUNCTIONS_DIR%/%_func_%.sh" "%_path_%")

	%dk_call% dk_allButFirstArgs %*

	set "DKSCRIPT_PATH=%DKSCRIPT_PATH:C:=/c%"
	if /i "%dk_callDKBash_ENV%" equ "WSL" (set "DKSCRIPT_PATH=%DKSCRIPT_PATH:/c/=/mnt/c/%")
	if /i "%dk_callDKBash_ENV%" equ "WSL" (set "DKBASH_FUNCTIONS_DIR=%DKBASH_FUNCTIONS_DIR:/c/=/mnt/c/%")	

	set "PAUSE_ON_EXIT=0"
	if /i "%dk_callDKBash_ENV%" equ "WSL" (set WSLENV=DKSCRIPT_PATH/u:DKBASH_FUNCTIONS_DIR_/u:PAUSE_ON_EXIT/u)

	set DKCOMMAND=%bash_exe% -c '%_path_% %dk_allButFirstArgs%'
	
	set "dk_exec_ECHO_OUTPUT=0"
	set "dk_exec_ECHO_ERROR=0"
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
		set "%_func_%=%dk_exec%"
	)
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_echo
	%dk_call% dk_callDKBash dk_testReturn inputA
	%dk_call% dk_echo "dk_callDKBash = %dk_callDKBash%"
	%dk_call% dk_echo "dk_testReturn = %dk_testReturn%"
	%dk_call% dk_echo
	
	%dk_call% dk_echo
	%dk_call% dk_callDKBatch dk_basename "C:/Users/Administrator/DigitalKnob/Development"
	%dk_call% dk_echo "dk_callDKBatch = %dk_callDKBatch%"
	%dk_call% dk_echo "dk_basename = %dk_basename%"
	%dk_call% dk_echo
%endfunction%
