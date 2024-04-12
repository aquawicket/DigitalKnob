#!/bin/sh
############# DigitalKnob builder script ############

# shellcheck disable=SC2034
# shellcheck disable=SC3028
# shellcheck disable=SC2119
# shellcheck disable=SC2120






















###### Global Script Variables ######
LOG_VERBOSE=1
LOG_DEBUG=1
HALT_ON_WARNINGS=0
HALT_ON_ERRORS=0
SCRIPT_DIR=$( cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit ; pwd -P )

SCRIPT_NAME=$(basename "$0")
true=0
false=1
clr="\033[0m"
black="\033[100m"
red="\033[31m"
green="\033[32m"
yellow="\033[33m"
blue="\033[34m"
magenta="\033[35m"
cyan="\033[36m"
white="\033[37m"

CMAKE_DL_WIN_X86=https://github.com/Kitware/CMake/releases/dk_download/v3.29.0/cmake-3.29.0-windows-i386.zip
CMAKE_DL_WIN_X86_64=https://github.com/Kitware/CMake/releases/dk_download/v3.29.0/cmake-3.29.0-windows-x86_64.zip
CMAKE_DL_WIN_ARM64=https://github.com/Kitware/CMake/releases/dk_download/v3.29.0/cmake-3.29.0-windows-arm64.zip
CMAKE_DL_MAC=https://github.com/Kitware/CMake/releases/dk_download/v3.29.0/cmake-3.29.0-macos-universal.tar.gz
#CMAKE_DL_MAC=https://github.com/Kitware/CMake/releases/dk_download/v3.29.0/cmake-3.29.0-macos10.10-universal.tar.gz
CMAKE_DL_LINUX_X86_64=https://github.com/Kitware/CMake/releases/dk_download/v3.29.0/cmake-3.29.0-linux-x86_64.tar.gz
CMAKE_DL_LINUX_ARM64=https://github.com/Kitware/CMake/releases/dk_download/v3.29.0/cmake-3.29.0-linux-aarch64.tar.gz

GIT_DL_WIN_X86=https://github.com/git-for-windows/git/releases/dk_download/v2.44.0.windows.1/PortableGit-2.44.0-32-bit.7z.exe
GIT_DL_WIN_X86_64=https://github.com/git-for-windows/git/releases/dk_download/v2.44.0.windows.1/PortableGit-2.44.0-64-bit.7z.exe


##################################################################################
# main()
#
#
main() {
	dk_verbose "main($*)"

	dk_validate_sudo
	
	if dk_defined WSLENV; then 
		dk_info "WSLENV is on"
		dk_info "calling sudo chown -R $LOGNAME $HOME to allow windows write access to \\\wsl.localhost\DISTRO\home\\$LOGNAME"
		sudo chown -R "$LOGNAME" "$HOME"
	fi
	
	# log to stdout and file
	#exec |& tee file.log 

	if [ -n "$USER" ]; then
		DKUSERNAME=$USER
	elif [ -n "$USERNAME" ]; then
		DKUSERNAME=$USERNAME
	fi
	dk_debug DKUSERNAME
	DKLOGNAME=$LOGNAME
	dk_debug DKLOGNAME
	DKHOME=$HOME
	dk_debug DKHOME
	DKPREFIX=$PREFIX
	dk_debug DKPREFIX
	DKTERM=$TERM
	dk_debug DKTERM
	DKSHELL=$SHELL
	dk_debug DKSHELL
	DKPATH=$PATH
	dk_debug DKPATH
	DKPWD=$PWD
	dk_debug DKPWD
	
	dk_debug SHLVL			# https://stackoverflow.com/a/4511483/688352
	dk_debug HOSTNAME
	dk_debug HOSTTYPE
	dk_debug MACHTYPE
	dk_debug MSYSTEM
	dk_debug OSTYPE
	dk_debug SCRIPT_NAME
	dk_debug SCRIPT_DIR
	dk_debug USER
	dk_debug USERNAME
	
	## Get the HOST_TRIPLE and other HOST variables
	dk_get_host_triple || dk_error "Could not determine HOST_TRIPLE"
	
	if [ -n "$USERPROFILE" ]; then
		DIGITALKNOB_DIR="$USERPROFILE\digitalknob"
		#DIGITALKNOB_DIR=$(sed 's.C:./c.g' <<< $DIGITALKNOB_DIR)
		#DIGITALKNOB_DIR=$(sed 's.\\./.g' <<< $DIGITALKNOB_DIR)
		dk_replace_all "$DIGITALKNOB_DIR" "\\" "/" DIGITALKNOB_DIR
		dk_replace_all "$DIGITALKNOB_DIR" "C:" "/c" DIGITALKNOB_DIR
	else
		DIGITALKNOB_DIR="$HOME/digitalknob"
	fi
	mkdir -p "$DIGITALKNOB_DIR";
	dk_debug DIGITALKNOB_DIR

	DKDOWNLOAD_DIR="$DIGITALKNOB_DIR/dk_download"
	mkdir -p "$DKDOWNLOAD_DIR";
	dk_debug DKDOWNLOAD_DIR
	
	DKTOOLS_DIR="$DIGITALKNOB_DIR/DKTools"
	mkdir -p "$DKTOOLS_DIR";
	dk_debug DKTOOLS_DIR

	if [ "$HOST_OS" = "mac" ]; then
		dk_validate_homebrew
	fi

	dk_validate_git
	dk_validate_branch

	dk_debug DKBRANCH_DIR
	dk_debug DKAPPS_DIR
	dk_debug DKCMAKE_DIR
	dk_debug DK3RDPARTY_DIR
	dk_debug DKIMPORTS_DIR
	dk_debug DKPLUGINS_DIR

	if [ ! "$SCRIPT_DIR" = "$DKBRANCH_DIR" ]; then
		dk_warning "$SCRIPT_NAME is not running from the DKBRANCH_DIR directory. Any changes will not be saved by git!"
		dk_warning "$SCRIPT_NAME path = $SCRIPT_DIR"
		dk_warning "DKBRANCH_DIR path = $DKBRANCH_DIR"
	fi
	
	while :
	do
		if [ -z "$UPDATE" ]; then dk_pick_update;	continue; fi
		if [ -z "$APP" ]; then dk_pick_app;		continue; fi
		if [ -z "$TARGET_OS" ]; then dk_pick_os;	continue; fi
		if [ -z "$TYPE" ]; then dk_pick_type;		continue; fi
		
		dk_create_cache
		
		dk_generate
		#if [ "$TARGET_OS" = "android_arm32" ]     dk_generate_toolchain android_arm32_toolchain
		#if [ "$TARGET_OS" = "android_arm64" ]     dk_generate_toolchain android_arm64_toolchain
		#if [ "$TARGET_OS" = "emscripten" ]        dk_generate_toolchain emscripten_toolchain
		#if [ "$TARGET_OS" = "win_arm64_clang" ]   dk_generate_toolchain windows_arm64_clang_toolchain
		#if [ "$TARGET_OS" = "win_x86_mingw" ]     dk_generate_toolchain windows_x86_mingw_toolchain
		#if [ "$TARGET_OS" = "win_x86_clang" ]     dk_generate_toolchain windows_x86_clang_toolchain
		#if [ "$TARGET_OS" = "win_x86_msvc" ]      dk_generate_toolchain windows_x86_msvc_toolchain
		#if [ "$TARGET_OS" = "win_x86_64_mingw" ]  dk_generate_toolchain windows_x86_64_mingw_toolchain
		#if [ "$TARGET_OS" = "win_x86_64_clang" ]  dk_generate_toolchain windows_x86_64_clang_toolchain
		#if [ "$TARGET_OS" = "win_x86_64_ucrt" ]   dk_generate_toolchain windows_x86_64_ucrt_toolchain
		#if [ "$TARGET_OS" = "win_x86_64_msvc" ]   dk_generate_toolchain windows_x86_64_msvc_toolchain
		
		dk_build
		
		unset UPDATE
		unset APP
		unset TARGET_OS
		unset TYPE
	done
}


##################################################################################
# dk_pick_update()
#
#
dk_pick_update() {
	dk_verbose "dk_pick_update($*)"
	[ -n "$1" ] && dk_error "dk_pick_update($*): Too many parameters"

	dk_read_cache
	
	dk_echo
	dk_check_remote
	dk_echo

	#dk_debug _APP_
	#dk_debug _TARGET_OS_ 
	#dk_debug _TYPE_

	if [ "$behind" = "0" ]; then
		if [ -n "$_APP_" ] && [ -n "$_TARGET_OS_" ] && [ -n "$_TYPE_" ]; then
			dk_echo " 0) Repeat cache [$_APP_ - $_TARGET_OS_ - $_TYPE_]"
		fi
		dk_echo " 1) Git Update"   
		dk_echo " 2) Git Commit"
		dk_echo " 3) Push assets"
		dk_echo " 4) Pull assets"
		dk_echo " 5) Reset All"
		dk_echo " 6) Remove All"
		dk_echo " 7) Clear Screen"
		dk_echo " 8) Clear cmake cache and .tmp files"
		dk_echo " 9) Reload"
		dk_echo "10) Exit"
		dk_echo
		dk_echo " Press Enter To Skip"
	else
		dk_warning "Your local repository is behind, please git update"
		dk_echo
		dk_echo "${red}" 
		if [ -n "$_APP_" ] && [ -n "$_TARGET_OS_" ] && [ -n "$_TYPE_" ]; then
			dk_echo " 0) Repeat cache [$_APP_ - $_TARGET_OS_ - $_TYPE_]"
		fi
		dk_echo "${green}"
		dk_echo " 1) Git Update"
		dk_echo "${red}"  
		dk_echo " 2) Git Commit"
		dk_echo " 3) Push assets"
		dk_echo " 4) Pull assets"
		dk_echo " 5) Reset All"
		dk_echo " 6) Remove All"
		dk_echo " 7) Clear Screen"
		dk_echo " 8) Clear cmake cache and .tmp files"
		dk_echo " 9) Reload"
		dk_echo "10) Exit"
		dk_echo
		dk_echo "Press Enter To Skip"
		dk_echo "${clr}"
	fi
	
	read input
	if [ "$input" = "0" ]; then
		dk_echo "repeating last selection"
		APP=$_APP_
		TARGET_OS=$_TARGET_OS_
		TYPE=$_TYPE_
		UPDATE=1
	elif [ "$input" = "1" ]; then
		dk_git_update
	elif [ "$input" = "2" ]; then
		dk_git_commit
	elif [ "$input" = "3" ]; then
		dk_push_assets
	elif [ "$input" = "4" ]; then
		dk_pull_assets
	elif [ "$input" = "5" ]; then
		dk_reset_all
	elif [ "$input" = "6" ]; then
		dk_remove_all
	elif [ "$input" = "7" ]; then
		clear
	elif [ "$input" = "8" ]; then
		dk_clear_cmake_cache
		dk_delete_temp_files
	elif [ "$input" = "9" ]; then
		dk_reload
	elif [ "$input" = "10" ]; then
		exit 0	
	elif [ "$input" = "" ]; then
		UPDATE=1
	else
		dk_warning "invalid selection"
	fi
}


