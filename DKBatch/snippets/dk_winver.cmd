@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


REM Check Windows architecture,edition and build number
for /f "tokens=1* delims==" %%A in ('wmic os get OSArchitecture^,Caption^,BuildNumber /value') do (
	for /f "tokens=*" %%S in ("%%B") do (
		if "%%A" equ "BuildNumber" set "Build_Number=%%S"
		if "%%A" equ "Caption" set "OS_Name=%%S"
		if "%%A" equ "OSArchitecture" set "OS_Architecture=%%S"
))

echo Build_Number = %Build_Number%
echo OS_Name = %OS_Name%
echo OS_Architecture = %OS_Architecture%
