@echo off&::###### DK.cmd #########################################################################################################################
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::######################### dk_exec SETTINGS #########################
if NOT defined dk_exec_ECHO_OUTPUT (set "dk_exec_ECHO_OUTPUT=1")
if NOT defined dk_exec_ECHO_ERROR  (set "dk_exec_ECHO_ERROR=1")
::set "dk_exec_PRINT_CALL=1" 		&:: dk_exec_call
::set "dk_exec_PRINT_COMMAND=1" 	&:: dk_exec_command
::set "dk_exec_PRINT_EXITCODES=1"	&:: dk_exec_exitcodes
::set "dk_exec_PRINT_EXITCODE=1"	&:: dk_exec_exitcode
::set "dk_exec_PRINT_STDERR=1"		&:: dk_exec_stderr[]
::set "dk_exec_PRINT_STDOUT=1"		&:: dk_exec_stdout[]
::set "dk_exec_PRINT_OUTPUT=1"		&:: dk_exec
::####################################################################
::# dk_exec(<command> <ret:optional>)
::#
::#		reference: https://stackoverflow.com/a/5807218
::#
::#		dk_exec_command	 - variable containing the command string
::#		dk_exec_stdout[] - an array containing the executable's output from stdout
::#		dk_exec_stderr[] - an array containing the exexutable's output fomr stderr
::#		dk_exec_exitcode - variable containng the exit status from the executable
::#		dk_exec          - variable containng the last line of output from the executable
::#
::#
:dk_exec
%setlocal%
	::%dk_call% dk_debugFunc 1 99
	
	%dk_call% dk_getParameterValue NO_ERROR %*
	if defined NO_ERROR (set "dk_exec_NO_ERROR=1")
	
	::set dk_func=cmake
	::set !dk_func!=test
	set dk_exec_call=%*
	set dk_exec_command=%dk_exec_call%
	set dk_exec_exitcodes=
	set dk_exec_exitcode=
	set dk_exec_stderr=
	set dk_exec_stdout=
	set dk_exec=
	:DeEscape
	echo %dk_exec_command% | findstr /c:"^^" >nul && (
		set dk_exec_command=%dk_exec_command:^^=^%
		goto :DeEscape
	)
	
	::###### dk_exec_PRINT_CALL ######
	if "%dk_exec_PRINT_CALL%" equ "1" (
		echo(
		for /f "usebackq delims=" %%G in (`echo "%lblue%dk_exec_call%clr%  > !dk_exec_call!"`) do (echo %%~G)
	)
	
	::###### dk_exec_PRINT_COMMAND ######
	if "%dk_exec_PRINT_COMMAND%" equ "1" (
		echo(
		for /f "usebackq delims=" %%G in (`echo "%lblue%dk_exec_command%clr%  > !dk_exec_command!"`) do (echo %%~G)
	)

	::###### dk_exec_stdout[] ######
	set /a "i=0"
	for /f "usebackq delims=" %%G in (`call %dk_exec_command% 2^>^&1 ^& call echo ExItCoDe%%^^errorlevel%%`) do (
	rem for /f "usebackq delims=" %%G in (`call %dk_exec_command% 2^>^&1 ^& if defined %~n1 call echo R_E_T_U_R_N%%^^%~n1%% ^& call echo ExItCoDe%%^^errorlevel%%`) do (
	rem for /f "usebackq delims=" %%G in (`call %dk_exec_command% 2^>^&1 ^& if defined !dk_func! call echo R_E_T_U_R_N%%^^%dk_func%%% ^& call echo ExItCoDe%%^^errorlevel%%`) do (
		set line=%%~G
		
		rem ###### dk_exec_stdout ######
		if "!line!" equ "!line:R_E_T_U_R_N=!" (
			if "!line!" equ "!line:ExItCoDe=!" (
			
				rem ###### dk_exec_stdout ######
				rem set "dk_exec_stdout=!dk_exec_stdout! !line!"
				set "dk_exec_stdout=!line!"
				if NOT defined dk_exec_stderr (
					set "dk_exec_stderr=!line!"
				) else (
					set "dk_exec_stderr=!dk_exec_stderr! !line!"
				)
				set "dk_exec_stdout[!i!]=!line!"
				
				rem ###### dk_exec_ECHO_OUTPUT ######
				if "%dk_exec_ECHO_OUTPUT%" equ "1" (
					for /f "usebackq delims=" %%G in (`echo "!dk_exec_stdout!"`) do (echo %%~G)
				)
				
				rem ###### dk_exec_PRINT_STDOUT ######
				if "%dk_exec_PRINT_STDOUT%" equ "1" (
					for /f "usebackq delims=" %%G in (`echo "%lblue%dk_exec_stdout%clr%   > !dk_exec_stdout!"`) do (echo %%~G)
				)
			) 
		)
		
		if "!line!" neq "!line:R_E_T_U_R_N=!" (
			set "dk_exec=!line:R_E_T_U_R_N=!"
		)
		
		if "!line!" neq "!line:ExItCoDe=!" (
			rem ###### dk_exec_exitcodes ######
			set /a "dk_exec_exitcodes=!line:ExItCoDe=!"
			
			rem ###### dk_exec_exitcode ######
			set /a "dk_exec_exitcode=!line:ExItCoDe=!"
		)
		set /a "i+=1"
	)
	
	::###### Set the errorlevel ######
	::%ComSpec% /c exit /b %dk_exec_exitcode%
	
	::###### TODO: dk_exec_PRINT_STDERR ######
	if "%dk_exec_PRINT_STDERR%" equ "1" (
		for /f "usebackq delims=" %%G in (`echo "%lblue%dk_exec_stderr%clr% > !dk_exec_stderr!"`) do (echo %%~G)
	)
	
	::###### dk_exec_PRINT_EXITCODES ######
	if "%dk_exec_PRINT_EXITCODES%" equ "1" (
		for /f "usebackq delims=" %%G in (`echo "%lblue%dk_exec_exitcodes%clr% > !dk_exec_exitcodes!"`) do (echo %%~G)
	)
	
	::###### dk_exec_PRINT_EXITCODE ######
	if "%dk_exec_PRINT_EXITCODE%" equ "1" (
		for /f "usebackq delims=" %%G in (`echo "%lblue%dk_exec_exitcode%clr% > !dk_exec_exitcode!"`) do (echo %%~G)
	)
			
	::###### dk_exec ######
	if "!dk_exec!" equ "" (
		set "dk_exec=!dk_exec_stdout!"
	)
	
	::###### dk_exec_PRINT_OUTPUT ######
	if "%dk_exec_PRINT_OUTPUT%" equ "1" (
		for /f "usebackq delims=" %%G in (`echo "%lblue%dk_exec%clr% > !dk_exec!"`) do (echo %%~G)
	)

	::###### Return the array to the calling scope ######
	set "dk_exec_SCOPE=1"
	for /F "delims=" %%G in ('set dk_exec') do (
		if defined dk_exec_SCOPE endlocal
		set "%%G"
	)
	
	if defined dk_exec_NO_ERROR (
		set "dk_exec_NO_ERROR="
		exit /b 0
	) else (
		if "!dk_exec_exitcode!" equ "0" (
			%dk_call% dk_return !dk_exec_exitcode! !dk_exec! & exit /b !dk_exec_exitcode!
		) else (
			echo dk_exec_stderr = "!dk_exec_stderr!"
			rem %dk_call% dk_return !dk_exec_exitcode! !dk_exec_stderr! & exit /b !dk_exec_exitcode!
			%dk_call% dk_error "ERROR:!dk_exec_exitcode! @ dk_exec.cmd" & exit /b !dk_exec_exitcode!
		)
	)
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

::	set "dk_exec_ECHO_OUTPUT=1"
::	set "dk_exec_ECHO_ERROR=1"
::	set "dk_exec_PRINT_CALL=1"
::	set "dk_exec_PRINT_COMMAND=1"
::	set "dk_exec_PRINT_EXITCODES=1"
::	set "dk_exec_PRINT_EXITCODE=1"
::	set "dk_exec_PRINT_STDERR=1"
::	set "dk_exec_PRINT_STDOUT=1"
::	set "dk_exec_PRINT_OUTPUT=1"

	echo.
	echo ###### calling dk_testError.cmd ######
	%dk_call% dk_exec dk_testError.cmd
	echo.
	pause
	
	set "test=has value"
	%dk_call% dk_exec dk_test.cmd abc "d e f"
	pause
	
::	%dk_call% dk_exec ver
::	pause

::	%dk_call% dk_exec badCommand
::	pause
	
::	%dk_call% dk_validate CURL_EXE "%dk_call% dk_CURL_EXE"
::	%dk_call% dk_exec %CURL_EXE% "http://www.google.com/index.html" -sI -o nul -w "%%%%%%%%{http_code}\n"
::	pause
	
::	%dk_call% dk_exec notepad.exe
::	pause
	
::	%dk_call% dk_validate ADB_EXE "%dk_call% ANDROID::dk_ADB_EXE"
::	%dk_call% dk_exec "%ADB_EXE%" shell pm list packages" &::-f string

::	%dk_call% dk_exec "%USERPROFILE:\=/%/.dk/DKC_BUILD_DIR/dk_test.exe" "var one" "var two" "var three"
	
::	%dk_call% dk_exec %USERPROFILE:\=/%/.dk/DKC_BUILD_DIR/dk_evalDKC_TEMP.exe
	
	


::	%dk_call% dk_echo "dk_exec_call      = %dk_exec_call%"
::	%dk_call% dk_echo "dk_exec_command   = %dk_exec_command%"
::	%dk_call% dk_echo "dk_exec_exitcodes = %dk_exec_exitcodes%"
::	%dk_call% dk_echo "dk_exec_exitcode  = %dk_exec_exitcode%"
::	%dk_call% dk_echo "dk_exec_stderr    = %dk_exec_stderr%"
::	%dk_call% dk_echo "dk_exec_stdout    = %dk_exec_stdout%"
::	%dk_call% dk_echo "dk_exec           = %dk_exec%"

%endfunction%
