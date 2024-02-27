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

	# log to stdout and file
	#exec |& tee file.log 

	# UNIX Environment Variables
	print_var SHLVL			# https://stackoverflow.com/a/4511483/688352
	print_var HOSTNAME
	print_var HOSTTYPE
	print_var MACHTYPE
	if [ -e /proc/device-tree/model ]; then
		MODEL=$(tr -d '\0' </proc/device-tree/model)
	fi
	print_var MODEL
	print_var MSYSTEM
	print_var OSTYPE
	print_var SCRIPTNAME
	print_var SCRIPTPATH
	print_var USER
	print_var USERNAME
	echo ""
	
	# https://llvm.org/doxygen/Triple_8h_source.html
	# NATIVE_OS
	
	if [[ "$MODEL" == "Raspberry"* ]]; then
		NATIVE_OS="raspberry"
	elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
		NATIVE_OS="linux"
	elif [[ "$OSTYPE" == "darwin"* ]]; then
		NATIVE_OS="mac"
	elif [[ "$OSTYPE" == "linux-android" ]]; then
		NATIVE_OS="android"
	elif [[ "$OSTYPE" == "msys" ]]; then
		NATIVE_OS="win"
	else
		echo "Unknown NATIVE_OS"
	fi
	print_var NATIVE_OS
	
	# NATIVE_ARCH
	if [[ "$HOSTTYPE" == "x86" ]]; then
		NATIVE_ARCH="x86"
	elif [[ "$HOSTTYPE" == "x86_64"* ]]; then
		NATIVE_ARCH="x86_64"
	elif [[ "$HOSTTYPE" == "aarch64"* ]]; then
		NATIVE_ARCH="arm64"
	else
		echo "Unknown NATIVE_ARCH"
	fi
	print_var NATIVE_ARCH
	
	# NATIVE_TRIPLE
	NATIVE_TRIPLE=${NATIVE_OS}_${NATIVE_ARCH}
	print_var NATIVE_TRIPLE
	echo ""
	

	if [[ -n "$USERPROFILE" ]]; then
		DIGITALKNOB="$USERPROFILE\digitalknob"
		DIGITALKNOB=$(sed 's.C:./c.g' <<< $DIGITALKNOB)
		DIGITALKNOB=$(sed 's.\\./.g' <<< $DIGITALKNOB)
	else
		DIGITALKNOB="$HOME/digitalknob"
	fi

	mkdir -p $DIGITALKNOB;
	print_var DIGITALKNOB

	DKDOWNLOAD="$DIGITALKNOB/download"
	mkdir -p $DKDOWNLOAD;
	print_var DKDOWNLOAD

	if [[ "$OSTYPE" == "darwin"* ]]; then
		validate_homebrew
	fi

	validate_which
	validate_cmake
	validate_git
	validate_branch

	print_var DKPATH
	print_var DKCMAKE
	print_var DK3RDPARTY
	print_var DKIMPORTS

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
	
	#read_cache
	
	echo ""	
    echo " 1) Git Update"
    echo " 2) Git Commit"
    echo " 3) Push assets"
    echo " 4) Pull assets"
    echo " 5) Reset All"
	echo " 6) Remove All"
    echo " 7) Clear Screen"
    echo " 8) Clear cmake cache and .tmp files"
    echo " 9) Reload"
    echo "10) Exit"
    echo "" 
    echo " Press Enter To Skip"
	
	read input
	if [ "$input" == "1" ]; then
		git_update
	elif [ "$input" == "2" ]; then
		git_commit
	elif [ "$input" == "3" ]; then
		push_assets
	elif [ "$input" == "4" ]; then
		pull_assets
	elif [ "$input" == "5" ]; then
		reset_all
	elif [ "$input" == "6" ]; then
		remove_all
	elif [ "$input" == "7" ]; then
		clear
	elif [ "$input" == "8" ]; then
		clear_cmake_cache
		delete_temp_files
	elif [ "$input" == "9" ]; then
		reload
	elif [ "$input" == "10" ]; then
		exit 0	
	elif [ "$input" == "" ]; then
		UPDATE=1
	else
		echo "invalid selection"
	fi
}

