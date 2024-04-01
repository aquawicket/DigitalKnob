#! /bin/bash

###### Global Script Variables ######
LOG_DEBUG=1
SCRIPT_DIR=$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )
SCRIPT_NAME=$(basename "$0")
true=0
false=1
CLR="\033[0m"
black="\033[100m"
red="\033[31m"
green="\033[32m"
yellow="\033[33m"
blue="\033[34m"
magenta="\033[35m"
cyan="\033[36m"
white="\033[37m"

CMAKE_DL_WIN_X86=https://github.com/Kitware/CMake/releases/download/v3.29.0/cmake-3.29.0-windows-i386.zip
CMAKE_DL_WIN_X86_64=https://github.com/Kitware/CMake/releases/download/v3.29.0/cmake-3.29.0-windows-x86_64.zip
CMAKE_DL_WIN_ARM64=https://github.com/Kitware/CMake/releases/download/v3.29.0/cmake-3.29.0-windows-arm64.zip
CMAKE_DL_MAC=https://github.com/Kitware/CMake/releases/download/v3.29.0/cmake-3.29.0-macos-universal.tar.gz
CMAKE_DL_MAC=https://github.com/Kitware/CMake/releases/download/v3.29.0/cmake-3.29.0-macos10.10-universal.tar.gz
CMAKE_DL_LINUX_X86_64=https://github.com/Kitware/CMake/releases/download/v3.29.0/cmake-3.29.0-linux-x86_64.tar.gz
CMAKE_DL_LINUX_ARM64=https://github.com/Kitware/CMake/releases/download/v3.29.0/cmake-3.29.0-linux-aarch64.tar.gz


###### main ######
function main() {
	dk_debug "main("$@")"
	dk_validate_sudo
	
	# if dk_command_exists bash; then echo "bash exists"; fi
	# log to stdout and file
	#exec |& tee file.log 

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
	print_var SCRIPT_NAME
	print_var SCRIPT_DIR
	print_var USER
	print_var USERNAME
	
	# https://llvm.org/doxygen/Triple_8h_source.html
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
	
	NATIVE_TRIPLE=${NATIVE_OS}_${NATIVE_ARCH}
	print_var NATIVE_TRIPLE
	
	if [[ -n "$USERPROFILE" ]]; then
		DIGITALKNOB_DIR="$USERPROFILE\digitalknob"
		DIGITALKNOB_DIR=$(sed 's.C:./c.g' <<< $DIGITALKNOB_DIR)
		DIGITALKNOB_DIR=$(sed 's.\\./.g' <<< $DIGITALKNOB_DIR)
	else
		DIGITALKNOB_DIR="$HOME/digitalknob"
	fi
	mkdir -p $DIGITALKNOB_DIR;
	print_var DIGITALKNOB_DIR

	DKDOWNLOAD_DIR="$DIGITALKNOB_DIR/download"
	mkdir -p $DKDOWNLOAD_DIR;
	print_var DKDOWNLOAD_DIR
	
	DKTOOLS_DIR="$DIGITALKNOB_DIR/DKTools"
	mkdir -p $DKTOOLS_DIR;
	print_var DKTOOLS_DIR

	if [[ "$OSTYPE" == "darwin"* ]]; then
		validate_homebrew
	fi

	#validate_cmake
	validate_git
	validate_branch

	print_var DKBRANCH_DIR
	print_var DKAPPS_DIR
	print_var DKCMAKE_DIR
	print_var DK3RDPARTY_DIR
	print_var DKIMPORTS_DIR
	print_var DKPLUGINS_DIR

	if [ ! $SCRIPT_DIR == $DKBRANCH_DIR ]; then
		dk_warning "$SCRIPT_NAME is not running from the DKBRANCH_DIR directory. Any changes will not be saved by git!"
		dk_warning "$SCRIPT_NAME path = $SCRIPT_DIR"
		dk_warning "DKBRANCH_DIR path = $DKBRANCH_DIR"
	fi
	
	while :
	do
		if ! [[ -n "$UPDATE" ]]; then Pick_Update;	continue; fi
		if ! [[ -n "$APP" ]]; then Pick_App;		continue; fi
		if ! [[ -n "$TARGET_OS" ]]; then Pick_OS;		continue; fi
		if ! [[ -n "$TYPE" ]]; then Pick_Type;		continue; fi
		
		create_cache
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
	dk_debug "Pick_Update("$@")"
	read_cache
	
	echo ""
	dk_check_remote
	echo ""
	
	if [[ -n "$_APP_" ]] && [[ -n "$_TARGET_OS_" ]] && [[ -n "$_TYPE_" ]]; then
		echo " 0) Repeat cache [$_APP_ - $_TARGET_OS_ - $_TYPE_]"
	fi
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
	if [ "$input" == "0" ]; then
		echo "repeating last selection"
		APP=$_APP_
		TARGET_OS=$_TARGET_OS_
		TYPE=$_TYPE_
		UPDATE=1
	elif [ "$input" == "1" ]; then
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
		dk_reload
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
	dk_debug "Pick_App("$@")"
	echo ""
	echo "${APP}  ${TARGET_OS} ${TYPE}"
	
	echo ""	
    echo " 1) HelloWorld"
    echo " 2) DKCore"
    echo " 3) DKJavascript"
    echo " 4) DKSDL"
    echo " 5) DKSDLRml"
    echo " 6) DKDomTest"
    echo " 7) DKTestAll"
    echo " 8) Enter Manually"
    echo " 9) Clear Screen"
    echo "10) Go Back"
    echo "11) Reload"
	echo "12) Exit"
    echo "" 
	
	read input
	if [ "$input" == "1" ]; then
		APP="HelloWorld"
	elif [ "$input" == "2" ]; then
		APP="DKCore"
	elif [ "$input" == "3" ]; then
		APP="DKJavascript"
	elif [ "$input" == "4" ]; then
		APP="DKSDL"
	elif [ "$input" == "5" ]; then
		APP="DKSDLRml"
	elif [ "$input" == "6" ]; then
		APP="DKDomTest"
	elif [ "$input" == "7" ]; then
		APP="DKTestAll"
	elif [ "$input" == "8" ]; then
		enter_manually
	elif [ "$input" == "9" ]; then
		clear
	elif [ "$input" == "10" ]; then
		UPDATE=
	elif [ "$input" == "11" ]; then
		dk_call dk_reload
	elif [ "$input" == "12" ]; then
		exit 0
	else
		echo "invalid selection"
	fi
}

