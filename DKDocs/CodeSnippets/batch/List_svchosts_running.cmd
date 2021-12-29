@echo off
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit )

tasklist /svc | find "svchost.exe" > processes_svchostRunning.txt 
