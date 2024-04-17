# dk_include_guard()

##################################################################################
# dk_reset_all()
#
#
dk_reset_all () {
	dk_verbose "dk_reset_all($*)"
	[ $# -gt 1 ] && dk_error "Too many parameters"
	
	if ! [ "$1" = "wipe" ]; then
		clear
		dk_echo
		dk_echo
		dk_info "Do you want to reset the entire local repository . . . ?"
		dk_info "This will delete digitalknob, everything will be reset,"
		dk_info "and the repository will be re-cloned. All libraries and tools"
		dk_info "will be redk_downloaded and rebuild from start. Save any changes"
		dk_info "you wish to commit or save beforehand."
		dk_echo
		
		dk_confirm || return 0
		
		# first we need to relocate this file up one directory
		# make sure script is running from DKBRANCH_DIR
		if ! [ "$SCRIPT_DIR" = "$DKBRANCH_DIR" ]; then
			dk_echo "${yellow}"
			dk_echo "WARNING: this file isn't running from the branch directory"
			dk_echo "Is must be in the branch directory to continue."
			dk_echo "SCRIPT_DIR = $SCRIPT_DIR"
			dk_echo "${clr}"			
			dk_debug DKBRANCH_DIR
			return $false;
		fi
		
		dk_info "RELOCATING SCRIPT TO -> $DIGITALKNOB_DIR/$SCRIPT_NAME"
		cp "$SCRIPT_DIR"/"$SCRIPT_NAME" "$DIGITALKNOB_DIR"/"$SCRIPT_NAME"
		exec "$DIGITALKNOB_DIR/$SCRIPT_NAME" dk_reset_all wipe
		exit
	else	
		#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		#:wipe
		
		#do we need sudo rights?
		#do we need to kill any processes?
		#do we need to undk_install any apps?
		#do we need to remove any environment variables?
		
		cd "$DIGITALKNOB_DIR" #|| dk_error "cd $$DIGITALKNOB_DIR failed!"
		dk_echo
		dk_echo "DELETING $DKBRANCH_DIR . . . ."
		dk_call rm -r -f "$DKBRANCH_DIR" #|| dk_error "dk_call rm -r -f $DKBRANCH_DIR failed"
		dk_echo "done."
		
		# wait for the folders to get deleted
		sleep 5

		if dk_file_exists "$DKBRANCH_DIR"; then
			dk_error "Oh no, the BRANCH folder is still there! :( "
		fi
		
		dk_git_update NO_CONFIRM
		
		# wait for build.sh to show up
		sleep 2
		
		if dk_file_exists "$DKBRANCH_DIR"/"$SCRIPT_NAME"; then
			clear
			. "$DKBRANCH_DIR"/"$SCRIPT_NAME" rm -r "$DIGITALKNOB_DIR"/"$SCRIPT_NAME"
			exit
		else
			dk_error "Oh no, the git cloned build.sh still isn't here! :( "
		fi
	fi
}