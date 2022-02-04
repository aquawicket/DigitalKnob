:: Windows Batch file DK builder
@echo off
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit )

echo This is a test batch file
