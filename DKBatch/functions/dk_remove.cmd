@echo off
call DK


::#####################################################################
::# dk_remove(<path>)
::#
::#
:dk_remove () {
	call dk_debugFunc
	
	set "_path=%1"
	if not exist "%_path%" (
		call dk_warning "dk_remove %_path% does not exist"
	)
	
	del /F /S "%_path%"
	call dk_sleep 1      &:: # give the path a second to delete
	
	if exist "%_path%" (
		call dk_error "dk_remove failed to remove %_path%"
		::return $false
	)
goto:eof



:DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	echo "DKTEST(${DKSCRIPT_NAME})"
	echo "created file to test dk_remove" > removeMe.file
	pause
	call dk_remove removeMe.file
