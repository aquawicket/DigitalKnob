@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::####################################################################
::# dk_CMD_EXE()
::#
::#
:dk_CMD_EXE
setlocal
	%dk_call% dk_debugFunc 0

	if exist "%CMD_EXE%" (%return%)

	set "CMD_EXE=%COMSPEC:\=/%"
	if not exist "%CMD_EXE%" (%dk_call% dk_findProgram CMD_EXE "cmd.exe" "%WINDIR:\=/%/System32")
	%dk_call% dk_assertPath "%CMD_EXE%"

	endlocal & (
		set "CMD_EXE=%CMD_EXE:\=/%"
	)
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_CMD_EXE
	%dk_call% dk_echo "CMD_EXE = '%CMD_EXE%'"
%endfunction%
