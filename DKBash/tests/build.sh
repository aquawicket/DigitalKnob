#!/bin/bash
############# DigitalKnob builder script ############

# shellcheck disable=SC2034
# shellcheck disable=SC3028
# shellcheck disable=SC2119
# shellcheck disable=SC2120



###### Reload Main Script with bash ######
if [ ${RELOAD_WITH_BASH-1} = 1 ]; then
	export RELOAD_WITH_BASH=0
	if [ -n "$(command -v bash)" ]; then
		echo "reloading with /bin/bash . . ."
		exec /bin/bash "${0}"
	else
		echo ""
		echo "ERROR: This script requires bash. Please install it and try again.";
		read -rp 'Press enter to exit...' key;
		exit 1
	fi
fi

###### include guard ######
[ -n "$DK_SH" ] && return || readonly DK_SH=1


###### get DKSCRIPT_ variables  ######
DKSCRIPT_PATH=$(pwd)/$(basename ${0})
[ ! -e $DKSCRIPT_PATH ] && dk_error "DKSCRIPT_PATH does not exist"
echo "DKSCRIPT_PATH = $DKSCRIPT_PATH"
[ -n "$(command -v "cygpath")" ] && DKSCRIPT_PATH=$(cygpath -u "$DKSCRIPT_PATH")
DKSCRIPT_DIR=$(dirname $DKSCRIPT_PATH)
echo "DKSCRIPT_DIR = $DKSCRIPT_DIR"
DKSCRIPT_FILE=$(basename $DKSCRIPT_PATH)
echo "DKSCRIPT_FILE = $DKSCRIPT_FILE"
DKSCRIPT_NAME="${DKSCRIPT_FILE%.*}";
echo "DKSCRIPT_NAME = ${DKSCRIPT_NAME}";


###### Set and check posix mode ######
$(set -o posix) && set -o posix && case :${SHELLOPTS}: in
  *:posix:*) echo "POSIX mode enabled" ;;
  *)         echo "POSIX mode not enabled" ;;
esac


###### Set error trace options ######
$(set -o pipefail) && set -o pipefail  	# trace ERR through pipes
$(set -o errtrace) && set -o errtrace 	# trace ERR through 'time command' and other functions
#$(set -o nounset) && set -o nounset  	# set -u : exit the script if you try to use an uninitialised variable
#$(set -o errexit) && set -o errexit  	# set -e : exit the script if any statement returns a non-true


###### set true and false variables ######
readonly true=0
readonly false=1


###### get DKBASH_DIR ######
export BASH_SOURCE_DIR=$( cd -- "$(dirname "$BASH_SOURCE")" >/dev/null 2>&1 ; pwd -P )
export DKBASH_DIR=$( cd -- "$(dirname "$BASH_SOURCE_DIR")" >/dev/null 2>&1 ; pwd -P )


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


cmake_Linux_Arm64_Import=https://github.com/Kitware/CMake/releases/dk_download/v3.29.5/cmake-3.29.5-linux-aarch64.tar.gz
cmake_Linux_X86_64_Import=https://github.com/Kitware/CMake/releases/dk_download/v3.29.5/cmake-3.29.5-linux-x86_64.tar.gz
#cmake_Mac10_X86_64_Import=https://github.com/Kitware/CMake/releases/dk_download/v3.29.5/cmake-3.29.5-macos10.10-universal.tar.gz
cmake_Mac_X86_64_Import=https://github.com/Kitware/CMake/releases/dk_download/v3.29.5/cmake-3.29.5-macos-universal.tar.gz
cmake_Windows_Arm64_Import=https://github.com/Kitware/CMake/releases/dk_download/v3.29.5/cmake-3.29.5-windows-arm64.zip
cmake_Windows_X86_64_Import=https://github.com/Kitware/CMake/releases/dk_download/v3.29.5/cmake-3.29.5-windows-x86_64.zip
cmake_Windows_X86_Import=https://github.com/Kitware/CMake/releases/dk_download/v3.29.5/cmake-3.29.5-windows-i386.zip

Git_Windows_X86_Import=https://github.com/git-for-windows/git/releases/dk_download/v2.44.0.windows.1/PortableGit-2.44.0-32-bit.7z.exe
Git_Windows_X86_64_Import=https://github.com/git-for-windows/git/releases/dk_download/v2.44.0.windows.1/PortableGit-2.44.0-64-bit.7z.exe


##################################################################################
# dk_buildMain()
#
#
dk_buildMain() {
	dk_debugFunc 0

	# log to stdout and file
	# exec > >(tee DKBuilder.log)
	
	dk_validateSudo
	
	if dk_defined WSLENV; then 
		dk_info "WSLENV is on"
		dk_info "calling sudo chown -R $LOGNAME $HOME to allow windows write access to \\\wsl.localhost\DISTRO\home\\$LOGNAME"
		#${sudo_exe} chown -R "$LOGNAME" "$HOME"
	fi

	dk_printVar SHLVL			# https://stackoverflow.com/a/4511483/688352
	dk_printVar MSYSTEM
	dk_printVar DKSCRIPT_PATH
	dk_printVar DKSCRIPT_DIR
	dk_printVar DKSCRIPT_FILE
	dk_printVar DKSCRIPT_NAME
	dk_printVar DKSCRIPT_EXT
	
	### Get the Host_Tuple and other Host variables
	dk_Host_Tuple
	
	dk_DIGITALKNOB_DIR

	dk_installGit
	dk_DKBRANCH_DIR

	dk_printVar DKBRANCH_DIR
	dk_printVar DKCPP_APPS_DIR
	dk_printVar DKCMAKE_DIR
	dk_printVar DK3RDPARTY_DIR
	dk_printVar DKIMPORTS_DIR
	dk_printVar DKCPP_PLUGINS_DIR

	if [ "$DKSCRIPT_DIR" != "${DKBRANCH_DIR}" ]; then
		dk_warning "$DKSCRIPT_FILE is not running from the DKBRANCH_DIR directory. Any changes will not be saved by git!"
		dk_warning "$DKSCRIPT_FILE path = $DKSCRIPT_DIR"
		dk_warning "DKBRANCH_DIR path = ${DKBRANCH_DIR}"
	fi
	
	while :
	do
		if [ -z "${UPDATE-}" ];     then dk_pickUpdate;  continue; fi
		if [ -z "${Target_App-}" ];        then dk_Target_App;     continue; fi
		if [ -z "${Target_Tuple-}" ];  then dk_pickOs;      continue; fi
		if [ -z "${Target_Type-}" ];       then dk_Target_Type;    continue; fi
		
		dk_createCache
		dk_generate	
		dk_buildApp
		
		unset UPDATE
		unset Target_App
		unset Target_Tuple
		unset Target_Type
	done
}


##################################################################################
# dk_pickUpdate()
#
#
dk_pickUpdate() {
	dk_debugFunc 0


	dk_readCache
	
	dk_echo
	dk_gitCheckRemote
	dk_echo
	
	#dk_printVar Target_App_Cache
	#dk_printVar Target_Tuple_Cache 
	#dk_printVar Target_Type_Cache
	
	if [ $behind -lt 1 ]; then
		if [ -n "${Target_App_Cache-}" ] && [ -n "${Target_Tuple_Cache-}" ] && [ -n "${Target_Type_Cache-}" ]; then
			dk_echo " 0) Repeat DKBuilder.cache [$Target_App_Cache - $Target_Tuple_Cache - $Target_Type_Cache]"
		fi
		dk_echo " 1) Git Update"   
		dk_echo " 2) Git Commit"
		dk_echo " 3) Push assets"
		dk_echo " 4) Pull assets"
		dk_echo " 5) Reset All"
		dk_echo " 6) Remove All"
		dk_echo " 7) Clear Screen"
		dk_echo " 8) Reload"
		dk_echo " 9) Exit"
		dk_echo
		dk_echo " Press Enter To Skip"
	else
		dk_warning "Your local repository is behind, please git update"
		dk_echo
		dk_echo "${red}" 
		if [ -n "$Target_App_Cache" ] && [ -n "$Target_Tuple_Cache" ] && [ -n "$Target_Type_Cache" ]; then
			dk_echo " 0) Repeat DKBuilder.cache [$Target_App_Cache - $Target_Tuple_Cache - $Target_Type_Cache]"
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
		dk_echo " 8) Reload"
		dk_echo " 9) Exit"
		dk_echo
		dk_echo "Press Enter To Skip"
		dk_echo "${clr}"
	fi
	
	read input
	if [ "${input}" = "0" ]; then
		dk_echo "repeating last selection"
		Target_App=$Target_App_Cache
		Target_Tuple=$Target_Tuple_Cache
		Target_Type=$Target_Type_Cache
		UPDATE=1
	elif [ "${input}" = "1" ]; then
		dk_gitUpdate
	elif [ "${input}" = "2" ]; then
		dk_gitCommit
	elif [ "${input}" = "3" ]; then
		dk_pushAssets
	elif [ "${input}" = "4" ]; then
		dk_pullAssets
	elif [ "${input}" = "5" ]; then
		dk_resetAll
	elif [ "${input}" = "6" ]; then
		dk_removeAll
	elif [ "${input}" = "7" ]; then
		clear
	elif [ "${input}" = "8" ]; then
		dk_reload
	elif [ "${input}" = "9" ]; then
		exit 0	
	elif [ "${input}" = "" ]; then
		UPDATE=1
	else
		dk_warning "invalid selection"
	fi
}


##################################################################################
# dk_Target_App()
#
#
dk_Target_App() {
	dk_debugFunc 0


	dk_echo
	dk_echo "${Target_App-}  ${Target_Tuple-} ${Target_Type-}"
	
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
	if [ "${input}" = "1" ]; then
		Target_App="HelloWorld"
	elif [ "${input}" = "2" ]; then
		Target_App="DKCore"
	elif [ "${input}" = "3" ]; then
		Target_App="DKJavascript"
	elif [ "${input}" = "4" ]; then
		Target_App="DKSDL"
	elif [ "${input}" = "5" ]; then
		Target_App="DKSDLRml"
	elif [ "${input}" = "6" ]; then
		Target_App="DKDomTest"
	elif [ "${input}" = "7" ]; then
		Target_App="DKTestAll"
	elif [ "${input}" = "8" ]; then
		dk_enterManually
	elif [ "${input}" = "9" ]; then
		clear
	elif [ "${input}" = "10" ]; then
		UPDATE=
	elif [ "${input}" = "11" ]; then
		dk_call dk_reload
	elif [ "${input}" = "12" ]; then
		exit 0
	else
		dk_warning "invalid selection"
	fi
}

