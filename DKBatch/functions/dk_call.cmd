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


rem ######################## dk_call settings ############################
rem if NOT DEFINED dk_call_HANDLE_ENTRY 	(set "dk_call_HANDLE_ENTRY=1")
rem if NOT DEFINED dk_call_HANDLE 			(set "dk_call_HANDLE=EXIT=1")
rem if NOT DEFINED dk_call_PRINT_CALLS 		(set "dk_call_PRINT_CALLS=1")
rem if NOT DEFINED dk_call_PRINT_ENTRY 		(set "dk_call_PRINT_ENTRY=1")
rem if NOT DEFINED dk_call_PRINT_EXIT 		(set "dk_call_PRINT_EXIT=1")
rem if NOT DEFINED dk_call_PRINT_SCOPE 		(set "dk_call_PRINT_SCOPE=1")
rem if NOT DEFINED dk_call_STACK_TO_FILE	(set "dk_call_STACK_TO_FILE=1")
rem if NOT DEFINED dk_call_ENTRY_TO_FILE	(set "dk_call_ENTRY_TO_FILE=1")
rem if NOT DEFINED dk_call_PIPE_ENTRY 		(set "dk_call_PIPE_ENTRY=1")
rem if NOT DEFINED dk_call_PIPE 			(set "dk_call_PIPE=EXIT=1")
rem if NOT DEFINED dk_call_EXIT_TO_FILE 	(set "dk_call_EXIT_TO_FILE=1")
rem ####################################################################
rem # dk_call(command args)
rem #
:dk_call
	if "%~1" equ "" (echo ERROR: use 'call dk_call %%0' at the top of your script to initialize dk_call. & pause & exit -1)
	
	set "arg1=%~1"
	if "%arg1:~0,1%" equ ":" (
		%dk_call% dk_notice "command = dk_call %~1"
		%dk_call% dk_error "use 'call' instead of 'dk_call' when calling :labels"
	)

	rem don't add these functions to the callstack, just call them
	if /i "%~1" equ "init"					(call :%* & exit /b !errorlevel!)
	if /i "%~1" equ "pushStack"				(call :%* & exit /b !errorlevel!)
	if /i "%~1" equ "popStack"				(call :%* & exit /b !errorlevel!)
	if /i "%~1" equ "setGlobal" 			(call :%* & exit /b !errorlevel!)
	if /i "%~1" equ "setReturn" 			(call :%* & exit /b !errorlevel!)
	if /i "%~1" equ "printStackVariables"	(call :%* & exit /b !errorlevel!)
	if /i "%~1" equ "endfunction_callback"	(call :%* & exit /b !errorlevel!)

	rem ###### Stack Variables ######
	(set __CMND__=%~1)							
	(call set __CMND__=%%__CMND__:::=/%%)		&rem Replace :: with /
	rem (set __FILE__=%~dpnx1)
	(set __FILE__=%~f1)
	(set __FILE__=%__FILE__:\=/%)
	(set __FILENAME__=%~nx1)
	(set __FUNC__=%~n1)
	
	if /i "!dk_call_IGNORE:%__FUNC__%=!" equ "%dk_call_IGNORE%" (set "__IGNORE__=1") else (set "__IGNORE__=")
	
	set dk_allButFirstArgs=%*
	for /f "tokens=1*" %%a in ("!dk_allButFirstArgs!") do (set __ARGV__=%%b)
	
	rem TODO - use dk_getFileLine to add the file line to the stack entry
	call :pushStack %*
	
	rem ###### Print function entry ####
rem if "%dk_call_PIPE_ENTRY%" equ "1" 		(call :dk_call_HANDLE_ENTRY)
rem if "%dk_call_PRINT_ENTRY%" equ "1" 		(call :dk_call_HANDLE_ENTRY)
rem if "%dk_call_ENTRY_TO_FILE%" equ "1"	(call :dk_call_HANDLE_ENTRY)
	if "%dk_call_HANDLE_ENTRY%" gtr "0" 	(call :dk_call_HANDLE_ENTRY)
	
	if %LVL% lss 1 (exit /b !errorlevel!)

	rem ##### Prepair ###########################################################################################
