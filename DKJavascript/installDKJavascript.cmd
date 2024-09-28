@echo off

if "%~1" neq "" goto:runDKJavascript
:installDKJavascript
	::###### DKINIT ######
	if not defined DKBATCH_FUNCTIONS_DIR_ set "DKBATCH_FUNCTIONS_DIR_=..\DKBatch\functions\"
	if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*
	
	::###### Install DKJavascript ######
	%dk_call% dk_echo "Installing DKJavascript . . ."
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKBRANCH_DIR"
	%dk_call% dk_validate NODEJS_EXE "call %DKIMPORTS_DIR%\nodejs\dk_installNodeJs"
	
	
	%dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\DKBatch"
	ftype DKJavascript=cmd /c call "%~f0" "%NODEJS_EXE%" "%DKJAVASCRIPT_FUNCTIONS_DIR%" "%%1" %*
	%dk_call% dk_registrySetKey "HKEY_CLASSES_ROOT\DKJavascript\DefaultIcon" "" "REG_SZ" "%NODEJS_EXE%"
	
	%dk_call% dk_registryDeleteKey "HKEY_CLASSES_ROOT\.js"
	%dk_call% dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.js"
	assoc .js=DKJavascript
	
	%dk_call% dk_success "DKJavascript install complete"
%endfunction%


:runDKJavascript
	set "NODEJS_EXE=%~1"
	set "DKJAVASCRIPT_FUNCTIONS_DIR=%~2
	set "DKSCRIPT_PATH=%~3"
	for %%Z in ("%DKSCRIPT_PATH%") do set "DKJAVASCRIPT_FILE=%%~nxZ"
    start %NODEJS_EXE% %DKJAVASCRIPT_FUNCTIONS_DIR%\DKNodeServer.js
	explorer "http://127.0.0.1:8080/%JAVASCRIPT_FILE%"
%endfunction%
