echo "$0 $*"
#[ -n "$include_dk_" ] && exit || export readonly include_dk_=1
[ -z "$DKINIT" ] && . ../../../DKBash/functions/DK.sh #$0

##################################################################################
# dk_installGit()
#
#
dk_installGit() {
	dk_debugFunc 0

	
	if ! dk_commandExists git; then
		dk_install git
	fi
	
	GIT_EXE=$(command -v git)
	[ -e ${GIT_EXE} ] || dk_error "GIT_EXE is invalid"
	
	dk_printVar GIT_EXE
}