@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# DKINSTALL
::#
:DKINSTALL
::%setlocal%
    %dk_call% dk_debugFunc 0
	
	%dk_call% dk_import APP
	
	::%dk_call% dk_set 7za_exe "%PLUGIN_Install_Path%/7za.exe"
	set "7za_exe=%PLUGIN_Install_Path%/7za.exe"
	if NOT exist "%7za_exe%" (%dk_call% dk_fatal "7za_exe:%7za_exe% not found")

%endfunction%