###### Pick_App ######
function Pick_App() {
	
	echo ""	
    echo " 1) HelloWorld"
    echo " 2) DKCore"
    echo " 3) DKJavascript"
    echo " 4) DKBuilder"
    echo " 5) DKSDL"
    echo " 6) DKSDLRml"
    echo " 7) DKDomTest"
    echo " 8) DKTestAll"
    echo " 9) Enter Manually"
    echo "10) Clear Screen"
    echo "11) Go Back"
    echo "12) Reload"
	echo "13) Exit"
    echo "" 
	
	read input
	if [ "$input" == "1" ]; then
		APP="HelloWorld"
	elif [ "$input" == "2" ]; then
		APP="DKCore"
	elif [ "$input" == "3" ]; then
		APP="DKJavascript"
	elif [ "$input" == "4" ]; then
		APP="DKBuilder"
	elif [ "$input" == "5" ]; then
		APP="DKSDL"
	elif [ "$input" == "6" ]; then
		APP="DKSDLRml"
	elif [ "$input" == "7" ]; then
		APP="DKDomTest"
	elif [ "$input" == "8" ]; then
		APP="DKTestAll"
	elif [ "$input" == "9" ]; then
		enter_manually
	elif [ "$input" == "10" ]; then
		clear
	elif [ "$input" == "11" ]; then
		UPDATE=
	elif [ "$input" == "12" ]; then
		dk_call reload
	elif [ "$input" == "13" ]; then
		exit 0
	else
		echo "invalid selection"
	fi
}

