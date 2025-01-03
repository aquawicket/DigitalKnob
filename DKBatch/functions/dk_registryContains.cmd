@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::#################################################################################
::# dk_registryContains(reg_path, find)
::#
::#
:dk_registryContains
setlocal
	%dk_call% dk_debugFunc 2 EnableDelayedExpansion
 
	for /f "usebackq delims=" %%a in (`reg query %~1`) do (
		set "str=%%a"
		
		if not "x!str:%~2=!" == "x!str!" (
			exit /b 0
		)
	)
	
    exit /b 1
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
   
    %dk_call% dk_registryContains "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\FirewallRules" "C:\Users\Administrator\digitalknob\Development\DKApps\HelloWorld\win_x86_64_clang\Debug\HelloWorld.exe" && (%dk_call% dk_echo "registry contains substring") || (%dk_call% dk_echo "registry does NOT contain substring")
%endfunction%
