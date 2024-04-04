#include_guard()

##################################################################################
# dk_reset_all()
#
#
function dk_reset_all() {
	dk_debug "dk_reset_all($@)"
	if ! [ "$1" == "wipe" ]; then
		clear
		echo ""
		echo ""
		echo "Do you want to reset the entire local repository . . . ?"
		echo "This will delete digitalknob, everything will be reset,"
		echo "and the repository will be re-cloned. All libraries and tools"
		echo "will be redownloaded and rebuild from start. Save any changes"
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
			return $false;
		fi
		
		echo "RELOCATING SCRIPT TO -> $DIGITALKNOB_DIR/$SCRIPT_NAME"
		cp $SCRIPT_DIR/$SCRIPT_NAME $DIGITALKNOB_DIR/$SCRIPT_NAME
		source "$DIGITALKNOB_DIR/$SCRIPT_NAME" reset_all wipe
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
		sleep 10

		if dk_file_exists $DKBRANCH_DIR; then
			echo "Oh no, the BRANCH folder is still there! :( "
			exit 1
		fi
		
		git_update NO_CONFIRM
		
		# wait for build.sh to show up
		sleep 2
		
		if dk_file_exists $DKBRANCH_DIR/$SCRIPT_NAME; then
			clear
			source $DKBRANCH_DIR/$SCRIPT_NAME rm -r $DIGITALKNOB_DIR/$SCRIPT_NAME
			exit
		else
			echo "Oh no, the git cloned build.sh still isn't here! :( "
			exit 1
		fi
	fi
}