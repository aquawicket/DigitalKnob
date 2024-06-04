@echo off
::if defined include_guard_dk_load ( goto:eof ) else set include_guard_dk_load=1
call DK


::####################################################################
::# dk_load()
::#
::#
:dk_load() {
	if not exist "%DKBATCH_FUNCTIONS_DIR%\dk_echo.cmd"      powershell -Command "(New-Object Net.WebClient).DownloadFile('%DKHTTP_DKBATCH_FUNCTIONS_DIR%/dk_echo.cmd', '%DKBATCH_FUNCTIONS_DIR%\dk_echo.cmd')"
	if not exist "%DKBATCH_FUNCTIONS_DIR%\dk_error.cmd"     powershell -Command "(New-Object Net.WebClient).DownloadFile('%DKHTTP_DKBATCH_FUNCTIONS_DIR%/dk_error.cmd', '%DKBATCH_FUNCTIONS_DIR%\dk_error.cmd')"
	if "%1" equ "" (call dk_error "dk_load(): incorrect number of arguments")
	
	if not exist "%DKBATCH_FUNCTIONS_DIR%\dk_debugFunc.cmd" powershell -Command "(New-Object Net.WebClient).DownloadFile('%DKHTTP_DKBATCH_FUNCTIONS_DIR%/dk_debugFunc.cmd', '%DKBATCH_FUNCTIONS_DIR%\dk_debugFunc.cmd')"
	call dk_debugFunc
	
	if not exist "%DKBATCH_FUNCTIONS_DIR%\dk_info.cmd"      powershell -Command "(New-Object Net.WebClient).DownloadFile('%DKHTTP_DKBATCH_FUNCTIONS_DIR%/dk_info.cmd', '%DKBATCH_FUNCTIONS_DIR%\dk_info.cmd')"
	if not exist "%DKBATCH_FUNCTIONS_DIR%\dk_download.cmd"  powershell -Command "(New-Object Net.WebClient).DownloadFile('%DKHTTP_DKBATCH_FUNCTIONS_DIR%/dk_download.cmd', '%DKBATCH_FUNCTIONS_DIR%\dk_download.cmd')"
	if not exist "%DKBATCH_FUNCTIONS_DIR%\%~1.cmd"          call dk_download "%DKHTTP_DKBATCH_FUNCTIONS_DIR%/%~1.cmd" "%DKBATCH_FUNCTIONS_DIR%\%~1.cmd"

goto:eof