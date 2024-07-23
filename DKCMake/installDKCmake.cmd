@echo off

:installDKCMake
	if not "%~1" == "" (goto:runDKCMake)
	echo Associating .cmake files with DKCmake . . .
	
	::###### DKINIT ######
	set "DKBATCH_FUNCTIONS_DIR=..\DKBatch\functions"
	set "DKBATCH_FUNCTIONS_DIR_=%DKBATCH_FUNCTIONS_DIR%\"
	call "%DKBATCH_FUNCTIONS_DIR%\DK.cmd"
	
	call dk_load dk_validate
	if not defined DKIMPORTS_DIR call "dk_validateBranch"
	if not defined CMAKE_EXE call "%DKIMPORTS_DIR%\cmake\dk_installCmake"
	
	call dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.cmake"
	ftype dkcmake=cmd /c call "%~f0" "%CMAKE_EXE%" "%DKCMAKE_FUNCTIONS_DIR%" "%%1" %*
	assoc .cmake=dkcmake
	call dk_registrySetKey "HKEY_CLASSES_ROOT\dkcmake\DefaultIcon" "" "REG_SZ" "%CMAKE%\bin\cmake-gui.exe"
goto:eof


:runDKCMake
	set "CMAKE_EXE=%~1"
	::echo CMAKE_EXE = %CMAKE_EXE%
	
	set "DKCMAKE_FUNCTIONS_DIR=%~2"
	set "DKCMAKE_FUNCTIONS_DIR=%DKCMAKE_FUNCTIONS_DIR:\=/%"
	::echo DKCMAKE_FUNCTIONS_DIR = %DKCMAKE_FUNCTIONS_DIR%
	
	set "CMAKE_FILE=%~3"
	set "CMAKE_FILE=%CMAKE_FILE:\=/%"
	::echo CMAKE_FILE = %CMAKE_FILE%

	echo ############### Digitalknob ##################
::echo %CMAKE_EXE% -DDKCMAKE_FUNCTIONS_DIR=%DKCMAKE_FUNCTIONS_DIR% -P %CMAKE_FILE%
     ::%CMAKE_EXE% -DDKCMAKE_FUNCTIONS_DIR=%DKCMAKE_FUNCTIONS_DIR% -P %CMAKE_FILE%

echo "%CMAKE_EXE%" -DQUEUE_BUILD=ON -DCLANG64=ON -DWIN_X86_64=ON -DEBUG=ON -DDKCMAKE_FUNCTIONS_DIR="%DKCMAKE_FUNCTIONS_DIR%" -P "%CMAKE_FILE%"
     "%CMAKE_EXE%" -DQUEUE_BUILD=ON -DCLANG64=ON -DWIN_X86_64=ON -DEBUG=ON -DDKCMAKE_FUNCTIONS_DIR="%DKCMAKE_FUNCTIONS_DIR%" -P "%CMAKE_FILE%"
	 pause
goto:eof