@echo off
set "variableA=C:\Users\Administrator\digitalknob\Development\DKBatch\functions\DK"
set "variableB=C:\Users\Administrator\digitalknob\Development\DKBatch\functions\DK.cmd"


echo variableA = %variableA:.cmd=%.cmd
echo variableB = %variableB:.cmd=%.cmd
pause