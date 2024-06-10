@echo off
call ../../DKBatch/functions/DK.cmd
call dk_validate DKIMPORTS_DIR "call dk_validateBranch"

if not "%*" == "" (goto:run_cmake_file)
	call %DKIMPORTS_DIR%\cmake\dk_installCmake.cmd
	echo Associating .cmake files with DKCmake_Batch_Wrapper . . .
	ftype dk_cmake=cmd /c call "%~0" "%%1" %*
	assoc .cmake=dk_cmake
	pause
exit


:run_cmake_file
	call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
	call dk_validate CMAKE_EXE "call %DKIMPORTS_DIR%\cmake\dk_installCmake"
	
::	cd %DKCMAKE_DIR%\functions
::	set "DKCMAKE_DIR=%DKCMAKE_DIR:\=/%"
::	%CMAKE_EXE% -DDKCMAKE_DIR=%DKCMAKE_DIR% -P %1
	
	cd %DKCMAKE_FUNCTIONS_DIR%
	set "DKCMAKE_FUNCTIONS_DIR=%DKCMAKE_FUNCTIONS_DIR:\=/%"
	%CMAKE_EXE% -DDKCMAKE_FUNCTIONS_DIR=%DKCMAKE_FUNCTIONS_DIR% -P %1

	pause
goto:eof