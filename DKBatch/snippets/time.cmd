@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


for /L %%L in (0,1,2147483648) do @(
	for /f "tokens=1-4 delims=:." %%A in ("!time!") do (
		
		rem   %%D = centiseconds
		rem   %%C = seconds
		rem   %%B = minutes
		rem   %%A = hours
		
		set "count=%%L"
		
		rem ### milliseconds   0 thru 1000(999)
		rem set "millisecond=0"
		
		rem ### centiseconds   0 thru 100(99)
		set "centisecond=%%D"
		set "centiseconds_in_milliseconds=%%D0"

		rem ### seconds in centisecond resolution   0 thru 6000(5999)
		rem set /a "second=100%%C%%100"
		rem set /a "second_in_seconds=!second!"
		    set /a "second_in_seconds=100%%C%%100"
			set "second_in_centiseconds=!second_in_seconds!%%D"
			set "second_in_milliseconds=!second_in_seconds!%%D0"
		
		rem ### minutes in centisecond resolution   0 thru 360000(359999)
		rem set /a "minute=100%%B%%100"
		rem set /a "minute_in_seconds=!minute!*60+!second_in_seconds!"
		rem set /a "minute_in_seconds=100%%B%%100*60+!second_in_seconds!"
			set /a "minute_in_seconds=100%%B%%100*60+!second_in_seconds!"
			set "minute_in_centiseconds=!minute_in_seconds!%%D"
			set "minute_in_milliseconds=!minute_in_seconds!%%D0"
		
		rem ### hours in centisecond resolution    0 thru 8640000(8639999)
		rem set /a "hour=100%%A%%100"
		rem set /a "hour_in_seconds=!hour!*60*60+!minute_in_seconds!"
		rem set /a "hour_in_seconds=100%%A%%100*60*60+!minute_in_seconds!"
		    rem set /a "hour_in_seconds=100%%A%%100*60*60+100%%B%%100*60+100%%C%%100"
			rem set /a "hour_in_seconds=100%%A%%100*3600+100%%B%%100*60+100%%C%%100"
			set /a "hour_in_seconds=100%%A%%100*3600+!minute_in_seconds!"
			set "hour_in_centiseconds=!hour_in_seconds!%%D"
			set "hour_in_milliseconds=!hour_in_seconds!%%D0"
		
		
		rem  ###### Print all in centiseconds (centiseconds appended) ######
	    rem echo count:!count!   TA:!time!   h:!hour_in_seconds!      m:!minute_in_seconds!      s:!second_in_seconds!
		call dk_sleep 1000
		echo count:!count!   TA:!time!   TB:%%A:%%B:%%C.%%D   h:!hour_in_centiseconds!    m:!minute_in_centiseconds!    s:!second_in_centiseconds!    cs:!centisecond!
		rem echo count:!count!   TA:!time!   h:!hour_in_milliseconds!   m:!minute_in_milliseconds!   s:!second_in_milliseconds!   cs:!centiseconds_in_milliseconds!
	)
)	
