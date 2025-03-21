@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::############################################################################
::# dk_settings()
::#
::#
:dk_settings
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_DKBRANCH_DIR"
	%dk_call% dk_getFileParam "%DKBRANCH_DIR%/settings" dk_call_PRINTENTRY
	%dk_call% dk_getFileParam "%DKBRANCH_DIR%/settings" dk_call_PRINTEXIT
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_settings
%endfunction%
