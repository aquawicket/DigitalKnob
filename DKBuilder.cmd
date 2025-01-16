@echo off

set "ENABLE_dk_debug=1"

setlocal enableDelayedExpansion

set "HDK=https://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/DKBatch/functions/DK.cmd"

set "DKF=%USERPROFILE%\digitalknob\Development\DKBatch\functions"

if not exist "!DKF!" set "DKF=%USERPROFILE%\.dk\DKBatch\functions"

attrib +h %USERPROFILE%\.dk

set "DK=!DKF!\DK.cmd"
mkdir "!DKF!" 2>nul
set "DK=!DKF!\DK.cmd" 

:: firewall
call :dk_firewallAllow powershell "%WINDIR%\system32\windowspowershell\v1.0\powershell.exe"
call :dk_firewallAllow curl "%WINDIR%\system32\curl.exe"
call :dk_firewallAllow git "C:\users\administrator\digitalknob\dktools\portablegit-2.46.2-64-bit\mingw64\libexec\git-core\git-remote-https.exe"

if not exist !DK! powershell -c "(New-Object Net.WebClient).DownloadFile('!HDK!','!DK!')" >nul 2>&1||certutil -urlcache -split -f "!HDK!" "!DK!" >nul 2>&1||curl -f "!HDK!" -o "!DK!" >nul 2>&1||echo DKINIT Failed

endlocal & set "DK=%DK%"
set "DKF=%DKF%"


call "%DK%" %~0 %*

::takeown /F %DKF% /R /D "Y"
::####################
%dk_call% dk_buildMain

:: 		DKHOME	                                 C:/Users/aquawicket
:: DKHTTP_HOME  	    https://raw.githubusercontent.com/aquawicket
:: DIGITALKNOB_DIR					     		 C:/Users/aquawicket/digitalknob/
:: DKHTTP_DIGITALKNOB	https://raw.githubusercontent.com/aquawicket/digitalknob/
:: 
%return%





:dk_firewallAllow
	call :dk_registryContains "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\FirewallRules" "%~2" && exit /b 0
	netsh advfirewall firewall add rule name="%~1" dir=in action=allow program="%~2" enable=yes profile=any
	netsh advfirewall firewall add rule name="%~1" dir=out action=allow program="%~2" enable=yes profile=any
	set "WFCUI_EXE=C:\Program Files\Malwarebytes\Windows Firewall Control\wfcUI.exe"
	if exist "%WFCUI_EXE%" call "%WFCUI_EXE%" -allow %2
%endfunction%


:dk_registryContains
	setlocal EnableDelayedExpansion
	for /f "usebackq delims=" %%a in (`reg query "%~1"`) do (
		set "str=%%a"
		if not "x!str:%~2=!" == "x!str!" exit /b 0
	)
    exit /b 1
%endfunction%