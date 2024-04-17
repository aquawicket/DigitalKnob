# dk_include_guard()

##################################################################################
# dk_remove_extension(<filepath>)
#
#
dk_remove_extension () {
	dk_verbose "dk_remove_extension($*)"
	[ $# -ne 1 ] && dk_error "Incorrect number of parameters"
	
	filepath="$1"
	filepath="${filepath%.*}"									    # remove everything past last dot
	[ "${filepath##*.}" = "tar" ] &&	filepath="${filepath%.*}"	# if .tar remove everything past last dot
}