#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

##################################################################################
# dk_generate()
#
#
dk_generate() {
	dk_debugFunc 0

	dk_call dk_echo
	dk_call dk_echo "##################################################################"
	dk_call dk_echo "     Generating ${target_app-} - ${target_triple-} - ${target_type-} - ${target_level-}"
	dk_call dk_echo "##################################################################"
	dk_call dk_echo

	dk_call dk_validate DKCPP_APPS_DIR "dk_call dk_DKBRANCH_DIR"
	TARGET_PATH="${DKCPP_APPS_DIR}/${target_app}"
	#dk_call dk_printVar TARGET_PATH
	dk_call dk_makeDirectory "${TARGET_PATH}/${target_triple,,}"
	dk_call dk_chdir "${TARGET_PATH}/${target_triple,,}"
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
	target_level="RebuildAll"
	DKLINK="Static"
	
	#declare -a CMAKE_ARGS
	#set --											#clear the positional parameters
	CMAKE_ARGS=()
	dk_call dk_arrayPush CMAKE_ARGS "-DDKCMAKE_FUNCTIONS_DIR_=${DKCMAKE_FUNCTIONS_DIR_}"
	if [ "${target_type}" = "Debug" ]; then
		#set -- "-DDEBUG=ON" )
		#set -- "${@}" "-DDEBUG=ON"
		dk_call dk_arrayPush CMAKE_ARGS "-DDEBUG=ON" "-DRELEASE=OFF"
	elif [ "${target_type}" = "Release" ]; then
		dk_call dk_arrayPush CMAKE_ARGS "-DDEBUG=OFF" "-DRELEASE=ON"
	elif [ "${target_type}" = "All" ]; then
		dk_call dk_arrayPush CMAKE_ARGS "-DDEBUG=ON" "-DRELEASE=ON"
	else
		dk_call dk_error "target_type:${target_type} is invalid"
	fi
	
	if [ "${target_level}" = "Build" ]; then
		dk_call dk_arrayPush CMAKE_ARGS "-DBUILD=ON"
	elif [ "${target_level}" = "Rebuild" ]; then
		dk_call dk_arrayPush CMAKE_ARGS "-DREBUILD=ON"
	elif [ "${target_level}" = "RebuildAll" ]; then
		dk_call dk_arrayPush CMAKE_ARGS "-DREBUILDALL=ON"
	else
		dk_call dk_error "target_level:${target_level} is invalid"
	fi
	
	if [ "${DKLINK}" = "Static" ]; then
		dk_call dk_arrayPush CMAKE_ARGS "-DSTATIC=ON"
	fi
	if [ "${DKLINK}" = "Shared" ]; then
		dk_call dk_arrayPush CMAKE_ARGS "-DSHARED=ON"
	fi
	
	CMAKE_BINARY_DIR="${CMAKE_TARGET_PATH}/${target_triple,,}/${target_type}"
	dk_call dk_makeDirectory "${CMAKE_BINARY_DIR}"
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
	if [ "${target_triple,,}" = "cosmo" ]; then
		dk_call dk_arrayPush CMAKE_ARGS "-G" "Unix Makefiles" 
	elif [ "${target_triple,,}" = "cygwin" ]; then
		dk_call dk_arrayPush CMAKE_ARGS "-G" "Unix Makefiles" 
	elif [ "${target_triple,,}" = "android_arm32_clang" ]; then
		dk_call dk_arrayPush CMAKE_ARGS "-G" "Unix Makefiles"
	elif [ "${target_triple,,}" = "android_arm64_clang" ]; then
		dk_call dk_arrayPush CMAKE_ARGS "-G" "Unix Makefiles"
	elif [ "${target_triple,,}" = "android_x86_clang" ]; then
		dk_call dk_arrayPush CMAKE_ARGS "-G" "Unix Makefiles"
	elif [ "${target_triple,,}" = "android_x86_64_clang" ]; then
		dk_call dk_arrayPush CMAKE_ARGS "-G" "Unix Makefiles"
	elif [ "${target_triple,,}" = "emscripten_x86_clang" ]; then
		dk_call dk_arrayPush CMAKE_ARGS "-G" "Unix Makefiles" 
	elif [ "${target_triple,,}" = "ios_arm32_clang" ]; then
		dk_call dk_arrayPush CMAKE_ARGS "-G" "Xcode"
	elif [ "${target_triple,,}" = "ios_arm64_clang" ]; then
		dk_call dk_arrayPush CMAKE_ARGS "-G" "Xcode"
	elif [ "${target_triple,,}" = "iossim_x86_clang" ]; then
		dk_call dk_arrayPush CMAKE_ARGS "-G" "Xcode"
	elif [ "${target_triple,,}" = "iossim_x86_64_clang" ]; then
		dk_call dk_arrayPush CMAKE_ARGS "-G" "Xcode"
	elif [ "${target_triple,,}" = "linux_x86_gcc" ]; then
		dk_call dk_arrayPush CMAKE_ARGS "-G" "Unix Makefiles" 
	elif [ "${target_triple,,}" = "linux_x86_64_clang" ]; then
		dk_call dk_arrayPush CMAKE_ARGS "-G" "Unix Makefiles" 
	elif [ "${target_triple,,}" = "linux_x86_64_gcc" ]; then
		dk_call dk_arrayPush CMAKE_ARGS "-G" "Unix Makefiles" 
	elif [ "${target_triple,,}" = "mac_x86_clang" ]; then
		dk_call dk_arrayPush CMAKE_ARGS "-G" "Xcode"
	elif [ "${target_triple,,}" = "mac_x86_64_clang" ]; then
		dk_call dk_arrayPush CMAKE_ARGS "-G" "Xcode"
	elif [ "${target_triple,,}" = "raspberry_arm32_clang" ]; then
		dk_call dk_arrayPush CMAKE_ARGS "-G" "Unix Makefiles" 
	elif [ "${target_triple,,}" = "raspberry_arm64_clang" ]; then
		dk_call dk_arrayPush CMAKE_ARGS "-G" "Unix Makefiles"
	elif [ "${target_triple,,}" = "win_arm64_clang" ]; then
		dk_call dk_arrayPush CMAKE_ARGS "-G" "MinGW Makefiles" "-DMSYSTEM=CLANGARM64"
		dk_call dk_validate DK3RDPARTY_DIR "dk_DK3RDPARTY_DIR"
		export PATH=${DK3RDPARTY_DIR}/msys2-x86_64-20231026/clangarm64/bin:${PATH}
	elif [ "${target_triple,,}" = "win_x86_clang" ]; then
		dk_call dk_arrayPush CMAKE_ARGS "-G" "MinGW Makefiles" "-DMSYSTEM=CLANG32"
		dk_call dk_validate DK3RDPARTY_DIR "dk_DK3RDPARTY_DIR"
		export PATH=${DK3RDPARTY_DIR}/msys2-x86_64-20231026/clang32/bin:${PATH}
	elif [ "${target_triple,,}" = "win_x86_gcc" ]; then
		dk_call dk_arrayPush CMAKE_ARGS "-G" "MinGW Makefiles" "-DMSYSTEM=MINGW32"
		dk_call dk_validate DK3RDPARTY_DIR "dk_DK3RDPARTY_DIR"
		export PATH=${DK3RDPARTY_DIR}/msys2-x86_64-20231026/mingw32/bin:${PATH}
	elif [ "${target_triple,,}" = "win_x86_64_clang" ]; then
		dk_call dk_arrayPush CMAKE_ARGS "-G" "MinGW Makefiles" "-DMSYSTEM=CLANG64"
		dk_call dk_validate DK3RDPARTY_DIR "dk_DK3RDPARTY_DIR"
		export PATH=${DK3RDPARTY_DIR}/msys2-x86_64-20231026/clang64/bin:${PATH}
	elif [ "${target_triple,,}" = "win_x86_64_gcc" ]; then
		dk_call dk_arrayPush CMAKE_ARGS "-G" "MinGW Makefiles" "-DMSYSTEM=MINGW64"
		dk_call dk_validate DK3RDPARTY_DIR "dk_DK3RDPARTY_DIR"
		export PATH=${DK3RDPARTY_DIR}/msys2-x86_64-20231026/mingw64/bin:${PATH}
	elif [ "${target_triple,,}" = "win_x86_64_ucrt" ]; then
		dk_call dk_arrayPush CMAKE_ARGS "-G" "MinGW Makefiles" "-DMSYSTEM=UCRT64"
		dk_call dk_validate DK3RDPARTY_DIR "dk_DK3RDPARTY_DIR"
		export PATH=${DK3RDPARTY_DIR}/msys2-x86_64-20231026/ucrt64/bin:${PATH}
	elif [ "${target_triple,,}" = "win_x86_64_msvc" ]; then
		dk_call dk_arrayPush CMAKE_ARGS "-G" "Visual Studio 17 2022"
	else
		dk_call dk_fatal "Could no determine target_triple:${target_triple,,}"
	fi

	###### CMAKE_TOOLCHAIN_FILE ######
#	TOOLCHAIN="${DKCMAKE_DIR}/toolchains/${target_triple,,}_toolchain.cmake"
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
	#dk_call ${DKIMPORTS_DIR}/cmake/dk_install.sh
	
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
