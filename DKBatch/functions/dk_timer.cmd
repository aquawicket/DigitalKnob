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
	setlocal enableExtensions
	echo:
	call set ID=%%%1%%
	
	::###### DATE ######
	set t=2
	if "%date%z" LSS "A" set t=1
	for /f "skip=1 tokens=2-4 delims=(-)" %%a in ('echo/^|date') do (
		for /f "tokens=%t%-4 delims=.-/ " %%d in ('date/t') do (
			set %%a=%%d
			set %%b=%%e
			set %%c=%%f
		)
	)
	set "Year=%yy%"
	set "Month=%mm%"
	set "Day=%dd%"

	::###### TIME ######
	for /f "tokens=5-8 delims=:. " %%a in ('echo/^|time') do (
	  set Hour=%%a
	  set Minute=%%b
	  set Second=%%c
	  set CentiSecond=%%d
	)
	
	::###### DATE-TIME #######
	::echo TIMESTAMP = %Year%-%Month%-%Day%T%Hour%:%Minute%:%Second%.%CentiSecond%
	
	
::	::###### centiSecondsToDate ######
::	echo:
::	echo ###### centiSecondsToDate ######
::	call:centiSecondsToDate %csecCSecs% csec
::	echo dateCsec = %csec%
::	call:centiSecondsToDate %secCSecs% csec sec
::	echo dateSec = %sec%.%csec%
::	call:centiSecondsToDate %minCSecs% csec sec min
::	echo dateMin = %min%:%sec%.%csec%
::	call:centiSecondsToDate %hourCSecs% csec sec min hour
::	echo dateHour = %hour%:%min%:%sec%.%csec%
::	call:centiSecondsToDate %dayCSecs% csec sec min hour day
::	echo dateDay = %day%T%hour%:%min%:%sec%.%csec%
::	call:centiSecondsToDate %monthCSecs% csec sec min hour day month
::	echo dateMonth = %month%-%day%T%hour%:%min%:%sec%.%csec%
::	call:centiSecondsToDate %yearCSecs% csec sec min hour day month year
::	echo dateYear = %year%-%month%-%day%T%hour%:%min%:%sec%.%csec% 

::	::###### BACK TO DATE ######
::	echo:
::	echo ###### BACK TO DATE ######
::	set /a "CentiB=(%CentiTime%)/1"
::	echo CentiB = %CentiB%
::	set /a "SecondB=(%SecondTime%-%CentiTime%)/100"
::	echo SecondB = %SecondB%
::	set /a "MinuteB=(%MinuteTime%-%SecondTime%)/60/100"
::	echo MinuteB = %MinuteB%
::	set /a "HourB=(%HourTime%-%MinuteTime%)/60/60/100"
::	echo HourB = %HourB%
::	set /a "DayB=(%DayTime%-%HourTime%)/24/60/60/100"
::	echo DayB = %DayB%
::	set /a "MonthB=(%MonthTime%-%DayTime%)/30/24/60/60/100"
::	echo MonthB = %MonthB%
::	::set /a "YearB=(%YearTime%-%MonthTime%)12/30/24/60/60/100"
::	::echo YearB = %YearB%
	
	

	call dk_dateToCentiSeconds seconds centiseconds %CentiSecond% %Second% %Minute% %Hour%
	set /a CentiSeconds=%seconds%*100+%centiseconds%
	
	::###### Timer / Elapsed Time ######
	echo: 
	echo ###### Timer / Elapsed Time ######
	for /f "tokens=1-3 delims= " %%a in ('echo/%ID%') do (
		set last=%%a
		set first=%%b
		set init=%%c
	)
	if {%init%}=={} endlocal & set %1=0 0 %CentiSeconds% & goto:eof
	set /a last=CentiSeconds-init-first
	set /a first+=last
	endlocal & set %1=%last% %first% %init%
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	call dk_minMaxArgs 0
	
	set "t1="
	call dk_timer t1
	echo t1 = %t1%
	call :show

	::wait about 1 seconds
	ping 127.0.0.1 -n 2 >nul
	call dk_timer t1
	echo t1 = %t1%
	call :show

	::wait about 2 seconds
	ping 127.0.0.1 -n 3 >nul
	call dk_timer t1
	echo t1 = %t1%
	call :show
	
	::wait about 3 seconds
	ping 127.0.0.1 -n 4 >nul
	call dk_timer t1
	echo t1 = %t1%
	call :show
goto:eof	

:show
	for /f "tokens=1-2 delims= " %%a in ('echo/%t1%') do (
		set /a "last.seconds=%%a/100"
		set /a "last.centiseconds=%%a-last.seconds*100"
		set /a "first.seconds=%%b/100"
		set /a "first.centiseconds=%%b-first.seconds*100"
		echo Seconds since last call: !last.seconds!.!last.centiseconds!, seconds since first call: !first.seconds!.!first.centiseconds!
	)
goto:eof
