call dk_includeGuard

::##################################################################################
::# dk_toVariableInfo(<message-variable>)
::#
::#	If the parameter is a variable containing the name of a valid variable name
::#	Convert the contents to the details of said variable
::#
::#	Example:  
::# set "myVar=this is my variable"
::# set "message=myVar"
::# call dk_toVariableInfo message
::# echo %message%
::#
::#	Output:
::#	myVar: 'this is my variable'
::#
:dk_toVariableInfo () {
	::call dk_debugFunc
	
	::set argc=0
	::for %%x in (%*) do Set /A argc+=1
	::if "%argc%" NEQ "1"	 call dk_verbose "dk_variableInfo(%*): incorrect number of parameters" & goto:eof
	if "%1"==""          call dk_error "dk_variableInfo: parameter 1 is invalid" & goto:eof
		
	setlocal enabledelayedexpansion
		::eval name='$'{$1}
		::$(expr "$name" : "[A-Za-z0-9_]\+$" 1>/dev/null) || return $false
		
		set "msg_var=%1"		
		if "%msg_var%"=="" call dk_error "dk_variableInfo: msg_var is invalid" & goto:eof
		::echo msg_var = %msg_var%
		
		call set "var=%%%msg_var%%%"
		if "%var%"=="" call dk_error "dk_variableInfo: var is invalid" & goto:eof
		::echo var = %var%
		
		call set "var_value=%%%var%%%"
		::echo var_value = %var_value%
		
		::var_name is literal '%VARIABLE%'
		set "var_name=%%!var!%%"  
		::echo var_name = %var_name%
		
		if "%var_value%" NEQ ""  set "new_msg=%%!var_name!%% = '%var_value%'"
		if "%var_value%"==""     set "new_msg=%%!var_name!%% = %red%UNDEFINED%clr%"
	endlocal & set "%1=%new_msg%"
goto:eof