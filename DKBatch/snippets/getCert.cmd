@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


set openssl="%USERPROFILE%\digitalknob\Development\3rdParty\openssl-1.0.2h-vs2015\bin\opensslMT"
set certs="%USERPROFILE%\digitalknob\Development\3rdParty\openjdk-9.0.4_windows-x64_bin\lib\security"
set keytool="%USERPROFILE%\digitalknob\Development\3rdParty\openjdk-9.0.4_windows-x64_bin\bin\keytool"
echo -n | %openssl% s_client -connect *.google.com:443 | %openssl% x509 > %certs%\google.cer
%keytool% -import -alias google4 -keystore %certs%\cacerts -file %certs%\google.cer
