@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_DKTOOLS_DIR()
::#
::#
:dk_DKTOOLS_DIR
    call dk_debugFunc 0
:: setlocal
   
    if defined DKTOOLS_DIR %return%
    
	%dk_call% dk_validate DIGITALKNOB_DIR "%dk_call% dk_DIGITALKNOB_DIR"
    set "DKTOOLS_DIR=%DIGITALKNOB_DIR%\DKTools"
    if not exist "%DKTOOLS_DIR%" %dk_call% dk_makeDirectory "%DKTOOLS_DIR%"
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_DKTOOLS_DIR
    %dk_call% dk_printVar DKTOOLS_DIR
%endfunction%