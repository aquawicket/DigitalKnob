# dk_include_guard()

##################################################################################
# dk_validate_branch()
#
#
###### dk_validate_branch ######
dk_validate_branch() {
	dk_debug "dk_validate_branch($@)"
	# If the current folder matches the current branch set DKBRANCH, default to Development
	
	FOLDER=$(basename $(pwd))
	DKBRANCH=Development
	
	if dk_file_exists $DIGITALKNOB_DIR$FOLDER.git; then
		BRANCH=$($GIT_EXE rev-parse --abbrev-ref HEAD)
		if [[ $BRANCH == $FOLDER ]]; then
			DKBRANCH=$FOLDER
		fi
	fi
	dk_print_var DKBRANCH
	
	DKBRANCH_DIR=$DIGITALKNOB_DIR/$DKBRANCH
	dk_print_var  DKBRANCH_DIR
	
	DKCMAKE_DIR=$DKBRANCH_DIR/DKCMake
	dk_print_var  DKCMAKE_DIR
	
	DK3RDPARTY_DIR=$DKBRANCH_DIR/3rdParty
	dk_print_var DK3RDPARTY_DIR
	
	DKIMPORTS_DIR=$DK3RDPARTY_DIR/_DKIMPORTS
	dk_print_var DKIMPORTS_DIR
	
	DKAPPS_DIR=$DIGITALKNOB_DIR/$DKBRANCH/DKApps
	dk_print_var DKAPPS_DIR
	
	DKPLUGINS_DIR=$DIGITALKNOB_DIR/$DKBRANCH/DKPlugins
	dk_print_var DKPLUGINS_DIR

	# make sure script is running from DKBRANCH_DIR
	#if ! [[ $SCRIPT_DIR == $DKBRANCH_DIR ]]; then
	#	if ! dk_file_exists $DKBRANCH_DIR$SCRIPT_NAME; then
	#		echo $DKBRANCH_DIR$SCRIPT_NAME
	#		cp $SCRIPT_DIR$SCRIPT_NAME $DKBRANCH_DIR$SCRIPT_NAME
	#	fi
	#	echo .
	#	echo RELOADING SCRIPT TO - $DKBRANCH_DIR$SCRIPT_NAME
	#	read -p Press enter to continue
	#	clear
	#	if dk_file_exists $DKBRANCH_DIR$SCRIPT_NAME; then
	#		rm $SCRIPT_DIR$SCRIPT_NAME
	#	fi
	#	$DKBRANCH_DIR$SCRIPT_NAME
	#	exit
	#fi
}