##################################################################################
# dk_pick_app()
#
#
dk_pick_app() {
	dk_verbose "dk_pick_app($*)"
	[ -n "$1" ] && dk_error "dk_pick_app($*): Too many parameters"

	dk_echo
	dk_echo "${APP}  ${TARGET_OS} ${TYPE}"
	
	dk_echo
    dk_echo " 1) HelloWorld"
    dk_echo " 2) DKCore"
    dk_echo " 3) DKJavascript"
    dk_echo " 4) DKSDL"
    dk_echo " 5) DKSDLRml"
    dk_echo " 6) DKDomTest"
    dk_echo " 7) DKTestAll"
    dk_echo " 8) Enter Manually"
    dk_echo " 9) Clear Screen"
    dk_echo "10) Go Back"
    dk_echo "11) Reload"
	dk_echo "12) Exit"
    dk_echo 
	
	read input
	if [ "$input" = "1" ]; then
		APP="HelloWorld"
	elif [ "$input" = "2" ]; then
		APP="DKCore"
	elif [ "$input" = "3" ]; then
		APP="DKJavascript"
	elif [ "$input" = "4" ]; then
		APP="DKSDL"
	elif [ "$input" = "5" ]; then
		APP="DKSDLRml"
	elif [ "$input" = "6" ]; then
		APP="DKDomTest"
	elif [ "$input" = "7" ]; then
		APP="DKTestAll"
	elif [ "$input" = "8" ]; then
		dk_enter_manually
	elif [ "$input" = "9" ]; then
		clear
	elif [ "$input" = "10" ]; then
		UPDATE=
	elif [ "$input" = "11" ]; then
		dk_call dk_reload
	elif [ "$input" = "12" ]; then
		exit 0
	else
		dk_warning "invalid selection"
	fi
}


##################################################################################
# dk_pick_os()
#
#
dk_pick_os() {
	dk_verbose "dk_pick_os($*)"
	[ -n "$1" ] && dk_error "dk_pick_os($*): Too many parameters"

	dk_echo
	dk_echo "${APP} ${TARGET_OS} ${TYPE}"
	dk_echo	
    dk_echo " 1) $HOST_TRIPLE"
	dk_echo
	dk_echo " 2) Android arm32"
	dk_echo " 3) Android arm64"
	dk_echo " 4) Android x86"
	dk_echo " 5) Android x86_64"
	dk_echo " 6) Emscripten"
	dk_echo " 7) Ios arm32"
	dk_echo " 8) Ios arm64"
	dk_echo " 9) Ios x86"
	dk_echo "10) Ios x86_64"
	dk_echo "11) Iossim arm32"
	dk_echo "12) Iossim arm64"
	dk_echo "13) Iossim x86"
	dk_echo "14) Iossim x86_64"
	dk_echo "15) Linux arm32"
	dk_echo "16) Linux arm64"
	dk_echo "17) Linux x86"
	dk_echo "18) Linux x86_64"
	dk_echo "19) Mac arm32"
	dk_echo "20) Mac arm64"
	dk_echo "21) Mac x86"
	dk_echo "22) Mac x86_64"
	dk_echo "23) Raspberry arm32"
	dk_echo "24) Raspberry arm64"
	dk_echo "25) Raspberry x86"
	dk_echo "26) Raspberry x86_64"
	dk_echo "27) Windows arm32"
	dk_echo "28) Windows arm64 (clang)"
	dk_echo "29) Windows x86 (gcc)"
	dk_echo "30) Windows x86 (clang)"
	dk_echo "31) Windows x86 (msvc)"
	dk_echo "32) Windows x86_64 (gcc)"
    dk_echo "33) Windows x86_64 (clang)"
    dk_echo "34) Windows x86_64 (ucrt)"
    dk_echo "35) Windows x86_64 (msvc)"
	dk_echo "36) Clear Screen"
	dk_echo "37) Go Back"
	dk_echo "38) Exit"
	dk_echo
	
	read input
	if [ "$input" = "1" ]; then
		TARGET_OS="$HOST_TRIPLE"
	elif [ "$input" = "2" ]; then
		TARGET_OS="android_arm32"
	elif [ "$input" = "3" ]; then
		TARGET_OS="android_arm64"
	elif [ "$input" = "4" ]; then
		TARGET_OS="android_x86"
	elif [ "$input" = "5" ]; then
		TARGET_OS="android_x86_64"
	elif [ "$input" = "6" ]; then
		TARGET_OS="emscripten"
	elif [ "$input" = "7" ]; then
		TARGET_OS="ios_arm32"
	elif [ "$input" = "8" ]; then
		TARGET_OS="ios_arm64"
	elif [ "$input" = "9" ]; then
		TARGET_OS="ios_x86"
	elif [ "$input" = "10" ]; then
		TARGET_OS="ios_x86_64"
	elif [ "$input" = "11" ]; then
		TARGET_OS="iossim_arm32"
	elif [ "$input" = "12" ]; then
		TARGET_OS="iossim_arm64"
	elif [ "$input" = "13" ]; then
		TARGET_OS="iossim_x86"
	elif [ "$input" = "14" ]; then
		TARGET_OS="iossim_x86_64"
	elif [ "$input" = "15" ]; then
		TARGET_OS="linux_arm32"
	elif [ "$input" = "16" ]; then
		TARGET_OS="linux_arm64"
	elif [ "$input" = "17" ]; then
		TARGET_OS="linux_x86"
	elif [ "$input" = "18" ]; then
		TARGET_OS="linux_x86_64"
	elif [ "$input" = "19" ]; then
		TARGET_OS="mac_arm32"
	elif [ "$input" = "20" ]; then
		TARGET_OS="mac_arm64"
	elif [ "$input" = "21" ]; then
		TARGET_OS="mac_x86"
	elif [ "$input" = "22" ]; then
		TARGET_OS="mac_x86_64"
	elif [ "$input" = "23" ]; then
		TARGET_OS="raspberry_arm32"
	elif [ "$input" = "24" ]; then
		TARGET_OS="raspberry_arm64"
	elif [ "$input" = "25" ]; then
		TARGET_OS="raspberry_x86"
	elif [ "$input" = "26" ]; then
		TARGET_OS="raspberry_x64"
	elif [ "$input" = "27" ]; then
		TARGET_OS="win_arm32"
	elif [ "$input" = "28" ]; then
		TARGET_OS="win_arm64_clang"
	elif [ "$input" = "29" ]; then
		TARGET_OS="win_x86_mingw"
	elif [ "$input" = "30" ]; then
		TARGET_OS="win_x86_clang"
	elif [ "$input" = "31" ]; then
		TARGET_OS="win_x86_msvc"
	elif [ "$input" = "32" ]; then
		TARGET_OS="win_x86_64_mingw"
	elif [ "$input" = "33" ]; then
		TARGET_OS="win_x86_64_clang"
	elif [ "$input" = "34" ]; then
		TARGET_OS="win_x86_64_ucrt"
	elif [ "$input" = "35" ]; then
		TARGET_OS="win_x86_64_msvc"
	elif [ "$input" = "36" ]; then
		clear
	elif [ "$input" = "37" ]; then
		APP=
	elif [ "$input" = "38" ]; then
		exit 0
	else
		dk_warning "invalid selection"
	fi
}


##################################################################################
# dk_pick_type()
#
#
dk_pick_type() {
	dk_verbose "dk_pick_type($*)"
	[ -n "$1" ] && dk_error "dk_pick_type($*): Too many parameters"

	dk_echo
	dk_echo "${APP} ${TARGET_OS} ${TYPE}"
	dk_echo	
    dk_echo " 1) Debug"
	dk_echo " 2) Release"
	dk_echo " 3) All"
	dk_echo " 4) Clear Screen"
	dk_echo " 5) Go Back"
	dk_echo " 6) Exit"
	dk_echo
	
	read input
	if [ "$input" = "1" ]; then
		TYPE="Debug"
	elif [ "$input" = "2" ]; then
		TYPE="Release"
	elif [ "$input" = "3" ]; then
		TYPE="All"
	elif [ "$input" = "4" ]; then
		clear
	elif [ "$input" = "5" ]; then
		TARGET_OS=
	elif [ "$input" = "6" ]; then
		exit 0
	else
		dk_warning "invalid selection"
	fi
}


##################################################################################
# dk_add_cmake_arg(<string>)
#
#
#dk_add_cmake_arg() {
#	dk_verbose "dk_add_cmake_arg($*)"
#
#   if [ "$*" = "" ]; then dk_error "dk_add_cmake_arg is empty!" & return 1
#    dk_echo added $*
#    CMAKE_ARGS+=( "%*" )
#}


