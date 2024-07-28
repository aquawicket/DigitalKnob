@echo off

if "%~1" neq "" (goto:runDKCpp)
:installDKCpp
	::###### DKINIT ######
	call "..\DKBatch\functions\DK.cmd"
	
	::###### Install DKBash ######
	call dk_echo "Installing DKCpp . . ."
	set "CL_EXE=%SystemRoot%\System32\cl.exe"
	set "DKCPP_FUNCTIONS_DIR=..\DKCpp\functions"
	
	call dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.cpp
	ftype DKCpp=cmd /c call "%~f0" "%DKCPP_FUNCTIONS_DIR%" "%CL_EXE%" "%%1" %*
	assoc .cpp=DKCpp
	call dk_registrySetKey "HKEY_CLASSES_ROOT\DKCpp\DefaultIcon" "" "REG_SZ" "%CL_EXE%"
	
	call dk_echo "DKCpp install complete"
	call dk_pause
goto:eof


:runDKCpp
	set "DKVB_FUNCTIONS_DIR=%~1"
	set "CL_EXE=%~2"
	set "DKCPP_FILE=%~3"
	start %CL_EXE% %DKCPP_FILE%
goto:eof