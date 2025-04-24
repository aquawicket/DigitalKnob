@if (@X) == (@Y) @end /*
<<<<<<< HEAD
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
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


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
>>>>>>> Development
    ping 127.0.0.1 -n %seconds% >null
%endfunction%



::############################ DKTEST ############################
:DKTEST
<<<<<<< HEAD
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_echo "sleeping for 1000 milliseconds . . ."
    %dk_call% dk_sleep 1000
=======
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_echo "sleeping for 3 seconds . . ."
    %dk_call% dk_sleep 3
>>>>>>> Development
%endfunction%
*/

WSH.Sleep(WSH.Arguments(0));



