# dk_include_guard()

##################################################################################
# dk_pick_update()
#
#
dk_pick_update() {
	dk_verbose "dk_pick_update($*)"
	[ $# -ne 0 ] && dk_error "Incorrect number of parameters"

	dk_read_cache
	
	dk_echo
	dk_check_remote
	dk_echo
	
	#dk_debug _APP_
	#dk_debug _TARGET_OS_ 
	#dk_debug _TYPE_
	
	if [ $behind -lt 1 ]; then
		if [ -n "${_APP_-}" ] && [ -n "${_TARGET_OS_-}" ] && [ -n "${_TYPE_-}s" ]; then
			dk_echo " 0) Repeat cache [$_APP_ - $_TARGET_OS_ - $_TYPE_]"
		fi
		dk_echo " 1) Git Update"   
		dk_echo " 2) Git Commit"
		dk_echo " 3) Push assets"
		dk_echo " 4) Pull assets"
		dk_echo " 5) Reset All"
		dk_echo " 6) Remove All"
		dk_echo " 7) Clear Screen"
		dk_echo " 8) Clear cmake cache and .tmp files"
		dk_echo " 9) Reload"
		dk_echo "10) Exit"
		dk_echo
		dk_echo " Press Enter To Skip"
	else
		dk_warning "Your local repository is behind, please git update"
		dk_echo
		dk_echo "${red}" 
		if [ -n "$_APP_" ] && [ -n "$_TARGET_OS_" ] && [ -n "$_TYPE_" ]; then
			dk_echo " 0) Repeat cache [$_APP_ - $_TARGET_OS_ - $_TYPE_]"
		fi
		dk_echo "${green}"
		dk_echo " 1) Git Update"
		dk_echo "${red}"  
		dk_echo " 2) Git Commit"
		dk_echo " 3) Push assets"
		dk_echo " 4) Pull assets"
		dk_echo " 5) Reset All"
		dk_echo " 6) Remove All"
		dk_echo " 7) Clear Screen"
		dk_echo " 8) Clear cmake cache and .tmp files"
		dk_echo " 9) Reload"
		dk_echo "10) Exit"
		dk_echo
		dk_echo "Press Enter To Skip"
		dk_echo "${clr}"
	fi
	
	read input
	if [ "$input" = "0" ]; then
		dk_echo "repeating last selection"
		APP=$_APP_
		TARGET_OS=$_TARGET_OS_
		TYPE=$_TYPE_
		UPDATE=1
	elif [ "$input" = "1" ]; then
		dk_git_update
	elif [ "$input" = "2" ]; then
		dk_git_commit
	elif [ "$input" = "3" ]; then
		dk_push_assets
	elif [ "$input" = "4" ]; then
		dk_pull_assets
	elif [ "$input" = "5" ]; then
		dk_reset_all
	elif [ "$input" = "6" ]; then
		dk_remove_all
	elif [ "$input" = "7" ]; then
		clear
	elif [ "$input" = "8" ]; then
		dk_clear_cmake_cache
		dk_delete_temp_files
	elif [ "$input" = "9" ]; then
		dk_reload
	elif [ "$input" = "10" ]; then
		exit 0	
	elif [ "$input" = "" ]; then
		UPDATE=1
	else
		dk_warning "invalid selection"
	fi
}