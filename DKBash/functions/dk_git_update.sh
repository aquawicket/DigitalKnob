# dk_include_guard()

##################################################################################
# dk_git_update()
#
#
function dk_git_update() {
	dk_debug "dk_git_update($@)"
	if ! [ "$1" == "NO_CONFIRM" ]; then
		echo "Git Update? Any local changes will be lost."
		if ! dk_confirm; then return; fi
	fi

	if [[ ! -d "$DKBRANCH_DIR/.git" ]]; then
		dk_call $GIT_EXE clone https://github.com/aquawicket/DigitalKnob.git $DKBRANCH_DIR
	fi
	dk_call cd $DKBRANCH_DIR
	dk_call $GIT_EXE pull --all
	dk_call $GIT_EXE checkout -- .
	dk_call $GIT_EXE checkout $DKBRANCH
	if [[ "$?" == "0" ]]; then
		echo "$DKBRANCH branch selected"
	else
	echo "Remote has no $DKBRANCH branch. Creating..."
		dk_call $GIT_EXE checkout -b $DKBRANCH main
		dk_call $GIT_EXE push --set-upstream origin $DKBRANCH
	fi
	dk_call chmod +x $DKBRANCH_DIR/build.sh
}