@echo off

tasklist /svc | find "svchost.exe" > processes_svchostRunning.txt 
pause
