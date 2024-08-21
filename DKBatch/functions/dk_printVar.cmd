@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::################################################################################
::# dk_printVar(variable)
::#
::#

:dk_printVar
    call dk_debugFunc 1

	if not defined ENABLE_dk_printVar set "ENABLE_dk_printVar=1"
    if "%ENABLE_dk_printVar%" neq "1" goto:eof
	
	%dk_call% dk_isVariableName "%~1" || goto:eof
	
    :array
		set "arry=%~1"
		if not defined %arry%[0] goto:pointer
		set /A "n=0"
		setlocal
		:loop1
			if not defined %arry%[%n%] goto:eof
			if "!DE!" equ "" %dk_call% dk_echo "%cyan% ARRAY:%arry%[%n%] =%blue% !%arry%[%n%]! %clr%"
			if "!DE!" neq "" %dk_call% dk_echo "%cyan% ARRAY:%arry%[%n%] =%blue% %%%arry%[%n%]%% %clr%"
			set /A n+=1
			goto :loop1 
    endlocal
    
    :pointer
		if not defined %~1 goto:undefined
		setlocal
		set "_ptr_=%~1"
		if "!DE!" neq "" %dk_call% dk_isAlphanumeric "%%%_ptr_%%%" || goto:variable
		if "!DE!" equ "" %dk_call% dk_isAlphanumeric "!_ptr_!" || goto:variable
		if "!DE!" neq "" call set "_ptrB_=%%%_ptr_%%%"
		if "!DE!" equ "" set "_ptrB_=!_ptr_!"
		::%dk_call% dk_isAlphanumeric "%%%_ptrB_%%%" || goto:variable
		if not defined "%_ptrB_%" goto:variable
		if "!DE!" neq "" call set "_ptrvalue_=%%%_ptrB_%%%"
		if "!DE!" equ "" set "_ptrvalue_=!_ptrB_!"
		%dk_call% dk_echo "%cyan% POINTER:%_ptr_% = %_ptrB_% =%blue% %_ptrvalue_% %clr%"
		endlocal
    goto:eof

    :variable
		setlocal
		set "_var_=%~1"
		if "!DE!" neq "" call set "_value_=%%%_var_%%%"			&:: FIXME: remove the need for call here
		if "!DE!" equ "" set "_value_=!%_var_%!"
		%dk_call% dk_echo "%cyan% VARIABLE:%~1 =%blue% %_value_% %clr%"
		endlocal
    goto:eof

    :undefined
		%dk_call% dk_echo "%cyan% %~1 =%red% UNDEFINED %clr%"
goto:eof






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc

    set "myVarA=This is a variable"
    %dk_call% dk_printVar myVarA

    set "myVarB=varB content"
    %dk_call% dk_printVar myVarB

    set "myVarC=myVarB"
    %dk_call% dk_printVar myVarC

    set "myVarD[0]=This is an array, element 0"
    set "myVarD[1]=This is an array, element 1"
    set "myVarD[2]=This is an array, element 2"
    %dk_call% dk_printVar myVarD
    %dk_call% dk_printVar myVarD[1]

    set "myVarE=dk_load('%DKIMPORTS_DIR%/notepadpp/DKMAKE.cmake')"
    %dk_call% dk_printVar myVarE

    ::set "myVarF"
    %dk_call% dk_printVar myVarF
goto:eof
