#!/bin/bash

# to run this script requires privledges
# > chmod 777 build.sh


###### validate_branch ######
validate_branch() {
	# If the current folder matches the current branch set DKBRANCH, default to Development
	FOLDER="$(basename $(pwd))"
	DKBRANCH="$(git rev-parse --abbrev-ref HEAD)"
	if [[ "$DKBRANCH" == "$FOLDER" ]]; then
		DKBRANCH="$FOLDER"
	else
		DKBRANCH="Development"
	fi
	echo "DKBRANCH = $DKBRANCH"
}
validate_branch

###### command_exists <command> ######
command_exists() {
	command -v "$1" >/dev/null 2>&1
}

###### file_exists <file> ######
file_exists() {
	[ -e $1 ]
}

###### install <package> ######
install() {
	echo "installing $1"
	if command_exists apt; then
		$SUDO apt -y install $1
	elif command_exists apt-get; then
		$SUDO apt-get -y install $1
	elif command_exists pkg; then
		$SUDO pkg install $1
	elif command_exists pacman; then
		$SUDO pacman -S $1
	elif command_exists brew; then
		$SUDO brew install $1
	else
		echo "ERROR: no package managers found"
	fi
}

### validate_package <command> <package> ###
validate_package() {
	if ! command_exists $1; then
		install $2
	fi
}

### clear_cmake_cache ###
clear_cmake_cache() {
	echo "Clearing CMake cache . . ."
	cd $DIGITALKNOB
	find . -name "CMakeCache.*" -delete
	rm -rf `find . -type d -name CMakeFiles`
}

### delete_temp_files ###
delete_temp_files() {
	echo "Deleting .TMP files . . ."
	cd $DIGITALKNOB
	rm -rf `find . -type d -name *.tmp`
	rm -rf `find . -type d -name *.TMP`
	find . -name "*.tmp" -delete
	find . -name "*.TMP" -delete
}

### validate_ostype ###
validate_ostype() {
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
	else
		echo "UNKNOWN OS ($OSTYPE)"
	fi
}
validate_ostype

# validata sudo
if command_exists sudo; then
	SUDO="sudo"
fi

DKPATH="$DIGITALKNOB/$DKBRANCH"
DKCMAKE="$DIGITALKNOB/$DKBRANCH/DKCMake"

