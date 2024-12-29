#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"

###############################################################################
# dk_target_triple()
#
#	Set the cached target variables
#   This information is pulled from the folder name of the CMAKE_BINARY_DIR
#   i.e.  win_x86_64_clang
#
#	If the CMAKE_BINARY_DIR is missing the <OS> or the <ARCH>, dk_target_triple_SET will be called to get those variables
#
#	os   				= android, emscripten, ios, iossim, linux, mac, raspberry, windows 
#	OS   				= ANDROID, EMSCRIPTEN, IOS, IOSSIM, LINUX, MAC, RASPBERRY, WINDOWS
#	arch				= arm32, arm64, x86, x86_64
#	ARCH				= ARM32, ARM64, X86, X86_64
#	env					= clang, cosmopolitan, mingw, msvc, ucrt
#	ENV					= CLANG, cosmopolitan, MINGW, MSVC, UCRT
#   <os>_<arch>			= android_arm64, emscripten_arm64, ios_arm64, iossim_arm64, linux_arm64, mac_arm64, raspberry_arm64, windows_arm64
#   <os>_<arch>_<env>	= android_arm64_clang, emscripten_arm64_clang, ios_arm64_clang, iossim_arm64_clang, linux_arm64_clang, mac_arm64_clang, raspberry_arm64_clang, windows_arm64_clang
#
dk_target_triple() {
	dk_debugFunc 0

	CMAKE_BINARY_DIR="C:\Users\Administrator\digitalknob\Development\DKApps\HelloWorld\win_x86_64_clang\Debug"
	default_target_env="clang"

	### Get TARGET_DIR ###
	dk_call dk_realpath "${CMAKE_BINARY_DIR}" TARGET_DIR
	dk_call dk_printVar TARGET_DIR 							# TARGET_DIR = C:/Users/Administrator/digitalknob/Development/DKApps/DKSample/win_x86_64_clang/Debug

	#### Set target_type / TARGET_TYPE ###
	if [ "${TARGET_DIR}" = "Debug" ]; then	
		### Get DEBUG ###
		dk_call dk_set DKBUILD_TYPE DEBUG					# DKBUILD_TYPE	= DEBUG
		dk_call dk_set ${DKBUILD_TYPE} 1					# DEBUG = 1	
		#dk_call dk_set TARGET_TYPE Debug					# TARGET_TYPE	= Debug
		dk_call dk_dirname TARGET_DIR TARGET_TRIPLE_DIR		# TARGET_TRIPLE_DIR = C:/Users/Administrator/digitalknob/Development/DKApps/DKSample/win_x86_64_clang
	elif [ "${TARGET_DIR}" = "Release" ]; then
		### Get RELEASE ###
		dk_call dk_set DKBUILD_TYPE RELEASE 				# DKBUILD_TYPE = RELEASE
		dk_call dk_set ${DKBUILD_TYPE} 1					# RELEASE = 1	
		#dk_call dk_set TARGET_TYPE Release					# TARGET_TYPE = Release
		dk_call dk_dirname ${TARGET_DIR} TARGET_TRIPLE_DIR	# TARGET_TRIPLE_DIR = C:/Users/Administrator/digitalknob/Development/DKApps/DKSample/win_x86_64_clang
	fi

	if ( ( dk_call dk_stringContains "${TARGET_DIR}" "android"      ) ||
		 ( dk_call dk_stringContains "${TARGET_DIR}" "android"      ) ||
		 ( dk_call dk_stringContains "${TARGET_DIR}" "emscripten"   ) ||
		 ( dk_call dk_stringContains "${TARGET_DIR}" "ios"          ) ||
		 ( dk_call dk_stringContains "${TARGET_DIR}" "iossim"       ) ||
		 ( dk_call dk_stringContains "${TARGET_DIR}" "linux"        ) ||
		 ( dk_call dk_stringContains "${TARGET_DIR}" "mac"          ) ||
		 ( dk_call dk_stringContains "${TARGET_DIR}" "raspberry"    ) ||
		 ( dk_call dk_stringContains "${TARGET_DIR}" "windows"      ) ||
		 ( dk_call dk_stringContains "${TARGET_DIR}" "cosmopolitan"	) ); then
		     dk_call dk_set TARGET_TRIPLE_DIR ${TARGET_DIR}
	else
		dk_call dk_target_triple_SET
		dk_call dk_set TARGET_TRIPLE_DIR ${TARGET_DIR}/${triple}
	fi

	if [ -e "${TARGET_TRIPLE_DIR}" ]; then
		dk_call dk_assertPath TARGET_TRIPLE_DIR
	else
		dk_call dk_warning "TARGET_TRIPLE_DIR:${TARGET_TRIPLE_DIR} does not exits."
		dk_call dk_debug "Creating directory . . .${TARGET_TRIPLE_DIR}"
		dk_call dk_makeDirectory "${TARGET_TRIPLE_DIR}"
	fi

	#### Set DK_PROJECT_DIR ###
	dk_call dk_dirname "${TARGET_TRIPLE_DIR}" DK_PROJECT_DIR
	dk_call dk_set DK_PROJECT_DIR "${DK_PROJECT_DIR}"
	dk_call dk_assertPath DK_PROJECT_DIR

	#### Set triple/TRIPLE, <os>_<arch>_<env>/<OS>_<ARCH>_<ENV> ###
	dk_call dk_basename ${TARGET_TRIPLE_DIR} triple		# triple 	= win_x86_64_clang
	dk_call dk_set triple ${triple}						# Globalize the variable
	dk_call dk_set target_triple ${triple}				# target_triple	= win_x86_64_clang
	dk_call dk_toUpper ${triple} TRIPLE					# TRIPLE	= WIN_X86_64_CLANG
	dk_call dk_set TRIPLE ${TRIPLE}						# Globalize the variable
	dk_call dk_set TARGET_TRIPLE ${TRIPLE}				#	TARGET_TRIPLE = WIN_X86_64_CLANG
	dk_call dk_set ${triple} 1							# win_x86_64_clang = 1
	dk_call dk_set ${TRIPLE} 1							# WIN_X86_64_CLANG = 1
	dk_call dk_printVar triple 
	dk_call dk_printVar TRIPLE 

	#### Set os / OS / <os>_target / <OS>_TARGET
	dk_call dk_stringContains "${TRIPLE}" "android" 		&& dk_call dk_set os android
	dk_call dk_stringContains "${TRIPLE}" "emscripten" 		&& dk_call dk_set os emscripten
	dk_call dk_stringContains "${TRIPLE}" "iossim" 			&& dk_call dk_set os iossim 
	dk_call dk_stringContains "${TRIPLE}" "ios" 			&& dk_call dk_set os ios
	dk_call dk_stringContains "${TRIPLE}" "linux" 			&& dk_call dk_set os linux
	dk_call dk_stringContains "${TRIPLE}" "mac" 			&& dk_call dk_set os mac
	dk_call dk_stringContains "${TRIPLE}" "raspberry" 		&& dk_call dk_set os raspberry
	dk_call dk_stringContains "${TRIPLE}" "windows" 		&& dk_call dk_set os windows
	dk_call dk_stringContains "${TRIPLE}" "win"				&& dk_call dk_set os win
	dk_call dk_stringContains "${TRIPLE}" "cosmopolitan"	&& dk_call dk_set os cosmopolitan
	if [ -z "${os-}" ]; then
		# dk_call dk_warning "The target triple:${triple} does not contain a valid os"
		dk_call dk_unset triple
		dk_call dk_unset TRIPLE 
		dk_call dk_target_triple_SET
	else
		dk_call dk_toUpper ${os} OS
		dk_call dk_set OS ${OS} 
		dk_call dk_set target_os ${os}
		dk_call dk_set TARGET_OS ${OS}
		dk_call dk_set ${os} 1
		dk_call dk_set ${OS} 1
		dk_call dk_set ${os}_target 1
		dk_call dk_set ${OS}_TARGET 1
	fi
	
	#### Get arch / ARCH
	dk_call dk_stringContains "${triple}" "arm64" 			&& dk_call dk_set arch arm64
	dk_call dk_stringContains "${triple}" "arm32" 			&& dk_call dk_set arch arm32
	dk_call dk_stringContains "${triple}" "x86_64" 			&& dk_call dk_set arch x86_64
	dk_call dk_stringContains "${triple}" "x86" 			&& dk_call dk_set arch x86
	dk_call dk_stringContains "${triple}" "cosmopolitan" 	&& dk_call dk_set arch cosmopolitan	
	
	if [ -z "${arch-}" ]; then
		dk_call dk_warning "The target triple:${triple} does not contain a valid arch"
		dk_call dk_target_triple_SET
	else
		dk_call dk_toUpper ${arch} ARCH
		dk_call dk_set ARCH ${ARCH}
		dk_call dk_set target_arch ${arch}
		dk_call dk_set TARGET_ARCH ${ARCH}
		dk_call dk_set ${arch} 1
		dk_call dk_set ${ARCH} 1
		dk_call dk_set ${arch}_target 1
		dk_call dk_set ${ARCH}_TARGET 1
	fi

	#### Set evn / ENV 
	dk_call dk_stringContains "${triple}" "clang" 			&& dk_call dk_set env clang
	dk_call dk_stringContains "${triple}" "mingw" 			&& dk_call dk_set env mingw
	dk_call dk_stringContains "${triple}" "ucrt"  			&& dk_call dk_set env ucrt
	dk_call dk_stringContains "${triple}" "msvc"  			&& dk_call dk_set env msvc
	dk_call dk_stringContains "${triple}" "cosmopolitan" 	&& dk_call dk_set env cosmopolitan
	if [ -z "${env-}" ]; then
		dk_call dk_warning "The target triple:${triple} does not contain a valid env"
		dk_call dk_set env ${default_target_env}
	else
		dk_call dk_toUpper ${env} ENV
		dk_call dk_set ENV ${ENV}
		dk_call dk_set target_env ${env}
		dk_call dk_set TARGET_ENV ${ENV}
		dk_call dk_set ${env} 1
		dk_call dk_set ${ENV} 1
		dk_call dk_set ${env}_target 1
		dk_call dk_set ${ENV}_TARGET 1
	fi

	#### Set MSYSTEM
	if [ -n "${ENV-}" ]; then
		if [ -n "${CLANG-}" ]; then 
			if [ -n "${ARM64-}" ]; then
				dk_call dk_set msystem "${env}${arch}"	# msystem = clangarm64
				dk_call dk_set MSYSTEM "${ENV}${ARCH}"	# MSYSTEM = CLANGARM64
			elif [ -n "${X86_64-}" ]; then
				dk_call dk_set msystem "${env}64"		# msystem = clang64, mingw64, ucrt64
				dk_call dk_set MSYSTEM "${ENV}64"		# MSYSTEM = CLANG64, MINGW64, UCRT64
			elif [ -n "${X86-}" ]; then
				dk_call dk_set msystem "${env}32"		# msystem = clang32, mingw32
				dk_call dk_set MSYSTEM "${ENV}32"		# MSYSTEM = CLANG32, MINGW32
			else
				dk_call dk_fatal "The target triple:${triple} does not contain a valid env or msystem"
			fi
		fi
		dk_call dk_set ${MSYSTEM} 1						# CLANGARM64, CLANG64, CLANG32, MINGW64, MINGW32, UCRT64 = 1
	fi
	
	### Set os_arch / OS_ARCH ###
	dk_call dk_set os_arch "${os}_${arch}"
	dk_call dk_set OS_ARCH "${OS}_${ARCH}"
	dk_call dk_set target_os_arch "${os_arch}"
	dk_call dk_set TARGET_OS_ARCH "${OS_ARCH}"
	dk_call dk_set ${os_arch} 1
	dk_call dk_set ${OS_ARCH} 1
	dk_call dk_set ${os_arch}_target 1
	dk_call dk_set ${OS_ARCH}_TARGET 1

	#### Set DEBUG_DIR and RELEASE_DIR variables
	if [ -n "${IOS-}" ]; then
		dk_call dk_set DEBUG_DIR Debug-iphoneos
		dk_call dk_set RELEASE_DIR Release-iphoneos
	elif [ -n "${IOSSIM-}" ]; then
		dk_call dk_set DEBUG_DIR Debug-iphonesimulator
		dk_call dk_set RELEASE_DIR Release-iphonesimulator
	else
		dk_call dk_set DEBUG_DIR Debug
		dk_call dk_set RELEASE_DIR Release
	fi
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0

	dk_call dk_target_triple
}
