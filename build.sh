#!/bin/bash
#{

if ! [[ "$@" == "" ]]; then
	"$@"
fi


############ DigitalKnob builder script ############
# to run this script requires privledges, use $ chmod 777 build.sh

###### GLOBAL USER VARIABLES ######
GIT_USER_EMAIL="aquawicket@hotmail.com"
GIT_USER_NAME="aquawicket"
	
###### Global Script Variables ######
SCRIPTPATH=$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )
SCRIPTNAME=$(basename "$0")
echo $SCRIPTPATH/$SCRIPTNAME
true=0
false=1
CLR="\033[0m"
black="100m"
red="\033[31m"
green="\033[32m"
yellow="\033[33m"
blue="\033[34m"
magenta="\033[35m"
cyan="\033[36m"
white="\033[37m"


###### main ######
function main() {

	validate_sudo

	#exec |& tee file.log

	echo ""
	echo "SHLVL = $SHLVL"			# https://stackoverflow.com/a/4511483/688352
	echo "HOSTNAME = $HOSTNAME"
	echo "HOSTTYPE = $HOSTTYPE"
	echo "MACHTYPE = $MACHTYPE"
	echo "MODEL = $MODEL"
	echo "MSYSTEM = $MSYSTEM"
	echo "OSTYPE = $OSTYPE"
	echo "SCRIPTNAME = $SCRIPTNAME"
	echo "SCRIPTPATH = $SCRIPTPATH"
	echo "USER = $USER"
	echo "USERNAME = $USERNAME"
	echo ""

	if [[ -n "$USERPROFILE" ]]; then
		DIGITALKNOB="$USERPROFILE\digitalknob"
		DIGITALKNOB=$(sed 's.C:./c.g' <<< $DIGITALKNOB)
		DIGITALKNOB=$(sed 's.\\./.g' <<< $DIGITALKNOB)
	else
		DIGITALKNOB="$HOME/digitalknob"
	fi

	mkdir -p $DIGITALKNOB;
	echo "DIGITALKNOB = $DIGITALKNOB"

	DKDOWNLOAD="$DIGITALKNOB/download"
	mkdir -p $DKDOWNLOAD;
	echo "DKDOWNLOAD = $DKDOWNLOAD"

	if [[ "$OSTYPE" == "darwin"* ]]; then
		validate_homebrew
	fi

	validate_which
	validate_cmake
	validate_git
	validate_branch

	echo "DKPATH = $DKPATH"
	echo "DKCMAKE = $DKCMAKE"
	echo "DK3RDPARTY = $DK3RDPARTY"
	echo "DKIMPORTS = $DKIMPORTS"

	if [ $SCRIPTPATH == $DKPATH ]; then
		echo "SCRIPTPATH and DKPATH are the same"
	else
		warning "$SCRIPTNAME is not running from the DKPATH directory. Any changes will not be saved by git!"
		warning "$SCRIPTNAME path = $SCRIPTPATH"
		warning "DKPATH path = $DKPATH"
	fi
	
	while :
	do
		if ! [[ -n "$UPDATE" ]];	then Pick_Update;	continue; fi
		if ! [[ -n "$APP" ]]; 		then Pick_App;		continue; fi
		if ! [[ -n "$TARGET_OS" ]]; then Pick_OS;		continue; fi
		if ! [[ -n "$TYPE" ]];		then Pick_Type;		continue; fi
		Generate_Project
		Build_Project
		
		unset UPDATE
		unset APP
		unset TARGET_OS
		unset TYPE
	done
	
	
}

###### Pick_Update ######
function Pick_Update() {
	echo ""
	
	# https://unix.stackexchange.com/a/293605
	COLUMNS=1
	PS3='Choose a selection: '
	options=(
		"Git Update" 
		"Git Commit" 
		"Push assets" 
		"Pull assets"
		"Reset Apps"
		"Reset Plugins"
		"Reset 3rdParty"
		"Reset All"
		"Clear Screen"
		"Clear cmake cache and .tmp files"
		"Reload"
		"Exit")
	select opt in "${options[@]}"
	do
		case $opt in
			"Git Update")
				git_update
				break
				;;
			"Git Commit")
				git_commit
				break
				;;
			"Push assets")
				push_assets
				break
				;;
			"Pull assets")
				pull_assets
				break
				;;
			"Reset Apps")
				reset_apps
				break
				;;
			"Reset Plugins")
				reset_plugins
				break
				;;
			"Reset 3rdParty")
				reset_3rdpaty
				break
				;;
			"Reset All")
				reset_all
				break
				;;
			"Clear Screen")
				clear
				break
				;;
			"Clear cmake cache and .tmp files")
				clear_cmake_cache
				delete_temp_files
				break
				;;
			"Reload")
				reload
				break
				;;
			"Exit")
				exit 0
				break
				;;
			*)
				UPDATE=1
				break
				;;
		esac
	done
}

###### Pick_App ######
function Pick_App() {
	echo ""
	
	# https://unix.stackexchange.com/a/293605
	COLUMNS=1
	PS3='Choose a selection: '
	options=(
		"HelloWorld" 
		"DKCore" 
		"DKJavascript" 
		"DKBuilder" 
		"DKSDL" 
		"DKSDLRml" 
		"DKDomTest" 
		"DKTestAll"
		"Enter_manually"
		"Clear Screen"
		"Go Back"
		"Reload"
		"Exit")
	select opt in "${options[@]}"
	do
		case $opt in
			"HelloWorld")
				APP="HelloWorld"
				break
				;;
			"DKCore")
				APP="DKCore"
				break
				;;
			"DKJavascript")
				APP="DKJavascript"
				break
				;;
			"DKBuilder")
				APP="DKBuilder"
				break
				;;
			"DKSDL")
				APP="DKSDL"
				break
				;;
			"DKSDLRml")
				APP="DKSDLRml"
				break
				;;
			"DKDomTest")
				APP="DKDomTest"
				break
				;;
			"DKTestAll")
				APP="DKTestAll"
				break
				;;
			"Enter_manually")
				enter_manually
				break
				;;				
			"Clear Screen")
				clear
				break
				;;
			"Go Back")
				UPDATE=
				break
				;;
			"Reload")
				dk_call reload
				break
				;;
			"Exit")
				exit 0
				break
				;;
			*) 
				echo "invalid option: $opt"
				APP=
				break
				;;
		esac
	done
}

