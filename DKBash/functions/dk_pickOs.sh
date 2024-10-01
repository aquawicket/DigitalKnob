#!/bin/sh
[ -z "${DKINIT}" ] && . "${DKBASH_FUNCTIONS_DIR_}DK.sh"


##################################################################################
# dk_pickOs()
#
#
dk_pickOs() {
	dk_debugFunc 0

	dk_echo
	dk_echo "${APP} ${triple-} ${TYPE-}"
	dk_echo	""
    dk_echo " 1) ${HOST_TRIPLE-}"
	dk_echo
	dk_echo " 2) Android arm32"
	dk_echo " 3) Android arm64"
	dk_echo " 4) Android x86"
	dk_echo " 5) Android x86_64"
	dk_echo " 6) Emscripten"
	dk_echo " 7) Ios arm32"
	dk_echo " 8) Ios arm64"
	dk_echo " 9) Ios x86"
	dk_echo "10) Ios x86_64"
	dk_echo "11) Iossim arm32"
	dk_echo "12) Iossim arm64"
	dk_echo "13) Iossim x86"
	dk_echo "14) Iossim x86_64"
	dk_echo "15) Linux arm32"
	dk_echo "16) Linux arm64"
	dk_echo "17) Linux x86"
	dk_echo "18) Linux x86_64"
	dk_echo "19) Mac arm32"
	dk_echo "20) Mac arm64"
	dk_echo "21) Mac x86"
	dk_echo "22) Mac x86_64"
	dk_echo "23) Raspberry arm32"
	dk_echo "24) Raspberry arm64"
	dk_echo "25) Raspberry x86"
	dk_echo "26) Raspberry x86_64"
	dk_echo "27) Windows arm32"
	dk_echo "28) Windows arm64 (clang)"
	dk_echo "29) Windows x86 (gcc)"
	dk_echo "30) Windows x86 (clang)"
	dk_echo "31) Windows x86 (msvc)"
	dk_echo "32) Windows x86_64 (gcc)"
    dk_echo "33) Windows x86_64 (clang)"
    dk_echo "34) Windows x86_64 (ucrt)"
    dk_echo "35) Windows x86_64 (msvc)"
	dk_echo "36) Clear Screen"
	dk_echo "37) Go Back"
	dk_echo "38) Exit"
	dk_echo
	
	#dk_call dk_keyboardInput choice
	dk_call dk_keyboardInputTimeout choice 1 60
	
	if [ "${choice}" = "1" ]; then
		triple="${HOST_TRIPLE-}"
	elif [ "${choice}" = "2" ]; then
		triple="android_arm32"
	elif [ "${choice}" = "3" ]; then
		triple="android_arm64"
	elif [ "${choice}" = "4" ]; then
		triple="android_x86"
	elif [ "${choice}" = "5" ]; then
		triple="android_x86_64"
	elif [ "${choice}" = "6" ]; then
		triple="emscripten"
	elif [ "${choice}" = "7" ]; then
		triple="ios_arm32"
	elif [ "${choice}" = "8" ]; then
		triple="ios_arm64"
	elif [ "${choice}" = "9" ]; then
		triple="ios_x86"
	elif [ "${choice}" = "10" ]; then
		triple="ios_x86_64"
	elif [ "${choice}" = "11" ]; then
		triple="iossim_arm32"
	elif [ "${choice}" = "12" ]; then
		triple="iossim_arm64"
	elif [ "${choice}" = "13" ]; then
		triple="iossim_x86"
	elif [ "${choice}" = "14" ]; then
		triple="iossim_x86_64"
	elif [ "${choice}" = "15" ]; then
		triple="linux_arm32"
	elif [ "${choice}" = "16" ]; then
		triple="linux_arm64"
	elif [ "${choice}" = "17" ]; then
		triple="linux_x86"
	elif [ "${choice}" = "18" ]; then
		triple="linux_x86_64"
	elif [ "${choice}" = "19" ]; then
		triple="mac_arm32"
	elif [ "${choice}" = "20" ]; then
		triple="mac_arm64"
	elif [ "${choice}" = "21" ]; then
		triple="mac_x86"
	elif [ "${choice}" = "22" ]; then
		triple="mac_x86_64"
	elif [ "${choice}" = "23" ]; then
		triple="raspberry_arm32"
	elif [ "${choice}" = "24" ]; then
		triple="raspberry_arm64"
	elif [ "${choice}" = "25" ]; then
		triple="raspberry_x86"
	elif [ "${choice}" = "26" ]; then
		triple="raspberry_x64"
	elif [ "${choice}" = "27" ]; then
		triple="win_arm32"
	elif [ "${choice}" = "28" ]; then
		triple="win_arm64_clang"
	elif [ "${choice}" = "29" ]; then
		triple="win_x86_mingw"
	elif [ "${choice}" = "30" ]; then
		triple="win_x86_clang"
	elif [ "${choice}" = "31" ]; then
		triple="win_x86_msvc"
	elif [ "${choice}" = "32" ]; then
		triple="win_x86_64_mingw"
	elif [ "${choice}" = "33" ]; then
		triple="win_x86_64_clang"
	elif [ "${choice}" = "34" ]; then
		triple="win_x86_64_ucrt"
	elif [ "${choice}" = "35" ]; then
		triple="win_x86_64_msvc"
	elif [ "${choice}" = "36" ]; then
		dk_clearScreen
	elif [ "${choice}" = "37" ]; then
		APP=
	elif [ "${choice}" = "38" ]; then
		dk_exit 0
	else
		dk_warning "invalid selection"
	fi
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_pickOs
}