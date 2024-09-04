@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0

::################################################################################
::# dk_importVars()
::#
::#
:dk_importVars
:: setlocal
    call dk_debugFunc 0

	if not exist "%TEMP%\DKEXPORT_VARS" %dk_call% dk_notice "DKEXPORT_VARS not found.  Nothing imported" && exit /b %errorlevel%
	
	::%dk_call% dk_copy "%TEMP%\DKEXPORT_VARS" "%TEMP%\DKEXPORT_VARS.cmd"
	%dk_call% dk_rename "%TEMP%\DKEXPORT_VARS" "%TEMP%\DKEXPORT_VARS.cmd"
	call "%TEMP%\DKEXPORT_VARS.cmd"
	del "%TEMP%\DKEXPORT_VARS.cmd"
	::del "%TEMP%\DKEXPORT_VARS"
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
    call dk_debugFunc 0

	%dk_call% dk_importVars
%endfunction%