###### Pick_OS ######
function Pick_OS() {
	echo ""
	# TODO
	#  1) Linux (x86_64)

	# 2) Android (arm32)
	# 3) Android (arm64)
	# 4) Android (x86)
	# 5) Android (x86_64)
	# 6) iOS (arm32)
	# 7) iOS (arm64)
	# 8) iOS (x86)
	# 9) iOS (x86_64)
	# 10) iOS-Simulator (arm32)
	# 11) iOS-Simulator (arm64)
	# 12) iOS-Simulator (x86)
	# 13) iOS-Simulator (x86_64)
	# 14) Linux (c)
	# 15) Linux (arm64)
	# 16) Linux (x86)
	# 17) Linux (x86_64)
	# 18) Mac (arm32)
	# 19) Mac (arm64)
	# 20) Mac (x86)
	# 21) Mac (x86_64)
	# 22) Raspberry (arm32)
	# 23) Raspberry (arm64)
	# 24) Raspberry (x86)
	# 25) Raspberry (x86_64)
	# 26) Windows (arm32)
	# 27) Windows (arm64)
	# 28) Windows (x86)
	# 29) Windows (x86_64)
	# 30) Clear Screen
	# 31) Go Back
	# 32) Exit
	
	# Raspberry Pi
	if [ -e /proc/device-tree/model ]; then
		MODEL=$(tr -d '\0' </proc/device-tree/model)
	fi
	
	# https://unix.stackexchange.com/a/293605
	COLUMNS=1
	PS3="Please select an OS to build for: "
	if [[ "$MODEL" == "Raspberry"* ]]; then
		options=("raspberry32" "android32" "android64" "emscripten" "Clear Screen" "Go Back" "Exit")
	elif [[ "$OSTYPE" == "linux-gnu"* ]] && [[ "$HOSTTYPE" == "x86_64"* ]]; then
		options=("linux64" "android32" "android64" "emscripten" "Clear Screen" "Go Back" "Exit")
	elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
		options=("linux32" "android32" "android64" "emscripten" "Clear Screen" "Go Back" "Exit")
	elif [[ "$OSTYPE" == "darwin"* ]] && [[ "$HOSTTYPE" == "x86_64"* ]]; then
		options=("mac64" "ios32" "ios64" "iossim32" "iossim64" "android32" "android64" "emscripten" "Clear Screen" "Go Back" "Exit")
	elif [[ "$OSTYPE" == "linux-android" ]]; then
		options=("android32" "android64" "Clear Screen" "Go Back" "Exit")
	elif [[ "$OSTYPE" == "msys" ]]; then
		options=("win32" "win64" "android32" "android64" "emscripten" "Clear Screen" "Go Back" "Exit")
	else
		echo "UNKNOWN OS TYPE ($OSTYPE)"
		options=("Exit")
	fi
	select opt in "${options[@]}"
	do
		case $opt in
			"android32")
				TARGET_OS="android32"
				break
				;;
			"android64")
				TARGET_OS="android64"
				break
				;;
			"emscripten")
				TARGET_OS="emscripten"
				break
				;;
			"ios32")
				TARGET_OS="ios32"
				break
				;;
			"ios64")
				TARGET_OS="ios64"
				break
				;;
			"iossim32")
				TARGET_OS="iossim32"
				break
				;;
			"iossim64")
				TARGET_OS="iossim64"
				break
				;;
			"linux32")
				TARGET_OS="linux32"
				break
				;;
			"linux64")
				TARGET_OS="linux64"
				break
				;;
			"mac32")
				TARGET_OS="mac32"
				break
				;;
			"mac64")
				TARGET_OS="mac64"
				break
				;;
			"raspberry32")
				TARGET_OS="raspberry32"
				break
				;;
			"win32")
				TARGET_OS="win32"
				break
				;;
			"win64")
				TARGET_OS="win64"
				break
				;;
			"Clear Screen")
				clear
				break;
				;;
			"Go Back")
				APP=
				break
				;;
			"Exit")
				exit 0
				break
				;;
			*) 
				echo "invalid option: $opt"
				break
				;;
		esac 
	done
}

###### Pick_Type ######
function Pick_Type() {
	echo ""
	
	# https://unix.stackexchange.com/a/293605
	COLUMNS=1
	PS3="Please select build type: "
	options=(
		"Debug" 
		"Release" 
		"All" 
		"Clear Screen"
		"Go Back"
		"Exit")
	select opt in "${options[@]}"
	do
		case $opt in
			"Debug")
				TYPE="Debug"
				break
				;;
			"Release")
				TYPE="Release"
				break
				;;
			"All")
				TYPE="All"
				break
				;;
			"Clear Screen")
				clear
				break
				;;
			"Go Back")
				TARGET_OS=
				break
				;;
			"Exit")
				exit 0
				break
				;;
			*) 
				echo "invalid option: $opt"
				break
				;;
		esac 
	done
}

