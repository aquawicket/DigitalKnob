@if (@X) == (@Y) @end /*
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_sleep(milliseconds)
::#
:dk_sleep
    call dk_debugFunc 1
 setlocal  
    :: Method 1 - javascript (fastest)
    set /a "milliseconds=%~1-100"
    cscript /nologo /e:JScript "%~f0" "%milliseconds%" %NO_STDERR% && %return% || (call ) %NO_OUTPUT%
    
    :: Method 2 - dk_powershell
    set /a "milliseconds=%~1-300"
    %dk_call% dk_powershell "Start-Sleep -m %milliseconds%" %NO_STDERR% && %return% || (call ) %NO_OUTPUT%
    
::  :: Method 3 - powershell directly
::  %dk_call% dk_printVar POWERSHELL_EXE
::  set /a "milliseconds=%~1-300"
::  %dk_call% %POWERSHELL_EXE% -Command "Start-Sleep -m %milliseconds%" %NO_STDERR% && %return% || (call ) %NO_OUTPUT%
    
    :: Method 4 - using ping
    set /a "seconds=(%~1+1000)/1000"
    ping 127.0.0.1 -n %seconds% >null
%endfunction%



::############################ DKTEST ############################
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_echo "sleeping for 1000 milliseconds . . ."
    %dk_call% dk_sleep 1000
%endfunction%
*/

WSH.Sleep(WSH.Arguments(0));



