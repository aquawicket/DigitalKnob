@rem shebang
@echo off&rem ###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
	setlocal enableDelayedExpansion
	if NOT EXIST "%DK.cmd%" (set "DK.cmd=%USERPROFILE%\Digital Knob\Development\DKBatch\functions\DK.cmd")
	if NOT DEFINED DK.cmd (for /F "delims=" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
	if NOT EXIST "!DK.cmd!" (
		"%SystemRoot%\System32\curl.exe" --silent --location --create-dirs --output "!DK.cmd!" http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DK.cmd)
	call "!DK.cmd:/=\!" "%%~0" %%*
	exit /b %errorlevel%
)
rem #################################################################################################################################################


rem ###############################################################################
rem # dk_fileReplaceMatchLine(file, find, replace)
rem #
rem #		replace lines containg search pattern. Any line containing the search 
rem #     pattern will be replaces with the new line
rem #
rem #	@file		- Path to the file to be altered.
rem #	@find		- The string to search for in the file.
rem #	@replace	- The string to replace the line(s) with
rem #
:dk_fileReplaceMatchLine
echo %~nx0 %*
setlocal disabledelayedexpansion enableextensions

	set "_file_=%~1"
	set "_file_=%_file_:/=\%"
	
	%setlocal%
	%dk_call% dk_replaceEqual "%~2" "{EQUAL}" find
	endlocal & (set find=%find%)
	
	rem set "replace=%~3"
	
	%dk_call% dk_validate findstr.exe  %dk_call% dk_findFile findstr.exe 

	>"%_file_%.new" (
		for /f "usebackqdelims=" %%i in (`%findstr.exe% /n "^" "%_file_%"`) do (
			set line=%%~i
			if "!!" neq "" (setlocal enabledelayedexpansion)
			set line=!line:*:=!
			
			%dk_call% dk_replaceEqual "!line!" "{EQUAL}"
			
			if "x!dk_replaceEqual:%find%=!x" neq "x!%dk_replaceEqual!x" (
				if "%~3" equ "" (
					echo.
				) else (
					echo.%~3
				)
			) else (
				if "!line!" equ "" (
					echo.
				) else (
					echo.!line!
				)
			)
			if "!!" equ "" (endlocal)
		)
	)

	move /y "%_file_%.new" "%_file_%" >nul
%endfunction%







rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_validate DKCACHE_DIR   %dk_call% dk_DKCACHE_DIR
	set "file=%DKCACHE_DIR%/dk_fileReplaceMatchLine_TEST.txt"
	
	>"%file:/=\%" (
		echo one=abc
		echo two=def
		echo three=ghi
		echo four=jkl
			echo three=mno
		echo five=pqr
	) 
	
	echo.
	echo ### %file% BEFORE ###
	type "%file:/=\%"
	
	%dk_call% dk_fileReplaceMatchLine   "%file%"   "three=ghi"   "%green%replaced three=ghi%clr%"
	
	
	echo.
	echo ### %file% AFTER ###
	type "%file:/=\%"
	
	%dk_call% dk_fileReplaceMatchLine   "%file%"   "one="   "%green%replaced one=%clr%"
	
	echo.
	echo ### %file% AFTER ###
	type "%file:/=\%"
	
	%dk_call% dk_fileReplaceMatchLine   "%file%"   "mno"   "%green%replaced mno%clr%"
	
	echo.
	echo ### %file% AFTER ###
	type "%file:/=\%"
%endfunction%

