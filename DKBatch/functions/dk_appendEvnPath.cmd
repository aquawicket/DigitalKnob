@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

call dk_source dk_appendEvnPath
call dk_source dk_debugFunc
call dk_source dk_error
call dk_source dk_info
call dk_source dk_stringContains
call dk_source dk_validate
call dk_source dk_validateBranch
::################################################################################
::# dk_appendEvnPath(array, index, element)
::#
::#   Func: Appends a path to the %PATH% environment variable
::#   path: A string containing the new path
::#
::#	  Example:  call dk_appendEvnPath C:\Windows\System32 result
::#          echo dk_appendEvnPath returned: %result%
::#
:dk_appendEvnPath () {
	call dk_debugFunc
	if %__ARGC__% neq 1 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	set "_path_=%~1"

	call dk_stringContains "%PATH%\" "%_path_%" result
	
	if "%result%" equ "true" dk_info "path already in list" & goto:oef
	
	setx PATH "%PATH%";"%_path_%" >nul
	set "PATH=%PATH%;%_path_%"
	if "%ERRORLEVEL%" neq "0" dk_error "ERROR: %ERRORLEVEL% 

	::endlocal & set "%3=%result%"
goto:eof





:DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	call dk_debugFunc

	call dk_validate DKBATCH_FUNCTIONS_DIR_ "call dk_validateBranch"	
	call dk_appendEvnPath %DKBATCH_FUNCTIONS_DIR%
goto:eof