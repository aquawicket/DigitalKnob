@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_startPackage(name)
::#
::#
:dk_startPackage
::setlocal
    %dk_call% dk_debugFunc 1
 
	::%dk_call% dk_callDKPowershell dk_startPackage %*
	%dk_call% dk_callDKPowershell dk_getPackagePath %* rtn_var

	:: Expand html escape codes
	setlocal disableDelayedExpansion
	set "rtn_var=%rtn_var:#33=!%
	start %rtn_var%
	
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_startPackage "Debian"
%endfunction%
