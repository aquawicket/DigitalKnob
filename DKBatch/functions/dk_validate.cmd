@echo off
call dk_includeGuard
call DK

::################################################################################
::# dk_validate(<variable> <function>)
::#
::#    Check if a variable is valid, otherwise run the function that defines said variable.
::#
:dk_validate () {
	call dk_debugFunc
	::if "%1"==""  call dk_error "parameter 1 is invalid"
	if "%2"==""  call dk_error "parameter 2 is invalid"

	if defined %1 if "%1" NEQ "" (goto:eof)
	call %2
	
	if not defined %1 dk_error "dk_validate was unable to get the variable with the function provided"
	if "%1"=="" dk_error "dk_validate called the code requested, but the variable is still empty"
goto:eof







:DKTEST ########################################################################

call dk_validate DIGITALKNOB_DIR dk_getDKPaths
echo DIGITALKNOB_DIR = %DIGITALKNOB_DIR%
echo DKDOWNLOAD_DIR = %DKDOWNLOAD_DIR%