###### Pick_OS ######
function Pick_OS() {
	dk_debug "Pick_OS("$@")"
	echo ""
	echo "${APP} ${TARGET_OS} ${TYPE}"
	
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
		TARGET_OS="android_x86_64"
	elif [ "$input" == "6" ]; then
		TARGET_OS="emscripten"
	elif [ "$input" == "7" ]; then
		TARGET_OS="ios_arm32"
	elif [ "$input" == "8" ]; then
		TARGET_OS="ios_arm64"
	elif [ "$input" == "9" ]; then
		TARGET_OS="ios_x86"
	elif [ "$input" == "10" ]; then
		TARGET_OS="ios_x86_64"
	elif [ "$input" == "11" ]; then
		TARGET_OS="iossim_arm32"
	elif [ "$input" == "12" ]; then
		TARGET_OS="iossim_arm64"
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
		TARGET_OS="windows_x86"
	elif [ "$input" == "30" ]; then
		TARGET_OS="windows_x86_64"
	elif [ "$input" == "31" ]; then
		clear
	elif [ "$input" == "32" ]; then
		APP=
	elif [ "$input" == "33" ]; then
		exit 0
	else
		echo "invalid selection"
	fi
}

###### Pick_Type ######
function Pick_Type() {
	dk_debug "Pick_Type("$@")"
	echo ""
	echo "${APP} ${TARGET_OS} ${TYPE}"
	
	echo ""	
    echo " 1) Debug"
	echo " 2) Release"
	echo " 3) All"
	echo " 4) Clear Screen"
	echo " 5) Go Back"
	echo " 6) Exit"
	echo ""
	
	read input
	if [ "$input" == "1" ]; then
		TYPE="Debug"
	elif [ "$input" == "2" ]; then
		TYPE="Release"
	elif [ "$input" == "3" ]; then
		TYPE="All"
	elif [ "$input" == "4" ]; then
		clear
	elif [ "$input" == "5" ]; then
		TARGET_OS=
	elif [ "$input" == "6" ]; then
		exit 0
	else
		echo "invalid selection"
	fi
}

###### Generate_Project ######
function Generate_Project() {
	dk_debug "Generate_Project("$@")"
	echo ""
	echo "##################################################################"
	echo "     Generating $APP - $TARGET_OS - $TYPE - $DKLEVEL"
	echo "##################################################################"
	echo ""

	clear_cmake_cache
	delete_temp_files

	TARGET_PATH=$DKAPPS_DIR/$APP
	print_var TARGET_PATH
	mkdir -p $TARGET_PATH/$TARGET_OS
	cd $TARGET_PATH/$TARGET_OS
	CMAKE_SOURCE_DIR="$DKCMAKE_DIR"
	print_var CMAKE_SOURCE_DIR
	if ! dk_file_exists $CMAKE_SOURCE_DIR; then
		dk_error "CMAKE_SOURCE_DIR does not exist"
	fi
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
	
	if ! [[ $WSL == 1 ]]; then
		CMAKE_ARGS+=( "-S=$CMAKE_SOURCE_DIR" )
	fi
	CMAKE_ARGS+=( "-B=$CMAKE_BINARY_DIR" )
	
	############ CMake Options ############
    #CMAKE_ARGS+=( "-DCMAKE_VERBOSE_MAKEFILE=1" ) 
    #CMAKE_ARGS+=( "--debug-output" )
	#CMAKE_ARGS+=( "--trace" )
	#CMAKE_ARGS+=( "--warn-unused-vars" )
	
	if [[ "$TARGET_OS" == "android_arm32" ]]; then
		CMAKE_ARGS+=( -G "Unix Makefiles" )
	fi

	if [[ "$TARGET_OS" == "android_arm64" ]]; then
		CMAKE_ARGS+=( "-G Unix Makefiles" )
	fi
	
	if [[ "$TARGET_OS" == "emscripten" ]]; then
		CMAKE_ARGS+=( "-G Unix Makefiles" )
	fi
	
	if [[ "$TARGET_OS" == "ios_arm32" ]]; then
		CMAKE_ARGS+=( "-G Xcode" )
	fi
	
	if [[ "$TARGET_OS" == "ios_arm64" ]]; then
		CMAKE_ARGS+=( "-G Xcode" )
	fi
	
	if [[ "$TARGET_OS" == "iossim_x86" ]]; then
		CMAKE_ARGS+=( "-G Xcode" )
	fi
	
	if [[ "$TARGET_OS" == "iossim_x86_64" ]]; then
		CMAKE_ARGS+=( "-G Xcode" )
	fi
	
	if [[ "$TARGET_OS" == "linux_x86" ]]; then
		CMAKE_ARGS+=( "-G Unix Makefiles" )
	fi
	
	if [[ "$TARGET_OS" == "linux_x86_64" ]]; then
		CMAKE_ARGS+=(-G)
		CMAKE_ARGS+=("Unix Makefiles")
	fi
	
	if [[ "$TARGET_OS" == "mac_x86" ]]; then
		CMAKE_ARGS+=( "-G Xcode" )
	fi
	
	if [[ "$TARGET_OS" == "mac_x86_64" ]]; then
		CMAKE_ARGS+=( "-G Xcode" )
	fi
	
	if [[ "$TARGET_OS" == "raspberry_arm32" ]]; then
		CMAKE_ARGS+=( "-G Unix Makefiles" )
	fi
	
	if [[ "$TARGET_OS" == "raspberry_arm64" ]]; then
		CMAKE_ARGS+=( "-G Unix Makefiles" )
	fi
	
	if [[ "$TARGET_OS" == "win_x86" ]]; then
		CMAKE_ARGS+=( "-G MSYS Makefiles" )
		#CMAKE_ARGS+=( "-DCMAKE_EXE_LINKER_FLAGS=-static -mconsole" )
	fi
	
	if [[ "$TARGET_OS" == "win_x86_64" ]]; then
		CMAKE_ARGS+=( "-G MSYS Makefiles" )
		#CMAKE_ARGS+=( "-DCMAKE_EXE_LINKER_FLAGS=-static -mconsole" )
	fi
	
	#### CMAKE CALL ####
	validate_cmake
	TOOLCHAIN="${TARGET_OS}_toolchain.cmake"
	echo "TOOLCHAIN = $TOOLCHAIN"
	if dk_file_exists $TOOLCHAIN; then
		CMAKE_ARGS+=( "-DCMAKE_TOOLCHAIN_FILE=$TOOLCHAIN" )
	fi
	
	if [[ $WSL == 1 ]]; then
		cd $DKCMAKE_DIR
		CMAKE_ARGS+=( .)
	fi
	
	#echo CMAKE_ARGS = "${CMAKE_ARGS[@]}
	dk_call $CMAKE_EXE "${CMAKE_ARGS[@]}" 
}
	
