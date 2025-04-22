@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::####################################################################
::# dk_isVariableName(string rtn_var)
::#
::#  https://stackoverflow.com/a/17584764
::#
::#
::#
::#
:dk_isVariableName
setlocal
	%dk_call% dk_debugFunc 1 2
 
    ::set "arg1=%~1"
    ::if defined "%~1" call set "arg1=%%%arg1%%%"
	
	for /f "delims=$-_0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" %%A in ("%~1") do (set "bad_characters=%%A")

    if not defined bad_characters (
		set "dk_isVariableName=0"
	) else (
		set "dk_isVariableName=1"
	)
    
	endlocal & (
		set "dk_isVariableName=%dk_isVariableName%"
		if "%~2" neq "" (set "%2=%dk_isVariableName%")
		exit /b %dk_isVariableName%
	)
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	set "name=__NULL__"
	set "%name%=PASSED"
	if "!%name%!" neq "PASSED" (%dk_call% dk_error "variabl name '%name%' failed") else (%dk_call% dk_success "%name% = '!%name%!'")
	%dk_call% dk_isVariableName %name% && %dk_call% dk_success "'%name%' is a valid variable name" || %dk_call% dk_error "'%name%' is NOT a valid variable name"

	set "name=____"
	set "%name%=PASSED"
	if "!%name%!" neq "PASSED" (%dk_call% dk_error "variabl name '%name%' failed") else (%dk_call% dk_success "%name% = '!%name%!'")
	%dk_call% dk_isVariableName %name% && %dk_call% dk_success "'%name%' is a valid variable name" || %dk_call% dk_info "'%name%' is NOT a valid variable name"

	set "name=____"
	set "%name%=PASSED"
	if "!%name%!" neq "PASSED" (%dk_call% dk_error "variabl name '%name%' failed") else (%dk_call% dk_success "%name% = '!%name%!'")
	%dk_call% dk_isVariableName %name% && %dk_call% dk_success "'%name%' is a valid variable name" || %dk_call% dk_info "'%name%' is NOT a valid variable name"

	set "name=____"
	set "%name%=PASSED"
	if "!%name%!" neq "PASSED" (%dk_call% dk_error "variabl name '%name%' failed") else (%dk_call% dk_success "%name% = '!%name%!'")
	%dk_call% dk_isVariableName %name% && %dk_call% dk_success "'%name%' is a valid variable name" || %dk_call% dk_info "'%name%' is NOT a valid variable name"

	set "name=____"
	set "%name%=PASSED"
	if "!%name%!" neq "PASSED" (%dk_call% dk_error "variabl name '%name%' failed") else (%dk_call% dk_success "%name% = '!%name%!'")
	%dk_call% dk_isVariableName %name% && %dk_call% dk_success "'%name%' is a valid variable name" || %dk_call% dk_info "'%name%' is NOT a valid variable name"

	set "name=____"
	set "%name%=PASSED"
	if "!%name%!" neq "PASSED" (%dk_call% dk_error "variabl name '%name%' failed") else (%dk_call% dk_success "%name% = '!%name%!'")
	%dk_call% dk_isVariableName %name% && %dk_call% dk_success "'%name%' is a valid variable name" || %dk_call% dk_info "'%name%' is NOT a valid variable name"

	set "name=____"
	set "%name%=PASSED"
	if "!%name%!" neq "PASSED" (%dk_call% dk_error "variabl name '%name%' failed") else (%dk_call% dk_success "%name% = '!%name%!'")
	%dk_call% dk_isVariableName %name% && %dk_call% dk_success "'%name%' is a valid variable name" || %dk_call% dk_info "'%name%' is NOT a valid variable name"

	set "name=____"
	set "%name%=PASSED"
	if "!%name%!" neq "PASSED" (%dk_call% dk_error "variabl name '%name%' failed") else (%dk_call% dk_success "%name% = '!%name%!'")
	%dk_call% dk_isVariableName %name% && %dk_call% dk_success "'%name%' is a valid variable name" || %dk_call% dk_info "'%name%' is NOT a valid variable name"

	set "name=____"
	set "%name%=PASSED"
	if "!%name%!" neq "PASSED" (%dk_call% dk_error "variabl name '%name%' failed") else (%dk_call% dk_success "%name% = '!%name%!'")
    %dk_call% dk_isVariableName %name% && %dk_call% dk_success "'%name%' is a valid variable name" || %dk_call% dk_info "'%name%' is NOT a valid variable name"

	set "name=__	__"
	set "%name%=PASSED"
	if "!%name%!" neq "PASSED" (%dk_call% dk_error "variabl name '%name%' failed") else (%dk_call% dk_success "%name% = '!%name%!'")
	%dk_call% dk_isVariableName %name% && %dk_call% dk_success "'%name%' is a valid variable name" || %dk_call% dk_info "'%name%' is NOT a valid variable name"

