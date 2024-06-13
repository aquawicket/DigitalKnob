@echo off
set JAVA_VERSION=11
setx JAVA_VERSION 11
set JAVA_HOME=C:/Users/aquawicket/digitalknob/Development/3rdParty/openjdk-11_windows-x64_bin
setx JAVA_HOME C:/Users/aquawicket/digitalknob/Development/3rdParty/openjdk-11_windows-x64_bin
setx VS_JavaHome C:/Users/aquawicket/digitalknob/Development/3rdParty/openjdk-11_windows-x64_bin
setx STUDIO_JDK C:/Users/aquawicket/digitalknob/Development/3rdParty/openjdk-11_windows-x64_bin
setx STUDIO_GRADLE_JDK C:/Users/aquawicket/digitalknob/Development/3rdParty/openjdk-11_windows-x64_bin
reg add "HKLM\SOFTWARE\JavaSoft\Java Runtime Environment" /v CurrentVersion /t REG_SZ /d 11 /f
reg add "HKLM\SOFTWARE\JavaSoft\Java Runtime Environment\11" /v JavaHome /t REG_SZ /d "C:/Users/aquawicket/digitalknob/Development/3rdParty/openjdk-11_windows-x64_bin" /f
reg add "HKLM\SOFTWARE\JavaSoft\Java Runtime Environment\11" /v RuntimeLib /t REG_SZ /d "C:/Users/aquawicket/digitalknob/Development/3rdParty/openjdk-11_windows-x64_bin\bin\server\jvm.dll" /f
