@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::####################################################################
::# dk_extract(file, destination)
::#
::#
:dk_extract
	call dk_debugFunc
	if %__ARGC__% neq 2 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	call dk_info "Extracting %~1 to %~2 . . ."
	if not exist "%~1"   call dk_error "cannot find %~1"
    powershell Expand-Archive "%~1" -DestinationPath "%~2"
goto:eof




::####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_validate DKDOWNLOAD_DIR "call dk_getDKPaths"
	call dk_extract "%DKDOWNLOAD_DIR%/cmake-3.29.5-windows-x86_64.zip" "%DKDOWNLOAD_DIR%"
goto:eof
