@echo off
if not defined DKINIT (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::####################################################################
::# dk_CMD_EXE()
::#
::#
:dk_CMD_EXE
::setlocal
	%dk_call% dk_debugFunc 0
   
    if exist "%CMD_EXE%" %return%

	if not exist "%CMD_EXE%"  set "CMD_EXE=%COMSPEC%"
	if not exist "%CMD_EXE%"  %dk_call% dk_findProgram CMD_EXE "cmd.exe" "%WINDIR%\System32"

%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_CMD_EXE
    %dk_call% dk_printVar CMD_EXE
%endfunction%
