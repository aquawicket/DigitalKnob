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
	echo:
	echo ###### DATE ######
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
	echo:
	echo ###### TIME ######
	for /f "tokens=5-8 delims=:. " %%a in ('echo/^|time') do (
	  set Hour=%%a
	  set Minute=%%b
	  set Second=%%c
	  set CentiSecond=%%d
	)
	echo TIME = %Hour%:%Minute%:%Second%.%CentiSecond%
	
	
	::###### DATE-TIME #######
	echo:
	echo ###### DATE-TIME #######
	echo TIMESTAMP = %Year%-%Month%-%Day%T%Hour%:%Minute%:%Second%.%CentiSecond%
	
	
	::###### REMOVE LEADING ZEROS ######
	echo:
	echo: ###### REMOVE LEADING ZEROS ######
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
	

	::###### dateToSec ######
	echo:
	echo ###### dateToSec ######
	call:dateToSec yearSecs %Second% %Minute% %Hour% %Day% %Month% %Year% 
	echo yearSecs = %yearSecs%
	call:dateToSec monthSecs %Second% %Minute% %Hour% %Day% %Month%
	echo monthSecs = %monthSecs%
	call:dateToSec daySecs %Second% %Minute% %Hour% %Day%
	echo daySecs = %daySecs%
	call:dateToSec hourSecs %Second% %Minute% %Hour%
	echo hourSecs = %hourSecs%
	call:dateToSec minSecs %Second% %Minute%
	echo minSecs = %minSecs%
	call:dateToSec secSecs %Second%
	echo secSecs = %secSecs%
	
	::###### secToDate ######
	echo:
	echo ###### secToDate ######
	call:secToDate %secSecs% sec
	echo dateSec = %sec%
	call:secToDate %minSecs% sec min
	echo dateMin = %min%:%sec%
	call:secToDate %hourSecs% sec min hour
	echo dateHour = %hour%:%min%:%sec%
	call:secToDate %daySecs% sec min hour day
	echo dateDay = %day%T%hour%:%min%:%sec%
	call:secToDate %monthSecs% sec min hour day month
	echo dateMonth = %month%-%day%T%hour%:%min%:%sec%
	call:secToDate %yearSecs% sec min hour day month year
	echo dateYear = %year%-%month%-%day%T%hour%:%min%:%sec% 
	
	::###### dateToCentiSeconds ######
	echo:
	echo ###### dateToCentiSeconds ######
	call:dateToCentiSeconds yearCSecs %CentiSecond% %Second% %Minute% %Hour% %Day% %Month% %Year% 
	echo yearCSecs = %yearCSecs%
	call:dateToCentiSeconds monthCSecs %CentiSecond% %Second% %Minute% %Hour% %Day% %Month%
	echo monthCSecs = %monthCSecs%
	call:dateToCentiSeconds dayCSecs %CentiSecond% %Second% %Minute% %Hour% %Day%
	echo dayCSecsB = %dayCSecs%
	call:dateToCentiSeconds hourCSecs %CentiSecond% %Second% %Minute% %Hour%
	echo hourCSecs = %hourCSecs%
	call:dateToCentiSeconds minCSecs %CentiSecond% %Second% %Minute%
	echo minCSecs = %minCSecs%
	call:dateToCentiSeconds secCSecs %CentiSecond% %Second%
	echo secCSecs = %secCSecs%
	call:dateToCentiSeconds csecCSecs %CentiSecond%
	echo csecCSecs = %csecCSecs%
	
	
	::###### TO CentiTime ######
	echo:
	echo ###### TO CentiTime ######
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
	
	
	::###### TO CentiTimeB ######
	echo:
	echo ###### TO CentiTimeB ######
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
	
	
	::###### BACK TO DATE ######
	echo:
	echo ###### BACK TO DATE ######
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
	echo: 
	echo ###### Timer / Elapsed Time ######
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

