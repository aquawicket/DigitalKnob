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




:dk_timer name
	set "T=%~1"
	if not defined %T%.startTime (
		set "%T%.startTime=%time: =0%"
		echo %T%.startTime: !%T%.startTime!
		exit /b 0
	)
	echo %T%.startTime: !%T%.startTime!
	set "%T%.endTime=%time: =0%"
	echo %T%.endTime:   !%T%.endTime!
	
	rem Get elapsed time:
	set "end=!%T%.endTime:%time:~8,1%=%%100)*100+1!"  &  set "start=!%T%.startTime:%time:~8,1%=%%100)*100+1!"
	set /A "%T%.elap=((((10!end:%time:~2,1%=%%100)*60+1!%%100)-((((10!start:%time:~2,1%=%%100)*60+1!%%100), %T%.elap-=(%T%.elap>>31)*24*60*60*100"
	rem echo %T%.elapsed:   !%T%.elap!
	
	rem Convert elapsed time to HH:MM:SS:CC format:
	set /A "cc=%T%.elap%%100+100,%T%.elap/=100,ss=%T%.elap%%60+100,%T%.elap/=60,mm=%T%.elap%%60+100,hh=%T%.elap/60+100"
	echo %T%.Elapsed:   %hh:~1%%time:~2,1%%mm:~1%%time:~2,1%%ss:~1%%time:~8,1%%cc:~1%
	echo.
%endfunction%




:DKTEST
%setlocal%

	%dk_call% dk_timer T1
	ping 127.0.0.1 -n 3 >null
	
	call :dk_timer T1
	call :dk_timer T2
	ping 127.0.0.1 -n 3 >null
	
	call :dk_timer T1
	call :dk_timer T2
	ping 127.0.0.1 -n 3 >null
	
	call :dk_timer T1
	pause
%endfunction%