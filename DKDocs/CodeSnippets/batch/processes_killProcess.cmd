::Kill a process
@echo off
%dkbatch%

:: kill by PID number
::taskkill /F /PID pid_number

:: kill by name
::taskkill /IM "process name" /F
taskkill /IM "SearchApp.exe" /F
