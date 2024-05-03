echo "$0 $*"
#[ -n "$include_dk_test" ] && exit || export readonly include_dk_test=1
[ -z "$DKINIT" ] && . ./DK.sh #$0


################################################################################
# dk_hexToVariable(<name> <hex>)
#
#    reference: https://www.ascii-code.com
#               https://www.gnu.org/software/bash/manual/html_node/ANSI_002dC-Quoting.html#ANSI_002dC-Quoting
#               https://unix.stackexchange.com/a/347410
#
dk_hexToVariable () {
	dk_debugFunc
	[ $# -ne 2 ] && dk_error "Incorrect number of parameters"
	
	# 0x1b  prints as  '\x1b'
	# ${2//0x/x}  removes any starting 0 and changes any 0x to x
	export $1=$(printf '\%s' ${2//0x/x})
}