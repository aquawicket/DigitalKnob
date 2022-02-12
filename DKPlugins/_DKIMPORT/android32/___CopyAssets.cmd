%dkbatch%
:: https://developer.android.com/studio/projects

set "PACKAGE_NAME=com.digitalknob.dk"
if not "%1"=="" set PACKAGE_NAME=%~1


set APP_ROOT=%~dp0

if not exist %ANDROID_HOME% ( 
	%ERROR% "ANDROID_HOME environment variable not set"
)

echo Copying assets to device
echo.
echo FROM: %APP_ROOT%/app/src/main/assets
echo   TO: /sdcard/Android/data/%PACKAGE_NAME%/files/assets
echo.
"%ANDROID_HOME%/platform-tools/adb" push %APP_ROOT%\app\src\main\assets /sdcard/Android/data/%PACKAGE_NAME%/files/assets
%IF_ERROR% "Failed to copy assets to the device"


ECHO Done
%DKEND%
