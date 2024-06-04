@echo off


::####################################################################
::# dk_call(<command args>)
::#
::#
:dk_call () {
	call dk_debugFunc

    ::call dk_echo %magenta% > %* %clr%
   
	if not exist "%DKBATCH_DIR%\functions\%~1.cmd" call dk_download "%DKHTTP_DKBATCH_FUNCTIONS_DIR%/%~1.cmd" "%DKBATCH_DIR%\functions\%~1.cmd"
    call %*



:DKTEST ########################################################################
