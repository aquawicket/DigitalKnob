# dk_include_guard()

##################################################################################
# dk_reload()
#
#
function dk_reload() {
	dk_debug "dk_reload($@)"
	dk_debug "reloading $SCRIPT_DIR/$SCRIPT_NAME"
	clear
	exec "$SCRIPT_DIR/$SCRIPT_NAME"
}