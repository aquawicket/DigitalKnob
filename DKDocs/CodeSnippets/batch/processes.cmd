:: list running processes and services
@echo off
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit )

echo ***processes ***
tasklist /SVC

echo *** Microsoft Apps ***
tasklist /APPS
