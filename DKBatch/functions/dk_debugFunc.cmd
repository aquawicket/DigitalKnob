@echo off
call DK

if not defined ENABLE_dk_debugFunc     set ENABLE_dk_debugFunc=1
if not defined MAX_STACK_LINES         set "MAX_STACK_LINES=200"
if not defined DKSTACK[0].__FILE__     set "DKSTACK[0].__FILE__=%0"
if not defined DKSTACK[0].__FUNCTION__ set "DKSTACK[0].__FUNCTION__=main"
if not defined DKSTACK[0].__ARGS__     set "DKSTACK[0].__ARGS__=0"
if not defined DKSTACK_length          set /a "DKSTACK_length=1"
if not defined DKSTACK_marker          set /a "DKSTACK_marker=1"
::################################################################################
::# dk_debugFunc()
::#
::#
:dk_debugFunc () {
	if "%*" neq "" call dk_error "%__FUNCTION__%(%*): too many arguments"
	
	if not exist "%DKBATCH_DIR%\functions\dk_caller.cmd" powershell -Command "(New-Object Net.WebClient).DownloadFile('%DKHTTP%/dk_caller.cmd', '%DKBATCH_DIR%\functions\dk_caller.cmd')"
	call dk_caller DKCALLER
	:dk_caller
	set "DKSTACK[%DKSTACK_marker%].__FILE__=%__FILE__%"
	set "DKSTACK[%DKSTACK_marker%].__FUNCTION__=%__FUNCTION__%"
	set "DKSTACK[%DKSTACK_marker%].__ARGS__=%__ARGS__%"
	
::	call dk_getCaller 2
::	:dk_getCaller_return2
::	set DKSTACK[%DKSTACK_marker%].__FILE__=%caller[0].fullpath%
::	set DKSTACK[%DKSTACK_marker%].__FUNCTION__=%caller[0].func%
::	set DKSTACK[%DKSTACK_marker%].__ARGS__=%caller[0].args%
	
	
	set /a DKSTACK_length+=1
	set /a DKSTACK_marker=%DKSTACK_length%	
::	if %DKSTACK_length% LSS %MAX_STACK_LINES% (
::		set /a DKSTACK_length+=1
::		echo "growing DKSTACK_length to %DKSTACK_length%"
::	) else (
::		echo "DKSTACK_length is capped at %DKSTACK_length%"
::	)
::	if %DKSTACK_marker% LSS %DKSTACK_length% (
::		set /a DKSTACK_marker+=1
::		echo "advancing DKSTACK_marker to %DKSTACK_marker%"
::	) else (
::		set /a DKSTACK_marker=0
::		echo "resetting DKSTACK_marker to %DKSTACK_marker%"

	
	if "%ENABLE_dk_debugFunc%" neq "1" goto:eof
	set "cyan=[36m"
	set "clr=[0m"
	echo %__FILE__%: %cyan%%__FUNCTION__%(%__ARGS__%)%clr%
	
goto:eof