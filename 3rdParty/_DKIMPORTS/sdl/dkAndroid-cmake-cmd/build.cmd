@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


set "DIGITALKNOB_DIR=%USERPROFILE%\digitalknob"
set "JAVA_HOME=%DIGITALKNOB_DIR%\Development\3rdParty\openjdk-11_windows-x64_bin"
setx JAVA_HOME %DIGITALKNOB_DIR%\Development\3rdParty\openjdk-11_windows-x64_bin

set APPPATH=%~dp0
if "%APPPATH%" equ "" (set APPPATH=.)
set "GRADLE_USER_HOME=%APPPATH%\gradle"
setx GRADLE_USER_HOME %APPPATH%\gradle

gradlew clean build --info
gradlew build --info

:: Files Created with build.cmd
:: C:/Uses/%USERNAME%/.gradle/*
:: android-project2/.gradle/*
:: android-project2/app/.cxx/*
:: android-project2/app/build/*


:: Files Created with SDL2_project.sln
:: C:/Uses/%USERNAME%/.gradle/*
:: android-project2/.gradle/*
:: android-project2/.vs/*
:: android-project2/ARM/*
:: android-project2/x64/*
:: android-project2/app/.cxx/*
:: android-project2/app/build/*
:: android-project2/app/jni/src/ARM/*