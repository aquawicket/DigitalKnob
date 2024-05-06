@echo off
call DK

::################################################################################
::# dk_decimalToVariable(<name> <decimal>)
::#
::#
:dk_decimalToVariable () {
	call dk_debugFunc
	
	call dk_decimalToHex %~2 hex
	call dk_hexToVariable %~1 %hex%
goto:eof