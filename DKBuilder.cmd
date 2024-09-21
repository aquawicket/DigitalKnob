@echo off&setlocal enableDelayedExpansion&set "HDK=https://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/DKBatch/functions/DK.cmd"&set "DKF=%HOMEDRIVE%%HOMEPATH%\digitalknob\Development\DKBatch\functions"&set "DK=!DKF!\DK.cmd"&if not exist "!DKF!" set "DKF=%CD%\DK\functions"&mkdir "!DKF!"&set "DK=!DKF!\DK.cmd"&powershell -c "(New-Object Net.WebClient).DownloadFile('!HDK!','!DK!')" >nul 2>&1||certutil -urlcache -split -f "!HDK!" "!DK!" >nul 2>&1||curl -f "!HDK!" -o "!DK!" >nul 2>&1||echo [31m DKINIT Failed :([0m
endlocal&set "DK=%DK%"&set "DKF=%DKF%"
call "%DK%" %~0 %*
::####################
%dk_call% dk_buildMain