@echo off
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit )

start /wait C:\Users\Administrator\digitalknob\Download\vs_Community.exe --layout "C:\Users\Administrator\digitalknob\Download\VisualStudio" --fix
