@echo off
call DK

::################################################################################
::# dk_exit()
::#
::#
:dk_exit () {
	call dk_debugFunc

	echo dk_exit(%*)
	cmd /k & exit
goto:eof