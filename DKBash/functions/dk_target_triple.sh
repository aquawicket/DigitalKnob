#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

###############################################################################
# dk_target_triple()
#
#	Set the cached target variables
#   This information is pulled from the folder name of the CMAKE_BINARY_DIR
#   i.e.  win_x86_64_clang
#
#	If the CMAKE_BINARY_DIR is missing the <TARGET_OS> or the <TARGET_ARCH>, dk_target_triple_SET will be called to get those variables
#
#	target_os   				= android, emscripten, ios, iossim, linux, mac, raspberry, windows 
#	TARGET_OS   				= ANDROID, EMSCRIPTEN, IOS, IOSSIM, LINUX, MAC, RASPBERRY, WINDOWS
#	target_arch				= arm32, arm64, x86, x86_64
#	TARGET_ARCH				= ARM32, ARM64, X86, X86_64
#	target_env					= clang, cosmopolitan, mingw, msvc, ucrt
#	TARGET_ENV					= CLANG, cosmopolitan, MINGW, MSVC, UCRT
#   <target_os>_<target_arch>			= android_arm64, emscripten_arm64, ios_arm64, iossim_arm64, linux_arm64, mac_arm64, raspberry_arm64, windows_arm64
#   <target_os>_<target_arch>_<target_env>	= android_arm64_clang, emscripten_arm64_clang, ios_arm64_clang, iossim_arm64_clang, linux_arm64_clang, mac_arm64_clang, raspberry_arm64_clang, windows_arm64_clang
#
dk_target_triple() {
	dk_debugFunc 0

	#CMAKE_BINARY_DIR="C:/Users/Administrator/digitalknob/Development/DKCpp/apps/HelloWorld/win_x86_64_clang/Debug"
	default_target_env="clang"

	### Get TARGET_DIR ###
	dk_call dk_realpath "${CMAKE_BINARY_DIR}" TARGET_DIR
	dk_call dk_printVar TARGET_DIR 							# TARGET_DIR = C:/Users/Administrator/digitalknob/Development/DKCpp/apps/DKSample/win_x86_64_clang/Debug

	#### Set target_type / TARGET_TYPE ###
	if [ "${TARGET_DIR}" = "Debug" ]; then	
		### Get DEBUG ###
		dk_call dk_set DKBUILD_TYPE DEBUG					# DKBUILD_TYPE	= DEBUG
		dk_call dk_set ${DKBUILD_TYPE} 1					# DEBUG = 1	
		dk_call dk_dirname TARGET_DIR TARGET_TRIPLE_DIR		# TARGET_TRIPLE_DIR = C:/Users/Administrator/digitalknob/Development/DKCpp/apps/DKSample/win_x86_64_clang
	elif [ "${TARGET_DIR}" = "Release" ]; then
		### Get RELEASE ###
		dk_call dk_set DKBUILD_TYPE RELEASE 				# DKBUILD_TYPE = RELEASE
		dk_call dk_set ${DKBUILD_TYPE} 1					# RELEASE = 1	
		dk_call dk_dirname ${TARGET_DIR} TARGET_TRIPLE_DIR	# TARGET_TRIPLE_DIR = C:/Users/Administrator/digitalknob/Development/DKCpp/apps/DKSample/win_x86_64_clang
	fi

	if ( ( dk_call dk_containsCI "${TARGET_DIR}" "android"      ) ||
		 ( dk_call dk_containsCI "${TARGET_DIR}" "android"      ) ||
		 ( dk_call dk_containsCI "${TARGET_DIR}" "emscripten"   ) ||
		 ( dk_call dk_containsCI "${TARGET_DIR}" "ios"          ) ||
		 ( dk_call dk_containsCI "${TARGET_DIR}" "iossim"       ) ||
		 ( dk_call dk_containsCI "${TARGET_DIR}" "linux"        ) ||
		 ( dk_call dk_containsCI "${TARGET_DIR}" "mac"          ) ||
		 ( dk_call dk_containsCI "${TARGET_DIR}" "raspberry"    ) ||
		 ( dk_call dk_containsCI "${TARGET_DIR}" "windows"      ) ||
		 ( dk_call dk_containsCI "${TARGET_DIR}" "cosmopolitan"	) ); then
		     dk_call dk_set TARGET_TRIPLE_DIR ${TARGET_DIR}
	else
		dk_call dk_target_triple_SET
		dk_call dk_set TARGET_TRIPLE_DIR ${TARGET_DIR}/${target_triple}
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

	#### Set target_triple/TARGET_TRIPLE, <target_os>_<target_arch>_<target_env>/<TARGET_OS>_<TARGET_ARCH>_<TARGET_ENV> ###
	dk_call dk_basename ${TARGET_TRIPLE_DIR} target_triple			# target_triple 	= win_x86_64_clang
	dk_call dk_set target_triple ${target_triple}					# Globalize the variable
	dk_call dk_toUpper ${target_triple} TARGET_TRIPLE				# TARGET_TRIPLE	= WIN_X86_64_CLANG
	dk_call dk_set TARGET_TRIPLE ${TARGET_TRIPLE}					# Globalize the variable
	dk_call dk_set ${target_triple} 1								# win_x86_64_clang = 1
	dk_call dk_set ${TARGET_TRIPLE} 1								# WIN_X86_64_CLANG = 1
	dk_call dk_printVar target_triple 
	dk_call dk_printVar TARGET_TRIPLE 

	#### Set target_os / TARGET_OS / <target_os>_target / <TARGET_OS>_TARGET
	dk_call dk_containsCI "${TARGET_TRIPLE}" "android" 		&& dk_call dk_set target_os android
	dk_call dk_containsCI "${TARGET_TRIPLE}" "emscripten" 	&& dk_call dk_set target_os emscripten
	dk_call dk_containsCI "${TARGET_TRIPLE}" "iossim" 		&& dk_call dk_set target_os iossim 
	dk_call dk_containsCI "${TARGET_TRIPLE}" "ios" 			&& dk_call dk_set target_os ios
	dk_call dk_containsCI "${TARGET_TRIPLE}" "linux" 			&& dk_call dk_set target_os linux
	dk_call dk_containsCI "${TARGET_TRIPLE}" "mac" 			&& dk_call dk_set target_os mac
	dk_call dk_containsCI "${TARGET_TRIPLE}" "raspberry" 		&& dk_call dk_set target_os raspberry
	dk_call dk_containsCI "${TARGET_TRIPLE}" "windows" 		&& dk_call dk_set target_os windows
	dk_call dk_containsCI "${TARGET_TRIPLE}" "win"			&& dk_call dk_set target_os win
	dk_call dk_containsCI "${TARGET_TRIPLE}" "cosmopolitan"	&& dk_call dk_set target_os cosmopolitan
	if [ -z "${target_os-}" ]; then
		# dk_call dk_warning "The target target_triple:${target_triple} does not contain a valid target_os"
		dk_call dk_unset target_triple
		dk_call dk_unset TARGET_TRIPLE 
		dk_call dk_target_triple_SET
	else
		dk_call dk_toUpper ${target_os} TARGET_OS
		dk_call dk_set target_os ${target_os}
		dk_call dk_set TARGET_OS ${TARGET_OS} 
		dk_call dk_set ${target_os} 1
		dk_call dk_set ${TARGET_OS} 1
		dk_call dk_set ${target_os}_target 1
		dk_call dk_set ${TARGET_OS}_TARGET 1
	fi
	
	#### Get target_arch / TARGET_ARCH
	dk_call dk_containsCI "${target_triple}" "arm64" 			&& dk_call dk_set target_arch arm64
	dk_call dk_containsCI "${target_triple}" "arm32" 			&& dk_call dk_set target_arch arm32
	dk_call dk_containsCI "${target_triple}" "x86_64" 			&& dk_call dk_set target_arch x86_64
	dk_call dk_containsCI "${target_triple}" "x86" 				&& dk_call dk_set target_arch x86
	dk_call dk_containsCI "${target_triple}" "cosmopolitan" 	&& dk_call dk_set target_arch cosmopolitan	
	
	if [ -z "${target_arch-}" ]; then
		dk_call dk_warning "The target target_triple:${target_triple} does not contain a valid target_arch"
		dk_call dk_target_triple_SET
	else
		dk_call dk_toUpper ${target_arch} TARGET_ARCH
		dk_call dk_set target_arch ${target_arch}
		dk_call dk_set TARGET_ARCH ${TARGET_ARCH}
		dk_call dk_set ${target_arch} 1
		dk_call dk_set ${TARGET_ARCH} 1
		dk_call dk_set ${target_arch}_target 1
		dk_call dk_set ${TARGET_ARCH}_TARGET 1
	fi

	#### Set evn / TARGET_ENV 
	dk_call dk_containsCI "${target_triple}" "clang" 			&& dk_call dk_set target_env clang
	dk_call dk_containsCI "${target_triple}" "mingw" 			&& dk_call dk_set target_env mingw
	dk_call dk_containsCI "${target_triple}" "ucrt"  			&& dk_call dk_set target_env ucrt
	dk_call dk_containsCI "${target_triple}" "msvc"  			&& dk_call dk_set target_env msvc
	dk_call dk_containsCI "${target_triple}" "cosmopolitan" 	&& dk_call dk_set target_env cosmopolitan
	if [ -z "${target_env-}" ]; then
		dk_call dk_warning "The target target_triple:${target_triple} does not contain a valid target_env"
		dk_call dk_set target_env ${default_target_env}
	else
		dk_call dk_toUpper ${target_env} TARGET_ENV
		dk_call dk_set target_env ${target_env}
		dk_call dk_set TARGET_ENV ${TARGET_ENV}
		dk_call dk_set ${target_env} 1
		dk_call dk_set ${TARGET_ENV} 1
		dk_call dk_set ${target_env}_target 1
		dk_call dk_set ${TARGET_ENV}_TARGET 1
	fi

	#### Set MSYSTEM
	if [ -n "${TARGET_ENV-}" ]; then
		if [ -n "${CLANG-}" ]; then 
			if [ -n "${ARM64-}" ]; then
				dk_call dk_set msystem "${target_env}${target_arch}"	# msystem = clangarm64
				dk_call dk_set MSYSTEM "${TARGET_ENV}${TARGET_ARCH}"	# MSYSTEM = CLANGARM64
			elif [ -n "${X86_64-}" ]; then
				dk_call dk_set msystem "${target_env}64"				# msystem = clang64, mingw64, ucrt64
				dk_call dk_set MSYSTEM "${TARGET_ENV}64"				# MSYSTEM = CLANG64, MINGW64, UCRT64
			elif [ -n "${X86-}" ]; then
				dk_call dk_set msystem "${target_env}32"				# msystem = clang32, mingw32
				dk_call dk_set MSYSTEM "${TARGET_ENV}32"				# MSYSTEM = CLANG32, MINGW32
			else
				dk_call dk_fatal "The target target_triple:${target_triple} does not contain a valid target_env or msystem"
			fi
		fi
		dk_call dk_set ${MSYSTEM} 1										# CLANGARM64, CLANG64, CLANG32, MINGW64, MINGW32, UCRT64 = 1
	fi
	
	### Set target_os_arch / TARGET_OS_ARCH ###
	dk_call dk_set target_os_arch "${target_os}_${target_arch}"
	dk_call dk_set TARGET_OS_ARCH "${TARGET_OS}_${TARGET_ARCH}"
	dk_call dk_set target_os_arch "${target_os_arch}"
	dk_call dk_set TARGET_OS_ARCH "${TARGET_OS_ARCH}"
	dk_call dk_set ${target_os_arch} 1
	dk_call dk_set ${TARGET_OS_ARCH} 1
	dk_call dk_set ${target_os_arch}_target 1
	dk_call dk_set ${TARGET_OS_ARCH}_TARGET 1

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
