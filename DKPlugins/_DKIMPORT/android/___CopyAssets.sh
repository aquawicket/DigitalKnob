#!/bin/bash

# to run this script requires privledges 
# > chmod 777 build.sh

### set DIGITALKNOB_DIR
if [[ -n "$USERPROFILE" ]]; then
	DIGITALKNOB_DIR="$USERPROFILE\digitalknob"
	DIGITALKNOB_DIR=$(sed 's.C:./c.g' <<< $DIGITALKNOB_DIR)
	DIGITALKNOB_DIR=$(sed 's.\\./.g' <<< $DIGITALKNOB_DIR)
else
	DIGITALKNOB_DIR="$HOME/digitalknob"
fi
mkdir -p $DIGITALKNOB_DIR
print_var DIGITALKNOB_DIR


PACKAGE_NAME="com.digitalknob.dk"
#if not "%1"=="" set PACKAGE_NAME=%~1
APP_ROOT="$PWD"
ANDROID_HOME="$DIGITALKNOB_DIR/Development/3rdParty/android-sdk"


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
