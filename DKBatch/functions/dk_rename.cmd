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
	
	%dk_call% dk_replaceAll "%~1" "/" "\" _from_
	%dk_call% dk_replaceAll "%~2" "/" "\" _to_
	if "%~3" equ "OVERWRITE" ( set "OVERWRITE=1" ) else ( set "OVERWRITE=0" )
	
	%dk_call% dk_info "Renameing %_from_% to %_to_%"
	
	if not exist "%_from_%" ( %dk_call% dk_error "dk_rename: %_from_% not found" )
	
	if exist "%_to_%" (
		if "%OVERWRITE%" neq "1" (
			%dk_call% dk_error "dk_rename Cannot rename file. Destiantion exists and OVERWRITE is not set"
		) 
		%dk_call% dk_delete %_to_%
	)
	
	:: the base directory of the %to% path must exist.    
	%dk_call% dk_dirname "%_to_%" _parent_dir_
	::%dk_call% dk_printVar _parent_dir_
	%dk_call% dk_makeDirectory "%_parent_dir_%"
	
	::rename "%_from_%" "%_to_%"
	move /Y "%_from_%" "%_to_%" %NO_STDOUT%
	
	::TODO
	::[ ? = "success" ]
goto:eof







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	%dk_call% dk_validate DIGITALKNOB_DIR "%dk_call% dk_getDKPaths"
	
	%dk_call% dk_fileWrite %DKTEMP_DIR%/renameMe.file "dk_rename test"
	%dk_call% dk_rename %DKTEMP_DIR%/renameMe.file %DKTEMP_DIR%/iWasRenamed.txt OVERWRITE
	
	%dk_call% dk_makeDirectory %DKTEMP_DIR%/renameMe
	%dk_call% dk_rename %DKTEMP_DIR%/renameMe %DKTEMP_DIR%/iWasRenamed OVERWRITE
goto:eof