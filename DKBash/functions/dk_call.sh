# dk_include_guard()

##################################################################################
# dk_call(args)
#
#
dk_call() {
	dk_debug "dk_call($@)"
	if [ -z "$1" ]; then
		dk_error "dk_call <command args> requires at least 1 parameter"
		return $false
	fi
	
	echo -e "${magenta} $ $@ ${clr}"
	"$@"
}