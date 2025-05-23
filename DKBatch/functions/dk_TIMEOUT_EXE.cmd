@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# dk_TIMEOUT_EXE()
::#
::#
:dk_TIMEOUT_EXE
%setlocal%
	%dk_call% dk_debugFunc 0
  
    if defined TIMEOUT_EXE (%return%)
   
    if not exist "%TIMEOUT_EXE%" (%dk_call% dk_findProgram TIMEOUT_EXE "timeout.exe" "%windir:\=/%/System32")
	%dk_call% dk_assertPath "%TIMEOUT_EXE%"
	
	endlocal & (
		set "TIMEOUT_EXE=%TIMEOUT_EXE%"
	)
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_TIMEOUT_EXE
    %dk_call% dk_echo "TIMEOUT_EXE = %TIMEOUT_EXE%"
%endfunction%
