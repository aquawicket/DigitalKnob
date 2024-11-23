@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ set "DKBATCH_FUNCTIONS_DIR_=..\..\..\DKBatch\functions\"
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*


::####################################################################
::# dk_installNuget()
::#
:dk_installNuget
	call dk_debugFunc 0
	
	
	%dk_call% dk_validate host_triple "%dk_call% dk_host_triple"
	if defined win_host               set "NUGET_DL=https://dist.nuget.org/win-x86-commandline/latest/nuget.exe"
	if not defined NUGET_DL           %dk_call% dk_error "NUGET_DL is invalid"

	%dk_call% dk_basename %NUGET_DL% NUGET_DL_FILE
	%dk_call% dk_removeExtension %NUGET_DL_FILE% NUGET_FOLDER
	::%dk_call% dk_convertToCIdentifier %NUGET_FOLDER% NUGET_FOLDER
	%dk_call% dk_toLower %NUGET_FOLDER% NUGET_FOLDER
	
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	%dk_call% dk_set NUGET %DKTOOLS_DIR%\%NUGET_FOLDER%
	%dk_call% dk_set NUGET_EXE %NUGET%\nuget.exe
	
	if exist "%NUGET_EXE%" goto nuget_installed
	%dk_call% dk_echo   
    %dk_call% dk_info "Installing nuget . . ."
    %dk_call% dk_download %NUGET_DL%
	%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DKDOWNLOAD_DIR"
    %dk_call% dk_smartExtract "%DKDOWNLOAD_DIR%\%NUGET_DL_FILE%" "%NUGET%"
	if NOT exist "%NUGET_EXE%" %dk_call% dk_error "cannot find NUGET_EXE:%NUGET_EXE%"
	:notepadpp_installed
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	%dk_call% dk_installNuget
%endfunction%
