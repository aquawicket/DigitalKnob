@echo off
setlocal EnableDelayedExpansion

::### keep window open ###
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit )





:::: INPUT_TIMEOUT ::::
echo.
echo A :::: INPUT_TIMEOUT :::: "%1"
set DEADLINE=10
if "%1" NEQ "" goto %1



:input_timeout_mainthread
echo B :input_timeout_mainthread
del input_timeout.tmp 2>nul >nul
start /b cmd /c %0 :input_timeout_secondThread
set n=0
echo Enter Text (%DEADLINE% seconds timeout):



:input_timeout_loop
::echo C :input_timeout_loop
set /a second+=1
ping -n 2 localhost > nul
if !second! LSS %DEADLINE% (
    if not exist input_timeout.tmp goto :input_timeout_loop
    < input_timeout.tmp (
        set /p input=
    )
	set result=!input!
	goto input_timeout_result
   
) ELSE (
	set result=default
	goto input_timeout_result
)
goto:eof


:input_timeout_secondThread
echo B :input_timeout_secondThread
set /p var=
> input_timeout.tmp echo !var!
goto:eof


:input_timeout_result
echo D :input_timeout_result
echo result = %result%