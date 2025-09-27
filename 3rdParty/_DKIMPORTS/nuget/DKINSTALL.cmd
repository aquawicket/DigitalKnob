@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# DKINSTALL()
::#
:DKINSTALL
::%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_validate Host_Tuple "%dk_call% dk_Host_Tuple"
	if defined win_host		(set "nuget_Import=https://dist.nuget.org/win-x86-commandline/latest/nuget.exe")
	if NOT defined nuget_Import	(%dk_call% dk_error "nuget_Import is invalid")

	%dk_call% dk_importVariables %nuget_Import% IMPORT_PATH "%DKIMPORTS_DIR%/nuget" ROOT "%DK3RDPARTY_DIR%"
	%dk_call% dk_set nuget_exe "%NUGET%/nuget.exe"
	
	if EXIST "%nuget_exe%" (%return%)
	%dk_call% dk_echo  
    %dk_call% dk_info "Installing nuget . . ."
    %dk_call% dk_download %nuget_Import%
	%dk_call% dk_copy "%dk_download%" "%nuget_exe%"
	%dk_call% dk_assertPath nuget_exe
	"%nuget_exe%"
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% DKINSTALL
%endfunction%
