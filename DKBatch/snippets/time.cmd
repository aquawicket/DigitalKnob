@echo off

for /L %%L in (-2147483648,1,2147483648) do @(
	for /f "tokens=1-4 delims=:." %%A in ("!time!") do (
		rem set "hour=%%A" & set "minute=%%B" & set "second=%%C" & set "centisecond=%%D"
		
		rem   %%D = centiseconds
		rem   %%C = seconds
		rem   %%B = minutes
		rem   %%A = hours
		
		
		rem   Print centiseconds   00 - 59
		rem echo %%D
		set "centiseconds=%%D"


		rem   Print seconds in centisecond resolution   0000 - 5999
		set "seconds_in_seconds=%%C"
		set "seconds_in_centiseconds=!seconds_in_seconds!%%D"
		
		
		rem   Print minutes in centisecond resolution   0000 - ??????? 
		set "second=%%C"
		set /a "second=100!second!%%100"
		set "minute=%%B"
		set /a "minute=100!minute!%%100"
		set /a "minutes_in_seconds=!minute!*60+!second!"
		set /a "minutes_in_centiseconds=!minutes_in_seconds!%%D"

		rem   Print hours in centisecond resolution    0000 - ???????
		set "hour=%%A"
		set /a "hour=100!hour!%%100"
		set /a "hours_in_seconds=!hour!*60*60+!minutes_in_seconds!"
		set /a "hours_in_centiseconds=!hours_in_seconds!%%D"
		
		
		
		
		echo !hours_in_centiseconds!     !minutes_in_centiseconds!     !seconds_in_centiseconds!     !centiseconds!
	)
)	
