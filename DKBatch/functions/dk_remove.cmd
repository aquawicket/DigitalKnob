@echo off
call DK.cmd


::#####################################################################
::# dk_remove(path)
::#
::#
:dk_remove () {
	call dk_debugFunc
	if %__ARGC__% neq 1 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	call dk_replaceAll "%~1" "/" "\" _path_
	if not exist "%_path_%" (
		call dk_warning "dk_remove %_path_% does not exist"
		goto:eof
	)
	
	call dk_getFullPath "%_path_%" _path_ 
	
	del /F /Q "%_path_%" >nul 2>&1
	rd /s /q "%_path_%" >nul 2>&1
	::call dk_sleep 1      &:: # give the path a second to delete
	
	if exist "%_path_%" (
		call dk_error "dk_remove failed to remove %_path_%"
	)
goto:eof



:DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	echo "DKTEST(${DKSCRIPT_NAME})"
	echo "created file to test dk_remove" > removeMe.file
	::call dk_sleep 1
	call dk_remove "removeMe.file"