##################################################################################
# dk_generate(<toolchain>)
#
#
dk_generate() {
	dk_verbose "dk_generate($*)"
	[ -n "$2" ] && dk_error "dk_generate($*): Too many parameters"
	
	dk_echo
	dk_echo "##################################################################"
	dk_echo "     Generating $APP - $TARGET_OS - $TYPE - $DKLEVEL"
	dk_echo "##################################################################"
	dk_echo

	dk_clear_cmake_cache
	dk_delete_temp_files

	TARGET_PATH="$DKAPPS_DIR"/"$APP"
	dk_debug TARGET_PATH
	mkdir -p "$TARGET_PATH"/"$TARGET_OS"
	cd "$TARGET_PATH"/"$TARGET_OS" || dk_error "cd $TARGET_PATH/$TARGET_OS failed!"
	CMAKE_SOURCE_DIR="$DKCMAKE_DIR"
	dk_debug CMAKE_SOURCE_DIR
	if ! dk_file_exists "$CMAKE_SOURCE_DIR"; then
		dk_error "CMAKE_SOURCE_DIR does not exist"
	fi
	dk_debug CMAKE_SOURCE_DIR
	CMAKE_TARGET_PATH=$TARGET_PATH
	dk_debug CMAKE_TARGET_PATH
	
	###### BUILD CMAKE_ARGS ARRAY ######
	DKLEVEL="RebuildAll"
	DKLINK="Static"
	
	#declare -a CMAKE_ARGS
	set --											#clear the positional parameters
	if [ "$TYPE" = "Debug" ]; then
		#CMAKE_ARGS+=( "-DDEBUG=ON" )
		#CMAKE_ARGS+=( "-DRELEASE=OFF" )
		set -- "$@" "-DDEBUG=ON"
		set -- "$@" "-DRELEASE=OFF"
	fi
	if [ "$TYPE" = "Release" ]; then
		#CMAKE_ARGS+=( "-DDEBUG=OFF" )
		#CMAKE_ARGS+=( "-DRELEASE=ON" )
		set -- "$@" "-DDEBUG=OFF"
		set -- "$@" "-DRELEASE=ON"
	fi
	if [ "$TYPE" = "All" ]; then
		#CMAKE_ARGS+=( "-DDEBUG=ON" )
		#CMAKE_ARGS+=( "-DRELEASE=ON" )
		set -- "$@" "-DDEBUG=ON"
		set -- "$@" "-DRELEASE=ON"
	fi
	if [ $DKLEVEL = "Build" ]; then
		#CMAKE_ARGS+=( "-DBUILD=ON" )
		set -- "$@" "-DBUILD=ON"
	fi
	if [ $DKLEVEL = "Rebuild" ]; then
		#CMAKE_ARGS+=( "-DREBUILD=ON" )
		set -- "$@" "-DREBUILD=ON"
	fi
	if [ $DKLEVEL = "RebuildAll" ]; then
		#CMAKE_ARGS+=( "-DREBUILDALL=ON" )
		set -- "$@" "-DREBUILDALL=ON"
	fi
	if [ $DKLINK = "Static" ]; then
		#CMAKE_ARGS+=( "-DSTATIC=ON" )
		set -- "$@" "-DSTATIC=ON"
	fi
	if [ $DKLINK = "Shared" ]; then
		#CMAKE_ARGS+=( "-DSHARED=ON" )
		set -- "$@" "-DSHARED=ON"
	fi
	
	CMAKE_BINARY_DIR=$CMAKE_TARGET_PATH/$TARGET_OS/$TYPE
	dk_debug CMAKE_BINARY_DIR
	
	if ! dk_defined WSLENV; then 
		#CMAKE_ARGS+=( "-S=$CMAKE_SOURCE_DIR" )
		set -- "$@" "-S=$CMAKE_SOURCE_DIR"
	fi
	#CMAKE_ARGS+=( "-B=$CMAKE_BINARY_DIR" )
	set -- "$@" "-B=$CMAKE_BINARY_DIR"
	
	############ CMake Options ############
    #CMAKE_ARGS+=( "-DCMAKE_VERBOSE_MAKEFILE=1" )
	#CMAKE_ARGS+=( "-DCMAKE_COLOR_DIAGNOSTICS=ON" )
	#CMAKE_ARGS+=( "-Wdev" )
	#CMAKE_ARGS+=( "-Werror=dev" )
	#CMAKE_ARGS+=( "-Wdeprecated" )
	#CMAKE_ARGS+=( "-Werror=deprecated" )
	#CMAKE_ARGS+=( "--graphviz=graphviz.txt" )
	#CMAKE_ARGS+=( "--system-information system_information.txt" )
	#CMAKE_ARGS+=( "--debug-trycompile" )
	#CMAKE_ARGS+=( "--debug-output" )
	#CMAKE_ARGS+=( "--trace" )
	#CMAKE_ARGS+=( "--trace-expand" )
	#CMAKE_ARGS+=( "--warn-uninitialized" )
	#CMAKE_ARGS+=( "--warn-unused-vars" )
	#CMAKE_ARGS+=( "--check-system-vars" )
	
	if [ "$TARGET_OS" = "android_arm32" ]; then
		#CMAKE_ARGS+=( "-G Unix Makefiles" )
		set -- "-G Unix Makefiles" "$@"
	fi

	if [ "$TARGET_OS" = "android_arm64" ]; then
		#CMAKE_ARGS+=( "-G Unix Makefiles" )
		set -- "-G Unix Makefiles" "$@"
	fi
	
	if [ "$TARGET_OS" = "emscripten" ]; then
		#CMAKE_ARGS+=( "-G Unix Makefiles" )
		set -- "-G Unix Makefiles" "$@"
	fi
	
	if [ "$TARGET_OS" = "ios_arm32" ]; then
		#CMAKE_ARGS+=( "-G Xcode" )
		set -- "-G Xcode" "$@"
	fi
	
	if [ "$TARGET_OS" = "ios_arm64" ]; then
		#CMAKE_ARGS+=( "-G Xcode" )
		set -- "-G Xcode" "$@"
	fi
	
	if [ "$TARGET_OS" = "iossim_x86" ]; then
		#CMAKE_ARGS+=( "-G Xcode" )
		set -- "-G Xcode" "$@"
	fi
	
	if [ "$TARGET_OS" = "iossim_x86_64" ]; then
		#CMAKE_ARGS+=( "-G Xcode" )
		set -- "-G Xcode" "$@"
	fi
	
	if [ "$TARGET_OS" = "linux_x86" ]; then
		#CMAKE_ARGS+=( "-G Unix Makefiles" )
		set -- "-G Unix Makefiles" "$@"
	fi
	
	if [ "$TARGET_OS" = "linux_x86_64" ]; then
		#CMAKE_ARGS+=( "-G Unix Makefiles" )
		set -- "-G Unix Makefiles" "$@"
	fi
	
	if [ "$TARGET_OS" = "mac_x86" ]; then
		#CMAKE_ARGS+=( "-G Xcode" )
		set -- "-G Xcode" "$@"
	fi
	
	if [ "$TARGET_OS" = "mac_x86_64" ]; then
		#CMAKE_ARGS+=( "-G Xcode" )
		set -- "-G Xcode" "$@"
	fi
	
	if [ "$TARGET_OS" = "raspberry_arm32" ]; then
		#CMAKE_ARGS+=( "-G Unix Makefiles" )
		set -- "-G Unix Makefiles" "$@"
	fi
	
	if [ "$TARGET_OS" = "raspberry_arm64" ]; then
		#CMAKE_ARGS+=( "-G Unix Makefiles" )
		set -- "-G Unix Makefiles" "$@"
	fi
	
	if [ "$TARGET_OS" = "win_x86" ]; then
		#CMAKE_ARGS+=( "-G MSYS Makefiles" )
		#CMAKE_ARGS+=( "-DCMAKE_EXE_LINKER_FLAGS=-static -mconsole" )
		set -- "-G MSYS Makefiles" "$@"
	fi
	
	if [ "$TARGET_OS" = "win_x86_64" ]; then
		#CMAKE_ARGS="${CMAKE_ARGS}\n-G\nMSYS Makefiles" )
		#CMAKE_ARGS+=( "-DCMAKE_EXE_LINKER_FLAGS=-static -mconsole" )
		set -- "-G MSYS Makefiles" "$@"
	fi
		
	#### CMAKE CALL ####
	dk_validate_cmake
	TOOLCHAIN="${DKCMAKE_DIR}/toolchains/${TARGET_OS}_toolchain.cmake"
	dk_echo "TOOLCHAIN = $TOOLCHAIN"
	if dk_file_exists "$TOOLCHAIN"; then
		#CMAKE_ARGS+=( "-DCMAKE_TOOLCHAIN_FILE=$TOOLCHAIN" )
		set -- "$@" "-DCMAKE_TOOLCHAIN_FILE=$TOOLCHAIN"
	fi
	
	if dk_defined WSLENV; then 
		cd "$DKCMAKE_DIR" || dk_error "cd $DKCMAKE_DIR failed!"
		#$CMAKE_ARGS+=( "." )
		set -- "$@" "."
	fi
	
	dk_echo "CMAKE_ARGS = $@"	
	dk_call "$CMAKE_EXE" "$@"
}


##################################################################################
# dk_generate_toolchain(<toolchain>)
#
#
#dk_generate_toolchain() {
#	dk_verbose "dk_generate_toolchain($*)"
#
#	toolchain=$1
#	
#	# TODO: we need a good way to pull the CMAKE_GENERATOR from the toolchain files.
#   ###### CMAKE_GENERATOR ######
#    string_contains $toolchain android hasAndroid
#    if "$hasAndroid" == "1"; then 
#        CMAKE_GENERATOR="Unix Makefiles"
#    elif [ ! "$hasAndroid" == "1" ]; then
#		CMAKE_GENERATOR="MinGW Makefiles"
#	fi
#	CMAKE_ARGS+=( "-G ${CMAKE_GENERATOR}" )
#    
#    ###### CMAKE_TOOLCHAIN_FILE ######
#	# dk_call set CMAKE_TOOLCHAIN_FILE=$DKCMAKE_DIR/toolchains/$1.cmake
#    # dk_call replace_all $CMAKE_TOOLCHAIN_FILE "\\" "/" CMAKE_TOOLCHAIN_FILE
#    # if exist $CMAKE_TOOLCHAIN_FILE CMAKE_ARGS+=( "-DCMAKE_TOOLCHAIN_FILE=$CMAKE_TOOLCHAIN_FILE" )
#   
#    ###### CMake Configure ######
#    dk_echo
#    dk_echo "****** CMAKE COMMAND ******"
#    dk_echo "${CMAKE_EXE}" "$CMAKE_ARGS"
#    "$CMAKE_EXE" "$CMAKE_ARGS"
#    dk_echo
#}
	

##################################################################################
# dk_build()
#
#
dk_build () {
	dk_verbose "dk_build($*)"
	[ -n "$1" ] && dk_error "dk_build($*): Too many parameters"

	dk_echo
	dk_echo "##################################################################"
	dk_echo "****** Building $APP - $TARGET_OS - $TYPE - $DKLEVEL ******"
	dk_echo "##################################################################"
	dk_echo
	
	if [ "$TYPE" = "Debug" ] || [ "$TYPE" = "All" ]; then
		if dk_file_exists "$DKAPPS_DIR/$APP/$TARGET_OS/Debug/CMakeCache.txt"; then
			dk_call "$CMAKE_EXE" --build "$DKAPPS_DIR/$APP/$TARGET_OS/Debug" --config Debug --verbose
		elif dk_file_exists "$DKAPPS_DIR/$APP/$TARGET_OS/CMakeCache.txt"; then
			dk_call "$CMAKE_EXE" --build "$DKAPPS_DIR/$APP/$TARGET_OS" --config Debug --verbose
		else
			dk_error "Could not find CMakeCache.txt in $APP/$TARGET_OS/Debug or $APP/$TARGET_OS"
		fi
	fi
	if [ "$TYPE" = "Release" ] || [ "$TYPE" = "All" ]; then
		if dk_file_exists "$DKAPPS_DIR/$APP/$TARGET_OS/Release/CMakeCache.txt"; then
			dk_call "$CMAKE_EXE" --build "$DKAPPS_DIR/$APP/$TARGET_OS/Release" --config Release --verbose
		elif dk_file_exists "$DKAPPS_DIR/$APP/$TARGET_OS/CMakeCache.txt"; then
			dk_call "$CMAKE_EXE" --build "$DKAPPS_DIR/$APP/$TARGET_OS" --config Release --verbose
		else
			dk_error "Could not find CMakeCache.txt in $APP/$TARGET_OS/Release or $APP/$TARGET_OS"
		fi
	fi
	
	dk_echo
	dk_echo "##################################################################"
	dk_echo "****** Done Building $APP - $TARGET_OS - $TYPE - $DKLEVEL ******"
	dk_echo "##################################################################"
	dk_echo
}


