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


rem ################################################################################
rem # dk_set(name, value...)
rem #
rem #
:dk_set
  if NOT defined dk_set_PRINT_VARIABLE (set dk_set_PRINT_VARIABLE=0)
%setlocal%
	
	for /f "tokens=1*" %%a in ("%*") do (
		endlocal & (
      set %~1=%%b
     )
	)
	
	
	if "%dk_set_PRINT_VARIABLE%" equ "1" (
		echo %~1 = !%~1!
	)
	
%endfunction%












:setTestA
	set A_*=%*
exit /b 0

:setTestB
	set B_*=%*
exit /b 0

:compair arg1 arg2
	echo.
	call :setTestA !%~1!
	call :setTestB !%~2!
	
	echo A %%* = %A_*%
	echo B %%* = %B_*%
	if "%A_*%" equ "%B_*%" (
		echo.%green% '%%*' Test passed %clr%
	) else (
		echo.%red% '%%*' Test failed %clr%
	)
	echo.
	
	
	if "!%~1!" neq "!%~2!"	(
		echo.%red% !%~1! == !%~2! failed %clr%
		exit /b 0
	)
	if "!%1!" neq "!%2!" (
		echo.%red% !%1! == !%2! failed %clr%
		exit /b 0
	)
	if [!%1!] neq [!%2!] (
		echo.%red% !%1! == !%2! failed %clr%
		exit /b 0
	)
	
	echo.%green% !%~1! == !%~2! passed %clr%
exit /b 0


rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	             set TestA=12345
	%dk_call% dk_set TestB 12345
	call :compair TestA TestB
	
	            set "TestA=12345"
	%dk_call% dk_set TestB 12345
	call :compair TestA TestB
	
	             set TestA="12345"
	%dk_call% dk_set TestB "12345"
	call :compair TestA TestB
	
		         set TestA=1 2 3 4 5
	%dk_call% dk_set TestB 1 2 3 4 5
	call :compair TestA TestB

			    set "TestA=1 2 3 4 5"
	%dk_call% dk_set TestB 1 2 3 4 5
	call :compair TestA TestB
	
				 set TestA="1 2 3 4 5"
	%dk_call% dk_set TestB "1 2 3 4 5"
	call :compair TestA TestB
	
			     set TestA="1 2 3" a b c
	%dk_call% dk_set TestB "1 2 3" a b c
	call :compair TestA TestB
   
                 set TestA=word
	%dk_call% dk_set TestB word
    call :compair TestA TestB
	
				 set TestA="abc" "123" "d e f" "4 5 6"
	%dk_call% dk_set TestB "abc" "123" "d e f" "4 5 6"
	call :compair TestA TestB
	
rem  %dk_call% dk_set myVar "words in quotes"
rem	echo myVar = %myVar%
rem	%dk_call% dk_echo "myVar = %myVar%"
	
rem	%dk_call% dk_set myVar words without quotes
rem	echo myVar = %myVar%
rem	%dk_call% dk_echo "myVar = %myVar%"

rem	%dk_call% dk_set myVarB "dk_info('test dk_info message')"
rem	echo myVar = %myVar%
rem	%dk_call% dk_echo "myVarB = %myVarB%"
	
	%dk_call% dk_validate DKTOOLS_DIR	%dk_call% dk_DKTOOLS_DIR
	%dk_call% dk_set cmake "%DKTOOLS_DIR%/cmake-3.29.5-windows-x86_64"
	echo cmake = %cmake%
	
	%dk_call% dk_set TEST_VAR "abc" "123" "d e f" "4 5 6"
	echo TEST_VAR = %TEST_VAR%
%endfunction%
