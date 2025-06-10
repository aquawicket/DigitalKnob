@echo off&::###### DK.cmd #########################################################################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::######################### dk_exec SETTINGS #########################
if not defined dk_exec_PRINT_COMMAND 	(set "dk_exec_PRINT_COMMAND=0"	) 	&:: dk_exec_command
if not defined dk_exec_PRINT_ARGS	 	(set "dk_exec_PRINT_ARGS=0"		) 	&:: dk_exec_arg<N>
if not defined dk_exec_PRINT_STDOUT		(set "dk_exec_PRINT_STDOUT=0"	)	&:: dk_exec_stdout[]
if not defined dk_exec_PRINT_STDERR 	(set "dk_exec_PRINT_STDERR=0"	)	&:: dk_exec_stderr[]
if not defined dk_exec_PRINT_EXITCODE 	(set "dk_exec_PRINT_EXITCODE=0"	)	&:: dk_exec_exitcode
::####################################################################
::# dk_exec(<command> <ret:optional>)
::#
::#		reference: https://stackoverflow.com/a/5807218
::#
::#		dk_exec_stdout[] - an array containing the executable's output from stdout
::#		dk_exec_stderr[] - an array containing the exexutable's output fomr stderr
::#		dk_exec_exitcode - variable containng the exit status from the executable
::#		dk_exec          - variable containng the last line of output from the executable
::#
::#
:dk_exec
%setlocal%
	::%dk_call% dk_debugFunc 1 99
	
	set dk_exec_command=%*
	:DeEscape
	echo %dk_exec_command% | findstr /c:"^^" >nul && (
		set dk_exec_command=%dk_exec_command:^^=^%
		goto :DeEscape
	)
	
	::###### dk_exec_command ######
	::set dk_exec_command=%_ARGS_%
	
	::###### dk_exec_PRINT_COMMAND ######
	if "%dk_exec_PRINT_COMMAND%" equ "1" (
		for /f "usebackq delims=" %%G in (`echo "%lblue%dk_exec_command%clr%  > !dk_exec_command!"`) do (echo %%~G)
	)

	::###### dk_exec_PRINT_ARGS ######
	if "%dk_exec_PRINT_ARGS%" equ "1" (
		if "%~1" neq "" for /f "usebackq delims=" %%G in (`echo "%lblue%dk_exec_arg1%clr%     > %1"`) do (echo %%~G)
		if "%~2" neq "" for /f "usebackq delims=" %%G in (`echo "%lblue%dk_exec_arg2%clr%     > %2"`) do (echo %%~G)
		if "%~3" neq "" for /f "usebackq delims=" %%G in (`echo "%lblue%dk_exec_arg3%clr%     > %3"`) do (echo %%~G)
		if "%~4" neq "" for /f "usebackq delims=" %%G in (`echo "%lblue%dk_exec_arg4%clr%     > %4"`) do (echo %%~G)
		if "%~5" neq "" for /f "usebackq delims=" %%G in (`echo "%lblue%dk_exec_arg5%clr%     > %5"`) do (echo %%~G)
		if "%~6" neq "" for /f "usebackq delims=" %%G in (`echo "%lblue%dk_exec_arg6%clr%     > %6"`) do (echo %%~G)
		if "%~7" neq "" for /f "usebackq delims=" %%G in (`echo "%lblue%dk_exec_arg7%clr%     > %7"`) do (echo %%~G)
		if "%~8" neq "" for /f "usebackq delims=" %%G in (`echo "%lblue%dk_exec_arg8%clr%     > %8"`) do (echo %%~G)
		if "%~9" neq "" for /f "usebackq delims=" %%G in (`echo "%lblue%dk_exec_arg9%clr%     > %9"`) do (echo %%~G)
	)

	::###### dk_exec_stdout[] ######
	set /a "i=0"
	for /f "usebackq delims=" %%G in (`%dk_exec_command% 2^>^&1 ^& call echo ExItCoDe%%^^errorlevel%%`) do (
		set "line=%%G"
		
		rem ###### dk_exec_stdout ######
		if "!line!" equ "!line:ExItCoDe=!" (
		
			rem ###### dk_exec_stdout ######
			set "dk_exec_stdout=!line!"
			set "dk_exec_stdout[!i!]=!dk_exec_stdout!"
			
			rem ###### dk_exec_PRINT_STDOUT ######
			if "%dk_exec_PRINT_STDOUT%" equ "1" (
				for /f "usebackq delims=" %%G in (`echo "%lblue%dk_exec_stdout%clr%   > !dk_exec_stdout!"`) do (echo %%~G)
			)
			
		) else (
			rem ###### dk_exec_exitcode ######
			set /a "dk_exec_exitcode=!line:ExItCoDe=!"
		)
		set /a "i+=1"
	)
		
	::###### dk_exec_PRINT_EXITCODE ######
	if "%dk_exec_PRINT_EXITCODE%" equ "1" (
		for /f "usebackq delims=" %%G in (`echo "%lblue%dk_exec_exitcode%clr% > !dk_exec_exitcode!"`) do (echo %%~G)
	)
			
	::###### TODO: dk_exec_PRINT_STDERR ######
	::if "%dk_exec_PRINT_STDERR%" equ "1" (
	::	echo dk_exec_stderr ^> !dk_exec_stderr!
	::)

	::###### NOTE: what is this doing, why is it needed? ######
	%ComSpec% /c exit /b 0
	
	::###### dk_exec ######
	set /a "last_output_line=i-2"
	::set "dk_exec=!dk_exec_stdout[%last_output_line%]!"
	set "dk_exec=!dk_exec_stdout!"

	::###### Return the array to the calling scope ######
	set "dk_exec_SCOPE=1"
	for /F "delims=" %%G in ('set dk_exec_stdout') do (
		if defined dk_exec_SCOPE endlocal
		set "dk_exec_command=%dk_exec_command%"
		set "dk_exec=%dk_exec%"
		set "dk_exec_exitcode=%dk_exec_exitcode%"
		set "%%G"
	)
exit /b %dk_exec_exitcode%
::%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

::	%dk_call% dk_validate ADB_EXE "%dk_call% ANDROID::dk_ADB_EXE"
::	%dk_call% dk_set myCommand ""%ADB_EXE%" shell pm list packages" &::-f string

::	%dk_call% dk_set myCommand ""%USERPROFILE:\=/%/.dk/DKC_BUILD_DIR/dk_test.exe" "var one" "var two" "var three""
	
::	set myCommand=%USERPROFILE:\=/%/.dk/DKC_BUILD_DIR/dk_evalDKC_TEMP.exe
	
::	set myCommand=ver
	set "dk_exec_PRINT_COMMAND=1"
	set "dk_exec_PRINT_ARGS=1"
	set "dk_exec_PRINT_STDOUT=1"
	set "dk_exec_PRINT_STDERR=1"
	set "dk_exec_PRINT_EXITCODE=1"
	
	%dk_call% dk_validate CURL_EXE "%dk_call% dk_CURL_EXE"
	set "url=http://www.google.com/index.html"
	set mycommand=%CURL_EXE% "%url%" -sI -o nul -w "%%%%%%%%{http_code}\n"
::	echo myCommand = !myCommand!
	
	%dk_call% dk_exec !myCommand!
	%dk_call% dk_echo
	%dk_call% dk_echo "dk_exec_command = !dk_exec_command!"
	%dk_call% dk_echo "dk_exec_stdout = !dk_exec_stdout!"
	%dk_call% dk_echo "dk_exec = !dk_exec!"
	%dk_call% dk_echo "dk_exec_exitcode = !dk_exec_exitcode!"

%endfunction%
