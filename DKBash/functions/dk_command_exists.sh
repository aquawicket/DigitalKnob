# dk_include_guard()

##################################################################################
# dk_command_exists(command)
#
#
dk_command_exists() {
	dk_debug "dk_command_exists($@)"
	! [[ "$(command -v $1)" == "" ]]
}