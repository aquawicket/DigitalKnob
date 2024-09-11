@echo off
if "%~1" == "dk_getHour" echo dk_getHour
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0



::##################################################################################
::# __TIME__()
::#
::#
::#
::#
:__TIME__
    ::call dk_debugFunc
 setlocal
 
::    nanoseconds="$(date +%s%N)"
::    date_nanoseconds="$(( nanoseconds % 1000000000))"

::    microseconds="$(( nanoseconds / 1000))"
::    date_microseconds="$((microseconds % 1000))"
      
::    milliseconds="$(( nanoseconds / 1000000))"
::    date_milliseconds="$((milliseconds % 1000000))"

::    seconds="$((nanoseconds / 1000000000))"
::    date_seconds="$(date -d@"$((    seconds % 1000000000))" +"%S")"

::    minutes="$((seconds/60))"
::    date_minutes="$(date -d@"$seconds" +"%M")"
::    t_minutes="$((seconds/60%60))"

::    ::hours="$((seconds/60/60))"
::    hours="$((seconds/3600))"
::    date_hours="$(date -d@"$seconds" +"%H")"
::    t_hours="$((seconds/60/60%24))"

::    ::days="$((seconds/60/60/24))"
::    days="$((seconds/86400))"
::    date_days="$(date -d@"$seconds" +"%d")"
::    t_days="$((seconds/60/60%24))"

::    ::weeks="$((seconds/60/60/24/7))"
::    weeks="$((seconds/604800))"
::    ::date_weeks="$(date -d@"$seconds" +"%d")"
::    t_weeks="$((seconds/60/60/24/7%30))"

::    ::months="$((seconds/60/60/24/30))"
::    months="$((seconds/2629746))"
::    date_months="$(date -d@"$seconds" +"%m")"
::    t_months="$((seconds/60/60/24%10))"

::    ::years="$((seconds/60/60/24/365))"
::    years="$((seconds/31556952))"
::    date_years="$(date -d@"$seconds" +"%Y")"
::    t_years="$((seconds/60/60/24/7%12))" 

::    decades="$((seconds/315569520))"
::    ::date_decades="$((date_years / 10))"
::    ::t_decades="$((seconds/60/60/24/365%10))"

::    centuries="$((seconds/3155695200))"
::    ::date_centuries="$((date_years / 100))"
::    ::t_centuries="$((seconds/60/60/24/365%100))"

::    timestamp="$(date -d@"$seconds" +"%Y-%m-%d-%H:%M:%S")"

::  echo "      nanoseconds = ${nanoseconds}"
::  echo " date_nanoseconds = ${date_nanoseconds}"

::  echo "     microseconds = ${microseconds}"
::  echo "date_microseconds = ${date_microseconds}"

::  echo "     milliseconds = ${milliseconds}"
::  echo "date_milliseconds = ${date_milliseconds}"

::  echo "          seconds = ${seconds}"
::  echo "     date_seconds = ${date_seconds}"

::  echo "          minutes = ${minutes}"
::  echo "     date_minutes = ${date_minutes}"
::  echo "        t_minutes = ${t_minutes}"

::  echo "            hours = ${hours}"
::  echo "       date_hours = ${date_hours}"
::  echo "          t_hours = ${t_hours}"

::  echo "             days = ${days}"
::  echo "        date_days = ${date_days}"
::  echo "           t_days = ${t_days}"

::  echo "            weeks = ${weeks}"
::  ::echo "       date_weeks = ${date_weeks}"
::  echo "          t_weeks = ${t_weeks}"

::  echo "           months = ${months}"
::  echo "      date_months = ${date_months}"
::  echo "         t_months = ${t_months}"

::  echo "            years = ${years}"
::  echo "       date_years = ${date_years}"
::  echo "          t_years = ${t_years}"

::  echo "          decades = ${decades}"
::  echo "     date_decades = ${date_decades}"
::  echo "        t_decades = ${t_decades}"

::  echo "        centuries = ${centuries}"
::  echo "   date_centuries = ${date_centuries}"
::  echo "      t_centuries = ${t_centuries}"

::  echo "        timestamp = ${timestamp}"
    echo "%date_hours%:%date_minutes%:%date_seconds%.%date_milliseconds%"; return
 endlocal
%endfunction%

:dk_getHour
 setlocal
    set hour=%time:~0,2%
    if "%hour:~0,1%" == " " set hour=0%hour:~1,1%
    echo %hour%
 endlocal
%endfunction%

    
::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
    call dk_debugFunc 0
    
    echo date time = %date% %time%
    echo date = %date%
    echo time = %time%

::  set centuries=%time:~0,2%
::  if "%centuries:~0,1%" == " " set centuries=0%centuries:~1,1%
::  echo centuries=%centuries%

::  set decades=%time:~0,2%
::  if "%decades:~0,1%" == " " set decades=0%decades:~1,1%
::  echo decades=%decades%

::  set years=%time:~0,2%
::  if "%years:~0,1%" == " " set years=0%years:~1,1%
::  echo years=%years%

::  set months=%time:~0,2%
::  if "%months:~0,1%" == " " set months=0%months:~1,1%
::  echo months=%months%

::  set weeks=%time:~0,2%
::  if "%weeks:~0,1%" == " " set weeks=0%weeks:~1,1%
::  echo weeks=%weeks%
    
::  set days=%time:~0,2%
::  if "%days:~0,1%" == " " set days=0%days:~1,1%
::  echo days=%days%
    
    set hours=%time:~0,2%
    if "%hours:~0,1%" == " " set hours=0%hours:~1,1%
    echo hours=%hours%
    
    set minutes=%time:~3,2%
    if "%minutes:~0,1%" == " " set minutes=0%minutes:~1,1%
    echo minutes=%minutes%
    
    set seconds=%time:~6,2%
    if "%seconds:~0,1%" == " " set seconds=0%seconds:~1,1%
    echo seconds=%seconds%
    
    set milliseconds=%time:~9,2%
    if "%milliseconds:~0,1%" == " " set milliseconds=0%milliseconds:~1,1%
    echo milliseconds=%milliseconds%
    
::  set microseconds=%time:~9,2%
::  if "%microseconds:~0,1%" == " " set microseconds=0%microseconds:~1,1%
::  echo microseconds=%microseconds%

::  set nanoseconds=%time:~9,2%
::  if "%nanoseconds:~0,1%" == " " set nanoseconds=0%nanoseconds:~1,1%
::  echo nanoseconds=%nanoseconds%
 endlocal
%endfunction%
