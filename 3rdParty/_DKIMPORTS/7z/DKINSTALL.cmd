@echo off&::###### DK.cmd #########################################################################################################################
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# DKINSTALL
::#
:DKINSTALL
::%setlocal%
    %dk_call% dk_debugFunc 0
	
	%dk_call% dk_import
	
	set "_7ZA_EXE=%PLUGIN.Install.Path%/7za.exe"
	%dk_call% dk_assertPath "%_7ZA_EXE%"
%endfunction%
