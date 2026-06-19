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
rem # dk_hexToDecimal(hex rtn_var:optional)
rem #
rem #    reference: https://www.ascii-code.com
rem #
:dk_hexToDecimal
%setlocal%

    set "hex=%~1"
    set "decimal="
    set /a dk_hexToDecimal=0x%hex:~-2%
	
	:return
	endlocal & (
		set "dk_hexToDecimal=%dk_hexToDecimal%"
		if "%~2" neq "" (
			set "%~2=%dk_hexToDecimal%"
		) else (
			echo %dk_hexToDecimal%
		)
	)
%endfunction%





rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

    %dk_call% dk_hexToDecimal 0x1b
    %dk_call% dk_echo "dk_hexToDecimal = %dk_hexToDecimal%"
%endfunction%
