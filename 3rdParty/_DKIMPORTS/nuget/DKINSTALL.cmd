@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::####################################################################
::# DKINSTALL()
::#
:DKINSTALL
::setlocal
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_validate host_triple "%dk_call% dk_host_triple"
	if defined win_host		(set "NUGET_DL=https://dist.nuget.org/win-x86-commandline/latest/nuget.exe")
	if not defined NUGET_DL	(%dk_call% dk_error "NUGET_DL is invalid")

	%dk_call% dk_importVariables %NUGET_DL% IMPORT_PATH "%DKIMPORTS_DIR%/nuget" ROOT "%DK3RDPARTY_DIR%"
	%dk_call% dk_set NUGET_EXE "%NUGET%/nuget.exe"
	
	if exist "%NUGET_EXE%" (%return%)
	%dk_call% dk_echo   
    %dk_call% dk_info "Installing nuget . . ."
    %dk_call% dk_download %NUGET_DL%
	%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DKDOWNLOAD_DIR"
	%dk_call% dk_copy "%DKDOWNLOAD_DIR%/nuget.exe" "%NUGET_EXE%"
	if NOT exist "%NUGET_EXE%" (%dk_call% dk_error "cannot find NUGET_EXE:%NUGET_EXE%")
	"%NUGET_EXE%"
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
	
	%dk_call% DKINSTALL
%endfunction%
