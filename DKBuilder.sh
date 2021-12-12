#!/bin/bash

if [ -e /proc/device-tree/model ]; then
MODEL=$(tr -d '\0' </proc/device-tree/model)
fi
if [[ "$MODEL" == "Raspberry"* ]]; then
	echo "The Host is a Raspberry Pi"
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
DKCMAKE="$DIGITALKNOB/DK/DKCMake"

sudo echo

# https://unix.stackexchange.com/a/293605
COLUMNS=1

while :
	do
	echo " "
	PS3='Please update and select an app to build: '
	options=("Git Update" "Git Commit" "DKBuilder" "DKSDLRmlUi" "DKTestAll" "Clear Screen" "Exit")
	select opt in "${options[@]}"
	do
		case $opt in
			"Git Update")
				echo "$opt"
				if [[ "$OSTYPE" == "darwin"* ]]; then
					echo "install Homebrew and git"
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
				;;
			"Git Commit")
				echo "$opt"
				if [[ "$OSTYPE" == "darwin"* ]]; then
					echo "install Homebrew and git"
					#ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
					# https://github.com/Homebrew/brew/issues/10368
					# rm -fr $(brew --repo homebrew/core)
					# brew tap homebrew/core
					# brew install git
				else
					sudo apt-get -y install git
				fi
				cd $DKPATH
				git commit -a -m "git commit"
				git push
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
			"Clear Screen")
				echo "$opt"
				clear
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
	if [[ "$OSTYPE" == "linux-gnu"* ]]; then
		options=("linux32" "linux64" "raspberry32" "Exit")
	elif [[ "$OSTYPE" == "darwin"* ]]; then
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

	cd $DIGITALKNOB
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
		cmake -G "Xcode" -DMAC_64=ON -DCMAKE_OSX_ARCHITECTURES=x86_64 -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DSTATIC=ON $DKCMAKE
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
		
		mkdir $DKPATH/DKApps/$APP/$OS
		mkdir $DKPATH/DKApps/$APP/$OS/Debug
		cd $DKPATH/DKApps/$APP/$OS/Debug
		cmake -G "Unix Makefiles" -DCMAKE_C_COMPILER="$GCC_PATH" -DCMAKE_CXX_COMPILER="$GPP_PATH" -DDEBUG=ON -DREBUILDALL=ON -DSTATIC=ON $DKCMAKE
		make $APP
		chmod +x $DKPATH/DKApps/$APP/$OS/Debug/$APP
		
		mkdir $DKPATH/DKApps/$APP/$OS/Release
		cd $DKPATH/DKApps/$APP/$OS/Release
		cmake -G "Unix Makefiles" -DCMAKE_C_COMPILER="$GCC_PATH" -DCMAKE_CXX_COMPILER="$GPP_PATH" -DRELEASE=ON -DREBUILDALL=ON -DSTATIC=ON $DKCMAKE
		make $APP
		chmod +x $DKPATH/DKApps/$APP/$OS/Release/$APP
	fi

    unset APP
	unset OS
done


exec $SHELL #keep terminal open
