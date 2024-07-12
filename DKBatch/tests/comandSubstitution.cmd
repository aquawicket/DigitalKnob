@echo off
call ..\functions\DK.cmd


::set "cmnd=&echo < "
set "$(=&call :mySub "
set ")=echo :%subfunc%"

:main
::	call :getversion
::	call echo ver = %ver%
::	call dk_echo "text before ,%ver%, text after"
	
::	set "command=ver"
::	call echo %command% = %%%command%%%
::	call dk_echo "text before ,%%%command%%%, text after"
	
::	set "myVar=%ver%"
::	call dk_echo "myVar = %myVar%"
	
::	set var=%$(%cmnd%)%
::	echo var = ,%var%, 
::	pause

	set ver=&call :funcA
	echo ver = %ver%
	
	set "start=&call :start "

	echo loading %start%dk_test
	call dk_echo "start = before %start%!dk_test!%end% after"
	
	pause
goto:eof


:funcA
	set ver=&for /f "usebackq tokens=*" %%a in (`ver`) do set "ver=%%a"
goto:eof

:start
	set start=&for /f "usebackq tokens=*" %%a in (`%1`) do set "end=%%a"
goto:eof


