#include_guard()

##################################################################################
# dk_create_cache()
#
#
function dk_create_cache() {
	dk_debug "dk_create_cache("$@")"
	echo "creating cache..."
	
	# write variable values line by line
	echo "$APP">"$DKBRANCH_DIR/cache"
	echo "$TARGET_OS">>"$DKBRANCH_DIR/cache"
	echo "$TYPE">>"$DKBRANCH_DIR/cache"
	#echo "$DKENV">>"$DKBRANCH_DIR/cache"
}