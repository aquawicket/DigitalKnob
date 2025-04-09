@if (@X) == (@Y) @end /*
@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::####################################################################
::# dk_sleep(seconds)
::#
:dk_sleep
setlocal
	%dk_call% dk_debugFunc 1  
    :: Method 1 - javascript (fastest)
    set /a "seconds=(%~1*1000)"
    cscript /nologo /e:javascript "%~f0" "%seconds%" %NO_STDERR% && dk_return || (call ) %NO_OUTPUT%
    
    :: Method 2 - dk_powershell
    set /a "seconds=%~1"
    %dk_call% dk_powershell "Start-Sleep -Seconds %seconds%" %NO_STDERR% && dk_return || (call ) %NO_OUTPUT%
    
::  :: Method 3 - powershell directly
::  set /a "seconds=%~1"
::  %dk_call% %POWERSHELL_EXE% -Command "Start-Sleep -Seconds %seconds%" %NO_STDERR% && dk_return || (call ) %NO_OUTPUT%
    
    :: Method 4 - using ping
    set /a "seconds=(%~1+1)"
    ping 127.0.0.1 -n %seconds% >null
%endfunction%



::############################ DKTEST ############################
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_echo "sleeping for 3 seconds . . ."
    %dk_call% dk_sleep 3
%endfunction%
*/

WSH.Sleep(WSH.Arguments(0));