###### Pick_OS ######
function Pick_OS() {
	
	echo ""	
    echo " 1) $NATIVE_TRIPLE"
	echo ""
	echo " 2) android arm32"
	echo " 3) android arm64"
	echo " 4) android x86"
	echo " 5) android x86_64"
	echo " 6) emscripten"
	echo " 7) ios arm32"
	echo " 8) ios arm64"
	echo " 9) ios x86"
	echo "10) ios x86_64"
	echo "11) iossim arm32"
	echo "12) iossim arm64"
	echo "13) iossim x86"
	echo "14) iossim x86_64"
	echo "15) linux arm32"
	echo "16) linux arm64"
	echo "17) linux x86"
	echo "18) linux x86_64"
	echo "19) mac arm32"
	echo "20) mac arm64"
	echo "21) mac x86"
	echo "22) mac x86_64"
	echo "23) raspberry arm32"
	echo "24) raspberry arm64"
	echo "25) raspberry x86"
	echo "26) raspberry x86_64"
	echo "27) win arm32"
	echo "28) win arm64"
	echo "29) win x86"
	echo "30) win x86_64"
	echo "31) Clear Screen"
	echo "32) Go Back"
	echo "33) Exit"
	echo "" 
	
	read input
	if [ "$input" == "1" ]; then
		TARGET_OS="$NATIVE_TRIPLE"
	elif [ "$input" == "2" ]; then
		TARGET_OS="android_arm32"
	elif [ "$input" == "3" ]; then
		TARGET_OS="android_arm64"
	elif [ "$input" == "4" ]; then
		TARGET_OS="android_x86"
	elif [ "$input" == "5" ]; then
		TARGET_OS="android_x64"
	elif [ "$input" == "6" ]; then
		TARGET_OS="emscripten"
	elif [ "$input" == "7" ]; then
		TARGET_OS="ios_arm32"
	elif [ "$input" == "8" ]; then
		TARGET_OS="ios_arm64"
	elif [ "$input" == "9" ]; then
		TARGET_OS="ios_x86"
	elif [ "$input" == "10" ]; then
		TARGET_OS="ios_x64"
	elif [ "$input" == "11" ]; then
		TARGET_OS="iossim_x86"
	elif [ "$input" == "12" ]; then
		TARGET_OS="iossim_x86_64"
	elif [ "$input" == "13" ]; then
		TARGET_OS="iossim_x86"
	elif [ "$input" == "14" ]; then
		TARGET_OS="iossim_x86_64"
	elif [ "$input" == "15" ]; then
		TARGET_OS="linux_arm32"
	elif [ "$input" == "16" ]; then
		TARGET_OS="linux_arm64"
	elif [ "$input" == "17" ]; then
		TARGET_OS="linux_x86"
	elif [ "$input" == "18" ]; then
		TARGET_OS="linux_x86_64"
	elif [ "$input" == "19" ]; then
		TARGET_OS="mac_arm32"
	elif [ "$input" == "20" ]; then
		TARGET_OS="mac_arm64"
	elif [ "$input" == "21" ]; then
		TARGET_OS="mac_x86"
	elif [ "$input" == "22" ]; then
		TARGET_OS="mac_x86_64"
	elif [ "$input" == "23" ]; then
		TARGET_OS="raspberry_arm32"
	elif [ "$input" == "24" ]; then
		TARGET_OS="raspberry_arm64"
	elif [ "$input" == "25" ]; then
		TARGET_OS="raspberry_x86"
	elif [ "$input" == "26" ]; then
		TARGET_OS="raspberry_x64"
	elif [ "$input" == "27" ]; then
		TARGET_OS="windows_arm32"
	elif [ "$input" == "28" ]; then
		TARGET_OS="windows_arm64"
	elif [ "$input" == "29" ]; then
		TARGET_OS="windows32"
	elif [ "$input" == "30" ]; then
		TARGET_OS="windows64"
	elif [ "$input" == "31" ]; then
		clear
	elif [ "$input" == "32" ]; then
		APP=
	elif [ "$input" == "33" ]; then
		exit 0
	else
		echo "invalid selection"
	fi
	return 0
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
	echo "****** Generating $APP - $TARGET_OS - $TYPE - $DKLEVEL ******"
	echo "##################################################################"
	echo ""

	clear_cmake_cache
	delete_temp_files

	TARGET_PATH=$DKPATH/DKApps/$APP
	print_var TARGET_PATH
	mkdir -p $TARGET_PATH/$TARGET_OS
	cd $TARGET_PATH/$TARGET_OS
	CMAKE_SOURCE_DIR=$DKCMAKE
	print_var CMAKE_SOURCE_DIR
	CMAKE_TARGET_PATH=$TARGET_PATH
	print_var CMAKE_TARGET_PATH
	
	###### BUILD CMAKE_ARGS ARRAY ######
	DKLEVEL="RebuildAll"
	DKLINK="Static"
	
	declare -a CMAKE_ARGS
	if [[ $TYPE == "Debug" ]]; then
		CMAKE_ARGS+=( "-DDEBUG=ON" )
		CMAKE_ARGS+=( "-DRELEASE=OFF" )
	fi
	if [[ $TYPE == "Release" ]]; then
		CMAKE_ARGS+=( "-DDEBUG=OFF" )
		CMAKE_ARGS+=( "-DRELEASE=ON" )
	fi
	if [[ $TYPE == "All" ]]; then
		CMAKE_ARGS+=( "-DDEBUG=ON" )
		CMAKE_ARGS+=( "-DRELEASE=ON" )
	fi
	if [[ $DKLEVEL == "Build" ]]; then
		CMAKE_ARGS+=( "-DBUILD=ON" )
	fi
	if [[ $DKLEVEL == "Rebuild" ]]; then
		CMAKE_ARGS+=( "-DREBUILD=ON" )
	fi
	if [[ $DKLEVEL == "RebuildAll" ]]; then
		CMAKE_ARGS+=( "-DREBUILDALL=ON" )
	fi
	if [[ $DKLINK == "Static" ]]; then
		CMAKE_ARGS+=( "-DSTATIC=ON" )
	fi
	if [[ $DKLINK == "Shared" ]]; then
		CMAKE_ARGS+=( "-DSHARED=ON" )
	fi
	
	CMAKE_BINARY_DIR=$CMAKE_TARGET_PATH/$TARGET_OS/$TYPE
	print_var CMAKE_BINARY_DIR
	
	CMAKE_ARGS+=( "-S=$CMAKE_SOURCE_DIR" )
	CMAKE_ARGS+=( "-B=$CMAKE_BINARY_DIR" )
	
	############ CMake Options ############
    #CMAKE_ARGS+=( "-DCMAKE_VERBOSE_MAKEFILE=1" ) 
    #CMAKE_ARGS+=( "--debug-output" )
	#CMAKE_ARGS+=( "--trace" )
	#CMAKE_ARGS+=( "--warn-unused-vars" )
	
	#echo CMAKE_ARGS = "${CMAKE_ARGS[@]}"
	
	#if [[ "$TYPE" == "Debug" ]] || [[ "$TYPE" == "All" ]]; then
	#	mkdir -p $CMAKE_TARGET_PATH/$TARGET_OS/Debug
	#fi
	#if [[ "$TYPE" == "Release" ]] || [[ "$TYPE" == "All" ]]; then
	#	mkdir -p $CMAKE_TARGET_PATH/$TARGET_OS/Release
	#fi
	
	
	###### GENERATOR ######
	#if [[ $TARGET_OS == "android"* ]]; then
	#	GENERATOR="Unix Makefiles"
	#elif [[ $TARGET_OS == "mac"* ]] || [[ $TARGET_OS == "ios"* ]]; then
	#	GENERATOR="Xcode"
	#elif [[ $TARGET_OS == "emscripten" ]]; then
	#	validate_emscripten
	#	GENERATOR="$EMSDK_GENERATOR"
	#	CMAKE_ARGS+=( "-DCMAKE_C_COMPILER=$EMSDK_C_COMPILER" )
	#	CMAKE_ARGS+=( "-DCMAKE_CXX_COMPILER=$EMSDK_CXX_COMPILER" )
	#	CMAKE_ARGS+=( "-DCMAKE_TOOLCHAIN_FILE=$EMSDK_TOOLCHAIN_FILE" )
	#	MSYSTEM=""
	#elif [[ -n "$MSYSTEM" ]]; then
	#	GENERATOR="MSYS Makefiles"
	#else
	#	GENERATOR="Unix Makefiles"
	#fi

	###### MAKE_PROGRAM ######
	#validate_make
	#if [[ -n "$MAKE_PROGRAM" ]]; then
	#	CMAKE_ARGS+=( "-DCMAKE_MAKE_PROGRAM=$MAKE_PROGRAM" )
	#fi
	
	###### C_COMPILER; CXX_COMPILER ######
	### GCC ###
	#if [[ $MSYSTEM == "MINGW32" ]] || [[ $MSYSTEM == "MINGW64" ]] || [[ $TARGET_OS == "linux"* ]] || [[ $MODEL == "Raspberry"* ]]; then
	#	validate_gcc
	#	CMAKE_ARGS+=( "-DCMAKE_C_COMPILER=$GCC_C_COMPILER" )
	#	CMAKE_ARGS+=( "-DCMAKE_CXX_COMPILER=$GCC_CXX_COMPILER" )
	#fi
	### CLANG ###
	#if [[ $MSYSTEM == "CLANG32" ]] || [[ $MSYSTEM == "CLANG64" ]] || [[ $MSYSTEM == "CLANGARM64" ]] || [[ $MSYSTEM == "UCRT64" ]]; then
	#	validate_clang
	#	CMAKE_ARGS+=( "-DCMAKE_C_COMPILER=$CLANG_C_COMPILER" )
	#	CMAKE_ARGS+=( "-DCMAKE_CXX_COMPILER=$CLANG_CXX_COMPILER" )
	#fi
	
	###### EXE_LINKER_FLAGS ######
	#if [[ -n "$MSYSTEM" ]]; then
	#	EXE_LINKER_FLAGS="-static -mconsole"		
	#	#CMAKE_ARGS+=( "-DCMAKE_EXE_LINKER_FLAGS=$EXE_LINKER_FLAGS" )
	#fi

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
	
	#mkdir -p $DKPATH/DKApps/$APP/$TARGET_OS
	#cd /
	
	#if [[ "$TYPE" == "Debug" ]] || [[ "$TYPE" == "All" ]]; then
	#	mkdir -p $DKPATH/DKApps/$APP/$TARGET_OS/Debug
	#fi
	#if [[ "$TYPE" == "Release" ]] || [[ "$TYPE" == "All" ]]; then
	#	mkdir -p $DKPATH/DKApps/$APP/$TARGET_OS/Release
	#fi
	
	if [[ "$TARGET_OS" == "android_arm32" ]]; then
		validate_android_ndk
	
		#CMAKE_ARGS+=( "-G 'Unix Makefiles'" )
		CMAKE_ARGS+=( "-DCMAKE_MAKE_PROGRAM=$ANDROID_NDK/prebuilt/linux-x86_64/bin/make" )
		CMAKE_ARGS+=( "-DCMAKE_ANDROID_ARCH_ABI=armeabi-v7a" )
		CMAKE_ARGS+=( "-DANDROID_ABI=armeabi-v7a" )
		CMAKE_ARGS+=( "-DANDROID_PLATFORM=$ANDROID_API" )
		CMAKE_ARGS+=( "-DCMAKE_ANDROID_NDK=$ANDROID_NDK" )
		CMAKE_ARGS+=( "-DANDROID_NDK=$ANDROID_NDK" )
		CMAKE_ARGS+=( "-DCMAKE_TOOLCHAIN_FILE=$ANDROID_TOOLCHAIN_FILE" )
		CMAKE_ARGS+=( "-DANDROID_TOOLCHAIN=clang" )
		CMAKE_ARGS+=( "-DCMAKE_ANDROID_STL_TYPE=c++_static" )
		CMAKE_ARGS+=( "-DANDROID_STL=c++_static" )
		#CMAKE_ARGS+=( "-DCMAKE_CXX_FLAGS='-std=c++1z -frtti -fexceptions'" )
	
		echo ""
		echo "****** CMAKE COMMAND ******"
		echo $CMAKE -G "Unix Makefiles" "${CMAKE_ARGS[@]}" -DCMAKE_CXX_FLAGS="-std=c++1z -frtti -fexceptions"
		echo ""
		dk_call $CMAKE -G "Unix Makefiles" "${CMAKE_ARGS[@]}" -DCMAKE_CXX_FLAGS="-std=c++1z -frtti -fexceptions"
	
		TARGET="main"	
	fi

	if [[ "$TARGET_OS" == "android_arm64" ]]; then
		validate_android_ndk
	
		#CMAKE_ARGS+=( "-G 'Unix Makefiles'" )
		CMAKE_ARGS+=( "-DCMAKE_MAKE_PROGRAM=$ANDROID_NDK/prebuilt/linux-x86_64/bin/make" )
		CMAKE_ARGS+=( "-DCMAKE_ANDROID_ARCH_ABI=arm64-v8a" )
		CMAKE_ARGS+=( "-DANDROID_ABI=arm64-v8a" )
		CMAKE_ARGS+=( "-DANDROID_PLATFORM=$ANDROID_API" )
		CMAKE_ARGS+=( "-DCMAKE_ANDROID_NDK=$ANDROID_NDK" )
		CMAKE_ARGS+=( "-DANDROID_NDK=$ANDROID_NDK" )
		CMAKE_ARGS+=( "-DCMAKE_TOOLCHAIN_FILE=$ANDROID_TOOLCHAIN_FILE" )
		CMAKE_ARGS+=( "-DANDROID_TOOLCHAIN=clang" )
		CMAKE_ARGS+=( "-DCMAKE_ANDROID_STL_TYPE=c++_static" )
		CMAKE_ARGS+=( "-DANDROID_STL=c++_static" )
		#CMAKE_ARGS+=( "-DCMAKE_CXX_FLAGS='-std=c++1z -frtti -fexceptions'" )
	
		echo ""
		echo "****** CMAKE COMMAND ******"
		echo $CMAKE -G "Unix Makefiles" "${CMAKE_ARGS[@]}" -DCMAKE_CXX_FLAGS="-std=c++1z -frtti -fexceptions"
		echo ""
		dk_call $CMAKE -G "Unix Makefiles" "${CMAKE_ARGS[@]}" -DCMAKE_CXX_FLAGS="-std=c++1z -frtti -fexceptions"
	
		TARGET="main"
	fi
	
	
	if [[ $TARGET_OS == "emscripten" ]]; then
		#setx PATH %PATH%;C:\Users\aquawicket\digitalknob\Development\3rdParty\python-2.7.18
		validate_emscripten
	
		CMAKE_ARGS+=( "-G $EMSDK_GENERATOR" )
		CMAKE_ARGS+=( "-DCMAKE_TOOLCHAIN_FILE=$EMSDK_TOOLCHAIN_FILE" )
		CMAKE_ARGS+=( "-DCMAKE_C_COMPILER=$EMSDK_C_COMPILER" )
		CMAKE_ARGS+=( "-DCMAKE_CXX_COMPILER=$EMSDK_CXX_COMPILER" )
	
		echo ""
		echo "****** CMAKE COMMAND ******"
		#echo $EMSDK_ENV && $CMAKE -G "$EMSDK_GENERATOR" "${CMAKE_ARGS[@]}"
		#echo $EMSDK_ENV && $CMAKE "${CMAKE_ARGS[@]}"
		echo ""
		#dk_call $EMSDK_ENV && $CMAKE -G "$EMSDK_GENERATOR" "${CMAKE_ARGS[@]}"
		dk_call $EMSDK_ENV && dk_call $CMAKE "${CMAKE_ARGS[@]}"
	
		set TARGET=${APP}_APP
	
	    #dk_call validate_emscripten
		#if [[ "$TYPE" == "Debug" ]] || [[ "$TYPE" == "All" ]]; then
		#	dk_call $EMSDK_ENV && $CMAKE -G "$GENERATOR" "${CMAKE_ARGS[@]}" -S$DKCMAKE -B$DKPATH/DKApps/$APP/$TARGET_OS/Debug
		#fi
		#if [[ "$TYPE" == "Release" ]] || [[ "$TYPE" == "All" ]]; then
		#	dk_call $EMSDK_ENV && $CMAKE -G "$GENERATOR" "${CMAKE_ARGS[@]}" -S$DKCMAKE -B$DKPATH/DKApps/$APP/$TARGET_OS/Release
		#fi
		#TARGET=${APP}_APP
	fi
	
	
	if [[ "$TARGET_OS" == "ios_arm32" ]]; then
		dk_call $CMAKE -G "$GENERATOR" -DCMAKE_TOOLCHAIN_FILE=$DKCMAKE/ios.toolchain.cmake -DPLATFORM=TARGET_OS -DSDK_VERSION=15.0 -DDEPLOYMENT_TARGET=13.0 "${CMAKE_ARGS[@]}" -S$DKCMAKE -B$DKPATH/DKApps/$APP/$TARGET_OS
	fi
	if [[ "$TARGET_OS" == "ios_arm64" ]]; then
		dk_call $CMAKE -G "$GENERATOR" -DCMAKE_TOOLCHAIN_FILE=$DKCMAKE/ios.toolchain.cmake -DPLATFORM=OS64 -DSDK_VERSION=15.0 -DDEPLOYMENT_TARGET=13.0 "${CMAKE_ARGS[@]}" -S$DKCMAKE -B$DKPATH/DKApps/$APP/$TARGET_OS
	fi
	if [[ "$TARGET_OS" == "iossim_x86" ]]; then
		dk_call $CMAKE -G "$GENERATOR" -DCMAKE_TOOLCHAIN_FILE=$DKCMAKE/ios.toolchain.cmake -DPLATFORM=SIMULATOR -DSDK_VERSION=15.0 -DDEPLOYMENT_TARGET=13.0 "${CMAKE_ARGS[@]}" -S$DKCMAKE -B$DKPATH/DKApps/$APP/$TARGET_OS
	fi
	if [[ "$TARGET_OS" == "iossim_x86_64" ]]; then
		dk_call $CMAKE -G "$GENERATOR" -DCMAKE_TOOLCHAIN_FILE=$DKCMAKE/ios.toolchain.cmake -DPLATFORM=SIMULATOR64 -DSDK_VERSION=15.0 -DDEPLOYMENT_TARGET=13.0 "${CMAKE_ARGS[@]}" -S$DKCMAKE -B$DKPATH/DKApps/$APP/$TARGET_OS
	fi
	
	if [[ "$TARGET_OS" == "linux_x86" ]]; then
		if [[ "$TYPE" == "Debug" ]] || [[ "$TYPE" == "All" ]]; then
			dk_call $CMAKE -G "$GENERATOR" "${CMAKE_ARGS[@]}" -S$DKCMAKE -B$DKPATH/DKApps/$APP/$TARGET_OS/Debug
		fi
		if [[ "$TYPE" == "Release" ]] || [[ "$TYPE" == "All" ]]; then
			dk_call $CMAKE -G "$GENERATOR" "${CMAKE_ARGS[@]}" -S$DKCMAKE -B$DKPATH/DKApps/$APP/$TARGET_OS/Release
		fi
		TARGET=${APP}_APP
	fi
	
	if [[ "$TARGET_OS" == "linux_x86_64" ]]; then
		if [[ "$TYPE" == "Debug" ]] || [[ "$TYPE" == "All" ]]; then
			dk_call $CMAKE -G "$GENERATOR" "${CMAKE_ARGS[@]}" -S$DKCMAKE -B$DKPATH/DKApps/$APP/$TARGET_OS/Debug
		fi
		if [[ "$TYPE" == "Release" ]] || [[ "$TYPE" == "All" ]]; then
			dk_call $CMAKE -G "$GENERATOR" "${CMAKE_ARGS[@]}" -S$DKCMAKE -B$DKPATH/DKApps/$APP/$TARGET_OS/Release
		fi
		TARGET=${APP}_APP
	fi
	
	if [[ "$TARGET_OS" == "mac_x86" ]]; then
		dk_call $CMAKE -G "$GENERATOR" -DMAC_X86=ON -DCMAKE_OSX_ARCHITECTURES=i686 "${CMAKE_ARGS[@]}" -S$DKCMAKE -B$DKPATH/DKApps/$APP/$TARGET_OS
	fi
	
	if [[ "$TARGET_OS" == "mac_x86_64" ]]; then
		dk_call $CMAKE -G "$GENERATOR" -DMAC_X86_64=ON -DCMAKE_OSX_ARCHITECTURES=x86_64 "${CMAKE_ARGS[@]}" -S$DKCMAKE -B$DKPATH/DKApps/$APP/$TARGET_OS
		TARGET=${APP}_APP
	fi
	
	if [[ "$TARGET_OS" == "raspberry_arm32" ]]; then
		if [[ "$TYPE" == "Debug" ]] || [[ "$TYPE" == "All" ]]; then
			dk_call $CMAKE -G "$GENERATOR" "${CMAKE_ARGS[@]}" -S$DKCMAKE -B$DKPATH/DKApps/$APP/$TARGET_OS/Debug
		fi
		if [[ "$TYPE" == "Release" ]] || [[ "$TYPE" == "All" ]]; then
			dk_call $CMAKE -G "$GENERATOR" "${CMAKE_ARGS[@]}" -S$DKCMAKE -B$DKPATH/DKApps/$APP/$TARGET_OS/Release
		fi
		TARGET=${APP}_APP
	fi
	
	if [[ "$TARGET_OS" == "raspberry_arm64" ]]; then
		if [[ "$TYPE" == "Debug" ]] || [[ "$TYPE" == "All" ]]; then
			dk_call $CMAKE -G "$GENERATOR" "${CMAKE_ARGS[@]}" -S$DKCMAKE -B$DKPATH/DKApps/$APP/$TARGET_OS/Debug
		fi
		if [[ "$TYPE" == "Release" ]] || [[ "$TYPE" == "All" ]]; then
			dk_call $CMAKE -G "$GENERATOR" "${CMAKE_ARGS[@]}" -S$DKCMAKE -B$DKPATH/DKApps/$APP/$TARGET_OS/Release
		fi
		TARGET=${APP}_APP
	fi
	
	if [[ "$TARGET_OS" == "win_x86" ]]; then
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
	
	if [[ "$TARGET_OS" == "win_x86_64" ]]; then
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
	echo "****** Building $APP - $TARGET_OS - $TYPE - $DKLEVEL ******"
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
	echo "****** Done Building $APP - $TARGET_OS - $TYPE - $DKLEVEL ******"
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
	print_var WHICH
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
	print_var CMAKE
}

