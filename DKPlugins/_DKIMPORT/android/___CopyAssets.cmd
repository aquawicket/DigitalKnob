%dkbatch%
:: https://developer.android.com/studio/projects

set "PACKAGE_NAME=com.digitalknob.dk"
::if not "%1"=="" set PACKAGE_NAME=%~1


set APP_ROOT=%~dp0

if not exist %ANDROID_HOME% ( 
	%ERROR% "ANDROID_HOME environment variable not set"
)

set ASSETS=%APP_ROOT%/app/src/main/assets
if exist %APP_ROOT%..\assets (
	set ASSETS=%APP_ROOT%..\assets
)

set DEVICE_PATH=/sdcard/Android/data/%PACKAGE_NAME%/files/assets

echo Deleting folder
echo.
echo. PATH: %DEVICE_PATH%
echo.
cmd /c "%ANDROID_HOME%/platform-tools/adb" shell rm -r %DEVICE_PATH%
::%IF_ERROR% "Failed to delete the folder on the device"


echo Copying assets to device
echo.
echo FROM: %ASSETS%
echo   TO: %DEVICE_PATH%
echo.
cmd /c "%ANDROID_HOME%/platform-tools/adb" push %ASSETS% %DEVICE_PATH%
%IF_ERROR% "Failed to copy assets to the device"


ECHO Done
%DKEND%