##################################################################################
# dk_pickOs()
#
#
dk_pickOs() {
	dk_debugFunc 0


	dk_echo
	dk_echo "${Target_App} ${Target_Tuple-} ${Target_Type-}"
	dk_echo	""
    dk_echo " 1) ${Host_Tuple-}"
	dk_echo
	dk_echo " 2) Android arm32"
	dk_echo " 3) Android arm64"
	dk_echo " 4) Android X86"
	dk_echo " 5) Android X86_64"
	dk_echo " 6) Emscripten"
	dk_echo " 7) Ios arm32"
	dk_echo " 8) Ios arm64"
	dk_echo " 9) Ios X86"
	dk_echo "10) Ios X86_64"
	dk_echo "11) Iossim arm32"
	dk_echo "12) Iossim arm64"
	dk_echo "13) Iossim X86"
	dk_echo "14) Iossim X86_64"
	dk_echo "15) Linux arm32"
	dk_echo "16) Linux arm64"
	dk_echo "17) Linux X86"
	dk_echo "18) Linux X86_64"
	dk_echo "19) Mac arm32"
	dk_echo "20) Mac arm64"
	dk_echo "21) Mac X86"
	dk_echo "22) Mac X86_64"
	dk_echo "23) Raspberry arm32"
	dk_echo "24) Raspberry arm64"
	dk_echo "25) Raspberry X86"
	dk_echo "26) Raspberry X86_64"
	dk_echo "27) Windows arm32"
	dk_echo "28) Windows arm64 (clang)"
	dk_echo "29) Windows X86 (gcc)"
	dk_echo "30) Windows X86 (clang)"
	dk_echo "31) Windows X86 (msvc)"
	dk_echo "32) Windows X86_64 (gcc)"
    dk_echo "33) Windows X86_64 (clang)"
    dk_echo "34) Windows X86_64 (ucrt)"
    dk_echo "35) Windows X86_64 (msvc)"
	dk_echo "36) Clear Screen"
	dk_echo "37) Go Back"
	dk_echo "38) Exit"
	dk_echo
	
	read input
	if [ "${input}" = "1" ]; then
		Target_Tuple="${Host_Tuple-}"
	elif [ "${input}" = "2" ]; then
		Target_Tuple="Android_Arm32"
	elif [ "${input}" = "3" ]; then
		Target_Tuple="android_Arm64"
	elif [ "${input}" = "4" ]; then
		Target_Tuple="android_X86"
	elif [ "${input}" = "5" ]; then
		Target_Tuple="android_X86_64"
	elif [ "${input}" = "6" ]; then
		Target_Tuple="Emscripten"
	elif [ "${input}" = "7" ]; then
		Target_Tuple="Ios_Arm32"
	elif [ "${input}" = "8" ]; then
		Target_Tuple="Ios_Arm64"
	elif [ "${input}" = "9" ]; then
		Target_Tuple="Ios_X86"
	elif [ "${input}" = "10" ]; then
		Target_Tuple="Ios_X86_64"
	elif [ "${input}" = "11" ]; then
		Target_Tuple="Iossim_Arm32"
	elif [ "${input}" = "12" ]; then
		Target_Tuple="Iossim_Arm64"
	elif [ "${input}" = "13" ]; then
		Target_Tuple="Iossim_X86"
	elif [ "${input}" = "14" ]; then
		Target_Tuple="Iossim_X86_64"
	elif [ "${input}" = "15" ]; then
		Target_Tuple="Linux_Arm32"
	elif [ "${input}" = "16" ]; then
		Target_Tuple="Linux_Arm64"
	elif [ "${input}" = "17" ]; then
		Target_Tuple="Linux_X86"
	elif [ "${input}" = "18" ]; then
		Target_Tuple="Linux_X86_64"
	elif [ "${input}" = "19" ]; then
		Target_Tuple="Mac_Arm32"
	elif [ "${input}" = "20" ]; then
		Target_Tuple="Mac_Arm64"
	elif [ "${input}" = "21" ]; then
		Target_Tuple="Mac_X86"
	elif [ "${input}" = "22" ]; then
		Target_Tuple="Mac_X86_64"
	elif [ "${input}" = "23" ]; then
		Target_Tuple="Raspberry_Arm32"
	elif [ "${input}" = "24" ]; then
		Target_Tuple="Raspberry_Arm64"
	elif [ "${input}" = "25" ]; then
		Target_Tuple="Raspberry_X86"
	elif [ "${input}" = "26" ]; then
		Target_Tuple="Raspberry_X86_64"
	elif [ "${input}" = "27" ]; then
		Target_Tuple="Windows_Arm32"
	elif [ "${input}" = "28" ]; then
		Target_Tuple="Windows_Arm64_Clang"
	elif [ "${input}" = "29" ]; then
		Target_Tuple="Windows_X86_Gcc"
	elif [ "${input}" = "30" ]; then
		Target_Tuple="Windows_X86_Clang"
	elif [ "${input}" = "31" ]; then
		Target_Tuple="Windows_X86_Msvc"
	elif [ "${input}" = "32" ]; then
		Target_Tuple="Windows_X86_64_Gcc"
	elif [ "${input}" = "33" ]; then
		Target_Tuple="Windows_X86_64_Clang"
	elif [ "${input}" = "34" ]; then
		Target_Tuple="Windows_X86_64_Ucrt"
	elif [ "${input}" = "35" ]; then
		Target_Tuple="Windows_X86_64_Msvc"
	elif [ "${input}" = "36" ]; then
		clear
	elif [ "${input}" = "37" ]; then
		Target_App=
	elif [ "${input}" = "38" ]; then
		exit 0
	else
		dk_warning "invalid selection"
	fi
}


##################################################################################
# dk_Target_Type()
#
#
dk_Target_Type() {
	dk_debugFunc 0


	dk_echo
	dk_echo "${Target_App} ${Target_Tuple} ${Target_Type-}"
	dk_echo	""
    dk_echo " 1) Debug"
	dk_echo " 2) Release"
	dk_echo " 3) All"
	dk_echo " 4) Clear Screen"
	dk_echo " 5) Go Back"
	dk_echo " 6) Exit"
	dk_echo
	
	read input
	if [ "${input}" = "1" ]; then
		Target_Type="Debug"
	elif [ "${input}" = "2" ]; then
		Target_Type="Release"
	elif [ "${input}" = "3" ]; then
		Target_Type="All"
	elif [ "${input}" = "4" ]; then
		clear
	elif [ "${input}" = "5" ]; then
		Target_Tuple=
	elif [ "${input}" = "6" ]; then
		exit 0
	else
		dk_warning "invalid selection"
	fi
}


##################################################################################
# dk_append_cmake_args(string)
#
#
#dk_append_cmake_args() {
#    dk_debugFunc
#
#    if [ "${*}" = "" ]; then dk_error "dk_append_cmake_args is empty!" & return 1
#    set -- "%*"
#    dk_echo appended ${*}
#}


#####################################################################
# prepend_cmake_args(string)
#
#
#prepend_cmake_args() {
#    dk_debugFunc
#	
#    if [ "${*}" = "" ]; then dk_error "dk_append_cmake_args is empty!" & return 1
#    set -- "%*"
#    dk_echo prepended ${*}
#}


