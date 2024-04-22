# dk_include_guard()

##################################################################################
# dk_read_cache()
#
#
dk_read_cache() {
	dk_verbose "dk_read_cache($*)"
	[ $# -ne 0 ] && dk_error "Incorrect number of parameters"
	
	if ! dk_file_exists "$DKBRANCH_DIR"/cache; then
		return 0
	fi
	_APP_=
	_TARGET_OS_=
	_TYPE_=
	
	dk_echo "reading cache..."
	count=0
	while read p; do
		if [ "$count" = "0" ]; then 
			_APP_=$(echo "$p" | tr -d '\r')
			#dk_debug _APP_
		fi
		if [ "$count" = "1" ]; then
			_TARGET_OS_=$(echo "$p" | tr -d '\r')
			#dk_debug _TARGET_OS_ 
		fi
		if [ "$count" = "2" ]; then
			_TYPE_=$(echo "$p" | tr -d '\r')
			#dk_debug _TYPE_
		fi
		#if [ "$count" = "3" ]; then
		#	_DKENV_=$(echo $p | tr -d '\r')
		#	#dk_debug _DKENV_
		#fi
		count=$((count + 1))
	done < "${DKBRANCH_DIR}"/cache
}