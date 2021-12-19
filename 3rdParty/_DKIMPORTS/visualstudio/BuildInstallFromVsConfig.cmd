:: Build a Visual Studio 17 2022 installer from 2022.vsconfig file
@echo off &setlocal enabledelayedexpansion
set "vsconfig=2022.vsconfig"
set "vs_community=vs_community__621291036.1634852628.exe"
set "dkdownload=C:\Users\%USERNAME%\digitalknob\Download"
if not exist "!vsconfig!" (
	set "errorlevel=The file !vsconfig! does no exist" 
	Goto :Error
)
if not exist "!vs_community!" (
	set "errorlevel=The file !vs_community! does no exist" 
	Goto :Error
)
if not exist "!dkdownload!" (
	set "errorlevel=The folder !dkdownload! does no exist" 
	Goto :Error
)
set /A i=0

:: Loop through file and store lines into an array
for /F "skip=3 usebackq delims=" %%a in (!file!) do (
	set /A i+=1
	::echo !i!
	set item=%%a
	
	::remove " 
	set item=!item:"=!

	::remove , 
	set item=!item:,=!
	
	::add to array
	set array[!i!]=!item:"=!
	set length=!i!
)

::subtract 2 from length
set /a length=!length!-2  

for /L %%i in (1,1,%length%) do (
	echo !array[%%i]!
)

:: We have the variables we need, so preform the task
::****************************************
start /wait %dkdownload%\%vs_community% --layout "%dkdownload%\VisualStudio" ^
for /L %%i in (1,1,%length%) do (
	--add !array[%%i]! ^
)
--lang en-US --passive --wait > nul
echo %errorlevel%
::****************************************

::****************************************
:End
echo end
pause
exit /b
::****************************************

::****************************************
:Error
cls & Color 0c
echo(
echo %errorlevel%
Pause>nul
exit /b
::****************************************