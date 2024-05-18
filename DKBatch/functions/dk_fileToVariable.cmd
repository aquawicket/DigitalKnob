@echo off
call DK

::################################################################################
::# dk_fileToVariable(<path> <output>)
::#
::#  Read lines of a file into an array and echo them back
::#
::#  reference: https://stackoverflow.com/a/49042678
::#
:dk_fileToVariable () {
	call dk_debugFunc
	if %__ARGC__% NEQ 2 (call dk_error "%__FUNCTION__%(): incorrect number of arguments")
	
    ::set "file=%~1"
	set "\n=\n"
	for /f "delims=" %%x in (%~1) do call set "_fileVar_=%%_fileVar_%%%\n%%%x"
	endlocal & set "%2=%_fileVar_%"
goto:eof



:DKTEST ########################################################################
	
	::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	call dk_fileToVariable "DK.cmd" myVar
	echo "%myVar%"