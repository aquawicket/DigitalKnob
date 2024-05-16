@echo off
call DK


::##################################################################################
::# dk_rename(<from> <to>)
::#
::#	Rename file or directory or move a file or directory to another location
::#
::#	@from		- The source path to copy
::#	@to			- The destination path to copy to
::#	OVERWRITE	- if any of the parameters equals OVERWRITE, overwritting existing files is enabled
::#
:dk_rename () {
	call dk_debugFunc
	if %__ARGC__% NEQ 2 (dk_error "%__FUNCTION__%(): incorrect number of arguments")
	
	call dk_replaceAll "%~1" "/" "\" _from_
	call dk_replaceAll "%~2" "/" "\" _to_
	::call dk_getFilename "%~2" _to_
	set "OVERWRITE=1"
	
	call dk_info "Renameing %_from_% to %_to_%"
	
	if not exist "%_from_%" ( call dk_error "dk_rename: %_from_% not found" )
	
	if exist "%_to_%" (
		if "%OVERWRITE%" neq "1" (
			call dk_error "dk_rename Cannot rename file. Destiantion exists and not set to OVERWRITE"
		)
		call dk_remove %_to_%
	)
	
	:: the base directory of the %to% path must exist.    
	call dk_getDirectory "%_to_%" _parent_dir_
	call dk_printVar _parent_dir_
	call dk_makeDirectory "%_parent_dir_%"
	
	::rename "%_from_%" "%_to_%"
	move /Y "%_from_%" "%_to_%"
	
	::TODO
	::[ ? = "success" ]
goto:eof



:DKTEST ###############################################################################

	call dk_validate DIGITALKNOB_DIR dk_getDKPaths
	
	echo "dk_rename test" > %DKDOWNLOAD_DIR%/renameMe.file
	call dk_rename %DKDOWNLOAD_DIR%/renameMe.file %DIGITALKNOB_DIR%/iWasRenamed.txt
	
	echo "dk_rename test" > renameMe.file
	call dk_rename renameMe.file iWasRenamed.txt
	
	call dk_makeDirectory %DKDOWNLOAD_DIR%/renameMe
	call dk_move %DKDOWNLOAD_DIR%/renameMe %DIGITALKNOB_DIR%/iWasRenamed
	
	call dk_makeDirectory renameMe
	call dk_move renameMe iWasRenamed
