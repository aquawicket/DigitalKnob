@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# dk_REG_EXE()
::#
::#
:dk_REG_EXE
%setlocal%
	%dk_call% dk_debugFunc 0
  
    if exist "%REG_EXE%" (%return%)

	set "REG_EXE=%windir:\=/%/System32/reg.exe"
	if not exist "%REG_EXE%" (%dk_call% dk_findProgram REG_EXE "reg.exe" "%windir:\=/%/System32")
	%dk_call% dk_assertPath "%REG_EXE%"
	
	endlocal & (
		set "REG_EXE=%REG_EXE%"
	)
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

    %dk_call% dk_REG_EXE
	%dk_call% dk_echo "REG_EXE = %REG_EXE%"
%endfunction%
