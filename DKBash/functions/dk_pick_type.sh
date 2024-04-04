#include_guard()

##################################################################################
# dk_pick_type()
#
#
function dk_pick_type() {
	dk_debug "Pick_Type($@)"
	echo ""
	echo "${APP} ${TARGET_OS} ${TYPE}"
	
	echo ""	
    echo " 1) Debug"
	echo " 2) Release"
	echo " 3) All"
	echo " 4) Clear Screen"
	echo " 5) Go Back"
	echo " 6) Exit"
	echo ""
	
	read input
	if [ "$input" == "1" ]; then
		TYPE="Debug"
	elif [ "$input" == "2" ]; then
		TYPE="Release"
	elif [ "$input" == "3" ]; then
		TYPE="All"
	elif [ "$input" == "4" ]; then
		clear
	elif [ "$input" == "5" ]; then
		TARGET_OS=
	elif [ "$input" == "6" ]; then
		exit 0
	else
		echo "invalid selection"
	fi
}