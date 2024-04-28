dk_includeGuard

##################################################################################
# dk_exit()
#
#
dk_exit () {
	dk_debugFunc
	
	echo "dk_exit $*"
	exec $SHELL #$*
	
	#exit $*
}