@echo off
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit )

set "DIGITALKNOB=C:\Users\Administrator\digitalknob"
::set "JDK=%DIGITALKNOB%\DK\3rdParty\openjdk-8u41-b04-windows-i586-14_jan_2020"
set "JDK=%DIGITALKNOB%\DK\3rdParty\openjdk-11_windows-x64_bin"

reg delete "HKLM\SOFTWARE\JavaSoft\Java Runtime Environment" /f
