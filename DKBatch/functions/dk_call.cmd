@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::######################## dk_call settings ##########################
::set "dk_call_PRINT_CALLS=1"
::set "dk_call_PRINT_ENTRY=1"
::set "dk_call_PRINT_EXIT=1"
::set "dk_call_PRINT_SCOPE=1"
::set "dk_call_STACK_TO_FILE=1"
::set "dk_call_ENTRY_TO_FILE=1"
::set "dk_call_EXIT_TO_FILE=1"
set "dk_call_IGNORE=dk_debugFunc"
::####################################################################
::# dk_call(command args)
::#
:dk_call
	if "%~1" equ "" (echo ERROR: use 'call dk_call %%0' at the top of your script to initialize dk_call. & pause & exit -1)
	
	set "arg1=%~1"
	if "%arg1:~0,1%" equ ":" (
		%dk_call% dk_notice "command = dk_call %~1"
		%dk_call% dk_error "use 'call' instead of 'dk_call' when calling :labels"
	)

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
	
	if "!dk_call_IGNORE:%__FUNC__%=!" equ "%dk_call_IGNORE%" (set "__IGNORE__=1") else (set "__IGNORE__=")
	
	set dk_allButFirstArgs=%*
	for /f "tokens=1*" %%a in ("!dk_allButFirstArgs!") do (set __ARGV__=%%b)
	
	::TODO - use dk_getFileLine to add the file line to the stack entry
	call :pushStack %*
	
	::###### Print function entry ####
	if "%dk_call_PRINT_ENTRY%" equ "1" (call :dk_call_PRINT_ENTRY)
	if "%dk_call_ENTRY_TO_FILE%" equ "1" (call :dk_call_ENTRY_TO_FILE)
	
	if %LVL% lss 1 (exit /b !errorlevel!)

	::##### Prepair ###########################################################################################
	if EXIST "%__CMND__:.cmd=%.cmd" (set __CMND__=%__CMND__:.cmd=%.cmd)
	if EXIST "%DKBATCH_FUNCTIONS_DIR_%%__CMND__:.cmd=%.cmd" (set __CMND__=%DKBATCH_FUNCTIONS_DIR_%%__CMND__:.cmd=%.cmd)
	if NOT EXIST "%__CMND__%" (
		call %DKBATCH_FUNCTIONS_DIR_%dk_source.cmd "%__CMND__%"
	)
	
	if EXIST "%__CMND__:.cmd=%.cmd" (set __CMND__=%__CMND__:.cmd=%.cmd)
	if EXIST "%DKBATCH_FUNCTIONS_DIR_%%__CMND__:.cmd=%.cmd" (set __CMND__=%DKBATCH_FUNCTIONS_DIR_%%__CMND__:.cmd=%.cmd)
	
	rem dk_call% dk_isCRLF "%__CMND__%" || %dk_call% dk_fileToCRLF "%__CMND__%"
	::###### Entry ############################################################################################
	if "%dk_call_PRINT_CALLS%" equ "1" (echo dk_call ^> %__CMND__% !__ARGV__!)
	
::	if defined dk_call_IGNORE if "X!dk_call_IGNORE:%__FUNC__%=!X" equ "X%dk_call_IGNORE%X" title DKBatch: %__FUNC__%(%__ARGV__%)

	call %__CMND__:/=\% %__ARGV__% && (
		set "__STATUS__=!errorlevel!"
		set "__BOOL__=true"
		if defined __STACK__%ENTRY% (
			call :setGlobal "__STACK__%ENTRY%" "%lblack%!__STACK__%ENTRY%! %white%status:%green%!__STATUS__!%clr%"
		)
		
		if "%dk_call_PRINT_EXIT%" equ "1" (call :dk_call_PRINT_EXIT)
		set /a LVL-=1
	) || (
		set "__STATUS__=!errorlevel!"
		set "__BOOL__=false"
		if defined __STACK__%ENTRY% (
			call :setGlobal "__STACK__%ENTRY%" "%lblack%!__STACK__%ENTRY%! %white%status:%red%!__STATUS__!%clr%"
		)
		
		rem ###### Print function exit ######
		if "%dk_call_PRINT_EXIT%" equ "1" (call :dk_call_PRINT_EXIT)
		if "%dk_call_EXIT_TO_FILE%" equ "1" (call :dk_call_EXIT_TO_FILE)
		set /a LVL-=1
	)
	
	::### NOTE: We can keep the whole stack if we comment this out.
	call :popStack