###### Generate_Project ######
function Generate_Project() {
	
	echo ""
	echo "##################################################################"
	echo "****** Generating $APP - $TARGET_OS - $TYPE - $LEVEL ******"
	echo "##################################################################"
	echo ""

	clear_cmake_cache
	delete_temp_files

	LEVEL="RebuildAll"
	LINK="Static"
	
	###### BUILD CMAKE_ARGS ARRAY ######
	declare -a CMAKE_ARGS
	if [[ $TYPE == "Debug" ]] || [[ $TYPE == "All" ]]; then
		CMAKE_ARGS+=( "-DDEBUG=ON" )
	else
		CMAKE_ARGS+=( "-DDEBUG=OFF" )
	fi
	if [[ $TYPE == "Release" ]] || [[ $TYPE == "All" ]]; then
		CMAKE_ARGS+=( "-DRELEASE=ON" )
	else
		CMAKE_ARGS+=( "-DRELEASE=OFF" )
	fi
	if [[ $LEVEL == "Build" ]]; then
		CMAKE_ARGS+=( "-DBUILD=ON" )
	fi
	if [[ $LEVEL == "Rebuild" ]]; then
		CMAKE_ARGS+=( "-DREBUILD=ON" )
	fi
	if [[ $LEVEL == "RebuildAll" ]]; then
		CMAKE_ARGS+=( "-DREBUILDALL=ON" )
	fi
	if [[ $LINK == "Static" ]]; then
		CMAKE_ARGS+=( "-DSTATIC=ON" )
	fi
	if [[ $LINK == "Shared" ]]; then
		CMAKE_ARGS+=( "-DSHARED=ON" )
	fi
	
	#CMAKE_ARGS+=( "-DCMAKE_VERBOSE_MAKEFILE=1" )
	#echo CMAKE_ARGS = "${CMAKE_ARGS[@]}"
	
	###### GENERATOR ######
	if [[ $TARGET_OS == "android"* ]]; then
		GENERATOR="Unix Makefiles"
	elif [[ $TARGET_OS == "mac"* ]] || [[ $TARGET_OS == "ios"* ]]; then
		GENERATOR="Xcode"
	elif [[ $TARGET_OS == "emscripten" ]]; then
		validate_emscripten
		GENERATOR="$EMSDK_GENERATOR"
		CMAKE_ARGS+=( "-DCMAKE_C_COMPILER=$EMSDK_C_COMPILER" )
		CMAKE_ARGS+=( "-DCMAKE_CXX_COMPILER=$EMSDK_CXX_COMPILER" )
		CMAKE_ARGS+=( "-DCMAKE_TOOLCHAIN_FILE=$EMSDK_TOOLCHAIN_FILE" )
		MSYSTEM=""
	elif [[ -n "$MSYSTEM" ]]; then
		GENERATOR="MSYS Makefiles"
	else
		GENERATOR="Unix Makefiles"
	fi

	###### MAKE_PROGRAM ######
	#validate_make
	#if [[ -n "$MAKE_PROGRAM" ]]; then
	#	CMAKE_ARGS+=( "-DCMAKE_MAKE_PROGRAM=$MAKE_PROGRAM" )
	#fi
	
	###### C_COMPILER; CXX_COMPILER ######
	### GCC ###
	if [[ $MSYSTEM == "MINGW32" ]] || [[ $MSYSTEM == "MINGW64" ]] || [[ $TARGET_OS == "linux"* ]] || [[ $MODEL == "Raspberry"* ]]; then
		validate_gcc
		CMAKE_ARGS+=( "-DCMAKE_C_COMPILER=$GCC_C_COMPILER" )
		CMAKE_ARGS+=( "-DCMAKE_CXX_COMPILER=$GCC_CXX_COMPILER" )
	fi
	### CLANG ###
	if [[ $MSYSTEM == "CLANG32" ]] || [[ $MSYSTEM == "CLANG64" ]] || [[ $MSYSTEM == "CLANGARM64" ]] || [[ $MSYSTEM == "UCRT64" ]]; then
		validate_clang
		CMAKE_ARGS+=( "-DCMAKE_C_COMPILER=$CLANG_C_COMPILER" )
		CMAKE_ARGS+=( "-DCMAKE_CXX_COMPILER=$CLANG_CXX_COMPILER" )
	fi
	
	###### EXE_LINKER_FLAGS ######
	if [[ -n "$MSYSTEM" ]]; then
		EXE_LINKER_FLAGS="-static -mconsole"		
		#CMAKE_ARGS+=( "-DCMAKE_EXE_LINKER_FLAGS=$EXE_LINKER_FLAGS" )
	fi

	#TODO: turn into a cmake_eval
	# build-essential for Tiny Core Linux
	#if command_exists tce-load; then
	#	validate_package libzstd libzstd
	#fi
	
    #TODO: turn into a cmake_eval
	# build-essential for Tiny Core Linux
	#if command_exists tce-load; then
	#	validate_package gcc compiletc
	#fi
	
	#dk_call export SHELL="/bin/bash"
	
	mkdir -p $DKPATH/DKApps/$APP/$TARGET_OS
	cd /
	
	if [[ "$TYPE" == "Debug" ]] || [[ "$TYPE" == "All" ]]; then
		mkdir -p $DKPATH/DKApps/$APP/$TARGET_OS/Debug
	fi
	if [[ "$TYPE" == "Release" ]] || [[ "$TYPE" == "All" ]]; then
		mkdir -p $DKPATH/DKApps/$APP/$TARGET_OS/Release
	fi
	
	if [[ "$TARGET_OS" == "android"* ]]; then
		validate_android_ndk
		TARGET="main"
	fi
			
	if [[ "$TARGET_OS" == "android32" ]]; then
		if [[ "$TYPE" == "Debug" ]] || [[ "$TYPE" == "All" ]]; then
	     	dk_call $CMAKE -G "$GENERATOR" -DANDROID_ABI=armeabi-v7a -DANDROID_PLATFORM=$ANDROID_API -DANDROID_NDK=$ANDROID_NDK -DCMAKE_TOOLCHAIN_FILE=$ANDROID_TOOLCHAIN_FILE -DANDROID_TOOLCHAIN=clang -DANDROID_STL=c++_static -DCMAKE_CXX_FLAGS="-std=c++1z -frtti -fexceptions" -DCMAKE_ANDROID_STL_TYPE=c++_static "${CMAKE_ARGS[@]}" -S$DKCMAKE -B$DKPATH/DKApps/$APP/$TARGET_OS/Debug
	    fi
	    if [[ "$TYPE" == "Release" ]] || [[ "$TYPE" == "All" ]]; then
	     	dk_call $CMAKE -G "$GENERATOR" -DANDROID_ABI=armeabi-v7a -DANDROID_PLATFORM=$ANDROID_API -DANDROID_NDK=$ANDROID_NDK -DCMAKE_TOOLCHAIN_FILE=$ANDROID_TOOLCHAIN_FILE -DANDROID_TOOLCHAIN=clang -DANDROID_STL=c++_static -DCMAKE_CXX_FLAGS="-std=c++1z -frtti -fexceptions" -DCMAKE_ANDROID_STL_TYPE=c++_static "${CMAKE_ARGS[@]}" -S$DKCMAKE -B$DKPATH/DKApps/$APP/$TARGET_OS/Release
	    fi
	fi

	if [[ "$TARGET_OS" == "android64" ]]; then
		if [[ "$TYPE" == "Debug" ]] || [[ "$TYPE" == "All" ]]; then
		    dk_call $CMAKE -G "$GENERATOR" -DANDROID_ABI=arm64-v8a -DANDROID_PLATFORM=$ANDROID_API -DANDROID_NDK=$ANDROID_NDK -DCMAKE_TOOLCHAIN_FILE=$ANDROID_TOOLCHAIN_FILE -DANDROID_TOOLCHAIN=clang -DANDROID_STL=c++_static -DCMAKE_CXX_FLAGS="-std=c++1z -frtti -fexceptions" -DCMAKE_ANDROID_STL_TYPE=c++_static "${CMAKE_ARGS[@]}" -S$DKCMAKE -B$DKPATH/DKApps/$APP/$TARGET_OS/Debug
	    fi
    	if [[ "$TYPE" == "Release" ]] || [[ "$TYPE" == "All" ]]; then
		    dk_call $CMAKE -G "$GENERATOR" -DANDROID_ABI=arm64-v8a -DANDROID_PLATFORM=$ANDROID_API -DANDROID_NDK=$ANDROID_NDK -DCMAKE_TOOLCHAIN_FILE=$ANDROID_TOOLCHAIN_FILE -DANDROID_TOOLCHAIN=clang -DANDROID_STL=c++_static -DCMAKE_CXX_FLAGS="-std=c++1z -frtti -fexceptions" -DCMAKE_ANDROID_STL_TYPE=c++_static "${CMAKE_ARGS[@]}" -S$DKCMAKE -B$DKPATH/DKApps/$APP/$TARGET_OS/Release
	    fi
	fi
	
	
	if [[ $TARGET_OS == "emscripten" ]]; then
	    #dk_call validate_emscripten
		if [[ "$TYPE" == "Debug" ]] || [[ "$TYPE" == "All" ]]; then
			dk_call $EMSDK_ENV && $CMAKE -G "$GENERATOR" "${CMAKE_ARGS[@]}" -S$DKCMAKE -B$DKPATH/DKApps/$APP/$TARGET_OS/Debug
		fi
		if [[ "$TYPE" == "Release" ]] || [[ "$TYPE" == "All" ]]; then
			dk_call $EMSDK_ENV && $CMAKE -G "$GENERATOR" "${CMAKE_ARGS[@]}" -S$DKCMAKE -B$DKPATH/DKApps/$APP/$TARGET_OS/Release
		fi
		TARGET=${APP}_APP
	fi
	
	
	if [[ "$TARGET_OS" == "ios32" ]]; then
		dk_call $CMAKE -G "$GENERATOR" -DCMAKE_TOOLCHAIN_FILE=$DKCMAKE/ios.toolchain.cmake -DPLATFORM=TARGET_OS -DSDK_VERSION=15.0 -DDEPLOYMENT_TARGET=13.0 "${CMAKE_ARGS[@]}" -S$DKCMAKE -B$DKPATH/DKApps/$APP/$TARGET_OS
	fi
	if [[ "$TARGET_OS" == "ios64" ]]; then
		dk_call $CMAKE -G "$GENERATOR" -DCMAKE_TOOLCHAIN_FILE=$DKCMAKE/ios.toolchain.cmake -DPLATFORM=OS64 -DSDK_VERSION=15.0 -DDEPLOYMENT_TARGET=13.0 "${CMAKE_ARGS[@]}" -S$DKCMAKE -B$DKPATH/DKApps/$APP/$TARGET_OS
	fi
	if [[ "$TARGET_OS" == "iossim32" ]]; then
		dk_call $CMAKE -G "$GENERATOR" -DCMAKE_TOOLCHAIN_FILE=$DKCMAKE/ios.toolchain.cmake -DPLATFORM=SIMULATOR -DSDK_VERSION=15.0 -DDEPLOYMENT_TARGET=13.0 "${CMAKE_ARGS[@]}" -S$DKCMAKE -B$DKPATH/DKApps/$APP/$TARGET_OS
	fi
	if [[ "$TARGET_OS" == "iossim64" ]]; then
		dk_call $CMAKE -G "$GENERATOR" -DCMAKE_TOOLCHAIN_FILE=$DKCMAKE/ios.toolchain.cmake -DPLATFORM=SIMULATOR64 -DSDK_VERSION=15.0 -DDEPLOYMENT_TARGET=13.0 "${CMAKE_ARGS[@]}" -S$DKCMAKE -B$DKPATH/DKApps/$APP/$TARGET_OS
	fi
	
	if [[ "$TARGET_OS" == "linux32" ]]; then
		if [[ "$TYPE" == "Debug" ]] || [[ "$TYPE" == "All" ]]; then
			dk_call $CMAKE -G "$GENERATOR" "${CMAKE_ARGS[@]}" -S$DKCMAKE -B$DKPATH/DKApps/$APP/$TARGET_OS/Debug
		fi
		if [[ "$TYPE" == "Release" ]] || [[ "$TYPE" == "All" ]]; then
			dk_call $CMAKE -G "$GENERATOR" "${CMAKE_ARGS[@]}" -S$DKCMAKE -B$DKPATH/DKApps/$APP/$TARGET_OS/Release
		fi
		TARGET=${APP}_APP
	fi
	
	if [[ "$TARGET_OS" == "linux64" ]]; then
		if [[ "$TYPE" == "Debug" ]] || [[ "$TYPE" == "All" ]]; then
			dk_call $CMAKE -G "$GENERATOR" "${CMAKE_ARGS[@]}" -S$DKCMAKE -B$DKPATH/DKApps/$APP/$TARGET_OS/Debug
		fi
		if [[ "$TYPE" == "Release" ]] || [[ "$TYPE" == "All" ]]; then
			dk_call $CMAKE -G "$GENERATOR" "${CMAKE_ARGS[@]}" -S$DKCMAKE -B$DKPATH/DKApps/$APP/$TARGET_OS/Release
		fi
		TARGET=${APP}_APP
	fi
	
	if [[ "$TARGET_OS" == "mac32" ]]; then
		dk_call $CMAKE -G "$GENERATOR" -DMAC_32=ON -DCMAKE_OSX_ARCHITECTURES=i686 "${CMAKE_ARGS[@]}" -S$DKCMAKE -B$DKPATH/DKApps/$APP/$TARGET_OS
	fi
	
	if [[ "$TARGET_OS" == "mac64" ]]; then
		dk_call $CMAKE -G "$GENERATOR" -DMAC_64=ON -DCMAKE_OSX_ARCHITECTURES=x86_64 "${CMAKE_ARGS[@]}" -S$DKCMAKE -B$DKPATH/DKApps/$APP/$TARGET_OS
		TARGET=${APP}_APP
	fi
	
	if [[ "$TARGET_OS" == "raspberry32" ]]; then
		if [[ "$TYPE" == "Debug" ]] || [[ "$TYPE" == "All" ]]; then
			dk_call $CMAKE -G "$GENERATOR" "${CMAKE_ARGS[@]}" -S$DKCMAKE -B$DKPATH/DKApps/$APP/$TARGET_OS/Debug
		fi
		if [[ "$TYPE" == "Release" ]] || [[ "$TYPE" == "All" ]]; then
			dk_call $CMAKE -G "$GENERATOR" "${CMAKE_ARGS[@]}" -S$DKCMAKE -B$DKPATH/DKApps/$APP/$TARGET_OS/Release
		fi
		TARGET=${APP}_APP
	fi
	
	if [[ "$TARGET_OS" == "raspberry64" ]]; then
		if [[ "$TYPE" == "Debug" ]] || [[ "$TYPE" == "All" ]]; then
			dk_call $CMAKE -G "$GENERATOR" "${CMAKE_ARGS[@]}" -S$DKCMAKE -B$DKPATH/DKApps/$APP/$TARGET_OS/Debug
		fi
		if [[ "$TYPE" == "Release" ]] || [[ "$TYPE" == "All" ]]; then
			dk_call $CMAKE -G "$GENERATOR" "${CMAKE_ARGS[@]}" -S$DKCMAKE -B$DKPATH/DKApps/$APP/$TARGET_OS/Release
		fi
		TARGET=${APP}_APP
	fi
	
	if [[ "$TARGET_OS" == "win32" ]]; then
		validate_msys2
		validate_make
		dk_call export PATH=${MSYS2}/mingw32/bin:$PATH
		dk_call export PATH=${MSYS2}/usr/bin:$PATH
		if [[ "$TYPE" == "Debug" ]] || [[ "$TYPE" == "All" ]]; then
			dk_call $CMAKE -G "$GENERATOR" "${CMAKE_ARGS[@]}" -S$DKCMAKE -B$DKPATH/DKApps/$APP/$TARGET_OS/Debug
		fi
		if [[ "$TYPE" == "Release" ]] || [[ "$TYPE" == "All" ]]; then
			dk_call $CMAKE -G "$GENERATOR" "${CMAKE_ARGS[@]}" -S$DKCMAKE -B$DKPATH/DKApps/$APP/$TARGET_OS/Release
		fi
		TARGET=${APP}_APP
	fi
	
	if [[ "$TARGET_OS" == "win64" ]]; then
		validate_msys2
		validate_make
		dk_call export PATH=${MSYS2}/mingw64/bin:$PATH
		dk_call export PATH=${MSYS2}/usr/bin:$PATH
		if [[ "$TYPE" == "Debug" ]] || [[ "$TYPE" == "All" ]]; then
			dk_call $CMAKE -G "$GENERATOR" "${CMAKE_ARGS[@]}" -S$DKCMAKE -B$DKPATH/DKApps/$APP/$TARGET_OS/Debug
		fi
		if [[ "$TYPE" == "Release" ]] || [[ "$TYPE" == "All" ]]; then
			dk_call $CMAKE -G "$GENERATOR" "${CMAKE_ARGS[@]}" -S$DKCMAKE -B$DKPATH/DKApps/$APP/$TARGET_OS/Release
		fi
		TARGET=${APP}_APP
	fi
}
	
