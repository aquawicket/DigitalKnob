@echo off
:: https://superuser.com/a/1702441/600216

wsl -e sh -c "\"$(wslpath '%1')\""
pause