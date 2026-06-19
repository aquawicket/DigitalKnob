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
rem # dk_BREAKPOINT()
rem #
:dk_BREAKPOINT
%setlocal%
 
	echo.
	echo. %cyan%########################### BREAKPOINT ################################
	echo.      __FUNC__: %__FUNC__%
	echo.      __FILE__: %__FILE__%
	echo.      __LINE__: %__LINE__%
rem	echo.    __CALLER__: %__CALLER__%  # TODO
	echo.      __ARGC__: '%__ARGC__%'
	echo.      __ARGV__: '%__ARGV__%'
	echo.
	:menu
	echo %clr%
	echo. 1) Continue   
	echo. 2) Print callstack
	echo. 3) Print variables
	echo. 4) Exit Program
	echo.
    echo. "Choose a selection"
    %dk_call% dk_keyboardInput
		
	if "%dk_keyboardInput%" equ "1" (
		%return%
	) else if "%dk_keyboardInput%" equ "2" (
		%dk_call% dk_stacktrace
	) else if "%dk_keyboardInput%" equ "3" (
		set
		echo %clr%
	) else if "%dk_keyboardInput%" equ "4" (
		exit %errorlevel%
	)
	goto:menu
		
rem	for /F "delims=" %%z in ('set %__FUNC__%') do (
rem		for /F "tokens=1,2 delims==" %%a in ("%%z") do (
rem			set var_name=%%a
rem			set var_value=%%b
rem			set var_value=!var_value:%ESC%=!
rem			echo %clr%!var_name! = '!var_value!%clr%'
rem		)
rem	)
	echo ##########################################################################%clr%
%endfunction%











rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_BREAKPOINT
%endfunction%

