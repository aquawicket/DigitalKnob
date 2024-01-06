:: Build a Visual Studio 17 2022 installer from 2022.vsconfig file
@echo off & %dkbatch%

setlocal enabledelayedexpansion

set "dkdownload=C:\Users\%USERNAME%\digitalknob\Download"
if not exist "%dkdownload%" (
	set "errorlevel=The folder %dkdownload% does not exist" 
	Goto :Error
)

set "vsconfig=2022.vsconfig"
if not exist "%vsconfig%" (
	set "errorlevel=The file %vsconfig% does not exist" 
	Goto :Error
)

set "vs_community=%dkdownload%\vs_Community.exe"
if not exist "%vs_community%" (
	set "errorlevel=The file %vs_community% does not exist" 
	Goto :Error
)

set /A i=0
echo i = %i%

:: Loop through file and store lines into an array
for /F "skip=3 tokens=1" %%a in (%vsconfig%) do (
	set /A i+=1
	echo i = !i!
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
set /a length=%length%-2  

for /L %%i in (1,1,%length%) do (
	echo !array[%%i]!
)

:: We have the variables we need, so preform the task
::******************* BuildInstaller.cmd *********************
(echo start /wait %vs_community% --layout "%dkdownload%\VisualStudio" ^^) > BuildInstaller.cmd
(set LF=^^)
for /L %%i in (1,1,%length%) do (echo --add !array[%%i]! !LF!) >> BuildInstaller.cmd
(echo --lang en-US --passive --wait) >> BuildInstaller.cmd
if NOT "%errorlevel%" == "0" goto Error
::****************************************

::******************* Install.cmd *********************
set "vs_setup=%dkdownload%\VisualStudio\vs_setup.exe"
(echo %vs_setup% --noweb --noUpdateInstaller ^^) > Install.cmd
(set LF=^^)
for /L %%i in (1,1,%length%) do (echo --add !array[%%i]! !LF!) >> Install.cmd
if NOT "%errorlevel%" == "0" goto Error
::****************************************

::****************************************
:End
echo errorlevel = %errorlevel%
echo end
pause
exit /b
::****************************************

::****************************************
:Error
cls & Color 0c
echo(
echo Failed with error code: %errorlevel%
Pause>nul
exit /b
::**************************************** 
 
%DKEND% 
