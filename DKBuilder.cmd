@echo off

setlocal enableDelayedExpansion

set "HDK=https://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/DKBatch/functions/DK.cmd"

set "DKF=%USERPROFILE%\digitalknob\Development\DKBatch\functions"

if not exist "!DKF!" set "DKF=%USERPROFILE%\.dk\DKBatch\functions"

attrib +h %USERPROFILE%\.dk

set "DK=!DKF!\DK.cmd"
mkdir "!DKF!" 2>nul
set "DK=!DKF!\DK.cmd" 

:: firewall
netsh advfirewall firewall add rule name="powershell" dir=in action=allow program="C:\windows\system32\windowspowershell\v1.0\powershell.exe" enable=yes profile=any
netsh advfirewall firewall add rule name="curl" dir=in action=allow program="C:\windows\system32\curl.exe" enable=yes profile=any
netsh advfirewall firewall add rule name="git" dir=in action=allow program="C:\users\administrator\digitalknob\dktools\portablegit-2.46.2-64-bit\mingw64\libexec\git-core\git-remote-https.exe" enable=yes profile=any

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