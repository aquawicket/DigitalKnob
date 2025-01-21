@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::#################################################################################
::# dk_registryContains(reg_path, find)
::#
::#
:dk_registryContains
setlocal enableDelayedExpansion
	%dk_call% dk_debugFunc 2 EnableDelayedExpansion
 
	for /f "usebackq delims=" %%a in (`reg query %~1`) do (
		set "str=%%a"
		
		if not "x!str:%~2=!x" == "x!str!x" (
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
	set "exe=C:\Windows\system32\curl.exe"
   
    %dk_call% dk_registryContains "%key%" "%exe%" && (
		%dk_call% dk_echo "FirewallRules contains %exe%"
	) || (
		%dk_call% dk_echo "FirewallRules does NOT contain %exe%"
	)
%endfunction%
