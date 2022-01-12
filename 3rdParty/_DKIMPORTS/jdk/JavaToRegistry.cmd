@echo off
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit )

set "DIGITALKNOB=C:\Users\Administrator\digitalknob"
set "JDK=%DIGITALKNOB%\DK\3rdParty\openjdk-8u41-b04-windows-i586-14_jan_2020"

reg add "HKLM\SOFTWARE\JavaSoft\Java Runtime Environment" /v CurrentVersion /t REG_SZ /d 8u41 /f
reg add "HKLM\SOFTWARE\JavaSoft\Java Runtime Environment\8u41" /v JavaHome /t REG_SZ /d "%JDK%" /f
reg add "HKLM\SOFTWARE\JavaSoft\Java Runtime Environment\8u41" /v RuntimeLib /t REG_SZ /d "%JDK%\bin\server\jvm.dll" /f