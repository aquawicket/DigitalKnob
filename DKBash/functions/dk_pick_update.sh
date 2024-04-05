# dk_include_guard()

##################################################################################
# dk_pick_update()
#
#
function dk_pick_update() {
	dk_debug "dk_pick_update($@)"
	dk_read_cache
	
	echo ""
	dk_check_remote
	echo ""
	
	if [[ -n "$_APP_" ]] && [[ -n "$_TARGET_OS_" ]] && [[ -n "$_TYPE_" ]]; then
		echo " 0) Repeat cache [$_APP_ - $_TARGET_OS_ - $_TYPE_]"
	fi
    echo " 1) Git Update"
    echo " 2) Git Commit"
    echo " 3) Push assets"
    echo " 4) Pull assets"
    echo " 5) Reset All"
	echo " 6) Remove All"
    echo " 7) Clear Screen"
    echo " 8) Clear cmake cache and .tmp files"
    echo " 9) Reload"
    echo "10) Exit"
    echo "" 
    echo " Press Enter To Skip"
	
	read input
	if [ "$input" == "0" ]; then
		echo "repeating last selection"
		APP=$_APP_
		TARGET_OS=$_TARGET_OS_
		TYPE=$_TYPE_
		UPDATE=1
	elif [ "$input" == "1" ]; then
		dk_git_update
	elif [ "$input" == "2" ]; then
		dk_git_commit
	elif [ "$input" == "3" ]; then
		dk_push_assets
	elif [ "$input" == "4" ]; then
		dk_pull_assets
	elif [ "$input" == "5" ]; then
		dk_reset_all
	elif [ "$input" == "6" ]; then
		dk_remove_all
	elif [ "$input" == "7" ]; then
		clear
	elif [ "$input" == "8" ]; then
		dk_clear_cmake_cache
		dk_delete_temp_files
	elif [ "$input" == "9" ]; then
		dk_reload
	elif [ "$input" == "10" ]; then
		exit 0	
	elif [ "$input" == "" ]; then
		UPDATE=1
	else
		echo "invalid selection"
	fi
}