@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::############ dk_exec SETTINGS ############
if not defined dk_exec_PRINT_COMMAND 	(set "dk_exec_PRINT_COMMAND=0"	) 	&:: dk_exec_command
if not defined dk_exec_PRINT_ARGS	 	(set "dk_exec_PRINT_ARGS=0"		) 	&:: dk_exec_arg<N>
if not defined dk_exec_PRINT_STDOUT		(set "dk_exec_PRINT_STDOUT=0" 	)	&:: dk_exec_stdout[]
if not defined dk_exec_PRINT_STDERR 	(set "dk_exec_PRINT_STDERR=0" 	)	&:: dk_exec_stderr[]
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

	::###### dk_exec_command ######
	set "dk_exec_command=%*"
	
	::###### dk_exec_PRINT_COMMAND ######
	if "%dk_exec_PRINT_COMMAND%" equ "1" (
		echo dk_exec_command ^> !dk_exec_command!
	)
	
	::###### dk_exec_PRINT_ARGS ######
	if "%dk_exec_PRINT_ARGS%" equ "1" (
		if "%~1" neq "" (echo dk_exec_arg1    ^> %~1)
		if "%~2" neq "" (echo dk_exec_arg2    ^> %~2)
		if "%~3" neq "" (echo dk_exec_arg3    ^> %~3)
		if "%~4" neq "" (echo dk_exec_arg4    ^> %~4)
		if "%~5" neq "" (echo dk_exec_arg5    ^> %~5)
		if "%~6" neq "" (echo dk_exec_arg6    ^> %~6)
		if "%~7" neq "" (echo dk_exec_arg7    ^> %~7)
		if "%~8" neq "" (echo dk_exec_arg8    ^> %~8)
		if "%~9" neq "" (echo dk_exec_arg9    ^> %~9)
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
				echo dk_exec_stdout ^> !dk_exec_stdout!
			)
			
		) else (
			rem ###### dk_exec_exitcode ######
			set /a "dk_exec_exitcode=!line:ExItCoDe=!"
		)
		set /a "i+=1"
	)
		
	::###### dk_exec_PRINT_EXITCODE ######
	if "%dk_exec_PRINT_EXITCODE%" equ "1" (
		echo dk_exec_exitcode ^> !dk_exec_exitcode!
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
	
::	set myCommand=C:\Users\Administrator\.dk\DKC_BUILD_DIR\dk_evalDKC_TEMP.exe
	
::	set myCommand=ver
	
	%dk_call% dk_validate CURL_EXE "%dk_call% dk_CURL_EXE"
	set "url=http://www.google.com/index.html"
	set myCommand=%CURL_EXE% -sI -o nul -w "%%{http_code}\n" "%url%"
	echo myCommand = !myCommand!
	
	%dk_call% dk_exec !myCommand!
	%dk_call% dk_printVar dk_exec_stdout
	%dk_call% dk_printVar dk_exec
	%dk_call% dk_printVar dk_exec_exitcode

%endfunction%
