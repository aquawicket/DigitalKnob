#!/bin/bash

echo "hostname = $HOSTNAME"
echo "hosttype = $HOSTTYPE"
echo "ostype = $OSTYPE"
echo "machtype = $MACHTYPE"

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
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

sudo echo

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
				if [[ "$OSTYPE" == "darwin"* ]]; then
					#ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
					# https://github.com/Homebrew/brew/issues/10368
					# rm -fr $(brew --repo homebrew/core)
					# brew tap homebrew/core
					# brew install git	
				else
					sudo apt-get -y install git
				fi
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
	echo Deleteing CMake cache . . .
	find . -name "CMakeCache.*" -delete
	rm -rf `find . -type d -name CMakeFiles`
		
	if [[ "$OSTYPE" == "darwin"* ]]; then
		#CLANG_PATH=$(which clang)
		#CLANGPP_PATH=$(which clang++)
		#export CC="$CLANG_PATH"
		#export CXX="$CLANGPP_PATH"
		#echo "CLANG_PATH = $CLANG_PATH"
		#echo "CLANGPP_PATH = $CLANGPP_PATH"
		#brew install cmake		
		mkdir $DKPATH/DKApps/$APP/$OS
		cd $DKPATH/DKApps/$APP/$OS
		cmake -G "Xcode" -DMAC_64=ON -DCMAKE_OSX_ARCHITECTURES=x86_64 -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DSTATIC=ON $DKPATH
		xcodebuild -configuration Debug build
		xcodebuild -configuration Release build
	else #Linux, Raspberry Pi
		GCC_PATH=$(which gcc)
		GPP_PATH=$(which g++)
		export CC="$GCC_PATH"
		export CXX="$GPP_PATH"
		echo "GCC_PATH = $GCC_PATH"
		echo "GPP_PATH = $GPP_PATH"
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
	fi

    unset APP
	unset OS
done


exec $SHELL #keep terminal open
