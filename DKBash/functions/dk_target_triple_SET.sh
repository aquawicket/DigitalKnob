#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

###############################################################################
# dk_target_triple_SET()
#
#
dk_target_triple_SET() {
	dk_debugFunc 0


	dk_call dk_validate host_triple "dk_call dk_host_triple"
	dk_call dk_set default_target_env clang

	dk_call dk_echo ""
	dk_call dk_echo " 1) ${host_triple}_${default_target_env}"
	dk_call dk_echo ""
	dk_call dk_echo " 2) cosmopolitan"
	dk_call dk_echo " 3) android_arm32_clang"
	dk_call dk_echo " 4) android_arm64_clang"
	dk_call dk_echo " 5) android_x86_clang"
	dk_call dk_echo " 6) android_x86_64_clang"
	dk_call dk_echo " 7) emscripten_x86_clang"
	dk_call dk_echo " 8) ios_arm32_clang"
	dk_call dk_echo " 9) ios_arm64_clang"
	dk_call dk_echo "10) ios_x86_clang"
	dk_call dk_echo "11) ios_x86_64_clang"
	dk_call dk_echo "12) iossim_arm32_clang"
	dk_call dk_echo "13) iossim_arm64_clang"
	dk_call dk_echo "14) iossim_x86_clang"
	dk_call dk_echo "15) iossim_x86_64_clang"
	dk_call dk_echo "16) linux_arm32_clang"
	dk_call dk_echo "17) linux_arm64_clang"
	dk_call dk_echo "18) linux_x86_clang"
	dk_call dk_echo "19) linux_x86_64_clang"
	dk_call dk_echo "20) mac_arm32_clang"
	dk_call dk_echo "21) mac_arm64_clang"
	dk_call dk_echo "22) mac_x86_clang"
	dk_call dk_echo "23) mac_x86_64_clang"
	dk_call dk_echo "24) raspberry_arm32_clang"
	dk_call dk_echo "25) raspberry_arm64_clang"
	dk_call dk_echo "26) raspberry_x86_clang"
	dk_call dk_echo "27) raspberry_x86_64_clang"
	dk_call dk_echo "28) windows_arm32_clang"
	dk_call dk_echo "29) windows_arm64_clang"
	dk_call dk_echo "30) windows_x86_clang"
	dk_call dk_echo "31) windows_x86_gcc"
	dk_call dk_echo "32) windows_x86_msvc"
	dk_call dk_echo "33) windows_x86_64_clang"
	dk_call dk_echo "34) windows_x86_64_gcc"
	dk_call dk_echo "35) windows_x86_64_msvc"
	dk_call dk_echo "36) windows_x86_64_ucrt"
	dk_call dk_echo "37) Go Back"
	dk_call dk_echo "38) Exit"
	dk_call dk_echo ""

	dk_call dk_keyboardInput input
	if [ "${input}" = "0" ]; then
		dk_call dk_echo "repeating last selection"
		#dk_call dk_set target_app 	${_target_app_)
		#dk_call dk_set target_os 	${_target_os_}
		#dk_call dk_set target_type ${_target_type_}
	elif [ "${input}" = "1" ]; then
		dk_call dk_set target_triple 	${host_triple}
		dk_call dk_set target_os     	${HOST_OS}
		dk_call dk_set target_arch  	${HOST_ARCH}
		if [ -n "${default_target_env-}" ]; then
			dk_call dk_set target_env  ${default_target_env}
		fi
	elif [ "${input}" = "2" ]; then
		dk_call dk_set target_os "cosmopolitan"
		dk_call dk_set target_arch "cosmopolitan"
		dk_call dk_set target_env "cosmopolitan"
	elif [ "${input}" = "3" ]; then
		dk_call dk_set target_os "android"
		dk_call dk_set target_arch "arm32"
		dk_call dk_set target_env "clang"
	elif [ "${input}" = "4" ]; then
		dk_call dk_set target_os "android"
		dk_call dk_set target_arch "arm64"
		dk_call dk_set target_env "clang"
	elif [ "${input}" = "5" ]; then
		dk_call dk_set target_os "android"
		dk_call dk_set target_arch "x86"
		dk_call dk_set target_env "clang"
	elif [ "${input}" = "6" ]; then
		dk_call dk_set target_os "android"
		dk_call dk_set target_arch "x86_64"
		dk_call dk_set target_env "clang"
	elif [ "${input}" = "7" ]; then
		dk_call dk_set target_os "emscripten"
		dk_call dk_set target_arch "x86"
		dk_call dk_set target_env "clang"
	elif [ "${input}" = "8" ]; then
		dk_call dk_set target_os "ios"
		dk_call dk_set target_arch "arm32"
		dk_call dk_set target_env "clang"
	elif [ "${input}" = "9" ]; then
		dk_call dk_set target_os "ios"
		dk_call dk_set target_arch "arm64"
		dk_call dk_set target_env "clang"
	elif [ "${input}" = "10" ]; then
		dk_call dk_set target_os "ios"
		dk_call dk_set target_arch "x86"
		dk_call dk_set target_env "clang"
	elif [ "${input}" = "11" ]; then
		dk_call dk_set target_os "ios"
		dk_call dk_set target_arch "x86_64"
		dk_call dk_set target_env "clang"
	elif [ "${input}" = "12" ]; then
		dk_call dk_set target_os "iossim"
		dk_call dk_set target_arch "arm32"
		dk_call dk_set target_env "clang"
	elif [ "${input}" = "13" ]; then
		dk_call dk_set target_os "iossim"
		dk_call dk_set target_arch "arm64"
		dk_call dk_set target_env "clang"
	elif [ "${input}" = "14" ]; then
		dk_call dk_set target_os "iossim"
		dk_call dk_set target_arch "x86"
		dk_call dk_set target_env "clang"
	elif [ "${input}" = "15" ]; then
		dk_call dk_set target_os "iossim"
		dk_call dk_set target_arch "x86_64"
		dk_call dk_set target_env "clang"
	elif [ "${input}" = "16" ]; then
		dk_call dk_set target_os "linux"
		dk_call dk_set target_arch "arm32"
		dk_call dk_set target_env "clang"
	elif [ "${input}" = "17" ]; then
		dk_call dk_set target_os "linux"
		dk_call dk_set target_arch "arm64"
		dk_call dk_set target_env "clang"
	elif [ "${input}" = "18" ]; then
		dk_call dk_set target_os "linux"
		dk_call dk_set target_arch "x86"
		dk_call dk_set target_env "clang"
	elif [ "${input}" = "19" ]; then
		dk_call dk_set target_os "linux"
		dk_call dk_set target_arch "x86_64"
		dk_call dk_set target_env "clang"
	elif [ "${input}" = "20" ]; then
		dk_call dk_set target_os "mac"
		dk_call dk_set target_arch "arm32"
		dk_call dk_set target_env "clang"
	elif [ "${input}" = "21" ]; then
		dk_call dk_set target_os "mac"
		dk_call dk_set target_arch "arm64"
		dk_call dk_set target_env "clang"
	elif [ "${input}" = "22" ]; then
		dk_call dk_set target_os "mac"
		dk_call dk_set target_arch "x86"
		dk_call dk_set target_env "clang"
	elif [ "${input}" = "23" ]; then
		dk_call dk_set target_os "mac"
		dk_call dk_set target_arch "x86_64"
		dk_call dk_set target_env "clang"
	elif [ "${input}" = "24" ]; then
		dk_call dk_set target_os "raspberry"
		dk_call dk_set target_arch "arm32"
		dk_call dk_set target_env "clang"
	elif [ "${input}" = "25" ]; then
		dk_call dk_set target_os "raspberry"
		dk_call dk_set target_arch "arm64"
		dk_call dk_set target_env "clang"
	elif [ "${input}" = "26" ]; then
		dk_call dk_set target_os "raspberry"
		dk_call dk_set target_arch "x86"
		dk_call dk_set target_env "clang"
	elif [ "${input}" = "27" ]; then
		dk_call dk_set target_os "raspberry"
		dk_call dk_set target_arch "x86_64"
		dk_call dk_set target_env "clang"
	elif [ "${input}" = "28" ]; then
		dk_call dk_set target_os "win"
		dk_call dk_set target_arch "arm32"
		dk_call dk_set target_env "clang"
	elif [ "${input}" = "29" ]; then
		dk_call dk_set target_os "win"
		dk_call dk_set target_arch "arm64"
		dk_call dk_set target_env "clang"
	elif [ "${input}" = "30" ]; then
		dk_call dk_set target_os "win"
		dk_call dk_set target_arch "x86"
		dk_call dk_set target_env "clang"
	elif [ "${input}" = "31" ]; then
		dk_call dk_set target_os "win"
		dk_call dk_set target_arch "x86"
		dk_call dk_set target_env "gcc"
	elif [ "${input}" = "32" ]; then
		dk_call dk_set target_os "win"
		dk_call dk_set target_arch "x86"
		dk_call dk_set target_env "msvc"
	elif [ "${input}" = "33" ]; then
		dk_call dk_set target_os "win"
		dk_call dk_set target_arch "x86_64"
		dk_call dk_set target_env "clang"
	elif [ "${input}" = "34" ]; then
		dk_call dk_set target_os "win"
		dk_call dk_set target_arch "x86_64"
		dk_call dk_set target_env "gcc"
	elif [ "${input}" = "35" ]; then
		dk_call dk_set target_os "win"
		dk_call dk_set target_arch "x86_64"
		dk_call dk_set target_env "msvc"
	elif [ "${input}" = "36" ]; then
		dk_call dk_set target_os "win"
		dk_call dk_set target_arch "x86_64"
		dk_call dk_set target_env "ucrt"
	elif [ "${input}" = "37" ]; then
		unset target_app
		return 1
	elif [ "${input}" = "38" ]; then
		dk_call dk_exit 0
	else
		dk_call dk_warning "invalid selection"
	fi

	dk_call dk_assertVar target_os
	dk_call dk_toUpper ${target_os} TARGET_OS
	dk_call dk_set TARGET_OS ${TARGET_OS}
	dk_call dk_set ${target_os} 1
	dk_call dk_set ${TARGET_OS} 1
	dk_call dk_assertVar TARGET_OS
	dk_call dk_printVar target_os
	dk_call dk_printVar TARGET_OS
	dk_call dk_printVar ${target_os}
	dk_call dk_printVar ${TARGET_OS}
	dk_call dk_assertVar target_arch
	dk_call dk_toUpper ${target_arch} TARGET_ARCH
	dk_call dk_set TARGET_ARCH ${TARGET_ARCH}
	dk_call dk_set ${target_arch} 1
	dk_call dk_set ${TARGET_ARCH} 1
	dk_call dk_assertVar TARGET_ARCH
	dk_call dk_printVar target_arch
	dk_call dk_printVar TARGET_ARCH
	dk_call dk_printVar ${target_arch}
	dk_call dk_printVar ${TARGET_ARCH}

	if [ -n "${target_env-}" ]; then
		dk_call dk_toUpper ${target_env} TARGET_ENV
		dk_call dk_set TARGET_ENV ${TARGET_ENV}
		dk_call dk_set ${target_env} 1
		dk_call dk_set ${TARGET_ENV} 1
		dk_call dk_printVar target_env
		dk_call dk_printVar TARGET_ENV
		dk_call dk_printVar ${target_env}
		dk_call dk_printVar ${TARGET_ENV}
	fi
		
	if [ -n "${target_env-}" ]; then
		dk_call dk_set target_triple "${target_os}_${target_arch}_${target_env}"
		dk_call dk_set TARGET_TRIPLE "${TARGET_OS}_${TARGET_ARCH}_${TARGET_ENV}"
	else
		dk_call dk_set target_triple "${target_os}_${target_arch}"
		dk_call dk_set TARGET_TRIPLE "${TARGET_OS}_${TARGET_ARCH}"
	fi
	dk_call dk_assertVar target_triple
	dk_call dk_assertVar TARGET_TRIPLE
	dk_call dk_set ${target_triple} 1	
	dk_call dk_set ${TARGET_TRIPLE} 1	
	dk_call dk_printVar target_triple
	dk_call dk_printVar TARGET_TRIPLE
	dk_call dk_printVar ${target_triple}
	dk_call dk_printVar ${TARGET_TRIPLE}	

	### Set DEBUG_DIR and RELEASE_DIR variables
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
	dk_call dk_assertVar DEBUG_DIR
	dk_call dk_assertVar RELEASE_DIR
	dk_call dk_printVar DEBUG_DIR
	dk_call dk_printVar RELEASE_DIR
	#else
	#dk_call dk_target_triple
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_target_triple_SET
}
