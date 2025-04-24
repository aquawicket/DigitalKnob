@echo off
echo|set /p="MySecretPassword" > %TMP%/hash.txt |certutil -hashfile %TMP%/hash.txt SHA256 | findstr /v "hash"
pause