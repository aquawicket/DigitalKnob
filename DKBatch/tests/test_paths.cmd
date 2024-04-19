@echo off

echo before
::###### Load Function files ######
call "../functions/DK.cmd"

::call dk_print_variables
::echo SCRIPT_PATH = %SCRIPT_PATH%

:: http://cplusplus.bordoon.com/cmd_exe_variables.html
:: d -- drive
:: p -- path
:: n -- file name
:: x -- extension
:: f -- full path
:: s -- short PATH
:: a -- attributes
:: t -- time
:: z -- size

:main
::	set "IN=%0"  																		:: DOES NOT WORK CORRECTLY 
::	call :get_unquoted %0 IN 															:: WORKS
	set "IN=%~0"																		:: WORKS
::	call :get_unquoted %~0 IN 															:: WORKS
::	set "IN=C:\Program Files\WSL\wsl.exe"												:: WORKS
::	call :get_unquoted "C:\Program Files\WSL\wsl.exe" IN 								:: WORKS
::	set "IN=C:\Users\aquawicket\digitalknob\Development\DKBatch\tests\test_blank.cmd"	:: WORKS
::	set "IN=C:/Program Files/WSL/wsl.exe"												:: WORKS
::  set "IN=test_dk_echo.cmd"															:: WORKS
::  set "IN=/test_dk_echo.cmd"															:: DOES NOT WORK CORRECTLY 
::  set "IN=\test_dk_echo.cmd"															:: DOES NOT WORK CORRECTLY 
::	set "IN=../docs.txt"																:: WORKS
::	set "IN=..\docs.txt"																:: WORKS
::	set "IN=..\functions\DK.cmd"														:: WORKS
::	set "IN=../functions/DK.cmd"														:: WORKS
::	set "IN=../functions\DK.cmd"														:: WORKS
::	set "IN=..\functions/DK.cmd"														:: WORKS
::	set "IN=..\\functions\\DK.cmd"														:: WORKS
::	set "IN=..//functions//DK.cmd"														:: WORKS
::	set "IN=..\..\DKBatch\functions\DK.cmd"									            :: WORKS
::	set "IN=..\..\DKBatch\..\Batch\functions\DK.cmd"									:: DOES NOT WORK CORRECTLY 

	echo IN         = "%IN%"
	
	call :get_quoted "%IN%" quoted
	echo quoted     = %quoted%
	
	call :get_unquoted "%IN%" unquoted
	echo unquoted   = %unquoted%
	
	
	call :get_drive "%IN%" drive
	echo drive      = %drive%
	
	call :get_path "%IN%" path
	echo path       = %path%
	
	call :get_name "%IN%" name
	echo name       = %name%
	
	call :get_extension "%IN%" extension
	echo extension  = %extension%
	
	call :get_fullpath "%IN%" fullpath
	echo fullpath   = %fullpath%
	
	call :get_shortpath "%IN%" shortpath
	echo shortpath  = %shortpath%
	
	call :get_attributes "%IN%" attributes
	echo attributes = %attributes%
	
	call :get_filetime "%IN%" filetime
	echo filetime   = %filetime%
	
	call :get_filesize "%IN%" filesize
	echo filesize   = %filesize%
	
	pause
goto:eof

:: PATH
::echo 0    = %~0
::echo N    = %N%

:: print all variable names
::for /f "usebackq delims==" %%i in (`set`) do @echo %%i

:get_quoted
	for %%Z in (%1) do set "OUT=%%~Z"
	for %%Z in (%1) do set "OUT=%%Z"
	endlocal & set %2=%OUT%
goto:eof

:get_unquoted
	for %%Z in (%1) do set "OUT=%%~Z"
	for %%Z in (%1) do set "OUT=%%~Z"
	endlocal & set %2=%OUT%
goto:eof

:get_drive
	for %%Z in (%1) do set "OUT=%%~Z"
	for %%Z in (%1) do set "OUT=%%~dZ"
	endlocal & set %2=%OUT%
goto:eof

:get_path
	for %%Z in (%1) do set "OUT=%%~Z"
	for %%Z in (%1) do set "OUT=%%~pZ"
	endlocal & set %2=%OUT%
goto:eof

:get_name
	for %%Z in (%1) do set "OUT=%%~Z"
	for %%Z in (%1) do set "OUT=%%~nZ"
	endlocal & set %2=%OUT%
goto:eof

:get_extension
	for %%Z in (%1) do set "OUT=%%~Z"
	for %%Z in (%1) do set "OUT=%%~xZ"
	endlocal & set %2=%OUT%
goto:eof

:get_fullpath
	for %%Z in (%1) do set "OUT=%%~Z"
	for %%Z in (%1) do set "OUT=%%~fZ"
	endlocal & set %2=%OUT%
goto:eof

:get_shortpath
	for %%Z in (%1) do set "OUT=%%~Z"
	for %%Z in (%1) do set "OUT=%%~sZ"
	endlocal & set %2=%OUT%
goto:eof

:get_attributes
	for %%Z in (%1) do set "OUT=%%~Z"
	for %%Z in (%1) do set "OUT=%%~aZ"
	endlocal & set %2=%OUT%
goto:eof

:get_filetime
	for %%Z in (%1) do set "OUT=%%~Z"
	for %%Z in (%1) do set "OUT=%%~tZ"
	endlocal & set %2=%OUT%
goto:eof

:get_filesize
	for %%Z in (%1) do set "OUT=%%~Z"
	for %%Z in (%1) do set "OUT=%%~zZ"
	endlocal & set %2=%OUT%
goto:eof

pause