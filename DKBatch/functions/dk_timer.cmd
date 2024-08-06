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
	
	::###### DATE TO Seconds ######
	call:dateToSec %Year% %Month% %Day% %Hour% %Minute% %Second% yearSecs
	echo yearSecs = %yearSecs%
	call:dateToSec 1970 %Month% %Day% %Hour% %Minute% %Second% monthSecs
	echo monthSecs = %monthSecs%
	call:dateToSec 1970 01 %Day% %Hour% %Minute% %Second% daySecs
	echo daySecs = %daySecs%
	call:dateToSec 1970 01 01 %Hour% %Minute% %Second% hourSecs
	echo hourSecs = %hourSecs%
	call:dateToSec 1970 01 01 00 %Minute% %Second% minSecs
	echo minSecs = %minSecs%
	call:dateToSec 1970 01 01 00 00 %Second% secSecs
	echo secSecs = %secSecs%
	
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
	
	
	::###### BACK TO DATE ######
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

:: A good alternative would be 
:: :dateToSec secs %ss% %nn% %hh% %dd% %mm% %yy%
:: This would always set the return variable as the first arg.
:: Then you could increment the arguments added to increase Resolution
:: I.E.  call:dateToSec mySecs %Seconds% %Minutes%
::     This would only provide a resolution of 59 minutes. 
:dateToSec %yy% %mm% %dd% %hh% %nn% %ss% secs
	setlocal ENABLEEXTENSIONS
	set yy=%1&set mm=%2&set dd=%3&set hh=%4&set nn=%5&set ss=%6
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
	endlocal&set %7=%j%
goto :EOF

:secToDate %secs% yy mm dd hh nn ss
	setlocal ENABLEEXTENSIONS
	set /a i=%1,ss=i%%60,i/=60,nn=i%%60,i/=60,hh=i%%24,dd=i/24,i/=24
	set /a a=i+2472632,b=4*a+3,b/=146097,c=-b*146097,c/=4,c+=a
	set /a d=4*c+3,d/=1461,e=-1461*d,e/=4,e+=c,m=5*e+2,m/=153,dd=153*m+2,dd/=5
	set /a dd=-dd+e+1,mm=-m/10,mm*=12,mm+=m+3,yy=b*100+d-4800+m/10
	(if %mm% LSS 10 set mm=0%mm%)&(if %dd% LSS 10 set dd=0%dd%)
	(if %hh% LSS 10 set hh=0%hh%)&(if %nn% LSS 10 set nn=0%nn%)
	if %ss% LSS 10 set ss=0%ss%
	endlocal&set %7=%ss%&set %6=%nn%&set %5=%hh%&^
	set %4=%dd%&set %3=%mm%&set %2=%yy%
goto :EOF

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
