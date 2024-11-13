@echo off&setlocal enableDelayedExpansion&set "HDK=https://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/DKBatch/functions/DK.cmd"&set "DKF=%USERPROFILE%\digitalknob\Development\DKBatch\functionsB"&set "DK=!DKF!\DK.cmd"&if not exist "!DKF!" set "DKF=%CD%\DK"&set "DK=!DKF!\DK.cmd"&mkdir "!DKF!"&powershell -command "(New-Object Net.WebClient).DownloadFile('!HDK!','!DK!')" >nul 2>&1 || certutil -urlcache -split -f "!HDK!" "!DK!" >nul 2>&1 || curl -f "!HDK!" -o "!DK!" >nul 2>&1 || echo [31m DKINIT Failed :( [0m&&call "!DK!" %~0 %*||call "!DK!" %~0 %*
::####################
%dk_call% dk_buildMain

HDK
DKF
DK