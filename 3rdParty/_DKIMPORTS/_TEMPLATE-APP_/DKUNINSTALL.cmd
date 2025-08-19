@echo off&::###### DK.cmd #########################################################################################################################
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# DKUNINSTALL
::#
:DKUNINSTALL
%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_getFileParams	"%~dp0/dkconfig.txt"
	%dk_call% dk_basename "%~dp0" PLUGIN
	%dk_call% dk_assertVar PLUGIN
	
	%dk_call% dk_validate Host_Tuple "%dk_call% dk_Host_Tuple"
	%dk_call% dk_assertVar Host_Tuple
	echo Host_Tuple = %Host_Tuple%
	echo %PLUGIN%_%Host_Tuple%_Import = !%PLUGIN%_%Host_Tuple%_Import!
		
	set "%PLUGIN%_Import=!%PLUGIN%_%Host_Tuple%_Import!"
	%dk_call% dk_assertVar %PLUGIN%_Import
	echo %PLUGIN%_Import = !%PLUGIN%_Import!

	%dk_call% dk_importVariables !%PLUGIN%_Import! IMPORT_PATH %DKIMPORTS_DIR%\%PLUGIN%
	%dk_call% dk_assertVar CURRENT_PLUGIN
	::set %CURRENT_PLUGIN%

	echo %dk_call% dk_delete "!%CURRENT_PLUGIN%!"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% DKUNINSTALL
%endfunction%



