@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::#####################################################################
::# dk_delete(path)
::#
::#
:dk_delete
	call dk_debugFunc 1
	
	%dk_call% dk_replaceAll "%~1" "/" "\" _path_
	if not exist "%_path_%" (
		%dk_call% dk_warning "dk_delete %_path_% does not exist"
		goto:eof
	)
	
	%dk_call% dk_getFullPath "%_path_%" _path_ 
	
	del /F /Q "%_path_%" >nul 2>&1
	rd /s /q "%_path_%" >nul 2>&1
	
	if exist "%_path_%" (
		%dk_call% dk_error "dk_delete failed to remove %_path_%"
	)
goto:eof






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	%dk_call% dk_fileWrite "removeMe.file" "created file to test dk_delete"
	%dk_call% dk_delete "removeMe.file"
goto:eof
