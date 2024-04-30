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
	::if "%2"==""  call dk_error "parameter 2 is invalid"

	if defined %1 (goto:eof)
	call %2
goto:eof







:DKTEST ########################################################################

call dk_validate DIGITALKNOB_DIR dk_getDKPaths
echo DIGITALKNOB_DIR = %DIGITALKNOB_DIR%
echo DKDOWNLOAD_DIR = %DKDOWNLOAD_DIR%