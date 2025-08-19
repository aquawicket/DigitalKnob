@echo off&::###### DK.cmd #########################################################################################################################
if NOT exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# DKINSTALL()
::#
:DKINSTALL
::%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_validate Host_Tuple "%dk_call% dk_Host_Tuple"
	if defined win_host		(set "NUGET_DL=https://dist.nuget.org/win-x86-commandline/latest/nuget.exe")
	if NOT defined NUGET_DL	(%dk_call% dk_error "NUGET_DL is invalid")

	%dk_call% dk_importVariables %NUGET_DL% IMPORT_PATH "%DKIMPORTS_DIR%/nuget" ROOT "%DK3RDPARTY_DIR%"
	%dk_call% dk_set NUGET_EXE "%NUGET%/nuget.exe"
	
	if exist "%NUGET_EXE%" (%return%)
	%dk_call% dk_echo  
    %dk_call% dk_info "Installing nuget . . ."
    %dk_call% dk_download %NUGET_DL%
	%dk_call% dk_copy "%dk_download%" "%NUGET_EXE%"
	%dk_call% dk_assertPath NUGET_EXE
	"%NUGET_EXE%"
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% DKINSTALL
%endfunction%
