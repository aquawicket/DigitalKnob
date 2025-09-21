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

	if EXIST "%wscript_exe%" (%return%)

	if NOT EXIST "%wscript_exe%" (set "wscript_exe=C:/Windows/System32/cscript.exe")
	if NOT EXIST "%wscript_exe%" (%dk_call% dk_findProgram wscript_exe "cscript.exe" "%windir:\=/%/System32")
	
	%dk_call% dk_assertPath "%wscript_exe:\=/%"

	endlocal & (
		set "wscript_exe=%wscript_exe:\=/%"
	)
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% DKINSTALL
	%dk_call% dk_debug "wscript_exe = %wscript_exe%"
%endfunction%