@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::################################################################################
::# dk_convertToCIdentifier(string rtn_var)
::#
::#
:dk_convertToCIdentifier
setlocal enabledelayedexpansion
	%dk_call% dk_debugFunc 1 2
    
    set "_input_=%~1"
    set "dk_convertToCIdentifier="
    set "map=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
    
    :c_identifier_loop
        if not defined _input_ (goto c_identifier_endLoop)
        
        for /F "delims=*~ eol=*" %%C in ("%_input_:~0,1%") do (            
            if "!map:%%C=!" neq "%map%" (set "dk_convertToCIdentifier=!dk_convertToCIdentifier!%%C")
            if "!map:%%C=!" equ "%map%" (set "dk_convertToCIdentifier=!dk_convertToCIdentifier!_")
        )
        set "_input_=%_input_:~1%"
        goto c_identifier_loop
    :c_identifier_endLoop
    
    endlocal & (
		set "dk_convertToCIdentifier=%dk_convertToCIdentifier%"
		if "%~2" neq "" (set "%2=%dk_convertToCIdentifier%")
	)
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    :: Can't handle these characters yet->    [ ] \ ' . / ~ " ? < >
    %dk_call% dk_set myVar "a A b B c C d D e E f F g G h H i I j J k K l L m M n N o O p P q Q r R s S t T u U v V w W x X y Y z Z 1 2 3 4 5 6 7 8 9 0 ` - = ; , ! @ # $ % ^ & * ( ) _ + { } | :"
    %dk_call% dk_convertToCIdentifier "%myVar%"
	%dk_call% dk_printVar dk_convertToCIdentifier
	
	%dk_call% dk_set myVar "a A b B c C d D e E f F g G h H i I j J k K l L m M n N o O p P q Q r R s S t T u U v V w W x X y Y z Z 1 2 3 4 5 6 7 8 9 0 ` - = ; , ! @ # $ % ^ & * ( ) _ + { } | :"
    %dk_call% dk_convertToCIdentifier "%myVar%" cIdentifier
	%dk_call% dk_printVar dk_convertToCIdentifier
	%dk_call% dk_printVar cIdentifier
%endfunction%
