@echo off

if "%~1" neq "" (goto:runDKJavascript)
:installDKJavascript
	::###### DKINIT ######
	call "..\DKBatch\functions\DK.cmd"
	
	::###### Install DKJavascript ######
	call dk_echo "Installing DKJavascript . . ."
	call dk_validate DKIMPORTS_DIR "call dk_validateBranch"
	call dk_validate NODEJS_EXE "call %DKIMPORTS_DIR%\nodejs\dk_installNodeJs"
	
	call dk_registryDeleteKey "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.js"
	ftype DKJavascript=cmd /c call "%~f0" "%NODEJS_EXE%" "%DKJAVASCRIPT_FUNCTIONS_DIR%" "%%1" %*
	assoc .js=DKJavascript
	call dk_registrySetKey "HKEY_CLASSES_ROOT\DKJavascript\DefaultIcon" "" "REG_SZ" "%NODEJS_EXE%"
	
	call dk_echo "DKJavascript install complete"
	call dk_pause
goto:eof


:runDKJavascript
	set "NODEJS_EXE=%~1"
	set "DKJAVASCRIPT_FUNCTIONS_DIR=%~2
	set "DKJAVASCRIPT_FILE=%~3"
	for %%Z in ("%DKJAVASCRIPT_FILE%") do set "DKJAVASCRIPT_FILE=%%~nxZ"
    start %NODEJS_EXE% %DKJAVASCRIPT_FUNCTIONS_DIR%\DKNodeServer.js
	explorer "http://127.0.0.1:8080/%JAVASCRIPT_FILE%"
goto:eof
