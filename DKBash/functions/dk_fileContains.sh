# dk_include_guard()

##################################################################################
# dk_fileContains(file, string)
#
#
dk_fileContains() {
	if [ -z "$2" ]; then
		dk_error "file_contains <file.ext> <string> requires 2 parameters"
		return $false
	fi
		
	grep -q "$2" "$1"
}