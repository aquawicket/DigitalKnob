@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::################################################################################
::# dk_convertToCIdentifier(string rtn_var)
::#
::#
:dk_convertToCIdentifier
	call dk_debugFunc
	if %__ARGC__% neq 2 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	setlocal EnableDelayedExpansion
    call dk_set _input_ "%~1"
    call dk_set map "abcdefghijklmnopqrstuvwxyz1234567890"

    :c_identifier_loop
        if not defined _input_ goto c_identifier_endLoop    
        for /F "delims=*~ eol=*" %%C in ("!_input_:~0,1!") do (
            if "!map:%%C=!" neq "!map!" set "_output=!_output!%%C"
            if "!map:%%C=!" equ "!map!" set "_output=!_output!_"
        )
        set "_input_=!_input_:~1!"
        goto c_identifier_loop
    :c_identifier_endLoop
	
	endlocal & call dk_set %2 "%_output%"
goto:eof






::####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	:: Can't handle these characters yet->    [ ] \ ' . / ~ " ? < >
	call dk_set myVar "a A b B c C d D e E f F g G h H i I j J k K l L m M n N o O p P q Q r R s S t T u U v V w W x X y Y z Z 1 2 3 4 5 6 7 8 9 0 ` - = ; , ! @ # $ % ^ & * ( ) _ + { } | :"
	call dk_convertToCIdentifier "%myVar%" myAlphaNumericVar
	call dk_printVar myAlphaNumericVar
goto:eof
