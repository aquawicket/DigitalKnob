@echo off&::###### DK.cmd #########################################################################################################################
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################

::if NOT defined dk_set_PRINT_VARIABLE (set "dk_set_PRINT_VARIABLE=0")
::################################################################################
::# dk_set(name, value...)
::#
::#
:dk_set
%setlocal%
	%dk_call% dk_debugFunc 2 99

	set "_VARIABLE_=%~1"
	
	set dk_allButFirstArgs=%*
	for /f "tokens=1*" %%a in ("!dk_allButFirstArgs!") do (
		set _VALUE_=%%b
	)
	
	endlocal & (
		set %_VARIABLE_%=%_VALUE_%
	)

	if "%dk_set_PRINT_VARIABLE%" equ "1" (
		%dk_call% dk_printVar %_VARIABLE_%
	)
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	             set TestA=12345
	%dk_call% dk_set TestB 12345
	if "%TestA%" equ "%TestB%" (%dk_call% dk_success "%TestA% == %TestB% passed") else (%dk_call% dk_error "%TestA% == %TestB% failed")
	
	            set "TestA=12345"
	%dk_call% dk_set TestB 12345
	if "%TestA%" equ "%TestB%" (%dk_call% dk_success "%TestA% == %TestB% passed") else (%dk_call% dk_error "%TestA% == %TestB% failed")
	
	             set TestA="12345"
	%dk_call% dk_set TestB "12345"
	if "%TestA%" equ "%TestB%" (%dk_call% dk_success "%TestA% == %TestB% passed") else (%dk_call% dk_error "%TestA% == %TestB% failed")
	
		         set TestA=1 2 3 4 5
	%dk_call% dk_set TestB 1 2 3 4 5
	if "%TestA%" equ "%TestB%" (%dk_call% dk_success "%TestA% == %TestB% passed") else (%dk_call% dk_error "%TestA% == %TestB% failed")

			    set "TestA=1 2 3 4 5"
	%dk_call% dk_set TestB 1 2 3 4 5
	if "%TestA%" equ "%TestB%" (%dk_call% dk_success "%TestA% == %TestB% passed") else (%dk_call% dk_error "%TestA% == %TestB% failed")
	
				 set TestA="1 2 3 4 5"
	%dk_call% dk_set TestB "1 2 3 4 5"
	if [%TestA%] equ [%TestB%] (%dk_call% dk_success %TestA%==%TestB% passed) else (%dk_call% dk_echo %TestA%==%TestB% failed)
	
			     set TestA="1 2 3" a b c
	%dk_call% dk_set TestB "1 2 3" a b c
				 set "unset=!TestA:%TestB%=!"
				 if "%unset%" equ "" (echo SUCCESS: [%TestA%] == [%TestB%] passed) else (echo ERROR: [%TestA%] == [%TestB%] failed)
   
                 set TestA=word
	%dk_call% dk_set TestB word
                 set "unset=!TestA:%TestB%=!"
				 if "%unset%" equ "" (echo SUCCESS: [%TestA%] == [%TestB%] passed) else (echo ERROR: [%TestA%] == [%TestB%] failed)
	
::  %dk_call% dk_set myVar "words in quotes"
::	echo myVar = %myVar%
::	%dk_call% dk_echo "myVar = %myVar%"
	
::	%dk_call% dk_set myVar words without quotes
::	echo myVar = %myVar%
::	%dk_call% dk_echo "myVar = %myVar%"

::	%dk_call% dk_set myVarB "dk_info('test dk_info message')"
::	echo myVar = %myVar%
::	%dk_call% dk_echo "myVarB = %myVarB%"
	
	%dk_call% dk_set CMAKE "%USERPROFILE:\=/%/DigitalKnob/DKTools/cmake-3.29.5-windows-x86_64"
	echo CMAKE = %CMAKE%
	
	%dk_call% dk_set TEST_VAR "abc" "123" "d e f" "4 5 6"
	echo TEST_VAR = %TEST_VAR%
%endfunction%
