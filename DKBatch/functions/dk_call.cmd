@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::######################## dk_call settings ##########################
::set "dk_call_PRINT_CALLS=1"
::set "dk_call_PRINT_ENTRY=1"
::set "dk_call_PRINT_EXIT=1"
::set "dk_call_PRINT_SCOPE=1"
::set "dk_call_IGNORE=dk_debugFunc;dk_echo;"
::####################################################################
::# dk_call(command args)
::#
:dk_call
	if "%~1" equ "" (echo ERROR: use 'call dk_call %%0' at the top of your script to initialize dk_call. & pause & exit -1)
	
	:: don't add these functions to the callstack, just call them
	if "%~1" equ "init"					(call :%* & exit /b !errorlevel!)
	if "%~1" equ "pushStack"			(call :%* & exit /b !errorlevel!)
	if "%~1" equ "popStack"				(call :%* & exit /b !errorlevel!)
	if "%~1" equ "setGlobal" 			(call :%* & exit /b !errorlevel!)
	if "%~1" equ "setReturn" 			(call :%* & exit /b !errorlevel!)
	if "%~1" equ "printStackVariables"	(call :%* & exit /b !errorlevel!)

	::###### Stack Variables ######
	(set __CMND__=%~1)
	(set __CMND__=!__CMND__:::=/!)		&:: Replace :: with /
	(set __FILE__=%~dpnx1)
	(set __FILE__=%__FILE__:\=/%)
	(set __FILENAME__=%~nx1)
	(set __FUNC__=%~n1)
	
	set dk_allButFirstArgs=%*
	if defined dk_allButFirstArgs (set __ARGV__=!dk_allButFirstArgs:*%1=!)
	::%dk_call% dk_allButFirstArgs %*
	
	::TODO - use dk_getFileLine to add the file line to the stack entry
	call :pushStack %*

	::###### Print function entry ####
	if "%dk_call_PRINT_ENTRY%" equ "1" (call :dk_call_PRINT_ENTRY)

	if %LVL% lss 1 (exit /b !errorlevel!)

::##### Prepair ###########################################################################################
	if exist "%__CMND__:.cmd=%.cmd" (set __CMND__=%__CMND__:.cmd=%.cmd)
	if exist "%DKBATCH_FUNCTIONS_DIR_%%__CMND__:.cmd=%.cmd" (set __CMND__=%DKBATCH_FUNCTIONS_DIR_%%__CMND__:.cmd=%.cmd)
	if not exist "%__CMND__%" (
		call dk_source "%__CMND__%"
	)
	
	if exist "%__CMND__:.cmd=%.cmd" (set __CMND__=%__CMND__:.cmd=%.cmd)
	if exist "%DKBATCH_FUNCTIONS_DIR_%%__CMND__:.cmd=%.cmd" (set __CMND__=%DKBATCH_FUNCTIONS_DIR_%%__CMND__:.cmd=%.cmd)
	
::###### Entry ############################################################################################
	if "%dk_call_PRINT_CALLS%" equ "1" (echo dk_call ^> %__CMND__% !__ARGV__!)

	call %__CMND__:/=\% %__ARGV__% && (
		set "LAST_STATUS=!errorlevel!"
		set "LAST_BOOL=0"
	) || (set "LAST_STATUS=!errorlevel!" & set "LAST_BOOL=1")
::###### Exit #############################################################################################

	::###### Print function exit ######
	if "%dk_call_PRINT_EXIT%" equ "1" (call :dk_call_PRINT_EXIT)

	call :popStack
exit /b %LAST_STATUS%




::####################################################################
::# :init
::#
:init
	set "setlocal=setlocal EnableDelayedExpansion
	::###### _SCOPE ######
	if "%dk_call_PRINT_SCOPE%" equ "1" (
		(set "_SCOPE_=DK")
		(set /a "_SCOPE_LVL_=0")
		echo SCOPE: !_SCOPE_LVL_!:!_SCOPE_!
		(set "setlocal=setlocal EnableDelayedExpansion & (set _SCOPE_=^!__FUNC__^!) & (set /a _SCOPE_LVL_+=1) & echo SCOPE: ^!_SCOPE_LVL_^!:^!_SCOPE_^!")
		rem set "setlocal=setlocal EnableDelayedExpansion & (set _SCOPE_=^!_SCOPE_^!-^!__FUNC__^!) & echo SCOPE: ^!_SCOPE_^!"
	)

	set "dk_call=call dk_call"
	
	set globalize=(for /F "delims=" %%a in ('set dk.') do ^
		endlocal^
		^& call set _line_=%%a^
		^& call set %%_line_%%^
		^& call set %%_line_:dk.gbl.=%%) 2^>nul

	::set dk_time=(call echo %%time%%)
	::set checkError=(if "!errorlevel!" neq "0" %dk_call% dk_error "!errorlevel! ERROR: in !__FILE__! !___FUNC___![!__ARGV__!]")

