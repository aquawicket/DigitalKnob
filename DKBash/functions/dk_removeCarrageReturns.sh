# dk_includeGuard()

##################################################################################
# dk_removeCarrageReturns(<input>)
#
#
dk_removeCarrageReturns () {
	dk_debugFunc
	[ $# -ne 0 ] && dk_error "Incorrect number of parameters"

	in=$1
	out=$(echo "$in" | tr -d '\r')
	# carrage returns are removed from <out>
}