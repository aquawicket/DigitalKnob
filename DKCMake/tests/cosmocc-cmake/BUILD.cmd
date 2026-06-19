rem shebang
@echo off&rem ###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
	setlocal enableDelayedExpansion
	if NOT EXIST "%DK.cmd%" (set "DK.cmd=%USERPROFILE%\Digital Knob\Development\DKBatch\functions\DK.cmd")
	if NOT DEFINED DK.cmd (for /F "delims=" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
	if NOT EXIST "!DK.cmd!" (
		start "" /b /wait /min "curl.exe" --silent --location --create-dirs --output "!DK.cmd!" http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DK.cmd)
	call "!DK.cmd:/=\!" "%%~0" %%*
	exit /b %errorlevel%
)
rem #################################################################################################################################################


%dk_call% dk_validate DK3RDPARTY_DIR     %dk_call% dk_DK3RDPARTY_DIR
%dk_call% dk_validate DKTOOLS_DIR        %dk_call% dk_DKTOOLS_DIR
%dk_call% dk_validate COSMO_C_COMPILER   %dk_call% dk_depend cosmocc
%dk_call% dk_validate COSMO_CXX_COMPILER %dk_call% dk_depend cosmocc

@RD /S /Q "build"

set "PATH=%DK3RDPARTY_DIR%/msys2-x86_64-20240727/usr/bin;%PATH%"
set "bash_exe=%DK3RDPARTY_DIR%/msys2-x86_64-20240727/usr/bin/bash.exe"
set "cmake.exe=%DKTOOLS_DIR%/cmake-3.29.5-windows-x86_64/bin/cmake"
set "CMAKE_TOOLCHAIN_FILE=%DK3RDPARTY_DIR%/_DKIMPORTS/cosmocc/cosmo_toolchain.cmake"
set "CMAKE_BINARY_DIR=%DKSCRIPT_DIR%/build"
set "CMAKE_SOURCE_DIR=%DKSCRIPT_DIR%"

::###### Configure helloWorld ######
%bash_exe% -c "%cmake.exe% -G ""MSYS Makefiles"" -DCMAKE_TOOLCHAIN_FILE=%CMAKE_TOOLCHAIN_FILE% -B%CMAKE_BINARY_DIR% -S%CMAKE_SOURCE_DIR%" --debug-trycompile


::###### Build helloWorld ######
%bash_exe% -c "%cmake.exe% --build %CMAKE_BINARY_DIR% --verbose"


::###### Execute helloWorld ######
echo.
echo.
%DKSCRIPT_DIR%\build\helloWorld.com

pause
