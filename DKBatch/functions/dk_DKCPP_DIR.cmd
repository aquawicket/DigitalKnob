@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_DKCPP_DIR()
::#
::#
:dk_DKCPP_DIR
    call dk_debugFunc 0
 ::setlocal
   
    if defined DKCPP_DIR %return%
    
	%dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_DKBRANCH_DIR"
    set "DKCPP_DIR=%DKBRANCH_DIR%\DKCpp"
	set "DKCPP_FUNCTIONS_DIR=%DKCPP_DIR%\functions"
	set "DKCPP_FUNCTIONS_DIR_=%DKCPP_DIR%\functions\"
    ::if not exist "%DKCPP_DIR%" %dk_call% dk_makeDirectory "%DKCPP_DIR%"
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_DKCPP_DIR
    %dk_call% dk_printVar DKCPP_DIR
%endfunction%
