call dk_includeGuard

::################################################################################
::# dk_exit()
::#
::#
:dk_exit () {
	call dk_debugFunc

	cmd /k & exit
goto:eof