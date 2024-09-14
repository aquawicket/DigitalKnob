@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_getDrive(path rtn_var)
::#
::#
:dk_getDrive
 setlocal
    call dk_debugFunc 2
    
    setlocal
        set "_input=%1"
        set "_input=%_input:"=%"
        if [%_input:~-1,1%] == [\] set "_input=%_input:~0,-1%"
        if [%_input:~-1,1%] == [/] set "_input=%_input:~0,-1%"
        for %%Z in ("%_input_%") do set "_drive_=%%~dZ"
    endlocal & set "%2=%_drive_%"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
    call dk_debugFunc 0
    
    %dk_call% dk_set myPath "C:\Windows"
    %dk_call% dk_getDrive "%myPath%" drive
    %dk_call% dk_printVar drive
%endfunction%
