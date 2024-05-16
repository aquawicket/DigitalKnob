@echo off
call DK

if not defined ENABLE_dk_printVar set "ENABLE_dk_printVar=1"
::################################################################################
::# dk_printVar(<variable>)
::#
::#
:dk_printVar () {
	call dk_debugFunc
	if "%~1" equ "" call dk_error "%__FUNCTION__%(%*): argument 1 is invalid"
	if "%~2" neq "" call dk_error "%__FUNCTION__%(%*): too many arguments"
	
	if "%ENABLE_dk_printVar%" neq "1"  goto:eof
	
	if not defined %~1 ( goto:try_array )
	set "_var_=%~1"
    call set "_value_=%%%_var_%%%"
    
	::echo %_var_% = '%_value_%'
	call dk_debug "%_var_% = '%_value_%'"
	goto:eof

	:try_array	
	if not defined %~1[0] (
		call dk_debug "%~1 = %red%UNDEFINED%clr%"
		goto:eof
	)
	set "_array_=%~1"
	set /A "n=0"
	setlocal EnableDelayedExpansion
		:loop1
		if defined %_array_%[%n%] ( 
		   call dk_debug "%_array_%[%n%] = '!%_array_%[%n%]!'"
		   set /A n+=1
		   goto :loop1 
		)
		::call dk_info "%_array_% length = %n%"
	endlocal
goto:eof




:DKTEST #####################################################################

set "myVar=This is a variable"
call dk_printVar myVar

set "myVarB="
call dk_printVar myVarB

set myVarC= 
call dk_printVar myVarC

set "myVarD[0]=This is an array, element 0"
set "myVarD[1]=This is an array, element 1"
set "myVarD[2]=This is an array, element 2"
call dk_printVar myVarD
call dk_printVar myVarD[1]

set "myVarE=dk_load('%DKIMPORTS_DIR%/notepadpp/DKMAKE.cmake')"
call dk_printVar myVarE

call dk_printVar :try_array