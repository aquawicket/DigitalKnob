: << '____CMD____'
@echo off
bash "%~f0" %*
goto :EOF
____CMD____
#!/bin/bash

# to run this script requires privledges 
# > chmod +x build.sh

if [ -e /proc/device-tree/model ]; then
	MODEL=$(tr -d '\0' </proc/device-tree/model)
fi
echo "hostname = $HOSTNAME"
echo "hosttype = $HOSTTYPE"
echo "ostype =   $OSTYPE"
echo "machtype = $MACHTYPE"


if [[ "$OSTYPE" == "linux-gnu"* ]]; then
	DIGITALKNOB_DIR="/home/$USER/digitalknob"
elif [[ "$OSTYPE" == "darwin"* ]]; then
	DIGITALKNOB_DIR="/Users/$USER/digitalknob"
elif [[ "$OSTYPE" == "cygwin" ]]; then
	DIGITALKNOB_DIR="C:/Users/$USERNAME/digitalknob"
elif [[ "$OSTYPE" == "msys" ]]; then
	DIGITALKNOB_DIR="C:/Users/$USERNAME/digitalknob"
elif [[ "$OSTYPE" == "win32" ]]; then #I'm not sure this can happen
	DIGITALKNOB_DIR="C:/Users/$USERNAME/digitalknob" 
elif [[ "$OSTYPE" == "freebsd"* ]]; then
	echo "TODO: DIGITALKNOB_DIR NOT SET"
else
    echo "UNKNOWN OS TYPE ($OSTYPE)"
fi
DKBRANCH="Development"
DKBRANCH_DIR="$DIGITALKNOB_DIR/$DKBRANCH"
DKCMAKE_DIR="$DKBRANCH_DIR/DKCMake"
DKAPPS_DIR="$DKBRANCH_DIR/DKApps"

sudo echo

# https://unix.stackexchange.com/a/293605
COLUMNS=1

while :
	do
	echo " "
	PS3='Please update and select an app to build: '
	options=("Git Update" "Git Commit" "DKBuilder" "DKSdlRmlUi" "DKTestAll" "Clear Screen" "Exit")
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
				if [[ ! -d "$DKBRANCH_DIR/.git" ]]; then
					git clone https://github.com/aquawicket/DigitalKnob.git $DKBRANCH_DIR
				fi
				cd $DKBRANCH_DIR
				
				#git checkout -- .
				#git pull origin master
				
				git checkout Development
				git pull
				
				chmod +x $DKBRANCH_DIR/build.sh
				chmod +x $DKCMAKE_DIR/dkbuild.sh
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
				cd $DKBRANCH_DIR
				git commit -a -m "git commit"
				git push
				;;
			"DKBuilder")
				echo "$opt"
				APP="DKBuilder"
				break
				;;
			"DKSdlRmlUi")
				echo "$opt"
				APP="DKSdlRmlUi"
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
	if [[ "$MODEL" == "Raspberry"* ]]; then
		options=("raspberry_arm32" "Exit")
	elif [[ "$OSTYPE" == "linux-gnu"* ]] && [[ "$HOSTTYPE" == "x86_64"* ]]; then
		options=("linux_x86_64" "Exit")
	elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
		options=("linux_x86" "Exit")
	elif [[ "$OSTYPE" == "darwin"* ]] && [[ "$HOSTTYPE" == "x86_64"* ]]; then
		options=("mac_x86_64" "Exit")
	else
		echo "UNKNOWN OS TYPE ($OSTYPE)"
		options=("Exit")
	fi
	select opt in "${options[@]}"
	do
		case $opt in
			"linux_x86")
				echo "$opt"
				OS="linux_x86"
				break
				;;
			"linux_x86_64")
				echo "$opt"
				OS="linux_x86_64"
				break
				;;
			"mac_x86_64")
				echo "$opt"
				OS="mac_x86_64"
				break
				;;
			"raspberry_arm32")
				echo "$opt"
				OS="raspberry_arm32"
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

	cd $DIGITALKNOB_DIR
	echo Deleteing CMake cache . . .
	find . -name "CMakeCache.*" -delete
	rm -rf `find . -type d -name CMakeFiles`
	
	echo Deleteing .tmp files . . .
	find . -name "*.tmp" -delete
	find . -name "*.TMP" -delete
		
	if [[ "$OSTYPE" == "darwin"* ]]; then
		#CLANG_PATH=$(which clang)
		#CLANGPP_PATH=$(which clang++)
		#export CC="$CLANG_PATH"
		#export CXX="$CLANGPP_PATH"
		#echo "CLANG_PATH = $CLANG_PATH"
		#echo "CLANGPP_PATH = $CLANGPP_PATH"
		#brew install cmake		
		mkdir $DKAPPS_DIR/$APP/$OS
		cd $DKAPPS_DIR/$APP/$OS
		cmake -G "Xcode" -DMAC_X86_64=ON -DCMAKE_OSX_ARCHITECTURES=x86_64 -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DSTATIC=ON $DKCMAKE_DIR
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
		
		mkdir $DKAPPS_DIR/$APP/$OS
		mkdir $DKAPPS_DIR/$APP/$OS/Debug
		cd $DKAPPS_DIR/$APP/$OS/Debug
		cmake -G "Unix Makefiles" -DCMAKE_C_COMPILER="$GCC_PATH" -DCMAKE_CXX_COMPILER="$GPP_PATH" -DDEBUG=ON -DREBUILDALL=ON -DSTATIC=ON $DKCMAKE_DIR
		make $APP
		chmod +x $DKAPPS_DIR/$APP/$OS/Debug/$APP
		
		mkdir $DKAPPS_DIR/$APP/$OS/Release
		cd $DKAPPS_DIR/$APP/$OS/Release
		cmake -G "Unix Makefiles" -DCMAKE_C_COMPILER="$GCC_PATH" -DCMAKE_CXX_COMPILER="$GPP_PATH" -DRELEASE=ON -DREBUILDALL=ON -DSTATIC=ON $DKCMAKE_DIR
		make $APP
		chmod +x $DKAPPS_DIR/$APP/$OS/Release/$APP
	fi

    unset APP
	unset OS
done


exec $SHELL #keep terminal open
