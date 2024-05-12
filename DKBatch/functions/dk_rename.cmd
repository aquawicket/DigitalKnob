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
	if "%~1" equ "" call dk_error "%__FUNCTION__%(%*): argument 1 is invalid"
	if "%~2" equ "" call dk_error "%__FUNCTION__%(%*): argument 2 is invalid"
	if "%~3" neq "" call dk_error "%__FUNCTION__%(%*): too many arguments"
	
	set "from=%~1"
	set "to=%~2"
	::OVERWRITE=     TODO
	
	call dk_info "Renameing %from% to %to%"
	
	if not exist "%from%" ( call dk_error "dk_rename: %from% not found" )
	
	if exist "%to%" ( pause )
::		if "%OVERWRITE%" neq "1" (
::			call dk_error "dk_rename Cannot rename file. Destiantion exists and not set to OVERWRITE"
::		)
		call dk_remove %to%
::	)
	
	:: the base directory of the %to% path must exist.    
	call dk_getDirectory "%to%" parent_dir
	
	call dk_printVar parent_dir
	call dk_makeDirectory "%parent_dir%"
	
	rename "%from%" "%to%"
	::TODO
	::[ ? = "success" ]
goto:eof



:DKTEST ###############################################################################

	echo "dk_rename test" > renameMe.file
	
	::rename renameMe.file iWasRenamed.txt
	call dk_rename renameMe.file iWasRenamed.txt
