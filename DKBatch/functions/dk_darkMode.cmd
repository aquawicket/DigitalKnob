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
rem # dk_darkMode(state rtn_var:optional)
rem #
rem #
:dk_darkMode
%setlocal%
 
	set KEY_NAME="HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize"
	
	rem ############ SET ############
	if "%~1" neq "" (
		set dk_darkMode=%~1
		reg add %KEY_NAME% /v AppsUseLightTheme /t REG_DWORD /d !dk_darkMode! /f
	
	rem ############ GET ############
	) else (
		set "DKDarkMode=%USERPROFILE:\=/%"
		for /f "usebackq tokens=3*" %%A in (`reg query %KEY_NAME% /v AppsUseLightTheme`) do (
			set dk_darkMode=%%A %%B
		)
	)
	rem set "dk_darkMode=%dk_darkMode:0x=%"
		
	:return
	endlocal & (
		set "dk_darkMode=%dk_darkMode%"
		if "%~2" neq "" (
			set "%~2=%dk_darkMode%"
		) else (
			echo %dk_darkMode%
		)
	)

%endfunction%











rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	echo.
	echo getting dark mode state . . .
	%dk_call% dk_darkMode
	%dk_call% dk_debug "dk_darkMode = %dk_darkMode%"
	pause
	
	echo.
	echo setting dark mode OFF
	%dk_call% dk_darkMode 1	
	echo getting dark mode state . . .
	%dk_call% dk_darkMode
	%dk_call% dk_debug "dk_darkMode = %dk_darkMode%"
	pause
	
	echo.
	echo setting dark mode ON
	%dk_call% dk_darkMode 0
	%dk_call% dk_debug "dk_darkMode = %dk_darkMode%"
	echo getting dark mode state . . .
	%dk_call% dk_darkMode
	%dk_call% dk_debug "dk_darkMode = %dk_darkMode%"

%endfunction%

