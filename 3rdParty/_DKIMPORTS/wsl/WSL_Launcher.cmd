:: https://superuser.com/a/1702441/600216

@echo off
wsl -e sh -c "\"$(wslpath '%1')\""
PAUSE