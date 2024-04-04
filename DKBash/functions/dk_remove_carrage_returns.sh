#include_guard()

##################################################################################
# dk_remove_carrage_returns()
#
#
function dk_remove_carrage_returns(){
	dk_debug "dk_remove_carrage_returns("$@")"
	in=$1
	out=$(echo $in | tr -d '\r')
	# carrage returns are removed from <out>
}