@echo off
call DK.cmd


::##################################################################################
::# dk_btoa(input, output)
::#
::#    Encode input to base-64 output
::#    https://github.com/base64code/examples
::#
:dk_btoa () {
	call dk_debugFunc
	if %__ARGC__% neq 2 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	if not exist "%~1" call dk_error "%~1 not found"
	if exist "%~2" call dk_error "%~2 already exists and cannot be overwritten"
	
	if exist "%~1" certutil -encode "%~1" "%~2"
goto:eof





:DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	call dk_debugFunc
	
	call dk_validate DKBRANCH_DIR "call dk_validateBranch"
	set "input=%DKBRANCH_DIR%\DKBuilder.cmd"
	set "output=%DKBRANCH_DIR%\DKBuilder.cmd.base64"
	call dk_btoa "%input%" "%output%"
goto:eof