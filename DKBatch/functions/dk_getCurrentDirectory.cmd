@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_getCurrentDirectory(rtn_var)
::#
::#    REFERENCE: https://ss64.com/nt/syntax-gettime.html
::#
:dk_getCurrentDirectory
setlocal
	%dk_call% dk_debugFunc 1
	set "currentDirectory=%CD%"
    endlocal & set "%1=%currentDirectory%"
	
::debug
::	%dk_call% dk_printVar %1
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_getCurrentDirectory myPath
    %dk_call% dk_echo "myPath = %myPath%"
%endfunction%   