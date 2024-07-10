#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

##################################################################################
# dk_generate()
#
#
dk_generate (){
	dk_debugFunc
	[ ${#} -ne 0 ] && dk_error "${FUNCNAME}(${#}): incorrect number of arguments"
	
	dk_echo
	dk_echo "##################################################################"
	dk_echo "     Generating ${APP} - ${TARGET_OS} - ${TYPE} - ${DKLEVEL-}"
	dk_echo "##################################################################"
	dk_echo

	dk_clearCmakeCache
	dk_deleteTempFiles

	TARGET_PATH="${DKAPPS_DIR}"/"${APP}"
	#dk_printVar TARGET_PATH
	dk_makeDirectory "${TARGET_PATH}"/"${TARGET_OS}"
	cd "${TARGET_PATH}"/"${TARGET_OS}"
	CMAKE_SOURCE_DIR="${DKCMAKE_DIR}"
	#dk_printVar CMAKE_SOURCE_DIR
	$(dk_pathExists "${CMAKE_SOURCE_DIR}") || dk_error "CMAKE_SOURCE_DIR:${CMAKE_SOURCE_DIR} does not exist"
	#dk_printVar CMAKE_SOURCE_DIR
	CMAKE_TARGET_PATH=${TARGET_PATH}
	#dk_printVar CMAKE_TARGET_PATH
	
	###### BUILD CMAKE_ARGS ARRAY ######
	DKLEVEL="RebuildAll"
	DKLINK="Static"
	
	#declare -a CMAKE_ARGS
	#set --											#clear the positional parameters
	CMAKE_ARGS=()
	if [ "${TYPE}" = "Debug" ]; then
		#set -- "-DDEBUG=ON" )
		#set -- "${@}" "-DDEBUG=ON"
		dk_arrayPush CMAKE_ARGS "-DDEBUG=ON" "-DRELEASE=OFF"
	elif [ "${TYPE}" = "Release" ]; then
		dk_arrayPush CMAKE_ARGS "-DDEBUG=OFF" "-DRELEASE=ON"
	elif [ "${TYPE}" = "All" ]; then
		dk_arrayPush CMAKE_ARGS "-DDEBUG=ON" "-DRELEASE=ON"
	else
		dk_error "TYPE:${TYPE} is invalid"
	fi
	
	if [ "${DKLEVEL}" = "Build" ]; then
		dk_arrayPush CMAKE_ARGS "-DBUILD=ON"
	elif [ "${DKLEVEL}" = "Rebuild" ]; then
		dk_arrayPush CMAKE_ARGS "-DREBUILD=ON"
	elif [ "${DKLEVEL}" = "RebuildAll" ]; then
		dk_arrayPush CMAKE_ARGS "-DREBUILDALL=ON"
	else
		dk_error "DKLEVEL:${DKLEVEL} is invalid"
	fi
	
	if [ "${DKLINK}" = "Static" ]; then
		dk_arrayPush CMAKE_ARGS "-DSTATIC=ON"
	fi
	if [ "${DKLINK}" = "Shared" ]; then
		dk_arrayPush CMAKE_ARGS "-DSHARED=ON"
	fi
	
	CMAKE_BINARY_DIR="${CMAKE_TARGET_PATH}/${TARGET_OS}/${TYPE}"
	#dk_printVar CMAKE_BINARY_DIR
	
	if ! dk_defined WSLENV; then 
		dk_arrayPush CMAKE_ARGS "-S=${CMAKE_SOURCE_DIR}"
	fi
	dk_arrayPush CMAKE_ARGS "-B=${CMAKE_BINARY_DIR}"
	
	############ CMake Options ############
    #dk_arrayPush CMAKE_ARGS "-DCMAKE_VERBOSE_MAKEFILE=1"
	#dk_arrayPush CMAKE_ARGS "-DCMAKE_COLOR_DIAGNOSTICS=ON"
	#dk_arrayPush CMAKE_ARGS "-Wdev"
	#dk_arrayPush CMAKE_ARGS "-Werror=dev"
	#dk_arrayPush CMAKE_ARGS "-Wdeprecated"
	#dk_arrayPush CMAKE_ARGS "-Werror=deprecated"
	#dk_arrayPush CMAKE_ARGS "--graphviz=graphviz.txt"
	#dk_arrayPush CMAKE_ARGS "--system-information system_information.txt"
	#dk_arrayPush CMAKE_ARGS "--debug-trycompile"
	#dk_arrayPush CMAKE_ARGS "--debug-output"
	#dk_arrayPush CMAKE_ARGS "--trace"
	#dk_arrayPush CMAKE_ARGS "--trace-expand"
	#dk_arrayPush CMAKE_ARGS "--warn-uninitialized"
	#dk_arrayPush CMAKE_ARGS "--warn-unused-vars"
	#dk_arrayPush CMAKE_ARGS "--check-system-vars"
	
	if [ "${TARGET_OS}" = "android_arm32" ]; then
		#set -- "-G Unix Makefiles" "${@}"
		dk_arrayUnshift CMAKE_ARGS "-G" "Unix Makefiles" 
	fi

	if [ "${TARGET_OS}" = "android_arm64" ]; then
		#set -- "-G Unix Makefiles" "${@}"
		dk_arrayUnshift CMAKE_ARGS "-G" "Unix Makefiles"
	fi
	
	if [ "${TARGET_OS}" = "emscripten" ]; then
		#set -- "-G Unix Makefiles" "${@}"
		dk_arrayUnshift CMAKE_ARGS "-G" "Unix Makefiles" 
	fi
	
	if [ "${TARGET_OS}" = "ios_arm32" ]; then
		#set -- "-G Xcode" "${@}"
		dk_arrayUnshift CMAKE_ARGS "-G" "Xcode"
	fi
	
	if [ "${TARGET_OS}" = "ios_arm64" ]; then
		#set -- "-G Xcode" "${@}"
		dk_arrayUnshift CMAKE_ARGS "-G" "Xcode"
	fi
	
	if [ "${TARGET_OS}" = "iossim_x86" ]; then
		#set -- "-G Xcode" "${@}"
		dk_arrayUnshift CMAKE_ARGS "-G" "Xcode"
	fi
	
	if [ "${TARGET_OS}" = "iossim_x86_64" ]; then
		#set -- "-G Xcode" "${@}"
		dk_arrayUnshift CMAKE_ARGS "-G" "Xcode"
	fi
	
	if [ "${TARGET_OS}" = "linux_x86" ]; then
		#set -- "-G Unix Makefiles" "${@}"
		dk_arrayUnshift CMAKE_ARGS "-G" "Unix Makefiles" 
	fi
	
	if [ "${TARGET_OS}" = "linux_x86_64" ]; then
		#set -- "-G Unix Makefiles" "${@}"
		dk_arrayUnshift CMAKE_ARGS "-G" "Unix Makefiles" 
	fi
	
	if [ "${TARGET_OS}" = "mac_x86" ]; then
		#set -- "-G Xcode" "${@}"
		dk_arrayUnshift CMAKE_ARGS "-G" "Xcode"
	fi
	
	if [ "${TARGET_OS}" = "mac_x86_64" ]; then
		#set -- "-G Xcode" "${@}"
		dk_arrayUnshift CMAKE_ARGS "-G" "Xcode"
	fi
	
	if [ "${TARGET_OS}" = "raspberry_arm32" ]; then
		#set -- "-G Unix Makefiles" "${@}"
		dk_arrayUnshift CMAKE_ARGS "-G" "Unix Makefiles" 
	fi
	
	if [ "${TARGET_OS}" = "raspberry_arm64" ]; then
		#set -- "-G Unix Makefiles" "${@}"
		dk_arrayUnshift CMAKE_ARGS "-G" "Unix Makefiles" 
	fi
	
	if [ "${TARGET_OS}" = "win_arm64_clang" ]; then
		export PATH=${DK3RDPARTY_DIR}/msys2-x86_64-20231026/clangarm64/bin:${PATH}
		#set -- "-G MSYS Makefiles" "${@}"
		dk_arrayUnshift CMAKE_ARGS "-G" "MSYS Makefiles" "-DMSYSTEM=CLANGARM64"
	fi
	
	if [ "${TARGET_OS}" = "win_x86_clang" ]; then
		export PATH=${DK3RDPARTY_DIR}/msys2-x86_64-20231026/clang32/bin:${PATH}
		#set -- "-G MSYS Makefiles" "${@}"
		dk_arrayUnshift CMAKE_ARGS "-G" "MSYS Makefiles" "-DMSYSTEM=CLANG32"
	fi
	
	if [ "${TARGET_OS}" = "win_x86_mingw" ]; then
		export PATH=${DK3RDPARTY_DIR}/msys2-x86_64-20231026/mingw32/bin:${PATH}
		#set -- "-G MSYS Makefiles" "${@}"
		dk_arrayUnshift CMAKE_ARGS "-G" "MSYS Makefiles" "-DMSYSTEM=MINGW32"
	fi
	
	if [ "${TARGET_OS}" = "win_x86_64_clang" ]; then
		export PATH=${DK3RDPARTY_DIR}/msys2-x86_64-20231026/clang64/bin:${PATH}
		#set -- "-DCMAKE_EXE_LINKER_FLAGS=-static -mconsole"
		#set -- "-G MSYS Makefiles" "${@}"
		dk_arrayUnshift CMAKE_ARGS "-G" "MSYS Makefiles" "-DMSYSTEM=CLANG64"
	fi
	
	if [ "${TARGET_OS}" = "win_x86_64_mingw" ]; then
		export PATH=${DK3RDPARTY_DIR}/msys2-x86_64-20231026/mingw64/bin:${PATH}
		#set -- "-G MSYS Makefiles" "${@}"
		dk_arrayUnshift CMAKE_ARGS "-G" "MSYS Makefiles" "-DMSYSTEM=MINGW64"
	fi
	
	if [ "${TARGET_OS}" = "win_x86_64_ucrt" ]; then
		export PATH=${DK3RDPARTY_DIR}/msys2-x86_64-20231026/ucrt64/bin:${PATH}
		#set -- "-G MSYS Makefiles" "${@}"
		dk_arrayUnshift CMAKE_ARGS "-G" "MSYS Makefiles" "-DMSYSTEM=UCRT64"
	fi

	###### CMAKE_TOOLCHAIN_FILE ######
#	TOOLCHAIN="${DKCMAKE_DIR}/toolchains/${TARGET_OS}_toolchain.cmake"
#	dk_echo "TOOLCHAIN = ${TOOLCHAIN}"
#	if dk_pathExists "${TOOLCHAIN}"; then
#		dk_arrayPush CMAKE_ARGS "-DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN}"
#	fi
	
	###### WSL CMake Fix ######
	if dk_defined WSLENV; then 
		cd "${DKCMAKE_DIR}"
		dk_arrayPush CMAKE_ARGS "."
	fi
	
	###### CMake Configure ######
	dk_installCmake
	
	dk_echo
	dk_echo "****** CMAKE COMMAND ******"
	#dk_printVar CMAKE_ARGS
	#dk_echo "CMAKE_ARGS = ${CMAKE_ARGS[*]}"
	dk_call ${CMAKE_EXE} "${CMAKE_ARGS[@]}" && dk_echo "CMake Generation Successful" || dk_error "CMake Generation Failed"
	dk_echo
}






DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	dk_generate
}
