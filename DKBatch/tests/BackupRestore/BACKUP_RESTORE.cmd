@echo off

set "FOLDER=%~dp0"
set "FOLDER=%FOLDER:~0,-1%"
set "SRC=%FOLDER:_BACKUP=%"
set "BACKUP=%FOLDER:_BACKUP=%_BACKUP"

echo   ~dp0 = %~dp0
echo    SRC = %SRC%
echo BACKUP = %BACKUP%
if /i "%~dp0" equ "%SRC%\" 	(goto :BACKUP)
if /i "%~dp0" equ "%BACKUP%\" 	(goto :RESTORE)

:BACKUP
	echo BACKUP:
	del /F /Q "%BACKUP%"
	rd /s /q "%BACKUP%"
	echo D|xcopy "%SRC%" "%BACKUP%" /S /E /H /Y
	cls
	echo Backup complete
exit /b 0

:RESTORE
	echo RESTORE:
	del /F /Q "%SRC%"
	rd /s /q "%SRC%"
	echo D|xcopy "%BACKUP%" "%SRC%" /S /E /H /Y
	cls
	echo Restore complete
exit /b 0