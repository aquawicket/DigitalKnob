@echo off


::start echo test ^> \\.\pipe\TestPipe ^| (set /p line= ^& echo line=%%line%%)
:: | ( set /p line= & echo %%line%%" & pause)
FOR /F "tokens=* USEBACKQ" %%F IN (`start echo test ^| \\.\pipe\TestPipe` ^| echo) DO (
echo %%F
)
ECHO %var%
pause