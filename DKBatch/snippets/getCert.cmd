@echo off&::###### DK.cmd #########################################################################################################################
if NOT exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


set openssl="%USERPROFILE%\DigitalKnob\Development\3rdParty\openssl-1.0.2h-vs2015\bin\opensslMT"
set certs="%USERPROFILE%\DigitalKnob\Development\3rdParty\openjdk-9.0.4_windows-x64_bin\lib\security"
set keytool="%USERPROFILE%\DigitalKnob\Development\3rdParty\openjdk-9.0.4_windows-x64_bin\bin\keytool"
echo -n | %openssl% s_client -connect *.google.com:443 | %openssl% x509 > %certs%\google.cer
%keytool% -import -alias google4 -keystore %certs%\cacerts -file %certs%\google.cer
