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


rem ####################################################################
rem # dk_isAlphanumeric(<string>, <output>:optional)
rem #
rem #  https://stackoverflow.com/a/17584764
rem #
:dk_isAlphanumeric
%setlocal%

    rem set "arg1=%~1"
    rem if defined "%~1" call set "arg1=%%%arg1%%%"
    for /f "delims=0123456789_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" %%i in ("%~1") do set "bad_characters=%%i"

    if NOT defined bad_characters (
        set "bad_characters="
		endlocal & (
			set "dk_isAlphanumeric=true"
			if "%~2" neq "" set "%2=%dk_isAlphanumeric%"
		)
        exit /b 0
    )
   
    set "bad_characters="
    endlocal & (
		set "dk_isAlphanumeric=false"
		if "%~2" neq "" set "%2=%dk_isAlphanumeric%"
	)
    exit /b 1
%endfunction%







rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

    %dk_call% dk_isAlphanumeric 69         && %dk_call% dk_info "is alphanumeric" || %dk_call% dk_info "is NOT alphanumeric"
    set "myNumber=42"
    %dk_call% dk_isAlphanumeric %myNumber% && %dk_call% dk_info "is alphanumeric" || %dk_call% dk_info "is NOT alphanumeric"
    %dk_call% dk_isAlphanumeric myNumber   && %dk_call% dk_info "is alphanumeric" || %dk_call% dk_info "is NOT alphanumeric"  &rem FIXME
    %dk_call% dk_isAlphanumeric 0          && %dk_call% dk_info "is alphanumeric" || %dk_call% dk_info "is NOT alphanumeric"
    %dk_call% dk_isAlphanumeric 1          && %dk_call% dk_info "is alphanumeric" || %dk_call% dk_info "is NOT alphanumeric"
    %dk_call% dk_isAlphanumeric 1.23       && %dk_call% dk_info "is alphanumeric" || %dk_call% dk_info "is NOT alphanumeric"
    %dk_call% dk_isAlphanumeric -42        && %dk_call% dk_info "is alphanumeric" || %dk_call% dk_info "is NOT alphanumeric"
    %dk_call% dk_isAlphanumeric "36"       && %dk_call% dk_info "is alphanumeric" || %dk_call% dk_info "is NOT alphanumeric"
   
    %dk_call% dk_isAlphanumeric "36a"      && %dk_call% dk_info "is alphanumeric" || %dk_call% dk_info "is NOT alphanumeric"
    %dk_call% dk_isAlphanumeric word       && %dk_call% dk_info "is alphanumeric" || %dk_call% dk_info "is NOT alphanumeric"
    %dk_call% dk_isAlphanumeric 123456789  && %dk_call% dk_info "is alphanumeric" || %dk_call% dk_info "is NOT alphanumeric"
    %dk_call% dk_isAlphanumeric myArray[0] && %dk_call% dk_info "is alphanumeric" || %dk_call% dk_info "is NOT alphanumeric"
%endfunction%
