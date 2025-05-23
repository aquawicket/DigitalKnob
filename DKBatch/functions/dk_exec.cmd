@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::############ dk_exec SETTINGS ############
if not defined dk_exec_ECHO_COMMAND 	(set "dk_exec_ECHO_COMMAND=1"	) 	&:: dk_exec_command
if not defined dk_exec_ECHO_STDOUT		(set "dk_exec_ECHO_STDOUT=1" 	)	&:: dk_exec_stdout[]
if not defined dk_exec_ECHO_STDERR 		(set "dk_exec_ECHO_STDERR=1" 	)	&:: dk_exec_stderr[]
::if not defined dk_exec_ECHO_EXITCODE 	(set "dk_exec_ECHO_EXITCODE=1"	)	&:: dk_exec_exitcode


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
setlocal enableDelayedExpansion
	%dk_call% dk_debugFunc 1 99

	::### set dk_exec_command ###
	set "dk_exec_command=%*"
	if "%dk_exec_ECHO_COMMAND%" equ "1" (
		echo dk_exec_command ^> %dk_exec_command%
	)

	::### set dk_exec_stdout[] ###
	set /a "i=0"
	for /f "usebackq delims=" %%Z in (`%dk_exec_command% 2^>^&1 ^& call echo ExItCoDe%%^^errorlevel%%`) do (
		set "line=%%Z"
		if "%%Z" equ "!line:ExItCoDe=!" (
			if "%dk_exec_ECHO_STDOUT%" equ "1" (
				echo dk_exec_stdout ^> %%Z
			) 
			set "dk_exec_stdout[!i!]=%%Z"
		) else (
			set /a "dk_exec_exitcode=!line:ExItCoDe=!"
		)
		set /a "i+=1"
	)
		
	::### set dk_exec_stderr[] ###
	:: TODO

	::NOTE:  what is this doing, why is it needed?
	%ComSpec% /c exit /b 0 
	
	::### set dk_exec ###
	set /a "last_output_line=i-2"
	set "dk_exec=!dk_exec_stdout[%last_output_line%]!"

	::### Return the array to the calling scope ###
	set "currentScope=1"
	for /F "delims=" %%b in ('set dk_exec_stdout') do (
		if defined currentScope endlocal
		set "dk_exec=%dk_exec%"
		set "dk_exec_exitcode=%dk_exec_exitcode%"
		set "%%b"
	)
exit /b %dk_exec_exitcode%
::%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	set myCommand=cmd /c dir
	%dk_call% dk_exec %myCommand%
	%dk_call% dk_printVar dk_exec_stdout
	%dk_call% dk_printVar dk_exec
	%dk_call% dk_printVar dk_exec_exitcode

::	%dk_call% dk_set myCommand ""%USERPROFILE:\=/%/.dk/DKC_BUILD_DIR/dk_test.exe" "var one" "var two" "var three""
::	%dk_call% dk_exec "%myCommand%"
::	%dk_call% dk_printVar dk_exec
	
::	%dk_call% dk_validate ADB_EXE "%dk_call% ANDROID::dk_ADB_EXE"
::	%dk_call% dk_set myCommand ""%ADB_EXE%" shell pm list packages" &::-f string
::	%dk_call% dk_exec "%myCommand%"
::	%dk_call% dk_printVar dk_exec
::	%dk_call% dk_echo "dk_exec = %dk_exec%"
::	%dk_call% dk_echo "dk_exec_exitcode = %dk_exec_status%"

%endfunction%
