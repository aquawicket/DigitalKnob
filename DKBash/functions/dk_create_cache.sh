# dk_include_guard()

##################################################################################
# dk_create_cache()
#
#
dk_create_cache () {
	dk_verbose "dk_create_cache($*)"
	[ $# -ne 0 ] && dk_error "Incorrect number of parameters"
	
	dk_echo "creating cache..."
	
	# write variable values line by line
	echo "$APP">"$DKBRANCH_DIR/cache"
	echo "$TARGET_OS">>"$DKBRANCH_DIR/cache"
	echo "$TYPE">>"$DKBRANCH_DIR/cache"
	#echo "$DKENV">>"$DKBRANCH_DIR/cache"
}