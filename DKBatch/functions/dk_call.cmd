@echo off
::call DK

::####################################################################
::# dk_call(<command args>)
::#
::#
:dk_call () {
	::call dk_debugFunc
	::if "%1"=="" call dk_error "Incorrect number of parameters"
    
	::call dk_echo "%magenta% > %* %clr%"
    if not exist "%DKBATCH_DIR%\functions\dk_load.cmd" powershell -Command "(New-Object Net.WebClient).DownloadFile('%DKHTTP%/dk_load.cmd', '%DKBATCH_DIR%\functions\dk_load.cmd')"
	call dk_load %~1
	call %*
goto:eof
