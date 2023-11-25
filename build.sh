#!/bin/bash

# to run this script requires privledges
# > chmod 777 build.sh

# If the current folder matches the current branch set BRANCH, default to Development
FOLDER="$(basename $(pwd))"
BRANCH="$(git rev-parse --abbrev-ref HEAD)"
if [[ "$BRANCH" == "$FOLDER" ]]; then
	BRANCH="$FOLDER"
else
	BRANCH="Development"
fi
echo "BRANCH = $BRANCH"


SUDO="sudo"
APT="apt-get"

if [ -e /proc/device-tree/model ]; then
	MODEL=$(tr -d '\0' </proc/device-tree/model)
fi

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
	SUDO=""
	APT="apt"
else
    echo "UNKNOWN OS ($OSTYPE)"
fi


DKPATH="$DIGITALKNOB/$BRANCH"
DKCMAKE="$DIGITALKNOB/$BRANCH/DKCMake"

echo "hostname		= $HOSTNAME"
echo "hosttype		= $HOSTTYPE"
echo "ostype		= $OSTYPE"
echo "machtype		= $MACHTYPE"
echo "model			= $MODEL"
echo "user			= $USER"
echo "username		= $USERNAME"
echo "digitalknob	= $DIGITALKNOB"
echo "dkpath		= $DKPATH"
echo "dkcmake		= $DKCMAKE"

$SUDO echo

# https://unix.stackexchange.com/a/293605
COLUMNS=1

