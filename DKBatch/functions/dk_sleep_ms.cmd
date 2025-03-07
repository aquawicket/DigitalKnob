@if (@X) == (@Y) @end /*
@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::####################################################################
::# dk_sleep_ms(milliseconds)
::#
:dk_sleep_ms
setlocal
	%dk_call% dk_debugFunc 1
	
    :: Method 1 - javascript (fastest)
    set /a "milliseconds=%~1"
    cscript /nologo /e:JScript "%~f0" "%milliseconds%" %NO_STDERR% && %return% || (call ) %NO_OUTPUT%
    
    :: Method 2 - dk_powershell
    set /a "milliseconds=%~1"
    %dk_call% dk_powershell "Start-Sleep -m %milliseconds%" %NO_STDERR% && %return% || (call ) %NO_OUTPUT%
    
::  :: Method 3 - powershell directly
::  set /a "milliseconds=%~1-300"
::  %dk_call% %POWERSHELL_EXE% -Command "Start-Sleep -m %milliseconds%" %NO_STDERR% && %return% || (call ) %NO_OUTPUT%
    
    :: Method 4 - using ping
    set /a "milliseconds=(%~1+1000)/1000"
    ping 127.0.0.1 -n %milliseconds% >null
%endfunction%



::############################ DKTEST ############################
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_echo "sleeping for 3000 milliseconds . . ."
    %dk_call% dk_sleep_ms 3000
%endfunction%

*/
WSH.Sleep(WSH.Arguments(0));



