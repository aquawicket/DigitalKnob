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
	if %__ARGC__% NEQ 2 (dk_error "%__FUNCTION__%(): incorrect number of arguments")
	
    ::set "file=%~1"
	setlocal EnableDelayedExpansion
	
	for /f "delims=" %%x in (DK.cmd) do set Build=%%x
	
    for /F "usebackq delims=" %%a in ("%~1") do (
		set "%~2[!i!]=%%a"
		set /a i+=1
    )
goto:eof



:DKTEST ########################################################################

setlocal enableDelayedExpansion
set \n=^


rem two empty line required after set \n

for /f "delims=" %%x in (DK.cmd) do set file_var=!file_var!!\n!%%x
	
	echo !file_var!