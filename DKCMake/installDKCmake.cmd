@echo off

if not "%~1" == "" (goto:runDKCMake)
:installDKCMake
	::###### DKINIT ######
	call "..\DKBatch\functions\DK.cmd"
	
	::###### Install DKBash ######
	call dk_echo "Installing DKCmake . . ."
	call dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.cmake"
	if not defined DKIMPORTS_DIR call dk_validateBranch
	if not defined CMAKE_EXE call "%DKIMPORTS_DIR%\cmake\dk_installCmake"
	
	call dk_registryDeleteKey "HKEY_CLASSES_ROOT\DKCmake"
	ftype DKCmake=cmd /c call "%~f0" "%CMAKE_EXE%" "%DKCMAKE_FUNCTIONS_DIR%" "%%1" %*
	call dk_registrySetKey "HKEY_CLASSES_ROOT\DKCmake\DefaultIcon" "" "REG_SZ" "%CMAKE%\bin\cmake-gui.exe"
	
	call dk_registryDeleteKey "HKEY_CLASSES_ROOT\.cmake"
	call dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.cmake"
	assoc .cmake=DKCmake

	call dk_echo "DKCmake install complete"
goto:eof


:runDKCMake
	set "CMAKE_EXE=%~1"
	set "DKCMAKE_FUNCTIONS_DIR=%~2"
	set "DKCMAKE_FUNCTIONS_DIR=%DKCMAKE_FUNCTIONS_DIR:\=/%"
	set "CMAKE_FILE=%~3"
	set "CMAKE_FILE=%CMAKE_FILE:\=/%"
    "%CMAKE_EXE%" -DQUEUE_BUILD=ON -DCLANG64=ON -DWIN_X86_64=ON -DEBUG=ON -DDKCMAKE_FUNCTIONS_DIR="%DKCMAKE_FUNCTIONS_DIR%" -P "%CMAKE_FILE%"
	
	::echo pause installDKCmake.cmd:34
	::pause
goto:eof