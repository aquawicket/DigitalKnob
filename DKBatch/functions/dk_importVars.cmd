@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0

::################################################################################
::# dk_importVars()
::#
::#
:dk_importVars
    call dk_debugFunc 0
:: setlocal

	%dk_call% dk_assert DKTEMP_DIR
	if not exist "%DKTEMP_DIR%\DKEXPORT_VARS" %dk_call% dk_notice "DKEXPORT_VARS not found.  Nothing imported" && exit /b %errorlevel%
	
	::%dk_call% dk_copy "%DKTEMP_DIR%\DKEXPORT_VARS" "%DKTEMP_DIR%\DKEXPORT_VARS.cmd"
	%dk_call% dk_rename "%DKTEMP_DIR%\DKEXPORT_VARS" "%DKTEMP_DIR%\DKEXPORT_VARS.cmd"
	call "%DKTEMP_DIR%\DKEXPORT_VARS.cmd"
	del "%DKTEMP_DIR%\DKEXPORT_VARS.cmd"
	::del "%DKTEMP_DIR%\DKEXPORT_VARS"
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
	%dk_call% dk_importVars
%endfunction%
