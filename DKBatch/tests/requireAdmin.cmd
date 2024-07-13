@echo off & cls & echo:
net file 1>nul 2>nul & if errorlevel 1 (echo you must right-click and select & echo "run as administrator"  to run this batch. exiting... & echo: & pause & exit /d)
REM ... proceed here with admin rights ...

pause