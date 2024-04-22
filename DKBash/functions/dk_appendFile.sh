# dk_includeGuard()

##################################################################################
# dk_appendFile(string, file)
#
#
dk_appendFile() {
	if [ -z "$2" ]; then
		dk_error "append_file <string> <file.ext> requires 2 parameters"
		return $false
	fi
	
	echo "$1" >> $2
}