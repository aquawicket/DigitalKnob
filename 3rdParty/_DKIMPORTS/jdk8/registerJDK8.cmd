@echo off
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit )

set "Folder=openjdk-8u41"
set "CurrentVersion=1.8.0_41"

set "JAVA_HOME=C:\Users\Administrator\digitalknob\DK\3rdParty\%Folder%"
setx JAVA_HOME %JAVA_HOME%
setx VS_JavaHome %JAVA_HOME% 

reg add "HKLM\SOFTWARE\JavaSoft\Java Runtime Environment" /v CurrentVersion /t REG_SZ /d %CurrentVersion% /f
reg add "HKLM\SOFTWARE\JavaSoft\Java Runtime Environment\%CurrentVersion%" /v JavaHome /t REG_SZ /d "%JAVA_HOME%" /f
reg add "HKLM\SOFTWARE\JavaSoft\Java Runtime Environment\%CurrentVersion%" /v RuntimeLib /t REG_SZ /d "%JAVA_HOME%\bin\server\jvm.dll" /f

