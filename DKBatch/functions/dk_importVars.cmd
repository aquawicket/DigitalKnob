@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0

::################################################################################
::# dk_importVars()
::#
::#
:dk_importVars
:: setlocal
    call dk_debugFunc 0

	if not exist "%TEMP%\DKEXPORT_VARS.cmd" %dk_call% dk_notice "DKEXPORT_VARS.cmd not found.  Nothing imported" && exit /b %errorlevel%
	
	call "%TEMP%\DKEXPORT_VARS.cmd" && del "%TEMP%\DKEXPORT_VARS.cmd"
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
    call dk_debugFunc 0

	%dk_call% dk_importVars
%endfunction%