::	set "name=__LF__"
::	set "%name%=PASSED"
::	if "!%name%!" neq "PASSED" (%dk_call% dk_error "variabl name '%name%' failed") else (%dk_call% dk_success "%name% = '!%name%!'")
::	%dk_call% dk_isVariableName %name% && %dk_call% dk_success "'%name%' is a valid variable name" || %dk_call% dk_info "'%name%' is NOT a valid variable name"

	set "name=____"
	set "%name%=PASSED"
	if "!%name%!" neq "PASSED" (%dk_call% dk_error "variabl name '%name%' failed") else (%dk_call% dk_success "%name% = '!%name%!'")
	%dk_call% dk_isVariableName %name% && %dk_call% dk_success "'%name%' is a valid variable name" || %dk_call% dk_info "'%name%' is NOT a valid variable name"

	set "name=____"
	set "%name%=PASSED"
	if "!%name%!" neq "PASSED" (%dk_call% dk_error "variabl name '%name%' failed") else (%dk_call% dk_success "%name% = '!%name%!'")
	%dk_call% dk_isVariableName %name% && %dk_call% dk_success "'%name%' is a valid variable name" || %dk_call% dk_info "'%name%' is NOT a valid variable name"

::	set "name=__CR__"
::	set "%name%=PASSED"
::	if "!%name%!" neq "PASSED" (%dk_call% dk_error "variabl name '%name%' failed") else (%dk_call% dk_success "%name% = '!%name%!'")
::	%dk_call% dk_isVariableName %name% && %dk_call% dk_success "'%name%' is a valid variable name" || %dk_call% dk_info "'%name%' is NOT a valid variable name"

	set "name=____"
	set "%name%=PASSED"
	if "!%name%!" neq "PASSED" (%dk_call% dk_error "variabl name '%name%' failed") else (%dk_call% dk_success "%name% = '!%name%!'")
	%dk_call% dk_isVariableName %name% && %dk_call% dk_success "'%name%' is a valid variable name" || %dk_call% dk_info "'%name%' is NOT a valid variable name"

	set "name=____"
	set "%name%=PASSED"
	if "!%name%!" neq "PASSED" (%dk_call% dk_error "variabl name '%name%' failed") else (%dk_call% dk_success "%name% = '!%name%!'")
	%dk_call% dk_isVariableName %name% && %dk_call% dk_success "'%name%' is a valid variable name" || %dk_call% dk_info "'%name%' is NOT a valid variable name"

	set "name=____"
	set "%name%=PASSED"
	if "!%name%!" neq "PASSED" (%dk_call% dk_error "variabl name '%name%' failed") else (%dk_call% dk_success "%name% = '!%name%!'")
	%dk_call% dk_isVariableName %name% && %dk_call% dk_success "'%name%' is a valid variable name" || %dk_call% dk_info "'%name%' is NOT a valid variable name"

	set "name=____"
	set "%name%=PASSED"
	if "!%name%!" neq "PASSED" (%dk_call% dk_error "variabl name '%name%' failed") else (%dk_call% dk_success "%name% = '!%name%!'")
	%dk_call% dk_isVariableName %name% && %dk_call% dk_success "'%name%' is a valid variable name" || %dk_call% dk_info "'%name%' is NOT a valid variable name"

	set "name=____"
	set "%name%=PASSED"
	if "!%name%!" neq "PASSED" (%dk_call% dk_error "variabl name '%name%' failed") else (%dk_call% dk_success "%name% = '!%name%!'")
	%dk_call% dk_isVariableName %name% && %dk_call% dk_success "'%name%' is a valid variable name" || %dk_call% dk_info "'%name%' is NOT a valid variable name"

	set "name=____"
	set "%name%=PASSED"
	if "!%name%!" neq "PASSED" (%dk_call% dk_error "variabl name '%name%' failed") else (%dk_call% dk_success "%name% = '!%name%!'")
	%dk_call% dk_isVariableName %name% && %dk_call% dk_success "'%name%' is a valid variable name" || %dk_call% dk_info "'%name%' is NOT a valid variable name"

	set "name=____"
	set "%name%=PASSED"
	if "!%name%!" neq "PASSED" (%dk_call% dk_error "variabl name '%name%' failed") else (%dk_call% dk_success "%name% = '!%name%!'")
	%dk_call% dk_isVariableName %name% && %dk_call% dk_success "'%name%' is a valid variable name" || %dk_call% dk_info "'%name%' is NOT a valid variable name"

	set "name=____"
	set "%name%=PASSED"
	if "!%name%!" neq "PASSED" (%dk_call% dk_error "variabl name '%name%' failed") else (%dk_call% dk_success "%name% = '!%name%!'")
	%dk_call% dk_isVariableName %name% && %dk_call% dk_success "'%name%' is a valid variable name" || %dk_call% dk_info "'%name%' is NOT a valid variable name"

	set "name=____"
	set "%name%=PASSED"
	if "!%name%!" neq "PASSED" (%dk_call% dk_error "variabl name '%name%' failed") else (%dk_call% dk_success "%name% = '!%name%!'")
	%dk_call% dk_isVariableName %name% && %dk_call% dk_success "'%name%' is a valid variable name" || %dk_call% dk_info "'%name%' is NOT a valid variable name"

	set "name=____"
	set "%name%=PASSED"
	if "!%name%!" neq "PASSED" (%dk_call% dk_error "variabl name '%name%' failed") else (%dk_call% dk_success "%name% = '!%name%!'")
	%dk_call% dk_isVariableName %name% && %dk_call% dk_success "'%name%' is a valid variable name" || %dk_call% dk_info "'%name%' is NOT a valid variable name"

	set "name=____"
	set "%name%=PASSED"
	if "!%name%!" neq "PASSED" (%dk_call% dk_error "variabl name '%name%' failed") else (%dk_call% dk_success "%name% = '!%name%!'")
	%dk_call% dk_isVariableName %name% && %dk_call% dk_success "'%name%' is a valid variable name" || %dk_call% dk_info "'%name%' is NOT a valid variable name"

	set "name=____"
	set "%name%=PASSED"
	if "!%name%!" neq "PASSED" (%dk_call% dk_error "variabl name '%name%' failed") else (%dk_call% dk_success "%name% = '!%name%!'")
	%dk_call% dk_isVariableName %name% && %dk_call% dk_success "'%name%' is a valid variable name" || %dk_call% dk_info "'%name%' is NOT a valid variable name"

	set "name=____"
	set "%name%=PASSED"
	if "!%name%!" neq "PASSED" (%dk_call% dk_error "variabl name '%name%' failed") else (%dk_call% dk_success "%name% = '!%name%!'")
	%dk_call% dk_isVariableName %name% && %dk_call% dk_success "'%name%' is a valid variable name" || %dk_call% dk_info "'%name%' is NOT a valid variable name"

	set "name=____"
	set "%name%=PASSED"
	if "!%name%!" neq "PASSED" (%dk_call% dk_error "variabl name '%name%' failed") else (%dk_call% dk_success "%name% = '!%name%!'")
	%dk_call% dk_isVariableName %name% && %dk_call% dk_success "'%name%' is a valid variable name" || %dk_call% dk_info "'%name%' is NOT a valid variable name"

	set "name=____"
	set "%name%=PASSED"
	if "!%name%!" neq "PASSED" (%dk_call% dk_error "variabl name '%name%' failed") else (%dk_call% dk_success "%name% = '!%name%!'")
	%dk_call% dk_isVariableName %name% && %dk_call% dk_success "'%name%' is a valid variable name" || %dk_call% dk_info "'%name%' is NOT a valid variable name"

	set "name=____"
	set "%name%=PASSED"
	if "!%name%!" neq "PASSED" (%dk_call% dk_error "variabl name '%name%' failed") else (%dk_call% dk_success "%name% = '!%name%!'")
	%dk_call% dk_isVariableName %name% && %dk_call% dk_success "'%name%' is a valid variable name" || %dk_call% dk_info "'%name%' is NOT a valid variable name"

	set "name=____"
	set "%name%=PASSED"
	if "!%name%!" neq "PASSED" (%dk_call% dk_error "variabl name '%name%' failed") else (%dk_call% dk_success "%name% = '!%name%!'")
	%dk_call% dk_isVariableName %name% && %dk_call% dk_success "'%name%' is a valid variable name" || %dk_call% dk_info "'%name%' is NOT a valid variable name"

	set "name=____"
	set "%name%=PASSED"
	if "!%name%!" neq "PASSED" (%dk_call% dk_error "variabl name '%name%' failed") else (%dk_call% dk_success "%name% = '!%name%!'")
	%dk_call% dk_isVariableName %name% && %dk_call% dk_success "'%name%' is a valid variable name" || %dk_call% dk_info "'%name%' is NOT a valid variable name"

	set "name=__ __"
	set "%name%=PASSED"
	if "!%name%!" neq "PASSED" (%dk_call% dk_error "variabl name '%name%' failed") else (%dk_call% dk_success "%name% = '!%name%!'")
	%dk_call% dk_isVariableName %name% && %dk_call% dk_success "'%name%' is a valid variable name" || %dk_call% dk_info "'%name%' is NOT a valid variable name"

	set "name=__!__"
	set "%name%=PASSED"
	if "!%name%!" neq "PASSED" (%dk_call% dk_error "variabl name '%name%' failed") else (%dk_call% dk_success "%name% = '!%name%!'")
	%dk_call% dk_isVariableName %name% && %dk_call% dk_success "'%name%' is a valid variable name" || %dk_call% dk_info "'%name%' is NOT a valid variable name"

	set "name=__^"__"
	set "%name%=PASSED"
	if "!%name%!" neq "PASSED" (%dk_call% dk_error "variabl name '%name%' failed") else (%dk_call% dk_success "%name% = '!%name%!'")
	%dk_call% dk_isVariableName %name% && %dk_call% dk_success "'%name%' is a valid variable name" || %dk_call% dk_info "'%name%' is NOT a valid variable name"

	set "name=__#__"
	set "%name%=PASSED"
	if "!%name%!" neq "PASSED" (%dk_call% dk_error "variabl name '%name%' failed") else (%dk_call% dk_success "%name% = '!%name%!'")
	%dk_call% dk_isVariableName %name% && %dk_call% dk_success "'%name%' is a valid variable name" || %dk_call% dk_info "'%name%' is NOT a valid variable name"

	set "name=__$__"
	set "%name%=PASSED"
	if "!%name%!" neq "PASSED" (%dk_call% dk_error "variabl name '%name%' failed") else (%dk_call% dk_success "%name% = '!%name%!'")
	%dk_call% dk_isVariableName %name% && %dk_call% dk_success "'%name%' is a valid variable name" || %dk_call% dk_info "'%name%' is NOT a valid variable name"

	set "name=__%%__"
	set "%name%=PASSED"
	if "!%name%!" neq "PASSED" (%dk_call% dk_error "variabl name '%name%' failed") else (%dk_call% dk_success "%name% = '!%name%!'")
	%dk_call% dk_isVariableName %name% && %dk_call% dk_success "'%name%' is a valid variable name" || %dk_call% dk_info "'%name%' is NOT a valid variable name"

	set "name=__^&__"
	set "%name%=PASSED"
	if "!%name%!" neq "PASSED" (%dk_call% dk_error "variabl name '%name%' failed") else (%dk_call% dk_success "%name% = '!%name%!'")
	%dk_call% dk_isVariableName %name% && %dk_call% dk_success "'%name%' is a valid variable name" || %dk_call% dk_info "'%name%' is NOT a valid variable name"

	set "name=__'__"
	set "%name%=PASSED"
	if "!%name%!" neq "PASSED" (%dk_call% dk_error "variabl name '%name%' failed") else (%dk_call% dk_success "%name% = '!%name%!'")
	%dk_call% dk_isVariableName %name% && %dk_call% dk_success "'%name%' is a valid variable name" || %dk_call% dk_info "'%name%' is NOT a valid variable name"

	set "name=__(__"
	set "%name%=PASSED"
	if "!%name%!" neq "PASSED" (%dk_call% dk_error "variabl name '%name%' failed") else (%dk_call% dk_success "%name% = '!%name%!'")
	%dk_call% dk_isVariableName %name% && %dk_call% dk_success "'%name%' is a valid variable name" || %dk_call% dk_info "'%name%' is NOT a valid variable name"

	set "name=__)__"
	set "%name%=PASSED"
	if "!%name%!" neq "PASSED" (%dk_call% dk_error "variabl name '%name%' failed") else (%dk_call% dk_success "%name% = '!%name%!'")
	%dk_call% dk_isVariableName %name% && %dk_call% dk_success "'%name%' is a valid variable name" || %dk_call% dk_info "'%name%' is NOT a valid variable name"

	set "name=__*__"
	set "%name%=PASSED"
	if "!%name%!" neq "PASSED" (%dk_call% dk_error "variabl name '%name%' failed") else (%dk_call% dk_success "%name% = '!%name%!'")
	%dk_call% dk_isVariableName %name% && %dk_call% dk_success "'%name%' is a valid variable name" || %dk_call% dk_info "'%name%' is NOT a valid variable name"

	set "name=__+__"
	set "%name%=PASSED"
	if "!%name%!" neq "PASSED" (%dk_call% dk_error "variabl name '%name%' failed") else (%dk_call% dk_success "%name% = '!%name%!'")
	%dk_call% dk_isVariableName %name% && %dk_call% dk_success "'%name%' is a valid variable name" || %dk_call% dk_info "'%name%' is NOT a valid variable name"

	set "name=____"
	set "%name%=PASSED"
	if "!%name%!" neq "PASSED" (%dk_call% dk_error "variabl name '%name%' failed") else (%dk_call% dk_success "%name% = '!%name%!'")
	%dk_call% dk_isVariableName %name% && %dk_call% dk_success "'%name%' is a valid variable name" || %dk_call% dk_info "'%name%' is NOT a valid variable name"

	set "name=____"
	set "%name%=PASSED"
	if "!%name%!" neq "PASSED" (%dk_call% dk_error "variabl name '%name%' failed") else (%dk_call% dk_success "%name% = '!%name%!'")
	%dk_call% dk_isVariableName %name% && %dk_call% dk_success "'%name%' is a valid variable name" || %dk_call% dk_info "'%name%' is NOT a valid variable name"

	set "name=____"
	set "%name%=PASSED"
	if "!%name%!" neq "PASSED" (%dk_call% dk_error "variabl name '%name%' failed") else (%dk_call% dk_success "%name% = '!%name%!'")
	%dk_call% dk_isVariableName %name% && %dk_call% dk_success "'%name%' is a valid variable name" || %dk_call% dk_info "'%name%' is NOT a valid variable name"

	set "name=____"
	set "%name%=PASSED"
	if "!%name%!" neq "PASSED" (%dk_call% dk_error "variabl name '%name%' failed") else (%dk_call% dk_success "%name% = '!%name%!'")
	%dk_call% dk_isVariableName %name% && %dk_call% dk_success "'%name%' is a valid variable name" || %dk_call% dk_info "'%name%' is NOT a valid variable name"

	set "name=____"
	set "%name%=PASSED"
	if "!%name%!" neq "PASSED" (%dk_call% dk_error "variabl name '%name%' failed") else (%dk_call% dk_success "%name% = '!%name%!'")
	%dk_call% dk_isVariableName %name% && %dk_call% dk_success "'%name%' is a valid variable name" || %dk_call% dk_info "'%name%' is NOT a valid variable name"

	set "name=____"
	set "%name%=PASSED"
	if "!%name%!" neq "PASSED" (%dk_call% dk_error "variabl name '%name%' failed") else (%dk_call% dk_success "%name% = '!%name%!'")
	%dk_call% dk_isVariableName %name% && %dk_call% dk_success "'%name%' is a valid variable name" || %dk_call% dk_info "'%name%' is NOT a valid variable name"

	set "name=____"
	set "%name%=PASSED"
	if "!%name%!" neq "PASSED" (%dk_call% dk_error "variabl name '%name%' failed") else (%dk_call% dk_success "%name% = '!%name%!'")
	%dk_call% dk_isVariableName %name% && %dk_call% dk_success "'%name%' is a valid variable name" || %dk_call% dk_info "'%name%' is NOT a valid variable name"

	set "name=____"
	set "%name%=PASSED"
	if "!%name%!" neq "PASSED" (%dk_call% dk_error "variabl name '%name%' failed") else (%dk_call% dk_success "%name% = '!%name%!'")
	%dk_call% dk_isVariableName %name% && %dk_call% dk_success "'%name%' is a valid variable name" || %dk_call% dk_info "'%name%' is NOT a valid variable name"

	set "name=____"
	set "%name%=PASSED"
	if "!%name%!" neq "PASSED" (%dk_call% dk_error "variabl name '%name%' failed") else (%dk_call% dk_success "%name% = '!%name%!'")
	%dk_call% dk_isVariableName %name% && %dk_call% dk_success "'%name%' is a valid variable name" || %dk_call% dk_info "'%name%' is NOT a valid variable name"

	set "name=____"
	set "%name%=PASSED"
	if "!%name%!" neq "PASSED" (%dk_call% dk_error "variabl name '%name%' failed") else (%dk_call% dk_success "%name% = '!%name%!'")
	%dk_call% dk_isVariableName %name% && %dk_call% dk_success "'%name%' is a valid variable name" || %dk_call% dk_info "'%name%' is NOT a valid variable name"

	set "name=____"
	set "%name%=PASSED"
	if "!%name%!" neq "PASSED" (%dk_call% dk_error "variabl name '%name%' failed") else (%dk_call% dk_success "%name% = '!%name%!'")
	%dk_call% dk_isVariableName %name% && %dk_call% dk_success "'%name%' is a valid variable name" || %dk_call% dk_info "'%name%' is NOT a valid variable name"

	set "name=____"
	set "%name%=PASSED"
	if "!%name%!" neq "PASSED" (%dk_call% dk_error "variabl name '%name%' failed") else (%dk_call% dk_success "%name% = '!%name%!'")
	%dk_call% dk_isVariableName %name% && %dk_call% dk_success "'%name%' is a valid variable name" || %dk_call% dk_info "'%name%' is NOT a valid variable name"

	set "name=____"
	set "%name%=PASSED"
	if "!%name%!" neq "PASSED" (%dk_call% dk_error "variabl name '%name%' failed") else (%dk_call% dk_success "%name% = '!%name%!'")
	%dk_call% dk_isVariableName %name% && %dk_call% dk_success "'%name%' is a valid variable name" || %dk_call% dk_info "'%name%' is NOT a valid variable name"

	set "name=____"
	set "%name%=PASSED"
	if "!%name%!" neq "PASSED" (%dk_call% dk_error "variabl name '%name%' failed") else (%dk_call% dk_success "%name% = '!%name%!'")
	%dk_call% dk_isVariableName %name% && %dk_call% dk_success "'%name%' is a valid variable name" || %dk_call% dk_info "'%name%' is NOT a valid variable name"

	set "name=____"
	set "%name%=PASSED"
	if "!%name%!" neq "PASSED" (%dk_call% dk_error "variabl name '%name%' failed") else (%dk_call% dk_success "%name% = '!%name%!'")
	%dk_call% dk_isVariableName %name% && %dk_call% dk_success "'%name%' is a valid variable name" || %dk_call% dk_info "'%name%' is NOT a valid variable name"

	set "name=____"
	set "%name%=PASSED"
	if "!%name%!" neq "PASSED" (%dk_call% dk_error "variabl name '%name%' failed") else (%dk_call% dk_success "%name% = '!%name%!'")
	%dk_call% dk_isVariableName %name% && %dk_call% dk_success "'%name%' is a valid variable name" || %dk_call% dk_info "'%name%' is NOT a valid variable name"

	set "name=____"
	set "%name%=PASSED"
	if "!%name%!" neq "PASSED" (%dk_call% dk_error "variabl name '%name%' failed") else (%dk_call% dk_success "%name% = '!%name%!'")
	%dk_call% dk_isVariableName %name% && %dk_call% dk_success "'%name%' is a valid variable name" || %dk_call% dk_info "'%name%' is NOT a valid variable name"
%endfunction%
