#!/bin/bash


# to run this script requires privledges 
# > chmod 777 build.sh

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
	DIGITALKNOB="/home/$USER/digitalknob"
elif [[ "$OSTYPE" == "darwin"* ]]; then
	DIGITALKNOB="/Users/$USER/digitalknob"
elif [[ "$OSTYPE" == "cygwin" ]]; then
	DIGITALKNOB="C:/Users/$USERNAME/digitalknob"
elif [[ "$OSTYPE" == "msys" ]]; then
	DIGITALKNOB="C:/Users/$USERNAME/digitalknob"
elif [[ "$OSTYPE" == "win32" ]]; then #I'm not sure this can happen
	DIGITALKNOB="C:/Users/$USERNAME/digitalknob" 
elif [[ "$OSTYPE" == "freebsd"* ]]; then
	echo "TODO: DIGITALKNOB NOT SET"
else
    echo "UNKNOWN OS TYPE ($OSTYPE)"
fi

GRADLE=1

APP_ROOT="$PWD"
APP_PATH="$APP_ROOT/app/src/main"
ANDROID_HOME="$DIGITALKNOB/DK/3rdParty/android-sdk"

# App package name and lable
TYPE="com"
COMPANY="digitalknob"
APP_NAME="dk"
APP_LABEL="DKApp"

APK_NAME="$APP_NAME"
PACKAGE_NAME="$TYPE.$COMPANY.$APP_NAME"

echo "15. Uninstall any previous matching package"
#"$ANDROID_HOME/platform-tools/adb" shell pm list packages $PACKAGE_NAME
# echo error level from list packages is %ERRORLEVEL%
#"$ANDROID_HOME/platform-tools/adb" shell pm list packages $PACKAGE_NAME | findstr /I /C:"$PACKAGE_NAME"
# echo error level from list packages findstr is %ERRORLEVEL%
#if %ERRORLEVEL% EQU 0 ( 
	echo "uninstalling previous $PACKAGE_NAME  package . . ."
	"$ANDROID_HOME/platform-tools/adb" shell pm uninstall $PACKAGE_NAME
#	%IF_ERROR% "Failed to Uninstall previous package"
#)



echo "16. Install the apk package to android device"
if [[ "$GRADLE" == "1"* ]]; then
	"$ANDROID_HOME/platform-tools/adb" install -r "$APP_ROOT/app/build/outputs/apk/debug/app-debug.apk"
else
	"$ANDROID_HOME/platform-tools/adb" install -r $APP_PATH/build/$APK_NAME.apk
fi
#%IF_ERROR% "Failed to Install the apk package to android device"


#echo "17. Copying assets to device"
#$APP_ROOT___CopyAssets.sh $PACKAGE_NAME 
