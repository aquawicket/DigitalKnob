@echo off
call "../../../DKBatch/functions/DK.cmd"


::####################################################################
::# dk_installNuget()
::#
:dk_installNuget () {
	call dk_debugFunc
	if %__ARGC__% NEQ 0 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	call dk_validate HOST_OS dk_getHostTriple
	if "%HOST_OS%"=="win"     call dk_set NUGET_DL "https://dist.nuget.org/win-x86-commandline/latest/nuget.exe"

	
	call dk_getFilename %NUGET_DL% NUGET_DL_FILE
	call dk_removeExtension %NUGET_DL_FILE% NUGET_NAME
	call dk_convertToCIdentifier %NUGET_NAME% NUGET_FOLDER
	call dk_validate DKTOOLS_DIR dk_getDKPaths
	call dk_set NUGET %DKTOOLS_DIR%\%NUGET_FOLDER%
	call dk_set NUGET_EXE %NUGET%\nuget.exe
	
	if exist "%NUGET_EXE%" goto:eof
	
	call dk_download %NUGET_DL% %DKDOWNLOAD_DIR%\%NUGET_DL_FILE%
	call dk_makeDirectory %NUGET%
	call dk_copy %DKDOWNLOAD_DIR%\%NUGET_DL_FILE% %NUGET%\%NUGET_DL_FILE% OVERWRITE
	
	if NOT exist "%NUGET_EXE%"  call dk_error "cannot find nuget"
	
	:: install via CMake
::  call dk_getDKPaths
::	call dk_validateBranch
::  call dk_cmakeEval "dk_load('%DKIMPORTS_DIR%/nuget/DKMAKE.cmake')" "NUGET_EXE"
::	call dk_printVar NUGET_EXE
goto:eof




:DKTEST ########################################################################

	call dk_installNuget