:dateToSec sec %second% %minute% %hour% %day% %month% %year%
	setlocal enableExtensions
	set ss=%2
	set nn=%3
	set hh=%4
	set dd=%5
	set mm=%6
	set yy=%7
	if "%yy%" equ "" set yy=1970
	if "%mm%" equ "" set mm=01
	if "%dd%" equ "" set dd=01
	if "%hh%" equ "" set hh=00
	if "%nn%" equ "" set nn=00
	if 1%yy% LSS 200 if 1%yy% LSS 170 (set yy=20%yy%) else (set yy=19%yy%)
	set /a dd=100%dd%%%100,mm=100%mm%%%100
	set /a z=14-mm,z/=12,y=yy+4800-z,m=mm+12*z-3,j=153*m+2
	set /a j=j/5+dd+y*365+y/4-y/100+y/400-2472633
	if 1%hh% LSS 20 set hh=0%hh%
	if {%nn:~2,1%} EQU {p} if "%hh%" NEQ "12" set hh=1%hh%&set/a hh-=88
	if {%nn:~2,1%} EQU {a} if "%hh%" EQU "12" set hh=00
	if {%nn:~2,1%} GEQ {a} set nn=%nn:~0,2%
	set /a hh=100%hh%%%100,nn=100%nn%%%100,ss=100%ss%%%100
	set /a j=j*86400+hh*3600+nn*60+ss
	endlocal & set %1=%j%
goto :EOF

:secToDate %secs% second minute hour day month year
	setlocal ENABLEEXTENSIONS
	set /a i=%1,ss=i%%60,i/=60,nn=i%%60,i/=60,hh=i%%24,dd=i/24,i/=24
	set /a a=i+2472632,b=4*a+3,b/=146097,c=-b*146097,c/=4,c+=a
	set /a d=4*c+3,d/=1461,e=-1461*d,e/=4,e+=c,m=5*e+2,m/=153,dd=153*m+2,dd/=5
	set /a dd=-dd+e+1,mm=-m/10,mm*=12,mm+=m+3,yy=b*100+d-4800+m/10
	(if %mm% LSS 10 set mm=0%mm%)&(if %dd% LSS 10 set dd=0%dd%)
	(if %hh% LSS 10 set hh=0%hh%)&(if %nn% LSS 10 set nn=0%nn%)
	if %ss% LSS 10 set ss=0%ss%
	endlocal & set "%2=%ss%" & if "%3" neq "" set "%3=%nn%" & if "%4" neq "" set "%4=%hh%" & if "%5" neq "" set "%5=%dd%" & if "%6" neq "" set "%6=%mm%" & if "%7" neq "" set "%7=%yy%"
goto:eof


:dateToSecB sec %second% %minute% %hour% %day% %month% %year%
	setlocal
	set ss=%2
	set nn=%3
	set hh=%4
	set dd=%5
	set mm=%6
	set yy=%7
	if "%yy%" equ "" set yy=1970
	if "%mm%" equ "" set mm=01
	if "%dd%" equ "" set dd=01
	if "%hh%" equ "" set hh=00
	if "%nn%" equ "" set nn=00
	set /a z=(14-100%mm%%%100)/12, y=10000%yy%%%10000-z
	set /a ut=y*365+y/4-y/100+y/400+(153*(100%Month%%%100+12*z-3)+2)/5+dd-719469
	set /a UnixTime=ut*86400+100%hh%%%100*3600+100%nn%%%100*60+100%ss%%%100
	endlocal & set %1=%UnixTime%
goto:eof

:dateToCentiSeconds centiSeconds %centiSecond% %second% %minute% %hour% %day% %month% %year%
	setlocal enableExtensions
	set cs=%2
	set ss=%3
	set nn=%4
	set hh=%5
	set dd=%6
	set mm=%7
	set yy=%8
	if "%yy%" equ "" set yy=1970
	if "%mm%" equ "" set mm=01
	if "%dd%" equ "" set dd=01
	if "%hh%" equ "" set hh=00
	if "%nn%" equ "" set nn=00
	if "%ss%" equ "" set ss=00
	if 1%yy% LSS 200 if 1%yy% LSS 170 (set yy=20%yy%) else (set yy=19%yy%)
	set /a dd=100%dd%%%100,mm=100%mm%%%100
	set /a z=14-mm,z/=12,y=yy+4800-z,m=mm+12*z-3,j=153*m+2
	set /a j=j/5+dd+y*365+y/4-y/100+y/400-2472633
	if 1%hh% LSS 20 set hh=0%hh%
	if {%nn:~2,1%} EQU {p} if "%hh%" NEQ "12" set hh=1%hh%&set/a hh-=88
	if {%nn:~2,1%} EQU {a} if "%hh%" EQU "12" set hh=00
	if {%nn:~2,1%} GEQ {a} set nn=%nn:~0,2%
	set cs=%cs:~0,2%
	set /a hh=100%hh%%%100,nn=100%nn%%%100,ss=100%ss%%%100
	set /a j=j*86400+hh*3600+nn*60+ss*100+cs
	endlocal & set %1=%j%
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
