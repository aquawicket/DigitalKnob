echo off

tasklist /v /fo csv

set "Title=DigitalKnob_%RANDOM%"
title %Title%
for /f "tokens=1-10 Delims=," %%a IN ('tasklist /v /fo csv ^| findstr /i "%Title%"') Do (
	rem echo Image_Name    = %%~a
	set "PID=%%~b"
	rem echo Session_Name  = %%~c
	rem echo Session#      = %%~d
	rem echo Mem_Usage     = %%~e,%%~f
	rem echo Status        = %%~g
	rem echo User_Name     = %%~h
	rem echo CPU Time      = %%~i
	rem echo Window_Title  = %%~j
)


pause
