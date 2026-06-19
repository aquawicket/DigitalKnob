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


rem ################################################################################
rem # dk_uptime(days hours minutes seconds)
rem #
rem # Args: %1 var to receive number of days of uptime (by ref)
rem #       %2 var to receive number of hours of uptime (by ref)
rem #       %3 var to receive number of minutes of uptime (by ref)
rem #       %4 var to receive number of seconds of uptime (optional, by ref)
rem #
rem #    REFERENCE: https://ritchielawrence.github.io/batchfunctionlibrary/
rem #
:dk_uptime
setlocal enableExtensions
	
    set "c=net statistics work"
    set "t=2"
    if "%date%z" lss "A" set "t=1"
    for /f "skip=1 tokens=2-4 delims=(-)" %%a in ('echo/^|date') do (
        for /f "tokens=%t%-4 delims=.-/ " %%d in ('date/t') do (
            set "%%a=%%d"
            set "%%b=%%e"
            set "%%c=%%f"
        )
    )
    for /f "tokens=5-8 delims=:. " %%a in ('echo/^|time') do (
        set "hh=%%a"
        set "nn=%%b"
        set "ss=%%c"
    )
    if 1%yy% lss 200 if 1%yy% lss 170 (
        set "yy=20%yy%"
    ) else (
        set "yy=19%yy%"
    )
    set /a "dd=100%dd%%%100"
    set /a "mm=100%mm%%%100"
    set /a "z=14-mm"
    set /a "z/=12"
    set /a "y=yy+4800-z"
    set /a "m=mm+12*z-3"
    set /a "j=153*m+2"
    set /a "j=j/5+dd+y*365+y/4-y/100+y/400-2472633"
    if 1%hh% lss 20 set "hh=0%hh%"
    set /a "hh=100%hh%%%100"
    set /a "nn=100%nn%%%100"
    set /a "f=j*1440+hh*60+nn"
	%dk_call% dk_validate findstr.exe %dk_call% dk_findFile findstr.exe
    for /f "tokens=3-8 delims=/:M " %%a in ('%c%^|%findstr.exe%/b /c:"Stat"') do (
        set "mm=%%a"
        set "dd=%%b"
        set "yy=%%c"
        set "hh=%%d"
        set "nn=%%e%%f"
    )
    if 1%yy% lss 200 if 1%yy% lss 170 (set "yy=20%yy%") else (set "yy=19%yy%")
    set /a "dd=100%dd%%%100"
    set /a "mm=100%mm%%%100"
    set /a "z=14-mm"
    set /a "z/=12"
    set /a "y=yy+4800-z"
    set /a "m=mm+12*z-3"
    set /a "j=153*m+2"
    set /a "j=j/5+dd+y*365+y/4-y/100+y/400-2472633"
    if 1%hh% lss 20 set "hh=0%hh%"
    if {%nn:~2,1%} EQU {P} if "%hh%" NEQ "12" set "hh=1%hh%" & set /a "hh-=88"
    if {%nn:~2,1%} EQU {A} if "%hh%" EQU "12" set "hh=00"
    if {%nn:~2,1%} GEQ {A} set "nn=%nn:~0,2%"
    set /a "hh=100%hh%%%100"
    set /a "nn=100%nn%%%100"
    set /a "s=j*1440+hh*60+nn"
    set /a "n=f-s"
    set /a "days=n/1440"
    set /a "n%%=1440"
    set /a "hours=n/60"
    set /a "n%%=60"
	
	:return
    endlocal & (
		set "dk_uptime_1=%days%"
		set "dk_uptime_2=%hours%"
		set "dk_uptime_3=%n%"
		set "dk_uptime_4=%ss%"
		set "findstr.exe=%findstr.exe%"
	)
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

    %dk_call% dk_uptime
    echo System uptime: days:%dk_uptime_1% hours:%dk_uptime_2% minutes:%dk_uptime_3% seconds:%dk_uptime_4%
	
	%dk_call% dk_uptime
    echo System uptime: days:%dk_uptime_1% hours:%dk_uptime_2% minutes:%dk_uptime_3% seconds:%dk_uptime_4%
%endfunction%    