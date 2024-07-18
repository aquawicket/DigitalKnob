@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd


::##################################################################################
::# dk_copy(from, to)
::#
::#	copy a file or directory to another location
::#
::#	@from		- The source path to copy
::#	@to			- The destination path to copy to
::#	OVERWRITE	- if any of the parameters equals OVERWRITE, overwritting existing file or folder is enabled
::#
:dk_copy
	call dk_debugFunc
	if %__ARGC__% LSS 2 call dk_error "%__FUNCTION__%(): not enough arguments"
	if %__ARGC__% GTR 3 call dk_error "%__FUNCTION__%(): too many arguments"
	
	call dk_replaceAll "%~1" "/" "\" _from_
	call dk_replaceAll "%~2" "/" "\" _to_
	if "%~3" equ "OVERWRITE" ( set "OVERWRITE=1" ) else ( set "OVERWRITE=0" )
	
	call dk_info "Copying %_from_% to %_to_%"
	
	if not exist "%_from_%" ( call dk_error "dk_copy: %_from_% not found" )
	
	if exist "%_to_%" (
		if "%OVERWRITE%" neq "1" (
			call dk_error "dk_copy Cannot copy file. Destiantion exists and OVERWRITE is not set"
		) 
		call dk_remove %_to_%
	)
	
	:: the base directory of the %to% path must exist.    
	call dk_dirname "%_to_%" _parent_dir_
	call dk_makeDirectory "%_parent_dir_%"
	
	::copy "%_from_%" "%_to_%"
	if exist "%_from_%\*" (
		echo D|xcopy "%_from_%" "%_to_%" /S /E /H /Y
	) else (
		echo F|xcopy "%_from_%" "%_to_%" /H /Y
	)

	::TODO
	::[ ? = "success" ]
goto:eof






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	call dk_validate DIGITALKNOB_DIR "call dk_getDKPaths"
	
	call dk_fileWrite %DKDOWNLOAD_DIR%\copyMe.file "dk_copy test"
	call dk_copy %DKDOWNLOAD_DIR%\copyMe.file %DIGITALKNOB_DIR%\iWasCopied.txt OVERWRITE
	
	call dk_fileWrite copyMe.file "dk_copy test"
	call dk_copy copyMe.file iWasCopied.txt OVERWRITE
	
	call dk_makeDirectory %DKDOWNLOAD_DIR%\copyMe
	call dk_copy %DKDOWNLOAD_DIR%\copyMe %DIGITALKNOB_DIR%\iWasCopied OVERWRITE
	
	call dk_makeDirectory copyMe
	call dk_copy copyMe iWasCopied OVERWRITE
goto:eof
