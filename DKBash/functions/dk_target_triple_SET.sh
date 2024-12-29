#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"

###############################################################################
# dk_target_triple_SET()
#
#
dk_target_triple_SET() {
	dk_debugFunc 0


	dk_call dk_validate host_triple "dk_call dk_host_triple"

	dk_call dk_echo ""
	dk_call dk_echo " 1) ${host_triple}"
	dk_call dk_echo ""
	dk_call dk_echo " 2) cosmopolitan"
	dk_call dk_echo " 3) Android arm32"
	dk_call dk_echo " 4) Android arm64"
	dk_call dk_echo " 5) Android x86"
	dk_call dk_echo " 6) Android x86_64"
	dk_call dk_echo " 7) Emscripten"
	dk_call dk_echo " 8) Ios arm32"
	dk_call dk_echo " 9) Ios arm64"
	dk_call dk_echo "10) Ios x86"
	dk_call dk_echo "11) Ios x86_64"
	dk_call dk_echo "12) Iossim arm32"
	dk_call dk_echo "13) Iossim arm64"
	dk_call dk_echo "14) Iossim x86"
	dk_call dk_echo "15) Iossim x86_64"
	dk_call dk_echo "16) Linux arm32"
	dk_call dk_echo "17) Linux arm64"
	dk_call dk_echo "18) Linux x86"
	dk_call dk_echo "19) Linux x86_64"
	dk_call dk_echo "20) Mac arm32"
	dk_call dk_echo "21) Mac arm64"
	dk_call dk_echo "22) Mac x86"
	dk_call dk_echo "23) Mac x86_64"
	dk_call dk_echo "24) Raspberry arm32"
	dk_call dk_echo "25) Raspberry arm64"
	dk_call dk_echo "26) Raspberry x86"
	dk_call dk_echo "27) Raspberry x86_64"
	dk_call dk_echo "28) Windows arm32"
	dk_call dk_echo "29) Windows arm64 (clang)"
	dk_call dk_echo "30) Windows x86 (gcc)"
	dk_call dk_echo "31) Windows x86 (clang)"
	dk_call dk_echo "32) Windows x86 (msvc)"
	dk_call dk_echo "33) Windows x86_64 (gcc)"
	dk_call dk_echo "34) Windows x86_64 (clang)"
	dk_call dk_echo "35) Windows x86_64 (ucrt)"
	dk_call dk_echo "36) Windows x86_64 (msvc)"
	dk_call dk_echo "37) Exit"
	dk_call dk_echo ""

	dk_call dk_keyboardInput input
	if [ "${input}" = "0" ]; then
		dk_call dk_echo "repeating last selection"
		#dk_call dk_set app 	${_app_)
		#dk_call dk_set os 		${_os_}
		#dk_call dk_set type 	${_type_}
	elif [ "${input}" = "1" ]; then
		dk_call dk_set triple 	${host_triple}
		dk_call dk_set os     	${HOST_OS}
		dk_call dk_set arch  	${HOST_ARCH}
		if [ -n "${host_env-}" ]; then
			dk_call dk_set env  ${HOST_ENV}
		fi
	elif [ "${input}" = "2" ]; then
		dk_call dk_set os "cosmopolitan"
		dk_call dk_set arch "cosmopolitan"
		dk_call dk_set env "cosmopolitan"
	elif [ "${input}" = "3" ]; then
		dk_call dk_set os "android"
		dk_call dk_set arch "arm32"
	elif [ "${input}" = "4" ]; then
		dk_call dk_set os "android"
		dk_call dk_set arch "arm64"
	elif [ "${input}" = "5" ]; then
		dk_call dk_set os "android"
		dk_call dk_set arch "x86"
	elif [ "${input}" = "6" ]; then
		dk_call dk_set os "android"
		dk_call dk_set arch "x86_64"
	elif [ "${input}" = "7" ]; then
		dk_call dk_set os "emscripten"
		dk_call dk_set arch "x86"
	elif [ "${input}" = "8" ]; then
		dk_call dk_set os "ios"
		dk_call dk_set arch "arm32"
	elif [ "${input}" = "9" ]; then
		dk_call dk_set os "ios"
		dk_call dk_set arch "arm64"
	elif [ "${input}" = "10" ]; then
		dk_call dk_set os "ios"
		dk_call dk_set arch "x86"
	elif [ "${input}" = "11" ]; then
		dk_call dk_set os "ios"
		dk_call dk_set arch "x86_64"
	elif [ "${input}" = "12" ]; then
		dk_call dk_set os "iossim"
		dk_call dk_set arch "arm32"
	elif [ "${input}" = "13" ]; then
		dk_call dk_set os "iossim"
		dk_call dk_set arch "arm64"
	elif [ "${input}" = "14" ]; then
		dk_call dk_set os "iossim"
		dk_call dk_set arch "x86"
	elif [ "${input}" = "15" ]; then
		dk_call dk_set os "iossim"
		dk_call dk_set arch "x86_64"
	elif [ "${input}" = "16" ]; then
		dk_call dk_set os "linux"
		dk_call dk_set arch "arm32"
	elif [ "${input}" = "17" ]; then
		dk_call dk_set os "linux"
		dk_call dk_set arch "arm64"
	elif [ "${input}" = "18" ]; then
		dk_call dk_set os "linux"
		dk_call dk_set arch "x86"
	elif [ "${input}" = "19" ]; then
		dk_call dk_set os "linux"
		dk_call dk_set arch "x86_64"
	elif [ "${input}" = "20" ]; then
		dk_call dk_set os "mac"
		dk_call dk_set arch "arm32"
	elif [ "${input}" = "21" ]; then
		dk_call dk_set os "mac"
		dk_call dk_set arch "arm64"
	elif [ "${input}" = "22" ]; then
		dk_call dk_set os "mac"
		dk_call dk_set arch "x86"
	elif [ "${input}" = "23" ]; then
		dk_call dk_set os "mac"
		dk_call dk_set arch "x86_64"
	elif [ "${input}" = "24" ]; then
		dk_call dk_set os "raspberry"
		dk_call dk_set arch "arm32"
	elif [ "${input}" = "25" ]; then
		dk_call dk_set os "raspberry"
		dk_call dk_set arch "arm64"
	elif [ "${input}" = "26" ]; then
		dk_call dk_set os "raspberry"
		dk_call dk_set arch "x86"
	elif [ "${input}" = "27" ]; then
		dk_call dk_set os "raspberry"
		dk_call dk_set arch "x86_64"
	elif [ "${input}" = "28" ]; then
		dk_call dk_set os "win"
		dk_call dk_set arch "arm32"
	elif [ "${input}" = "29" ]; then
		dk_call dk_set os "win"
		dk_call dk_set arch "arm64"
		dk_call dk_set env "clang"
	elif [ "${input}" = "30" ]; then
		dk_call dk_set os "win"
		dk_call dk_set arch "x86"
		dk_call dk_set env "mingw"
	elif [ "${input}" = "31" ]; then
		dk_call dk_set os "win"
		dk_call dk_set arch "x86"
		dk_call dk_set env "clang"
	elif [ "${input}" = "32" ]; then
		dk_call dk_set os "win"
		dk_call dk_set arch "x86"
		dk_call dk_set env "msvc"
	elif [ "${input}" = "33" ]; then
		dk_call dk_set os "win"
		dk_call dk_set arch "x86_64"
		dk_call dk_set env "mingw"
	elif [ "${input}" = "34" ]; then
		dk_call dk_set os "win"
		dk_call dk_set arch "x86_64"
		dk_call dk_set env "clang"
	elif [ "${input}" = "35" ]; then
		dk_call dk_set os "win"
		dk_call dk_set arch "x86_64"
		dk_call dk_set env "ucrt"
	elif [ "${input}" = "36" ]; then
		dk_call dk_set os "win"
		dk_call dk_set arch "x86_64"
		dk_call dk_set env "msvc"
	elif [ "${input}" = "37" ]; then
		dk_call dk_exit 0
	else
		dk_call dk_warning "invalid selection"
	fi

	dk_call dk_assertVar os
	dk_call dk_toUpper ${os} OS
	dk_call dk_set OS ${OS}
	dk_call dk_set ${os} 1
	dk_call dk_set ${OS} 1
	dk_call dk_assertVar OS
	dk_call dk_printVar os
	dk_call dk_printVar OS
	dk_call dk_printVar ${os}
	dk_call dk_printVar ${OS}
	dk_call dk_assertVar arch
	dk_call dk_toUpper ${arch} ARCH
	dk_call dk_set ARCH ${ARCH}
	dk_call dk_set ${arch} 1
	dk_call dk_set ${ARCH} 1
	dk_call dk_assertVar ARCH
	dk_call dk_printVar arch
	dk_call dk_printVar ARCH
	dk_call dk_printVar ${arch}
	dk_call dk_printVar ${ARCH}

	if [ -n "${env-}" ]; then
		dk_call dk_toUpper ${env} ENV
		dk_call dk_set ENV ${ENV}
		dk_call dk_set ${env} 1
		dk_call dk_set ${ENV} 1
		dk_call dk_printVar env
		dk_call dk_printVar ENV
		dk_call dk_printVar ${env}
		dk_call dk_printVar ${ENV}
	fi
		
	if [ -n "${env-}" ]; then
		dk_call dk_set triple "${os}_${arch}_${env}"
		dk_call dk_set TRIPLE "${OS}_${ARCH}_${ENV}"
	else
		dk_call dk_set triple "${os}_${arch}"
		dk_call dk_set TRIPLE "${OS}_${ARCH}"
	fi
	dk_call dk_assertVar triple
	dk_call dk_assertVar TRIPLE
	dk_call dk_set ${triple} 1	
	dk_call dk_set ${TRIPLE} 1	
	dk_call dk_printVar triple
	dk_call dk_printVar TRIPLE
	dk_call dk_printVar ${triple}
	dk_call dk_printVar ${TRIPLE}	

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
