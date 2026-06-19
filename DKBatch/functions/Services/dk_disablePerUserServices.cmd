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
rem # Services/dk_disablePerUserServices()
rem #
rem #
:dk_disablePerUserServices
%setlocal%

	for /f "tokens=2" %%G in ('sc query state^=all type^=userservice ^| find "SERVICE_NAME"') do (
		%dk_call% dk_registrySetKey "HKLM\SYSTEM\ControlSet001\Services\%%G" 		"UserServiceFlags" "REG_DWORD" "0"
		%dk_call% dk_registrySetKey "HKLM\SYSTEM\CurrentControlSet\Services\%%G" 	"UserServiceFlags" "REG_DWORD" "0"
	)

	%dk_call% dk_notice "Restart for changes to take effect"
%endfunction%











rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	
	%dk_call% Services/dk_disablePerUserServices
%endfunction%

