@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::### DEPEND ###
::%dk_call% dk_depend vc_redist   &::# for VCRUNTIME140.dll


::####################################################################
::# DKINSTALL
::#
:DKINSTALL
::setlocal
	%dk_call% dk_debugFunc 0
	::%dk_call% dk_depend vc_redist
	
	%dk_call% dk_import APP
	
	set "PHP_EXE=%PLUGIN.Install.Path%/php.exe"
	%dk_call% dk_assertFile PHP_EXE
%endfunction%
