@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_getParentFolder(<input> rtn_var)
::#
::#
:dk_getParentFolder
    call dk_debugFunc 2
 setlocal
 
    for %%a in ("%1") do for %%b in ("%%~dpa\.") do set "parent=%%~nxb"
    set "%2=%parent%"
    %dk_call% dk_printVar "%2"
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_getParentFolder
%endfunction%