::###### Exit #############################################################################################
exit /b %__STATUS__%

::####################################################################
::# :updateIndent
::#
:updateIndent
	if "%~1" neq "" (
		set "num=%~1"
	) else (
		set "num=%LVL%"
	)
	(set pad=)
	for /l %%x in (1, 1, %num%) do (set pad=!pad!%indent%)
exit /b !errorlevel!

::####################################################################
::# :dk_call_PRINT_ENTRY
::#
:dk_call_PRINT_ENTRY
	if defined dk_call_IGNORE if "X!dk_call_IGNORE:%__FUNC__%=!X" neq "X%dk_call_IGNORE%X" (%return%)
	if "%~1" neq "" (
		set "_ent_=%~1"
	) else (
		set "_ent_=%ENTRY%"
	)
	if "%~1" neq "" (
		set "_lvl_=%~2"
	) else (
		set "_lvl_=%LVL%"
	)
	call :updateIndent %_lvl_%
	echo %pad%%_lvl_%х!__STACK__%_ent_%!
exit /b !errorlevel!

::####################################################################
::# :dk_call_PRINT_EXIT
::#
:dk_call_PRINT_EXIT
	if defined dk_call_IGNORE if "X!dk_call_IGNORE:%__FUNC__%=!X" neq "X%dk_call_IGNORE%X" (%return%)
	if "%~1" neq "" (
		set "_ent_=%~1"
	) else (
		set "_ent_=%ENTRY%"
	)
	if "%~1" neq "" (
		set "_lvl_=%~2"
	) else (
		set "_lvl_=%LVL%"
	)
	
	call :updateIndent %_lvl_%
	if "!__STATUS__!" equ "0" (set STATUS=%green%!__STATUS__!:!__BOOL__!%clr%) else (set STATUS=%red%!__STATUS__!:!__BOOL__!%clr%)
	echo %pad%  им!__STACK__%_ent_%!
exit /b !errorlevel!

::####################################################################
::# :dk_call_ENTRY_TO_FILE
::#
:dk_call_ENTRY_TO_FILE
	if defined dk_call_IGNORE if "X!dk_call_IGNORE:%__FUNC__%=!X" neq "X%dk_call_IGNORE%X" (%return%)
	if "%~1" neq "" (
		set "_ent_=%~1"
	) else (
		set "_ent_=%ENTRY%"
	)
	if "%~1" neq "" (
		set "_lvl_=%~2"
	) else (
		set "_lvl_=%LVL%"
	)
	call :updateIndent %_lvl_%
	echo %pad%%_lvl_%х!__STACK__%_ent_%!>> "%DKSCRIPT_NAME%.log"
exit /b !errorlevel!

::####################################################################
::# :dk_call_EXIT_TO_FILE
::#
:dk_call_EXIT_TO_FILE
	if defined dk_call_IGNORE if "X!dk_call_IGNORE:%__FUNC__%=!X" neq "X%dk_call_IGNORE%X" (%return%)
	if "%~1" neq "" (
		set "_ent_=%~1"
	) else (
		set "_ent_=%ENTRY%"
	)
	if "%~1" neq "" (
		set "_lvl_=%~2"
	) else (
		set "_lvl_=%LVL%"
	)
	call :updateIndent %_lvl_%
	if "!__STATUS__!" equ "0" (set STATUS=%green%!__STATUS__!:!__BOOL__!%clr%) else (set STATUS=%red%!__STATUS__!:!__BOOL__!%clr%)
	echo %pad%  им!__STACK__%_ent_%! >> "%DKSCRIPT_NAME%.log"
exit /b !errorlevel!

::####################################################################
::# :setGlobal(name value)
::#
:setGlobal
setlocal enableDelayedExpansion
	set dk_allButFirstArgs=%*
	for /f "tokens=1*" %%a in ("!dk_allButFirstArgs!") do endlocal & (set %~1=%%b)
	::(set dk.gbl.%~1=%argv%)		&:: prefix the variable name with dk.gbl. and assign a value
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
	call :setGlobal __STACK__%ENTRY%
	(set /a ENTRY-=1)
exit /b !errorlevel!

