@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::################################################################################
::# dk_importVars()
::#
::#
:dk_importVars
::%setlocal%
	%dk_call% dk_debugFunc 0
	%dk_call% dk_echo "IMPORTING VARIABLES ......"
	%dk_call% dk_assertPath DKCACHE_DIR
	if not exist "%DKCACHE_DIR%/DKEXPORT_VARS" (
		%dk_call% dk_notice "DKEXPORT_VARS not found.  Nothing imported"
		%return%
	)
	
	%dk_call% dk_rename "%DKCACHE_DIR%/DKEXPORT_VARS" "%DKCACHE_DIR%/DKEXPORT_VARS.cmd" OVERWRITE
::endlocal	
	%dk_call% "%DKCACHE_DIR%/DKEXPORT_VARS.cmd"
	::type "%DKCACHE_DIR%/DKEXPORT_VARS.cmd"
	
::	set "saveFile=DKEXPORT_VARS.cmd.%TIME%"
::	set "saveFile=%saveFile::=_%"

	::del "%DKCACHE_DIR%/DKEXPORT_VARS.cmd"
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_importVars
%endfunction%