###### Build_Project ######
function Build_Project() {
	dk_debug "Build_Project("$@")"
	echo ""
	echo "##################################################################"
	echo "****** Building $APP - $TARGET_OS - $TYPE - $DKLEVEL ******"
	echo "##################################################################"
	echo ""
	
	if [[ "$TYPE" == "Debug" ]] || [[ "$TYPE" == "All" ]]; then
		if dk_file_exists $DKAPPS_DIR/$APP/$TARGET_OS/Debug/CMakeCache.txt; then
			dk_call $CMAKE_EXE --build $DKAPPS_DIR/$APP/$TARGET_OS/Debug --config Debug --verbose
		elif dk_file_exists $DKAPPS_DIR/$APP/$TARGET_OS/CMakeCache.txt; then
			dk_call $CMAKE_EXE --build $DKAPPS_DIR/$APP/$TARGET_OS --config Debug --verbose
		else
			dk_error "Could not find CMakeCache.txt in $APP/$TARGET_OS/Debug or $APP/$TARGET_OS"
		fi
	fi
	if [[ "$TYPE" == "Release" ]] || [[ "$TYPE" == "All" ]]; then
		if dk_file_exists $DKAPPS_DIR/$APP/$TARGET_OS/Release/CMakeCache.txt; then
			dk_call $CMAKE_EXE --build $DKAPPS_DIR/$APP/$TARGET_OS/Release --config Release --verbose
		elif dk_file_exists $DKAPPS_DIR/$APP/$TARGET_OS/CMakeCache.txt; then
			dk_call $CMAKE_EXE --build $DKAPPS_DIR/$APP/$TARGET_OS --config Release --verbose
		else
			dk_error "Could not find CMakeCache.txt in $APP/$TARGET_OS/Release or $APP/$TARGET_OS"
		fi
	fi
	
	echo ""
	echo "##################################################################"
	echo "****** Done Building $APP - $TARGET_OS - $TYPE - $DKLEVEL ******"
	echo "##################################################################"
	echo ""
}





###### dk_debug <string> ######
function dk_debug() {
	if [ $LOG_DEBUG == 1 ]; then 
		echo -e "${blue} DEBUG: $1 ${CLR}"
		return $true
	fi
}

###### dk_warning <string> ######
function dk_warning() {
	echo -e "${yellow} WARNING: $1 ${CLR}"
	return $true
}

###### dk_error <string> ######
function dk_error() {
	echo -e "${red} ERROR: $1 ${CLR}"
	return $false
}

###### message <string> ######
function message() {
	if [ -z "$1" ]; then
		dk_error "message <string> requires 1 parameter"
		return $false
	fi
	echo "$@"	
}

###### dk_call <command args> ######
function dk_call() {
	dk_debug "dk_call("$@")"
	if [ -z "$1" ]; then
		dk_error "dk_call <command args> requires at least 1 parameter"
		return $false
	fi
	
	echo -e "${magenta} $ $@ ${CLR}"
	"$@"
}

###### dk_check_remote ######
function dk_check_remote() {
	dk_debug "dk_check_remote("$@")"
	if [ -d .git ]; then
		git remote update > /dev/null 2> /dev/null
		branch=$(git rev-parse --abbrev-ref HEAD)
		ahead=$(git rev-list --count origin/$branch..$branch)
		behind=$(git rev-list --count $branch..origin/$branch)
		echo "$ahead commits ahead, $behind commits behind"
	fi
}

###### dk_validate_sudo ######
function dk_validate_sudo() {
	dk_debug "dk_validate_sudo("$@")"
	if command -v "sudo" >/dev/null 2>&1; then
		SUDO="sudo"
	fi
	$SUDO echo
}

###### dk_reload ######
function dk_reload() {
	dk_debug "dk_reload("$@")"
	dk_debug "reloading $SCRIPT_DIR/$SCRIPT_NAME"
	clear
	exec "$SCRIPT_DIR/$SCRIPT_NAME"
}

###### dk_confirm() ######
function dk_confirm() {
	dk_debug "dk_confirm("$@")"
	echo -e "${yellow} Are you sure ? [Y/N] ${CLR}"
	read -p " " -n 1 -r
	echo ""
	echo ""
	[[ $REPLY =~ ^[Yy]$ ]]
}

