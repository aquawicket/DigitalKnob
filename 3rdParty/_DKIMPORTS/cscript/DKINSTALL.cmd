@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# DKINSTALL()
::#
:DKINSTALL
%setlocal%
	%dk_call% dk_debugFunc 0

	if EXIST "%cscript_exe%" (%return%)

	if NOT EXIST "%cscript_exe%" (set "cscript_exe=%windir:\=/%/System32/cscript.exe")
	if NOT EXIST "%cscript_exe%" (%dk_call% dk_findProgram cscript_exe "cscript.exe" "%windir:\=/%/System32")
	
	%dk_call% dk_assertPath "%cscript_exe:\=/%"

	endlocal & (
		set "cscript_exe=%cscript_exe:\=/%"
	)
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% DKINSTALL
	%dk_call% dk_debug "cscript_exe = %cscript_exe%"
%endfunction%