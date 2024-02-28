ECHO off && cls

"C:\Program Files (x86)\Git\bin\git.exe" add %1
@echo Added %1 to repository
:: @echo press and key to continue && timeout /t 60 > nul