::	set checkError=(if "!errorlevel!" neq "0" %dk_call% dk_error "!errorlevel! ERROR: in !__FILE__! !___FUNC___![!__ARGV__!]")	

::	set endfunction=exit /b !errorlevel!)
::	set return=exit /b !errorlevel!)
	
	set endfunction=(call dk_return^& exit /b ^!errorlevel^!)
	set return=(call dk_return^& exit /b ^!errorlevel^!)

	if not defined ESC (set "ESC=")
	if not defined clr (set "clr=%ESC%[0m")
	set /a "LVL=0"
	set "pad=%clr%"
	set "padB=      "
	set "indent=        "
exit /b !errorlevel!

::####################################################################
::# :updateIndent
::#
:updateIndent
	(set pad=)
	(set padB=)
	for /l %%x in (1, 1, %LVL%) do (set pad=!pad!%indent%)
	for /l %%x in (1, 1, %LVL%) do (set padB=!padB!%indent%)
exit /b !errorlevel!

::####################################################################
::# :dk_call_PRINT_ENTRY
::#
:dk_call_PRINT_ENTRY
	if defined dk_call_IGNORE if "X!dk_call_IGNORE:%__FUNC__%=!X" neq "X%dk_call_IGNORE%X" (%endfunction%)
	call :updateIndent

::	for /f "tokens=4 delims= " %%G in ('chcp') do set _codepage_=%%G
::	if "%_codepage_%" neq "65001" chcp 65001>nul
::	echo %pad% !__FUNC__!(!__ARGV__!)

	echo %pad%х !__FUNC__!(!__ARGV__!)

::	echo %pad%%DEC%mq^> %ASCII%!__FUNC__!(!__ARGV__!)
exit /b !errorlevel!

::####################################################################
::# :dk_call_PRINT_EXIT
::#
:dk_call_PRINT_EXIT
	if defined dk_call_IGNORE if "X!dk_call_IGNORE:%__FUNC__%=!X" neq "X%dk_call_IGNORE%X" (%endfunction%)
	call :updateIndent
	::echo %pad% !__FUNC__!(!__ARGV__!)
	::echo %pad%
	echo %pad%им !__FUNC__!(!__ARGV__!)
	echo %pad%
::	echo %pad%%DEC%lqq %ASCII%!__FUNC__!(!__ARGV__!)
::	echo %pad%v
exit /b !errorlevel!

::####################################################################
::# :printConstantVariables
::#
:printConstantVariables
	call :updateIndent
	if defined dk_call			(echo %padB% dk_call		= %dk_call%)
	if defined indent			(echo %padB% indent			= %indent%)
	if defined pad				(echo %padB% pad			= %pad%)
exit /b !errorlevel!

::####################################################################
::# :printStackVariables
::#
:printStackVariables
	call :updateIndent
	if defined LVL				(echo %padB% LVL  = %LVL%)
	if defined __STACK__%LVL%	(echo %padB% __STACK__%LVL% = !__STACK__%LVL%!)
exit /b !errorlevel!

::####################################################################
::# :printParentStackVariables
::#
:printParentStackVariables
	(set /a PLVL=LVL-1)
	call :updateIndent	
	if defined PLVL				(echo %padB% PLVL  = %PLVL%)
	if defined __STACK__%PLVL% 	(echo %padB% __STACK__%PLVL% = !__STACK__%PLVL%!)
exit /b !errorlevel!

::####################################################################
::# :setReturn
::#
:setReturn name value
	set argv=%*
	if defined argv 			(set argv=!argv:*%1 =!)
	(set %~1=%argv%)
	(set dk.rtn.%~1=%argv%)		&:: prefix the variable name with dk.rtn. and assign a value
exit /b !errorlevel!

::####################################################################
::# :popStack
::#
:popStack
	call :setGlobal __STACK__%LVL%
	(set /a LVL-=1)
exit /b !errorlevel!

::####################################################################
::# :pushStack
::#
:pushStack file args
	(set /a LVL+=1)
	call :setGlobal __STACK__%LVL% %*
	::call :setGlobal __STACK__%LVL% %time% %*
exit /b !errorlevel!

::####################################################################
::# :setGlobal(name value)
::#
:setGlobal
	::%dk_call% dk_allButFirstArgs %*
	set argv=%*
	if defined argv (set argv=!argv:*%1=!)
	(set %~1=%argv%)
	(set dk.gbl.%~1=%argv%)		&:: prefix the variable name with dk.gbl. and assign a value
exit /b !errorlevel!





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_test
%endfunction%
