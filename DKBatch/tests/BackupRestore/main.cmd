@echo off
call "BACKUP_RESTORE.cmd"

echo.
call "deleteSelf.cmd"
echo returned to main.cmd %errorlevel%

echo.
call "%~dp0\Parent Folder\deleteParentFolder.cmd"
echo returned to main.cmd %errorlevel%

echo.
call "moveSelf.cmd"
echo returned to main.cmd %errorlevel%

echo.
pause