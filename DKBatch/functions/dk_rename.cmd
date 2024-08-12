@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"


::##################################################################################
::# dk_rename(from, to)
::#
::#	Rename/Move a file or directory to another name/location
::#
::#	@from		- The source path to move or rename
::#	@to			- The destination path to move or rename to
::#	OVERWRITE	- if any of the parameters equals OVERWRITE, overwritting existing file or folder is enabled
::#
:dk_rename
	call dk_debugFunc 2 3
	
	call dk_replaceAll "%~1" "/" "\" _from_
	call dk_replaceAll "%~2" "/" "\" _to_
	if "%~3" equ "OVERWRITE" ( set "OVERWRITE=1" ) else ( set "OVERWRITE=0" )
	
	call dk_info "Renameing %_from_% to %_to_%"
	
	if not exist "%_from_%" ( call dk_error "dk_rename: %_from_% not found" )
	
	if exist "%_to_%" (
		if "%OVERWRITE%" neq "1" (
			call dk_error "dk_rename Cannot rename file. Destiantion exists and OVERWRITE is not set"
		) 
		call dk_delete %_to_%
	)
	
	:: the base directory of the %to% path must exist.    
	call dk_dirname "%_to_%" _parent_dir_
	call dk_printVar _parent_dir_
	call dk_makeDirectory "%_parent_dir_%"
	
	::rename "%_from_%" "%_to_%"
	move /Y "%_from_%" "%_to_%"
	
	::TODO
	::[ ? = "success" ]
goto:eof







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_validate DIGITALKNOB_DIR "call dk_getDKPaths"
	
	call dk_fileWrite %DKDOWNLOAD_DIR%/renameMe.file "dk_rename test"
	call dk_rename %DKDOWNLOAD_DIR%/renameMe.file %DIGITALKNOB_DIR%/iWasRenamed.txt OVERWRITE
	
	call dk_fileWrite renameMe.file "dk_rename test"
	call dk_rename renameMe.file iWasRenamed.txt OVERWRITE
	
	call dk_makeDirectory %DKDOWNLOAD_DIR%/renameMe
	call dk_rename %DKDOWNLOAD_DIR%/renameMe %DIGITALKNOB_DIR%/iWasRenamed OVERWRITE
	
	call dk_makeDirectory renameMe
	call dk_rename renameMe iWasRenamed OVERWRITE
goto:eof