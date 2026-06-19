:printMacro
setlocal enableDelayedExpansion
echo ############ %~1 ############
echo !%~1!
echo ############ %~1 ############
endlocal
exit /b