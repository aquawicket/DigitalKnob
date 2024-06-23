@echo off
call DK.cmd

if not defined ESC   call set "ESC="
if not defined red   call set "red=%ESC%[31m"
if not defined LBLUE call set "LBLUE=%ESC%[94m"
if not defined blue  call set "blue=%ESC%[34m"
if not defined clr   call set "clr=%ESC%[0m"
if not defined ENABLE_dk_printVar set "ENABLE_dk_printVar=0"
::################################################################################
::# dk_printVar(variable)
::#
::#
:dk_printVar () {
	call dk_debugFunc
    if %__ARGC__% neq 1 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")

    if "%ENABLE_dk_printVar%" neq "1" goto:eof

	if not defined %~1 ( goto:undefined )

	:array
	set "arry=%~1"
	set /A "n=0"
	setlocal EnableDelayedExpansion
	:loop1
	if not defined %arry%[%n%] ( goto:pointer )
	call dk_echo %LBlue% %arry%[%n%] %blue% = !%arry%[%n%]!%clr%
	set /A n+=1
	goto :loop1 
	endlocal
	
    :pointer
	setlocal
    set "_ptr_=%~1"
	call set "_ptrB_=%%%_ptr_%%%"
	if not "%_ptrB_%"=="%_ptrB_: =%" ( goto:variable )
    if not defined %_ptrB_% ( goto:variable )
	call set "_ptrvalue_=%%%_ptrB_%%%"
    call dk_echo %LBlue% %_ptr_%%clr% %blue% = %_ptrB_% = %_ptrvalue_% %clr%
    endlocal
    goto:eof

    :variable
    set "_var_=%~1"
	call set "_value_=%%%_var_%%%"
    if not defined %~1 ( goto:undefined )
    call dk_echo %LBlue% %~1 %blue% = %_value_% %clr%
    goto:eof

    :undefined
    call dk_echo %LBlue% %~1 %blue% = %red% UNDEFINED %clr%
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
goto:eof
