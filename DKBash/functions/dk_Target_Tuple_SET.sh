#!/usr/bin/env sh
############################## DigitalKnob DKBash ################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################


###############################################################################
# dk_Target_Tuple_SET()
#
#
dk_Target_Tuple_SET() {
	dk_debugFunc 0


	dk_call dk_validate Host_Tuple "dk_call dk_Host_Tuple"
	dk_call dk_set default_Target_Env Clang

	dk_call dk_echo ""
	dk_call dk_echo " 1) ${Host_Tuple}_${default_Target_Env}"
	dk_call dk_echo ""
	dk_call dk_echo " 2) Cosmopolitan"
	dk_call dk_echo " 3) Android_Arm32_Clang"
	dk_call dk_echo " 4) Android_Arm64_Clang"
	dk_call dk_echo " 5) Android_x86_Clang"
	dk_call dk_echo " 6) Android_x86_64_Clang"
	dk_call dk_echo " 7) Emscripten_x86_Clang"
	dk_call dk_echo " 8) Ios_Arm32_Clang"
	dk_call dk_echo " 9) Ios_Arm64_Clang"
	dk_call dk_echo "10) Ios_x86_Clang"
	dk_call dk_echo "11) Ios_x86_64_Clang"
	dk_call dk_echo "12) Iossim_Arm32_Clang"
	dk_call dk_echo "13) Iossim_Arm64_Clang"
	dk_call dk_echo "14) Iossim_x86_Clang"
	dk_call dk_echo "15) Iossim_x86_64_Clang"
	dk_call dk_echo "16) Linux_Arm32_Clang"
	dk_call dk_echo "17) Linux_Arm32_Gcc"
	dk_call dk_echo "18) Linux_Arm64_Clang"
	dk_call dk_echo "19) Linux_Arm64_Gcc"
	dk_call dk_echo "20) Linux_x86_Clang"
	dk_call dk_echo "21) Linux_x86_Gcc"
	dk_call dk_echo "22) Linux_x86_64_Clang"
	dk_call dk_echo "23) Linux_x86_64_Gcc"
	dk_call dk_echo "24) Mac_Arm32_Clang"
	dk_call dk_echo "25) Mac_Arm64_Clang"
	dk_call dk_echo "26) Mac_x86_Clang"
	dk_call dk_echo "27) Mac_x86_64_Clang"
	dk_call dk_echo "28) Raspberry_Arm32_Clang"
	dk_call dk_echo "29) Raspberry_Arm32_Gcc"
	dk_call dk_echo "30) Raspberry_Arm64_Clang"
	dk_call dk_echo "31) Raspberry_Arm64_Gcc"
	dk_call dk_echo "32) Windows_Arm32_Clang"
	dk_call dk_echo "33) Windows_Arm64_Clang"
	dk_call dk_echo "34) Windows_x86_Clang"
	dk_call dk_echo "35) Windows_x86_Gcc"
	dk_call dk_echo "36) Windows_x86_Msvc"
	dk_call dk_echo "37) Windows_x86_64_Clang"
	dk_call dk_echo "38) Windows_x86_64_Gcc"
	dk_call dk_echo "39) Windows_x86_64_Msvc"
	dk_call dk_echo "40) Windows_x86_64_Ucrt"
	dk_call dk_echo "41) Go Back"
	dk_call dk_echo "42) Exit"
	dk_call dk_echo ""

	dk_call dk_keyboardInput input
	if [ "${input}" = "0" ]; then
		dk_call dk_echo "repeating last selection"
		#dk_call dk_set Target_App 	${_Target_App_)
		#dk_call dk_set Target_Os 	${_Target_Os_}
		#dk_call dk_set Target_Type ${_Target_Type_}
	elif [ "${input}" = "1" ]; then
		dk_call dk_set Target_Tuple 	${Host_Tuple}
		dk_call dk_set Target_Os     	${Host_Os}
		dk_call dk_set Target_Arch  	${Host_Arch}
		if [ -n "${default_Target_Env-}" ]; then
			dk_call dk_set Target_Env  ${default_Target_Env}
		fi
	elif [ "${input}" = "2" ]; then
		dk_call dk_set Target_Os "Cosmopolitan"
		dk_call dk_set Target_Arch "Cosmopolitan"
		dk_call dk_set Target_Env "Cosmopolitan"
	elif [ "${input}" = "3" ]; then
		dk_call dk_set Target_Os "Android"
		dk_call dk_set Target_Arch "Arm32"
		dk_call dk_set Target_Env "Clang"
	elif [ "${input}" = "4" ]; then
		dk_call dk_set Target_Os "Android"
		dk_call dk_set Target_Arch "Arm64"
		dk_call dk_set Target_Env "Clang"
	elif [ "${input}" = "5" ]; then
		dk_call dk_set Target_Os "Android"
		dk_call dk_set Target_Arch "X86"
		dk_call dk_set Target_Env "Clang"
	elif [ "${input}" = "6" ]; then
		dk_call dk_set Target_Os "Android"
		dk_call dk_set Target_Arch "X86_64"
		dk_call dk_set Target_Env "Clang"
	elif [ "${input}" = "7" ]; then
		dk_call dk_set Target_Os "Emscripten"
		dk_call dk_set Target_Arch "X86"
		dk_call dk_set Target_Env "Clang"
	elif [ "${input}" = "8" ]; then
		dk_call dk_set Target_Os "Ios"
		dk_call dk_set Target_Arch "Arm32"
		dk_call dk_set Target_Env "Clang"
	elif [ "${input}" = "9" ]; then
		dk_call dk_set Target_Os "Ios"
		dk_call dk_set Target_Arch "Arm64"
		dk_call dk_set Target_Env "Clang"
	elif [ "${input}" = "10" ]; then
		dk_call dk_set Target_Os "Ios"
		dk_call dk_set Target_Arch "X86"
		dk_call dk_set Target_Env "Clang"
	elif [ "${input}" = "11" ]; then
		dk_call dk_set Target_Os "Ios"
		dk_call dk_set Target_Arch "X86_64"
		dk_call dk_set Target_Env "Clang"
	elif [ "${input}" = "12" ]; then
		dk_call dk_set Target_Os "Iossim"
		dk_call dk_set Target_Arch "Arm32"
		dk_call dk_set Target_Env "Clang"
	elif [ "${input}" = "13" ]; then
		dk_call dk_set Target_Os "Iossim"
		dk_call dk_set Target_Arch "Arm64"
		dk_call dk_set Target_Env "Clang"
	elif [ "${input}" = "14" ]; then
		dk_call dk_set Target_Os "Iossim"
		dk_call dk_set Target_Arch "X86"
		dk_call dk_set Target_Env "Clang"
	elif [ "${input}" = "15" ]; then
		dk_call dk_set Target_Os "Iossim"
		dk_call dk_set Target_Arch "X86_64"
		dk_call dk_set Target_Env "Clang"
	elif [ "${input}" = "16" ]; then
		dk_call dk_set Target_Os "Linux"
		dk_call dk_set Target_Arch "Arm32"
		dk_call dk_set Target_Env "Clang"
	elif [ "${input}" = "17" ]; then
		dk_call dk_set Target_Os "Linux"
		dk_call dk_set Target_Arch "Arm32"
		dk_call dk_set Target_Env "Gcc"
	elif [ "${input}" = "18" ]; then
		dk_call dk_set Target_Os "Linux"
		dk_call dk_set Target_Arch "Arm64"
		dk_call dk_set Target_Env "Clang"
	elif [ "${input}" = "19" ]; then
		dk_call dk_set Target_Os "Linux"
		dk_call dk_set Target_Arch "Arm64"
		dk_call dk_set Target_Env "Gcc"
	elif [ "${input}" = "20" ]; then
		dk_call dk_set Target_Os "Linux"
		dk_call dk_set Target_Arch "X86"
		dk_call dk_set Target_Env "Clang"
	elif [ "${input}" = "21" ]; then
		dk_call dk_set Target_Os "Linux"
		dk_call dk_set Target_Arch "X86"
		dk_call dk_set Target_Env "Gcc"
	elif [ "${input}" = "22" ]; then
		dk_call dk_set Target_Os "Linux"
		dk_call dk_set Target_Arch "X86_64"
		dk_call dk_set Target_Env "Clang"
	elif [ "${input}" = "23" ]; then
		dk_call dk_set Target_Os "Linux"
		dk_call dk_set Target_Arch "X86_64"
		dk_call dk_set Target_Env "Gcc"
	elif [ "${input}" = "24" ]; then
		dk_call dk_set Target_Os "Mac"
		dk_call dk_set Target_Arch "Arm32"
		dk_call dk_set Target_Env "Clang"
	elif [ "${input}" = "25" ]; then
		dk_call dk_set Target_Os "Mac"
		dk_call dk_set Target_Arch "Arm64"
		dk_call dk_set Target_Env "Clang"
	elif [ "${input}" = "26" ]; then
		dk_call dk_set Target_Os "Mac"
		dk_call dk_set Target_Arch "X86"
		dk_call dk_set Target_Env "Clang"
	elif [ "${input}" = "27" ]; then
		dk_call dk_set Target_Os "Mac"
		dk_call dk_set Target_Arch "X86_64"
		dk_call dk_set Target_Env "Clang"
	elif [ "${input}" = "28" ]; then
		dk_call dk_set Target_Os "Raspberry"
		dk_call dk_set Target_Arch "Arm32"
		dk_call dk_set Target_Env "Clang"
	elif [ "${input}" = "29" ]; then
		dk_call dk_set Target_Os "Raspberry"
		dk_call dk_set Target_Arch "Arm64"
		dk_call dk_set Target_Env "Clang"
	elif [ "${input}" = "30" ]; then
		dk_call dk_set Target_Os "Raspberry"
		dk_call dk_set Target_Arch "X86"
		dk_call dk_set Target_Env "Clang"
	elif [ "${input}" = "31" ]; then
		dk_call dk_set Target_Os "Raspberry"
		dk_call dk_set Target_Arch "X86_64"
		dk_call dk_set Target_Env "Clang"
	elif [ "${input}" = "32" ]; then
		dk_call dk_set Target_Os "Win"
		dk_call dk_set Target_Arch "Arm32"
		dk_call dk_set Target_Env "Clang"
	elif [ "${input}" = "33" ]; then
		dk_call dk_set Target_Os "Win"
		dk_call dk_set Target_Arch "Arm64"
		dk_call dk_set Target_Env "Clang"
	elif [ "${input}" = "34" ]; then
		dk_call dk_set Target_Os "Win"
		dk_call dk_set Target_Arch "X86"
		dk_call dk_set Target_Env "Clang"
	elif [ "${input}" = "35" ]; then
		dk_call dk_set Target_Os "Win"
		dk_call dk_set Target_Arch "X86"
		dk_call dk_set Target_Env "Gcc"
	elif [ "${input}" = "36" ]; then
		dk_call dk_set Target_Os "Win"
		dk_call dk_set Target_Arch "X86"
		dk_call dk_set Target_Env "Msvc"
	elif [ "${input}" = "37" ]; then
		dk_call dk_set Target_Os "Win"
		dk_call dk_set Target_Arch "X86_64"
		dk_call dk_set Target_Env "Clang"
	elif [ "${input}" = "38" ]; then
		dk_call dk_set Target_Os "Win"
		dk_call dk_set Target_Arch "X86_64"
		dk_call dk_set Target_Env "Gcc"
	elif [ "${input}" = "39" ]; then
		dk_call dk_set Target_Os "Win"
		dk_call dk_set Target_Arch "X86_64"
		dk_call dk_set Target_Env "Msvc"
	elif [ "${input}" = "40" ]; then
		dk_call dk_set Target_Os "Win"
		dk_call dk_set Target_Arch "X86_64"
		dk_call dk_set Target_Env "Ucrt"
	elif [ "${input}" = "41" ]; then
		unset Target_App
		return 1
	elif [ "${input}" = "42" ]; then
		dk_call dk_exit 0
	else
		dk_call dk_warning "invalid selection"
	fi

	dk_call dk_assertVar Target_Os
	dk_call dk_set ${Target_Os} 1
	dk_call dk_assertVar Target_Arch
	dk_call dk_set ${Target_Arch} 1

	if [ -n "${Target_Env-}" ]; then
		dk_call dk_set ${Target_Env} 1
	fi
		
	if [ -n "${Target_Env-}" ]; then
		dk_call dk_set Target_Tuple "${Target_Os}_${Target_Arch}_${Target_Env}"
	else
		dk_call dk_set Target_Tuple "${Target_Os}_${Target_Arch}"
	fi
	dk_call dk_assertVar Target_Tuple
	dk_call dk_set ${Target_Tuple} 1		

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
	#dk_call dk_Target_Tuple
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_Target_Tuple_SET
}
