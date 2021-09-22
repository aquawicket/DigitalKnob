#!/bin/bash

echo "hostname = $HOSTNAME"
echo "hosttype = $HOSTTYPE"
echo "ostype = $OSTYPE"
echo "machtype = $MACHTYPE"

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
	sudo echo
	DKPATH="/home/$USER/digitalknob/DK"
elif [[ "$OSTYPE" == "darwin"* ]]; then
	DKPATH="/Users/$USER/digitalknob/DK"
elif [[ "$OSTYPE" == "cygwin" ]]; then
	echo "TODO: DKPATH NOT SET"
elif [[ "$OSTYPE" == "msys" ]]; then
	echo "TODO: DKPATH NOT SET"
elif [[ "$OSTYPE" == "win32" ]]; then
	echo "TODO: DKPATH NOT SET" #I'm not sure this can happen
elif [[ "$OSTYPE" == "freebsd"* ]]; then
	echo "TODO: DKPATH NOT SET"
else
    echo "UNKNOWN OS TYPE ($OSTYPE)"
fi

APP="DKBuilder"
#TYPE="Release"

GCC_PATH=$(which gcc)
GPP_PATH=$(which g++)
export CC="$GCC_PATH"
export CXX="$GPP_PATH"


while :
	do
	echo " "
	PS3='Please update and select an app to build: '
	options=("Git Update" "DKBuilder" "DKSDLRmlUi" "DKTestAll" "Exit")
	select opt in "${options[@]}"
	do
		case $opt in
			"Git Update")
				echo "$opt"
				git clone https://github.com/aquawicket/DigitalKnob.git $DKPATH
				cd $DKPATH
				git checkout -- .
				git pull origin master
				chmod +x $DKPATH/DKBuilder.sh
				echo "${options[@]}"
				;;
			"DKBuilder")
				echo "$opt"
				APP="DKBuilder"
				break
				;;
			"DKSDLRmlUi")
				echo "$opt"
				APP="DKSDLRmlUi"
				break
				;;
			"DKTestAll")
				echo "$opt"
			APP="DKTestAll"
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

	echo " "
	PS3='Please select an OS to build for: '
	options=("linux32" "linux64" "mac64" "raspberry32" "Exit")
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

	cd $DKPATH
	echo Deleteing all CMakeCache.txt files....
	find . -name "CMakeCache.*" -delete
	rm -rf `find . -type d -name CMakeFiles`
		
	mkdir $DKPATH/DKApps/$APP/$OS
	if [[ "$OSTYPE" == "linux-gnu"* ]]; then
		DKPATH="/home/$USER/digitalknob/DK"
		sudo apt-get -y install git
		sudo apt-get -y install cmake
		sudo apt-get -y install gcc
		sudo apt-get -y install g++
		
		mkdir $DKPATH/DKApps/$APP/$OS/Debug
		cd $DKPATH/DKApps/$APP/$OS/Debug
		cmake -G "Unix Makefiles" -DCMAKE_C_COMPILER="$GCC_PATH" -DCMAKE_CXX_COMPILER="$GPP_PATH" -DDEBUG=ON -DREBUILDALL=ON -DSTATIC=ON $DKPATH
		make $APP
		chmod +x $DKPATH/DKApps/$APP/$OS/Debug/$APP
		
		mkdir $DKPATH/DKApps/$APP/$OS/Release
		cd $DKPATH/DKApps/$APP/$OS/Release
		cmake -G "Unix Makefiles" -DCMAKE_C_COMPILER="$GCC_PATH" -DCMAKE_CXX_COMPILER="$GPP_PATH" -DRELEASE=ON -DREBUILDALL=ON -DSTATIC=ON $DKPATH
		make ${APP}
		chmod +x $DKPATH/DKApps/$APP/$OS/Release/${APP}
	else
    cd $DKPATH/DKApps/$APP/$OS
	cmake -G "Unix Makefiles" -DCMAKE_C_COMPILER="$GCC_PATH" -DCMAKE_CXX_COMPILER="$GPP_PATH" -DDEBUG=ON -DRELEASE=ON -DREBUILDALL=ON -DSTATIC=ON $DKPATH
	
	cd $DKPATH/DKApps/$APP/$OS/Debug
	make $APP
	chmod +x $DKPATH/DKApps/$APP/$OS/Debug/$APP
	
	cd $DKPATH/DKApps/$APP/$OS/Release
	make ${APP}
	chmod +x $DKPATH/DKApps/$APP/$OS/Release/${APP}
	fi

    unset APP
	unset OS
done


exec $SHELL #keep terminal open
