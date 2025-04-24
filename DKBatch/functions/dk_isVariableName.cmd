<<<<<<< HEAD
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################

>>>>>>> Development

::####################################################################
::# dk_isVariableName(string rtn_var)
::#
::#  https://stackoverflow.com/a/17584764
::#
<<<<<<< HEAD
:dk_isVariableName
    call dk_debugFunc 1 2
 setlocal
 
    ::set "arg1=%~1"
    ::if defined "%~1" call set "arg1=%%%arg1%%%"
    set "var="&for /f "delims=0123456789_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ[]" %%i in ("%~1") do set "bad_characters=%%i"

    if not defined bad_characters (
        set "bad_characters="
        if "%~2" neq "" (endlocal & set "%2=true")
        exit /b 0
    )
    
    set "bad_characters="
    if "%~2" neq "" (endlocal & call set "%2=false")
    exit /b 1
=======
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
>>>>>>> Development
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
<<<<<<< HEAD
    call dk_debugFunc 0
 setlocal

    %dk_call% dk_isVariableName 69         && %dk_call% dk_info "is a valid variable name" || %dk_call% dk_info "is NOT a valid variable name"
    set "myNumber=42"
    %dk_call% dk_isVariableName %myNumber% && %dk_call% dk_info "is a valid variable name" || %dk_call% dk_info "is NOT a valid variable name"
    %dk_call% dk_isVariableName myNumber   && %dk_call% dk_info "is a valid variable name" || %dk_call% dk_info "is NOT a valid variable name"  &:: FIXME
    %dk_call% dk_isVariableName 0          && %dk_call% dk_info "is a valid variable name" || %dk_call% dk_info "is NOT a valid variable name"
    %dk_call% dk_isVariableName 1          && %dk_call% dk_info "is a valid variable name" || %dk_call% dk_info "is NOT a valid variable name"
    %dk_call% dk_isVariableName 1.23       && %dk_call% dk_info "is a valid variable name" || %dk_call% dk_info "is NOT a valid variable name"
    %dk_call% dk_isVariableName -42        && %dk_call% dk_info "is a valid variable name" || %dk_call% dk_info "is NOT a valid variable name"
    %dk_call% dk_isVariableName "36"       && %dk_call% dk_info "is a valid variable name" || %dk_call% dk_info "is NOT a valid variable name"
    
    %dk_call% dk_isVariableName "36a"      && %dk_call% dk_info "is a valid variable name" || %dk_call% dk_info "is NOT a valid variable name"
    %dk_call% dk_isVariableName word       && %dk_call% dk_info "is a valid variable name" || %dk_call% dk_info "is NOT a valid variable name"
    %dk_call% dk_isVariableName 123456789  && %dk_call% dk_info "is a valid variable name" || %dk_call% dk_info "is NOT a valid variable name"
    %dk_call% dk_isVariableName myArray[0] && %dk_call% dk_info "is a valid variable name" || %dk_call% dk_info "is NOT a valid variable name"
=======
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
>>>>>>> Development
%endfunction%
