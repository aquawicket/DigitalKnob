@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_startPackage(name)
::#
::#
:dk_startPackage
    call dk_debugFunc 1
 setlocal
 
	%dk_call% dk_callDKPowershell dk_startPackage %*
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_startPackage "Debian"
%endfunction%
