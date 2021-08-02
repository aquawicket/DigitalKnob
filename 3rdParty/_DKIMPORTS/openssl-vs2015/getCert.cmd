@echo off
echo -n | opensslMT s_client -connect google.com:443 | opensslMT x509 > google.cert
echo press and key to continue && timeout /t 60 > nul