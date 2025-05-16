#!/usr/bin/env sh
############################## DigitalKnob DKBash ################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################


##################################################################################
# dk_generate()
#
#
dk_generate() {
	dk_debugFunc 0

	dk_call dk_echo
	dk_call dk_echo "##################################################################"
	dk_call dk_echo "     Generating ${Target_App-} - ${Target_Tuple-} - ${Target_Type-} - ${Target_Level-}"
	dk_call dk_echo "##################################################################"
	dk_call dk_echo

	dk_call dk_validate DKCPP_APPS_DIR "dk_call dk_DKBRANCH_DIR"
	TARGET_PATH="${DKCPP_APPS_DIR}/${Target_App}"
	#dk_call dk_printVar TARGET_PATH
	dk_call dk_mkdir "${TARGET_PATH}/${Target_Tuple,,}"
	dk_call dk_chdir "${TARGET_PATH}/${Target_Tuple,,}"
	dk_call dk_assertPath DKCMAKE_DIR
	#dk_call dk_assertPath ${DKCMAKE_DIR}
	CMAKE_SOURCE_DIR="${DKCMAKE_DIR}"
	dk_call dk_assertPath CMAKE_SOURCE_DIR
	#dk_call dk_assertPath ${CMAKE_SOURCE_DIR}
	#dk_call dk_printVar CMAKE_SOURCE_DIR
	#$(dk_call dk_pathExists "${CMAKE_SOURCE_DIR}") || dk_call dk_error "CMAKE_SOURCE_DIR:${CMAKE_SOURCE_DIR} does not exist"
	#dk_call dk_printVar CMAKE_SOURCE_DIR
	CMAKE_TARGET_PATH="${TARGET_PATH}"
	#dk_call dk_printVar CMAKE_TARGET_PATH
	
	###### BUILD CMAKE_ARGS ARRAY ######
	Target_Level="RebuildAll"
	DKLINK="Static"
	
	#declare -a CMAKE_ARGS
	#set --											#clear the positional parameters
	CMAKE_ARGS=()
	dk_call dk_arrayPush CMAKE_ARGS "-DDKCMAKE_FUNCTIONS_DIR_=${DKCMAKE_FUNCTIONS_DIR_}"
	if [ "${Target_Type}" = "Debug" ]; then
		#set -- "-DDEBUG=ON" )
		#set -- "${@}" "-DDEBUG=ON"
		dk_call dk_arrayPush CMAKE_ARGS "-DDEBUG=ON" "-DRELEASE=OFF"
	elif [ "${Target_Type}" = "Release" ]; then
		dk_call dk_arrayPush CMAKE_ARGS "-DDEBUG=OFF" "-DRELEASE=ON"
	elif [ "${Target_Type}" = "All" ]; then
		dk_call dk_arrayPush CMAKE_ARGS "-DDEBUG=ON" "-DRELEASE=ON"
	else
		dk_call dk_error "Target_Type:${Target_Type} is invalid"
	fi
	
	if [ "${Target_Level}" = "Build" ]; then
		dk_call dk_arrayPush CMAKE_ARGS "-DBUILD=ON"
	elif [ "${Target_Level}" = "Rebuild" ]; then
		dk_call dk_arrayPush CMAKE_ARGS "-DREBUILD=ON"
	elif [ "${Target_Level}" = "RebuildAll" ]; then
		dk_call dk_arrayPush CMAKE_ARGS "-DREBUILDALL=ON"
	else
		dk_call dk_error "Target_Level:${Target_Level} is invalid"
	fi
	
	if [ "${DKLINK}" = "Static" ]; then
		dk_call dk_arrayPush CMAKE_ARGS "-DSTATIC=ON"
	fi
	if [ "${DKLINK}" = "Shared" ]; then
		dk_call dk_arrayPush CMAKE_ARGS "-DSHARED=ON"
	fi
	
	CMAKE_BINARY_DIR="${CMAKE_TARGET_PATH}/${Target_Tuple,,}/${Target_Type}"
	dk_call dk_mkdir "${CMAKE_BINARY_DIR}"
	#dk_call dk_printVar CMAKE_BINARY_DIR
	
	if ! dk_call dk_defined WSLENV; then
	if ! dk_call dk_defined CYGWIN; then
		dk_call dk_arrayPush CMAKE_ARGS "-S" "${CMAKE_SOURCE_DIR}"
	fi
	fi
	dk_call dk_arrayPush CMAKE_ARGS "-B" "${CMAKE_BINARY_DIR}"
	
	############ CMake Options ############
    dk_call dk_arrayPush CMAKE_ARGS "-DCMAKE_VERBOSE_MAKEFILE=1"
	dk_call dk_arrayPush CMAKE_ARGS "-DCMAKE_COLOR_DIAGNOSTICS=ON"
	#dk_call dk_arrayPush CMAKE_ARGS "-Wdev"
	#dk_call dk_arrayPush CMAKE_ARGS "-Werror=dev"
	#dk_call dk_arrayPush CMAKE_ARGS "-Wdeprecated"
	#dk_call dk_arrayPush CMAKE_ARGS "-Werror=deprecated"
	#dk_call dk_arrayPush CMAKE_ARGS "--graphviz=graphviz.txt"
	#dk_call dk_arrayPush CMAKE_ARGS "--system-information system_information.txt"
	#dk_call dk_arrayPush CMAKE_ARGS "--debug-trycompile"
	#dk_call dk_arrayPush CMAKE_ARGS "--debug-output"
	#dk_call dk_arrayPush CMAKE_ARGS "--trace"
	#dk_call dk_arrayPush CMAKE_ARGS "--trace-expand"
	#dk_call dk_arrayPush CMAKE_ARGS "--warn-uninitialized"
	#dk_call dk_arrayPush CMAKE_ARGS "--warn-unused-vars"
	#dk_call dk_arrayPush CMAKE_ARGS "--check-system-vars"
	
	# NOTE; ${var,,} converts the var value to lowercase. use ^^ for uppercase
	if [ "${Target_Tuple,,}" = "cosmo" ]; then
		dk_call dk_arrayPush CMAKE_ARGS "-G" "Unix Makefiles" 
	elif [ "${Target_Tuple,,}" = "cygwin" ]; then
		dk_call dk_arrayPush CMAKE_ARGS "-G" "Unix Makefiles" 
	elif [ "${Target_Tuple,,}" = "Android_Arm32_Clang" ]; then
		dk_call dk_arrayPush CMAKE_ARGS "-G" "Unix Makefiles"
	elif [ "${Target_Tuple,,}" = "Android_Arm64_Clang" ]; then
		dk_call dk_arrayPush CMAKE_ARGS "-G" "Unix Makefiles"
	elif [ "${Target_Tuple,,}" = "Android_X86_Clang" ]; then
		dk_call dk_arrayPush CMAKE_ARGS "-G" "Unix Makefiles"
	elif [ "${Target_Tuple,,}" = "Android_X86_64_Clang" ]; then
		dk_call dk_arrayPush CMAKE_ARGS "-G" "Unix Makefiles"
	elif [ "${Target_Tuple,,}" = "Emscripten_X86_Clang" ]; then
		dk_call dk_arrayPush CMAKE_ARGS "-G" "Unix Makefiles" 
	elif [ "${Target_Tuple,,}" = "Ios_Arm32_Clang" ]; then
		dk_call dk_arrayPush CMAKE_ARGS "-G" "Xcode"
	elif [ "${Target_Tuple,,}" = "Ios_Arm64_Clang" ]; then
		dk_call dk_arrayPush CMAKE_ARGS "-G" "Xcode"
	elif [ "${Target_Tuple,,}" = "Iossim_X86_Clang" ]; then
		dk_call dk_arrayPush CMAKE_ARGS "-G" "Xcode"
	elif [ "${Target_Tuple,,}" = "Iossim_X86_Clang" ]; then
		dk_call dk_arrayPush CMAKE_ARGS "-G" "Xcode"
	elif [ "${Target_Tuple,,}" = "Linux_X86_Gcc" ]; then
		dk_call dk_arrayPush CMAKE_ARGS "-G" "Unix Makefiles" 
	elif [ "${Target_Tuple,,}" = "Linux_X86_64_Clang" ]; then
		dk_call dk_arrayPush CMAKE_ARGS "-G" "Unix Makefiles" 
	elif [ "${Target_Tuple,,}" = "Linux_X86_64_Gcc" ]; then
		dk_call dk_arrayPush CMAKE_ARGS "-G" "Unix Makefiles" 
	elif [ "${Target_Tuple,,}" = "Mac_X86_Clang" ]; then
		dk_call dk_arrayPush CMAKE_ARGS "-G" "Xcode"
	elif [ "${Target_Tuple,,}" = "Mac_X86_64_Clang" ]; then
		dk_call dk_arrayPush CMAKE_ARGS "-G" "Xcode"
	elif [ "${Target_Tuple,,}" = "Raspberry_Arm32_Clang" ]; then
		dk_call dk_arrayPush CMAKE_ARGS "-G" "Unix Makefiles" 
	elif [ "${Target_Tuple,,}" = "Raspberry_Arm64_Clang" ]; then
		dk_call dk_arrayPush CMAKE_ARGS "-G" "Unix Makefiles"
	elif [ "${Target_Tuple,,}" = "Win_Arm64_Clang" ]; then
		dk_call dk_arrayPush CMAKE_ARGS "-G" "MinGW Makefiles" "-DMSYSTEM=CLANGARM64"
		dk_call dk_validate DK3RDPARTY_DIR "dk_DK3RDPARTY_DIR"
		export PATH=${DK3RDPARTY_DIR}/msys2-x86_64-20231026/clangarm64/bin:${PATH}
	elif [ "${Target_Tuple,,}" = "Win_X86_Clang" ]; then
		dk_call dk_arrayPush CMAKE_ARGS "-G" "MinGW Makefiles" "-DMSYSTEM=CLANG32"
		dk_call dk_validate DK3RDPARTY_DIR "dk_DK3RDPARTY_DIR"
		export PATH=${DK3RDPARTY_DIR}/msys2-x86_64-20231026/clang32/bin:${PATH}
	elif [ "${Target_Tuple,,}" = "Win_X86_Gcc" ]; then
		dk_call dk_arrayPush CMAKE_ARGS "-G" "MinGW Makefiles" "-DMSYSTEM=MINGW32"
		dk_call dk_validate DK3RDPARTY_DIR "dk_DK3RDPARTY_DIR"
		export PATH=${DK3RDPARTY_DIR}/msys2-x86_64-20231026/mingw32/bin:${PATH}
	elif [ "${Target_Tuple,,}" = "Win_X86_64_Clang" ]; then
		dk_call dk_arrayPush CMAKE_ARGS "-G" "MinGW Makefiles" "-DMSYSTEM=CLANG64"
		dk_call dk_validate DK3RDPARTY_DIR "dk_DK3RDPARTY_DIR"
		export PATH=${DK3RDPARTY_DIR}/msys2-x86_64-20231026/clang64/bin:${PATH}
	elif [ "${Target_Tuple,,}" = "Win_X86_64_Gcc" ]; then
		dk_call dk_arrayPush CMAKE_ARGS "-G" "MinGW Makefiles" "-DMSYSTEM=MINGW64"
		dk_call dk_validate DK3RDPARTY_DIR "dk_DK3RDPARTY_DIR"
		export PATH=${DK3RDPARTY_DIR}/msys2-x86_64-20231026/mingw64/bin:${PATH}
	elif [ "${Target_Tuple,,}" = "Win_X86_64_Ucrt" ]; then
		dk_call dk_arrayPush CMAKE_ARGS "-G" "MinGW Makefiles" "-DMSYSTEM=UCRT64"
		dk_call dk_validate DK3RDPARTY_DIR "dk_DK3RDPARTY_DIR"
		export PATH=${DK3RDPARTY_DIR}/msys2-x86_64-20231026/ucrt64/bin:${PATH}
	elif [ "${Target_Tuple,,}" = "Win_X86_64_Msvc" ]; then
		dk_call dk_arrayPush CMAKE_ARGS "-G" "Visual Studio 17 2022"
	else
		dk_call dk_fatal "Could no determine Target_Tuple:${Target_Tuple,,}"
	fi

	###### CMAKE_TOOLCHAIN_FILE ######
#	TOOLCHAIN="${DKCMAKE_DIR}/toolchains/${Target_Tuple,,}_toolchain.cmake"
#	dk_call dk_echo "TOOLCHAIN = ${TOOLCHAIN}"
#	if dk_call dk_pathExists "${TOOLCHAIN}"; then
#		dk_call dk_arrayPush CMAKE_ARGS "-DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN}"
#	fi
	
	###### WSL CMake Fix ######
	if dk_call dk_defined WSLENV; then 
		cd "${DKCMAKE_DIR}"
		dk_call dk_arrayPush CMAKE_ARGS "."
	fi
	
	###### Cygwin CMake Fix ######
	if dk_call dk_defined CYGWIN; then 
		cd "${DKCMAKE_DIR}"
		dk_call dk_arrayPush CMAKE_ARGS "."
	fi
	
	###### Clear CMake Cache ######
	dk_call dk_clearCmakeCache "${CMAKE_BINARY_DIR}"
	
	###### CMake Configure ######
	dk_call dk_installCmake
	#dk_call dk_validate DKIMPORTS_DIR "dk_DKIMPORTS_DIR"
	#dk_call ${DKIMPORTS_DIR}/cmake/DKINSTALL.sh
	
	dk_call dk_echo
	dk_call dk_echo "****** CMAKE COMMAND ******"
	#dk_call dk_nativePath ${CMAKE_EXE} NATIVE_CMAKE_EXE
	dk_call dk_printVar CMAKE_ARGS
	dk_call ${CMAKE_EXE} "${CMAKE_ARGS[@]}" && dk_call dk_echo "CMake Generation Successful" || dk_call dk_error "CMake Generation Failed"
	dk_call dk_echo
}








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_generate
}
