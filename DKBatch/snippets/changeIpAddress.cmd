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


rem Change Ip Address Configuration
rem netsh interface ipv4 set address name="YOUR INTERFACE NAME" static IP_ADDRESS SUBNET_MASK GATEWAY

rem change ethernet
::netsh interface ipv4 set address name="Ethernet" static 10.0.0.102 255.255.255.0 10.0.0.1

rem change wifi
netsh interface ipv4 set address name="Wi-Fi" static 10.0.0.109 255.255.255.0 10.0.0.1

rem change dns servers
netsh interface ipv4 set dnsservers "Wi-Fi" static 10.0.0.1
netsh interface ipv4 ADD dns "Wi-Fi" 208.67.222.222 Index=2
netsh interface ipv4 ADD dns "Wi-Fi" 8.8.8.8 Index=3

rem change to dhcp
::netsh interface ipv4 set address name=”Wi-Fi” source=dhcp
::netsh interface ipv4 set dnsservers name"Wi-Fi" source=dhcp