###### Build_Project ######
function Build_Project() {

	echo ""
	echo "##################################################################"
	echo "****** Building $APP - $TARGET_OS - $TYPE - $LEVEL ******"
	echo "##################################################################"
	echo ""
	
	if [[ "$TYPE" == "Debug" ]] || [[ "$TYPE" == "All" ]]; then
		if file_exists $DKPATH/DKApps/$APP/$TARGET_OS/Debug/CMakeCache.txt; then
			dk_call $CMAKE --build $DKPATH/DKApps/$APP/$TARGET_OS/Debug --target ${TARGET} --config Debug --verbose
		elif file_exists $DKPATH/DKApps/$APP/$TARGET_OS/CMakeCache.txt; then
			dk_call $CMAKE --build $DKPATH/DKApps/$APP/$TARGET_OS --target ${TARGET} --config Debug --verbose
		else
			error "Could not find CMakeCache.txt in $APP/$TARGET_OS/Debug or $APP/$TARGET_OS"
		fi
	fi
	if [[ "$TYPE" == "Release" ]] || [[ "$TYPE" == "All" ]]; then
		if file_exists $DKPATH/DKApps/$APP/$TARGET_OS/Release/CMakeCache.txt; then
			dk_call $CMAKE --build $DKPATH/DKApps/$APP/$TARGET_OS/Release --target ${TARGET} --config Release --verbose
		elif file_exists $DKPATH/DKApps/$APP/$TARGET_OS/CMakeCache.txt; then
			dk_call $CMAKE --build $DKPATH/DKApps/$APP/$TARGET_OS --target ${TARGET} --config Release --verbose
		else
			error "Could not find CMakeCache.txt in $APP/$TARGET_OS/Release or $APP/$TARGET_OS"
		fi
	fi
	
	echo ""
	echo "##################################################################"
	echo "****** Done Building $APP - $TARGET_OS - $TYPE - $LEVEL ******"
	echo "##################################################################"
	echo ""
}

