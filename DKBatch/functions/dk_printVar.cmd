@echo off
call DK


::################################################################################
::# dk_printVar(<variable>)
::#
::#
:dk_printVar () {
	if not defined ENABLE_dk_printVar set "ENABLE_dk_printVar=1"
	
	set "OLD_ENABLE_dk_debugFunc=%ENABLE_dk_debugFunc%"
	set "ENABLE_dk_debugFunc=0"
	call dk_debugFunc
	set "ENABLE_dk_debugFunc=%OLD_ENABLE_dk_debugFunc%"
	if %__ARGC__% NEQ 1 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	if "%ENABLE_dk_printVar%" neq "1"  goto:eof
	
	:pointer
	set "_var_=%~1"
	setlocal EnableDelayedExpansion
	call set "_value_=!%_var_%!"
	if not defined !_value_! ( endlocal & goto :array )
	call dk_debug "%_var_% = '!%_value_%!'"
	endlocal
    goto:eof
	
	:array
	if not defined %~1[0] ( goto :variable )
    set "_array_=%~1"
    set /A "n=0"
    setlocal EnableDelayedExpansion
    :loop1
    if defined %_array_%[%n%] ( 
        call dk_debug "%_array_%[%n%] = '!%_array_%[%n%]!'"
        set /A n+=1
        goto :loop1 )
    ::call dk_info "%_array_% length = %n%"
    endlocal
    goto:eof

    :variable
	set "_var_=%~1"
    if not defined %~1 ( goto :undefined )	
    call dk_debug "%_var_% = '%%%_var_%%%'"
    goto:eof
    
    :undefined
    call dk_debug "%~1 = %red%UNDEFINED%clr%"
	
goto:eof
    
    
    
    	
	


:DKTEST #####################################################################

set "myVarA=This is a variable"
call dk_printVar myVarA

set "myVarB=varB content"
call dk_printVar myVarB

set "myVarC=myVarB"
call dk_printVar myVarC

set "myVarD[0]=This is an array, element 0"
set "myVarD[1]=This is an array, element 1"
set "myVarD[2]=This is an array, element 2"
call dk_printVar myVarD
call dk_printVar myVarD[1]

set "myVarE=dk_load('%DKIMPORTS_DIR%/notepadpp/DKMAKE.cmake')"
call dk_printVar myVarE

::set "myVarF"
call dk_printVar myVarF