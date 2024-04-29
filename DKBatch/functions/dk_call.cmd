@echo off
call dk_includeGuard
call DK

::####################################################################
::# dk_call(<command args>)
::#
::#
:dk_call () {
	call dk_debugFunc
	if "%1"=="" call dk_error "Incorrect number of parameters"

    call dk_echo %magenta% > %* %clr%
   
	call %*
goto:eof