echo "hostname = $HOSTNAME"
echo "hosttype = $HOSTTYPE"
echo "ostype = $OSTYPE"
echo "machtype = $MACHTYPE"
echo "model = $MODEL"
echo "user = $USER"
echo "username = $USERNAME"
echo "digitalknob = $DIGITALKNOB"
echo "dkpath = $DKPATH"
echo "dkcmake = $DKCMAKE"

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
				  validate_package git git
				fi
				
				if [[ ! -d "$DKPATH/.git" ]]; then
					git clone https://github.com/aquawicket/DigitalKnob.git $DKPATH
				fi
				cd $DKPATH
				git pull --all
				git checkout -- .
				git checkout $DKBRANCH
				if [[ "$?" == "0" ]]; then
					echo "$DKBRANCH branch selected"
				else
					echo "Remote has no $DKBRANCH branch. Creating..."
					git checkout -b $DKBRANCH main
					git push --set-upstream origin $DKBRANCH
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
					validate_package git git
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
	elif [[ "$OSTYPE" == "msys" ]]; then
		options=("win32" "win64" "android32" "android64" "Clear Screen" "Exit")
	else
		echo "UNKNOWN OS TYPE ($OSTYPE)"
		options=("Exit")
	fi
	select opt in "${options[@]}"
	do
		case $opt in
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
			"raspberry32")
				echo "$opt"
				OS="raspberry32"
				break
				;;
			"win32")
				echo "$opt"
				OS="win32"
				break
				;;
			"win64")
				echo "$opt"
				OS="win64"
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
	
	clear_cmake_cache
	delete_temp_files
		
	validate_package which which
	if [[ "$OSTYPE" == "msys" ]]; then
		validate_package cmake mingw-w64-x86_64-cmake
	else
		validate_package cmake cmake
	fi
	validate_package gcc gcc
	validate_package g++ g++

	#GCC_PATH=$(which gcc)
	#GPP_PATH=$(which g++)
	#export CC="$GCC_PATH"
	#export CXX="$GPP_PATH"
	#echo "GCC_PATH = $GCC_PATH"
	#echo "GPP_PATH = $GPP_PATH"
	
	#CLANG_PATH=$(which clang)
	#CLANGPP_PATH=$(which clang++)
	#export CC="$CLANG_PATH"
	#export CXX="$CLANGPP_PATH"
	#echo "CLANG_PATH = $CLANG_PATH"
	#echo "CLANGPP_PATH = $CLANGPP_PATH"
	
	LEVEL="RebuildAll"
	LINK="Static"
	
	### Create the cmake string
	cmake_string=""
	if [[ $TYPE == "Debug" ]] || [[ $TYPE == "All" ]]; then
		cmake_string+="-DDEBUG=ON "
	fi
	if [[ $TYPE == "Release" ]] || [[ $TYPE == "All" ]]; then
		cmake_string+="-DRELEASE=ON "
	fi
	if [[ $LEVEL == "Build" ]]; then
		cmake_string+="-DBUILD=ON "
	fi
	if [[ $LEVEL == "Rebuild" ]]; then
		cmake_string+="-DREBUILD=ON "
	fi
	if [[ $LEVEL == "RebuildAll" ]]; then
		cmake_string+="-DREBUILDALL=ON "
	fi
	if [[ $LINK == "Static" ]]; then
		cmake_string+="-DSTATIC=ON "
	fi
	if [[ $LINK == "Shared" ]]; then
		cmake_string+="-DSHARED=ON "
	fi
	#cmake_string = cmake_string.replace("  "," ")
	#const app_path = DKBuild_FindAppPath(APP)
	
	echo cmake_string = $cmake_string
	
		
	############  GENERATE PROJECT ############ 
	echo Generating OS=$OS APP=$APP TYPE=$TYPE LEVEL=$LEVEL
	
	mkdir $DKPATH/DKApps/$APP/$OS
	cd /
	
	if [[ "$TYPE" == "Debug" ]] || [[ "$TYPE" == "All" ]]; then
		mkdir $DKPATH/DKApps/$APP/$OS/Debug
	fi
	if [[ "$TYPE" == "Release" ]] || [[ "$TYPE" == "All" ]]; then
		mkdir $DKPATH/DKApps/$APP/$OS/Release
	fi
	
	if [[ "$OS" == "android"* ]]; then
		ANDROID_API="31"
		if [[ "$OSTYPE" == "linux-android" ]]; then
		    ANDROID_NDK_BUILD="23.2.8568313"
		else
			ANDROID_NDK_BUILD="23.1.7779620"
		fi
		ANDROID_NDK="$DKPATH/3rdParty/android-sdk/ndk/$ANDROID_NDK_BUILD"
		if file_exists $ANDROID_NDK/build/cmake/android.toolchain.cmake; then
			ANDROID_TOOLCHAIN=$ANDROID_NDK/build/cmake/android.toolchain.cmake
		fi
	fi
			
	if [[ "$OS" == "android32" ]]; then
		#ANDROID_API="31"
		#if [[ "$OSTYPE" == "linux-android" ]]; then
		#    ANDROID_NDK_BUILD="23.2.8568313"
		#else
		#	ANDROID_NDK_BUILD="23.1.7779620"
		#fi
		#ANDROID_NDK="$DKPATH/3rdParty/android-sdk/ndk/$ANDROID_NDK_BUILD"
		#if file_exists $ANDROID_NDK/build/cmake/android.toolchain.cmake; then
		#	ANDROID_TOOLCHAIN=$ANDROID_NDK/build/cmake/android.toolchain.cmake
		#fi
		cmake -G "Unix Makefiles" -DANDROID_ABI=armeabi-v7a -DANDROID_PLATFORM=$ANDROID_API -DANDROID-NDK=$ANDROID_NDK -DANDROID_TOOLCHAIN=clang -DANDROID_STL=c++_static -DCMAKE_CXX_FLAGS="-std=c++1z -frtti -fexceptions" -DCMAKE_ANDROID_STL_TYPE=c++_static $cmake_string -S$DKCMAKE -B$DKPATH/DKApps/$APP/$OS/Debug
		TARGET="main"
	fi
	if [[ "$OS" == "android64" ]]; then
		#ANDROID_API="31"
		#if [[ "$OSTYPE" == "linux-android" ]]; then
		#    ANDROID_NDK_BUILD="23.2.8568313"
		#else
		#	ANDROID_NDK_BUILD="23.1.7779620"
		#fi
		#ANDROID_NDK="$DKPATH/3rdParty/android-sdk/ndk/$ANDROID_NDK_BUILD"
		#if file_exists $ANDROID_NDK/build/cmake/android.toolchain.cmake; then
		#	ANDROID_TOOLCHAIN=$ANDROID_NDK/build/cmake/android.toolchain.cmake
		#fi
		cmake -G "Unix Makefiles" -DANDROID_ABI=arm64-v8a -DANDROID_PLATFORM=$ANDROID_API -DANDROID-NDK=$ANDROID_NDK -DCMAKE_TOOLCHAIN_FILE=$ANDROID_TOOLCHAIN -DANDROID_TOOLCHAIN=clang -DANDROID_STL=c++_static -DCMAKE_CXX_FLAGS="-std=c++1z -frtti -fexceptions" -DCMAKE_ANDROID_STL_TYPE=c++_static $cmake_string -S$DKCMAKE -B$DKPATH/DKApps/$APP/$OS/Debug
		TARGET="main"
	fi
	if [[ "$OS" == "emscipten" ]]; then
		echo -e "emscripten incomplete...\n"
	fi
	if [[ "$OS" == "ios32" ]]; then
		cmake -G "Xcode" -DCMAKE_TOOLCHAIN_FILE=$DKCMAKE/ios.toolchain.cmake -DPLATFORM=OS -DSDK_VERSION=15.0 -DDEPLOYMENT_TARGET=13.0 $cmake_string -S$DKCMAKE -B$DKPATH/DKApps/$APP/$OS
	fi
	if [[ "$OS" == "ios64" ]]; then
		cmake -G "Xcode" -DCMAKE_TOOLCHAIN_FILE=$DKCMAKE/ios.toolchain.cmake -DPLATFORM=OS64 -DSDK_VERSION=15.0 -DDEPLOYMENT_TARGET=13.0 $cmake_string -S$DKCMAKE -B$DKPATH/DKApps/$APP/$OS
	fi
	if [[ "$OS" == "iossim32" ]]; then
		cmake -G "Xcode" -DCMAKE_TOOLCHAIN_FILE=$DKCMAKE/ios.toolchain.cmake -DPLATFORM=SIMULATOR -DSDK_VERSION=15.0 -DDEPLOYMENT_TARGET=13.0 $cmake_string -S$DKCMAKE -B$DKPATH/DKApps/$APP/$OS
	fi
	if [[ "$OS" == "iossim64" ]]; then
		cmake -G "Xcode" -DCMAKE_TOOLCHAIN_FILE=$DKCMAKE/ios.toolchain.cmake -DPLATFORM=SIMULATOR64 -DSDK_VERSION=15.0 -DDEPLOYMENT_TARGET=13.0 $cmake_string -S$DKCMAKE -B$DKPATH/DKApps/$APP/$OS
	fi
	if [[ "$OS" == "linux32" ]]; then
		cmake -G "Unix Makefiles" -DCMAKE_C_COMPILER="$GCC_PATH" -DCMAKE_CXX_COMPILER="$GPP_PATH" $cmake_string -S$DKCMAKE -B$DKPATH/DKApps/$APP/$OS
		TARGET=${APP}_APP
	fi
	if [[ "$OS" == "linux64" ]]; then
		cmake -G "Unix Makefiles" -DCMAKE_C_COMPILER="$GCC_PATH" -DCMAKE_CXX_COMPILER="$GPP_PATH" $cmake_string -S$DKCMAKE -B$DKPATH/DKApps/$APP/$OS
		TARGET=${APP}_APP
	fi
	if [[ "$OS" == "mac32" ]]; then
		cmake -G "Xcode" -DMAC_32=ON -DCMAKE_OSX_ARCHITECTURES=i686 $cmake_string -S$DKCMAKE -B$DKPATH/DKApps/$APP/$OS
	fi
	if [[ "$OS" == "mac64" ]]; then
		cmake -G "Xcode" -DMAC_64=ON -DCMAKE_OSX_ARCHITECTURES=x86_64 $cmake_string -S$DKCMAKE -B$DKPATH/DKApps/$APP/$OS
	fi
	if [[ "$OS" == "raspberry32" ]]; then
		cmake -G "Unix Makefiles" -DCMAKE_C_COMPILER="$GCC_PATH" -DCMAKE_CXX_COMPILER="$GPP_PATH" $cmake_string -S$DKCMAKE -B$DKPATH/DKApps/$APP/$OS
		TARGET=${APP}_APP
	fi
	if [[ "$OS" == "raspberry64" ]]; then
		cmake -G "Unix Makefiles" -DCMAKE_C_COMPILER="$GCC_PATH" -DCMAKE_CXX_COMPILER="$GPP_PATH" $cmake_string -S$DKCMAKE -B$DKPATH/DKApps/$APP/$OS
		TARGET=${APP}_APP
	fi
	if [[ "$OS" == "win32" ]]; then
		#MSYS2="$DKPATH/3rdParty/msys2-x86_64-20221216"
		#export PATH=${MSYS2}/mingw64/bin:$PATH
		#export PATH=${MSYS2}/usr/bin:$PATH
		#set PATH=%PATH%;${MSYS2}/mingw64/bin
		if [[ "$TYPE" == "Debug" ]] || [[ "$TYPE" == "All" ]]; then
			cmake -G "Unix Makefiles" $cmake_string -S$DKCMAKE -B$DKPATH/DKApps/$APP/$OS/Debug
		fi
		if [[ "$TYPE" == "Release" ]] || [[ "$TYPE" == "All" ]]; then
			cmake -G "Unix Makefiles" $cmake_string -S$DKCMAKE -B$DKPATH/DKApps/$APP/$OS/Release
		fi
		TARGET=${APP}_APP
	fi
	if [[ "$OS" == "win64" ]]; then
		#MSYS2="$DKPATH/3rdParty/msys2-x86_64-20221216"
		#export PATH=${MSYS2}/mingw64/bin:$PATH
		#export PATH=${MSYS2}/usr/bin:$PATH
		#set PATH=%PATH%;${MSYS2}/mingw64/bin
		if [[ "$TYPE" == "Debug" ]] || [[ "$TYPE" == "All" ]]; then
			cmake -G "Unix Makefiles" $cmake_string -S$DKCMAKE -B$DKPATH/DKApps/$APP/$OS/Debug
		fi
		if [[ "$TYPE" == "Release" ]] || [[ "$TYPE" == "All" ]]; then
			cmake -G "Unix Makefiles" $cmake_string -S$DKCMAKE -B$DKPATH/DKApps/$APP/$OS/Release
		fi
		TARGET=${APP}_APP
	fi
	
	
	############  BUILD PROJECT ############ 
	if [[ "$TYPE" == "Debug" ]] || [[ "$TYPE" == "All" ]]; then
		#xcodebuild -configuration Debug build
		#cmake --build $DKPATH/DKApps/$APP/$OS --target ${APP}_APP --config Debug
		cmake --build $DKPATH/DKApps/$APP/$OS/Debug --target ${TARGET} --config Debug
	fi
	if [[ "$TYPE" == "Release" ]] || [[ "$TYPE" == "All" ]]; then
		#xcodebuild -configuration Release build
		#cmake --build $DKPATH/DKApps/$APP/$OS --target ${APP}_APP --config Release
		cmake --build $DKPATH/DKApps/$APP/$OS/Release --target ${TARGET} --config Release
	fi
	
	echo "******* Done building $APP - $OS - $TYPE *******"
	
    unset APP
	unset OS
	unset TYPE
done


exec $SHELL		# keep terminal open