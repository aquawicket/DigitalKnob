@echo off
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit )

reg add "HKLM\SOFTWARE\JavaSoft\Java Runtime Environment" /v CurrentVersion /t REG_SZ /d %JDK_VERSION% /f
reg add "HKLM\SOFTWARE\JavaSoft\Java Runtime Environment\%JDK_VERSION%" /v JavaHome /t REG_SZ /d "%JDK_HOME%" /f
reg add "HKLM\SOFTWARE\JavaSoft\Java Runtime Environment\%JDK_VERSION%" /v RuntimeLib /t REG_SZ /d "%JDK_HOME%\bin\server\jvm.dll" /f