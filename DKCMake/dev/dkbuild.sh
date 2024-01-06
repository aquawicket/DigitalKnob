#!/bin/bash

# Let's ask the use to type in what they want to build
# could be an app, library or anything with a DKMAKE.cmake file
# We whould also give the option to list targets as well


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
	echo "TODO: DIGITALKNOB NOT SET"
else
    echo "UNKNOWN OS TYPE ($OSTYPE)"
fi
DKPATH="$DIGITALKNOB/DK"
DKCMAKE="$DIGITALKNOB/Development/DKCMake"

sudo echo

# https://unix.stackexchange.com/a/293605
COLUMNS=1

echo " "
PS3='Please select an OS to build for: '
if [[ "$MODEL" == "Raspberry"* ]]; then
	options=("raspberry32" "Exit")
elif [[ "$OSTYPE" == "linux-gnu"* ]] && [[ "$HOSTTYPE" == "x86_64"* ]]; then
	options=("linux64" "Exit")
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
	options=("linux32" "Exit")
elif [[ "$OSTYPE" == "darwin"* ]] && [[ "$HOSTTYPE" == "x86_64"* ]]; then
	options=("mac64" "Exit")
else
	echo "UNKNOWN OS TYPE ($OSTYPE)"
	options=("Exit")
fi
select opt in "${options[@]}"
do
	case $opt in
		"linux32")
			echo "$opt"
			OS="linux32"
			break
			;;
		"linux64")
			echo "$opt"
			OS="linux64"
			break
			;;
		"mac64")
			echo "$opt"
			OS="mac64"
			break
			;;
		"raspberry32")
			echo "$opt"
			OS="raspberry32"
			break
			;;
		"Exit")
			echo "$opt"
			exit 0
			;;
		*) echo "invalid option $REPLY";;
	esac 
	REPLY=
done
	
echo Please type the name of the library, tool or app to build. Then press enter.
read input 
echo " "
echo "cmake -G "Unix Makefiles" -DDEBUG=ON -DRELEASE=ON -DSTATIC=ON -DREBUILDALL=ON -DTARGET=$input -DOS=$OS -S $DKCMAKE -B $DKCMAKE/temp"
echo " "
cmake -G "Unix Makefiles" -DDEBUG=ON -DRELEASE=ON -DSTATIC=ON -DREBUILDALL=ON -DHAVE_DKDuktape=1 -DTARGET=$input -DOS=$OS -S $DKCMAKE -B $DKCMAKE/temp

exec $SHELL #keep terminal open