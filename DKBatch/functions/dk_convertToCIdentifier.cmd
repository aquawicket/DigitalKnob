@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::################################################################################
::# dk_convertToCIdentifier(string rtn_var)
::#
::#
:dk_convertToCIdentifier
::setlocal enabledelayedexpansion
	call dk_debugFunc 2
	
	:: FIXME: requires delayed expansion
	setlocal enabledelayedexpansion
	if "!d!" neq "" %dk_call% dk_error "%__FUNCTION__% requires delayed expansion"
	
    set "_input_=%~1"
	set "_output_="
    set "map=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
	
    :c_identifier_loop
        if not defined _input_ goto c_identifier_endLoop  
		
		for /F "delims=*~ eol=*" %%C in ("%_input_:~0,1%") do (
			rem FIXME: non delayed expansion broken
			rem if "!DE!" neq "" call set "mapn=%%map:%%C=%%"
			rem if "!DE!" neq "" if "%mapn%" neq "%map%" call set "_output_=%%_output_%%%%C"
            rem if "!DE!" neq "" if "%mapn%" equ "%map%" call set "_output_=%%_output_%%_"
			
            if "!DE!" equ "" if "!map:%%C=!" neq "%map%" set "_output_=!_output_!%%C"
            if "!DE!" equ "" if "!map:%%C=!" equ "%map%" set "_output_=!_output_!_"
        )
        set "_input_=%_input_:~1%"
        goto:c_identifier_loop
    :c_identifier_endLoop
	
	endlocal & set "%2=%_output_%"
goto:eof






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	:: Can't handle these characters yet->    [ ] \ ' . / ~ " ? < >
	%dk_call% dk_set myVar "a A b B c C d D e E f F g G h H i I j J k K l L m M n N o O p P q Q r R s S t T u U v V w W x X y Y z Z 1 2 3 4 5 6 7 8 9 0 ` - = ; , ! @ # $ % ^ & * ( ) _ + { } | :"
	%dk_call% dk_convertToCIdentifier "%myVar%" cIdentifier
	%dk_call% dk_printVar cIdentifier
goto:eof
