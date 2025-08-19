@echo off
if "%~1" equ "" (goto DKINSTALL)

:runDKCMake
	echo :runDKCMake %*
	
	set "CMAKE_EXE=%~1"
	set "DKCMAKE_FUNCTIONS_DIR_=%~2"
	set "DKSCRIPT_PATH=%~3"
	set "DKSCRIPT_PATH=%DKSCRIPT_PATH:\=/%"

	if NOT EXIST %ComSpec% (echo ERROR: ComSpec NOT found)
	if NOT EXIST %CMAKE_EXE% (echo ERROR: CMAKE_EXE NOT found)
	if NOT EXIST %DKSCRIPT_PATH% (echo ERROR: DKSCRIPT_PATH NOT found)
	::###### run script ######
	set cmnd="%ComSpec%" /V:ON /K call %CMAKE_EXE% -P "%DKSCRIPT_PATH%"
	echo %cmnd%
	%cmnd% & echo success || echo failed

	::###### exit_code ######
	if %ERRORLEVEL% neq 0 (
		echo ERROR:%ERRORLEVEL%
		pause
	)
%endfunction%














:DKINSTALL
	if "%~1" neq "" (goto:eof)
	
	echo Installing DKCmake . . .
	
	@echo off&::###### DK.cmd #########################################################################################################################
	if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%" (set "DKBATCH_FUNCTIONS_DIR_=%CD:\=/%/../DKBatch/functions/") 
	if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
	if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
	::#################################################################################################################################################


	::###### Install DKCMake ######
	::%dk_call% dk_validate DKIMPORTS_DIR     		"%dk_call% dk_DKIMPORTS_DIR"
	%dk_call% dk_validate CMAKE_EXE     			"%dk_call% dk_depend cmake"
	%dk_call% dk_validate DKCMAKE_FUNCTIONS_DIR_ 	"%dk_call% dk_DKBRANCH_DIR"

	ftype DKCmake=%ComSpec% /V:ON /K call "%~f0" "%CMAKE_EXE%" "%DKCMAKE_FUNCTIONS_DIR_%" "%%1" %*
	%dk_call% dk_registrySetKey "HKCR/DKCmake/DefaultIcon" "" "REG_SZ" "%CMAKE%/bin/cmake-gui.exe"
	assoc .cmake=DKCmake

	%dk_call% dk_success "DKCmake install complete"
%endfunction%



