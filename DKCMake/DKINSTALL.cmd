@echo off
if "%~1" == "" (goto:DKINSTALL)

:runDKCMake
	echo DKINSTALL.cmd %*
	set "CMAKE_EXE=%~1"
	set "DKCMAKE_FUNCTIONS_DIR_=%~2"
	set "DKSCRIPT_PATH=%~3"
	set "DKSCRIPT_PATH=%DKSCRIPT_PATH:\=/%"

	::###### run script ######
	set cmnd="%COMSPEC%" /V:ON /K call "%CMAKE_EXE%" -DQUEUE_BUILD=ON -P "%DKSCRIPT_PATH%"
	echo %cmnd%
	%cmnd%

	::###### exit_code ######
	if %ERRORLEVEL% neq 0 (
		echo ERROR:%ERRORLEVEL%
		pause
	)
%endfunction%














:DKINSTALL
	if not "%~1"=="" (goto:eof)
	
	echo Installing DKCmake . . .
	
	::###### DK.cmd ######
	if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
	if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

	::###### Install DKCMake ######
	%dk_call% dk_validate DKIMPORTS_DIR     "%dk_call% dk_DKIMPORTS_DIR"
	if not defined CMAKE_EXE                 %dk_call% "%DKIMPORTS_DIR%/cmake/DKINSTALL.cmd"

	%dk_call% dk_validate DKCMAKE_FUNCTIONS_DIR_ "%dk_call% dk_DKBRANCH_DIR"

	ftype DKCmake=%COMSPEC% /V:ON /K call "%~f0" "%CMAKE_EXE%" "%DKCMAKE_FUNCTIONS_DIR_%" "%%1" %*
	%dk_call% dk_registrySetKey "HKCR/DKCmake/DefaultIcon" "" "REG_SZ" "%CMAKE%/bin/cmake-gui.exe"
	assoc .cmake=DKCmake

	%dk_call% dk_success "DKCmake install complete"
%endfunction%



