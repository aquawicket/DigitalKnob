# dk_include_guard()

##################################################################################
# dk_git_commit()
#
#
function dk_git_commit() {	
	dk_debug "dk_git_commit($@)"
	echo "Please enter some details about this commit, Then press ENTER."
	read message
	
	cd $DKBRANCH_DIR
	
	STORE=$($GIT_EXE config credential.helper)
	dk_print_var STORE
	if [ -z "$STORE" ]; then
		$GIT_EXE config --global credential.helper store
		echo ""
		echo "git credential.helper is now set to store"
		echo ""
	fi
	
	USER_EMAIL=$($GIT_EXE config --global user.email)
	if [ -z "$USER_EMAIL" ]; then
		echo ""
		echo "please enter an email address"
		read input
		$GIT_EXE config --global user.email "$input"
		echo ""
		echo "git user.email '$input' saved"
		echo ""
	fi

	USER_NAME=$($GIT_EXE config --global user.name)
	if [ -z "USER_NAME" ]; then
		echo ""
		echo "please enter a username"
		read input
		$GIT_EXE config --global user.name "$input"
		echo ""
		echo "git user.name '$input' saved"
		echo ""
	fi
	
	if [ -z "$message" ]; then
		message="git commit"
	fi
	
	echo ""
	echo "git commit \"${message}\""
	if ! dk_confirm; then return; fi
	
	dk_call $GIT_EXE commit -a -m "${message}"
    dk_call $GIT_EXE push
}