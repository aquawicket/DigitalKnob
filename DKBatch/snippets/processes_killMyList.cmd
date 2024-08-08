::Kill a processes in processes_MYList.txt
@echo off

:: kill by name
for /f "tokens=*" %%a in (processes_MyList.txt) do (
	echo %%a 
	taskkill /IM "%%a" /F
)

pause
