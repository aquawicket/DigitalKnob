@rem shebang
@echo off&rem ###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
	setlocal enableDelayedExpansion
	if NOT EXIST "%DK.cmd%" (set "DK.cmd=%USERPROFILE%\Digital Knob\Development\DKBatch\functions\DK.cmd")
	if NOT DEFINED DK.cmd (for /F "delims=" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
	if NOT EXIST "!DK.cmd!" (
		start "" /b /wait /min "curl.exe" --silent --location --create-dirs --output "!DK.cmd!" http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DK.cmd)
	call "!DK.cmd:/=\!" "%%~0" %%*
	exit /b %errorlevel%
)
rem #################################################################################################################################################


rem ################## dk_printVar SETTINGS ####################
rem if NOT defined dk_printVar_ENABLE (set "dk_printVar_ENABLE=1")
rem if "%dk_printVar_ENABLE%" neq "1" (%return%)
rem ################################################################################
rem # dk_printVar(variable)
rem #
rem #
:dk_printVar
%setlocal%
   
    rem %dk_call% dk_isVariableName "%~1" || %return%
   
    :array
		if NOT defined %~1[0] goto pointer
        set /a "n=0"
        :loop1
            if NOT defined %~1[%n%] %return%
			
			rem delayed expansion OFF
            if "!!" neq "" %dk_call% dk_echo "%cyan% ARRAY:%~1[%n%] =%blue% %%%~1[%n%]%% %clr%"
			
			rem delayed expansion ON
			if "!!" equ "" %dk_call% dk_echo "%cyan% ARRAY:%~1[%n%] =%blue% !%~1[%n%]! %clr%"

            set /a n+=1
        goto :loop1
	%return%

    :pointer
        if NOT defined %~1 goto undefined

        rem delayed expansion OFF
        if "!!" neq "" %dk_call% dk_isVariableName "%%%~1%%" || goto variable
        if "!!" neq "" call set "_ptrB_=%%%~1%%"
		if "!!" neq "" %dk_call% dk_defined "%%%~1%%" || goto variable
		if "!!" neq "" %dk_call% dk_echo "%cyan% POINTER:%~1 = %blue%%_ptrB_% = %%%_ptrB_%%% %clr%"

		rem delayed expansion ON
        if "!!" equ "" %dk_call% dk_isVariableName "!%~1!" || goto variable
        if "!!" equ "" set "_ptrB_=!%~1!"
		if "!!" equ "" if NOT defined !%~1! goto variable
		if "!!" equ "" %dk_call% dk_echo "%cyan% POINTER:%~1 = %blue%%_ptrB_% = !%_ptrB_%! %clr%"
    %return%

    :variable	
		rem delayed expansion OFF
		if "!!" neq "" %dk_call% dk_echo "%cyan% VARIABLE:%~1 =%blue% %%%~1%% %clr%"
		
		rem delayed expansion ON
		if "!!" equ "" %dk_call% dk_echo "%cyan% VARIABLE:%~1 =%blue% !%~1! %clr%"
    %return%

    :undefined
        %dk_call% dk_echo "%cyan% %~1 =%red% UNDEFINED %clr%"
	%return%
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%


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

    rem set "myVarE"
    %dk_call% dk_printVar myVarE
%endfunction%
