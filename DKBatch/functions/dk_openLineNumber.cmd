@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::############################################################################
::# dk_openLineNumber(file, lineno)
::#
::#
:dk_openLineNumber
%setlocal%
	%dk_call% dk_debugFunc 1 2

	set "filepath=%~1"
	if "%~2" neq "" (set "lineno=-n%~2")

	%dk_call% dk_validate NOTEPADPP_EXE "%dk_call% dk_NOTEPADPP_EXE"
	start "" "%NOTEPADPP_EXE%" "%filepath%" %lineno%
%endfunction%











::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	::%dk_call% dk_openLineNumber "%USERPROFILE:\=/%/digitalknob/Development/README.md"
	%dk_call% dk_openLineNumber "%USERPROFILE:\=/%/digitalknob/Development/README.md" 23
%endfunction%

