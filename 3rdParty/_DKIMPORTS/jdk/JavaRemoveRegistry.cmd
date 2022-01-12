@echo off
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit )

reg delete "HKLM\SOFTWARE\JavaSoft\Java Runtime Environment" /f
