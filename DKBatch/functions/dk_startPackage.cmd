@echo off&::###### DK.cmd #########################################################################################################################
if NOT exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# dk_startPackage(name)
::#
::#
:dk_startPackage
::%setlocal%
    %dk_call% dk_debugFunc 1

	::%dk_call% dk_callDKPowershell dk_startPackage %*
	%dk_call% dk_callDKPowershell dk_getPackagePath %*

	:: Expand html escape codes
	setlocal disableDelayedExpansion
	set "dk_callDKPowershell=%dk_callDKPowershell:#33=!%
	start %dk_callDKPowershell%
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

    %dk_call% dk_startPackage "Debian"
%endfunction%