###### validate_sudo ######
function validate_sudo() {
	if command -v "sudo" >/dev/null 2>&1; then
		SUDO="sudo"
	fi
	$SUDO echo
}

###### dk_call <command args> ######
function dk_call() {
	if [ -z "$1" ]; then
		error "dk_call <command args> requires at least 1 parameter"
		return $false
	fi
	
	echo -e "${magenta} $ $@ ${CLR}"
	"$@"
}

###### reload ######
function reload() {
	echo "reloading $SCRIPTPATH/$SCRIPTNAME"
	clear && $SCRIPTPATH/$SCRIPTNAME && exit
}

###### warning <string> ######
function warning() {
	echo -e "${yellow} WARNING: $1 ${CLR}"
}

###### error <string> ######
function error() {
	echo -e "${red} ERROR: $1 ${CLR}"
}

###### message <string> ######
function message() {
	if [ -z "$1" ]; then
		error "message <string> requires 1 parameter"
		return $false
	fi
	echo "$@"	
}

###### CONFIRM() ######
function CONFIRM() {
	echo -e "${yellow} Are you sure ? [Y/N] ${CLR}"
	read -p " " -n 1 -r
	echo
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then 
		return 1; 
	fi
}

###### string_contains <string> <substring> ######
function string_contains() {
	if [ -z "$2" ]; then
		error "string_contains <string> <substring> requires 2 parameters"
		return $false
	fi
	[[ $1 == *"$2"* ]]
}

