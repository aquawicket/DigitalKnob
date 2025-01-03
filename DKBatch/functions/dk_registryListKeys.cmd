@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::#################################################################################
::# dk_registryListKeys(reg_path)
::#
::#
:dk_registryListKeys
setlocal
	%dk_call% dk_debugFunc 1 EnableDelayedExpansion
 
	for /f "usebackq delims=" %%a in (`reg query %~1`) do (
		echo %%a
	)
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
   
    %dk_call% dk_registryListKeys "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\FirewallRules"
%endfunction%