###### dk_string_contains <string> <substring> ######
function dk_string_contains() {
	dk_debug "dk_string_contains("$@")"
	if [ -z "$2" ]; then
		dk_error "dk_string_contains <string> <substring> requires 2 parameters"
		return $false
	fi
	[[ $1 == *"$2"* ]]
}

###### dk_command_exists <command> ######
function dk_command_exists() {
	dk_debug "dk_command_exists("$@")"
	! [[ "$(command -v $1)" == "" ]]
}
	
###### dk_file_exists <file> ######
function dk_file_exists() {
	dk_debug "dk_file_exists("$@")"
	if [ -e "$1" ]; then
		dk_debug "dk_file_exists("$@"): FOUND"
	else
		dk_error "dk_file_exists("$@"): NOT FOUND!" 
	fi
	[ -e "$1" ]
}

###### dk_get_filename <path> <output> ######
function dk_get_filename() {
	dk_debug "dk_get_filename("$@")"
	if [ -z "$2" ]; then
		dk_error "dk_get_filename <path> <output> requires 2 parameters"
		return "$false"
	fi
	
	eval "$2=$(basename $1)"
	#[[ $base_name == "" ]]
}

###### dk_convert_to_c_identifier <input> <output> ######
function dk_convert_to_c_identifier() {
	dk_debug "dk_convert_to_c_identifier("$@")"
	if [ -z "$2" ]; then
		dk_error "dk_convert_to_c_identifier <input> <output> requires 2 parameters"
		return $false
	fi
	input=$1
	echo "dk_convert_to_c_identifier($1, $2)"
	input="${input//[^[:alnum:]]/_}"
	echo "input = $input"
	eval "$2=$input"
	#[[ $input == "" ]]
}

###### convert_to_lowercase <input> <output> ######
function convert_to_lowercase() {
	dk_debug "convert_to_lowercase("$@")"
	if [ -z "$2" ]; then
		dk_error "dk_convert_to_c_identifier <input> <output> requires 2 parameters"
		return $false
	fi
	input=$1
	echo "convert_to_lowercase($1, $2)"
	echo "$input" | tr '[:upper:]' '[:lower:]'
	echo "input = $input"
	eval "$2=$input"
	#[[ $input == "" ]]
}

###### download <url> <destination> ######
function download() {
	dk_debug "download("$@")"
	if [ -z "$2" ]; then
		dk_error "dk_convert_to_c_identifier <input> <output> requires 2 parameters"
		return $false
	fi
	
	if dk_file_exists $2; then
		echo "download(): $2 already exists"
		return 0
	fi
	#echo "download($1, $2)"
	echo "Downloading $1 . . ."
	parentdir="$(dirname "$2")"
	#filename="$(basename "$2")"
	echo "parentdir = $parentdir"
	#echo "filename = $filename"
	olddir=$pwd
	echo "cd $parentdir"
	cd $parentdir
	echo "wget -P $parentdir $1"
	wget -P $parentdir $1 
	cd $oldpwd
	#[[ $input == "" ]]
}

###### extract <file> <destination> ######
function extract() {
	dk_debug "extract($@)"
	if [ -z "$2" ]; then
		dk_error "extract <input> <output> requires 2 parameters"
		return $false
	fi

	filename="$(basename "$1")"
	destFolder="${filename%.*}"
	destFolder="${destFolder%.*}"
	fulldest="$2/$destFolder"
	print_var fulldest
		
	#if dk_file_exists $fulldest; then
	#	echo "extract(): $fulldest already exists"
	#	return 0
	#fi
	echo "Extracting $1 . . ."
	parentdir="$(dirname "$1")"
	parentdest="$(dirname "$2")"
	echo "parentdir = $parentdir"
	echo "filename = $filename"
	#need to cd into parent directory of $1 and send tar the file name of $1
	olddir=$pwd
	echo "cd $parentdir"
	cd $parentdir
	echo "tar -xf $filename -C $2"
	tar -xf $filename -C $2
	cd $oldpwd
	dk_convert_to_c_identifier $destFolder destFolder_
	print_var destFolder_
	echo "mv $2/$destFolder $2/$destFolder_"
	mv $2/$destFolder $2/$destFolder_
	echo $CMAKE_FOLDER>$2/$destFolder_/installed
	
	#TODO
	#[[ $input == "" ]]
}

###### rename <from> <to> ######
function rename() {
	dk_debug "rename("$@")"
	if [ -z "$2" ]; then
		dk_error "dk_get_filename <path> <output> requires 2 parameters"
		return $false
	fi
	
	#TODO
	#[[ ? == "success" ]]
}

