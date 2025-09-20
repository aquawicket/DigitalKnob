@if (@X)==(@Y) @end /*
@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# dk_sleep_ms(milliseconds)
::#
:dk_sleep_ms
%setlocal%
	%dk_call% dk_debugFunc 1
	
    ::### Method 1 - direct javascript (fastest)
    cscript /nologo /e:javascript "%~f0" "%~1"
   
	::### Method 2 - dk_evalPowershell
	::%dk_call% dk_evalPowershell "Start-Sleep -m %~1"
   
	::### Method 3 - direct powershell
	::powershell.exe -Command "Start-Sleep -m %~1"
   
	::### Method 4 - using ping
	::set /a "seconds=(%~1+1000)/1000"
	::ping 127.0.0.1 -n %seconds% >null
%endfunction%



::############################ DKTEST ############################
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	echo(
    echo( sleeping for 3000 milliseconds (3 seconds). . .
    %dk_call% dk_sleep_ms 3000
	echo( done
	
	echo(
	echo( sleeping for 1000 milliseconds (1 second). . .
    %dk_call% dk_sleep_ms 1000
	echo( done
%endfunction%

*/
WSH.Sleep(WSH.Arguments(0));