rem
rem		If the command is a fullpath, we can just check that it exists. and run it.
rem		
rem		If however, it is not a full path, i.e. function name or executbale name, we need to determine what we 
rem		have, where to find it, and how to run it.
rem
rem		Our first clue is an extension. 
rem		.exe indicates either a 3rdParty plugin or a System executable. The path to the .exe is stored in a variable
rem 	named after the executable. Example: %dk_call% curl.exe --version stores the path to curl.exe in %curl.exe%.
rem 	so step .
rem			1. Check if the Command variable is defined and contains a valid path.
rem			2. If not, check DKIMPORTS for a DKINSTALL.cmd for that executable.  curl.exe = DKIMPORTS_DIR/curl.exe/DKINSTALL.cmd
rem				or DKIMPORTS_DIR/curl/DKINSTALL.cmd. Running that should obtain the curl.exe variable to use.
rem			3. If the executable is NOT a plugin in DKIMPORTS, simpily search for the file to store in the variable
rem 			and proceed to run the command 
rem
rem		If the extension is .cmd, .bat or there is NO extension, we will check DKBATCH_FUNCTIONS_DIR for a match.
rem			1. Check if the command matches a function in DKBATCH_FUNCTIONS_DIR. 	
	rem ### Search for program in 3rdParty/_DKIMPORTS
	if NOT EXIST "%__CMND__%" (
		if EXIST "%DKIMPORTS_DIR%/%__CMND__%/DKINSTALL.cmd" (
			if not defined %__CMND__% (
				rem echo %__CMND__% is NOT DEFINED
				call "%DKIMPORTS_DIR%/%__CMND__%/DKINSTALL.cmd"
			)
			if not defined %__CMND__% (
				echo FAILED TO DEFINE %__CMND__%
				exit /b 1
			) 			
			if NOT EXIST "!%__CMND__%!" (
				echo ERROR: !%__CMND__%! NOT FOUND
				exit /b 1
			)

			set __CMND__=!%__CMND__:/=\%!
			if NOT EXIST "!__CMND__!" (
				echo ERROR: !__CMND__! NOT FOUND
				exit /b 1
			)
		
			echo %blue% dk_call PLUGIN: !__CMND__:/=\! %__ARGV__% %clr%
		)
	)

	rem ### Search for function in DKBATCH_FUNCTIONS_DIR_
	if NOT EXIST "%__CMND__%" (
		if EXIST "%__CMND__:.cmd=%.cmd"								(set __CMND__=%__CMND__:.cmd=%.cmd)
		if EXIST "%DKBATCH_FUNCTIONS_DIR_%%__CMND__:.cmd=%.cmd"		(set __CMND__=%DKBATCH_FUNCTIONS_DIR_%%__CMND__:.cmd=%.cmd)
	)

	rem ### Search for executable
rem	if NOT EXIST "%__CMND__%" (
rem		call dk_findFile %__CMND__%
rem		if EXIST "!dk_findFile!" (
rem			set "__CMND__=!dk_findFile!"
rem		)
rem	)

	rem ### download function if missing
 	if NOT EXIST "%__CMND__%" (
		call %DKBATCH_FUNCTIONS_DIR_%dk_source.cmd "%__CMND__%"
		if EXIST "%__CMND__:.cmd=%.cmd"								(set __CMND__=%__CMND__:.cmd=%.cmd)
		if EXIST "%DKBATCH_FUNCTIONS_DIR_%%__CMND__:.cmd=%.cmd"		(set __CMND__=%DKBATCH_FUNCTIONS_DIR_%%__CMND__:.cmd=%.cmd)
	)
	
rem dk_call% dk_isCRLF "%__CMND__%" || %dk_call% dk_fileToCRLF "%__CMND__%"
	rem ###### Entry ############################################################################################
	if "%dk_call_PRINT_CALLS%" equ "1" (echo dk_call ^> %__CMND__% !__ARGV__!)
	
