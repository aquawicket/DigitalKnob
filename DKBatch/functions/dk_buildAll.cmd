@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::#################################################################################
:: dk_build()
::
::
:build_all
	call dk_debugFunc 0
	
goto:eof



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call build_all
goto:eof
