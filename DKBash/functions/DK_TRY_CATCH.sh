dk_includeGuard

##################################################################################
# DK_TRY_CATCH(<function> <args>)
#
#	reference: https://stackoverflow.com/a/11092989/688352
#
DK_TRY_CATCH () {
	dk_debugFunc
	
	# Don't pipe the subshell into anything or we won't be able to see its exit status
	set +e; ( set -e
		"$@" 
	); err_status=$?; set -e

	if [ "$err_status" -ne "0" ]; then
		echo "ERROR_STATUS: $err_status"
		dk_pause
		dk_error "test"
	fi
}