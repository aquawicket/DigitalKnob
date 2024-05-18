@echo off
call DK

::####################################################################
::# dk_commandToVariable(<command . .> <variable_name>)
::#
::#    reference: https://stackoverflow.com/a/5807218
::#
:dk_commandToVariable () {
	call dk_debugFunc
	if %__ARGC__% NEQ 2 (call dk_error "%__FUNCTION__%(): incorrect number of arguments")
	
	
	::set "_command_=%__ARGS__%"
	::set /a "_lastArgN_=%__ARGC__%-1"
	::call set "_returnVar_=%%__ARGV__[%_lastArgN_%]%%"
	::call set "_command_=%%_command_:%_returnVar_%=%%"

	set _command_=%~1
	::set "_command_=%_command_:"=_QUOTE_%"
	set _returnVar_=%~2
	::call dk_printVar _command_
	::call dk_printVar _returnVar_
	
	::set "_command_=%_command_:_QUOTE_="%"
	for /f "usebackq delims=|" %%f in (`%_command_%`) do (
        rem echo %%f
		if not defined %_returnVar_% set "%_returnVar_%=%%f"
    )
	goto:eof
	
	

	
	
	
	
	
	
	
	setlocal EnableDelayedExpansion
	set /a "_argCount_=0"
	for %%a in (%*) do (
		set "_args_[!_argCount_!]=%%~a"
		set /a "_argCount_+=1"
	)
	call dk_printVar _argCount_
	call dk_printVar _args_
	endlocal
	goto:eof
	
	
	set "_command_="
    :command_args
		set "arg=%1"
		set "arg=%arg:"=_QUOTE_%"
			
		if not "%~2"=="" (
			if not defined _command_ (
				set "_command_=%arg%"
			) else (
				set "_command_=%_command_% %arg%"
			)
		)
		rem set "_lastArg_=%~1"
		shift
    if not "%~2"=="" goto command_args
	set "_lastArg_=%~2"
	
    set "_command_=%_command_:_QUOTE_="%"

    for /F "tokens=*" %%g in ('%_command_% 2^> nul') do (
        set "%_lastArg_%=%%g"
		::call dk_printVar variable_name
		call dk_printVar %_lastArg_%
        rem set "variable_value=%%g"
    )

    call dk_checkError
goto:eof




:DKTEST ########################################################################

	set "myCommand=dir"
	call dk_commandToVariable "%myCommand%" myVariable
	call dk_printVar myVariable
	