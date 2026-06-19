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



rem #######################################
rem #	dk_timer(name) 
rem #
rem #
:dk_timer
	set "T=%~1"
	if not defined %T%.startTime (
		set "%T%.startTime=%time: =0%"
rem		echo %T%.startTime: !%T%.startTime!
		exit /b 0
	)
rem	echo %T%.startTime: !%T%.startTime!
	set "%T%.endTime=%time: =0%"
rem	echo %T%.endTime:   !%T%.endTime!
	
	rem Get elapsed time:
	set "end=!%T%.endTime:%time:~8,1%=%%100)*100+1!"  &  set "start=!%T%.startTime:%time:~8,1%=%%100)*100+1!"
	set /A "%T%.elap=((((10!end:%time:~2,1%=%%100)*60+1!%%100)-((((10!start:%time:~2,1%=%%100)*60+1!%%100), %T%.elap-=(%T%.elap>>31)*24*60*60*100"
	rem echo %T%.elapsed:   !%T%.elap!
	
	rem Convert elapsed time to HH:MM:SS:CC format:
	set /A "cc=%T%.elap%%100+100,%T%.elap/=100,ss=%T%.elap%%60+100,%T%.elap/=60,mm=%T%.elap%%60+100,hh=%T%.elap/60+100"
	set %T%.Elapsed=%hh:~1%%time:~2,1%%mm:~1%%time:~2,1%%ss:~1%%time:~8,1%%cc:~1%
rem	echo %T%.Elapsed = !%T%.Elapsed!
rem	echo.
	set "%T%.startTime=%time: =0%"
	
	set dk_timer=!%T%.Elapsed!
rem	endlocal & (
rem		set "dk_timer=%dk_timer%"
rem	)
%endfunction%




:DKTEST
%setlocal%

	%dk_call% dk_timer Bob
	%dk_call% dk_sleep_ms 3000
	%dk_call% dk_timer Bob
	echo dk_timer = %dk_timer%
	%dk_call% dk_sleep_ms 3000
	%dk_call% dk_timer Bob
	echo dk_timer = %dk_timer%
	%dk_call% dk_sleep_ms 3000
	%dk_call% dk_timer Bob
	echo dk_timer = %dk_timer%

	%dk_call% dk_timer Paul
	%dk_call% dk_sleep_ms 2000
	%dk_call% dk_timer Paul
	echo dk_timer = %dk_timer%
	%dk_call% dk_sleep_ms 2000
	%dk_call% dk_timer Paul
	echo dk_timer = %dk_timer%
	%dk_call% dk_sleep_ms 2000
	%dk_call% dk_timer Paul
	echo dk_timer = %dk_timer%
	
	%dk_call% dk_timer Rainey
	%dk_call% dk_sleep_ms 1000
	%dk_call% dk_timer Rainey
	echo dk_timer = %dk_timer%
	%dk_call% dk_sleep_ms 1000
	%dk_call% dk_timer Rainey
	echo dk_timer = %dk_timer%
	%dk_call% dk_sleep_ms 1000
	%dk_call% dk_timer Rainey
	echo dk_timer = %dk_timer%
	
	%dk_call% dk_timer Fred
	%dk_call% dk_sleep_ms 500
	%dk_call% dk_timer Fred
	echo dk_timer = %dk_timer%
	%dk_call% dk_sleep_ms 500
	%dk_call% dk_timer Fred
	echo dk_timer = %dk_timer%
	%dk_call% dk_sleep_ms 500
	%dk_call% dk_timer Fred
	echo dk_timer = %dk_timer%
	
	%dk_call% dk_timer Sally
	%dk_call% dk_sleep_ms 250
	%dk_call% dk_timer Sally
	echo dk_timer = %dk_timer%
	%dk_call% dk_sleep_ms 250
	%dk_call% dk_timer Sally
	echo dk_timer = %dk_timer%
	%dk_call% dk_sleep_ms 250
	%dk_call% dk_timer Sally
	echo dk_timer = %dk_timer%
	
	%dk_call% dk_timer Bill
	%dk_call% dk_sleep_ms 100
	%dk_call% dk_timer Bill
	echo dk_timer = %dk_timer%
	%dk_call% dk_sleep_ms 100
	%dk_call% dk_timer Bill
	echo dk_timer = %dk_timer%
	%dk_call% dk_sleep_ms 100
	%dk_call% dk_timer Bill
	echo dk_timer = %dk_timer%
	
	%dk_call% dk_timer Oscar
	%dk_call% dk_sleep_ms 50
	%dk_call% dk_timer Oscar
	echo dk_timer = %dk_timer%
	%dk_call% dk_sleep_ms 50
	%dk_call% dk_timer Oscar
	echo dk_timer = %dk_timer%
	%dk_call% dk_sleep_ms 50
	%dk_call% dk_timer Oscar
	echo dk_timer = %dk_timer%
	
	%dk_call% dk_timer Betty
	%dk_call% dk_sleep_ms 25
	%dk_call% dk_timer Betty
	echo dk_timer = %dk_timer%
	%dk_call% dk_sleep_ms 25
	%dk_call% dk_timer Betty
	echo dk_timer = %dk_timer%
	%dk_call% dk_sleep_ms 25
	%dk_call% dk_timer Betty
	echo dk_timer = %dk_timer%
	
	%dk_call% dk_timer Flash
rem	%dk_call% dk_sleep_ms 1
	%dk_call% dk_timer Flash
	echo dk_timer = %dk_timer%
rem	%dk_call% dk_sleep_ms 1
	%dk_call% dk_timer Flash
	echo dk_timer = %dk_timer%
rem	%dk_call% dk_sleep_ms 1
	%dk_call% dk_timer Flash
	echo dk_timer = %dk_timer%
%endfunction%