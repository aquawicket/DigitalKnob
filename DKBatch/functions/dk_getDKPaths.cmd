@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_getDKPaths()
::#
::#
:dk_getDKPaths
    call dk_debugFunc 0
:: setlocal

	%dk_call% dk_DIGITALKNOB_DIR
    %dk_call% dk_DKTOOLS_DIR
    %dk_call% dk_DKDOWNLOAD_DIR
    %dk_call% dk_DKTEMP_DIR
	%dk_call% dk_DKDESKTOP_DIR
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_getDKPaths
%endfunction%