##################################################################################
# dk_echo(<message>)
#
#
dk_echo () {
	#echo "dk_echo($*)"

	[ -d "/proc" ] && shell_type=$(basename $(readlink /proc/$$/exe))
	[ "$SHELL" = "/bin/zsh" ] && shell_type="zsh" 
	#echo "shell_type = $shell_type"

	if [ "$shell_type" = "sh" ]; then  
		echo "$1"
	elif [ "$shell_type" = "dash" ]; then
		echo "$1"
	elif [ "$shell_type" = "zsh" ]; then
		echo "$1"
	else	
		echo -e "$1"
	fi
}


##################################################################################
# dk_verbose(<message>)
#
#
dk_verbose () {
	#dk_verbose "dk_verbose($*)"
	[ -z "$1" ] && dk_error "dk_verbose($*): requires at least 1 parameter"
	
	if [ "$LOG_VERBOSE" = "1" ]; then 
		dk_echo "${cyan}VERBOSE: $1 ${clr}"
	fi
}


##################################################################################
# dk_debug(<message>)
#
#
dk_debug () {
	#dk_verbose "dk_debug($*)"
	[ -z "$1" ] && dk_error "dk_debug($*): requires at least 1 parameter"

	[ ! "$LOG_DEBUG" = "1" ] && return 0
	msg="$1"
	if dk_defined ${msg}; then
		eval value='$'{$msg}
		msg="${msg}: ${value}"
	fi

	dk_echo "${blue}  DEBUG: $msg ${clr}"
}


##################################################################################
# dk_info(<message>)
#
#
dk_info () {
	#dk_verbose "dk_info($*)"
	
	dk_echo "${white}   INFO: $1 ${clr}"
}


##################################################################################
# dk_warning(<message>)
#
#
dk_warning () {
	#dk_verbose "dk_warning($*)"
	
	dk_echo "${yellow}WARNING: $1 ${clr}"
	if [ "$TRACE_ON_WARNINGS" = "1" ]; then
		dk_stacktrace
	fi
	if [ "$HALT_ON_WARNINGS" = "1" ]; then
		exit 1
	fi
}


##################################################################################
# dk_error(<message>)
#
#
dk_error () {
	#dk_verbose "dk_error($*)"
	
	dk_echo "${red}  ERROR: $1 ${clr}"
	dk_stacktrace
	[ "$HALT_ON_ERRORS" = "1" ] && exit 1
	exit 1
}


##################################################################################
# dk_stacktrace()
#
#
dk_stacktrace () {
    dk_verbose "dk_stacktrace($*)"
	[ -n "$1" ] && dk_error "dk_stacktrace($*): Too many parameters"
	
    #local i=1 line file func								# FIXME: n POSIX sh, 'local' is undefined.
    #while read -r line func file < <(caller $i); do
    #   echo >&2 "[$i] $file:$line $func(): $(sed -n ${line}p $file)"
    #   ((i++))
    #done
}


##################################################################################
# dk_defined(<variable>)
#
#
dk_defined () {
	dk_verbose "dk_defined($*)"
	[ -z "$1" ] && dk_error "dk_defined($*): requires at least 1 parameter"
	[ -n "$2" ] && return $false
	
	var="$1"
	eval value='$'{${var}+x}
	[ -z "$value" ] && return $false
	return $true;
}


##################################################################################
# dk_call(<command args>)
#
#
dk_call () {
	dk_verbose "dk_call($*)"
	[ -z "$1" ] && dk_error "dk_call($*): requires at least 1 parameter"

	dk_echo "${magenta} $ $* ${clr}"
	"$@"
}


##################################################################################
# dk_check_remote()
#
#
dk_check_remote () {
	dk_verbose "dk_check_remote($*)"
	[ -n "$1" ] && dk_error "dk_check_remote($*): Too many parameters"

	#if [ -d .git ]; then
	if [ -d "${DKBRANCH_DIR}/.git" ]; then
		git remote update > /dev/null 2> /dev/null
		branch=$(git rev-parse --abbrev-ref HEAD)
		ahead=$(git rev-list --count origin/$branch..$branch)
		behind=$(git rev-list --count $branch..origin/$branch)
		dk_info "$ahead commits ahead, $behind commits behind"
	fi
}


##################################################################################
# dk_validate_sudo()
#
#
dk_validate_sudo () {
	dk_verbose "dk_validate_sudo($*)"
	[ -n "$1" ] && dk_error "dk_pick_update($*): Too many parameters"
	
	if command -v "sudo" >/dev/null 2>&1; then
		SUDO="sudo"
	fi
	$SUDO echo
}


##################################################################################
# dk_reload()
#
#
dk_reload () {
	dk_verbose "dk_reload($*)"
	[ -n "$1" ] && dk_error "dk_reload($*): Too many parameters"
	
	dk_debug "reloading $SCRIPT_DIR/$SCRIPT_NAME"
	clear
	exec "$SCRIPT_DIR/$SCRIPT_NAME"
}


##################################################################################
# dk_confirm()
#
#
dk_confirm() {
	dk_verbose "dk_confirm($*)"
	[ -n "$1" ] && dk_error "dk_confirm($*): Too many parameters"

	dk_echo "${yellow} Are you sure ? [Y/N] ${clr}"
	#read -p " " -n 1 -r REPLY
	read -rp $" " REPLY
	dk_echo
	dk_echo
	#result=$(echo $REPLY | grep "^[Yy]$")
	[ "$REPLY" = "y" ] && return $true
	[ "$REPLY" = "Y" ] && return $true
	return $false;
}


##################################################################################
# dk_string_contains(<string> <substring>)
#
#
dk_string_contains () {
	dk_verbose "dk_string_contains($*)"
	[ -n "$3" ] && dk_error "dk_string_contains($*): Too many parameters"

	if [ -z "$2" ]; then
		dk_error "dk_string_contains <string> <substring> requires 2 parameters"
		return $false
	fi
	
	# https://stackoverflow.com/a/8811800/688352
	string=$1
	substring=$2
	[ "${string#*"$substring"}" != "$string" ]	
	#[[ ${string} == *"${substring}"* ]]		# bash version
}



##################################################################################
# dk_command_exists(<command>)
#
#
dk_command_exists () {
	dk_verbose "dk_command_exists($*)"
	[ -n "$2" ] && dk_error "dk_command_exists($*): Too many parameters"
	
	! [ "$(command -v "$1")" = "" ]
}
	

##################################################################################
# dk_file_exists(<file>)
#
#
dk_file_exists () {
	dk_verbose "dk_file_exists($*)"
	[ -n "$2" ] && dk_error "dk_file_exists($*): Too many parameters"

	#if [ -e "$1" ]; then
	#	dk_debug "dk_file_exists($*): FOUND"
	#else
	#	dk_warning "dk_file_exists($*): NOT FOUND!" 
	#fi
	[ -e "$1" ]
}


##################################################################################
# dk_get_filename(<path> <output>)
#
#
dk_get_filename () {
	dk_verbose "dk_get_filename($*)"
	[ -n "$3" ] && dk_error "dk_file_exists($*): Too many parameters"
	
	if [ -z "$2" ]; then
		dk_error "dk_get_filename <path> <output> requires 2 parameters"
		return "$false"
	fi
	
	eval "$2=$(basename "$1")"
	#[ "$base_name" = "" ]
}


##################################################################################
# dk_convert_to_c_identifier(<input> <output>)
#
#
dk_convert_to_c_identifier () {
	dk_verbose "dk_convert_to_c_identifier($*)"
	[ -n "$3" ] && dk_error "dk_convert_to_c_identifier($*): Too many parameters"
	
	if [ -z "$2" ]; then
		dk_error "dk_convert_to_c_identifier <input> <output> requires 2 parameters"
		return $false
	fi
	input=$1
	dk_debug "input = $input"
	
	#input="${input//[^[:alnum:]]/_}"			# BASH alpha_numeric_replace
	dk_replace_all "$input" "-" "_" input		# POSIX replace
	dk_replace_all "$input" "." "_" output		# POSIX replace
	
	dk_debug "output = $output"
	eval "$2=$output"
	#[ $input = "" ]
}

