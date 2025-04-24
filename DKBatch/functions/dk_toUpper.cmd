<<<<<<< HEAD
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################

>>>>>>> Development

::################################################################################
::# dk_toUpper(string rtn_var)
::#
::#
:dk_toUpper
<<<<<<< HEAD
    call dk_debugFunc 2
 setlocal
 
        set "_upper_=%~1"
        if "!DE!" equ "" for %%# in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do set "_upper_=!_upper_:%%#=%%#!")           &:: with delayed expansion ON
        if "!DE!" neq "" for %%# in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do call set "_upper_=%%_upper_:%%#=%%#%%")    &:: with delayed expansion OFF
    endlocal & set "%2=%_upper_%"
=======
setlocal enableDelayedExpansion
	%dk_call% dk_debugFunc 2

	set "dk_toUpper=%~1"
	for %%# in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do set "dk_toUpper=!dk_toUpper:%%#=%%#!")
    
	endlocal & (
		set "dk_toUpper=%dk_toUpper%"
		if "%~2" neq "" (set "%~2=%dk_toUpper%")
	)
>>>>>>> Development
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
<<<<<<< HEAD
    call dk_debugFunc 0
 setlocal
 
    :: Can't handle these characters yet->    [ ] \ ' . / ~ " ? < >
    set "myVar=a A b B c C d D e E f F g G h H i I j J k K l L m M n N o O p P q Q r R s S t T u U v V w W x X y Y z Z 1 2 3 4 5 6 7 8 9 0 ` - = ; , ! @ # $ % ^ & * ( ) _ + { } | :"
    %dk_call% dk_toUpper "%myVar%" uppercase
    
    %dk_call% dk_printVar myVar
    %dk_call% dk_printVar uppercase
=======
setlocal
	%dk_call% dk_debugFunc 0

    :: Can't handle these characters yet->    [ ] \ ' . / ~ " ? < >
    set "myVar=a A b B c C d D e E f F g G h H i I j J k K l L m M n N o O p P q Q r R s S t T u U v V w W x X y Y z Z 1 2 3 4 5 6 7 8 9 0 ` - = ; , ! @ # $ % ^ & * ( ) _ + { } | :"
	%dk_call% dk_echo
	%dk_call% dk_echo "myVar = %myVar%"
	
	:: default variable output
    %dk_call% dk_toUpper "%myVar%"
	%dk_call% dk_echo
	%dk_call% dk_echo "dk_toUpper = %dk_toUpper%"
	
	:: user variable output
	%dk_call% dk_toUpper "%myVar%" myVar_UPPER
	%dk_call% dk_echo
	%dk_call% dk_echo "myVar_UPPER = %myVar_UPPER%"
>>>>>>> Development
%endfunction%
