rem shebang
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

:RUN
	setlocal enableDelayedExpansion

	echo.#####################
	echo.###### varTest ######
	echo.#####################
	echo.


	set file=varTest.bash
	echo.
	echo.############ %file% #############
	%dk_call% dk_validate wsl.exe 	%dk_call% dk_depend wsl.exe 1>nul
	"%ComSpec%" /c %wsl.exe% chmod 777 %file:C:=/mnt/c%
	"%ComSpec%" /c %wsl.exe% bash %file:C:=/mnt/c%


	set file=varTest.bat
	echo.
	echo.############ %file% #############
	"%ComSpec%" /c %file%


	set file=varTest.c
	echo.
	echo.############ %file% #############
	%dk_call% dk_validate Host_Tuple 	%dk_call% dk_Host_Tuple						1>nul
	%dk_call% dk_validate Target_Os 	%dk_call% DKBuilder/Target_Os %Host_Os%		1>nul
	%dk_call% dk_validate Target_Arch 	%dk_call% DKBuilder/Target_Arch %Host_Arch%	1>nul
	%dk_call% dk_validate Target_Env 	%dk_call% DKBuilder/Target_Env Clang		1>nul
	%dk_call% dk_validate clang_exe 	%dk_call% dk_depend clang_exe				1>nul
	del %file%.exe								 									1>nul
	%ComSpec% /c %clang_exe% %file% -o %file%.exe 1>nul 2>nul
	%ComSpec% /c %file%.exe
	del %file%.exe


	set file=varTest.cmake
	echo.
	echo.############ %file% #############
	%dk_call% dk_validate cmake.exe 	%dk_call% dk_depend cmake.exe				1>nul
	"%ComSpec%" /c %cmake.exe% -P %file%


	set file=varTest.cmd
	echo.
	echo.############ %file% #############
	"%ComSpec%" /c %file%


	set file=varTest.cpp
	echo.
	echo.############ %file% #############
	%dk_call% dk_validate clang_exe %dk_call% dk_depend clang_exe					1>nul
	set "clang++_exe=%clang_exe:.exe=++.exe%										1>nul
	del %file%.exe 																	1>nul
	%ComSpec% /c %clang_exe% -o %file%.exe -static %file% 1>nul 2>nul
	%ComSpec% /c %file%.exe
	del %file%.exe


	set file=varTest.cs
	echo.
	echo.############ %file% #############
	%dk_call% dk_validate powershell.exe %dk_call% dk_depend powershell.exe			1>nul
	%ComSpec% /c %powershell.exe% -NoProfile -ExecutionPolicy Bypass -Command ^"^
	Add-Type -Path 'varTest.cs'; ^
	[Program]::Main();"


	set file=varTest.java
	echo.
	echo.############ %file% #############
	%dk_call% dk_validate java_exe %dk_call% dk_depend openjdk						1>nul
	%dk_call% dk_validate javac_exe %dk_call% dk_depend openjdk						1>nul
	del %file:.java=.class% 1>nul 2>nul
	%ComSpec% /c %javac_exe% %file%
	%ComSpec% /c %java_exe% varTest
	del %file:.java=.class%


	set file=varTest.js
	echo.
	echo.############ %file% #############
	%dk_call% dk_validate cscript.exe %dk_call% dk_depend cscript.exe					1>nul
	"%ComSpec%" /c %cscript.exe% //D //E:{16d51579-a30b-4c8b-a276-0ff4dc41e755} //X //NoLogo %file%


	set file=varTest.php
	echo.
	echo.############ %file% #############
	%dk_call% dk_validate php_exe %dk_call% dk_depend php-src							1>nul
	%ComSpec% /c %php_exe% %file%


	set file=varTest.pl
	echo.
	echo.############ %file% #############
	%dk_call% dk_validate perl_exe %dk_call% dk_depend perl							1>nul
	"%ComSpec%" /c %perl_exe% %file%


	set file=varTest.ps1
	echo.
	echo.############ %file% #############
	%dk_call% dk_validate powershell.exe %dk_call% dk_depend powershell.exe			1>nul
	"%ComSpec%" /c %powershell.exe% ./%file%


	set file=varTest.py
	echo.
	echo.############ %file% #############
	%dk_call% dk_validate python_exe %dk_call% dk_depend python3					1>nul
	%ComSpec% /c %python_exe% %file%


	set file=varTest.rb
	echo.
	echo.############ %file% #############
	%dk_call% dk_validate ruby_exe %dk_call% dk_depend Ruby							1>nul
	%ComSpec% /c %ruby_exe% %file%


	set file=varTest.sh
	echo.
	echo.############ %file% #############
	%dk_call% dk_validate wsl.exe %dk_call% dk_depend wsl.exe						1>nul
	%ComSpec% /c %wsl.exe% chmod 777 %file:C:=/mnt/c%
	"%ComSpec%" /c wsl sh %file:C:=/mnt/c%


	set file=varTest.vbs
	echo.
	echo.############ %file% #############
	%dk_call% dk_validate cscript.exe %dk_call% dk_depend cscript.exe				1>nul
	"%ComSpec%" /c %cscript.exe% //D //E:vbscript //X //NoLogo %file%
%endfunction%











rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% RUN
	
%endfunction%
