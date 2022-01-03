::Kill a processes in processes_MYList.txt
@echo off
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit )

:: kill by name
for /f "tokens=*" %%a in (processes_MyList.txt) do (
	echo %%a 
	taskkill /IM "%%a" /F
)