rem	if defined dk_call_IGNORE if /i "X!dk_call_IGNORE:%__FUNC__%=!X" equ "X%dk_call_IGNORE%X" title DKBatch: %__FUNC__%(%__ARGV__%)
rem	call %DKBATCH_FUNCTIONS_DIR_%dk_isCRLF "%__CMND__%" || call %DKBATCH_FUNCTIONS_DIR_%dk_fileToCRLF "%__CMND__%"
	
	call "%__CMND__:/=\%" %__ARGV__% && (
		set "__STATUS__=!errorlevel!"
		set "__BOOL__=true"
		if defined __STACK__%ENTRY% (
			call :setGlobal "__STACK__%ENTRY%" %lblack%!__STACK__%ENTRY%! %white%status:%green%!__STATUS__!%clr%
		)
		
		rem ###### Print function exit ######
rem 	if "%dk_call_PIPE_EXIT%" equ "1" (call :dk_call_PIPE_EXIT)
rem 	if "%dk_call_PRINT_EXIT%" equ "1" (call :dk_call_PRINT_EXIT)
rem 	if "%dk_call_EXIT_TO_FILE%" equ "1" (call :dk_call_EXIT_TO_FILE)
		if "%dk_call_HANDLE_EXIT%" gtr "0" (call :dk_call_HANDLE_EXIT)
		
		set /a LVL-=1
	) || (
		set "__STATUS__=!errorlevel!"
		set "__BOOL__=false"
		if defined __STACK__%ENTRY% (
			call :setGlobal "__STACK__%ENTRY%" %lblack%!__STACK__%ENTRY%! %white%status:%red%!__STATUS__!%clr%
		)
		
		rem ###### Print function exit ######
rem 	if "%dk_call_PIPE_EXIT%" equ "1" (call :dk_call_PIPE_EXIT)
rem 	if "%dk_call_PRINT_EXIT%" equ "1" (call :dk_call_PRINT_EXIT)
rem 	if "%dk_call_EXIT_TO_FILE%" equ "1" (call :dk_call_EXIT_TO_FILE)
		if "%dk_call_HANDLE_EXIT%" gtr "0" (call :dk_call_HANDLE_EXIT)
	)

	rem ### NOTE: We can keep the whole stack if we comment this out.
	call :popStack

rem ###### Exit #############################################################################################
exit /b %__STATUS__%

rem ####################################################################
rem # :updateIndent
rem #
:updateIndent
	if "%~1" neq "" (
		set "num=%~1"
	) else (
		set "num=%LVL%"
	)
	(set pad=)
	for /l %%x in (1, 1, %num%) do (set pad=!pad!%indent%)
exit /b !errorlevel!

rem ####################################################################
rem # :dk_call_HANDLE_ENTRY
rem #
:dk_call_HANDLE_ENTRY
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
	if "%dk_call_PRINT_ENTRY%" 		equ "1" (echo %pad%%_lvl_%х!__STACK__%_ent_%!)
	if "%dk_call_PIPE_ENTRY%" 		equ "1"	(>\\.\pipe\TestPipe echo %pad%%_lvl_%х!__STACK__%_ent_%!) 2>nul
	if "%dk_call_ENTRY_TO_FILE%" 	equ "1"	(>>"%DKSCRIPT_NAME%.log" echo %pad%%_lvl_%х!__STACK__%_ent_%!)
exit /b !errorlevel!

rem ####################################################################
rem # :dk_call_PRINT_EXIT
rem #
:dk_call_HANDLE_EXIT
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
	if "%dk_call_PRINT_ENTRY%" 		equ "1"	(echo %pad%  им!__STACK__%_ent_%!)
	if "%dk_call_PIPE_ENTRY%" 		equ "1"	(echo %pad%  им!__STACK__%_ent_%!> \\.\pipe\TestPipe) 2>nul
	if "%dk_call_EXIT_TO_FILE%" 	equ "1"	(echo %pad%  им!__STACK__%_ent_%!>> "%DKSCRIPT_NAME%.log")
exit /b !errorlevel!

rem ####################################################################
rem # :setGlobal(name value)
rem #
:setGlobal
setlocal enableDelayedExpansion
	set dk_allButFirstArgs=%*
	for /f "tokens=1*" %%a in ("!dk_allButFirstArgs!") do endlocal & (set %~1=%%b)
	rem (set dk.gbl.%~1=%argv%)		&rem prefix the variable name with dk.gbl. and assign a value
exit /b !errorlevel!

rem ####################################################################
rem # :setReturn
rem #
:setReturn name value
	set argv=%*
	if defined argv 			(set argv=!argv:*%1 =!)
	(set %~1=%argv%)
	(set dk.rtn.%~1=%argv%)		&rem prefix the variable name with dk.rtn. and assign a value
exit /b !errorlevel!

rem ####################################################################
rem # :popStack
rem #
:popStack
	call :setGlobal __STACK__%ENTRY%
	(set /a ENTRY-=1)
exit /b !errorlevel!

rem ####################################################################
rem # :pushStack(file args)
rem #
:pushStack
	if NOT defined LVL (set /a "LVL=0")
	if NOT defined LVL (set /a "ENTRY=0")
	(set /a LVL+=1)
	(set /a ENTRY+=1)
	call :setGlobal __STACK__%ENTRY% %*
	
	rem echo %ENTRY%: !__STACK__%ENTRY%!
	if "%dk_call_STACK_TO_FILE%" equ "1" (>>"%DKSCRIPT_NAME%.log" echo %ENTRY%: !__STACK__%ENTRY%!)
exit /b !errorlevel!

