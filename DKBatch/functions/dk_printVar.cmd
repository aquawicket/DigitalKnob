@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

call dk_source dk_isVariableName
call dk_source dk_isAlphanumeric
::################################################################################
::# dk_printVar(variable)
::#
::#

:dk_printVar
    call dk_debugFunc 1

	if not defined ENABLE_dk_printVar set "ENABLE_dk_printVar=1"
    if "%ENABLE_dk_printVar%" neq "1" goto:eof
	
	call dk_isVariableName "%~1" || goto:eof
	
	
    :array
		set "arry=%~1"
		if not defined %arry%[0] goto:pointer
		set /A "n=0"
		setlocal
		:loop1
			if not defined %arry%[%n%] goto:eof
			if "!!" equ "" call dk_echo "%cyan% ARRAY:%arry%[%n%] =%blue% !%arry%[%n%]! %clr%"
			if "!!" neq "" call dk_echo "%cyan% ARRAY:%arry%[%n%] =%blue% %%%arry%[%n%]%% %clr%"
			set /A n+=1
			goto :loop1 
    endlocal
    
    :pointer
		if not defined %~1 goto:undefined
		setlocal
		set "_ptr_=%~1"
		if "!!" neq "" call dk_isAlphanumeric "%%%_ptr_%%%" || goto:variable
		if "!!" equ "" call dk_isAlphanumeric "!_ptr_!" || goto:variable
		if "!!" neq "" call set "_ptrB_=%%%_ptr_%%%"
		if "!!" equ "" set "_ptrB_=!_ptr_!"
		::call dk_isAlphanumeric "%%%_ptrB_%%%" || goto:variable
		if not defined "%_ptrB_%" goto:variable
		if "!!" neq "" call set "_ptrvalue_=%%%_ptrB_%%%"
		if "!!" equ "" set "_ptrvalue_=!_ptrB_!"
		call dk_echo "%cyan% POINTER:%_ptr_% = %_ptrB_% =%blue% %_ptrvalue_% %clr%"
		endlocal
    goto:eof

    :variable
		setlocal
		set "_var_=%~1"
		if "!!" neq "" call set "_value_=%%%_var_%%%"			&:: FIXME: remove the need for call here
		if "!!" equ "" set "_value_=!%_var_%!"
		call dk_echo "%cyan% VARIABLE:%~1 =%blue% %_value_% %clr%"
		endlocal
    goto:eof

    :undefined
		call dk_echo "%cyan% %~1 =%red% UNDEFINED %clr%"
goto:eof






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc

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
