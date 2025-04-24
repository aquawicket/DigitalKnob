@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::#################################################################################
::# dk_registryContains(reg_path, find)
::#
::#
:dk_registryContains
setlocal enableDelayedExpansion
	%dk_call% dk_debugFunc 2
 
	set "_reg_path_=%~1"
 
	%dk_call% dk_validate REG_EXE "%dk_call% dk_REG_EXE"
	
	for /f "usebackq delims=" %%a in (`%REG_EXE% query "%_reg_path_:/=\%"`) do (
		set "line=%%a"
		if not "x!line:%~2=!x" equ "x!line!x" (
			exit /b 0
		)
	)
	
    exit /b 1
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
   
	set "key=HKLM\SYSTEM\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\FirewallRules"
	set "exe=C:/ProgramFiles (x86)/Edrum Monitor/EdrumMon.exe"
   
    %dk_call% dk_registryContains "%key%" "%exe%" && (
		%dk_call% dk_echo "FirewallRules contains %exe%"
	) || (
		%dk_call% dk_echo "FirewallRules does NOT contain %exe%"
	)
%endfunction%
