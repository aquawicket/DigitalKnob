@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# dk_CSCRIPT_EXE()
::#
::#
:dk_CSCRIPT_EXE
%setlocal%
	%dk_call% dk_debugFunc 0

	if EXIST "%CSCRIPT_EXE%" (%return%)

	if NOT EXIST "%CSCRIPT_EXE%" (%dk_call% dk_findProgram CSCRIPT_EXE "cscript.exe" "%windir%/System32")
	%dk_call% dk_assertPath "%CSCRIPT_EXE%"

	endlocal & (
		set "CSCRIPT_EXE=%CSCRIPT_EXE%"
	)
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_CSCRIPT_EXE
	%dk_call% dk_echo "CSCRIPT_EXE = %CSCRIPT_EXE%"
%endfunction%
