::dk_include_guard()
setlocal EnableDelayedExpansion

::################################################################################
::# dk_convertToCIdentifier(<in> <out>)
::#
::#
:dk_convertToCIdentifier () {
	call dk_verbose "dk_convertToCIdentifier(%*)"
	
    set "_input=%1"
	::call dk_debug _input

    set "map=abcdefghijklmnopqrstuvwxyz 1234567890"

    :c_identifier_loop
        if not defined _input goto c_identifier_endLoop    
        for /F "delims=*~ eol=*" %%C in ("!_input:~0,1!") do (
                if "!map:%%C=!" NEQ "!map!" set "_output=!_output!%%C"
                if "!map:%%C=!" EQU "!map!" set "_output=!_output!_"
        )
        set "_input=!_input:~1!"
    goto c_identifier_loop

    :c_identifier_endLoop
	::call dk_debug _output

endlocal & set "%2=%_output%"		
goto:eof