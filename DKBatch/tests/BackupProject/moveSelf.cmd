@echo off

echo ### START: T='%_TARGET%' ###
if "%~f0" neq "%_TARGET%" (
	setlocal enableDelayedExpansion
	mkdir "%~dp0NewLocation"
	set "_TARGET=%~dp0NewLocation\%~nx0"
    call move "%~f0" "!_TARGET!"
    "!_TARGET!"
	endlocal
)
echo ### MOVED: T='%_TARGET%' ###
exit /b 13
