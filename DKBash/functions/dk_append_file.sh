# dk_include_guard()

##################################################################################
# dk_append_file(string, file)
#
#
dk_append_file() {
	if [ -z "$2" ]; then
		dk_error "append_file <string> <file.ext> requires 2 parameters"
		return $false
	fi
	
	echo "$1" >> $2
}