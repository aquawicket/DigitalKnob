@echo off
call DK

if not defined ENABLE_dk_printVar set "ENABLE_dk_printVar=1"
::################################################################################
::# dk_printVar(<variable>)
::#
::#
:dk_printVar () {
	call dk_debugFunc
	
	if "%ENABLE_dk_printVar%" neq "1"  goto:eof
	
	if not defined %~1 (
		echo %1 = %red%UNDEFINED%clr%
		goto:eof
	)
    
	set "_var_=%1"
    call set "_value_=%%%_var_%%%"
    echo %_var_% = '%_value_%'
goto:eof




:DKTEST #####################################################################

set "myVar=This is a string"
call dk_printVar myVar

set "myVarB="
call dk_printVar myVarB

set myVarC= 
call dk_printVar myVarC