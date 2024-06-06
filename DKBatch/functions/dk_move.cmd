@echo off
call DK


::##################################################################################
::# dk_move(<from> <to>)
::#
::#	Move/Rename a file or directory to another location/name
::#
::#	@from		- The source path to move or rename
::#	@to			- The destination path to move or rename to
::#	OVERWRITE	- if any of the parameters equals OVERWRITE, overwritting existing file or folder is enabled
::#
:dk_move () {
	call dk_debugFunc
	if %__ARGC__% LSS 2 (call dk_error "%__FUNCTION__%(): not enough arguments")
	if %__ARGC__% GTR 3 (call dk_error "%__FUNCTION__%(): too many arguments")
	
	call dk_replaceAll "%~1" "/" "\" _from_
	call dk_replaceAll "%~2" "/" "\" _to_
	if "%~3" equ "OVERWRITE" ( set "OVERWRITE=1" ) else ( set "OVERWRITE=0" )
	
	call dk_info "Moving %_from_% to %_to_%"
	
	if not exist "%_from_%" ( call dk_error "dk_move: %_from_% not found" )
	
	if exist "%_to_%" (
		if "%OVERWRITE%" neq "1" (
			call dk_error "dk_rename Cannot move file. Destiantion exists and OVERWRITE is not set"
		) 
		call dk_remove %_to_%
	)
	
	:: the base directory of the %to% path must exist.    
	call dk_getDirname "%_to_%" _parent_dir_
	call dk_printVar _parent_dir_
	call dk_makeDirectory "%_parent_dir_%"
	
	move /Y "%_from_%" "%_to_%"
	
	::TODO
	::[ ? = "success" ]
goto:eof



:DKTEST ###############################################################################
	
	call dk_validate DIGITALKNOB_DIR "call dk_getDKPaths"
	
	echo "dk_move test" > %DKDOWNLOAD_DIR%/moveMe.file
	call dk_move %DKDOWNLOAD_DIR%/moveMe.file %DIGITALKNOB_DIR%/iWasMoved.txt OVERWRITE
	
	echo "dk_move test" > moveMe.file
	call dk_move moveMe.file iWasMoved.txt OVERWRITE
	
	call dk_makeDirectory %DKDOWNLOAD_DIR%/moveMe
	call dk_move %DKDOWNLOAD_DIR%/moveMe %DIGITALKNOB_DIR%/iWasMoved OVERWRITE
	
	call dk_makeDirectory moveMe
	call dk_move moveMe iWasMoved OVERWRITE
