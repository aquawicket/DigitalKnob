@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::##################################################################################
::# dk_rename(from, to)
::# dk_rename(from, to, OVERWRITE)
::#
::# Rename/Move a file or directory to another name/location
::#
::# @from		- The source path to move or rename
::# @to			- The destination path to move or rename to
::# OVERWRITE	- if OVERWRITE is specified, overwritting existing file or folder is enabled
::#
:dk_rename
setlocal
	%dk_call% dk_debugFunc 2 3
	
	set "_from_=%~1"
	set "_to_=%~2"
	if "%~3" equ "OVERWRITE" (set "OVERWRITE=1") else (set "OVERWRITE=0")
	
	%dk_call% dk_info "Renameing %_from_% to %_to_%"
	
	if not exist "%_from_%" (
		%dk_call% dk_error "dk_rename: %_from_% not found"
		dk_return
	)
	
	if exist "%_to_%" (
		if not "%OVERWRITE%"=="1" (
			%dk_call% dk_error "dk_rename Cannot rename file. Destiantion already exists and OVERWRITE is not set"
			dk_return
		) 
		%dk_call% dk_delete %_to_%
	)
	
	:: the base directory of the %_to_% path must exist.	
	%dk_call% dk_dirname "%_to_%"
	if not exist "%dk_dirname%" (%dk_call% dk_makeDirectory "%dk_dirname%")
	
	move /Y "%_from_:/=\%" "%_to_:/=\%" %NO_STDOUT%
	
	::TODO
	::[ ? = "success" ]
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_validate DIGITALKNOB_DIR "%dk_call% dk_DIGITALKNOB_DIR"
	
	%dk_call% dk_fileWrite "%DKCACHE_DIR%/renameMe.file" "dk_rename test"
	%dk_call% dk_rename "%DKCACHE_DIR%/renameMe.file" "%DKCACHE_DIR%/iWasRenamed.txt" OVERWRITE
	
	%dk_call% dk_makeDirectory "%DKCACHE_DIR%/renameMe"
	%dk_call% dk_rename "%DKCACHE_DIR%/renameMe" "%DKCACHE_DIR%/iWasRenamed" OVERWRITE
%endfunction%