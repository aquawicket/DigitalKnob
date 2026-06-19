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


rem ####################################################################
rem # dk_asciiToHex(ascii, <rtn_var>:optional)
rem #
rem #	reference: https://www.ascii-code.com
rem #
:dk_asciiToHex
%setlocal%

	rem Store the string in chr.tmp file
	set /P "=%~1" < NUL > chr.tmp

	rem Create zero.tmp file with the same number of Ascii zero characters
	for %%a in (chr.tmp) do (
		%dk_call% fsutil.exe file createnew zero.tmp %%~Za > NUL
	)

	rem Compare both files with FC /B and get the differences
	set "dk_asciiToHex="
	for /F "skip=1 tokens=2" %%a in ('fc /B chr.tmp zero.tmp') do set "dk_asciiToHex=%%a"
	del chr.tmp zero.tmp
	set "dk_asciiToHex=0x%dk_asciiToHex:~-2%"

	
	:return
	endlocal & (
		set "dk_asciiToHex_1=%~1"
		set "dk_asciiToHex=%dk_asciiToHex%"
		if "%~2" neq "" (
			set "%~2=%dk_asciiToHex%"
		) else (
			rem echo %dk_asciiToHex%
		)
	)
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_asciiToHex a 	& %dk_call% dk_echo "'!dk_asciiToHex_1!' = !dk_asciiToHex!"
	%dk_call% dk_asciiToHex b 	& %dk_call% dk_echo "'!dk_asciiToHex_1!' = !dk_asciiToHex!"
	%dk_call% dk_asciiToHex c 	& %dk_call% dk_echo "'!dk_asciiToHex_1!' = !dk_asciiToHex!"
	%dk_call% dk_asciiToHex d 	& %dk_call% dk_echo "'!dk_asciiToHex_1!' = !dk_asciiToHex!"
	%dk_call% dk_asciiToHex e 	& %dk_call% dk_echo "'!dk_asciiToHex_1!' = !dk_asciiToHex!"
	%dk_call% dk_asciiToHex f 	& %dk_call% dk_echo "'!dk_asciiToHex_1!' = !dk_asciiToHex!"
	%dk_call% dk_asciiToHex g 	& %dk_call% dk_echo "'!dk_asciiToHex_1!' = !dk_asciiToHex!"
	%dk_call% dk_asciiToHex h 	& %dk_call% dk_echo "'!dk_asciiToHex_1!' = !dk_asciiToHex!"
	%dk_call% dk_asciiToHex h 	& %dk_call% dk_echo "'!dk_asciiToHex_1!' = !dk_asciiToHex!"
	%dk_call% dk_asciiToHex j 	& %dk_call% dk_echo "'!dk_asciiToHex_1!' = !dk_asciiToHex!"
	%dk_call% dk_asciiToHex k 	& %dk_call% dk_echo "'!dk_asciiToHex_1!' = !dk_asciiToHex!"
	%dk_call% dk_asciiToHex l 	& %dk_call% dk_echo "'!dk_asciiToHex_1!' = !dk_asciiToHex!"
	%dk_call% dk_asciiToHex m 	& %dk_call% dk_echo "'!dk_asciiToHex_1!' = !dk_asciiToHex!"
	%dk_call% dk_asciiToHex n 	& %dk_call% dk_echo "'!dk_asciiToHex_1!' = !dk_asciiToHex!"
	%dk_call% dk_asciiToHex o 	& %dk_call% dk_echo "'!dk_asciiToHex_1!' = !dk_asciiToHex!"
	%dk_call% dk_asciiToHex p 	& %dk_call% dk_echo "'!dk_asciiToHex_1!' = !dk_asciiToHex!"
	%dk_call% dk_asciiToHex q 	& %dk_call% dk_echo "'!dk_asciiToHex_1!' = !dk_asciiToHex!"
	%dk_call% dk_asciiToHex r 	& %dk_call% dk_echo "'!dk_asciiToHex_1!' = !dk_asciiToHex!"
	%dk_call% dk_asciiToHex s 	& %dk_call% dk_echo "'!dk_asciiToHex_1!' = !dk_asciiToHex!"
	%dk_call% dk_asciiToHex t 	& %dk_call% dk_echo "'!dk_asciiToHex_1!' = !dk_asciiToHex!"
	%dk_call% dk_asciiToHex u 	& %dk_call% dk_echo "'!dk_asciiToHex_1!' = !dk_asciiToHex!"
	%dk_call% dk_asciiToHex v 	& %dk_call% dk_echo "'!dk_asciiToHex_1!' = !dk_asciiToHex!"
	%dk_call% dk_asciiToHex w 	& %dk_call% dk_echo "'!dk_asciiToHex_1!' = !dk_asciiToHex!"
	%dk_call% dk_asciiToHex x 	& %dk_call% dk_echo "'!dk_asciiToHex_1!' = !dk_asciiToHex!"
	%dk_call% dk_asciiToHex y 	& %dk_call% dk_echo "'!dk_asciiToHex_1!' = !dk_asciiToHex!"
	%dk_call% dk_asciiToHex z 	& %dk_call% dk_echo "'!dk_asciiToHex_1!' = !dk_asciiToHex!"
%endfunction%