###### validate_cmake ######
function validate_cmake() {
	dk_debug "validate_cmake("$@")"
	
	if [[ $NATIVE_OS == "android" ]]; then
		CMAKE_SYSTEM_INSTALL=1
	fi
	if [[ $CMAKE_SYSTEM_INSTALL == 1 ]]; then
		echo "Installing CMake System packages"
		CMAKE_EXE=$(command -v cmake)
		print_var CMAKE_EXE
		if ! dk_command_exists cmake; then
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
		CMAKE_EXE=$(command -v cmake)
		print_var CMAKE_EXE
	else
		echo "Installing DK CMake packages"
		## New method of obtaining cmake
		######################################################################################################
		if [[ "${NATIVE_OS}_${NATIVE_ARCH}" == "win_arm32" ]];		then CMAKE_DL=$CMAKE_DL_WIN_ARM32;		fi
		if [[ "${NATIVE_OS}_${NATIVE_ARCH}" == "win_arm64" ]];		then CMAKE_DL=$CMAKE_DL_WIN_ARM64;		fi
		if [[ "${NATIVE_OS}_${NATIVE_ARCH}" == "win_x86" ]];		then CMAKE_DL=$CMAKE_DL_WIN_X86;		fi
		if [[ "${NATIVE_OS}_${NATIVE_ARCH}" == "win_x86_64" ]];		then CMAKE_DL=$CMAKE_DL_WIN_X86_64;		fi
		if [[ "${NATIVE_OS}" == "mac" ]];							then CMAKE_DL=$CMAKE_DL_MAC;			fi
		if [[ "${NATIVE_OS}_${NATIVE_ARCH}" == "linux_x86_64" ]];	then CMAKE_DL=$CMAKE_DL_LINUX_X86_64;	fi
		if [[ "${NATIVE_OS}_${NATIVE_ARCH}" == "linux_arm64" ]];	then CMAKE_DL=$CMAKE_DL_LINUX_ARM64;	fi
		print_var CMAKE_DL
		
		dk_get_filename $CMAKE_DL CMAKE_DL_FILE
		print_var CMAKE_DL_FILE
		
		#CMAKE_FOLDER="${CMAKE_DL_FILE%%.*}"	# remove everything past first dot
		CMAKE_FOLDER="${CMAKE_DL_FILE%.*}"
		print_var CMAKE_FOLDER
		
		#CMAKE_FOLDER="${CMAKE_FOLDER%.*}"
		#print_var CMAKE_FOLDER
		
		dk_convert_to_c_identifier $CMAKE_FOLDER CMAKE_FOLDER
		convert_to_lowercase $CMAKE_FOLDER CMAKE_FOLDER
		print_var CMAKE_FOLDER
		
		if [[ "${NATIVE_OS}" == "win" ]]; then
			CMAKE_EXE=$DKTOOLS_DIR/$CMAKE_FOLDER/bin/cmake.exe
		elif [[ "${NATIVE_OS}" == "mac" ]]; then
			CMAKE_EXE=$DKTOOLS_DIR/$CMAKE_FOLDER/CMake.app/Content/bin/cmake
		elif [[ "${NATIVE_OS}" == "linux" ]]; then
			CMAKE_EXE=$DKTOOLS_DIR/$CMAKE_FOLDER/bin/cmake
		fi
		print_var CMAKE_EXE
		
		if dk_file_exists $CMAKE_EXE; then return $true; fi

		echo ""   
		echo "Installing cmake . . ."
		download $CMAKE_DL $DKDOWNLOAD_DIR/$CMAKE_DL_FILE
		echo "extract $CMAKE_DL_FILE $DKTOOLS_DIR"
		extract $DKDOWNLOAD_DIR/$CMAKE_DL_FILE $DKTOOLS_DIR

		
		
		#if ! dk_file_exists $CMAKE_EXE; then error "cannot find cmake"; fi
	fi
}

###### validate_git ######
function validate_git() {
	dk_debug "validate_git("$@")"
	if ! dk_command_exists git; then
		install git
	fi
	
	GIT_EXE=$(command -v git)
	print_var GIT_EXE
}

###### validate_homebrew ######
function validate_homebrew() {
	dk_debug "validate_homebrew("$@")"
	if ! [[ "$OSTYPE" == "darwin"* ]]; then
		return
	fi
		
	if ! dk_command_exists brew; then
		echo "installing Homebrew"
		ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
		# https://github.com/Homebrew/brew/issues/10368
		rm -fr $(brew --repo homebrew/core)
		brew tap homebrew/core
	fi
	
	BREW=$(command -v brew)
	print_var BREW
}

###### package_installed <package> ######
function package_installed() {
	dk_debug "package_installed("$@")"
	if dk_command_exists dpkg-query; then
		if [ $(dpkg-query -W -f='${Status}' $1 2>/dev/null | grep -c "ok installed") -ne 0 ]; then
			return $true
		fi
	elif dk_command_exists brew; then
		if brew list $1 &>/dev/null; then
			return $true
		fi
	elif dk_command_exists apt; then
		dk_error "package_installed() apt-get not implemented"
	elif dk_command_exists apt-get; then
		dk_error "package_installed() apt-get not implemented"
	elif dk_command_exists pkg; then
		dk_error "package_installed() pkg not implemented"
	elif dk_command_exists pacman; then
		if pacman -Qs $1 > /dev/null; then
			#FIXME: this doesn't always work
			return $false;
		fi
	elif dk_command_exists tce-load; then
		#dk_error "package_installed() tce-load not implemented"
		return $false
	else
		dk_error "ERROR: no package managers found"
	fi
	return $false
}

###### install <package> ######
function install() {
	dk_debug "install("$@")"
	#if package_installed $1; then
	#	echo "$1 already installed"
	#	return $false;
	#fi
	
	echo "installing $1"

	if dk_command_exists brew; then
		dk_call $SUDO brew install $1
	elif dk_command_exists apt; then
		dk_call $SUDO apt -y install $1
	elif dk_command_exists apt-get; then
		echo "found apt-get"
		dk_call $SUDO apt-get -y install $1
	elif dk_command_exists pkg; then
		dk_call $SUDO pkg install $1
	elif dk_command_exists pacman; then
		dk_call $SUDO pacman -S $1 --noconfirm
	elif dk_command_exists tce-load; then
		dk_call $SUDO tce-load -wi $1
	else
		dk_error "ERROR: no package managers found"
	fi
}

###### validate_package <command> <package> ######
function validate_package() {
	dk_debug "validate_package("$@")"
	if ! dk_command_exists $1; then
		install $2
	fi
}

