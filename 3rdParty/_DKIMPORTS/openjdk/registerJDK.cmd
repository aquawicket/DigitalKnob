@echo off
call ..\..\..\DKBatch\functions\DK.cmd

set "Folder=openjdk-11_windows-x64_bin"
set "CurrentVersion=11"

set "JAVA_VERSION=%CurrentVersion%"
setx JAVA_VERSION %CurrentVersion%
set "JAVA_HOME=%DK3RDPARTY_DIR%\%Folder%"
setx JAVA_HOME %JAVA_HOME%
setx VS_JavaHome %JAVA_HOME%
setx STUDIO_JDK %JAVA_HOME%
setx STUDIO_GRADLE_JDK %JAVA_HOME%
reg add "HKLM\SOFTWARE\JavaSoft\Java Runtime Environment" /v CurrentVersion /t REG_SZ /d %CurrentVersion% /f
reg add "HKLM\SOFTWARE\JavaSoft\Java Runtime Environment\%CurrentVersion%" /v JavaHome /t REG_SZ /d "%JAVA_HOME%" /f
reg add "HKLM\SOFTWARE\JavaSoft\Java Runtime Environment\%CurrentVersion%" /v RuntimeLib /t REG_SZ /d "%JAVA_HOME%\bin\server\jvm.dll" /f
