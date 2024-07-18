@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::################################################################################
::# dk_toLower(string rtn_var)
::#
::#
:dk_toLower
	call dk_debugFunc
	if %__ARGC__% neq 2 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	setlocal
		set "_lower_=%~1"
		%if_NDE% for %%# in (a b c d e f g h i j k l m n o p q r s t u v w x y z) do call set "_lower_=%%_lower_:%%#=%%#%%")	&:: with delayed expansion OFF
		%if_DE%  for %%# in (a b c d e f g h i j k l m n o p q r s t u v w x y z) do set "_lower_=!_lower_:%%#=%%#!")			&:: with delayed expansion ON
	endlocal & set "%2=%_lower_%"
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	:: Can't handle these characters yet->    [ ] \ ' . / ~ " ? < >
	set "myVar=a A b B c C d D e E f F g G h H i I j J k K l L m M n N o O p P q Q r R s S t T u U v V w W x X y Y z Z 1 2 3 4 5 6 7 8 9 0 ` - = ; , ! @ # $ % ^ & * ( ) _ + { } | :"
	call dk_toLower "%myVar%" lowercase
	
	call dk_printVar myVar
	call dk_printVar lowercase
goto:eof
