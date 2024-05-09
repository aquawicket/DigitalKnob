@echo off
call DK

::####################################################################
::# dk_commandToVariable(<command . .> <variable_name>)
::#
::#
:dk_commandToVariable () {
	call dk_debugFunc	
	if "%~1" equ "" call dk_error "%__FUNCTION__%(%*): argument 1 is invalid"
	if "%~2" equ "" call dk_error "%__FUNCTION__%(%*): argument 2 is invalid"

    set command=

    :command_args
    set arg=%1
    set arg=%arg:"=_QUOTE_%
        
    if not "%~2"=="" (
        if "%command%"=="" (
            set "command=%arg%"
        ) else (
            set "command=%command% %arg%"
        )
    )
    set variable_name=%~1
    shift
    if not "%~1"=="" goto command_args

    set command=%command:_QUOTE_="%

    for /F "tokens=*" %%g in ('%command% 2^> nul') do (
        set %variable_name%=%%g
        set "variable_value=%%g"
    )

    ::echo dk_commandToVariable(%*) -^> %%%variable_name%%% = %variable_value%
    call dk_checkError
goto:eof