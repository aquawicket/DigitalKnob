:: Build a Visual Studio 17 2022 installer from 2022.vsconfig file
@echo off
set "file=2022.vsconfig"
if not exist "%file%" (Goto :Error)
set /A i=0

for /F "skip=3 usebackq delims=" %%a in ("%file%") do (
	set /A i+=1
	::call echo %%i%%
	call set array[%%i%%]=%%a
	call set n=%%i%%
)

for /L %%i in (1,1,%n%) do (
	call echo %%array[%%i]%%
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