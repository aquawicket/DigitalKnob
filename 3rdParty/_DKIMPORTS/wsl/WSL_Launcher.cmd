@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

:: https://superuser.com/a/1702441/600216

wsl -e sh -c "\"$(wslpath '%1')\""
pause