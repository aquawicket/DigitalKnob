:: Build a Visual Studio 17 2022 installer from 2022.vsconfig file
@echo off &setlocal enabledelayedexpansion
set "file=2022.vsconfig"
if not exist "!file!" (Goto :Error)
set /A i=0

:: Loop through file and store lines into an array
for /F "skip=3 usebackq delims=" %%a in (!file!) do (
	set /A i+=1
	::echo !i!
	set array[!i!]=%%a
	set length=!i!
)

::subtract 2 from length
set /a length=!length!-2  

for /L %%i in (1,1,%length%) do (
	echo !array[%%i]!
)

pause

:End
exit /b

::****************************************
:Error
cls & Color 4c
echo(
echo The file %vsconfig_file% does not exist
Pause>nul
exit /b
::****************************************