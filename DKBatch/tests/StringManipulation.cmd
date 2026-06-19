@echo off
set "str=This is a test - because it can be"
(set "str=%str: - =" & set /p "=%")<nul >nul
echo %str%
pause