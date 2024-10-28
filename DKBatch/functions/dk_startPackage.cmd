@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_startPackage(name)
::#
::#
:dk_startPackage
    call dk_debugFunc 1
 ::setlocal disableDelayedExpansion
 
	::%dk_call% dk_callDKPowershell dk_startPackage %*
	%dk_call% dk_callDKPowershell dk_getPackagePath %* rtn_var

	:: Expand html escape codes
	setlocal disableDelayedExpansion
	%dk_call% dk_replaceAll "%rtn_var%" "#33" "!" rtn_var
	start %rtn_var%
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_startPackage "Debian"
%endfunction%
