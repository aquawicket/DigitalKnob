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


rem ###############################################################################
rem # dk_fileReplace(file, find, replace)
rem #
rem #		parses a File line by line and replaces a substring
rem #
rem #	@file	- Path to the file to be altered.
rem #	@find		- The string to search for in the file.
rem #	@replace	- The string to replace the found string with
rem #
:dk_fileReplace
%setlocal%
	set "file=%~1"
	set "find=%~2"
	set "replace=%~3"

	%dk_call% dk_validate findstr.exe %dk_call% dk_findFile findstr.exe
	
	setlocal disableDelayedExpansion enableExtensions 
	>"%file:/=\%.new" (
	  for /f "delims=" %%i in ('%findstr.exe:/=\% /n "^" "%file:/=\%"') do (
		  set "line=%%i"
		  setlocal enabledelayedexpansion
		  set "line=!line:*:=!"
		  if defined line set "line=!line:%~2=%~3!"
		  echo.!line!
		  endlocal
	  )
	)
	endlocal
	
	move /y "%file:/=\%.new" "%file:/=\%" >nul
%endfunction%







rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	
	mkdir "%SystemDrive%\DK Test" 1>nul 2>nul
	set "_file_=%SystemDrive%\DK Test\dk_fileReplace_TEST.txt"

	> "%_file_%" (
		echo one
		echo two
		echo three
		echo four
		echo five
	) 
	
	echo.
	echo ### Before ###
	type "%_file_%"
	
	%dk_call% dk_fileReplace  "%_file_%"  "hre"  "##this string was replaced##"
	
	echo.
	echo ### After ###
	type "%_file_%"
%endfunction%
