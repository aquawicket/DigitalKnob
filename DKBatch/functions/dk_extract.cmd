@echo off
call DK

::####################################################################
::# dk_extract(<file> <destination>)
::#
::#
:dk_extract () {
	call dk_debugFunc
	if %__ARGC__% NEQ 2 (dk_error "%__FUNCTION__%(): incorrect number of arguments")
	
	call dk_info "Extracting %~1 to %~2 . . ."
	if not exist "%~1"   call dk_error "cannot find %~1"
    powershell Expand-Archive "%~1" -DestinationPath "%~2"
goto:eof




:DKTEST ########################################################################
