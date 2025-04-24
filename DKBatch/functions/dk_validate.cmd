<<<<<<< HEAD
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

 if defined %~1 (%return%)
::################################################################################
::# dk_validate(variable, code)
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::################################################################################
::# dk_validate(variable, code) NO_HALT
>>>>>>> Development
::#
::#    Check if a variable is valid, otherwise run code to validate the variable
::#
:dk_validate
<<<<<<< HEAD
    call dk_debugFunc 2
:: setlocal

    %dk_call% dk_stringContains "%~2" "call" || %dk_call% dk_error "dk_validate parameter 2 requires the use of call"
    %~2
    
    if not defined %~1 dk_error "dk_validate was unable to set the variable:%~1 with the code provided"
    
::%DEBUG%
::    %dk_call% dk_printVar "%~1"
=======
::setlocal
	%dk_call% dk_debugFunc 2

	if defined %~1 (dk_return)

	::echo %~2
	%~2

	if "%~3" equ "NO_HALT"	(dk_return)
	if not defined %~1	(%dk_call% dk_error "dk_validate was unable to set the variable:%~1 with the code provided")
>>>>>>> Development
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
<<<<<<< HEAD
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_validate DIGITALKNOB_DIR "%dk_call% dk_DIGITALKNOB_DIR"
    %dk_call% dk_echo "DIGITALKNOB_DIR = %DIGITALKNOB_DIR%"
	
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DIGITALKNOB_DIR"
    %dk_call% dk_echo "DKTOOLS_DIR = %DKTOOLS_DIR%"
	
	%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DIGITALKNOB_DIR"
    %dk_call% dk_echo "DKDOWNLOAD_DIR = %DKDOWNLOAD_DIR%"
=======
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_validate DIGITALKNOB_DIR "%dk_call% dk_DIGITALKNOB_DIR"
	%dk_call% dk_echo "DIGITALKNOB_DIR = %DIGITALKNOB_DIR%"

	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	%dk_call% dk_echo "DKTOOLS_DIR = %DKTOOLS_DIR%"

	%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DKDOWNLOAD_DIR"
	%dk_call% dk_echo "DKDOWNLOAD_DIR = %DKDOWNLOAD_DIR%"

	%dk_call% dk_validate TESTABC "%dk_call% dk_testB"
>>>>>>> Development
%endfunction%
