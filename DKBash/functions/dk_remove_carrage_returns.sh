# dk_include_guard()

##################################################################################
# dk_remove_carrage_returns(<input>)
#
#
dk_remove_carrage_returns () {
	dk_verbose "dk_remove_carrage_returns($*)"
	[ $# -ne 0 ] && dk_error "Incorrect number of parameters"

	in=$1
	out=$(echo "$in" | tr -d '\r')
	# carrage returns are removed from <out>
}