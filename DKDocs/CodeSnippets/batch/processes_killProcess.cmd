::Kill a process
@echo off
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit )

:: kill by PID number
::taskkill /F /PID pid_number

:: kill by name
::taskkill /IM "process name" /F
taskkill /IM "SearchApp.exe" /F
