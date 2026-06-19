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
rem # dk_IpAddressLocal()
rem #
rem #		Get the local ip address.
rem #
:dk_IpAddressLocal
%setlocal%
	
	%dk_call% dk_validate findstr.exe %dk_call% dk_findFile findstr.exe
	for /f "delims=[] tokens=2" %%a in ('ping -4 -n 1 %ComputerName% ^| %findstr.exe% [') do (
		set dk_IpAddressLocal=%%a
	)
	
	:return
	endlocal & (
		set "dk_IpAddressLocal=%dk_IpAddressLocal%"
		set "findstr.exe=%findstr.exe%"
	)
%endfunction%











rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	
	%dk_call% dk_IpAddressLocal
	%dk_call% dk_debug "dk_IpAddressLocal = %dk_IpAddressLocal%"
%endfunction%

