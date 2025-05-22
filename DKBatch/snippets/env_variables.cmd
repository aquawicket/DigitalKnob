@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


echo %0(%*)

:::::: Load DK Function files (DK_INIT) ::::::
call ../functions/DK.cmd

:main
	:: Get the PATH environment variable from registry
	call dk_registryGetKey HKCU\Environment PATH PATH_VALUE
	echo PATH_VALUE = %PATH_VALUE%
	echo:
	pause
	
	:: Delete the PATH environment variable from registry
	::call dk_delete_registry_key HKCU\Environment PATH
	echo:
	pause
	
	:: Set the PATH environment variable from registry
	::call dk_registrySetKey HKCU\Environment PATH REG_EXPAND_SZ %PATH_VALUE%
	echo:
	pause
%endfunction%
