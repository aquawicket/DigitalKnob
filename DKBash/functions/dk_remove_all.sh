# dk_include_guard()

##################################################################################
# dk_remove_all()
#
#
dk_remove_all () {
	dk_verbose "dk_remove_all($*)"
	[ $# -gt 1 ] && dk_error "Too many parameters"
	
	if ! [ "$1" = "wipe" ]; then	
		clear
		dk_echo
		dk_echo
		dk_echo "Do you want to remove the entire local repository . . . ?"
		dk_echo "This will delete digitalknob, Save any changes"
		dk_echo "you wish to commit or save beforehand."		
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
			return 1;
		fi
		
		dk_info "RELOCATING SCRIPT TO -> $DIGITALKNOB_DIR/$SCRIPT_NAME"
		cp "$SCRIPT_DIR"/"$SCRIPT_NAME" "$DIGITALKNOB_DIR"/"$SCRIPT_NAME"
		. "$DIGITALKNOB_DIR/$SCRIPT_NAME" dk_remove_all wipe
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
		dk_info "DELETING $DKBRANCH_DIR . . . ."
		rm -r -f "$DKBRANCH_DIR"
		dk_info "done."
		
		# wait for the folders to get deleted
		sleep 3
		
		if dk_file_exists "$DKBRANCH_DIR"; then
			dk_error "Oh no, the BRANCH folder is still there! :( "
		fi
	fi
}