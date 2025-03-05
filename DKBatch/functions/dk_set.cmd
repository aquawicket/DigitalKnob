@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::################################################################################
::# dk_set(name, value...)
::#
::#
:dk_set
setlocal
::	%dk_call% dk_debugFunc 2 99

	echo:
	set _name_=%~1
	echo _name_ = %_name_%
	
	set _args_=%*
	set _args_=!_args_:%~1 =!
	echo _args_ = %_args_%
	
	set /a argc=0
	for %%Z in (%_args_%) do (
		set /a argc+=1
	)
	if %argc%==1 (
		for %%Z in (%_args_%) do set _args_=%%~Z
	)
	echo argc = %argc%
	::if [%_args_:~-1%"]==["] set "_args_=%_args_:~0,-1%"
	
	echo _args_ = %_args_%
	
	endlocal & (set %~1=%_args_%)
	echo %~1 = !%~1!
	
	::DEBUG
::    %dk_call% dk_printVar %~1
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST 
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_set myVar word
	echo myVar = %myVar%
    ::%dk_call% dk_echo "myVar = %myVar%"
	
    %dk_call% dk_set myVar "words in quotes"
	echo myVar = %myVar%
    ::%dk_call% dk_echo "myVar = %myVar%"
	
	%dk_call% dk_set myVar words without quotes
	echo myVar = %myVar%
    ::%dk_call% dk_echo "myVar = %myVar%"
	
	
	
	%dk_call% dk_set myVarB "dk_info('test dk_info message')"
	echo myVar = %myVar%
	::%dk_call% dk_echo "myVarB = %myVarB%"
%endfunction%
