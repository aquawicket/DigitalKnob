@echo off

:MAIN
setlocal enableDelayedExpansion
if "!DE!" neq "" (echo ERROR: enableDelayedExpansion failed!)

	if NOT defined DIGITALKNOB (set "DIGITALKNOB=DigitalKnob")
	if NOT defined DKBRANCH (set "DKBRANCH=Development")
	if NOT defined HDK (set "HDK=https://raw.githubusercontent.com/aquawicket/%DIGITALKNOB%/%DKBRANCH%/DKBatch/functions/DK.cmd")
	if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%" (set "DKBATCH_FUNCTIONS_DIR_=%USERPROFILE:\=/%/%DIGITALKNOB%/%DKBRANCH%/DKBatch/functions/")
	if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%" (mkdir "%DKBATCH_FUNCTIONS_DIR_%" >nul 2>&1)
	set "DK_CMD=%DKBATCH_FUNCTIONS_DIR_%DK.cmd"
	
	::###### TEMPORARY for WinPE #######
	if "%SystemDrive%" equ "X:" (
		if NOT EXIST "%windir%\System32\curl.exe" 		(copy "C:\Windows\System32\curl.exe"		"%windir%\System32\curl.exe")
		if NOT EXIST "%windir%\System32\certutil.exe" 	(copy "C:\Windows\System32\certutil.exe" 	"%windir%\System32\certutil.exe")
	)
	
	::########################
	set "CURL_EXE=%windir:\=/%/System32/curl.exe"
	set "CERTUTIL_EXE=%windir:\=/%/System32/certutil.exe"
	set "BITSADMIN_EXE=%windir:\=/%/System32/bitsadmin.exe"
	set "POWERSHELL_EXE=%windir:\=/%/System32/WindowsPowershell/v1.0/powershell.exe"
	set "GIT_REMOTE_HTTPS_EXE=%USERPROFILE:\=/%/%DIGITALKNOB%/DKTools/git-portable-2.46.2-64-bit/mingw64/libexec/git-core/git-remote-https.exe"

	::###### firewall allow ######
	call :dk_firewallAllow curl "%CURL_EXE%"
	call :dk_firewallAllow certutil "%CERTUTIL_EXE%"
	call :dk_firewallAllow bitsadmin "%BITSADMIN_EXE%"
	call :dk_firewallAllow powershell "%POWERSHELL_EXE%"
	call :dk_firewallAllow git-remote-https "%GIT_REMOTE_HTTPS_EXE%"

	if NOT EXIST "%DK_CMD%" (
		"%CURL_EXE%" -L "!HDK!" -o "!DK_CMD!" >nul 2>&1 || ^
		"%CERTUTIL_EXE%" -urlcache -split -f "!HDK!" "!DK_CMD!" >nul 2>&1 || ^
		"%BITSADMIN_EXE%" /transfer /Download /priority Foreground "!HDK!" "!DK_CMD:/=\!" >nul 2>&1 || ^
		"%POWERSHELL_EXE%" -c "(New-Object Net.WebClient).DownloadFile('!HDK!','!DK_CMD!')" >nul 2>&1 || ^
		echo ERROR: DK.cmd download Failed
	)

	call "%DK_CMD%" "%~0" %*

	::takeown /F %DKF% /R /D "Y"
	%dk_call% DKBuilder/main.cmd
	
%endfunction%


:dk_registryContains regpath value
setlocal enableDelayedExpansion
	for /f "usebackq delims=" %%G in (`reg query %~1`) do (
		set "str=%%G"
		if "x!str:%~2=!x" neq "x!str!x" (exit /b 0)
	)
exit /b 1


:dk_firewallAllow name file
setlocal enableDelayedExpansion
	set "_name_=%~1"
	set "_file_=%~2"
	set "_file_=%_file_:/=\%
	call :dk_registryContains "HKLM\SYSTEM\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\FirewallRules" "%_file_%" && (exit /b 0)
	::###### netsh ######
	netsh advfirewall firewall add rule name="%_name_%" dir=in action=allow program="%_file_%" enable=yes profile=any 1>nul 2>nul
	netsh advfirewall firewall add rule name="%_name_%" dir=out action=allow program="%_file_%" enable=yes profile=any 1>nul 2>nul
	::###### Windows Firewall Control ######
	if EXIST "%ProgramFiles%\Malwarebytes\Windows Firewall Control\wfc.exe" (set "WFC_APP=%ProgramFiles%\Malwarebytes\Windows Firewall Control\wfc.exe")
	if EXIST "%ProgramFiles%\Malwarebytes\Windows Firewall Control\wfcUI.exe" (set "WFC_APP=%ProgramFiles%\Malwarebytes\Windows Firewall Control\wfcUI.exe")
	if EXIST "%WFC_APP%" ("%ComSpec%" /c "%WFC_APP%" -allow %_file_%)
exit /b 0
