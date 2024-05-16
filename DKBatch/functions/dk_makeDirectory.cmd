@echo off
call DK

::####################################################################
::# dk_makeDirectory(<path>)
::#
::#
:dk_makeDirectory () {
	call dk_debugFunc
	if %__ARGC__% NEQ 1 (dk_error "%__FUNCTION__%(): incorrect number of arguments")
	
	call dk_replaceAll "%~1" "/" "\" _path_
    if exist "%_path_%" (
		call dk_info "%_path_% already exists"
		goto:eof
	)
	mkdir "%_path_%"
goto:eof



:DKTEST ###############################################################################

call dk_makeDirectory "CreatedDirectory"