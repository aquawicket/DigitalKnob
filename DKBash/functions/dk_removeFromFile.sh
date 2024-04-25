# dk_includeGuard

##################################################################################
# dk_removeFromFile()
#
#
dk_removeFromFile() {
	dk_debugFunc
	[ -z "$2" ] && dk_error "remove_from_file <string> <file.ext> requires 2 parameters"

	sed -i -e "/$1/d" $2
}