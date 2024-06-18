@echo off
call DK

call dk_source dk_replaceAll
::####################################################################
::# dk_makeDirectory(path)
::#
::#
:dk_makeDirectory () {
	call dk_debugFunc
	if %__ARGC__% neq 1 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	call dk_replaceAll "%~1" "/" "\" _path_
    if exist "%_path_%" (
		rem call dk_info "%_path_% already exists"
		goto:eof
	)
	mkdir "%_path_%"
goto:eof



:DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ##########

	call dk_makeDirectory "CreatedDirectory"
goto:eof