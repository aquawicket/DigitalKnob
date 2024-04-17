# dk_include_guard()

#####################################################################
# dk_get_dkpaths()
#
#
dk_get_dkpaths () {
	dk_verbose "dk_get_dkpaths($*)"
	
	if [ -n "${USERPROFILE-}" ]; then
		dk_debug USERPROFILE
		DIGITALKNOB_DIR="$USERPROFILE\digitalknob"
		dk_replace_all "$DIGITALKNOB_DIR" "\\" "/" DIGITALKNOB_DIR
		dk_replace_all "$DIGITALKNOB_DIR" "C:" "/c" DIGITALKNOB_DIR
	else
		DIGITALKNOB_DIR="$HOME/digitalknob"
	fi
	dk_debug DIGITALKNOB_DIR
	mkdir -p "$DIGITALKNOB_DIR"
	
	DKTOOLS_DIR="$DIGITALKNOB_DIR/DKTools"
	mkdir -p "$DKTOOLS_DIR"
	dk_debug DKTOOLS_DIR
	
	DKDOWNLOAD_DIR="$DIGITALKNOB_DIR/download"
	mkdir -p "$DKDOWNLOAD_DIR"
	dk_debug DKDOWNLOAD_DIR
}