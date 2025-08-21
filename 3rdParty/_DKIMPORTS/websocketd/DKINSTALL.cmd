@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# DKINSTALL
::#
:DKINSTALL
%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_getFileParams	"%~dp0/dkconfig.txt"
	%dk_call% dk_basename "%~dp0" PLUGIN

	%dk_call% dk_validate Host_Tuple "%dk_call% dk_Host_Tuple"
	set "%PLUGIN%_Import=!%PLUGIN%_%Host_Tuple%_Import!"
	%dk_call% dk_assertVar %PLUGIN%_Import

	%dk_call% dk_importVariables !%PLUGIN%_Import! IMPORT_PATH %DKIMPORTS_DIR%\%PLUGIN%
	%dk_call% dk_assertVar %PLUGIN%

	set "WEBSOCKETD_EXE=!%PLUGIN%!/websocketd.exe"
	if EXIST "%WEBSOCKETD_EXE%" (goto:end)

	%dk_call% dk_download "!%PLUGIN%_Import!"
	%dk_call% dk_smartExtract "%dk_download%" "!%PLUGIN%!"
	%dk_call% dk_assertFile WEBSOCKETD_EXE
	
	:end
	endlocal & (
		set "WEBSOCKETD_EXE=%WEBSOCKETD_EXE%"
	)
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% DKINSTALL
%endfunction%