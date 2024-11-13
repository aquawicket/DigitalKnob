@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::##################################################################################
::# dk_fileAppend(<file> string)
::#
::#
:dk_fileAppend
    call dk_debugFunc 2
 setlocal
 
    if exist "%~1" (
        echo %~2 >> "%~1"
    ) else (
        echo %~2 > "%~1"
    )
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_fileAppend "dk_fileAppend_TEST.txt" "string appended from dk_fileAppend"
%endfunction%
