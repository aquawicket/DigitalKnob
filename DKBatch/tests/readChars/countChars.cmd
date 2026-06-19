@echo off
setlocal EnableDelayedExpansion

set "ch=#" 
set "ascMap=000#101#202#A41#B42#C43"
set "split=!ascMap:*%ch%=!"
set /a "hexVal=0x!split:~0,2!"
echo !ch!
echo !split!
echo !hexVal!
pause
	
set "_file_=%USERPROFILE%\Digital Knob\Development\test\ASCII_UTF8_CRLF_TRIMMED"
set /P string= < "%_file_%"
echo The string:
echo !string!
echo/

set "digits=0123456789"
set "letters=ABCDEFGHIJKLMNOPQRSTUVWXYZ"

rem Separate string in chars
for /F "delims=" %%a in ('cmd /Q /U /C type "%_file_%" ^| find /V ""') do (

	set /A all+=1
	
	set "ascMap=000#101#202#A41#B42"
			set "split=!ascMap:*%%a=!"
			set /a "hexVal=0x!split:~0,2!"

	rem Two special cases first: exclamation mark and equal-sign
	if "%%a" equ "" (
		set /A special+=1
		echo SPE: %%a HEX: !hexVal!
	) else if "%%a" equ "=" (
		set /A special+=1
		echo SPE: %%a HEX: !hexVal!
	) else if "!letters:%%a=!" equ "%letters%" (
		if "!digits:%%a=!" equ "%digits%" (
			set /A "special+=1"
			echo SPE: %%a HEX: !hexVal!
		) else (
			set /A "digit+=1"
			echo DIG: %%a HEX: !hexVal!
		)
	) else (
		if "!letters:%%a=%%a!" equ "%letters%" (
			set /A "upper+=1"
			echo UPP: %%a HEX: !hexVal!
		) else (
			set /A "lower+=1"
			echo LOW: %%a HEX: !hexVal!
		)
	)
)

echo chars:   %all%
echo upper:   %upper%
echo lower:   %lower%
echo digit:   %digit%
echo special: %special%
pause