@echo off

:install_cmake_fileAssociation
	if not "%*" == "" (goto:run_cmake_file)
	if not defined DKINIT call "..\..\..\DKBatch\functions\DK.cmd"
	call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
	call dk_validate CMAKE_EXE "call %DKIMPORTS_DIR%\cmake\dk_installCmake"
	echo Associating .cmake files with DKCmake_Batch_Wrapper . . .
	ftype dk_cmake=cmd /c call "%~f0" "%%1" %*
	assoc .cmake=dk_cmake
goto:eof


:run_cmake_file
	set "DIGITALKNOB_DIR=%HOMEDRIVE%%HOMEPATH%\digitalknob"
	set "DKTOOLS_DIR=%DIGITALKNOB_DIR%\DKTools"
	set "DKBRANCH_DIR=%DIGITALKNOB_DIR%\Development"
	set "DKCMAKE_FUNCTIONS_DIR=%DKBRANCH_DIR%\DKCMake\functions"
	set "CMAKE_EXE=%DKTOOLS_DIR%\cmake_3_29_5_windows_x86_64\bin\cmake.exe"

::	cd %DKCMAKE_DIR%\functions
::	set "DKCMAKE_DIR=%DKCMAKE_DIR:\=/%"
::	%CMAKE_EXE% -DDKCMAKE_DIR=%DKCMAKE_DIR% -P %1

	cd %DKCMAKE_FUNCTIONS_DIR%
	set "DKCMAKE_FUNCTIONS_DIR=%DKCMAKE_FUNCTIONS_DIR:\=/%"
	%CMAKE_EXE% -DDKCMAKE_FUNCTIONS_DIR=%DKCMAKE_FUNCTIONS_DIR% -P %1

	pause
goto:eof