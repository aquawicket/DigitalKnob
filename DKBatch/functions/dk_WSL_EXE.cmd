@echo off&::###### DK.cmd #########################################################################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# dk_WSL_EXE()
::#
::#
:dk_WSL_EXE
%setlocal%
	%dk_call% dk_debugFunc 0

	if exist "%WSL_EXE%" (%return%)

	set "WSL_EXE=%windir:\=/%/System32/wsl.exe"
	if not exist "%WSL_EXE%" (%dk_call% dk_findProgram WSL_EXE "wsl.exe" "%windir%/System32")
	
	%dk_call% dk_assertPath "%WSL_EXE%"
	endlocal & (
		set "WSL_EXE=%WSL_EXE%"
	)
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_WSL_EXE
	%dk_call% dk_echo "WSL_EXE = %WSL_EXE%"
%endfunction%
