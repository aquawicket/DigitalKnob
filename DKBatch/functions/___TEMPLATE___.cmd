@echo off
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::############################################################################
::# dk_function()
::#
::#
:dk_function
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_todo
%endfunction%


















::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_function
%endfunction%
