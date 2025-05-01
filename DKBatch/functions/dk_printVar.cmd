@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::################## dk_printVar SETTINGS ####################
if not defined dk_printVar_ENABLE (set "dk_printVar_ENABLE=1")
if "%dk_printVar_ENABLE%" neq "1" (%return%)
::################################################################################
::# dk_printVar(variable)
::#
::#
:dk_printVar
%setlocal%
    ::%dk_call% dk_debugFunc 1
    
    %dk_call% dk_isVariableName "%~1" || dk_return
    
    :array
		if not defined %~1[0] goto pointer
        set /a "n=0"
        :loop1
            if not defined %~1[%n%] dk_return
			
			:: delayed expansion OFF
            if "!DE!" neq "" %dk_call% dk_echo "%cyan% ARRAY:%~1[%n%] =%blue% %%%~1[%n%]%% %clr%"
			
			:: delayed expansion ON
			if "!DE!" equ "" %dk_call% dk_echo "%cyan% ARRAY:%~1[%n%] =%blue% !%~1[%n%]! %clr%"

            set /a n+=1
        goto :loop1 
	dk_return

    :pointer
        if not defined %~1 goto undefined

        :: delayed expansion OFF
        if "!DE!" neq "" %dk_call% dk_isVariableName "%%%~1%%" || goto variable
        if "!DE!" neq "" call set "_ptrB_=%%%~1%%"
		if "!DE!" neq "" %dk_call% dk_defined "%%%~1%%" || goto variable
		if "!DE!" neq "" %dk_call% dk_echo "%cyan% POINTER:%~1 = %_ptrB_% =%blue% %%%_ptrB_%%% %clr%"

		:: delayed expansion ON
        if "!DE!" equ "" %dk_call% dk_isVariableName "!%~1!" || goto variable
        if "!DE!" equ "" set "_ptrB_=!%~1!"
		if "!DE!" equ "" if not defined !%~1! goto variable
		if "!DE!" equ "" %dk_call% dk_echo "%cyan% POINTER:%~1 = %_ptrB_% =%blue% !%_ptrB_%! %clr%"
    dk_return

    :variable	
		:: delayed expansion OFF
		if "!DE!" neq "" %dk_call% dk_echo "%cyan% VARIABLE:%~1 =%blue% %%%~1%% %clr%"
		
		:: delayed expansion ON
		if "!DE!" equ "" %dk_call% dk_echo "%cyan% VARIABLE:%~1 =%blue% !%~1! %clr%"
    dk_return

    :undefined
        %dk_call% dk_echo "%cyan% %~1 =%red% UNDEFINED %clr%"
	dk_return
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0


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

    ::set "myVarE"
    %dk_call% dk_printVar myVarE
%endfunction%
