@rem shebang
@echo off&rem ###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
	setlocal enableDelayedExpansion
	if NOT EXIST "%DK.cmd%" (set "DK.cmd=%USERPROFILE%\Digital Knob\Development\DKBatch\functions\DK.cmd")
	if NOT DEFINED DK.cmd (for /F "delims=" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
	if NOT EXIST "!DK.cmd!" (
		start "" /b /wait /min "curl.exe" --silent --location --create-dirs --output "!DK.cmd!" http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DK.cmd)
	call "!DK.cmd:/=\!" "%%~0" %%*
	exit /b %errorlevel%
)
rem #################################################################################################################################################


rem ##################################################################################
rem # dk_secondsToDate(%seconds% second minute hour day month year)
rem #
rem #
:dk_secondsToDate
%setlocal%

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

    rem  set /a "CentiB=(%CentiTime%)/1"
    rem  echo CentiB = %CentiB%
    rem  set /a "SecondB=(%SecondTime%-%CentiTime%)/100"
    rem  echo SecondB = %SecondB%
    rem  set /a "MinuteB=(%MinuteTime%-%SecondTime%)/60/100"
    rem  echo MinuteB = %MinuteB%
    rem  set /a "HourB=(%HourTime%-%MinuteTime%)/60/60/100"
    rem  echo HourB = %HourB%
    rem  set /a "DayB=(%DayTime%-%HourTime%)/24/60/60/100"
    rem  echo DayB = %DayB%
    rem  set /a "MonthB=(%MonthTime%-%DayTime%)/30/24/60/60/100"
    rem  echo MonthB = %MonthB%
    rem  ::set /a "YearB=(%YearTime%-%MonthTime%)12/30/24/60/60/100"
    rem  ::echo YearB = %YearB%
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

    %dk_call% dk_getDate Day Month Year
    %dk_call% dk_getTime CentiSecond Second Minute Hour
    echo TIMESTAMP = %Year%-%Month%-%Day%T%Hour%:%Minute%:%Second%.%CentiSecond%
   
    %dk_call% dk_dateToSeconds seconds %Second% %Minute% %Hour% %Day% %Month% %Year%
    %dk_call% dk_secondsToDate %seconds% SecondB MinuteB HourB DayB MonthB YearB
    echo TIMESTAMP = %YearB%-%MonthB%-%DayB%T%HourB%:%MinuteB%:%SecondB%
%endfunction%