##################################################################################
# dk_replace_all(<input> <searchValue> <newValue> <output>)
#
#
dk_replace_all () {
	dk_verbose "dk_replace_all($*)"
	[ -n "$5" ] && dk_error "dk_replace_all($*): Too many parameters"
	
    input=$1
	searchValue=$2
	newValue=$3
    output=
		
    while [ -n "$input" ]; do
        LEFT=${input%%"$searchValue"*}

        if [ "$LEFT" = "$input" ]; then
            output=$output$input
			break
        fi

        output=$output$LEFT$newValue
        input=${input#*"$searchValue"}
    done
	
	dk_debug "output = '$output'"
	eval "$4=$output"
}


##################################################################################
# dk_to_lower(<input> <output>)
#
#
dk_to_lower () {
	dk_verbose "dk_to_lower($*)"
	[ -z "$2" ] && dk_error "dk_to_lower($*): requires 2 parameters"
	[ -n "$3" ] && dk_error "dk_to_lower($*): Too many parameters"

	input=$1
	output=$(echo "$input" | tr '[:upper:]' '[:lower:]')
	#dk_debug output
	eval "$2=$output"
	#[ "$output" = "" ]
}


##################################################################################
# dk_download(<url> <destination>)
#
#
dk_download () {
	dk_verbose "dk_download($*)"
	[ -n "$3" ] && dk_error "dk_download($*): Too many parameters"

	if [ -z "$2" ]; then
		dk_error "dk_convert_to_c_identifier <input> <output> requires 2 parameters"
		return $false
	fi
	
	if dk_file_exists "$2"; then
		dk_warning "dk_download(): $2 already exists"
		return 0
	fi
	dk_info "Downloading $1 . . ."
	parentdir="$(dirname "$2")"
	dk_debug "parentdir = $parentdir"
	olddir=$PWD
	cd "$parentdir" || dk_error "cd $parentdir failed!"
	wget -P "$parentdir" "$1" 
	cd "$oldpwd" || dk_error "cd $oldpwd failed!"
	#[ "$input" = "" ]
}


##################################################################################
# dk_extract(<file> <destination>)
#
#
dk_extract () {
	dk_verbose "dk_extract($*)"
	[ -n "$3" ] && dk_error "dk_extract($*): Too many parameters"

	if [ -z "$2" ]; then
		dk_error "dk_extract <input> <output> requires 2 parameters"
		return $false
	fi

	filename="$(basename "$1")"
	destFolder="${filename%.*}"
	destFolder="${destFolder%.*}"
	fulldest="$2/$destFolder"
	dk_debug fulldest
		
	#if dk_file_exists $fulldest; then
	#	dk_warning "dk_extract(): $fulldest already exists"
	#	return 0
	#fi
	dk_info "Extracting $1 . . ."
	parentdir="$(dirname "$1")"
	parentdest="$(dirname "$2")"
	dk_debug "parentdir = $parentdir"
	dk_debug "filename = $filename"
	#need to cd into parent directory of $1 and send tar the file name of $1
	olddir=$PWD
	cd "$parentdir" || dk_error "cd $$parentdir failed!"
	tar -xf "$filename" -C "$2"
	cd "$oldpwd" || dk_error "cd $$oldpwd failed!"
	dk_convert_to_c_identifier "$destFolder" destFolder_
	dk_debug destFolder_
	mv "$2"/"$destFolder" "$2"/"$destFolder_"

	#echo echo "$CMAKE_FOLDER">"$2"/"$destFolder_"/dk_installed

	#TODO
	#[ "$input" = "" ]
}


##################################################################################
# dk_rename(<from> <to>)
#
#
dk_rename () {
	dk_verbose "dk_rename($*)"
	[ -n "$3" ] && dk_error "dk_rename($*): Too many parameters"

	if [ -z "$2" ]; then
		dk_error "dk_get_filename <path> <output> requires 2 parameters"
		return $false
	fi
	
	#TODO
	#[ ? = "success" ]
}


##################################################################################
# dk_validate_cmake()
#
#
dk_validate_cmake () {
	dk_verbose "dk_validate_cmake($*)"
	[ -n "$1" ] && dk_error "dk_validate_cmake($*): Too many parameters"
	
	if [ "$HOST_OS" = "android" ]; then
		CMAKE_SYSTEM_INSTALL=1
	fi
	if [ "$CMAKE_SYSTEM_INSTALL" = "1" ]; then
		dk_info "Installing CMake System packages"
		CMAKE_EXE=$(command -v cmake)
		dk_debug CMAKE_EXE
		if ! dk_command_exists cmake; then
			if [ "$MSYSTEM" = "CLANG32" ]; then
				dk_install mingw-w64-clang-i686-cmake
			elif [ "$MSYSTEM" = "CLANG64" ]; then
				dk_install mingw-w64-clang-x86_64-cmake
			elif [ "$MSYSTEM" = "CLANGARM64" ]; then
				dk_install mingw-w64-clang-aarch64-cmake
			elif [ "$MSYSTEM" = "MINGW32" ]; then
				dk_install mingw-w64-i686-cmake
			elif [ "$MSYSTEM" = "MINGW64" ]; then
				dk_install mingw-w64-x86_64-cmake
			elif [ "$MSYSTEM" = "UCRT64" ]; then
				dk_install mingw-w64-ucrt-x86_64-cmake
			else
				dk_install cmake
			fi
		fi	
		CMAKE_EXE=$(command -v cmake)
		dk_debug CMAKE_EXE
	else
		dk_info "Installing DK CMake packages"
		######################################################################################################
		if [ "${HOST_TRIPLE}" = "win_arm32" ];			then CMAKE_DL=$CMAKE_DL_WIN_ARM32;		fi
		if [ "${HOST_TRIPLE}" = "win_arm64" ];			then CMAKE_DL=$CMAKE_DL_WIN_ARM64;		fi
		if [ "${HOST_TRIPLE}" = "win_x86" ];			then CMAKE_DL=$CMAKE_DL_WIN_X86;		fi
		if [ "${HOST_TRIPLE}" = "win_x86_64" ];			then CMAKE_DL=$CMAKE_DL_WIN_X86_64;		fi
		if [ "${HOST_OS}" = "mac" ];					then CMAKE_DL=$CMAKE_DL_MAC;			fi
		if [ "${HOST_TRIPLE}" = "linux_x86_64" ];		then CMAKE_DL=$CMAKE_DL_LINUX_X86_64;	fi
		if [ "${HOST_TRIPLE}" = "linux_arm64" ];		then CMAKE_DL=$CMAKE_DL_LINUX_ARM64;	fi
		if [ "${HOST_TRIPLE}" = "raspberry_arm64" ];	then CMAKE_DL=$CMAKE_DL_LINUX_ARM64;	fi
		dk_debug CMAKE_DL
		
		dk_get_filename "$CMAKE_DL" CMAKE_DL_FILE
		dk_debug CMAKE_DL_FILE
		
		CMAKE_FOLDER="${CMAKE_DL_FILE%.*}"		# remove everything past last dot
		dk_debug CMAKE_FOLDER
		dk_debug "CMAKE_DL_FILE extension = ${CMAKE_FOLDER##*.}"
		if [ "${CMAKE_FOLDER##*.}" = "tar" ]; then
			CMAKE_FOLDER="${CMAKE_FOLDER%.*}"	# .tar.?? files remove past the last TWO dots
		fi
		
		dk_convert_to_c_identifier "$CMAKE_FOLDER" CMAKE_FOLDER
		dk_to_lower "$CMAKE_FOLDER" CMAKE_FOLDER
		dk_debug CMAKE_FOLDER
		
		if [ "${HOST_OS}" = "win" ]; then
			CMAKE_EXE=$DKTOOLS_DIR/$CMAKE_FOLDER/bin/cmake.exe
		elif [ "${HOST_OS}" = "mac" ]; then
			CMAKE_EXE=$DKTOOLS_DIR/$CMAKE_FOLDER/CMake.app/Contents/bin/cmake
		elif [ "${HOST_OS}" = "linux" ]; then
			CMAKE_EXE=$DKTOOLS_DIR/$CMAKE_FOLDER/bin/cmake
		elif [ "${HOST_OS}" = "raspberry" ]; then
			CMAKE_EXE=$DKTOOLS_DIR/$CMAKE_FOLDER/bin/cmake
		else
			dk_error "no cmake for this OS"
		fi
		dk_debug CMAKE_EXE
		
		if dk_file_exists "$CMAKE_EXE"; then return $true; fi

		dk_echo 
		dk_info "Installing cmake . . ."
		dk_download "$CMAKE_DL" "$DKDOWNLOAD_DIR"/"$CMAKE_DL_FILE"
		dk_extract "$DKDOWNLOAD_DIR"/"$CMAKE_DL_FILE" "$DKTOOLS_DIR"
		
		#if ! dk_file_exists $CMAKE_EXE; then error "cannot find cmake"; fi
	fi
}


##################################################################################
# dk_validate_git()
#
#
dk_validate_git () {
	dk_verbose "dk_validate_git($*)"
	[ -n "$1" ] && dk_error "dk_validate_git($*): Too many parameters"
	
	if ! dk_command_exists git; then
		dk_install git
	fi
	
	GIT_EXE=$(command -v git)
	dk_debug GIT_EXE
}


##################################################################################
# dk_validate_homebrew()
#
#
dk_validate_homebrew () {
	dk_verbose "dk_validate_homebrew($*)"
	[ -n "$1" ] && dk_error "dk_validate_homebrew($*): Too many parameters"

	if ! [ "$OSTYPE" = "darwin"* ]; then
		return
	fi
		
	if ! dk_command_exists brew; then
		dk_info "dk_installing Homebrew"
		ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/dk_install/master/dk_install)"
		# https://github.com/Homebrew/brew/issues/10368
		rm -fr $(brew --repo homebrew/core)
		brew tap homebrew/core
	fi
	
	BREW=$(command -v brew)
	dk_debug BREW
}


##################################################################################
# dk_package_installed(<package>)
#
#
dk_package_installed () {
	dk_verbose "dk_package_installed($*)"
	[ -n "$2" ] && dk_error "dk_package_installed($*): Too many parameters"

	if dk_command_exists dpkg-query; then
		if [ $(dpkg-query -W -f='${Status}' "$1" 2>/dev/null | grep -c "ok dk_installed") -ne 0 ]; then
			return $true
		fi
	elif dk_command_exists brew; then
		if brew list "$1" &>/dev/null; then
			return $true
		fi
	elif dk_command_exists apt; then
		dk_error "dk_package_installed() apt-get not implemented"
	elif dk_command_exists apt-get; then
		dk_error "dk_package_installed() apt-get not implemented"
	elif dk_command_exists pkg; then
		dk_error "dk_package_installed() pkg not implemented"
	elif dk_command_exists pacman; then
		if pacman -Qs "$1" > /dev/null; then
			#FIXME: this doesn't always work
			return $false;
		fi
	elif dk_command_exists tce-load; then
		#dk_error "dk_package_installed() tce-load not implemented"
		return $false
	else
		dk_error "ERROR: no package managers found"
	fi
	return $false
}


##################################################################################
# dk_install(<package>)
#
#
dk_install () {
	dk_verbose "dk_install($*)"
	[ -n "$2" ] && dk_error "dk_install($*): Too many parameters"

	#if dk_package_installed $1; then
	#	dk_warning "$1 already dk_installed"
	#	return $false;
	#fi
	
	dk_info "dk_installing $1"

	if dk_command_exists brew; then
		dk_call "$SUDO" brew dk_install "$1"
	elif dk_command_exists apt; then
		dk_call "$SUDO" apt -y dk_install "$1"
	elif dk_command_exists apt-get; then
		dk_info "found apt-get"
		dk_call "$SUDO" apt-get -y dk_install "$1"
	elif dk_command_exists pkg; then
		dk_call "$SUDO" pkg dk_install "$1"
	elif dk_command_exists pacman; then
		dk_call "$SUDO" pacman -S "$1" --noconfirm
	elif dk_command_exists tce-load; then
		dk_call "$SUDO" tce-load -wi "$1"
	else
		dk_error "ERROR: no package managers found"
	fi
}