###### validate_ostype ######
function validate_ostype() {
	dk_debug "validate_ostype("$@")"
	if [ -e /proc/device-tree/model ]; then
		MODEL=$(tr -d '\0' </proc/device-tree/model)
	fi

	if [[ "$OSTYPE" == "linux-gnu"* ]]; then
		DIGITALKNOB_DIR="/home/$USER/digitalknob"
	elif [[ "$OSTYPE" == "darwin"* ]]; then
		DIGITALKNOB_DIR="/Users/$USER/digitalknob"
	elif [[ "$OSTYPE" == "cygwin" ]]; then
		DIGITALKNOB_DIR="/c/Users/$USERNAME/digitalknob"
	elif [[ "$OSTYPE" == "msys" ]]; then
		DIGITALKNOB_DIR="/c/Users/$USERNAME/digitalknob"
	elif [[ "$OSTYPE" == "win32" ]]; then #I'm not sure this can happen
		DIGITALKNOB_DIR="/c/Users/$USERNAME/digitalknob" 
	elif [[ "$OSTYPE" == "freebsd"* ]]; then
		echo "TODO: freebsd builder incomplete"
	elif [[ "$OSTYPE" == "linux-android" ]]; then
		DIGITALKNOB_DIR="/data/data/com.termux/files/home/digitalknob"
	else
		dk_error "UNKNOWN OS ($OSTYPE)"
	fi
}

###### validate_branch ######
function validate_branch() {
	dk_debug "validate_branch("$@")"
	# If the current folder matches the current branch set DKBRANCH, default to Development
	
	FOLDER="$(basename $(pwd))"
	DKBRANCH="Development"
	
	if dk_file_exists .git; then
		BRANCH="$($GIT_EXE rev-parse --abbrev-ref HEAD)"
		if [[ "$BRANCH" == "$FOLDER" ]]; then
			DKBRANCH="$FOLDER"
		fi
	fi
	print_var DKBRANCH
	
	DKBRANCH_DIR="$DIGITALKNOB_DIR/$DKBRANCH"
	print_var  DKBRANCH_DIR
	
	DKCMAKE_DIR="$DKBRANCH_DIR/DKCMake"
	print_var  DKCMAKE_DIR
	
	DK3RDPARTY_DIR="$DKBRANCH_DIR/3rdParty"
	print_var DK3RDPARTY_DIR
	
	DKIMPORTS_DIR="$DK3RDPARTY_DIR/_DKIMPORTS"
	print_var DKIMPORTS_DIR
	
	DKAPPS_DIR="$DIGITALKNOB_DIR/$DKBRANCH/DKApps"
	print_var DKAPPS_DIR
	
	DKPLUGINS_DIR="$DIGITALKNOB_DIR/$DKBRANCH/DKPlugins"
	print_var DKPLUGINS_DIR

	# make sure script is running from DKBRANCH_DIR
	#if ! [[ "$SCRIPT_DIR" == "$DKBRANCH_DIR" ]]; then
	#	if ! dk_file_exists $DKBRANCH_DIR/$SCRIPT_NAME; then
	#		echo "$DKBRANCH_DIR/$SCRIPT_NAME"
	#		cp $SCRIPT_DIR/$SCRIPT_NAME $DKBRANCH_DIR/$SCRIPT_NAME
	#	fi
	#	echo .
	#	echo "RELOADING SCRIPT TO -> $DKBRANCH_DIR/$SCRIPT_NAME"
	#	read -p "Press enter to continue"
	#	clear
	#	if dk_file_exists $DKBRANCH_DIR/$SCRIPT_NAME; then
	#		rm $SCRIPT_DIR/$SCRIPT_NAME
	#	fi
	#	$DKBRANCH_DIR/$SCRIPT_NAME
	#	exit
	#fi
}

###### dk_pause ######
function dk_pause() {
	read -rsp $'Press any key to continue...\n' -n 1 key
	# echo $key
}


###### clear_cmake_cache ######
function clear_cmake_cache() {
	dk_debug "clear_cmake_cache("$@")"
	echo "Clearing CMake cache . . ."
	cd $DIGITALKNOB_DIR
	find . -name "CMakeCache.*" -delete
	rm -rf `find . -type d -name CMakeFiles`
}

###### delete_temp_files ######
function delete_temp_files() {
	dk_debug "delete_temp_files("$@")"
	echo "Deleting .TMP files . . ."
	cd $DIGITALKNOB_DIR
	rm -rf `find . -type d -name *.tmp`
	rm -rf `find . -type d -name *.TMP`
	find . -name "*.tmp" -delete
	find . -name "*.TMP" -delete
}

###### validate_msys2 ######
#function validate_msys2() {
#	dk_debug "validate_msys2("$@")"
#	cmake_eval "include('$DKIMPORTS_DIR/msys2/DKMAKE.cmake')" "MSYS2"
#	print_var MSYS2
#}

###### validate_make ######
#function validate_make() {
#	dk_debug "validate_make("$@")"
#	cmake_eval "include('$DKIMPORTS_DIR/make/DKMAKE.cmake')" "MAKE_PROGRAM"
#	print_var MAKE_PROGRAM
#}

###### validate_emscripten ######
#function validate_emscripten() {
#	dk_debug "validate_emscripten("$@")"
#	cmake_eval "include('$DKIMPORTS_DIR/emsdk/DKMAKE.cmake')" "EMSDK;EMSDK_ENV;EMSDK_GENERATOR;EMSDK_TOOLCHAIN_FILE;EMSDK_C_COMPILER;EMSDK_CXX_COMPILER"
#	print_var EMSDK
#	print_var EMSDK_ENV
#	print_var EMSDK_GENERATOR
#	print_var EMSDK_TOOLCHAIN_FILE
#	print_var EMSDK_C_COMPILER
#	print_var EMSDK_CXX_COMPILER
#}

###### validate_android_ndk ######
#function validate_android_ndk() {
#	dk_debug "validate_android_ndk("$@")"
#	cmake_eval "include('$DKIMPORTS_DIR/android-ndk/DKMAKE.cmake')" "ANDROID_NDK;ANDROID_GENERATOR;ANDROID_TOOLCHAIN_FILE;ANDROID_API;ANDROID_MAKE_PROGRAM;ANDROID_C_COMPILER;ANDROID_CXX_COMPILER"
#	print_var ANDROID_NDK
#	print_var ANDROID_GENERATOR
#	print_var ANDROID_TOOLCHAIN_FILE
#	print_var ANDROID_API
#	print_var ANDROID_MAKE_PROGRAM
#	print_var ANDROID_C_COMPILER
#	print_var ANDROID_CXX_COMPILER
#}

