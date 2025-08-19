@echo off&::###### DK.cmd #########################################################################################################################
if NOT exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# dk_TIMEOUT_EXE()
::#
::#
:dk_TIMEOUT_EXE
%setlocal%
	%dk_call% dk_debugFunc 0
  
    if exist "%TIMEOUT_EXE%" (%return%)
   
    %dk_call% dk_findProgram TIMEOUT_EXE "timeout.exe" "%windir%/System32"
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
