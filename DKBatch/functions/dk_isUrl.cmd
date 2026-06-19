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
rem # dk_isUrl(string)
rem #
rem #  https://stackoverflow.com/a/17584764
rem #
:dk_isUrl
%setlocal%

	set "dk_isUrl_1=%~1"
	%dk_call% dk_validate findstr.exe %dk_call% dk_findFile findstr.exe
	set "dk_isUrl=1"
	echo %dk_isUrl_1% | "%findstr.exe:/=\%" /i "http://"	>nul && (set "dk_isUrl=0")
	echo %dk_isUrl_1% | "%findstr.exe:/=\%" /i "https://"	>nul && (set "dk_isUrl=0")
	echo %dk_isUrl_1% | "%findstr.exe:/=\%" /i "ftp://"		>nul && (set "dk_isUrl=0")
	echo %dk_isUrl_1% | "%findstr.exe:/=\%" /i "ftps://"	>nul && (set "dk_isUrl=0")
	
	
	:return
	endlocal & (
		set "dk_isUrl_1=%dk_isUrl_1%"
		set "dk_isUrl=%dk_isUrl%"
		set "findstr.exe=%findstr.exe%"
	)
	exit /b %dk_isUrl%
%endfunction%







rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_isUrl http://www.test.com 		&& (echo !dk_isUrl_1! = true) || (call & echo !dk_isUrl_1! = false)
	%dk_call% dk_isUrl "http://www.test.com" 	&& (echo !dk_isUrl_1! = true) || (call & echo !dk_isUrl_1! = false)
	%dk_call% dk_isUrl HTTP://www.test.com 		&& (echo !dk_isUrl_1! = true) || (call & echo !dk_isUrl_1! = false)
	%dk_call% dk_isUrl "HTTP://WWW.TEST.COM" 	&& (echo !dk_isUrl_1! = true) || (call & echo !dk_isUrl_1! = false)
	%dk_call% dk_isUrl https://www.test.com		&& (echo !dk_isUrl_1! = true) || (call & echo !dk_isUrl_1! = false)
	%dk_call% dk_isUrl "https://www.test.com"	&& (echo !dk_isUrl_1! = true) || (call & echo !dk_isUrl_1! = false)
	%dk_call% dk_isUrl HTTPS://www.test.com		&& (echo !dk_isUrl_1! = true) || (call & echo !dk_isUrl_1! = false)
	%dk_call% dk_isUrl "HTTPS://WWW.TEST.COM"	&& (echo !dk_isUrl_1! = true) || (call & echo !dk_isUrl_1! = false)
	%dk_call% dk_isUrl ftp://www.test.com		&& (echo !dk_isUrl_1! = true) || (call & echo !dk_isUrl_1! = false)
	%dk_call% dk_isUrl "ftp://www.test.com"		&& (echo !dk_isUrl_1! = true) || (call & echo !dk_isUrl_1! = false)
	%dk_call% dk_isUrl FTP://WWW.TEST.COM		&& (echo !dk_isUrl_1! = true) || (call & echo !dk_isUrl_1! = false)
	%dk_call% dk_isUrl "FTP://WWW.TEST.COM"		&& (echo !dk_isUrl_1! = true) || (call & echo !dk_isUrl_1! = false)
	%dk_call% dk_isUrl ftp://www.test.com		&& (echo !dk_isUrl_1! = true) || (call & echo !dk_isUrl_1! = false)
	%dk_call% dk_isUrl "ftp://www.test.com"		&& (echo !dk_isUrl_1! = true) || (call & echo !dk_isUrl_1! = false)
	%dk_call% dk_isUrl FTPS://WWW.TEST.COM		&& (echo !dk_isUrl_1! = true) || (call & echo !dk_isUrl_1! = false)
	%dk_call% dk_isUrl "FTPS://WWW.TEST.COM"	&& (echo !dk_isUrl_1! = true) || (call & echo !dk_isUrl_1! = false)
	%dk_call% dk_isUrl http://www.test.com 		&& (echo !dk_isUrl_1! = true) || (call & echo !dk_isUrl_1! = false)	
	%dk_call% dk_isUrl www.test.com				&& (echo !dk_isUrl_1! = true) || (call & echo !dk_isUrl_1! = false)

	rem ### NOT VALID ###
rem	%dk_call% dk_isUrl www.test.com 			&& echo %dk_isUrl_1% = true 	|| echo %dk_isUrl_1% = false
rem	%dk_call% dk_isUrl https://www.test.com
rem	%dk_call% dk_echo "%dk_isUrl_1% = %dk_isUrl%"
%endfunction%