###### command_exists <command> ######
function command_exists() {
	command -v "$1" >/dev/null 2>&1
}
	
###### file_exists <file> ######
function file_exists() {
	[ -e $1 ]
}

###### validate_which ######
function validate_which() {
	if ! command_exists which; then
		install which
	fi
	
	WHICH=$(which which)
	echo "WHICH = $WHICH"
}

###### validate_cmake ######
function validate_cmake() {
	if ! command_exists cmake; then
		if [[ "$MSYSTEM" == "CLANG32" ]]; then
			install mingw-w64-clang-i686-cmake
		elif [[ "$MSYSTEM" == "CLANG64" ]]; then
			install mingw-w64-clang-x86_64-cmake
		elif [[ "$MSYSTEM" == "CLANGARM64" ]]; then
			install mingw-w64-clang-aarch64-cmake
		elif [[ "$MSYSTEM" == "MINGW32" ]]; then
			install mingw-w64-i686-cmake
		elif [[ "$MSYSTEM" == "MINGW64" ]]; then
			install mingw-w64-x86_64-cmake
		elif [[ "$MSYSTEM" == "UCRT64" ]]; then
			install mingw-w64-ucrt-x86_64-cmake
		else
			install cmake
		fi
	fi
	
	CMAKE=$(which cmake)
	echo "CMAKE = $CMAKE"
}

###### validate_git ######
function validate_git() {
	if ! command_exists git; then
		install git
	fi
	
	GIT=$(which git)
	echo "GIT = $GIT"	
}

###### validate_homebrew ######
function validate_homebrew() {
	
	if ! [[ "$OSTYPE" == "darwin"* ]]; then
		return
	fi
		
	if ! command_exists brew; then
		echo "installing Homebrew"
		ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
		# https://github.com/Homebrew/brew/issues/10368
		rm -fr $(brew --repo homebrew/core)
		brew tap homebrew/core
	fi
	
	BREW=$(which brew)
	echo "BREW = $BREW"	
}

###### package_installed <package> ######
function package_installed() {
	if command_exists dpkg-query; then
		if [ $(dpkg-query -W -f='${Status}' $1 2>/dev/null | grep -c "ok installed") -ne 0 ]; then
			return $true
		fi
	elif command_exists brew; then
		if brew list $1 &>/dev/null; then
			return $true
		fi
	elif command_exists apt; then
		error "package_installed() apt-get not implemented"
	elif command_exists apt-get; then
		error "package_installed() apt-get not implemented"
	elif command_exists pkg; then
		error "package_installed() pkg not implemented"
	elif command_exists pacman; then
		if pacman -Qs $1 > /dev/null; then
			#FIXME: this doesn't always work
			return $false;
		fi
	elif command_exists tce-load; then
		#error "package_installed() tce-load not implemented"
		return $false
	else
		error "ERROR: no package managers found"
	fi
	return $false
}

###### install <package> ######
function install() {
	#if package_installed $1; then
	#	echo "$1 already installed"
	#	return $false;
	#fi
	
	echo "installing $1"

	if command_exists brew; then
		dk_call $SUDO brew install $1
	elif command_exists apt; then
		dk_call $SUDO apt -y install $1
	elif command_exists apt-get; then
		dk_call $SUDO apt-get -y install $1
	elif command_exists pkg; then
		dk_call $SUDO pkg install $1
	elif command_exists pacman; then
		dk_call $SUDO pacman -S $1 --noconfirm
	elif command_exists tce-load; then
		dk_call tce-load -wi $1
	else
		error "ERROR: no package managers found"
	fi
}

###### validate_package <command> <package> ######
function validate_package() {
	if ! command_exists $1; then
		install $2
	fi
}

###### validate_ostype ######
function validate_ostype() {
	if [ -e /proc/device-tree/model ]; then
		MODEL=$(tr -d '\0' </proc/device-tree/model)
	fi

	if [[ "$OSTYPE" == "linux-gnu"* ]]; then
		DIGITALKNOB="/home/$USER/digitalknob"
	elif [[ "$OSTYPE" == "darwin"* ]]; then
		DIGITALKNOB="/Users/$USER/digitalknob"
	elif [[ "$OSTYPE" == "cygwin" ]]; then
		DIGITALKNOB="/c/Users/$USERNAME/digitalknob"
	elif [[ "$OSTYPE" == "msys" ]]; then
		DIGITALKNOB="/c/Users/$USERNAME/digitalknob"
	elif [[ "$OSTYPE" == "win32" ]]; then #I'm not sure this can happen
		DIGITALKNOB="/c/Users/$USERNAME/digitalknob" 
	elif [[ "$OSTYPE" == "freebsd"* ]]; then
		echo "TODO: freebsd builder incomplete"
	elif [[ "$OSTYPE" == "linux-android" ]]; then
		DIGITALKNOB="/data/data/com.termux/files/home/digitalknob"
	else
		error "UNKNOWN OS ($OSTYPE)"
	fi
}

