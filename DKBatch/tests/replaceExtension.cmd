@echo off
set "variableA=%USERPROFILE:\=/%/Digital Knob/Development/DKBatch/functions/DK"
set "variableB=%USERPROFILE:\=/%/Digital Knob/Development/DKBatch/functions/DK.cmd"


echo variableA = %variableA:.cmd=%.cmd
echo variableB = %variableB:.cmd=%.cmd
pause