#include_guard()

##################################################################################
# dk_remove_all()
#
#
function dk_remove_all() {
	dk_debug "dk_remove_all("$@")"
	if ! [ "$1" == "wipe" ]; then	
		clear
		echo ""
		echo ""
		echo "Do you want to remove the entire local repository . . . ?"
		echo "This will delete digitalknob, Save any changes"
		echo "you wish to commit or save beforehand."
		echo ""
		
		if ! dk_confirm; then return; fi
		
		# first we need to relocate this file up one directory
		# make sure script is running from DKBRANCH_DIR
		if ! [ $SCRIPT_DIR == $DKBRANCH_DIR ]; then
			echo "WARNING: this file isn't running from the branch directory"
			echo "Is must be in the branch directory to continue."
			echo "SCRIPT_DIR = $SCRIPT_DIR"
			print_var DKBRANCH_DIR
			return 1;
		fi
		
		echo "RELOCATING SCRIPT TO -> $DIGITALKNOB_DIR/$SCRIPT_NAME"
		cp $SCRIPT_DIR/$SCRIPT_NAME $DIGITALKNOB_DIR/$SCRIPT_NAME
		source "$DIGITALKNOB_DIR/$SCRIPT_NAME" remove_all wipe
		exit
	else	
		#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
		#:wipe
		
		#do we need sudo rights?
		#do we need to kill any processes?
		#do we need to uninstall any apps?
		#do we need to remove any environment variables?
		
		cd $DIGITALKNOB_DIR
		echo ""
		echo "DELETING $DKBRANCH_DIR . . . ."
		rm -r -f $DKBRANCH_DIR
		echo "done."
		
		# wait for the folders to get deleted
		sleep 3
		
		if dk_file_exists $DKBRANCH_DIR; then
			echo "Oh no, the BRANCH folder is still there! :( "
		fi
	fi
}