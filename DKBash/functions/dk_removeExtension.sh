dk_includeGuard

##################################################################################
# dk_removeExtension(<filepath>)
#
#
dk_removeExtension () {
	dk_debugFunc
	[ $# -ne 1 ] && dk_error "Incorrect number of parameters"
	
	filepath="$1"
	filepath="${filepath%.*}"									    # remove everything past last dot
	[ "${filepath##*.}" = "tar" ] &&	filepath="${filepath%.*}"	# if .tar remove everything past last dot
}