@echo off
%dkbatch%

tasklist /svc | find "svchost.exe" > processes_svchostRunning.txt 
