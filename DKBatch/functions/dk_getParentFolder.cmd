@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::####################################################################
::# dk_getParentFolder(<input> rtn_var)
::#
::#
:dk_getParentFolder
setlocal
	%dk_call% dk_debugFunc 2

    for %%a in ("%1") do for %%b in ("%%~dpa\.") do set "dk_getParentFolder=%%~nxb"
    endlocal & (
		set "dk_getParentFolder=%dk_getParentFolder%"
	)
    %dk_call% dk_printVar dk_getParentFolder
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_getParentFolder "C:/Windows/System32"
%endfunction%
