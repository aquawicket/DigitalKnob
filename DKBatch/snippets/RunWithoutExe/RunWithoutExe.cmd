@echo off
cd %~dp0
rem https://www.hexacorn.com/blog/2019/04/21/cmd-exe-running-any-file-no-matter-what-extension
rem https://ss64.com/nt/start.html

rem ###### HelloWorld.exe ######
echo ### HelloWorld.exe ###
start "" /b /wait /min "HelloWorld.exe"

rem ###### HelloWorld.foo ######
echo ### HelloWorld.foo ###
start "" /b /wait /min "HelloWorld.foo"

rem ###### HelloWorld ######
echo ### HelloWorld ###
start "" /b /wait /min "HelloWorld"

rem ###### HelloWorld.txt ######
echo ### HelloWorld.txt ###
start "" /b /wait /min "HelloWorld.txt"


rem ###### HelloWorld ######
rem echo ### HelloWorld ###
rem ::# Backup the .txt association and set it to cmdfile
rem FOR /F "tokens=*" %%g IN ('%ComSpec% /c ASSOC .') do (SET backup=%%g)
rem if not defined backup (set "backup=.=")
rem ::# Set assoc . to cmdfile
rem "%ComSpec%" /c assoc .=cmdfile
rem start "" /b /wait /min "HelloWorld"
rem ::# restore . assoc backup
rem "%ComSpec%" /c assoc %backup%
pause