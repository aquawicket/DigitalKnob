#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"

##################################################################################
# dk_assertArgs()
#
#
dk_assertArgs (){
	# frame 1 holds the argument checking information
	#echo "dk_assertArgs:FUNCTION = $(__FUNCTION__ 1)"
	#echo "dk_assertArgs:ARGC = $(__ARGC__ 1)"
	#echo "dk_assertArgs:ARGV = $(__ARGV__ 1)"
	
	# frame 2 holds the arguments to check against
	#echo ""
	#echo "dk_assertArgs:FUNCTION = $(__FUNCTION__ 2)"
	#echo "dk_assertArgs:ARGC = $(__ARGC__ 2)"
	#echo "dk_assertArgs:ARGV = $(__ARGV__ 2)"
	
	# ARGC - optional args = min arg count
	
	
	# check if we have less than the minimum argument count
	minimumArgCount=$(__ARGC__ 1)
	if [ $(__ARGC__ 2) -lt ${minimumArgCount} ]; then
		dk_error "$(__FUNCTION__ 2)($(__ARGV__ 2)): not enough arguments. Minimum is $(__ARGC__ 1)"
	fi
	
	# check if we have exceeded the maximum argument count
	maximumArgCount=$(__ARGC__ 1)
	if [ $(__ARGC__ 2) -gt ${maximumArgCount} ]; then
		dk_error "$(__FUNCTION__ 2)($(__ARGV__ 2)): too many arguments. Max is $(__ARGC__ 1)"
	fi
}


test_function (){
	dk_debugFunc
	dk_assertArgs int string
}

DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc

	test_function 123 abc
}	