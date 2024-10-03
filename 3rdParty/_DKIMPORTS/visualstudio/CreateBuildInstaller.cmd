@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*


:: Build a Visual Studio 17 2022 installer from 2022.vsconfig file


setlocal enabledelayedexpansion

set "dkdownload=%HOMEDRIVE%%HOMEPATH%\digitalknob\Download"
if not exist "%dkdownload%" (
	set "errorlevel=The folder %dkdownload% does not exist" 
	goto Error
)

set "vsconfig=2022.vsconfig"
if not exist "%vsconfig%" (
	set "errorlevel=The file %vsconfig% does not exist" 
	goto Error
)

set "vs_community=%dkdownload%\vs_Community.exe"
if not exist "%vs_community%" (
	set "errorlevel=The file %vs_community% does not exist" 
	goto Error
)

set /A i=0
%dk_call% dk_echo i = %i%

:: Loop through file and store lines into an array
for /F "skip=3 tokens=1" %%a in (%vsconfig%) do (
	set /A i+=1
	%dk_call% dk_echo i = !i!
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
	%dk_call% dk_echo !array[%%i]!
)

:: We have the variables we need, so preform the task
::******************* BuildInstaller.cmd *********************
(%dk_call% dk_echo start /wait %vs_community% --layout "%dkdownload%\VisualStudio" ^^) > BuildInstaller.cmd
(set LF=^^)
for /L %%i in (1,1,%length%) do (%dk_call% dk_echo --add !array[%%i]! !LF!) >> BuildInstaller.cmd
(%dk_call% dk_echo --lang en-US --passive --wait) >> BuildInstaller.cmd
if NOT "%errorlevel%" == "0" goto Error
::****************************************

::******************* Install.cmd *********************
set "vs_setup=%dkdownload%\VisualStudio\vs_setup.exe"
(%dk_call% dk_echo %vs_setup% --noweb --noUpdateInstaller ^^) > Install.cmd
(set LF=^^)
for /L %%i in (1,1,%length%) do (%dk_call% dk_echo --add !array[%%i]! !LF!) >> Install.cmd
if NOT "%errorlevel%" == "0" goto Error
::****************************************

::****************************************
:End
	%dk_call% dk_echo errorlevel = %errorlevel%
	%dk_call% dk_echo end
	pause
%endfunction%
::****************************************

::****************************************
:Error
	cls & Color 0c
	%dk_call% dk_echo(
	%dk_call% dk_echo Failed with error code: %errorlevel%
	Pause>nul
%endfunction%
::**************************************** 
