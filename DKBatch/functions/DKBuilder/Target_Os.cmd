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


rem #####################################################################
rem # Target_Os()
rem #
rem #	  Target_Os = Android, Emscripten, Ios, Iossim, Linux, Mac, Raspberry, Windows
rem #
:Target_Os
%setlocal%

	rem ###### SET ######
	if "%~1" neq "" (
		set "Target_Os=%~1"
	
	rem ###### GET ######	
	) else (
		if "!Target_Os_Cache!" neq "" (
			echo.
			echo. 0^) !Target_Os_Cache!
		)
		echo.
		rem if NOT defined Host_Os (%dk_call% dk_Host_Os)
		%dk_call% dk_validate Host_OS %dk_call% dk_Host_Os
		echo. 1^) !Host_Os!
		echo. 2^) Android
		echo. 3^) Cosmopolitan
		echo. 4^) Emscripten
		echo. 5^) Ios
		echo. 6^) Iossim
		echo. 7^) Linux
		echo. 8^) Mac
		echo. 9^) Raspberry
		echo.10^) Windows
		echo.11^) Go Back
		echo.12^) Exit
		echo.

		%dk_call% dk_keyboardInput
			   if "!dk_keyboardInput!" equ "0"	(set "Target_Os=!Target_Os_Cache!"
		) else if "!dk_keyboardInput!" equ "1"	(set "Target_Os=!Host_Os!"
		) else if "!dk_keyboardInput!" equ "2" 	(set "Target_Os=Android"
		) else if "!dk_keyboardInput!" equ "3" 	(set "Target_Os=Cosmopolitan"
		) else if "!dk_keyboardInput!" equ "4" 	(set "Target_Os=Emscripten"
		) else if "!dk_keyboardInput!" equ "5" 	(set "Target_Os=Ios"
		) else if "!dk_keyboardInput!" equ "6" 	(set "Target_Os=Iossim"
		) else if "!dk_keyboardInput!" equ "7" 	(set "Target_Os=Linux"
		) else if "!dk_keyboardInput!" equ "8" 	(set "Target_Os=Mac"
		) else if "!dk_keyboardInput!" equ "9" 	(set "Target_Os=Raspberry"
		) else if "!dk_keyboardInput!" equ "10"	(set "Target_Os=Windows"
		) else if "!dk_keyboardInput!" equ "11"	(
			endlocal
			%dk_call% dk_unset Target_App
			%return%
		) else if "!dk_keyboardInput!" equ "12"	(%dk_call% dk_exit 0
		) else (
			%dk_call% dk_error "dk_keyboardInput:'!dk_keyboardInput!' invalid selection"
			endlocal
			goto:Target_Os
		)
	)
	
	endlocal & (
		set "Target_Os=%Target_Os%"
		set "%Target_Os%=1"
	)
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	rem ###### GET ######
    %dk_call% Target_Os
	%dk_call% dk_debug "Target_Os = %Target_Os%"
	%dk_call% dk_debug "%Target_Os% = !%Target_Os%!"
	
	rem ###### SET ######
	%dk_call% Target_Os "Windows"
	%dk_call% dk_debug "Target_Os = %Target_Os%"
	%dk_call% dk_debug "%Target_Os% = !%Target_Os%!"
	
%endfunction%