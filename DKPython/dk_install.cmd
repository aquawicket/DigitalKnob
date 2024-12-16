@echo off

if "%~1" neq "" goto runDKPython
:dk_install
	::###### DKINIT ######
	if not defined DKBATCH_FUNCTIONS_DIR_ set "DKBATCH_FUNCTIONS_DIR_=..\DKBatch\functions\"
	if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*
	
	::###### Install DKPython ######
	%dk_call% dk_echo "Installing DKPython . . ."
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	::%dk_call% dk_validate PYTHON_EXE "call %DKIMPORTS_DIR%\powershell\dk_install.cmd"
	%dk_call% dk_validate PYTHON_EXE "%dk_call% dk_PYTHON_EXE"
	
	
	%dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\DKPython"
	
	%dk_call% dk_validate CMD_EXE "%dk_call% dk_CMD_EXE"
	ftype DKPython=%COMSPEC% /c call "%~f0" "%DKPYTHON_FUNCTIONS_DIR%" "%PYTHON_EXE%" "%%1" %*
	%dk_call% dk_registrySetKey "HKEY_CLASSES_ROOT\DKPython\DefaultIcon" "" "REG_SZ" "%PYTHON_EXE%"
	
	%dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\.py"
	%dk_call% dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.py
	assoc .py=DKPython
	
	%dk_call% dk_success "DKPython install complete"
%endfunction%


:runDKPython
	set "DKPYTHON_FUNCTIONS_DIR=%~1"
	set "PYTHON_EXE=%~2"
	set "DKSCRIPT_PATH=%~3"
	
	
	::###### run script ######
	%COMSPEC% /V:ON /K call %PYTHON_EXE% -Command %DKSCRIPT_PATH%; exit $LASTEXITCODE && (echo returned TRUE) || (echo returned FALSE)
	
	::###### exit_code ######
	if %ERRORLEVEL% neq 0 echo ERROR:%ERRORLEVEL% && pause
	
	::###### reload ######
	if not exist %~dp0\reload goto:eof
	del %~dp0\reload
	cls
	goto runDKPython
%endfunction%
