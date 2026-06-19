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
rem # Target_Type(rtn_var:Target_Type)
rem #
rem #
:Target_Type
%setlocal%

	rem ###### SET ######
	if "%~1" neq "" (
		set "Target_Type=%~1"
		
	rem ###### GET ######	
	) else (
		if "!Target_Type_Cache!" neq "" (
			echo.
			echo. 0^) !Target_Type_Cache!
		)
		echo.
		echo. 1^) Release
		echo. 2^) Debug
		echo. 3^) All
		echo. 4^) Go Back
		echo. 5^) Exit
   
		%dk_call% dk_echo
		%dk_call% dk_echo "Please select a build type."
   
		%dk_call% dk_keyboardInput
		rem %dk_call% dk_keyboardInputTimeout 1 60
			   if "!dk_keyboardInput!" equ "0" (set "Target_Type=!Target_Type_Cache!"
		) else if "!dk_keyboardInput!" equ "1" (set "Target_Type=Release"
		) else if "!dk_keyboardInput!" equ "2" (set "Target_Type=Debug"
		) else if "!dk_keyboardInput!" equ "3" (set "Target_Type=All"
		) else if "!dk_keyboardInput!" equ "4" (
			endlocal
			%dk_call% dk_unset Target_Env
			%return%
		) else if "!dk_keyboardInput!" equ "5" (%dk_call% dk_exit 0
		) else ( 
			%dk_call% dk_error "dk_keyboardInput:'!dk_keyboardInput!' invalid selection"
			endlocal
			goto:Target_Type
		)
	)

	endlocal & (
		set "Target_Type=%Target_Type%"
		set "%Target_Type%=1"
	)
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

    rem ###### GET ######
    %dk_call% Target_Type
	%dk_call% dk_debug "Target_Type = %Target_Type%"
	%dk_call% dk_debug "%Target_Type% = !%Target_Type%!"
	
	rem ###### SET ######
	%dk_call% Target_Type "Release"
	%dk_call% dk_debug "Target_Type = %Target_Type%"
	%dk_call% dk_debug "%Target_Type% = !%Target_Type%!"
%endfunction%
