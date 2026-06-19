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
rem # dk_setGlobal(name, value...)
rem #
rem #
:dk_setGlobal
  if NOT defined dk_setGlobal_PRINT_VARIABLE (set dk_setGlobal_PRINT_VARIABLE=0)
%setlocal%
	
	%dk_call% dk_validate DKCACHE_DIR %dk_call% dk_DKCACHE_DIR
  for /f "tokens=1*" %%a in ("%*") do (
    endlocal & (set %~1=%%b)
  )
	
	%dk_call% dk_fileVariable "%DKCACHE_DIR%/GLOBALVARS.txt" %~1 !%~1!
	
	if "%dk_setGlobal_PRINT_VARIABLE%" equ "1" (
		echo %~1 = !%~1!
	)
	
%endfunction%












rem :setTestA
rem 	set A_*=%*
rem exit /b 0

rem :setTestB
rem 	set B_*=%*
rem exit /b 0

:compair arg1 arg2
  rem	call :setTestA !%1!
  rem	call :setTestB !%2!
  rem	echo A %%* = %A_*%
  rem	echo B %%* = %B_*%
  rem  if [%A_*%] equ [%B_*%] (
  rem    echo.%green% 'A %%* = B %%*' Test passed %clr%
  rem  ) else (
  rem		echo.%red% 'A %%* = B %%*' Test failed %clr%
  rem	)
	echo.
	echo. A = !%~1!
	echo. B = !%~2!
	if "!%~1!" neq "!%~2!"	(
		echo.%red% !%~1! == !%~2! Test failed %clr%
		exit /b 0
	)
	if "!%1!" neq "!%2!" (
		echo.%red% !%1! == !%2! Test failed %clr%
		exit /b 0
	)
	if [!%1!] neq [!%2!] (
		echo.%red% !%1! == !%2! Test failed %clr%
		exit /b 0
	)
	
	echo.%green% !%1! == !%2! Test passed %clr%
exit /b 0


rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

  	                 set "TestA=12345"
	%dk_call% dk_setGlobal TestB 12345
	call :compair TestA TestB
	
	                  set TestA=12345 "12345"
	%dk_call% dk_setGlobal TestB 12345 "12345"
	call :compair TestA TestB
	
    	             set "TestA=abc def"
	%dk_call% dk_setGlobal TestB abc def
	call :compair TestA TestB
	
	    	            set TestA=abc def "abc def"
	%dk_call% dk_setGlobal TestB abc def "abc def"
	call :compair TestA TestB
	
		               set "TestA=1 2 3 4 5"
	%dk_call% dk_setGlobal TestB 1 2 3 4 5
	call :compair TestA TestB
	
			              set TestA=1 2 3 4 5 "1 2 3 4 5"
	%dk_call% dk_setGlobal TestB 1 2 3 4 5 "1 2 3 4 5"
	call :compair TestA TestB
	
			              set TestA=abc "def" g h i
	%dk_call% dk_setGlobal TestB abc "def" g h i
	call :compair TestA TestB

				            set TestA=1 "abc" 2 3 "d e f" 4 5 6 "g h i"
	%dk_call% dk_setGlobal TestB 1 "abc" 2 3 "d e f" 4 5 6 "g h i"
	call :compair TestA TestB
	
					          set TestA=A sentence without quotes "and a sentence with quotes"
	%dk_call% dk_setGlobal TestB A sentence without quotes "and a sentence with quotes"
	call :compair TestA TestB
	
						          set TestA=` "`"
	%dk_call% dk_setGlobal TestB ` "`"
	call :compair TestA TestB

		echo.
rem  %dk_call% dk_setGlobal myVar "words in quotes"
rem	echo myVar = %myVar%
rem	%dk_call% dk_echo "myVar = %myVar%"
	
rem	%dk_call% dk_setGlobal myVar words without quotes
rem	echo myVar = %myVar%
rem	%dk_call% dk_echo "myVar = %myVar%"

rem	%dk_call% dk_setGlobal myVarB "dk_info('test dk_info message')"
rem	echo myVar = %myVar%
rem	%dk_call% dk_echo "myVarB = %myVarB%"
	
	%dk_call% dk_validate DKTOOLS_DIR	%dk_call% dk_DKTOOLS_DIR
	%dk_call% dk_set cmake "%DKTOOLS_DIR%/cmake-3.29.5-windows-x86_64"
	echo cmake = %cmake%
	
	%dk_call% dk_setGlobal TEST_VAR "abc" "123" "d e f" "4 5 6"
	echo TEST_VAR = %TEST_VAR%
%endfunction%
