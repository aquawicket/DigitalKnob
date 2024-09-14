@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::##################################################################################
::# dk_dateToSeconds(seconds %second% %minute% %hour% %day% %month% %year%)
::#
::#
:dk_dateToSeconds
    call dk_debugFunc 1 7
 setlocal
 
    setlocal
    if "%~2" equ "" (set "ss=0")    else (set /a "ss=100%~2%%100")
    if "%~3" equ "" (set "nn=0")    else (set /a "nn=100%~3%%100")
    if "%~4" equ "" (set "hh=0")    else (set /a "hh=100%~4%%100")
    if "%~5" equ "" (set "dd=1")    else (set /a "dd=100%~5%%100")
    if "%~6" equ "" (set "mm=1")    else (set /a "mm=100%~6%%100")
    if "%~7" equ "" (set "yy=1970") else (set /a "yy=10000%~7%%10000")

    set /a "dd=dd-1"
    set /a "mm=mm-1"
    set /a "yy=yy-1970"
    
    set /a "Seconds_ss=%ss%"
    set /a "Minutes_ss=%nn%*60+%Seconds_ss%"
    set /a "Hours_ss=%hh%*60*60+%Minutes_ss%"
    set /a "Days_ss=%dd%*24*60*60+%Hours_ss%
    set /a "Months_ss=(%mm%*304/10)*24*60*60+%Days_ss%"
    set /a "Years_ss=(%yy%*12*304/10)*24*60*60+%Months_ss%"
    if %Years_ss% gtr 99999999 set /a "Years_ss=Years_ss+2160000"
    endlocal & set %1=%Years_ss%
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_getDate Day Month Year
    %dk_call% dk_getTime CentiSecond Second Minute Hour
    echo TIMESTAMP = %Year%-%Month%-%Day%T%Hour%:%Minute%:%Second%.%CentiSecond%
    
    echo:
    echo ###### dk_dateToSeconds ######
    %dk_call% dk_dateToSeconds seconds %Second% %Minute% %Hour% %Day% %Month% %Year% 
    echo %Year%/%Month%/%Day% %Hour%:%Minute%:%Second% = %seconds% seconds
    %dk_call% dk_dateToSeconds seconds %Second% %Minute% %Hour% %Day% %Month%
    echo %Month%/%Day% %Hour%:%Minute%:%Second% = %seconds% seconds
    %dk_call% dk_dateToSeconds seconds %Second% %Minute% %Hour% %Day%
    echo %Day% %Hour%:%Minute%:%Second% = %seconds% seconds
    %dk_call% dk_dateToSeconds seconds %Second% %Minute% %Hour%
    echo %Hour%:%Minute%:%Second% = %seconds% seconds
    %dk_call% dk_dateToSeconds seconds %Second% %Minute%
    echo %Minute%:%Second% = %seconds% seconds
    %dk_call% dk_dateToSeconds seconds %Second%
    echo :%Second% = %seconds% seconds
%endfunction%
