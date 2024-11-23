@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::###############################################################################
::# dk_DKPLUGINS_DIR()
::#
::#
:dk_DKPLUGINS_DIR
	call dk_debugFunc 0
	
	%dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_DKBRANCH_DIR"
	%dk_call% dk_set DKPLUGINS_DIR "%DKBRANCH_DIR%\DKPlugins"
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	%dk_call% dk_DKPLUGINS_DIR
	%dk_call% dk_printVar DKPLUGINS_DIR
%endfunction%
