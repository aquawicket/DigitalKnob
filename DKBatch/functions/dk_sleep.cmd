@if (@X) == (@Y) @end /*
@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::####################################################################
::# dk_sleep(milliseconds)
::#
:dk_sleep
	call dk_debugFunc
	if %__ARGC__% neq 1 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	:: Method 1
	set /a "milliseconds=%~1-100"
	cscript /nologo /e:JScript "%~f0" "%milliseconds%" 2>nul && goto:eof || (call )
	
	:: Method 2
	set /a "milliseconds=%~1-300"
	powershell -Command "Start-Sleep -m %milliseconds%" 2>nul && goto:eof || (call )
	
	:: Method 3
	set /a "seconds=(%~1+1000)/1000"
	ping 127.0.0.1 -n %seconds% >null
goto:eof



::############################ DKTEST ############################
:DKTEST
	call dk_debugFunc
	
	call dk_echo "sleeping for 1000 milliseconds . . ."
	call dk_sleep 1000
goto:eof
*/

WSH.Sleep(WSH.Arguments(0));



