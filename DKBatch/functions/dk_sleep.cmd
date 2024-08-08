@if (@X) == (@Y) @end /*
@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

set /a "sleepAdjustment=-100"
::####################################################################
::# dk_sleep(milliseconds)
::#
:dk_sleep
	call dk_debugFunc
	if %__ARGC__% neq 1 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	set /a "milliseconds=%~1+sleepAdjustment"
	cscript /nologo /e:JScript "%~f0" "%milliseconds%" 2>nul && goto:eof || (call )
	
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



