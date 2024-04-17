::dk_include_guard()

::####################################################################
::# dk_command_to_variable(<command . .> <variable_name>)
::#
::#
:dk_command_to_variable () {
	call dk_verbose "dk_command_to_variable(%*)"
	
    if [%2] == [] (
        echo "ERROR: dk_command_to_variable() requires at least 2 parameters"
        goto:eof
    )
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

    ::echo dk_command_to_variable(%*) -^> %%%variable_name%%% = %variable_value%
    call dk_check_error
goto:eof