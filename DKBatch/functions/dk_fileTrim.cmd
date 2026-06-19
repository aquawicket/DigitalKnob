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
rem # dk_fileTrim(file)
rem #
rem #		Remove all of the empty lines from a file
rem #
rem #	Reference: https://stackoverflow.com/a/45021815
rem #
:dk_fileTrim
%setlocal%
 	
	echo 1 = %~1
	set "file=%~1"
	set "file=%file:/=\%"
	echo file = %file%
	
	%dk_call% dk_validate findstr.exe %dk_call% dk_findFile findstr.exe
	%findstr.exe% /rc:"[^ 	]" "%file%"> "%file%.tmp"
	move /y "%file%.tmp" "%file%"
%endfunction%











rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	set "file=%~dp0dk_fileTrim_TEST.txt"
	set "file=%file:\=/%"
	
	>"%file/=\%" (
		echo.###########
		echo.
		echo. 2 
		echo. 
		echo. 4 
		echo.  
		echo. 6 
		echo.	
		echo. 8 
		echo. 	
		echo. 10 
		echo.	 
		echo. 12 
		echo.	 	
		echo. 14 
		echo. 	 
		echo.###########
	)
	
	echo ###### Before dk_fileTrim ######
	type "%file:/=\%"
	echo.
	
	%dk_call% dk_fileTrim "%file%"
	
	echo ###### After dk_fileTrim ######
	type "%file:/=\%"
	echo.

%endfunction%

