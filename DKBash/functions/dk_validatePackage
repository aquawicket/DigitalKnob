echo "$0 $*"
#[ -n "$include_dk_test" ] && exit || export readonly include_dk_test=1
[ -z "$DKINIT" ] && . ./DK.sh #$0


##################################################################################
# dk_validatePackage(<command> <package>)
#
#
dk_validatePackage () {
	dk_debugFunc
	[ $# -ne 2 ] && dk_error "Incorrect number of parameters"
	
	if ! dk_commandExists "$1"; then
		dk_install "$2"
	fi
}