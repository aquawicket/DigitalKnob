%dkbatch%

set GRADLE=1

set "APP_ROOT=%~dp0"
set "APP_PATH=%APP_ROOT%app/src/main"

set "APK_NAME=%APP_NAME%"
set "PACKAGE_NAME=%TYPE%.%COMPANY%.%APP_NAME%"

:: App package name and lable
set "TYPE=com"
set "COMPANY=digitalknob"
set "APP_NAME=dk"
set "APP_LABEL=DKApp"

echo 15. Uninstall any previous matching package
cmd /c "%ANDROID_HOME%/platform-tools/adb" shell pm list packages %PACKAGE_NAME%
::echo error level from list packages is %ERRORLEVEL%
cmd /c "%ANDROID_HOME%/platform-tools/adb" shell pm list packages %PACKAGE_NAME% | findstr /I /C:"%PACKAGE_NAME%"
::echo error level from list packages findstr is %ERRORLEVEL%
if %ERRORLEVEL% EQU 0 ( 
	echo uninstalling previous %PACKAGE_NAME%  package . . .
	cmd /c "%ANDROID_HOME%/platform-tools/adb" shell pm uninstall %PACKAGE_NAME%
	%IF_ERROR% "Failed to Uninstall previous package"
)



echo 16. Install the apk package to android device
if %GRADLE% EQU 1 (
	cmd /c "%ANDROID_HOME%/platform-tools/adb" install -r %APP_ROOT%\app\build\outputs\apk\debug\app-debug.apk
) else (
	cmd /c "%ANDROID_HOME%/platform-tools/adb" install -r %APP_PATH%/build/%APK_NAME%.apk
)
%IF_ERROR% "Failed to Install the apk package to android device"


::echo 17. Copying assets to device
::call %APP_ROOT%___CopyAssets.cmd %PACKAGE_NAME% 
 
%DKEND% 
