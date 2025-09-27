@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::############################################################################
::# dk_openLineNumber(filepath, lineno)
::#
::#
:dk_openLineNumber
%setlocal%
	%dk_call% dk_debugFunc 2

	set "filepath=%~1"
	set "lineno=%~2"

	%dk_call% dk_validate notepadpp_exe "%dk_call% dk_depend notepadpp_exe"
	start "" "%notepadpp_exe%" "%filepath%" -n%lineno%
%endfunction%











::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	::%dk_call% dk_openLineNumber "%USERPROFILE:\=/%/DigitalKnob/Development/README.md"
	%dk_call% dk_openLineNumber "%USERPROFILE:\=/%/DigitalKnob/Development/README.md" 23
%endfunction%

