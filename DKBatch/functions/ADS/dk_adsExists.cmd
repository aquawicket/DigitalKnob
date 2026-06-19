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
rem # dk_adsExists(adsPath)
rem #
rem #
:dk_adsExists
%setlocal%

	set "adsPath=%~1"
	set "adsPath=%adsPath:/=\%"
	
	set "sort_exe=%SystemRoot%\System32\sort.exe"
	(%sort_exe% < "%adsPath%") 1>nul 2>nul && (
		set dk_adsExists=0
	) || (
		set dk_adsExists=1
	)

	:return
	endlocal & (
		set "dk_adsExists=%dk_adsExists%"
		if "%~2" neq "" (
			set "%~2=%dk_adsExists%"
		) else (
			rem echo %dk_adsExists%
		)
	)
	
	exit /b %dk_adsExists%
%endfunction%











rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% ADS\dk_adsExists "DKADS.txt:DKBuilder.cmd" && (
		echo Alternate data stream 1 exists
	) || (
		echo Alternate data stream 1 NOT FOUND
	)
	
	%dk_call% ADS\dk_adsExists "DKADS.txt:NonExistent.ext" && (
		echo Alternate data stream 2 exists
	) || (
		(call ) & echo Alternate data stream 2 NOT FOUND
	)
%endfunction%
