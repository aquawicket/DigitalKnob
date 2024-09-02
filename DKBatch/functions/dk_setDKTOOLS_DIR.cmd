@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0

::####################################################################
::# dk_setDKTOOLS_DIR()
::#
::#
:dk_setDKTOOLS_DIR
:: setlocal
    call dk_debugFunc 0
    
    if defined DKTOOLS_DIR %dk_call% dk_warning "DKTOOLS_DIR already set to %DKTOOLS_DIR%" && goto:eof
    
    if not defined DIGITALKNOB_DIR %dk_call% dk_setDIGITALKNOB_DIR
    set "DKTOOLS_DIR=%DIGITALKNOB_DIR%\DKTools"
    if not exist "%DKTOOLS_DIR%" %dk_call% dk_makeDirectory "%DKTOOLS_DIR%"
goto:eof







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
    call dk_debugFunc 0
    
    %dk_call% dk_setDKTOOLS_DIR
    %dk_call% dk_printVar DKTOOLS_DIR
    
    %dk_call% dk_setDKTOOLS_DIR
    %dk_call% dk_printVar DKTOOLS_DIR
goto:eof
