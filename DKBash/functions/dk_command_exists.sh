#include_guard()

##################################################################################
# dk_command_exists(command)
#
#
dk_command_exists () {
	if [ -z "$2" ]; then
		dk_error "remove_from_file <string> <file.ext> requires 2 parameters"
		return $false
	fi
		
	sed -i -e "/$1/d" $2
}