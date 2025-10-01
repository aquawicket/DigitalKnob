@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


REM Check Windows architecture,edition and build number
for /f "tokens=1* delims==" %%A in ('wmic os get OSArchitecture^,Caption^,BuildNumber /value') do (
	for /f "tokens=*" %%S in ("%%B") do (
		if /i "%%A" equ "BuildNumber" set "Build_Number=%%S"
		if /i "%%A" equ "Caption" set "OS_Name=%%S"
		if /i "%%A" equ "OSArchitecture" set "OS_Architecture=%%S"
))

echo Build_Number = %Build_Number%
echo OS_Name = %OS_Name%
echo OS_Architecture = %OS_Architecture%
