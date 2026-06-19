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
rem # dk_source(function_name)
rem #
rem #    @function_name   - the function name of the file to source. Download if needed
rem #
:dk_source
rem %setlocal%
	
	set "_fnc_=%~1"
	if NOT defined _fnc_		(echo ERROR: dk_source _fnc_:%_fnc_% EMPTY 		& exit /b 1)
	if "%_fnc_%" equ "" 		(echo ERROR: dk_source _fnc_:%_fnc_% UNDEFINED 	& exit /b 1)
	if EXIST "%_fnc_%" 			(exit /b %errorlevel%)
		
	if NOT defined DKHOME_DIR 	(%dk_call% DKHOME_DIR)
	if NOT defined DKHTTP_DIR 	(set "DKHTTP_DIR=http://aquawicket.com")
	if NOT defined DKBRANCH_DIR	(%dk_call% dk_DKBRANCH_DIR)
		
	rem ###### ensure .cmd extension
	set "_fnc_=%_fnc_:.cmd=%.cmd"
	if EXIST "%_fnc_%" (exit /b %errorlevel%)
	
	rem ###### Atempt to extract the file from DigitalKnob.tar.gz
	if "%DKOFFLINE%" equ "1" (
		if EXIST "%DigitalKnob_tar_gz%" 			(%dk_call% tar.exe -zxvf "%DigitalKnob_tar_gz%" -C "%DKBRANCH_DIR%" DKBatch/functions/%_fnc_%)
		if EXIST "%DKBATCH_FUNCTIONS_DIR_%%_fnc_%" 	(exit /b %errorlevel%)
	)
	
	rem ###### If func doesn't contain C:  ...prepend C:\Users\Administrator\Digital Knob\Development\DKBash\functions\ ######
	if "!_fnc_:%SystemDrive%=!" equ "%_fnc_%" 	(set "_fnc_=%DKBATCH_FUNCTIONS_DIR_%%_fnc_%")
	if EXIST "%_fnc_%" 							(exit /b %errorlevel%)

	rem ############ Download the file if missing #############
	rem ###### Replace DKHOME_DIR:'C:/Users/Administrator' with DKHTTP_DIR:'http://aquawicket.com'
	if NOT EXIST "%_fnc_%" (
		rem call set "_url_=%%_fnc_:%DKHOME_DIR%=%DKHTTP_DIR%%%"
		set "_url_=!_fnc_:%DKHOME_DIR%=%DKHTTP_DIR%!"
	)
	set "_url_=%_url_:\=/%"
	
	rem ### Get URL
	for %%Z in ("%_fnc_%") do 	(set "dirn=%%~dpZ")
	if "%dirn:~-1%" equ "\" 	(set "dirn=%dirn:~0,-1%")
	if "%dirn:~-1%" equ "/" 	(set "dirn=%dirn:~0,-1%")
	if NOT EXIST "%dirn%" 		(mkdir "%dirn:/=\%")	
	
	rem ### DOWNLOAD
	echo downloading %_url_:/=\% . . .
	set "curl.exe=%SystemRoot%\System32\curl.exe"
	if NOT EXIST "%_fnc_%" (
		"%curl.exe:/=\%" --version 1>nul 2>nul && (
			"%curl.exe:/=\%" --silent --show-error --remove-on-error --location "%_url_:\=/%" --create-dirs --output "%_fnc_%"
		)
	)

rem	set "certutil.exe=%SystemRoot%\System32\certutil.exe"
rem	if NOT EXIST "%_fnc_%" (
rem		"%certutil.exe:/=\%" 1>nul 2>nul && (
rem			"%certutil.exe:/=\%" -urlcache -split -f "%_url_:\=/%" "%_fnc_%"
rem		)
rem	)
	
rem	set "bitsadmin.exe=%SystemRoot%\System32\bitsadmin.exe"
rem	if NOT EXIST "%_fnc_%" (
rem		"%bitsadmin.exe:/=\%" 1>nul 2>nul && (
rem			"%bitsadmin.exe:/=\%" /transfer /Download /priority Foreground "%_url_:\=/%" "%_fnc_%"
rem		)
rem	)
	
	rem ############ Final Check ############
	if NOT EXIST "%_fnc_%" (
		echo ERROR   Failed to download %_fnc_%
		exit /b 1
	)
%endfunction%	
	






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	del "dk_info.cmd_BACKUP"
	ren "dk_info.cmd" "dk_info.cmd_BACKUP"
	del "dk_info.cmd"
	pause
    %dk_call% dk_source dk_info
    call dk_info "test dk_info using dk_source to download it first"
%endfunction%