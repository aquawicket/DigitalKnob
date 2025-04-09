@echo off
if "%~1" equ "" (goto DKINSTALL)

:runDKJavascript
	set "NODEJS_EXE=%~1"
	set "DKJAVASCRIPT_FUNCTIONS_DIR=%~2
	set "DKSCRIPT_PATH=%~3"
	for %%Z in ("%DKSCRIPT_PATH%") do set "DKJAVASCRIPT_FILE=%%~nxZ"
	cd C:\
    start %NODEJS_EXE% %DKJAVASCRIPT_FUNCTIONS_DIR%\DKNodeServer.js
	explorer "http://127.0.0.1:8080/Users/Administrator/digitalknob/Development/DKHtml/index.html?DKTEST=%DKSCRIPT_PATH%"
%endfunction%





















:DKINSTALL
	::###### DK.cmd ######
	if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
	if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
	
	::###### Install DKJavascript ######
	%dk_call% dk_echo "Installing DKJavascript . . ."
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	%dk_call% dk_validate NODEJS_EXE "%dk_call% %DKIMPORTS_DIR%\nodejs\DKINSTALL.cmd"
	%dk_call% dk_registryDeleteKey "HKCR\DKBatch"
	
	%dk_call% dk_validate CMD_EXE "%dk_call% dk_CMD_EXE"
	ftype DKJavascript="%CMD_EXE%" /c call "%~f0" "%NODEJS_EXE%" "%DKJAVASCRIPT_FUNCTIONS_DIR%" "%%1" %*
	%dk_call% dk_registrySetKey "HKCR\DKJavascript\DefaultIcon" "" "REG_SZ" "%NODEJS_EXE%"
	
	%dk_call% dk_registryDeleteKey "HKCR\.js"
	%dk_call% dk_registryDeleteKey "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.js"
	assoc .js=DKJavascript
	
	%dk_call% dk_success "DKJavascript install complete"
%endfunction%



