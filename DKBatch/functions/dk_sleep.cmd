@if (@X) == (@Y) @end /*
@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# dk_sleep(seconds)
::#
:dk_sleep
%setlocal%
	%dk_call% dk_debugFunc 1 
   
	::### Method 1 - javascript (fastest)
    cscript /nologo /e:javascript "%~f0" "%~1"
   
    ::### Method 2 - dk_evalPowershell
	::%dk_call% dk_evalPowershell "Start-Sleep -Seconds %~1"
   
	::### Method 3 - powershell directly
	:: powershell.exe -Command "Start-Sleep -Seconds %~1"
   
    ::### Method 4 - using ping
	::set /a "seconds=(%~1+1)"
	::ping 127.0.0.1 -n %seconds% >nul
%endfunction%



::############################ DKTEST ############################
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	echo(
    echo( sleeping for 3 seconds . . .
    %dk_call% dk_sleep 3
	echo( done
	
	echo(
	echo( sleeping for 2 seconds . . .
    %dk_call% dk_sleep 2
	echo( done
	
	echo(
	echo( sleeping for 1 second . . .
    %dk_call% dk_sleep 1
	echo( done
%endfunction%


*/
WSH.Sleep(WSH.Arguments(0)*1000);



