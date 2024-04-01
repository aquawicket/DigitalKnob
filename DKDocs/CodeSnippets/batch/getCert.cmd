@echo off
%dkbatch%

set openssl="%HOMEDRIVE%%HOMEPATH%\digitalknob\Development\3rdParty\openssl-1.0.2h-vs2015\bin\opensslMT"
set certs="%HOMEDRIVE%%HOMEPATH%\digitalknob\Development\3rdParty\openjdk-9.0.4_windows-x64_bin\lib\security"
set keytool="%HOMEDRIVE%%HOMEPATH%\digitalknob\Development\3rdParty\openjdk-9.0.4_windows-x64_bin\bin\keytool"
echo -n | %openssl% s_client -connect *.google.com:443 | %openssl% x509 > %certs%\google.cer
%keytool% -import -alias google4 -keystore %certs%\cacerts -file %certs%\google.cer
