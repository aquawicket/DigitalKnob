@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0

::####################################################################
::# dk_setDKTEMP_DIR()
::#
::#
:dk_setDKTEMP_DIR
:: setlocal
    call dk_debugFunc 0
    
    if defined DKTEMP_DIR %dk_call% dk_warning "DKTEMP_DIR already set to %DKTEMP_DIR%" && goto:eof
    
    if not defined DIGITALKNOB_DIR %dk_call% dk_setDIGITALKNOB_DIR
    set "DKTEMP_DIR=%DIGITALKNOB_DIR%\temp"
    if not exist "%DKTEMP_DIR%" %dk_call% dk_makeDirectory "%DKTEMP_DIR%"
goto:eof







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
    call dk_debugFunc 0
    
    %dk_call% dk_setDKTEMP_DIR
    %dk_call% dk_printVar DKTOOLS_DIR
    
    %dk_call% dk_setDKTEMP_DIR
    %dk_call% dk_printVar DKTOOLS_DIR
goto:eof
