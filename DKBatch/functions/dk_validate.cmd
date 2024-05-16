@echo off
call DK

::################################################################################
::# dk_validate(<variable> <code>)
::#
::#    Check if a variable is valid, otherwise run the function that defines said variable.
::#
:dk_validate () {
	call dk_debugFunc
	if %__ARGC__% NEQ 2 (dk_error "%__FUNCTION__%(): incorrect number of arguments")

	if defined %~1 if "%~1" neq "" (goto:eof)
	call %~2
	
	if not defined %~1 dk_error "dk_validate was unable to set the variable with the code provided"
	if "%~1"=="" dk_error "dk_validate called the code requested, but the variable is still empty"
	
	
goto:eof







:DKTEST ########################################################################

call dk_validate DIGITALKNOB_DIR dk_getDKPaths
echo DIGITALKNOB_DIR = %DIGITALKNOB_DIR%
echo DKDOWNLOAD_DIR = %DKDOWNLOAD_DIR%