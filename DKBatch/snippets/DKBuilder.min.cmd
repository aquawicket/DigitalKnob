@echo off&set "HDK=https://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/DKBatch/functions/DK.cmd"&set "DKBF=%HOMEDRIVE%%HOMEPATH%\digitalknob\Development\DKBatch\functionsB"&if not exist "%DKBF%" set "DKBF=%CD%\DKBF"&set "CMDK=%DKBF%\DK.cmd"&mkdir "%DKBF%"&set "DKBATCH_FUNCTIONS_DIR=%DKBF%"
if not exist "%CMDK%" powershell -command "(New-Object Net.WebClient).DownloadFile('%HDK%', '%CMDK%')" >nul 2>&1 || certutil -urlcache -split -f "%HDK%" "%CMDK%" >nul 2>&1 || curl -f "%HDK%" -o "%CMDK%" >nul 2>&1 || echo [31m DKINIT Failed :( [0m
call "%CMDK%" %~0

::################## DKBuilder ####################
pause
%dk_call% dk_buildMain
