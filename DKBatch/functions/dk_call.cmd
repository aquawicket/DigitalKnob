@echo off


::####################################################################
::# dk_call(<command args>)
::#
::#
:::dk_call () {
	::call dk_debugFunc
	::if "%1"=="" call dk_error "Incorrect number of parameters"

    ::call dk_echo %magenta% > %* %clr%
   
	if not exist "%DKBATCH_DIR%\functions\%~1.cmd" call dk_download "%DKHTTP%/%~1.cmd" "%DKBATCH_DIR%\functions\%~1.cmd"
call %*
