%DKBATCH%
:: https://developer.android.com/studio/projects

set APP_ROOT=%~dp0
set "PACKAGE_NAME=%~1"
if not exist %ANDROID_HOME% (
	echo ERROR: The ANDROID_HOME environment variable is invalid
	goto :end
)

echo Copying assets to device
"%ANDROID_HOME%/platform-tools/adb" push %APP_ROOT%\app\src\main\assets /sdcard/Android/data/%PACKAGE_NAME%/files/assets
if NOT "%ERRORLEVEL%" == "0" goto error

ECHO Done
goto :EOF

:error
echo Failed with error code: %ERRORLEVEL%
pause

%DKEND%
