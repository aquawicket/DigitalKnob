dk_includeGuard

##################################################################################
# dk_convertToCIdentifier(<input> <output>)
#
#
dk_convertToCIdentifier () {
	dk_debugFunc
	[ $# -ne 2 ] && dk_error "Incorrect number of parameters"
	
	input=$1
	
	#input="${input//[^[:alnum:]]/_}"			# BASH alpha_numeric_replace
	dk_replaceAll "$input" "-" "_" input		# POSIX replace
	dk_replaceAll "$input" "." "_" output		# POSIX replace
	
	dk_debug "output = $output"
	eval "$2=$output"
	#[ $input = "" ]
}