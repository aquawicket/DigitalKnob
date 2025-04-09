@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::#########################################################################################################
::# dk_dateToCentiSeconds(seconds centiseconds %centisecond% %second% %minute% %hour% %day% %month% %year%)
::#
::#
:dk_dateToCentiSeconds
setlocal
    %dk_call% dk_debugFunc 1 9
 
    ::if "%~3" equ "" (set "cs=0")    else (set /a "cs=%~3")
    if "%~3" equ "" (set "cs=0")    else (set /a "cs=100%~3%%100")
    if "%~4" equ "" (set "ss=0")    else (set /a "ss=100%~4%%100")
    if "%~5" equ "" (set "nn=0")    else (set /a "nn=100%~5%%100")
    if "%~6" equ "" (set "hh=0")    else (set /a "hh=100%~6%%100")
    if "%~7" equ "" (set "dd=1")    else (set /a "dd=100%~7%%100")
    if "%~8" equ "" (set "mm=1")    else (set /a "mm=100%~8%%100")
    if "%~9" equ "" (set "yy=1970") else (set /a "yy=10000%~9%%10000")

    set /a "dd=dd-1"
    set /a "mm=mm-1"
    set /a "yy=yy-1970"
    
    set /a "CentiSeconds_cs=%cs%"
    set /a "Seconds_ss=%ss%"
    set /a "Minutes_ss=%nn%*60+%Seconds_ss%"
    set /a "Hours_ss=%hh%*60*60+%Minutes_ss%"
    set /a "Days_ss=%dd%*24*60*60+%Hours_ss%
    set /a "Months_ss=(%mm%*304/10)*24*60*60+%Days_ss%"
    set /a "Years_ss=(%yy%*12*304/10)*24*60*60+%Months_ss%"
    if %Years_ss% gtr 99999999 set /a "Years_ss=Years_ss+2160000"
    endlocal & set "%1=%Years_ss%" & set "%2=%CentiSeconds_cs%"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_getDate Day Month Year
    %dk_call% dk_getTime CentiSecond Second Minute Hour
    echo TIMESTAMP = %Year%-%Month%-%Day%T%Hour%:%Minute%:%Second%.%CentiSecond%
    
    echo:
    echo ###### dk_dateToCentiSeconds ######
    %dk_call% dk_dateToCentiSeconds seconds centiseconds %CentiSecond% %Second% %Minute% %Hour% %Day% %Month% %Year% 
    echo %Year%/%Month%/%Day% %Hour%:%Minute%:%Second%.%CentiSecond% = %seconds%.%centiseconds% seconds
    %dk_call% dk_dateToCentiSeconds seconds centiseconds %CentiSecond% %Second% %Minute% %Hour% %Day% %Month%
    echo %Month%/%Day% %Hour%:%Minute%:%Second%.%CentiSecond% = %seconds%.%centiseconds% seconds
    %dk_call% dk_dateToCentiSeconds seconds centiseconds %CentiSecond% %Second% %Minute% %Hour% %Day%
    echo %Day% %Hour%:%Minute%:%Second%.%CentiSecond% = %seconds%.%centiseconds% seconds
    %dk_call% dk_dateToCentiSeconds seconds centiseconds %CentiSecond% %Second% %Minute% %Hour%
    echo %Hour%:%Minute%:%Second%.%CentiSecond% = %seconds%.%centiseconds% seconds
    %dk_call% dk_dateToCentiSeconds seconds centiseconds %CentiSecond% %Second% %Minute%
    echo %Minute%:%Second%.%CentiSecond% = %seconds%.%centiseconds% seconds
    %dk_call% dk_dateToCentiSeconds seconds centiseconds %CentiSecond% %Second%
    echo :%Second%.%CentiSecond% = %seconds%.%centiseconds% seconds
    %dk_call% dk_dateToCentiSeconds seconds centiseconds %CentiSecond%
    echo .%CentiSecond% = %seconds%.%centiseconds% seconds
%endfunction%
