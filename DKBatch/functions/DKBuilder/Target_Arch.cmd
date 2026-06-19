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
rem # Target_Arch()
rem #
rem #	  Target_Arch = Android, Emscripten, Ios, Iossim, Linux, Mac, Raspberry, Windows
rem #
:Target_Arch
%setlocal%

	rem ###### SET ######
	if "%~1" neq "" (
		set "Target_Arch=%~1"
	
	rem ###### GET ######	
	) else (
		if "!Target_Arch_Cache!" neq ""	(
			echo.
			echo. 0^) !Target_Arch_Cache!
		)
		echo.		
		if NOT defined Host_Arch (%dk_call% dk_Host_Arch)
		echo. 1^) !Host_Arch!
		echo. 2^) Arm32
		echo. 3^) Arm64
		echo. 4^) X86
		echo. 5^) X86_64
		echo. 6^) Go Back
		echo. 7^) Exit
		echo.

		%dk_call% dk_keyboardInput
		
			   if "!dk_keyboardInput!" equ "0" (set "Target_Arch=!Target_Arch_Cache!"
		) else if "!dk_keyboardInput!" equ "1" (set "Target_Arch=!Host_Arch!"
		) else if "!dk_keyboardInput!" equ "2" (set "Target_Arch=Arm32"
		) else if "!dk_keyboardInput!" equ "3" (set "Target_Arch=Arm64"
		) else if "!dk_keyboardInput!" equ "4" (set "Target_Arch=X86"
		) else if "!dk_keyboardInput!" equ "5" (set "Target_Arch=X86_64"
		) else if "!dk_keyboardInput!" equ "6" (
			endlocal
			%dk_call% dk_unset Target_Os
			%return%
		) else if "!dk_keyboardInput!" equ "7" (%dk_call% dk_exit 0
		) else (
			%dk_call% dk_error "dk_keyboardInput:'!dk_keyboardInput!' invalid selection"
			endlocal
			goto:Target_Arch
		)
	)
	
	endlocal & (
		set "Target_Arch=%Target_Arch%"
		set "%Target_Arch%=1"
	)
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	rem ###### GET ######
    %dk_call% Target_Arch
	%dk_call% dk_debug "Target_Arch = %Target_Arch%"
	%dk_call% dk_debug "%Target_Arch% = !%Target_Arch%!"
	
	rem ###### SET ######
	%dk_call% Target_Arch "I686"
	%dk_call% dk_debug "Target_Arch = %Target_Arch%"
	%dk_call% dk_debug "%Target_Arch% = !%Target_Arch%!"
	
%endfunction%