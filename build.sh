#!/bin/bash

############## DigitalKnob builder script ############

# to run this script requires privledges, use $ chmod 777 build.sh

###### global variables ######
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

###### validate_sudo ######
function validate_sudo() {
	if command -v "sudo" >/dev/null 2>&1; then
		SUDO="sudo"
	fi
	$SUDO echo
}

###### call <command args> ######
function call() {
	if [ -z "$1" ]; then
		error "call <command args> requires at least 1 parameter"
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
	echo "\$WHICH = $WHICH"
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
	echo "\$CMAKE = $CMAKE"
}

###### validate_git ######
function validate_git() {
	if ! command_exists git; then
		install git
	fi
	
	GIT=$(which git)
	echo "\$GIT = $GIT"	
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
	echo "\$BREW = $BREW"	
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
		call $SUDO brew install $1
	elif command_exists apt; then
		call $SUDO apt -y install $1
	elif command_exists apt-get; then
		call $SUDO apt-get -y install $1
	elif command_exists pkg; then
		call $SUDO pkg install $1
	elif command_exists pacman; then
		call $SUDO pacman -S $1 --noconfirm
	elif command_exists tce-load; then
		call tce-load -wi $1
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
	
	#echo "DKBRANCH = $DKBRANCH"
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
	echo MSYS2 = $MSYS2
}

###### validate_emscripten ######
function validate_emscripten() {
	cmake_eval "include('$DKIMPORTS/emsdk/DKMAKE.cmake')" "EMSDK;EMSDK_ENV;EMSDK_TOOLCHAIN_FILE"
	echo EMSDK = $EMSDK
	echo EMSDK_ENV = $EMSDK_ENV
	echo EMSDK_TOOLCHAIN_FILE = $EMSDK_TOOLCHAIN_FILE
}


###### cmake_eval ######
function cmake_eval() {
	if [ -z "$1" ]; then
		echo "ERROR: cmake_eval() parameter 1 is invalid"
		return $false
	fi
	
	commands="$1"
	variables="$2"
	#echo "commands = $commands"
	#set commands=$commands:"=%"  #TODO: remove double quotes
	DKCOMMAND="$commands"
	echo "DKCOMMAND = $DKCOMMAND"
	
	#$CMAKE "-DDKCMAKE=$DKCMAKE" "-DDKCOMMAND=$DKCOMMAND" -P $DKCMAKE/dev/cmake_eval.cmake --log-level=TRACE >cmake_eval.out 2>cmake_eval.err
	
	if [[ -n "$2" ]]; then
		call $CMAKE "-DDKCMAKE=$DKCMAKE" "-DDKCOMMAND=$DKCOMMAND" "-DDKRETURN=$2" -P $DKCMAKE/dev/cmake_eval.cmake
		if file_exists $DKCMAKE/cmake_vars.sh; then
	    	echo "executing cmake_vars.sh"
			source $DKCMAKE/cmake_vars.sh
			#rm $DKCMAKE/cmake_vars.sh
		fi
	else
		call $CMAKE -DDKCMAKE=$DKCMAKE -DDKCOMMAND=$DKCOMMAND -P $DKCMAKE/dev/cmake_eval.cmake
	fi
	
	#echo return code: $?
	return $true
	
	
	out=""
	while IFS= read -r outline 
		do
			out="$out $outline"
			echo "$outline"
		done < cmake_eval.out
	#out contains all of the lines
	#echo "$out"
	
	
	err=""
	while IFS= read -r errline
		do
			err="$err $errline"
			echo -e "${red} $errline ${CLR}"
		done < cmake_eval.err
	#err contains all of the lines
	#echo "$err"	

	#del cmake_eval.out
	#del cmake_eval.out


	#if "%ERROR_CODE%"=="0" (
	#	echo return code: %ERROR_CODE%
	#)
	#if not "%ERROR_CODE%"=="0" (
	#	echo return code: %ERROR_CODE%
	#)
}














############################################################
#############  main #######################################
###########################################################

validate_sudo


echo ""
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
echo " "

#--------------------------------------------------------
# Main
#--------------------------------------------------------
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


if [ $SCRIPTPATH == $DKPATH ];then
	echo "SCRIPTPATH and DKPATH are the same"
else
	warning "$SCRIPTNAME is not running from the DKPATH directory. Any changes will not be saved by git!"
	warning "$SCRIPTNAME path = $SCRIPTPATH"
	warning "DKPATH path = $DKPATH"
fi


# https://unix.stackexchange.com/a/293605
COLUMNS=1

