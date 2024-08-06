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
	echo DATE = %Month%/%Day%/%Year%
	
	::###### TIME ######
	for /f "tokens=5-8 delims=:. " %%a in ('echo/^|time') do (
	  set Hour=%%a
	  set Minute=%%b
	  set Second=%%c
	  set CentiSecond=%%d
	)
	echo TIME = %Hour%:%Minute%:%Second%.%CentiSecond%
	
	
	::###### DATE-TIME #######
	echo TIMESTAMP = %Year%-%Month%-%Day%T%Hour%:%Minute%:%Second%.%CentiSecond%
	
	::###### REMOVE LEADING ZEROS ######
	set /a "Year=10000%Year%%%10000"
	set /a "Month=100%Month%%%100"
	set /a "Day=100%Day%%%100"
	set /a "Hour=100%Hour%%%100"
	set /a "Minute=100%Minute%%%100"
	set /a "Second=100%Second%%%100"
	set /a "CentiSecond=100%CentiSecond%%%100"
	::echo TIMESTAMP = %Year%-%Month%-%Day%T%Hour%:%Minute%:%Second%.%CentiSecond%
	
	::set "Resolution=CentiSecond"
	::set "Width=Minute"
	
	::     Seconds =    1             Seconds =  1
	::Milliseconds =    1000           Minute =  0.0166667
	::Centiseconds =    100              Hour =  0.00027777833333
	:: Deciseconds =    10
	::     Seconds =    1
	:: Decaseconds =    0.1
	::Hectoseconds =    0.01
	:: Kiloseconds =    0.001
	
	
	
	::###### UNIX TIME ######
	set /a z=(14-100%Month%%%100)/12, y=10000%Year%%%10000-z
	set /a ut=y*365+y/4-y/100+y/400+(153*(100%Month%%%100+12*z-3)+2)/5+Day-719469
	set /a UnixTime=ut*86400+100%Hour%%%100*3600+100%Minute%%%100*60+100%Second%%%100
	echo UnixTime = %UnixTime%
	
	::###### UNIX TIME A ######
	set /a UnixTimeA=100%Hour%%%100*3600+100%Minute%%%100*60+100%Second%%%100
	echo UnixTimeA = %UnixTimeA%
	
	::###### CentiTime ######
	set /a "CentiTime=%CentiSecond%*1"
	echo CentiTime = %CentiTime%
	set /a "SecondTime=(%Second%)*100+%CentiSecond%"
	echo SecondTime = %SecondTime%
	set /a "MinuteTime=((%Minute%)*60+%Second%)*100+%CentiSecond%"
	echo MinuteTime = %MinuteTime%
	set /a "HourTime=(((%Hour%)*60+%Minute%)*60+%Second%)*100+%CentiSecond%"
	echo HourTime = %HourTime%
	set /a "DayTime=((((%Day%)*24+%Hour%)*60+%Minute%)*60+%Second%)*100+%CentiSecond%"
	echo DayTime = %DayTime%
	set /a "MonthTime=(((((%Month%)*30+%Day%)*24+%Hour%)*60+%Minute%)*60+%Second%)*100+%CentiSecond%"
	echo MonthTime = %MonthTime%
	::set /a "YearTime=((((((%Year%)*12+%Month%)*30+%Day%)*24+%Hour%)*60+%Minute%)*60+%Second%)*100+%CentiSecond%"
	::echo YearTime = %YearTime%
	
	

	set /a "CentiTime=%CentiSecond%*1"
	echo CentiTime = %CentiTime%
	

	set /a "SecondTime=%Second%*100+%CentiTime%"
	echo SecondTime = %SecondTime%
	set /a "MinuteTime=%Minute%*60*100+%SecondTime%"
	echo MinuteTime = %MinuteTime%
	set /a "HourTime=%Hour%*60*60*100+%MinuteTime%"
	echo HourTime = %HourTime%
	set /a "DayTime=%Day%*24*60*60*100+%HourTime%
	echo DayTime = %DayTime%
	set /a "MonthTime=%Month%*30*24*60*60*100+%DayTime%"
	echo MonthTime = %MonthTime%
	::set /a "YearTime=%Month%*3110400000+%MonthTime%"
	::echo YearTime = %YearTime%
	
	set /a "CentiB=(%CentiTime%)/1"
	echo CentiB = %CentiB%
	set /a "SecondB=(%SecondTime%-%CentiTime%)/100"
	echo SecondB = %SecondB%
	set /a "MinuteB=(%MinuteTime%-%SecondTime%)/60/100"
	echo MinuteB = %MinuteB%
	set /a "HourB=(%HourTime%-%MinuteTime%)/60/60/100"
	echo HourB = %HourB%
	set /a "DayB=(%DayTime%-%HourTime%)/24/60/60/100"
	echo DayB = %DayB%
	set /a "MonthB=(%MonthTime%-%DayTime%)/30/24/60/60/100"
	echo MonthB = %MonthB%
	::set /a "YearB=(%YearTime%-%MonthTime%)12/30/24/60/60/100"
	::echo YearB = %YearB%
	
	

	
	
	::###### Timer / Elapsed Time ######
	for /f "tokens=1-3 delims= " %%a in ('echo/%ID%') do (
		set last=%%a
		set first=%%b
		set init=%%c
	)
	if {%init%}=={} endlocal & set %1=0 0 %CentiSecondsTime% & goto:eof
	set /a last=CentiSecondsTime-init-first
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
		echo/Seconds since last call: %%a, seconds since first call: %%b
	)
goto:eof
