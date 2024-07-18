@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::################################################################################
::# dk_toUpper(string rtn_var)
::#
::#
:dk_toUpper
	call dk_debugFunc
	if %__ARGC__% neq 2 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	setlocal
		set "_upper_=%~1"
		%if_NDE% for %%# in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do call set "_upper_=%%_upper_:%%#=%%#%%")	&:: with delayed expansion OFF
		%if_DE%  for %%# in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do set "_upper_=!_upper_:%%#=%%#!")			&:: with delayed expansion ON
	endlocal & set "%2=%_upper_%"
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	:: Can't handle these characters yet->    [ ] \ ' . / ~ " ? < >
	set "myVar=a A b B c C d D e E f F g G h H i I j J k K l L m M n N o O p P q Q r R s S t T u U v V w W x X y Y z Z 1 2 3 4 5 6 7 8 9 0 ` - = ; , ! @ # $ % ^ & * ( ) _ + { } | :"
	call dk_toUpper "%myVar%" uppercase
	
	call dk_printVar myVar
	call dk_printVar uppercase
goto:eof
