@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::################################################################################
::# dk_validate(variable, code)
::#
::#    Check if a variable is valid, otherwise run code to validate the variable
::#
:dk_validate
	call dk_debugFunc 2

	if defined %~1 if "%~1" neq "" (goto:eof)     &:: if the variable is already valid, return
	
	call dk_stringContains "%~2" "call" || call dk_error "dk_validate parameter 2 requires the use of call"
	::call %~2
	%~2
	
	if not defined %~1 dk_error "dk_validate was unable to set the variable with the code provided"
	if "%~1"=="" dk_error "dk_validate called the code requested, but the variable is still invalid"
	call dk_printVar "%~1"
goto:eof






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
    call dk_validate DIGITALKNOB_DIR "call dk_getDKPaths"
    echo DIGITALKNOB_DIR = %DIGITALKNOB_DIR%
    echo DKTOOLS_DIR = %DKTOOLS_DIR%
    echo DKDOWNLOAD_DIR = %DKDOWNLOAD_DIR%
goto:eof
