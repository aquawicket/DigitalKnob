echo "$0 $*"
#[ -n "$include_dk_test" ] && exit || export readonly include_dk_test=1
[ -z "$DKINIT" ] && . ./DK.sh #$0


##################################################################################
# dk_pullAssets()
#
#
dk_pullAssets () {
	dk_debugFunc
	[ $# -ne 0 ] && dk_error "Incorrect number of parameters"
	
	dk_confirm || return 0

	dk_error "not implemented,  TODO"
}