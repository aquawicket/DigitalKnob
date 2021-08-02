@echo off
set openssl="C:\Users\aquawicket\digitalknob\DK\3rdParty\openssl-1.0.2h-vs2015\bin\opensslMT"
set certs="C:\Users\aquawicket\digitalknob\DK\3rdParty\openjdk-9.0.4_windows-x64_bin\lib\security"
set keytool="C:\Users\aquawicket\digitalknob\DK\3rdParty\openjdk-9.0.4_windows-x64_bin\bin\keytool"
echo -n | %openssl% s_client -connect google.com:443 | %openssl% x509 > %certs%\google.cert
%keytool% -import -alias google -keystore %certs%\cacerts -file %certs%\google.cert
echo press and key to continue && timeout /t 60 > nul