::####################################################################
::# :pushStack(file args)
::#
:pushStack
	if NOT defined LVL (set /a "LVL=0")
	if NOT defined LVL (set /a "ENTRY=0")
	(set /a LVL+=1)
	(set /a ENTRY+=1)
	call :setGlobal __STACK__%ENTRY% %*
	
	::echo %ENTRY%: !__STACK__%ENTRY%!
	if "%dk_call_STACK_TO_FILE%" equ "1" (
		echo %ENTRY%: !__STACK__%ENTRY%! >> "%DKSCRIPT_NAME%.log"
	)
exit /b !errorlevel!

::####################################################################
::# :init
::#
:init
	call :pushStack %~n0%~0 %*
	set "setlocal=setlocal EnableDelayedExpansion"
	if not defined true 	(set "true=0")
	if not defined false 	(set "false=1")
	
	::###### _SCOPE ######
	if "%dk_call_PRINT_SCOPE%" equ "1" (
		(set "_SCOPE_=DK")
		(set /a "_SCOPE_LVL_=0")
		echo SCOPE: !_SCOPE_LVL_!:!_SCOPE_!
		(set "setlocal=setlocal EnableDelayedExpansion & (set _SCOPE_=^!__FILE__^!) & (set /a _SCOPE_LVL_+=1) & echo SCOPE: ^!_SCOPE_LVL_^!:^!_SCOPE_^!")
	)

	set "dk_call=call %DKBATCH_FUNCTIONS_DIR_%dk_call.cmd"
	
	set globalize=(for /F "delims=" %%a in ('set dk.') do ^
		endlocal^
		^& call set _line_=%%a^
		^& call set %%_line_%%^
		^& call set %%_line_:dk.gbl.=%%) 2^>nul

	::set dk_time=(call echo %%time%%)

	::set endfunction=(exit /b ^^!errorlevel^^!)
	::set return=(exit /b ^^!errorlevel^^!)
	::set endfunction=(if 0 neq ^^!errorlevel^^! ^^!dk_call^^! dk_error "endfunction:ERROR:^!errorlevel^! @ ^!__FILENAME__^!.cmd") ^& (exit /b ^^!errorlevel^^!)
	set endfunction=(if "^!DE^!" neq "" %setlocal%) ^& (if 0 neq ^^!errorlevel^^! ^^!dk_call^^! dk_error "endfunction:ERROR:^!errorlevel^! @ ^!__FILENAME__^!.cmd") ^& (exit /b ^^!errorlevel^^!)
	     set return=(if 0 neq ^^!errorlevel^^! ^^!dk_call^^! dk_error "return:ERROR:^!errorlevel^! @ ^!__FILENAME__^!.cmd") ^& (exit /b ^^!errorlevel^^!)
	 set checkerror=(if 0 neq ^^!errorlevel^^! ^^!dk_call^^! dk_error "checkerror:ERROR:^!errorlevel^! @ ^!__FILENAME__^!.cmd")
	
	if NOT defined pad (set "pad=%clr%")
	if NOT defined indent (set "indent=   ")
	
	if "%dk_call_PRINT_ENTRY%" equ "1" (
		for /l %%x in (1, 1, %ENTRY%) do (
			call :dk_call_PRINT_ENTRY %%x %%x
		)
	)
	
	::###### Clear the stack log file ######
	if "%dk_call_STACK_TO_FILE%" equ "1" (
		echo( %DKSCRIPT_PATH% %DKSCRIPT_ARGS% - %date% %time%> "%DKSCRIPT_NAME%.log"
		for /l %%x in (1, 1, %ENTRY%) do (
			echo %%x: !__STACK__%%x! >> "%DKSCRIPT_NAME%.log"
		)	
	)
	
	if "%dk_call_ENTRY_TO_FILE%" equ "1" (
		for /l %%x in (1, 1, %ENTRY%) do (
			call :dk_call_ENTRY_TO_FILE %%x %%x
		)
	)
	%dk_call% dk_color

exit /b !errorlevel!



	













::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_test
exit /b !errorlevel!






rem	set "arg1=%~1"
rem	if "%arg1:~0,1%" equ ":" (
rem		for %%G in ("%arg1:~1%") do set "_file_=%%~fG.cmd"
rem		set "_label_=%~1"
rem		
rem		%dk_call% dk_callFileLabel "!_file_!" "!_label_!"
rem		%return%
rem	)