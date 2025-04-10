@echo off

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


dk_OS_BUILD
dk_OS_NAME
dk_OS_ARCH