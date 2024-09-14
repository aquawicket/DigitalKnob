@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*

::##################################################################################
::# dk_secondsToDate(%seconds% second minute hour day month year)
::#
::#
:dk_secondsToDate 
    call dk_debugFunc 1 7
 setlocal
 
    set /a i=%1
    set /a ss=i%%60
    set /a i/=60
    set /a nn=i%%60
    set /a i/=60
    set /a hh=i%%24
    set /a dd=i/24
    set /a i/=24
    set /a a=i+2472632
    set /a b=4*a+3
    set /a b/=146097
    set /a c=-b*146097
    set /a c/=4
    set /a c+=a
    set /a d=4*c+3
    set /a d/=1461
    set /a e=-1461*d
    set /a e/=4
    set /a e+=c
    set /a m=5*e+2
    set /a m/=153
    set /a dd=153*m+2
    set /a dd/=5
    set /a dd=-dd+e+1
    set /a mm=-m/10
    set /a mm*=12
    set /a mm+=m+3
    set /a yy=b*100+d-4800+m/10
    (if %mm% LSS 10 set mm=0%mm%)&(if %dd% LSS 10 set dd=0%dd%)
    (if %hh% LSS 10 set hh=0%hh%)&(if %nn% LSS 10 set nn=0%nn%)
    if %ss% LSS 10 set ss=0%ss%
    endlocal & set "%2=%ss%" & set "%3=%nn%" & set "%4=%hh%" & set "%5=%dd%" & set "%6=%mm%" & set "%7=%yy%"

    ::  set /a "CentiB=(%CentiTime%)/1"
    ::  echo CentiB = %CentiB%
    ::  set /a "SecondB=(%SecondTime%-%CentiTime%)/100"
    ::  echo SecondB = %SecondB%
    ::  set /a "MinuteB=(%MinuteTime%-%SecondTime%)/60/100"
    ::  echo MinuteB = %MinuteB%
    ::  set /a "HourB=(%HourTime%-%MinuteTime%)/60/60/100"
    ::  echo HourB = %HourB%
    ::  set /a "DayB=(%DayTime%-%HourTime%)/24/60/60/100"
    ::  echo DayB = %DayB%
    ::  set /a "MonthB=(%MonthTime%-%DayTime%)/30/24/60/60/100"
    ::  echo MonthB = %MonthB%
    ::  ::set /a "YearB=(%YearTime%-%MonthTime%)12/30/24/60/60/100"
    ::  ::echo YearB = %YearB%
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_getDate Day Month Year
    %dk_call% dk_getTime CentiSecond Second Minute Hour
    echo TIMESTAMP = %Year%-%Month%-%Day%T%Hour%:%Minute%:%Second%.%CentiSecond%
    
    %dk_call% dk_dateToSeconds seconds %Second% %Minute% %Hour% %Day% %Month% %Year%
    %dk_call% dk_secondsToDate %seconds% SecondB MinuteB HourB DayB MonthB YearB
    echo TIMESTAMP = %YearB%-%MonthB%-%DayB%T%HourB%:%MinuteB%:%SecondB%
%endfunction%
