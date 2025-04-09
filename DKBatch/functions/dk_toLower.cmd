@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::################################################################################
::# dk_toLower(string rtn_var)
::#
::#
:dk_toLower
setlocal enableDelayedExpansion
	%dk_call% dk_debugFunc 2

        set "_lower_=%~1"
        for %%# in (a b c d e f g h i j k l m n o p q r s t u v w x y z) do set "_lower_=!_lower_:%%#=%%#!")           &:: with delayed expansion ON
    endlocal & set "%2=%_lower_%"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    :: Can't handle these characters yet->    [ ] \ ' . / ~ " ? < >
    set "myVar=a A b B c C d D e E f F g G h H i I j J k K l L m M n N o O p P q Q r R s S t T u U v V w W x X y Y z Z 1 2 3 4 5 6 7 8 9 0 ` - = ; , ! @ # $ % ^ & * ( ) _ + { } | :"
    %dk_call% dk_toLower "%myVar%" lowercase
    
    %dk_call% dk_printVar myVar
    %dk_call% dk_printVar lowercase
%endfunction%
