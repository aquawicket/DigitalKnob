@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::call dk_source dk_debugFunc
::call dk_source dk_echo
::call dk_source dk_info
::################################################################################
::# dk_source(function_name)
::#
::#    @function_name	- the function name of the file to source and download if needed
::#
:dk_source
	if exist "%DKBATCH_FUNCTIONS_DIR_%dk_debugFunc.cmd" call dk_debugFunc
	::if %__ARGC__% neq 1 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	if not defined DKHTTP_DKBATCH_FUNCTIONS_DIR echo "ERROR: DKHTTP_DKBATCH_FUNCTIONS_DIR is invalid" & pause
	if exist "%DKBATCH_FUNCTIONS_DIR%\%~1.cmd" goto:eof
	
	::echo "(New-Object Net.WebClient).DownloadFile('%DKHTTP_DKBATCH_FUNCTIONS_DIR%/%~1.cmd', '%DKBATCH_FUNCTIONS_DIR%\%~1.cmd')"
	powershell -Command "(New-Object Net.WebClient).DownloadFile('%DKHTTP_DKBATCH_FUNCTIONS_DIR%/%~1.cmd', '%DKBATCH_FUNCTIONS_DIR%\%~1.cmd')"
	if not exist "%DKBATCH_FUNCTIONS_DIR%\%~1.cmd" call dk_echo "%1 command not found"
goto:eof






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST 
	call dk_debugFunc
	
	call dk_source dk_info
	call dk_info "test message using dk_source to load first"
goto:eof