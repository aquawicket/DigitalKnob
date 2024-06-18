@echo off
call DK

::################################################################################
::# dk_source(function_name)
::#
::#    @function_name	- the function name of the file to download
::#
:dk_source () {
	if exist "%DKBATCH_FUNCTIONS_DIR%\dk_debugFunc.cmd" call dk_debugFunc
	
	if not exist "%DKBATCH_FUNCTIONS_DIR%\%~1.cmd" powershell -Command "(New-Object Net.WebClient).DownloadFile('%DKHTTP_DKBATCH_FUNCTIONS_DIR%/%~1.cmd', '%DKBATCH_FUNCTIONS_DIR%\%~1.cmd')"
goto:eof



:DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

goto:eof