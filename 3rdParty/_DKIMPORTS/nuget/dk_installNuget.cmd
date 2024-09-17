@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*


::####################################################################
::# dk_installNuget()
::#
:dk_installNuget
	call dk_debugFunc 0
	
	
	call dk_validate DK_HOST_OS "call dk_getHostTriple"
	if "%DK_HOST_OS%"=="win"     call dk_set NUGET_DL "https://dist.nuget.org/win-x86-commandline/latest/nuget.exe"
	if not defined NUGET_DL call dk_error "NUGET_DL is invalid"

	call dk_basename %NUGET_DL% NUGET_DL_FILE
	call dk_removeExtension %NUGET_DL_FILE% NUGET_FOLDER
	::call dk_convertToCIdentifier %NUGET_FOLDER% NUGET_FOLDER
	call dk_toLower %NUGET_FOLDER% NUGET_FOLDER
	
	call dk_validate DKTOOLS_DIR "call dk_setDKTOOLS_DIR"
	call dk_set NUGET %DKTOOLS_DIR%\%NUGET_FOLDER%
	call dk_set NUGET_EXE %NUGET%\nuget.exe
	
	if exist "%NUGET_EXE%" goto:nuget_installed
	call dk_echo   
    call dk_info "Installing nuget . . ."
    call dk_download %NUGET_DL%
    call dk_smartExtract "%DKDOWNLOAD_DIR%\%NUGET_DL_FILE%" "%NUGET%"
	if NOT exist "%NUGET_EXE%" call dk_error "cannot find NUGET_EXE:%NUGET_EXE%"
	:notepadpp_installed
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_installNuget
%endfunction%
