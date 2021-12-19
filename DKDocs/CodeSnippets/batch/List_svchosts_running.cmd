@ECHO off
tasklist /svc | find "svchost.exe" > C:\tasklist.txt 
pause