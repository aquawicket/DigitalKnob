# dk_include_guard()

##################################################################################
# dk_remove_from_file()
#
#
dk_remove_from_file () {
	if [ -z "$2" ]; then
		dk_error "remove_from_file <string> <file.ext> requires 2 parameters"
		return $false
	fi
		
	sed -i -e "/$1/d" $2
}