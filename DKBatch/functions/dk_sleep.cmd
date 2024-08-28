@if (@X) == (@Y) @end /*
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0

::####################################################################
::# dk_sleep(milliseconds)
::#
:dk_sleep
 setlocal
	call dk_debugFunc 1
	
	:: Method 1 - javascript (fastest)
	set /a "milliseconds=%~1-100"
	cscript /nologo /e:JScript "%~f0" "%milliseconds%" 2>nul && goto:eof || (call ) %NO_STD%
	
	:: Method 2 - dk_powershell
	set /a "milliseconds=%~1-300"
	%dk_call% dk_powershell "Start-Sleep -m %milliseconds%" 2>nul && goto:eof || (call ) %NO_STD%
	
::	:: Method 3 - powershell directly
::	set /a "milliseconds=%~1-300"
::	%dk_call% powershell -Command "Start-Sleep -m %milliseconds%" 2>nul && goto:eof || (call ) %NO_STD%
	
	:: Method 4 - using ping
	set /a "seconds=(%~1+1000)/1000"
	ping 127.0.0.1 -n %seconds% >null
goto:eof



::############################ DKTEST ############################
:DKTEST
 setlocal
	call dk_debugFunc 0
	
	%dk_call% dk_echo "sleeping for 1000 milliseconds . . ."
	%dk_call% dk_sleep 1000
goto:eof
*/

WSH.Sleep(WSH.Arguments(0));



