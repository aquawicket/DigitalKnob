@echo off
echo ~0 = %~0
echo ~f0 = %~f0
echo * = %*

set "DIGITALKNOB_DIR=%HOMEDRIVE%%HOMEPATH%\digitalknob"
set "DKBRANCH_DIR=%DIGITALKNOB_DIR%\Development"
call "%DKBRANCH_DIR%\DKBatch\functions\DK.cmd"
call dk_load dk_validate
call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
call dk_validate CMAKE_EXE "call %DKIMPORTS_DIR%\cmake\dk_installCmake"

:install_cmake_fileAssociation
	if not "%*" == "" (goto:run_cmake_file)
	echo Associating .cmake files with DKCmake_Batch_Wrapper . . .
	ftype dk_cmake=cmd /c call "%~f0" "%%1" %*
	assoc .cmake=dk_cmake
goto:eof


:run_cmake_file
	set "DKCMAKE_FUNCTIONS_DIR=%DKBRANCH_DIR%\DKCMake\functions"

::	cd %DKCMAKE_DIR%\functions
::	set "DKCMAKE_DIR=%DKCMAKE_DIR:\=/%"
::	%CMAKE_EXE% -DDKCMAKE_DIR=%DKCMAKE_DIR% -P %1

	cd %DKCMAKE_FUNCTIONS_DIR%
	set "DKCMAKE_FUNCTIONS_DIR=%DKCMAKE_FUNCTIONS_DIR:\=/%"
	%CMAKE_EXE% -DDKCMAKE_FUNCTIONS_DIR=%DKCMAKE_FUNCTIONS_DIR% -P %1

	pause
goto:eof