##################################################################################
# dk_validate_package(<command> <package>)
#
#
dk_validate_package () {
	dk_verbose "dk_validate_package($*)"
	[ -n "$3" ] && dk_error "dk_validate_package($*): Too many parameters"
	
	if ! dk_command_exists "$1"; then
		dk_install "$2"
	fi
}


##################################################################################
# dk_validate_ostype()
#
#
#dk_validate_ostype () {
#	dk_verbose "dk_validate_ostype($*)"
#	[ -n "$1" ] && dk_error "dk_validate_ostype($*): Too many parameters"
#	
#	if [ -e /proc/device-tree/model ]; then
#		MODEL=$(tr -d '\0' </proc/device-tree/model)
#	fi
#
#	if [ "$OSTYPE" = "linux-gnu"* ]; then
#		DIGITALKNOB_DIR="/home/$USER/digitalknob"
#	elif [ "$OSTYPE" = "darwin"* ]; then
#		DIGITALKNOB_DIR="/Users/$USER/digitalknob"
#	elif [ "$OSTYPE" = "cygwin" ]; then
#		DIGITALKNOB_DIR="/c/Users/$USERNAME/digitalknob"
#	elif [ "$OSTYPE" = "msys" ]; then
#		DIGITALKNOB_DIR="/c/Users/$USERNAME/digitalknob"
#	elif [ "$OSTYPE" = "win32" ]; then #I'm not sure this can happen
#		DIGITALKNOB_DIR="/c/Users/$USERNAME/digitalknob" 
#	elif [ "$OSTYPE" = "freebsd"* ]; then
#		dk_error "TODO: freebsd builder incomplete"
#	elif [ "$OSTYPE" = "linux-android" ]; then
#		DIGITALKNOB_DIR="/data/data/com.termux/files/home/digitalknob"
#	else
#		dk_error "UNKNOWN OS ($OSTYPE)"
#	fi
#}


##################################################################################
# dk_validate_branch()
#
#
dk_validate_branch () {
	dk_verbose "dk_validate_branch($*)"
	[ -n "$1" ] && dk_error "dk_validate_branch($*): Too many parameters"

	# If the current folder matches the current branch set DKBRANCH, default to Development
	
	FOLDER="$(basename $(pwd))"
	DKBRANCH="Development"
	
	if dk_file_exists "$DIGITALKNOB_DIR"/"$FOLDER"/.git; then
		BRANCH="$($GIT_EXE rev-parse --abbrev-ref HEAD)"
		if [ "$BRANCH" = "$FOLDER" ]; then
			DKBRANCH="$FOLDER"
		fi
	fi
	dk_debug DKBRANCH
	
	DKBRANCH_DIR="$DIGITALKNOB_DIR/$DKBRANCH"
	dk_debug  DKBRANCH_DIR
	
	DKCMAKE_DIR="$DKBRANCH_DIR/DKCMake"
	dk_debug  DKCMAKE_DIR
	
	DK3RDPARTY_DIR="$DKBRANCH_DIR/3rdParty"
	dk_debug DK3RDPARTY_DIR
	
	DKIMPORTS_DIR="$DK3RDPARTY_DIR/_DKIMPORTS"
	dk_debug DKIMPORTS_DIR
	
	DKAPPS_DIR="$DIGITALKNOB_DIR/$DKBRANCH/DKApps"
	dk_debug DKAPPS_DIR
	
	DKPLUGINS_DIR="$DIGITALKNOB_DIR/$DKBRANCH/DKPlugins"
	dk_debug DKPLUGINS_DIR

	# make sure script is running from DKBRANCH_DIR
	#if ! [ "$SCRIPT_DIR" = "$DKBRANCH_DIR" ]; then
	#	if ! dk_file_exists $DKBRANCH_DIR/$SCRIPT_NAME; then
	#		dk_debug "$DKBRANCH_DIR/$SCRIPT_NAME"
	#		cp $SCRIPT_DIR/$SCRIPT_NAME $DKBRANCH_DIR/$SCRIPT_NAME
	#	fi
	#	dk_echo
	#	dk_info "RELOADING SCRIPT TO -> $DKBRANCH_DIR/$SCRIPT_NAME"
	#	read -p "Press enter to continue"
	#	clear
	#	if dk_file_exists $DKBRANCH_DIR/$SCRIPT_NAME; then
	#		rm $SCRIPT_DIR/$SCRIPT_NAME
	#	fi
	#	$DKBRANCH_DIR/$SCRIPT_NAME
	#	exit
	#fi
}


##################################################################################
# dk_wait_for_key()
#
#
dk_wait_for_key () {
	dk_verbose "dk_wait_for_key($*)"
	[ -n "$1" ] && dk_error "dk_wait_for_key($*): Too many parameters"
	
	read -rsp $'Press any key to continue...\n' -n 1 key
}


##################################################################################
# dk_clear_cmake_cache()
#
#
dk_clear_cmake_cache () {
	dk_verbose "dk_clear_cmake_cache($*)"
	[ -n "$1" ] && dk_error "dk_clear_cmake_cache($*): Too many parameters"
	
	dk_info "Clearing CMake cache . . ."
	cd "$DIGITALKNOB_DIR" || dk_error "cd $$DIGITALKNOB_DIR failed!"
	find . -name "CMakeCache.*" -delete
	rm -rf $(find . -type d -name CMakeFiles)
}


##################################################################################
# dk_delete_temp_files()
#
#
dk_delete_temp_files () {
	dk_verbose "dk_delete_temp_files($*)"
	[ -n "$1" ] && dk_error "dk_delete_temp_files($*): Too many parameters"

	dk_info "Deleting .TMP files . . ."
	cd "$DIGITALKNOB_DIR" || dk_error "cd $$DIGITALKNOB_DIR failed!"
	rm -rf $(find . -type d -name *.tmp)
	rm -rf $(find . -type d -name *.TMP)
	find . -name "*.tmp" -delete
	find . -name "*.TMP" -delete
}


##################################################################################
# dk_validate_msys2()
#
#
#dk_validate_msys2 () {
#	dk_verbose "dk_validate_msys2($*)"
#	[ -n "$1" ] && dk_error "dk_validate_msys2($*): Too many parameters"
#
#	dk_cmake_eval "include('$DKIMPORTS_DIR/msys2/DKMAKE.cmake')" "MSYS2"
#	dk_debug MSYS2
#}


##################################################################################
# dk_validate_make()
#
#
#dk_validate_make () {
#	dk_verbose "dk_validate_make($*)"
#	[ -n "$1" ] && dk_error "dk_validate_make($*): Too many parameters"
#
#	dk_cmake_eval "include('$DKIMPORTS_DIR/make/DKMAKE.cmake')" "MAKE_PROGRAM"
#	dk_debug MAKE_PROGRAM
#}


##################################################################################
# dk_validate_emscripten()
#
#
#dk_validate_emscripten () {
#	dk_verbose "dk_validate_emscripten($*)"
#	[ -n "$1" ] && dk_error "dk_validate_emscripten($*): Too many parameters"
#
#	dk_cmake_eval "include('$DKIMPORTS_DIR/emsdk/DKMAKE.cmake')" "EMSDK;EMSDK_ENV;EMSDK_GENERATOR;EMSDK_TOOLCHAIN_FILE;EMSDK_C_COMPILER;EMSDK_CXX_COMPILER"
#	dk_debug EMSDK
#	dk_debug EMSDK_ENV
#	dk_debug EMSDK_GENERATOR
#	dk_debug EMSDK_TOOLCHAIN_FILE
#	dk_debug EMSDK_C_COMPILER
#	dk_debug EMSDK_CXX_COMPILER
#}


##################################################################################
# dk_validate_android_ndk()
#
#
#dk_validate_android_ndk () {
#	dk_verbose "dk_validate_android_ndk($*)"
#	[ -n "$1" ] && dk_error "dk_validate_android_ndk($*): Too many parameters"
#
#	dk_cmake_eval "include('$DKIMPORTS_DIR/android-ndk/DKMAKE.cmake')" "ANDROID_NDK;ANDROID_GENERATOR;ANDROID_TOOLCHAIN_FILE;ANDROID_API;ANDROID_MAKE_PROGRAM;ANDROID_C_COMPILER;ANDROID_CXX_COMPILER"
#	dk_debug ANDROID_NDK
#	dk_debug ANDROID_GENERATOR
#	dk_debug ANDROID_TOOLCHAIN_FILE
#	dk_debug ANDROID_API
#	dk_debug ANDROID_MAKE_PROGRAM
#	dk_debug ANDROID_C_COMPILER
#	dk_debug ANDROID_CXX_COMPILER
#}


##################################################################################
# dk_validate_clang()
#
#
#dk_validate_clang () {
#	dk_verbose "dk_validate_clang($*)"
#	[ -n "$1" ] && dk_error "dk_validate_clang($*): Too many parameters"
#
#	dk_cmake_eval "include('$DKIMPORTS_DIR/clang/DKMAKE.cmake')" "CLANG_C_COMPILER;CLANG_CXX_COMPILER"
#	dk_debug CLANG_C_COMPILER
#	dk_debug CLANG_CXX_COMPILER
#}


##################################################################################
# dk_validate_gcc()
#
#
#dk_validate_gcc () {
#	dk_verbose "dk_validate_gcc($*)"
#	[ -n "$1" ] && dk_error "dk_validate_gcc($*): Too many parameters"
#
#	dk_cmake_eval "include('$DKIMPORTS_DIR/gcc/DKMAKE.cmake')" "GCC_C_COMPILER;GCC_CXX_COMPILER"
#	dk_debug GCC_C_COMPILER
#	dk_debug GCC_CXX_COMPILER
#}


##################################################################################
# dk_cmake_eval(<cmake_commands;.;.;> <return_variables;.;.;.> <-DVARS;.;.;>)
#
#			
dk_cmake_eval () {
	dk_verbose "dk_cmake_eval($*)"
	
	if [ -z "$1" ]; then
		dk_error "dk_cmake_eval() parameter 1 is invalid"
	fi
	
	commands="$1"
	variables="$2"
	#set commands=$commands:"=%"  #TODO: remove double quotes
	DKCOMMAND="$commands"
	dk_debug DKCOMMAND
	
	if [ -n "$variables" ]; then
		dk_call "$CMAKE_EXE" "-DDKCMAKE_DIR=$DKCMAKE_DIR" "-DDKCOMMAND=$DKCOMMAND" "-DDKRETURN=$2" "$3" -P "$DKCMAKE_DIR"/dev/dk_cmake_eval.cmake
		if dk_file_exists "$DKCMAKE_DIR"/cmake_vars.sh; then
	    	dk_info "executing cmake_vars.sh"
			source "$DKCMAKE_DIR"/cmake_vars.sh
			#rm $DKCMAKE_DIR/cmake_vars.sh
		fi
	else
		dk_call "$CMAKE_EXE" "-DDKCMAKE_DIR=$DKCMAKE_DIR" "-DDKCOMMAND=$DKCOMMAND" -P "$DKCMAKE_DIR"/dev/dk_cmake_eval.cmake
	fi
	#dk_debug return code: $?
}


