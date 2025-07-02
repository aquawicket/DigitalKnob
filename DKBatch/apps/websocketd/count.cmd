@echo off

:: Count from 1 to 10 with a sleep
for /l %%x IN (1,1,1000) DO (
    ping 127.0.0.1 -n 2 >nul
	echo %%x
)