rem ####################################################################
rem # :init
rem #
:init
	call :pushStack %~n0%~0 %*
	rem set "setlocal=setlocal EnableDelayedExpansion"
	rem if not defined true 	(set "true=0")
	rem if not defined false 	(set "false=1")
	
	rem ###### _SCOPE ######
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

	rem set dk_time=(call echo %%time%%)
	
	rem #set endfunction=(if "^!DE^!" neq "" %setlocal%) ^& (if 0 neq ^^!errorlevel^^! ^^!dk_call^^! dk_error "endfunction:ERROR:^!errorlevel^! @ ^!__FILENAME__^!.cmd") ^& (exit /b ^^!errorlevel^^!)
	set endfunction=(if "^!DE^!" neq "" %setlocal%) ^& (^^!dk_call^^! endfunction_callback ^^!errorlevel^^! ^^!__FILE__^^! ^^!__FUNCTION__^^! ^^!__CMND__^^! ) ^& (exit /b ^^!errorlevel^^!)
	rem set return=(if "^!DE^!" neq "" %setlocal%) ^& (if 0 neq ^^!errorlevel^^! ^^!dk_call^^! dk_error "endfunction:ERROR:^!errorlevel^! @ ^!__FILENAME__^!.cmd") ^& (exit /b ^^!errorlevel^^!)
	set return=(if "^!DE^!" neq "" %setlocal%) ^& (^^!dk_call^^! endfunction_callback ^^!errorlevel^^! ^^!__FILE__^^! ^^!__FUNCTION__^^! ^^!__CMND__^^!) ^& (exit /b ^^!errorlevel^^!)
	set checkerror=(if "^!DE^!" neq "" %setlocal%) ^& (if 0 neq ^^!errorlevel^^! ^^!dk_call^^! dk_error "endfunction:ERROR:^!errorlevel^! @ ^!__FILENAME__^!.cmd" ^& exit /b ^^!errorlevel^^!)
	rem set clearerror=(cmd /c exit /b 0)

	if NOT defined pad (set "pad=%clr%")
	if NOT defined indent (set "indent=   ")
	
	if "%dk_call_PRINT_ENTRY%" equ "1" (
		for /l %%x in (1, 1, %ENTRY%) do (
			call :dk_call_HANDLE_ENTRY %%x %%x
		)
	)
	
	rem ###### Clear the stack log file ######
	if "%dk_call_STACK_TO_FILE%" equ "1" (
		echo. %DKSCRIPT_PATH% %DKSCRIPT_ARGS% - %date% %time%> "%DKSCRIPT_NAME%.log"
		for /l %%x in (1, 1, %ENTRY%) do (
			>>"%DKSCRIPT_NAME%.log" (echo %%x: !__STACK__%%x!)
		)	
	)
	
	if "%dk_call_ENTRY_TO_FILE%" equ "1" (
		for /l %%x in (1, 1, %ENTRY%) do (
			call :dk_call_ENTRY_TO_FILE %%x %%x
		)
	)
	%dk_call% dk_color

exit /b !errorlevel!

rem ###################
:endfunction_callback
	rem echo endfunction_callback(%*)
	if %~1 neq 0 (
		!dk_call! dk_error "endfunction:ERROR:%~1 @ %~3"
	)
	
	rem ###### DKCatchAll ################################
	rem set "DKCatchAll=%USERPROFILE:\=/%/.dk/catchAll"
	if NOT defined DKCatchAll (goto :END_DKCatchAll)
		for /F %%i in ('dir /b /a "%DKCatchAll:/=\%\*" 2^>nul') do (
			echo [31m ERROR: DKCatchALL is NOT empty
			echo [31m ERROR: ERROR:%~1 @ %~3"
			call "%DKBATCH_FUNCTIONS_DIR_%dk_stacktrace.cmd"
			pause
		)
		if "%CD%" neq "%DKCatchAll:/=\%" (
			echo [31m ERROR: DKCatchALL is not the current directory.
			echo [31m ERROR: ERROR:%~1 @ %~3"
			echo [31m ERROR: echo %CD%
			call "%DKBATCH_FUNCTIONS_DIR_%dk_stacktrace.cmd"
			pause
		)
	:END_DKCatchAll
	rem ##################################################
	
exit /b !errorlevel!
	













rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

rem	%dk_call% dk_test
rem	%dk_call% curl.exe --help
rem	%dk_call% cmd.exe /?

	%dk_call% cmd.exe /c ver
	%dk_call% curl.exe --version
	%dk_call% tar.exe --help
	%dk_call% winget.exe --help
	%dk_call% WMIC.exe /?
exit /b !errorlevel!