##################################################################################
# dk_push_assets()
#
#
dk_push_assets () {
	dk_verbose "dk_push_assets($*)"
	[ -n "$1" ] && dk_error "dk_push_assets($*): Too many parameters"
	
	if ! dk_confirm; then return; fi
	dk_error "not implemented,  TODO"
}


##################################################################################
# dk_pull_assets()
#
#
dk_pull_assets () {
	dk_verbose "dk_pull_assets($*)"
	[ -n "$1" ] && dk_error "dk_pull_assets($*): Too many parameters"
	
	if ! dk_confirm; then return; fi
	dk_error "not implemented,  TODO"
}


##################################################################################
# dk_reset_all()
#
#
dk_reset_all () {
	dk_verbose "dk_reset_all($*)"
	[ -n "$2" ] && dk_error "dk_reset_all($*): Too many parameters"
	
	if ! [ "$1" = "wipe" ]; then
		clear
		dk_echo
		dk_echo
		dk_info "Do you want to reset the entire local repository . . . ?"
		dk_info "This will delete digitalknob, everything will be reset,"
		dk_info "and the repository will be re-cloned. All libraries and tools"
		dk_info "will be redk_downloaded and rebuild from start. Save any changes"
		dk_info "you wish to commit or save beforehand."
		dk_echo
		
		if ! dk_confirm; then return; fi
		
		# first we need to relocate this file up one directory
		# make sure script is running from DKBRANCH_DIR
		if ! [ "$SCRIPT_DIR" = "$DKBRANCH_DIR" ]; then
			dk_echo "${yellow}"
			dk_echo "WARNING: this file isn't running from the branch directory"
			dk_echo "Is must be in the branch directory to continue."
			dk_echo "SCRIPT_DIR = $SCRIPT_DIR"
			dk_echo "${clr}"			
			dk_debug DKBRANCH_DIR
			return $false;
		fi
		
		dk_info "RELOCATING SCRIPT TO -> $DIGITALKNOB_DIR/$SCRIPT_NAME"
		cp "$SCRIPT_DIR"/"$SCRIPT_NAME" "$DIGITALKNOB_DIR"/"$SCRIPT_NAME"
		. "$DIGITALKNOB_DIR/$SCRIPT_NAME" dk_reset_all wipe
		exit
	else	
		#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		#:wipe
		
		#do we need sudo rights?
		#do we need to kill any processes?
		#do we need to undk_install any apps?
		#do we need to remove any environment variables?
		
		cd "$DIGITALKNOB_DIR" || dk_error "cd $$DIGITALKNOB_DIR failed!"
		dk_echo
		dk_info "DELETING $DKBRANCH_DIR . . . ."
		rm -r -f "$DKBRANCH_DIR"
		dk_info "done."
		
		# wait for the folders to get deleted
		sleep 10

		if dk_file_exists "$DKBRANCH_DIR"; then
			dk_error "Oh no, the BRANCH folder is still there! :( "
		fi
		
		dk_git_update NO_CONFIRM
		
		# wait for build.sh to show up
		sleep 2
		
		if dk_file_exists "$DKBRANCH_DIR"/"$SCRIPT_NAME"; then
			clear
			source "$DKBRANCH_DIR"/"$SCRIPT_NAME" rm -r "$DIGITALKNOB_DIR"/"$SCRIPT_NAME"
			exit
		else
			dk_error "Oh no, the git cloned build.sh still isn't here! :( "
		fi
	fi
}


##################################################################################
# dk_remove_all()
#
#
dk_remove_all () {
	dk_verbose "dk_remove_all($*)"
	[ -n "$1" ] && dk_error "dk_reset_all($*): Too many parameters"
	
	if ! [ "$1" = "wipe" ]; then	
		clear
		dk_echo
		dk_echo
		dk_echo "Do you want to remove the entire local repository . . . ?"
		dk_echo "This will delete digitalknob, Save any changes"
		dk_echo "you wish to commit or save beforehand."		
		dk_echo
		
		if ! dk_confirm; then return; fi
		
		# first we need to relocate this file up one directory
		# make sure script is running from DKBRANCH_DIR
		if ! [ "$SCRIPT_DIR" = "$DKBRANCH_DIR" ]; then
			dk_echo "${yellow}"				
			dk_echo "WARNING: this file isn't running from the branch directory"
			dk_echo "Is must be in the branch directory to continue."
			dk_echo "SCRIPT_DIR = $SCRIPT_DIR"
			dk_echo "${clr}"			
			dk_debug DKBRANCH_DIR
			return 1;
		fi
		
		dk_info "RELOCATING SCRIPT TO -> $DIGITALKNOB_DIR/$SCRIPT_NAME"
		cp "$SCRIPT_DIR"/"$SCRIPT_NAME" "$DIGITALKNOB_DIR"/"$SCRIPT_NAME"
		source "$DIGITALKNOB_DIR/$SCRIPT_NAME" dk_remove_all wipe
		exit
	else	
		#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		#:wipe
		
		#do we need sudo rights?
		#do we need to kill any processes?
		#do we need to undk_install any apps?
		#do we need to remove any environment variables?
		
		cd "$DIGITALKNOB_DIR" || dk_error "cd $$DIGITALKNOB_DIR failed!"
		dk_echo
		dk_info "DELETING $DKBRANCH_DIR . . . ."
		rm -r -f "$DKBRANCH_DIR"
		dk_info "done."
		
		# wait for the folders to get deleted
		sleep 3
		
		if dk_file_exists "$DKBRANCH_DIR"; then
			dk_error "Oh no, the BRANCH folder is still there! :( "
		fi
	fi
}


##################################################################################
# dk_git_update()
#
#
dk_git_update () {
	dk_verbose "dk_git_update($*)"
	[ -n "$1" ] && dk_error "dk_git_update($*): Too many parameters"

	if ! [ "$1" = "NO_CONFIRM" ]; then
		dk_info "Git Update? Any local changes will be lost."
		if ! dk_confirm; then return; fi
	fi

	if [ ! -d "$DKBRANCH_DIR/.git" ]; then
		dk_call "$GIT_EXE" clone https://github.com/aquawicket/DigitalKnob.git "$DKBRANCH_DIR"
	fi
	dk_call cd "$DKBRANCH_DIR" || dk_error "cd $$DKBRANCH_DIR failed!"
	dk_call "$GIT_EXE" pull --all
	dk_call "$GIT_EXE" checkout -- .
	dk_call "$GIT_EXE" checkout "$DKBRANCH"
	if [ "$?" = "0" ]; then
		dk_info "$DKBRANCH branch selected"
	else
	dk_info "Remote has no $DKBRANCH branch. Creating..."
		dk_call "$GIT_EXE" checkout -b "$DKBRANCH" main
		dk_call "$GIT_EXE" push --set-upstream origin "$DKBRANCH"
	fi
	dk_call chmod +x "$DKBRANCH_DIR"/build.sh
}


##################################################################################
# dk_git_commit()
#
#
dk_git_commit () {	
	dk_verbose "dk_git_commit($*)"
	[ -n "$1" ] && dk_error "dk_git_commit($*): Too many parameters"
	
	dk_info "Please enter some details about this commit, Then press ENTER."
	read message
	
	cd "$DKBRANCH_DIR" || dk_error "cd \$DKBRANCH_DIR failed!"
	
	STORE=$($GIT_EXE config credential.helper)
	dk_debug STORE
	if [ -z "$STORE" ]; then
		$GIT_EXE config --global credential.helper store
		dk_echo
		dk_info "git credential.helper is now set to store"
		dk_echo
	fi
	
	USER_EMAIL=$($GIT_EXE config --global user.email)
	if [ -z "$USER_EMAIL" ]; then
		dk_echo
		dk_info "please enter an email address"
		read input
		$GIT_EXE config --global user.email "$input"
		dk_echo
		dk_info "git user.email '$input' saved"
		dk_echo
	fi

	USER_NAME=$($GIT_EXE config --global user.name)
	if [ -z "USER_NAME" ]; then
		dk_echo
		dk_info "please enter a username"
		read input
		$GIT_EXE config --global user.name "$input"
		dk_echo
		dk_info "git user.name '$input' saved"
		dk_echo
	fi
	
	if [ -z "$message" ]; then
		message="git commit"
	fi
	
	dk_echo
	dk_info "git commit \"${message}\""
	if ! dk_confirm; then
		return 0
	fi
	
	dk_call "$GIT_EXE" commit -a -m "${message}"
    dk_call "$GIT_EXE" push
}


##################################################################################
# dk_enter_manually()
#
#
dk_enter_manually () {
	dk_verbose "dk_enter_manually($*)"
	[ -n "$1" ] && dk_error "dk_enter_manually($*): Too many parameters"
	
	dk_info "Please type the name of the library, tool or app to build. Then press enter."
	read input
	
	APP="_${input}_"
	
	#Search digitalknob for the matching entry containing a DKMAKE.cmake file  
	if test -f "$DKIMPORTS_DIR"/"$input"/DKMAKE.cmake; then
		TARGET_PATH=$DKIMPORTS_DIR/$input
	fi
	if test -f "$DKPLUGINS_DIR"/"$input"/DKMAKE.cmake; then
		TARGET_PATH=$DKPLUGINS_DIR/$input
	fi
	if test -f "$DKAPPS_DIR"/"$input"/DKMAKE.cmake; then
		TARGET_PATH=$DKAPPS_DIR/$input
		return $true
	fi
	dk_debug TARGET_PATH
	
	if [ ! -d "$DKAPPS_DIR"/"$APP" ]; then
		mkdir -p "$DKAPPS_DIR"/"$APP";
	fi
	
	# create DKApps/<APP>/DKMAKE.cmake 
	echo "dk_depend($input)" > "$DKAPPS_DIR"/"$APP"/DKMAKE.cmake
	
	# create DKApps/<APP>/main.cpp
	echo "int main(int argc, char** argv) { return 0; }" > "$DKAPPS_DIR"/"$APP"/main.cpp
}


