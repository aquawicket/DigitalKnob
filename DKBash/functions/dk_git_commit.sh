# dk_include_guard()

##################################################################################
# dk_git_commit()
#
#
dk_git_commit () {	
	dk_verbose "dk_git_commit($*)"
	[ $# -ne 0 ] && dk_error "Incorrect number of parameters"
	
	dk_info "Please enter some details about this commit, Then press ENTER."
	read message
	
	cd "$DKBRANCH_DIR" #|| dk_error "cd \$DKBRANCH_DIR failed!"
	
	STORE=$($GIT_EXE config credential.helper)
	dk_debug STORE
	if [ -z "$STORE" ]; then
		$GIT_EXE config --global credential.helper store
		dk_echo
		dk_info "git credential.helper is now set to store"
		dk_echo
	fi
	
	USER_EMAIL=$($GIT_EXE config --global user.email)
	if [ -z "$USER_EMAIL" ]; then
		dk_echo
		dk_info "please enter an email address"
		read input
		$GIT_EXE config --global user.email "$input"
		dk_echo
		dk_info "git user.email '$input' saved"
		dk_echo
	fi

	USER_NAME=$($GIT_EXE config --global user.name)
	if [ -z "USER_NAME" ]; then
		dk_echo
		dk_info "please enter a username"
		read input
		$GIT_EXE config --global user.name "$input"
		dk_echo
		dk_info "git user.name '$input' saved"
		dk_echo
	fi
	
	if [ -z "$message" ]; then
		message="git commit"
	fi
	
	dk_echo
	dk_info "git commit \"${message}\""
	dk_confirm || return 0
	
	#dk_call "$GIT_EXE" commit -a -m "${message}"
	"$GIT_EXE" commit -a -m "${message}"
    dk_call "$GIT_EXE" push
}