# dk_include_guard()

##################################################################################
# dk_call(<command args>)
#
#
dk_call () {
	#dk_verbose "dk_call($*)"
	[ "$#" -lt "1" ] && dk_error "Incorrect number of parameters"

	dk_echo "${magenta} $ $* ${clr}"
	#$("$@") && "$@" 2>&1 #|| dk_verbose "'$*: failed!'"
	"$@"
}