@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::################################################################################
::# dk_getAttributes(<pathname>, <rtn_var>:optional)
::#
:dk_getAttributes
setlocal
	%dk_call% dk_debugFunc 2

	set "pathname=%1"
	set "pathname=%pathname:"=%"
	set "pathname=%pathname:/=\%"
	if "%pathname:~-1%"=="\"   set "pathname=%pathname:~0,-1%"

	for %%Z in ("%pathname%") do set "dk_getAttributes=%%~aZ"
::	set "dk_getAttributes=%dk_getAttributes:\=/%"

	endlocal & (
		set "dk_getAttributes=%dk_getAttributes%"
		if "%2" neq "" set "%2=%dk_getAttributes%"
	)	
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_set myPath "DK.cmd"
	%dk_call% dk_set myPath "DK.cmd"
	%dk_call% dk_getAttributes "%myPath%" attributes
	%dk_call% dk_printVar attributes
%endfunction%
