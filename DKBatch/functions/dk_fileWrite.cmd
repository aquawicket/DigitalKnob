@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::##################################################################################
::# dk_fileWrite(file, string)
::#
::#
:dk_fileWrite
    call dk_debugFunc 2
 setlocal
 
    echo %~2 > "%~1"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_fileWrite "dk_fileWrite_TEST.txt" "string written by dk_fileWrite"
%endfunction%
