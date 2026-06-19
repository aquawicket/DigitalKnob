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


%dk_call% dk_validate DIGITALKNOB_DIR   %dk_call% dk_DIGITALKNOB_DIR
set "JAVA_HOME=%DIGITALKNOB_DIR%/Development/3rdParty/openjdk-11_windows-x64_bin"
setx JAVA_HOME %DIGITALKNOB_DIR%/Development/3rdParty/openjdk-11_windows-x64_bin

set APPPATH=%~dp0
if "%APPPATH%" equ "" (set APPPATH=.)
set "GRADLE_USER_HOME=%APPPATH%/gradle"
setx GRADLE_USER_HOME %APPPATH%/gradle

gradlew clean build --info
gradlew build --info

rem  Files Created with build.cmd
rem  %USERPROFILE:\=/%/.gradle/*
rem  android-project2/.gradle/*
rem  android-project2/app/.cxx/*
rem  android-project2/app/build/*


rem  Files Created with SDL2_project.sln
rem  %USERPROFILE:\=/%/.gradle/*
rem  android-project2/.gradle/*
rem  android-project2/.vs/*
rem  android-project2/ARM/*
rem  android-project2/x64/*
rem  android-project2/app/.cxx/*
rem  android-project2/app/build/*
rem  android-project2/app/jni/src/ARM/*