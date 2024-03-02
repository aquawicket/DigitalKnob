#!/bin/bash

if [ -e /proc/device-tree/model ]; then
	MODEL=$(tr -d '\0' </proc/device-tree/model)
fi
echo "hostname = $HOSTNAME"
echo "hosttype = $HOSTTYPE"
echo "ostype =   $OSTYPE"
echo "machtype = $MACHTYPE"


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

BRANCH="Development"
SDKMANAGER="$DIGITALKNOB_DIR/$BRANCH/3rdParty/android-sdk/cmdline-tools/latest/bin/sdkmanager"
yes | $SDKMANAGER --licenses
#$SDKMANAGER --licenses
 