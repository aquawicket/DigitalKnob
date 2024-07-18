@echo off
if "%~1" neq "" goto %~1

:main
	echo this is a string echoed from bat_echo
goto:eof

:hour
	set hour=%time:~0,2%
	if "%hour:~0,1%" == " " set hour=0%hour:~1,1%
	echo %hour%
goto:eof

:minute
	set minute=%time:~3,2%
	if "%minute:~0,1%" == " " set minute=0%minute:~1,1%
	echo %minute%
goto:eof

:second
	set second=%time:~6,2%
	if "%second:~0,1%" == " " set second=0%second:~1,1%
	echo %second%
goto:eof

:millisecond
	set millisecond=%time:~9,2%
	if "%millisecond:~0,1%" == " " set millisecond=0%millisecond:~1,1%
	echo %millisecond%
goto:eof