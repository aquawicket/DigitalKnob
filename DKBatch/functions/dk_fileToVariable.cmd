@echo off
call DK.cmd

::################################################################################
::# dk_fileToVariable(path rtn_var)
::#
::#  Read lines of a file into an array and echo them back
::#
::#  reference: https://stackoverflow.com/a/49042678
::#
:dk_fileToVariable () {
	call dk_debugFunc
	if %__ARGC__% neq 2 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
    ::call dk_set file %~1
	set "\n=\n"
	for /f "delims=" %%x in (%~1) do call set "_fileVar_=%%_fileVar_%%%\n%%%x"
	endlocal & call dk_set %2 "%_fileVar_%"
goto:eof



:DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	
	call dk_fileToVariable "DK.cmd" myVar
	echo "%myVar%"