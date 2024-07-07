@echo off

:installDKCMake
	if not "%*" == "" (goto:runDKCMake)
	echo Associating .cmake files with DKCmake . . .
	
	::###### DKINIT ######
	set "DIGITALKNOB_DIR=%HOMEDRIVE%%HOMEPATH%\digitalknob"
	set "DKBRANCH_DIR=%DIGITALKNOB_DIR%\Development"
	set "DKBATCH_FUNCTION_DIR=%DKBRANCH_DIR%\DKBatch\functions"
	set "DKBATCH_FUNCTION_DIR_=%DKBATCH_FUNCTION_DIR%\"
	call "%DKBATCH_FUNCTION_DIR_%DK.cmd"
	
	call dk_load dk_validate
	call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
	call dk_validate CMAKE_EXE "call %DKIMPORTS_DIR%\cmake\dk_installCmake"
	
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

echo %CMAKE_EXE% -DQUEUE_BUILD=ON -DCLANG64=ON -DWIN_X86_64=ON -DEBUG=ON -DDKCMAKE_FUNCTIONS_DIR=%DKCMAKE_FUNCTIONS_DIR% -P %CMAKE_FILE%
     %CMAKE_EXE% -DQUEUE_BUILD=ON -DCLANG64=ON -DWIN_X86_64=ON -DEBUG=ON -DDKCMAKE_FUNCTIONS_DIR=%DKCMAKE_FUNCTIONS_DIR% -P %CMAKE_FILE%
	pause
goto:eof