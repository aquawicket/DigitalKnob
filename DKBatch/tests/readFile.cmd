@echo off
rem https://www.dostips.com/forum/viewtopic.php?f=3&t=2128&sid=938ec204d04c1482fc7c39b6a457b052
setlocal EnableDelayedExpansion

set "file=C:\UnicodeList.txt"
echo file = %file%
for /f "usebackq" %%b in (`type "%file%" ^| find "" /v /c`) do (
	set /a lines += %%b
)




::echo STOP>>%file%
pause
<"%file%" (
   call :readLoop
)
pause
goto:eof

set /a "n=0"
:readLoop
	set "line="
	set /p line=
	::if defined line   (echo.!line!)
	set /a n+=1
	echo.%n%    !line!
	if %n% gtr %lines% goto:eof
	if !line!==STOP goto:eof
goto :readLoop
