@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


:: Change Ip Address Configuration
:: netsh interface ipv4 set address name="YOUR INTERFACE NAME" static IP_ADDRESS SUBNET_MASK GATEWAY

:: change ethernet
::netsh interface ipv4 set address name="Ethernet" static 10.0.0.102 255.255.255.0 10.0.0.1

:: change wifi
netsh interface ipv4 set address name="Wi-Fi" static 10.0.0.109 255.255.255.0 10.0.0.1

:: change dns servers
netsh interface ipv4 set dnsservers "Wi-Fi" static 10.0.0.1
netsh interface ipv4 ADD dns "Wi-Fi" 208.67.222.222 Index=2
netsh interface ipv4 ADD dns "Wi-Fi" 8.8.8.8 Index=3

:: change to dhcp
::netsh interface ipv4 set address name=”Wi-Fi” source=dhcp
::netsh interface ipv4 set dnsservers name"Wi-Fi" source=dhcp