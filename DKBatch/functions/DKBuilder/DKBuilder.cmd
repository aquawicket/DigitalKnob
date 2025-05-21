@echo off

:MAIN
setlocal enableDelayedExpansion

	set "ENABLE_dk_debug=1"
	if not defined HDK (set "HDK=https://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/DKBatch/functions/DK.cmd")
	if not defined DIGITALKNOB (set "DIGITALKNOB=digitalknob")
	if not defined DKBRANCH (set "DKBRANCH=Development")
	if not exist "%DKBATCH_FUNCTIONS_DIR_%" (set "DKBATCH_FUNCTIONS_DIR_=%USERPROFILE:\=/%/%DIGITALKNOB%/%DKBRANCH%/DKBatch/functions/")
	if not exist "%DKBATCH_FUNCTIONS_DIR_%" (mkdir "%DKBATCH_FUNCTIONS_DIR_%" >nul 2>&1)
	set "DK=%DKBATCH_FUNCTIONS_DIR_%/DK.cmd"

	:: firewall
	call :dk_firewallAllow powershell "%WINDIR:\=/%/System32/WindowsPowershell/v1.0/powershell.exe"
	call :dk_firewallAllow curl "%WINDIR:\=/%/System32/curl.exe"
	call :dk_firewallAllow git "%USERPROFILE:\=/%/digitalknob/DKTools/git-portable-2.46.2-64-bit/mingw64/libexec/git-core/git-remote-https.exe"

	if not exist %DK% (
		powershell -c "(New-Object Net.WebClient).DownloadFile('!HDK!','!DK!')" >nul 2>&1 || ^
		certutil -urlcache -split -f "!HDK!" "!DK!" >nul 2>&1 || ^
		curl -f "!HDK!" -o "!DK!" >nul 2>&1 || ^
		echo DK.cmd Failed
	)

	call "%DK%" "%~0" %*

	::takeown /F %DKF% /R /D "Y"
	%dk_call% main.cmd
exit /b %errorlevel%


:dk_registryContains
setlocal enableDelayedExpansion
	for /f "usebackq delims=" %%a in (`reg query %~1`) do (
		set "str=%%a"
		if "x!str:%~2=!x" neq "x!str!x" (exit /b 0)
	)
    exit /b 1
%endfunction%


:dk_firewallAllow
setlocal enableDelayedExpansion
	set "_name_=%~1"
	set "_file_=%~2"
	call :dk_registryContains "HKLM\SYSTEM\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\FirewallRules" "%_file_:/=\%" && (exit /b 0)
	::###### netsh ######
	netsh advfirewall firewall add rule name="%_name_%" dir=in action=allow program="%_file_:/=\%" enable=yes profile=any 1>nul 2>nul
	netsh advfirewall firewall add rule name="%_name_%" dir=out action=allow program="%_file_:/=\%" enable=yes profile=any 1>nul 2>nul
	::###### Windows Firewall Control ######
	if not exist "%WFC_EXE%" 	(set "WFC_EXE=C:/Program Files/Malwarebytes/Windows Firewall Control/wfc.exe")
	if not exist "%WFCUI_EXE%" 	(set "WFCUI_EXE=C:/Program Files/Malwarebytes/Windows Firewall Control/wfcUI.exe")
	if exist "%WFC_EXE%"		(set "WFC_APP=%WFC_EXE%")
	if exist "%WFCUI_EXE%"		(set "WFC_APP=%WFCUI_EXE%")
	if exist "%WFC_APP%"		(set cmnd="%WFC_APP%" -allow "%_file_:/=\%")
	if not exist "%CMD_EXE%"	(set "CMD_EXE=%ComSpec%")
	if not exist "%CMD_EXE%"	(%dk_call% dk_error "CMD_EXE is invalid")
	::echo cmnd ^> "%CMD_EXE%" /c "%cmnd%"
	"%CMD_EXE%" /c "%cmnd%"
%endfunction%
