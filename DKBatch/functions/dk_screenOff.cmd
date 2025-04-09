@echo off
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::################################################################################
::# dk_screenOff()
::#
::#
:dk_screenOff
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_callDKPowershell dk_screenOff
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_screenOff
%endfunction%
