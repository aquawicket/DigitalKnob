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


rem ############################################################################
rem # __TIME__()
rem #
rem #
rem #
rem #
:__TIME__
%setlocal%

rem    nanoseconds="$(date +%s%N)"
rem    date_nanoseconds="$(( nanoseconds % 1000000000))"

rem    microseconds="$(( nanoseconds / 1000))"
rem    date_microseconds="$((microseconds % 1000))"
     
rem    milliseconds="$(( nanoseconds / 1000000))"
rem    date_milliseconds="$((milliseconds % 1000000))"

rem    seconds="$((nanoseconds / 1000000000))"
rem    date_seconds="$(date -d@"$((    seconds % 1000000000))" +"%S")"

rem    minutes="$((seconds/60))"
rem    date_minutes="$(date -d@"$seconds" +"%M")"
rem    t_minutes="$((seconds/60%60))"

rem    ::hours="$((seconds/60/60))"
rem    hours="$((seconds/3600))"
rem    date_hours="$(date -d@"$seconds" +"%H")"
rem    t_hours="$((seconds/60/60%24))"

rem    ::days="$((seconds/60/60/24))"
rem    days="$((seconds/86400))"
rem    date_days="$(date -d@"$seconds" +"%d")"
rem    t_days="$((seconds/60/60%24))"

rem    ::weeks="$((seconds/60/60/24/7))"
rem    weeks="$((seconds/604800))"
rem    ::date_weeks="$(date -d@"$seconds" +"%d")"
rem    t_weeks="$((seconds/60/60/24/7%30))"

rem    ::months="$((seconds/60/60/24/30))"
rem    months="$((seconds/2629746))"
rem    date_months="$(date -d@"$seconds" +"%m")"
rem    t_months="$((seconds/60/60/24%10))"

rem    ::years="$((seconds/60/60/24/365))"
rem    years="$((seconds/31556952))"
rem    date_years="$(date -d@"$seconds" +"%Y")"
rem    t_years="$((seconds/60/60/24/7%12))"

rem    decades="$((seconds/315569520))"
rem    ::date_decades="$((date_years / 10))"
rem    ::t_decades="$((seconds/60/60/24/365%10))"

rem    centuries="$((seconds/3155695200))"
rem    ::date_centuries="$((date_years / 100))"
rem    ::t_centuries="$((seconds/60/60/24/365%100))"

rem    timestamp="$(date -d@"$seconds" +"%Y-%m-%d-%H:%M:%S")"

rem  echo "      nanoseconds = ${nanoseconds}"
rem  echo " date_nanoseconds = ${date_nanoseconds}"

rem  echo "     microseconds = ${microseconds}"
rem  echo "date_microseconds = ${date_microseconds}"

rem  echo "     milliseconds = ${milliseconds}"
rem  echo "date_milliseconds = ${date_milliseconds}"

rem  echo "          seconds = ${seconds}"
rem  echo "     date_seconds = ${date_seconds}"

rem  echo "          minutes = ${minutes}"
rem  echo "     date_minutes = ${date_minutes}"
rem  echo "        t_minutes = ${t_minutes}"

rem  echo "            hours = ${hours}"
rem  echo "       date_hours = ${date_hours}"
rem  echo "          t_hours = ${t_hours}"

rem  echo "             days = ${days}"
rem  echo "        date_days = ${date_days}"
rem  echo "           t_days = ${t_days}"

rem  echo "            weeks = ${weeks}"
rem  ::echo "       date_weeks = ${date_weeks}"
rem  echo "          t_weeks = ${t_weeks}"

rem  echo "           months = ${months}"
rem  echo "      date_months = ${date_months}"
rem  echo "         t_months = ${t_months}"

rem  echo "            years = ${years}"
rem  echo "       date_years = ${date_years}"
rem  echo "          t_years = ${t_years}"

rem  echo "          decades = ${decades}"
rem  echo "     date_decades = ${date_decades}"
rem  echo "        t_decades = ${t_decades}"

rem  echo "        centuries = ${centuries}"
rem  echo "   date_centuries = ${date_centuries}"
rem  echo "      t_centuries = ${t_centuries}"

rem  echo "        timestamp = ${timestamp}"
rem  echo "%date_hours%:%date_minutes%:%date_seconds%.%date_milliseconds%"; return
%endfunction%

rem dk_getHour
rem %setlocal%
rem
rem    set hour=%time:~0,2%
rem    if "%hour:~0,1%" equ " " set hour=0%hour:~1,1%
rem    echo %hour%
rem %endfunction%

   
rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

    echo date time = %date% %time%
    echo date = %date%
    echo time = %time%

rem  set centuries=%time:~0,2%
rem  if "%centuries:~0,1%" equ " " set centuries=0%centuries:~1,1%
rem  echo centuries=%centuries%

rem  set decades=%time:~0,2%
rem  if "%decades:~0,1%" equ " " set decades=0%decades:~1,1%
rem  echo decades=%decades%

rem  set years=%time:~0,2%
rem  if "%years:~0,1%" equ " " set years=0%years:~1,1%
rem  echo years=%years%

rem  set months=%time:~0,2%
rem  if "%months:~0,1%" equ " " set months=0%months:~1,1%
rem  echo months=%months%

rem  set weeks=%time:~0,2%
rem  if "%weeks:~0,1%" equ " " set weeks=0%weeks:~1,1%
rem  echo weeks=%weeks%
   
rem  set days=%time:~0,2%
rem  if "%days:~0,1%" equ " " set days=0%days:~1,1%
rem  echo days=%days%
   
    set hours=%time:~0,2%
    if "%hours:~0,1%" equ " " set hours=0%hours:~1,1%
    echo hours=%hours%
   
    set minutes=%time:~3,2%
    if "%minutes:~0,1%" equ " " set minutes=0%minutes:~1,1%
    echo minutes=%minutes%
   
    set seconds=%time:~6,2%
    if "%seconds:~0,1%" equ " " set seconds=0%seconds:~1,1%
    echo seconds=%seconds%
   
    set milliseconds=%time:~9,2%
    if "%milliseconds:~0,1%" equ " " set milliseconds=0%milliseconds:~1,1%
    echo milliseconds=%milliseconds%
   
rem  set microseconds=%time:~9,2%
rem  if "%microseconds:~0,1%" equ " " set microseconds=0%microseconds:~1,1%
rem  echo microseconds=%microseconds%

rem  set nanoseconds=%time:~9,2%
rem  if "%nanoseconds:~0,1%" equ " " set nanoseconds=0%nanoseconds:~1,1%
rem  echo nanoseconds=%nanoseconds%
%endfunction%