###### validate_clang ######
#function validate_clang() {
#	dk_debug "validate_clang("$@")"
#	cmake_eval "include('$DKIMPORTS_DIR/clang/DKMAKE.cmake')" "CLANG_C_COMPILER;CLANG_CXX_COMPILER"
#	print_var CLANG_C_COMPILER
#	print_var CLANG_CXX_COMPILER
#}

###### validate_gcc ######
#function validate_gcc() {
#	dk_debug "validate_gcc("$@")"
#	cmake_eval "include('$DKIMPORTS_DIR/gcc/DKMAKE.cmake')" "GCC_C_COMPILER;GCC_CXX_COMPILER"
#	print_var GCC_C_COMPILER
#	print_var GCC_CXX_COMPILER
#}
			
### cmake_eval <cmake_commands;.;.;> <return_variables;.;.;.> <-DVARS;.;.;>
function cmake_eval() {
	dk_debug "cmake_eval("$@")"
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
		dk_call $CMAKE_EXE "-DDKCMAKE_DIR=$DKCMAKE_DIR" "-DDKCOMMAND=$DKCOMMAND" "-DDKRETURN=$2" $3 -P $DKCMAKE_DIR/dev/cmake_eval.cmake
		if dk_file_exists $DKCMAKE_DIR/cmake_vars.sh; then
	    	echo "executing cmake_vars.sh"
			source $DKCMAKE_DIR/cmake_vars.sh
			#rm $DKCMAKE_DIR/cmake_vars.sh
		fi
	else
		dk_call $CMAKE_EXE "-DDKCMAKE_DIR=$DKCMAKE_DIR" "-DDKCOMMAND=$DKCOMMAND" -P $DKCMAKE_DIR/dev/cmake_eval.cmake
	fi
	#echo return code: $?
}

###### push_assets ######
function push_assets() {
	dk_debug "push_assets("$@")"
	if ! dk_confirm; then return; fi
	echo "not implemented,  TODO"
}

###### pull_assets ######
function pull_assets() {
	dk_debug "pull_assets("$@")"
	if ! dk_confirm; then return; fi
	echo "not implemented,  TODO"
}

###### reset_all ######
function reset_all() {
	dk_debug "reset_all("$@")"
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
		
		if ! dk_confirm; then return; fi
		
		# first we need to relocate this file up one directory
		# make sure script is running from DKBRANCH_DIR
		if ! [ $SCRIPT_DIR == $DKBRANCH_DIR ]; then
			echo "WARNING: this file isn't running from the branch directory"
			echo "Is must be in the branch directory to continue."
			echo "SCRIPT_DIR = $SCRIPT_DIR"
			print_var DKBRANCH_DIR
			return $false;
		fi
		
		echo "RELOCATING SCRIPT TO -> $DIGITALKNOB_DIR/$SCRIPT_NAME"
		cp $SCRIPT_DIR/$SCRIPT_NAME $DIGITALKNOB_DIR/$SCRIPT_NAME
		source "$DIGITALKNOB_DIR/$SCRIPT_NAME" reset_all wipe
		exit
	else	
		#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		#:wipe
		
		#do we need sudo rights?
		#do we need to kill any processes?
		#do we need to uninstall any apps?
		#do we need to remove any environment variables?
		
		cd $DIGITALKNOB_DIR
		echo ""
		echo "DELETING $DKBRANCH_DIR . . . ."
		rm -r -f $DKBRANCH_DIR
		echo "done."
		
		# wait for the folders to get deleted
		sleep 10

		if dk_file_exists $DKBRANCH_DIR; then
			echo "Oh no, the BRANCH folder is still there! :( "
			exit 1
		fi
		
		git_update NO_CONFIRM
		
		# wait for build.sh to show up
		sleep 2
		
		if dk_file_exists $DKBRANCH_DIR/$SCRIPT_NAME; then
			clear
			source $DKBRANCH_DIR/$SCRIPT_NAME rm -r $DIGITALKNOB_DIR/$SCRIPT_NAME
			exit
		else
			echo "Oh no, the git cloned build.sh still isn't here! :( "
			exit 1
		fi
	fi
}

###### remove_all ######
function remove_all() {
	dk_debug "remove_all("$@")"
	if ! [ "$1" == "wipe" ]; then	
		clear
		echo ""
		echo ""
		echo "Do you want to remove the entire local repository . . . ?"
		echo "This will delete digitalknob, Save any changes"
		echo "you wish to commit or save beforehand."
		echo ""
		
		if ! dk_confirm; then return; fi
		
		# first we need to relocate this file up one directory
		# make sure script is running from DKBRANCH_DIR
		if ! [ $SCRIPT_DIR == $DKBRANCH_DIR ]; then
			echo "WARNING: this file isn't running from the branch directory"
			echo "Is must be in the branch directory to continue."
			echo "SCRIPT_DIR = $SCRIPT_DIR"
			print_var DKBRANCH_DIR
			return 1;
		fi
		
		echo "RELOCATING SCRIPT TO -> $DIGITALKNOB_DIR/$SCRIPT_NAME"
		cp $SCRIPT_DIR/$SCRIPT_NAME $DIGITALKNOB_DIR/$SCRIPT_NAME
		source "$DIGITALKNOB_DIR/$SCRIPT_NAME" remove_all wipe
		exit
	else	
		#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		#:wipe
		
		#do we need sudo rights?
		#do we need to kill any processes?
		#do we need to uninstall any apps?
		#do we need to remove any environment variables?
		
		cd $DIGITALKNOB_DIR
		echo ""
		echo "DELETING $DKBRANCH_DIR . . . ."
		rm -r -f $DKBRANCH_DIR
		echo "done."
		
		# wait for the folders to get deleted
		sleep 3
		
		if dk_file_exists $DKBRANCH_DIR; then
			echo "Oh no, the BRANCH folder is still there! :( "
		fi
	fi
}

