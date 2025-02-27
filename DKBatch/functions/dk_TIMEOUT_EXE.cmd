@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::####################################################################
::# dk_TIMEOUT_EXE()
::#
::#
:dk_TIMEOUT_EXE
setlocal
	%dk_call% dk_debugFunc 0
   
    if defined TIMEOUT_EXE (%return%)
    
	set "TIMEOUT_EXE=%WINDIR:\=/%/System32/timeout.exe"
    if not exist "%TIMEOUT_EXE%" (%dk_call% dk_findProgram TIMEOUT_EXE "timeout.exe" "%WINDIR%\system32")
	
	endlocal & (
		set "TIMEOUT_EXE=%TIMEOUT_EXE%"
	)
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_validate TIMEOUT_EXE "%dk_call% dk_TIMEOUT_EXE"
    %dk_call% dk_printVar TIMEOUT_EXE
%endfunction%
