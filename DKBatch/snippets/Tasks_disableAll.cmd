@echo off

for /f "tokens=1 delims=," %%a in (
    'schtasks /Query /FO csv ^| find /V "Task name" ^| find /V "Disabled"'
) do (
	echo %%a
	schtasks /change /tn %%a /disable
)