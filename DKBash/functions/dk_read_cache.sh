#include_guard()

##################################################################################
# dk_read_cache()
#
#
function dk_read_cache() {
	dk_debug "dk_read_cache("$@")"
	if ! dk_file_exists $DKBRANCH_DIR/cache; then
		return
	fi

	echo "reading cache..."
	count=0
	while read p; do
		if [ $count == 0 ]; then 
			_APP_=$(echo $p | tr -d '\r')
		fi
		if [ $count == 1 ]; then
			_TARGET_OS_=$(echo $p | tr -d '\r')
		fi
		if [ $count == 2 ]; then
			_TYPE_=$(echo $p | tr -d '\r')
		fi
		#if [ $count == 3 ]; then
		#	_DKENV_=$(echo $p | tr -d '\r')
		#fi
		(( count++ ))
	done < $DKBRANCH_DIR/cache
}