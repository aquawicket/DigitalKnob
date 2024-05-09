@echo off
call DK

::################################################################################
::# dk_convertToCIdentifier(<in> <out>)
::#
::#
:dk_convertToCIdentifier () {
	::call dk_debugFunc
	
	setlocal EnableDelayedExpansion
    set "_input=%1"
	::call dk_printVar _input

    set "map=abcdefghijklmnopqrstuvwxyz 1234567890"

    :c_identifier_loop
        if not defined _input goto c_identifier_endLoop    
        for /F "delims=*~ eol=*" %%C in ("!_input:~0,1!") do (
                if "!map:%%C=!" neq "!map!" set "_output=!_output!%%C"
                if "!map:%%C=!" equ "!map!" set "_output=!_output!_"
        )
        set "_input=!_input:~1!"
    goto c_identifier_loop

    :c_identifier_endLoop
	::call dk_printVar _output

	endlocal & set "%2=%_output%"		
goto:eof