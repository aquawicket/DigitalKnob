@echo off
call DK


::##################################################################################
::# dk_move(<from> <to>)
::#
::#	Rename file or directory or move a file or directory to another location
::#
::#	@from		- The source path to copy
::#	@to			- The destination path to copy to
::#	OVERWRITE	- if any of the parameters equals OVERWRITE, overwritting existing files is enabled
::#
:dk_move () {
	call dk_debugFunc
	if %__ARGC__% NEQ 2 (dk_error "%__FUNCTION__%(): incorrect number of arguments")
	
	call dk_replaceAll "%~1" "/" "\" _from_
	::set "_to_=%~2"
	call dk_getFilename "%~2" _to_
	set "OVERWRITE=1"
	
	call dk_info "Moving %_from_% to %_to_%"
	
	if not exist "%_from_%" ( call dk_error "dk_move: %_from_% not found" )
	
	if exist "%_to_%" (
		if "%OVERWRITE%" neq "1" (
			call dk_error "dk_move Cannot ove file. Destiantion exists and not set to OVERWRITE"
		)
		call dk_remove %_to_%
	)
	
	:: the base directory of the %to% path must exist.    
	call dk_getDirectory "%_to_%" _parent_dir_
	call dk_printVar _parent_dir_
	call dk_makeDirectory "%_parent_dir_%"
	
	move /Y "%_from_%" "%_to_%"
	::TODO
	::[ ? = "success" ]
goto:eof



:DKTEST ###############################################################################

	echo "dk_move test" > moveMe.file

	call dk_move moveMe.file iWasMoved.txt
