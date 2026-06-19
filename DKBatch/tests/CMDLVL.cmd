@echo off


if NOT DEFINED CMDLVL (set CMDLVL=0)
:loop
if DEFINED CMDLINE_%CMDLVL% (
	set /a CMDLVL+=1
	goto:loop
)
if NOT DEFINED pad (set "pad=")
set "padchar=     "
for /l %%x in (1, 1, %CMDLVL%) do (set pad=%pad%%padchar%)


echo.
echo %pad%### ENTER %CMDLVL% ###
set CMDLINE_%CMDLVL%=%CMDCMDLINE%
echo %pad%CMDLVL = %CMDLVL%
call echo %pad%CMDLINE_%CMDLVL% = %%CMDLINE_%CMDLVL%%%
set "caller=%~1"
if "%caller%" equ "" (set "caller=main")
echo %pad%caller = %caller%

if %CMDLVL% lss 5 (
	%ComSpec% /c %~f0 %CMDLVL%
	call echo %pad%errorlevel = %%errorlevel%%
	echo.
	echo %pad%CMDLVL = %CMDLVL%
)
echo %pad%### EXITING %CMDLVL% ###



if %CMDLVL% equ 0 (pause)
exit %CMDLVL%

