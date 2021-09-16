#!/bin/bash

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
	#HOST_OS="linux"
	OS="linux64"
	DKPATH="/home/$USER/digitalknob/DK"
	sudo apt-get -y install git
	sudo apt-get -y install cmake
	sudo apt-get -y install gcc
	sudo apt-get -y install g++
elif [[ "$OSTYPE" == "darwin"* ]]; then
	#HOST_OS="mac"
	DKPATH="/Users/$USER/digitalknob/DK"
elif [[ "$OSTYPE" == "cygwin" ]]; then
    #HOST_OS="cygwin"
	echo "TODO: DKPATH NOT SET"
elif [[ "$OSTYPE" == "msys" ]]; then
    #HOST_OS="msys"
	echo "TODO: DKPATH NOT SET"
elif [[ "$OSTYPE" == "win32" ]]; then
    #HOST_OS="win32" #I'n not sure this can happen
	echo "TODO: DKPATH NOT SET"
elif [[ "$OSTYPE" == "freebsd"* ]]; then
    #HOST_OS="freebsd"
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
	mkdir $DKPATH/DKApps/$APP/$OS/Debug
	cd $DKPATH/DKApps/$APP/$OS/Debug
	cmake -G "Unix Makefiles" -DCMAKE_C_COMPILER="$GCC_PATH" -DCMAKE_CXX_COMPILER="$GPP_PATH" -DDEBUG=ON -DREBUILDALL=ON -DSTATIC=ON $DKPATH
	make $APP_$OSd
	chmod +x $DKPATH/DKApps/$APP/$OS/Debug/$APP_$OSd
	
	mkdir $DKPATH/DKApps/$APP/$OS/Release
	cd $DKPATH/DKApps/$APP/$OS/Release
	cmake -G "Unix Makefiles" -DCMAKE_C_COMPILER="$GCC_PATH" -DCMAKE_CXX_COMPILER="$GPP_PATH" -DRELEASE=ON -DREBUILDALL=ON -DSTATIC=ON $DKPATH
	make $APP_$OS
	chmod +x $DKPATH/DKApps/$APP/$OS/Release/$APP_$OS
else
    cd $DKPATH/DKApps/$APP/$OS
	cmake -G "Unix Makefiles" -DCMAKE_C_COMPILER="$GCC_PATH" -DCMAKE_CXX_COMPILER="$GPP_PATH" -DDEBUG=ON -DRELEASE=ON -DREBUILDALL=ON -DSTATIC=ON $DKPATH
	
	cd $DKPATH/DKApps/$APP/$OS/Debug
	make $APP_$OSd
	chmod +x $DKPATH/DKApps/$APP/$OS/Debug/$APP_$OSd
	
	cd $DKPATH/DKApps/$APP/$OS/Release
	make $APP_$OS
	chmod +x $DKPATH/DKApps/$APP/$OS/Release/$APP_$OS
fi

exec $SHELL #keep terminal open