while :
	do
	echo " "
	PS3='Please update and select an app to build: '
	options=(
		"Git Update" 
		"Git Commit" 
		"HelloWorld" 
		"DKCore" 
		"DKJavascript" 
		"DKBuilder" 
		"DKSDL" 
		"DKSDLRml" 
		"DKDomTest" 
		"DKTestAll" 
		"Clear Screen"
		"Go Back"
		"Reload"
		"Exit")
	select opt in "${options[@]}"
	do
		case $opt in
			"Git Update")
				echo "$opt"
				
				if [[ ! -d "$DKPATH/.git" ]]; then
					call git clone https://github.com/aquawicket/DigitalKnob.git $DKPATH
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
				#call reload
				;;
			"Git Commit")
				echo "$opt"
				cd $DKPATH
				git commit -a -m "git commit"
				git push
				;;
			"HelloWorld")
				echo "$opt"
				APP="HelloWorld"
				break
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
			"Go Back")
				echo "$opt"
				;;
			"Reload")
				echo "$opt"
				call reload
				;;
			"Exit")
				echo "$opt"
				exit 0
				;;
			*) echo "invalid option $REPLY";;
		esac 
		REPLY=
	done
	TARGET=${APP}


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
	echo " "
	PS3='Please select an OS to build for: '
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
		options=("win32" "win64" "android32" "android64" "Clear Screen" "Go Back" "Exit")
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
			"Go Back")
				echo "$opt"
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
			"Go Back")
				echo "$opt"
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
	
	CMAKE_ARGS+=( "-DCMAKE_VERBOSE_MAKEFILE=1" )
	#echo CMAKE_ARGS = "${CMAKE_ARGS[@]}"
	
	
	
	###### GENERATOR ######
	if  [[ -n "$MSYSTEM" ]]; then
		GENERATOR="MSYS Makefiles"
	elif [[ "$OS" == "mac"* ]] || [[ "$OS" == "ios"* ]]; then
		GENERATOR="Xcode"
	elif [[ "$OS" == "emscipten"* ]]; then
		GENERATOR="MinGW Makefiles"
	else
		GENERATOR="Unix Makefiles"
	fi

	
	
	###### MAKE_PROGRAM ######
	#cmake_eval "include('$DKIMPORTS/make/DKMAKE.cmake')" "MAKE_PROGRAM"
	#echo "MAKE_PROGRAM = $MAKE_PROGRAM"
	#if [[ -n "$MAKE_PROGRAM" ]]; then
	#	CMAKE_ARGS+=( "-DCMAKE_MAKE_PROGRAM=$MAKE_PROGRAM" )
	#fi
	
	###### C_COMPILER; CXX_COMPILER ######
	### GCC ###
	if [[ $MSYSTEM == "MINGW32" ]] || [[ $MSYSTEM == "MINGW64" ]]; then
		cmake_eval "include('$DKIMPORTS/gcc/DKMAKE.cmake')" "C_COMPILER;CXX_COMPILER"
		echo "C_COMPILER = $C_COMPILER"
		echo "CXX_COMPILER = $CXX_COMPILER"
		CMAKE_ARGS+=( "-DCMAKE_C_COMPILER=$C_COMPILER" )
		CMAKE_ARGS+=( "-DCMAKE_CXX_COMPILER=$CXX_COMPILER" )
	fi
	### CLANG ###
	if [[ $MSYSTEM == "CLANG32" ]] || [[ $MSYSTEM == "CLANG64" ]] || [[ $MSYSTEM == "CLANGARM64" ]] || [[ $MSYSTEM == "UCRT64" ]]; then
		cmake_eval "include('$DKIMPORTS/clang/DKMAKE.cmake')" "C_COMPILER;CXX_COMPILER"
		echo "C_COMPILER = $C_COMPILER"
		echo "CXX_COMPILER = $CXX_COMPILER"
		CMAKE_ARGS+=( "-DCMAKE_C_COMPILER=$C_COMPILER" )
		CMAKE_ARGS+=( "-DCMAKE_CXX_COMPILER=$CXX_COMPILER" )
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
	
	call export SHELL="/bin/bash"
	

	
	
	
	
	
	echo ""
	echo "##################################################################"
	echo "****** Generating $APP - $OS - $TYPE - $LEVEL ******"
	echo "##################################################################"
	echo ""
	
	mkdir -p $DKPATH/DKApps/$APP/$OS
	cd /
	
	if [[ "$TYPE" == "Debug" ]] || [[ "$TYPE" == "All" ]]; then
		mkdir -p $DKPATH/DKApps/$APP/$OS/Debug
	fi
	if [[ "$TYPE" == "Release" ]] || [[ "$TYPE" == "All" ]]; then
		mkdir -p $DKPATH/DKApps/$APP/$OS/Release
	fi
	
	if [[ "$OS" == "android"* ]]; then
	    cmake_eval "include('$DKIMPORTS/android-ndk/DKMAKE.cmake')" "ANDROID_NDK;ANDROID_NDK_BUILD;ANDROID_TOOLCHAIN"
	    echo "ANDROID_NDK = $ANDROID_NDK"
		echo "ANDROID_NDK_BUILD = $ANDROID_NDK_BUILD"
	    echo "ANDROID_TOOLCHAIN = $ANDROID_TOOLCHAIN"
		ANDROID_API=31
        echo "ANDROID_API = $ANDROID_API"
		
		TARGET="main"
	fi
			
	if [[ "$OS" == "android32" ]]; then
		if [[ "$TYPE" == "Debug" ]] || [[ "$TYPE" == "All" ]]; then
	     	call $CMAKE -G "$GENERATOR" -DANDROID_ABI=armeabi-v7a -DANDROID_PLATFORM=$ANDROID_API -DANDROID_NDK=$ANDROID_NDK -DANDROID_TOOLCHAIN=clang -DANDROID_STL=c++_static -DCMAKE_CXX_FLAGS="-std=c++1z -frtti -fexceptions" -DCMAKE_ANDROID_STL_TYPE=c++_static "${CMAKE_ARGS[@]}" -S$DKCMAKE -B$DKPATH/DKApps/$APP/$OS/Debug
	    fi
	    if [[ "$TYPE" == "Release" ]] || [[ "$TYPE" == "All" ]]; then
	     	call $CMAKE -G "$GENERATOR" -DANDROID_ABI=armeabi-v7a -DANDROID_PLATFORM=$ANDROID_API -DANDROID_NDK=$ANDROID_NDK -DANDROID_TOOLCHAIN=clang -DANDROID_STL=c++_static -DCMAKE_CXX_FLAGS="-std=c++1z -frtti -fexceptions" -DCMAKE_ANDROID_STL_TYPE=c++_static "${CMAKE_ARGS[@]}" -S$DKCMAKE -B$DKPATH/DKApps/$APP/$OS/Release
	    fi
	fi

	if [[ "$OS" == "android64" ]]; then
		if [[ "$TYPE" == "Debug" ]] || [[ "$TYPE" == "All" ]]; then
		    call $CMAKE -G "$GENERATOR" -DANDROID_ABI=arm64-v8a -DANDROID_PLATFORM=$ANDROID_API -DANDROID_NDK=$ANDROID_NDK -DCMAKE_TOOLCHAIN_FILE=$ANDROID_TOOLCHAIN -DANDROID_TOOLCHAIN=clang -DANDROID_STL=c++_static -DCMAKE_CXX_FLAGS="-std=c++1z -frtti -fexceptions" -DCMAKE_ANDROID_STL_TYPE=c++_static "${CMAKE_ARGS[@]}" -S$DKCMAKE -B$DKPATH/DKApps/$APP/$OS/Debug
	    fi
    	if [[ "$TYPE" == "Release" ]] || [[ "$TYPE" == "All" ]]; then
		    call $CMAKE -G "$GENERATOR" -DANDROID_ABI=arm64-v8a -DANDROID_PLATFORM=$ANDROID_API -DANDROID_NDK=$ANDROID_NDK -DCMAKE_TOOLCHAIN_FILE=$ANDROID_TOOLCHAIN -DANDROID_TOOLCHAIN=clang -DANDROID_STL=c++_static -DCMAKE_CXX_FLAGS="-std=c++1z -frtti -fexceptions" -DCMAKE_ANDROID_STL_TYPE=c++_static "${CMAKE_ARGS[@]}" -S$DKCMAKE -B$DKPATH/DKApps/$APP/$OS/Release
	    fi
	fi
	
	
	if [[ "$OS" == "emscipten" ]]; then
	    call validate_emscripten
		if [[ "$TYPE" == "Debug" ]] || [[ "$TYPE" == "All" ]]; then
			call "$EMSDK_ENV" & "$CMAKE" -G "$GENERATOR" -DCMAKE_TOOLCHAIN_FILE="$EMSDK_TOOLCHAIN_FILE" "${CMAKE_ARGS[@]}" -S$DKCMAKE -B$DKPATH/DKApps/$APP/$OS/Debug
		fi
		if [[ "$TYPE" == "Release" ]] || [[ "$TYPE" == "All" ]]; then
			call "$EMSDK_ENV" & "$CMAKE" -G "$GENERATOR" -DCMAKE_TOOLCHAIN_FILE="$EMSDK_TOOLCHAIN_FILE" "${CMAKE_ARGS[@]}" -S$DKCMAKE -B$DKPATH/DKApps/$APP/$OS/Release
		fi
		TARGET=${APP}_APP
	fi
	
	
	if [[ "$OS" == "ios32" ]]; then
		call $CMAKE -G "$GENERATOR" -DCMAKE_TOOLCHAIN_FILE=$DKCMAKE/ios.toolchain.cmake -DPLATFORM=OS -DSDK_VERSION=15.0 -DDEPLOYMENT_TARGET=13.0 "${CMAKE_ARGS[@]}" -S$DKCMAKE -B$DKPATH/DKApps/$APP/$OS
	fi
	if [[ "$OS" == "ios64" ]]; then
		call $CMAKE -G "$GENERATOR" -DCMAKE_TOOLCHAIN_FILE=$DKCMAKE/ios.toolchain.cmake -DPLATFORM=OS64 -DSDK_VERSION=15.0 -DDEPLOYMENT_TARGET=13.0 "${CMAKE_ARGS[@]}" -S$DKCMAKE -B$DKPATH/DKApps/$APP/$OS
	fi
	if [[ "$OS" == "iossim32" ]]; then
		call $CMAKE -G "$GENERATOR" -DCMAKE_TOOLCHAIN_FILE=$DKCMAKE/ios.toolchain.cmake -DPLATFORM=SIMULATOR -DSDK_VERSION=15.0 -DDEPLOYMENT_TARGET=13.0 "${CMAKE_ARGS[@]}" -S$DKCMAKE -B$DKPATH/DKApps/$APP/$OS
	fi
	if [[ "$OS" == "iossim64" ]]; then
		call $CMAKE -G "$GENERATOR" -DCMAKE_TOOLCHAIN_FILE=$DKCMAKE/ios.toolchain.cmake -DPLATFORM=SIMULATOR64 -DSDK_VERSION=15.0 -DDEPLOYMENT_TARGET=13.0 "${CMAKE_ARGS[@]}" -S$DKCMAKE -B$DKPATH/DKApps/$APP/$OS
	fi
	
	if [[ "$OS" == "linux32" ]]; then
		if [[ "$TYPE" == "Debug" ]] || [[ "$TYPE" == "All" ]]; then
			call $CMAKE -G "$GENERATOR" "${CMAKE_ARGS[@]}" -S$DKCMAKE -B$DKPATH/DKApps/$APP/$OS/Debug
		fi
		if [[ "$TYPE" == "Release" ]] || [[ "$TYPE" == "All" ]]; then
			call $CMAKE -G "$GENERATOR" "${CMAKE_ARGS[@]}" -S$DKCMAKE -B$DKPATH/DKApps/$APP/$OS/Release
		fi
		TARGET=${APP}_APP
	fi
	
	if [[ "$OS" == "linux64" ]]; then
		if [[ "$TYPE" == "Debug" ]] || [[ "$TYPE" == "All" ]]; then
			call $CMAKE -G "$GENERATOR" "${CMAKE_ARGS[@]}" -S$DKCMAKE -B$DKPATH/DKApps/$APP/$OS/Debug
		fi
		if [[ "$TYPE" == "Release" ]] || [[ "$TYPE" == "All" ]]; then
			call $CMAKE -G "$GENERATOR" "${CMAKE_ARGS[@]}" -S$DKCMAKE -B$DKPATH/DKApps/$APP/$OS/Release
		fi
		TARGET=${APP}_APP
	fi
	
	if [[ "$OS" == "mac32" ]]; then
		call $CMAKE -G "$GENERATOR" -DMAC_32=ON -DCMAKE_OSX_ARCHITECTURES=i686 "${CMAKE_ARGS[@]}" -S$DKCMAKE -B$DKPATH/DKApps/$APP/$OS
	fi
	
	if [[ "$OS" == "mac64" ]]; then
		call $CMAKE -G "$GENERATOR" -DMAC_64=ON -DCMAKE_OSX_ARCHITECTURES=x86_64 "${CMAKE_ARGS[@]}" -S$DKCMAKE -B$DKPATH/DKApps/$APP/$OS
		TARGET=${APP}_APP
	fi
	
	if [[ "$OS" == "raspberry32" ]]; then
		if [[ "$TYPE" == "Debug" ]] || [[ "$TYPE" == "All" ]]; then
			call $CMAKE -G "$GENERATOR" "${CMAKE_ARGS[@]}" -S$DKCMAKE -B$DKPATH/DKApps/$APP/$OS/Debug
		fi
		if [[ "$TYPE" == "Release" ]] || [[ "$TYPE" == "All" ]]; then
			call $CMAKE -G "$GENERATOR" "${CMAKE_ARGS[@]}" -S$DKCMAKE -B$DKPATH/DKApps/$APP/$OS/Release
		fi
		TARGET=${APP}_APP
	fi
	
	if [[ "$OS" == "raspberry64" ]]; then
		if [[ "$TYPE" == "Debug" ]] || [[ "$TYPE" == "All" ]]; then
			call $CMAKE -G "$GENERATOR" "${CMAKE_ARGS[@]}" -S$DKCMAKE -B$DKPATH/DKApps/$APP/$OS/Debug
		fi
		if [[ "$TYPE" == "Release" ]] || [[ "$TYPE" == "All" ]]; then
			call $CMAKE -G "$GENERATOR" "${CMAKE_ARGS[@]}" -S$DKCMAKE -B$DKPATH/DKApps/$APP/$OS/Release
		fi
		TARGET=${APP}_APP
	fi
	
	if [[ "$OS" == "win32" ]]; then
		validate_msys2
		call export PATH=${MSYS2}/mingw32/bin:$PATH
		call export PATH=${MSYS2}/usr/bin:$PATH
		if [[ "$TYPE" == "Debug" ]] || [[ "$TYPE" == "All" ]]; then
			call $CMAKE -G "$GENERATOR" "${CMAKE_ARGS[@]}" -S$DKCMAKE -B$DKPATH/DKApps/$APP/$OS/Debug
		fi
		if [[ "$TYPE" == "Release" ]] || [[ "$TYPE" == "All" ]]; then
			call $CMAKE -G "$GENERATOR" "${CMAKE_ARGS[@]}" -S$DKCMAKE -B$DKPATH/DKApps/$APP/$OS/Release
		fi
		TARGET=${APP}_APP
	fi
	
	if [[ "$OS" == "win64" ]]; then
		validate_msys2
		call export PATH=${MSYS2}/mingw64/bin:$PATH
		call export PATH=${MSYS2}/usr/bin:$PATH
		if [[ "$TYPE" == "Debug" ]] || [[ "$TYPE" == "All" ]]; then
			call $CMAKE -G "$GENERATOR" "${CMAKE_ARGS[@]}" -S$DKCMAKE -B$DKPATH/DKApps/$APP/$OS/Debug
		fi
		if [[ "$TYPE" == "Release" ]] || [[ "$TYPE" == "All" ]]; then
			call $CMAKE -G "$GENERATOR" "${CMAKE_ARGS[@]}" -S$DKCMAKE -B$DKPATH/DKApps/$APP/$OS/Release
		fi
		TARGET=${APP}_APP
	fi
	
	
	
	echo ""
	echo "##################################################################"
	echo "****** Building $APP - $OS - $TYPE - $LEVEL ******"
	echo "##################################################################"
	echo ""
	
	if [[ "$TYPE" == "Debug" ]] || [[ "$TYPE" == "All" ]]; then
		if file_exists $DKPATH/DKApps/$APP/$OS/Debug/CMakeCache.txt; then
			call $CMAKE --build $DKPATH/DKApps/$APP/$OS/Debug --target ${TARGET} --config Debug --verbose
		else
			call $CMAKE --build $DKPATH/DKApps/$APP/$OS --target ${TARGET} --config Debug --verbose
		fi
	fi
	if [[ "$TYPE" == "Release" ]] || [[ "$TYPE" == "All" ]]; then
		if file_exists $DKPATH/DKApps/$APP/$OS/Release/CMakeCache.txt; then
			call $CMAKE --build $DKPATH/DKApps/$APP/$OS/Release --target ${TARGET} --config Release --verbose
		else
			call $CMAKE --build $DKPATH/DKApps/$APP/$OS --target ${TARGET} --config Release --verbose
		fi
	fi
	
	echo "******* Done building $APP - $OS - $TYPE *******"
	
    unset APP
	unset OS
	unset TYPE
done


exec $SHELL		# keep terminal open