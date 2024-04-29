@echo off
call dk_includeGuard
call DK

::################################################################################
::# dk_clearScreen()
::#
::#
:dk_clearScreen () {
	call dk_debugFunc
	
    cls
goto:eof