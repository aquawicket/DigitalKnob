@echo off
set "variableA=%USERPROFILE:\=/%/digitalknob/Development/DKBatch/functions/DK"
set "variableB=%USERPROFILE:\=/%/digitalknob/Development/DKBatch/functions/DK.cmd"


echo variableA = %variableA:.cmd=%.cmd
echo variableB = %variableB:.cmd=%.cmd
pause