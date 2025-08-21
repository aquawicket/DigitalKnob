@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::############################################################################
::# dk_deleteEmptyDirs(base_path)
::#
::#
:dk_deleteEmptyDirs
%setlocal%
	%dk_call% dk_debugFunc 1
	
	echo deleting all empty directories in %~1
	%dk_call% dk_confirm || (%return%)

	for /f "delims=" %%d in ('dir "%~1" /ad /b /s ^| sort /r') do @(dir /a-d /b "%%d" | findstr "." > nul || rd /s /q "%%d")
%endfunction%











::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_selectFolder
	%dk_call% dk_deleteEmptyDirs "%dk_selectFolder%"
	
%endfunction%

