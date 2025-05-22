@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::#################################################################################
::# dk_registryListKeys(reg_path)
::#
::#
:dk_registryListKeys
%setlocal%
	%dk_call% dk_debugFunc 1

	set "_reg_path_=%~1"

	for /f "usebackq delims=" %%a in (`reg query %_reg_path_:/=\%`) do (
		echo %%a
	)
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
  
    %dk_call% dk_registryListKeys "HKLM/SYSTEM/ControlSet001/Services/SharedAccess/Parameters/FirewallPolicy/FirewallRules"
%endfunction%
