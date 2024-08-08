@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::################################################################################
::# dk_timer(ID)
::#
::#    Func: Returns number of seconds elapsed since the function was last
::#        called and first called. For NT4/2000/XP/2003.
::#
::#    Args: %1 (by ref) The first time this function is called, this variable
::#        is initialised to '<last> <first> <init>' where <last> and <first>
::#        are zero and <init> is the number of elapsed seconds since
::#        1970-01-01 00:00:00. This value is used by subsequent calls to
::#        determine the elapsed number of seconds since the last call
::#        (<last>) and the first call (<first>).
::#
::#    REFERENCE: https://ritchielawrence.github.io/batchfunctionlibrary/
::#
:dk_timer
	setlocal enableDelayedExpansion
	
	::call dk_getTime centisecond second minute hour
	for /f "tokens=1-3 delims=1234567890 " %%a in ("%time%") do set "delims=%%a%%b%%c" 
	for /f "tokens=1-4 delims=%delims%" %%A in ("%time%") do (set "hour=%%A" & set "minute=%%B" & set "second=%%C" & set "centiseconds=%%D")
	set /a "second=100%second%%%100,minute=100%minute%%%100,hour=100%hour: =%%%100"
	::echo TIME = %hour%:%minute%:%second%.%centiseconds%
	
	::call dk_dateToCentiSeconds seconds centiseconds %centisecond% %second% %minute% %hour%
	set /a "seconds=(hour*60*60)+(minutes*60)+second"
	set /a "currentTime=%seconds%%centiseconds%"	

	if {!%~1.startTime!}=={} endlocal & set %1.startTime=%currentTime% & set %1.lastTime=%currentTime% & goto:eof
	set "startTime=!%~1.startTime!
	set "lastTime=!%~1.lastTime!"
	
	::echo startTime = %startTime%
	echo lastTime = %lastTime%
	echo currentTime = %currentTime%
	

	
	
	set /a "lastElapsed=currentTime-lastTime"
	set /a "elapsed.whole=%lastElapsed%/100, elapsed.fraction=%lastElapsed%%%100"
	
	
	endlocal & set "%1.lastTime=%currentTime%" & set "%1=%elapsed.whole%.%elapsed.fraction%"
	
	::echo %~1.startTime = !%~1.startTime!
	echo %~1.lastTime = !%~1.lastTime!
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	call dk_minMaxArgs 0
	
	
	call dk_timer t1


	echo:
	echo waiting about 1 millisecond
	call dk_sleep 1
	call dk_timer t1
	echo Seconds since last call: = %t1%

	echo:
	echo waiting about 10 milliseconds
	call dk_sleep 10
	call dk_timer t1
	echo Seconds since last call: = %t1%
	
	echo:
	echo waiting about 100 milliseconds
	call dk_sleep 100
	call dk_timer t1
	echo Seconds since last call: = %t1%
	
	echo:
	echo waiting about 1000 milliseconds
	call dk_sleep 1000
	call dk_timer t1
	echo Seconds since last call: = %t1%
	
	:timerLoop
		echo:
		echo waiting about 1000 milliseconds
		call dk_sleep 1000
		call dk_timer t1
		echo Seconds since last call: = %t1%
	goto:timerLoop
goto:eof	
