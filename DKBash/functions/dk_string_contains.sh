# dk_include_guard()

##################################################################################
# dk_string_contains(<string> <substring>)
#
#
dk_string_contains () {
	dk_verbose "dk_string_contains($*)"
	[ $# -ne 2 ] && dk_error "Incorrect number of parameters"
	
	# https://stackoverflow.com/a/8811800/688352
	string=$1
	substring=$2
	[ "${string#*"$substring"}" != "$string" ]	
}