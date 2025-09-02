@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# dk_callDKHtml(function, arguments..., rtn_var)
::#
::#
::#
:dk_callDKHtml
%setlocal%
	%dk_call% dk_debugFunc 1 99

	set "_func_=%~1"
	set "_path_=%DKHTML_FUNCTIONS_DIR:\=/%/%_func_%.sh"
	
	::### Get DKHTTP_DKBASH_FUNCTIONS_DIR
	if NOT defined DKHTTP_DKBASH_DIR			(set "DKHTTP_DKBASH_DIR=%DKHTTP_DKBRANCH_DIR%/DKBash")
	if NOT defined DKHTTP_DKBASH_FUNCTIONS_DIR  (set "DKHTTP_DKBASH_FUNCTIONS_DIR=%DKHTTP_DKBASH_DIR%/functions")

	::### Download files if missing
	if NOT EXIST "%DKHTML_FUNCTIONS_DIR%/DK.sh"	(%dk_call% dk_download "%DKHTTP_DKBASH_FUNCTIONS_DIR%/DK.sh" "%DKHTML_FUNCTIONS_DIR%/DK.sh")
	if NOT EXIST "%_path_%"						(%dk_call% dk_download "%DKHTTP_DKBASH_FUNCTIONS_DIR%/%_func_%.sh" "%_path_%")

	%dk_call% dk_allButFirstArgs %*

	set "DKSCRIPT_PATH=%DKSCRIPT_PATH:C:=/c%"
	set "PAUSE_ON_EXIT=0"

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
		set "dk_callDKHtml=%dk_exec%"
		set "%_func_%=%dk_exec%"
	)
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	::### TODO ####
%endfunction%
