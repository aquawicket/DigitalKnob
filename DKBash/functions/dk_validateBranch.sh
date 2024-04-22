# dk_includeGuard()

##################################################################################
# dk_validateBranch()
#
#
dk_validateBranch () {
	dk_verbose "dk_validateBranch($*)"
	[ $# -ne 0 ] && dk_error "Incorrect number of parameters"

	# If the current folder matches the current branch set DKBRANCH, default to Development
	
	FOLDER="$(basename $(pwd))"
	DKBRANCH="Development"
	
	[ -z $DIGITALKNOB_DIR ] && dk_getDKPaths
	if dk_fileExists "$DIGITALKNOB_DIR"/"$FOLDER"/.git; then
		BRANCH="$($GIT_EXE rev-parse --abbrev-ref HEAD)"
		if [ "$BRANCH" = "$FOLDER" ]; then
			DKBRANCH="$FOLDER"
		fi
	fi
	dk_debug DKBRANCH
	
	DKBRANCH_DIR="$DIGITALKNOB_DIR/$DKBRANCH"
	dk_debug  DKBRANCH_DIR
	
	DKCMAKE_DIR="$DKBRANCH_DIR/DKCMake"
	dk_debug  DKCMAKE_DIR
	
	DK3RDPARTY_DIR="$DKBRANCH_DIR/3rdParty"
	dk_debug DK3RDPARTY_DIR
	
	DKIMPORTS_DIR="$DK3RDPARTY_DIR/_DKIMPORTS"
	dk_debug DKIMPORTS_DIR
	
	DKAPPS_DIR="$DIGITALKNOB_DIR/$DKBRANCH/DKApps"
	dk_debug DKAPPS_DIR
	
	DKPLUGINS_DIR="$DIGITALKNOB_DIR/$DKBRANCH/DKPlugins"
	dk_debug DKPLUGINS_DIR

	# make sure script is running from DKBRANCH_DIR
	#if ! [ "$SCRIPT_DIR" = "$DKBRANCH_DIR" ]; then
	#	if ! dk_fileExists $DKBRANCH_DIR/$SCRIPT_NAME; then
	#		dk_debug "$DKBRANCH_DIR/$SCRIPT_NAME"
	#		cp $SCRIPT_DIR/$SCRIPT_NAME $DKBRANCH_DIR/$SCRIPT_NAME
	#	fi
	#	dk_echo
	#	dk_info "RELOADING SCRIPT TO -> $DKBRANCH_DIR/$SCRIPT_NAME"
	#	read -p "Press enter to continue"
	#	clear
	#	if dk_fileExists $DKBRANCH_DIR/$SCRIPT_NAME; then
	#		rm $SCRIPT_DIR/$SCRIPT_NAME
	#	fi
	#	$DKBRANCH_DIR/$SCRIPT_NAME
	#	exit
	#fi
}