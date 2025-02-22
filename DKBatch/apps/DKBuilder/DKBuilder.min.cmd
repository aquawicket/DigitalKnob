@echo off&setlocal enableDelayedExpansion&set "HDK=https://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/DKBatch/functions/DK.cmd"&set "DKF=%USERPROFILE%\digitalknob\Development\DKBatch\functions"&set "DK=!DKF!\DK.cmd"&if not exist "!DKF!" (set "DKF=%USERPROFILE%\.dk\DKBatch\functions")&mkdir "!DKF!"&set "DK=!DKF!\DK.cmd"&powershell -c "(New-Object Net.WebClient).DownloadFile('!HDK!','!DK!')" >nul 2>&1||certutil -urlcache -split -f "!HDK!" "!DK!" >nul 2>&1||curl -f "!HDK!" -o "!DK!" >nul 2>&1||echo DK_CMD Failed
endlocal&(set "DK=%DK%"&set "DKF=%DKF%")
call "%DK%" %~0 %*
::takeown /F %DKF% /R /D "Y"
::####################
%dk_call% dk_buildMain