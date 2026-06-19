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
rem # dk_setLineNumbers(file)
rem #
rem #		find all occurences of line:n= in a file and replace them with line:n=LineNumber
rem #
rem #
:dk_setLineNumbers
%setlocal%
 
	set "_file_=%~1"
	set "_file_=%_file_:/=\%"
	set "_crlf_=%_file_%.crlf"
	set "_temp_=%_file_%.temp"

	set "anyChange="
	set "equal=="
	set lastLine=0
	%dk_call% dk_validate find.exe 	%dk_call% dk_findFile find.exe
	call type "%_file_:/=\%" | "%find.exe:/=\%" "" /v > "%_crlf_%"
< "%_crlf_%" (
	for /F "delims=:" %%a in ('findstr /N /I /C:"line:n%equal%" "%_crlf_%"') do (
		set /A lines=%%a-lastLine-1, lastLine=%%a
		for /L %%z in (1,1,!lines!) do (
			set "line="
			set /P "line="
			echo.!line!
		)
		set /P "line="
		for /F "tokens=1-26 delims== " %%b in ("!line:%%=!") do (
			if "%%b" equ "line:n" if "%%c" neq "%%a" (set "line=!line:%%c%%=%%a%%!" & set "anyChange=true")
			if "%%c" equ "line:n" if "%%d" neq "%%a" (set "line=!line:%%d%%=%%a%%!" & set "anyChange=true")
			if "%%d" equ "line:n" if "%%e" neq "%%a" (set "line=!line:%%e%%=%%a%%!" & set "anyChange=true")
			if "%%e" equ "line:n" if "%%f" neq "%%a" (set "line=!line:%%f%%=%%a%%!" & set "anyChange=true")
			if "%%f" equ "line:n" if "%%g" neq "%%a" (set "line=!line:%%g%%=%%a%%!" & set "anyChange=true")
			if "%%g" equ "line:n" if "%%h" neq "%%a" (set "line=!line:%%h%%=%%a%%!" & set "anyChange=true")
			if "%%h" equ "line:n" if "%%i" neq "%%a" (set "line=!line:%%i%%=%%a%%!" & set "anyChange=true")
			if "%%i" equ "line:n" if "%%j" neq "%%a" (set "line=!line:%%j%%=%%a%%!" & set "anyChange=true")
			if "%%j" equ "line:n" if "%%k" neq "%%a" (set "line=!line:%%k%%=%%a%%!" & set "anyChange=true")
			if "%%k" equ "line:n" if "%%l" neq "%%a" (set "line=!line:%%l%%=%%a%%!" & set "anyChange=true")
			if "%%l" equ "line:n" if "%%m" neq "%%a" (set "line=!line:%%m%%=%%a%%!" & set "anyChange=true")
			if "%%m" equ "line:n" if "%%n" neq "%%a" (set "line=!line:%%n%%=%%a%%!" & set "anyChange=true")
			if "%%n" equ "line:n" if "%%o" neq "%%a" (set "line=!line:%%o%%=%%a%%!" & set "anyChange=true")
			if "%%o" equ "line:n" if "%%p" neq "%%a" (set "line=!line:%%p%%=%%a%%!" & set "anyChange=true")
			if "%%p" equ "line:n" if "%%q" neq "%%a" (set "line=!line:%%q%%=%%a%%!" & set "anyChange=true")
			if "%%q" equ "line:n" if "%%r" neq "%%a" (set "line=!line:%%r%%=%%a%%!" & set "anyChange=true")
			if "%%r" equ "line:n" if "%%s" neq "%%a" (set "line=!line:%%s%%=%%a%%!" & set "anyChange=true")
			if "%%s" equ "line:n" if "%%t" neq "%%a" (set "line=!line:%%t%%=%%a%%!" & set "anyChange=true")
			if "%%t" equ "line:n" if "%%u" neq "%%a" (set "line=!line:%%u%%=%%a%%!" & set "anyChange=true")
			if "%%u" equ "line:n" if "%%v" neq "%%a" (set "line=!line:%%v%%=%%a%%!" & set "anyChange=true")
			if "%%v" equ "line:n" if "%%w" neq "%%a" (set "line=!line:%%w%%=%%a%%!" & set "anyChange=true")
			if "%%w" equ "line:n" if "%%x" neq "%%a" (set "line=!line:%%x%%=%%a%%!" & set "anyChange=true")
			if "%%x" equ "line:n" if "%%y" neq "%%a" (set "line=!line:%%y%%=%%a%%!" & set "anyChange=true")
			if "%%y" equ "line:n" if "%%z" neq "%%a" (set "line=!line:%%z%%=%%a%%!" & set "anyChange=true")
		)
		echo !line!
	)
	%dk_call% dk_validate findstr.exe %dk_call% dk_findFile findstr.exe
	!findstr.exe! "^"
) > %_temp_%

	if defined anyChange (
		move /Y "%_temp_%" "%_file_%" > nul
		del "%_crlf_%"
	) else (
		del "%_temp_%"
		del "%_crlf_%"
	)
	endlocal & (
		set line=n
	)
%endfunction%











rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_setLineNumbers "%~f0"

	echo %line:n=95%
	echo %line:n=96% %line:n=96%
	echo %line:n=97% %line:n=97% %line:n=97% 
	echo %line:n=98% %line:n=98% %line:n=98% %line:n=98% %line:n=98% %line:n=98% %line:n=98% %line:n=98%
	echo %line:n=99% %line:n=99% %line:n=99% 
	echo %line:n=100% %line:n=100%
	echo %line:n=101%
	echo !line:n=0!
%endfunction%

