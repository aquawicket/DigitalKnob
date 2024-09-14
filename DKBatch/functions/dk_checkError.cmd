@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*

::####################################################################
::# dk_checkError()
::#
:dk_checkError
    call dk_debugFunc 0
 setlocal
 
    if %ERRORLEVEL% equ 0 goto:eof
    %dk_call% dk_error "ERRORLEVEL = %ERRORLEVEL%"
    ::endlocal
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_checkError
%endfunction%
