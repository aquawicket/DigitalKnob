#include_guard()

##################################################################################
# dk_pick_os()
#
#
function dk_pick_os() {
	dk_debug "dk_pick_os("$@")"
	echo ""
	echo "${APP} ${TARGET_OS} ${TYPE}"
	
	echo ""	
    echo " 1) $HOST_TRIPLE"
	echo ""
	echo " 2) android arm32"
	echo " 3) android arm64"
	echo " 4) android x86"
	echo " 5) android x86_64"
	echo " 6) emscripten"
	echo " 7) ios arm32"
	echo " 8) ios arm64"
	echo " 9) ios x86"
	echo "10) ios x86_64"
	echo "11) iossim arm32"
	echo "12) iossim arm64"
	echo "13) iossim x86"
	echo "14) iossim x86_64"
	echo "15) linux arm32"
	echo "16) linux arm64"
	echo "17) linux x86"
	echo "18) linux x86_64"
	echo "19) mac arm32"
	echo "20) mac arm64"
	echo "21) mac x86"
	echo "22) mac x86_64"
	echo "23) raspberry arm32"
	echo "24) raspberry arm64"
	echo "25) raspberry x86"
	echo "26) raspberry x86_64"
	echo "27) win arm32"
	echo "28) win arm64"
	echo "29) win x86"
	echo "30) win x86_64"
	echo "31) Clear Screen"
	echo "32) Go Back"
	echo "33) Exit"
	echo "" 
	
	read input
	if [ "$input" == "1" ]; then
		TARGET_OS="$HOST_TRIPLE"
	elif [ "$input" == "2" ]; then
		TARGET_OS="android_arm32"
	elif [ "$input" == "3" ]; then
		TARGET_OS="android_arm64"
	elif [ "$input" == "4" ]; then
		TARGET_OS="android_x86"
	elif [ "$input" == "5" ]; then
		TARGET_OS="android_x86_64"
	elif [ "$input" == "6" ]; then
		TARGET_OS="emscripten"
	elif [ "$input" == "7" ]; then
		TARGET_OS="ios_arm32"
	elif [ "$input" == "8" ]; then
		TARGET_OS="ios_arm64"
	elif [ "$input" == "9" ]; then
		TARGET_OS="ios_x86"
	elif [ "$input" == "10" ]; then
		TARGET_OS="ios_x86_64"
	elif [ "$input" == "11" ]; then
		TARGET_OS="iossim_arm32"
	elif [ "$input" == "12" ]; then
		TARGET_OS="iossim_arm64"
	elif [ "$input" == "13" ]; then
		TARGET_OS="iossim_x86"
	elif [ "$input" == "14" ]; then
		TARGET_OS="iossim_x86_64"
	elif [ "$input" == "15" ]; then
		TARGET_OS="linux_arm32"
	elif [ "$input" == "16" ]; then
		TARGET_OS="linux_arm64"
	elif [ "$input" == "17" ]; then
		TARGET_OS="linux_x86"
	elif [ "$input" == "18" ]; then
		TARGET_OS="linux_x86_64"
	elif [ "$input" == "19" ]; then
		TARGET_OS="mac_arm32"
	elif [ "$input" == "20" ]; then
		TARGET_OS="mac_arm64"
	elif [ "$input" == "21" ]; then
		TARGET_OS="mac_x86"
	elif [ "$input" == "22" ]; then
		TARGET_OS="mac_x86_64"
	elif [ "$input" == "23" ]; then
		TARGET_OS="raspberry_arm32"
	elif [ "$input" == "24" ]; then
		TARGET_OS="raspberry_arm64"
	elif [ "$input" == "25" ]; then
		TARGET_OS="raspberry_x86"
	elif [ "$input" == "26" ]; then
		TARGET_OS="raspberry_x64"
	elif [ "$input" == "27" ]; then
		TARGET_OS="windows_arm32"
	elif [ "$input" == "28" ]; then
		TARGET_OS="windows_arm64"
	elif [ "$input" == "29" ]; then
		TARGET_OS="windows_x86"
	elif [ "$input" == "30" ]; then
		TARGET_OS="windows_x86_64"
	elif [ "$input" == "31" ]; then
		clear
	elif [ "$input" == "32" ]; then
		APP=
	elif [ "$input" == "33" ]; then
		exit 0
	else
		echo "invalid selection"
	fi
}