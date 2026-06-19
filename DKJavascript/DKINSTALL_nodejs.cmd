@echo off
if "%~1" equ "" (goto DKINSTALL)

:runDKJavascript
	set "nodejs_exe=%~1"
	set "DKJAVASCRIPT_FUNCTIONS_DIR=%~2
	set "DKSCRIPT_PATH=%~3"
	for %%Z in ("%DKSCRIPT_PATH%") do set "DKJAVASCRIPT_FILE=%%~nxZ"
	cd %SystemDrive%\
    start %nodejs_exe% %DKJAVASCRIPT_FUNCTIONS_DIR%\DKNodeServer.js
	explorer "http://127.0.0.1:8080/Users/Administrator/Digital Knob/Development/DKHtml/index.html?DKTEST=%DKSCRIPT_PATH%"
%endfunction%





















:DKINSTALL
	@echo off&rem ###### DK.cmd #########################################################################################################################
	if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%" (set "DKBATCH_FUNCTIONS_DIR_=%CD:\=/%/../DKBatch/functions/") 
	if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
	if not defined DKINIT_cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %* && exit /b %errorlevel%)
	rem #################################################################################################################################################
	
	::###### Install DKJavascript ######
	%dk_call% dk_echo "Installing DKJavascript . . ."
	%dk_call% dk_validate DKIMPORTS_DIR %dk_call% dk_DKIMPORTS_DIR
	%dk_call% dk_validate nodejs_exe %dk_call% dk_depend nodejs
	%dk_call% dk_registryDeleteKey "HKCR\DKBatch"
	
	%dk_call% dk_validate cmd.exe %dk_call% dk_depend cmd
	ftype DKJavascript="%cmd.exe%" /c call "%~f0" "%nodejs_exe%" "%DKJAVASCRIPT_FUNCTIONS_DIR%" "%%1" %*
	%dk_call% dk_registrySetKey "HKCR\DKJavascript\DefaultIcon" "" "REG_SZ" "%nodejs_exe%"
	
	%dk_call% dk_registryDeleteKey "HKCR\.js"
	%dk_call% dk_registryDeleteKey "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.js"
	assoc .js=DKJavascript
	
	%dk_call% dk_success "DKJavascript install complete"
%endfunction%



