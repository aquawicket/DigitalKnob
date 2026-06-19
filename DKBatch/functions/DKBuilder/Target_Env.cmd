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
rem # Target_Env()
rem #
rem #	  Target_Env = Clang32, Clang64, Cygwin, MinGw32, MinGW64, Msvc, Ucrt64, Wsl
rem #	  Target_Env = Clang, Gcc, Msvc
rem #
:Target_Env
%setlocal%

	rem ### Target_Env() settings ###########################
	if NOT defined Target_Env_DEFAULT (set "Target_Env_DEFAULT=Clang")

	rem ###### SET ######
	if "%~1" neq "" (
		set "Target_Env=%~1"

	rem ###### GET ######	
	) else (
		if "!Target_Env_Cache!" neq "" (
			echo.
			echo. 0^) !Target_Env_Cache!
		)
		echo.
		echo. 1^) %Target_Env_DEFAULT%
		echo. 2^) Gcc
		echo. 3^) Msvc
		echo. 4^) Gcc-Ucrt
		echo. 5^) Go Back
		echo. 6^) Exit
		echo.

		%dk_call% dk_keyboardInput
		       if "!dk_keyboardInput!" equ "0" (set "Target_Env=!Target_Env_Cache!"
		) else if "!dk_keyboardInput!" equ "1" (set "Target_Env=!Target_Env_DEFAULT!"
		) else if "!dk_keyboardInput!" equ "2" (set "Target_Env=Gcc"
		) else if "!dk_keyboardInput!" equ "3" (set "Target_Env=Msvc"
		) else if "!dk_keyboardInput!" equ "4" (set "Target_Env=Ucrt"
		) else if "!dk_keyboardInput!" equ "5" (
			endlocal
			%dk_call% dk_unset Target_Arch
			%return%
		) else if "!dk_keyboardInput!" equ "6"	(%dk_call% dk_exit 0
		) else (
			%dk_call% dk_error "dk_keyboardInput:'!dk_keyboardInput!' invalid selection"
			endlocal
			goto:Target_Env
		)
	)
	
	
	endlocal & (
		set "Target_Env=%Target_Env%"
		set "%Target_Env%=1"
	)
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	rem ###### GET ######
    %dk_call% Target_Env
	%dk_call% dk_debug "Target_Env = %Target_Env%"
	%dk_call% dk_debug "%Target_Env% = !%Target_Env%!"
	
	rem ###### SET ######
	%dk_call% Target_Env "Ucrt"
	%dk_call% dk_debug "Target_Env = %Target_Env%"
	%dk_call% dk_debug "%Target_Env% = !%Target_Env%!"
	
%endfunction%