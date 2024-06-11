@echo off

:install_cmake_fileAssociation
	if not "%*" == "" (goto:run_cmake_file)
	echo Associating .cmake files with DKCmake . . .
	
	set "DIGITALKNOB_DIR=%HOMEDRIVE%%HOMEPATH%\digitalknob"
	set "DKBRANCH_DIR=%DIGITALKNOB_DIR%\Development"
	call "%DKBRANCH_DIR%\DKBatch\functions\DK.cmd"
	call dk_load dk_validate
	call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
	call dk_validate CMAKE_EXE "call %DKIMPORTS_DIR%\cmake\dk_installCmake"
	
	ftype dk_cmake=cmd /c call "%~f0" "%DKCMAKE_FUNCTIONS_DIR%" "%CMAKE_EXE%" "%%1" %*
	assoc .cmake=dk_cmake
	call dk_registrySetKey "HKEY_CLASSES_ROOT\dk_cmake\DefaultIcon" "" "REG_SZ" "%CMAKE%\bin\cmake-gui.exe"
goto:eof


:run_cmake_file
	set "DKCMAKE_FUNCTIONS_DIR=%~1"
	set "CMAKE_EXE=%~2"
	set "CMAKE_FILE=%~3"

	echo ############### Digitalknob ##################
	cd %DKCMAKE_FUNCTIONS_DIR%
	set "DKCMAKE_FUNCTIONS_DIR=%DKCMAKE_FUNCTIONS_DIR:\=/%"
	start %CMAKE_EXE% -DDKCMAKE_FUNCTIONS_DIR=%DKCMAKE_FUNCTIONS_DIR% -P %CMAKE_FILE%
goto:eof