###### validate_git ######
function validate_git() {
	if ! command_exists git; then
		install git
	fi
	
	GIT=$(which git)
	print_var GIT
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
	print_var BREW
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
	
	print_var DKBRANCH
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
	print_var MSYS2
}

###### validate_make ######
function validate_make() {
	cmake_eval "include('$DKIMPORTS/make/DKMAKE.cmake')" "MAKE_PROGRAM"
	print_var MAKE_PROGRAM
}

###### validate_emscripten ######
function validate_emscripten() {
	cmake_eval "include('$DKIMPORTS/emsdk/DKMAKE.cmake')" "EMSDK;EMSDK_ENV;EMSDK_GENERATOR;EMSDK_TOOLCHAIN_FILE;EMSDK_C_COMPILER;EMSDK_CXX_COMPILER"
	print_var EMSDK
	print_var EMSDK_ENV
	print_var EMSDK_GENERATOR
	print_var EMSDK_TOOLCHAIN_FILE
	print_var EMSDK_C_COMPILER
	print_var EMSDK_CXX_COMPILER
}

###### validate_android_ndk ######
function validate_android_ndk() {
	cmake_eval "include('$DKIMPORTS/android-ndk/DKMAKE.cmake')" "ANDROID_API;ANDROID_NDK;ANDROID_TOOLCHAIN_FILE"	
	print_var ANDROID_API
	print_var ANDROID_NDK
	print_var ANDROID_TOOLCHAIN_FILE
}

