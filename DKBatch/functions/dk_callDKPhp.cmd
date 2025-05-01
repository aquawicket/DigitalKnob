@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::####################################################################
::# dk_callDKPhp(function, arguments...)
::#
::#
:dk_callDKPhp
%setlocal%
	%dk_call% dk_debugFunc 1 99

	::### Get DKC_FUNCTIONS_DIR
	%dk_call% dk_validate DKPHP_FUNCTIONS_DIR		"%dk_call% dk_DKBRANCH_DIR"
	if not exist "%DKPHP_FUNCTIONS_DIR%"			(mkdir "%DKPHP_FUNCTIONS_DIR:/=\%")
	%dk_call% dk_assertPath DKPHP_FUNCTIONS_DIR

	::### Get DKHTTP_DKPHP_DIR
	if not defined DKHTTP_DKPHP_DIR					(set "DKHTTP_DKPHP_DIR=%DKHTTP_DKBRANCH_DIR%/DKPhp")
	if not defined DKHTTP_DKPHP_FUNCTIONS_DIR		(set "DKHTTP_DKPHP_FUNCTIONS_DIR=%DKHTTP_DKPHP_DIR%/functions")

	::### Download files if missing
	if not exist "%DKPHP_FUNCTIONS_DIR%/DK.php"		(%dk_call% dk_download "%DKHTTP_DKPHP_FUNCTIONS_DIR%/DK.php" "%DKPHP_FUNCTIONS_DIR%/DK.php")
	if not exist "%DKPHP_FUNCTIONS_DIR%/%~1.php"	(%dk_call% dk_download "%DKHTTP_DKPHP_FUNCTIONS_DIR%/%~1.php" "%DKPHP_FUNCTIONS_DIR%/%~1.php")

	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	%dk_call% dk_validate PHP_EXE "call %DKIMPORTS_DIR%/php-src/DKINSTALL.cmd"

	::### All but first Args ###
	%dk_call% dk_allButFirstArgs %*
	
	::############ DKPhp function call ############
	set DKCOMMAND="%ComSpec%" /V:ON /c call "%PHP_EXE%" "%DKPHP_FUNCTIONS_DIR%/%~1.php" &::%dk_allButFirstArgs%
	%dk_call% dk_exec "%DKCOMMAND%"
	endlocal & (
		set "dk_callDKPhp=%dk_exec%"
	)
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_callDKPhp dk_test "arg 1" "arg 2" "arg 3"
	%dk_call% dk_echo
	%dk_call% dk_echo "dk_callDKPhp = %dk_callDKPhp%"
%endfunction%
