@echo off
setlocal EnableDelayedExpansion
::### keep window open ###
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit )

:ENTRY
echo :ENTRY(%*) %0
if "%*" NEQ "" (
	echo ENTRY* = %*
	echo call %*
	call %*
	goto:end
	::echo goto %*
	::goto %*
)

::main
:main
	echo :main(%*) %0
	call:input_timeout %0 "My Message" 5
	::goto:input_timeout "" "My Message" 5
	echo main:eof
goto:eof

::input_timeout <goto> <message> <deadline>
:input_timeout
	echo :input_timeout(%*) %0

	:: goto
	if [%1]==[] (
		set "_goto=Default goto"
	) else (
		set "_goto=%1"
	)
	
	:: message
	if [%2]==[] (
		set "message=Enter Text"
	) else (
		set "message=%2"
	)
	
	:: deadline
	if [%3]==[] (
		set "deadline=10"
	) else (
		set "deadline=%3"
	)
	
	set /a countdown=%deadline%
	set message=%message% (waiting %deadline% seconds)	
	
	echo :input_timeout 1 = %1
	if "%1" == ":input_timeout_secondThread" (
		echo 1 = %1
		goto %1
	)
	::-------------------------------------------------------> call secondThread

	echo :input_timeout 0 = %0
	echo start /b cmd /c %0 :input_timeout_secondThread
	::start /b cmd /c %0 :input_timeout_secondThread
	start /b cmd /c %1 :input_timeout_secondThread
	set n=0
	echo %message%
	goto:input_timeout_loop

	:input_timeout_loop
		echo :input_timeout_loop(%*) %0
		
		set /a second+=1
		TITLE !countdown!
		set /a countdown-=1
		ping -n 2 localhost > nul
		if !second! LSS %deadline% (
			TITLE !countdown!
			if not exist input_timeout.tmp goto :input_timeout_loop
		)
		goto :input_timeout_result
	goto:eof
	
	:input_timeout_secondThread
		echo :input_timeout_secondThread(%*) %0
		
		:: set file from initial input
		del input_timeout.tmp 2>nul >nul
		set /p var=
		> input_timeout.tmp echo !var!
	goto:eof

	:input_timeout_result
		echo :input_timeout_result(%*) %0
		
		if exist input_timeout.tmp (
			set /p result=<input_timeout.tmp
			del input_timeout.tmp 2>nul >nul
		) else (
			set result=default
		)
		
		echo result = %result%
		TITLE %result%
	goto:eof
goto:eof
