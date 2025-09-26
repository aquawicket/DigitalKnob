@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# dk_WSL_EXE()
::#
::#
:dk_WSL_EXE
%setlocal%
	%dk_call% dk_debugFunc 0

	if EXIST "%wsl_exe%" (%return%)

	set "wsl_exe=%windir:\=/%/System32/wsl.exe"
	if NOT EXIST "%wsl_exe%" (%dk_call% dk_findProgram wsl_exe "wsl.exe" "%windir%/System32")
	
	%dk_call% dk_assertPath "%wsl_exe%"
	endlocal & (
		set "wsl_exe=%wsl_exe%"
	)
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_depend wsl
	%dk_call% dk_echo "wsl_exe = %wsl_exe%"
%endfunction%
