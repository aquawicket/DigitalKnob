@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::##################################################################################
::# dk_copy(from, to)
::#
::# copy a file or directory to another location
::#
::# @from       - The source path to copy
::# @to         - The destination path to copy to
::# OVERWRITE   - if any of the parameters equals OVERWRITE, overwritting existing file or folder is enabled
::#
:dk_copy
%setlocal%
	%dk_call% dk_debugFunc 2 3

	set "_from_=%~1"	
	set "_to_=%~2"
	if /i "%~3" equ "OVERWRITE" (set "OVERWRITE=1") else (set "OVERWRITE=0")

	%dk_call% dk_info "Copying %_from_% to %_to_%"

	if NOT EXIST "%_from_%" (%dk_call% dk_error "dk_copy:'%_from_%' NOT found")

	if EXIST "%_to_%" (
		if "%OVERWRITE%" neq "1" (
			%dk_call% dk_error "dk_copy Cannot copy file. Destiantion already exists and OVERWRITE is NOT set"
		)
		%dk_call% dk_delete %_to_%
	)

	:: the base directory of the %to% path must EXIST.   
	%dk_call% dk_dirname "%_to_%"
	if NOT EXIST "%dk_dirname%" (%dk_call% dk_mkdir "%dk_dirname%")

	::copy "%_from_%" "%_to_%"
	if EXIST "%_from_%\*" (
		echo D|xcopy "%_from_:/=\%" "%_to_:/=\%" /S /E /H /Y
	) else (
		echo F|xcopy "%_from_:/=\%" "%_to_:/=\%" /H /Y
	)

	if NOT EXIST "%_to_%" (%dk_call% dk_fatal "dk_copy failed: %_to_% does NOT EXIST")
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_validate DKCACHE_DIR "%dk_call% dk_DKCACHE_DIR"

	%dk_call% dk_fileWrite "%DKCACHE_DIR%/copyMe.file" "dk_copy test"
	%dk_call% dk_copy "%DKCACHE_DIR%/copyMe.file" "%DKCACHE_DIR%/iWasCopied.txt" OVERWRITE

	%dk_call% dk_mkdir "%DKCACHE_DIR%/copyMe"
	%dk_call% dk_copy "%DKCACHE_DIR%/copyMe" "%DKCACHE_DIR%/iWasCopied" OVERWRITE
%endfunction%