###### git_update ######
function git_update() {
	dk_debug "git_update("$@")"
	if ! [ "$1" == "NO_CONFIRM" ]; then
		echo "Git Update? Any local changes will be lost."
		if ! dk_confirm; then return; fi
	fi

	if [[ ! -d "$DKBRANCH_DIR/.git" ]]; then
		dk_call $GIT_EXE clone https://github.com/aquawicket/DigitalKnob.git $DKBRANCH_DIR
	fi
	dk_call cd $DKBRANCH_DIR
	dk_call $GIT_EXE pull --all
	dk_call $GIT_EXE checkout -- .
	dk_call $GIT_EXE checkout $DKBRANCH
	if [[ "$?" == "0" ]]; then
		echo "$DKBRANCH branch selected"
	else
	echo "Remote has no $DKBRANCH branch. Creating..."
		dk_call $GIT_EXE checkout -b $DKBRANCH main
		dk_call $GIT_EXE push --set-upstream origin $DKBRANCH
	fi
	dk_call chmod +x $DKBRANCH_DIR/build.sh
}

###### git_commit ######
function git_commit() {	
	dk_debug "git_commit("$@")"
	echo "Please enter some details about this commit, Then press ENTER."
	read message
	
	cd $DKBRANCH_DIR
	
	STORE=$($GIT_EXE config credential.helper)
	print_var STORE
	if [ -z "$STORE" ]; then
		$GIT_EXE config --global credential.helper store
		echo ""
		echo "git credential.helper is now set to store"
		echo ""
	fi
	
	USER_EMAIL=$($GIT_EXE config --global user.email)
	if [ -z "$USER_EMAIL" ]; then
		echo ""
		echo "please enter an email address"
		read input
		$GIT_EXE config --global user.email "$input"
		echo ""
		echo "git user.email '$input' saved"
		echo ""
	fi

	USER_NAME=$($GIT_EXE config --global user.name)
	if [ -z "USER_NAME" ]; then
		echo ""
		echo "please enter a username"
		read input
		$GIT_EXE config --global user.name "$input"
		echo ""
		echo "git user.name '$input' saved"
		echo ""
	fi
	
	if [ -z "$message" ]; then
		message="git commit"
	fi
	
	echo ""
	echo "git commit \"${message}\""
	if ! dk_confirm; then return; fi
	
	dk_call $GIT_EXE commit -a -m "${message}"
    dk_call $GIT_EXE push
}

###### enter_manually ######
function enter_manually() {
	dk_debug "enter_manually("$@")"
	echo "Please type the name of the library, tool or app to build. Then press enter."
	read input
	
	APP="_${input}_"
	
	#Search digitalknob for the matching entry containing a DKMAKE.cmake file  
	if test -f $DKIMPORTS_DIR/$input/DKMAKE.cmake; then
		TARGET_PATH=$DKIMPORTS_DIR/$input
	fi
	if test -f $DKPLUGINS_DIR/$input/DKMAKE.cmake; then
		TARGET_PATH=$DKPLUGINS_DIR/$input
	fi
	if test -f $DKAPPS_DIR/$input/DKMAKE.cmake; then
		TARGET_PATH=$DKAPPS_DIR/$input
		return $true
	fi
	print_var TARGET_PATH
	
	if [ ! -d $DKAPPS_DIR/$APP ]; then
		mkdir -p $DKAPPS_DIR/$APP;
	fi
	
	# create DKApps/<APP>/DKMAKE.cmake 
	echo "dk_depend($input)" > $DKAPPS_DIR/$APP/DKMAKE.cmake
	
	# create DKApps/<APP>/main.cpp
	echo "int main(int argc, char** argv) { return 0; }" > $DKAPPS_DIR/$APP/main.cpp
}

###### create_cache ######
function create_cache() {
	dk_debug "create_cache("$@")"
	echo "creating cache..."
	
	# write variable values line by line
	echo "$APP">"$DKBRANCH_DIR/cache"
	echo "$TARGET_OS">>"$DKBRANCH_DIR/cache"
	echo "$TYPE">>"$DKBRANCH_DIR/cache"
	#echo "$DKENV">>"$DKBRANCH_DIR/cache"
}

###### read_cache ######
function read_cache() {
	dk_debug "read_cache("$@")"
	if ! dk_file_exists $DKBRANCH_DIR/cache; then
		return
	fi

	echo "reading cache..."
	count=0
	while read p; do
		if [ $count == 0 ]; then 
			_APP_=$(echo $p | tr -d '\r')
		fi
		if [ $count == 1 ]; then
			_TARGET_OS_=$(echo $p | tr -d '\r')
		fi
		if [ $count == 2 ]; then
			_TYPE_=$(echo $p | tr -d '\r')
		fi
		#if [ $count == 3 ]; then
		#	_DKENV_=$(echo $p | tr -d '\r')
		#fi
		(( count++ ))
	done < $DKBRANCH_DIR/cache
}

###### print_var ######
function print_var() {
	dk_debug "print_var("$@")"
	var=$1
	if [ -n "${!var}" ]; then
		echo "$1 = ${!var}"
	#else
		#echo "$1 = !!!INVALID!!!"
	fi
}

###### remove_carrage_returns ######
function remove_carrage_returns(){
	dk_debug "remove_carrage_returns("$@")"
	in=$1
	out=$(echo $in | tr -d '\r')
	# carrage returns are removed from <out>
}

if ! [[ "$@" == "" ]]; then
	"$@"
fi

main "$@"

#exec $SHELL		# keep terminal open