##################################################################################
# dk_create_cache()
#
#
dk_create_cache () {
	dk_verbose "dk_create_cache($*)"
	[ -n "$1" ] && dk_error "dk_create_cache($*): Too many parameters"
	
	dk_echo "creating cache..."
	
	# write variable values line by line
	echo "$APP">"$DKBRANCH_DIR/cache"
	echo "$TARGET_OS">>"$DKBRANCH_DIR/cache"
	echo "$TYPE">>"$DKBRANCH_DIR/cache"
	#echo "$DKENV">>"$DKBRANCH_DIR/cache"
}


##################################################################################
# dk_read_cache()
#
#
dk_read_cache() {
	dk_verbose "dk_read_cache($*)"
	[ -n "$1" ] && dk_error "dk_read_cache($*): Too many parameters"
	
	if ! dk_file_exists "$DKBRANCH_DIR"/cache; then
		return 0
	fi
	_APP_=
	_TARGET_OS_=
	_TYPE_=
	
	dk_echo "reading cache..."
	count=0
	while read p; do
		if [ "$count" = "0" ]; then 
			_APP_=$(echo "$p" | tr -d '\r')
			#dk_debug _APP_
		fi
		if [ "$count" = "1" ]; then
			_TARGET_OS_=$(echo "$p" | tr -d '\r')
			#dk_debug _TARGET_OS_ 
		fi
		if [ "$count" = "2" ]; then
			_TYPE_=$(echo "$p" | tr -d '\r')
			#dk_debug _TYPE_
		fi
		#if [ "$count" = "3" ]; then
		#	_DKENV_=$(echo $p | tr -d '\r')
		#	#dk_debug _DKENV_
		#fi
		count=$((count + 1))
	done < "${DKBRANCH_DIR}"/cache
}


##################################################################################
# dk_remove_carrage_returns(<input>)
#
#
dk_remove_carrage_returns () {
	dk_verbose "dk_remove_carrage_returns($*)"
	[ -n "$1" ] && dk_error "dk_remove_carrage_returns($*): Too many parameters"

	in=$1
	out=$(echo "$in" | tr -d '\r')
	# carrage returns are removed from <out>
}


##################################################################################
# dk_save_args(<args..>)
#
# reference: https://www.etalabs.net/sh_tricks.html
#
# usage:
#   set -- One Two Three Four
#   myarrayA=$(dk_save_args "$@")
#   eval "set -- $myarrayA"
#	echo "$1 $2 $3 $4"
#
dk_save_args () {
	dk_verbose "dk_save_args($*)"

	for i do 
		printf %s\\n "$i" | sed "s/'/'\\\\''/g;1s/^/'/;\$s/\$/' \\\\/"
	done
	echo " "
}


##################################################################################
# dk_get_host_triple(<input>)
#
#	Get host variable such as 'HOST_OS', 'HOST_ARCH', 'HOST_ENV', 'HOST_VENDOR
#	and build the accoring HOST_TRIPLE variable.  I.E. windows_x86_64_msys2
#
dk_get_host_triple () {
	dk_verbose "dk_get_host_triple($*)"
	[ -n "$1" ] && dk_error "dk_get_host_triple($*): Too many parameters"

	# currently, our host triple consists of only 2 variable needed
	# HOST_TRIPLE=${HOST_OS}_${HOST_ARCH}
	
	# https://unix.stackexchange.com/questions/225350/how-to-find-out-triplet-without-gcc
	# https://en.wikipedia.org/wiki/Uname
	
	# g++ -dumpmachine
	# gcc -print-multiarch
	# clang -print-effective-triple
	# clang -print-target-triple
	# clang++ -print-effective-triple
	# clang++ -print-target-triple

	dk_debug "\$(uname) = $(uname)"
	dk_debug "\$(uname -a) = $(uname -a)" # kernel-name, nodename, kernel-release, kernel-version, machine, processor, hardware-platform, operating-system
	dk_debug "\$(uname -m) = $(uname -m)"
	dk_debug "\$(uname -n) = $(uname -n)"
	dk_debug "\$(uname -r) = $(uname -r)"
	dk_debug "\$(uname -s) = $(uname -s)"
	dk_debug "\$(uname -v) = $(uname -v)"
	#[ -e /proc/cpuinfo ] && dk_debug "\$(tr -d '\0' </proc/cpuinfo) = $(tr -d '\0' </proc/cpuinfo)"
	#[ -e /proc/device-tree/model ] && dk_debug "\$(tr -d '\0' </proc/device-tree/model) = $(tr -d '\0' </proc/device-tree/model)"

	# Get the HOST_OS
	# https://llvm.org/doxygen/Triple_8h_source.html
	if dk_string_contains "$(uname -a)" "Android"; then			# android
		HOST_OS="android"
	elif dk_string_contains "$(uname -a)" "Darwin"; then		# mac
		HOST_OS="mac"
	elif dk_string_contains "$(uname -a)" "raspberrypi"; then	# raspberry
		HOST_OS="raspberry"
 	elif dk_string_contains "$(uname -a)" "Linux"; then			# linux
		HOST_OS="linux"
	elif dk_string_contains "$(uname -a)" "Msys"; then			# win
		HOST_OS="win"
	else
		dk_error "Unsupported HOST_OS: $(uname)"
	fi
	[ -z "$HOST_OS" ] && dk_error "Failed to get HOST_OS variable"
	dk_debug HOST_OS

	#dk_to_lower "$(uname)" HOST_OS
	#[ -z "$HOST_OS" ] && dk_error "Failed to get HOST_OS variable"
	#dk_debug HOST_OS


	# Get the HOST_ARCH
	# https://stackoverflow.com/a/45125525
	# aarch64    	- AArch64 (little endian)
    # aarch64_32 	- AArch64 (little endian ILP32)
    # aarch64_be 	- AArch64 (big endian)
	# alpha			-
    # amdgcn     	- AMD GCN GPUs
	# arc			-
    # arm        	- ARM
    # arm64      	- ARM64 (little endian)
    # arm64_32   	- ARM64 (little endian ILP32)
    # armeb      	- ARM (big endian)
	# armv7l	 	- 	
	# armv8b 	 	- (arm64 compat)
	# armv8l 	 	- (arm64 compat)
    # avr        	- Atmel AVR Microcontroller
	# blackfin		-
    # bpf        	- BPF (host endian)
    # bpfeb      	- BPF (big endian)
    # bpfel      	- BPF (little endian)
	# cris			- 
	# frv			-
	# h8300			-
    # hexagon    	- Hexagon
	# ia64			-
	# i386 		 	- (x86)
	# i686 		 	- (x86 compat)	
    # lanai      	- Lanai
	# m32r			-
    # m68k			- Motorola 68000 family
	# metag			-
	# microblaze	-
    # mips       	- MIPS (32-bit big endian)
    # mips64     	- MIPS (64-bit big endian)
    # mips64el   	- MIPS (64-bit little endian)
    # mipsel     	- MIPS (32-bit little endian)
	# mn10300		-
    # msp430     	- MSP430 [experimental]
	# nios2			-
    # nvptx      	- NVIDIA PTX 32-bit
    # nvptx64    	- NVIDIA PTX 64-bit
	# openrisc		- 
	# parisc 		- (native or compat)
	# parisc64 		- (parisc)
	# ppc 			- (powerpc native or compat)
    # ppc32      	- PowerPC 32
    # ppc32le    	- PowerPC 32 LE
    # ppc64      	- PowerPC 64
    # ppc64le    	- PowerPC 64 LE
	# ppcle 		- (powerpc native or compat)
    # r600       	- AMD GPUs HD2XXX-HD6XXX
    # riscv32    	- 32-bit RISC-V
    # riscv64    	- 64-bit RISC-V
	# s390 			- (s390x compat)
	# s390x			-
	# score			-
	# sh			-
	# sh64 (sh)		-
    # sparc      	- Sparc
	# sparc64		-
    # sparcel   	- Sparc LE
    # sparcv9   	- Sparc V9
    # systemz   	- SystemZ
    # thumb     	- Thumb
    # thumbeb   	- Thumb (big endian)
	# tile			-
	# unicore32		-
    # ve        	- VE
    # wasm32    	- WebAssembly 32-bit
    # wasm64    	- WebAssembly 64-bit
    # x86       	- 32-bit X86: Pentium-Pro and above
    # x86-64    	- 64-bit X86: EM64T and AMD64
    # xcore     	- XCore
	# xtensa		-
	HOST_ARCH="$(uname -m)"
	[ -z "$HOST_ARCH" ] && dk_error "Failed to get HOST_ARCH variable"
	dk_debug HOST_ARCH
	
	if [ "$HOST_ARCH" = "arm" ]; then
		HOST_ARCH="arm"
	elif [ "$HOST_ARCH" = "armeb" ]; then
		HOST_ARCH="arm"
	elif [ "$HOST_ARCH" = "armv7l" ]; then
		HOST_ARCH="arm"
	elif [ "$HOST_ARCH" = "aarch64" ]; then
		HOST_ARCH="arm64"
	elif [ "$HOST_ARCH" = "aarch64_32" ]; then
		HOST_ARCH="arm64"
	elif [ "$HOST_ARCH" = "aarch64_be" ]; then
		HOST_ARCH="arm64"
	elif [ "$HOST_ARCH" = "arm64" ]; then
		HOST_ARCH="arm64"
	elif [ "$HOST_ARCH" = "arm64_32" ]; then
		HOST_ARCH="arm64"
	elif [ "$HOST_ARCH" = "armv8b" ]; then
		HOST_ARCH="arm64"
	elif [ "$HOST_ARCH" = "armv8l" ]; then
		HOST_ARCH="arm64"
	elif [ "$HOST_ARCH" = "x86" ]; then
		HOST_ARCH="x86"
	elif [ "$HOST_ARCH" = "i386" ]; then
		HOST_ARCH="x86"
	elif [ "$HOST_ARCH" = "i686" ]; then
		HOST_ARCH="x86"
	elif [ "$HOST_ARCH" = "x86_64" ]; then
		HOST_ARCH="x86_64"
	elif [ "$HOST_ARCH" = "x86-64" ]; then
		HOST_ARCH="x86_64"
	elif [ "$HOST_ARCH" = "ia64" ]; then
		HOST_ARCH="x86_64"
	else
		dk_error "Unsupported HOST_ARCH: ${HOST_ARCH}"
	fi

	HOST_TRIPLE=${HOST_OS}_${HOST_ARCH}
	dk_debug HOST_TRIPLE
}




#echo "@ = $@"
[ "$*" = "" ] || "$@"
main "$@"

#exec $SHELL		# keep terminal open