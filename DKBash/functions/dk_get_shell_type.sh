# dk_include_guard()

##################################################################################
# dk_get_shell_type()
#
#
dk_get_shell_type () {
	dk_verbose "dk_get_shell_type($*)"
	[ $# -ne 0 ] && dk_error "Incorrect number of parameters"
	echo "SHELL = $SHELL"
	echo "BASH_SOURCE = $BASH_SOURCE"
	echo "BASH_LINENO = $BASH_LINENO"

	[ -e "/proc" ] || dk_warning "/proc does not exist" && return 0 
	PID_EXE=$(readlink /proc/$$/exe);
	SHELL_TYPE=${PID_EXE##*/};           
	echo "SHELL_TYPE   = $SHELL_TYPE"
}