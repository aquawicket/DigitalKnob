@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0

::####################################################################
::# dk_asciiToHex(ascii, rtn_var)
::#
::#    reference: https://www.ascii-code.com
::#
:dk_asciiToHex
    call dk_debugFunc 2
 setlocal
 
    :: Store the string in chr.tmp file
    set /P "=%~1" < NUL > chr.tmp

    :: Create zero.tmp file with the same number of Ascii zero characters
    for %%a in (chr.tmp) do fsutil file createnew zero.tmp %%~Za > NUL

    :: Compare both files with FC /B and get the differences
    set "hex="
    for /F "skip=1 tokens=2" %%a in ('fc /B chr.tmp zero.tmp') do set "hex=%%a"
    del chr.tmp zero.tmp
    set "hex=0x%hex:~-2%"
    
    endlocal & set "%2=%hex%"

:: debug
	%dk_call% dk_printVar %2
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_set myAscii x
    %dk_call% dk_asciiToHex myAscii myHex
    %dk_call% dk_info "myHex = %myHex%"
%endfunction%
