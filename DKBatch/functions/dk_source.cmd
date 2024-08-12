@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::call dk_source dk_debugFunc
::call dk_source dk_echo
::call dk_source dk_info
::################################################################################
::# dk_source(function_name)
::#
::#    @function_name	- the function name of the file to source and download if needed
::#
:dk_source
	if exist "%DKBATCH_FUNCTIONS_DIR%\dk_debugFunc.cmd" call dk_debugFunc 1
	
	setlocal
	if not defined DKHTTP_DKBATCH_FUNCTIONS_DIR echo "ERROR: DKHTTP_DKBATCH_FUNCTIONS_DIR is invalid" & pause
	if exist "%DKBATCH_FUNCTIONS_DIR%\%~1.cmd" goto:eof
	
	echo downloading %~1 . . .
	
	:: Try dk_download
	if exist "%DKBATCH_FUNCTIONS_DIR%\dk_download.cmd" call dk_download "%DKHTTP_DKBATCH_FUNCTIONS_DIR%/%~1.cmd" "%DKBATCH_FUNCTIONS_DIR%\%~1.cmd"
	if exist "%DKBATCH_FUNCTIONS_DIR%\%~1.cmd" goto:eof
	
	:: Try dk_powershellEval
	if exist "%DKBATCH_FUNCTIONS_DIR%\dk_powershellEval.cmd" call dk_powershellEval "(New-Object Net.WebClient).DownloadFile('%DKHTTP_DKBATCH_FUNCTIONS_DIR%/%~1.cmd', '%DKBATCH_FUNCTIONS_DIR%\%~1.cmd')"
	if exist "%DKBATCH_FUNCTIONS_DIR%\%~1.cmd" goto:eof
		
	:: Try powershell
	powershell /? 1>nul && powershell -Command "(New-Object Net.WebClient).DownloadFile('%DKHTTP_DKBATCH_FUNCTIONS_DIR%/%~1.cmd', '%DKBATCH_FUNCTIONS_DIR%\%~1.cmd')"
	if exist "%DKBATCH_FUNCTIONS_DIR%\%~1.cmd" goto:eof
	
	:: Try curl
	curl --help 1>nul && curl "%DKHTTP_DKBATCH_FUNCTIONS_DIR%/%~1.cmd" -o "%DKBATCH_FUNCTIONS_DIR%\%~1.cmd"
	if exist "%DKBATCH_FUNCTIONS_DIR%\%~1.cmd" goto:eof
	
	:: Try certutil
	certutil.exe /? 1>nul && certutil.exe -urlcache -split -f "%DKHTTP_DKBATCH_FUNCTIONS_DIR%/%~1.cmd" "%DKBATCH_FUNCTIONS_DIR%\%~1.cmd"
	if exist "%DKBATCH_FUNCTIONS_DIR%\%~1.cmd" goto:eof
	
	if not exist "%DKBATCH_FUNCTIONS_DIR%\%~1.cmd" call dk_echo "failed to download %1.cmd"
	endlocal
goto:eof






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST 
	call dk_debugFunc 0
	
	call dk_source dk_info
	call dk_info "test message using dk_source to load first"
goto:eof