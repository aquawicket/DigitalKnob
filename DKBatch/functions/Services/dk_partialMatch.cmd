@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=%CD:\=/%/../")
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)


::############################################################################
::# dk_partialMatch()
::#
::#
:dk_partialMatch
%setlocal%
	%dk_call% dk_debugFunc 1

	set "string=%1"

	echo #### Windows Services containing %string% ####
	sc queryex type= service state= all | find /i %string%

	:: output of command to a variable
	::for /f "delims=" %%i in ('command') do set output=%%i

	:: last 5 chaacters of the string
	::set "substring=%i~-5%"
	::echo "%substring%"
%endfunction%


















::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_partialMatch "Windows Push Notifications User Service"
%endfunction%