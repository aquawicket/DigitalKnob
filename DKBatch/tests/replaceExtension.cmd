@echo off
set "variableA=%USERPROFILE:\=/%/DigitalKnob/Development/DKBatch/functions/DK"
set "variableB=%USERPROFILE:\=/%/DigitalKnob/Development/DKBatch/functions/DK.cmd"


echo variableA = %variableA:.cmd=%.cmd
echo variableB = %variableB:.cmd=%.cmd
pause