###### validate_clang ######
function validate_clang() {
	cmake_eval "include('$DKIMPORTS/clang/DKMAKE.cmake')" "CLANG_C_COMPILER;CLANG_CXX_COMPILER"
	print_var CLANG_C_COMPILER
	print_var CLANG_CXX_COMPILER
}

###### validate_gcc ######
function validate_gcc() {
	cmake_eval "include('$DKIMPORTS/gcc/DKMAKE.cmake')" "GCC_C_COMPILER;GCC_CXX_COMPILER"
	print_var GCC_C_COMPILER
	print_var GCC_CXX_COMPILER
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
	print_var DKCOMMAND
	
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
			print_var DKPATH
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


function remove_all() {
	if ! [ "$1" == "wipe" ]; then	
		clear
		echo ""
		echo ""
		echo "Do you want to remove the entire local repository . . . ?"
		echo "This will delete digitalknob, Save any changes"
		echo "you wish to commit or save beforehand."
		echo ""
		
		if CONFIRM; then return; fi
		
		# first we need to relocate this file up one directory
		# make sure script is running from DKPATH
		if ! [ $SCRIPTPATH == $DKPATH ]; then
			echo "WARNING: this file isn't running from the branch directory"
			echo "Is must be in the branch directory to continue."
			echo "SCRIPTPATH = $SCRIPTPATH"
			print_var DKPATH
			return 1;
		fi
		
		echo "RELOCATING SCRIPT TO -> $DIGITALKNOB/$SCRIPTNAME"
		cp $SCRIPTPATH/$SCRIPTNAME $DIGITALKNOB/$SCRIPTNAME
		source "$DIGITALKNOB/$SCRIPTNAME" remove_all wipe
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
	
	STORE=$($GIT config credential.helper)
	print_var STORE
	if [ -z "$STORE" ]; then
		$GIT config --global credential.helper store
		echo ""
		echo "git credential.helper is now set to store"
		echo ""
	fi
	
	USER_EMAIL=$($GIT config --global user.email)
	if [ -z "$USER_EMAIL" ]; then
		echo ""
		echo "please enter an email address"
		read input
		$GIT config --global user.email "$input"
		echo ""
		echo "git user.email '$input' saved"
		echo ""
	fi

	USER_NAME=$($GIT config --global user.name)
	if [ -z "USER_NAME" ]; then
		echo ""
		echo "please enter a username"
		read input
		$GIT config --global user.name "$input"
		echo ""
		echo "git user.name '$input' saved"
		echo ""
	fi
	
    
	if [ -z "$message" ]; then
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
	#print_var input
	
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
	print_var TARGET_PATH
	
	if [ ! -d $DKPATH/DKApps/$APP ]; then
		mkdir -p $DKPATH/DKApps/$APP;
	fi
	
	# create DKApps/<APP>/DKMAKE.cmake 
	echo "dk_depend($input)" > $DKPATH/DKApps/$APP/DKMAKE.cmake
	
	# create DKApps/<APP>/main.cpp
	echo "int main(int argc, char** argv) { return 0; }" > $DKPATH/DKApps/$APP/main.cpp
}

function create_cache() {
	echo "creating cache..."
	#print_var APP
	#print_var TARGET_OS
	#print_var TYPE
	#print_var DKLEVEL
	
	# write variable values line by line
	echo "$APP">"$DKPATH/cache"
	echo "$TARGET_OS">>"$DKPATH/cache"
	echo "$TYPE">>"$DKPATH/cache"
	#echo "$DKLEVEL">>"$DKPATH/cache"
}

function read_cache() {
	echo "reading cache..."
	count=0
	while read p; do
		#echo "$count: $p"
		if [ $count == 0 ]; then 
			_APP_="$p"
		fi
		if [ $count == 1 ]; then
			_TARGET_OS_="$p"
		fi
		if [ $count == 2 ]; then
			_TYPE_="$p"
		fi
		#if [ $count == 3 ]; then
		#	_DKLEVEL_="$p"
		#fi

		(( count++ ))
	done < $DKPATH/cache
	
	#print_var _APP_
	#print_var _TARGET_OS_
	#print_var _TYPE_
	#print_var _DKLEVEL_
}

function print_var() {
	var=$1
	if [ -z "${!var}" ]; then
		echo "$1 = !!!INVALID!!!"
	else
		echo "$1 = ${!var}"
	fi
}


main "$@"

#} |& tee build.log

#exec $SHELL		# keep terminal open