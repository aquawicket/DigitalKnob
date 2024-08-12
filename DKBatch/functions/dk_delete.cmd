@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"


::#####################################################################
::# dk_delete(path)
::#
::#
:dk_delete
	call dk_debugFunc 1
	
	call dk_replaceAll "%~1" "/" "\" _path_
	if not exist "%_path_%" (
		call dk_warning "dk_delete %_path_% does not exist"
		goto:eof
	)
	
	call dk_getFullPath "%_path_%" _path_ 
	
	del /F /Q "%_path_%" >nul 2>&1
	rd /s /q "%_path_%" >nul 2>&1
	
	if exist "%_path_%" (
		call dk_error "dk_delete failed to remove %_path_%"
	)
goto:eof






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_fileWrite "removeMe.file" "created file to test dk_delete"
	call dk_delete "removeMe.file"
goto:eof
