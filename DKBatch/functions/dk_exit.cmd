@echo off
call DK

::################################################################################
::# dk_exit()
::#
::#
:dk_exit () {
	call dk_debugFunc

	::cmd /k & exit
	exit
goto:eof