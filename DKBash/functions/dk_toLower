echo "$0 $*"
#[ -n "$include_dk_test" ] && exit || export readonly include_dk_test=1
[ -z "$DKINIT" ] && . ./DK.sh #$0


##################################################################################
# dk_toLower(<variable>)
#
#
dk_toLower () {
	dk_debugFunc
	[ $# -ne 1 ] && dk_error "Incorrect number of parameters"
	
	dk_defined $1 || dk_error "dk_toLower($*): $1 is not defined"

	eval value='$'{$1}
	value=$(echo "$value" | tr '[:upper:]' '[:lower:]')

	eval "$1=$value"
}