@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_readlink(path "-f" rtn_var)
::#
::#    read the contents of a symbolic link
::#
::#    SHELL: https://man7.org/linux/man-pages/man1/realpath.1.html
::#    C:     https://pubs.opengroup.org/onlinepubs/9699919799/functions/readlink.html
::#
:dk_readlink
 setlocal
    call dk_debugFunc 2
    
    set _input=%1
    set _input=%_input:"=%
    if [%_input:~-1,1%] == [\] set _input=%_input:~0,-1%
    if [%_input:~-1,1%] == [/] set _input=%_input:~0,-1%
    endlocal & for %%Z in ("%_input%") do set "%2=%%~fZ"
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
    
    %dk_call% dk_set myPath "DK.cmd"
    %dk_call% dk_readlink "%myPath%" realpath
    %dk_call% dk_printVar realpath
%endfunction%
