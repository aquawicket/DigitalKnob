@echo off
echo|set /p="MySecretPassword" > %TMP%/hash.txt |%CERTUTIL_EXE% -hashfile %TMP%/hash.txt SHA256 | findstr /v "hash"
pause