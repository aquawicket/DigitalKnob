@echo off
if "%~1" == "" (goto dk_install)

:runDKPython
	set "DKPYTHON_FUNCTIONS_DIR=%~1"
	set "PYTHON3_EXE=%~2"
	set "DKSCRIPT_PATH=%~3"
	
	::echo DKPYTHON_FUNCTIONS_DIR = %DKPYTHON_FUNCTIONS_DIR%
	::echo PYTHON3_EXE = %PYTHON3_EXE%
	::echo DKSCRIPT_PATH = %DKSCRIPT_PATH%
	::echo:
	
	::###### run script ######
	::title %DKSCRIPT_PATH%
	::(set PATH=%DKPYTHON_FUNCTIONS_DIR%;%PATH% & 
	(set cmnd=%COMSPEC% /V:ON /k call "%PYTHON3_EXE%" "%DKSCRIPT_PATH%")
	::echo %cmnd%
	::echo:
	::echo:
	%cmnd%
	
	::###### exit_code ######
	if %ERRORLEVEL% neq 0 (
		echo ERROR:%ERRORLEVEL% 
		pause
	)
	pause
	::###### reload ######
::	if not exist %~dp0\reload (goto:eof)
::	del %~dp0\reload
::	cls
::	goto runDKPython
exit /b 0




















:dk_install
	if "%~1" neq "" (goto:eof)
	::###### DKINIT ######
	if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=..\DKBatch\functions\")
	if not defined DKINIT (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)
	
	::###### Install DKPython ######
	%dk_call% dk_echo "Installing DKPython . . ."
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	%dk_call% dk_validate PYTHON3_EXE "%dk_call% %DKIMPORTS_DIR%\python3\dk_install.cmd"
::	echo PYTHON3_EXE = %PYTHON3_EXE%
::	%dk_call% dk_registryDeleteKey "HKCR\DKPython"
	%dk_call% dk_validate CMD_EXE "%dk_call% dk_CMD_EXE"
	ftype DKPython=%COMSPEC% /c call "%~f0" "%DKPYTHON_FUNCTIONS_DIR%" "%PYTHON3_EXE%" "%%1" %*
	%dk_call% dk_registrySetKey "HKCR\DKPython\DefaultIcon" "" "REG_SZ" "%PYTHON3_EXE%"	
::	%dk_call% dk_registryDeleteKey "HKCR\.py"
::	%dk_call% dk_registryDeleteKey "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.py"
	assoc .py=DKPython
	
	%dk_call% dk_success "DKPython install complete"
%endfunction%
