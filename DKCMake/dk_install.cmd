@echo off
if "%~1" == "" (goto:dk_install)

:runDKCMake
	echo dk_install.cmd %*
	set "CMAKE_EXE=%~1"
	set "CMAKE_EXE=%CMAKE_EXE:/=\%"
	set "DKCMAKE_FUNCTIONS_DIR=%~2"
	set "DKCMAKE_FUNCTIONS_DIR=%DKCMAKE_FUNCTIONS_DIR:\=/%/"
	:: set "DKCMAKE_FUNCTIONS_DIR_=%DKCMAKE_FUNCTIONS_DIR%/"
	set "DKSCRIPT_PATH=%~3"
	set "DKSCRIPT_PATH=%DKSCRIPT_PATH:\=/%"
	
	::###### run script ######
    ::"%ComSpec%" /V:ON /K call "%CMAKE_EXE%" -DQUEUE_BUILD=ON -DCLANG64=ON -DWIN_X86_64=ON -DEBUG=ON -DDKCMAKE_FUNCTIONS_DIR="%DKCMAKE_FUNCTIONS_DIR%" -P "%DKSCRIPT_PATH%"
	::"%ComSpec%" /V:ON /K call "%CMAKE_EXE%" -DQUEUE_BUILD=ON -DDKCMAKE_FUNCTIONS_DIR_="%DKCMAKE_FUNCTIONS_DIR_%" -P "%DKSCRIPT_PATH%"
	::%dk_call% dk_validate CMAKE_EXE "%dk_call% dk_CMAKE_EXE"
	set cmnd="%ComSpec%" /V:ON /K call "%CMAKE_EXE%" -DQUEUE_BUILD=ON -P "%DKSCRIPT_PATH%"
	echo %cmnd%
	%cmnd%
	
	::###### exit_code ######
	if %ERRORLEVEL% neq 0 echo ERROR:%ERRORLEVEL% && pause
	
	::###### reload ######
::	if not exist %~dp0\reload goto:eof
::	del %~dp0\reload
::	cls
::	goto runDKCMake
%endfunction%














:dk_install
	if not defined DKBATCH_FUNCTIONS_DIR_    set "DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%\digitalknob\Development\DKBatch\functions\"
	if not defined DKINIT                    call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

	::###### Install DKBash ######
	%dk_call% dk_echo "Installing DKCmake . . ."
::	%dk_call% dk_registryDeleteKey "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.cmake"
	%dk_call% dk_validate DKIMPORTS_DIR     "%dk_call% dk_DKIMPORTS_DIR"
	if not defined CMAKE_EXE                 %dk_call% "%DKIMPORTS_DIR%\cmake\dk_install.cmd"
	
	%dk_call% dk_validate DKCMAKE_FUNCTIONS_DIR "%dk_call% dk_DKBRANCH_DIR"
	
::	%dk_call% dk_registryDeleteKey "HKCR\DKCmake"
	ftype DKCmake=%COMSPEC% /c call "%~f0" "%CMAKE_EXE%" "%DKCMAKE_FUNCTIONS_DIR%" "%%1" %*
	%dk_call% dk_registrySetKey "HKCR\DKCmake\DefaultIcon" "" "REG_SZ" "%CMAKE%\bin\cmake-gui.exe"
	
::	%dk_call% dk_registryDeleteKey "HKCR\.cmake"
::	%dk_call% dk_registryDeleteKey "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.cmake"
	assoc .cmake=DKCmake

	%dk_call% dk_success "DKCmake install complete"
%endfunction%



