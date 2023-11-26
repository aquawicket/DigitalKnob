#!/bin/bash

if [ -e /proc/device-tree/model ]; then
	MODEL=$(tr -d '\0' </proc/device-tree/model)
fi
echo "hostname = $HOSTNAME"
echo "hosttype = $HOSTTYPE"
echo "ostype =   $OSTYPE"
echo "machtype = $MACHTYPE"


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
	echo "TODO: freebsd builder incomplete"
elif [[ "$OSTYPE" == "linux-android" ]]; then
	DIGITALKNOB="/data/data/com.termux/files/home/digitalknob"
else
    echo "UNKNOWN OS TYPE ($OSTYPE)"
fi

BRANCH="Development"
SDKMANAGER="$DIGITALKNOB/$BRANCH/3rdParty/android-sdk/cmdline-tools/latest/bin/sdkmanager"
yes | $SDKMANAGER --licenses
#$SDKMANAGER --licenses
 