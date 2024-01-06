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


PACKAGE_NAME="com.digitalknob.dk"
#if not "%1"=="" set PACKAGE_NAME=%~1
APP_ROOT="$PWD"
ANDROID_HOME="$DIGITALKNOB/Development/3rdParty/android-sdk"


if [[ -f "$ANDROID_HOME" ]]; then
    echo "$ANDROID_HOME"
else
	echo "ANDROID_HOME environment variable not set"
fi

	
#ASSETS="$APP_ROOT/app/src/main/assets"
#if [[ -f "$APP_ROOT/../assets" ]]; then
	ASSETS="$APP_ROOT/../assets"
#fi

DEVICE_PATH="/sdcard/Android/data/$PACKAGE_NAME/files/assets"

echo "Deleting folder"
echo " "
echo "PATH: $DEVICE_PATH"
echo " "
"$ANDROID_HOME/platform-tools/adb" shell rm -r $DEVICE_PATH
#%IF_ERROR% "Failed to delete the folder on the device"


echo "Copying assets to device"
echo " "
echo "FROM: $ASSETS"
echo "  TO: $DEVICE_PATH"
echo " "
"$ANDROID_HOME/platform-tools/adb" push $ASSETS $DEVICE_PATH
#%IF_ERROR% "Failed to copy assets to the device"


echo "Done"