while :
	do
	echo " "
	PS3='Please update and select an app to build: '
	options=("Git Update" "Git Commit" "DKCore" "DKJavascript" "DKBuilder" "DKSDL" "DKSDLRml" "DKDomTest" "DKTestAll" "Clear Screen" "Exit")
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
					$SUDO $APT -y install git
				fi
				
				
				if [[ ! -d "$DKPATH/.git" ]]; then
					git clone https://github.com/aquawicket/DigitalKnob.git $DKPATH
				fi
				cd $DKPATH
				git pull --all
				git checkout -- .
				git checkout $BRANCH
				if [[ "$?" == "0" ]]; then
					echo "$BRANCH branch selected"
				else
					echo "Remote has no $BRANCH branch. Creating..."
					git checkout -b $BRANCH main
					git push --set-upstream origin $BRANCH
				fi
								
				
				chmod +x $DKPATH/build.sh
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
					$SUDO $APT -y install git
				fi
				cd $DKPATH
				git commit -a -m "git commit"
				git push
				;;
			"DKCore")
				echo "$opt"
				APP="DKCore"
				break
				;;
			"DKJavascript")
				echo "$opt"
				APP="DKJavascript"
				break
				;;
			"DKBuilder")
				echo "$opt"
				APP="DKBuilder"
				break
				;;
			"DKSDL")
				echo "$opt"
				APP="DKSDL"
				break
				;;
			"DKSDLRml")
				echo "$opt"
				APP="DKSDLRml"
				break
				;;
			"DKDomTest")
				echo "$opt"
				APP="DKDomTest"
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
		options=("raspberry32" "android32" "android64" "emscripten" "Clear Screen" "Exit")
	elif [[ "$OSTYPE" == "linux-gnu"* ]] && [[ "$HOSTTYPE" == "x86_64"* ]]; then
		options=("linux64" "android32" "android64" "emscripten" "Clear Screen" "Exit")
	elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
		options=("linux32" "android32" "android64" "emscripten" "Clear Screen" "Exit")
	elif [[ "$OSTYPE" == "darwin"* ]] && [[ "$HOSTTYPE" == "x86_64"* ]]; then
		options=("mac64" "ios32" "ios64" "iossim32" "iossim64" "android32" "android64" "emscripten" "Clear Screen" "Exit")
	elif [[ "$OSTYPE" == "linux-android" ]]; then
		options=("android32" "android64" "Clear Screen" "Exit")
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
			"mac32")
				echo "$opt"
				OS="mac32"
				break
				;;
			"mac64")
				echo "$opt"
				OS="mac64"
				break
				;;
			"ios32")
				echo "$opt"
				OS="ios32"
				break
				;;
			"ios64")
				echo "$opt"
				OS="ios64"
				break
				;;
			"iossim32")
				echo "$opt"
				OS="iossim32"
				break
				;;
			"iossim64")
				echo "$opt"
				OS="iossim64"
				break
				;;
			"raspberry32")
				echo "$opt"
				OS="raspberry32"
				break
				;;
			"android32")
				echo "$opt"
				OS="android32"
				break
				;;
			"android64")
				echo "$opt"
				OS="android64"
				break
				;;
			"emscripten")
				echo "$opt"
				OS="emscripten"
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
	PS3='Please select build type: '
	options=("Debug" "Release" "All" "Clear Screen" "Exit")
	select opt in "${options[@]}"
	do
		case $opt in
			"Debug")
				echo "$opt"
				TYPE="Debug"
				break
				;;
			"Release")
				echo "$opt"
				TYPE="Release"
				break
				;;
			"All")
				echo "$opt"
				TYPE="All"
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
	
	cd $DIGITALKNOB
	echo Deleteing CMake cache . . .
	find . -name "CMakeCache.*" -delete
	rm -rf `find . -type d -name CMakeFiles`
	
	echo Deleteing .tmp files . . .
	find . -name "*.tmp" -delete
	find . -name "*.TMP" -delete
		
	if [[ "$OSTYPE" == "darwin"* ]]; then	# Apple
		#CLANG_PATH=$(which clang)
		#CLANGPP_PATH=$(which clang++)
		#export CC="$CLANG_PATH"
		#export CXX="$CLANGPP_PATH"
		#echo "CLANG_PATH = $CLANG_PATH"
		#echo "CLANGPP_PATH = $CLANGPP_PATH"
		#brew install cmake		
		mkdir $DKPATH/DKApps/$APP/$OS
		cd $DKPATH/DKApps/$APP/$OS
		
		if [[ "$OS" == "mac32" ]]; then
			cmake -G "Xcode" -DMAC_32=ON -DCMAKE_OSX_ARCHITECTURES=i686 -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DSTATIC=ON $DKCMAKE
		fi
		if [[ "$OS" == "mac64" ]]; then
			cmake -G "Xcode" -DMAC_64=ON -DCMAKE_OSX_ARCHITECTURES=x86_64 -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DSTATIC=ON $DKCMAKE
		fi
		if [[ "$OS" == "ios32" ]]; then
			cmake -G "Xcode" -DCMAKE_TOOLCHAIN_FILE=$DKCMAKE/ios.toolchain.cmake -DPLATFORM=OS -DSDK_VERSION=15.0 -DDEPLOYMENT_TARGET=13.0 -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DSTATIC=ON -S$DKCMAKE -B$DKPATH/DKApps/$APP/$OS
		fi
		if [[ "$OS" == "ios64" ]]; then
			cmake -G "Xcode" -DCMAKE_TOOLCHAIN_FILE=$DKCMAKE/ios.toolchain.cmake -DPLATFORM=OS64 -DSDK_VERSION=15.0 -DDEPLOYMENT_TARGET=13.0 -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DSTATIC=ON -S$DKCMAKE -B$DKPATH/DKApps/$APP/$OS
		fi
		if [[ "$OS" == "iossim32" ]]; then
			cmake -G "Xcode" -DCMAKE_TOOLCHAIN_FILE=$DKCMAKE/ios.toolchain.cmake -DPLATFORM=SIMULATOR -DSDK_VERSION=15.0 -DDEPLOYMENT_TARGET=13.0 -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DSTATIC=ON -S$DKCMAKE -B$DKPATH/DKApps/$APP/$OS
		fi
		if [[ "$OS" == "iossim64" ]]; then
			cmake -G "Xcode" -DCMAKE_TOOLCHAIN_FILE=$DKCMAKE/ios.toolchain.cmake -DPLATFORM=SIMULATOR64 -DSDK_VERSION=15.0 -DDEPLOYMENT_TARGET=13.0 -DDEBUG=ON -DRELEASE=ON -DREBUILD=ON -DSTATIC=ON -S$DKCMAKE -B$DKPATH/DKApps/$APP/$OS
		fi
		if [[ "$OS" == "android32" ]]; then
			ANDROID_API="31"
			ANDROID_NDK_BUILD="23.1.7779620"
			ANDROID_NDK="$DKPATH/3rdParty/android-sdk/ndk/$ANDROID_NDK_BUILD"
			cmake -G "Unix Makefiles" -DANDROID_ABI=armeabi-v7a -DANDROID_PLATFORM=$ANDROID_API -DANDROID-NDK=$ANDROID_NDK -DCMAKE_TOOLCHAIN_FILE=$ANDROID_NDK/build/cmake/android.toolchain.cmake -DANDROID_TOOLCHAIN=clang -DANDROID_STL=c++_static -DCMAKE_CXX_FLAGS="-std=c++1z -frtti -fexceptions" -DCMAKE_ANDROID_STL_TYPE=c++_static -DRELEASE=OFF -DDEBUG=ON -DREBUILDALL=ON -DSTATIC=ON -S$DKCMAKE -B$DKPATH/DKApps/$APP/$OS/Debug
			TARGET="main"
		fi
		if [[ "$OS" == "android64" ]]; then
			ANDROID_API="31"
			ANDROID_NDK_BUILD="23.1.7779620"
			ANDROID_NDK="$DKPATH/3rdParty/android-sdk/ndk/$ANDROID_NDK_BUILD"
			cmake -G "Unix Makefiles" -DANDROID_ABI=arm64-v8a -DANDROID_PLATFORM=$ANDROID_API -DANDROID-NDK=$ANDROID_NDK -DCMAKE_TOOLCHAIN_FILE=$ANDROID_NDK/build/cmake/android.toolchain.cmake -DANDROID_TOOLCHAIN=clang -DANDROID_STL=c++_static -DCMAKE_CXX_FLAGS="-std=c++1z -frtti -fexceptions" -DCMAKE_ANDROID_STL_TYPE=c++_static -DRELEASE=OFF -DDEBUG=ON -DREBUILDALL=ON -DSTATIC=ON -S$DKCMAKE -B$DKPATH/DKApps/$APP/$OS/Debug
			TARGET="main"
		fi
		if [[ "$OS" == "emscipten" ]]; then
			echo -e "emscripten incomplete...\n"
		fi
		
		if [[ "$TYPE" == "Debug" ]] || [[ "$TYPE" == "All" ]]; then
			#xcodebuild -configuration Debug build
			cmake --build $DKPATH/DKApps/$APP/$OS --target ${APP}_APP --config Debug
		fi
		
		if [[ "$TYPE" == "Release" ]] || [[ "$TYPE" == "All" ]]; then
			#xcodebuild -configuration Release build
			cmake --build $DKPATH/DKApps/$APP/$OS --target ${APP}_APP --config Debug
		fi
	else	# Linux, Raspberry Pi, Android
		$SUDO $APT -y install cmake
		$SUDO $APT -y install gcc
		$SUDO $APT -y install g++
		$SUDO $APT -y install which
		GCC_PATH=$(which gcc)
		GPP_PATH=$(which g++)
		export CC="$GCC_PATH"
		export CXX="$GPP_PATH"
		echo "GCC_PATH = $GCC_PATH"
		echo "GPP_PATH = $GPP_PATH"

		mkdir $DKPATH/DKApps/$APP/$OS
		
		if [[ "$TYPE" == "Debug" ]] || [[ "$TYPE" == "All" ]]; then
			mkdir $DKPATH/DKApps/$APP/$OS/Debug
			cd $DKPATH/DKApps/$APP/$OS/Debug
			
			if [[ "$OS" == "android32" ]]; then
				ANDROID_API="31"
				ANDROID_NDK_BUILD="23.1.7779620"
				ANDROID_NDK="$DKPATH/3rdParty/android-sdk/ndk/$ANDROID_NDK_BUILD"
				cmake -G "Unix Makefiles" -DANDROID_ABI=armeabi-v7a -DANDROID_PLATFORM=$ANDROID_API -DANDROID-NDK=$ANDROID_NDK -DCMAKE_TOOLCHAIN_FILE=$ANDROID_NDK/build/cmake/android.toolchain.cmake -DANDROID_TOOLCHAIN=clang -DANDROID_STL=c++_static -DCMAKE_CXX_FLAGS="-std=c++1z -frtti -fexceptions" -DCMAKE_ANDROID_STL_TYPE=c++_static -DRELEASE=OFF -DDEBUG=ON -DREBUILDALL=ON -DSTATIC=ON -S$DKCMAKE -B$DKPATH/DKApps/$APP/$OS/Debug
				TARGET="main"
			fi
			if [[ "$OS" == "android64" ]]; then
				ANDROID_API="31"
				ANDROID_NDK_BUILD="23.1.7779620"
				ANDROID_NDK="$DKPATH/3rdParty/android-sdk/ndk/$ANDROID_NDK_BUILD"
				cmake -G "Unix Makefiles" -DANDROID_ABI=arm64-v8a -DANDROID_PLATFORM=$ANDROID_API -DANDROID-NDK=$ANDROID_NDK -DCMAKE_TOOLCHAIN_FILE=$ANDROID_NDK/build/cmake/android.toolchain.cmake -DANDROID_TOOLCHAIN=clang -DANDROID_STL=c++_static -DCMAKE_CXX_FLAGS="-std=c++1z -frtti -fexceptions" -DCMAKE_ANDROID_STL_TYPE=c++_static -DRELEASE=OFF -DDEBUG=ON -DREBUILDALL=ON -DSTATIC=ON -S$DKCMAKE -B$DKPATH/DKApps/$APP/$OS/Debug
				TARGET="main"
			fi
			if [[ "$OS" == "linux32" ]]; then
				cmake -G "Unix Makefiles" -DCMAKE_C_COMPILER="$GCC_PATH" -DCMAKE_CXX_COMPILER="$GPP_PATH" -DRELEASE=OFF -DDEBUG=ON -DREBUILDALL=ON -DSTATIC=ON $DKCMAKE
				TARGET=${APP}_APP
			fi
			if [[ "$OS" == "linux64" ]]; then
				cmake -G "Unix Makefiles" -DCMAKE_C_COMPILER="$GCC_PATH" -DCMAKE_CXX_COMPILER="$GPP_PATH" -DRELEASE=OFF -DDEBUG=ON -DREBUILDALL=ON -DSTATIC=ON $DKCMAKE
				TARGET=${APP}_APP
			fi
			if [[ "$OS" == "raspberry32" ]]; then
				cmake -G "Unix Makefiles" -DCMAKE_C_COMPILER="$GCC_PATH" -DCMAKE_CXX_COMPILER="$GPP_PATH" -DRELEASE=OFF -DDEBUG=ON -DREBUILDALL=ON -DSTATIC=ON $DKCMAKE
				TARGET=${APP}_APP
			fi
			if [[ "$OS" == "raspberry64" ]]; then
				cmake -G "Unix Makefiles" -DCMAKE_C_COMPILER="$GCC_PATH" -DCMAKE_CXX_COMPILER="$GPP_PATH" -DRELEASE=OFF -DDEBUG=ON -DREBUILDALL=ON -DSTATIC=ON $DKCMAKE
				TARGET=${APP}_APP
			fi
			if [[ "$OS" == "emscipten" ]]; then
				echo -e "emscripten incomplete...\n"
			fi

			cmake --build $DKPATH/DKApps/$APP/$OS/Debug --target ${TARGET} --config Debug
			#chmod +x $DKPATH/DKApps/$APP/$OS/Debug/${TARGET}
		fi
		
		if [[ "$TYPE" == "Release" ]] || [[ "$TYPE" == "All" ]]; then
			mkdir $DKPATH/DKApps/$APP/$OS/Release
			cd $DKPATH/DKApps/$APP/$OS/Release
			
			if [[ "$OS" == "android32" ]]; then
				ANDROID_API="31"
				ANDROID_NDK_BUILD="23.1.7779620"
				ANDROID_NDK="$DKPATH/3rdParty/android-sdk/ndk/$ANDROID_NDK_BUILD"
				cmake -G "Unix Makefiles" -DANDROID_ABI=armeabi-v7a -DANDROID_PLATFORM=$ANDROID_API -DANDROID-NDK=$ANDROID_NDK -DCMAKE_TOOLCHAIN_FILE=$ANDROID_NDK/build/cmake/android.toolchain.cmake -DANDROID_TOOLCHAIN=clang -DANDROID_STL=c++_static -DCMAKE_CXX_FLAGS="-std=c++1z -frtti -fexceptions" -DCMAKE_ANDROID_STL_TYPE=c++_static -DRELEASE=ON -DDEBUG=OFF -DREBUILDALL=ON -DSTATIC=ON -S$DKCMAKE -B$DKPATH/DKApps/$APP/$OS/Release
				TARGET="main"
			fi
			if [[ "$OS" == "android64" ]]; then
				ANDROID_API="31"
				ANDROID_NDK_BUILD="23.1.7779620"
				ANDROID_NDK="$DKPATH/3rdParty/android-sdk/ndk/$ANDROID_NDK_BUILD"
				cmake -G "Unix Makefiles" -DANDROID_ABI=arm64-v8a -DANDROID_PLATFORM=$ANDROID_API -DANDROID-NDK=$ANDROID_NDK -DCMAKE_TOOLCHAIN_FILE=$ANDROID_NDK/build/cmake/android.toolchain.cmake -DANDROID_TOOLCHAIN=clang -DANDROID_STL=c++_static -DCMAKE_CXX_FLAGS="-std=c++1z -frtti -fexceptions" -DCMAKE_ANDROID_STL_TYPE=c++_static -DRELEASE=ON -DDEBUG=OFF -DREBUILDALL=ON -DSTATIC=ON -S$DKCMAKE -B$DKPATH/DKApps/$APP/$OS/Release
				TARGET="main"
			fi
			if [[ "$OS" == "linux32" ]]; then
				cmake -G "Unix Makefiles" -DCMAKE_C_COMPILER="$GCC_PATH" -DCMAKE_CXX_COMPILER="$GPP_PATH" -DRELEASE=ON -DDEBUG=OFF -DREBUILDALL=ON -DSTATIC=ON $DKCMAKE
				TARGET=${APP}_APP
			fi
			if [[ "$OS" == "linux64" ]]; then
				cmake -G "Unix Makefiles" -DCMAKE_C_COMPILER="$GCC_PATH" -DCMAKE_CXX_COMPILER="$GPP_PATH" -DRELEASE=ON -DDEBUG=OFF -DREBUILDALL=ON -DSTATIC=ON $DKCMAKE
				TARGET=${APP}_APP
			fi
			if [[ "$OS" == "raspberry32" ]]; then
				cmake -G "Unix Makefiles" -DCMAKE_C_COMPILER="$GCC_PATH" -DCMAKE_CXX_COMPILER="$GPP_PATH" -DRELEASE=ON -DDEBUG=OFF -DREBUILDALL=ON -DSTATIC=ON $DKCMAKE
				TARGET=${APP}_APP
			fi
			if [[ "$OS" == "raspberry64" ]]; then
				cmake -G "Unix Makefiles" -DCMAKE_C_COMPILER="$GCC_PATH" -DCMAKE_CXX_COMPILER="$GPP_PATH" -DRELEASE=ON -DDEBUG=OFF -DREBUILDALL=ON -DSTATIC=ON $DKCMAKE
				TARGET=${APP}_APP
			fi
			if [[ "$OS" == "emscipten" ]]; then
				echo -e "emscripten incomplete...\n"
			fi
			
			cmake --build $DKPATH/DKApps/$APP/$OS/Release --target ${TARGET} --config Release
			#chmod +x $DKPATH/DKApps/$APP/$OS/Release/${TARGET}
		fi
	fi

	$ echo "******* Done building $APP - $OS - $TYPE *******"	
	
    unset APP
	unset OS
	unset TYPE
done


exec $SHELL		# keep terminal open