##################################################################################
# dk_generate()
#
#
dk_generate() {
	dk_verbose "dk_generate(${*})"
	[ ${#} -gt 0 ] && dk_error "too many arguments"
	
	dk_echo
	dk_echo "##################################################################"
	dk_echo "     Generating ${Target_App} - ${Target_Tuple} - ${Target_Type} - ${Target_Level-}"
	dk_echo "##################################################################"
	dk_echo

	dk_clearCmakeCache
	dk_deleteTempFiles

	Target_App_Dir="${DKCPP_APPS_DIR}"/"${Target_App}"
	dk_printVar Target_App_Dir
	mkdir -p "${Target_App_Dir}"/"${Target_Tuple}"
	cd "${Target_App_Dir}"/"${Target_Tuple}"
	CMAKE_SOURCE_DIR="${DKCMAKE_DIR}"
	dk_printVar CMAKE_SOURCE_DIR
	if ! dk_pathExists "${CMAKE_SOURCE_DIR}"; then
		dk_error "CMAKE_SOURCE_DIR does not exist"
	fi
	dk_printVar CMAKE_SOURCE_DIR
	
	###### BUILD CMAKE_ARGS ARRAY ######
	Target_Level="RebuildAll"
	Target_Link="Static"
	
	#declare -a CMAKE_ARGS
	set --											#clear the positional parameters
	if [ "${Target_Type}" = "Debug" ]; then
		#set -- "-DDEBUG=ON" )
		set -- "${@}" "-DDEBUG=ON"
		set -- "${@}" "-DRELEASE=OFF"
	fi
	if [ "${Target_Type}" = "Release" ]; then
		set -- "${@}" "-DDEBUG=OFF"
		set -- "${@}" "-DRELEASE=ON"
	fi
	if [ "${Target_Type}" = "All" ]; then
		set -- "${@}" "-DDEBUG=ON"
		set -- "${@}" "-DRELEASE=ON"
	fi
	if [ "${Target_Level}" = "Build" ]; then
		set -- "${@}" "-DBUILD=ON"
	fi
	if [ "${Target_Level}" = "Rebuild" ]; then
		set -- "${@}" "-DREBUILD=ON"
	fi
	if [ "${Target_Level}" = "RebuildAll" ]; then
		set -- "${@}" "-DREBUILDALL=ON"
	fi
	if [ "$Target_Link" = "Static" ]; then
		set -- "${@}" "-DSTATIC=ON"
	fi
	if [ "$Target_Link" = "Shared" ]; then
		set -- "${@}" "-DSHARED=ON"
	fi
	
	CMAKE_BINARY_DIR=${Target_App_Dir}/${Target_Tuple}/${Target_Type}
	dk_printVar CMAKE_BINARY_DIR
	
	if ! dk_defined WSLENV; then 
		set -- "${@}" "-S=${CMAKE_SOURCE_DIR}"
	fi
	set -- "${@}" "-B=${CMAKE_BINARY_DIR}"
	
	############ CMake Options ############
    #set -- "${@}" "-DCMAKE_VERBOSE_MAKEFILE=1"
	#set -- "${@}" "-DCMAKE_COLOR_DIAGNOSTICS=ON"
	#set -- "${@}" "-Wdev"
	#set -- "${@}" "-Werror=dev"
	#set -- "${@}" "-Wdeprecated"
	#set -- "${@}" "-Werror=deprecated"
	#set -- "${@}" "--graphviz=graphviz.txt"
	#set -- "${@}" "--system-information system_information.txt"
	#set -- "${@}" "--debug-trycompile"
	#set -- "${@}" "--debug-output"
	#set -- "${@}" "--trace"
	#set -- "${@}" "--trace-expand"
	#set -- "${@}" "--warn-uninitialized"
	#set -- "${@}" "--warn-unused-vars"
	#set -- "${@}" "--check-system-vars"
	
	if [ "${Target_Tuple}" = "Android_Arm32" ]; then
		set -- "-G Unix Makefiles" "${@}"
	fi

	if [ "${Target_Tuple}" = "Android_Arm64" ]; then
		set -- "-G Unix Makefiles" "${@}"
	fi
	
	if [ "${Target_Tuple}" = "Emscripten" ]; then
		set -- "-G Unix Makefiles" "${@}"
	fi
	
	if [ "${Target_Tuple}" = "Ios_Arm32" ]; then
		set -- "-G Xcode" "${@}"
	fi
	
	if [ "${Target_Tuple}" = "Ios_Arm64" ]; then
		set -- "-G Xcode" "${@}"
	fi
	
	if [ "${Target_Tuple}" = "Iossim_X86" ]; then
		set -- "-G Xcode" "${@}"
	fi
	
	if [ "${Target_Tuple}" = "Iossim_X86_64" ]; then
		set -- "-G Xcode" "${@}"
	fi
	
	if [ "${Target_Tuple}" = "Linux_X86" ]; then
		set -- "-G Unix Makefiles" "${@}"
	fi
	
	if [ "${Target_Tuple}" = "Linux_X86_64" ]; then
		set -- "-G Unix Makefiles" "${@}"
	fi
	
	if [ "${Target_Tuple}" = "Mac_X86" ]; then
		set -- "-G Xcode" "${@}"
	fi
	
	if [ "${Target_Tuple}" = "Mac_X86_64" ]; then
		set -- "-G Xcode" "${@}"
	fi
	
	if [ "${Target_Tuple}" = "Raspberry_Arm32" ]; then
		set -- "-G Unix Makefiles" "${@}"
	fi
	
	if [ "${Target_Tuple}" = "Raspberry_Arm64" ]; then
		set -- "-G Unix Makefiles" "${@}"
	fi
	
	if [ "${Target_Tuple}" = "Windows_Arm64_Clang" ]; then
		export PATH=${DK3RDPARTY_DIR}/msys2-x86_64-20231026/clangarm64/bin:$PATH
		set -- "-G MSYS Makefiles" "${@}"
	fi
	
	if [ "${Target_Tuple}" = "Windows_X86_Clang" ]; then
		export PATH=${DK3RDPARTY_DIR}/msys2-x86_64-20231026/clang32/bin:$PATH
		set -- "-G MSYS Makefiles" "${@}"
	fi
	
	if [ "${Target_Tuple}" = "Windows_X86_Gcc" ]; then
		export PATH=${DK3RDPARTY_DIR}/msys2-x86_64-20231026/mingw32/bin:$PATH
		set -- "-G MSYS Makefiles" "${@}"
	fi
	
	#set -- "-DCMAKE_EXE_LINKER_FLAGS=-static -mconsole"
	if [ "${Target_Tuple}" = "Windows_X86_64_Clang" ]; then
		export PATH=${DK3RDPARTY_DIR}/msys2-x86_64-20231026/clang64/bin:$PATH
		set -- "-G MSYS Makefiles" "${@}"
	fi
	
	if [ "${Target_Tuple}" = "Windows_X86_64_Gcc" ]; then
		export PATH=${DK3RDPARTY_DIR}/msys2-x86_64-20231026/mingw64/bin:$PATH
		set -- "-G MSYS Makefiles" "${@}"
	fi
	
	if [ "${Target_Tuple}" = "Windows_X86_64_Ucrt" ]; then
		export PATH=${DK3RDPARTY_DIR}/msys2-x86_64-20231026/ucrt64/bin:$PATH
		set -- "-G MSYS Makefiles" "${@}"
	fi

	###### CMAKE_TOOLCHAIN_FILE ######
#	TOOLCHAIN="${DKCMAKE_DIR}/toolchains/${Target_Tuple}_toolchain.cmake"
#	dk_echo "TOOLCHAIN = $TOOLCHAIN"
#	if dk_pathExists "$TOOLCHAIN"; then
#		set -- "${@}" "-DCMAKE_TOOLCHAIN_FILE=$TOOLCHAIN"
#	fi
	
	###### WSL CMake Fix ######
	if dk_defined WSLENV; then 
		cd "${DKCMAKE_DIR}"
		set -- "${@}" "."
	fi
	
	###### CMake Configure ######
	dk_installCmake
	
	dk_echo
	dk_echo "****** CMAKE COMMAND ******"
	dk_echo "CMAKE_ARGS = ${@}"	
	dk_call "${cmake_exe}" "${@}"
	dk_echo
}
	

##################################################################################
# dk_buildApp()
#
#
dk_buildApp() {
	dk_verbose "dk_buildApp(${*})"
	[ ${#} -gt 0 ] && dk_error "too many arguments"

	dk_echo
	dk_echo "##################################################################"
	dk_echo "****** Building ${Target_App} - ${Target_Tuple} - ${Target_Type} - ${Target_Level} ******"
	dk_echo "##################################################################"
	dk_echo
	
	if [ "${Target_Type}" = "Debug" ] || [ "${Target_Type}" = "All" ]; then
		if dk_pathExists "${DKCPP_APPS_DIR}/${Target_App}/${Target_Tuple}/Debug/CMakeCache.txt"; then
			dk_call "${cmake_exe}" "--build" "${DKCPP_APPS_DIR}/${Target_App}/${Target_Tuple}/Debug" "--config Debug" "--verbose"
		elif dk_pathExists "${DKCPP_APPS_DIR}/${Target_App}/${Target_Tuple}/CMakeCache.txt"; then
			dk_call "${cmake_exe}" "--build" "${DKCPP_APPS_DIR}/${Target_App}/${Target_Tuple}" "--config Debug" "--verbose"
		else
			dk_error "Could not find CMakeCache.txt in ${Target_App}/${Target_Tuple}/Debug or ${Target_App}/${Target_Tuple}"
		fi
	fi
	if [ "${Target_Type}" = "Release" ] || [ "${Target_Type}" = "All" ]; then
		if dk_pathExists "${DKCPP_APPS_DIR}/${Target_App}/${Target_Tuple}/Release/CMakeCache.txt"; then
			dk_call "${cmake_exe}" --build "${DKCPP_APPS_DIR}/${Target_App}/${Target_Tuple}/Release" --config Release --verbose
		elif dk_pathExists "${DKCPP_APPS_DIR}/${Target_App}/${Target_Tuple}/CMakeCache.txt"; then
			dk_call "${cmake_exe}" --build "${DKCPP_APPS_DIR}/${Target_App}/${Target_Tuple}" --config Release --verbose
		else
			dk_error "Could not find CMakeCache.txt in ${Target_App}/${Target_Tuple}/Release or ${Target_App}/${Target_Tuple}"
		fi
	fi
	
	dk_echo
	dk_echo "##################################################################"
	dk_echo "****** Done Building ${Target_App} - ${Target_Tuple} - ${Target_Type} - ${Target_Level} ******"
	dk_echo "##################################################################"
	dk_echo
}


####################################################################
# DKBash FUNCTIONS
# 
#####################################################################

#####################################################################
# dk_DIGITALKNOB_DIR()
#
#
dk_DIGITALKNOB_DIR() {
	dk_verbose "dk_DIGITALKNOB_DIR(${*})"
	
	if [ -n "${USERPROFILE-}" ]; then
		dk_printVar USERPROFILE
		DIGITALKNOB_DIR="$USERPROFILE\DigitalKnob"
		dk_replaceAll "${DIGITALKNOB_DIR}" "\\" "/" DIGITALKNOB_DIR
		dk_replaceAll "${DIGITALKNOB_DIR}" "C:" "/c" DIGITALKNOB_DIR
	else
		DIGITALKNOB_DIR="$HOME/DigitalKnob"
	fi
	dk_printVar DIGITALKNOB_DIR
	mkdir -p "${DIGITALKNOB_DIR}"
	
	DKTOOLS_DIR="${DIGITALKNOB_DIR}/DKTools"
	mkdir -p "${DKTOOLS_DIR}"
	dk_printVar DKTOOLS_DIR
	
	DKDOWNLOAD_DIR="${DIGITALKNOB_DIR}/download"
	mkdir -p "${DKDOWNLOAD_DIR}"
	dk_printVar DKDOWNLOAD_DIR
}

##################################################################################
# dk_url()
#
#
dk_url() {
	dk_contains ${1} "://" && return $(true)
	return $(false)
}

##################################################################################
# dk_installCmake()
#
#
dk_installCmake() {
	dk_verbose "dk_installCmake(${*})"
	[ ${#} -gt 0 ] && dk_error "too many arguments"
	
	######################################################################################################
	if [ "${Host_Os}" 		= "Android" ]; 				then cmake_Import=cmake;							fi
	if [ "${Host_Tuple}" 	= "Windows_Arm32" ];		then cmake_Import=$cmake_Windows_Arm32_Import;				fi
	if [ "${Host_Tuple}" 	= "Windows_Arm64" ];		then cmake_Import=$cmake_Windows_Arm64_Import;				fi
	if [ "${Host_Tuple}" 	= "Windows_X86" ];			then cmake_Import=$cmake_Windows_X86_Import;				fi
	if [ "${Host_Tuple}"	= "Windows_X86_64" ];		then cmake_Import=$cmake_Windows_X86_Import_64;				fi
	if [ "${Host_Os}" 		= "Mac" ];					then cmake_Import=$cmake_Mac_X86_64_Import;					fi
	if [ "${Host_Tuple}" 	= "Linux_X86_64" ];			then cmake_Import=$cmake_Linux_X86_64_Import;			fi
	if [ "${Host_Tuple}" 	= "Linux_Arm64" ];			then cmake_Import=$cmake_Linux_Arm64_Import;			fi
	if [ "${Host_Tuple}" 	= "Raspberry_Arm64" ];		then cmake_Import=$cmake_Linux_Arm64_Import;			fi
	if [ "${Target_Tuple}" 	= "Android_Arm32" ]; 		then cmake_Import=cmake;							fi
	if [ "${Target_Tuple}" 	= "Windows_Arm64_Clang" ]; 	then cmake_Import=mingw-w64-clang-aarch64-cmake;	fi
	if [ "${Target_Tuple}" 	= "Windows_X86_Clang" ];	then cmake_Import=mingw-w64-clang-i686-cmake;		fi
	if [ "${Target_Tuple}" 	= "Windows_X86_Gcc" ]; 		then cmake_Import=mingw-w64-i686-cmake;				fi
	if [ "${Target_Tuple}"	= "Windows_X86_64_Clang" ];	then cmake_Import=mingw-w64-clang-x86_64-cmake;		fi
	if [ "${Target_Tuple}" 	= "Windows_X86_64_Gcc" ];	then cmake_Import=mingw-w64-x86_64-cmake;			fi
	if [ "${Target_Tuple}" 	= "Windows_X86_64_Ucrt" ]; 	then cmake_Import=mingw-w64-ucrt-x86_64-cmake;		fi
	
	dk_printVar cmake_Import
	if dk_url ${cmake_Import}; then
		dk_info "Installing CMake from dl files"
		dk_printVar cmake_Import
		
		dk_basename "$cmake_Import" cmake_Import_FILE
		dk_printVar cmake_Import_FILE
		
		cmake_Install_Folder="${cmake_Import_FILE%.*}"		# remove everything past last dot
		dk_printVar cmake_Install_Folder
		dk_debug "cmake_Import_FILE extension = ${cmake_Install_Folder##*.}"
		if [ "${cmake_Install_Folder##*.}" = "tar" ]; then
			cmake_Install_Folder="${cmake_Install_Folder%.*}"	# .tar.?? files remove past the last TWO dots
		fi
		
		#dk_convertToCIdentifier "$cmake_Install_Folder" cmake_Install_Folder
		dk_toLower cmake_Install_Folder
		dk_printVar cmake_Install_Folder
		
		if [ "${Host_Os}" = "Windows" ]; then
			cmake_exe=${DKTOOLS_DIR}/$cmake_Install_Folder/bin/cmake.exe
		elif [ "${Host_Os}" = "Mac" ]; then
			cmake_exe=${DKTOOLS_DIR}/$cmake_Install_Folder/CMake.app/Contents/bin/cmake
		elif [ "${Host_Os}" = "Linux" ]; then
			cmake_exe=${DKTOOLS_DIR}/$cmake_Install_Folder/bin/cmake
		elif [ "${Host_Os}" = "Raspberry" ]; then
			cmake_exe=${DKTOOLS_DIR}/$cmake_Install_Folder/bin/cmake
		else
			dk_error "no cmake for this OS"
		fi
		dk_printVar cmake_exe
		
		if dk_pathExists "${cmake_exe}"; then 
			return $(true);
		fi

		dk_echo
		dk_info "Installing cmake . . ."
		dk_download "$cmake_Import"
		dk_extract "${dk_download}" "${DKTOOLS_DIR}"
		
		#if ! dk_pathExists ${cmake_exe}; then error "cannot find cmake"; fi

	else	# Linux package
		dk_info "Installing CMake from package managers"
		
		cmake_exe=$(command -v cmake)
		dk_printVar cmake_exe
		if ! dk_commandExists cmake; then
			dk_installPackage ${cmake_Import}
		fi	
		cmake_exe=$(command -v cmake)
		dk_printVar cmake_exe
	fi
}


##################################################################################
# dk_echo(message)
#
#
dk_echo() {
	#echo "dk_echo(${*})"

	if [ "$(echo -e)" = "" ]; then
		echo -e "${1-}"
	else
		echo "${1-}"
	fi
}


##################################################################################
# dk_verbose(message)
#
#
dk_verbose() {
	#dk_verbose "dk_verbose(${*})"
	[ -z "${1}" ] && dk_error "dk_verbose(${*}): requires at least 1 parameter"
	
	[ ${LOG_VERBOSE} = 1 ] || return 0

	dk_echo "${cyan}VERBOSE: ${1} ${clr}"
}


##################################################################################
# dk_debug(message)
#
#	Print a debug message to the console
#
#	@msg	- The message to print
#
dk_debug() {
	#dk_verbose "dk_debug(${*})"	
	[ ${#} -lt 1 ] && dk_error "dk_debug(${*}): requires at least 1 parameter"
	
	[ $LOG_DEBUG -eq 1 ] || return 0
	
	msg="${1}"
	dk_echo "${blue}  DEBUG: ${msg} ${clr}"
}


##################################################################################
# dk_info(message)
#
#
dk_info() {
	#dk_verbose "dk_info(${*})"
	
	msg="${1}"
	dk_echo "${white}   INFO: ${msg} ${clr}"
}


##################################################################################
# dk_warning(message)
#
#
dk_warning() {
	#dk_verbose "dk_warning(${*})"
	
	msg="${1}"
	dk_echo "${yellow}WARNING: ${msg} ${clr}"
	[ ${TRACE_ON_WARNINGS-} = 1 ] && dk_stacktrace
	[ ${HALT_ON_WARNINGS-} = 1 ] && exit 1
}


##################################################################################
# dk_error(message)
#
#
dk_error() {
	#dk_verbose "dk_error(${*})"
	
	msg="${1}"
	dk_echo "${red}  ERROR: ${msg} ${clr}"
	dk_stacktrace
	[ $CONTINUE_ON_ERRORS = 1 ] && return 0
	dk_pause
	exit 1
}


##################################################################################
# dk_variable_info(name output)
#
#
dk_variable_info() {
	echo "dk_variable_info(${*})"
	
	[ ${#} -ne 2 ] && return $(false)										# if not exactly 2 parameters
	$(expr "${1}" : "^[A-Za-z0-9_]\+$" 1>/dev/null) || return $(false)		# if not valid variable name
	$(expr "${2}" : "^[A-Za-z0-9_]\+$" 1>/dev/null) || return $(false)		# if not valid variable name
	
	if dk_defined ${1}; then
		eval value='$'{${1}}
		eval "${2}=\"${1} = '${value}'\""
	else
		eval "${2}=\"${1} = ${red}NOT DEFINED${clr}\""
	fi
}

##################################################################################
# dk_stacktrace()
#
#
dk_stacktrace() {
    dk_verbose "dk_stacktrace(${*})"
	[ ${#} -gt 0 ] && dk_error "too many arguments"
	
	#[ "${LINENO-}" = "" ] || "LINENO = ${LINENO-}"	

	### VERSION 1 ###
	[ "${FUNCNAME-}" = "" ] && return 0
	#[ "${BASH_SOURCE-}" = "" ] && return 0
	#[ "${BASH_LINENO-}" = "" ] && return 0
	local i=${1:-1} size=${#FUNCNAME[@]}
 	((i<size)) && echo "STACKTRACE[$size]" 
	i=0
	while [ "$i" -le "$size" ]; do
		((frame=${#FUNCNAME[@]}-i-2 ))
		echo "[$frame] ${BASH_SOURCE[$i]:-}:${BASH_LINENO[$i]} ${FUNCNAME[$i+1]}()"
		i=$(( i + 1 ))
	done 


#	### VERSION 2 ###
#	[ "${FUNCNAME-}" = "" ] && return 0
#	[ "${BASH_SOURCE-}" = "" ] && return 0
#	[ "${BASH_LINENO-}" = "" ] && return 0
#	local status_code="${1}" 
#	local -a stack=("Stack trace of error code '${status_code}':")
#	local stack_size=${#FUNCNAME[@]}
#	local -i i
#	local indent="    "
#	# to avoid noise we start with 1 to skip the stack function
#	for (( i = 1; i < stack_size; i++ )); do
#	    local func="${FUNCNAME[$i]:-(top level)}"
#	    local -i line="${BASH_LINENO[$(( i - 1 ))]}"
#	    local src="${BASH_SOURCE[$i]:-(no file)}"
#	    stack+=("${indent} └ $src:$line ($func)")
#	    indent="${indent}    "
#	done
#	(IFS=$'\n'; echo "${stack[*]}")


#	### VERSION 3 ###
#	local i=1 line file func
#	while read -r line func file < <(caller ${i}); do
#		echo >&2 [$i] $file:$line $func(): $(sed -n ${line}p $file)
#		((i++))
#	done
}

##################################################################################
# dk_defined(variable)
#
# Evaluates to true if the parameter is a variable that exists.
#
dk_defined() {
	dk_verbose "dk_defined(${*})"
	[ ${#} -ne 1 ] && return $(false) # Incorrect number of parameters
	
	eval value='$'{${1}+x} # value will = 'x' if the variable is defined
	[ -n "${value}" ]
}


##################################################################################
# dk_hasValue(variable)
#
# Evaluates to true if the parameter is a variable that exists and has value
#
dk_hasValue() {
	dk_verbose "dk_hasValue(${*})"
	[ ${#} -ne 1 ] && dk_error "Incorrect number of parameters"
	
	eval value='$'{${1}}
	[ -n "${value//[[:blank:]]/}" ] # remove spaces and check if empty
}


##################################################################################
# dk_call(command args)
#
#
dk_call() {
	#dk_verbose "dk_call(${*})"
	[ ${#} -lt 1 ] && dk_error "Incorrect number of parameters"

	dk_echo "${magenta} $ ${*} ${clr}"
	#$("${@}") && "${@}" 2>&1 #|| dk_verbose "'${*}: failed!'"
	"${@}"
}


##################################################################################
# dk_gitCheckRemote()
#
#
dk_gitCheckRemote() {
	dk_verbose "dk_gitCheckRemote(${*})"
	[ ${#} -gt 0 ] && dk_error "too many arguments"

	ahead=0
	behind=0
	if [ -d "${DKBRANCH_DIR}/.git" ]; then
		cd "${DKBRANCH_DIR}"
		${git_exe} -C ${DKBRANCH_DIR} remote update
		branch=$(${git_exe} -C ${DKBRANCH_DIR} rev-parse --abbrev-ref HEAD)
		ahead=$(${git_exe} -C ${DKBRANCH_DIR} rev-list --count origin/$branch..$branch)
		behind=$(${git_exe} -C ${DKBRANCH_DIR} rev-list --count $branch..origin/$branch)
		dk_info "$ahead commits ahead, $behind commits behind"
	fi
}


##################################################################################
# dk_validate_sudo()
#
#
dk_validate_sudo() {
	dk_verbose "dk_validate_sudo(${*})"
	[ ${#} -gt 0 ] && dk_error "too many arguments"
	
	if command -v "sudo" >/dev/null; then
		sudo_exe="sudo"
	fi
	${sudo_exe} echo
}


##################################################################################
# dk_reload()
#
#
dk_reload() {
	dk_verbose "dk_reload(${*})"
	[ ${#} -gt 0 ] && dk_error "too many arguments"
	
	dk_debug "reloading $DKSCRIPT_DIR/$DKSCRIPT_FILE"
	clear
	exec "$DKSCRIPT_DIR/$DKSCRIPT_FILE"
}


##################################################################################
# dk_confirm()
#
#
dk_confirm() {
	dk_verbose "dk_confirm(${*})"
	[ ${#} -gt 0 ] && dk_error "too many arguments"

	dk_echo "${yellow} Are you sure ? [Y/N] ${clr}"
	read -rp $" " REPLY
	dk_echo
	dk_echo
	#result=$(echo ${REPLY} | grep "^[Yy]$")
	[ "${REPLY}" = "y" ] && return $(true)
	[ "${REPLY}" = "Y" ] && return $(true)
	return $(false);
}


##################################################################################
# dk_contains(string substring)
#
#
dk_contains() {
	dk_verbose "dk_contains(${*})"
	[ ${#} -ne 2 ] && dk_error "Incorrect number of parameters"
	
	# https://stackoverflow.com/a/8811800/688352
	string=${1}
	substring=${2}
	[ "${string#*"$substring"}" != "$string" ]	
}



##################################################################################
# dk_commandExists(command)
#
#
dk_commandExists() {
	dk_verbose "dk_commandExists(${*})"
	[ ${#} -ne 1 ] && dk_error "Incorrect number of parameters"

	[ -n "$(command -v "${1}")" ]
}
	

##################################################################################
# dk_pathExists(file)
#
#
dk_pathExists() {
	dk_verbose "dk_pathExists(${*})"
	[ ${#} -ne 1 ] && dk_error "Incorrect number of parameters"

	#if [ -e "${1}" ]; then
	#	dk_debug "dk_pathExists(${*}): FOUND"
	#else
	#	dk_warning "dk_pathExists(${*}): NOT FOUND!" 
	#fi
	[ -e "${1}" ]
}


##################################################################################
# dk_basename(path output)
#
#
dk_basename() {
	dk_verbose "dk_basename(${*})"
	[ ${#} -ne 2 ] && dk_error "Incorrect number of parameters"
	
	eval "${2}=$(basename "${1}")"
}


##################################################################################
# dk_convertToCIdentifier(input output)
#
#
dk_convertToCIdentifier() {
	dk_verbose "dk_convertToCIdentifier(${*})"
	[ ${#} -ne 2 ] && dk_error "Incorrect number of parameters"
	
	input=${1}
	
	#input="${input//[^[:alnum:]]/_}"			# BASH alpha_numeric_replace
	dk_replaceAll "${input}" "-" "_" input		# POSIX replace
	dk_replaceAll "${input}" "." "_" output		# POSIX replace
	
	eval "${2}=${output}"
	dk_printVar ${2}
	#[ ${input} = "" ]
}

##################################################################################
# dk_replaceAll(input searchValue newValue output)
#
#
dk_replaceAll() {
	dk_verbose "dk_replaceAll(${*})"
	[ ${#} -ne 4 ] && dk_error "Incorrect number of parameters"
	
    input=${1}
	searchValue=${2}
	newValue=${3}
    output=
		
    while [ -n "${input}" ]; do
        LEFT=${input%%"$searchValue"*}

        if [ "$LEFT" = "${input}" ]; then
            output=${output}${input}
			break
        fi

        output=${output}$LEFT$newValue
        input=${input#*"$searchValue"}
    done
	
	
	eval "${4}=${output}"
	dk_printVar ${4}
}


##################################################################################
# dk_toLower(variable)
#
#
dk_toLower() {
	dk_verbose "dk_toLower(${*})"
	[ ${#} -ne 1 ] && dk_error "Incorrect number of parameters"
	
	dk_defined ${1} || dk_error "dk_toLower(${*}): ${1} is not defined"

	eval value='$'{${1}}
	value=$(echo "${value}" | tr '[:upper:]' '[:lower:]')

	eval "${1}=${value}"
}


##################################################################################
# dk_download(url destination)
#
#
dk_download() {
	dk_verbose "dk_download(${*})"
	[ ${#} -ne 2 ] && dk_error "Incorrect number of parameters"
	
	if dk_pathExists "${2}"; then
		dk_warning "dk_download(): ${2} already exists"
		return 0
	fi
	dk_info "Downloading ${1} . . ."
	parentdir="$(dirname "${2}")"
	dk_printVar "parentdir = $parentdir"
	olddir=$PWD
	cd "$parentdir" #|| dk_error "cd $parentdir failed!"
	wget -P "$parentdir" "${1}" 
	cd "$oldpwd" #|| dk_error "cd $oldpwd failed!"
	#[ "${input}" = "" ]
}


##################################################################################
# dk_extract(file destination)
#
#
dk_extract() {
	dk_verbose "dk_extract(${*})"
	[ ${#} -ne 2 ] && dk_error "Incorrect number of parameters"

	filename="$(basename "${1}")"
	destFolder="${filename%.*}"
	destFolder="${destFolder%.*}"
	fulldest="${2}/$destFolder"
	dk_printVar fulldest
		
	#if dk_pathExists $fulldest; then
	#	dk_warning "dk_extract(): $fulldest already exists"
	#	return 0
	#fi
	dk_info "Extracting ${1} . . ."
	parentdir="$(dirname "${1}")"
	parentdest="$(dirname "${2}")"
	dk_printVar "parentdir = $parentdir"
	dk_printVar "filename = $filename"
	#need to cd into parent directory of ${1} and send tar the file name of ${1}
	olddir=$PWD
	cd "$parentdir" #|| dk_error "cd $$parentdir failed!"
	tar -xf "$filename" -C "${2}"
	cd "$oldpwd" #|| dk_error "cd $$oldpwd failed!"
	#dk_convertToCIdentifier "$destFolder" destFolder_
	dk_printVar destFolder_
	mv "${2}"/"$destFolder" "${2}"/"$destFolder_"

	#TODO
	#[ "${input}" = "" ]
}


##################################################################################
# dk_rename(from to)
#
#
dk_rename() {
	dk_verbose "dk_rename(${*})"
	[ ${#} -ne 2 ] && dk_error "Incorrect number of parameters"
	
	#TODO
	#[ ? = "success" ]
}


##################################################################################
# dk_removeExtension(filepath)
#
#
dk_removeExtension() {
	dk_verbose "dk_removeExtension(${*})"
	[ ${#} -ne 1 ] && dk_error "Incorrect number of parameters"
	
	filepath="${1}"
	filepath="${filepath%.*}"									    # remove everything past last dot
	[ "${filepath##*.}" = "tar" ] &&	filepath="${filepath%.*}"	# if .tar remove everything past last dot

}


##################################################################################
# dk_installGit()
#
#
dk_installGit() {
	dk_verbose "dk_installGit(${*})"
	[ ${#} -gt 0 ] && dk_error "too many arguments"
	
	if ! dk_commandExists git; then
		dk_installPackage git
	fi
	
	git_exe=$(command -v git)
	[ -e ${git_exe} ] || dk_error "git_exe is invalid"
	
	dk_printVar git_exe
}


##################################################################################
# dk_installHomebrew()
#
#
dk_installHomebrew() {
	dk_verbose "dk_installHomebrew(${*})"
	[ ${#} -gt 0 ] && dk_error "Incorrect number of parameters"

	if ! [ "$OSTYPE" = "darwin"* ]; then
		return
	fi
		
	if ! dk_commandExists brew; then
		dk_info "dk_installing Homebrew"
		ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
		# https://github.com/Homebrew/brew/issues/10368
		rm -fr $(brew --repo homebrew/core)
		brew tap homebrew/core
	fi
	
	BREW=$(command -v brew)
	dk_printVar BREW
}


##################################################################################
# dk_packageInstalled(package)
#
#
dk_packageInstalled() {
	dk_verbose "dk_packageInstalled(${*})"
	[ ${#} -ne 1 ] && dk_error "Incorrect number of parameters"

	if dk_commandExists dpkg-query; then
		if [ $(dpkg-query -W -f='${Status}' "${1}" 2>/dev/null | grep -c "ok dk_installed") -ne 0 ]; then
			return $(true)
		fi
	elif dk_commandExists brew; then
		if brew list "${1}" &>/dev/null; then
			return $(true)
		fi
	elif dk_commandExists apt; then
		dk_error "dk_packageInstalled() apt-get not implemented"
	elif dk_commandExists apt-get; then
		dk_error "dk_packageInstalled() apt-get not implemented"
	elif dk_commandExists pkg; then
		dk_error "dk_packageInstalled() pkg not implemented"
	elif dk_commandExists pacman; then
		if pacman -Qs "${1}" >/dev/null; then
			#FIXME: this doesn't always work
			return $(false);
		fi
	elif dk_commandExists tce-load; then
		#dk_error "dk_packageInstalled() tce-load not implemented"
		return $(false)
	else
		dk_error "ERROR: no package managers found"
	fi
	return $(false)
}


##################################################################################
# dk_installPackage(package)
#
#
dk_installPackage() {
	dk_verbose "dk_installPackage(${*})"
	[ ${#} -ne 1 ] && dk_error "Incorrect number of parameters"

	#if dk_packageInstalled ${1}; then
	#	dk_warning "${1} already dk_installed"
	#	return $(false);
	#fi
	
	dk_info "dk_installing ${1}"

	if dk_commandExists brew; then
		dk_call brew install "${1}"
	elif dk_commandExists apt; then
		dk_call apt -y install "${1}"
	elif dk_commandExists apt-get; then
		dk_call apt-get -y install "${1}"
	elif dk_commandExists pkg; then
		dk_call pkg install "${1}"
	elif dk_commandExists pacman; then
		dk_call pacman -S "${1}" --noconfirm
	elif dk_commandExists tce-load; then
		dk_call tce-load -wi "${1}"
	else
		dk_error "ERROR: no package managers found"
	fi
}


##################################################################################
# dk_validatePackage(command package)
#
#
dk_validatePackage() {
	dk_verbose "dk_validatePackage(${*})"
	[ ${#} -ne 2 ] && dk_error "Incorrect number of parameters"
	
	if ! dk_commandExists "${1}"; then
		dk_installPackage "${2}"
	fi
}


##################################################################################
# dk_validateOstype()
#
#
#dk_validateOstype() {
#	dk_verbose "dk_validateOstype(${*})"
#	[ ${#} -gt 0 ] && dk_error "Incorrect number of parameters"
#	
#	if [ -e /proc/device-tree/model ]; then
#		MODEL=$(tr -d '\0' </proc/device-tree/model)
#	fi
#
#	if [ "$OSTYPE" = "linux-gnu"* ]; then
#		DIGITALKNOB_DIR="/home/$USER/DigitalKnob"
#	elif [ "$OSTYPE" = "darwin"* ]; then
#		DIGITALKNOB_DIR="/Users/$USER/DigitalKnob"
#	elif [ "$OSTYPE" = "cygwin" ]; then
#		DIGITALKNOB_DIR="/c/Users/$USERNAME/DigitalKnob"
#	elif [ "$OSTYPE" = "msys" ]; then
#		DIGITALKNOB_DIR="/c/Users/$USERNAME/DigitalKnob"
#	elif [ "$OSTYPE" = "win32" ]; then #I'm not sure this can happen
#		DIGITALKNOB_DIR="/c/Users/$USERNAME/DigitalKnob" 
#	elif [ "$OSTYPE" = "freebsd"* ]; then
#		dk_error "TODO: freebsd builder incomplete"
#	elif [ "$OSTYPE" = "linux-android" ]; then
#		DIGITALKNOB_DIR="/data/data/com.termux/files/home/DigitalKnob"
#	else
#		dk_error "UNKNOWN OS ($OSTYPE)"
#	fi
#}


##################################################################################
# dk_DKBRANCH_DIR()
#
#
dk_DKBRANCH_DIR() {
	dk_verbose "dk_DKBRANCH_DIR(${*})"
	[ ${#} -gt 0 ] && dk_error "Incorrect number of parameters"

	# If the current folder matches the current branch set DKBRANCH, default to Development
	
	FOLDER="$(basename $(pwd))"
	DKBRANCH="Development"
	
	if dk_pathExists "${DIGITALKNOB_DIR}"/"$FOLDER"/.git; then
		BRANCH="$($git_exe rev-parse --abbrev-ref HEAD)"
		if [ "$BRANCH" = "$FOLDER" ]; then
			DKBRANCH="$FOLDER"
		fi
	fi
	dk_printVar DKBRANCH
	
	DKBRANCH_DIR="${DIGITALKNOB_DIR}/$DKBRANCH"
	dk_printVar  DKBRANCH_DIR
	
	DKCMAKE_DIR="${DKBRANCH_DIR}/DKCMake"
	dk_printVar  DKCMAKE_DIR
	
	DK3RDPARTY_DIR="${DKBRANCH_DIR}/3rdParty"
	dk_printVar DK3RDPARTY_DIR
	
	DKIMPORTS_DIR="$DK3RDPARTY_DIR/_DKIMPORTS"
	dk_printVar DKIMPORTS_DIR
	
	DKCPP_APPS_DIR="${DIGITALKNOB_DIR}/${DKBRANCH}/DKCpp/apps"
	dk_printVar DKCPP_APPS_DIR
	
	DKCPP_PLUGINS_DIR="${DIGITALKNOB_DIR}/$DKBRANCH/DKCpp/plugins"
	dk_printVar DKCPP_PLUGINS_DIR

	# make sure script is running from DKBRANCH_DIR
	#if ! [ "$DKSCRIPT_DIR" = "${DKBRANCH_DIR}" ]; then
	#	if ! dk_pathExists ${DKBRANCH_DIR}/$DKSCRIPT_FILE; then
	#		dk_debug "${DKBRANCH_DIR}/$DKSCRIPT_FILE"
	#		cp $DKSCRIPT_DIR/$DKSCRIPT_FILE ${DKBRANCH_DIR}/$DKSCRIPT_FILE
	#	fi
	#	dk_echo
	#	dk_info "RELOADING SCRIPT TO -> ${DKBRANCH_DIR}/$DKSCRIPT_FILE"
	#	read -p "Press enter to continue"
	#	clear
	#	if dk_pathExists ${DKBRANCH_DIR}/$DKSCRIPT_FILE; then
	#		rm $DKSCRIPT_DIR/$DKSCRIPT_FILE
	#	fi
	#	${DKBRANCH_DIR}/$DKSCRIPT_FILE
	#	exit
	#fi
}


##################################################################################
# dk_pause()
#
#
dk_pause() {
	dk_verbose "dk_pause(${*})"
	[ ${#} -gt 0 ] && dk_error "Incorrect number of parameters"
	
	read -rp 'Press enter to continue...' key
}


##################################################################################
# dk_clearCmakeCache()
#
#
dk_clearCmakeCache() {
	dk_verbose "dk_clearCmakeCache(${*})"
	[ ${#} -gt 0 ] && dk_error "Incorrect number of parameters"
	
	dk_info "Clearing CMake cache . . ."
	cd "${DIGITALKNOB_DIR}" #|| dk_error "cd $${DIGITALKNOB_DIR} failed!"
	find . -name "CMakeCache.*" -delete
	rm -rf $(find . -type d -name CMakeFiles)
}


##################################################################################
# dk_deleteTempFiles()
#
#
dk_deleteTempFiles() {
	dk_verbose "dk_deleteTempFiles(${*})"
	[ ${#} -gt 0 ] && dk_error "Incorrect number of parameters"

	dk_info "Deleting .TMP files . . ."
	cd "${DIGITALKNOB_DIR}" #|| dk_error "cd $${DIGITALKNOB_DIR} failed!"
	rm -rf $(find . -type d -name *.tmp)
	rm -rf $(find . -type d -name *.TMP)
	find . -name "*.tmp" -delete
	find . -name "*.TMP" -delete
}


##################################################################################
# dk_installMsys2()
#
#
#dk_installMsys2() {
#	dk_verbose "dk_installMsys2(${*})"
#	[ ${#} -gt 0 ] && dk_error "Incorrect number of parameters"
#
#	dk_cmakeEval "include('${DKIMPORTS_DIR}/msys2/DKINSTALL.cmake')" "MSYS2"
#	dk_printVar MSYS2
#}


##################################################################################
# dk_installMake()
#
#
#dk_installMake() {
#	dk_verbose "dk_installMake(${*})"
#	[ ${#} -gt 0 ] && dk_error "Incorrect number of parameters"
#
#	dk_cmakeEval "include('${DKIMPORTS_DIR}/make/DKINSTALL.cmake')" "MAKE_PROGRAM"
#	dk_printVar MAKE_PROGRAM
#}


##################################################################################
# dk_installEmscripten()
#
#
#dk_installEmscripten() {
#	dk_verbose "dk_installEmscripten(${*})"
#	[ ${#} -gt 0 ] && dk_error "Incorrect number of parameters"
#
#	dk_cmakeEval "include('${DKIMPORTS_DIR}/emsdk/DKINSTALL.cmake')" "emsdk;emsdk_ENV;emsdk_GENERATOR;emsdk_TOOLCHAIN_FILE;emsdk_C_COMPILER;emsdk_CXX_COMPILER"
#	dk_printVar emsdk
#	dk_printVar emsdk_ENV
#	dk_printVar emsdk_GENERATOR
#	dk_printVar emsdk_TOOLCHAIN_FILE
#	dk_printVar emsdk_C_COMPILER
#	dk_printVar emsdk_CXX_COMPILER
#}


##################################################################################
# dk_installAndroidNdk()
#
#
#dk_installAndroidNdk() {
#	dk_verbose "dk_installAndroidNdk(${*})"
#	[ ${#} -gt 0 ] && dk_error "Incorrect number of parameters"
#
#	dk_cmakeEval "include('${DKIMPORTS_DIR}/android-ndk/DKINSTALL.cmake')" "ANDROID_NDK;ANDROID_GENERATOR;ANDROID_TOOLCHAIN_FILE;ANDROID_API;ANDROID_MAKE_PROGRAM;ANDROID_C_COMPILER;ANDROID_CXX_COMPILER"
#	dk_printVar ANDROID_NDK
#	dk_printVar ANDROID_GENERATOR
#	dk_printVar ANDROID_TOOLCHAIN_FILE
#	dk_printVar ANDROID_API
#	dk_printVar ANDROID_MAKE_PROGRAM
#	dk_printVar ANDROID_C_COMPILER
#	dk_printVar ANDROID_CXX_COMPILER
#}


##################################################################################
# dk_installClang()
#
#
#dk_installClang() {
#	dk_verbose "dk_installClang(${*})"
#	[ ${#} -gt 0 ] && dk_error "Incorrect number of parameters"
#
#	dk_cmakeEval "include('${DKIMPORTS_DIR}/clang/DKINSTALL.cmake')" "CLANG_C_COMPILER;CLANG_CXX_COMPILER"
#	dk_printVar CLANG_C_COMPILER
#	dk_printVar CLANG_CXX_COMPILER
#}


##################################################################################
# dk_installGcc()
#
#
#dk_installGcc() {
#	dk_verbose "dk_installGcc(${*})"
#	[ ${#} -gt 0 ] && dk_error "Incorrect number of parameters"
#
#	dk_cmakeEval "include('${DKIMPORTS_DIR}/gcc/DKINSTALL.cmake')" "GCC_C_COMPILER;GCC_CXX_COMPILER"
#	dk_printVar GCC_C_COMPILER
#	dk_printVar GCC_CXX_COMPILER
#}


##################################################################################
# dk_cmakeEval(cmake_commands;.;.; return_variables;.;.;. -DVARS;.;.;)
#
#			
dk_cmakeEval() {
	dk_verbose "dk_cmakeEval(${*})"
	
	if [ -z "${1}" ]; then
		dk_error "dk_cmakeEval() parameter 1 is invalid"
	fi
	
	commands="${1}"
	variables="${2}"
	#set commands=$commands:"=%"  #TODO: remove double quotes
	DKCOMMAND="$commands"
	dk_printVar DKCOMMAND
	
	if [ -n "$variables" ]; then
		dk_call "${cmake_exe}" "-DDKCMAKE_DIR=${DKCMAKE_DIR}" "-DDKCOMMAND=$DKCOMMAND" "-DDKRETURN=${2}" "${3}" -P "${DKCMAKE_DIR}"/dev/dk_cmakeEval.cmake
		if dk_pathExists "${DKCMAKE_DIR}"/cmake_vars; then
	    	dk_info "executing cmake_vars"
			. "${DKCMAKE_DIR}"/cmake_vars
			#rm ${DKCMAKE_DIR}/cmake_vars
		fi
	else
		dk_call "${cmake_exe}" "-DDKCMAKE_DIR=${DKCMAKE_DIR}" "-DDKCOMMAND=$DKCOMMAND" -P "${DKCMAKE_DIR}"/dev/dk_cmakeEval.cmake
	fi
	#dk_debug return code: ${?}
}


##################################################################################
# dk_pushAssets()
#
#
dk_pushAssets() {
	dk_verbose "dk_pushAssets(${*})"
	[ ${#} -gt 0 ] && dk_error "Incorrect number of parameters"
	
	dk_confirm || return 0
	
	dk_error "not implemented,  TODO"
}


##################################################################################
# dk_pullAssets()
#
#
dk_pullAssets() {
	dk_verbose "dk_pullAssets(${*})"
	[ ${#} -gt 0 ] && dk_error "Incorrect number of parameters"
	
	dk_confirm || return 0

	dk_error "not implemented,  TODO"
}


##################################################################################
# dk_resetAll()
#
#
dk_resetAll() {
	dk_verbose "dk_resetAll(${*})"
	[ ${#} -gt 1 ] && dk_error "Too many parameters"
	
	if ! [ "${1}" = "wipe" ]; then
		clear
		dk_echo
		dk_echo
		dk_info "Do you want to reset the entire local repository . . . ?"
		dk_info "This will delete DigitalKnob, everything will be reset,"
		dk_info "and the repository will be re-cloned. All libraries and tools"
		dk_info "will be re downloaded and rebuild from start. Save any changes"
		dk_info "you wish to commit or save beforehand."
		dk_echo
		
		dk_confirm || return 0
		
		# first we need to relocate this file up one directory
		# make sure script is running from DKBRANCH_DIR
		if ! [ "$DKSCRIPT_DIR" = "${DKBRANCH_DIR}" ]; then
			dk_echo "${yellow}"
			dk_echo "WARNING: this file isn't running from the branch directory"
			dk_echo "Is must be in the branch directory to continue."
			dk_echo "DKSCRIPT_DIR = $DKSCRIPT_DIR"
			dk_echo "${clr}"			
			dk_printVar DKBRANCH_DIR
			return $(false);
		fi
		
		dk_info "RELOCATING SCRIPT TO -> ${DIGITALKNOB_DIR}/$DKSCRIPT_FILE"
		cp "$DKSCRIPT_DIR"/"$DKSCRIPT_FILE" "${DIGITALKNOB_DIR}"/"$DKSCRIPT_FILE"
		exec "${DIGITALKNOB_DIR}/$DKSCRIPT_FILE" dk_resetAll wipe
		exit
	else	
		#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		#:wipe
		
		#do we need sudo rights?
		#do we need to kill any processes?
		#do we need to undk_install any apps?
		#do we need to remove any environment variables?
		
		cd "${DIGITALKNOB_DIR}" #|| dk_error "cd $${DIGITALKNOB_DIR} failed!"
		dk_echo
		dk_echo "DELETING ${DKBRANCH_DIR} . . . ."
		dk_call rm -r -f "${DKBRANCH_DIR}" #|| dk_error "dk_call rm -r -f ${DKBRANCH_DIR} failed"
		dk_echo "done."
		
		# wait for the folders to get deleted
		sleep 5

		if dk_pathExists "${DKBRANCH_DIR}"; then
			dk_error "Oh no, the BRANCH folder is still there! :( "
		fi
		
		dk_gitUpdate NO_CONFIRM
		
		# wait for build.sh to show up
		sleep 2
		
		if dk_pathExists "${DKBRANCH_DIR}"/"$DKSCRIPT_FILE"; then
			clear
			. "${DKBRANCH_DIR}"/"$DKSCRIPT_FILE" rm -r "${DIGITALKNOB_DIR}"/"$DKSCRIPT_FILE"
			exit
		else
			dk_error "Oh no, the git cloned build.sh still isn't here! :( "
		fi
	fi
}


##################################################################################
# dk_removeAll()
#
#
dk_removeAll() {
	dk_verbose "dk_removeAll(${*})"
	[ ${#} -gt 1 ] && dk_error "Too many parameters"
	
	if ! [ "${1}" = "wipe" ]; then	
		clear
		dk_echo
		dk_echo
		dk_echo "Do you want to remove the entire local repository . . . ?"
		dk_echo "This will delete DigitalKnob, Save any changes"
		dk_echo "you wish to commit or save beforehand."		
		dk_echo
		
		dk_confirm || return 0
		
		# first we need to relocate this file up one directory
		# make sure script is running from DKBRANCH_DIR
		if ! [ "$DKSCRIPT_DIR" = "${DKBRANCH_DIR}" ]; then
			dk_echo "${yellow}"				
			dk_echo "WARNING: this file isn't running from the branch directory"
			dk_echo "Is must be in the branch directory to continue."
			dk_echo "DKSCRIPT_DIR = $DKSCRIPT_DIR"
			dk_echo "${clr}"			
			dk_printVar DKBRANCH_DIR
			return 1;
		fi
		
		dk_info "RELOCATING SCRIPT TO -> ${DIGITALKNOB_DIR}/$DKSCRIPT_FILE"
		cp "$DKSCRIPT_DIR"/"$DKSCRIPT_FILE" "${DIGITALKNOB_DIR}"/"$DKSCRIPT_FILE"
		. "${DIGITALKNOB_DIR}/$DKSCRIPT_FILE" dk_removeAll wipe
		exit
	else	
		#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		#:wipe
		
		#do we need sudo rights?
		#do we need to kill any processes?
		#do we need to undk_install any apps?
		#do we need to remove any environment variables?
		
		cd "${DIGITALKNOB_DIR}" #|| dk_error "cd $${DIGITALKNOB_DIR} failed!"
		dk_echo
		dk_info "DELETING ${DKBRANCH_DIR} . . . ."
		rm -r -f "${DKBRANCH_DIR}"
		dk_info "done."
		
		# wait for the folders to get deleted
		sleep 3
		
		if dk_pathExists "${DKBRANCH_DIR}"; then
			dk_error "Oh no, the BRANCH folder is still there! :( "
		fi
	fi
}


##################################################################################
# dk_gitUpdate(NO_CONFIRM:optional)
#
#
dk_gitUpdate() {
	dk_verbose "dk_gitUpdate(${*})"
	[ ${#} -gt 1 ] && dk_error "Too many parameters"

	if ! [ "${1-}" = "NO_CONFIRM" ]; then
		dk_info "Git Update? Any local changes will be lost."
		dk_confirm || return 0
	fi

	if [ ! -d "${DKBRANCH_DIR}/.git" ]; then
		dk_call "$git_exe" clone https://github.com/aquawicket/DigitalKnob.git "${DKBRANCH_DIR}"
	fi
	dk_call cd "${DKBRANCH_DIR}" #|| dk_error "cd $${DKBRANCH_DIR} failed!"
	"$git_exe" pull --all
	dk_call "$git_exe" checkout -- .
	"$git_exe" checkout "$DKBRANCH"
	if [ "${?}" = "0" ]; then
		dk_info "$DKBRANCH branch selected"
	else
		dk_info "Remote has no $DKBRANCH branch. Creating..."
		dk_call "$git_exe" checkout -b "$DKBRANCH" main
		dk_call "$git_exe" push --set-upstream origin "$DKBRANCH"
	fi
	#dk_call ${sudo_exe} chmod +x "${DKBRANCH_DIR}"/build.sh
}


##################################################################################
# dk_gitCommit()
#
#
dk_gitCommit() {	
	dk_verbose "dk_gitCommit(${*})"
	[ ${#} -gt 0 ] && dk_error "Incorrect number of parameters"
	
	dk_info "Please enter some details about this commit, Then press ENTER."
	read message
	
	cd "${DKBRANCH_DIR}" #|| dk_error "cd \${DKBRANCH_DIR} failed!"
	
	STORE=$($git_exe config credential.helper)
	dk_printVar STORE
	if [ -z "$STORE" ]; then
		$git_exe config --global credential.helper store
		dk_echo
		dk_info "git credential.helper is now set to store"
		dk_echo
	fi
	
	USER_EMAIL=$($git_exe config --global user.email)
	if [ -z "$USER_EMAIL" ]; then
		dk_echo
		dk_info "please enter an email address"
		read input
		$git_exe config --global user.email "${input}"
		dk_echo
		dk_info "git user.email '${input}' saved"
		dk_echo
	fi

	USER_NAME=$($git_exe config --global user.name)
	if [ -z "USER_NAME" ]; then
		dk_echo
		dk_info "please enter a username"
		read input
		$git_exe config --global user.name "${input}"
		dk_echo
		dk_info "git user.name '${input}' saved"
		dk_echo
	fi
	
	if [ -z "$message" ]; then
		message="git commit"
	fi
	
	dk_echo
	dk_info "git commit \"${message}\""
	dk_confirm || return 0
	
	#dk_call "$git_exe" commit -a -m "${message}"
	"$git_exe" commit -a -m "${message}"
    dk_call "$git_exe" push
}


##################################################################################
# dk_enterManually()
#
#
dk_enterManually() {
	dk_verbose "dk_enterManually(${*})"
	[ ${#} -gt 0 ] && dk_error "Incorrect number of parameters"
	
	dk_info "Please type the name of the library, tool or app to build. Then press enter."
	read input
	
	Target_App="_${input}_"
	
	#Search DigitalKnob for the matching entry containing a DKINSTALL.cmake file  
	if test -f "${DKIMPORTS_DIR}"/"${input}"/DKINSTALL.cmake; then
		Target_App_Dir=${DKIMPORTS_DIR}/${input}
	fi
	if test -f "${DKCPP_PLUGINS_DIR}"/"${input}"/DKINSTALL.cmake; then
		Target_App_Dir=${DKCPP_PLUGINS_DIR}/${input}
	fi
	if test -f "${DKCPP_APPS_DIR}"/"${input}"/DKINSTALL.cmake; then
		Target_App_Dir=${DKCPP_APPS_DIR}/${input}
		return $(true)
	fi
	dk_printVar Target_App_Dir
	
	if [ ! -d "${DKCPP_APPS_DIR}"/"${Target_App}" ]; then
		mkdir -p "${DKCPP_APPS_DIR}"/"${Target_App}";
	fi
	
	# create apps/<Target_App>/DKINSTALL.cmake 
	echo "dk_depend(${input})" > "${DKCPP_APPS_DIR}"/"${Target_App}"/DKINSTALL.cmake
	
	# create apps/<Target_App>/main.cpp
	echo "int main(int argc, char** argv) { return 0; }" > "${DKCPP_APPS_DIR}"/"${Target_App}"/main.cpp
}


##################################################################################
# dk_createCache()
#
#
dk_createCache() {
	dk_verbose "dk_createCache(${*})"
	[ ${#} -gt 0 ] && dk_error "Incorrect number of parameters"
	
	dk_echo "creating DKBuilder.cache..."
	
	# write variable values line by line
	echo "${Target_App}">"${DKCACHE_DIR}/DKBuilder.cache"
	echo "${Target_Tuple}">>"${DKCACHE_DIR}/DKBuilder.cache"
	echo "${Target_Type}">>"${DKCACHE_DIR}/DKBuilder.cache"
	#echo "$DKENV">>"${DKCACHE_DIR}/DKBuilder.cache"
}


##################################################################################
# dk_readCache()
#
#
dk_readCache() {
	dk_verbose "dk_readCache(${*})"
	[ ${#} -gt 0 ] && dk_error "Incorrect number of parameters"
	
	if ! dk_pathExists "${DKCACHE_DIR}"/DKBuilder.cache; then
		return 0
	fi
	Target_App_Cache=
	Target_Tuple_Cache=
	Target_Type_Cache=
	
	dk_echo "reading DKBuilder.cache..."
	count=0
	while read p; do
		if [ "${count}" = "0" ]; then 
			Target_App_Cache=$(echo "$p" | tr -d '\r')
			#dk_printVar Target_App_Cache
		fi
		if [ "${count}" = "1" ]; then
			Target_Tuple_Cache=$(echo "$p" | tr -d '\r')
			#dk_printVar Target_Tuple_Cache 
		fi
		if [ "${count}" = "2" ]; then
			Target_Type_Cache=$(echo "$p" | tr -d '\r')
			#dk_printVar Target_Type_Cache
		fi
		#if [ "${count}" = "3" ]; then
		#	_DKENV_=$(echo $p | tr -d '\r')
		#	#dk_printVar _DKENV_
		#fi
		count=$((count + 1))
	done < "${DKCACHE_DIR}"/DKBuilder.cache
}


##################################################################################
# dk_removeCarrageReturns(input)
#
#
dk_removeCarrageReturns() {
	dk_verbose "dk_removeCarrageReturns(${*})"
	[ ${#} -gt 0 ] && dk_error "Incorrect number of parameters"

	in=${1}
	out=$(echo "$in" | tr -d '\r')
	# carrage returns are removed from <out>
}


##################################################################################
# dk_saveArgs(args..)
#
# reference: https://www.etalabs.net/sh_tricks.html
#
# usage:
#   set -- One Two Three Four
#   myarrayA=$(dk_saveArgs "${@}")
#   eval "set -- $myarrayA"
#	echo "${1} ${2} ${3} ${4}"
#
dk_saveArgs() {
	dk_verbose "dk_saveArgs(${*})"

	for i do 
		printf %s\\n "$i" | sed "s/'/'\\\\''/g;1s/^/'/;\$s/\$/' \\\\/"
	done
	echo " "
}

##################################################################################
# try(args..)
#
try() { 
	#${@} >/dev/null
	${@} 2>&1
}


##################################################################################
# dk_Host_Tuple(input)
#
#	Get host variable such as 'Host_Os', 'Host_Arch', 'Host_Env', 'Host_Vendor
#	and build the accoring Host_Tuple variable.  I.E. Windows_X86_64_Clang
#
dk_Host_Tuple() {
	dk_verbose "dk_Host_Tuple(${*})"
	[ ${#} -gt 0 ] && dk_error "Incorrect number of parameters"
	
	# currently, our host Target_Tuple consists of only 2 variable needed
	# Host_Tuple=${Host_Os}_${Host_Arch}
	
	# https://unix.stackexchange.com/questions/225350/how-to-find-out-tuplet-without-gcc
	# https://en.wikipedia.org/wiki/Uname
	
	# g++ -dumpmachine
	# gcc -print-multiarch
	# clang -print-effective-Target_Tuple
	# clang -print-target-Target_Tuple
	# clang++ -print-effective-Target_Tuple
	# clang++ -print-target-Target_Tuple

	#[ -e /proc/cpuinfo ] && dk_debug "\$(tr -d '\0' </proc/cpuinfo) = $(tr -d '\0' </proc/cpuinfo)"
	#[ -e /proc/device-tree/model ] && dk_debug "\$(tr -d '\0' </proc/device-tree/model) = $(tr -d '\0' </proc/device-tree/model)"

	if dk_commandExists clang; then  
		CLANG_TUPLE=$(try clang -dumpmachine) && dk_printVar CLANG_TUPLE	

		remainder="$CLANG_TUPLE"
		CLANG_ARCH="${remainder%%-*}"; remainder="${remainder#*-}"
		dk_printVar CLANG_ARCH
		CLANG_VENDOR="${remainder%%-*}"; remainder="${remainder#*-}"
		dk_printVar CLANG_VENDOR
		CLANG_OS="${remainder%%-*}"; remainder="${remainder#*-}"
		dk_printVar CLANG_OS
		CLANG_ENV="${remainder%%-*}"; remainder="${remainder#*-}"
		dk_printVar CLANG_ENV

		[ -z ${Host_Tuple-} ] && Host_Tuple=${CLANG_TUPLE} && dk_printVar Host_Tuple
		[ -z ${Host_Arch-} ] && Host_Arch=${CLANG_ARCH} && dk_printVar Host_Arch
		[ -z ${Host_Vendor-} ] && Host_Vendor=${CLANG_VENDOR} && dk_printVar Host_Vendor
		[ -z ${Host_Os-} ] && Host_Os=${CLANG_OS} && dk_printVar Host_Os
		[ -z ${Host_Env-} ] && Host_Env=${CLANG_ENV} && dk_printVar Host_Env
	fi
	if dk_commandExists gcc; then
		GCC_TUPLE=$(try gcc -dumpmachine) && dk_printVar GCC_TUPLE

		remainder="${GCC_TUPLE}"
		GCC_ARCH="${remainder%%-*}"; remainder="${remainder#*-}"
		dk_printVar GCC_ARCH
		GCC_VENDOR="${remainder%%-*}"; remainder="${remainder#*-}"
		dk_printVar GCC_VENDOR
		GCC_OS="${remainder%%-*}"; remainder="${remainder#*-}"
		dk_printVar GCC_OS
		GCC_ENV="${remainder%%-*}"; remainder="${remainder#*-}"
		dk_printVar GCC_ENV

		[ -z ${Host_Tuple-} ] && Host_Tuple=${GCC_TUPLE} && dk_printVar Host_Tuple
		[ -z ${Host_Arch-} ] && Host_Arch=${GCC_ARCH} && dk_printVar Host_Arch
		[ -z ${Host_Vendor-} ] && Host_Vendor=${GCC_VENDOR} && dk_printVar Host_Vendor
		[ -z ${Host_Os-} ] && Host_Os=${GCC_OS} && dk_printVar Host_Os
		[ -z ${Host_Env-} ] && Host_Env=${GCC_ENV} && dk_printVar Host_Env
	fi
	if dk_commandExists bash; then
		BASH_TUPLE=$(bash -c "echo \${MACHTYPE}")
		dk_printVar BASH_TUPLE

		remainder="${BASH_TUPLE}"
		BASH_ARCH="${remainder%%-*}"; remainder="${remainder#*-}"
		dk_printVar BASH_ARCH
		BASH_VENDOR="${remainder%%-*}"; remainder="${remainder#*-}"
		dk_printVar BASH_VENDOR
		BASH_OS="${remainder%%-*}"; remainder="${remainder#*-}"
		dk_printVar BASH_OS
		BASH_ENV="${remainder%%-*}"; remainder="${remainder#*-}"
		dk_printVar BASH_ENV

		[ -z ${Host_Tuple-} ] && Host_Tuple=$BASH_TUPLE && dk_printVar Host_Tuple
		[ -z ${Host_Arch-} ] && Host_Arch=$BASH_ARCH && dk_printVar Host_Arch
		[ -z ${Host_Vendor-} ] && Host_Vendor=$BASH_VENDOR && dk_printVar Host_Vendor
		[ -z ${Host_Os-} ] && Host_Os=$BASH_OS && dk_printVar Host_Os
		[ -z ${Host_Env-} ] && Host_Env=${BASH_ENV-} && dk_printVar Host_Env
	fi	
	
	if dk_commandExists uname; then
		
		UNAME="$(uname)"
		dk_printVar UNAME	
		UNAME_a="$(try uname -a)" && dk_printVar UNAME_a
		UNAME_s="$(try uname -s)" && dk_printVar UNAME_s
		UNAME_n="$(try uname -n)" && dk_printVar UNAME_n	
		UNAME_r="$(try uname -r)" && dk_printVar UNAME_r
		UNAME_v="$(try uname -v)" && dk_printVar UNAME_v
		UNAME_m="$(try uname -m)" && dk_printVar UNAME_m
		UNAME_p="$(try uname -p)" && dk_printVar UNAME_p
		UNAME_i="$(try uname -i)" && dk_printVar UNAME_i
		UNAME_o="$(try uname -o)" && dk_printVar UNAME_o
		
		UNAME_ARCH="$(try uname -m)"
		dk_toLower UNAME_ARCH
		UNAME_SUBARCH=""
		
		if [ "$(try uname -s)" = "Darwin" ]; then
			UNAME_VENDOR="-apple"
		else
			UNAME_VENDOR="-unknown"
		fi


		if [ "$(try uname -s)" = "darwin" ]; then
			UNAME_OS="-$(try uname -s)$(try uname -r)"
		else
			UNAME_OS="-$(try uname -s)" && dk_toLower UNAME_OS
		fi

		if dk_contains "$(try uname -o)" "GNU"; then
			UNAME_ENV="-gnu"
		elif dk_contains "$(try uname -o)" "Android"; then
			UNAME_ENV="-android" #FIXME: need abi number I.E. -android24
		else
			UNAME_ENV=""
		fi

		#UNAME_ObjectFormat=""

		UNAME_TUPLE=${UNAME_ARCH}${UNAME_SUBARCH}${UNAME_VENDOR}${UNAME_OS}${UNAME_ENV}
		dk_printVar UNAME_TUPLE

		[ -z $Host_Tuple ] && Host_Tuple=$UNAME_TUPLE && dk_printVar Host_Tuple
		[ -z $Host_Arch ] && Host_Arch=$UNAME_ARCH && dk_printVar Host_Arch
		[ -z $Host_Vendor ] && Host_Vendor=$UNAME_VENDOR && dk_printVar Host_Vendor
		[ -z $Host_Os ] && Host_Os=$UNAME_OS && dk_printVar Host_Os
		[ -z $Host_Env ] && Host_Env=$UNAME_ENV && dk_printVar Host_Env
	fi
	


	### Get the Host_Os ###
	# https://llvm.org/doxygen/Triple_8h_source.html
	if dk_contains "${UNAME_a}" "Android"; then			# Android
		Host_Os="Android"
	elif dk_contains "${UNAME_a}" "Darwin"; then		# Mac
		Host_Os="Mac"
	elif dk_contains "${UNAME_a}" "raspberrypi"; then	# Raspberry
		Host_Os="Raspberry"
 	elif dk_contains "${UNAME_a}" "Linux"; then			# Linux
		Host_Os="Linux"
	elif dk_contains "${UNAME_a}" "Msys"; then			# Windows
		Host_Os="Windows"
	else
		dk_error "Unsupported Host_Os: ${UNAME_a}"
	fi
	[ -z "$Host_Os" ] && dk_error "Failed to get Host_Os variable"
	dk_printVar Host_Os


	### Get the Host_Arch ###
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
	
	if [ "$UNAME_m" = "arm" ]; then
		Host_Arch="arm"
	elif [ "$UNAME_m" = "armeb" ]; then
		Host_Arch="arm"
	elif [ "$UNAME_m" = "armv7l" ]; then
		Host_Arch="arm"
	elif [ "$UNAME_m" = "aarch64" ]; then
		Host_Arch="arm64"
	elif [ "$UNAME_m" = "aarch64_32" ]; then
		Host_Arch="arm64"
	elif [ "$UNAME_m" = "aarch64_be" ]; then
		Host_Arch="arm64"
	elif [ "$UNAME_m" = "arm64" ]; then
		Host_Arch="arm64"
	elif [ "$UNAME_m" = "arm64_32" ]; then
		Host_Arch="arm64"
	elif [ "$UNAME_m" = "armv8b" ]; then
		Host_Arch="arm64"
	elif [ "$UNAME_m" = "armv8l" ]; then
		Host_Arch="arm64"
	elif [ "$UNAME_m" = "x86" ]; then
		Host_Arch="X86"
	elif [ "$UNAME_m" = "i386" ]; then
		Host_Arch="X86"
	elif [ "$UNAME_m" = "i686" ]; then
		Host_Arch="X86"
	elif [ "$UNAME_m" = "x86_64" ]; then
		Host_Arch="X86_64"
	elif [ "$UNAME_m" = "x86-64" ]; then
		Host_Arch="X86_64"
	elif [ "$UNAME_m" = "ia64" ]; then
		Host_Arch="X86_64"
	else
		dk_error "Unsupported Host_Arch: ${UNAME_m}"
	fi

	Host_Tuple=${Host_Os}_${Host_Arch}
	dk_printVar Host_Tuple
}


##################################################################################
# DK_TRY_CATCH(function, args)
#
#	reference: https://stackoverflow.com/a/11092989/688352
#
DK_TRY_CATCH() {
	# Don't pipe the subshell into anything or we won't be able to see its exit status
	set +e; ( set -e
		"${@}" 
	); err_status=${?}; set -e

	if [ "$err_status" -ne "0" ]; then
		echo "ERROR_STATUS: $err_status"
		dk_pause
		dk_error "test"
	fi
}


##################################################################################
# dk_getShellType()
#
#
dk_getShellType() {
	dk_verbose "dk_getShellType(${*})"
	[ ${#} -gt 0 ] && dk_error "Incorrect number of parameters"
	
	echo "SHELL = ${SHELL}"
	echo "BASH_SOURCE = $BASH_SOURCE"
	echo "BASH_LINENO = $BASH_LINENO"

	[ -e "/proc" ] || dk_warning "/proc does not exist" && return 0 
	PID_EXE=$(readlink /proc/$$/exe);
	SHELL_TYPE=${PID_EXE##*/};           
	echo "SHELL_TYPE   = $SHELL_TYPE"
}




#set -x

#echo "\$$ = $$"								# Process ID of the current shell instance.
#echo "PID = $(ps -p $$ -o pid=)"							
#echo "PPID = $(ps -p $$ -o ppid=)"				
#echo "SH_PID = $(sh -c 'ps -p $$ -o pid=')"		
#echo "SH_PPID = $(sh -c 'ps -p $$ -o ppid=')"	
#echo "EXE = $(readlink /proc/$$/exe)"			# exe path of the current shell instance. 
#PID=$$;                             echo "PID          = $PID"
#PID_EXE=$(readlink /proc/$PID/exe); echo "PID_EXE      = $PID_EXE"
#SHELL_TYPE=${PID_EXE##*/};          echo "SHELL_TYPE   = $SHELL_TYPE"



echo "* = ${*}"
#[ "${*}" = "" ] || DK_TRY_CATCH "${@}"
#DK_TRY_CATCH dk_buildMain "${@}"
[ "${*}" = "" ] || "${@}"
dk_buildMain "${@}"





