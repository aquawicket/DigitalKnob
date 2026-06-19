@echo off
rem https://www.dostips.com/forum/viewtopic.php?f=3&t=2128&sid=938ec204d04c1482fc7c39b6a457b052
rem chcp 65001>nul


for /f %%a in ('copy /Z %ComSpec% nul') do set "CR=%%a"

endlocal & (set LF=^
%= This creates an escaped Line Feed - DO NOT ALTER =%
)
setlocal EnableDelayedExpansion

set "file=dkconfig.txt"
for /f "usebackq" %%a in (`dir /b /s %file%`)  do (
	for /f "usebackq" %%b in (`type %%a ^| find "" /v /c`) do (
		set /a lines+=%%b
 	)
)
set data=data 
<%file% (
   call :readLoop
)
echo ------------------------ %file% ------------------------
echo !data!
echo --------------------------------------------------------

>"fileOut.txt" echo !data!
pause
goto:eof

set n=0





:readLoop
	set "line="
	(set /p line=)
	
	if defined n (
		(set data=!data!!CR!!LF!%n%: !line!)
	) else (
		set data=0: !line!
	)
	rem for /f "tokens=1,2 delims==" %%a in ("!line!") do (echo a=%%a b=%%b)
	set /a n+=1
	if %n% equ %lines% exit /b 0
goto :readLoop
