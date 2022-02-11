%dkbatch%

set "PACKAGE_NAME=com.digitalknob.DKJni"

"%ANDROID_HOME%/platform-tools/adb" shell pm list packages %PACKAGE_NAME% | findstr /I /C:"%PACKAGE_NAME%"
if %errorlevel% == 1 (
    echo APP NOT INSTALLED
) else (
    echo APP ALREADY INSTALLED
)
