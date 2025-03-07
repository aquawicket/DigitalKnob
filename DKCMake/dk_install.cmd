@echo off
if "%~1" == "" (goto:dk_install)

:runDKCMake
	echo dk_install.cmd %*
	set "CMAKE_EXE=%~1"
	::set "DKCMAKE_FUNCTIONS_DIR_=%~2"
	set "DKSCRIPT_PATH=%~3"
	
	::###### run script ######
	set cmnd="%COMSPEC%" /V:ON /K call "%CMAKE_EXE%" -DQUEUE_BUILD=ON -P "%DKSCRIPT_PATH:\=/%"
	echo %cmnd%
	%cmnd%
	
	::###### exit_code ######
	if %ERRORLEVEL% neq 0 (echo ERROR:%ERRORLEVEL% & pause)
%endfunction%














:dk_install
	if not "%~1"=="" (goto:eof)
	
	if not defined DKBATCH_FUNCTIONS_DIR_   (set "DKBATCH_FUNCTIONS_DIR_=%USERPROFILE:\=/%/digitalknob/Development/DKBatch/functions/")
	if not defined DK_CMD 					(call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

	::###### Install DKBash ######
	%dk_call% dk_echo "Installing DKCmake . . ."
::	%dk_call% dk_registryDeleteKey "HKCU/SOFTWARE/Microsoft/Windows/CurrentVersion/Explorer/FileExts/.cmake"
	%dk_call% dk_validate DKIMPORTS_DIR     "%dk_call% dk_DKIMPORTS_DIR"
	if not defined CMAKE_EXE                 %dk_call% "%DKIMPORTS_DIR%/cmake/dk_install.cmd"
	
	%dk_call% dk_validate DKCMAKE_FUNCTIONS_DIR_ "%dk_call% dk_DKBRANCH_DIR"
	
::	%dk_call% dk_registryDeleteKey "HKCR/DKCmake"
	ftype DKCmake=%COMSPEC% /V:ON /K call "%~f0" "%CMAKE_EXE%" "%DKCMAKE_FUNCTIONS_DIR_%" "%%1" %*
	%dk_call% dk_registrySetKey "HKCR/DKCmake/DefaultIcon" "" "REG_SZ" "%CMAKE%/bin/cmake-gui.exe"
	
::	%dk_call% dk_registryDeleteKey "HKCR/.cmake"
::	%dk_call% dk_registryDeleteKey "HKCU/SOFTWARE/Microsoft/Windows/CurrentVersion/Explorer/FileExts/.cmake"
	assoc .cmake=DKCmake

	%dk_call% dk_success "DKCmake install complete"
%endfunction%



