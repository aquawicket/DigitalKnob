@echo off
call :label
echo returned
pause
exit /b

:label
test_without_callB
exit /b