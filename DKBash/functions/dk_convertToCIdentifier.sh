# dk_include_guard()

##################################################################################
# dk_convertToCIdentifier(<input> <output>)
#
#
dk_convertToCIdentifier () {
	dk_verbose "dk_convertToCIdentifier($*)"
	[ $# -ne 2 ] && dk_error "Incorrect number of parameters"
	
	input=$1
	
	#input="${input//[^[:alnum:]]/_}"			# BASH alpha_numeric_replace
	dk_replace_all "$input" "-" "_" input		# POSIX replace
	dk_replace_all "$input" "." "_" output		# POSIX replace
	
	dk_debug "output = $output"
	eval "$2=$output"
	#[ $input = "" ]
}