# dk_include_guard()

##################################################################################
# dk_pick_type()
#
#
dk_pick_type() {
	dk_verbose "dk_pick_type($*)"
	[ $# -ne 0 ] && dk_error "Incorrect number of parameters"

	dk_echo
	dk_echo "${APP} ${TARGET_OS} ${TYPE-}"
	dk_echo	
    dk_echo " 1) Debug"
	dk_echo " 2) Release"
	dk_echo " 3) All"
	dk_echo " 4) Clear Screen"
	dk_echo " 5) Go Back"
	dk_echo " 6) Exit"
	dk_echo
	
	read input
	if [ "$input" = "1" ]; then
		TYPE="Debug"
	elif [ "$input" = "2" ]; then
		TYPE="Release"
	elif [ "$input" = "3" ]; then
		TYPE="All"
	elif [ "$input" = "4" ]; then
		clear
	elif [ "$input" = "5" ]; then
		TARGET_OS=
	elif [ "$input" = "6" ]; then
		exit 0
	else
		dk_warning "invalid selection"
	fi
}