###### validate_branch ######
function validate_branch() {
	# If the current folder matches the current branch set DKBRANCH, default to Development
	
	FOLDER="$(basename $(pwd))"
	DKBRANCH="Development"
	
	if file_exists .git; then
		BRANCH="$($GIT rev-parse --abbrev-ref HEAD)"
		if [[ "$BRANCH" == "$FOLDER" ]]; then
			DKBRANCH="$FOLDER"
		fi
	fi
	
	#echo "$\DKBRANCH = $DKBRANCH"
	DKPATH="$DIGITALKNOB/$DKBRANCH"
	DKCMAKE="$DKPATH/DKCMake"
	DK3RDPARTY="$DKPATH/3rdParty"
	DKIMPORTS="$DK3RDPARTY/_DKIMPORTS"

	# make sure script is running from DKPATH
	#if ! [[ "$SCRIPTPATH" == "$DKPATH" ]]; then
	#	if ! file_exists $DKPATH/$SCRIPTNAME; then
	#		echo "$DKPATH/$SCRIPTNAME"
	#		cp $SCRIPTPATH/$SCRIPTNAME $DKPATH/$SCRIPTNAME
	#	fi
	#	echo .
	#	echo "RELOADING SCRIPT TO -> $DKPATH/$SCRIPTNAME"
	#	read -p "Press enter to continue"
	#	clear
	#	if file_exists $DKPATH/$SCRIPTNAME; then
	#		rm $SCRIPTPATH/$SCRIPTNAME
	#	fi
	#	$DKPATH/$SCRIPTNAME
	#	exit
	#fi
}

###### clear_cmake_cache ######
function clear_cmake_cache() {
	echo "Clearing CMake cache . . ."
	cd $DIGITALKNOB
	find . -name "CMakeCache.*" -delete
	rm -rf `find . -type d -name CMakeFiles`
}

###### delete_temp_files ######
function delete_temp_files() {
	echo "Deleting .TMP files . . ."
	cd $DIGITALKNOB
	rm -rf `find . -type d -name *.tmp`
	rm -rf `find . -type d -name *.TMP`
	find . -name "*.tmp" -delete
	find . -name "*.TMP" -delete
}

###### validate_msys2 ######
function validate_msys2() {
	cmake_eval "include('$DKIMPORTS/msys2/DKMAKE.cmake')" "MSYS2"
	echo "MSYS2 = $MSYS2"
}

###### validate_make ######
function validate_make() {
	cmake_eval "include('$DKIMPORTS/make/DKMAKE.cmake')" "MAKE_PROGRAM"
	echo "MAKE_PROGRAM = $MAKE_PROGRAM"
}

###### validate_emscripten ######
function validate_emscripten() {
	cmake_eval "include('$DKIMPORTS/emsdk/DKMAKE.cmake')" "EMSDK;EMSDK_ENV;EMSDK_GENERATOR;EMSDK_TOOLCHAIN_FILE;EMSDK_C_COMPILER;EMSDK_CXX_COMPILER"
	echo "EMSDK = $EMSDK"
	echo "EMSDK_ENV = $EMSDK_ENV"
	echo "EMSDK_GENERATOR = $EMSDK_GENERATOR"
	echo "EMSDK_TOOLCHAIN_FILE = $EMSDK_TOOLCHAIN_FILE"
	echo "EMSDK_C_COMPILER = $EMSDK_C_COMPILER"
	echo "EMSDK_CXX_COMPILER = $EMSDK_CXX_COMPILER"
}

###### validate_android_ndk ######
function validate_android_ndk() {
	cmake_eval "include('$DKIMPORTS/android-ndk/DKMAKE.cmake')" "ANDROID_API;ANDROID_NDK;ANDROID_TOOLCHAIN_FILE"	
	echo "ANDROID_API = $ANDROID_API"
	echo "ANDROID_NDK = $ANDROID_NDK"
	echo "ANDROID_TOOLCHAIN_FILE = $ANDROID_TOOLCHAIN_FILE"
}

###### validate_clang ######
function validate_clang() {
	cmake_eval "include('$DKIMPORTS/clang/DKMAKE.cmake')" "CLANG_C_COMPILER;CLANG_CXX_COMPILER"
	echo "CLANG_C_COMPILER = $CLANG_C_COMPILER"
	echo "CLANG_CXX_COMPILER = $CLANG_CXX_COMPILER"
}

###### validate_gcc ######
function validate_gcc() {
	cmake_eval "include('$DKIMPORTS/gcc/DKMAKE.cmake')" "GCC_C_COMPILER;GCC_CXX_COMPILER"
	echo "GCC_C_COMPILER = $GCC_C_COMPILER"
	echo "GCC_CXX_COMPILER = $GCC_CXX_COMPILER"
}
			
### cmake_eval <cmake_commands;.;.;> <return_variables;.;.;.> <-DVARS;.;.;>
function cmake_eval() {
	if [ -z "$1" ]; then
		echo "ERROR: cmake_eval() parameter 1 is invalid"
		return $false
	fi
	
	commands="$1"
	variables="$2"
	#set commands=$commands:"=%"  #TODO: remove double quotes
	DKCOMMAND="$commands"
	echo "DKCOMMAND = $DKCOMMAND"
	
	if [[ -n "$variables" ]]; then
		dk_call $CMAKE "-DDKCMAKE=$DKCMAKE" "-DDKCOMMAND=$DKCOMMAND" "-DDKRETURN=$2" $3 -P $DKCMAKE/dev/cmake_eval.cmake
		if file_exists $DKCMAKE/cmake_vars.sh; then
	    	echo "executing cmake_vars.sh"
			source $DKCMAKE/cmake_vars.sh
			#rm $DKCMAKE/cmake_vars.sh
		fi
	else
		dk_call $CMAKE -DDKCMAKE=$DKCMAKE -DDKCOMMAND=$DKCOMMAND -P $DKCMAKE/dev/cmake_eval.cmake
	fi
	
	#echo return code: $?
}

