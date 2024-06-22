@echo off
call DK


::##################################################################################
::# dk_atob(input, output)
::#
::#    Decode base-64 input to output
::#    https://github.com/base64code/examples
::#
:dk_atob () {
	call dk_debugFunc
	if %__ARGC__% neq 2 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	if not exist "%~1" call dk_error "%~1 not found"
	if exist "%~2" call dk_error "%~2 already exists and cannot be overwritten"
	
	if exist "%~1" certutil -decode "%~1" "%~2"
goto:eof





:DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	call dk_debugFunc
	
	call dk_validate DKBRANCH_DIR "call dk_validateBranch"
	set "input=%DKBRANCH_DIR%\DKBuilder.cmd.base64"
	set "output=%DKBRANCH_DIR%\DKBuilder_decoded.cmd"
	call dk_atob "%input%" "%output%"
goto:eof