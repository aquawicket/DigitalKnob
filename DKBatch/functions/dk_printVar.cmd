@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_printVar(variable)
::#
::#

:dk_printVar
    ::call dk_debugFunc 1
 setlocal
 ::setlocal enableDelayedExpansion
 ::setlocal disableDelayedExpansion
 ::if "!DE!" equ "" (echo delayed expansion ON) else (echo delayed expansion OFF)
	
    if not defined ENABLE_dk_printVar set "ENABLE_dk_printVar=1"
    if "%ENABLE_dk_printVar%" neq "1" %return%
    
    %dk_call% dk_isVariableName "%~1" || %return%
    
    :array
		if not defined %~1[0] goto:pointer
        set /a "n=0"
        :loop1
            if not defined %~1[%n%] %return%
			
			:: delayed expansion OFF
            if "!DE!" neq "" %dk_call% dk_echo "%cyan% ARRAY:%~1[%n%] =%blue% %%%~1[%n%]%% %clr%"
			
			:: delayed expansion ON
			if "!DE!" equ "" %dk_call% dk_echo "%cyan% ARRAY:%~1[%n%] =%blue% !%~1[%n%]! %clr%"

            set /A n+=1
        goto :loop1 
	%return%

    :pointer
        if not defined %~1 goto:undefined

        :: delayed expansion OFF
        if "!DE!" neq "" %dk_call% dk_isVariableName "%%%~1%%" || goto:variable
        if "!DE!" neq "" call set "_ptrB_=%%%~1%%"
		if "!DE!" neq "" %dk_call% dk_defined "%%%~1%%" || goto:variable
		if "!DE!" neq "" %dk_call% dk_echo "%cyan% POINTER:%~1 = %_ptrB_% =%blue% %%%_ptrB_%%% %clr%"

		:: delayed expansion ON
        if "!DE!" equ "" %dk_call% dk_isVariableName "!%~1!" || goto:variable
        if "!DE!" equ "" set "_ptrB_=!%~1!"
		if "!DE!" equ "" if not defined !%~1! goto:variable
		if "!DE!" equ "" %dk_call% dk_echo "%cyan% POINTER:%~1 = %_ptrB_% =%blue% !%_ptrB_%! %clr%"
    %return%

    :variable	
		:: delayed expansion OFF
		if "!DE!" neq "" %dk_call% dk_echo "%cyan% VARIABLE:%~1 =%blue% %%%~1%% %clr%"
		
		:: delayed expansion ON
		if "!DE!" equ "" %dk_call% dk_echo "%cyan% VARIABLE:%~1 =%blue% !%~1! %clr%"
    %return%

    :undefined
        %dk_call% dk_echo "%cyan% %~1 =%red% UNDEFINED %clr%"
	%return%
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
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