function push_assets() {
	if CONFIRM; then return; fi
	
	echo "not implemented,  TODO"
}

function pull_assets() {
	if CONFIRM; then return; fi
	
	echo "not implemented,  TODO"
}

function reset_apps() {
	if CONFIRM; then return; fi
	
	cd $DKPATH/DKApps
	$GIT clean -f -d
}

function reset_3rdpaty() {
	if CONFIRM; then return; fi
	
	cd $DKPATH/3rdParty
	$GIT clean -f -d
}

function reset_plugins() {
	if CONFIRM; then return; fi
	
	cd $DKPATH/DKPlugins
	$GIT clean -f -d
}

function reset_all() {

if ! [ "$1" == "wipe" ]; then
		
	clear
	echo ""
	echo ""
	echo "Do you want to reset the entire local repository . . . ?"
	echo "This will delete digitalknob, everything will be reset,"
	echo "and the repository will be re-cloned. All libraries and tools"
	echo "will be redownloaded and rebuild from start. Save any changes"
	echo "you wish to commit or save beforehand."
	echo ""
	
	if CONFIRM; then return; fi
	
	# first we need to relocate this file up one directory
	# make sure script is running from DKPATH
	if ! [ $SCRIPTPATH == $DKPATH ]; then
		echo "WARNING: this file isn't running from the branch directory"
		echo "Is must be in the branch directory to continue."
		echo "SCRIPTPATH = $SCRIPTPATH"
		echo "DKPATH = $DKPATH"
		return 1;
	fi
	
	echo "RELOCATING SCRIPT TO -> $DIGITALKNOB/$SCRIPTNAME"
	cp $SCRIPTPATH/$SCRIPTNAME $DIGITALKNOB/$SCRIPTNAME
	source "$DIGITALKNOB/$SCRIPTNAME" reset_all wipe
	exit
else	
	#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	#:wipe
	
	#do we need admin rights?
	#runas /user:Administrator cmd
	
	#do we need to kill any processes?
	
	#do we need to uninstall any apps?
	
	#do we need to remove any environment variables?
	
	#should we do a git clean first?
	#cd %DKPATH%
	#"%GIT%" clean -f -d
	
	cd $DIGITALKNOB
	echo ""
	echo "DELETING $DKDOWNLOAD . . . ."
	rm -r -f $DKDOWNLOAD
	echo "done."
	echo ""
	echo "DELETING $DKPATH . . . ."
	rm -r -f $DKPATH
	echo "done."
	
	# wait 10 seconds at lease for the folders to get deleted
	sleep 10
	
	if file_exists $DKDOWNLOAD; then
		echo "Oh no, the downloads folder is still there! :( "
	fi
	if file_exists $DKPATH; then
		echo "Oh no, the BRANCH folder is still there! :( "
	fi
	
	git_update NO_CONFIRM
	
	# wait a few seconds for build.sh to show up
	sleep 5
	
	if file_exists $DKPATH/$SCRIPTNAME; then
		clear
		source $DKPATH/$SCRIPTNAME rm -r $DIGITALKNOB/$SCRIPTNAME
		exit
	else
		echo "Oh no, the git cloned build.sh still isn't here! :( "
	fi
fi
}

function git_update() {
	
	if ! [ "$1" == "NO_CONFIRM" ]; then
		echo "Git Update? Any local changes will be lost."
		if CONFIRM; then return; fi
	fi

	if [[ ! -d "$DKPATH/.git" ]]; then
		dk_call $GIT clone https://github.com/aquawicket/DigitalKnob.git $DKPATH
	fi
	dk_call cd $DKPATH
	dk_call $GIT pull --all
	dk_call $GIT checkout -- .
	dk_call $GIT checkout $DKBRANCH
	if [[ "$?" == "0" ]]; then
		echo "$DKBRANCH branch selected"
	else
	echo "Remote has no $DKBRANCH branch. Creating..."
		dk_call $GIT checkout -b $DKBRANCH main
		dk_call $GIT push --set-upstream origin $DKBRANCH
	fi
	dk_call chmod +x $DKPATH/build.sh
}

function git_commit() {	
	
	echo "Please enter some details about this commit, Then press enter."
	read message
	
	cd $DKPATH
	USER_EMAIL=$($GIT config --global user.email)
	if ! [[ -n "USER_EMAIL" ]]; then
		$GIT config --global user.email $GIT_USER_EMAIL
	fi
	USER_NAME=$($GIT config --global user.name)
	if ! [[ -n "USER_NAME" ]]; then
		$GIT config --global user.name $GIT_USER_NAME
	fi
	STORE=$($GIT config credential.helper)
	if [[ "$STORE" == "store" ]]; then
		$GIT config --global credential.helper store
	fi
    
	if ! [[ -n "$message" ]]; then
		message="git commit"
	fi
	
	echo ""
	echo "git commit \"${message}\""
	if CONFIRM; then return; fi
	
	dk_call $GIT commit -a -m "${message}"
    dk_call $GIT push
}

function enter_manually() {
	echo "Please type the name of the library, tool or app to build. Then press enter."
	read input
	
	APP="_${input}_"
	
	#Search digitalknob for the matching entry containing a DKMAKE.cmake file  
	if test -f $DKPATH/3rdParty/_DKIMPORTS/$input/DKMAKE.cmake; then
		TARGET_PATH=$DKPATH/3rdParty/_DKIMPORTS/$input
	fi
	if test -f $DKPATH/DKPlugins/$input/DKMAKE.cmake; then
		TARGET_PATH=$DKPATH/DKPlugins/$input
	fi
	if test -f $DKPATH/DKApps/$input/DKMAKE.cmake; then
		TARGET_PATH=$DKPATH/DKApps/$input
		return 0
	fi
	if [ ! -d $DKPATH/DKApps/$APP ]; then
		mkdir -p $DKPATH/DKApps/$APP;
	fi
	echo "dk_depend($input)" > $DKPATH/DKApps/$APP/DKMAKE.cmake
	
	echo ""
	echo "$input" 
	echo "TARGET_PATH = $TARGET_PATH"
}


main "$@"

#} |& tee build.log

#exec $SHELL		# keep terminal open